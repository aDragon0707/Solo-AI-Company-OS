---
type: handbook
protocol: SACP/0.1
id: hackathon_study_handbook_zh_20260506
status: draft
owner: founder
created_at: 2026-05-06T21:30:00+08:00
updated_at: 2026-05-06T21:30:00+08:00
verification: partial
related_docs:
  - 00_System_Brain/Hackathon_Demo_Script_ZH.md
  - 00_System_Brain/Hackathon_SACP_Adversarial_Skill_Direction.md
---

# 黑客松专项讲解手册：三天啃下 Solo AI Company OS

## 先稳住：你不用懂所有技术

这套项目上台时不是考你讲底层实现。

你只需要把主线讲清楚：

```text
一个人如何管理一组 AI 员工？

答案：
人做决定。
AI 执行任务。
worklog 记录经验。
skill 让经验复用。
```

评委真正要听的是：

1. 你解决了什么真实问题？
2. 为什么现在的 agent 工作方式不够？
3. 你的最小 demo 能不能跑通？
4. 这个方向有没有继续扩展的空间？

## 项目一句话

```text
Solo-AI-Company-OS 是一个 Markdown 轻协议层，让 AI agent 像公司员工一样留下决策、工作日志、交接记录和可复用技能。
```

## 你要背下来的四个词

### 1. Decide

人类决定方向。

AI 不替代 founder，不偷偷改战略，不把自己的推理当成事实。

### 2. Execute

AI 执行具体任务。

比如写代码、整理资料、审查 handoff、生成 worklog、起草 skill。

### 3. Record

AI 做完要留下 worklog。

worklog 不是总结文学，而是可被下一个 agent 读取的操作记录。

### 4. Reuse

重复出现的好方法变成 skill。

但 skill 晋升必须经过 human promotion gate。

## 核心术语翻译成人话

| 术语 | 人话解释 | 上台说法 |
|---|---|---|
| SACP | Solo AI Company Protocol | AI 公司之间共享的最小交接协议 |
| worklog | 工作日志 | AI 做完事留下的可读记录 |
| handoff | 交接 | 一个 AI 把下一步交给另一个 AI |
| handoff_id | 任务快递单号 | 防止重复执行的任务编号 |
| source_handoff_id | 原始任务引用 | 接收方说明自己处理的是哪个任务 |
| attempt_id | 第几次尝试 | 区分重试和新任务 |
| lease | 临时占用权 | 防止两个 agent 同时抢同一任务 |
| source_fingerprint | 输入指纹 | 判断任务内容有没有真的变 |
| skill | 可复用技能 | 从经验里沉淀出来的操作方法 |
| distill | 蒸馏 | 把一次经验整理成 skill 草稿 |
| promote | 晋升 | 人批准后变成正式能力 |
| dirty run | 脏跑实验 | 先用小样例发现问题，不急着写完整宪法 |

## 项目的三层结构

### 第一层：Solo AI Company OS

这是大愿景。

它回答：

```text
一个人怎么带一组 AI 员工长期工作？
```

包含：

- founder decisions
- AI employee roles
- worklogs
- handoffs
- skills
- dashboards

### 第二层：SACP/0.1

这是轻协议。

它回答：

```text
不同 AI 怎么读同一批 Markdown 文件，不重复干活？
```

当前重点字段：

```yaml
type: worklog
protocol: SACP/0.1
status: completed
handoff_id: handoff_abc
source_handoff_id: handoff_abc
attempt_id: attempt_001
```

### 第三层：sacp-adversarial-handoff-review

这是黑客松 demo 的主角。

它回答：

```text
给我一组乱糟糟的 worklog 和 handoff，我怎么判断下一步谁做、要不要重复触发、是否要重试、是否能沉淀成 skill？
```

## 为什么我们的项目不单薄

表面看是 Markdown 文件。

实际背后有四个能力：

1. 记忆：worklog 让 AI 工作不丢失。
2. 协作：handoff_id 让多 agent 不重复触发。
3. 审查：adversarial review 让 AI 区分事实、推理和未知。
4. 自进化：skill distillation 让经验变成可复用能力。

