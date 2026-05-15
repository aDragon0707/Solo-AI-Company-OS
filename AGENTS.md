# AGENTS.md - Codex Execution Contract

This repository uses Markdown as operating memory. Codex and other coding agents should follow this contract before changing files.

## Start Here

1. The latest explicit user instruction wins.
2. If the user says "only explain", "do not generate code", or "do not test", do not edit files or run tests.
3. If the user says "implement", "update", "fix", or gives clear approval, make the smallest scoped change and verify it.
4. Read explicit user-provided files first, then relevant dashboards or protocols.
5. Do not read raw founder ledgers unless the current task explicitly requires them and the user authorizes it.
6. Never publish, upload, vote, comment, install, spend, or contact external parties without human approval.

## Codex Task Packet

For substantial work, maintain this compact state before acting:

```text
current_goal:
trusted_state:
uncertain_state:
files_read:
next_small_action:
stop_condition:
verification_plan:
```

If the task is still unclear after reading five files, stop and summarize instead of continuing to chase references.

## Editing Rules

- Prefer targeted edits over broad rewrites.
- Use the repository's existing structure and naming.
- Do not revert user changes.
- Keep public docs free of private paths, credentials, customer data, and unpublished strategy.
- For public-facing changes, run the release validator or privacy guard when practical.

## Detailed Protocol

Read the detailed Chinese operating rule here:

```text
00_System_Brain/CODEX_EXECUTION_ALIGNMENT_PROTOCOL.md
```
