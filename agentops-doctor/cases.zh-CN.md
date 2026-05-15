# AgentOps Doctor 公开案例库

所有案例均为构造案例，不包含真实项目、路径、客户、平台、截图或 credentials。

## 1. completed handoff -> skip

```yaml
handoff_id: hf_001
status: completed
attempt_id: attempt_001
source_fingerprint: sha256:aaa
```

诊断：已完成，跳过，不重复执行。

## 2. processing + active lease -> wait

```yaml
handoff_id: hf_002
status: processing
lease_owner: agent_b
lease_expires_at: 2099-01-01T23:50:00
attempt_id: attempt_001
source_fingerprint: sha256:bbb
```

诊断：其他 agent 持有有效 lease，等待。

## 3. processing + expired lease + same fingerprint -> retry

```yaml
handoff_id: hf_003
status: processing
lease_owner: agent_c
lease_expires_at: 2020-01-01T22:00:00
attempt_id: attempt_001
source_fingerprint: sha256:ccc
```

诊断：lease 过期，任务内容未变。保留 handoff_id，创建 attempt_002。

## 4. same handoff + new fingerprint -> rework

```yaml
handoff_id: hf_004
status: processing
lease_expired: true
previous_source_fingerprint: sha256:old
source_fingerprint: sha256:new
```

诊断：不是重复执行，输入变了，需要 rework / update。

## 5. new human decision -> new handoff_id

```yaml
human_decision_changed: true
source_fingerprint: sha256:new-task
```

诊断：任务身份改变，创建新的 handoff_id。

## 6. blocked -> human

```yaml
handoff_id: hf_006
status: blocked
reason: needs human decision
```

诊断：不要自动 retry，等待人类决策。

## 7. worklog claim 没证据

```yaml
findings:
  - This model is much faster.
tools_used: []
verification: none
```

诊断：claim 无证据，必须补工具、数据、验证方式，或改成保守表达。

## 8. verification 字段为空

```yaml
findings:
  - p95=320ms
tools_used:
  - python
verification:
```

诊断：worklog 不完整。verification 必须说明怎么复查。

## 9. 经验该 record

```yaml
task_type: recurring_api_check
repeat_expected: true
evolution_decision: ignore
```

诊断：ignore 太弱。预计会重复，至少 record。

## 10. 经验该 distill

```yaml
repeat_count: 5
same_process_reused: true
evolution_decision: record
```

诊断：可复用流程已经出现，建议 distill 成 skill 草稿。

## 11. promote candidate

```yaml
repeat_count: 8
independent_agents_confirmed: 2
human_approved: false
```

诊断：可以标记 promote candidate，但不能自动 promote。

## 12. privacy rewrite

```text
The file at [PRIVATE_LOCAL_PATH] shows [PRIVATE_CUSTOMER_DATA].
```

诊断：PRIVATE，不能公开。改写为：

```text
A private dataset was analyzed. Public output should only describe the method and sanitized result.
```
