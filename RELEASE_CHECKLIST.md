> 🌐 Language: **English** | [[zh/RELEASE_CHECKLIST.md|简体中文]]
# Release Checklist

**Purpose:** Publish Solo-AI-Company-OS without leaking private context or shipping a broken self-serve package.

---

## 1. Pre-Release Review

- Confirm the repo contains only fictional examples.
- Confirm the free Core is useful without paid files.
- Confirm `PRODUCT_BOUNDARY.md` still reflects the current product model.
- Confirm `LAUNCH_PLAYBOOK.md` does not promise manual setup support as the default path.

---

## 2. Run Validation

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-release.ps1
```

Expected output:

```text
VALIDATION_OK
```

Validation checks required paths, forbidden terms, script parsing, SVG parsing, and vault initialization.

---

## 3. Build Release ZIP

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\package-release.ps1 -Version '0.1.0'
```

Expected output:

```text
PACKAGE_OK [path to ZIP]
```

The ZIP should be created under `dist/`, which is intentionally ignored by Git.

---

## 4. Manual Spot Check

Open the ZIP and confirm:

- it contains `README.md`
- it contains `OBSIDIAN_HOME.md`
- it contains `scripts/init-vault.ps1`
- it does not contain `.git/`
- it does not contain `.obsidian/`
- it does not contain `dist/`

---

## 5. GitHub Release

Create a release with:

- version tag such as `v0.1.0`
- short description using the README tagline
- the generated ZIP as an attached asset
- notes that the project is Markdown-first and self-serve

Do not attach private vaults, local screenshots with private data, or generated test output.

---

## 6. Launch Copy

Use the launch positioning from `LAUNCH_PLAYBOOK.md`.

Core message:

```text
Stop losing your AI company inside chat history.
```

One-sentence description:

```text
A disciplined Markdown operating system for solo founders managing AI employees.
```
