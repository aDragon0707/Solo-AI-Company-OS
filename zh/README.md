> 🌐 Language: **简体中文** | [English](../README.md)

# Solo-AI-Company-OS

**别再让你的 AI 公司迷失在聊天历史里了。**

一个面向人类协调 AI 员工的 Markdown 操作系统，具备持久记忆、清晰决策、工作日志和无缝交接能力。

Solo-AI-Company-OS 帮助你将从散落各处的 AI 对话转化为创始人决策、基于角色的 AI 操作员、持久的工作日志、交接流程以及一个真正可信的学习闭环。

这不是一份提示词合集。这是一个用于记忆、委派、审查和创始人判断的操作系统。

```text
人类决策。AI 执行。Markdown 记录。工作日志交接。
```

![Solo-AI-Company-OS 总览图](assets/solo-ai-company-os-map.svg)

---

## 概览

| 如果你的 AI 工作感觉像…… | 这个系统将为你提供…… |
|---|---|
| 决策埋没在旧聊天记录中 | 正式的创始人决策日志 |
| 每次 AI 对话都冷启动 | 稳定的角色提示和开工前必读文件 |
| 进度报告转瞬即逝 | 可交接的工作日志 |
| 策略与混乱思考混为一谈 | 独立的收件箱、决策和回顾分类账 |
| 创始人逐渐失去技术信心 | 以 AI-05 为导师的学习实验室 |
| Obsidian 变成另一个文件夹迷宫 | 链接地图和 AI 文本维护协议 |

这个系统刻意保持"朴实无华"的最佳状态：纯文本文件、明确的规则、持久的交接能力，不依赖任何隐藏的平台。

---

## 适用人群

- **独立创始人（Solo Founder）和独立开发者（Indie Hacker）**：正在借助 AI 构建复杂产品。
- **研究人员和顾问**：需要管理多个 AI 上下文窗口。
- **非技术背景的创始人**：使用 AI 理解代码库和技术系统。
- **运营者**：需要 AI 工作留下持久痕迹，而不是消失在聊天历史中。

针对 Obsidian 的 MOC（Map of Content）导航进行了优化，但本质上只是 Markdown。你可以在 Obsidian、VS Code、Cursor 或任何编辑器中使用它。

如果你希望在构建更重的工具之前拥有一个轻量级的公司记忆系统，请使用本系统。

如果你想要的是一个自动运行的 Agent 平台、一个任务应用克隆、一个个人知识管理主题或一组一次性提示词，那么本系统不适合你。

---

## 15 分钟快速上手

不要过度思考架构。从一个 AI 员工和一份工作日志开始。

最简便的 Windows 设置方式：

1. 下载 release ZIP 包。
2. 解压缩。
3. 双击 `INSTALL_WINDOWS.bat`。
4. 在 Obsidian 中打开生成的文件夹。
5. 打开 `FIRST_30_MINUTES.md`。

一条命令完成设置：

```powershell
powershell -ExecutionPolicy Bypass -File .\INSTALL.ps1
```

安装程序会询问几个问题，创建你的 vault，然后打开生成的文件夹。

高级自助设置：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-vault.ps1 `
  -OutputPath 'F:\Your-New-Vault' `
  -CompanyName 'Your Company' `
  -FounderName 'Your Name' `
  -ProjectName 'Your Project' `
  -ProductName 'Your Product' `
  -CreateDay1Worklog
