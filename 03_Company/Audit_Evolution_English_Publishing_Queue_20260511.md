# Audit Evolution English Publishing Queue

status: draft_ready
prepared_at: 2026-05-11
clawhub: https://clawhub.ai/skills/audit-evolution
github: https://github.com/aDragon0707/audit-evolution-agent-flight-recorder
sacp: https://github.com/aDragon0707/sacp

---

## Positioning

Audit Evolution is not a BotLearn-only benchmark trick.

It is a reusable evolution loop for any agent that needs to improve across runs:

```text
evidence -> state -> diagnosis -> memory -> minimal patch -> field note -> next-run bootstrap
```

The core message:

```text
Most agents do not fail because they cannot reflect.
They fail because their reflection does not become a reproducible next run.
```

Short tagline:

```text
No evidence, no evolution.
```

SACP cross-link:

```text
SACP says: No receipt, no trust.
Audit Evolution says: No evidence, no evolution.
```

---

## 1. ClawHub Community Post

Title:

```text
Audit Evolution: a flight recorder for agents that need to improve across runs
```

Body:

```text
Audit Evolution is now live on ClawHub:
https://clawhub.ai/skills/audit-evolution

GitHub:
https://github.com/aDragon0707/audit-evolution-agent-flight-recorder

This is not a BotLearn-only benchmark helper.

Audit Evolution is a reusable evolution loop for any long-running agent, coding agent, research agent, workflow agent, or skill-building agent that needs to improve across runs.

Most “agent self-improvement” fails at the same point:

The agent finishes a run, writes a vague reflection, maybe tweaks a prompt, and then nobody can tell what evidence justified the change or what the next agent should do differently.

Audit Evolution turns a run into a structured flight record:

Evidence Pack
-> Snapshot
-> Evolution Card
-> Memory Ledger Entry
-> Minimal Skill Patch Proposal
-> Field Note
-> Next-Run Bootstrap
-> Short Command Menu

The point is not to make agents auto-fix themselves.

The point is to make agent evolution auditable, reproducible, and approval-gated.

Evidence Pack asks:
- What evidence exists?
- What is missing?
- Which claims are verified facts?
- Which claims are stale, inferred, or unknown?

Snapshot asks:
- What is the current trusted state?
- What is uncertain?
- What is the next smallest safe action?
- When should the agent stop?

Evolution Card asks:
- Which capability failed or needs improvement?
- perceive, reason, act, memory, guard, or autonomy?
- What minimal patch would improve the next run?

Memory Ledger Entry asks:
- What should be remembered?
- What should expire?
- What retrieval key will help the next run?
- What should not be promoted without human approval?

Minimal Skill Patch Proposal asks:
- What is the smallest useful change?
- Can it be tested locally?
- Does it require human approval before promotion?

Next-Run Bootstrap asks:
- What should the next agent read first?
- What should it do first?
- What should it avoid?
- How should it verify?

This makes the workflow useful far beyond one benchmark platform:

- agent skill development
- prompt and workflow iteration
- long-running coding agents
- research agents with handoffs
- benchmark loops
- eval-driven agent improvement
- memory hygiene
- compliance and quality review
- multi-agent operations
- human-in-the-loop approval gates

BotLearn is just one proof point. The deeper use case is agent evolution itself.

We used this pattern while iterating on agents such as Longju and Jobs, but the structure is intentionally portable: any agent that can read instructions and produce structured output can use the loop.

The safety boundary is important:

Audit Evolution is not an auto-fixer.

It can gather evidence, create a snapshot, propose a memory entry, propose a minimal patch, and prepare a next-run bootstrap.

But publishing, uploading, installing, voting, commenting, spending, official benchmark runs, durable memory promotion, and durable skill promotion still require explicit human approval.

I also pair it with SACP:
https://github.com/aDragon0707/sacp

SACP says:
No receipt, no trust.

Audit Evolution says:
No evidence, no evolution.

Together they create a small operating discipline:

1. If an agent claims work is done, it should leave a receipt.
2. If an agent claims it improved, it should show the evidence and the next-run patch.

30-second test:

Tell your agent:

Start Audit Evolution.
Goal: review my last agent run and decide whether it should enter the next evolution cycle.
Boundary: audit first. Do not directly modify skills, config, memory, or external systems.
Return:
1. Evidence Pack
2. Snapshot
3. Evolution Card
4. Memory Ledger Entry
5. Minimal Skill Patch Proposal
6. Field Note
7. Next-Run Bootstrap
8. Short Command Menu

If the output is just a reflection, it missed the point.

If the output gives you evidence, state, diagnosis, a minimal patch, and the next run’s bootstrap, then the agent has started to build a real evolution trail.
```

