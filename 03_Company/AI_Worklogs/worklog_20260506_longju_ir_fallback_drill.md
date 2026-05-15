---
type: worklog
protocol: SACP/0.1
id: worklog_20260506_longju_ir_fallback_drill
agent_id: Longju
owner: Longju
status: completed
source_handoff_id: null
tools_used:
  - web_fetch
  - web_search timeout observed
  - GitHub API
verification: full - 3 tests passed, results cross-verified
evolution_decision: distill
related:
  - "[[03_Company/MOC_AgentOps_Doctor|AgentOps Doctor Map]]"
  - "[[03_Company/AI_Worklogs/WORKLOG_INDEX|Worklog Index]]"
---

# Longju IR Fallback Drill - 2026-05-06

**Parent maps:** [[03_Company/MOC_AgentOps_Doctor|AgentOps Doctor Map]] / [[03_Company/AI_Worklogs/WORKLOG_INDEX|Worklog Index]]

## Background

The first information-retrieval test exposed three mistakes:

1. Longju fetched one fixed release page instead of checking an official index.
2. FTP directory existence was incorrectly treated as stable release evidence.
3. Pre-release suffixes such as `rc` and `a` were not checked before answering.

The drill tested whether official-source fallback can still work when `web_search` times out.

## Test Results

### Test 1 - Python Latest Stable

| Field | Value |
|---|---|
| web_search | timeout |
| Primary source | `https://www.python.org/downloads/release/python-3144/` |
| Cross-check | `https://www.python.org/ftp/python/` - 3.14.5 artifacts had `rc1`; 3.15.0 artifacts had `a1` to `a8` |
| Version | Python 3.14.4 |
| Release date | Apr 7, 2026 |
| Channel | stable - release page says fourth maintenance release |

### Test 2 - Node.js Latest LTS

| Field | Value |
|---|---|
| web_search | timeout |
| Primary source | `https://nodejs.org/en/about/previous-releases` |
| Cross-check | `https://nodejs.org/dist/latest-v24.x/SHASUMS256.txt` |
| Version | Node.js v24.15.0 Krypton |
| Release date | Apr 15, 2026 |
| Channel | LTS |

### Test 3 - openai/openai-python Latest Release

| Field | Value |
|---|---|
| web_search | timeout |
| Primary source | `https://api.github.com/repos/openai/openai-python/releases/latest` |
| Cross-check | `https://api.github.com/repos/openai/openai-python/releases?per_page=5` |
| Version | v2.34.0 |
| Release date | 2026-05-04 |
| Channel | stable - `prerelease: false`, `draft: false` |

## Key Learnings

### Release Channel Identification

- `a` means alpha.
- `b` means beta.
- `rc` means release candidate.
- No suffix usually means final stable, but it still needs source confirmation.
- Artifact directory existence does not prove stable release.
- GitHub API exposes explicit `prerelease` and `draft` fields.

### Source Priority

1. Official release or detail page.
2. Official index or listing page.
3. Public API.
4. Static directory or symlink files.
5. Artifact directory, which only proves file existence.

### web_search Timeout Rule

- `web_search` timeout is not automatically a blocker.
- Use `web_fetch` against known official URLs.
- If the source cannot be discovered, declare the limitation instead of pretending certainty.

## Changes Made

- Added an IR fallback checklist to Longju's router skill in the OpenClaw workspace.
- Recorded the drill in this worklog.
- Linked this worklog into [[03_Company/MOC_AgentOps_Doctor|AgentOps Doctor Map]] and [[03_Company/AI_Worklogs/WORKLOG_INDEX|Worklog Index]].

## Verification Status

- 3 of 3 drill tasks passed.
- Public-source fallback worked.
- No benchmark was run.
- No upload or publish action was taken.

## Next Recommendation

Keep the IR fallback logic as part of AgentOps Doctor's tool-routing discipline, but do not publish it as a standalone skill unless it becomes a repeated external need.
