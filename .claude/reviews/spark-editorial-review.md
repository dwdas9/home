# Editorial review — Spark section

**Date:** 2026-07-10 · **Status:** awaiting approval · **Scope:** `docs/Spark-DataBricks/` (41 files, ~40,400 words)

Nothing has been rewritten. This is the review that precedes rewriting.

---

## 0. Inventory

| Folder | Files | Words | What it holds |
|---|---:|---:|---|
| `1.0_Spark/` | 20 | 25,103 | Core Spark: concepts, architecture, transformations, tuning, quizzes |
| `1.1_PySparkGotchas/` | 9 | 5,058 | Nine performance gotchas, one per file |
| `2.0_Spark_To_ADLS/` | 2 | 3,786 | A **project** (Sparkzure) + a methods reference |
| `3.0_Databricks/` | 9 | 5,316 | Databricks platform: clusters, auth, secrets, Delta |
| `4.0_Hive/` | 1 | 1,119 | Hive architecture |

Two measurements frame the rest of this document:

- **Internal cross-links within the section: 0.** No article sends the reader to another.
- **Inbound links from the rest of the site: 4**, and all four point at
  `2.0_Spark_To_ADLS/2.0_Spark_To_ADLS.md` — a project write-up, not a concept page.

A section where no page references another is not a learning module. It is a folder.

---

## 1. Overall structure

### 1.1 The Gotchas content exists twice, and neither copy is whole

`1.0_Spark/2.0_PySpark_Gotchas.md` (4,983 w) and `1.1_PySparkGotchas/*` (9 files, 5,058 w)
present the same nine gotchas. Same examples, same `# BAD:` comments, same numbers.
The nav lists both, and **both nav labels read "PySpark Gotchas"** — the sidebar shows the
same title twice at different depths.

Neither copy can simply be kept:

- **The monolith is truncated.** 97 code fences (an odd number — one is unterminated). The
  file ends `"""Perform GroupBy with memory awareness"""` with no closing fence and no
  trailing newline, mid-function, inside a `=== "Smart GroupBy…"` tab. Gotcha #13 has no end.
- **The monolith over-promises.** Its `## Categories` block advertises five categories.
  The body delivers four. *Configuration* (default settings, resource allocation, dynamic
  scaling) and *Advanced Topics* (UDF optimization, streaming pitfalls, monitoring) are
  announced and never written.
- **The split folder is incomplete.** It contains gotchas #1–#9. Gotchas **#10 Broadcasting
  Memory Bombs, #11 Inefficient Join Ordering, #12 Multiple-Pass Aggregation Waste, and
  #13 High-Cardinality GroupBy Memory Explosion** exist only inside the broken monolith.

The split files are the better artifact: they have a consistent spine (Problem → Why → Solutions
→ Key Takeaways → Measuring Impact) and use tabbed content well. The monolith holds four
articles' worth of material that would be lost if it were simply deleted.

### 1.2 Duplication beyond the gotchas

| Topic | Where it is explained | Count |
|---|---|---:|
| **Data skew** | `1.5_DataSkewHandling.md` (924 w) · `1.1_PySparkGotchas/Data Skew-….md` (394 w) · monolith Gotcha #9 (~190 lines) | **3** |
| **Caching / persistence** | `1.3_persist_and_cache.md` · gotcha #6 over-caching · #7 storage levels · #8 lazy-cache trap · a "Cache Data for Reuse" section inside `1.12_Spark_Shuffle.md` | **5** |
| **Hive** | `4.0_Hive/Hive_Concepts.md` · `1.0_Spark-Concepts.md` §"What is Apache Hive?" · `1.16_ConnectingSparkToHive.md` · `1.13_…Metastore.md` · `3.1_Catalogs_And_Metastore.md` · **and `DevOps/Docker/…/4.9.1_Hive_Concepts.md` in a different tab** | **6** |
| **PySpark vs "real" Spark** | `1.0.1__Python_PySpark_Spark_Confusion.md` (the good one) · `1.15_CommonPysparkTopics.md` §"Just PySpark vs Real Spark" · `Install-Pyspark-Windows.md` appendix §"Pyspark Vs Full Spark Overview" | **3** |
| **Shuffle** | `1.12_Spark_Shuffle.md` (a 235-word stub) · `1.2_SparkArchitecture.md` §"What is a Shuffle?"/"When Does a Shuffle Occur?"/"How to Optimize Shuffle" · `1.11_…Questions.md` §`spark.sql.shuffle.partitions` | **3** |

