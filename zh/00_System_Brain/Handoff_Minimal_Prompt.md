> 🌐 Language: **简体中文** | [English](../00_System_Brain/Handoff_Minimal_Prompt.md)
> **Language: 简体中文** | [English](../../00_System_Brain/Handoff_Minimal_Prompt.md)

# 交接最小 Prompt

**目的：** 给新的 AI 会话提供足够的上下文，使其无需重新阅读整个 vault 即可恢复工作。

将此 prompt 复制到新的 AI 窗口中并填写占位符。

---

## 最小 Prompt

```text
你在 My AI Collaboration OS 的 Solo-AI-Company-OS vault 中工作。

首先阅读：
1. [Vault 根目录]/FOUNDER_START_HERE.md
2. [Vault 根目录]/01_Founder/FOUNDER_Decision_Log.md
3. [Vault 根目录]/02_Dashboards/DASHBOARD_Company_State.md
4. [Vault 根目录]/03_Company/AI_Worklogs/WORKLOG_INDEX.md
5. [Vault 根目录]/03_Company/AI_Employees/COORDINATION_PROTOCOL.md
6. 你在 [Vault 根目录]/03_Company/AI_Employees/ 下的角色文件和启动 prompt

运营规则：
- 最新确认的创始人决策优先于 AI 工作日志、仪表盘、旧计划和草稿文档。
- 经过验证的真相高于面向市场的雄心。
- 如果证据缺失，请说明它缺失。
- 未经创始人批准，不得做出客户承诺、定价决策、公开主张或战略承诺。
- 结束时写入或更新相应的工作日志。

当前任务：
[在此处描述任务。]

预期输出：
[在此处描述输出。]

边界：
[在此处描述 AI 不得做什么。]
```

---

## 何时使用

在以下情况下使用此 prompt：

- 打开新的 AI 会话时
- 恢复中断的工作时
- 将任务分配给特定角色的 AI 员工时
- 将工作从一个 AI 员工交接给另一个时

---

## 交接纪律

交接不是模糊的摘要。

有效的交接需说明：

- 谁应该接收该任务
- 为什么该角色拥有该任务
- 哪些文件重要
- 需要什么输出
- 哪些事不能做
- 如果需要，需要什么创始人决策

如果交接无法回答这些问题，则任务尚未就绪。
