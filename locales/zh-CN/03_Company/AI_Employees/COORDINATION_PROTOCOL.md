# AI 员工协作规则

<!-- locale: zh-CN -->

**用途：** 让不同 AI 窗口交接时不靠猜。

每个 AI 员工都要记住：

```text
Founder 做决策。
AI 做执行。
Worklog 留下过程。
Handoff 让下一个 AI 接得住。
```

---

## 1. 先看哪个文件

如果文件之间冲突，按这个顺序判断：

| 优先级 | 文件或来源 |
|---:|---|
| 1 | founder 最新明确决定 |
| 2 | `01_Founder/FOUNDER_Decision_Log.md` |
| 3 | verified project truth |
| 4 | `02_Dashboards/DASHBOARD_Company_State.md` |
| 5 | `03_Company/AI_Worklogs/WORKLOG_INDEX.md` |
| 6 | `03_Company/AI_Employees/*/ROLE.md` |
| 7 | skills、旧草稿、旧聊天 |

Dashboard 是当前状态摘要，不是最高权威。

Worklog 记录做过什么，但不能覆盖 founder decision。

Skill 帮助执行，也不能覆盖 founder decision 或 verified project truth。

---

## 2. 每次交接必须写清楚

如果一个 AI 要把任务交给另一个 AI，用这个格式：

```text
Handoff To:
Reason For Handoff:
Current State:
Files Read:
Files Changed:
Verification Status:
Known Gaps:
Next AI Needs:
Do Not Assume:
Founder Decision Needed:
```

如果没有这些信息，下一个 AI 不应该假装知道发生了什么。

正确做法是问 AI-01 或 founder 补上下文。

---

## 3. 谁负责什么

| AI | 主要负责 | 不能负责 |
|---|---|---|
| AI-01 | 优先级、分工、dashboard、handoff | founder 最终决定 |
| AI-02 | 项目事实、构建、验证、source truth | 未经审查的市场结论 |
| AI-03 | 用户、增长、对外材料、pipeline | 技术事实来源 |
| AI-04 | claim boundary、风险、敏感表达 | 客户承诺 |
| AI-05 | founder 学习、架构解释、作业批改 | 未经 AI-02 审查的生产改动 |

---

## 4. 最小交接格式

```text
Handoff To: AI-XX
Reason:
Input Files:
Required Output:
Verification Required:
Cannot Do:
Priority:
Deadline or Window:
Founder Decision Needed:
```

---

## 5. 完成标准

任务结束时，负责的 AI 必须说明：

- 做了什么
- 验证了什么
- 还不确定什么
- 改了哪些文件
- 下一个 AI 或 founder 要做什么
- 是否需要写 worklog

没有 worklog，就没有长期公司记忆。
