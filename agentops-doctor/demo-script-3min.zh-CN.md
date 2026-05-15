# AgentOps Doctor 3 分钟演示稿

## 0:00-0:30 开场

多 Agent 系统最烦的不是模型不够聪明，而是状态不干净。

一个 agent 说自己做完了，另一个又跑了一遍。同一个任务出现两个结果。或者 worklog 只有一句“已优化”，三天后没人知道怎么验证。

AgentOps Doctor 做的就是运行体检。

## 0:30-1:20 问题

它检查五类问题：

1. handoff 是否重复执行；
2. lease 是否过期；
3. worklog 是否缺工具和验证；
4. claim 是否有证据；
5. 经验是否应该沉淀成 skill。

它不调度 agent，不改代码，只输出诊断报告。

## 1:20-2:20 Demo

输入：

```yaml
handoff_id: demo_003
status: processing
lease_owner: agent_a
lease_expires_at: 2020-01-01T10:00:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
```

诊断：

```text
processing + expired lease + same fingerprint
-> retry
-> same handoff_id
-> new attempt_id
-> set new lease_owner and lease_expires_at
```

再看 worklog：

```yaml
findings:
  - response time is much faster
tools_used: []
verification:
```

诊断：

```text
dirty worklog.
没有工具列表，没有 verification，结论不可复查。
```

## 2:20-3:00 结尾

AgentOps Doctor 是开源 Solo-AI-Company-OS 的第一个可安装诊断模块。

完整 OS 负责管理 AI 员工、worklog、handoff 和 skill evolution。Doctor 先切出最容易现场验证的一块：运行体检。

一句话：

```text
多 Agent 系统需要的不只是更聪明的模型，还需要可复查的运行纪律。
```
