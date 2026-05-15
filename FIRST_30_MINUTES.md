# First 30 Minutes

**Purpose:** Help a new founder start using Solo-AI-Company-OS without understanding the whole system first.

Do only the steps on this page. Ignore the rest of the vault until these are done.

Plain version:

```text
Make one decision.
Ask AI-01 what to do next.
Save what happened.
Stop.
```

---

## 0. Open The Vault

Open the generated folder in Obsidian, VS Code, Cursor, or any Markdown editor.

Start from:

```text
OBSIDIAN_HOME.md
```

If you are in Obsidian, keep these two notes open:

- [[OBSIDIAN_HOME|Obsidian Home]]
- [[02_Dashboards/DASHBOARD_Company_State|Company State Dashboard]]

---

## 1. Write One Founder Decision

Open:

```text
01_Founder/FOUNDER_Decision_Log.md
```

Add one decision:

```text
## DEC-YYYYMMDD-001 - Establish AI Operating Boundaries

Date:
Status: active
Decision Owner: Founder

Decision:
AI employees may help execute, organize, review, and maintain work, but founder decisions remain the source of authority.

Why:
The system needs a clear boundary between AI output and founder judgment.

AI Impact:
- AI must read founder decisions before work.
- AI worklogs do not override founder decisions.
- AI must mark uncertainty instead of guessing.
```

This is enough for Day 1. Do not try to fill every template.

What this means in plain English:

```text
AI can help, but you remain the source of authority.
```

---

## 2. Open AI-01

Open:

```text
03_Company/AI_Employees/AI-01_Founder_Office/START_PROMPT.md
```

Copy the prompt into your AI chat.

Then add this founder command:

```text
AI-01, read the founder decision log, Obsidian home, company state dashboard, AI text maintenance protocol, and worklog index.

Tell me:
1. the top 3 priorities for making this vault useful
2. the current blockers
3. what founder decisions are missing
4. which file I should update next
5. what worklog should be created after this session

Do not invent business progress. Treat this as Day 1 setup only.
```

If you want the AI to reply in another language, add that request after the prompt. Do not rewrite the role prompt first.

---

## 3. Update The Company State Dashboard

Open:

```text
02_Dashboards/DASHBOARD_Company_State.md
```

Fill only the obvious parts:

- current priority
- current blocker
- next founder decision needed
- next AI owner

If you are unsure, write:

```text
not yet verified
```

Do not make the dashboard look more mature than the source files support.

The dashboard is just a snapshot. It is allowed to look incomplete.

---

## 4. Save The First Worklog

Open:

```text
03_Company/AI_Worklogs/WORKLOG_TEMPLATE.md
```

Create a new worklog from the template after the AI-01 session.

Name it like:

```text
03_Company/AI_Worklogs/AI-01_Worklog_YYYYMMDD_First_Coordination.md
```

The worklog should say what AI-01 read, what it recommended, what changed, and what still needs founder input.

Think of the worklog as a note for the next AI window:

```text
Here is what happened. Here is what is still unknown. Do not guess.
```

---

## 5. Stop

After these steps, stop.

You have already created the minimum loop:

```text
Founder decision -> AI-01 coordination -> dashboard update -> worklog handoff
```

That loop is the product. The folder structure is only there to support it.

After your first real worklog exists, you can use `03_Company/Skills/WORKLOG_TO_SKILL_PROMPT.md` to turn a repeatable work pattern into a reusable skill. Do this later; do not make it part of Day 1 setup.

---

## What Not To Do Yet

Do not:

- customize every AI role
- fill every template
- create a complex graph
- turn rough thoughts into decisions
- ask multiple AI employees to work at the same time
- treat setup as business progress

The system becomes useful through repeated small loops, not one giant setup session.

---

## Next Session

For the next session, start again from:

```text
OBSIDIAN_HOME.md
```

Then read:

- [[01_Founder/FOUNDER_Decision_Log|Founder Decision Log]]
- [[02_Dashboards/DASHBOARD_Company_State|Company State Dashboard]]
- [[03_Company/AI_Worklogs/WORKLOG_INDEX|Worklog Index]]

Ask AI-01 what should happen next.
