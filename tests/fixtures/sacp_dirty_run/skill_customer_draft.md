---
type: skill
protocol: SACP/0.1
id: skill_customer_draft_fixture
skill_id: skill_customer_draft_fixture
owner: AI-03
status: draft
skill_status: draft
created_at: 2026-05-06T10:30:00+08:00
updated_at: 2026-05-06T10:30:00+08:00
assigned_agents:
  - AI-03
source_worklog: worklog_20260506_ai02_fixture
related_handoff_id: handoff_20260506_ai02_to_ai03_fixture
---

# Skill Draft: Customer-Facing Draft From Verified Context

## When To Use

Use this draft skill when AI-03 needs to turn verified internal context into customer-facing language for founder review.

## Steps

1. Read the founder decision and source worklog.
2. Check whether a handoff already exists.
3. If a handoff exists, cite its `handoff_id` instead of creating a duplicate.
4. Draft concise language for founder review.
5. Mark any claim that needs review before public use.

## Do Not Assume

Do not assume the draft is approved for public release.

Do not assume a completed source worklog means the same handoff should fire again.

