# Project State

**Updated:** 2026-07-11 · **Branch:** `spark-curation` · **Working tree:** clean · **Never pushed**

Keep this file under one screen. It answers one question: *what would the last session tell me
if I could ask them?* Delete finished items rather than accumulating a changelog — git is the
changelog.

---

## The standing brief

Turn this site from accumulated notes into **world-class technical articles** a developer bookmarks
and recommends. The owner runs the assistant as **editor-in-chief**: execute the roadmap
autonomously, one article to publication quality at a time; interrupt only for strategic forks,
external assets (images), or contradictions. The reframed vision is *"how a data engineer should
think,"* not "Spark docs" — begin with why distributed computing exists at all.

1. **One article at a time.** Don't move on until it's publication quality. Rewrite; correct
   inaccuracies rather than repeat them.
2. **Hand-drawn sketches are the signature — and they must be funny.** A real, recognisable
   engineering gag plus a hand-lettered **title** inside the frame. Exaggeration alone reads as
   generic AI ("no concept"). Pitch the joke, get a yes, then write the prompt. Owner saves images
   as **.jpg**. Read `.claude/illustrations/STYLE.md` before any image; titles override its
   "no text beyond labels" rule.

Plans: `.claude/reviews/ecosystem-curriculum-masterplan.md` (the ecosystem on-ramp) and
`spark-editorial-review.md` (the Spark tab). `DECISIONS.md` when a choice looks arbitrary. Work on
`spark-curation`. **Nothing is published;** `ci.yml` deploys only from `main`.

---

## In flight

**Track B — the on-ramp. Module 0 (Why Big Data) is COMPLETE and live on the branch.** New tab
`docs/BigDataFoundations/`, three articles forming one continuous arc, all `mkdocs build --strict`
clean:
- `010-why-big-data/when-one-machine-isnt-enough.md` — the true entry point (three walls → scale out).
- `010-why-big-data/three-hard-problems.md` — store / survive / coordinate; the diagnostic lens.
- `010-why-big-data/ecosystem-map.md` — layered Mermaid map, no sketch by design. Normal page for
  now; promote to the tab `index.md` during the eventual restructure.

**Illustration pipeline — running one sketch at a time with the owner.**
- **F-01 `frankenstein-server.jpg` is LIVE** (thesis image atop article 1). Comedy-first winner.
- **F-02 `top-of-the-range.jpg` — prompt delivered in chat, owner is generating it.** It's the funny
  rework of the price-ceiling idea (computer shop, biggest box bursts through the roof, `$99,999,999`,
  moth from the wallet, `NO BIGGER!`). When it lands: save to the sketches folder, **replace the old
  `bigger-box-price-ceiling` inline `<!-- ILLUSTRATION -->` brief in article 1's Wall 1 section** with
  `<figure>`, flip manifest F-02 to live, strict build, commit.
- **F-03…F-07 inline briefs and manifest entries are still the ORIGINAL, too-literal versions**
  (all-eggs-one-basket, many-hands-one-book, warehouse-manifest, understudy-steps-in,
  jigsaw-to-one-table). **Do not hand those to the owner as-is** — each must first be reworked to the
  funny-gag-plus-title bar, pitched, approved, then generated. F-03 next; my pitch idea: one smug
  giant server tripping over its own power cord while the little cluster shrugs.

## Next

1. **Wire in F-02 `top-of-the-range.jpg`** the moment the owner saves it (steps above).
2. **Continue F-03 → F-07**, one at a time, reworking each to the comedy+title bar before the owner
   generates it. Update both the article's inline brief and `manifest.md` when a concept changes.
3. **Then resume writing: Track B Module 1 — Hadoop, starting with HDFS (1.2).** Then YARN (1.3),
   MapReduce (1.4, the "why Spark" hinge), modes (1.5). Salvage the buried
   `DevOps/Docker/ContainerStacks/BigDataStack/4.9.2_Hadoop_Concepts.md` rather than restating it
   (plan §3/§4). Wire the ecosystem-map's forward links to these as they land.

**Track A — the Spark tab — is PAUSED** (owner chose the on-ramp first). When resumed, the detailed
plan is in `spark-editorial-review.md`; the first two steps are (a) wire `lineage-cake.png` into
`1.0_Spark-Concepts.md` *(generated last session but never saved to the repo — must be re-generated;
save to `docs/Spark-DataBricks/1.0_Spark/images/sketches/`, insert after "…the recipe that produced
it", mark S-04 live)*, then (b) rewrite `1.0.1__Python_PySpark_Spark_Confusion.md`. Keystone gaps to
write: **Reading the Spark UI**, AQE, Joins, Lazy/Catalyst. The docs/ restructure is deliberately
deferred to one final batch.

## Blocked / open questions

- **Images are owner-generated (external asset).** F-02 is with the owner now.
- Crash-resilience hooks may still not be live — `refs/snapshots/` needs a fresh check
  (`git for-each-ref refs/snapshots/`); open `/hooks` once if empty.
- Branch has **no upstream**; never pushed. Merging to `main` publishes immediately.
- Minor, unanswered: Home tab's on-page `## Projects` vs sidebar `Professional Projects`;
  `refs/backup/pre-detrailer` safe to delete.

## Assumptions a future session should not re-derive

- `mkdocs.yml` `nav:` is the site map. **Do not scan `docs/`.** A new `.md` is invisible until added.
- Everything under `docs/` is published. Notes live in `.claude/`.
- **`mkdocs build --strict` aborts on an image path that does not resolve.** Never write `<figure>`
  markup before the image file is on disk — that's why briefs go in as HTML comments.
- `use_directory_urls: false` (forced by `offline`), so a filename *is* its URL; every rename needs a
  `redirect_maps` entry. Mermaid works (superfences). **Caveat** font loaded for sketch captions.
- Material code annotations (`# (1)!`) render as literal text here — use plain comments.
- `pymdownx.details`/admonition titles have no escape syntax — use typographic quotes.
- `mkdocs.exe`/`mkdocs` live in `.venv/Scripts`; `jq` is not installed; hook scripts use git + sed
  only, on purpose.
- Track A duplication still to resolve when it resumes: caching 5×, Hive 6×, shuffle 3×, skew 2×,
  PySpark-vs-Spark 3× (see `spark-editorial-review.md`).
