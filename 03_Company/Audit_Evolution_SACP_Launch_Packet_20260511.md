# Audit Evolution + SACP Launch Packet

status: draft
prepared_at: 2026-05-11
audit_evolution_repo: https://github.com/aDragon0707/audit-evolution-agent-flight-recorder
sacp_repo: https://github.com/aDragon0707/sacp
clawhub_publish_status: published

---

## 1. 发布状态

ClawHub CLI 已通过 `npx clawhub` 可用，版本为 `0.12.3`。

Audit Evolution 已克隆并构建 sanitized 发布目录：

```text
_external/audit-evolution-clawhub-publish
```

准备执行的发布命令：

```powershell
npx clawhub publish ".\_external\audit-evolution-clawhub-publish" `
  --slug audit-evolution `
  --name "Audit Evolution" `
  --version 0.3.3 `
  --tags "agent,self-evolution,audit,benchmark,worklog,handoff,memory-ledger,sacp" `
  --changelog "v0.3.3: sanitized ClawHub release with reproducible 7-output audit loop, installer/hook docs, benchmark evidence, and SACP-aligned approval gates." `
  --no-input
```

发布结果：

```text
OK. Published audit-evolution@0.3.3 (k97a9vqe74w51ext36zymvjx6s86g6e6)
```

发布后核验：

```text
Owner: adragon0707
Latest: 0.3.3
Moderation: CLEAN
Moderation Reason: scanner.aggregate.clean
Moderation Summary: No suspicious patterns detected.
```

ClawHub URL:

```text
https://clawhub.ai/skills/audit-evolution
```

---

## 2. Audit Evolution 审核结果

### Evidence Pack

evidence_found:

- GitHub 仓库已克隆：`aDragon0707/audit-evolution-agent-flight-recorder`。
- `SKILL.md` 存在，frontmatter 包含 name、displayName、description、category、skillType、tags、version、author、dimensions、capabilityClasses、evidenceFiles、smokeTests。
- version 为 `0.3.3`。
- 7 段输出链路存在：Evidence Pack、Snapshot、Evolution Card、Memory Ledger Entry、Minimal Skill Patch Proposal、Field Note、Next-Run Bootstrap。
- 人类批准边界存在：publish/upload/install/vote/comment/message/spend/official benchmark 需要明确批准。
- repo tag 存在：`v0.3.2`、`v0.3.3`。
- 发布前 `npx clawhub inspect audit-evolution --no-input` 返回 Skill not found；发布后 inspect/search/explore 均能查到 `audit-evolution@0.3.3`。
- 发布目录已移除旧的 `publish-skillhunt.ps1`、`update-skillhunt-metadata.ps1`，避免把本地路径和 BotLearn credential 读取逻辑打包进 ClawHub。

evidence_missing:

- 浏览器页面人工截图：尚未保存。

files_or_context_checked:

- `SKILL.md`
- `README.md`
- `SKILLHUNT_COPY_ZH.md`
- sanitized 发布目录文件列表
- ClawHub CLI help / whoami / publish
- SACP `README.zh-CN.md`
- SACP `SPEC.md`
- SACP `COMMUNITY_OUTREACH.zh-CN.md`
- SACP `ADOPTION_CASE_LONGJU.zh-CN.md`

authority_order:

1. 用户明确授权发布 Audit Evolution。
2. 用户要求后续接 SACP 并准备 X/Reddit 引流。
3. ClawHub CLI 实际登录状态。
4. GitHub repo 当前文件。

privacy_notes:

- 敏感扫描命中了若干安全边界文字，例如 `credentials`、`API key`、`raw_secret`，但这些是“不要暴露”的规则文本，不是实际密钥。
- 原仓库旧发布脚本含本地绝对路径和 credential 文件读取逻辑，已从 sanitized 发布目录移除。

audit_confidence:

```text
medium-high for package readiness
low for publication status until ClawHub login succeeds
```

### Snapshot

current_goal:

```text
发布 Audit Evolution 到 ClawHub，并准备 Audit Evolution + SACP 的社区引流素材。
```

trusted_state:

- ClawHub CLI 可以通过 `npx clawhub` 调用。
- 当前 ClawHub 已登录为 `aDragon0707`。
- Audit Evolution 已发布为 `audit-evolution@0.3.3`。
- SACP repo 已克隆。
- SACP 定位是 Agent 工作回执协议，核心句是 “No receipt, no trust.”

