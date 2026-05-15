# Start Here

**Use this page if the repo feels too abstract.**

You do not need to understand the whole system first.

Solo-AI-Company-OS does one simple thing:

```text
It turns scattered AI chats into a reusable working system.
```

---

## The Problem

If you use AI for real work, you probably have this mess:

```text
Chat 1: strategy
Chat 2: code
Chat 3: customer copy
Chat 4: review
Chat 5: "wait, what did we decide?"
```

The problem is not that AI is weak.

The problem is that AI work has no durable company memory.

---

## The Fix

This repo gives you a plain Markdown vault with four jobs:

| You need... | Use this |
|---|---|
| one place for real decisions | Founder Decision Log |
| AI roles that know their job | AI Employees |
| a record of what happened | Worklogs |
| reusable ways of working | Skills |

That is the whole idea.

```text
Human decides.
AI executes.
Worklogs capture experience.
Skills make it reusable.
```

---

## The First Use Case

Imagine you want AI to help with a project.

Do not start by asking five AI windows to do everything.

Start like this:

```text
1. Write one founder decision.
2. Open AI-01 and ask it to route the next step.
3. Save the result as a worklog.
```

After that, the next AI window can continue from files instead of guessing from chat history.

---

## First 15 Minutes

### Step 1: Install

Download the release ZIP, unzip it, and double-click:

```text
INSTALL_WINDOWS.bat
```

Choose `en` or `zh-CN` when the installer asks for vault language.

Open the generated folder in Obsidian.

### Step 2: Open This File

Inside your generated vault, open:

```text
FIRST_30_MINUTES.md
```

### Step 3: Start AI-01

Open:

```text
03_Company/AI_Employees/AI-01_Founder_Office/START_PROMPT.md
```

Copy it into your AI chat.

Then say:

```text
Help me complete the first setup loop.

Do not invent business progress.
Tell me the next 3 actions, the blockers, and what worklog I should create.
```

---

## What You Should Feel

After the first session, you should have:

- one clear decision
- one AI role in charge of routing
- one dashboard with current state
- one worklog the next AI can read

That is success.

Do not fill every file. Do not customize every role. Do not build a perfect graph.

The system becomes useful through small loops.

---

## What Each Folder Means

| Folder | Plain meaning |
|---|---|
| `01_Founder/` | your thoughts, decisions, and retrospectives |
| `02_Dashboards/` | quick status pages |
| `03_Company/AI_Employees/` | AI role prompts |
| `03_Company/AI_Worklogs/` | what each AI did |
| `03_Company/Skills/` | reusable patterns learned from worklogs |
| `04_Learning/` | help the founder understand the system |

Start with `FIRST_30_MINUTES.md`. Come back to this table when the folders feel confusing.
