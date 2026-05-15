---
type: printable_manual
protocol: SACP/0.1
id: printable_core_manual_zh_20260506
status: draft
owner: founder
created_at: 2026-05-06T22:20:00+08:00
updated_at: 2026-05-06T22:20:00+08:00
verification: partial
---

# Solo AI Company OS 黑客松核心教材

## 封面记忆

```text
Human decides.
AI executes.
Worklogs capture experience.
Skills make it reusable.
```

中文：

```text
人做决定。
AI 执行。
工作日志记录经验。
技能让经验复用。
```

这就是整个项目的骨架。

## 1. 这到底是什么？

Solo-AI-Company-OS 不是一个普通 app。

它是一套给人和 AI agent 共同读写的公司操作协议。

你可以把它想成：

```text
一个 solo founder 的 AI 公司文件系统。
```

它让 AI 工作不再散落在聊天窗口里，而是留下四类痕迹：

1. founder decision：人类做过什么决定。
2. worklog：AI 做了什么工作。
3. handoff：下一步交给谁。
4. skill：这次经验能否变成下次可复用能力。

## 2. 为什么需要它？

现在用 AI 做复杂项目，会遇到四个问题：

### 问题 A：聊天记忆会断

一个 agent 今天懂了，明天新窗口又忘了。

### 问题 B：多个 agent 会重复执行

AI-02 已经交接给 AI-03。

另一个 agent 再读到同一条 worklog，可能以为又要执行一次。

### 问题 C：AI 会把推理当事实

它可能把“我猜测完成了”写成“已验证完成”。

### 问题 D：经验不能复用

今天踩坑修好了，下一次还要重新解释。

Solo-AI-Company-OS 的答案是：

```text
把 AI 的工作过程沉淀成文件协议。
```

## 3. SACP 是什么？

SACP = Solo AI Company Protocol。

SACP/0.1 当前不是完整宪法，而是 Dirty Run。

Dirty Run 的意思是：

```text
先用小样例跑通，发现摩擦，再写正式协议。
```

SACP/0.1 验证一个最小判断：

```text
Markdown + YAML frontmatter 是否足够让 Codex / Claude Code / OpenClaw 自然读写？
```

## 4. 为什么是 Markdown + YAML？

因为它同时服务两种读者：

```text
Markdown body 给人看。
YAML frontmatter 给 agent 读。
```

例子：

```yaml
---
type: worklog
protocol: SACP/0.1
id: worklog_20260506_ai02_fixture
agent_id: AI-02
status: completed
handoff_id: handoff_20260506_ai02_to_ai03_fixture
downstream_handoff: AI-03
handoff_status: requested
verification: partial
---
```

人看到的是说明。

AI 看到的是状态。

## 5. 最重要的 handoff 风险

AI 协作里最危险的不是不会做，而是重复做。

坏场景：

```text
AI-02 做完了。
AI-02 写了 completed worklog。
AI-03 应该接手。
另一个 agent 也读到了同一条 worklog。
它也触发 AI-03。
第三个 agent 又触发一次。
同一个任务被重复执行三次。
```

SACP 的第一条安全规则：

```text
status: completed 是事实状态，不是触发事件。
```

第二条：

```text
downstream_handoff 只是交接目标，不是每次读取都触发。
```

第三条：

```text
handoff_id 是任务身份证。
```

## 6. handoff_id 和 attempt_id

### handoff_id

`handoff_id` 表示“这是哪个任务”。

同一个任务重复读取，`handoff_id` 不变。

### attempt_id

`attempt_id` 表示“这是第几次尝试”。

如果 AI-03 超时了，不应该新建 handoff。

正确做法：

```yaml
handoff_id: handoff_abc
attempt_id: attempt_002
```

也就是说：

```text
同一个任务的重试，用新 attempt_id。
真正的新任务，才用新 handoff_id。
```

## 7. receiving worklog 为什么重要？

不要强迫接收方回写原文件。

接收方可以写一条新的 receiving worklog：