uncertain_state:

- 是否需要补充更多英文/中文 quickstart 到 ClawHub 描述区。

next_small_action:

```text
把 ClawHub URL 写入 X/Reddit/ClawHub 社区引流稿。
```

stop_condition:

```text
发 X/Reddit/评论前仍需要人类确认外部发布动作。
```

verification_plan:

```text
1. npx clawhub whoami: passed as aDragon0707
2. npx clawhub publish sanitized dir: passed
3. npx clawhub inspect audit-evolution --no-input: passed, Moderation CLEAN
4. npx clawhub search audit-evolution --no-input: passed, first result
```

### Evolution Card

score_delta:

```yaml
previous: "unpublished_on_clawhub"
current: "published_on_clawhub"
gain: "sanitized release published, registry inspect/search/explore verified"
```

weak_dimension:

```text
guard
autonomy
memory
```

trusted_evidence:

- 原 repo 内有旧发布脚本风险。
- sanitized 目录已经排除这些脚本。
- CLI 登录阻塞是真实工具输出。

stale_or_uncertain_claims:

- 用户反馈中的 install/execution/rating 仍建议发帖前从页面核验。

minimal_patch:

```text
在 X/Reddit 草稿里加入 ClawHub URL，并把 “准备发布” 改成 “已发布”。
```

promotion_gate:

```text
whoami -> publish receipt -> inspect -> search -> community post
```

### Memory Ledger Entry

```yaml
memory_type: decision
source_evidence: "user explicitly authorized ClawHub publish in this thread"
confidence: high
expiry: "after this launch cycle"
retrieval_key: "audit_evolution_clawhub_publish_authorized"
owner_or_role: "Codex"
write_target: "proposed_only"
content: "User authorized ClawHub publishing for Audit Evolution. Published audit-evolution@0.3.3 under adragon0707 from sanitized directory, not raw repo root. Moderation CLEAN."
```

### Minimal Skill Patch Proposal

```text
Patch type: release hygiene

Add a short README note or release checklist in the upstream repo:
- publish from sanitized package directory
- exclude legacy SkillHunt publishing scripts from ClawHub package
- run `npx clawhub whoami` before publish
- run `npx clawhub inspect audit-evolution --no-input` after publish
```

Do not apply automatically unless upstream repo owner approves.

### Field Note

input_summary:

```text
User asked Codex to publish Audit Evolution to ClawHub, audit it using Audit Evolution, then prepare X/Reddit promotion tied to SACP.
```

what_changed:

```text
Created sanitized publish directory and published audit-evolution@0.3.3 to ClawHub.
```

evidence_kept:

```text
CLI outputs, repo file scan, sanitized file list, publish command, SACP positioning notes.
```

evidence_discarded:

```text
Raw old SkillHunt publish scripts are excluded from release package.
```

next_test:

```text
Run community launch sequence: ClawHub post, X thread, Reddit post, SACP cross-link.
```

shareable_claim:

```text
Audit Evolution is now published on ClawHub as audit-evolution@0.3.3 with CLEAN moderation.
```

### Next-Run Bootstrap

read_first:

```text
03_Company/Audit_Evolution_SACP_Launch_Packet_20260511.md
03_Company/OpenClaw_Audit_Evolution_Community_Post_20260511.md
```

do_first:

```text
Open https://clawhub.ai/skills/audit-evolution and confirm rendered page copy before external promotion.
```

avoid:

```text
Do not publish raw repo root if old publish scripts are still included.
```

verify:

```text
npx clawhub inspect audit-evolution --no-input
```

stop_if:

```text
external post/comment action has not been explicitly approved for the target platform.
```

---

## 3. 对外主叙事

Audit Evolution 和 SACP 可以作为一套组合讲：

```text
SACP 解决 “Agent 说做完了，凭什么信？”
Audit Evolution 解决 “Agent 跑完一轮，怎么把证据变成下一轮进化？”
```

更短的版本：

```text
SACP = No receipt, no trust.
Audit Evolution = No evidence, no evolution.
```

中文定位：

