param(
    [string]$OutputPath,
    [string]$WorkspaceName,
    [string]$FounderName,
    [string]$ProjectName,
    [string]$ProductName,
    [switch]$Force,
    [switch]$NoOpenFolder
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Read-Value {
    param(
        [string]$CurrentValue,
        [string]$Prompt,
        [string]$DefaultValue
    )

    if (-not [string]::IsNullOrWhiteSpace($CurrentValue)) {
        return $CurrentValue.Trim()
    }

    if (-not [string]::IsNullOrWhiteSpace($DefaultValue)) {
        $value = Read-Host "$Prompt [$DefaultValue]"
        if ([string]::IsNullOrWhiteSpace($value)) {
            return $DefaultValue.Trim()
        }
        return $value.Trim()
    }

    do {
        $value = Read-Host $Prompt
    } while ([string]::IsNullOrWhiteSpace($value))

    return $value.Trim()
}

function Get-SafeFolderName {
    param([string]$Name)

    $invalidChars = [System.IO.Path]::GetInvalidFileNameChars()
    $safeChars = $Name.ToCharArray() | ForEach-Object {
        if ($invalidChars -contains $_) {
            '-'
        } else {
            $_
        }
    }

    $safeName = (-join $safeChars) -replace '\s+', '-'
    $safeName = $safeName.Trim('-')

    if ([string]::IsNullOrWhiteSpace($safeName)) {
        return 'Solo-AI-Company-OS-Vault'
    }

    return $safeName
}

function Read-Yes {
    param([string]$Prompt)

    $answer = Read-Host "$Prompt [y/N]"
    return $answer -match '^(y|yes)$'
}

$repoRoot = [System.IO.Path]::GetFullPath($PSScriptRoot)
$initScript = Join-Path -Path $repoRoot -ChildPath 'scripts\init-vault.ps1'

if (-not (Test-Path -LiteralPath $initScript)) {
    throw "Cannot find setup script: $initScript"
}

Write-Host ''
Write-Host 'Solo-AI-Company-OS Human-AI Collaboration Installer'
Write-Host 'Answer a few questions. Press Enter to accept the suggested value.'
Write-Host ''

$defaultFounderName = [Environment]::UserName

$WorkspaceName = Read-Value -CurrentValue $WorkspaceName -Prompt 'Workspace name' -DefaultValue 'My AI Collaboration OS'
$FounderName = Read-Value -CurrentValue $FounderName -Prompt 'Your name' -DefaultValue $defaultFounderName
$ProjectName = Read-Value -CurrentValue $ProjectName -Prompt 'Primary project name' -DefaultValue $WorkspaceName
$ProductName = Read-Value -CurrentValue $ProductName -Prompt 'Primary product, offer, or deliverable name' -DefaultValue $ProjectName

$safeFolderName = Get-SafeFolderName -Name $WorkspaceName
$documentsPath = [Environment]::GetFolderPath('MyDocuments')
if ([string]::IsNullOrWhiteSpace($documentsPath)) {
    $documentsPath = [Environment]::GetFolderPath('UserProfile')
}
$defaultOutputPath = Join-Path -Path $documentsPath -ChildPath "$safeFolderName-Vault"
$OutputPath = Read-Value -CurrentValue $OutputPath -Prompt 'Where should the vault be created?' -DefaultValue $defaultOutputPath
$OutputPath = [System.IO.Path]::GetFullPath($OutputPath)

while ((Test-Path -LiteralPath $OutputPath) -and (-not $Force)) {
    Write-Host ''
    Write-Host "This folder already exists: $OutputPath"
    if (Read-Yes -Prompt 'Replace it?') {
        $Force = $true
    } else {
        $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $suggestedPath = "$OutputPath-$timestamp"
        $OutputPath = Read-Value -CurrentValue '' -Prompt 'Choose a new vault path' -DefaultValue $suggestedPath
        $OutputPath = [System.IO.Path]::GetFullPath($OutputPath)
    }
}

Write-Host ''
Write-Host 'Creating your vault...'
Write-Host ''

$initArgs = @{
    OutputPath = $OutputPath
    CompanyName = $WorkspaceName
    FounderName = $FounderName
    ProjectName = $ProjectName
    ProductName = $ProductName
    CreateDay1Worklog = $true
}

if ($Force) {
    $initArgs.Force = $true
}

& $initScript @initArgs

Write-Host ''
Write-Host 'Done.'
Write-Host "Vault path: $OutputPath"
Write-Host ''
Write-Host 'Next steps:'
Write-Host '1. Open Obsidian.'
Write-Host '2. Choose "Open folder as vault".'
Write-Host "3. Select this folder: $OutputPath"
Write-Host '4. Open OBSIDIAN_HOME.md.'
Write-Host ''
Write-Host 'For AI-assisted link cleanup, open:'
Write-Host '00_System_Brain\AI_Obsidian_Link_Maintenance_Prompt.md'
Write-Host 'For broader AI text maintenance rules, open:'
Write-Host '00_System_Brain\AI_Text_Maintenance_Protocol.md'
Write-Host ''

if (-not $NoOpenFolder) {
    Start-Process explorer.exe -ArgumentList "`"$OutputPath`""
}
