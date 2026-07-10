# Decisions

Append-only. Newest first. One entry per decision that a future reader might otherwise
reverse without realising it was a choice.

Record the **rationale and the rejected alternative** — not what changed. What changed is in
the diff. Why it changed is only ever here.

Entry format: `## YYYY-MM-DD — Title`, then *Decision* / *Why* / *Rejected*.

---

## 2026-07-10 — No AI attribution in commits or PRs

**Decision:** `attribution.commit` and `attribution.pr` are empty strings in
`.claude/settings.json`, and `CLAUDE.md` forbids hand-writing a `Co-Authored-By` trailer. The
repository owner is the sole author. Two commits that already carried the trailer were rebuilt
without it before being pushed.

**Why:** Several different assistants are used in this repository. A trailer naming one of them
implies that tool has standing in the history it does not have, and makes the log misleading
rather than informative. The owner is already recorded as both author and committer.

**Rejected:** A `Co-Authored-By` naming the owner — they are already the author, so the trailer
would list the same person twice. Renaming `CLAUDE.md` / `.claude/` for further de-branding —
the published site never contains either name (`docs/` is clean and `gh-deploy` publishes only
the built `site/`), and hooks and slash commands load only from `.claude/`, so renaming that
directory would silently disable the snapshot system.

## 2026-07-10 — Crash resilience: git refs as a write-ahead log, not a new snapshot system

**Decision:** A `PostToolUse` hook on `Write|Edit` snapshots the working tree into
`refs/snapshots/<ts>-edit` using a temporary index (`read-tree` → `add -A` → `write-tree` →
`commit-tree` → `update-ref`). `PreCompact` takes one more before the context window is
summarized. `SessionStart` and `PostCompact` inject branch, dirty files, and the newest snapshot
ref straight into model context.

**Why:** When a session dies, file edits survive on disk — the *conversation* is what is lost.
So there are two distinct problems. Bytes are protected automatically by snapshots; orientation
is protected by `STATE.md` being injected rather than remembered. `/handover` alone was
insufficient because it only runs on a graceful exit, which is exactly what a crash denies.

The temporary-index technique matters: it means a snapshot can be taken at any instant, including
mid-edit, without touching `HEAD`, the index, or the working tree. Snapshots live under
`refs/snapshots/` so the default push refspec (`refs/heads/*`) never uploads them.

**Rejected:** Auto-committing to the branch (pollutes history, fights the user's own staging).
`git stash create` (silently omits untracked files — `CLAUDE.md` would have been lost).
A `Stop`-hook nudge to update STATE.md — `Stop` fires after *every* assistant turn, so it would
nag constantly.

## 2026-07-10 — Hook scripts depend on git and sed only

**Decision:** `.claude/scripts/*.sh` avoid `jq` and `python`, hand-rolling JSON escaping in `sed`.

**Why:** `jq` is not installed on this machine, and the only `python` on `PATH` lives in `.venv`,
which is gitignored and may not exist. A resilience hook that fails when the environment is
degraded is worse than no hook, because it fails silently at exactly the moment it is needed.

**Rejected:** `jq` (absent); `python -c` (dependent on a gitignored virtualenv).

## 2026-07-10 — Handover lives in `.claude/`, never in `docs/`

**Decision:** Session state and this log live in `.claude/`, tracked in git. `CLAUDE.md` sits at
the repo root and is loaded automatically into every session.

**Why:** `docs/` is the MkDocs `docs_dir`. Anything placed there is built into the public site.
Handover notes in `docs/` would be published to the internet.

**Rejected:** A `docs/internal/` folder — same publishing problem, and excluding it would mean
maintaining an `exclude_docs` rule forever. Also rejected a separate "snapshot" or checkpoint
system: git already provides checkpoints. The reason existing checkpoints are useless is that
1077 commit messages say `changes`, not that the mechanism is missing. Fixing the messages is
the fix.

## 2026-07-10 — Naming the Home tab project group

**Decision:** The nav group inside the Home tab is `Professional Projects`. The heading on the
page itself is just `## Projects`.

**Why:** A top-level `Projects` tab already exists (`DE-Projects/` — StreamKraft, Sparkzure,
demo builds). The `AboutMe/` pages are résumé-style client engagements. Both are visible in the
global nav chrome simultaneously, so the sidebar label must disambiguate. Within the page body
nothing competes with the word "Projects", so the shorter heading reads better after the
Professional Journey narrative.

**Rejected:** Naming both `Projects` (ambiguous in the sidebar); naming both
`Professional Projects` (clumsy as an on-page heading).

## 2026-07-10 — Home and About Me share one tab

**Decision:** `Home` became a nav *section* whose index page is `index.md`, with the About Me
pages nested beneath it. Relies on the `navigation.indexes` theme feature, already enabled.

**Why:** The Home tab *is* the about-me page — its content is Early Life, Family, Professional
Journey. A group inside it labelled "About Me" was describing the containing tab, not its own
contents. What the group actually holds is projects.

**Rejected:** Flattening the three pages directly under `Home` with no group label — loses the
useful grouping. Note the bare `- 'index.md'` entry (no title) is what makes the tab itself
land on the homepage rather than on the first child page; do not give it a title.

## 2026-07-10 — Enabled `md_in_html`

**Decision:** Added `md_in_html` to `markdown_extensions`.

**Why:** Required by Material's `<div class="grid cards" markdown>` component. Confirmed inert
for existing content before enabling: no file under `docs/` uses a `markdown=` attribute on raw
HTML, so nothing else re-renders.

**Rejected:** A plain linked list instead of cards — chosen against for visual weight on the
landing page.
