# Decisions

Append-only. Newest first. One entry per decision that a future reader might otherwise
reverse without realising it was a choice.

Record the **rationale and the rejected alternative** — not what changed. What changed is in
the diff. Why it changed is only ever here.

Entry format: `## YYYY-MM-DD — Title`, then *Decision* / *Why* / *Rejected*.

---

## 2026-07-11 — Sketches must be funny, and carry a title in the frame

**Decision:** The signature sketches are held to a comedy bar: each must land a **genuine,
recognisable engineering gag** (not just an exaggerated diagram) **and carry a short hand-lettered
title inside the image.** The briefing loop is now *pitch the joke and analogy first → owner says it's
funny → then write the full image prompt.* The title overrides `STYLE.md`'s "no text beyond labels"
rule. First sketch made this way and shipped: `frankenstein-server.jpg` (one PC upgraded into an
exploding jet-engine contraption = SCALE UP, beside bored cheap boxes = SCALE OUT) for Module 0.1.

**Why:** The owner rejected the first two prompts (a bodybuilder ox, then a Frankenstein *without*
the comedy foregrounded) as "just AI — no concept." A merely *exaggerated* drawing reads as generic;
humour rooted in a situation an engineer recognises is what makes the idea stick — *"they laugh, they
remember."* A title sharpens the punchline like a New Yorker cartoon and gives the picture a second
beat.

**Rejected:** The literal analogy sketches briefed earlier the same day (strongman-under-a-piano for
scale-out, and the by-the-book "one strong analogy, minimal, no title" reading of `STYLE.md`). They
were clear but inert. Comedy costs a round or two of iteration per sketch and occasionally bends the
chosen analogy toward whatever is funniest — accepted, because memorability is the whole point of
having sketches at all. The one-claim rule and the "brief lives inline as a comment" workflow from the
entry below are unchanged; only the bar for what earns a laugh is raised.

## 2026-07-11 — Illustration briefs live inline as HTML comments, analogy-first

**Decision:** The illustration workflow is refined on three points (`STYLE.md` updated): (1)
**analogy-first** — discover the best real-world analogy *before* designing a sketch; the drawing
is the last step. (2) **Generous density** on the actively-taught articles — ten-plus sketches on a
long hard article is fine, provided each still passes the one-claim rule. (3) The **brief is written
inline at the anchor point, wrapped in an HTML comment** (`<!-- ILLUSTRATION: slug … -->`), not only
in `manifest.md`. The comment holds Purpose/Concept/Analogy/Composition/Labels/Alt/Caption/Style;
`manifest.md` keeps a one-line pointer as the backlog index. When the PNG exists, the comment is
swapped for the `<figure class="sketch">` block.

**Why:** The owner's expanded illustration brief asks for prompts co-located with the prose,
created as the article is written, so a future session sees exactly which drawings were intended
and where. Inline comments deliver that. They also dodge two hard local constraints that the
owner's literal format (`![](images/placeholder.png)` + a visible `> IMAGE_PROMPT` blockquote)
would have hit head-on.

**Rejected:** The literal visible-placeholder format — `mkdocs build --strict` **aborts** on an
image path that does not resolve, so a `placeholder.png` reference breaks the build (the safety net
run before every commit); and everything under `docs/` is **published**, so a raw prompt blockquote
would appear to public readers. A single shared real `placeholder.png` on disk would fix the build
half but still leak prompt text to readers and risk placeholder images shipping to the live site.
Keeping briefs *only* in `manifest.md` (the prior workflow) — rejected because it separates the
brief from the paragraph it serves; the inline comment plus a manifest pointer gives both locality
and a single backlog view.

## 2026-07-10 — Hand-drawn sketches are the site's signature, and they argue

**Decision:** Articles carry many rough, hand-drawn, black-ink sketches — not one hero image.
Style is locked in `.claude/illustrations/STYLE.md`; every planned drawing is briefed in
`.claude/illustrations/manifest.md` before it is generated. The governing rule: **an illustration
makes exactly one claim, and the claim must be writable as a single sentence before anything is
drawn.** No sketch is decorative. Density of roughly one per major section is expected.

Placement is normally **at the paragraph where the reader is about to get it wrong**, not at the
top of the article. There the drawing answers a question the reader has already formed. A hero
sketch is reserved for articles whose entire thesis *is* the counterintuitive idea.

**Why:** The factual content of an article about Spark or Git is a commodity — thousands of sites
have it. What a reader remembers, and links to, is how it was shown. A drawing of a cake with one
slice missing next to its recipe teaches lineage better than three paragraphs, and it survives in
memory long after the wording is gone. That memorability is the differentiator the owner is buying.

**Rejected:** A sketch at the top of *every* article — a fixed slot at a fixed size becomes
wallpaper within a dozen pages, readers develop banner blindness to it, and it silently commits
241 pages to a quota that will be half-met and therefore look unfinished. Also rejected: text
inside the images beyond ≤4 short hand-lettered labels (unsearchable, untranslatable, invisible to
screen readers, and where image models are weakest); recurring mascot characters (decoration, not
argument).