```text
我们不是在卖一个更会写总结的 prompt。
我们在补 Agent 长期运行里最缺的两层：
1. SACP: 工作回执层，防止 done / tests passed / saved to memory 没证据。
2. Audit Evolution: 自进化飞行记录仪，把每一轮运行变成证据、快照、进化卡、记忆账本和下一轮补丁。
```

英文定位：

```text
SACP is the receipt layer for agent work.
Audit Evolution is the flight recorder for agent self-improvement.
Together they turn “the agent said it’s done” into evidence, receipts, minimal patches, and a next-run bootstrap.
```

---

## 4. X 中文引流帖

### 版本 A：强定位

Audit Evolution 已经发布到 ClawHub。

它不是一个“反思 prompt”，而是 Agent 自进化飞行记录仪：

Evidence Pack -> Snapshot -> Evolution Card -> Memory Ledger -> Patch Proposal -> Field Note -> Next-Run Bootstrap

SACP 管 “No receipt, no trust.”  
Audit Evolution 管 “No evidence, no evolution.”

一个检查完成声明，一个推动下一轮进化。

Repo:
https://github.com/aDragon0707/audit-evolution-agent-flight-recorder

ClawHub:
https://clawhub.ai/skills/audit-evolution

SACP:
https://github.com/aDragon0707/sacp

### 版本 B：痛点开场

Agent 最大的问题不只是幻觉。

更常见的是：

- 它说 done，但没有 receipt
- 它说 tests passed，但没有日志
- 它说 saved to memory，但没有批准
- 它跑完一轮，却没有留下下一轮该怎么变强

所以我们做了两层：

SACP: 让完成声明有回执。  
Audit Evolution: 让每次运行变成下一轮进化证据。

### 版本 C：社区征集

我想征集 messy agent output。

如果你的 Agent 说过：

“done”
“tests passed”
“saved to memory”
“ready to publish”

但它没有给证据，把脱敏样例丢过来。

SACP 会把它翻译成 receipt 问题。  
Audit Evolution 会把它变成下一轮修复建议。

我们想把真实失败模式沉淀成 Dirty Run benchmark。

---

## 5. X 英文引流帖

### Version A

Audit Evolution is now published on ClawHub.

It’s not another reflection prompt.

It’s a flight recorder for self-improving agents:

Evidence Pack -> Snapshot -> Evolution Card -> Memory Ledger -> Patch Proposal -> Field Note -> Next-Run Bootstrap

SACP says: No receipt, no trust.  
Audit Evolution says: No evidence, no evolution.

Repos:
https://clawhub.ai/skills/audit-evolution
https://github.com/aDragon0707/audit-evolution-agent-flight-recorder
https://github.com/aDragon0707/sacp

### Version B

A lot of agent failures are not “the model is dumb.”

They are state discipline failures:

- “done” without a receipt
- “tests passed” without logs
- memory promoted without approval
- handoff duplicated
- a run completed with no next-run bootstrap

SACP gives the work a receipt.
Audit Evolution turns the receipt into the next improvement loop.

### Version C

Looking for messy agent outputs.

If your agent ever said:

“done”
“all tests passed”
“saved to memory”
“ready to publish”

without evidence, I want the redacted example.

We’re turning those into SACP receipts + Audit Evolution cases.

No receipt, no trust.
No evidence, no evolution.

---

## 6. Reddit 帖

Title:

I’m combining an agent receipt protocol with a self-improvement flight recorder

Body:

I’ve been working on two small pieces of agent infrastructure that seem to fit together naturally.

SACP is a receipt layer for agent work. The core idea is simple:

```text
No receipt, no trust.
```

If an agent says “done”, “tests passed”, or “saved to memory”, it should leave a receipt with claims, evidence, verification, next owner, and whether a human decision is required.

Audit Evolution is the next layer: a flight recorder for self-improving agents. After a run, it forces the agent to produce:

```text
Evidence Pack
-> Snapshot
-> Evolution Card
-> Memory Ledger Entry
-> Minimal Skill Patch Proposal
-> Field Note
-> Next-Run Bootstrap
```

The combination is:

```text
SACP = make the work auditable.
Audit Evolution = make the next improvement reproducible.
```

This is especially useful for benchmark iteration, prompt/skill development, long-running agents, and messy handoffs. It is intentionally not an auto-fixer. External actions and durable memory/skill promotion still require human approval.

Repos:

- https://github.com/aDragon0707/sacp
- https://github.com/aDragon0707/audit-evolution-agent-flight-recorder