None of these cross-reference each other. A reader who lands on the 394-word skew page has no
way to discover the 924-word one.

Note the shuffle case in particular: **the dedicated shuffle article contains less about shuffle
than the architecture article does.**

### 1.3 A project write-up is filed as a concept page

`2.0_Spark_To_ADLS/2.0_Spark_To_ADLS.md` opens with `# Project Sparkzure Part1` and contains a
**second `#` heading at line 278**, `# Project Sparkzure Part2`. Two articles in one file.

Meanwhile the top-level **Projects** tab already has a `Sparkzure` entry, and three of the four
inbound links to this whole section come from Projects pages pointing here. The content is in
the wrong tab.

The sibling file `2.1_Spark-To_ADLS_Summary.md` is genuinely good — five authentication methods
to reach Azure Storage from Spark, each with code. That is a reference article, and it is buried
inside a project folder.

### 1.4 The Spark tab is teaching two different subjects

Pages 1–20 teach Spark, the engine. Pages 21–30 teach Databricks, a commercial platform whose
prerequisites are Azure service principals, Key Vault, and ADLS — none of which the Spark path
covers. `3.0_Databricks/4.8_Databricks_ProjectA1.md` is a capstone that introduces **DBT and
ADF**, neither of which appears anywhere earlier in the tab.

### 1.5 Two competing quiz pages, plus quizzes inside articles

`1.11_Spark_Interview_Questions.md` (2,021 w) and `1.14_Q&A.md` (1,449 w, Databricks-certification
multiple choice) overlap. Separately, `1.4_broadcastvariables.md` ends with "Knowledge Check" and
`1.5_DataSkewHandling.md` with "Check your knowledge". Four different quiz mechanisms.

Worse: `1.11` contains **real teaching material that exists nowhere else** — join strategies,
Catalyst's four phases, DAG explanation, `spark.sql.shuffle.partitions`. The section's best
technical content is hiding in an interview-prep page.

---

## 2. Learning journey

Reconstructed from the current nav order, the reader's path is:

> Concepts → Python/PySpark confusion → Narrow vs Wide → Architecture → Cache & Persist →
> Broadcast Variables → Data Skew → Missing Values → Window Functions → Partitioning →
> RDD vs DataFrame → PySpark Gotchas → Scala → Interview Q&A → Q&A → Shuffle → Catalogs →
> Common Topics → Hive → Setup Guide

Problems, in order of severity:

1. **Optimization before mechanism.** *Cache & Persist* (5th) and *Data Skew* (7th) arrive before
   the reader knows what a partition, a stage, or a shuffle is. Skew is defined as "uneven key
   distribution across partitions" — partitions are introduced at position 10, shuffle at 16.
2. **Shuffle arrives 16th.** Narrow vs Wide (3rd) exists *only* to explain which operations
   shuffle. The payoff lands thirteen articles later.
3. **The setup guide is last.** A reader who wants to follow along has to reach position 20 to
   learn how to install anything.
4. **RDD vs DataFrame arrives 11th**, after four articles have already used DataFrames.
5. **The tab ends on a cliff.** Position 20 is an installation guide; then, without transition,
   Hive appears, then Databricks, then a DBT/ADF capstone.
6. **Nothing points forward.** No article ends by telling the reader where to go next.

The intended prerequisite chain — *what Spark is → how it executes → what that costs → how to
avoid the costs* — is present in the material but not in the ordering.

