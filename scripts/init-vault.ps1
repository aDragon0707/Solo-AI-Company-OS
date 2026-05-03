param(
    [string]$OutputPath,
    [string]$CompanyName,
    [string]$FounderName,
    [string]$ProjectName,
    [string]$ProductName,
    [switch]$Force,
    [switch]$CreateDay1Worklog
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Read-RequiredValue {
    param(
        [string]$CurrentValue,
        [string]$Prompt
    )

    if (-not [string]::IsNullOrWhiteSpace($CurrentValue)) {
        return $CurrentValue.Trim()
    }

    do {
        $value = Read-Host $Prompt
    } while ([string]::IsNullOrWhiteSpace($value))

    return $value.Trim()
}

function Get-FullPath {
    param([string]$Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return [System.IO.Path]::GetFullPath($Path)
    }

    return [System.IO.Path]::GetFullPath((Join-Path -Path (Get-Location) -ChildPath $Path))
}

function Add-TrailingSeparator {
    param([string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath($Path).TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
    return $fullPath + [System.IO.Path]::DirectorySeparatorChar
}

$OutputPath = Read-RequiredValue -CurrentValue $OutputPath -Prompt 'Output vault path'
$CompanyName = Read-RequiredValue -CurrentValue $CompanyName -Prompt 'Company name'
$FounderName = Read-RequiredValue -CurrentValue $FounderName -Prompt 'Founder name'
$ProjectName = Read-RequiredValue -CurrentValue $ProjectName -Prompt 'Main project name'
$ProductName = Read-RequiredValue -CurrentValue $ProductName -Prompt 'Main product name'

$sourceRoot = [System.IO.Path]::GetFullPath((Join-Path -Path $PSScriptRoot -ChildPath '..'))
$outputRoot = Get-FullPath -Path $OutputPath

$sourceWithSlash = Add-TrailingSeparator -Path $sourceRoot
$outputWithSlash = Add-TrailingSeparator -Path $outputRoot

if ($outputWithSlash.Equals($sourceWithSlash, [System.StringComparison]::OrdinalIgnoreCase) -or
    $outputWithSlash.StartsWith($sourceWithSlash, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Output path must be outside the template repo: $sourceRoot"
}

if (Test-Path -LiteralPath $outputRoot) {
    if (-not $Force) {
        Write-Error "Output path already exists: $outputRoot. Use -Force to replace it."
        exit 1
    }

    $resolvedOutput = [System.IO.Path]::GetFullPath((Resolve-Path -LiteralPath $outputRoot).Path)
    $resolvedWithSlash = Add-TrailingSeparator -Path $resolvedOutput

    if ($resolvedWithSlash.Equals($sourceWithSlash, [System.StringComparison]::OrdinalIgnoreCase) -or
        $resolvedWithSlash.StartsWith($sourceWithSlash, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to remove a path inside the template repo: $resolvedOutput"
    }

    Remove-Item -LiteralPath $resolvedOutput -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $outputRoot | Out-Null

$excludedRootNames = @('.git', '.obsidian')
$sourceRootLength = $sourceWithSlash.Length

Get-ChildItem -LiteralPath $sourceRoot -Force -Recurse | ForEach-Object {
    $relativePath = $_.FullName.Substring($sourceRootLength)
    $rootName = ($relativePath -split '[\\/]', 2)[0]

    if ($excludedRootNames -contains $rootName) {
        return
    }

    $destinationPath = Join-Path -Path $outputRoot -ChildPath $relativePath

    if ($_.PSIsContainer) {
        New-Item -ItemType Directory -Force -Path $destinationPath | Out-Null
        return
    }

    $destinationParent = Split-Path -Parent $destinationPath
    New-Item -ItemType Directory -Force -Path $destinationParent | Out-Null
    Copy-Item -LiteralPath $_.FullName -Destination $destinationPath -Force
}

$replacements = [ordered]@{
    '[Company Name]' = $CompanyName
    '[Founder Name]' = $FounderName
    '[Project Name]' = $ProjectName
    '[Product Name]' = $ProductName
}

$textExtensions = @('.md', '.txt', '.svg', '.json', '.yaml', '.yml')

Get-ChildItem -LiteralPath $outputRoot -Force -Recurse -File | ForEach-Object {
    if ($textExtensions -notcontains $_.Extension) {
        return
    }

    $content = Get-Content -LiteralPath $_.FullName -Raw
    foreach ($placeholder in $replacements.Keys) {
        $content = $content.Replace($placeholder, $replacements[$placeholder])
    }
    Set-Content -LiteralPath $_.FullName -Value $content -Encoding UTF8
}

if ($CreateDay1Worklog) {
    $dateCompact = Get-Date -Format 'yyyyMMdd'
    $dateIso = Get-Date -Format 'yyyy-MM-dd'
    $worklogDir = Join-Path -Path $outputRoot -ChildPath '03_Company\AI_Worklogs'
    New-Item -ItemType Directory -Force -Path $worklogDir | Out-Null

    $worklogPath = Join-Path -Path $worklogDir -ChildPath "AI-01_Worklog_${dateCompact}_Day1_Setup.md"
    $worklogContent = @"
# AI-01 Worklog - $dateIso - Day 1 Setup

## Task Received
- Initialize a Solo-AI-Company-OS vault from the template.

## Files Read
- Template files copied from the local Solo-AI-Company-OS repo.

## Work Completed
- Created a new vault for $CompanyName.
- Replaced core placeholders for company, founder, project, and product.
- Created this setup record.

## Files Changed
- Generated vault files under $outputRoot.

## Verification Status
- Initialization script completed.
- This record only documents vault setup.
- No business work, research work, customer work, or implementation work has been completed by AI.

## Not Completed
- Founder decisions are not yet filled in.
- Company state still needs founder review.
- AI role prompts may need customization.

## Needs Founder
- Review FOUNDER_START_HERE.md.
- Fill 01_Founder/FOUNDER_Decision_Log.md.
- Update 02_Dashboards/DASHBOARD_Company_State.md.
- Open 02_Dashboards/DASHBOARD_Link_Map.md in Obsidian and confirm the starting graph.
- Read 00_System_Brain/AI_Text_Maintenance_Protocol.md before asking AI to maintain dashboards, maps, worklog indexes, handoffs, or links.

## Needs Another AI
- AI-01 should perform the first coordination review after the founder fills initial decisions.

## Handoff For Next AI
Handoff To: AI-01 Founder Office / PMO
Reason For Handoff: First coordination pass after template initialization.
Current State: Vault initialized only.
Files Read: Template files copied by script, including AI text maintenance protocol, Obsidian link map, and AI link maintenance prompt.
Files Changed: Generated vault files.
Verification Status: Setup script completed.
Known Gaps: No founder-approved operating decisions yet.
Next AI Needs: Read founder decision log, company state dashboard, AI text maintenance protocol, link map, coordination protocol, and worklog index.
Do Not Assume: Do not treat setup as evidence of business progress.
Founder Decision Needed: Initial operating boundaries and first project priority.

## Next Recommendation
- Founder fills the first decision log entry before assigning AI work.
"@

    Set-Content -LiteralPath $worklogPath -Value $worklogContent -Encoding UTF8
}

Write-Host "Vault initialized at: $outputRoot"
