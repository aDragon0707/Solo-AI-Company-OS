# 第一次运行示例

这是一个虚构示例，帮助你理解第一轮该怎么跑。

---

## 场景

你刚生成了一个 vault，项目叫：

```text
Example AI Workspace
```

你现在不知道该先看哪个文件，也不知道怎么让 AI 接上系统。

---

## 第一步：写一条 founder decision

打开：

```text
01_Founder/FOUNDER_Decision_Log.md
```

写入：

```text
## DEC-20260505-001 - Establish AI Operating Boundaries

Date: 2026-05-05
Status: active
Decision Owner: Founder

Decision:
AI can help execute, organize, review, and maintain work, but founder decisions remain the source of authority.

Why:
The system needs a clear boundary between AI output and founder judgment.

AI Impact:
- AI must read founder decisions before work.
- AI worklogs do not override founder decisions.
- AI must mark uncertainty instead of guessing.
```

意思是：

```text
AI 可以干活，但最终判断归人。
```

---

## 第二步：启动 AI-01

打开：

```text
03_Company/AI_Employees/AI-01_Founder_Office/START_PROMPT.md
```

复制英文 prompt 到 AI 聊天窗口。

然后追加：

```text
请用中文回复我，但继续遵守上面的英文系统规则。
```

再追加这个任务：

```text
AI-01，请阅读 founder decision log、OBSIDIAN_HOME、company state dashboard、AI text maintenance protocol、worklog index。

请告诉我：
1. 让这个 vault 变得有用的前三个优先级
2. 当前 blockers
3. 还缺哪些 founder decisions
4. 下一步我应该更新哪个文件
5. 本次会话后应该创建什么 worklog

不要虚构业务进展。只当作 Day 1 setup。
```

---

## 第三步：更新 dashboard

打开：

```text
02_Dashboards/DASHBOARD_Company_State.md
```

只更新你确定的内容。

例如：

```text
Current priority: Complete Day 1 setup loop
Current blocker: Founder has not yet customized AI role prompts
Next founder decision needed: Which project should AI-01 coordinate first?
Next AI owner: AI-01
```

不知道的地方写：

```text
not yet verified
```

---

## 第四步：保存 worklog

复制：

```text
03_Company/AI_Worklogs/WORKLOG_TEMPLATE.md
```

新建：

```text
03_Company/AI_Worklogs/AI-01_Worklog_20260505_First_Coordination.md
```

记录：

```text
Files Read:
- 01_Founder/FOUNDER_Decision_Log.md
- OBSIDIAN_HOME.md
- 02_Dashboards/DASHBOARD_Company_State.md
- 00_System_Brain/AI_Text_Maintenance_Protocol.md
- 03_Company/AI_Worklogs/WORKLOG_INDEX.md

Work Completed:
- Reviewed Day 1 setup state.
- Identified first priorities.
- Recommended dashboard update.

Not Completed:
- No business work completed.
- No customer promises made.
- No project evidence verified.

Needs Founder:
- Choose first real project priority.
```

---

## 第五步：停下来

第一轮不用做更多。

你已经完成了：

```text
决策 -> AI 协调 -> 状态更新 -> 工作交接
```

这就是 Solo-AI-Company-OS 的最小使用方式。
