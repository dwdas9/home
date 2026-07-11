# Illustration style bible

Sketches are the signature of this site. They are not decoration; they are the reason a reader
remembers our explanation of shuffle rather than someone else's. Everything here exists so that
sketch #40, drawn a year from now, comes out in the same hand as sketch #3.

**Read this before generating any image.** Do not improvise the style.

---

## The one rule

> **Every illustration makes exactly one claim, and you must be able to write that claim as a
> single sentence before you draw it.**

If the sentence is "this article is about Spark", there is no illustration. If it is *"don't keep
a spare cake, keep the recipe — then rebuild only the slice you lost"*, draw it.

The claim goes in the brief. The caption is usually the claim, lightly reworded.

## Start with the analogy, not the drawing

Do not think in terms of drawings. Think in terms of ideas — then in terms of the **familiar
real-world experience that behaves almost exactly like this concept.** The drawing is the last
step, not the first.

Before briefing any sketch, generate several candidate analogies and pick the one that is easiest
to recognise, explains the most important behaviour, introduces the fewest misconceptions, and can
be drawn with a few lines. A library, a post office, a restaurant kitchen, a motorway, a moving
crew, an airport control tower, a national census. The reader should already understand the
analogy before they read the article; the sketch just makes them think *"oh — it's just like
that,"* and that recognition is the entire goal.

Different concepts want different analogies. One analogy explains fault tolerance, another
scalability, another concurrency. Do not stretch one analogy across a whole article. **One
illustration, one insight** — if you have three ideas, that is three sketches, not one crowded one.

## What earns a sketch

Draw when the drawing does work a paragraph cannot:

- A **misconception** the reader currently holds. (The most valuable case by far.)
- A **trade-off** with two visualizable sides.
- A **workflow or sequence** with a surprising step.
- A **comparison** where one side is absurd once you see it.
- A **common mistake** that is funny when drawn.

Do not draw for: reference tables, cheatsheets, Q&A pages, installation steps, changelogs, or to
fill a slot at the top of an article because other articles have one.

## Where it goes

**Not automatically at the top.** The strongest position is *the paragraph where the reader is
about to get it wrong* — the sketch then arrives as the answer to a question they have already
formed in their head.

An opening sketch is right only when the article's whole thesis is itself the counterintuitive
idea (e.g. "when you should not use Spark").

**Be generous.** On the teaching articles under active rewrite (the Spark ecosystem and its new
foundations), too few sketches is the more common failure, not too many. A long, hard article can
easily carry ten or more: an analogy sketch, a workflow, a before/after, a common-mistake, an
architecture doodle. Whenever a paragraph runs long, ask whether a drawing would replace half of
it — and if the answer is *"a good teacher would grab the marker here,"* brief the sketch.

Two limits hold regardless of generosity: **every sketch still has to earn its place** by the one
rule (it makes a single claim a paragraph could not), and **never two in a row** without prose
between them. Generosity is about frequency, not about lowering the bar — a page of ten sketches
that each land beats one polished diagram, but ten decorative ones is worse than none.

This generosity is scoped to the articles being taught, not blanket across all ~241 pages; see
`DECISIONS.md` on why a fixed sketch-in-every-article slot was rejected.

---

## The master prompt

Use this verbatim. Replace only `{SUBJECT}` and `{LABELS}`. Keep the constraint paragraphs
unchanged — they are what makes forty images look like one artist.

```text
A rough hand-drawn ink sketch in the style of an old newspaper spot illustration or a
mid-century textbook line drawing. Single black ink pen on off-white paper. Loose, slightly
wobbly, confident linework — as if drawn quickly by an engineer in the margin of a notebook or
on a whiteboard. Economical: the fewest lines that carry the idea.

No shading beyond a few sparse hatching strokes. No gradients, no grey fills, no colour, no
crosshatched volume. Flat and diagrammatic rather than perspectival. Generous empty paper around
the subject. No frame, no border, no background scenery that does not serve the idea.

The whole image must read as one clear idea at thumbnail size.

Subject: {SUBJECT}

Hand-lettered labels in scruffy uppercase, as few as possible: {LABELS}
No other text anywhere in the image.

Square-ish or 4:3. Transparent or plain off-white background.
```

