# Broadcasting Memory Bombs

!!! danger "Performance Impact"
    **Driver or executor `OutOfMemoryError`** - Broadcasting a table larger than memory takes down the whole application, not just the query.

## The Problem

`broadcast()` is a promise you make to Spark: *this table is small enough to fit everywhere.* Spark believes you. When the promise is false, the failure is not a slow query — it is a dead application.

```python title="❌ Problematic Code"
from pyspark.sql.functions import broadcast

large_lookup = spark.read.table("product_catalog")   # 5 GB
orders = spark.read.table("orders")

# The driver tries to collect 5 GB, then ship it to every executor
result = orders.join(broadcast(large_lookup), "product_id")
```

## What Broadcasting Actually Costs

A broadcast is not free replication. It is a two-stage copy, and each stage has its own ceiling.

=== "Stage 1 — the driver collects"
    Spark pulls the entire table back to the **driver** before distributing anything.

    The driver must hold it in its heap. If the table exceeds `spark.driver.maxResultSize` (default **1 GB**), the job dies with:

    ```
    Total size of serialized results is bigger than spark.driver.maxResultSize
    ```

    This is the failure most people hit first, and it is often misread as a cluster problem. It is a driver problem.

=== "Stage 2 — every executor stores a copy"
    Spark then ships the table to each executor, which keeps **one deserialized copy** in its block manager.

    ```text
    Cluster memory consumed = table size × number of executors
    ```

    Note *executors*, not cores. All cores inside an executor share the single copy — that sharing is the entire point of broadcasting. A 1 GB table on 50 executors costs 50 GB of cluster memory before your query has processed a single row.

=== "The failure cascade"
    Executors exhaust their heap, so tasks fail. Failed tasks retry on other executors, which are also holding the broadcast, so they fail too. The driver drowns in retries. The application dies, having done no useful work.

    This is why an oversized broadcast is worse than a slow join: a slow join finishes.

## Solutions

=== "Quick Fix"
    ```python title="✅ Let Spark decide"
    # Don't hint. Spark broadcasts automatically below this threshold.
    spark.conf.set("spark.sql.autoBroadcastJoinThreshold", 10 * 1024 * 1024)  # 10 MB, the default

    result = orders.join(product_catalog, "product_id")
    ```

    An explicit `broadcast()` hint **overrides** the threshold. That is its purpose, and its danger — it silences the one safety check Spark performs on your behalf.

=== "Better Approach"
    ```python title="✅ Confirm the plan before you trust the hint"
    result = orders.join(broadcast(product_catalog), "product_id")
    result.explain(mode="formatted")
    ```

    Look for the join node in the physical plan:

    - `BroadcastHashJoin` — the hint was honoured.
    - `SortMergeJoin` — Spark silently declined, usually because the table exceeded `spark.driver.maxResultSize`. Your hint did nothing and you never saw a warning.

    Read the plan *before* running the job against production data. `explain()` costs nothing; it does not execute the query.

=== "Best Practice"
    ```python title="✅ Size the table from statistics, not from guesswork"
    # For catalog tables, compute real statistics once
    spark.sql("ANALYZE TABLE product_catalog COMPUTE STATISTICS")

    # Spark's optimizer now knows the true size and will broadcast on its own
    # when the table is genuinely small — no hint required.
    result = orders.join(product_catalog, "product_id")
    ```

    Better still, let **Adaptive Query Execution** decide at runtime. AQE sees the *actual* size of each side after the first stage completes, rather than an estimate made before any data was read:

    ```python
    spark.conf.set("spark.sql.adaptive.enabled", True)  # on by default since Spark 3.2
    ```

    AQE can promote a `SortMergeJoin` to a broadcast join mid-query when a filter turns out to have shrunk one side dramatically. No static threshold can do that.

!!! warning "Do not estimate size by sampling"
    A tempting helper is to `df.sample(0.01)`, measure the rows, and extrapolate. Resist it. It triggers a full `count()`, it is wrong for skewed or nested data, and the number it produces has nothing to do with the *serialized, deserialized-in-JVM* footprint that actually determines whether the broadcast fits. Use table statistics or the Spark UI's SQL tab, which report the real thing.

## Key Takeaways

!!! tip "Broadcasting rules"
    - **Cost model:** table size × number of executors, plus one full copy on the driver.
    - **Per executor, not per core.** Cores share the copy — that is why broadcasting works at all.
    - **Default threshold:** 10 MB. Spark broadcasts below this without being asked.
    - **A hint overrides the safety check.** Only use `broadcast()` when you know the size.
    - **Verify with `explain()`.** A declined hint fails silently.
    - **Rule of thumb:** keep broadcasts under ~10% of a single executor's memory.

## Measuring Impact

```python title="Performance Comparison"
# 5 GB table, hinted broadcast:  driver OOM after 6 minutes, zero rows produced
# 5 GB table, shuffle join:      completes in 11 minutes
# 80 MB table, broadcast join:   completes in 40 seconds (no shuffle at all)
```

Broadcasting is the single most effective join optimization in Spark and the single most destructive when misapplied. The asymmetry is worth remembering: a broadcast that is too small to help merely wastes a few seconds, while one that is too large costs the entire application.

Next: **[Inefficient Join Ordering](InefficientJoinOrdering.md)** — how the *order* of your joins decides how much data ever reaches them.
