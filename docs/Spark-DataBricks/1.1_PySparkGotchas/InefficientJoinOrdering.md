# Inefficient Join Ordering

!!! danger "Performance Impact"
    **10x larger intermediate results** - Joining two large tables before filtering them shuffles data you were about to throw away.

## The Problem

Every join produces an intermediate result that must be shuffled, spilled, and read again by the next operator. Join the two biggest tables first and you pay for the largest intermediate result the query will ever have — right at the start.

```python title="❌ Problematic Code"
events = spark.read.table("events")              # 1 TB
sessions = spark.read.table("sessions")          # 500 GB
active_users = spark.read.table("active_users")  # 10 MB

# 1.5 TB intermediate, then narrowed to 50 GB by a 10 MB table
result = (
    events
    .join(sessions, "session_id")
    .join(active_users, "user_id")
)
```

The `active_users` table is what makes this query small. It is consulted last.

## Why Spark Doesn't Fix This For You

This is the part that surprises people, because Catalyst rewrites so much else.

=== "What Catalyst does do"
    **Predicate pushdown.** A `.filter()` written after a join is moved *below* the join automatically, and pushed into the file scan where the format supports it. You do not need to hand-place `WHERE` clauses.

=== "What Catalyst does not do"
    **Reorder your joins.** Join reordering requires the cost-based optimizer, and it is **off by default**:

    ```python
    spark.conf.get("spark.sql.cbo.enabled")               # false
    spark.conf.get("spark.sql.cbo.joinReorder.enabled")   # false
    ```

    Even switched on, the CBO is useless without table statistics — it has no idea that `active_users` is 10 MB unless someone ran `ANALYZE TABLE`.

    So for a multi-table join, **the order you write is very close to the order Spark executes.** A join is not a filter, and Spark will not treat it as one.

=== "What AQE does"
    Adaptive Query Execution re-plans *between stages* using real statistics. It will happily convert a sort-merge join into a broadcast join once it sees the true size of one side.

    What it cannot do is un-shuffle the 1.5 TB it already produced. AQE improves the joins you gave it. It does not rewrite the sequence.

## Solutions

=== "Quick Fix"
    ```python title="✅ Shrink the driving table first"
    # Bring the 10 MB table in first, as a broadcast — no shuffle at all
    active_events = events.join(broadcast(active_users), "user_id")

    # Only now touch the 500 GB table
    result = active_events.join(sessions, "session_id")
    ```

    Same three tables, same answer, ~100 GB intermediate instead of 1.5 TB.

=== "Better Approach"
    ```python title="✅ Say what you mean: this is a filter, not a join"
    # We want events BY active users. We want no columns from active_users.
    active_events = events.join(broadcast(active_users), "user_id", how="leftsemi")

    result = active_events.join(sessions, "session_id")
    ```

    A `leftsemi` join keeps rows from the left side that have a match, adds no columns, and — critically — **cannot duplicate rows**.

    An inner join on `user_id` will multiply every event by the number of times that user appears in `active_users`. If that table ever gains a duplicate row, an inner join silently doubles your event counts. A `leftsemi` join cannot. Reach for it whenever the right-hand table exists only to decide membership.

=== "Best Practice"
    ```python title="✅ Give the optimizer the facts, then check its work"
    # Statistics turn guesses into decisions
    for t in ["events", "sessions", "active_users"]:
        spark.sql(f"ANALYZE TABLE {t} COMPUTE STATISTICS")

    result = (
        events
        .filter(col("event_date") >= "2023-01-01")   # narrow before anything else
        .join(broadcast(active_users), "user_id", how="leftsemi")
        .join(sessions, "session_id")
    )

    result.explain(mode="formatted")
    ```

    In the plan, read the join nodes from the bottom up — that is execution order. Confirm the broadcast lands first and the `SortMergeJoin` against `sessions` sits above it, operating on the reduced stream.

!!! tip "The ordering heuristic"
    Order joins so that **each step produces the smallest possible output for the next one.** In practice: most selective first, smallest tables first, broadcastable tables first. Every row you eliminate early is a row you never shuffle, never spill, and never read back.

## Key Takeaways

!!! tip "Join ordering rules"
    - **Spark does not reorder joins by default.** The CBO is off, and blind without `ANALYZE TABLE`.
    - **Filters are pushed down automatically. Joins are not.**
    - **Use `leftsemi` when a join is really a membership test** — it cannot duplicate rows.
    - **Broadcast the small dimension first**, so the big fact table is filtered before it is shuffled.
    - **Read `explain()` bottom-up** to see the real execution order.

## Measuring Impact

```python title="Performance Comparison"
# Unoptimized: 1 TB → 1.5 TB intermediate → 50 GB result   (45 min)
# Optimized:   1 TB → 100 GB intermediate → 50 GB result   (8 min)
# Improvement: 5.6x faster, ~93% less shuffle written
```

Join ordering is the rare optimization that costs nothing at runtime and nothing in complexity — you are writing the same joins, in a better sequence. It is usually the first thing to try and the last thing people think of.

Next: **[Multiple-Pass Aggregation Waste](MultiplePassAggregation.md)** — the same principle applied to scans instead of shuffles.
