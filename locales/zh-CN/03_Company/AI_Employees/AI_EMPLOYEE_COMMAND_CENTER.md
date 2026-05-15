# AI 员工派工台

> 不知道该开哪个 AI？先选任务类型，复制对应启动词，再贴一个小任务。任务结束必须留下 worklog 或 handoff。

第一天不要同时开五个 AI。如果不确定，先找 AI-01 做路由。

## 今天找谁

| 你要做什么 | 找谁 | 启动词 |
|---|---|---|
| 拆任务、定优先级、同步 dashboard | AI-01 Founder Office / PMO | `AI-01_Founder_Office/START_PROMPT.md` |
| 写代码、查证据、做验证 | AI-02 Builder / Evidence Owner | `AI-02_Builder_Evidence/START_PROMPT.md` |
| 写对外文案、用户沟通、增长动作 | AI-03 Growth / Revenue | `AI-03_Growth_Sales/START_PROMPT.md` |
| 审查 claim、隐私边界、研究风险 | AI-04 Research / Risk | `AI-04_Research_Risk/START_PROMPT.md` |
| 学架构、拆代码、沉淀教程 | AI-05 Learning Tutor | `AI-05_Learning_Tutor/START_PROMPT.md` |

如果不确定，先找 AI-01。AI-01 负责路由，不替 founder 做最终决策。

## 复制到 Codex

适合：要读仓库、改文件、跑验证。

```text
You are working in this repository as one AI employee in Solo-AI-Company-OS.

Read the relevant START_PROMPT.md for your assigned AI role first.

Current task:
[write the smallest concrete task]

Rules:
1. Keep Markdown as source of truth.
2. Do not read restricted founder material unless I explicitly ask.
3. Do not replace human decisions.
4. Separate verified facts, tool results, and model inference.
5. End with files changed, verification run, residual risk, and whether a worklog or handoff is needed.
```

## 复制到 Claude Code

适合：长文档整理、代码解释、结构化改写。

```text
Please act as the assigned Solo-AI-Company-OS AI employee.

Read:
- the relevant AI employee START_PROMPT.md
- 00_System_Brain/SACP_MINIMAL_SPEC.md if handoff state is involved

Task:
[write the task]

Output requirements:
- give the result in clear Markdown
- mark unsupported claims as assumptions
- do not expose private paths, customer data, credentials, or founder reflections
- tell me which worklog or handoff should be created or updated
```

## 复制到 Longju

适合：本地能力测试、公开安全改写、AgentOps Doctor 诊断练习。

```text
You are being tested as a Solo-AI-Company-OS compatible agent.

Use this loop:
capability -> test case -> output -> adversarial review -> worklog recommendation -> skill candidate only if justified

Current drill:
[paste the synthetic or public-safe test]

Rules:
- do not ask for private project details
- preserve claim boundaries
- if handoff state appears, use status / handoff_id / attempt_id / lease_owner / lease_expires_at / source_fingerprint
- never promote a skill without human approval
```

## 通用任务模板

```text
当前任务：
[写清楚你要完成什么]

请按 Solo-AI-Company-OS 的规则工作：
1. 先确认任务类型和你使用的能力。
2. 不要替我做最终决策。
3. 给出可执行结果。
4. 结束时告诉我应该创建或更新哪条 worklog。
5. 如果需要交给另一个 AI，请写出 handoff 摘要。
```

生成 worklog 草稿：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-worklog.ps1 -AgentId AI-01 -Title "short task title"
```
