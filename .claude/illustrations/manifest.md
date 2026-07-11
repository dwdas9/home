# Illustration manifest — the backlog index

One line per planned and completed sketch. Read [`STYLE.md`](STYLE.md) first — the master prompt
lives there and must be used verbatim.

As of 2026-07-11 the **full brief lives inline in the article as an HTML comment** at the anchor
point (see `STYLE.md` › Workflow and `DECISIONS.md`). This file is now the **index** — it exists so
the backlog of ungenerated sketches is visible in one place, not so the briefs can be reconstructed
from it. The older entries below still carry their full briefs inline here; that is fine, but new
sketches only need a pointer line here and the full brief in the article.

**Status:** `todo` = brief written, image not generated · `drawn` = PNG exists, markup not inserted
· `live` = rendered in the article and passing `mkdocs build --strict`.

Generate the ★ tier first. If only four sketches are ever made, make those.

---

## `1.0_Spark-Concepts.md` — What Is Apache Spark?

Save to `docs/Spark-DataBricks/1.0_Spark/images/sketches/`.

---

### ★ S-04 · `lineage-cake.png` — status: `todo`

**Anchor:** section *"The idea that makes memory safe: lineage"*, immediately after
"…**the recipe that produced it**."

**Claim:** Don't keep a spare copy of the data. Keep the recipe, and rebuild only the piece you lost.

**Subject:** A round cake on a stand with exactly one wedge missing, a small puff of smoke where
the wedge used to be. To the right, a recipe card pinned to the wall, with a dotted arrow curving
from the card into the empty wedge — rebuilding just that one slice. In the background, faint and
crossed out with a big X, three identical whole cakes stacked on a shelf.

**Labels:** `RECIPE` · `JUST THIS SLICE` · `3 COPIES` (on the crossed-out cakes)

**Alt:** A cake missing one slice, with a recipe card and an arrow showing that single slice being re-baked; three identical backup cakes are crossed out behind it.

**Caption:** Don't keep a spare cake. Keep the recipe, and re-bake only the slice you lost.

> This is the most important sketch in the section. Lineage is the idea that earns Spark the
> right to hold data in memory, and it is the one the old article never mentioned.

---

### ★ S-08 · `crane-grocery-bag.png` — status: `todo`

**Anchor:** section *"When you should not use Spark"*, under the "Your data fits on one machine" tab
— or immediately above the section heading, as the section's thesis image.

**Claim:** Below a few hundred gigabytes, the cluster costs more than the job.

**Subject:** An enormous dockyard container crane, drawn tall and heavy, lowering its vast hook
toward a single small paper grocery bag on the ground. A person stands beside the bag holding it
up helpfully, looking slightly embarrassed. The crane dwarfs everything.

