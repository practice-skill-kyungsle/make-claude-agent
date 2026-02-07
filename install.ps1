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

# Create target directories
Write-Host "Creating directories..."
Create-Dir "$ClaudeDir\agents\main-ai"
Create-Dir "$ClaudeDir\agents\strategy-ai"
Create-Dir "$ClaudeDir\agents\sub-ai"
Create-Dir "$ClaudeDir\agents\bug-diagnoser"
Create-Dir "$ClaudeDir\skills\dev-workflow"
Create-Dir "$ClaudeDir\skills\make-plan"
Create-Dir "$ClaudeDir\skills\run-plan"
Create-Dir "$ClaudeDir\skills\diagnosis-bug"
Write-Host ""

# Install agents
Write-Host "Installing agents..."
Copy-FileWithConfirm "$ScriptDir\.claude\agents\main-ai\main-ai.md" "$ClaudeDir\agents\main-ai\main-ai.md"
Copy-FileWithConfirm "$ScriptDir\.claude\agents\strategy-ai\strategy-ai.md" "$ClaudeDir\agents\strategy-ai\strategy-ai.md"
Copy-FileWithConfirm "$ScriptDir\.claude\agents\sub-ai\sub-ai.md" "$ClaudeDir\agents\sub-ai\sub-ai.md"
Copy-FileWithConfirm "$ScriptDir\.claude\agents\bug-diagnoser\bug-diagnoser.md" "$ClaudeDir\agents\bug-diagnoser\bug-diagnoser.md"
Write-Host ""

# Install skills
Write-Host "Installing skills..."
Copy-FileWithConfirm "$ScriptDir\.claude\skills\dev-workflow\SKILL.md" "$ClaudeDir\skills\dev-workflow\SKILL.md"
Copy-FileWithConfirm "$ScriptDir\.claude\skills\make-plan\SKILL.md" "$ClaudeDir\skills\make-plan\SKILL.md"
Copy-FileWithConfirm "$ScriptDir\.claude\skills\run-plan\SKILL.md" "$ClaudeDir\skills\run-plan\SKILL.md"
Copy-FileWithConfirm "$ScriptDir\.claude\skills\diagnosis-bug\SKILL.md" "$ClaudeDir\skills\diagnosis-bug\SKILL.md"
Write-Host ""

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Installed to: $ClaudeDir"
Write-Host ""
Write-Host "Agents:"
Write-Host "  - main-ai"
Write-Host "  - strategy-ai"
Write-Host "  - sub-ai"
Write-Host "  - bug-diagnoser"
Write-Host ""
Write-Host "Skills:"
Write-Host "  - /dev-workflow"
Write-Host "  - /make-plan"
Write-Host "  - /run-plan"
Write-Host "  - /diagnosis-bug"
Write-Host ""
