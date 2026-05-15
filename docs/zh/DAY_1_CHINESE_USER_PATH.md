# Day-1 中文用户路径

不要先读完整仓库。第一天只跑一个小闭环：选入口，开一个 AI，留下 worklog 草稿。

---

## 10 分钟体验

适合：你刚打开项目，只想知道它是不是有用。

1. 打开 `OBSIDIAN_HOME.md`。
2. 选择 `03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md`。
3. 如果不知道选谁，先用 AI-01。
4. 给 AI 一个很小的任务：整理今天下一步、检查一个 worklog、或改一段公开文案。
5. 结束后生成 worklog 草稿：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-worklog.ps1 -AgentId AI-01 -Title "first setup loop"
```

完成这一步就够了。不要在第一天读完整架构。

---

## 跑一个 AI 员工

适合：你已经知道今天要做什么，但不知道该交给哪个 AI。

1. 打开 `03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md`。
2. 按任务类型选一个 AI：
   - 拆任务、排优先级、同步状态 -> AI-01
   - 写代码、查证据、跑验证 -> AI-02
   - 写对外文案、用户沟通、增长动作 -> AI-03
   - 审查 claim、隐私、风险 -> AI-04
   - 学架构、做教程、复盘 -> AI-05
3. 复制对应 `START_PROMPT.md`。
4. 再贴派工台里的“复制任务模板”。
5. 任务结束时要求它告诉你：应该写哪条 worklog，是否需要 handoff。

成功标准：下次 AI 可以从文件继续，而不是只能从聊天记录继续。

---

## 试一次 AgentOps Doctor

适合：你想快速看到这个系统的诊断能力。

1. 打开 `agentops-doctor/README.zh-CN.md`。
2. 复制这个例子给 AI：

```yaml
handoff_id: demo_003
status: processing
lease_owner: agent_a
lease_expires_at: 2020-01-01T10:00:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
```

3. 要求它按 AgentOps Doctor 判断：skip / wait / retry / rework / block。
4. 期望答案：

```text
processing + expired lease + same source_fingerprint
-> retry
-> keep same handoff_id
-> create new attempt_id
-> refresh lease_owner and lease_expires_at
```

成功标准：你能看懂为什么不是新建一个 handoff，而是用同一个 `handoff_id` 重试。
