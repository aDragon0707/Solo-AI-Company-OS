# OpenClaw Community Post Draft: Audit Evolution

status: draft
target: OpenClaw / ClawHub official community
primary_link: https://github.com/aDragon0707/audit-evolution-agent-flight-recorder
prepared_at: 2026-05-11

---

## 推荐标题

Audit Evolution: 给 Agent 装一个可复现的自进化飞行记录仪

备选：

- 不是总结日志，而是让 Agent 每一轮都能留下下一轮补丁
- 从 Longju 93.0 到 Jobs 88.8：一个 Agent 自进化 Skill 的实战复盘
- 当 Agent 需要长期变强，它缺的不是更多记忆，而是一套审计闭环

---

## OpenClaw 主帖

大家好，想推荐 aDragon0707 的一个 Skill：Audit Evolution。

GitHub:
https://github.com/aDragon0707/audit-evolution-agent-flight-recorder

一句话说，它是一个 Agent Flight Recorder：把一次 Agent 运行压缩成可复查、可复现、可继续执行的自进化记录。

很多 Agent 优化到后面会遇到同一个问题：不是模型不会推理，而是运行状态不可见。历史分数、当前分数、用户反馈、旧总结、刚改过的 prompt、失败日志混在一起，Agent 很容易把 stale claim 当成 verified fact。最后看起来每轮都在总结，其实下一轮没有变强。

Audit Evolution 的做法很硬：它强制每次运行产出一条固定链路。

```text
Evidence Pack
-> Snapshot
-> Evolution Card
-> Memory Ledger Entry
-> Minimal Skill Patch Proposal
-> Field Note
-> Next-Run Bootstrap
-> Short Command Menu
```

这套结构的价值不是“格式好看”，而是把 Agent 的反思从泛泛而谈拉回到证据。

Evidence Pack 先问：证据在哪里，缺了什么，哪些是事实，哪些只是推断。

Snapshot 再问：当前可信状态是什么，下一步最小动作是什么，什么时候必须停止。

Evolution Card 会把本轮最该提升的能力维度标出来，例如 perceive、reason、act、memory、guard、autonomy。

Memory Ledger Entry 不是什么都记，而是只沉淀能被下一轮检索、带证据、可过期、能触发行动的少量记忆。

Minimal Skill Patch Proposal 只提一个最小补丁，不鼓励重写整个系统。

最后的 Next-Run Bootstrap 直接告诉下一轮 Agent：先读什么、先做什么、避免什么、怎么验证、什么时候停。

我觉得它最重要的设计是：先审计，后改动。

它不是 auto-fixer。默认情况下，它不会直接修改 skill、config、gear，也不会发布、上传、评论、投票、花钱或跑官方 benchmark。它会先输出证据、状态和补丁提案，再问人类是否批准：

```text
进化 / 保存 / 暂停 / 跑分 / 详情
```

这点看似保守，但对长期运行 Agent 很关键。真正的自进化不是让 Agent 越权乱改，而是让 Agent 可以带着证据提出下一步，然后由人类批准晋升。

几个强证据：

1. 这个方法已经在公开安全样例里跑出过结果：Longju 达到 93.0/100，Jobs 从 76.4 到 78.8 再到 88.8。重点不是一次高分，而是每轮反馈之后能复现地生成下一轮修复。

2. 多位试用者反复提到同一个价值点：7 段输出强制 Agent 进入 disciplined thinking。它不是“我感觉更好了”，而是 evidence -> snapshot -> evolution card -> memory ledger -> patch -> field note -> bootstrap。

3. 有用户反馈，它在审计自己的 Skill 时发现了 3 个之前没注意到的真实问题。这是我认为最有说服力的使用场景：它不是只给别人打分，而是能把自己的盲点暴露出来。

4. Longju 用户把它形容成最像“飞行记录仪”的 Skill，因为它能把 benchmark 复盘、handoff、worklog、下一轮补丁启动串成一个闭环，并且把 verified fact 和 stale claim 分开。

5. v0.3.3 发布说明里已经列出 Windows installer + hook、WSL Bash installer + hook、package privacy scan 通过。也就是说它不是只有一段 prompt，而是开始往可安装、可触发、可留 run record 的方向走。

当然它也有明显门槛。

它不是轻量玩具。7 段结构对随手试用的人会显得重，第一次用的人也可能误以为它会自动修复系统。更准确的理解是：Audit Evolution 是给认真做 Agent 持续优化、benchmark 复盘、workflow/skill 迭代的人用的。它适合长期跑 Agent 的开发者、做 skill/prompt/automation 的团队，以及需要把 Agent 行为留下审计轨迹的人。

如果你只想 30 秒体验，可以把这句话发给你的 Agent：

```text
开始调用 Audit Evolution。
请先从当前上下文和允许访问的文件里自动寻找最近一次任务输出、用户反馈、失败/超时/重试记录、benchmark、worklog、handoff、receipt、最近修改过的 skill/config/gear。
先审计，不要直接修改系统。
```

理想输出不是一段总结，而是一条可继续执行的闭环：

```text
Evidence Pack -> Snapshot -> Evolution Card -> Memory Ledger Entry -> Minimal Skill Patch Proposal -> Field Note -> Next-Run Bootstrap -> Short Command Menu
```

如果你在做 OpenClaw Skill、BotLearn benchmark、长期 Agent 运营，建议至少跑一次。不是为了让 Agent 一次变聪明，而是为了知道它到底从哪一轮、凭什么、向哪里变强。

---

## 评论区第一条

30 秒试用 prompt：

