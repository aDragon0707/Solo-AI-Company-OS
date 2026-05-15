# AgentOps Doctor

AgentOps Doctor is the first public diagnostic slice of Solo-AI-Company-OS.

It checks multi-agent operating state without controlling your agents or touching your code.

Give it a sanitized handoff, worklog, claim, or skill-evolution note. It returns a diagnostic report.

## What It Diagnoses

| Module | Question |
|---|---|
| Handoff Diagnosis | Should this handoff be skipped, waited on, retried, reworked, or blocked? |
| Worklog Audit | Is this worklog complete enough to trust or continue? |
| Claim Review | Are public claims supported by evidence and bounded correctly? |
| Skill Evolution Gate | Should this lesson be ignored, recorded, distilled, or promoted as a candidate? |
| Privacy Rewrite | Can this output be made public-safe? |

## Example

Input:

```yaml
handoff_id: demo_002
status: processing
lease_owner: agent_a
lease_expires_at: 2026-05-06T10:00:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
```

Diagnosis:

```text
processing + expired lease + same source_fingerprint
-> retry with a new attempt_id
-> keep the same handoff_id
-> set a new lease_owner and lease_expires_at
```

## Boundary

Use sanitized state only. Do not paste credentials, private project names, local paths, customer data, screenshots, or unpublished founder decisions.

Before publishing public text, run:

```bash
python scripts/os-helper.py privacy-guard --file agentops-doctor/README.md
```

For the Chinese field guide, see [README.zh-CN.md](README.zh-CN.md).
