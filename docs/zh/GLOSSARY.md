# 核心术语表

| 术语 | 中文解释 |
|---|---|
| AI Company OS | 用 Markdown 管理 AI 员工、决策、工作日志、接力和能力进化的操作系统 |
| AgentOps Doctor | 从 OS 中切出的公开诊断模块，用来检查 agent 运行状态 |
| AI Employee | 一个有职责、边界和启动词的 AI 工作身份，不是“人格” |
| Worklog | AI 完成重要任务后留下的可交接工作记录 |
| Handoff | 一个 AI 把任务交给另一个 AI 或下一轮自己的接力记录 |
| handoff_id | 接力任务的幂等键，用来防止重复执行 |
| attempt_id | 同一个 handoff 的第几次尝试 |
| lease | 临时占用权，表示某个 agent 正在处理这个任务 |
| source_fingerprint | 输入内容或任务状态的指纹，用来判断任务是否已经变化 |
| Claim Boundary | 声明边界：每个结论必须能追溯到证据，不能把推断说成事实 |
| Adversarial Review | 反向审查：专门找漏洞、越界、伪确定性和遗漏证据 |
| Skill Distillation | 从重复有效的 worklog 中提炼可复用能力 |
| Human Promotion Gate | 只有人类能批准某个 skill 进入正式运行路径 |
| Markdown Source of Truth | Markdown 文件是真相来源，而不是聊天窗口里的模糊记忆 |
| Obsidian Backlinks | Obsidian 双链，用来让 dashboard、MOC、worklog、skill 互相可达 |

## 最重要的区分

| 不要混淆 | 正确理解 |
|---|---|
| worklog 不是触发器 | worklog 是历史记录 |
| handoff_id 不是每次 retry 都新建 | 同一任务 retry 只增加 attempt_id |
| skill 不是 AI 自己想加就加 | promote 必须人类批准 |
| dashboard 不是决策源 | dashboard 只是状态摘要 |
| AgentOps Doctor 不是完整 OS | 它只是第一个公开诊断模块 |