**Deferred, knowingly:** Dark mode. Black ink on off-white glares in the `slate` scheme. The owner
ruled this secondary. The prompt still asks for transparent backgrounds so that one CSS
`filter: invert()` rule can fix it later without regenerating anything.

**Constraint discovered:** `mkdocs build --strict` **aborts** on an image path that does not
resolve. Briefs are therefore committed to the manifest, never as `<figure>` markup awaiting a PNG.

## 2026-07-10 — Editorial curation workflow: review a whole section, then wait

**Decision:** The site is being converted from accumulated notes into a curated technical
handbook, **one section at a time** (a section = a top-level `nav:` tab). For each section:
review the whole thing first, produce a written editorial plan under `.claude/reviews/`, **wait
for the owner's approval**, and only then rewrite article by article. Never review or rewrite an
article in isolation. Restructuring — merging, splitting, deleting, renumbering, adding new
articles — is in scope and expected; existing structure carries no presumption of correctness.

The guiding principle is **curation over accumulation**: every article must earn its place in a
learning journey, and the section as a whole is the unit of quality, not the paragraph.

**Why:** The pages were written fast, while learning, over years. Polishing prose page-by-page
would preserve exactly what is wrong — the sequencing, the duplication, the dead ends. The Spark
review made the cost concrete: ~10,000 of ~40,400 words are the same nine gotchas written twice,
and no article in the section links to any other. Neither defect is visible from inside a single
article, so an article-at-a-time reviewer would never find them.

**Rejected:** Copy-editing in place (cannot see cross-article duplication or ordering problems).
Reviewing and rewriting in the same pass (the owner wants to approve structural surgery before it
happens, because deletions and renames are expensive to undo once the site has published them).
Putting review documents in `docs/` — everything there is published to the public site.

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

## 2026-07-12 — The Content Bible outranks everything, and the hook says so

The owner supplied `.claude/CONTENT-BIBLE.md` as "the most important guiding principle", to be read
before writing anything. It is now the single source of truth for how the site explains things and it
outranks CLAUDE.md itself.

Three mechanisms enforce it, because a doctrine nobody reads is decoration:
1. CLAUDE.md opens with it, above even the "start here" pointer to STATE.md.
2. `.claude/scripts/context.sh` injects "READ THE CONTENT BIBLE BEFORE WRITING ANY PROSE" into every
   SessionStart and PostCompact, so a fresh or compacted session cannot miss it.
3. Part 11's checklist is the ship gate. "Mostly" is a no.

**`TEACHING-BRIEF.md` was deleted the same day it was written.** It was the assistant's condensation
of an earlier version of the same brief, and the Bible supersedes it completely. Two overlapping
doctrine files drift, and the moment they disagree the writer picks the one that suits them, which is
how a style guide dies. One law, one file. WRITING-STYLE.md survives only because it is the long-form
reference *behind* Part 3, not a competing account of it.

**The warehouse world is kept**, recorded in CLAUDE.md rather than in the Bible, because it is a
content decision (which analogy this site chose) rather than a rule of explanation (Bible §6.5 says
prefer analogies that extend, and the warehouse is us obeying that).

## 2026-07-12 — Two species of image, and the conflict that forced STYLE.md to be rescoped

The owner revised the Content Bible: Part 2.9 now invokes the **bizarreness effect**, and Part 4
splits every image on the site into two species with **opposite laws**.

- **Anchor image** (4.4): one per concept, at the top, job is *memory*. Deliberately strange. Its 5
  to 10 embedded words *are* the definition. Style **varies relentlessly, never twice in a row.**
  Must pass the **fusion test**: describe it in one sentence, and that sentence must state the
  concept's defining property.
- **Teaching diagram** (4.5): plain, placed where discussed, job is *understanding*, one locked hand.

**This contradicted `illustrations/STYLE.md` in four places,** and the contradiction was not
cosmetic. STYLE.md exists so that "sketch #40 comes out in the same hand as sketch #3"; it says
images do *not* go at the top; it caps text at four labels; and its master prompt is what "makes
forty images look like one artist." The anchor image inverts every one of those.

**Resolved by scope, not by deletion.** STYLE.md is now explicitly the law of *teaching diagrams
only*, with a table at the top showing the split and a hard instruction never to apply its master
prompt to an anchor. Both documents are right about their own species. Locking an anchor to a house
style would destroy the exact property that makes it work, and letting a teaching diagram improvise
its style would destroy the shape vocabulary that makes the fifth article cheap to read.

**Consequence for the live pipeline:** F-01 (`frankenstein-server`, ink sketch) is article 1's
anchor, and it passes fusion. F-02 to F-07 sit inside the article, so they are teaching diagrams and
keep the locked prompt. Article 2's anchor therefore **may not be an ink sketch.**