---

## 3. Article quality

### Flagged: incomplete or broken

| File | W | Problem |
|---|---:|---|
| `1.0_Spark-Concepts.md` | 492 | **The section's entry point.** Contains an **empty `## Spark RDDs` heading with no body.** "Spark Architecture" and "Spark Lifecycle" are bare images with no prose. Defines Hive and Hadoop before explaining Spark's own execution model. Opens by comparing Spark to MapReduce — which the reader has not met. Typos: "sytem", "lie ADLS", "he **Hive metastore**", "conventioal". No summary, no next step. |
| `1.12_Spark_Shuffle.md` | 235 | Last sentence is broken mid-thought: *"So, you can  operations, repartitioning data, and cahe frequently used data to reduce shuffle."* (missing verb, double space, "cahe"). Opens with an image before any heading. |
| `2.0_PySpark_Gotchas.md` | 4,983 | Truncated mid-code-block. Unbalanced fences. Promises 5 categories, delivers 4. |
| `3.5_Databricks_SQL.md` | 77 | Not an article. An `#` heading that is a bare external hyperlink, one paragraph, one snippet. |
| `3.7_DeltaLake_And_Lakehouse.md` | 182 | Two `#` headings in one file. Ends on a PDF link with no conclusion. Covers a technology the site's own projects depend on. |
| `3.3_Mount_ADLS_on_Databricks.md` | 283 | Overlaps `3.2_AuthenticationMethods.md` §3 (Service Principal + OAuth2) almost entirely. |

### Flagged: misplaced

| File | Issue |
|---|---|
| `1.10_Scala_Cheatsheet.md` (398 w) | Orphan. A Scala table inside a PySpark section. Nothing links to it; nothing depends on it; no article asks the reader to read Scala. |
| `2.0_Spark_To_ADLS.md` | Project content in a concepts tab (see §1.3). |
| `4.8_Databricks_ProjectA1.md` | Capstone introducing DBT + ADF cold; numbered `4.8` while living in `3.0_Databricks/`. |
| `1.11_Spark_Interview_Questions.md` | Contains the section's only coverage of join strategies and Catalyst phases. |

### Genuinely good — keep, polish, promote

| File | W | Why |
|---|---:|---|
| `1.0.1__Python_PySpark_Spark_Confusion.md` | 1,302 | The best article in the section. Answers a real, specific confusion ("Does installing PySpark give me real Spark?") that the reader actually has and that is poorly covered elsewhere on the web. This is the model for what every page should be. |
| `1.1_PySparkGotchas/*` | 5,058 | Consistent structure, honest numbers, good use of tabs. Needs completing, not rewriting. |
| `2.1_Spark-To_ADLS_Summary.md` | 603 | Five auth methods, each with runnable code. A real reference table. |
| `1.13_SparkDatabaseTablesCatalogsMetastore.md` | 1,417 | Traces what actually happens on disk when you `CREATE TABLE`. Rare and useful. |
| `1.2_SparkArchitecture.md` | 2,188 | Substantial. Too many subjects in one file (see §4). |

---

## 4. Content gaps

Ordered by how much each would improve the section.

1. **Reading the Spark UI / diagnosing a slow job.** *(Largest gap.)* Thirteen gotchas assert
   "this is 10× slower." Not one shows the reader how to *see* that in the UI — stage timeline,
   task duration skew, spill metrics, shuffle read/write. This is the skill that converts the
   whole section from trivia into practice, and it is the natural spine tying the gotchas back
   to the execution model.
2. **Adaptive Query Execution.** Mentioned once, as a bullet inside the skew page. AQE has been
   on by default since Spark 3.2 and it silently invalidates roughly half the manual tuning
   advice on this site (coalescing partitions, converting sort-merge to broadcast, splitting
   skewed partitions). Every optimization article needs to say what AQE already does for you.