### Never include

Mascots or recurring characters · company logos or brand marks · glowing laptop screens ·
isometric or 3D rendering · clean vector lines · watermarks or signatures · speech bubbles with
more than four words · anything resembling stock "tech illustration" · text beyond the specified
labels.

### Labels

At most **four** hand-lettered labels, and every one of them must also appear in the caption or
the surrounding prose. Image models letter badly and the result is unsearchable, untranslatable,
and invisible to a screen reader. The picture carries the idea; the words carry the words.

---

## Markup

Images live beside the article: `images/sketches/<idea-slug>.png`.

Name for the **idea**, not the article: `lineage-cake.png`, not `spark-concepts-fig-3.png`. When
an article is renamed — and in this repo they will be — the sketch name still makes sense.

```markdown
<figure class="sketch" markdown>
![A cake with one slice missing, beside the recipe card that will rebuild it.](images/sketches/lineage-cake.png)
<figcaption>Don't keep a spare cake. Keep the recipe, and re-bake only the slice you lost.</figcaption>
</figure>
```

`md_in_html` is enabled, which is what makes `<figure markdown>` work. `attr_list` gives the class.

**Alt text is mandatory and describes the drawing, not the claim.** The caption makes the claim.
A reader who cannot see the image must still be able to follow the article without it — the
sketch reinforces understanding, it never carries information found nowhere else.

!!! danger "A missing image fails the build"
    `mkdocs build --strict` aborts on an image path that does not resolve. **Never commit an
    `![]()` or `<figure>` referencing a PNG that does not yet exist on disk** — not even a
    `placeholder.png`. This is why the brief goes in as an HTML *comment* (below): a comment
    references no image, so the build stays green until the real drawing lands.

---

## Workflow — the brief lives inline, as a comment

Write the brief **at the exact point in the article where the drawing belongs**, so it sits with
the prose it serves and survives every rename. It goes in as an HTML comment — invisible to the
reader (everything under `docs/` is published), harmless to the strict build, and a one-for-one
swap target once the PNG exists.

```markdown
<!-- ILLUSTRATION: <idea-slug>
Purpose:     what confusion this removes.
Concept:     the single claim, as one sentence.
Analogy:     the familiar real-world thing it maps to.
Composition: the scene in enough detail that two image models would draw it the same — placement,
             figures, arrows, foreground/background, movement.
Labels:      ≤4 scruffy uppercase labels, each of which also appears in caption or prose.
Alt:         describes the drawing (not the claim), for screen readers.
Caption:     one line — usually the claim, reworded.
Style:       use the master prompt above verbatim; put Composition into {SUBJECT} and Labels into
             {LABELS}. Only override the style for a genuine reason.
-->
```

Then:

1. While writing, drop one of these comments wherever a drawing would beat a paragraph. Commit —
   the article now carries its own illustration plan.
2. Add a one-line pointer in `manifest.md` (id → article + slug + status `todo`) so the backlog of
   ungenerated sketches is visible in one place. The manifest is the index; the comment is the brief.
3. Generate the image from the master prompt + the comment's Composition/Labels. Save as
   `images/sketches/<idea-slug>.png`.
4. **Replace the comment** with the `<figure class="sketch">` markup (Alt → the `![]()` alt,
   Caption → `<figcaption>`). Run `mkdocs build --strict`. Commit.
5. Flip the manifest pointer to `live`.

Steps 1–2 are cheap and survive a lost session. Step 3 is the only one that needs a human. Because
the brief is inline, a future session rewriting the article sees exactly which drawings were
intended and where — no cross-referencing the manifest to reconstruct intent.

---

## Deferred

Dark mode is knowingly unhandled. Black ink on off-white paper will glare in the `slate` scheme.
When it becomes worth fixing, the cheap route is transparent-background PNGs plus one rule in
`docs/stylesheets/extra.css`:

```css
[data-md-color-scheme="slate"] .sketch img { filter: invert(1) hue-rotate(180deg); }
```

Generating on **transparent** backgrounds from the start costs nothing and keeps that door open,
so the master prompt asks for it. Do not paint a white rectangle into the image.
