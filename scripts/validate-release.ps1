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
        if (
            $path -like '*\.git\*' -or
            $path -like '*\.obsidian\*' -or
            $path -like '*\dist\*' -or
            $path -like '*\runtime\*' -or
            $path -like '*\__pycache__\*' -or
            $path -like '*\_external\*'
        ) {
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
    'AGENTS.md',
    'README.md',
    'START_HERE.md',
    'FIRST_30_MINUTES.md',
    'docs\zh\START_HERE.md',
    'docs\zh\DAY_1_CHINESE_USER_PATH.md',
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
    '02_Dashboards\DASHBOARD_Longju_Experiment.md',
    '02_Dashboards\DASHBOARD_Link_Map.md',
    '00_System_Brain\AI_Text_Maintenance_Protocol.md',
    '00_System_Brain\AI_Obsidian_Link_Maintenance_Prompt.md',
    '00_System_Brain\AI_TASK_PACKET_TEMPLATE_ZH.md',
    '00_System_Brain\CODEX_EXECUTION_ALIGNMENT_PROTOCOL.md',
    '00_System_Brain\Doc_Memory_Spine_Skill.md',
    '00_System_Brain\LONGJU_DRIFT_CONTROL_PROTOCOL.md',
    '00_System_Brain\SACP_Dirty_Run_Experiment.md',
    '00_System_Brain\SACP_MINIMAL_SPEC.md',
    '00_System_Brain\SACP_Protocol.md',
    '00_System_Brain\SACP_Agent_Bridge.md',
    '03_Company\Skills\README.md',
    '03_Company\Skills\SKILL_TEMPLATE.md',
    '03_Company\Skills\SKILL_LIBRARY.md',
    '03_Company\Skills\AGENT_SKILL_MATRIX.md',
    '03_Company\Skills\WORKLOG_TO_SKILL_PROMPT.md',
    '03_Company\AI_Employees\FIVE_LOBSTERS_OPERATING_MODEL.md',
    'locales\zh-CN\START_HERE.md',
    'locales\zh-CN\FIRST_30_MINUTES.md',
    'locales\zh-CN\OBSIDIAN_HOME.md',
    'locales\zh-CN\02_Dashboards\DASHBOARD_Company_State.md',
    'locales\zh-CN\03_Company\AI_Employees\COORDINATION_PROTOCOL.md',
    'locales\zh-CN\03_Company\AI_Employees\README.md',
    'locales\zh-CN\03_Company\AI_Employees\AI-01_Founder_Office\ROLE.md',
    'locales\zh-CN\03_Company\AI_Employees\AI-01_Founder_Office\START_PROMPT.md',
    'locales\zh-CN\03_Company\AI_Employees\AI-02_Builder_Evidence\ROLE.md',
    'locales\zh-CN\03_Company\AI_Employees\AI-02_Builder_Evidence\START_PROMPT.md',
    'locales\zh-CN\03_Company\AI_Employees\AI-03_Growth_Sales\ROLE.md',
    'locales\zh-CN\03_Company\AI_Employees\AI-03_Growth_Sales\START_PROMPT.md',
    'locales\zh-CN\03_Company\AI_Employees\AI-04_Research_Risk\ROLE.md',
    'locales\zh-CN\03_Company\AI_Employees\AI-04_Research_Risk\START_PROMPT.md',
    'locales\zh-CN\03_Company\AI_Employees\AI-05_Learning_Tutor\ROLE.md',
    'locales\zh-CN\03_Company\AI_Employees\AI-05_Learning_Tutor\START_PROMPT.md',
    'locales\zh-CN\03_Company\AI_Worklogs\WORKLOG_TEMPLATE.md',
    'locales\zh-CN\03_Company\Skills\README.md',
    '03_Company\AI_Worklogs\WORKLOG_TEMPLATE.md',
    'scripts\init-vault.ps1',
    'scripts\README.md',
    'tests\fixtures\sacp_dirty_run\decision.md',
    'tests\fixtures\sacp_dirty_run\worklog_ai02_completed.md',
    'tests\fixtures\sacp_dirty_run\handoff_ai02_to_ai03.md',
    'tests\fixtures\sacp_dirty_run\skill_customer_draft.md',
    'tests\fixtures\sacp_dirty_run\trial_ai03_receiving_worklog.md',
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
        -Language 'en' `
        -CreateDay1Worklog | Out-Null

    $generatedRequiredPaths = @(
        'AGENTS.md',
        'OBSIDIAN_HOME.md',
        'FIRST_30_MINUTES.md',
        '01_Founder',
        '02_Dashboards\DASHBOARD_Company_State.md',
        '02_Dashboards\DASHBOARD_Longju_Experiment.md',
        '02_Dashboards\DASHBOARD_Link_Map.md',
        '00_System_Brain\AI_Text_Maintenance_Protocol.md',
        '00_System_Brain\AI_Obsidian_Link_Maintenance_Prompt.md',
        '00_System_Brain\AI_TASK_PACKET_TEMPLATE_ZH.md',
        '00_System_Brain\CODEX_EXECUTION_ALIGNMENT_PROTOCOL.md',
        '00_System_Brain\LONGJU_DRIFT_CONTROL_PROTOCOL.md',
        '00_System_Brain\SACP_Protocol.md',
        '00_System_Brain\SACP_Agent_Bridge.md',
        '03_Company\Skills\README.md',
        '03_Company\Skills\SKILL_TEMPLATE.md',
        '03_Company\Skills\SKILL_LIBRARY.md',
        '03_Company\Skills\AGENT_SKILL_MATRIX.md',
        '03_Company\Skills\WORKLOG_TO_SKILL_PROMPT.md',
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

    $zhTestOutputPath = Join-Path -Path $tempRoot -ChildPath 'Solo-AI-Company-OS-Validation-zh-CN'
    Remove-TestOutput -Path $zhTestOutputPath -AllowedRoot $tempRoot

    & powershell -ExecutionPolicy Bypass -File (Join-Path -Path $repoRoot -ChildPath 'scripts\init-vault.ps1') `
        -OutputPath $zhTestOutputPath `
        -CompanyName 'Northstar Notes' `
        -FounderName 'Example Founder' `
        -ProjectName 'BriefForge' `
        -ProductName 'BriefForge' `
        -Language 'zh-CN' `
        -CreateDay1Worklog | Out-Null

    $zhGeneratedRequiredPaths = @(
        'AGENTS.md',
        'START_HERE.md',
        'FIRST_30_MINUTES.md',
        'OBSIDIAN_HOME.md',
        '02_Dashboards\DASHBOARD_Company_State.md',
        '02_Dashboards\DASHBOARD_Longju_Experiment.md',
        '00_System_Brain\AI_TASK_PACKET_TEMPLATE_ZH.md',
        '00_System_Brain\CODEX_EXECUTION_ALIGNMENT_PROTOCOL.md',
        '00_System_Brain\LONGJU_DRIFT_CONTROL_PROTOCOL.md',
        '00_System_Brain\SACP_Protocol.md',
        '00_System_Brain\SACP_Agent_Bridge.md',
        '03_Company\AI_Employees\COORDINATION_PROTOCOL.md',
        '03_Company\AI_Employees\README.md',
        '03_Company\AI_Employees\AI-01_Founder_Office\ROLE.md',
        '03_Company\AI_Employees\AI-01_Founder_Office\START_PROMPT.md',
        '03_Company\AI_Employees\AI-02_Builder_Evidence\ROLE.md',
        '03_Company\AI_Employees\AI-02_Builder_Evidence\START_PROMPT.md',
        '03_Company\AI_Employees\AI-03_Growth_Sales\ROLE.md',
        '03_Company\AI_Employees\AI-03_Growth_Sales\START_PROMPT.md',
        '03_Company\AI_Employees\AI-04_Research_Risk\ROLE.md',
        '03_Company\AI_Employees\AI-04_Research_Risk\START_PROMPT.md',
        '03_Company\AI_Employees\AI-05_Learning_Tutor\ROLE.md',
        '03_Company\AI_Employees\AI-05_Learning_Tutor\START_PROMPT.md',
        '03_Company\AI_Worklogs\WORKLOG_TEMPLATE.md',
        '03_Company\Skills\README.md'
    )

    foreach ($relativePath in $zhGeneratedRequiredPaths) {
        Assert-RequiredPath -Path (Join-Path -Path $zhTestOutputPath -ChildPath $relativePath)
    }

    $zhContent = Get-Content -LiteralPath (Join-Path -Path $zhTestOutputPath -ChildPath 'START_HERE.md') -Raw
    if ($zhContent -notmatch '<!-- locale: zh-CN -->') {
        throw 'Generated zh-CN START_HERE.md does not look localized.'
    }

    $zhExpectedTitle = -join ([char[]](0x4ECE, 0x8FD9, 0x91CC, 0x5F00, 0x59CB))
    if ($zhContent -notmatch [regex]::Escape($zhExpectedTitle)) {
        throw 'Generated zh-CN START_HERE.md has broken UTF-8 Chinese text.'
    }

    $zhPlaceholderMatches = Get-ChildItem -LiteralPath $zhTestOutputPath -Recurse -File -Filter '*.md' -Force |
        Select-String -Pattern $placeholderPatterns

    if ($zhPlaceholderMatches) {
        $summary = $zhPlaceholderMatches | Select-Object -First 20 Path, LineNumber, Line | Format-Table -AutoSize | Out-String
        throw "Generated zh-CN vault still has core placeholders:`n$summary"
    }

    Remove-TestOutput -Path $zhTestOutputPath -AllowedRoot $tempRoot
}

Write-Host 'VALIDATION_OK'
