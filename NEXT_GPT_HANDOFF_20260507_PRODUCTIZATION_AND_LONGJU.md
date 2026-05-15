# Next GPT Handoff - 2026-05-07 - Productization, Longju, and Solo AI Company OS

> This is an internal handoff for the next GPT/Codex session. It is not a public README.

Internal boundary: this file may contain local paths, sandbox names, and private operating context for the next AI session. Do not copy those details into public docs, demo scripts, README files, release notes, or generated vaults. Public output must abstract them into capability, pattern, or synthetic case language.

## 0. Read This First

The current project is `F:\Solo-AI-Company-OS`.

This repo should remain the source of truth / open-source mother system.

`D:\OpenClaw_Workspace` should remain the sandbox for Longju, BotLearn, SkillHunt, generated test vaults, and event-specific packages.

Do not move the main repo into `D:\OpenClaw_Workspace`.

Do not read or summarize restricted founder material unless the human explicitly asks for it in that session.

## 1. What We Actually Did Today

### 1.1 Productized The First Screen

We changed the project from "documentation maze" toward "Chinese-first product entry".

Updated:

- `README.md`
- `OBSIDIAN_HOME.md`
- `docs/zh/README.md`
- `docs/zh/START_HERE.md`
- `docs/zh/QUICKSTART.md`
- `docs/zh/GLOSSARY.md`
- `docs/zh/FIRST_RUN_EXAMPLE.md`

New Chinese public docs:

- `docs/zh/WHY_THIS_EXISTS.md`
- `docs/zh/HACKATHON_STORY.md`
- `docs/zh/ONE_PAGE_VISUAL_GUIDE.md`

New visual:

- `assets/solo-ai-company-os-home.zh-CN.svg`

The new first-screen model is:

```text
1. I want to manage AI employees -> AI Employee Command Center
2. I want to diagnose Agent / Worklog problems -> AgentOps Doctor
3. I want to understand the architecture -> One-Page Visual Guide
```

### 1.2 Added AI Employee Command Center

New file:

- `03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md`

Purpose:

- Make the AI employee system operational for new users.
- Help users choose AI-01 / AI-02 / AI-03 / AI-04 / AI-05 by task type.
- Give copyable task instructions.
- End every serious task with a worklog or handoff.

Updated:

- `03_Company/AI_Employees/README.md`
- `03_Company/MOC_AI_Employees.md`
- `03_Company/Skills/AGENT_SKILL_MATRIX.md`

Important shift:

The skill matrix is now an internal reference. The command center is the user-facing dispatch desk.

### 1.3 Integrated AgentOps Doctor As A Top-Level Public Module

New folder:

- `agentops-doctor/`

New files:

- `agentops-doctor/README.zh-CN.md`
- `agentops-doctor/README.md`
- `agentops-doctor/templates.zh-CN.md`
- `agentops-doctor/cases.zh-CN.md`
- `agentops-doctor/field-notes-playbook.zh-CN.md`
- `agentops-doctor/demo-script-3min.zh-CN.md`

Updated:

- `03_Company/MOC_AgentOps_Doctor.md`

Positioning:

```text
Solo-AI-Company-OS = mother system
AgentOps Doctor = first public diagnostic module
Handoff Diagnosis = one module inside Doctor
```

AgentOps Doctor checks:

- handoff state
- lease / attempt / source_fingerprint
- dirty worklogs
- unsupported claims
- skill evolution gates
- public/private rewrite boundaries

### 1.4 Added Lightweight Automation

New scripts:

- `scripts/new-worklog.ps1`
- `scripts/new-handoff.ps1`
- `scripts/doctor-example.ps1`
- `scripts/os-helper.py`

Updated:

- `scripts/README.md`

Purpose:

- Avoid making users hand-write every frontmatter field.
- Keep the system Markdown-first.
- Add cross-platform support through `os-helper.py`.

Python helper supports:

```bash
python scripts/os-helper.py new-worklog --agent-id AI-01 --title "first setup loop"
python scripts/os-helper.py new-handoff --from-agent AI-01 --to-agent AI-02 --task-title "prototype evidence check"
python scripts/os-helper.py doctor-example --case handoff-expired
python scripts/os-helper.py privacy-guard --file agentops-doctor/README.zh-CN.md
```

### 1.5 Fixed zh-CN Generated Vault Entry Risk

The zh-CN locale overlay had old mojibake text and was overriding the new Home during vault generation.

Fixed:

- `locales/zh-CN/OBSIDIAN_HOME.md`
- `locales/zh-CN/START_HERE.md`
- `locales/zh-CN/FIRST_30_MINUTES.md`
- `locales/zh-CN/03_Company/AI_Employees/README.md`
- `locales/zh-CN/03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md`

