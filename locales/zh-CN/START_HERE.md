<!-- locale: zh-CN -->

# 从这里开始

如果你第一次打开这个项目，只记住一句话：

```text
先选入口，再开 AI。
```

你不需要先理解所有文件夹。Solo-AI-Company-OS 先帮你解决一个最具体的问题：

```text
让 AI 工作不要只留在聊天窗口里。
```

---

## 你现在应该打开哪里

| 场景 | 打开 |
|---|---|
| 我第一天只想快速跑通 | `docs/zh/DAY_1_CHINESE_USER_PATH.md` |
| 我不知道该用哪个 AI | `03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md` |
| 我的 handoff / worklog 卡住了 | `agentops-doctor/README.zh-CN.md` |
| 我想看懂整个系统 | `docs/zh/ONE_PAGE_VISUAL_GUIDE.md` |

---

## 第一次使用流程

1. 打开 `OBSIDIAN_HOME.md`。
2. 打开 `03_Company/AI_Employees/AI_EMPLOYEE_COMMAND_CENTER.md`。
3. 选一个 AI 员工。
4. 复制对应 `START_PROMPT.md` 到你的 AI 聊天窗口。
5. 给它一个小任务。
6. 任务结束后生成 worklog 草稿：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-worklog.ps1 -AgentId AI-01 -Title "first setup loop"
```

---

## 第一轮成功的标准

你不需要完成整个系统配置。第一轮只要得到：

- 一个明确的下一步；
- 一个知道自己职责的 AI 员工；
- 一条可交接的 worklog 草稿；
- 一个下次还能继续的文件入口。

如果你已经做到这些，就算成功。
