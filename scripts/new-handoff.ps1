param(
  [string]$FromAgent = "AI-01",
  [string]$ToAgent = "AI-02",
  [string]$TaskTitle = "handoff task",
  [string]$OutputDir = "03_Company/AI_Worklogs",
  [int]$LeaseMinutes = 30
)

$ErrorActionPreference = "Stop"

function Convert-ToSlug {
  param([string]$Value)
  $slug = $Value.ToLowerInvariant() -replace '[^a-z0-9]+', '-'
  $slug = $slug.Trim('-')
  if ([string]::IsNullOrWhiteSpace($slug)) { return "handoff" }
  return $slug
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$targetDir = if ([System.IO.Path]::IsPathRooted($OutputDir)) {
  $OutputDir
} else {
  Join-Path $repoRoot $OutputDir
}

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

$date = Get-Date -Format "yyyyMMdd"
$timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:sszzz"
$leaseExpires = (Get-Date).AddMinutes($LeaseMinutes).ToString("yyyy-MM-ddTHH:mm:sszzz")
$slug = Convert-ToSlug $TaskTitle
$handoffId = "handoff_${date}_${slug}"
$fileName = "${handoffId}.md"
$path = Join-Path $targetDir $fileName

if (Test-Path $path) {
  throw "Refusing to overwrite existing handoff: $path"
}

$content = @"
---
type: handoff
protocol: SACP/0.1
handoff_id: $handoffId
from_agent: $FromAgent
to_agent: $ToAgent
status: requested
attempt_id: attempt_001
lease_owner:
lease_expires_at: $leaseExpires
source_fingerprint: TODO
created_at: $timestamp
---

# Handoff - $TaskTitle

## Context

- TODO: What happened before this handoff?

## Requested Next Action

- TODO: What should $ToAgent do?

## Evidence / Inputs

- TODO: Link worklog, dashboard, artifact, or source note.

## Authority Packet

Current goal:

Authoritative files:

Do not read:

Max files to read: 5

Acceptance criteria:

Stop condition:

Allowed actions:

Forbidden actions:

Verification plan:

## State Confidence

Verified now:

Trusted snapshot:

Stale log:

Model inference:

Unknown:

## Worker Brief

What happened:

Evidence kept:

Evidence discarded:

Current blocker:

Recommended next action:

## Success Criteria

- TODO: How should the receiver know it is done?

## Retry Rule

Same handoff_id + same source_fingerprint + expired lease -> retry with new attempt_id.

Same handoff_id + new source_fingerprint -> rework/update, not duplicate.

New human decision or changed task identity -> create new handoff_id.
"@

Set-Content -Path $path -Value $content -Encoding UTF8 -NoNewline
Write-Output $path
