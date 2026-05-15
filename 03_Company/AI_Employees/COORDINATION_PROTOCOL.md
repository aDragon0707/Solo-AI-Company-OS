# AI Employees Coordination Protocol

**Purpose:** Define how AI employees coordinate, pass state, and prevent hallucinated continuation.

---

## 1. Single Source Hierarchy

| Source Type | Authority |
|---|---|
| Founder decisions | `01_Founder/FOUNDER_Decision_Log.md` |
| Verified project truth | project-specific truth source |
| Company state summary | `02_Dashboards/DASHBOARD_Company_State.md` |
| Work history | `03_Company/AI_Worklogs/WORKLOG_INDEX.md` |
| Role scope | `03_Company/AI_Employees/*/ROLE.md` |

If sources conflict, the founder decision log wins.

The company state dashboard is an orientation layer. It must be updated when worklogs or founder decisions change, but it does not override either one.

---

## 2. State-Passing Mechanism

When an AI finishes a task, it must leave enough context for the next AI to continue without guessing.

Every handoff must include:

```text
Handoff To:
Reason For Handoff:
Current State:
Files Read:
Files Changed:
Verification Status:
Known Gaps:
Next AI Needs:
Do Not Assume:
Founder Decision Needed:
```

If this section is missing, the next AI must treat the task as under-specified and ask AI-01 or the founder for clarification.

---

## 3. Role Boundaries

| AI | Owns | Must Not Own |
|---|---|---|
| AI-01 | coordination and state | final customer promises |
| AI-02 | truth and verification | market claims without review |
| AI-03 | sales material | technical truth source |
| AI-04 | claim boundaries | customer commitments |
| AI-05 | founder learning | production changes without review |

---

## 4. Cross-AI Handoff Format

```text
Handoff To: AI-XX
Reason:
Input Files:
Required Output:
Verification Required:
Cannot Do:
Priority:
Deadline or Window:
Founder Decision Needed:
```

---

## 5. Completion Rule

A task is not complete until the responsible AI records:

- what it did
- what it verified
- what remains uncertain
- what changed
- what the next AI or founder needs

No worklog, no durable company memory.

---

## 6. SACP/0.1 Experimental Bridge

SACP/0.1 is the experimental Solo AI Company Protocol layer.

Read:

```text
00_System_Brain/SACP_Protocol.md
00_System_Brain/SACP_Agent_Bridge.md
```

Use SACP only as a lightweight Markdown/YAML operating contract. Do not treat it as a CLI, app, server, database, or autonomous runtime.

When a worklog or handoff has SACP frontmatter:

- `status: completed` is a fact state, not a trigger event
- `downstream_handoff` names a target owner, not a repeated trigger
- `handoff_id` is the idempotency key
- a receiving worklog should cite `source_handoff_id`
- do not create duplicate handoffs on repeated reads
- do not require mutation of the source handoff file unless the founder explicitly asks

If SACP fields conflict with founder decisions or verified truth, the existing source hierarchy still wins.
