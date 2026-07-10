# Project State

**Updated:** 2026-07-10 · **Branch:** `changes-cleanup` · **Working tree:** clean, pushed to origin

Keep this file under one screen. It answers one question: *what would the last session tell me
if I could ask them?* Delete finished items rather than accumulating a changelog — git is the
changelog.

---

## In flight

Nothing half-finished. Both pieces below are pushed to `origin/changes-cleanup`. **Not merged.**
`origin/main` is untouched, so the live site still shows the old Home tab.

**1. Home tab restructure.** The tab now reads as one story: Early Life → Family → Professional
Journey → Projects.

- `mkdocs.yml` — `Home` is a nav *section* (index page `index.md`) so Home and About Me share one
  tab. Former `About Me:` group renamed `Professional Projects:`. Enabled `md_in_html`.
- `docs/index.md` — appended a `## Projects` section: a three-card Material grid linking the three
  `docs/AboutMe/` pages, which previously had **no inbound links from anywhere**.

Verified: `mkdocs build --strict` passes; 13 tabs, Home did not split; cards rendered as real
cards (6 inline `<svg>`, 3 `<hr>`, no literal `:material-…:` leaking); links resolve; the string
`About Me` is gone from the rendered site.

**2. Cross-session continuity system.** `CLAUDE.md` (auto-loaded), this file, `DECISIONS.md`,
the `/handover` command, and crash-resilience hooks in `.claude/settings.json` backed by
`.claude/scripts/{snapshot,context}.sh`.

Verified: snapshot script creates `refs/snapshots/*` without touching HEAD/index/worktree,
captures untracked files, dedups, prunes to 50. Both hook scripts emit valid JSON. All four hook
commands run verbatim. `mkdocs build --strict` still clean and no `.claude/` file leaks into the
built site.

Dark mode was verified from the built CSS rather than a browser: card icons carry no hardcoded
`fill` and inherit `fill: currentcolor`; the card border uses `var(--md-default-fg-color--lightest)`.
The `slate` scheme redefines both. The grid is theme-correct by construction.

## Next

1. **The hooks are not live yet.** `.claude/` did not exist when the authoring session started,
   so the settings watcher never picked it up. Open `/hooks` once, or start a new session, then
   confirm by making any edit and running
   `git for-each-ref refs/snapshots/` — an `-edit` ref should appear. This is the only thing
   standing between you and automatic crash protection.
2. Open a PR from `changes-cleanup`, or merge it. **Merging to `main` publishes to the live
   public site immediately** via `mkdocs gh-deploy --force` — see `CLAUDE.md`. The branch is
   pushed but nothing is published yet.

## Blocked / open questions

- On-page heading is `## Projects` while the sidebar group is `Professional Projects`. Deliberate
  (see DECISIONS, "Naming the Home tab project group"), but the user may want them identical.
  One-word change in `docs/index.md`.

## Assumptions a future session should not re-derive

- `mkdocs.yml` `nav:` is the site map. Do not scan `docs/` to discover pages.
- Everything under `docs/` is published. Notes never go there.
- No file was moved and no URL changed, so no redirects are needed.
- `jq` is not installed and the only `python` lives in `.venv`. Hook scripts therefore depend on
  git and sed only, on purpose. Do not "simplify" them with `jq`.
