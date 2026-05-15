param(
  [string]$AgentId = "AI-01",
  [string]$Title = "untitled task",
  [string]$OutputDir = "03_Company/AI_Worklogs"
)

$ErrorActionPreference = "Stop"

function Convert-ToSlug {
  param([string]$Value)
  $slug = $Value.ToLowerInvariant() -replace '[^a-z0-9]+', '-'
  $slug = $slug.Trim('-')
  if ([string]::IsNullOrWhiteSpace($slug)) { return "task" }
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
$slug = Convert-ToSlug $Title
$fileName = "worklog_${date}_${AgentId}_${slug}.md"
$path = Join-Path $targetDir $fileName

if (Test-Path $path) {
  throw "Refusing to overwrite existing worklog: $path"
}

$content = @"
---
type: worklog
protocol: SACP/0.1
id: worklog_${date}_${AgentId}_${slug}
agent_id: $AgentId
status: draft
created_at: $timestamp
verification: pending
evolution_decision: record
---

# Worklog - $Title

## Task

- TODO: What was requested?

## Tools Used

- TODO: List tools, commands, scripts, or documents used.

## Work Completed

- TODO: What changed?

## Authority Packet

Current goal:

Authoritative files:

Do not read:

Max files to read:

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

## Worklog Brief

What happened:

Evidence kept:

Evidence discarded:

Current blocker:

Next reviewer action:

## Verification

- TODO: How was this checked?

## Residual Risk

- TODO: What remains uncertain?

## Evolution

Decision: ignore | record | distill | promote_candidate

Reason:

## Handoff

Next owner:

Next action:
"@

Set-Content -Path $path -Value $content -Encoding UTF8 -NoNewline
Write-Output $path
