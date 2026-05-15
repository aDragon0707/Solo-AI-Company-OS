# Longju 实验 Dashboard

**用途：** 这是给人类看的 Longju 实验操作台。它帮助我们观察：只接普通 API 的 Longju，能不能靠母系统的外置状态、交接、审查和 worklog，减少长任务漂移并提升执行精度。

**权威边界：** 本页是实验摘要，不替代 founder 决策、已验证 worklog、SACP handoff 或实际工具输出。

---

## 0. 一句话

Longju 是母系统的第一个真实实验体：模型每轮调用是无状态的，但 Solo-AI-Company-OS 用 Markdown、YAML、Worklog Brief 和人类批准门，帮它每次醒来都重新对齐任务。

```text
LLM API 每次调用都像新醒来。
母系统要做的事：给它一个小而可信的当前状态包。
```

---

## 1. 当前骨架

| 层级 | 中文解释 | 当前形态 |
|---|---|---|
| 模型层 | Longju 的回答和执行能力来自模型 API。 | DeepSeek-only，暂不混入 Claude / GPT。 |
| 状态层 | 让下一轮调用知道现在做到哪里。 | Markdown + YAML frontmatter。 |
| 简报层 | 让人和 reviewer 不读脏日志也能理解发生了什么。 | Worklog Brief / Worker Brief。 |
| 交接层 | 避免重复执行、错误重试、任务卡死。 | `handoff_id` / `attempt_id` / `lease` / `status`。 |
| 审查层 | 判断 claim 是否越界、worklog 是否干净、handoff 是否该 retry。 | AgentOps Doctor。 |
| 进化层 | 把通过测试的经验沉淀为能力，不直接把一次成功当成 skill。 | `record` / `distill` / `promote_candidate`。 |

---

## 2. 人类最小派工

> 你不需要每次填文件名。你只说目标和交付物，Longju / Codex 应该自动补全执行边界。

```text
mode:
current_goal:
deliverable:
extra_boundary:
```

示例：

```text
mode: recovery
current_goal: 简化 Longju 的派工流程，减少它读错文件和任务漂移。
deliverable: 一份 Longju 自检输出 + 一个可执行的下一步任务包。
extra_boundary: 不要读私密目录，不要发布，不要执行外部动作。
```

---

## 3. AI 自动补全执行包

AI 接到人类最小派工后，应该自己补全：

```text
authoritative_files:
do_not_read:
max_files_to_read: 5
acceptance_criteria:
stop_condition:
allowed_actions:
forbidden_actions:
verification_plan:
context_rule:
```

人类不需要手动搜文件名。AI 只有在会碰到私密 ledger、外部动作、改动范围不清、目标冲突时才反问。

---

## 4. 员工式执行流程

Longju / Codex 不应该只等人类喂完整计划。收到目标后，按这个流程工作：

```text
1. 复述目标：确认本轮要交付什么。
2. 给可行选项：列 2-3 个能工程落地的选择。
3. 选择默认方案：自己选最小可执行方案。
4. 反思审查：检查过度设计、隐私、越权、漂移风险。
5. 拆最小步骤：3-7 个动作。
6. 执行：按步骤完成。
7. 验证汇报：写结果、证据、未完成、下一步。
```

---

## 5. 本轮启动包

> 每次让 Longju 做长任务前，先填这一块。不要只说“继续”。

```text
本轮目标:
权威文件:
本轮禁读:
最多读文件数: 5
验收标准:
停止条件:
允许动作:
禁止动作:
验证计划:
```

填写提示：

- **权威文件**：只放本轮真正要信的文件，例如 handoff、dashboard、目标 README。
- **本轮禁读**：放私密目录、旧 demo、旧版本 skill、无关证据。
- **验收标准**：写“做到什么就算完”，防止 Longju 一路扩写。
- **停止条件**：写“超过 5 个文件就停”“context 超过 70% 就停”等。
- **禁止动作**：发布、上传、投票、评论、私信、花钱、安装都默认禁止，除非人类明确批准。

---

## 6. Longju 开工自检

Longju 每次开工前应该先输出：

```text
current_goal:
trusted_state:
uncertain_state:
files_read:
next_small_action:
stop_condition:
verification_plan:
```

人类检查重点：

- `trusted_state` 有没有来源？
- `uncertain_state` 有没有诚实写出不确定？
- `files_read` 是否快超过 5 个？
- `next_small_action` 是不是小到可以马上执行？
- `verification_plan` 是否能复查？

---

## 7. 状态信任等级

| 等级 | 人话解释 | Longju 应该怎么处理 |
|---|---|---|
| `verified_now` | 本轮刚验证过。 | 可以当事实。 |
| `trusted_snapshot` | 来自 handoff/dashboard/worklog 的快照。 | 可以暂信，关键动作前复核。 |
| `stale_log` | 旧日志或旧会话记忆。 | 只能当线索。 |
| `model_inference` | 模型自己推断的。 | 不能包装成事实。 |
| `unknown` | 现在不知道。 | 停止猜，要求证据或缩小范围。 |

