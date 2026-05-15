# Dashboard - Company State

**Purpose:** Provide a quick operating snapshot for the founder and AI employees.

**Authority:** This dashboard summarizes state. It does not override `01_Founder/FOUNDER_Decision_Log.md` or verified project truth.

---

## Current Snapshot

| Field | Current State |
|---|---|
| Company | Solo-AI-Company-OS working vault |
| Founder | 龙驹 / human final authority |
| Main project | AI Company OS with AgentOps Doctor release slice |
| Main product | AgentOps Doctor: Worklog, Handoff & Skill Evolution Review |
| Current stage | productized public Markdown layer with AgentOps Doctor module |
| Last reviewed | 2026-05-07 |

---

## Top Priorities

| Priority | Owner | Status | Notes |
|---|---|---|---|
| Chinese-first public entry | AI-01 | DONE | README and Obsidian Home now route to dispatch desk, AgentOps Doctor, and architecture guide. |
| AgentOps Doctor public module | Founder / AI-01 / AI-04 | INTEGRATED, NEEDS FINAL REVIEW | Top-level public docs, cases, templates, field notes, and demo script now exist. |
| AI employee dispatch desk | AI-01 | DONE | Users can pick the right AI employee without reading the full matrix first. |
| Longju as live OS experiment | AI-01 / Longju / AI-04 | ACTIVE | New dashboard and drift-control protocol track whether Markdown/YAML state improves a DeepSeek-only agent's execution stability. |
| Codex execution alignment | AI-01 / Codex | ACTIVE | Root `AGENTS.md` and Codex protocol now define task mode, authority, read budget, stop conditions, and verification expectations. |

---

## Active Blockers

| Blocker | Owner | Needed To Resolve | Status |
|---|---|---|---|
| Public publish scope | Founder / AI-04 | Final review of AgentOps Doctor public module and examples before external publish. | NEEDS FOUNDER DECISION |
| Skill publish command not run | Founder | Publish requires explicit human approval and platform timing. | OPEN |
| BotLearn setup heartbeat page pending | External platform | Treat as platform sync issue unless new evidence appears. | NOT A LOCAL BLOCKER |
| Longju benchmark recheck regression | AI-01 / Longju | Use dry-run answers, source checks, and shorter verified responses before next public score push. | OPEN |

---

## Founder Decisions Needed

| Decision Needed | Why It Matters | Requested By | Status |
|---|---|---|---|
| Approve AgentOps Doctor as the SkillHunt publish direction | Prevents the work from drifting back into either a tiny handoff tool or an overlarge OS dump. | AI-01 | Needs Founder Decision |
| Approve public examples and field-note language | Prevents leakage and overclaiming before external release. | AI-04 | Needs Founder Decision |
| Decide whether the current release candidate may become an active company skill after one field test | Keeps the human promotion gate intact. | AI-01 | Needs Founder Decision |

---

## AI Employee Ownership

| AI | Current Assignment | Status | Next Handoff |
|---|---|---|---|
| AI-01 | Coordinate AgentOps Doctor release sprint and memory sync | ACTIVE | Founder / AI-04 |
| AI-02 | Verify public-safe examples and technical claims | READY | AI-04 |
| AI-03 | Prepare field-facing README, pitch, and usage-note prompts | READY | Founder / AI-04 |
| AI-04 | Claim-boundary, privacy, and publish-scope review | REQUIRED BEFORE PUBLISH | Founder |
| AI-05 | Turn the architecture into founder study material | READY | docs/zh/ONE_PAGE_VISUAL_GUIDE.md |

---

## Recent Worklog Summary

| Date | AI | Topic | Worklog | State Impact |
|---|---|---|---|---|
| 2026-05-06 | AI-01 | Longju AgentOps Doctor distillation | `03_Company/AI_Worklogs/AI-01_Worklog_20260506_Longju_AgentOps_Doctor_Distillation.md` | Converted the Longju tuning process into a company memory and release-sprint direction. |
| 2026-05-06 | Longju | IR fallback drill | `03_Company/AI_Worklogs/worklog_20260506_longju_ir_fallback_drill.md` | Established official-source fallback for latest/current queries when web search times out. |
| 2026-05-06 | Longju | Handoff state machine refinement | `03_Company/AI_Worklogs/worklog_20260506_longju_handoff_state_machine.md` | Refined handoff retry, lease, attempt, and receiving-worklog authority rules. |
| 2026-05-07 | AI-01 | Longju live experiment dashboard | `02_Dashboards/DASHBOARD_Longju_Experiment.md` | Turned Longju into the first visible test object for the mother system's drift-control loop. |
| 2026-05-07 | Codex | Codex execution alignment protocol | `00_System_Brain/CODEX_EXECUTION_ALIGNMENT_PROTOCOL.md` | Added a self-governance protocol so Codex can distinguish analysis, implementation, review, stop conditions, and no-read boundaries. |

---

## Update Rule

When AI-01 updates this dashboard, it must preserve uncertainty.

Use:

- `not yet verified`
- `[Needs Founder Decision]`
- `blocked`
- `unknown`

Do not convert unclear work into confirmed state.
