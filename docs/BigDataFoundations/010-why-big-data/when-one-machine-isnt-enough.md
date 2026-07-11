---
title: When One Machine Stops Being Enough
description: Why you cannot always just buy a bigger server: the three walls that vertical scaling hits, why horizontal scaling is the answer, and the bill that answer quietly hands you. The true entry point to the big-data ecosystem.
---

# When One Machine Stops Being Enough

The computer you are reading this on is astonishingly powerful. A modern laptop has more computing power than the machines that ran entire banks thirty years ago. For almost everything you will ever do, **one computer is enough.** That is worth saying plainly, because most of "big data" is a story about the rare moment when it stops being true.

So start with the instinct everyone has, because it is a good one:

> *My program is too slow, or my data is too big to fit. I'll just get a bigger computer.*

That instinct is correct. It stays correct for far longer than beginners expect. This entire article is about the exact moment it stops being correct, and what an experienced engineer reaches for instead.

Two phrases carry the whole field, so let us name them once and never be confused by them again:

- **Scaling up** (*vertical scaling*): make the one machine bigger. More CPU, more memory, faster disk.
- **Scaling out** (*horizontal scaling*): keep the machines ordinary, but use **more of them** at once.

Everything below is a single question: when do you stop scaling up and start scaling out?

<figure class="sketch" markdown>
![One desktop computer absurdly over-upgraded with a bolted-on jet turbine, extra fans and a smoking chimney, sparking and about to explode, while a tidy row of small cheap computers hums along happily beside it, one of them wearing sunglasses.](images/sketches/frankenstein-server.jpg)
<figcaption>You can bolt a jet engine to one computer. It will not end well. The bored little machines next to it were the answer all along.</figcaption>
</figure>

---

## The bigger-box instinct works for a long time

Before we bury vertical scaling, let us give it its due, because it is quietly the right answer most of the time.

A single virtual machine you can rent today, by the hour, can have **over a hundred CPU cores and several terabytes of memory.** The largest cloud instances reach into the tens of terabytes of RAM. That is not a toy. A machine like that will hold a dataset that would have been called "big data" a decade ago *entirely in memory*, and chew through it without a cluster, without a framework, without any of the complexity the rest of this site is about.

!!! tip "Reach for the bigger box first"
    A huge fraction of problems labelled "big data" are nothing of the sort. They fit on one large machine with room to spare. The simplest system that solves your problem is almost always the right one, and one machine is the simplest system there is. **Do not reach for a cluster before you have to.** The rest of this article is about how to know when you have to.

So if one machine goes this far, why does anyone build clusters at all? Because vertical scaling runs into **three separate walls,** and a bigger box does not help you climb any of them.

---

## Wall 1: the price stops being fair, and then the box runs out

Doubling a machine does not double its price. In the commodity range, price and power rise together roughly fairly. Past that range, the curve bends sharply upward: the parts that go into the very largest servers are specialised, low-volume, and priced accordingly. You pay a steep premium for the privilege of keeping everything on one box.

And then the box runs out. That is the part people forget. There is a largest machine that money can buy. When you have rented the biggest instance your cloud offers, there is no "twice as big" to rent at any price. The ceiling is not financial at that point. It is physical.

