# make-claude-agent Installer for Windows
# Run: .\install.ps1

$ErrorActionPreference = "Stop"

# Get script directory (source files location)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Determine Claude config directory
$ClaudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { "$env:USERPROFILE\.claude" }

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  make-claude-agent Installer" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Source directory: $ScriptDir"
Write-Host "Target directory: $ClaudeDir"
Write-Host ""

# Verify source directory has .claude folder
if (-not (Test-Path "$ScriptDir\.claude")) {
    Write-Host "Error: Source .claude directory not found at $ScriptDir\.claude" -ForegroundColor Red
    exit 1
}

# Function to create directory if not exists
function Create-Dir {
    param([string]$Path)

    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Host "Created directory: $Path" -ForegroundColor Green
    }
}

# Function to copy file with overwrite confirmation
function Copy-FileWithConfirm {
    param(
        [string]$Source,
        [string]$Destination
    )

    $FileName = Split-Path -Leaf $Source

    if (-not (Test-Path $Source)) {
        Write-Host "Warning: Source file not found: $Source" -ForegroundColor Yellow
        return
    }

    if (Test-Path $Destination) {
        Write-Host "File already exists: $Destination" -ForegroundColor Yellow
        $answer = Read-Host "Overwrite? (y/n)"
        if ($answer -eq 'y' -or $answer -eq 'Y') {
            Copy-Item -Path $Source -Destination $Destination -Force
            Write-Host "Overwritten: $FileName" -ForegroundColor Green
        } else {
            Write-Host "Skipped: $FileName" -ForegroundColor Yellow
        }
    } else {
        Copy-Item -Path $Source -Destination $Destination -Force
        Write-Host "Installed: $FileName" -ForegroundColor Green
    }
}

# Auto-detect and install agents
$AgentsSrc = "$ScriptDir\.claude\agents"
$AgentNames = @()
if (Test-Path $AgentsSrc) {
    Write-Host "Installing agents..."
    foreach ($agentDir in Get-ChildItem -Path $AgentsSrc -Directory) {
        $agentName = $agentDir.Name
        $AgentNames += $agentName
        Create-Dir "$ClaudeDir\agents\$agentName"
        foreach ($file in Get-ChildItem -Path $agentDir.FullName -File) {
            Copy-FileWithConfirm $file.FullName "$ClaudeDir\agents\$agentName\$($file.Name)"
        }
    }
    Write-Host ""
} else {
    Write-Host "No agents directory found, skipping..." -ForegroundColor Yellow
    Write-Host ""
}

# Auto-detect and install skills
$SkillsSrc = "$ScriptDir\.claude\skills"
$SkillNames = @()
if (Test-Path $SkillsSrc) {
    Write-Host "Installing skills..."
    foreach ($skillDir in Get-ChildItem -Path $SkillsSrc -Directory) {
        $skillName = $skillDir.Name
        $SkillNames += $skillName
        Create-Dir "$ClaudeDir\skills\$skillName"
        foreach ($file in Get-ChildItem -Path $skillDir.FullName -File) {
            Copy-FileWithConfirm $file.FullName "$ClaudeDir\skills\$skillName\$($file.Name)"
        }
    }
    Write-Host ""
} else {
    Write-Host "No skills directory found, skipping..." -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Installed to: $ClaudeDir"
Write-Host ""

if ($AgentNames.Count -gt 0) {
    Write-Host "Agents:"
    foreach ($name in $AgentNames) {
        Write-Host "  - $name"
    }
    Write-Host ""
}

if ($SkillNames.Count -gt 0) {
    Write-Host "Skills:"
    foreach ($name in $SkillNames) {
        Write-Host "  - /$name"
    }
    Write-Host ""
}
