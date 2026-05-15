---
type: study_pack
protocol: SACP/0.1
id: hackathon_study_pack_zh_20260506
status: draft
owner: founder
created_at: 2026-05-06T22:20:00+08:00
updated_at: 2026-05-06T22:20:00+08:00
verification: partial
---

# Hackathon Study Pack ZH

这是一套给创始人三天硬啃 Solo-AI-Company-OS / SACP / agent self-evolution 的中文学习包。

它不是正式协议，不是 release 文档，不是 CLI/app/server。

目标：

```text
把复杂架构压成可以学习、可以打印、可以上台讲、可以被追问的材料。
```

## 文件

| 文件 | 用途 |
|---|---|
| `PRINTABLE_CORE_MANUAL_ZH.md` | 可打印核心教材 |
| `ARCHITECTURE_DEEP_DIVE_ZH.md` | 架构深讲 |
| `FIELD_CARDS_ZH.md` | 字段速查卡 |
| `DRILLS_ZH.md` | 演练题 |
| `scripts/sacp_dirty_run_lesson.py` | 教学代码：读取 fixture 并判断 handoff |
| `scripts/render_pdf.py` | 把 Markdown 教材渲染成 PDF |
| `out/` | 生成的 PDF 和输出报告 |

## 推荐学习顺序

1. 先打印 `PRINTABLE_CORE_MANUAL_ZH.pdf`。
2. 读 `FIELD_CARDS_ZH.md`，把字段记成人话。
3. 跑 `scripts/sacp_dirty_run_lesson.py`，看 agent-readable 协议如何被代码读取。
4. 做 `DRILLS_ZH.md` 的题。
5. 最后读 `ARCHITECTURE_DEEP_DIVE_ZH.md`，准备评委追问。

## 生成 PDF

```powershell
python .\00_System_Brain\Hackathon_Study_Pack_ZH\scripts\render_pdf.py
```

生成：

```text
00_System_Brain\Hackathon_Study_Pack_ZH\out\Solo_AI_Company_OS_Hackathon_Study_Pack_ZH.pdf
```

## 运行教学代码

```powershell
python .\00_System_Brain\Hackathon_Study_Pack_ZH\scripts\sacp_dirty_run_lesson.py
```

输出会说明：

- 下一个 owner 是谁
- 是否重复触发
- 是否创建新 handoff
- receiving worklog 如何引用原始 handoff_id
- 为什么 `status: completed` 不是触发事件

