param(
    [string]$TestOutputPath,
    [switch]$SkipInitTest
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Add-TrailingSeparator {
    param([string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath($Path).TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
    return $fullPath + [System.IO.Path]::DirectorySeparatorChar
}

function Assert-RequiredPath {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Missing required path: $Path"
    }
}

function Assert-NoMatches {
    param(
        [string]$Root,
        [string[]]$Patterns
    )

    $files = Get-ChildItem -LiteralPath $Root -Recurse -File -Force | Where-Object {
        $path = $_.FullName
        if ($path -like '*\.git\*' -or $path -like '*\.obsidian\*' -or $path -like '*\dist\*') {
            return $false
        }
        return $true
    }

    $matches = $files | Select-String -Pattern $Patterns -CaseSensitive:$false
    if ($matches) {
        $summary = $matches | Select-Object -First 20 Path, LineNumber, Line | Format-Table -AutoSize | Out-String
        throw "Forbidden term scan failed:`n$summary"
    }
}

function Test-PowerShellFile {
    param([string]$Path)

    $tokens = $null
    $errors = $null
    [System.Management.Automation.Language.Parser]::ParseFile($Path, [ref]$tokens, [ref]$errors) | Out-Null
    if ($errors.Count -gt 0) {
        $summary = $errors | Select-Object Message, Extent | Format-Table -AutoSize | Out-String
        throw "PowerShell parse failed for ${Path}:`n$summary"
    }
}

function Remove-TestOutput {
    param(
        [string]$Path,
        [string]$AllowedRoot
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return
    }

    $fullPath = [System.IO.Path]::GetFullPath($Path)
    $allowedWithSlash = Add-TrailingSeparator -Path $AllowedRoot
    $fullWithSlash = Add-TrailingSeparator -Path $fullPath

    if (-not $fullWithSlash.StartsWith($allowedWithSlash, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to clean test output outside allowed temp root: $fullPath"
    }

    Remove-Item -LiteralPath $fullPath -Recurse -Force
}

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path -Path $PSScriptRoot -ChildPath '..'))

if ([string]::IsNullOrWhiteSpace($TestOutputPath)) {
    $TestOutputPath = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath 'Solo-AI-Company-OS-Validation'
}

$requiredPaths = @(
    'README.md',
    'FIRST_30_MINUTES.md',
    'docs\zh\README.md',
    'docs\zh\QUICKSTART.md',
    'docs\zh\GLOSSARY.md',
    'docs\zh\FIRST_RUN_EXAMPLE.md',
    'INSTALL.ps1',
    'INSTALL_WINDOWS.bat',
    'LICENSE',
    'CONTRIBUTING.md',
    'PRODUCT_BOUNDARY.md',
    'LAUNCH_PLAYBOOK.md',
    'EXAMPLE_DAY_1.md',
    'OBSIDIAN_HOME.md',
    '02_Dashboards\DASHBOARD_Company_State.md',
    '02_Dashboards\DASHBOARD_Link_Map.md',
    '00_System_Brain\AI_Text_Maintenance_Protocol.md',
    '00_System_Brain\AI_Obsidian_Link_Maintenance_Prompt.md',
    '03_Company\AI_Worklogs\WORKLOG_TEMPLATE.md',
    'scripts\init-vault.ps1',
    'scripts\README.md',
    'assets\solo-ai-company-os-map.svg'
)

foreach ($relativePath in $requiredPaths) {
    Assert-RequiredPath -Path (Join-Path -Path $repoRoot -ChildPath $relativePath)
}

$forbiddenPatterns = @(
    ('Cap' + 'ella'),
    ('Book' + 'ing\.com'),
    ('Book' + 'ing'),
    ('\bO' + 'TA\b'),
    ('Luxury ' + 'Hotels'),
    ('Luxury ' + 'Hotel'),
    ('Law ' + 'Firms'),
    ('Law ' + 'Firm'),
    ('Shadow' + 'Buyer'),
    ('Audit ' + 'Sprint'),
    ('Diagnostic ' + 'Run'),
    ('US' + 'D 3,000'),
    ('\bUS' + 'D\b'),
    ('Play' + 'wright'),
    ('D' + 'OM hashing'),
    ('D' + 'OM'),
    ('Ma' + 'nn-Whitney'),
    ('Ma' + 'nn')
)

Assert-NoMatches -Root $repoRoot -Patterns $forbiddenPatterns

Get-ChildItem -LiteralPath (Join-Path -Path $repoRoot -ChildPath 'scripts') -Filter '*.ps1' -File | ForEach-Object {
    Test-PowerShellFile -Path $_.FullName
}

Test-PowerShellFile -Path (Join-Path -Path $repoRoot -ChildPath 'INSTALL.ps1')

[xml](Get-Content -LiteralPath (Join-Path -Path $repoRoot -ChildPath 'assets\solo-ai-company-os-map.svg') -Raw) | Out-Null

if (-not $SkipInitTest) {
    $tempRoot = [System.IO.Path]::GetTempPath()
    Remove-TestOutput -Path $TestOutputPath -AllowedRoot $tempRoot

    & powershell -ExecutionPolicy Bypass -File (Join-Path -Path $repoRoot -ChildPath 'scripts\init-vault.ps1') `
        -OutputPath $TestOutputPath `
        -CompanyName 'Northstar Notes' `
        -FounderName 'Example Founder' `
        -ProjectName 'BriefForge' `
        -ProductName 'BriefForge' `
        -CreateDay1Worklog | Out-Null

    $generatedRequiredPaths = @(
        'OBSIDIAN_HOME.md',
        'FIRST_30_MINUTES.md',
        '01_Founder',
        '02_Dashboards\DASHBOARD_Company_State.md',
        '02_Dashboards\DASHBOARD_Link_Map.md',
        '00_System_Brain\AI_Text_Maintenance_Protocol.md',
        '00_System_Brain\AI_Obsidian_Link_Maintenance_Prompt.md',
        '03_Company',
        '04_Learning'
    )

    foreach ($relativePath in $generatedRequiredPaths) {
        Assert-RequiredPath -Path (Join-Path -Path $TestOutputPath -ChildPath $relativePath)
    }

    if (Test-Path -LiteralPath (Join-Path -Path $TestOutputPath -ChildPath '.git')) {
        throw 'Generated vault should not contain .git/'
    }

    if (Test-Path -LiteralPath (Join-Path -Path $TestOutputPath -ChildPath '.obsidian')) {
        throw 'Generated vault should not contain .obsidian/'
    }

    $placeholderPatterns = @('\[Company Name\]', '\[Founder Name\]', '\[Project Name\]', '\[Product Name\]')
    $placeholderMatches = Get-ChildItem -LiteralPath $TestOutputPath -Recurse -File -Filter '*.md' -Force |
        Select-String -Pattern $placeholderPatterns

    if ($placeholderMatches) {
        $summary = $placeholderMatches | Select-Object -First 20 Path, LineNumber, Line | Format-Table -AutoSize | Out-String
        throw "Generated vault still has core placeholders:`n$summary"
    }

    Remove-TestOutput -Path $TestOutputPath -AllowedRoot $tempRoot
}

Write-Host 'VALIDATION_OK'
