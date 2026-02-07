#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get script directory (source files location)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Determine Claude config directory
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

echo "============================================"
echo "  make-claude-agent Installer"
echo "============================================"
echo ""
echo "Source directory: $SCRIPT_DIR"
echo "Target directory: $CLAUDE_DIR"
echo ""

# Verify source directory has .claude folder
if [ ! -d "$SCRIPT_DIR/.claude" ]; then
    echo -e "${RED}Error: Source .claude directory not found at $SCRIPT_DIR/.claude${NC}"
    exit 1
fi

# Function to create directory if not exists
create_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo -e "${GREEN}Created directory: $dir${NC}"
    fi
}

# Function to copy file with overwrite confirmation
copy_file() {
    local src="$1"
    local dest="$2"
    local filename=$(basename "$src")

    if [ ! -f "$src" ]; then
        echo -e "${YELLOW}Warning: Source file not found: $src${NC}"
        return
    fi

    if [ -f "$dest" ]; then
        echo -e "${YELLOW}File already exists: $dest${NC}"
        read -p "Overwrite? (y/n): " answer
        case $answer in
            [Yy]* )
                cp "$src" "$dest"
                echo -e "${GREEN}Overwritten: $filename${NC}"
                ;;
            * )
                echo -e "${YELLOW}Skipped: $filename${NC}"
                ;;
        esac
    else
        cp "$src" "$dest"
        echo -e "${GREEN}Installed: $filename${NC}"
    fi
}

# Create target directories
echo "Creating directories..."
create_dir "$CLAUDE_DIR/agents/main-ai"
create_dir "$CLAUDE_DIR/agents/strategy-ai"
create_dir "$CLAUDE_DIR/agents/sub-ai"
create_dir "$CLAUDE_DIR/agents/bug-diagnoser"
create_dir "$CLAUDE_DIR/skills/dev-workflow"
create_dir "$CLAUDE_DIR/skills/make-plan"
create_dir "$CLAUDE_DIR/skills/run-plan"
create_dir "$CLAUDE_DIR/skills/diagnosis-bug"
echo ""

# Install agents
echo "Installing agents..."
copy_file "$SCRIPT_DIR/.claude/agents/main-ai/main-ai.md" "$CLAUDE_DIR/agents/main-ai/main-ai.md"
copy_file "$SCRIPT_DIR/.claude/agents/strategy-ai/strategy-ai.md" "$CLAUDE_DIR/agents/strategy-ai/strategy-ai.md"
copy_file "$SCRIPT_DIR/.claude/agents/sub-ai/sub-ai.md" "$CLAUDE_DIR/agents/sub-ai/sub-ai.md"
copy_file "$SCRIPT_DIR/.claude/agents/bug-diagnoser/bug-diagnoser.md" "$CLAUDE_DIR/agents/bug-diagnoser/bug-diagnoser.md"
echo ""

# Install skills
echo "Installing skills..."
copy_file "$SCRIPT_DIR/.claude/skills/dev-workflow/SKILL.md" "$CLAUDE_DIR/skills/dev-workflow/SKILL.md"
copy_file "$SCRIPT_DIR/.claude/skills/make-plan/SKILL.md" "$CLAUDE_DIR/skills/make-plan/SKILL.md"
copy_file "$SCRIPT_DIR/.claude/skills/run-plan/SKILL.md" "$CLAUDE_DIR/skills/run-plan/SKILL.md"
copy_file "$SCRIPT_DIR/.claude/skills/diagnosis-bug/SKILL.md" "$CLAUDE_DIR/skills/diagnosis-bug/SKILL.md"
echo ""

echo "============================================"
echo -e "${GREEN}Installation complete!${NC}"
echo "============================================"
echo ""
echo "Installed to: $CLAUDE_DIR"
echo ""
echo "Agents:"
echo "  - main-ai"
echo "  - strategy-ai"
echo "  - sub-ai"
echo "  - bug-diagnoser"
echo ""
echo "Skills:"
echo "  - /dev-workflow"
echo "  - /make-plan"
echo "  - /run-plan"
echo "  - /diagnosis-bug"
echo ""
