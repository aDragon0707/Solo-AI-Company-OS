# Five Lobsters Operating Model

> Advanced collaboration note. Do not make this the Day-1 default.

The default operating loop is:

```text
AI-01 coordinator -> AI-02 builder/evidence -> AI-04 adversarial review -> Human approval
```

Use all five AI employees only when the task is complex enough to justify the coordination cost.

---

## Role Map

| AI | Role | Use In Multi-Agent Work |
|---|---|---|
| AI-01 | Coordinator / state owner | Defines task boundary, owner, priority, blocker, and final handoff state. |
| AI-02 | Builder / evidence owner | Produces implementation, artifacts, measurements, and verification notes. |
| AI-03 | Growth / expression | Turns verified results into public-facing language, demo scripts, or user feedback prompts. |
| AI-04 | Adversarial review / risk | Checks claim boundary, privacy, unsupported inference, release risk, and rework needs. |
| AI-05 | Tutor / memory | Explains the system, creates learning material, and helps distill reusable patterns after work is verified. |

## Recommended Model Assignment

Use different model families when possible for adversarial review, because one family can share blind spots.

| Function | Recommended Assignment |
|---|---|
| Coordination | Stable generalist model with strong instruction following. |
| Build / evidence | Coding-capable model with tool execution. |
| Public expression | Strong writing model with claim-boundary discipline. |
| Risk review | Different model family from the builder when available. |
| Tutor / memory | Patient explainer model that can simplify without weakening rules. |

## Handoff Chain

Use SACP handoff fields from `00_System_Brain/SACP_MINIMAL_SPEC.md`.

```text
AI-01 creates requested handoff
AI-02 claims/processes and writes worklog
AI-04 reviews claims, evidence, privacy, and release boundary
Human approves, blocks, or changes direction
AI-03 and AI-05 join only if expression or teaching/memory is needed
```

## When To Use 1-3-1

Use a compact 1-3-1 loop when work needs both speed and review:

```text
1 coordinator -> 3 workers/reviewers -> 1 human final decision
```

Good cases:

- release candidate review
- public demo package
- protocol or skill promotion
- private-to-public rewrite
- complex bug with evidence and communication risk

## When Not To Use Five Agents

Do not use five agents for:

- first-day onboarding
- one small documentation edit
- a simple command result
- work that has no evidence, privacy, or public-expression risk
- tasks where the human has not chosen a direction yet

If the coordination overhead feels larger than the task, return to:

```text
AI-01 + AI-02 + AI-04 + Human
```

## Completion Rule

Every serious multi-agent run ends with:

- one worklog that records tools, evidence, verification, and residual risk;
- any needed handoff with `status`, `handoff_id`, `attempt_id`, lease fields, and `source_fingerprint`;
- human approval before any skill is promoted.
