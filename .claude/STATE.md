# Project State

**Updated:** 2026-07-10 · **Branch:** `spark-curation` · **Working tree:** clean · **Never pushed**

Keep this file under one screen. It answers one question: *what would the last session tell me
if I could ask them?* Delete finished items rather than accumulating a changelog — git is the
changelog.

---

## The standing brief

The owner is turning this site from accumulated notes into **world-class technical articles** —
the kind a developer bookmarks and recommends. Two rules govern everything:

1. **One article at a time.** Do not move on until the current article is publication quality.
   Rewrite completely where needed. Correct inaccuracies rather than repeat them.
2. **Hand-drawn sketches are the site's signature.** Many per article, not one hero image.
   Proactively brief an illustration wherever a drawing beats a paragraph — never wait to be asked.

Read `.claude/illustrations/STYLE.md` before touching any image. Read `DECISIONS.md` when a choice
looks arbitrary. Section-level review lives in `.claude/reviews/spark-editorial-review.md`.

Work happens on `spark-curation`, cut from `changes-cleanup` so the Home-tab PR stays reviewable
on its own. **Nothing is published.** `ci.yml` deploys only from `main`.

---

## In flight

**The Spark section, article by article.** Six commits on the branch, all verified with
`mkdocs build --strict`.

### Done

- **`5b68d3f`** — `mkdocs-redirects` added, pinned `<1.2.3`. *1.2.3 pulls in `properdocs`, a second
  copy of the docs engine (the MkDocs 2.0 rebrand). Do not lift that pin casually.*
- **`0f5b086`** — Deleted the truncated `1.0_Spark/2.0_PySpark_Gotchas.md`, which duplicated the
  nine `1.1_PySparkGotchas/` articles and appeared in nav under the same label. Rescued its four
  unique gotchas as `BroadcastingMemoryBombs`, `InefficientJoinOrdering`, `MultiplePassAggregation`,
  `HighCardinalityGroupBy`. Added `1.1_PySparkGotchas/index.md` with a symptom→article lookup.
  Old URL redirects there.
- **`680d223`** — Rewrote `1.0_Spark-Concepts.md` ("What Is Apache Spark?"), the section's entry
  point. Added lineage, "when not to use Spark", the honest reading of the 100× claim, five
  misconceptions. Replaced both PNGs with Mermaid.
- **`2149380`** — Fixed literal `\"` leaking into six collapsible titles.
- **`dd54104`** — The illustration system: `STYLE.md`, `manifest.md` (13 briefs), `.sketch` CSS.

### Blocked on the owner — one thing

**`lineage-cake.png` has been generated but is not in the repo.** It was pasted into the chat, not
saved. It must be written to:

```
docs/Spark-DataBricks/1.0_Spark/images/sketches/lineage-cake.png
```

Once it exists: insert the `<figure class="sketch">` markup after the sentence ending
"**the recipe that produced it**" in the *lineage* section of `1.0_Spark-Concepts.md`, run the
strict build, mark brief **S-04** `live` in the manifest, commit.

The drawing came back better than its brief — the slice is *restored and steaming*, not missing.
Caption the drawing, not the brief. The background is off-white rather than transparent; that is
acceptable, see the dark-mode note in `STYLE.md`.

## Next

1. Wire in `lineage-cake.png` (above). Then generate the other three starred briefs: **S-08**
   crane-and-grocery-bag, **S-01** hundred-clerks, **S-03** relay-vs-filing-cabinet.
2. **Rewrite `1.0.1__Python_PySpark_Spark_Confusion.md`** — next in reading order. Already the
   strongest page in the section; it should absorb the two duplicate explanations of the same
   topic (`1.15_CommonPysparkTopics.md` §"Just PySpark vs Real Spark", and the appendix of
   `Install-Pyspark-Windows.md`). Brief its sketches while writing.
3. Then, in reading order: `1.2_SparkArchitecture` (split out jobs/stages/tasks, move its shuffle
   sections into `1.12`), `1.1_NarrowVsWideTransformation`, `1.12_Spark_Shuffle`,
   `1.3_persist_and_cache`, `1.5_DataSkewHandling`.
4. Write the missing keystone articles: **Reading the Spark UI** (the biggest gap in the section —
   thirteen gotchas assert "10× slower" and none shows how to *see* it), AQE, Joins, Lazy/Catalyst.
5. **Last, as one batch:** rename/renumber into `docs/Spark/` five modules + a separate
   `docs/Databricks/` tab, move Sparkzure to `DE-Projects/`, write the full `redirect_maps`, rewrite
   `nav:`. Deliberately deferred — renaming is mechanical and would churn every commit before it.
6. **The crash-resilience hooks are still not live.** `refs/snapshots/` holds only refs from
   2026-07-09. Open `/hooks` once, or start a new session, then confirm with an edit +
   `git for-each-ref refs/snapshots/`.
7. The branch has **no upstream**. Push when ready. Merging to `main` publishes immediately.

## Blocked / open questions

- On-page heading is `## Projects` while the sidebar group is `Professional Projects` on the Home
  tab. Deliberate (see DECISIONS), but the owner may want them identical.
- `refs/backup/pre-detrailer` still exists locally. Safe to delete; offered, never answered.

## Assumptions a future session should not re-derive

- `mkdocs.yml` `nav:` is the site map. **Do not scan `docs/`** to discover pages.
- Everything under `docs/` is published. Notes never go there — hence `.claude/reviews/` and
  `.claude/illustrations/`.
- **`mkdocs build --strict` aborts on an image path that does not resolve.** Never commit
  `<figure>` markup before the PNG exists. This is why briefs live in the manifest.
- **Material code annotations (`# (1)!`) do not work on this site.** `content.code.annotate` is
  enabled, yet the marker renders as literal text; no page in the built site has ever had a working
  annotation. Use plain comments. Do not spend a session rediscovering this.
- **`pymdownx.details` titles have no escape syntax.** `"\"quoted\""` renders the backslashes.
  Use typographic quotes.
- `use_directory_urls: false` (forced by the `offline` plugin), so a filename *is* its URL.
- Mermaid works (`pymdownx.superfences` custom fence). The **Caveat** handwriting font is already
  loaded via `extra_javascript` and is now used for sketch captions.
- Two PNGs in `1.0_Spark/images/` (`2024-09-08-01-42-45`, `2024-09-08-02-01-36`) are now orphaned.
  They had baked-in white and black backgrounds respectively, so each was unreadable in one of the
  site's two colour schemes. Replaced by Mermaid. Left on disk.
- `Install-Pyspark-Windows.md` has a dead absolute link to
  `/Pyspark_And_Spark/PysparkIsNotFullSpark.html`. Strict build only logs it as INFO because it is
  absolute. Fix during that article's rewrite.
- `1.11_Spark_Interview_Questions.md` holds the section's **only** coverage of join strategies and
  Catalyst's phases. Promote that material into real articles before trimming the page.
- Still duplicated, to be resolved as each article is rewritten: caching 5×, Hive 6× (one copy in
  the DevOps tab), shuffle 3×, data skew 2× (was 3×), PySpark-vs-Spark 3×.
- `jq` is not installed; the only `python` lives in `.venv`. Hook scripts depend on git and sed
  only, on purpose. Do not "simplify" them with `jq`.
