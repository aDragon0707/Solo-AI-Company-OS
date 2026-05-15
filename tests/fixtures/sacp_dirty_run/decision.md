---
type: decision
protocol: SACP/0.1
id: decision_20260506_dirty_run_fixture
decision_id: DEC-20260506-SACP-DIRTY-RUN
decision_owner: Human
decision_status: accepted
owner: Human
status: active
created_at: 2026-05-06T10:00:00+08:00
updated_at: 2026-05-06T10:00:00+08:00
applies_to:
  - SACP/0.1 Dirty Run
  - Markdown YAML frontmatter fixtures
---

# Decision: Run SACP/0.1 As A Dirty Run First

The human decision is to test SACP/0.1 as a lightweight company operating protocol before writing a formal protocol document.

The experiment should stay boring on purpose:

- Markdown files
- YAML frontmatter
- fake public fixture content
- no CLI
- no server
- no database
- no release claim

The first risk to test is handoff idempotency across repeated agent reads.

