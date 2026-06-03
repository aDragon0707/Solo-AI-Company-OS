# Solo-AI-Company-OS 中文入口

> 一个给 solo founder 的 Markdown 公司大脑。
> 用来管理 AI 员工、记录决策、留下 worklog、完成 handoff，并把有用的方法沉淀成 skill。

如果你已经开始用 AI 写代码、做项目、跑多个窗口，你大概率会遇到这些问题：

- 🤯 聊天记录太多，过两天自己都忘了为什么这么做；
- 🤖 不同 AI 窗口互相不知道对方干过什么；
- 📝 任务做完了，但没有留下 worklog，下次只能重新解释；
- 🔁 同一个流程反复教 AI，经验没有沉淀；
- 🧪 AI 说“完成了”，但你不知道有没有证据。

Solo-AI-Company-OS 想解决的不是“让 AI 更聪明”。

它想解决的是：

> 怎么让一个人，也能像管理一个小团队一样，管理自己的 AI 协作。

![Solo-AI-Company-OS 产品地图](../../assets/solo-ai-company-os-home.zh-CN.svg)

---

## 先别读完整架构

第一次只跑一个小闭环：

1. 写下一条明确的任务目标。
2. 从 [AI 员工派工台](../../03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md) 选一个 AI 员工。
3. 复制对应的 `START_PROMPT.md` 到聊天窗口。
4. 任务结束后，用 `scripts/new-worklog.ps1` 生成一条 worklog 草稿。

跑完这四步，你就已经开始拥有自己的 AI 公司记忆了。

---

## 这个系统里有什么？

```text
人做决策。
AI 做执行。
Worklog 留下记忆。
Handoff 负责接力。
Skill 复用经验。
Doctor 检查风险。
Markdown 保存协作真相。
```

| 模块 | 它负责什么 |
|---|---|
| 🧭 Founder Decision Log | 记录人的判断、取舍和原因 |
| 🤖 AI Employees | 给不同 AI 员工分配职责和边界 |
| 📝 Worklogs | 留下任务过程、结果、证据和遗留问题 |
| 🔁 Handoffs | 让不同窗口、不同 agent 可以接着干 |
| 🧰 Skills | 把验证过的方法沉淀成可复用能力 |
| 📊 Dashboards | 快速看见项目状态 |
| 🩺 AgentOps Doctor | 检查上下文、证据、claim 和协作风险 |

这不是一个 prompt collection。
它更像一个用 Markdown 搭起来的 AI 协作操作台。

---

## 你现在想做什么？

| 我想要 | 去这里 |
|---|---|
| 第一天跑通一次 | [Day-1 中文用户路径](DAY_1_CHINESE_USER_PATH.md) |
| 快速开始 | [快速上手](QUICKSTART.md) |
| 看一次完整例子 | [第一次运行示例](FIRST_RUN_EXAMPLE.md) |
| 选择 AI 员工 | [AI 员工派工台](../../03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md) |
| 理解核心概念 | [核心术语表](GLOSSARY.md) |
| 知道它为什么存在 | [为什么这不是 prompt collection](WHY_THIS_EXISTS.md) |

---

## 给谁用？

这个项目适合你，如果你：

- 正在用 AI 写代码、做产品、做内容或跑个人项目；
- 经常同时开 Claude Code、Codex、Cursor、Gemini 或多个聊天窗口；
- 发现 AI 很强，但上下文、记录、交接、验证经常失控；
- 想把 AI 当成一组可以管理的“员工”，而不是一次性聊天工具。

如果你只是想找几个 prompt，这个项目可能太重了。
如果你想长期管理自己的 AI 工作流，它会越来越有用。

英文根目录 README 负责 GitHub 国际传播；中文文档负责中文用户现场和日常使用。
