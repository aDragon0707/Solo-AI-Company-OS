# 能力记忆层

**用途：** 把好用的 AI 工作方式沉淀成可复用能力。

这个文件夹负责让一次成功协作变成下次可复用的工作方法。

循环是：

```text
founder decision -> AI execution -> worklog -> skill -> better future execution
```

Skill 不能覆盖 founder decision。它只是帮助 AI 复用已经证明有用的工作模式。

---

## 什么是 Skill？

Skill 是一个可复用的工作方法。

它应该说明：

- 什么情况下用
- 哪个 AI 员工可以用
- 先读哪些文件
- 按什么步骤做
- 不能假设什么
- 最后怎么汇报

AI employee 不是人，而是一个可复用工作身份。Skill 是这个身份能复用的能力。

---

## 核心文件

- `SKILL_LIBRARY.md`：已有能力库。
- `SKILL_TEMPLATE.md`：新增 skill 的模板。
- `AGENT_SKILL_MATRIX.md`：哪个 AI 身份可以用哪些 skill。
- `WORKLOG_TO_SKILL_PROMPT.md`：让 AI 从 worklog 提炼 skill 的 prompt。

---

## 怎么用

1. 完成一次真实工作。
2. 写 worklog。
3. 问 AI-01 或相关 AI：这个 worklog 里有没有可复用模式？
4. 如果有，用 `WORKLOG_TO_SKILL_PROMPT.md`。
5. 把新 skill 加进 `SKILL_LIBRARY.md`。
6. 在 `AGENT_SKILL_MATRIX.md` 分配给对应 AI。

不要从愿望、想法或模糊聊天总结里创造 skill。Skill 应该来自完成过或明确测试过的工作。

---

## 权威规则

当文件冲突时，顺序是：

1. founder decision log
2. verified project truth
3. current dashboard state
4. AI worklogs
5. skills
6. older drafts or chat history

Skill 可以改善执行，但不能创造权威。

