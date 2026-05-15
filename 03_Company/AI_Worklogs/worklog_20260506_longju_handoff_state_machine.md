---
type: worklog
protocol: SACP/0.1
id: worklog_20260506_longju_handoff_state_machine
agent_id: Longju
owner: Longju
status: completed
source_handoff_id: none
processed_handoff_ids: []
created_handoff_ids: []
tools_used:
  - sacp-adversarial-handoff-review
  - longju-self-evolution-router
verification: partial
evolution_decision: record
human_approved: false
created_at: 2026-05-06T20:44:00+08:00
related:
  - "[[03_Company/MOC_AgentOps_Doctor|AgentOps Doctor Map]]"
  - "[[00_System_Brain/SACP_Protocol|SACP Protocol]]"
  - "[[03_Company/AI_Worklogs/WORKLOG_INDEX|Worklog Index]]"
---

# Longju Handoff State Machine Refinement - 2026-05-06

**Parent maps:** [[03_Company/MOC_AgentOps_Doctor|AgentOps Doctor Map]] / [[03_Company/AI_Worklogs/WORKLOG_INDEX|Worklog Index]]

## Background

The first version of the handoff review logic was too aggressive and too absolute.

Two mistakes were identified through adversarial review:

1. `source_handoff_id` existing in a receiving worklog was treated as completed work.
2. Contradictory source worklog fields were treated as an automatic `block` verdict.

Both were corrected.

## Corrected Authority Rule

The receiving worklog is the authority for receiving-side state.

`source_handoff_id` only proves that a receiving worklog references the source handoff. It does not prove completion by itself.

The receiving worklog status must be checked:

- `completed` -> dedup skip
- `processing` with active lease -> wait
- `processing` with expired lease -> retry with a new `attempt_id`
- `failed` or `expired` -> retry or escalate according to retry policy
- `blocked` -> wait for human decision

## Corrected Retry Rule

Do not use an absolute rule such as "retry never creates a new handoff."

Use this conditional rule instead:

- same `handoff_id` + same `source_fingerprint` + expired lease -> retry with new `attempt_id`
- same `handoff_id` + new `source_fingerprint` -> rework or update, not duplicate
- new human decision or changed task identity -> create a new `handoff_id`

## Decision Chain

```text
Step 1: Is there a receiving worklog with the same source_handoff_id?
  no  -> first receiving action may proceed
  yes -> inspect receiving worklog status

Step 2: What is the receiving worklog status?
  completed  -> skip
  processing -> inspect lease
  failed     -> retry or escalate
  expired    -> retry or escalate
  blocked    -> human decision

Step 3: If processing, is the lease still active?
  yes -> wait
  no  -> stale lease; retry with new attempt_id

Step 4: Did the task identity change?
  same source_fingerprint -> same handoff_id, new attempt_id
  new source_fingerprint  -> rework/update path
  new human decision      -> new handoff_id
```

## Why This Matters

This prevents three common multi-agent failures:

- duplicate execution of the same handoff
- permanent blocking on stale leases
- treating a changed input as a duplicate just because the handoff edge name stayed the same

## Verification Status

- Logic was checked against the refined SACP handoff state machine.
- The rule is now suitable for AgentOps Doctor's Handoff Diagnosis module.
- No publish action was taken.
- Human promotion has not been approved.

## Next Recommendation

Keep this as a recorded worklog and use it as evidence for AgentOps Doctor's Handoff Diagnosis module.

Do not promote it into an active skill until the founder approves the public release scope.
