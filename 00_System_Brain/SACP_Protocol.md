---
type: protocol
protocol: SACP/0.1
id: sacp_protocol_0_1_draft
status: experimental
owner: AI-01
created_at: 2026-05-06T11:00:00+08:00
updated_at: 2026-05-06T11:00:00+08:00
verification: dirty_run
---

# SACP/0.1 Protocol Draft

**Parent maps:** [[03_Company/MOC_AgentOps_Doctor|AgentOps Doctor Map]] / [[02_Dashboards/DASHBOARD_Link_Map|Obsidian Link Map]]

**Related worklog:** [[03_Company/AI_Worklogs/AI-01_Worklog_20260506_Longju_AgentOps_Doctor_Distillation|Longju AgentOps Doctor Distillation]]

## Status

This is a small experimental draft for SACP/0.1.

It is not a release spec, a full governance document, or a platform design. It exists to test whether Markdown plus YAML frontmatter can help AI employees coordinate work without a CLI, app, server, database, or complex parser.

SACP means:

```text
Solo AI Company Protocol
```

Core loop:

```text
Human decides. AI executes. Worklogs capture experience. Skills make it reusable.
```

## What SACP Is

SACP/0.1 is a file-level operating protocol for a Markdown company vault.

It gives AI employees a small shared contract for reading state, identifying owners, creating worklogs, and passing handoffs without relying on hidden chat memory.

## What SACP Is Not

SACP/0.1 is not:

- an autonomous agent runtime
- a task app
- a database schema
- a background worker
- a release checklist
- a replacement for founder decisions

## Entity Model

A SACP-readable file is a Markdown file with optional YAML frontmatter.

The body remains human-readable explanation. The frontmatter is lightweight machine-readable state.

Recommended entity types:

- `decision`
- `worklog`
- `handoff`
- `skill`
- `receipt`
- `experiment`
- `protocol`

Minimum shared fields:

```yaml
type: worklog
protocol: SACP/0.1
id: unique_file_or_entity_id
owner: AI-XX
status: draft
created_at: 2026-05-06T11:00:00+08:00
updated_at: 2026-05-06T11:00:00+08:00
```

If the entity is owned by an AI employee, `agent_id` may be used in addition to `owner`.

## Source Of Truth

SACP does not change the existing authority order:

1. Latest explicit human instruction
2. Founder decision log
3. Verified project truth
4. Company dashboard
5. Worklogs and handoffs
6. Skills
7. Older drafts or chat history

If SACP fields conflict with a founder decision, the founder decision wins.

## Handoff Semantics

Handoffs are where repeated agent reads can create accidental duplicate work. SACP/0.1 treats handoffs as idempotent requests.

Required handoff fields:

```yaml
type: handoff
protocol: SACP/0.1
handoff_id: handoff_YYYYMMDD_from_to_short
from_agent: AI-02
to_agent: AI-03
status: requested
processed_by: []
source_worklog: worklog_id_here
```

Rules:

- `status: completed` is a fact state, not a trigger event.
- `downstream_handoff: AI-03` names a routing target, not a repeated trigger.
- `handoff_id` is the idempotency key.
- A reader must not create a second handoff for the same request unless a human or owning AI creates a new `handoff_id`.
- `status: requested` means the receiving AI may process the request once.
- `processed_by` is allowed, but source-file mutation is not required.
- A receiving worklog can record `source_handoff_id` instead of rewriting the original handoff.

## Receiving Worklog Pattern

When an AI processes a handoff, it should leave a receiving worklog with the source handoff key:

```yaml
type: worklog
protocol: SACP/0.1
id: worklog_YYYYMMDD_ai03_short
agent_id: AI-03
owner: AI-03
status: completed
source_handoff_id: handoff_YYYYMMDD_ai02_to_ai03_short
processed_handoff_ids:
  - handoff_YYYYMMDD_ai02_to_ai03_short
created_handoff_ids: []
verification: partial
```

This lets a later agent see that the handoff was already handled without relying on chat memory.

## Agent Operating Loop

When SACP/0.1 is active, an AI employee should:

1. Read the normal role and coordination files.
2. Read this protocol and `00_System_Brain/SACP_Agent_Bridge.md`.
3. Scan relevant worklogs, handoffs, and skills.
4. Identify handoffs addressed to its `agent_id`.
5. Check whether the `handoff_id` already appears in a receiving worklog as `source_handoff_id` or `processed_handoff_ids`.
6. Process only unprocessed handoffs it owns.
7. Write a worklog or receipt that cites the source `handoff_id`.
8. Create a new handoff only when a new downstream owner truly needs one.
9. End with owner, action, verification status, and next handoff status.

## Automation Boundary

Allowed in SACP/0.1:

- read Markdown files
- read YAML frontmatter
- identify owner and next action
- draft or write worklogs
- draft or write handoff notes
- update indexes or dashboards when asked
- cite source handoff IDs

Not allowed in SACP/0.1:

- auto-send customer messages
- approve founder decisions
- rewrite source decisions
- silently mark uncertain work as verified
- create duplicate handoffs on repeated reads
- require a background service
- require a database
- require a CLI

## Open Questions

These should stay open until more Dirty Runs are complete:

- Should `processed_by` ever be mandatory?
- Should processed receipts live beside worklogs or in a separate append-only folder?
- Should the `status` lifecycle remain minimal for SACP/0.1 or expand after more Dirty Runs?
- Should skills be promoted only from completed worklogs, or can trial fixtures create draft skills?

## Current Recommendation

Use `source_handoff_id` in receiving worklogs as the first idempotency mechanism.

Keep `processed_by` optional until the project proves that agents can safely mutate source files without creating merge or trust problems.