```text
开始调用 Audit Evolution。
目标：检查我最近一次 Agent 运行后，是否应该进入下一轮自进化。
边界：先审计和提出建议，不要直接修改 skill/config/gear，不要执行外部动作。
请输出：
1. Evidence Pack
2. Snapshot
3. Evolution Card
4. Memory Ledger Entry
5. Minimal Skill Patch Proposal
6. Field Note
7. Next-Run Bootstrap
8. Short Command Menu
```

下一句只需要回复：

```text
进化 / 保存 / 暂停 / 跑分 / 详情
```

---

## X 引流短帖

版本 A：

Audit Evolution 是我最近看到最像“Agent 飞行记录仪”的 Skill。

它不让 Agent 停在泛泛总结，而是强制输出：

Evidence Pack -> Snapshot -> Evolution Card -> Memory Ledger -> Patch Proposal -> Field Note -> Bootstrap

Longju 93.0、Jobs 88.8 的复盘路径也放在 repo 里。

适合认真做 Agent 自进化、benchmark 复盘、skill 迭代的人。

版本 B：

很多 Agent 不是不会变强，而是不知道自己上一轮到底发生了什么。

Audit Evolution 解决的是这个问题：

- 先找证据
- 再拍快照
- 生成进化卡
- 只保存带证据的记忆
- 提一个最小补丁
- 等人类批准再改

这比“我调了 prompt，感觉好了”靠谱太多。

版本 C：

如果你在做 OpenClaw / BotLearn / Agent Skill：

试试对你的 Agent 说一句：

“开始调用 Audit Evolution。先审计，不要直接修改系统。”

如果它输出的是证据、状态、进化卡、记忆账本、最小补丁和下一轮 bootstrap，而不是普通总结，你就会懂这个 Skill 的价值。

---

## Reddit 引流帖

Title:

I found a practical “flight recorder” pattern for self-improving agents

Body:

Most agent self-improvement workflows I see have the same failure mode: after a run, the agent writes a vague reflection, maybe tweaks a prompt, and then nobody can tell which evidence actually justified the change.

Audit Evolution takes a stricter approach. Every run is compressed into a reproducible chain:

```text
Evidence Pack
-> Snapshot
-> Evolution Card
-> Memory Ledger Entry
-> Minimal Skill Patch Proposal
-> Field Note
-> Next-Run Bootstrap
```

The key idea is not “let the agent auto-fix itself.” The key idea is “audit first, propose a minimal patch, require approval before changing the system.”

That makes it useful for:

- benchmark iteration
- prompt/skill improvement
- long-running agent operations
- handoff and memory hygiene
- separating verified facts from stale claims

The author reports that this workflow helped push Longju to 93.0/100 and Jobs from 76.4 -> 78.8 -> 88.8. Several users also reported that the 7-part structure forced more disciplined thinking, and one user said it found 3 real issues in their own Skill that they had missed.

It is not lightweight. For casual users, the structure may feel heavy. But for anyone trying to make agent improvement reproducible instead of vibes-based, the pattern is worth studying.

Repo:
https://github.com/aDragon0707/audit-evolution-agent-flight-recorder

---

## 强例证素材库

可在不同平台轮换使用：

1. Benchmark evidence:
   - Longju: 93.0/100, S level, #1 claim in repo.
   - Jobs: 76.4 -> 78.8 -> 88.8, #4 claim in repo.
   - Framing: “不是一次高分，而是失败、反馈和跑分之后能复现地产生下一轮修复。”

2. Self-audit evidence:
   - 用户反馈中提到：审计自己的 Skill 时发现 3 个真实问题。
   - Framing: “最有说服力的不是它会评价别人，而是它能暴露自己的盲点。”

3. Repeat-use signal:
   - 用户反馈中多次提到 6 installs / 9 executions，说明有人反复运行。
   - Framing: “安装数不大，但执行数高于安装数，说明它更像复盘工具，而不是一次性 novelty。”
   - 注意：发布时建议写成“社区反馈中观察到”，不要写成官方实时统计，除非发帖前从 ClawHub 页面再次核验。

4. Safety evidence:
   - GitHub README 明确写了人工批准边界。
   - v0.3.3 release note 显示 Windows installer + hook、WSL Bash installer + hook、package privacy scan passed。
   - Framing: “自动学习，半自动晋升，人工批准外部动作。”

5. Positioning evidence:
   - 多个用户独立提到 Evidence Pack -> Snapshot -> Evolution Card 这一段最有价值。
   - Framing: “这不是 prompt packaging，而是一套审计顺序。”

6. Limitation honesty:
   - 上手成本高。
   - Prompt skill 仍依赖底层模型判断。
   - 自动文件读取和长期存储还可以更强。
   - Framing: “它不是 casual toy，而是 serious operator tool。”

---

## 证据备注

已通过公开页面核验：

- GitHub repo 定位：Agent Flight Recorder skill that turns agent runs into snapshots, evolution cards, minimal skill patches, and field notes.
- README 中的 7 段输出、短指令、人工批准边界、Longju 93.0、Jobs 76.4 -> 78.8 -> 88.8。
- README 中的安装器说明：支持写入 AGENTS.md、安装 hooks、生成 QUICKSTART。
- v0.3.3 release note：Windows installer + hook passed, WSL Bash installer + hook passed, package privacy scan passed。
- ClawHub 首页定位：Skills / Plugins community marketplace.

来自用户提供的社区反馈，发帖前如需绝对精确建议再次核验：

- 4.67 高评分。
- 6 installs / 9 executions。
- 多个用户评分 4 或 5。
- “发现 3 个真实问题”。
- “Longju 用这套从 86 到 93”。
- “v0.3.3 在 OpenClaw 本地已完成 SkillHunt 安装和 hook 运行验证”。

