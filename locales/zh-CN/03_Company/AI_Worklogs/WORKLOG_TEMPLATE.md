# 工作日志模板

**用途：** 记录 AI 做过什么，让下一个 AI 不用靠猜。

复制下面模板，新建一个 worklog 文件。

命名建议：

```text
AI-XX_Worklog_YYYYMMDD_short-topic.md
```

---

```markdown
## AI-XX 工作日志 - YYYY-MM-DD - [主题]

### 收到的任务
- [AI 被要求做什么]

### 读取的文件
- [读过哪些文件或资料]

### 完成的工作
- [实际完成了什么]

### 权威启动包
本轮目标:
权威文件:
本轮禁读:
最多读文件数:
验收标准:
停止条件:
允许动作:
禁止动作:
验证计划:

### 状态信任等级
本轮已验证:
可信快照:
旧日志:
模型推断:
未知:

### Worklog Brief
发生了什么:
保留的证据:
丢弃的证据:
当前阻塞:
下一个 reviewer 动作:

### 修改 / 新增的文件
- [改了哪些文件]

### 验证状态
- [跑了哪些检查]
- [Passed / Failed / Not Run]
- [已知限制]

### 未完成
- [还剩什么]

### 需要 Founder 提供
- [需要 founder 决策、批准或补充的信息]

### 需要其他 AI 提供
- [AI-XX 和原因]

### 给下一个 AI 的交接
Handoff To:
Reason For Handoff:
Current State:
Files Read:
Files Changed:
Verification Status:
Known Gaps:
Next AI Needs:
Do Not Assume:
Founder Decision Needed:

### 下一步建议
- [一个明确下一步]
```

---

## 交接规则

如果另一个 AI 可能继续这项工作，handoff 部分必须写。

下一个 AI 不应该从感觉、记忆或旧聊天里猜上下文。

如果 handoff 不完整，下一个 AI 必须先问清楚，不能直接行动。
