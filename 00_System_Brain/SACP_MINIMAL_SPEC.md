---
type: protocol
protocol: SACP/0.1
id: sacp_minimal_spec_20260507
status: draft
owner: AI-01
created_at: 2026-05-07T14:00:00+08:00
verification: pending
---

# SACP Minimal Spec

**Purpose:** Define the smallest handoff state contract that scripts, AgentOps Doctor examples, and AI employee notes should share.

SACP stays Markdown-first. Frontmatter gives agents enough state to avoid duplicate work; the Markdown body keeps the context readable.

## Handoff Frontmatter

Use one status field:

```yaml
type: handoff
protocol: SACP/0.1
handoff_id: handoff_YYYYMMDD_short_task
from_agent: AI-01
to_agent: AI-02
status: requested
attempt_id: attempt_001
lease_owner:
lease_expires_at: 2026-05-07T15:00:00+08:00
source_fingerprint: sha256:abc123
created_at: 2026-05-07T14:30:00+08:00
```

Do not add `handoff_status` for SACP/0.1. Use `status` for the handoff lifecycle.

## Field Meanings

| Field | Meaning |
|---|---|
| `handoff_id` | Stable identity of the task request. Keep it when retrying the same request. |
| `status` | Current lifecycle state of this handoff. |
| `attempt_id` | Execution attempt under the same `handoff_id`. Increment on retry. |
| `lease_owner` | Agent currently claiming or processing the handoff. Empty means unclaimed. |
| `lease_expires_at` | Time after which another agent may retry if work is still incomplete. |
| `source_fingerprint` | Short hash or stable label for the input/context that created this handoff. |

Receiving worklogs should keep the idempotency trail:

```yaml
source_handoff_id: handoff_YYYYMMDD_short_task
processed_handoff_ids:
  - handoff_YYYYMMDD_short_task
```

## Handoff States

| Status | Meaning | Allowed next action |
|---|---|---|
| `requested` | A sender created the handoff, but no receiver owns it yet. | Receiver may claim it. |
| `claimed` | A receiver has accepted ownership but has not started substantial work. | Receiver starts processing or releases/blocks it. |
| `processing` | A receiver is actively working under a lease. | Wait while lease is active; retry if lease expires. |
| `completed` | The requested work is done and recorded. | Skip unless source input changes. |
| `failed` | The attempt failed, but the task may still be valid. | Retry with same `handoff_id`, new `attempt_id`, and refreshed lease. |
| `expired` | The lease expired before completion. | Retry with same `handoff_id` if `source_fingerprint` is unchanged. |
| `blocked` | Work cannot continue without a human or upstream decision. | Do not retry automatically; ask the owner/human. |
| `superseded` | A newer human decision or changed task replaced this handoff. | Do not retry; follow or create the newer handoff. |

## Diagnosis Rules

- `completed` -> skip.
- `processing` plus active lease -> wait.
- `processing` or `expired` plus expired lease and same `source_fingerprint` -> retry with the same `handoff_id` and a new `attempt_id`.
- Same `handoff_id` plus changed `source_fingerprint` -> rework/update, not duplicate.
- New human decision or changed task identity -> new `handoff_id`.
- `blocked` -> ask human or upstream owner before continuing.

## YAML + Worklog Brief Pattern

Every serious handoff, worklog, or Longju run snapshot should combine:

```text
YAML frontmatter = machine-readable state
Markdown brief = human-readable execution summary
```

The YAML should answer "what state am I in?" The brief should answer "what happened and what should the reviewer do next?"

Synthetic example:

```yaml
---
type: longju_run_snapshot
protocol: SACP/0.1
task_id: audit_pricing_001
status: blocked
retry_count: 3
error_type: dynamic_captcha
extracted_entities: [price, sku_id]
handoff_directive: request_alternative_access_method
evolution_decision: record
---
```

```markdown
# Worker Brief

What happened:
Standard access was attempted 3 times and each attempt triggered a dynamic challenge.

Evidence kept:
Extracted entity targets: price, sku_id.

Evidence discarded:
Raw HTML was about 125kb and was discarded so it would not pollute the next context window.

Current blocker:
The current access method cannot complete the task reliably.

Next reviewer action:
Decide whether to use an alternative access method, change scope, or return to the human for approval.
```

## Cross-Window Context Boundary

Context token usage is runtime telemetry, not task truth.

- A sender may use its own local context usage to decide when to compress or hand off.
- A receiver must not use the sender's token usage to judge the receiver's current window.
- If the receiver's current context usage is not provided by the human or platform, write `receiver_context_tokens: unknown`.
- In cross-window handoff, prefer `handoff_reason: context_pressure` over copying old token counts.

Minimal cross-window packet:

```yaml
---
type: handoff_snapshot
protocol: SACP/0.1
handoff_id: handoff_YYYYMMDD_short_task
status: requested
handoff_reason: context_pressure
receiver_context_tokens: unknown
current_goal:
trusted_state:
uncertain_state:
files_to_read:
files_not_to_read:
next_small_action:
stop_condition:
verification_plan:
---
```

```markdown
# Receiver Brief

What happened:

What is trusted:

What is uncertain:

What the receiver should do next:

What the receiver must not assume:
```

## Authority Boundary

This spec does not override human decisions, founder decision logs, or verified project truth. It only defines the minimum handoff state shape for SACP/0.1.
