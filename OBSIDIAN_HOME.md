# Solo-AI-Company-OS Home

> 主入口。不要从文件夹树里迷路，先从这里选路径。

![Solo-AI-Company-OS 产品地图](assets/solo-ai-company-os-home.zh-CN.svg)

---

## 今天你要做什么

| 目的 | 入口 | 什么时候用 |
|---|---|---|
| 管理 AI 员工 | [[03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER|AI 员工派工台]] | 不知道该开哪个 AI、复制哪段启动词、任务结束写什么 |
| 诊断 Agent / Worklog | [[agentops-doctor/README.zh-CN|AgentOps Doctor]] | handoff 重复、lease 过期、worklog 太脏、claim 没证据 |
| 复制派工模板 | [[00_System_Brain/AI_TASK_PACKET_TEMPLATE_ZH|AI 派工模板]] | 想给 Codex 或 Longju 一个清楚的小任务包 |
| 给 Codex 派仓库任务 | [[00_System_Brain/CODEX_EXECUTION_ALIGNMENT_PROTOCOL|Codex 执行对齐协议]] | 想让 Codex 明确只分析、实现、审查、停止条件和禁读边界 |
| 理解完整架构 | [[docs/zh/ONE_PAGE_VISUAL_GUIDE|中文一页纸图解]] | 想看懂 Human / AI / Worklog / Handoff / Skill 的关系 |

最短新手路径：

```text
[[docs/zh/START_HERE|从这里开始]]
-> [[docs/zh/DAY_1_CHINESE_USER_PATH|Day-1 中文用户路径]]
-> [[03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER|AI 员工派工台]]
-> [[03_Company/AI_Worklogs/WORKLOG_INDEX|Worklog Index]]
```

---

## 1. 中文上手

- [[docs/zh/README|中文首页]]
- [[docs/zh/START_HERE|从这里开始]]
- [[docs/zh/DAY_1_CHINESE_USER_PATH|Day-1 中文用户路径]]
- [[docs/zh/QUICKSTART|快速上手]]
- [[docs/zh/GLOSSARY|核心术语表]]
- [[docs/zh/FIRST_RUN_EXAMPLE|第一次运行示例]]
- [[docs/zh/WHY_THIS_EXISTS|为什么这不是 prompt collection]]
- [[docs/zh/HACKATHON_STORY|黑客松展示故事]]

---

## 2. AI 员工操作区

- [[03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER|AI 员工派工台]]
- [[03_Company/AI_Employees/FIVE_LOBSTERS_OPERATING_MODEL|Five Lobsters Operating Model]]
- [[03_Company/AI_Employees/README|AI Employees Home]]
- [[03_Company/MOC_AI_Employees|AI Employee Map]]
- [[03_Company/AI_Employees/COORDINATION_PROTOCOL|Coordination Protocol]]
- [[03_Company/Skills/AGENT_SKILL_MATRIX|Agent Skill Matrix]]
- [[03_Company/Skills/SKILL_LIBRARY|Skill Library]]
- [[03_Company/AI_Worklogs/WORKLOG_INDEX|Worklog Index]]
- [[03_Company/AI_Worklogs/WORKLOG_TEMPLATE|Worklog Template]]

默认 AI 员工：

- [[03_Company/AI_Employees/AI-01_Founder_Office/START_PROMPT|AI-01 Founder Office / PMO]]
- [[03_Company/AI_Employees/AI-02_Builder_Evidence/START_PROMPT|AI-02 Builder / Evidence Owner]]
- [[03_Company/AI_Employees/AI-03_Growth_Sales/START_PROMPT|AI-03 Growth / Revenue]]
- [[03_Company/AI_Employees/AI-04_Research_Risk/START_PROMPT|AI-04 Research / Risk]]
- [[03_Company/AI_Employees/AI-05_Learning_Tutor/START_PROMPT|AI-05 Learning Tutor]]

---

## 3. AgentOps Doctor

- [[agentops-doctor/README.zh-CN|AgentOps Doctor 中文 README]]
- [[agentops-doctor/templates.zh-CN|诊断输入模板]]
- [[agentops-doctor/cases.zh-CN|公开案例库]]
- [[agentops-doctor/field-notes-playbook.zh-CN|现场实战手册]]
- [[03_Company/MOC_AgentOps_Doctor|AgentOps Doctor MOC]]

一句话：它是 AI Company OS 的第一个公开诊断模块，用来检查 handoff、worklog、claim、skill evolution 和 privacy rewrite。

---

## 4. 公司运行地图

- [[02_Dashboards/DASHBOARD_Company_State|Company State Dashboard]]
- [[02_Dashboards/DASHBOARD_Longju_Experiment|Longju Experiment Dashboard]]
- [[02_Dashboards/DASHBOARD_Link_Map|Obsidian Link Map]]
- [[03_Company/MOC_Company|Company Map]]
- [[03_Company/Skills/README|Skill Memory Layer]]
- [[03_Company/User_Research/README|User Research]]
- [[03_Company/MOC_Demo_Package|Demo Package Map]]
- [[03_Company/MOC_Project_Evidence|Project Evidence Map]]

---

## 5. 系统原则

- [[00_System_Brain/System_Principles|System Principles]]
- [[00_System_Brain/AI_Employees_Operating_Model|AI Employees Operating Model]]
- [[00_System_Brain/AI_Text_Maintenance_Protocol|AI Text Maintenance Protocol]]
- [[00_System_Brain/Claim_Boundary_Principles|Claim Boundary Principles]]
- [[00_System_Brain/Handoff_Minimal_Prompt|Minimal Handoff Prompt]]
- [[00_System_Brain/AI_TASK_PACKET_TEMPLATE_ZH|AI Task Packet Template]]
- [[00_System_Brain/CODEX_EXECUTION_ALIGNMENT_PROTOCOL|Codex Execution Alignment Protocol]]
- [[00_System_Brain/LONGJU_DRIFT_CONTROL_PROTOCOL|Longju Drift Control Protocol]]
- [[00_System_Brain/SACP_MINIMAL_SPEC|SACP Minimal Spec]]
- [[00_System_Brain/SACP_Protocol|SACP Protocol]]

---

## 6. 开源项目文件

- [README](README.md)
- [Contributing](CONTRIBUTING.md)
- [Launch Playbook](LAUNCH_PLAYBOOK.md)
- [Product Boundary](PRODUCT_BOUNDARY.md)
- [Release Checklist](RELEASE_CHECKLIST.md)
- [Scripts](scripts/README.md)
- [License](LICENSE)

---

## Daily Rule

```text
先选入口，再开 AI。
Human decides.
AI executes.
Worklogs remember.
Handoffs coordinate.
Skills evolve.
Markdown stays source of truth.
```
