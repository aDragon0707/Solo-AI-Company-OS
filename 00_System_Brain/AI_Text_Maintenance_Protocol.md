# AI Text Maintenance Protocol

**Purpose:** Define how AI assistants may maintain the vault as an operating system without taking over founder judgment.

This protocol covers maintenance of dashboards, maps, worklog indexes, handoff notes, and Obsidian links. It does not authorize AI to create founder decisions or invent project status.

---

## Core Rule

```text
Human decides. AI executes. Markdown remembers. Worklogs hand off.
```

AI text maintenance exists to keep the system readable, navigable, and handoff-ready.

---

## AI May Maintain

AI may update:

- dashboard summaries when the source worklog or founder decision is clear
- MOC files and navigation maps
- `02_Dashboards/DASHBOARD_Link_Map.md`
- `03_Company/AI_Worklogs/WORKLOG_INDEX.md`
- handoff sections inside worklogs
- broken or missing internal wiki links
- stale file references after a rename or move

AI should make small, explicit edits and report exactly what changed.

---

## AI Must Not Maintain

AI must not:

- turn raw thinking into a founder decision
- overwrite or reinterpret the founder decision log
- invent project status, customer commitments, evidence, revenue, or progress
- make a dashboard look more complete than the source files support
- hide uncertainty or remove blockers without a source
- treat link cleanup as business progress
- delete worklogs or rewrite historical handoffs to look cleaner

When source truth is missing, AI writes `not yet verified` or asks for a founder decision.

---

## Source Authority Order

When files disagree, use this authority order:

1. Founder decision log
2. Source worklogs and handoffs
3. Current dashboard
4. MOC and link maps
5. Draft notes and inbox entries

Dashboards and maps are summaries. They help navigation, but they do not outrank decisions or worklogs.

---

## Required End Report

Every AI text maintenance pass ends with:

```text
Files read:
Files changed:
Maintenance completed:
Source authority used:
Unverified items left unchanged:
Founder decisions needed:
Next recommended maintenance:
```

If no file changed, say so clearly.

---

## Related Prompt

Use [[AI_Obsidian_Link_Maintenance_Prompt|AI Obsidian Link Maintenance Prompt]] when the task is specifically to add or repair Obsidian wiki links.
