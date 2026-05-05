# Scripts

**Purpose:** Provide self-serve setup tools for Solo-AI-Company-OS.

---

## Initialize A Custom Vault

For the easiest Windows setup, use the root installer:

```powershell
powershell -ExecutionPolicy Bypass -File .\INSTALL.ps1
```

Or double-click `INSTALL_WINDOWS.bat`.

Use the script below when you want full parameter control.

Use `init-vault.ps1` to copy this template into a new folder and replace the core placeholders.

The generated vault includes:

- a stable front door at `OBSIDIAN_HOME.md`
- a first-session guide at `FIRST_30_MINUTES.md`
- a company state dashboard at `02_Dashboards/DASHBOARD_Company_State.md`
- AI text maintenance rules at `00_System_Brain/AI_Text_Maintenance_Protocol.md`
- an Obsidian wiki-link map at `02_Dashboards/DASHBOARD_Link_Map.md`
- an AI link maintenance prompt at `00_System_Brain/AI_Obsidian_Link_Maintenance_Prompt.md`

Example:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-vault.ps1 `
  -OutputPath 'F:\_tmp\Northstar-Notes-Vault' `
  -CompanyName 'Northstar Notes' `
  -FounderName 'Example Founder' `
  -ProjectName 'BriefForge' `
  -ProductName 'BriefForge' `
  -CreateDay1Worklog
```

---

## Parameters

| Parameter | Required | Purpose |
|---|---|---|
| `-OutputPath` | yes | Destination folder for the generated vault |
| `-CompanyName` | yes | Replaces `My AI Collaboration OS` |
| `-FounderName` | yes | Replaces `[Founder Name]` |
| `-ProjectName` | yes | Replaces `My AI Collaboration OS` |
| `-ProductName` | yes | Replaces `My AI Collaboration OS` |
| `-Force` | no | Replaces an existing output folder |
| `-CreateDay1Worklog` | no | Adds a setup-only AI-01 worklog |

If a required value is missing, the script asks for it interactively.

---

## Safety Rules

The script:

- does not call the network
- does not require external packages
- does not copy `.git/`
- does not copy `.obsidian/`
- refuses to write the generated vault inside the template repo
- refuses to overwrite an existing output folder unless `-Force` is used

The generated Day 1 worklog records setup only. It does not claim that AI completed business, customer, research, or implementation work.

After setup, open the generated folder in Obsidian and start from `FIRST_30_MINUTES.md` or `OBSIDIAN_HOME.md`. For dashboard, MOC, worklog-index, handoff, or link cleanup, ask an AI assistant that can edit your vault to follow `00_System_Brain/AI_Text_Maintenance_Protocol.md`.

---

## Validate A Release

Use `validate-release.ps1` before publishing or packaging.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-release.ps1
```

The validation script checks:

- required public files exist
- forbidden terms are absent
- PowerShell scripts parse
- the system map SVG parses as XML
- the vault initialization flow works
- generated Markdown has no core placeholders left

Use `-SkipInitTest` only when you need a faster documentation-only check.

---

## Package A Release ZIP

Use `package-release.ps1` to build a self-serve ZIP under `dist/`.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\package-release.ps1 -Version '0.1.0'
```

The package script runs validation first, then creates:

```text
dist/Solo-AI-Company-OS-v0.1.0.zip
```

The ZIP excludes:

- `.git/`
- `.obsidian/`
- `dist/`

Use `-Force` to replace an existing ZIP.
