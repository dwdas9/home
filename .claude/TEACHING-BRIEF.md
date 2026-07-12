# The Teaching Brief

**This governs what an article does. [`WRITING-STYLE.md`](WRITING-STYLE.md) governs how it sounds.**
Where the two appear to conflict, the writing style wins. The owner supplied both.

We are not writing documentation, a textbook, or a reference manual. We are building a learning
experience. The reader is a busy engineer with limited attention, and if she understands the concept
after a few minutes on the page, the page has succeeded. Nothing else about it matters.

---

## The one hard rule

**Every new technical concept begins with a real-world scenario. The technical name comes last.**

The reader should understand the idea before she learns what it is called. If no suitable analogy
exists, invent one. The order is fixed and it is never inverted:

```
Real-world situation
        ↓
The problem it creates
        ↓
The pain point
        ↓
How a person would solve it
        ↓
The technology does the same thing
        ↓
The technical term, finally named
```

The reader should arrive at the terminology thinking *"Spark is doing what I would have done."* Not
*"I have now been told what a shuffle is."*

Test every explanation against one question before writing it: **if I had two minutes to explain this
to a twelve-year-old, what situation would make her say "oh, I get it"?** Write that first.

---

## The world

The site keeps **one recurring analogy world: a goods warehouse with a delivery fleet.** The reader
should not have to build a fresh mental model on every page, so concepts connect to a world she
already knows by the time she meets them.

| In the world | In the systems |
|---|---|
| Crates on shelves | Data at rest, HDFS |
| Three copies in three sheds | Replication |
| The shift manager assigning work | YARN, the resource manager |
| Pickers and packers | Executors and tasks |
| Pallets and trucks | Partitions |
| Re-sorting parcels by postcode | Shuffle |
| The front counter, stocked in advance | Cache |
| A picker calling in sick | Fault tolerance |
| The order in which things must be loaded | The DAG |

**Use the world where it fits honestly, and reach past it where a sharper analogy exists.** A forced
analogy teaches worse than no analogy. The warehouse is the default and the connective tissue, not a
cage: if supermarket queues explain a shuffle better on a given page, use supermarket queues, then
tie the point back to the warehouse in a line.

---

## How a page is built

1. **One idea per section.** Each heading answers exactly one question: *what is Hadoop, why was it
   invented, why was it not enough, why Spark.* Never two concepts at once.
2. **The problem before the solution.** The reader feels the pain first. A technology introduced
   before its problem is a feature list, and feature lists do not teach.
3. **Progressive disclosure.** Build up. Complexity arrives only after the foundation under it holds.
4. **Curiosity before answers.** Ask the question, let the reader think for a beat, then answer it.
5. **Reward progress.** Short summaries and a takeaway the reader can carry to the next page. Learning
   should feel like it is going somewhere.
6. **Scannable.** Headings, whitespace, callouts, comparison tables. No walls of text.
7. **One memorable moment per page,** at minimum: a surprising number, an unexpected comparison, a
   sketch that lands. If nothing on the page is memorable, nothing on the page will be remembered.
8. **Teach concepts, not features.** Why it exists, what it solves, why the previous answer failed,
   when to use it. Understanding beats memorisation.

---

## Illustrations are teaching, not decoration

If one drawing replaces three paragraphs, draw it and delete the paragraphs. For every major concept,
ask what the simplest sketch would be that makes the idea obvious on sight. The illustration teaches;
the prose beside it reinforces.

The sketch bar itself is separate and it is strict: a real, recognisable engineering gag plus a
hand-lettered title. See [`illustrations/STYLE.md`](illustrations/STYLE.md).

---

## Constraints

Never add words unless they add understanding. Cut anything that does not earn its place. Avoid
repetition, avoid filler, respect the reader's time. Density is a virtue and padding is not, which is
the same thing the writing style says, arrived at from the other direction.
