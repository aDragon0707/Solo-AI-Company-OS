# Doc Memory Spine Skill

**Purpose:** Keep the vault's operating memory coherent over time.

Use this skill when the project has many memory files and the founder needs dashboards, maps, worklogs, handoffs, prompts, and source-of-truth rules to stay synchronized.

This is a documentation governance skill. It is not an excuse to invent facts, rewrite history, or make the system look cleaner than it is.

---

## When To Use

Use this skill for:

- updating `AGENTS.md`, `CLAUDE.md`, or other AI memory files
- repairing stale startup prompts
- syncing dashboards and MOC files
- maintaining worklog indexes
- reviewing handoff quality
- checking source-of-truth order
- adding or refining claim-boundary wording
- repairing Obsidian links and navigation maps

Do not use this skill to mutate raw data, source artifacts, evidence files, reports, or production outputs unless the founder explicitly assigned that task.

---

## Source Of Truth Order

Use the project's explicit authority order when one exists.

Default order:

1. Latest explicit founder instruction.
2. Founder decision log.
3. Verified project truth.
4. Current dashboards.
5. Coordination and handoff docs.
6. Worklogs and indexes.
7. MOCs and navigation maps.
8. Historical notes and old chat summaries.

Never let a worklog override a founder decision.

---

## Core Workflow

1. Identify the memory surfaces involved.
2. Read the smallest set of source files needed.
3. Compare current docs against the source-of-truth order.
4. Find stale paths, outdated instructions, broken links, missing owners, and overconfident wording.
5. Apply targeted edits only.
6. Sync any dashboard, MOC, worklog index, or skill matrix that should reflect the new state.
7. Report what changed, what stayed uncertain, and what founder decision is still needed.

---

## Quality Gate

Before editing a major memory file, check:

| Criterion | Question |
|---|---|
| Current | Are paths, commands, owners, and dates still correct? |
| Authoritative | Does the file respect founder decisions and verified truth? |
| Navigable | Can a human or AI find the next important file? |
| Handoff-ready | Can another AI continue without guessing? |
| Bounded | Does the language avoid unsupported claims? |
| Concise | Is duplicated or stale instruction removed? |

If a file fails several criteria, summarize the problems before editing.

---

## Editing Rules

- Prefer targeted edits over full rewrites.
- Preserve uncertainty instead of smoothing it away.
- Do not convert inbox thoughts into decisions.
- Do not hide blockers.
- Do not delete historical worklogs to make the system look cleaner.
- Use internal links when the vault uses Obsidian navigation.
- Keep examples generic unless the founder explicitly asks for project-specific examples.

---

## Output Format

End with:

```text
Memory surfaces read:
Files changed:
State synced:
Broken or stale items fixed:
Unverified items left unchanged:
Founder decisions needed:
Next memory owner:
Worklog needed:
```

---

## Example Prompt

```text
Use the Doc Memory Spine skill.

Read the founder decision log, company dashboard, worklog index, link map, AI employee entry, skill matrix, and the files directly related to this request.

Repair stale instructions and navigation only where the source files support the change.

Do not invent project status.
Do not rewrite founder decisions.
End with files read, files changed, uncertainty left in place, and whether a worklog/index update is needed.
```

