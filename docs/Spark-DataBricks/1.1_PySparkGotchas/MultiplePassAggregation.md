# Multiple-Pass Aggregation Waste

!!! danger "Performance Impact"
    **3-5x unnecessary data scans** - Each `.collect()` is a separate Spark job that re-reads the entire dataset from storage.

## The Problem

Transformations in Spark are lazy; actions are not. Every action starts a new job, and a new job re-reads the source unless something is cached. Four statistics computed one at a time means four full scans of the same data.

```python title="❌ Problematic Code"
total_sales = df.agg(sum("sales")).collect()[0][0]     # Job 1: full scan
avg_sales   = df.agg(avg("sales")).collect()[0][0]     # Job 2: full scan
max_sales   = df.agg(max("sales")).collect()[0][0]     # Job 3: full scan
count_sales = df.agg(count("sales")).collect()[0][0]   # Job 4: full scan
```

Reading a terabyte four times to produce four numbers is not an aggregation problem. It is an *action* problem — and it hides in plain sight because each line looks cheap.

## Why This Happens

=== "Lazy transformations, eager actions"
    `df.agg(...)` builds a plan and executes nothing. `.collect()` executes it.

    Spark has no memory of the previous job. It cannot know that the scan it just performed would have served this query too, so it starts again from the file system.

=== "Aggregations are nearly free to combine"
    A single scan can compute any number of aggregates at once. Spark accumulates all of them per partition in one pass, then merges the partial results in one shuffle.

    Four aggregates cost roughly what one costs. The scan dominates; the arithmetic does not.

## Solutions

=== "Quick Fix"
    ```python title="✅ One agg, one job, one scan"
    from pyspark.sql import functions as F

    stats = df.agg(
        F.sum("sales").alias("total"),
        F.avg("sales").alias("average"),
        F.max("sales").alias("maximum"),
        F.min("sales").alias("minimum"),
        F.count("sales").alias("n"),
        F.stddev("sales").alias("stddev"),
    ).collect()[0]

    print(f"Total {stats['total']:,.2f} · mean {stats['average']:,.2f} · n={stats['n']:,}")
    ```

    One `.collect()`, one job, one scan.

=== "Better Approach"
    ```python title="✅ Approximate percentiles in the same pass"
    stats = df.agg(
        F.sum("sales").alias("total"),
        F.expr("percentile_approx(sales, 0.5)").alias("median"),
        F.expr("percentile_approx(sales, array(0.25, 0.75))").alias("quartiles"),
        F.approx_count_distinct("customer_id", 0.02).alias("approx_customers"),
    ).collect()[0]
    ```

    An exact median requires a full sort; `percentile_approx` does not, and it joins the same single pass. Likewise `approx_count_distinct` replaces a `distinct().count()` — which is a shuffle of every distinct value — with a bounded-memory sketch.

    Reach for the exact version when the number must be exact. For a dashboard, 2% error is not an error.

=== "Best Practice"
    ```python title="✅ When you genuinely need many separate queries, cache once"
    df_clean = df.filter(F.col("sales").isNotNull()).cache()
    df_clean.count()   # materialise the cache — see the Lazy Cache Evaluation Trap

    # Now each of these reads memory, not storage
    by_region  = df_clean.groupBy("region").agg(F.sum("sales"))
    by_segment = df_clean.groupBy("segment").agg(F.sum("sales"))

    df_clean.unpersist()
    ```

    Caching solves a different problem: many *different* queries over one dataset. Combining aggregates solves many *aggregates* over one query. Use the right one — caching four `.agg()` calls still runs four jobs, it just makes them cheaper.

!!! warning "`sum`, `max`, `min` and `count` shadow Python builtins"
    ```python
    from pyspark.sql.functions import sum, max, count   # ← now max([1,2,3]) is a Column expression
    ```

    The failure is confusing: an unrelated `max()` call elsewhere in the module starts raising `TypeError: Column is not iterable`. Import the module instead — `from pyspark.sql import functions as F` — and write `F.sum`. Every example above does.

## Key Takeaways

!!! tip "Aggregation rules"
    - **Every action is a job. Every job re-reads the source.** Count your `.collect()` calls.
    - **Combine aggregates into one `.agg()`** — the scan is the cost, not the arithmetic.
    - **`percentile_approx` and `approx_count_distinct`** join the same pass; exact versions demand a sort or a shuffle.
    - **Cache for many queries, combine for many aggregates.** They are not substitutes.
    - **Import `functions as F`.** Never `from ... import sum`.

## Measuring Impact

```python title="Performance Comparison"
# Before: 4 jobs, 4 full scans   (20 minutes)
# After:  1 job,  1 full scan    (5 minutes)
# Improvement: 4x faster, 75% less I/O billed
```

The number of scans a query performs equals the number of actions you called on it. That sentence explains most surprising Spark bills.

Next: **[High-Cardinality GroupBy Memory Explosion](HighCardinalityGroupBy.md)** — what happens when a single pass still produces too much state.
