# Solo-AI-Company-OS

> 一个用 Markdown 管理 AI 员工、决策、工作日志、接力和能力进化的一人公司操作系统。

**English short version:** Solo-AI-Company-OS is a Markdown operating system for coordinating AI workers with durable decisions, worklogs, handoffs, and reusable skills.

![Solo-AI-Company-OS 产品地图](assets/solo-ai-company-os-home.zh-CN.svg)

---

## 先选一条路

不要先读完整架构。先按你的目的进入：

| 你现在想做什么                 | 打开这里                                                              | 结果                                                            |
| ----------------------- | ----------------------------------------------------------------- | ------------------------------------------------------------- |
| 我想开始管理 AI 员工            | [AI 员工派工台](03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md) | 选对 AI 身份，复制启动词，交付后留下 worklog                                  |
| 我想给 Agent / Worklog 做体检 | [AgentOps Doctor](agentops-doctor/README.zh-CN.md)                | 判断 skip / wait / retry / rework / block，检查脏 worklog 和越界 claim |
| 我想理解完整架构                | [中文一页纸图解](docs/zh/ONE_PAGE_VISUAL_GUIDE.md)                       | 看懂 Human / AI Employees / Worklogs / Handoffs / Skills 的关系    |

中文用户入口：

- [中文首页](docs/zh/README.md)
- [从这里开始](docs/zh/START_HERE.md)
- [快速上手](docs/zh/QUICKSTART.md)
- [核心术语表](docs/zh/GLOSSARY.md)

---

## 这不是 prompt collection

大多数 AI 工作会散在聊天窗口里：

```text
窗口 A 讨论战略
窗口 B 写代码
窗口 C 查资料
窗口 D 做审查
然后没人记得：上次到底决定了什么？
```

Solo-AI-Company-OS 的核心不是“更长的提示词”，而是把 AI 工作变成可交接、可复查、可复用的公司记忆。

```text
Human decides.
AI executes.
Worklogs remember.
Handoffs coordinate.
Skills evolve.
Markdown stays source of truth.
```

---

## 包含什么

| 模块 | 作用 |
|---|---|
| Founder Decision Log | 人类记录正式决策，AI 不覆盖人类判断 |
| AI Employees | 不同 AI 身份有职责、边界和启动词 |
| Worklogs | 每次重要 AI 工作留下可交接记录 |
| Handoffs | 用 handoff_id / attempt_id / lease 避免重复执行和卡死 |
| Skills | 从验证过的 worklog 中沉淀可复用能力 |
| Dashboards | 摘要当前状态，但不替代正式决策 |
| AgentOps Doctor | 第一个公开模块，用来诊断多 Agent 运行问题 |

---

## AgentOps Doctor

[AgentOps Doctor](agentops-doctor/README.zh-CN.md) 是从 OS 里切出来的第一个可安装/可展示模块。

它不调度你的 agent，不改你的代码，只做诊断：

- handoff 是否重复执行
- processing 是否因为 lease 过期而卡住
- worklog 是否缺 tools_used / verification
- 公开输出里的 claim 是否越界
- 某条经验应该 ignore / record / distill / promote candidate

如果你在黑客松或团队协作现场，只想快速展示一个可用功能，先展示 AgentOps Doctor。

---

## Longju 实验：用母系统驾驭一只虾

Longju 是 Solo-AI-Company-OS 的第一个真实实验对象：它当前只接普通 API 模型，但用母系统补上外置状态、角色、交接、审查和记忆。

这个实验要验证一件事：

```text
LLM API 每次调用都是无状态的。
Markdown + YAML + Worklog Brief 可以让 agent 每次醒来都读懂当前状态。
```

Longju 的每次重要任务都应该留下：

- YAML frontmatter：给下一次模型调用快速恢复状态；
- Worklog Brief：给人类和 reviewer 快速理解发生了什么；
- handoff / attempt / lease：避免重复执行和错误重试；
- evidence boundary：区分工具结果、文件状态、模型推理和未知。

AgentOps Doctor 是这个母系统的第一个诊断切片；Longju 是用来反复测试它的实验体。

---

## 15 分钟上手

Windows 最短路径：

```powershell
powershell -ExecutionPolicy Bypass -File .\INSTALL.ps1
```

安装器会询问语言。中文用户选择：

```text
zh-CN
```

生成 vault 后，打开：

```text
OBSIDIAN_HOME.md
```

然后只做一件事：从 [AI 员工派工台](03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md) 选一个 AI 员工，跑完一次任务，并用脚本生成 worklog 草稿：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-worklog.ps1 -AgentId AI-01 -Title "first setup loop"
```

---

## 轻量自动化

这些脚本只生成 Markdown，不联网、不写数据库、不依赖外部包：

```powershell
.\scripts\new-worklog.ps1      # 生成 worklog 草稿
.\scripts\new-handoff.ps1      # 生成 handoff 草稿
.\scripts\doctor-example.ps1   # 打印 AgentOps Doctor 示例输入
```

macOS / Linux / cross-platform users can use the no-dependency Python helper:

```bash
python scripts/os-helper.py new-worklog --agent-id AI-01 --title "first setup loop"
python scripts/os-helper.py new-handoff --from-agent AI-01 --to-agent AI-02 --task-title "prototype evidence check"
python scripts/os-helper.py doctor-example --case handoff-expired
python scripts/os-helper.py privacy-guard --text "public text to check"
```

脚本只是省掉手写字段。真正的 source of truth 仍然是 Markdown 文件。

---

## 适合谁

- 一个人管理多个 AI agent 的 founder / indie hacker
- 用 Codex、Claude Code、Cursor、ChatGPT 做真实项目的人
- 希望 AI 工作跨会话、跨工具、跨角色持续的人
- 需要把 AI 输出变成可审查证据链的小团队
- 想用 Obsidian 双链管理 AI 公司记忆的人

不适合：

- 想要全自动 agent 平台的人
- 只想收藏 prompt 的人
- 不愿意留下任何 worklog 的人
- 想把 AI 输出直接当事实的人

---

## English Overview

Solo-AI-Company-OS is a Markdown-first operating system for solo founders and small teams coordinating AI workers.

It provides:

- founder decision logs
- role-based AI employees
- worklogs and handoffs
- a skill evolution gate
- dashboards and Obsidian maps
- AgentOps Doctor as the first public diagnostic slice

The system is intentionally plain: Markdown files, explicit ownership, auditable work, and human approval before behavior promotion.

---

## Safety Boundary

This repository is a public template and operating model. Do not put private customer data, credentials, screenshots, unpublished strategy, or raw founder reflections into public outputs.

Core rule:

```text
Founder decisions outrank AI suggestions.
Verified truth outranks narrative.
Markdown stays source of truth.
```
