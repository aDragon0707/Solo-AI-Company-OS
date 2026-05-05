> 🌐 Language: **English** | [[zh/00_System_Brain/V2_Cognitive_OS_Roadmap.md|简体中文]]
# Solo-AI-Company-OS v2: Cognitive Operating System Roadmap

## Vision: The Nervous System Over The Skeleton

Solo-AI-Company-OS v1 is an **Organizational Skeleton**. It uses Markdown and Obsidian to establish discipline, separating thinking from decision-making. It is human-readable, intentionally lightweight, transparent, and requires zero complex infrastructure to deploy today.

Version 2 represents the **Optional Intelligent Execution Layer (The Nervous System)**. As a solo founder scales their AI automation, they may eventually encounter the "Context Tax"--where reading static Markdown folders becomes too slow or expensive for AI agents. V2 outlines the future direction for converting this static memory into an active, event-driven architecture.

**The Core Principle:**
V2 does **not** replace V1. V2 is an optional toolkit of derived states and queryable interfaces built *on top* of the V1 Markdown foundation.

---

## Anti-Goals (What V2 Will Never Do)

To preserve the utility of this operating system, the future architecture strictly adheres to these constraints:
* **Do not require heavy infrastructure to use v1.** A solo founder should never *need* an MCP server or LangGraph just to run the base OS.
* **Do not replace founder decision logs.** Markdown remains the ultimate source of truth.
* **Do not overwrite raw worklogs.** The messy reality of AI execution must remain visible.
* **Do not auto-convert every inbox thought into a task.** The founder must have space to vent and brainstorm without triggering system-wide execution.
* **Do not red-team every trivial output.** Adversarial review should be reserved for high-risk operations to prevent the system from becoming slow and prohibitively expensive.

---

## The Four Future Modules (Opt-In Architecture)

### 1. Queryable Context Interfaces (Dynamic Context)
Instead of forcing AI to read massive `ROLE.md` and `Decision_Log.md` files sequentially, future implementations will explore an MCP-style interface.
* **Concept:** Move from static reading to dynamic querying (e.g., `get_active_constraints(role, task)`, `get_latest_decision(topic)`).
* **Benefit:** Reduces token bloat and keeps context windows highly focused.

### 2. Derived State Graph (Structured Memory)
While raw Markdown worklogs act as the human-readable "legal pad" (the unedited accident scene of daily work), the system will eventually support a machine-readable derived layer.
* **Concept:** An operational view that translates completed worklogs into a JSON event stream or State Graph.
* **Benefit:** Allows complex AI agents to quickly understand the current project state without reading weeks of narrative text.

### 3. Decision-Intake Workflow (Cognitive Intake)
The `FOUNDER_Thinking_Inbox.md` remains a free-form zone for anxiety, ideas, and complaints. V2 introduces a buffer that *only activates upon request*.
* **Concept:** When the founder explicitly asks to formalize an idea, a Socratic dialogue engine helps refine the raw thought into an architectural thesis before it is committed to the Decision Log.
* **Benefit:** Prevents half-baked ideas from instantly becoming mandatory AI tasks.

### 4. Red-Team Review Gates (Adversarial Safety)
Peer review among AI employees often leads to "pandering" and shared hallucinations. V2 proposes isolated Red-Team gateways that serve strictly as blockers.
* **Concept:** A gateway model that does not fix or polish, but only rejects outputs that violate the Founder's Decision Log.
* **Threshold:** Only deployed at high-risk choke points (e.g., public claims, pricing changes, production merges, or core truth promotion).
