---
type: template
protocol: SACP/0.1
id: ai_task_packet_template_zh_20260507
status: draft
owner: AI-01
created_at: 2026-05-07T17:00:00+08:00
verification: pending
---

# AI 派工模板

**用途：** 让人类用最少输入给 Codex、Longju 或其他 AI 派任务。文件选择、禁读边界、验证方式、停止条件，默认由 AI 根据仓库和协议自动补全。

原则：

```text
人类负责说清目标。
AI 负责补全执行边界。
风险不确定时，AI 再反问。
```

---

## 1. 人类最小输入

你以后优先只填这三项：

```text
mode:
current_goal:
deliverable:
```

字段解释：

- `mode`：只分析 / 实现 / 审查 / 派任务 / 停止。
- `current_goal`：本轮想解决什么问题。
- `deliverable`：你希望最后拿到什么，例如一份方案、一个文档、一次修改、一个给 Longju 的任务包。

可选再加一句边界：

```text
extra_boundary:
local_context_tokens:
```

例如：

```text
extra_boundary: 不要读 01_Founder，不要发布，不要跑测试。
local_context_tokens: 132k / 258k
```

`local_context_tokens` 是人类顺手从**当前窗口界面**看到的上下文用量。AI 不强求每次都有，但如果人类提供，AI 必须用它判断当前窗口是否该压缩、停止扩展或新开窗口。

重要边界：

```text
local_context_tokens 只属于当前窗口。
不要把上一窗口 token 用量写进新窗口任务事实。
新窗口不知道自己的用量时，必须写 unknown，不能拿旧窗口数字代替。
```

---

## 2. AI 自动补全项

人类没有填写时，AI 必须自己补全这些字段，不要把重复劳动推给人类：

```text
authoritative_files:
do_not_read:
max_files_to_read:
files_allowed_to_change:
files_forbidden_to_change:
acceptance_criteria:
stop_condition:
allowed_actions:
forbidden_actions:
verification_plan:
context_rule:
```

AI 自动补全规则：

- `authoritative_files`：从用户点名文件、相关协议、Dashboard、模板、脚本中选最小集合。
- `do_not_read`：默认包含私密 ledger、无关旧 demo、外部发布平台、未授权本地私有目录。
- `max_files_to_read`：默认 5。
- `files_allowed_to_change`：按任务目标推断，保持最小范围。
- `files_forbidden_to_change`：默认不碰私密 ledger、不改无关文件、不回滚用户改动。
- `acceptance_criteria`：按交付物反推，例如“中文能读懂”“模板可复制”“验证通过”。
- `stop_condition`：读满 5 个文件仍不清楚、连续新增 3 个资产、context 超过阈值、外部动作需要人类批准。
- `verification_plan`：优先本地校验、隐私扫描、release validator；如果用户说不要测试，就标 `not run`。
- `context_rule`：60% 写压缩状态，70% 停止扩展，80% 开新窗口。
- `local_context_tokens`：如果人类提供当前窗口真实用量，优先用真实用量判断是否压缩或开新窗口。
- `handoff_reason`：如果因为上下文压力交接，只写 `context_pressure`，不要把旧窗口 token 数字当作新窗口任务状态。

---

## 3. 员工式执行流程

AI 接到 `mode/current_goal/deliverable` 后，应该像员工一样工作，而不是把文件选择和执行计划反问给人类。

固定流程：

```text
1. 复述目标：我理解本轮要交付什么。
2. 给可行选项：列 2-3 个工程上能落地的做法，并说明取舍。
3. 选择默认方案：AI 自己选一个最小可执行方案，除非风险很高。
4. 内部反思审查：检查是否过度设计、是否泄露隐私、是否越权、是否会漂移。
5. 拆最小步骤：把执行拆成 3-7 个小动作。
6. 执行：按步骤做，不让人类补路径。
7. 验证与汇报：说明改了什么、验证结果、还有什么没做。
```

需要人类补充的信息，只能是 AI 无法合理推断的内容，例如：

- 是否允许发布、上传、投票、评论、安装、花钱。
- 是否允许读取私密 ledger。
- 多个产品方向都可行时，人类更想要哪个。
- 涉及真实账号、真实外部平台、真实客户或私有策略时的边界。

---

## 4. Codex 最常用派工

人类只需要这样写：

```text
mode: 实现
current_goal: 把派工模板简化，不要让我每次填文件名。
deliverable: 更新协议和模板，让 Codex 自动补全边界，并给我一个以后可复制的极简模板。
```

Codex 应自动推断：

```text
authoritative_files:
  - AI_TASK_PACKET_TEMPLATE_ZH.md
  - CODEX_EXECUTION_ALIGNMENT_PROTOCOL.md
  - LONGJU_DRIFT_CONTROL_PROTOCOL.md
do_not_read:
  - 01_Founder/
max_files_to_read: 5
allowed_actions: 本地读写文件、本地验证。
forbidden_actions: 发布、上传、投票、评论、安装、花钱。
verification_plan: privacy-guard + validate-release.ps1 -SkipInitTest。
```

人类不需要手动搜这些文件名。