你可以这样讲：

```text
我们没有先造一个大平台，而是先验证 agent 能不能读写最小协议。
如果这个最小协议成立，后面可以接 OpenClaw、Codex、Claude Code，也可以接自动化扫描和 dashboard。
```

## 为什么参加 BotLearn/黑客松合理

黑客松主题如果是 agent 进化，我们的切入点很合适：

```text
大多数自进化都在讲让 agent 学新工具。
我们讲的是：agent 学到经验后，怎么安全地变成组织能力。
```

这有一个更成熟的表达：

```text
Agent self-evolution needs memory, review, and human promotion.
```

中文：

```text
AI 自进化不能只靠自动安装技能。
它还需要记忆、审查和人类晋升门禁。
```

## 三天学习计划

### Day 1：只啃故事和 demo

目标：能讲 3 分钟，不看稿也不崩。

读：

1. `F:\Solo-AI-Company-OS\00_System_Brain\Hackathon_Demo_Script_ZH.md`
2. `F:\Solo-AI-Company-OS\README.md`
3. `F:\Solo-AI-Company-OS\00_System_Brain\Hackathon_SACP_Adversarial_Skill_Direction.md`

练：

1. 用自己的话讲四词循环：决定、执行、记录、复用。
2. 打开四个 demo 文件，按顺序讲一遍。
3. 录一遍 3 分钟音频，听哪里卡。

今天必须会答：

```text
你做的是什么？
解决什么问题？
为什么不是普通 prompt？
```

### Day 2：啃机制和追问

目标：评委问技术细节时，你不慌。

读：

1. `F:\Solo-AI-Company-OS\00_System_Brain\SACP_Protocol.md`
2. `D:\OpenClaw_Workspace\skills\sacp-adversarial-handoff-review\SKILL.md`
3. `F:\Solo-AI-Company-OS\03_Company\AI_Worklogs\worklog_20260506_longju_handoff_state_machine.md`

必须搞懂：

1. `status: completed` 不是触发事件。
2. `handoff_id` 是任务编号。
3. `source_handoff_id` 是接收方引用原任务。
4. 超时重试用 `attempt_id`，不是新建任务。
5. skill 晋升必须人批准。

练：

用这句话解释技术细节：

```text
handoff_id 解决重复触发，attempt_id 解决超时重试，human promotion gate 解决自进化失控。
```

### Day 3：啃展示、问答和备份

目标：上台材料完整，有备用方案。

准备：

1. 一个 3 分钟版本。
2. 一个 90 秒版本。
3. 一个 5 分钟版本。
4. 一个无需网络的本地文件演示。
5. 一个评委追问回答库。

检查：

1. 四个 demo 文件都能打开。
2. Longju 能回答 handoff review prompt。
3. 没有泄露 API key、token、客户数据、私有 founder 内容。
4. 不承诺正式 release，不承诺完整 autonomous runtime。

## 你要会讲的 5 个场景

### 场景 1：重复触发

```text
一个 agent 已经把任务交给 AI-03。
另一个 agent 又读到这个 completed worklog。
如果没有 handoff_id，它可能再交一次。
有 handoff_id 后，系统知道这是不是同一个任务。
```

### 场景 2：接收方已经做了

```text
接收方 AI-03 写了 receiving worklog，并引用 source_handoff_id。
后来再读到原任务，就知道不要重复触发。
```

### 场景 3：接收方超时

```text
如果 AI-03 卡住，不是新建一个任务。
还是同一个 handoff_id，但增加 attempt_id。
这样历史链不断，审查也清楚。
```

### 场景 4：经验变成 skill

```text
一次经验先 record。
如果重复出现，就 distill 成 skill 草稿。
但只有人批准，才 promote 成正式能力。
```

### 场景 5：复杂计算

```text
如果任务涉及复杂数学或统计，Longju 不能心算。
它必须选择 Python、scipy、decimal、fractions 等工具。
如果缺 sympy/mpmath，就必须承认只能数值验证，不能当成证明。
```

