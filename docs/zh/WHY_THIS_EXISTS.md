# 为什么这不是 prompt collection

Prompt collection 解决的是“怎么让 AI 这一次回答得更好”。

Solo-AI-Company-OS 解决的是另一个问题：

```text
这一次 AI 做完以后，下一次谁能接着做？
```

## 聊天窗口的问题

聊天窗口很适合探索，但不适合当公司记忆：

- 决策和想法混在一起；
- AI 输出和事实证据混在一起；
- 多个 AI 窗口互相不知道对方做了什么；
- 重复有效的方法没有沉淀；
- 出错后很难复盘到底是哪一步坏了。

## OS 的作用

这个 OS 把 AI 工作拆成几个稳定对象：

- `decision`：人类正式决定；
- `worklog`：AI 做了什么；
- `handoff`：谁接手下一步；
- `skill`：哪些经验可以复用；
- `dashboard`：现在状态是什么；
- `doctor`：哪里可能卡住或越界。

这些对象都是 Markdown 文件。它们能被人读，也能被 AI 读。

## 为什么要有人类 promotion gate

AI 可以建议“这条经验应该沉淀成 skill”，但不能自己批准。

因为一旦 skill 进入正式运行路径，它就会影响未来行为。这个权力必须留给人类。

```text
worklog -> record -> distill -> promote candidate -> human approve
```

## 最小有用版本

你不需要一开始就理解整个 OS。

只要跑通这个小循环：

```text
选 AI 员工 -> 执行任务 -> 写 worklog -> 必要时 handoff
```

系统就已经开始把一次性聊天变成长期资产。
