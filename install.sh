#!/bin/bash

# ============================================================
# D-EPCT+R Workflow v2.4 Installer
# Install Claude Code skills + RALPH Mode + 35+ Knowledge Files
# Structure BMAD-inspired avec Activation, Principes, Règles
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/elsolal/Skillz-Claude/main/install.sh | bash -s -- .
#   ./install.sh /path/to/project
# ============================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

REPO_URL="https://github.com/elsolal/Skillz-Claude.git"
REPO_NAME="Skillz-Claude"

# Default target is current directory
TARGET_DIR="${1:-.}"
TARGET_DIR="$(cd "$TARGET_DIR" 2>/dev/null && pwd)" || TARGET_DIR="$(pwd)/${1:-.}"
TARGET_CLAUDE="$TARGET_DIR/.claude"
TARGET_DOCS="$TARGET_DIR/docs"

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════════════════╗"
echo "║               D-EPCT+R Workflow v2.4 Installer                        ║"
echo "║                                                                       ║"
echo "║   MODE MANUEL:  Validation humaine à chaque étape                     ║"
echo "║   MODE RALPH:   Boucle autonome jusqu'à complétion                    ║"
echo "║   KNOWLEDGE:    35+ fichiers (testing, workflows, PRD)                ║"
echo "║   STRUCTURE:    Skills BMAD-inspired (Activation, Principes, Règles)  ║"
echo "╚═══════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Determine source directory
# If run via curl pipe, we need to clone the repo first
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" 2>/dev/null)" 2>/dev/null && pwd)" || SCRIPT_DIR=""

if [ -z "$SCRIPT_DIR" ] || [ ! -d "$SCRIPT_DIR/.claude" ]; then
    # Running via curl pipe or .claude not found - need to clone
    echo -e "${BLUE}📥 Downloading D-EPCT+R workflow from GitHub...${NC}"

    TEMP_DIR=$(mktemp -d)
    trap "rm -rf $TEMP_DIR" EXIT

    if command -v git &> /dev/null; then
        git clone --depth 1 --quiet "$REPO_URL" "$TEMP_DIR/$REPO_NAME"
    else
        echo -e "${RED}❌ Error: git is required but not installed${NC}"
        exit 1
    fi

    SOURCE_CLAUDE="$TEMP_DIR/$REPO_NAME/.claude"
    echo -e "${GREEN}✅ Downloaded successfully${NC}"
    echo ""
else
    # Running from cloned repo
    SOURCE_CLAUDE="$SCRIPT_DIR/.claude"
fi

# Check source exists
if [ ! -d "$SOURCE_CLAUDE" ]; then
    echo -e "${RED}❌ Error: .claude directory not found${NC}"
    exit 1
fi

# Check if target already has .claude
if [ -d "$TARGET_CLAUDE" ]; then
    echo -e "${YELLOW}⚠️  Warning: .claude directory already exists in $TARGET_DIR${NC}"
    echo ""
    read -p "Do you want to merge? (y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}❌ Installation cancelled${NC}"
        exit 1
    fi
    MERGE_MODE=true
else
    MERGE_MODE=false
fi

echo -e "${BLUE}📦 Installing D-EPCT+R workflow v2.4 to $TARGET_DIR...${NC}"
echo ""

# Create directories if needed
mkdir -p "$TARGET_CLAUDE/skills"
mkdir -p "$TARGET_CLAUDE/commands"
mkdir -p "$TARGET_CLAUDE/hooks"
mkdir -p "$TARGET_CLAUDE/knowledge/testing"
mkdir -p "$TARGET_CLAUDE/knowledge/workflows"

# Create docs structure
echo -e "${GREEN}📁 Creating docs structure...${NC}"
mkdir -p "$TARGET_DOCS/planning/brainstorms"
mkdir -p "$TARGET_DOCS/planning/prd"
mkdir -p "$TARGET_DOCS/planning/architecture"
mkdir -p "$TARGET_DOCS/stories"
mkdir -p "$TARGET_DOCS/ralph-logs"
echo -e "   ${GREEN}✅ docs/planning/brainstorms/${NC}"
echo -e "   ${GREEN}✅ docs/planning/prd/${NC}"
echo -e "   ${GREEN}✅ docs/planning/architecture/${NC}"
echo -e "   ${GREEN}✅ docs/stories/${NC}"
echo -e "   ${GREEN}✅ docs/ralph-logs/${NC}"

