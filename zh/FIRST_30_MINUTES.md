> 🌐 Language: **简体中文** | [English](../FIRST_30_MINUTES.md)

# 前 30 分钟

**目的：** 帮助新创始人开始使用 Solo-AI-Company-OS，无需先了解整个系统。

只执行本页面上的步骤。在这些步骤完成之前，忽略 vault 中其余的内容。

---

## 0. 打开 Vault

在 Obsidian、VS Code、Cursor 或任何 Markdown 编辑器中打开生成的文件夹。

从以下位置开始：

```text
OBSIDIAN_HOME.md
```

如果你在 Obsidian 中，请保持这两个笔记处于打开状态：

- [[zh/OBSIDIAN_HOME|Obsidian 主页]]
- [[zh/02_Dashboards/DASHBOARD_Company_State|公司状态仪表板]]

---

## 1. 写一条创始人决策

打开：

```text
01_Founder/FOUNDER_Decision_Log.md
```

添加一条决策：

```text
## DEC-YYYYMMDD-001 - 建立 AI 操作边界

日期：
状态：活跃
决策负责人：创始人

决策：
AI 员工可以协助执行、组织、审查和维护工作，但创始人决策仍然是权威来源。

原因：
系统需要在 AI 输出和创始人判断之间设定明确的边界。

AI 影响：
- AI 在工作前必须阅读创始人决策。
- AI 工作日志不能覆盖创始人决策。
- AI 必须标注不确定性，而不是猜测。
```

这足够第一天使用了。不要试图填满每一个模板。

---

## 2. 打开 AI-01

打开：

```text
03_Company/AI_Employees/AI-01_Founder_Office/START_PROMPT.md
```

将提示词复制到你的 AI 聊天中。

然后添加这条创始人指令：

```text
AI-01，请阅读创始人决策日志、Obsidian 主页、公司状态仪表板、AI 文本维护协议和工作日志索引。

请告诉我：
1. 让这个 vault 变得有用的前 3 个优先级
2. 当前的阻碍因素
3. 缺少哪些创始人决策
4. 下一步我应该更新哪个文件
5. 本次会话后应该创建什么工作日志

不要虚构业务进展。只当作是第一天的设置。
```

---

## 3. 更新公司状态仪表板

打开：

```text
02_Dashboards/DASHBOARD_Company_State.md
```

只填写明显的部分：

- 当前优先级
- 当前阻碍因素
- 下一个需要的创始人决策
- 下一个 AI 负责人

如果不确定，请写：

```text
尚未验证
```

不要让仪表板看起来比源文件所支持的状态更成熟。

---

## 4. 保存第一份工作日志

打开：

```text
03_Company/AI_Worklogs/WORKLOG_TEMPLATE.md
```

在 AI-01 会话结束后，根据模板创建一份新的工作日志。

命名为如下格式：

```text
03_Company/AI_Worklogs/AI-01_Worklog_YYYYMMDD_First_Coordination.md
```

工作日志应说明 AI-01 读了什么、它推荐了什么、什么发生了变化，以及哪些事项仍需要创始人输入。

---

## 5. 停下来

完成以上步骤后，请停下来。

你已经创建了最小循环：

```text
创始人决策 -> AI-01 协调 -> 仪表板更新 -> 工作日志交接
```

这个循环就是产品本身。文件夹结构只是为了支撑它而存在。

---

## 暂时不要做什么

不要：

- 自定义每一个 AI 角色
- 填满每一个模板
- 创建复杂的图形
- 将粗糙的想法转化为决策
- 同时让多个 AI 员工工作
- 把设置当成业务进展

系统通过重复的小循环变得有用，而不是通过一次庞大的设置会话。

---

## 下一次会话

下一次会话，请再次从以下位置开始：

```text
OBSIDIAN_HOME.md
```

然后阅读：

- [[zh/01_Founder/FOUNDER_Decision_Log|创始人决策日志]]
- [[zh/02_Dashboards/DASHBOARD_Company_State|公司状态仪表板]]
- [[zh/03_Company/AI_Worklogs/WORKLOG_INDEX|工作日志索引]]

询问 AI-01 接下来应该做什么。
