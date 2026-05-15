---
type: experiment
protocol: SACP/0.1
id: sacp_dirty_run_20260506
status: draft
owner: AI-01
scope: agent-readable company operating protocol
verification: partial
---

# SACP/0.1 Dirty Run Experiment

**Parent maps:** [[03_Company/MOC_AgentOps_Doctor|AgentOps Doctor Map]] / [[03_Company/MOC_Company|Company Map]]

**Related protocol:** [[00_System_Brain/SACP_Protocol|SACP Protocol]]

## Purpose

This Dirty Run tests whether Solo-AI-Company-OS can behave as an agent-readable company operating protocol using only Markdown files with YAML frontmatter.

The goal is not to freeze SACP/0.1 as a full protocol. The goal is to discover friction before writing `00_System_Brain/SACP_Protocol.md`.

Working principle:

```text
Human decides. AI executes. Worklogs capture experience. Skills make it reusable.
```

## Experiment Question

Can Codex or Claude Code read a small group of Markdown entities and correctly infer:

- who owns the next action
- whether a new handoff should be created
- whether an existing handoff would be triggered twice
- how a receiving worklog should cite the original handoff event

## Fixture Set

Fixture directory:

```text
tests/fixtures/sacp_dirty_run/
```

Entities:

- `decision.md`
- `worklog_ai02_completed.md`
- `handoff_ai02_to_ai03.md`
- `skill_customer_draft.md`

These are fake public examples. They are not release notes, production data, or founder decisions.

## Minimum Field Set

### Shared Fields

- `type`
- `protocol`
- `id`
- `status`
- `owner` or `agent_id`
- `created_at`
- `updated_at`

### Decision Fields

- `decision_id`
- `decision_owner`
- `decision_status`
- `applies_to`

### Worklog Fields

- `agent_id`
- `status`
- `handoff_id`
- `downstream_handoff`
- `processed_by`
- `related_skills`
- `verification`

### Handoff Fields

- `handoff_id`
- `from_agent`
- `to_agent`
- `status`
- `trigger_kind`
- `processed_by`
- `source_worklog`

### Skill Fields

- `skill_id`
- `assigned_agents`
- `source_worklog`
- `related_handoff_id`
- `skill_status`

## Idempotency Rule Under Test

`status: completed` is a fact state. It is not an event trigger.

`downstream_handoff: AI-03` is a routing target. It does not mean every read should create another handoff.

`handoff_id` is the idempotency key. If a reader sees the same `handoff_id` again, it must treat it as the same handoff request unless the human explicitly creates a new handoff with a new key.

`status: requested` means the handoff is open for receiving work. It does not require the source file to be rewritten during the Dirty Run.

`processed_by: []` may record readers that already processed the handoff, but SACP/0.1 should not assume that every agent can or should mutate the original file. A receiving worklog can instead cite the original `handoff_id`.

## Test Prompt

Give Codex or Claude Code this instruction:

```text
Read every Markdown file in tests/fixtures/sacp_dirty_run/.

Treat YAML frontmatter as machine-readable state and the body as human-readable explanation.

Answer these questions:
1. What is the next owner?
2. Should you create a new handoff?
3. Would processing these files trigger the same handoff more than once?
4. If AI-03 writes a receiving worklog, how should it reference the source handoff?

Rules:
- status: completed is a fact, not a trigger.
- downstream_handoff names the target owner, but does not create a new event by itself.
- handoff_id is the idempotency key.
- If status is requested and processed_by does not include AI-03, AI-03 may process the request once.
- Do not require mutation of the source handoff file. A receiving worklog may record source_handoff_id instead.
```

Expected answer:

- The next owner is `AI-03`.
- A new handoff should not be created because `handoff_20260506_ai02_to_ai03_fixture` already exists.
- Re-reading the same files should not repeatedly trigger the handoff.
- The receiving worklog should include `source_handoff_id: handoff_20260506_ai02_to_ai03_fixture`.

## Test Method

1. Ask an agent to read the fixture directory.
2. Ask it to infer the next owner and action.
3. Ask it whether it would create a new handoff.
4. Ask it to draft, but not necessarily write, the receiving worklog frontmatter.
5. Compare the answer against the expected answer above.

## Success Standards

The Dirty Run succeeds if the agent:

- identifies `AI-03` as the next owner
- avoids creating a duplicate handoff
- treats `handoff_id` as the idempotency key
- distinguishes state from events
- carries the original `handoff_id` into the receiving worklog
- does not require a parser, database, server, or CLI

The Dirty Run exposes friction if the agent:

- treats `status: completed` as an event trigger
- creates a new handoff only because `downstream_handoff` exists
- ignores `handoff_id`
- assumes it must rewrite the source worklog or handoff file
- cannot infer the next owner from Markdown plus YAML frontmatter

## Temporary Boundary

This file is an experiment note, not the SACP specification.

Do not treat these fields as permanent until the Dirty Run result is reviewed.
