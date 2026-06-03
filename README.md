# Solo-AI-Company-OS

> A Markdown company brain for solo founders working with AI agents.

AI tools are powerful.
Real AI work gets messy fast.

- 🤯 decisions disappear inside chat history
- 🤖 different AI windows do not know what others did
- 📝 finished tasks leave no durable worklog
- 🔁 useful workflows are taught again and again
- 🧪 AI says "done", but nobody checks the evidence

Solo-AI-Company-OS helps you turn scattered AI sessions into reviewable, reusable operating memory.

[中文文档](docs/zh/README.md) · [Start Here](FOUNDER_START_HERE.md) · [AgentOps Doctor](agentops-doctor/README.md)

![Solo-AI-Company-OS map](assets/solo-ai-company-os-map.svg)

---

## The Smallest Useful Loop

Do not read the whole architecture first.
Run one small loop:

```text
Human decides.
AI executes.
Worklog remembers.
Handoff coordinates.
Skill evolves.
Doctor checks risk.
Markdown keeps the operating memory.
```

1. Pick one real task.
2. Choose an AI worker.
3. Copy its `START_PROMPT.md` into your AI tool.
4. Finish the task.
5. Create a worklog.
6. Review what should become a reusable skill.

That is enough to start building durable AI memory.

---

## What Is Inside?

| Part | Purpose |
|---|---|
| 🧭 Founder Decision Log | Records human decisions, tradeoffs, and why they were made |
| 🤖 AI Employees | Defines AI worker roles, boundaries, and start prompts |
| 📝 Worklogs | Keeps task history, evidence, results, and open questions |
| 🔁 Handoffs | Lets agents, windows, and future sessions continue work |
| 🧰 Skills | Turns verified workflows into reusable operating knowledge |
| 📊 Dashboards | Summarizes current state without replacing source records |
| 🩺 AgentOps Doctor | Checks context, claims, evidence, and workflow risk |

This is not a prompt collection.
It is an operating memory system for human-AI work.

---

## Who This Is For

Use this if you:

- work with Codex, Claude Code, Cursor, ChatGPT, Gemini, or other AI tools
- run projects across multiple AI windows or agents
- keep losing context between sessions
- want AI work to become reviewable, transferable, and reusable
- think of AI as a small team, not just a chat box

This may be too heavy if you only want a list of prompts.

---

## Quick Start

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\INSTALL.ps1
```

Cross-platform helpers:

```bash
python scripts/os-helper.py new-worklog --agent-id AI-01 --title "first setup loop"
python scripts/os-helper.py new-handoff --from-agent AI-01 --to-agent AI-02 --task-title "evidence check"
python scripts/os-helper.py doctor-example --case handoff-expired
```

The scripts only create Markdown drafts.
The real source of truth is still the operating memory you maintain.

---

## Documentation

- [中文文档](docs/zh/README.md)
- [Founder Start Here](FOUNDER_START_HERE.md)
- [First 30 Minutes](FIRST_30_MINUTES.md)
- [Example Day 1](EXAMPLE_DAY_1.md)
- [AgentOps Doctor](agentops-doctor/README.md)
- [Product Boundary](PRODUCT_BOUNDARY.md)

---

## Safety Boundary

Do not put credentials, private customer data, unpublished strategy, or raw founder reflections into public outputs.

Core rule:

```text
Founder decisions outrank AI suggestions.
Verified truth outranks narrative.
Operating memory beats scattered chat history.
```
