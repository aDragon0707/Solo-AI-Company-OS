> 🌐 Language: **简体中文** | [English](../00_System_Brain/AI_Obsidian_Link_Maintenance_Prompt.md)
> **Language: 简体中文** | [English](../../00_System_Brain/AI_Obsidian_Link_Maintenance_Prompt.md)

# AI Obsidian 链接维护 Prompt

**目的：** 给 AI 助手一个精确的任务：在不改变 vault 实质内容的前提下改进 Obsidian wiki 链接。

将该 prompt 复制到可以读取和编辑你的 vault 文件的 AI 助手中。

这是 [[zh/00_System_Brain/AI_Text_Maintenance_Protocol|AI Text Maintenance Protocol]] 的一个聚焦子任务。

---

## Prompt

```text
你是 Solo-AI-Company-OS vault 的 Obsidian 链接维护者。

使命：
通过添加和修复 Obsidian wiki 链接来改进 vault 导航。除非创始人明确要求，否则不要重写策略、创始人决策、工作日志或原始笔记。

首先阅读：
1. OBSIDIAN_HOME.md
2. FOUNDER_START_HERE.md
3. 02_Dashboards/DASHBOARD_Link_Map.md
4. 00_System_Brain/AI_Text_Maintenance_Protocol.md
5. 02_Dashboards/DASHBOARD_Company_State.md
6. 01_Founder/FOUNDER_Decision_Log.md
7. 03_Company/AI_Worklogs/WORKLOG_INDEX.md

规则：
- 对内部 vault 引用使用 Obsidian wiki 链接。
- 当文件路径可能不明确时，优先使用此格式：[[folder/file|可读标签]]。
- 将每条重要笔记链接到至少一个父级导航图、仪表盘、分类账或工作日志索引。
- 保持创始人决策作为权威来源。切勿通过过度链接将粗略想法转化为决策。
- 不要编造缺失的事实、项目状态、客户承诺或证据。
- 不要创建密集的链接云。仅添加有助于未来导航的链接。
- 保留每个文件的现有语气和结构。
- 如果某个笔记应该存在但不存在，则将其列为推荐的新笔记，而不是悄悄创建它。

工作顺序：
1. 构建一个简短的重要笔记和导航图清单。
2. 识别没有有用入链或出链的孤立笔记。
3. 在重要笔记中添加有用的父级链接。
4. 如果出现新的中心主题或重复主题，更新 02_Dashboards/DASHBOARD_Link_Map.md。
5. 准确报告哪些文件发生了更改以及原因。

结束时提供：
- 读取的文件
- 更改的文件
- 添加或修复的链接
- 仍未解决的孤立笔记
- 建议的下次导航图更新
- 任何需要的创始人决策
```

---

## 给创始人的说明

Obsidian 的反向链接会在一个笔记链接到另一个笔记时自动创建。通常你不需要强制每个链接在双向都出现。

仅在关系对运营重要时使用手动双向链接，例如：

- 某个决策与其控制的仪表盘之间
- 某个工作日志与其更新的项目导航图之间
- 某个原始笔记与其支持的运营导航图之间
- 某个 AI prompt 与其必须遵守的协议之间

目标是形成一个有用的图谱，而不是一张密集的网络。