# Copy knowledge base
echo -e "${GREEN}📚 Installing Knowledge Base (35+ files)...${NC}"
if [ -d "$SOURCE_CLAUDE/knowledge" ]; then
    # Copy testing knowledge (32 files)
    if [ -d "$SOURCE_CLAUDE/knowledge/testing" ]; then
        cp -r "$SOURCE_CLAUDE/knowledge/testing/"* "$TARGET_CLAUDE/knowledge/testing/" 2>/dev/null || true
        testing_count=$(ls -1 "$SOURCE_CLAUDE/knowledge/testing/"*.md 2>/dev/null | wc -l | tr -d ' ')
        echo -e "   ${GREEN}✅ testing/ ($testing_count files)${NC}"
    fi
    # Copy workflows knowledge
    if [ -d "$SOURCE_CLAUDE/knowledge/workflows" ]; then
        cp -r "$SOURCE_CLAUDE/knowledge/workflows/"* "$TARGET_CLAUDE/knowledge/workflows/" 2>/dev/null || true
        workflows_count=$(ls -1 "$SOURCE_CLAUDE/knowledge/workflows/"* 2>/dev/null | wc -l | tr -d ' ')
        echo -e "   ${GREEN}✅ workflows/ ($workflows_count files)${NC}"
    fi
    # Copy index
    if [ -f "$SOURCE_CLAUDE/knowledge/tea-index.csv" ]; then
        cp "$SOURCE_CLAUDE/knowledge/tea-index.csv" "$TARGET_CLAUDE/knowledge/"
        echo -e "   ${GREEN}✅ tea-index.csv${NC}"
    fi
fi

