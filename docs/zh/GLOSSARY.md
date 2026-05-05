# 核心术语表

这份表把项目里的英文名词翻译成人话。

---

## Founder

创始人，也就是最终做决定的人。

AI 可以建议、执行、整理、审查，但不能替 founder 做最终决策。

---

## Founder Decision Log

创始人决策日志。

它记录正式决定，例如：

```text
我们先做 public alpha，不做正式 launch。
```

AI 必须遵守这里的决策。AI worklog 不能覆盖 founder decision。

---

## Founder Thinking Inbox

创始人想法收件箱。

这里可以很乱，用来放：

- 想法
- 担心
- 灵感
- 没想清楚的问题

注意：这里的内容不是正式决策。

---

## AI Employee

AI 员工。

它不是人格设定，而是一个有职责边界的 AI 角色。

例如：

- AI-01 管协调和优先级
- AI-02 管项目真相和验证
- AI-03 管增长和用户
- AI-04 管风险和措辞边界
- AI-05 管学习和解释

---

## START_PROMPT

AI 员工的启动词。

你打开一个新的 AI 聊天窗口时，把对应 AI 的 `START_PROMPT.md` 复制进去。

正式 prompt 保持英文。需要中文回复时，可以追加：

```text
请用中文回复我，但继续遵守上面的英文系统规则。
```

---

## Worklog

工作日志。

AI 完成一次任务后，要留下：

- 读了哪些文件
- 做了什么
- 改了什么
- 没做什么
- 下一个 AI 怎么接
- 哪些地方需要 founder 决策

它的作用是让下一次 AI 不用从零开始。

---

## Handoff

交接。

意思是把当前工作状态交给下一个 AI 或下一次会话。

好的 handoff 应该让别人知道：

```text
现在做到哪了，为什么停在这里，下一步该干什么。
```

---

## Dashboard

状态仪表板。

它不是事实来源，而是快速摘要。

如果 dashboard 和 founder decision log 冲突，以 founder decision log 为准。

---

## MOC

Map of Content，内容地图。

在 Obsidian 里，它像目录和导航中心，帮你不要在文件夹里乱找。

---

## Core

核心系统。

指这个 repo 里真正决定系统行为的英文文件，例如：

- `OBSIDIAN_HOME.md`
- `FIRST_30_MINUTES.md`
- `00_System_Brain/`
- `03_Company/AI_Employees/`
- `03_Company/AI_Worklogs/`

中文文档只解释 Core 怎么用，不维护第二套 Core。
