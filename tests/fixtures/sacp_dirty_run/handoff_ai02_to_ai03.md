---
type: handoff
protocol: SACP/0.1
id: handoff_doc_20260506_ai02_to_ai03_fixture
handoff_id: handoff_20260506_ai02_to_ai03_fixture
from_agent: AI-02
to_agent: AI-03
owner: AI-03
status: open
handoff_status: requested
trigger_kind: explicit_handoff_request
created_at: 2026-05-06T10:22:00+08:00
updated_at: 2026-05-06T10:22:00+08:00
processed_by: []
source_worklog: worklog_20260506_ai02_fixture
---

# Handoff: AI-02 To AI-03

## Reason

AI-03 should draft founder-review customer-facing language for the SACP/0.1 Dirty Run concept.

## Input Files

- `tests/fixtures/sacp_dirty_run/decision.md`
- `tests/fixtures/sacp_dirty_run/worklog_ai02_completed.md`

## Required Output

AI-03 should create or propose a receiving worklog that references:

```yaml
source_handoff_id: handoff_20260506_ai02_to_ai03_fixture
```

## Cannot Do

AI-03 must not create a second handoff for the same request unless the human explicitly asks for a new handoff with a new `handoff_id`.

AI-03 must not treat repeated reads as repeated triggers.

