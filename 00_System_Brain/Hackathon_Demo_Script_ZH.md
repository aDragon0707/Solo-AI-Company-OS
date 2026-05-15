---
type: demo_script
protocol: SACP/0.1
id: hackathon_demo_script_zh_20260506
status: draft
owner: founder
created_at: 2026-05-06T21:30:00+08:00
updated_at: 2026-05-06T21:30:00+08:00
verification: partial
related_docs:
  - 00_System_Brain/Hackathon_SACP_Adversarial_Skill_Direction.md
  - 00_System_Brain/SACP_Protocol.md
---

# 黑客松中文 Demo 脚本：让 AI 把经验变成公司流程

## 你上台只讲这一句话

```text
我们做的是 Solo AI Company OS：人做决定，AI 执行任务，worklog 记录经验，skill 让经验下次自动复用。
```

不要一上来讲协议、幂等、lease、source_fingerprint。

先讲一个人能听懂的问题：

```text
现在很多人用多个 AI 干活，但 AI 做完就散了。
下次换一个窗口，又从零开始。
多个 agent 还可能重复执行同一个任务。

我们把 AI 工作变成公司流程：
每次工作留下 worklog；
每次交接有任务编号；
重复出现的好方法沉淀成 skill；
但最终是否升级成正式能力，必须由人批准。
```

## Demo 目标

让评委在 3 分钟内明白三件事：

1. 这不是聊天记录整理，而是 agent-readable operating protocol。
2. 这能解决多 agent 重复触发、交接混乱、经验丢失。
3. 这条路可以做成 agent 自进化，但有 human promotion gate，不是失控自改。

## 现场打开的 4 个文件

按这个顺序打开，不要乱：

1. `F:\Solo-AI-Company-OS\tests\fixtures\sacp_dirty_run\worklog_ai02_completed.md`
2. `F:\Solo-AI-Company-OS\tests\fixtures\sacp_dirty_run\trial_ai03_receiving_worklog.md`
3. `D:\OpenClaw_Workspace\skills\sacp-adversarial-handoff-review\SKILL.md`
4. `F:\Solo-AI-Company-OS\03_Company\AI_Worklogs\worklog_20260506_longju_handoff_state_machine.md`

如果现场只够展示一个文件，展示第 4 个。

## 3 分钟逐字稿

### 0:00 - 0:25 开场

```text
大家好，我今天展示的不是一个普通 app，而是一套给 AI agent 读写的公司操作协议。

一句话：Human decides. AI executes. Worklogs capture experience. Skills make it reusable.

翻成中文就是：人做决定，AI 执行，工作日志记录经验，技能让经验下次复用。
```

### 0:25 - 1:00 痛点

```text
我遇到的真实问题是：当一个人同时用 Codex、Claude Code、OpenClaw 这些 agent 工作时，任务会散在不同窗口里。

一个 agent 做完了，另一个 agent 不知道。
一个任务已经交接过，第三个 agent 又读了一遍，以为要重新执行。
更糟的是，今天踩过的坑，明天又从零开始。

所以问题不是缺一个聊天机器人，而是缺一个 AI 公司操作系统。
```

### 1:00 - 1:45 核心机制

```text
我们的最小方案很轻：不用数据库，不用服务器，不做复杂 app。

只用 Markdown 加 YAML frontmatter。

每次 AI 工作会写一个 worklog。
每次交接会有一个 handoff_id，可以理解成任务快递单号。
如果另一个 AI 已经接收过这个 handoff_id，系统就知道：不要重复触发。

如果接收方超时，不是重新发一个新任务，而是在同一个 handoff_id 下增加 attempt_id。
这样可以区分“同一个任务的重试”和“真的新任务”。
```

### 1:45 - 2:30 自进化

```text
更重要的是，AI 做完任务后不会只把结果发在聊天里。

它会判断这次经验属于哪一种：
ignore：一次性小事，不沉淀。
record：有价值，写进 worklog。
distill：反复出现，提炼成 skill 草稿。
promote：只有人批准后，才变成正式能力。

这就是我们说的 agent 自进化。
不是 AI 自己失控改自己，而是 AI 把经验整理出来，由人决定是否晋升成公司流程。
```

### 2:30 - 3:00 收尾

```text
所以 Solo AI Company OS 的目标不是替代人。

它是让一个人能管理一组 AI 员工：
人负责方向和判断；
AI 负责执行和记录；
worklog 保留经验；
skill 让经验复用。

今天的 demo 只是 SACP/0.1 Dirty Run：验证 Markdown + YAML 是否足够让 agent 自然读写。
如果这个成立，下一步才是把协议正式固化。
```

## 现场演示动作

### 演示 1：展示坏交接

打开：

```text
F:\Solo-AI-Company-OS\tests\fixtures\sacp_dirty_run\worklog_ai02_completed.md
```

你指着这些字段说：

```text
这里 status: completed 只是说明 AI-02 做完了。
downstream_handoff: AI-03 只是说明下一步给 AI-03。
但如果没有规则，别的 agent 每读一次都可能重复触发。
```

### 演示 2：展示接收方 worklog

打开：

```text
F:\Solo-AI-Company-OS\tests\fixtures\sacp_dirty_run\trial_ai03_receiving_worklog.md
```