# Copy skills
echo -e "${GREEN}📁 Installing skills (10)...${NC}"
for skill_dir in "$SOURCE_CLAUDE/skills"/*; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        target_skill="$TARGET_CLAUDE/skills/$skill_name"

        if [ -d "$target_skill" ] && [ "$MERGE_MODE" = true ]; then
            echo -e "   ${YELLOW}⚠️  Skipping $skill_name (already exists)${NC}"
        else
            cp -r "$skill_dir" "$TARGET_CLAUDE/skills/"
            echo -e "   ${GREEN}✅ $skill_name${NC}"
        fi
    fi
done

# Copy commands
echo -e "${GREEN}📁 Installing commands (6)...${NC}"
for cmd_file in "$SOURCE_CLAUDE/commands"/*.md; do
    if [ -f "$cmd_file" ]; then
        cmd_name=$(basename "$cmd_file")
        target_cmd="$TARGET_CLAUDE/commands/$cmd_name"

        if [ -f "$target_cmd" ] && [ "$MERGE_MODE" = true ]; then
            echo -e "   ${YELLOW}⚠️  Skipping $cmd_name (already exists)${NC}"
        else
            cp "$cmd_file" "$TARGET_CLAUDE/commands/"
            echo -e "   ${GREEN}✅ $cmd_name${NC}"
        fi
    fi
done

# Copy hooks
echo -e "${GREEN}📁 Installing RALPH hooks...${NC}"
if [ -d "$SOURCE_CLAUDE/hooks" ]; then
    for hook_file in "$SOURCE_CLAUDE/hooks"/*; do
        if [ -f "$hook_file" ]; then
            hook_name=$(basename "$hook_file")
            target_hook="$TARGET_CLAUDE/hooks/$hook_name"

            if [ -f "$target_hook" ] && [ "$MERGE_MODE" = true ]; then
                echo -e "   ${YELLOW}⚠️  Skipping $hook_name (already exists)${NC}"
            else
                cp "$hook_file" "$TARGET_CLAUDE/hooks/"
                chmod +x "$TARGET_CLAUDE/hooks/$hook_name"
                echo -e "   ${GREEN}✅ $hook_name${NC}"
            fi
        fi
    done
fi

# Copy settings.json
echo -e "${GREEN}📄 Installing settings.json...${NC}"
if [ -f "$SOURCE_CLAUDE/settings.json" ]; then
    if [ -f "$TARGET_CLAUDE/settings.json" ] && [ "$MERGE_MODE" = true ]; then
        echo -e "   ${YELLOW}⚠️  settings.json exists - creating settings.ralph.json${NC}"
        cp "$SOURCE_CLAUDE/settings.json" "$TARGET_CLAUDE/settings.ralph.json"
        echo -e "   ${YELLOW}📝 NOTE: Merge settings.ralph.json into your existing settings.json${NC}"
    else
        cp "$SOURCE_CLAUDE/settings.json" "$TARGET_CLAUDE/"
        echo -e "   ${GREEN}✅ settings.json${NC}"
    fi
fi

# Handle CLAUDE.md
echo -e "${GREEN}📄 Installing CLAUDE.md...${NC}"
if [ -f "$TARGET_CLAUDE/CLAUDE.md" ] && [ "$MERGE_MODE" = true ]; then
    echo -e "   ${YELLOW}⚠️  CLAUDE.md exists - creating CLAUDE.d-epct.md instead${NC}"
    cp "$SOURCE_CLAUDE/CLAUDE.md" "$TARGET_CLAUDE/CLAUDE.d-epct.md"
    echo ""
    echo -e "${YELLOW}📝 NOTE: Merge the content of CLAUDE.d-epct.md into your existing CLAUDE.md${NC}"
else
    cp "$SOURCE_CLAUDE/CLAUDE.md" "$TARGET_CLAUDE/"
    echo -e "   ${GREEN}✅ CLAUDE.md${NC}"
fi

# Create .gitkeep files to preserve empty directories
touch "$TARGET_DOCS/planning/brainstorms/.gitkeep"
touch "$TARGET_DOCS/planning/prd/.gitkeep"
touch "$TARGET_DOCS/planning/architecture/.gitkeep"
touch "$TARGET_DOCS/stories/.gitkeep"
touch "$TARGET_DOCS/ralph-logs/.gitkeep"

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════╗"
echo -e "║                     ✅ Installation Complete!                         ║"
echo -e "╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}Installed components:${NC}"
echo ""
echo -e "${BLUE}  📚 Knowledge Base (35+ files):${NC}"
echo "    testing/     32 files (test levels, priorities, factories, fixtures...)"
echo "    workflows/   3 files (PRD template, complexity matrix, project types)"
echo ""
echo -e "${BLUE}  Skills (10):${NC}"
echo "    Planning:  idea-brainstorm, pm-prd, architect, pm-stories"
echo "    Dev:       github-issue-reader, codebase-explainer,"
echo "               implementation-planner, code-implementer,"
echo "               test-runner, code-reviewer"
echo ""
echo -e "${BLUE}  Commands - Mode Manuel:${NC}"
echo "    /discovery           Planning avec validation"
echo "    /feature #123        Dev avec validation"
echo ""
echo -e "${MAGENTA}  Commands - Mode RALPH (autonome):${NC}"
echo "    /auto-loop \"prompt\"  Boucle générique"
echo "    /auto-discovery      Planning autonome"
echo "    /auto-feature #123   Dev autonome"
echo "    /cancel-ralph        Arrêter la boucle"
echo ""
echo -e "${CYAN}Usage:${NC}"
echo ""
echo "  cd $TARGET_DIR"
echo "  claude"
echo ""
echo -e "  ${BLUE}# Mode Manuel (validation humaine)${NC}"
echo "  /discovery"
echo "  /feature #123"
echo ""
echo -e "  ${MAGENTA}# Mode RALPH (autonome)${NC}"
echo "  /auto-discovery \"Je veux créer une app de todo\""
echo "  /auto-feature #123 --max 50"
echo ""
echo -e "${CYAN}Workflow:${NC}"
echo ""
echo "  Planning:  🧠 Brainstorm → 📋 PRD → 🏗️ Architecture → 📝 Stories"
echo "  Dev:       🔍 Explain → 📝 Plan → 💻 Code → 🧪 Test → 🔄 Review ×3"
echo ""
echo -e "${CYAN}Knowledge disponible:${NC}"
echo ""
echo "  Les skills chargent automatiquement le knowledge pertinent."
echo "  Voir .claude/knowledge/tea-index.csv pour l'index complet."
echo ""
