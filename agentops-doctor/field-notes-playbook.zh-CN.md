# AgentOps Doctor 现场实战手册

目标：上午三小时内让别人快速试用，留下真实反馈。

## 核心打法

不要推销“完整 OS”。现场只讲一个点：

```text
你有 agent 状态卡住、重复执行、worklog 不可复查的问题吗？
我这有一个 1 分钟诊断工具。
```

## 第 0-30 分钟：布场

准备两个可视化示例：

```text
示例 A:
输入：handoff processing, lease expired
输出：retry with new attempt_id, same handoff_id

示例 B:
输入：worklog 有结论，但 tools_used / verification 为空
输出：dirty worklog, cannot reproduce
```

准备好：

- [输入模板](templates.zh-CN.md)
- [公开案例库](cases.zh-CN.md)
- 一句反馈模板

## 第 30-120 分钟：逐个交流

10 句话术：

1. “你们 agent 有没有重复执行过同一个任务？”
2. “不用给我代码，贴一段脱敏状态字段就行。”
3. “我帮你判断该 skip、wait、retry、rework 还是 block。”
4. “如果卡在 processing，我可以帮你看 lease 是有效还是过期。”
5. “这个工具只出诊断报告，不改你的系统。”
6. “没有真实日志也没事，我有构造模板，现场 30 秒跑一个。”
7. “如果你有 worklog，我可以查 tools_used 和 verification 是否完整。”
8. “它主要防三件事：重复执行、脏状态、经验没沉淀。”
9. “你拿诊断结果去修自己的 agent。如果有用，帮我留一句实战笔记。”
10. “它是 Solo-AI-Company-OS 的公开切片，不需要你先理解完整 OS。”

## 第 120-180 分钟：收集反馈

反馈模板：

```text
你的环境：
用了 AgentOps Doctor 查什么：
发现了什么问题：
最有用的诊断是什么：
希望下个版本增加什么：
是否允许匿名引用这条反馈：
```

## 不要做

- 不要索要真实代码或未脱敏日志；
- 不要展示私有项目路径；
- 不要讲太多底层 OS；
- 不要承诺自动修复；
- 不要说“绝对能定位 bug”；
- 不要让别人觉得这是一套必须迁移的框架。

## 成功标准

- 至少 5 个真实试用或模板试用；
- 至少 3 条可引用反馈；
- 至少 1 个新的诊断 case；
- 现场讲述能在 3 分钟内完成。