```

或者手动设置：

1. **打开 vault**
   在 Obsidian、VS Code、Cursor 或任何 Markdown 编辑器中打开此文件夹。

2. **认领系统**
   打开 `FOUNDER_START_HERE.md`，将 `My AI Collaboration OS`、`My AI Collaboration OS` 和 `My AI Collaboration OS` 替换为你自己的内容。

3. **写下你的第一条创始人决策**
   打开 `01_Founder/FOUNDER_Decision_Log.md` 并创建：
   `DEC-YYYYMMDD-001 - Establish AI Operating Boundaries`（建立 AI 操作边界）。

4. **聘用 AI-01**
   打开 `03_Company/AI_Employees/AI-01_Founder_Office/START_PROMPT.md`，复制提示词并粘贴到你的 LLM 聊天中。

   AI-01 负责协调。它不做创始人决策。

5. **创建第一份工作日志**
   在 AI-01 给出优先级后，使用以下模板保存结果：
   `03_Company/AI_Worklogs/WORKLOG_TEMPLATE.md`。

你现在拥有了持久的公司记忆。欢迎来到第一天。

想先看看系统长什么样再填充自己的 vault？打开 `EXAMPLE_DAY_1.md`。

想要安装后最短的上手路径？打开 `FIRST_30_MINUTES.md`。

使用 Obsidian？设置完成后打开 `02_Dashboards/DASHBOARD_Link_Map.md`。生成的 vault 包含一个入门 wiki-link 地图、`00_System_Brain/AI_Text_Maintenance_Protocol.md` 和 `00_System_Brain/AI_Obsidian_Link_Maintenance_Prompt.md`，用于请 AI 助手保持导航、仪表板和交接的整洁，而不改变创始人决策。

---

## 为什么存在这个系统

使用 AI 的独立创始人常常遇到同样的问题：

- 重要决策消失在聊天历史中
- 多个 AI 窗口丢失上下文或重复工作
- AI 输出与创始人决策混淆
- 市场野心污染了项目真相
- 创始人逐渐无法理解自己正在构建的系统

Solo-AI-Company-OS 通过将 Markdown vault 转化为一个轻量级公司记忆系统来解决这些问题。

核心原则很简单：

```text
创始人做决策。AI 员工执行、记录、审查和教学。
```

---

## 五大支柱

### 1. 创始人决策与思考系统

创始人有三个独立分类账：

- `01_Founder/FOUNDER_Thinking_Inbox.md`：存放原始想法、担忧、创意和未解决的问题
- `01_Founder/FOUNDER_Decision_Log.md`：存放所有 AI 员工必须遵守的正式决策
- `01_Founder/FOUNDER_Retrospective_Log.md`：用于每日或每周反思

原始思考可以杂乱无章。正式决策需要结构化、注明日期且可审查。回顾将经验转化为更好的未来决策。

### 2. AI 问责与数据留存

AI 工作者被视为员工，拥有角色、边界、启动提示词和工作日志。

每个 AI 员工都有：

- `ROLE.md`
- `START_PROMPT.md`
- 明确的职责
- 禁止的行为
- 开工前必须阅读的文件
- 任务结束后的报告要求

每项已完成的任务都必须为下一个 AI 留下足够的上下文，使其无需猜测就能继续。

### 3. 项目学习实验室

创始人拥有一个专属的学习区域，不与生产工作混在一起。

学习风格是：

```text
架构意图优先，代码解构其次。
```

AI-05 会先讲解模块为什么存在、它处于什么位置、它控制什么风险，然后才讲解关键路径上的代码是如何工作的。

### 4. 公司状态与项目真相分离

公司材料可以总结已验证的真相，但不能替代它。

使用这个通用的项目真相链：

```text
[数据采集组件] -> [完整性验证] -> [分析输出]
```

面向市场的语言必须位于已验证项目真相的下游。

### 5. Obsidian MOC 导航

vault 使用内容地图（MOC）文件作为导航枢纽。

`OBSIDIAN_HOME.md` 是前门。MOC 文件连接：

- 创始人决策
- AI 员工
- 公司运营
- 项目证据
- 演示资产
- 账户工作区
- 学习实验室

目标是避免在文件夹树中迷失方向。人类创始人和 AI 上下文窗口都从稳定的入口点开始。

V1 版本还包括 `02_Dashboards/DASHBOARD_Link_Map.md`（一个入门 Obsidian 图形地图），以及一个 AI 文本维护协议，用于保持链接、仪表板、地图和交接的有用性，而不改变笔记的含义。

---

## 默认 AI 团队

| AI | 角色 | 职责 |
|---|---|---|
| AI-01 | 创始人办公室 / PMO | 优先级、路由、仪表板、状态纪律 |
| AI-02 | 构建者 / 证据负责人 | 项目真相、验证、实施质量 |
| AI-03 | 增长 / 收入 | 客户、外联、报价、管道 |
| AI-04 | 研究 / 风险 | 声明边界、敏感语言、审查 |
| AI-05 | 学习导师 | 创始人学习、架构讲解、作业审查 |

---

## 日常操作循环

1. 打开 `OBSIDIAN_HOME.md`。
2. 阅读 `01_Founder/FOUNDER_Decision_Log.md`。
3. 请 AI-01 给出最高优先级事项和阻碍因素。
4. 只打开任务所需的 AI 员工。
5. AI 读取其角色、提示词、仪表板和工作日志索引。
6. AI 完成任务并撰写工作日志。
7. AI-01 更新公司状态和协调信息。
8. 创始人记录新的决策或回顾笔记。

---

## 这个系统不是什么

本项目不是：

- 一个后端应用程序
- 一个客户关系管理系统
- 一个法律合规系统
- 创始人判断力的替代品
- 一组通用提示词

它是一个结构化的 Markdown 操作系统，用于有纪律地运行 AI 辅助工作。

---

## 第一天之后

一旦快速上手流程正常运行：

1. 将 `OBSIDIAN_HOME.md` 作为稳定的前门。不要重命名它。
2. 在 `03_Company/AI_Employees/` 下自定义 AI 员工角色。
3. 使用 `03_Company/AI_Worklogs/WORKLOG_INDEX.md` 跟踪持久的工作历史。
4. 当创始人需要理解架构或代码时，使用 `04_Learning/`。
5. 只有在 V1 版本已经有用之后，才阅读 `00_System_Brain/V2_Cognitive_OS_Roadmap.md`。

---

## 示例与发布文件

- `CODEX_RESTART_PROMPT.md`：让全新的 Codex 会话在重新安装后恢复项目上下文。
- `FIRST_30_MINUTES.md`：为新用户提供最精简的、有用的第一天操作循环。
- `EXAMPLE_DAY_1.md`：展示一个完全虚构的系统内第一天示例。
- `CONTRIBUTING.md`：定义什么样的开源贡献适合本项目。
- `LAUNCH_PLAYBOOK.md`：记录推荐的公开发布和盈利路径。
- `PRODUCT_BOUNDARY.md`：定义免费 Core 和未来 Pro Pack 的边界。
- `PROJECT_STATUS.md`：跟踪维护者视角的发布进度，不修改可复用的模板文件。
- `RELEASE_CHECKLIST.md`：定义公开发布前的验证和打包流程。
- `00_System_Brain/AI_Text_Maintenance_Protocol.md`：定义 AI 如何维护仪表板、地图、链接、索引和交接，而不取代创始人判断。
- `03_Company/User_Research/`：包含公开的用户痛点研究提示和综合分析，用于改进定位和上手体验。
- `scripts/init-vault.ps1`：无需付费工具或网络调用即可生成定制化的 vault。
- `scripts/validate-release.ps1` 和 `scripts/package-release.ps1`：支持自助发布检查和 ZIP 打包。
- `LICENSE`：使核心模板可用、可复刻、可混编。

---

## 核心规则

当 AI 输出与创始人最新的明确决策冲突时，创始人决策日志为准。

当市场野心与已验证的项目真相冲突时，已验证的真相为准。
