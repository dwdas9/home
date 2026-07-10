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

The claim goes in the manifest. The caption is usually the claim, lightly reworded.

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

Long articles carry many sketches — roughly one per major section is a healthy density. Never two
in a row without prose between them.

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
    `mkdocs build --strict` aborts on an image path that does not resolve. **Never commit the
    `<figure>` markup before the PNG exists.** The manifest exists so briefs can be written and
    committed without touching the article.

---

## Workflow

1. While rewriting an article, note every place a drawing would beat a paragraph.
2. Add a brief to `manifest.md` — id, anchor, claim, subject, labels, alt, caption. Commit that.
3. Generate the image from the master prompt. Save as `images/sketches/<idea-slug>.png`.
4. Insert the `<figure>` markup. Run `mkdocs build --strict`. Commit.
5. Tick the brief in the manifest.

Steps 1–2 are cheap and survive a lost session. Step 3 is the only one that needs a human.

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
