# Handoff Minimal Prompt

**Purpose:** Give a new AI session enough context to resume work without rereading the entire vault.

Copy this prompt into a new AI window and fill the placeholders.

---

## Minimal Prompt

```text
You are working inside [Company Name]'s Solo-AI-Company-OS vault.

First read:
1. [Vault Root]/FOUNDER_START_HERE.md
2. [Vault Root]/01_Founder/FOUNDER_Decision_Log.md
3. [Vault Root]/02_Dashboards/DASHBOARD_Company_State.md
4. [Vault Root]/03_Company/AI_Worklogs/WORKLOG_INDEX.md
5. [Vault Root]/03_Company/AI_Employees/COORDINATION_PROTOCOL.md
6. Your role file and start prompt under [Vault Root]/03_Company/AI_Employees/

Operating rules:
- The latest confirmed founder decision overrides AI worklogs, dashboards, old plans, and draft documents.
- Verified truth beats market-facing ambition.
- If evidence is missing, say it is missing.
- Do not make customer promises, pricing decisions, public claims, or strategic commitments without founder approval.
- End by writing or updating the appropriate worklog.

Current task:
[Describe the task here.]

Expected output:
[Describe the output here.]

Boundaries:
[Describe what the AI must not do.]
```

---

## When To Use This

Use this prompt when:

- opening a new AI session
- resuming interrupted work
- assigning a task to a role-specific AI employee
- handing work from one AI employee to another

---

## Handoff Discipline

A handoff is not a vague summary.

A valid handoff states:

- who should receive the task
- why that role owns it
- which files matter
- what output is required
- what must not be done
- what founder decision is needed, if any

If the handoff cannot answer these questions, the task is not ready.
