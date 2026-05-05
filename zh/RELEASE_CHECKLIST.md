> 🌐 Language: **简体中文** | [English](../RELEASE_CHECKLIST.md)

# 发布清单

**目的：** 发布 Solo-AI-Company-OS，避免泄露私人上下文或发布损坏的自助包。

---

## 1. 发布前审查

- 确认仓库只包含虚构示例。
- 确认免费 Core 在没有付费文件的情况下仍然有用。
- 确认 `PRODUCT_BOUNDARY.md` 仍然反映当前的产品模型。
- 确认 `LAUNCH_PLAYBOOK.md` 没有将手动设置支持作为默认路径来承诺。

---

## 2. 运行验证

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-release.ps1
```

预期输出：

```text
VALIDATION_OK
```

验证检查包括：必要的路径、禁用词、脚本解析、SVG 解析和 vault 初始化。

---

## 3. 构建发布 ZIP

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\package-release.ps1 -Version '0.1.0'
```

预期输出：

```text
PACKAGE_OK [ZIP 包路径]
```

ZIP 包应创建在 `dist/` 下，该目录已被 Git 有意忽略。

---

## 4. 人工抽查

打开 ZIP 包并确认：

- 包含 `README.md`
- 包含 `OBSIDIAN_HOME.md`
- 包含 `scripts/init-vault.ps1`
- 不包含 `.git/`
- 不包含 `.obsidian/`
- 不包含 `dist/`

---

## 5. GitHub Release

创建一个 Release，包含：

- 版本标签，如 `v0.1.0`
- 简短描述，使用 README 的宣传语
- 生成的 ZIP 包作为附件
- 注明该项目是以 Markdown 优先且自助的

不要附加私人 vault、包含私人数据的本地截图或生成的测试输出。

---

## 6. 发布文案

使用 `LAUNCH_PLAYBOOK.md` 中的发布定位。

核心信息：

```text
别再让你的 AI 公司迷失在聊天历史里了。
```

一句话描述：

```text
一个为管理 AI 员工的独立创始人打造的有纪律的 Markdown 操作系统。
```
