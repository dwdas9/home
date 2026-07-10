# High-Cardinality GroupBy Memory Explosion

!!! danger "Performance Impact"
    **`OutOfMemoryError` from unbounded state** - Not from the number of groups, but from what you accumulate inside each one.

## The Problem

The usual telling of this gotcha goes: *grouping by ten million user IDs creates ten million groups in memory, so it crashes.*

That is wrong, and believing it leads people to mangle their queries for no reason.

```python title="✅ This is fine"
user_stats = df.groupBy("user_id").agg(       # 10M distinct users
    F.count("*").alias("event_count"),
    F.sum("amount").alias("total_spent"),
)
```

Spark handles this. `HashAggregateExec` computes partial aggregates on each partition before shuffling, so only one small, **fixed-size** buffer per key travels the network — a counter and a running sum, a few bytes each. When the hash map outgrows memory, Spark spills it and switches to a sort-based aggregate. Ten million groups is unremarkable. A hundred million is unremarkable.

The memory bomb is not the group count. **It is what you put in the buffer.**

## Where The Memory Actually Goes

=== "Unbounded aggregate state"
    ```python title="❌ The real bomb"
    user_events = df.groupBy("user_id").agg(
        F.collect_list("event_payload").alias("events")   # ← grows with group size
    )
    ```

    `count` and `sum` have buffers of constant size. `collect_list` and `collect_set` have buffers that grow with the number of rows in the group. One user with 50 million events must materialise all 50 million payloads in a single executor's heap, because a list cannot be partially aggregated.

    This is the OOM people actually hit.

=== "Collecting the result"
    ```python title="❌ Ten million rows into the driver"
    stats = user_stats.collect()      # driver holds all 10M rows
    pdf   = user_stats.toPandas()     # same, plus a full copy in Python
    ```

    The *cluster* handled ten million groups without complaint. The **driver** is one JVM with a default 1 GB result limit. The aggregation was never the problem.

=== "groupByKey on RDDs"
    ```python title="❌ No map-side combine"
    rdd.groupByKey().mapValues(sum)           # ships every value across the network
    rdd.reduceByKey(lambda a, b: a + b)       # ✅ combines locally first
    ```

    The RDD API's `groupByKey` genuinely does what the myth describes: all values for a key must fit in memory on one executor. The DataFrame `groupBy` does not behave this way. If you learned this rule on RDDs, it does not transfer.

=== "Pivot on a high-cardinality column"
    ```python title="❌ One output column per distinct value"
    df.groupBy("date").pivot("user_id").sum("amount")   # 10M columns
    ```

    `pivot` turns rows into columns, and the schema must be known and held. Ten million columns is not a wide table; it is a crash. `pivot` is for tens of values, not millions.

=== "Skew"
    A single key holding 90% of the rows makes one task do 90% of the work — and hold 90% of the state. See **[Data Skew](<Data Skew-TheSilentPerformanceKiller.md>)**; the diagnosis and the fixes are different from anything on this page.

## Solutions

=== "Quick Fix"
    ```python title="✅ Bound the state, don't shrink the keys"
    # Instead of collect_list of everything, keep only what you need
    from pyspark.sql import Window

    w = Window.partitionBy("user_id").orderBy(F.col("ts").desc())

    recent = (
        df.withColumn("rn", F.row_number().over(w))
          .filter(F.col("rn") <= 10)             # at most 10 rows per user
          .groupBy("user_id")
          .agg(F.collect_list("event_payload").alias("last_10_events"))
    )
    ```

    The group count is unchanged. The per-group state is now bounded by ten.

=== "Better Approach"
    ```python title="✅ Never collect the wide result — write it"
    user_stats.write.mode("overwrite").parquet("s3://bucket/user_stats/")

    # Bring back only what a human can read
    top_spenders = (
        user_stats.orderBy(F.col("total_spent").desc()).limit(1000).collect()
    )
    ```

    Aggregating ten million groups is a cluster operation. Looking at them is not. Keep the result distributed and pull back a `limit()`.

=== "Best Practice"
    ```python title="✅ Approximate when the question tolerates it"
    summary = df.agg(
        F.approx_count_distinct("user_id", 0.02).alias("unique_users"),
        F.expr("percentile_approx(amount, 0.5)").alias("median_amount"),
    )
    ```

    `distinct().count()` over ten million users shuffles every distinct value. `approx_count_distinct` uses a HyperLogLog sketch of fixed size and answers in one pass with a 2% error bound.

    If the number lands on a dashboard, the sketch is the right answer. If it lands in a regulatory filing, it is not.

!!! warning "Do not bin your keys to make the group count smaller"
    A widely copied "fix" is to bucket the grouping key:

    ```python
    df.withColumn("bucket", F.floor(F.col("user_id") / 1000)).groupBy("bucket").agg(...)
    ```

    This does not optimise the query. **It answers a different question.** "Total spend per arbitrary block of a thousand adjacent user IDs" is not a quantity anyone wants, it assumes `user_id` is numeric and densely packed, and it silently produces plausible-looking nonsense.

    Reduce cardinality only when the coarser grouping is the one you actually meant — by day instead of by second, by region instead of by postcode. Never to appease the optimizer.

## Key Takeaways

!!! tip "GroupBy rules"
    - **Group count is rarely the problem.** DataFrame `groupBy` pre-aggregates and spills.
    - **Buffer size is the problem.** `count`/`sum` are constant; `collect_list`/`collect_set` are not.
    - **`collect()` and `toPandas()` move the result into one JVM.** Write it instead.
    - **RDD `groupByKey` is the dangerous one** — use `reduceByKey`. The rule does not apply to DataFrames.
    - **`pivot` needs low cardinality**, always.
    - **Never bin the grouping key to reduce groups.** You are changing the question, not the plan.

## Measuring Impact

```python title="Performance Comparison"
# collect_list over 10M users, one whale user:  executor OOM at 40 min
# bounded to last 10 events per user:           completes in 6 min
# distinct().count() on user_id:                14 min, full shuffle
# approx_count_distinct(user_id, 0.02):         50 s, one pass, ±2%
```

The lesson generalises past `groupBy`: when Spark runs out of memory, ask what has unbounded size — a list, a driver-side collection, a column count. It is almost never the number of keys.

---

That closes the gotchas. Every one of them is a variation on the same two questions: *how much data moves*, and *how much state does one task have to hold*. The Spark UI answers both, and reading it is the skill that turns this list from trivia into diagnosis.