<!-- ILLUSTRATION: bigger-box-price-ceiling  (SUPERSEDED, regenerating as the funnier "top-of-the-range": a computer shop where the biggest box has burst through the roof into the clouds, price $99,999,999, a moth flying from the customer's wallet, a NO BIGGER! card on the empty shelf; title "TOP OF THE RANGE". Swap in top-of-the-range.jpg when it lands.)
Purpose:     kill the belief that you can always just buy a bigger machine.
Concept:     vertical scaling gets disproportionately expensive and then simply hits a ceiling: there is no bigger box.
Labels:      "TOP OF THE RANGE" (title) · "$99,999,999" · "NO BIGGER!"
Caption:     Scaling up gets more expensive than it has any right to, and then, one day, the shop is simply out of bigger.
Style:       use the master prompt in STYLE.md verbatim; include a hand-lettered title across the top.
-->

Two ordinary machines cost far less than one machine twice as powerful, and unlike that machine, they actually exist. That alone is a strong hint about where this is heading.

---

## Wall 2: one machine is one thing that can break

Here is a failure mode that no amount of money fixes. Your job has been running for nine hours. At hour nine, the machine's power supply dies.

You have **nothing.** Not a partial answer, not a checkpoint you didn't write, nothing. And a bigger machine makes this *worse*, not better: it concentrates more of your work behind a single point of failure. Adding RAM does not buy you reliability. It buys you a larger, more expensive single thing to lose.

<!-- ILLUSTRATION: all-eggs-one-basket  (REWORK to the funny+title bar before generating; pitch the joke first. Idea: one smug giant server tripping over its own power cord and going dark, while the little cluster beside it just shrugs and carries on.)
Purpose:     show that reliability is not a quantity you can add to one machine.
Concept:     one machine holding everything means one failure loses everything.
Labels:      "ONE MACHINE" · "MANY MACHINES"
Caption:     Reliability isn't something you buy more of on one box. It comes from having more than one box.
Style:       use the master prompt in STYLE.md verbatim; include a hand-lettered title.
-->

Reliability, it turns out, is not a component you can order. It is a *property of having more than one of something.* One machine cannot have it, however large.

---

## Wall 3: a fast brain still reads one page at a time

This is the wall that surprises people most, because it has nothing to do with how clever or fast the CPU is.

Suppose you must scan a 10 TB file: just read it once, cover to cover. A *fast* local NVMe drive reads at roughly 2 GB per second, and most storage is slower than that. Do the division: 10 TB at 2 GB/s is still about **an hour and a half of pure reading** on the fast disk, and many hours on the ordinary network or cloud storage where big files actually live. The whole time, the CPU sits idle, waiting for bytes to arrive.

Now here is the trap. Buying a faster CPU does *nothing*, because the CPU was never the bottleneck. And you cannot make a single disk read meaningfully faster than a single disk reads. You have hit a physical rate limit on one machine, and no upgrade you can bolt onto that machine moves it.

There is exactly one way to read faster than one disk: **read from many disks at the same time.**

<!-- ILLUSTRATION: many-hands-one-book  (REWORK to the funny+title bar before generating.)
Purpose:     separate "processing speed" from "how fast you can get the data in", the real bottleneck.
Concept:     one disk reads at one fixed speed; the only way to read faster is to read many at once.
Labels:      "ONE DISK" · "MANY DISKS" · "SAME TIME"
Caption:     One disk reads at one speed. Ten disks read ten chapters at once. That is the only lever that moves.
Style:       use the master prompt in STYLE.md verbatim; include a hand-lettered title.
-->

Notice that the three walls are not really about money at all. They are three *different* ceilings: **price, reliability, and throughput**, and a bigger box slams into all three. No single machine, however expensive, escapes even one of them.

---

## The other kind of bigger: more boxes

If you cannot buy a machine that is strong enough, reliable enough, and fast enough at reading, you change the shape of the answer entirely. Instead of one heroic machine, you use **many ordinary ones, working on the problem together.** This is horizontal scaling, and it is the idea the entire rest of this site is built on.

The cleanest way to feel the difference is to stop thinking about computers for a moment and think about moving a house. Look at what a moving crew buys you against all three walls at once:

- **Price.** Ten ordinary movers cost far less than one mythical strongman ten times as strong, who does not exist anyway. Commodity machines are cheap and plentiful precisely *because* they are ordinary.
- **Reliability.** If one mover calls in sick, the sofa still moves; the others cover. If the strongman pulls a muscle, everything stops. Many machines can lose one and carry on.
- **Throughput.** Ten movers carry ten things at once. A hundred machines each read their own 100 GB slice of that 10 TB file *simultaneously*. Each machine does one-hundredth of the reading, so the hour and a half collapses toward a minute.

That is the whole promise of horizontal scaling, and it is genuinely transformative. A hundred cheap machines beat one impossible one on cost, on survival, and on speed, all three.

---

## Nothing is free: the bill comes due later

If horizontal scaling were pure upside, this site would be one page long. It is not, and here is the honest catch: **the moment you split a job across many machines, you inherit a whole family of problems that a single machine never had.**

A single machine never had to ask any of these. A cluster asks all of them, constantly:

- A 10 TB file will not fit on any one machine. So **how do you store a file across many machines** that each hold only a slice of it, and find it again later?
- Machines fail. With a hundred of them, one failing is not a rare disaster; it is *Tuesday*. So **how does a job survive a machine dying** halfway through, without starting over?
- Counting unique users, or joining two tables, needs to see *all* the data, but each machine only holds a fraction. So **how do machines that each see one piece cooperate** to produce an answer that depends on the whole?
- Some machines finish early; one unlucky machine gets the hard slice and lags. So **how do you keep ninety-nine machines from waiting on the one slow one?**

These are **the three hard problems of distributed data**: storing across machines, surviving failure, and coordinating work. They are the subject of the very next article. For now, hold on to just one idea, because it is the key that unlocks everything that follows:

!!! quote "The idea to carry forward"
    Every tool you are about to meet on this site, from HDFS and YARN through MapReduce and Hive to Spark itself, is at bottom **an answer to a problem that horizontal scaling created.** You chose many machines to beat the three walls. The entire ecosystem is the bill for that choice, paid down one clever idea at a time.

---

## So when should you actually scale out?

Because the bill is real, the discipline is to scale out **only when a wall forces you to.** A useful rule of thumb, in order:

1. **Start on one machine.** It is simpler, cheaper to reason about, and has no distributed bugs, because there is nothing distributed. Most jobs never need to leave here.
2. **Scale it up** if it is slow or tight. Rent the bigger box. This buys you a long runway with almost no added complexity.
3. **Scale out only when you hit a wall the bigger box cannot climb:** the data will not fit or cannot be read fast enough even at full disk speed, or you must survive machine failure, or the largest single machine on offer still is not enough.

!!! warning "The most expensive mistake in this whole field"
    It is reaching for a cluster too early. A distributed system makes you pay a permanent **coordination tax**, the cost of all four questions above, on *every* job, forever. Pay that tax for a job a single machine would have finished, and you have bought yourself slower results, more moving parts, and a harder system to debug, in exchange for nothing. When we reach Spark, you will see this exact mistake has a name and a shape: [the giant crane lowered to lift a single grocery bag](../../Spark-DataBricks/1.0_Spark/1.0_Spark-Concepts.md). Keep it in mind the whole way there.

---

## The mental model to carry forward

If you remember one thing from this page, remember the shape of the decision, not the numbers in it:

> You scale **up** by making one machine bigger, until you hit the wall of price, reliability, or read speed. Then you scale **out** by using many ordinary machines instead, which beats all three walls and in return hands you the problems of *storing, surviving, and coordinating* across those machines.

Everything else on this site is what people built to solve those three problems well. You now know *why* the big-data ecosystem exists. Next, we look at the three problems themselves in detail, the foundation every later tool is standing on.

---

*Next: **[The three hard problems of distributed data](three-hard-problems.md)**, storing across machines, surviving failure, and coordinating the work.*