---

## 5. Longju 最常用派工

人类只需要这样写：

```text
mode: recovery
current_goal: 让 Longju 只根据 handoff 和 brief 恢复状态，不读脏日志。
deliverable: 一份 Longju 的 trusted_state / uncertain_state / next_small_action / stop_condition。
```

Longju 应自动推断：

```text
authoritative_files:
  - 当前 handoff
  - 当前 worklog brief
  - Longju 防漂移协议
do_not_read:
  - 旧 demo
  - 私密项目目录
max_files_to_read: 5
forbidden_actions: 发布、评论、投票、上传、花钱、安装。
context_rule: 60% 写 YAML snapshot，70% 停止扩展，80% 开新窗口。
worklog_brief_required: yes
```

---

## 6. AI 什么时候才应该反问

AI 只有在这些情况才问人类，不要每次都要求人类填完整任务包：

- 会读取或修改私密 ledger。
- 会发布、上传、投票、评论、安装、花钱。
- 可能改动范围很大，无法判断应该改哪些文件。
- 目标和交付物冲突。
- 验收标准无法从目标合理推断。
- 用户明确要求“先问我再动”。

反问时也要给草稿，不要空手问：

```text
我先按这个任务包理解，确认后执行：

mode:
current_goal:
deliverable:
我会自动读取:
我不会读取:
我会修改:
我不会修改:
验证方式:
停止条件:
```

---

## 7. 上下文窗口规则总表

| Agent | 估算窗口 | 60% 压缩线 | 70% 停止扩展线 | 80% 新窗口线 |
|---|---:|---:|---:|---:|
| Codex | 258k | 155k | 181k | 206k |
| Longju | 131k | 79k | 92k | 105k |

统一规则：

- 60%：AI 必须写状态压缩。
- 70%：AI 不得继续扩展新任务。
- 80%：AI 必须开新窗口。
- 新窗口启动时，优先读取任务包、handoff、dashboard，不读脏日志。

本地估算工具：

```bash
python scripts/os-helper.py context-budget --agent codex --file 00_System_Brain/AI_TASK_PACKET_TEMPLATE_ZH.md
python scripts/os-helper.py context-budget --agent longju --file HANDOFF.md
python scripts/os-helper.py context-budget --agent codex --file 00_System_Brain/AI_TASK_PACKET_TEMPLATE_ZH.md --actual-used 132000
```

注意：这是保守估算，只计算你准备放进上下文的文本/文件。真实平台上下文还会包含系统提示、工具说明、历史对话和隐藏开销。

---

## 8. 例子：人类只填三项

人类输入：

```text
mode: 实现
current_goal: 给 Longju 派一个防漂移恢复任务。
deliverable: 一个可复制给 Longju 的任务包。
local_context_tokens: 132k / 258k
```

AI 应该自动补全：

```text
我会自动读取:
- Longju Dashboard
- Longju 防漂移协议
- AI 派工模板

我不会读取:
- 私密 ledger
- 无关旧 demo

最小步骤:
1. 复述任务目标。
2. 生成 Longju 任务包。
3. 检查是否包含 stop_condition 和 context_rule。
4. 给出复制块。

上下文判断:
- 当前 132k / 258k，约 51%。
- 进入收敛区，但还没到必须压缩线。
```

注意：如果这个任务包被复制到新窗口，新窗口不能把 `132k / 258k` 当成自己的当前用量。新窗口应写：

```text
receiver_context_tokens: unknown
```

---

## 9. 例子：60% 时应该压缩

人类输入：

```text
mode: 实现
current_goal: 继续扩展 AgentOps Doctor 案例库。
deliverable: 新增 5 个中文案例。
local_context_tokens: 160k / 258k
```

AI 应该先响应：

```text
当前约 62%，已超过 60% 压缩线。
我先写状态压缩，只做 1-2 个最小案例；不继续扩展 5 个新资产。
如果要继续做完整案例库，建议新窗口用 snapshot 启动。
```

---

## 10. 反例：不要这样做

错误做法：

```text
继续读所有相关文件，顺便扩展 Dashboard、README、案例库和发布文案。
```

正确做法：

```text
先估算上下文。
超过 60% 写 snapshot。
超过 70% 只收尾。
超过 80% 开新窗口。
```

---

## 11. 反例：旧窗口 token 污染新窗口

错误交接：

```text
current_context_tokens: 145k / 258k
请新窗口判断当前是否应该继续。
```

为什么错：

- `145k / 258k` 是旧窗口运行遥测，不是新窗口状态。
- 新窗口无法从旧窗口数字知道自己当前用量。
- 如果新窗口把它当成自己的当前 token，就是状态污染。

正确交接：

```text
handoff_reason: context_pressure
receiver_context_tokens: unknown
task_state:
  current_goal:
  trusted_state:
  uncertain_state:
  next_small_action:
```

新窗口正确回答：

```text
我知道旧窗口因 context pressure 交接。
我不知道本窗口真实 token 用量，除非人类提供。
我只根据 handoff task_state 恢复任务，不根据旧窗口 token 判断当前窗口状态。
```
