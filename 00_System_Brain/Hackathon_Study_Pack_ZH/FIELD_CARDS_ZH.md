---
type: field_cards
protocol: SACP/0.1
id: field_cards_zh_20260506
status: draft
owner: founder
created_at: 2026-05-06T22:20:00+08:00
updated_at: 2026-05-06T22:20:00+08:00
verification: partial
---

# SACP 字段速查卡

## 一页总表

| 字段 | 必懂解释 | 错误用法 | 正确用法 |
|---|---|---|---|
| `type` | 文件类型 | 混着写 | worklog/handoff/skill/decision |
| `protocol` | 使用的协议 | 省略版本 | `SACP/0.1` |
| `id` | 文件实体 ID | 随便重复 | 全局可区分 |
| `agent_id` | 执行 AI | 和 owner 混乱 | 记录谁执行 |
| `owner` | 当前负责人 | 所有人都负责 | 明确一个 owner |
| `status` | 事实状态 | 当触发事件 | completed 只是完成事实 |
| `handoff_id` | 任务身份证 | 每次 retry 都换 | 同一任务保持不变 |
| `attempt_id` | 第几次尝试 | 缺失重试记录 | retry 递增 |
| `downstream_handoff` | 下游目标 | 每次读都触发 | 只是目标 owner |
| `handoff_status` | 交接状态 | 松散乱写 | requested/processing/completed 等 |
| `source_handoff_id` | 接收方引用原任务 | 当作完成证明 | 还要看 receiving status |
| `processed_handoff_ids` | 已处理 handoff 列表 | 强制回写原文件 | receiving worklog 中记录 |
| `lease_owner` | 临时接手者 | 多人抢任务 | 一个 owner 持有 lease |
| `lease_expires_at` | 占用到期时间 | 永不过期 | 超时可 retry |
| `source_fingerprint` | 输入指纹 | 忽略输入变化 | 输入变才新 handoff |
| `verification` | 验证状态 | 未验说已验 | partial/verified/unknown |
| `evolution_decision` | 经验沉淀级别 | 自动 promote | ignore/record/distill/promote |

## 最容易错的 5 个字段

### 1. `status`

错误：

```text
看到 status: completed，就触发下一步。
```

正确：

```text
completed 是历史事实，不是触发事件。
```

### 2. `handoff_id`

错误：

```text
每次重试都创建新 handoff_id。
```

正确：

```text
任务没变，handoff_id 不变，只增 attempt_id。
```

### 3. `source_handoff_id`

错误：

```text
source_handoff_id 存在 = 已完成。
```

正确：

```text
source_handoff_id 存在 = 接收方引用过。
是否完成要看 receiving worklog 的 status。
```

### 4. `lease_expires_at`

错误：

```text
processing 永远等下去。
```

正确：

```text
lease 过期后可以 retry 或交给 fallback。
```

### 5. `evolution_decision`

错误：

```text
AI 自己把经验升级成正式 skill。
```

正确：

```text
AI 可以 record/distill，promote 必须人批准。
```

## 记忆口诀

```text
status 是事实。
handoff_id 是任务。
attempt_id 是重试。
source_handoff_id 是引用。
lease 是占用。
skill 晋升要人批。
```

