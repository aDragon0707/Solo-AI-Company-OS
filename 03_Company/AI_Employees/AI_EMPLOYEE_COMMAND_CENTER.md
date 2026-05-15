# AI 员工派工台

> 不知道该开哪个 AI？先选任务类型，复制对应启动词，再贴一个小任务。任务结束必须留下 worklog 或 handoff。

第一天不要同时开五个 AI。如果不确定，先找 AI-01 做路由。

## 一句话规则

```text
AI 员工不是人格，是可复用的工作身份。
Human decides. AI executes. Worklog remembers.
```

---

## 今天找谁

| 你要做什么 | 找谁 | 打开启动词 | 期望输出 |
|---|---|---|---|
| 拆任务、定优先级、同步 dashboard | AI-01 Founder Office / PMO | `AI-01_Founder_Office/START_PROMPT.md` | 下一步、blocker、handoff、worklog 建议 |
| 写代码、查证据、做验证、整理 artifacts | AI-02 Builder / Evidence Owner | `AI-02_Builder_Evidence/START_PROMPT.md` | 实现/验证记录/证据边界 |
| 写对外文案、用户沟通、报价、增长动作 | AI-03 Growth / Revenue | `AI-03_Growth_Sales/START_PROMPT.md` | 对外草稿、行动清单、风险提示 |
| 审查 claim、隐私边界、研究风险、公开表达 | AI-04 Research / Risk | `AI-04_Research_Risk/START_PROMPT.md` | pass / revise / soften / remove |
| 学架构、拆代码、把经验变成教程 | AI-05 Learning Tutor | `AI-05_Learning_Tutor/START_PROMPT.md` | 解释、练习、学习材料 |

AI-01 负责路由，不替 founder 做最终决策。

---

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

---

## 通用任务模板

把对应 `START_PROMPT.md` 复制进 AI 聊天窗口后，再贴下面这段：

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

中文回复可加：

```text
请用中文回复，但继续遵守上面的角色、证据和边界规则。
```

---

## 每个 AI 的使用方式

### AI-01 Founder Office / PMO

适合：

- 今天不知道先做什么；
- 需要同步 dashboard；
- 需要把任务拆给 AI-02/03/04/05；
- 需要把 worklog 变成下一步计划。

结束时应该留下：

```text
priority summary + blockers + next handoff + worklog update
```

### AI-02 Builder / Evidence Owner

适合：

- 写代码或改文档结构；
- 跑验证；
- 查证据链；
- 判断某个输出是否有事实支撑。

结束时应该留下：

```text
files changed + tools used + verification + residual risk
```

### AI-03 Growth / Revenue

适合：

- 写 README、社区帖、现场话术；
- 设计用户反馈收集；
- 梳理商业价值；
- 准备 demo 表达。

结束时应该留下：

```text
public-facing draft + target audience + claim boundary notes
```

### AI-04 Research / Risk

适合：

- 公开发布前审查；
- 判断是否泄密；
- 检查 claim 是否过度；
- 把 PRIVATE 内容改写成 PUBLIC-safe 表达。

结束时应该留下：

```text
verdict + risky claims + required edits + publish boundary
```

### AI-05 Learning Tutor

适合：

- 你想真正学懂系统；
- 把复杂架构讲成人话；
- 把代码/文档拆成学习材料；
- 做复盘和练习题。

结束时应该留下：

```text
plain-language explanation + examples + homework or next reading
```

---

## 任务结束检查

每次重要任务结束前问：

1. 这次是否改变了状态？
2. 是否用到了工具或证据？
3. 下次 AI 能不能从文件继续？
4. 是否需要 handoff？
5. 这次经验应该 ignore / record / distill / promote candidate？

如果答案里有“是”，就写 worklog。

生成 worklog 草稿：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-worklog.ps1 -AgentId AI-01 -Title "short task title"
```

生成 handoff 草稿：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-handoff.ps1 -FromAgent AI-01 -ToAgent AI-02 -TaskTitle "handoff title"
```

---

## 相关文件

- `03_Company/AI_Employees/README.md`
- `03_Company/AI_Employees/COORDINATION_PROTOCOL.md`
- `03_Company/Skills/AGENT_SKILL_MATRIX.md`
- `03_Company/Skills/SKILL_LIBRARY.md`
- `03_Company/AI_Worklogs/WORKLOG_TEMPLATE.md`
- `03_Company/AI_Worklogs/WORKLOG_INDEX.md`
