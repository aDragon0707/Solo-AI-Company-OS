# Next GPT Handoff - zh-CN Vault Completion

## 0. Current Goal

The current product goal is to make Solo-AI-Company-OS understandable and usable for both English and Chinese users.

The important shift:

```text
Do not treat Chinese as only docs/zh guidance.
Chinese users should be able to generate a Chinese-first Obsidian vault during installation.
```

The installer now supports:

```powershell
-Language 'en'
-Language 'zh-CN'
```

Your next job is to finish the missing zh-CN overlay files so Chinese users do not open the generated vault and feel like they are reading a difficult foreign-language operating manual.

---

## 1. Repository And State

Open-source repo:

```text
F:\Solo-AI-Company-OS
```

Do not edit the private parent project unless the founder explicitly asks.

Current branch is expected to be `main`.

The working tree currently contains uncommitted v0.2 work:

- Skill Memory Layer
- public Doc Memory Spine skill
- English and Chinese plain-language onboarding
- installer language option
- zh-CN locale overlay
- UTF-8 fix for generated Chinese vaults

Before editing, run:

```powershell
Set-Location -LiteralPath 'F:\Solo-AI-Company-OS'
git status --short
```

Do not revert existing changes.

---

## 2. What Is Already Done

### Skill Memory Layer

Added:

```text
03_Company/Skills/README.md
03_Company/Skills/SKILL_TEMPLATE.md
03_Company/Skills/SKILL_LIBRARY.md
03_Company/Skills/AGENT_SKILL_MATRIX.md
03_Company/Skills/WORKLOG_TO_SKILL_PROMPT.md
```

Core idea:

```text
Human decides. AI executes. Worklogs capture experience. Skills make it reusable.
```

### Public Doc Memory Spine Skill

Added:

```text
00_System_Brain/Doc_Memory_Spine_Skill.md
```

This was abstracted from a local long-term documentation maintenance skill. It is now generic and safe for public release.

It is also linked from:

```text
OBSIDIAN_HOME.md
02_Dashboards/DASHBOARD_Link_Map.md
03_Company/Skills/SKILL_LIBRARY.md
03_Company/Skills/AGENT_SKILL_MATRIX.md
```

### Plain-Language Entry

Added:

```text
START_HERE.md
docs/zh/START_HERE.md
```

Purpose:

- explain the system without architecture-heavy language
- tell users what problem it solves
- give a first 15-minute path

### Installer Language Support

Updated:

```text
INSTALL.ps1
scripts/init-vault.ps1
scripts/validate-release.ps1
scripts/README.md
README.md
docs/zh/README.md
docs/zh/QUICKSTART.md
```

The installer now supports language selection.

`scripts/init-vault.ps1` copies the base template and then overlays files from:

```text
locales/zh-CN
```

Important fix already made:

```powershell
Get-Content -Encoding UTF8
```

This prevents Chinese Markdown from becoming mojibake during placeholder replacement.

### Current zh-CN Overlay Files

Already added:

```text
locales/zh-CN/START_HERE.md
locales/zh-CN/FIRST_30_MINUTES.md
locales/zh-CN/OBSIDIAN_HOME.md
locales/zh-CN/02_Dashboards/DASHBOARD_Company_State.md
locales/zh-CN/03_Company/AI_Employees/README.md
locales/zh-CN/03_Company/AI_Worklogs/WORKLOG_TEMPLATE.md
locales/zh-CN/03_Company/Skills/README.md
```

These are only the first Chinese-first surfaces. More are needed.

---

## 3. What Still Needs To Be Added

Create zh-CN overlay files for the most important AI employee files.

Write them under the same relative paths inside:

```text
locales/zh-CN
```

### Required Next Overlay Files

Add:

```text
locales/zh-CN/03_Company/AI_Employees/COORDINATION_PROTOCOL.md
locales/zh-CN/03_Company/AI_Employees/AI-01_Founder_Office/ROLE.md
locales/zh-CN/03_Company/AI_Employees/AI-01_Founder_Office/START_PROMPT.md
locales/zh-CN/03_Company/AI_Employees/AI-02_Builder_Evidence/ROLE.md
locales/zh-CN/03_Company/AI_Employees/AI-02_Builder_Evidence/START_PROMPT.md
locales/zh-CN/03_Company/AI_Employees/AI-03_Growth_Sales/ROLE.md
locales/zh-CN/03_Company/AI_Employees/AI-03_Growth_Sales/START_PROMPT.md
locales/zh-CN/03_Company/AI_Employees/AI-04_Research_Risk/ROLE.md
locales/zh-CN/03_Company/AI_Employees/AI-04_Research_Risk/START_PROMPT.md
locales/zh-CN/03_Company/AI_Employees/AI-05_Learning_Tutor/ROLE.md
locales/zh-CN/03_Company/AI_Employees/AI-05_Learning_Tutor/START_PROMPT.md
```

These files should be Chinese-first, but keep stable file names and role IDs:

```text
AI-01
AI-02
AI-03
AI-04
AI-05
Founder Decision Log
Worklog
Skill
Dashboard
Handoff
```

Do not rename files or folders.

---

## 4. Writing Rules For zh-CN Overlay

The Chinese overlay must feel like product onboarding, not a translated constitution.

Use plain Chinese.

Prefer:

```text
你要做什么
先读哪些文件
能做什么
不能做什么
结束时交付什么
什么时候交给另一个 AI
```

Avoid:

