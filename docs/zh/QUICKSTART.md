# 中文快速上手

## 1. 安装

下载 release ZIP，解压后双击：

```text
INSTALL_WINDOWS.bat
```

或者运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\INSTALL.ps1
```

安装器询问语言时选择：

```text
zh-CN
```

---

## 2. 打开主入口

用 Obsidian、VS Code、Cursor 或任意 Markdown 编辑器打开生成的 vault。

先打开：

```text
OBSIDIAN_HOME.md
```

然后按你的目的选：

- `AI_EMPLOYEE_COMMAND_CENTER.md`：开始派工；
- `agentops-doctor/README.zh-CN.md`：做运行体检；
- `docs/zh/ONE_PAGE_VISUAL_GUIDE.md`：看架构图。

---

## 3. 启动第一个 AI 员工

如果你只是想开始，不确定找谁，先用 AI-01：

```text
03_Company/AI_Employees/AI-01_Founder_Office/START_PROMPT.md
```

复制里面的提示词到 AI 聊天窗口，再补一句：

```text
请用中文回答我。帮我完成第一次 setup loop：列出接下来 3 个动作、当前 blocker，以及这次结束后应该创建什么 worklog。
```

---

## 4. 生成第一条 worklog

任务结束后运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-worklog.ps1 -AgentId AI-01 -Title "first setup loop"
```

打开生成的文件，把 AI 做了什么、用了什么工具、验证了什么补进去。

---

## 5. 需要诊断时用 AgentOps Doctor

打印一个示例输入：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\doctor-example.ps1 -Case handoff-expired
```

把示例发给 AgentOps Doctor 或你的 AI，得到诊断报告。

---

## 6. 每天只做一个循环

```text
打开 Home
-> 选 AI 员工
-> 执行一个任务
-> 写 worklog
-> 必要时 handoff
-> 有重复价值再 distill 成 skill
```

先让系统跑起来，再让它变漂亮。
