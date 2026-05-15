---
type: agent_bridge
protocol: SACP/0.1
id: sacp_agent_bridge_0_1_draft
status: experimental
owner: AI-01
created_at: 2026-05-06T11:05:00+08:00
updated_at: 2026-05-06T11:05:00+08:00
verification: dirty_run
---

# SACP Agent Bridge

**Parent maps:** [[03_Company/MOC_AgentOps_Doctor|AgentOps Doctor Map]] / [[02_Dashboards/DASHBOARD_Link_Map|Obsidian Link Map]]

**Related protocol:** [[00_System_Brain/SACP_Protocol|SACP Protocol]]

## Purpose

This bridge tells AI employees how to use SACP/0.1 in ordinary Markdown work.

It is an operating prompt, not software. The agent performs the steps by reading and writing files in the vault.

## When To Use

Use this bridge when the task involves:

- worklogs
- handoffs
- next owner detection
- repeated agent reads
- converting a worklog into a skill
- deciding whether a handoff already happened

## Current Agent Setup

Before acting, identify:

```yaml
current_agent_id: AI-XX
current_task: short_task_name
```

Then read:

- `00_System_Brain/SACP_Protocol.md`
- `03_Company/AI_Employees/COORDINATION_PROTOCOL.md`
- your own `ROLE.md`
- `03_Company/AI_Worklogs/WORKLOG_INDEX.md`
- any explicit files named by the human

## SACP Scan

Scan the relevant Markdown files for frontmatter fields:

- `protocol: SACP/0.1`
- `type`
- `id`
- `agent_id`
- `owner`
- `status`
- `handoff_id`
- `source_handoff_id`
- `processed_handoff_ids`
- `from_agent`
- `to_agent`
- `downstream_handoff`

Do not depend on perfect coverage. Older files may not have SACP fields.

## Owner Rule

The next owner is the most specific valid owner in this order:

1. Latest human instruction
2. `to_agent` on an open handoff
3. `downstream_handoff` on a completed worklog
4. `owner` or `agent_id` on the current entity
5. AI-01 if routing is unclear
6. Human if a decision is needed

## Idempotency Rule

Treat a handoff as already represented if the same `handoff_id` appears in:

- the source handoff file
- a receiving worklog as `source_handoff_id`
- a receiving worklog under `processed_handoff_ids`

Do not create a new handoff just because the same completed worklog is read again.

## Processing Rule

If all are true:

- `to_agent` or `downstream_handoff` matches `current_agent_id`
- `status: requested`
- no receiving worklog already cites the same `handoff_id`

then the current AI may process the handoff once.

If any condition is unclear, ask AI-01 or the human instead of inventing state.

## Write Rule

The preferred SACP/0.1 write is a receiving worklog.

Minimum receiving worklog frontmatter:

```yaml
type: worklog
protocol: SACP/0.1
id: worklog_YYYYMMDD_aiXX_short
agent_id: AI-XX
owner: AI-XX
status: completed
source_handoff_id: handoff_YYYYMMDD_source_key
processed_handoff_ids:
  - handoff_YYYYMMDD_source_key
created_handoff_ids: []
related_skills: []
verification: partial
```

Do not require source-file mutation. If source mutation is needed, ask for explicit permission or use the repo's established append-only pattern.

## New Handoff Rule

Create a new handoff only when a new downstream owner has distinct work to do.

Every new handoff needs a new `handoff_id`.

If the next step is founder review, do not create an AI handoff. Mark the next owner as `Human`.

## Output Contract

End SACP work with:

```text
Current Agent:
Source Handoff ID:
Next Owner:
Created New Handoff: yes/no
Duplicate Trigger Avoided: yes/no
Receiving Worklog:
Verification:
Open Questions:
```

## Dirty Run Expected Result

For `tests/fixtures/sacp_dirty_run/`, the expected result is:

- current actionable owner: `AI-03`
- new handoff required: no
- duplicate trigger: no
- receiving worklog should cite `source_handoff_id: handoff_20260506_ai02_to_ai03_fixture`
