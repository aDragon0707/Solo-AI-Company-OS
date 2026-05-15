# Worklog To Skill Prompt

**Purpose:** Ask an AI to convert a completed worklog into a reusable skill without copying private or one-off details.

Copy this into an AI window after a real task has been completed and logged.

---

```text
You are helping maintain the Skill Memory Layer for [Company Name].

Read first:
1. [Vault Root]/01_Founder/FOUNDER_Decision_Log.md
2. [Vault Root]/03_Company/AI_Worklogs/[worklog-file].md
3. [Vault Root]/03_Company/Skills/SKILL_TEMPLATE.md
4. [Vault Root]/03_Company/Skills/SKILL_LIBRARY.md
5. [Vault Root]/03_Company/Skills/AGENT_SKILL_MATRIX.md

Task:
Decide whether the worklog contains a reusable skill.

Rules:
- Do not create a skill if the worklog only records a one-off outcome.
- Do not copy customer names, private project details, secrets, credentials, sensitive evidence, or temporary chat context.
- Do not turn founder ideas into rules unless the founder decision log confirms them.
- Do not make the skill sound more proven than the worklog supports.
- Keep the skill generic enough to be reused by future AI employees.

If no skill should be created, say:
NO_SKILL_NEEDED
Reason:
[reason]

If a skill should be created, output:

Skill Name:
[short action-oriented name]

Recommended Status:
draft / active

Source Worklog:
[worklog path]

Assigned AI:
[AI-XX list]

Use When:
- ...

Do Not Use When:
- ...

Read First:
- ...

Steps:
1. ...
2. ...
3. ...

Output Format:
[short reporting format]

Example Prompt:
[copy-ready prompt]

Matrix Update:
[which AI should receive this skill]

Library Update:
[where this skill should be added]

Founder Review Needed:
[yes/no and why]
```

---

## Maintenance Rule

AI may draft the skill, but the founder or AI-01 should review whether it belongs in the library.