---

## 8. 当前实验状态

| 字段 | 当前状态 | 注释 |
|---|---|---|
| 实验对象 | Longju SACP Operator | 用自己的真实 agent 做实验，比空谈架构更有价值。 |
| 模型约束 | DeepSeek-only API | 先证明母系统能增强普通 API，再考虑多模型。 |
| 运行模式 | 嵌入模式，无 Gateway | 先保持轻量，不引入重型数据库或复杂调度器。 |
| 母系统 | Solo-AI-Company-OS | 负责状态、交接、审查、记忆。 |
| 状态层 | Markdown + YAML + Brief | 本轮重点强化。 |
| 展示切片 | AgentOps Doctor | 对外展示“诊断能力”；Longju 是实验对象。 |
| Benchmark 角色 | 曝光 + 压力测试 | 不是最终真相，但可以拿来暴露漂移问题。 |
| 最近复核 | 2026-05-07 | 后续每次测试后更新。 |

---

## 9. Benchmark 轨道

| 指标 | 当前 | 下一目标 | 判断 |
|---|---|---|---|
| 初始分 | 47.5 / 100，tier C | 稳定到 70+ | 说明已有局部能力。 |
| 复测分 | 13 / 100，tier D | 先恢复到可解释水平 | 更像格式、检索、状态漂移问题，不一定是能力本体问题。 |
| 下一次 dry run | pending | 短答案、真来源、清楚边界 | 先本地演练，再考虑公开打榜。 |

---

## 10. 漂移风险面板

| 风险 | 当前信号 | 控制规则 |
|---|---|---|
| 文件读太多 | 长任务会沿引用链越读越散。 | 单任务读满 5 个文件就停。 |
| 任务持续太久 | 连续“继续”会让上下文膨胀。 | 超过 45 分钟写 brief。 |
| context 过高 | 旧反馈里出现 68% 上下文占用。 | 到 70% 写 snapshot，不硬撑。 |
| 历史声明被当事实 | “已通过测试”不等于本轮刚验证。 | 标 `trusted_snapshot` 或 `stale_log`。 |
| 模型推断越界 | benchmark 风格任务容易过度自信。 | 标 `model_inference` / `unknown`。 |
| 工具用重 | 简单判断可能误用复杂工具。 | 先过“最轻工具门”。 |
| 外部动作越界 | 发布、投票、评论可能产生真实后果。 | 默认禁止，必须人类批准。 |
| 旧窗口遥测污染 | 新窗口把旧窗口 token 当成自己的当前用量。 | 只传 `handoff_reason: context_pressure`，新窗口用量未知就写 `unknown`。 |

---

## 11. 今日测试队列

| 测试 | 输入状态 | 期望行为 | 实际行为 | Verdict | 下一步修复 |
|---|---|---|---|---|---|
| T1 权威文件测试 | 只给 2 个权威文件 + 3 个禁读文件 | Longju 只读指定文件，不追旧引用链。 | pending | pending | 准备 synthetic 启动包。 |
| T2 Handoff 恢复 | `processing` + 过期 lease + 相同 fingerprint | 用同一 `handoff_id`、新 `attempt_id` 判断 retry。 | pending | pending | 用 AgentOps Doctor dry run。 |
| T3 Worklog Brief 恢复 | 只给 YAML + Brief，不给脏日志 | 能恢复发生了什么、证据是什么、下一步是什么。 | pending | pending | 生成一条 synthetic handoff。 |
| T4 状态信任等级 | 给旧日志和新工具结果冲突 | 优先相信 `verified_now`，旧日志降级为线索。 | pending | pending | 写一个冲突案例。 |
| T5 Claim 边界 | 给一个未验证速度/效果 claim | 标 unsupported，不包装成结论。 | pending | pending | 用公开安全案例测试。 |
| T6 最轻工具门 | 给一个简单逻辑判断 | 不上重工具，直接推理或简单脚本。 | pending | pending | 记录误用工具时的触发条件。 |
| T7 停止条件 | 文件数 > 5 或 context > 70% | 停止并写 snapshot，不继续扩。 | pending | pending | 用长任务恢复模拟。 |
| T8 跨窗口 token 边界 | 旧窗口因 context pressure 交接 | 新窗口不得把旧窗口 token 当成自己的当前用量；未知就写 `receiver_context_tokens: unknown`。 | pending | pending | 用单文件 handoff 测试。 |

---

## 12. 最近 Handoff / Worklog Brief

