# Scripts

**Purpose:** Provide self-serve setup and Markdown-generation helpers for Solo-AI-Company-OS.

All scripts are no-dependency PowerShell helpers. They do not call the network, install packages, or write to a database.

---

## Initialize A Custom Vault

For the easiest Windows setup, use the root installer:

```powershell
powershell -ExecutionPolicy Bypass -File .\INSTALL.ps1
```

Or double-click `INSTALL_WINDOWS.bat`.

Use `init-vault.ps1` when you want full parameter control.

Example:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-vault.ps1 `
  -OutputPath '.\_tmp\Northstar-Notes-Vault' `
  -CompanyName 'Northstar Notes' `
  -FounderName 'Example Founder' `
  -ProjectName 'BriefForge' `
  -ProductName 'BriefForge' `
  -Language 'zh-CN' `
  -CreateDay1Worklog
```

---

## Create A Worklog Draft

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-worklog.ps1 -AgentId AI-01 -Title "first setup loop"
```

Cross-platform:

```bash
python scripts/os-helper.py new-worklog --agent-id AI-01 --title "first setup loop"
```

This creates a draft Markdown worklog under:

```text
03_Company/AI_Worklogs/
```

It refuses to overwrite an existing file.

---

## Create A Handoff Draft

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-handoff.ps1 -FromAgent AI-01 -ToAgent AI-02 -TaskTitle "prototype evidence check"
```

Cross-platform:

```bash
python scripts/os-helper.py new-handoff --from-agent AI-01 --to-agent AI-02 --task-title "prototype evidence check"
```

This creates a draft handoff with:

- `handoff_id`
- `attempt_id`
- `lease_expires_at`
- `source_fingerprint`
- retry rule notes

It refuses to overwrite an existing file.

---

## Print AgentOps Doctor Examples

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\doctor-example.ps1 -Case handoff-expired
```

Cross-platform:

```bash
python scripts/os-helper.py doctor-example --case handoff-expired
```

Available cases:

- `handoff-completed`
- `handoff-active`
- `handoff-expired`
- `worklog-dirty`
- `privacy-rewrite`

Copy the output into AgentOps Doctor or any AI assistant following the Doctor README.

---

## Run Privacy Guard

Use this before publishing public-facing text:

```bash
python scripts/os-helper.py privacy-guard --file agentops-doctor/README.zh-CN.md
```

Or check inline text:

```bash
python scripts/os-helper.py privacy-guard --text "No private paths here."
```

It blocks common local paths, credential assignments, and `sk-...` style keys. Teaching placeholders such as `[PRIVATE_PROJECT_NAME]` are allowed so public examples can demonstrate sanitization.

---

## Estimate Context Budget

Use this before loading a large handoff, dashboard, or bundle of notes into an AI context window.

```bash
python scripts/os-helper.py context-budget --agent codex --file 00_System_Brain/AI_TASK_PACKET_TEMPLATE_ZH.md
python scripts/os-helper.py context-budget --agent longju --file HANDOFF.md --file CURRENT_BRIEF.md
python scripts/os-helper.py context-budget --agent codex --file 00_System_Brain/AI_TASK_PACKET_TEMPLATE_ZH.md --actual-used 132000
```

The estimator is conservative and local-only. It cannot know hidden system, chat-history, or platform overhead tokens, so treat the result as a planning signal, not exact billing telemetry.

If the AI UI shows the current context usage, pass it with `--actual-used`. The helper will print a calibration factor and adjusted phase.

Thresholds:

- 45%: start converging
- 60%: write state compression
- 70%: stop expansion
- 80%: start a new window

---

## Validate A Release

Use `validate-release.ps1` before publishing or packaging.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-release.ps1
```

The validation script checks required public files, forbidden terms, PowerShell parsing, SVG parsing, and vault initialization.

---

## Package A Release ZIP

Use `package-release.ps1` to build a self-serve ZIP under `dist/`.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\package-release.ps1 -Version '0.1.0'
```

The ZIP excludes:

- `.git/`
- `.obsidian/`
- `dist/`
