# AgentOps Doctor

> 给多 Agent 系统做运行体检：检查重复执行、卡住的 handoff、脏 worklog、越界 claim，以及经验是否该沉淀成 skill。

AgentOps Doctor 是 Solo-AI-Company-OS 的第一个公开诊断模块。

它不调度你的 agent，不改你的代码，不读取你的私有项目。你给它一段脱敏后的状态片段，它给你一份诊断报告。

---

## 适合谁

- 正在用多个 agent 协作的人；
- 有 worklog / handoff / task state 的人；
- 遇到重复执行、状态卡住、结果不可复现的人；
- 想把实战经验沉淀成 skill，但不想让 AI 自动乱升级规则的人。

---

## 你给它什么

一段脱敏 handoff：

```yaml
handoff_id: hf_001
status: processing
lease_owner: agent_a
lease_expires_at: 2026-05-07T10:30:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
```

一段 worklog：

```yaml
findings:
  - p95 about 320ms
tools_used: []
verification:
evolution_decision: record
```

一段准备公开的回答：

```text
这个模型比另一个模型快很多。
```

---

## 你得到什么

一份结构化诊断：

| 检查项 | 可能结果 |
|---|---|
| Handoff Diagnosis | skip / wait / retry / rework / block |
| Worklog Audit | pass / needs evidence / dirty / blocked |
| Claim Review | pass / revise / soften / remove |
| Skill Evolution Gate | ignore / record / distill / promote candidate |
| Privacy Rewrite | public-safe / internal-only / private / restricted |

---

## 快速例子

### 例 1：handoff lease 过期

输入：

```yaml
handoff_id: demo_002
status: processing
lease_owner: agent_a
lease_expires_at: 2026-05-06T10:00:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
```

诊断：

```text
processing + expired lease + same source_fingerprint
-> retry with new attempt_id
-> keep same handoff_id
-> set new lease_owner and lease_expires_at
```

### 例 2：worklog 缺验证

输入：

```yaml
findings:
  - response time is much faster
tools_used: []
verification:
```

诊断：

```text
dirty worklog.
The claim has no tools_used and no verification.
Add measurement method, tool list, and repeatable verification notes.
```

### 例 3：公开回答有隐私内容

输入：

```text
我们在 [PRIVATE_PROJECT_NAME] 的 [PRIVATE_LOCAL_PATH] 里验证过。
```

输出：

```text
我们在一个真实项目中验证过这个模式，但公开表达只保留方法，不暴露项目名、路径或数据。
```

---

## 五个模块

1. **Handoff Diagnosis**
   判断 handoff 是 skip、wait、retry、rework 还是 block。

2. **Worklog Audit**
   检查 worklog 是否有 owner、tools_used、verification、residual risk。

3. **Adversarial Claim Review**
   检查每个 claim 是否有证据，是否把推断说成事实。

4. **Skill Evolution Gate**
   判断经验该 ignore、record、distill，还是标记为 promote candidate。

5. **Privacy / Public Rewrite**
   把含私有信息的输出改写成 PUBLIC-safe 版本。

---

## 使用边界

可以输入：

- 脱敏后的状态字段；
- 构造案例；
- 已经去掉项目名、路径、客户、平台、截图、credentials 的 worklog 片段。

不要输入：

- 私有项目路径；
- 客户或平台名称；
- credentials；
- raw screenshots；
- founder 私人反思；
- 未发布商业决策。

发布或粘贴公开内容前，可以先跑物理脱敏卡点：

```bash
python scripts/os-helper.py privacy-guard --file agentops-doctor/README.zh-CN.md
```

它会拦截常见本地路径、credential 字段和 `sk-...` 形态 key。`[PRIVATE_*]` 这种教学占位符允许保留，用来示范如何脱敏。

---

## 现场反馈模板

```text
你的环境：
用了 AgentOps Doctor 查什么：
发现了什么问题：
最有用的诊断是什么：
希望下个版本增加什么：
```

反馈会进入下一轮 worklog，再由 human promotion gate 决定是否沉淀为正式 skill。