First comment:

```text
Quick command:

Start Audit Evolution.
Audit my last agent run.
Separate verified facts, user feedback, stale claims, model inference, and unknowns.
Propose one minimal next-run patch.
Do not modify anything until I approve.

Expected loop:
Evidence Pack -> Snapshot -> Evolution Card -> Memory Ledger -> Patch Proposal -> Field Note -> Bootstrap
```

---

## 2. X Thread

Thread title tweet:

```text
Audit Evolution is now live on ClawHub.

It is not a BotLearn-only benchmark trick.

It is a flight recorder for agents that need to improve across runs.

No evidence, no evolution.

https://clawhub.ai/skills/audit-evolution
```

Tweet 2:

```text
Most “agent self-improvement” fails in the same boring place:

The agent finishes a run.
It writes a vague reflection.
Maybe it tweaks a prompt.

Then nobody can tell:
- what evidence justified the change
- what state is trusted
- what the next agent should do differently
```

Tweet 3:

```text
Audit Evolution forces each run into a reproducible chain:

Evidence Pack
-> Snapshot
-> Evolution Card
-> Memory Ledger Entry
-> Minimal Skill Patch Proposal
-> Field Note
-> Next-Run Bootstrap

That is the flight record.
```

Tweet 4:

```text
This is useful beyond benchmarks:

- coding agents
- research agents
- workflow agents
- skill builders
- prompt iteration
- eval loops
- memory hygiene
- handoff review
- human approval gates

BotLearn is one proof point. Agent evolution is the real use case.
```

Tweet 5:

```text
The important design choice:

Audit first.
Patch second.
Human approval before durable change.

It can propose memory entries and skill patches.

It should not silently promote memory, mutate skills, publish, upload, comment, spend, or run official benchmarks without approval.
```

Tweet 6:

```text
I pair it with SACP:
https://github.com/aDragon0707/sacp

SACP says:
No receipt, no trust.

Audit Evolution says:
No evidence, no evolution.

One checks whether agent work can be trusted.
The other turns a run into the next improvement loop.
```

Tweet 7:

```text
30-second test:

Tell your agent:

“Start Audit Evolution. Audit my last run. Separate verified facts, user feedback, stale claims, model inference, and unknowns. Propose one minimal next-run patch. Do not modify anything until I approve.”
```

Tweet 8:

```text
If the result is just a reflection, it missed the point.

If it gives evidence, state, diagnosis, memory hygiene, a minimal patch, and a next-run bootstrap, then the agent has started building a real evolution trail.

ClawHub:
https://clawhub.ai/skills/audit-evolution

GitHub:
https://github.com/aDragon0707/audit-evolution-agent-flight-recorder
```

Single-post version:

```text
Audit Evolution is live on ClawHub.

Not a BotLearn-only trick. It is a flight recorder for agents that need to improve across runs:

Evidence Pack -> Snapshot -> Evolution Card -> Memory Ledger -> Patch Proposal -> Field Note -> Bootstrap

No evidence, no evolution.

https://clawhub.ai/skills/audit-evolution
```

---

## 3. Reddit Post

Recommended subreddits:

```text
r/AI_Agents
r/LocalLLaMA
r/LangChain
r/ArtificialInteligence
r/MachineLearning
r/OpenAI
```

Title option A:

```text
I built a “flight recorder” pattern for agents that need to improve across runs
```

Title option B:

```text
Agent self-improvement needs evidence trails, not vague reflection
```

Body:

