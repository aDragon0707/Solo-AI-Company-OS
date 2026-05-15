# 前 30 分钟

目标：不要读完整系统。只跑通一个最小闭环。

## 0-5 分钟：打开主入口

打开：

```text
OBSIDIAN_HOME.md
```

你只需要看三条入口：

- AI 员工派工台；
- AgentOps Doctor；
- 一页纸架构。

## 5-10 分钟：选 AI-01

打开：

```text
03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md
```

如果不确定选谁，先选 AI-01。

复制：

```text
03_Company/AI_Employees/AI-01_Founder_Office/START_PROMPT.md
```

## 10-20 分钟：让 AI-01 拆第一个小任务

给 AI-01：

```text
请帮我完成第一次 setup loop。
列出接下来 3 个动作、当前 blocker，以及这次结束后应该创建什么 worklog。
不要虚构业务进展。
```

## 20-30 分钟：生成 worklog 草稿

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-worklog.ps1 -AgentId AI-01 -Title "first setup loop"
```

填入：

- task；
- tools_used；
- work completed；
- verification；
- residual risk；
- evolution decision。

## 成功标准

你现在应该拥有：

- 一个可继续的入口；
- 一个明确的 AI 员工；
- 一条 worklog 草稿；
- 下次继续工作的上下文。

这就够了。不要第一天追求完整。
