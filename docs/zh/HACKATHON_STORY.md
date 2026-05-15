# 黑客松展示故事

## 一句话

Solo-AI-Company-OS 是母体，AgentOps Doctor 是第一个公开诊断模块。

## 为什么现场不直接展示完整 OS

完整 OS 太大。它包含 AI 员工、worklog、handoff、skill、dashboard、Obsidian 双链、隐私边界和人类审批门。

现场三分钟讲完整 OS，观众会觉得像在读系统论文。

所以现场只展示一个能立刻试用的切片：

```text
AgentOps Doctor
```

## AgentOps Doctor 解决什么

多 Agent 系统常见问题：

- 同一个任务被重复执行；
- handoff 卡在 processing；
- lease 已经过期但没人接手；
- worklog 只有结论，没有 tools_used 和 verification；
- 公开回答里有证据不足的 claim；
- 有价值经验没有进入 skill evolution。

AgentOps Doctor 的输出是诊断报告，不是调度系统。

## 现场故事线

```text
先讲痛点：多 agent 不是缺聪明，缺运行纪律。
再给输入：一段脱敏 handoff 或 worklog。
再出报告：skip / wait / retry / rework / block。
最后回到母体：这只是 Solo-AI-Company-OS 的第一个公开模块。
```

## 现场边界

- 不要求别人给代码；
- 不要求别人给真实数据；
- 只看脱敏字段；
- 只输出建议，不碰对方系统；
- 收集实战笔记用于下一轮迭代。

## 结尾句

```text
AgentOps Doctor 是开源 Solo-AI-Company-OS 的第一个可安装诊断模块。
它证明了一件事：多 Agent 系统需要的不只是更聪明的模型，还需要可复查的运行纪律。
```