```text
I recently published a ClawHub skill called Audit Evolution:

https://clawhub.ai/skills/audit-evolution

GitHub:
https://github.com/aDragon0707/audit-evolution-agent-flight-recorder

The short version:

This is not a BotLearn-only benchmark trick.

It is a reusable “flight recorder” pattern for any agent that needs to improve across runs.

The failure mode I keep seeing:

An agent finishes a task, writes a vague reflection, maybe changes a prompt, and calls that “self-improvement.”

But there is no durable evidence trail:

- What exactly happened?
- Which claims were verified?
- Which claims were stale or inferred?
- What changed?
- Why should the next run behave differently?
- What should be remembered?
- What should not be promoted without approval?

Audit Evolution forces every run through a structured loop:

```text
Evidence Pack
-> Snapshot
-> Evolution Card
-> Memory Ledger Entry
-> Minimal Skill Patch Proposal
-> Field Note
-> Next-Run Bootstrap
```

The goal is not to let the agent auto-fix itself.

The goal is to make agent evolution:

- evidence-based
- reproducible
- reviewable
- handoff-friendly
- memory-safe
- human-approval-gated

The skill is useful for:

- coding agents
- research agents
- workflow agents
- prompt/skill iteration
- eval loops
- benchmark loops
- memory hygiene
- compliance or quality review
- multi-agent handoffs

Benchmarks are only one proof point. The bigger idea is that a real agent evolution loop should produce a next-run bootstrap, not just a reflection.

I also pair this with SACP:

https://github.com/aDragon0707/sacp

SACP is a small receipt protocol for agent work:

```text
No receipt, no trust.
```

Audit Evolution adds the improvement layer:

```text
No evidence, no evolution.
```

Together:

1. If an agent says it completed work, it should leave a receipt.
2. If an agent says it improved, it should show the evidence and the next-run patch.

The safety boundary matters:

Audit Evolution can propose a memory entry or a skill patch, but it should not silently promote memory, mutate skills, publish, upload, comment, spend, or run official benchmarks without explicit human approval.

30-second test:

Tell your agent:

```text
Start Audit Evolution.
Audit my last agent run.
Separate verified facts, user feedback, stale claims, model inference, and unknowns.
Propose one minimal next-run patch.
Do not modify skills, config, memory, or external systems until I approve.
```

If it gives you only a generic reflection, it missed the point.

If it gives you evidence, state, diagnosis, memory hygiene, a minimal patch, and a next-run bootstrap, then you have the start of a real evolution trail.

I’m especially interested in redacted examples of messy agent runs:

- “done” without evidence
- “tests passed” without logs
- memory promoted without approval
- handoff duplicated
- benchmark improvement without a reproducible patch
- agents claiming they published something without a receipt

Those are the cases I want to turn into more dirty-run examples.
```

Short comment to add after posting:

```text
The thing I’m trying to avoid is “vibes-based self-improvement.”

If an agent improved, I want to see:

1. the evidence
2. the state snapshot
3. the weak capability
4. the minimal patch
5. the next-run bootstrap

Otherwise the next agent is just inheriting a story, not an evolution trail.
```

---

## 4. Reply Templates

When someone says “Isn’t this just a prompt?”:

```text
It is prompt-native by design, but the object it produces is the important part: evidence pack, state snapshot, evolution card, memory ledger entry, patch proposal, field note, and next-run bootstrap.

The goal is not “better wording.” The goal is a reproducible run record that another agent can continue from.
```

When someone says “Why not just use memory?”:

```text
Most memory systems answer “what should be stored?”

Audit Evolution asks a stricter question first:

What evidence justifies storing it, when should it expire, what retrieval key should trigger it, and does it require human approval before promotion?
```

When someone says “Is this only for benchmarks?”:

```text
No. Benchmarks are just a convenient proof point because they create receipts.

The core use case is any agent that needs to improve across runs: coding, research, operations, workflows, skill building, handoffs, and eval loops.
```

When someone says “Does it auto-fix agents?”:

```text
No. That is intentional.

It audits first and proposes one minimal patch. Durable changes, memory promotion, publishing, external actions, and official benchmarks stay approval-gated.
```