```text
大段抽象原则
像论文一样的解释
过度术语堆叠
把所有英文都硬翻译
```

Keep the English role IDs and file names because the system depends on stable paths.

In Chinese prompt files, include a line like:

```text
请用中文回复，但继续遵守本 prompt 的职责、边界和读取顺序。
```

Each START_PROMPT should tell the AI to read:

```text
01_Founder/FOUNDER_Decision_Log.md
02_Dashboards/DASHBOARD_Company_State.md
03_Company/AI_Worklogs/WORKLOG_INDEX.md
03_Company/AI_Employees/COORDINATION_PROTOCOL.md
03_Company/Skills/AGENT_SKILL_MATRIX.md
03_Company/Skills/SKILL_LIBRARY.md
its own ROLE.md
```

AI-05 can additionally read the learning files.

---

## 5. Role Intent To Preserve

### AI-01 Founder Office / PMO

Purpose:

- split founder intent into tasks
- route work to the correct AI
- maintain dashboard, worklog index, handoff discipline
- surface missing founder decisions

Must not:

- make founder decisions
- hide blockers
- rewrite project truth to look cleaner

### AI-02 Builder / Evidence Owner

Purpose:

- protect project truth
- verify technical or operational facts
- report what is verified, unknown, failed, or not run
- give conservative facts to AI-03 and AI-04

Must not:

- write customer promises
- convert uncertainty into confident claims
- hide failed checks

### AI-03 Growth / Revenue

Purpose:

- draft customer-facing assets
- prepare outreach, offer, pricing, pipeline materials
- move toward revenue while staying downstream of verified truth

Must not:

- send messages as the founder
- approve pricing
- make unsupported claims

### AI-04 Research / Risk

Purpose:

- review claims and sensitive wording
- keep uncertainty visible
- produce safer wording
- identify missing verification

Must not:

- invent authority
- turn weak evidence into strong claims
- remove useful caution just to make copy sound better

### AI-05 Learning Tutor

Purpose:

- teach the founder
- explain architecture before code details
- review learning submissions
- turn experience into learning material

Must not:

- dump jargon
- start with syntax unless asked
- mix learning exercises into production work without AI-02 review

---

## 6. Update Validation

After adding zh-CN overlay files, update:

```text
scripts/validate-release.ps1
```

Add the new locale files to `$requiredPaths`.

Also add them to the generated zh-CN required path check if they should appear in generated vaults.

Current validation already checks:

- required public files exist
- forbidden terms are absent
- PowerShell scripts parse
- SVG parses
- English vault generation works
- zh-CN vault generation works
- Chinese generated files are valid UTF-8
- generated Markdown has no core placeholders left

Do not weaken validation.

---

## 7. Required Tests

Run:

```powershell
Set-Location -LiteralPath 'F:\Solo-AI-Company-OS'
powershell -ExecutionPolicy Bypass -File .\scripts\validate-release.ps1
```

Expected:

```text
VALIDATION_OK
```

Then run explicit zh-CN install test:

```powershell
powershell -ExecutionPolicy Bypass -File .\INSTALL.ps1 `
  -WorkspaceName 'Example AI Company OS' `
  -FounderName 'Example Founder' `
  -ProjectName 'Human AI Collaboration System' `
  -ProductName 'Solo-AI-Company-OS' `
  -Language 'zh-CN' `
  -OutputPath 'F:\_tmp\Solo-AI-Company-OS-zh-Test' `
  -Force `
  -NoOpenFolder
```

Check:

```powershell
[System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes('F:\_tmp\Solo-AI-Company-OS-zh-Test\START_HERE.md')).Substring(0,120)
[System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes('F:\_tmp\Solo-AI-Company-OS-zh-Test\03_Company\AI_Employees\AI-01_Founder_Office\START_PROMPT.md')).Substring(0,200)
```

Expected:

- readable Chinese
- no mojibake
- no core placeholders
- no `.git`
- no `.obsidian`

Clean test output safely:

```powershell
$target = 'F:\_tmp\Solo-AI-Company-OS-zh-Test'
$full = [System.IO.Path]::GetFullPath($target)
if ($full.StartsWith('F:\_tmp\', [System.StringComparison]::OrdinalIgnoreCase) -and (Test-Path -LiteralPath $full)) {
  Remove-Item -LiteralPath $full -Recurse -Force
}
```

Package:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\package-release.ps1 -Version '0.2.0' -Force
```

Expected:

```text
PACKAGE_OK F:\Solo-AI-Company-OS\dist\Solo-AI-Company-OS-v0.2.0.zip
```

---

## 8. Forbidden Leakage Rules

Do not copy private project examples, buyer names, sector-specific terms, source paths, or business details into the open-source repo.

The public repo must stay generic.

Do not introduce any forbidden terms that the release validator scans for.

Run validation before finalizing.

---

## 9. Commit Guidance

After the zh-CN overlay is complete and validation passes:

```powershell
git add .
git status --short
git commit -m "Add Chinese-first vault overlays"
git push origin main
```

Only commit after:

```text
VALIDATION_OK
```

and after the generated zh-CN vault is manually checked for readable Chinese.

---

## 10. Founder Intent

The founder is Chinese and explicitly does not want Chinese users to feel forced to read a difficult English-first Obsidian vault.

The desired product experience:

```text
English users can install an English vault.
Chinese users can install a Chinese-first vault.
Both should understand what the system does within minutes.
Neither should feel like they are reading a thesis before using the product.
```

Keep the system practical, plain, and immediately usable.
