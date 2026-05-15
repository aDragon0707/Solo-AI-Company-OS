---
type: drills
protocol: SACP/0.1
id: drills_zh_20260506
status: draft
owner: founder
created_at: 2026-05-06T22:20:00+08:00
updated_at: 2026-05-06T22:20:00+08:00
verification: partial
---

# SACP 演练题

## 练习 1：completed 是否触发？

输入：

```yaml
status: completed
downstream_handoff: AI-03
handoff_status: requested
handoff_id: handoff_abc
```

问题：

是否每次读取都触发 AI-03？

答案：

```text
否。
status: completed 是事实状态，不是触发事件。
downstream_handoff 是目标，不是重复触发信号。
必须检查 handoff_id 是否已被 receiving worklog 引用。
```

## 练习 2：receiving completed

输入：

```yaml
source_handoff_id: handoff_abc
status: completed
```

判断：

```text
dedup skip。
不新建 handoff。
不重复触发。
不增 attempt_id。
```

## 练习 3：processing + active lease

输入：

```yaml
source_handoff_id: handoff_abc
status: processing
lease_owner: AI-03
lease_expires_at: future_time
```

判断：

```text
wait。
不重复触发。
等待 lease_owner。
```

## 练习 4：processing + expired lease

输入：

```yaml
source_handoff_id: handoff_abc
status: processing
lease_owner: AI-03
lease_expires_at: past_time
```

判断：

```text
retry。
不新建 handoff_id。
递增 attempt_id。
设置新 lease。
```

## 练习 5：输入变了

输入：

```text
同一个 handoff_id，但 human decision 改了。
```

判断：

```text
可以创建新 handoff_id。
因为任务语义已经变了。
```

## 练习 6：经验是否 promote？

输入：

```text
AI 发现一个重复出现的好方法。
```

问题：

AI 是否能自己 promote？

答案：

```text
不能。
AI 可以 distill 成 skill 草稿。
promote 必须人类批准。
```

## 练习 7：评委追问

问题：

```text
这和 prompt 模板有什么区别？
```

答案：

```text
Prompt 模板通常只影响一次对话。
SACP worklog 和 skill 是持久文件。
不同 agent、不同窗口、不同时间都可以重新读取。
```

## 练习 8：数学工具诚实性

问题：

```text
一个 agent 用 float 算出 0.0019807923169267708。
它能说这是 exact 吗？
```

答案：

```text
不能。
必须保留 Fraction 作为精确真值。
float 是二进制近似，打印结果不等于数学精确值。
```

## 练习 9：latest 信息检索

问题：

```text
问 current latest Python version。
只 fetch python-3140 release page 够吗？
```

答案：

```text
不够。
必须先查 downloads index 或 release listing，再查具体版本详情页。
```

## 练习 10：上台一句话

问题：

```text
请用一句话讲清项目。
```

答案：

```text
Solo-AI-Company-OS 让一个人管理一组 AI 员工：人做决定，AI 执行，worklog 记录经验，skill 让经验复用。
```