Generated test vault:

```text
D:\OpenClaw_Workspace\saco_zh_test_vault
```

Final check passed:

- generated zh-CN vault contains new Home
- Home links to command center, AgentOps Doctor, and one-page visual guide
- AgentOps Doctor and helper scripts copied
- generated entry files passed precise mojibake scan

### 1.6 Synced Navigation State

Updated:

- `02_Dashboards/DASHBOARD_Company_State.md`
- `02_Dashboards/DASHBOARD_Link_Map.md`
- `03_Company/MOC_Company.md`

Purpose:

- Home, dashboard, MOC, AgentOps Doctor, and AI employee command center are now connected.

## 2. Verification Already Run

Passed:

- PowerShell worklog generation
- PowerShell handoff generation
- Python worklog generation
- Python handoff generation
- `doctor-example` output
- `privacy-guard` blocks Windows paths and `sk-...` style keys
- `privacy-guard` passes public docs
- SVG XML parsing
- PowerShell script parsing
- Python syntax compile
- precise mojibake scan for key public files
- link text checks for README/Home/MOC/Doctor/Command Center
- generated zh-CN vault final check

Important note:

PowerShell may display Chinese incorrectly because of console encoding. Use Python UTF-8 reads or Unicode escape checks when verifying Chinese text.

## 3. The Human's Three Current Directions

The human has three big directions:

### Direction 1: Make The One-Person Company Project Simpler

Goal:

Make the project feel easy, light, and obvious to new users.

It should connect smoothly to:

- Codex
- Claude / Claude Code
- Longju
- any AI chat window that can read Markdown context

Current concern:

The repo still risks feeling like math homework or a research paper.

Next GPT should continue reducing first-use friction.

Recommended next work:

1. Create a `DAY_1_CHINESE_USER_PATH.md`.
2. Make `AI_EMPLOYEE_COMMAND_CENTER.md` even more button-like.
3. Add "copy this prompt" blocks for:
   - Codex
   - Claude Code
   - Longju
4. Add a "Do not read all files" warning to onboarding.
5. Make the generated vault open with only 3-5 obvious actions.

### Direction 2: Feed More Project Experience Into Longju

Goal:

Test how strong the human's own Longju / lobster agent really is after absorbing project experience.

Known pattern:

Do not dump private project details into public outputs.

Instead:

```text
private project experience -> abstract capability -> public-safe case -> skill candidate
```

Current Longju capability arc already includes:

- IR fallback with official source checks
- release channel reasoning
- exact rational / float honesty
- symbolic math / high precision tooling
- SACP handoff state machine
- privacy boundary
- knowledge routing by source aliases
- AgentOps Doctor distillation

Recommended next work:

1. Create a local `Longju_Learning_Queue.md`.
2. For each private project, extract only:
   - capability name
   - public-safe pattern
   - test drill
   - privacy boundary
   - possible skill candidate
3. Run Longju through a new `Local Gate Test v0.3`:
   - multi-agent coordination
   - evidence chain
   - code execution
   - claim boundary
   - skill evolution
   - public rewrite
4. Record results as worklogs, not immediate promoted skills.

### Direction 3: Tighten The Architecture Details

Goal:

The architecture looks simple, but the details need to be nailed down.

Key areas needing precision:

- handoff_id vs attempt_id vs source_fingerprint
- lease ownership and expiry
- worklog as record, not trigger
- skill evolution gate
- human promotion gate
- dashboard vs decision log authority
- public/internal/private/restricted boundary
- multi-model adversarial review

Recommended next work:

1. Create a concise `SACP_MINIMAL_SPEC.md`.
2. Create a visual state machine for handoff:
   - requested
   - claimed
   - processing
   - completed
   - failed
   - expired
   - blocked
   - superseded
3. Create a "five lobsters collaboration" operating note:
   - AI-01 coordinator
   - AI-02 builder/evidence
   - AI-03 growth/expression
   - AI-04 adversarial review/risk
   - AI-05 tutor/memory
4. Decide how different models can be assigned to different roles.

## 4. Adversarial Review Of The Human's Thinking

### 4.1 The Simplicity Goal Is Correct, But Dangerous If It Becomes Shallow

The OS should be easier to enter.

But do not remove the discipline that makes it valuable.

Keep:

- worklogs
- handoffs
- claim boundary
- human promotion gate
- Markdown source of truth

Simplify the path, not the principles.

Bad simplification:

```text
"Just chat with AI and write notes when you remember."
```

Good simplification:

```text
"Pick AI -> run task -> write worklog -> diagnose if stuck."
```

### 4.2 Feeding Longju More Knowledge Is Valuable, But Only Through Tests

