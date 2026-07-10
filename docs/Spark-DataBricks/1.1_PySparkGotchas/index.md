# PySpark Gotchas

Thirteen ways a correct Spark job becomes an expensive one — and how to see each of them coming.

Every entry below follows the same shape: the code that looks reasonable, what Spark actually does with it, and the smallest change that fixes it. None of them is about writing wrong answers. They are all about writing right answers slowly.

!!! note "Two questions underlie all thirteen"
    **How much data moves?** Shuffles, broadcasts, and scans dominate runtime. Everything else is arithmetic.

    **How much state must one task hold?** Memory failures come from unbounded buffers — a list, a driver-side collection, a column count — almost never from the number of rows.

## Data loading and I/O

| Gotcha | The mistake | Typical cost |
|---|---|---|
| [The Small Files Performance Killer](SmallFilesPerformanceKiller.md) | One task per file, ten thousand files | 10–50× slower |
| [Schema Inference Double-Read Penalty](SchemaInferenceDouble-ReadPenalty.md) | Letting Spark guess the schema | Every read costs two |
| [Suboptimal File Format Choices](SuboptimalFileFormatChoices.md) | Row formats for analytical scans | 10× slower, 5× larger |

## Partitioning

| Gotcha | The mistake | Typical cost |
|---|---|---|
| [The Goldilocks Partition Problem](TheGoldilocksPartitionProblem.md) | Partitions too small, or too few | 20× task overhead |
| [High-Cardinality Partitioning Disaster](High-CardinalityPartitioningDisaster.md) | `partitionBy` on a user ID | Millions of tiny files |

## Caching and persistence

| Gotcha | The mistake | Typical cost |
|---|---|---|
| [The Over-Caching Memory Waste](Over-CachingMemoryWaste.md) | Caching everything, evicting what mattered | Memory starvation |
| [Wrong Storage Level Choices](WrongStorageLevelChoices.md) | `MEMORY_ONLY` on data that doesn't fit | Constant recomputation |
| [Lazy Cache Evaluation Trap](LazyCacheEvaluationTrap.md) | `.cache()` without an action | Cache never populated |

## Joins

| Gotcha | The mistake | Typical cost |
|---|---|---|
| [Data Skew — The Silent Performance Killer](<Data Skew-TheSilentPerformanceKiller.md>) | One key holds most of the rows | 99% of tasks wait for 1% |
| [Broadcasting Memory Bombs](BroadcastingMemoryBombs.md) | Hinting a broadcast that doesn't fit | Driver OOM, application dies |
| [Inefficient Join Ordering](InefficientJoinOrdering.md) | Joining the two biggest tables first | 10× larger intermediates |

## Aggregation

| Gotcha | The mistake | Typical cost |
|---|---|---|
| [Multiple-Pass Aggregation Waste](MultiplePassAggregation.md) | One `.collect()` per statistic | One full scan each |
| [High-Cardinality GroupBy Memory Explosion](HighCardinalityGroupBy.md) | Unbounded state per group | Executor OOM |

---

## Where to start

If you have a slow job in front of you right now, the fastest route to a diagnosis is the Spark UI's **Stages** tab. Sort the tasks of the slowest stage by duration:

- **A few tasks far slower than the median** → [Data Skew](<Data Skew-TheSilentPerformanceKiller.md>).
- **Thousands of tiny, fast tasks** → [Small Files](SmallFilesPerformanceKiller.md) or [Goldilocks Partitions](TheGoldilocksPartitionProblem.md).
- **Large "Shuffle Write"** → [Join Ordering](InefficientJoinOrdering.md).
- **Nonzero "Spill (Disk)"** → [Wrong Storage Level](WrongStorageLevelChoices.md) or unbounded aggregate state.
- **The same stage running repeatedly** → [Multiple-Pass Aggregation](MultiplePassAggregation.md) or the [Lazy Cache Trap](LazyCacheEvaluationTrap.md).

Read the numbers before changing the code. Every fix on this page makes some other workload slower.