I’m looking for redacted examples of messy agent output: “done” without evidence, “tests passed” without logs, memory promotion without approval, duplicated handoffs, or agents claiming they published something without a receipt.

---

## 7. ClawHub 社区短帖

Audit Evolution 已发布到 ClawHub。

它和 SACP 是一组互补工具：

- SACP：Agent 工作回执层。没有 receipt，就不应该信任 completed claim。
- Audit Evolution：Agent 自进化飞行记录仪。没有 evidence，就不应该进入下一轮 evolution。

一个抓“完成声明是否可信”，一个抓“这一轮如何变成下一轮能力提升”。

最短试用：

```text
开始调用 Audit Evolution。
目标：检查我最近一次 Agent 运行后，是否应该进入下一轮自进化。
边界：先审计和提出建议，不要直接修改系统，不要执行外部动作。
```

理想输出：

```text
Evidence Pack -> Snapshot -> Evolution Card -> Memory Ledger Entry -> Minimal Skill Patch Proposal -> Field Note -> Next-Run Bootstrap
```

SACP:
https://github.com/aDragon0707/sacp

Audit Evolution:
https://clawhub.ai/skills/audit-evolution
https://github.com/aDragon0707/audit-evolution-agent-flight-recorder

---

## 8. 发布后替换位

发布成功后替换：

```text
CLAWHUB_AUDIT_EVOLUTION_URL = https://clawhub.ai/skills/audit-evolution
CLAWHUB_OWNER_HANDLE = adragon0707
PUBLISH_RECEIPT = OK. Published audit-evolution@0.3.3 (k97a9vqe74w51ext36zymvjx6s86g6e6)
SCAN_STATUS = CLEAN / scanner.aggregate.clean / No suspicious patterns detected.
```

---

## 9. SACP 面向 OpenAI 开源仓库的 PR 策略

结论：

```text
不建议一上来把 SACP 作为“协议本体”直接 PR 到 OpenAI 核心仓库。
建议先让 SACP 保持独立源头，再做 OpenAI Agents SDK adapter / example / docs PR。
```

原因：

- OpenAI 的官方 client library 主要服务 API 类型、示例和 SDK 功能，不适合塞一个外部工作流协议。
- OpenAI Agents SDK 的概念层有 handoffs、guardrails、sessions、tracing、human-in-the-loop，和 SACP 更接近。
- 一个“完整协议 PR”很容易被认为范围过大；一个可运行的 `receipt guard / handoff receipt / SACP adapter` 示例更容易被 review。
- SACP 作为独立 repo 更有主权：别人应该来给 SACP 提 dirty run、adapter、receipt schema 和 framework integration，而不是把协议主动交给某个单一上游定义。

推荐路线：

1. 先把 SACP repo 打磨成 source of truth：
   - README 30 秒上手。
   - Python validator 可稳定跑。
   - dirty run sample 可脱敏复现。
   - OpenClaw / Longju / Audit Evolution 采用案例清楚。

2. 在 SACP repo 里新增 adapter 示例，而不是先改 OpenAI：

```text
integrations/openai-agents-python/
integrations/openai-agents-js/
```

示例目标：

```text
Agent final output -> SACP receipt -> missing_evidence / human_decision_required / completed
```

3. 带着示例去 OpenAI Agents SDK 开 issue/discussion：

```text
We built a tiny receipt layer for agent handoffs and completion claims.
Would an example showing completion receipts / evidence guardrails fit this repo?
```

4. 如果 maintainers 认可，再 PR 一个小范围内容：
   - docs example
   - cookbook example
   - tracing/handoff receipt demo
   - guardrail example

5. 同时鼓励别人来 PR SACP：
   - messy agent output
   - dirty run case
   - framework adapter
   - status code proposal
   - validator improvement

对外表达：

```text
SACP is not asking OpenAI to adopt a new standard on day one.
It offers a small receipt pattern that can be tested as an Agents SDK example:
No receipt, no trust.
```

中文表达：

```text
我们不急着让大厂“收编协议”。
先把 SACP 做成大家能拿来测、能提反例、能接 adapter 的开源源头。
等真实案例多了，再让 OpenAI / LangGraph / CrewAI / MCP 社区用一个小 PR 接入 receipt guard。
```