3. **Lazy evaluation and the Catalyst optimizer.** The word "lazy" appears in gotcha #8's title.
   Catalyst's four phases appear only inside the interview-questions page. There is no article
   explaining *why* transformations don't execute.
4. **Joins.** No article. Join *strategies* live in interview questions. `1.4` covers broadcast
   *variables* (a different thing that shares a name). Broadcast *joins* appear as a skew remedy.
   Joins are the single most common source of Spark performance problems.
5. **DataFrame basics.** The section teaches architecture, tuning, and catalogs — but never
   "here is how you read, transform, and write a DataFrame." A reader arriving from the Python
   tab has no on-ramp.
6. **Writing data: modes, idempotency, overwrite semantics.** `1.8` covers `partitionBy` and
   bucketing; nothing covers `mode("overwrite")` and its footguns.
7. **UDFs and why to avoid them.** Promised in the monolith's Categories block. Never written.
8. **Delta Lake, properly.** 182 words for the format the site's own projects are built on.
9. **Structured Streaming.** Zero coverage — while the site has an entire *Stream Processing* tab
   that never connects back to Spark.

---

## 5. Filenames and ordering

### 5.1 The current numbering is lexically unsortable

`1.10_Scala_Cheatsheet.md` sorts **before** `1.2_SparkArchitecture.md`, because `"1.1" < "1.2"`
as text. The folder listing is therefore in an order nobody intended, which is very likely how the
nav order drifted out of sequence in the first place. The nav currently reads
`… 1.10, 1.11, 1.14, 1.12, 1.13, 1.15, 1.16` — **1.14 before 1.12**.

Fixes:

- **Zero-pad to three digits.** `010`, `020`, … `100`, `110`. Sorts correctly forever, in every
  tool, with nine insertion slots between neighbours.
- **One number per level.** Never `1.2`. Depth is expressed by folders, not by dots.
- **Hyphens, lowercase.** `use_directory_urls: false` means the filename *is* the URL
  (`010-what-is-spark.html`). Underscores and capitals in URLs are avoidable friction.

### 5.2 Specific filename defects

- `1.1_PySparkGotchas/Data Skew-TheSilentPerformanceKiller.md` — **contains a space.** Becomes
  `%20` in the URL.
- `1.0.1__Python_PySpark_Spark_Confusion.md` — double underscore.
- `2.0_PySpark_Gotchas.md` lives in `1.0_Spark/` but is numbered `2.0`, colliding with the
  sibling folder `2.0_Spark_To_ADLS/`.
- `3.0_Databricks/4.8_Databricks_ProjectA1.md` — numbered `4.8` inside the `3.0` folder.
- `4.0_Hive/` — a folder holding exactly one file.
- The folder name `Spark-DataBricks` bakes the two-subjects-in-one-tab problem into every URL.

### 5.3 Proposed layout