**Labels:** `SPARK` (on the crane's boom) · `50 GB` (on the bag)

**Alt:** A giant container crane lowering its hook to lift one small paper grocery bag.

**Caption:** The most common Spark performance problem is that Spark should not have been there.

---

### ★ S-01 · `hundred-clerks.png` — status: `todo`

**Anchor:** opening, after "One machine gets the shard containing your biggest customer and takes
twenty times longer than the rest."

**Claim:** Splitting the work across machines is the easy part. Everything that goes wrong
afterwards is the hard part.

**Subject:** A long row of small desks with clerks at them, drawn receding across the page. Most
clerks have one thin ledger and are working calmly. One desk in the middle is buckling and
splintering under an enormous tottering stack of ledgers, its clerk barely visible. Two clerks are
passing thick bundles of paper to each other across the aisle, papers flying. Three clerks at the
end have their feet up, asleep, nothing on their desks.

**Labels:** `SKEW` (near the buckling desk) · `SHUFFLE` (near the paper-passing) · `IDLE` (near the sleepers)

**Alt:** A row of clerks: most work steadily, one is buried under a collapsing stack of ledgers, two are passing papers across the aisle, and three sit idle with nothing to do.

**Caption:** A hundred machines is the easy part. Skew, shuffle and idleness are what you actually pay for.

---

### ★ S-03 · `relay-vs-filing-cabinet.png` — status: `todo`

**Anchor:** section *"What MapReduce got wrong"*, replacing or accompanying the two Mermaid flowcharts.

**Claim:** MapReduce wrote to disk — in triplicate — between every step. Spark hands over the baton.

**Subject:** Two horizontal running lanes, one above the other. **Top lane:** a relay runner has
stopped mid-race and is queuing at a filing cabinet, laboriously writing on three carbon-copy
sheets; the next runner waits at the line, tapping a foot; a clock shows time passing. **Bottom
lane:** two runners simply slap a baton from hand to hand at full speed, no cabinet in sight.

**Labels:** `MAPREDUCE` (top lane) · `SPARK` (bottom lane) · `×3` (on the carbon copies)

**Alt:** Two relay lanes. In the top one a runner stops to file three carbon copies at a cabinet while the next runner waits; in the bottom one runners pass a baton at full speed.

**Caption:** Every MapReduce stage stopped to write three replicated copies to disk. Spark just passes the baton.

---

### S-05 · `hundred-x-asterisk.png` — status: `todo`

**Anchor:** the `!!! warning "About that 100× number"` admonition.

**Claim:** The number is real. The benchmark it came from is missing.

**Subject:** A huge circus-poster-style notice nailed to a wooden fence, with bold hand-lettering
shouting the headline and a tiny asterisk beside it. Far below, in scrawl so small it is nearly a
squiggle, the footnote. A person stands on tiptoe peering at the footnote through an oversized
magnifying glass.

**Labels:** `100× FASTER!*` (the headline) · `*if you read the same data 30 times` (the footnote)

**Alt:** A circus poster shouting "100x faster!" with a tiny asterisked footnote that a person is squinting at through a magnifying glass.

**Caption:** True on an iterative in-memory benchmark. On a single-pass ETL scan, rather less exciting.

---

### S-06 · `lazy-waiter.png` — status: `todo`

**Anchor:** section *"Lazy on purpose"*, after the three-line code block and "Not one row has been read."

**Claim:** Transformations only write things down. Nothing moves until an action asks for the answer.

**Subject:** Two panels side by side. **Left:** a waiter stands perfectly still with a notepad,
pencil poised, while a customer gestures through an enormously long order; cobwebs hang from the
waiter's elbow and a snail rests on his shoe. **Right:** the customer says the final word and the
waiter has become a blur of motion lines, notepad flying, one shoe left behind.

**Labels:** `TRANSFORMATIONS` (left) · `ACTION!` (right)

**Alt:** A waiter stands motionless taking a long order, cobwebs forming; then bolts into a blur the moment the customer finishes.

**Caption:** `filter`, `select`, `groupBy` — the waiter is only writing. `show()` is when he runs.

---

### S-02 · `engine-on-a-bench.png` — status: `todo`

**Anchor:** section *"Spark is an engine, not a system"*, after "Both of those are somebody else's
job" and before or instead of the layers Mermaid diagram.

**Claim:** Spark computes. Storage and cluster management are somebody else's parts, and you bring them.

**Subject:** A bare car engine sitting on a workshop bench — no car anywhere. A fuel hose runs off
the edge of the page to a battered jerry can. The bench itself has castors, drawn as detachable. A
mechanic stands beside it, shrugging, holding a wheel that clearly belongs to nothing.

**Labels:** `SPARK` (on the engine block) · `STORAGE` (on the jerry can) · `CLUSTER MANAGER` (on the trolley)

**Alt:** A car engine alone on a workshop bench, fuel hose running to a separate jerry can, mounted on a detachable wheeled trolley, with a shrugging mechanic.

**Caption:** A superb engine, and no fuel tank, no wheels, and no chassis. You supply those.

---

### S-07 · `desk-and-floor.png` — status: `todo`

**Anchor:** section *"'In-memory' does not mean 'must fit in memory'"*, after "Your two-terabyte
job runs fine on a cluster with two hundred gigabytes of RAM."

**Claim:** Spark prefers memory and spills to disk. The data does not have to fit.

**Subject:** An engineer working at a small desk. On the desk, a neat modest stack of papers. Piled
around the desk legs and spreading across the floor, a much larger sprawl of papers. The engineer
is calmly reaching down to the floor for the next sheet, unbothered, still working.

**Labels:** `MEMORY` (a small sign on the desk) · `DISK` (chalked on the floorboards)

**Alt:** An engineer working at a small tidy desk, calmly reaching down to a much larger pile of papers spread across the floor around it.

**Caption:** Memory is where Spark would like to work. The floor is always available.

---

### S-09 · `library-card-catalogue.png` — status: `todo`

**Anchor:** section *"Where Hadoop and Hive fit today"*, after "the Hive metastore, turned out to be
the genuinely useful part."

**Claim:** Hive's engine died. Its catalogue outlived it — which is why `hive_metastore` keeps
appearing in platforms nobody installed Hive on.

**Subject:** The ruins of a grand library: broken columns, a collapsed roof, rubble, weeds. Standing
completely intact in the centre of the wreckage, spotless and upright, a wooden card-catalogue
cabinet. A librarian, entirely unfazed, has one drawer open and is thumbing through the cards. A
cracked stone sign lies in the rubble.

**Labels:** `HIVE` (on the cracked sign) · `METASTORE` (on the cabinet)

**Alt:** A ruined library with a single card-catalogue cabinet standing intact in the rubble, a librarian calmly using it.

**Caption:** Nobody wants Hive's query engine any more. Everybody still uses its card catalogue.

---

## `1.1_PySparkGotchas/` — the gotchas

Save to `docs/Spark-DataBricks/1.1_PySparkGotchas/images/sketches/`.

---

### ★ G-02 · `skew-99-done.png` — status: `todo`

**Article:** `Data Skew-TheSilentPerformanceKiller.md` · **Anchor:** under "Why Skew Kills Performance".

**Claim:** A job is exactly as slow as its slowest task. Adding machines does not help the one that is buried.

**Subject:** A large open-plan office. Ninety-nine desks are empty, chairs neatly tipped up on
them, workers standing around with coffee, coats on, chatting, clearly done. One desk in the
middle is invisible beneath a mountain of paper; a single pair of hands protrudes from it. An
enormous wall clock looms over the scene.

**Labels:** `DONE` (on a chalkboard by the idle group) · `1 TASK` (an arrow to the buried desk)

**Alt:** An office where ninety-nine workers stand around finished, coats on, while one worker is buried under a mountain of paper.

**Caption:** Ninety-nine tasks finished in thirty seconds. The job is not finished.

---

### ★ G-01 · `broadcast-photocopier.png` — status: `todo`

**Article:** `BroadcastingMemoryBombs.md` · **Anchor:** under "What Broadcasting Actually Costs",
after the "Stage 2 — every executor stores a copy" tab.

**Claim:** A broadcast is one copy per executor, not one copy for the cluster.

**Subject:** A photocopier in the middle of a room, mid-groan, spitting out an identical
phone-book-sized ledger onto a conveyor. Along the conveyor, a row of small desks; each desk
receives its own gigantic ledger and each desk is visibly splintering and collapsing under it. One
cheerful person feeds the original into the copier, oblivious.

**Labels:** `5 GB` (on the original ledger) · `× 50` (over the conveyor)

**Alt:** A photocopier producing an identical phone-book-sized ledger for every desk in a row, each desk collapsing under the weight.

**Caption:** Table size × number of executors. The driver has to hold one too, before any of this starts.

---

### G-04 · `four-trips-one-number.png` — status: `todo`

**Article:** `MultiplePassAggregation.md` · **Anchor:** after the "❌ Problematic Code" block.

**Claim:** Every action re-reads the source. Four statistics, four full scans.

**Subject:** A wide landscape. A tiny figure walks a long, long road from a distant warehouse back
to a desk, carrying a single slip of paper with one number on it. The road is drawn four times, in
four parallel loops, each ending at the same desk with one more slip. The warehouse is drawn once,
far away.

**Labels:** `SUM` `AVG` `MAX` `COUNT` (one on each slip)

**Alt:** A figure walking the same long road from a distant warehouse four times, each trip returning with a single slip of paper bearing one number.

**Caption:** Four `.collect()` calls. Four walks to the warehouse.

---

### G-03 · `tally-counter-vs-scroll.png` — status: `todo`

**Article:** `HighCardinalityGroupBy.md` · **Anchor:** under "Where The Memory Actually Goes",
after the "Unbounded aggregate state" tab.

**Claim:** It is not the number of groups. It is what you accumulate inside each one.

**Subject:** Two people side by side. **Left:** relaxed, holding a small brass tally counter that
fits in the palm, clicking it, unbothered. **Right:** buried to the neck in an endlessly unspooling
paper scroll that pours from a spindle and coils across the whole floor, one hand reaching out for
help.

**Labels:** `count( )` `sum( )` (left) · `collect_list( )` (right)

**Alt:** One person calmly clicking a small tally counter; beside them another is buried in an endlessly unspooling paper scroll.

**Caption:** A counter is a few bytes, whatever you count. A list is as big as what you put in it.

---

## Big Data Foundations — Module 0.1 `when-one-machine-isnt-enough.md`

Save to `docs/BigDataFoundations/010-why-big-data/images/sketches/`. Full briefs live inline in the
article as HTML comments at each anchor; these are the index pointers.

- **★ F-01 · `strongman-vs-moving-crew.png`** — status: `todo`. The article's signature. *Past a
  point you stop hiring a stronger worker and start hiring more workers.* Anchor: "The other kind of
  bigger: more boxes".
- **F-02 · `bigger-box-price-ceiling.png`** — status: `todo`. *Twice the machine costs far more than
  twice the price — and eventually there is no twice-as-big to buy.* Anchor: Wall 1.
- **F-03 · `all-eggs-one-basket.png`** — status: `todo`. *Reliability comes from having more than one
  box, not from a bigger one.* Anchor: Wall 2.
- **F-04 · `many-hands-one-book.png`** — status: `todo`. *One disk reads at one speed; the only lever
  is reading many at once.* Anchor: Wall 3.

Generate **F-01 first** — if only one sketch from this article is ever made, make that one.

---

## Later articles

Add briefs here as each article is rewritten. Do not batch-generate ahead of the prose — the
sketch has to answer a question the article has actually raised.