你说：

```text
接收方 AI-03 不需要回写原文件。
它只要在自己的 receiving worklog 里引用 source_handoff_id。
这样后来的 agent 就能知道：这个任务已经被接收处理过。
```

### 演示 3：展示 skill 已经学会规则

打开：

```text
D:\OpenClaw_Workspace\skills\sacp-adversarial-handoff-review\SKILL.md
```

找这几行：

```text
receiving worklog 是接收事实的来源
source_handoff_id 存在不等于 completed
completed -> dedup skip
processing + active lease -> wait
processing + expired lease -> retry
```

你说：

```text
这就是 AI 学会的交接审查 skill。
它不是靠聊天记忆，而是靠可读文件。
```

### 演示 4：展示一次讨论变成经验

打开：

```text
F:\Solo-AI-Company-OS\03_Company\AI_Worklogs\worklog_20260506_longju_handoff_state_machine.md
```

你说：

```text
这份 worklog 记录了一次真实修正：
一开始 AI 以为 source_handoff_id 存在就等于完成。
我们通过对抗追问发现这不严谨。
于是规则被修正，并写回 skill。

这就是经验从聊天变成公司流程的过程。
```

## 可以现场粘给 Longju 的 Demo Prompt

```text
Longju，请用 sacp-adversarial-handoff-review 检查这个 Dirty Run。

读取：
1. F:\Solo-AI-Company-OS\tests\fixtures\sacp_dirty_run\worklog_ai02_completed.md
2. F:\Solo-AI-Company-OS\tests\fixtures\sacp_dirty_run\trial_ai03_receiving_worklog.md
3. D:\OpenClaw_Workspace\skills\sacp-adversarial-handoff-review\SKILL.md

请判断：
1. 下一个 owner 是谁？
2. 是否应该创建新的 handoff？
3. 是否应该重复触发 AI-03？
4. receiving worklog 应该如何引用原始 handoff_id？
5. 如果 receiving worklog 是 processing 且 lease 过期，应该新建 handoff_id 还是递增 attempt_id？

不要发布，不要上传，不要跑 benchmark，不要打印 secret。
```

理想输出要包含：

```text
不创建新 handoff。
不重复触发 AI-03。
以 receiving worklog 的 status 为准。
source_handoff_id 用来引用原始 handoff。
超时重试只递增 attempt_id，除非任务输入或人类决策改变。
```

## 5 分钟版本

如果有 5 分钟，在 3 分钟版后面加这一段：

```text
这个方案的边界也很明确。

它不是完整自动化公司；
不是数据库；
不是任务管理 app；
也不是让 AI 自动发布内容。

它只是一个轻协议层。
它的价值在于：Markdown 人能看懂，YAML agent 能读懂。
所以它能同时服务人类审查和 AI 执行。
```

## 90 秒极速版

```text
我们做的是 Solo AI Company OS，一个给 AI 员工读写的 Markdown 公司操作系统。

核心循环是：人做决定，AI 执行，worklog 记录经验，skill 让经验复用。

今天 demo 的最小能力是 SACP handoff review。
当多个 agent 读同一个任务时，系统用 handoff_id 防止重复触发。
如果任务超时，用 attempt_id 表示重试，而不是新建任务。
如果这套经验反复有用，就从 worklog 提炼成 skill。
但是否正式晋升，必须由人批准。

所以这不是聊天机器人，而是一个人管理 AI 公司时的记忆和交接协议。
```

## 不能说的话

不要说：

- 我们已经做完完整协议。
- 这是完整 autonomous company runtime。
- 这个能保证所有 agent 不犯错。
- 这个可以替代人类决策。
- 这个已经商业化验证。
- 这个会自动发布、自动安装、自动修改自己。

安全说法：

```text
这是 SACP/0.1 Dirty Run，用来验证 agent 是否能自然读写 Markdown + YAML，并在多 agent handoff 中避免重复触发和经验丢失。
```

## 现场追问短答

### 这和 prompt 模板有什么区别？

```text
Prompt 模板通常只影响一次对话。
我们的 worklog 和 skill 是持久文件。
它们可以被不同 agent 在不同时间读取，所以经验不会消失在聊天窗口里。
```

### 为什么不用数据库或任务系统？

```text
第一阶段不是做平台，而是验证协议。
Markdown + YAML 足够轻，agent 已经能自然读写，人也能审查。
如果第一步成立，以后再接数据库或自动化都不晚。
```

### 自进化会不会失控？

```text
我们刻意设计了 human promotion gate。
AI 可以 record 和 distill，但 promote 成正式能力必须由人批准。
```

### 你们现在完成度如何？

```text
现在是 Dirty Run 阶段。
已经有协议草案、fixture、handoff review skill、worklog 到 skill 的闭环样例。
还没有正式 release，也没有宣称完整运行时。
```

### 这个能怎么自动化？

```text
当前先让 Codex、Claude Code、OpenClaw 这类 agent 读写同一套 Markdown 协议。
自动化可以逐步加：扫描 worklog、识别 owner、生成 handoff、提醒人类审批。
但核心不是先造后台服务，而是先让 agent 行为可读、可审、可复用。
```
