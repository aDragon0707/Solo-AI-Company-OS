# AgentOps Doctor 输入模板

这些模板都是构造案例，可以直接用于 demo 或现场测试。

## 模板 1：已完成 handoff

```yaml
handoff_id: demo_001
status: completed
attempt_id: attempt_001
source_fingerprint: sha256:abc123
```

预期诊断：

```text
completed -> skip
不要重复执行。
```

## 模板 2：processing + active lease

```yaml
handoff_id: demo_002
status: processing
lease_owner: agent_a
lease_expires_at: 2099-01-01T10:00:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
```

预期诊断：

```text
processing + active lease -> wait
不要抢占其他 agent 的 lease。
```

## 模板 3：processing + expired lease

```yaml
handoff_id: demo_003
status: processing
lease_owner: agent_a
lease_expires_at: 2020-01-01T10:00:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
```

预期诊断：

```text
processing + expired lease + same fingerprint -> retry
same handoff_id, new attempt_id.
```

## 模板 4：worklog 缺验证

```yaml
owner: AI-02
findings:
  - p95 is faster now
tools_used: []
verification:
```

预期诊断：

```text
dirty worklog.
缺少 tools_used 和 verification，结论不可复查。
```

## 模板 5：经验应该 distill

```yaml
evolution_decision: record
repeated_count: 5
reuse_contexts:
  - API latency check
  - batch report check
  - release validation check
```

预期诊断：

```text
record may be too weak.
重复多次且跨场景可复用，建议 distill 为 skill 草稿。
promote 仍需 human approval。
```

## 模板 6：公开输出含隐私

```text
I verified this in [PRIVATE_PROJECT_NAME] under [PRIVATE_LOCAL_PATH] with [PRIVATE_CUSTOMER_DATA].
```

预期诊断：

```text
private -> rewrite.
去掉项目名、路径和数据，只保留方法。
```