Do not keep telling Longju more and more theory.

Longju should learn through drills:

```text
capability -> test case -> output -> adversarial review -> worklog -> distill candidate
```

Otherwise it becomes a beautifully instructed agent that still fails under pressure.

### 4.3 Architecture Detail Work Must Stay Operational

It is tempting to write a perfect protocol.

Do not overdo it.

Every protocol detail should answer:

```text
What bug does this prevent?
What file records it?
How does the next AI continue from it?
```

If a detail does not help execution, it belongs in a note, not the core loop.

### 4.4 Multi-Model Adversarial Review Is A Real Advantage

The human asked whether different models should be introduced for adversarial review.

Answer:

Yes.

Reason:

One model family tends to share blind spots. Use different models for:

- implementation
- expression
- risk review
- teaching
- final synthesis

Minimum practical setup:

```text
AI-01: coordinator / state
AI-02: builder / evidence
AI-04: adversarial review
Human: final approval
```

Add AI-03 and AI-05 after the three-agent loop is stable.

## 5. Recommended Next Sprint

Name:

```text
Solo-AI-Company-OS Simplification + Longju Evaluation Sprint 1.1
```

### Step 1: Create A Day-1 Chinese User Path

Output:

- `docs/zh/DAY_1_CHINESE_USER_PATH.md`

Content:

- "If you only have 10 minutes"
- "If you want to run one AI employee"
- "If you want to try AgentOps Doctor"
- "If you want to connect Codex / Claude / Longju"

### Step 2: Create Five Lobsters Collaboration Note

Output:

- `03_Company/AI_Employees/FIVE_LOBSTERS_OPERATING_MODEL.md`

Content:

- role map
- model assignment idea
- handoff chain
- adversarial review loop
- when to use 1-3-1
- when not to use five agents

### Step 3: Create Longju Learning Queue

Output:

- `03_Company/AI_Worklogs/Longju_Learning_Queue.md` or `00_System_Brain/Longju_Learning_Queue.md`

Content:

- capability queue
- source category
- test drill
- privacy boundary
- expected output
- evolution decision

### Step 4: Run Local Gate Test v0.3

Run tests against Longju:

1. handoff diagnosis
2. worklog audit
3. claim boundary rewrite
4. exact math / statistics
5. knowledge routing
6. multi-agent adversarial review
7. public communication draft

Record results in a worklog.

### Step 5: Do Not Publish Yet Without Review

Before public publish:

- Run privacy guard.
- Have AI-04 review public language.
- Confirm AgentOps Doctor examples are all synthetic.
- Confirm no local project paths or private customer/platform details.

## 6. Concrete Current Best Demo Case

Best single AgentOps Doctor demo:

```yaml
handoff_id: demo_003
status: processing
lease_owner: agent_a
lease_expires_at: 2020-01-01T10:00:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
```

Expected diagnosis:

```text
processing + expired lease + same fingerprint
-> retry
-> same handoff_id
-> new attempt_id
-> set new lease_owner and lease_expires_at
```

Why this is strongest:

- It is concrete.
- It is fast to explain.
- It prevents duplicate work.
- It shows that the Doctor is operational, not just a writing assistant.
- It naturally leads into the bigger OS story.

## 7. Rules For The Next GPT

Do:

- Keep the project Markdown-first.
- Keep Chinese onboarding first for the current event context.
- Keep English short but present for GitHub.
- Use `F:\Solo-AI-Company-OS` as the source repo.
- Use `D:\OpenClaw_Workspace` as sandbox/test/event workspace.
- Prefer small user-facing entry files over more theory.
- Verify generated zh-CN vault when changing locales.

Do not:

- Move the main repo into `D:\OpenClaw_Workspace`.
- Read restricted founder files without explicit approval.
- Publish or upload anything without the human saying so.
- Turn every insight into a promoted skill.
- Expose private project paths or private project details in public docs.
- Optimize only for benchmark score.

## 8. Good First Prompt For Next GPT

```text
You are working in F:\Solo-AI-Company-OS.

Read NEXT_GPT_HANDOFF_20260507_PRODUCTIZATION_AND_LONGJU.md first.

Do not read 01_Founder unless I explicitly ask.

Continue the Solo-AI-Company-OS Simplification + Longju Evaluation Sprint 1.1.

First, inspect the current README, OBSIDIAN_HOME, AI_EMPLOYEE_COMMAND_CENTER, agentops-doctor, and zh-CN locale overlay.

Then propose or implement the next smallest set of changes to:
1. make Day-1 onboarding simpler,
2. define five-lobster collaboration,
3. prepare Longju Local Gate Test v0.3.

Keep outputs Markdown-first and public-safe.
```
