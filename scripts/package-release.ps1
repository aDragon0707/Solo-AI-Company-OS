param(
    [string]$Version = '0.1.0',
    [string]$OutputDir,
    [switch]$Force,
    [switch]$SkipValidation
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Add-TrailingSeparator {
    param([string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath($Path).TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
    return $fullPath + [System.IO.Path]::DirectorySeparatorChar
}

function Remove-SafeDirectory {
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
        throw "Refusing to remove directory outside allowed root: $fullPath"
    }

    Remove-Item -LiteralPath $fullPath -Recurse -Force
}

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path -Path $PSScriptRoot -ChildPath '..'))

if ([string]::IsNullOrWhiteSpace($OutputDir)) {
    $OutputDir = Join-Path -Path $repoRoot -ChildPath 'dist'
}

$outputRoot = [System.IO.Path]::GetFullPath($OutputDir)
$packageName = "Solo-AI-Company-OS-v$Version"
$zipPath = Join-Path -Path $outputRoot -ChildPath "$packageName.zip"

if (-not $SkipValidation) {
    & powershell -ExecutionPolicy Bypass -File (Join-Path -Path $repoRoot -ChildPath 'scripts\validate-release.ps1') | Out-Null
}

New-Item -ItemType Directory -Force -Path $outputRoot | Out-Null

if (Test-Path -LiteralPath $zipPath) {
    if (-not $Force) {
        Write-Error "Package already exists: $zipPath. Use -Force to replace it."
        exit 1
    }

    Remove-Item -LiteralPath $zipPath -Force
}

$tempRoot = [System.IO.Path]::GetTempPath()
$stagingRoot = Join-Path -Path $tempRoot -ChildPath "Solo-AI-Company-OS-Package-$([guid]::NewGuid().ToString('N'))"
$stagingProjectRoot = Join-Path -Path $stagingRoot -ChildPath $packageName

try {
    New-Item -ItemType Directory -Force -Path $stagingProjectRoot | Out-Null

    $excludedRootNames = @('.git', '.obsidian', 'dist')
    $sourceWithSlash = Add-TrailingSeparator -Path $repoRoot
    $sourceRootLength = $sourceWithSlash.Length

    Get-ChildItem -LiteralPath $repoRoot -Force -Recurse | ForEach-Object {
        $relativePath = $_.FullName.Substring($sourceRootLength)
        $rootName = ($relativePath -split '[\\/]', 2)[0]

        if ($excludedRootNames -contains $rootName) {
            return
        }

        $destinationPath = Join-Path -Path $stagingProjectRoot -ChildPath $relativePath

        if ($_.PSIsContainer) {
            New-Item -ItemType Directory -Force -Path $destinationPath | Out-Null
            return
        }

        $destinationParent = Split-Path -Parent $destinationPath
        New-Item -ItemType Directory -Force -Path $destinationParent | Out-Null
        Copy-Item -LiteralPath $_.FullName -Destination $destinationPath -Force
    }

    Compress-Archive -LiteralPath $stagingProjectRoot -DestinationPath $zipPath -Force
}
finally {
    Remove-SafeDirectory -Path $stagingRoot -AllowedRoot $tempRoot
}

Write-Host "PACKAGE_OK $zipPath"
