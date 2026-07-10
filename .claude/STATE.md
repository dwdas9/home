# Project State

**Updated:** 2026-07-10 · **Branch:** `changes-cleanup` · **Working tree:** review doc uncommitted

Keep this file under one screen. It answers one question: *what would the last session tell me
if I could ask them?* Delete finished items rather than accumulating a changelog — git is the
changelog.

---

## In flight

**Editorial curation of the site, one section at a time.** The owner wants the site turned from
accumulated notes into a curated technical handbook. Standing workflow: review a whole section
first, produce a plan, **wait for approval**, then rewrite one article at a time. Never review an
article in isolation. See `DECISIONS.md`, "Editorial curation workflow".

**Spark is the first section.** Review complete and written to
`.claude/reviews/spark-editorial-review.md`. **Awaiting approval — nothing has been rewritten.**

Three decisions block Phase 1:

1. Restructure depth (split Databricks into its own tab? rename `Spark-DataBricks/` → `Spark/`?)
2. URL stability — add `mkdocs-redirects` before renaming, or accept 404s?
3. Gotchas canonicalisation — keep the 9 split files, or repair the monolith?

Headline findings, so a future session need not re-derive them:

- **Zero internal cross-links** among the section's 41 articles. Only 4 inbound links from the
  rest of the site, and 3 point at a *project* write-up misfiled as a concept page.
- **~10,000 of ~40,400 words are duplicated.** `1.0_Spark/2.0_PySpark_Gotchas.md` and the 9 files
  in `1.1_PySparkGotchas/` are the same nine gotchas. Both appear in `nav:` under the same label.
- **The monolith is truncated** — 97 code fences (odd), ends mid-docstring with no newline. It is
  the *only* home of gotchas #10–#13. Neither copy is complete.
- Data skew explained 3×, caching 5×, Hive 6× (once from the DevOps tab), shuffle 3×.
- The dedicated shuffle page (235 w) says less about shuffle than the architecture page does.

## Next

1. Get the three decisions above answered, then start **Phase 1 (de-duplication)** — highest
   value, no renames, fully revertible. Phases are listed in §8 of the review doc.
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