```yaml
type: worklog
protocol: SACP/0.1
agent_id: AI-03
status: completed
source_handoff_id: handoff_20260506_ai02_to_ai03_fixture
processed_handoff_ids:
  - handoff_20260506_ai02_to_ai03_fixture
```

这说明：

```text
AI-03 已经接收并处理了这个 handoff。
```

后来的 agent 看到 `source_handoff_id`，就知道不要重复触发。

## 8. 修正版状态机

判断 handoff 时，不以 source worklog 为唯一事实。

真正关键的是 receiving worklog。

```text
source_handoff_id 存在，不等于 completed。
必须看 receiving worklog 自己的 status。
```

状态判断：

```text
completed
  -> dedup skip，不重复触发

processing + active lease
  -> wait，等待 lease_owner

processing + expired lease
  -> retry，同一 handoff_id 下递增 attempt_id

failed / expired / blocked
  -> retry or human decision
```

新建 handoff_id 的条件只有三个：

1. 人类决策改变。
2. 任务输入改变。
3. source_fingerprint 改变。

## 9. Skill 是怎么来的？

AI 完成任务后，不是直接“自我进化”。

它先做一个判断：

```text
ignore | record | distill | promote
```

### ignore

一次性小事，不沉淀。

### record

有价值，写进 worklog。

### distill

可复用，整理成 skill 草稿。

### promote

只有人类批准后，才变成正式能力。

这叫 human promotion gate。

它防止 AI 失控自改。

## 10. 自进化的正确理解

错误理解：

```text
AI 自己安装一堆插件，自己修改自己。
```

正确理解：

```text
AI 从 worklog 中发现可复用模式，起草 skill，人类批准后进入正式能力库。
```

所以我们的自进化公式是：

```text
worklog -> review -> skill draft -> human approval -> reusable skill
```

## 11. 为什么这不是 prompt 模板？

Prompt 模板通常只影响一次对话。

SACP 文件会留下来。

不同 agent、不同窗口、不同时间，都能重新读取。

这就是区别：

```text
prompt 是一次性指令。
SACP 是持久操作记忆。
```

## 12. 为什么不是先做 app？

因为第一阶段要验证协议，而不是包装 UI。

如果 agent 不能稳定读写 Markdown + YAML，做 app 也只是把混乱变漂亮。

当前路线：

```text
先验证轻协议。
再考虑自动化。
最后再考虑产品化。
```

## 13. 黑客松展示主线

三分钟只讲这条：

```text
多个 AI agent 一起工作时，最容易重复触发和丢失经验。
我们用 Markdown + YAML 记录 worklog 和 handoff。
handoff_id 防止重复执行。
attempt_id 处理重试。
worklog 把经验留下。
skill 把经验复用。
human promotion gate 防止自进化失控。
```

## 14. 你必须能回答的 5 个问题

### Q1：你做的是什么？

```text
一个 agent-readable company operating protocol。
它让 AI 员工留下决策、工作日志、交接记录和可复用技能。
```

### Q2：解决什么问题？

```text
解决 AI 工作散在聊天窗口、多 agent 重复执行、交接不清、经验无法复用的问题。
```

### Q3：为什么不用数据库？

```text
第一步验证协议，不验证平台。
Markdown + YAML 足够轻，也方便人类审查。
```

### Q4：自进化会不会失控？

```text
不会默认失控。
AI 可以 record 和 distill，但 promote 必须由人批准。
```

### Q5：完成度如何？

```text
现在是 SACP/0.1 Dirty Run。
已经有 fixture、skill、worklog 闭环。
没有宣称完整 release 或 autonomous runtime。
```

## 15. 打印后每天怎么学

### Day 1

背四词循环：

```text
决定、执行、记录、复用。
```

练 90 秒版本。

### Day 2

理解三个字段：

```text
handoff_id
source_handoff_id
attempt_id
```

跑教学脚本。

### Day 3

练追问。

只讲已经验证的 Dirty Run，不夸大。

## 最后一页：上台底气

你不需要把每个技术词讲深。

你要让评委看到：

```text
这个项目不是在堆 prompt。
它在解决 AI 员工如何留下组织记忆的问题。
```

这就是它的价值。

