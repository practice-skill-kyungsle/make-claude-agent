#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory (source files location)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Determine Claude config directory
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN}  make-claude-agent Installer${NC}"
echo -e "${CYAN}============================================${NC}"
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

# Auto-detect and install agents
AGENTS_SRC="$SCRIPT_DIR/.claude/agents"
AGENT_NAMES=()
if [ -d "$AGENTS_SRC" ]; then
    echo "Installing agents..."
    for agent_dir in "$AGENTS_SRC"/*/; do
        [ -d "$agent_dir" ] || continue
        agent_name=$(basename "$agent_dir")
        AGENT_NAMES+=("$agent_name")
        create_dir "$CLAUDE_DIR/agents/$agent_name"
        for file in "$agent_dir"*; do
            [ -f "$file" ] || continue
            filename=$(basename "$file")
            copy_file "$file" "$CLAUDE_DIR/agents/$agent_name/$filename"
        done
    done
    echo ""
else
    echo -e "${YELLOW}No agents directory found, skipping...${NC}"
    echo ""
fi

# Auto-detect and install skills
SKILLS_SRC="$SCRIPT_DIR/.claude/skills"
SKILL_NAMES=()
if [ -d "$SKILLS_SRC" ]; then
    echo "Installing skills..."
    for skill_dir in "$SKILLS_SRC"/*/; do
        [ -d "$skill_dir" ] || continue
        skill_name=$(basename "$skill_dir")
        SKILL_NAMES+=("$skill_name")
        create_dir "$CLAUDE_DIR/skills/$skill_name"
        for file in "$skill_dir"*; do
            [ -f "$file" ] || continue
            filename=$(basename "$file")
            copy_file "$file" "$CLAUDE_DIR/skills/$skill_name/$filename"
        done
    done
    echo ""
else
    echo -e "${YELLOW}No skills directory found, skipping...${NC}"
    echo ""
fi

echo -e "${CYAN}============================================${NC}"
echo -e "${GREEN}Installation complete!${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""
echo "Installed to: $CLAUDE_DIR"
echo ""

if [ ${#AGENT_NAMES[@]} -gt 0 ]; then
    echo "Agents:"
    for name in "${AGENT_NAMES[@]}"; do
        echo "  - $name"
    done
    echo ""
fi

if [ ${#SKILL_NAMES[@]} -gt 0 ]; then
    echo "Skills:"
    for name in "${SKILL_NAMES[@]}"; do
        echo "  - /$name"
    done
    echo ""
fi
