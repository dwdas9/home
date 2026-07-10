# Project State

**Updated:** 2026-07-10 · **Branch:** `spark-curation` · **Working tree:** clean, not pushed

Keep this file under one screen. It answers one question: *what would the last session tell me
if I could ask them?* Delete finished items rather than accumulating a changelog — git is the
changelog.

---

## In flight

**Editorial curation of the site, one section at a time.** The owner wants the site turned from
accumulated notes into a curated technical handbook. Standing workflow: review a whole section
first, produce a plan, **wait for approval**, then rewrite one article at a time. Never review an
article in isolation. See `DECISIONS.md`, "Editorial curation workflow".

**Spark is the first section.** Review written to `.claude/reviews/spark-editorial-review.md`.
**Plan approved.** All three open decisions were answered with the recommended option:

1. **Full restructure** — rename `Spark-DataBricks/` → `Spark/`, split Databricks into its own
   top-level tab, renumber as `010/020/030` across five modules, move Sparkzure to Projects.
2. **Add `mkdocs-redirects` before renaming.** Done (Phase 0).
3. **The nine split gotcha files are canonical.** The monolith is deleted. Done (Phase 1a).

Work happens on branch `spark-curation`, cut from `changes-cleanup` so the Home-tab PR stays
reviewable on its own. Phases are listed in §8 of the review doc.

### Done

- **Phase 0** (`5b68d3f`) — `mkdocs-redirects` pinned `<1.2.3` in `requirements.txt`, plugin wired
  into `mkdocs.yml` with an initially empty `redirect_maps`. *1.2.3 drags in `properdocs`, a second
  copy of the docs engine (the MkDocs 2.0 rebrand). Do not lift the pin without reading that.*
- **Phase 1a** (`0f5b086`) — deleted the truncated `1.0_Spark/2.0_PySpark_Gotchas.md`; rescued its
  four unique gotchas into `1.1_PySparkGotchas/` as `BroadcastingMemoryBombs`,
  `InefficientJoinOrdering`, `MultiplePassAggregation`, `HighCardinalityGroupBy`; added an
  `index.md` with a symptom→article lookup; old URL redirects to that index. Strict build clean,
  redirect stub verified in the built site.

  Rewritten, not copied — the originals contained a Python `SyntaxError`, a non-existent
  `getBroadcastInfos()` API, a function used as a context manager, the claim that broadcast memory
  scales with executor *cores* (it is one copy per *executor*), and a false premise that a 10M-key
  `groupBy` exhausts memory (Spark pre-aggregates map-side and spills).

### Remaining

Phase 1b (merge the other duplicated topics) → Phase 2 (rename + nav + redirect map) →
Phase 3 (rewrite in reading order) → Phase 4 (new articles) → Phase 5 (cross-links, Mermaid).

Headline findings, so a future session need not re-derive them:

- **Zero internal cross-links** among the section's 41 articles. Only 4 inbound links from the
  rest of the site, and 3 point at a *project* write-up misfiled as a concept page
  (`2.0_Spark_To_ADLS.md`, which holds **two** articles — second `#` heading at line 278).
- Still duplicated, awaiting Phase 1b: **data skew 3×** (`1.5_DataSkewHandling.md` + the gotcha),
  **caching 5×** (`1.3_persist_and_cache.md` + gotchas #6/#7/#8 + a section inside `1.12`),
  **Hive 6×** (incl. `DevOps/Docker/…/4.9.1_Hive_Concepts.md` in another tab),
  **PySpark-vs-Spark 3×**, **shuffle 3×**.
- The dedicated shuffle page (`1.12`, 235 w) says less about shuffle than `1.2_SparkArchitecture.md`
  does, and its last sentence is broken mid-clause.
- `1.0_Spark-Concepts.md` — the section's entry point — has an **empty `## Spark RDDs` heading**.
- `1.11_Spark_Interview_Questions.md` holds the section's *only* coverage of join strategies and
  Catalyst's phases. Promote that material before trimming the page.
- `Install-Pyspark-Windows.md` contains a dead absolute link to
  `/Pyspark_And_Spark/PysparkIsNotFullSpark.html` (page no longer exists). Strict build only
  logs it as INFO because it is absolute — fix during the rewrite.

## Next

1. **Phase 1b** — merge the remaining duplicated topics listed above. No renames yet.
2. **The hooks are not live yet.** `.claude/` did not exist when the authoring session started,
   so the settings watcher never picked it up. Open `/hooks` once, or start a new session, then
   confirm by making any edit and running
   `git for-each-ref refs/snapshots/` — an `-edit` ref should appear. This is the only thing
   standing between you and automatic crash protection.
3. Open a PR from `changes-cleanup`, or merge it. **Merging to `main` publishes to the live
   public site immediately** via `mkdocs gh-deploy --force` — see `CLAUDE.md`. The Home-tab work
   is pushed but nothing is published yet.

## Blocked / open questions

- On-page heading is `## Projects` while the sidebar group is `Professional Projects`. Deliberate
  (see DECISIONS, "Naming the Home tab project group"), but the user may want them identical.
  One-word change in `docs/index.md`.

## Assumptions a future session should not re-derive

- `mkdocs.yml` `nav:` is the site map. Do not scan `docs/` to discover pages.
- Everything under `docs/` is published. Notes never go there — that is why the editorial review
  lives in `.claude/reviews/`.
- The Home-tab change moved no file and changed no URL, so it needed no redirects. **The Spark
  restructure is not like that** — every rename changes a public URL, and `mkdocs-redirects` is
  not currently installed.
- `use_directory_urls: false` (forced by the `offline` plugin), so a filename *is* its URL.
  Renaming `1.2_SparkArchitecture.md` breaks `.../1.2_SparkArchitecture.html`.
- `pymdownx.superfences` already wires a `mermaid` custom fence, and 9 pages elsewhere use it.
  Diagrams cost nothing to add. Zero Spark pages use them.
- `jq` is not installed and the only `python` lives in `.venv`. Hook scripts therefore depend on
  git and sed only, on purpose. Do not "simplify" them with `jq`.
