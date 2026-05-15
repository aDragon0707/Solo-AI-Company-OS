# 第一次运行示例

这是一个完全虚构的第一天示例，用来说明系统怎么跑。

## 目标

```text
我想用 AI 帮我整理一个产品原型，但不希望进展只留在聊天窗口里。
```

## 第一步：选 AI 员工

打开：

```text
03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md
```

这个任务需要拆解和协调，所以选择：

```text
AI-01 Founder Office / PMO
```

复制：

```text
03_Company/AI_Employees/AI-01_Founder_Office/START_PROMPT.md
```

## 第二步：给 AI 的任务

```text
请帮我把“整理产品原型”拆成今天可以完成的 3 个动作。
不要替我做战略决策。
请列出当前 blocker、建议交给哪个 AI 员工，以及任务结束后应该写什么 worklog。
```

## 第三步：AI 输出后你要保存什么

保存一条 worklog 草稿：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-worklog.ps1 -AgentId AI-01 -Title "product prototype planning"
```

在 worklog 中补充：

```yaml
tools_used:
  - AI-01 planning prompt
verification:
  - human reviewed next three actions
evolution_decision: record
```

## 第四步：如果要交给下一个 AI

生成 handoff 草稿：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-handoff.ps1 -FromAgent AI-01 -ToAgent AI-02 -TaskTitle "prototype evidence check"
```

## 第五步：如果状态卡住

打印 AgentOps Doctor 示例：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\doctor-example.ps1 -Case handoff-expired
```

用它检查当前 handoff 是应该 wait、retry，还是需要 human 介入。

## 成功标准

第一次成功不是“系统全填完”，而是：

- 你知道该找哪个 AI；
- AI 留下了 worklog；
- 下次可以从文件继续；
- 有问题可以用 AgentOps Doctor 诊断。