## 评委追问回答库

### Q1：你这个是不是就是 Obsidian 模板？

```text
不是。
Obsidian 是人看的知识库。
我们强调的是 agent-readable：Markdown 给人看，YAML frontmatter 给 AI 读。
核心不是页面好看，而是 AI 能根据字段判断 owner、handoff、retry 和 skill evolution。
```

### Q2：为什么不做 app？

```text
因为现在最重要的不是 UI，而是协议是否成立。
如果 agent 连最小 Markdown 协议都读不稳，做 app 也只是把混乱包装起来。
我们先验证最小协议，再考虑产品化。
```

### Q3：你们的 moat 是什么？

```text
不是某个字段，而是完整闭环：
worklog 记录经验；
handoff 防重复协作；
adversarial review 防止假完成；
skill distillation 把经验复用；
human gate 控制自进化。
```

### Q4：这和多 agent 框架有什么关系？

```text
很多多 agent 框架负责运行 agent。
我们负责 agent 之间的组织记忆和交接纪律。
可以接到 Codex、Claude Code、OpenClaw 或其他框架上。
```

### Q5：自进化怎么体现？

```text
自进化不是 AI 偷偷改自己。
我们的定义是：AI 从 worklog 中发现可复用模式，起草 skill，人类批准后进入正式能力库。
```

### Q6：如果 AI 写错 worklog 怎么办？

```text
所以我们有 adversarial review 和 evidence boundary。
AI 必须区分 verified fact、tool result、model inference、unknown。
不能把推理伪装成事实。
```

### Q7：这能自动化到什么程度？

```text
第一步是手动 Dirty Run。
第二步可以让 agent 自动扫描 handoff。
第三步可以接定时任务或 dashboard。
但发布、晋升 skill、对外动作仍然由人批准。
```

### Q8：为什么这个适合 solo founder？

```text
因为 solo founder 最大的问题不是没人聊天，而是 AI 工作没有组织记忆。
这个 OS 让一个人也能有类似公司里的决策、执行、交接、复盘和能力沉淀。
```

## 你不要主动讲的高级词

这些可以藏起来，评委追问再讲：

- idempotency
- lease
- source_fingerprint
- YAML frontmatter parser
- mpmath / sympy
- non-parametric statistics
- evidence ledger

如果必须讲，就翻译：

| 高级词 | 中文说法 |
|---|---|
| idempotency | 同一个任务读很多次，也只执行一次 |
| lease | 某个 AI 临时接手任务的占用权 |
| source_fingerprint | 判断任务输入有没有变的指纹 |
| evidence boundary | 哪些是事实，哪些只是 AI 推理 |
| non-parametric | 不强行假设数据符合正态分布 |

## 现场风险和备份

### 如果网络挂了

不用演 BotLearn。

只演本地文件：

1. bad worklog
2. receiving worklog
3. skill review rules
4. corrected worklog

### 如果 Longju 不听话

直接展示文件，不现场生成。

说：

```text
现场 agent 输出不是重点。
重点是协议文件已经 agent-readable，输出可以被复查。
```

### 如果有人质疑太早期

回答：

```text
对，所以我们明确叫 Dirty Run。
我们没有假装完成完整协议。
黑客松阶段就是验证最小闭环：worklog -> review -> skill。
```

## 三天结束时你的验收标准

你能做到下面这些，就够上台：

1. 90 秒说清项目。
2. 3 分钟完整讲 demo。
3. 说清 worklog、handoff_id、skill、human promotion gate。
4. 打开四个文件演示一遍。
5. 回答“这和 prompt 有什么区别”。
6. 回答“自进化会不会失控”。
7. 知道不能过度承诺完整 runtime 或正式 release。

## 最后记忆卡片

```text
不是聊天机器人。
不是任务 app。
不是完整自动公司。

这是 AI 公司操作协议的第一步：
让 AI 工作可记录、可交接、可审查、可复用。

Human decides.
AI executes.
Worklogs capture experience.
Skills make it reusable.
```
