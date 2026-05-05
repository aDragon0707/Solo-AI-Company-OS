# Contributing

Thank you for helping improve Solo-AI-Company-OS.

This project is intentionally lightweight. Contributions should make the system clearer, easier to adopt, and safer for founders using AI employees.

---

## Contribution Philosophy

The core template should remain:

- Markdown-first
- human-readable
- easy to fork
- useful without paid tools
- useful without complex setup
- strict about founder decision authority
- strict about separating verified truth from public story

When in doubt, prefer clarity over cleverness.

---

## Good Contributions

These are welcome:

- clearer onboarding text
- Chinese onboarding guides and translation packs
- better examples using fully fictional companies
- improved role prompts for AI employees
- stronger worklog and handoff templates
- Obsidian navigation improvements
- small learning lab additions
- typo fixes and broken link fixes
- launch materials that explain the system without hype
- issue templates and pull request templates

---

## Branch And Pull Request Flow

Please open pull requests against:

```text
develop
```

The maintainer will review changes in `develop` before merging stable updates into `main`.

Use small pull requests when possible:

- one translation pack
- one tutorial
- one onboarding improvement
- one bug fix

Avoid mixing translation, structure changes, and new product ideas in the same pull request.

---

## Translation And Tutorial Contributions

Chinese onboarding material is welcome.

Good places for translation or tutorials:

- `docs/`
- `examples/`
- a clearly named language pack folder

Recommended first Chinese pack:

```text
docs/zh/
```

Translation and tutorial pull requests should:

- preserve the English Core unless the PR explicitly explains why a Core phrase should change
- keep filenames and links stable when possible
- explain any terms that do not translate cleanly
- avoid private user stories or real business data
- show the simplest installation path first

Chinese material should focus on:

- installation walkthroughs
- first-session guidance
- screenshots and step-by-step explanations
- glossary for terms like founder decision, worklog, handoff, dashboard, MOC, and AI employee
- Chinese summaries that point back to the canonical English Core files

Chinese material should not:

- fork the functional system into a separate Chinese Core
- duplicate every AI prompt into a second maintained prompt set
- change link targets in a way that breaks Obsidian navigation
- make the Chinese guide the source of truth for AI behavior

Prompt policy:

```text
Canonical AI prompts stay in the English Core.
Chinese guides may explain how to use them, but should link back to the English prompt files.
```

This keeps the system maintainable and prevents English and Chinese behavior from drifting apart.

For a first Chinese tutorial, prioritize:

```text
Download ZIP -> unzip -> double-click INSTALL_WINDOWS.bat -> open Obsidian -> read FIRST_30_MINUTES.md
```

---

## Contributions That Need Care

These may fit, but should be discussed first:

- new AI employee roles
- new top-level folders
- advanced automation
- integrations with paid tools
- changes to the decision log model
- changes to the V2 roadmap
- large rewrites of the README

The project should not become heavy before the basic Markdown version is proven useful.

---

## Out Of Scope

Please avoid:

- adding real company data
- adding client names, private notes, or proprietary project details
- turning the repo into a task app clone
- replacing founder decisions with AI-generated decisions
- requiring a database or server for V1
- adding vague productivity language without practical examples
- adding prompts that encourage AI to guess missing facts

---

## Example Data Rule

Examples must be fictional.

Use invented names, invented products, invented customers, and invented situations. If an example is inspired by real work, rewrite it until it cannot expose a real company, client, person, market plan, or internal technical detail.

---

## Pull Request Checklist

Before opening a pull request:

- read `README.md`
- read `00_System_Brain/System_Principles.md`
- make sure your change keeps V1 lightweight
- use fictional data only
- check that links point to existing files
- explain why the change helps a solo founder operate AI work more clearly

---

## Maintainer Review Standard

A change is a good fit when it helps a new founder answer one of these questions faster:

- What did I decide?
- Which AI should do this?
- What did the last AI actually do?
- What still needs founder judgment?
- What is verified, and what is still only a draft?

If a change makes those answers harder to see, it probably does not belong in the core template.
