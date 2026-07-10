---
description: Close out the session — update STATE.md, log any new rationale, commit.
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git add:*), Bash(git commit:*), Bash(mkdocs build:*), Read, Edit, Write
---

Close out this session so the next one can resume without re-reading the repository.

## 1. Verify before recording

Run `mkdocs build --strict` into a scratch directory. Do not record work as done if the build
fails. If it passes but you changed a card grid, grep the built HTML for `class="grid cards"`
and inline `<svg>` — card indentation fails silently.

If you cannot verify something, it goes under **Next** in STATE.md as explicitly unverified.
Never write "done" for something you did not observe working.

## 2. Rewrite `.claude/STATE.md`

Rewrite it, don't append. It describes the present, not the past.

- **In flight** — what is half-finished, and precisely where it stands. Name the files.
- **Next** — the concrete first action for the next session, including anything left unverified.
- **Blocked / open questions** — decisions awaiting the user.
- **Assumptions** — facts the next session would otherwise waste context re-deriving.

Delete anything now finished. Git is the changelog; this file is the handover. Keep it under
one screen. If it is growing, you are writing history instead of state.

## 3. Append to `.claude/DECISIONS.md` — only if a decision was made

A decision is a fork where a reasonable person would have gone the other way. Record the
rationale and the rejected alternative. Skip this step entirely if the session only executed
an already-recorded plan; an empty log is better than a padded one.

Never rewrite existing entries. Newest first.

## 4. Fold durable facts into `CLAUDE.md`

If the session cost time on something a future session would also hit — a silent failure mode,
a plugin that overrides a setting, a convention — add one line to the Gotchas section.
`CLAUDE.md` is paid on every session, so it must stay short. Prune anything no longer true
rather than letting it grow.

## 5. Commit

Stage the content changes together with the updated state files, so the state always matches
the tree it describes.

Write a real commit message: what changed and why, in one line, then detail if it warrants it.
This repository has 1077 commits titled `changes` — that is exactly why this workflow exists.
Do not add another.

**Do not push and do not merge to `main` unless explicitly asked.** CI runs
`mkdocs gh-deploy --force` on push to `main`, which publishes to the live public site.

## 6. Report

Tell the user in plain prose: what shipped, what is unverified, and the single next action.
