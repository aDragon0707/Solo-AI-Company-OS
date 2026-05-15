# AI Employees - Daily Entry

**Purpose:** Choose the right AI employee for a task and start with the correct role prompt.

如果你是第一次使用，先打开：

```text
AI_EMPLOYEE_COMMAND_CENTER.md
```

That command center is the user-facing dispatch desk. This file is the role directory.

---

## Fast Path

1. Open `AI_EMPLOYEE_COMMAND_CENTER.md`.
2. Pick one AI employee by task type.
3. Copy that employee's `START_PROMPT.md`.
4. Add the current task.
5. Require a worklog or explicit no-worklog reason before closing.

Coordination rules:

```text
COORDINATION_PROTOCOL.md
```

Skill reference:

```text
03_Company/Skills/AGENT_SKILL_MATRIX.md
03_Company/Skills/SKILL_LIBRARY.md
```

---

## Default AI Employees

### AI-01 Founder Office / PMO

Use for:

```text
priorities, task routing, dashboards, state sync, decision discipline
```

Read:

- `AI-01_Founder_Office/ROLE.md`
- `AI-01_Founder_Office/START_PROMPT.md`

### AI-02 Builder / Evidence Owner

Use for:

```text
technical work, verification, source truth, artifacts, build quality
```

Read:

- `AI-02_Builder_Evidence/ROLE.md`
- `AI-02_Builder_Evidence/START_PROMPT.md`

### AI-03 Growth / Revenue

Use for:

```text
leads, outreach, customer messages, offers, pricing drafts, pipeline
```

Read:

- `AI-03_Growth_Sales/ROLE.md`
- `AI-03_Growth_Sales/START_PROMPT.md`

### AI-04 Research / Risk

Use for:

```text
claim boundaries, research framing, risk review, sensitive language
```

Read:

- `AI-04_Research_Risk/ROLE.md`
- `AI-04_Research_Risk/START_PROMPT.md`

### AI-05 Learning Tutor

Use for:

```text
founder learning, architecture explanation, homework review, code comprehension
```

Read:

- `AI-05_Learning_Tutor/ROLE.md`
- `AI-05_Learning_Tutor/START_PROMPT.md`

---

## Rule For Every AI Window

Every AI starts by reading:

1. relevant founder-approved decision or task brief
2. relevant dashboard or project state
3. its own role file
4. coordination protocol
5. worklog index

Every AI ends by writing a worklog or explicitly stating why no worklog was needed.