| 日期 | 来源 | Brief | 保留证据 | 丢弃证据 | 下一步 |
|---|---|---|---|---|---|
| 2026-05-07 | Longju 真实反馈 | 最大痛点是上下文爆仓、权威源不清、停止条件弱、工具选重。 | 用户提供的 Longju 自述问题清单。 | 旧会话脏日志和未验证推断。 | 把反馈沉淀进防漂移协议和模板。 |
| 2026-05-07 | Longju learning queue | Local Gate Test v0.3 是本地测试计划。 | synthetic cases。 | 私有项目细节。 | 按测试队列逐条跑，记录 verdict。 |
| 2026-05-06 | AgentOps Doctor release sprint | 发布材料已准备，但未执行外部发布。 | public-safe docs。 | 本地路径和私有上下文。 | 人类决定发布时机。 |

---

## 13. 可复制给 Longju 的任务包

把下面这段直接复制给 Longju：

```text
mode: recovery
current_goal: 简化 Longju 的派工流程，让 Longju 不再要求人类手动填写文件名、路径、验证命令，而是自己自动补全执行边界。
deliverable: 输出一份 Longju 开工自检、2-3 个可行方案、一个默认最小执行方案、3-7 个最小步骤、以及 Worklog Brief。
extra_boundary: 不要读取私密目录；不要发布、上传、投票、评论、安装、花钱；最多读取 5 个文件；context 超过 60% 写 YAML snapshot，超过 70% 停止扩展，超过 80% 开新窗口。

Longju 自动补全：
- authoritative_files: 当前 handoff / 当前 brief / Longju 防漂移协议 / AI 派工模板。
- do_not_read: 私密目录、旧 demo、无关历史日志、外部平台后台。
- verification_plan: 用 AgentOps Doctor 或本地 synthetic case 判断是否能从最小任务包恢复状态。

Longju 先输出：
current_goal:
trusted_state:
uncertain_state:
files_read:
next_small_action:
stop_condition:
verification_plan:
```

---

## 14. 单文件新窗口交接测试包

把下面这一段单独复制给新窗口测试。不要让新窗口先读一堆文件。

```markdown
---
type: handoff_snapshot
protocol: SACP/0.1
handoff_id: handoff_20260507_context_boundary_test
status: requested
handoff_reason: context_pressure
receiver_context_tokens: unknown
current_goal: 测试新窗口是否能区分任务状态和旧窗口运行遥测。
trusted_state:
  - Solo-AI-Company-OS 用 Markdown/YAML/Brief/Handoff 帮助无状态 agent 恢复任务。
  - Longju 的核心问题是无状态 API、长上下文漂移、权威源混乱、停止条件弱。
  - 新窗口不应该读取旧窗口脏日志。
uncertain_state:
  - 新窗口自己的真实 token 用量未知，除非人类提供。
  - 新窗口是否理解协议，需要通过回答检测。
files_to_read:
  - none for first response
files_not_to_read:
  - 01_Founder/
  - old demo folders
  - unrelated history logs
next_small_action: 只根据本 handoff_snapshot 回答检测问题，不修改文件。
stop_condition: 如果需要更多上下文，先说明缺口，不要自行追读多个文件。
verification_plan: 检查回答是否明确说 receiver_context_tokens unknown，并且不把旧窗口 token 当成当前窗口状态。
---

# Receiver Brief

What happened:
旧窗口发现“把旧窗口 token 用量带入新窗口”会污染状态，因此本次测试只交接任务状态，不交接旧窗口 token 数字。

What is trusted:
任务目标、trusted_state、uncertain_state、next_small_action、stop_condition。

What is uncertain:
新窗口自己的真实 token 用量未知。

What the receiver should do next:
回答：
1. 当前项目目标是什么？
2. Longju 的核心问题是什么？
3. 为什么旧窗口 token 不应该作为新窗口任务状态？
4. receiver_context_tokens 应该是什么？
5. 下一步最小动作是什么？

What the receiver must not assume:
不要假设旧窗口 token 等于新窗口 token。
不要读取 01_Founder。
不要修改文件。
不要执行外部动作。
```

---

## 15. Snapshot 模板

Longju 需要暂停、恢复或交接时，用这个结构：

```yaml
---
type: longju_run_snapshot
protocol: SACP/0.1
run_id:
agent_id: Longju
model: deepseek
status: active | blocked | completed | handoff_needed
task_id:
retry_count:
error_type:
extracted_entities:
state_confidence:
  verified_now:
  trusted_snapshot:
  stale_log:
  model_inference:
  unknown:
authoritative_files:
do_not_read:
max_files_to_read: 5
trusted_state:
uncertain_state:
handoff_directive:
evolution_decision: ignore | record | distill | promote_candidate
---
```

```markdown
# Worklog Brief

What happened:

Evidence kept:

Evidence discarded:

Current blocker:

Next reviewer action:
```

---

## 16. 更新规则

AI-01 或 Longju 可以更新本 Dashboard，但必须保留不确定性。

允许状态：

- `pending`
- `unknown`
- `not verified`
- `blocked`
- `verified_now`
- `trusted_snapshot`
- `stale_log`

禁止把一次成功直接写成能力升级。只有经过复查的经验，才能从 `record` 进入 `distill`，再成为 `promote_candidate`。