```
docs/Spark/
  index.md                                   [NEW] module map, the tab landing page

  010-foundations/
    010-what-is-spark.md                     ← rewrite of 1.0_Spark-Concepts
    020-python-pyspark-and-spark.md          ← 1.0.1 + absorbs 1.15 §1 + install appendix
    030-installing-pyspark.md                ← Install-Pyspark-Windows
    040-rdd-dataframe-dataset.md             ← 1.9
    050-lazy-evaluation-and-catalyst.md      [NEW]

  020-execution-model/
    010-architecture.md                      ← 1.2, shuffle section removed
    020-jobs-stages-and-tasks.md             ← split out of 1.2
    030-narrow-and-wide-transformations.md   ← 1.1
    040-shuffle.md                           ← 1.12 stub + 1.2's shuffle sections, rewritten
    050-partitions.md                        ← 1.8 (first half)
    060-adaptive-query-execution.md          [NEW]
    070-reading-the-spark-ui.md              [NEW] ← the keystone article

  030-working-with-data/
    010-dataframe-basics.md                  [NEW]
    020-missing-values.md                    ← 1.6
    030-duplicates-and-window-functions.md   ← 1.7
    040-joins.md                             [NEW] absorbs join strategies from 1.11
    050-broadcast-variables.md               ← 1.4
    060-caching-and-persistence.md           ← 1.3 + gotchas #6/#7/#8 folded in
    070-writing-partitioning-and-bucketing.md ← 1.8 (second half)
    080-tables-catalogs-and-metastore.md     ← 1.13
    090-hive.md                              ← 4.0_Hive (canonical) + 1.16
    100-connecting-to-azure-storage.md       ← 2.1_Spark-To_ADLS_Summary (rescued)

  040-performance/
    index.md                                 [NEW] the gotchas map
    010-small-files.md                       ┐
    020-schema-inference.md                  │
    030-file-formats.md                      │
    040-partition-sizing.md                  │ ← the 9 split files,
    050-high-cardinality-partitioning.md     │   kept as the canonical copies
    060-over-caching.md                      │
    070-storage-levels.md                    │
    080-lazy-cache-trap.md                   │
    090-data-skew.md                         ┘ ← merged with 1.5_DataSkewHandling
    100-broadcast-memory-bombs.md            ┐
    110-join-ordering.md                     │ ← rescued from the truncated monolith
    120-aggregation-passes.md                │
    130-high-cardinality-groupby.md          ┘ ← rescued AND finished
    140-udfs.md                              [NEW] the monolith's unwritten promise

  090-reference/
    010-interview-questions.md               ← 1.11, minus material promoted to real articles
    020-certification-questions.md           ← 1.14
    030-scala-cheatsheet.md                  ← 1.10
```

**Moves out of the section:**

- `2.0_Spark_To_ADLS/2.0_Spark_To_ADLS.md` → split at its second `#` into
  `DE-Projects/Sparkzure/010-connecting-spark-to-adls.md` and `020-sorting-files-in-adls.md`.
  Three of the four inbound links already point there.
- `3.0_Databricks/*` → its own top-level **Databricks** tab (see §5.4).
- `DevOps/Docker/…/4.9.1_Hive_Concepts.md` → reduced to a link to the canonical `090-hive.md`.

### 5.4 Proposed Databricks tab

```
docs/Databricks/
  index.md                                   [NEW]
  010-what-is-databricks.md                  ← 3.0
  020-clusters-and-compute.md                ← 3.0 §Clusters, expanded
  030-magic-commands.md                      ← 3.6
  040-unity-catalog-and-metastore.md         ← 3.1
  050-connecting-to-adls.md                  ← 3.2 + 3.3 merged
  060-secret-scopes.md                       ← 3.4
  070-delta-lake.md                          ← 3.7, expanded from 182 w
  080-databricks-sql.md                      ← 3.5, expanded from 77 w
  090-project-ecommerce-with-dbt-and-adf.md  ← 4.8, with prerequisites stated
```

### 5.5 URL stability — a blocking prerequisite

Every rename changes a public URL. `use_directory_urls: false`, so
`1.2_SparkArchitecture.md` is served as `.../1.2_SparkArchitecture.html` today.

**`mkdocs-redirects` is not installed** (`requirements.txt` has no entry, `mkdocs.yml` has no
`redirects:` block). Without it:

- the 4 known inbound links break — `mkdocs build --strict` will catch those;
- every external link, bookmark, and search-engine result 404s **silently**.

Recommendation: add `mkdocs-redirects` to `requirements.txt` and generate a
`redirect_maps:` entry for all 41 old paths **before** any file is renamed. Cost: one dependency
and ~41 lines of YAML. This is cheap now and impossible later.

---

## 6. Consistency

