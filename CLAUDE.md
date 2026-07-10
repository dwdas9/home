# Das Digital Digest — Material for MkDocs site

A personal documentation site: ~241 Markdown pages on data engineering, Azure, Spark, DevOps.
No build step, no tests, no application code. Content and navigation are the whole project.

**Start here:** read [`.claude/STATE.md`](.claude/STATE.md) for what is in flight.
Consult [`.claude/DECISIONS.md`](.claude/DECISIONS.md) when a choice looks arbitrary — it probably wasn't.

## Do not scan the repository

The `nav:` block in `mkdocs.yml` is the complete table of contents for every page on the site.
It is hand-maintained and always current. **Use it to locate pages; do not glob or grep `docs/`
to find out what exists.** Open only the specific `.md` files a task requires.

A new `.md` file is invisible to the site until it is added to `nav:`. There is no autodiscovery.

## Commands

| Task | Command |
|---|---|
| Preview locally | `mkdocs serve` |
| Verify a change | `mkdocs build --strict --site-dir "$SCRATCH/testsite"` |
| Deploy | Push to `main`. Never run `gh-deploy` by hand. |

`--strict` is the safety net. It catches unknown icon shortcodes and broken relative links,
which are the two failure modes this site actually hits. Run it before every commit.

**Deployment is automatic and public.** `.github/workflows/ci.yml` runs `mkdocs gh-deploy --force`
on any push to `main`. Merging to `main` publishes to the live site immediately.

## Layout

- `docs/` — **everything here is published.** Never put notes, plans, or scratch files here.
- `site/` — build output, gitignored.
- `.claude/` — session state and decisions. Tracked in git on purpose; that is what makes handover work.
- `*.py` at root — one-off maintenance scripts (`audit_links.py`, `fix_broken_images.py`, `resize_images.py`).
  They write `*_report.txt` alongside themselves. Not part of the build.

## Content conventions

Narrative prose uses admonitions; project write-ups use collapsible tab blocks. Match the
surrounding page rather than introducing a third style.

```markdown
!!! Quote "Section Title"        # narrative (see docs/index.md)

??? tabs "Project Name"          # engagement write-up (see docs/AboutMe/)
    === "Tab Name"
```

## Gotchas that cost a session to rediscover

- The `offline` plugin forces `use_directory_urls: false`. Links render as `page.html`,
  not `page/`. Do not "fix" this.
- `md_in_html` is enabled for Material card grids. Card list items are `-` followed by
  **three** spaces; continuation lines indent **four**. Wrong indentation silently renders a
  plain bullet list instead of cards — the build still passes. Verify by grepping the built
  HTML for `class="grid cards"` and inline `<svg>`.
- Icon shortcodes (`:material-*:`, `:octicons-*:`) work because `pymdownx.emoji` is wired to
  Material's twemoji index with the SVG generator. An unknown icon name fails the strict build.

## Crash resilience — already automatic

Hooks in `.claude/settings.json` handle the case where a session dies mid-task. You do not
invoke these; they fire on their own.

- **After every `Write`/`Edit`**, the working tree is snapshotted to `refs/snapshots/<ts>-edit`.
  Snapshots are ordinary commits built with a temporary index — they never touch `HEAD`, the
  index, or your files, and they capture untracked files too. They are local-only (never pushed).
- **Before context compaction**, a `precompact` snapshot is taken.
- **At session start and after compaction**, current branch, uncommitted files, and the newest
  snapshot are injected into context automatically.

**If you find uncommitted changes you did not make, a previous session died. Do not discard
them.** Read `.claude/STATE.md`, then:

```bash
git for-each-ref --sort=-refname refs/snapshots/   # list, newest first
git diff HEAD <ref>                                # what it holds
git restore --source=<ref> --worktree -- .         # take it back
```

Snapshots protect bytes, not reasoning. Only `STATE.md` protects reasoning.

## Session discipline

Snapshots are automatic; **state is not**. Update `.claude/STATE.md` when you finish a unit of
work — not only at the end — because the end is exactly what a crash denies you. Write down what
you are about to attempt *before* attempting it.

Finish every session with `/handover`. It updates `.claude/STATE.md`, appends any new rationale
to `.claude/DECISIONS.md`, and commits.

Write real commit messages. 1077 of the existing ones say `changes`, which is why this file
has to exist. Do not add another.

**Never add a `Co-Authored-By` trailer, and never attribute a commit or PR to an AI tool.**
The repository owner is the sole author. `attribution` is set to empty strings in
`.claude/settings.json`; do not override it, and do not hand-write the trailer either.
Several different assistants work in this repo — attribution noise makes the history
misleading rather than informative.