| Issue | Count | Detail |
|---|---:|---|
| **Hardcoded inline colours** | 9 files | `<span style="color: #ff6600">` etc. The site has a light/dark palette toggle; these are baked to one scheme and become unreadable in `slate`. Files: `1.13`, `1.15`, `1.1`, `1.2`, `1.6`, `Install-Pyspark-Windows`, `2.1`, `3.4`, `3.6`. |
| **Raw `<img>` with hardcoded chrome** | 9 files | `style="border: 1px solid #ddd; box-shadow: …"` — light-mode chrome in markup. Should be plain `![]()`, which `glightbox` already enhances. |
| **Three admonition dialects** | — | 13 files use `!!!`, 10 use `=== "tabs"`, 3 use `???`. `CLAUDE.md` specifies `!!!` for narrative, `??? tabs` for project write-ups. |
| **Inconsistent opening heading level** | — | Some files open `#`, some `##`, `3.2` opens `###`, `1.12` opens with an image before any heading. |
| **Multiple `#` per file** | 2 files | `3.7_DeltaLake_And_Lakehouse.md`, `2.0_Spark_To_ADLS.md`. |
| **Nav label ≠ page title** | many | nav "Concepts" → `# Overview`; nav "Setup Guide" → `# Getting Started with Data Engineering…`. |
| **Duplicate nav labels** | 1 | "PySpark Gotchas" appears twice in the Spark tab. |
| **Mermaid unused** | — | `pymdownx.superfences` already wires a `mermaid` custom fence, and 9 pages elsewhere on the site use it. **Zero Spark pages do**, despite the section being full of architecture, lifecycle, and DAG explanations currently carried by screenshots. |

---

## 7. Reader experience

- **Two of the three most-linked entry points are broken promises.** The tab's first article has
  an empty heading; its flagship "Complete Guide" stops mid-sentence.
- **Nothing ends.** Articles stop when the author ran out of notes. `1.12` stops mid-clause.
  `3.7` stops on a PDF link. `2.0_PySpark_Gotchas` stops inside a docstring.
- **Nothing leads anywhere.** Zero cross-links. Every article is a cul-de-sac.
- **Screenshots do the work prose should do.** `1.0_Spark-Concepts.md` renders "Spark
  Architecture" as an image and says nothing about it. Mermaid is already available.
- **The reader is quizzed before being taught.** `1.4` and `1.5` end in knowledge checks; the
  concepts they test are explained later in the tab.

---

## 8. Recommended sequence of work

Ordered so that each phase is independently valuable and independently revertible.

**Phase 0 — Prerequisites (no content change).**
Add `mkdocs-redirects`. Decide the Databricks split. Agree the naming convention.

**Phase 1 — Remove duplication.** *Highest value, lowest risk, no renames.*
Rescue gotchas #10–#13 from the monolith into the split folder; finish #13; delete the monolith.
Merge `1.5_DataSkewHandling` into the canonical skew article. Collapse the three PySpark-vs-Spark
explanations into `1.0.1`. Move `1.12`'s content into a real shuffle article.
*Removes ~5,000 duplicated words and one structurally broken file.*

**Phase 2 — Restructure.** Rename, renumber, move, write the redirect map, rewrite `nav:`.
One commit, verified with `mkdocs build --strict`.

**Phase 3 — Rewrite, one article at a time,** in reading order, starting with
`010-what-is-spark.md`. Each rewrite ends with a summary and a "next" link, so the chain
knits itself together as it goes.

**Phase 4 — Write the new articles.** Spark UI first (it is the keystone), then AQE, joins,
lazy/Catalyst, DataFrame basics.

**Phase 5 — Final pass.** Re-read the section end to end as a reader. Verify every cross-link,
every "next", every heading level. Convert the remaining screenshots to Mermaid where a diagram
would say it better.

---

## 9. Open decisions (need approval)

1. **Restructure depth** — full (split Databricks into its own tab, rename folder to
   `docs/Spark/`) vs. Spark-tab-only renumbering vs. content-only (no renames at all).
2. **URL stability** — add `mkdocs-redirects` before renaming, or accept 404s on old URLs.
3. **Gotchas canonicalisation** — keep the nine split files and port #10–#13 into them
   (recommended), or repair the monolith and delete the folder.
