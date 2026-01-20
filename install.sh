#!/bin/bash

# ============================================================
# D-EPCT+R Workflow v2.5 Installer
# Install Claude Code skills + RALPH Mode + 35+ Knowledge Files
# Structure BMAD-inspired avec Activation, Principes, Règles
# NEW: UX Designer + UI Designer skills with auto-trigger
#
# Usage:
#   # Fresh install
#   curl -fsSL https://raw.githubusercontent.com/elsolal/Skillz-Claude/main/install.sh | bash -s -- .
#   ./install.sh /path/to/project
#
#   # Update existing installation (preserves CLAUDE.md, settings.json, mcp.json)
#   curl -fsSL https://raw.githubusercontent.com/elsolal/Skillz-Claude/main/install.sh | bash -s -- . --update
#   ./install.sh /path/to/project --update
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

# Parse arguments
UPDATE_MODE=false
TARGET_DIR=""

for arg in "$@"; do
    case $arg in
        --update)
            UPDATE_MODE=true
            ;;
        *)
            if [ -z "$TARGET_DIR" ]; then
                TARGET_DIR="$arg"
            fi
            ;;
    esac
done

# Default target is current directory
TARGET_DIR="${TARGET_DIR:-.}"
TARGET_DIR="$(cd "$TARGET_DIR" 2>/dev/null && pwd)" || TARGET_DIR="$(pwd)/${TARGET_DIR}"
TARGET_CLAUDE="$TARGET_DIR/.claude"
TARGET_DOCS="$TARGET_DIR/docs"

# Display header
echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════════════════╗"
if [ "$UPDATE_MODE" = true ]; then
echo "║             D-EPCT+R Workflow v2.5 Updater                            ║"
else
echo "║             D-EPCT+R Workflow v2.5 Installer                          ║"
fi
echo "║                                                                       ║"
echo "║   MODE MANUEL:  Validation humaine à chaque étape                     ║"
echo "║   MODE RALPH:   Boucle autonome jusqu'à complétion                    ║"
echo "║   KNOWLEDGE:    35+ fichiers (testing, workflows, PRD)                ║"
echo "║   UX/UI:        Skills design optionnels avec auto-trigger            ║"
echo "╚═══════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Update mode info
if [ "$UPDATE_MODE" = true ]; then
    echo -e "${CYAN}🔄 Mode UPDATE activé${NC}"
    echo -e "   → Skills, commands, hooks, examples, knowledge seront mis à jour"
    echo -e "   → CLAUDE.md, settings.json, mcp.json seront préservés"
    echo ""
fi

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

# Check if target already has .claude (for non-update mode)
MERGE_MODE=false
if [ -d "$TARGET_CLAUDE" ]; then
    if [ "$UPDATE_MODE" = true ]; then
        # Update mode - no confirmation needed
        echo -e "${BLUE}📦 Updating D-EPCT+R workflow in $TARGET_DIR...${NC}"
    else
        echo -e "${YELLOW}⚠️  Warning: .claude directory already exists in $TARGET_DIR${NC}"
        echo ""
        echo -e "   Pour mettre à jour, utilisez: ${CYAN}--update${NC}"
        echo ""
        read -p "Do you want to merge (skip existing files)? (y/n): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${RED}❌ Installation cancelled${NC}"
            exit 1
        fi
        MERGE_MODE=true
    fi
else
    if [ "$UPDATE_MODE" = true ]; then
        echo -e "${YELLOW}⚠️  No existing installation found. Running fresh install...${NC}"
        UPDATE_MODE=false
    fi
fi

if [ "$UPDATE_MODE" != true ] && [ "$MERGE_MODE" != true ]; then
    echo -e "${BLUE}📦 Installing D-EPCT+R workflow v2.5 to $TARGET_DIR...${NC}"
fi
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
mkdir -p "$TARGET_DOCS/planning/ux"
mkdir -p "$TARGET_DOCS/planning/prd"
mkdir -p "$TARGET_DOCS/planning/ui"
mkdir -p "$TARGET_DOCS/planning/architecture"
mkdir -p "$TARGET_DOCS/stories"
mkdir -p "$TARGET_DOCS/ralph-logs"
echo -e "   ${GREEN}✅ docs/planning/brainstorms/${NC}"
echo -e "   ${GREEN}✅ docs/planning/ux/${NC}"
echo -e "   ${GREEN}✅ docs/planning/prd/${NC}"
echo -e "   ${GREEN}✅ docs/planning/ui/${NC}"
echo -e "   ${GREEN}✅ docs/planning/architecture/${NC}"
echo -e "   ${GREEN}✅ docs/stories/${NC}"
echo -e "   ${GREEN}✅ docs/ralph-logs/${NC}"

# Copy knowledge base (always update in UPDATE_MODE)
echo -e "${GREEN}📚 Installing Knowledge Base (35+ files)...${NC}"
if [ -d "$SOURCE_CLAUDE/knowledge" ]; then
    # Copy testing knowledge (32 files)
    if [ -d "$SOURCE_CLAUDE/knowledge/testing" ]; then
        cp -r "$SOURCE_CLAUDE/knowledge/testing/"* "$TARGET_CLAUDE/knowledge/testing/" 2>/dev/null || true
        testing_count=$(ls -1 "$SOURCE_CLAUDE/knowledge/testing/"*.md 2>/dev/null | wc -l | tr -d ' ')
        if [ "$UPDATE_MODE" = true ]; then
            echo -e "   ${CYAN}🔄 testing/ ($testing_count files)${NC}"
        else
            echo -e "   ${GREEN}✅ testing/ ($testing_count files)${NC}"
        fi
    fi
    # Copy workflows knowledge
    if [ -d "$SOURCE_CLAUDE/knowledge/workflows" ]; then
        cp -r "$SOURCE_CLAUDE/knowledge/workflows/"* "$TARGET_CLAUDE/knowledge/workflows/" 2>/dev/null || true
        workflows_count=$(ls -1 "$SOURCE_CLAUDE/knowledge/workflows/"* 2>/dev/null | wc -l | tr -d ' ')
        if [ "$UPDATE_MODE" = true ]; then
            echo -e "   ${CYAN}🔄 workflows/ ($workflows_count files)${NC}"
        else
            echo -e "   ${GREEN}✅ workflows/ ($workflows_count files)${NC}"
        fi
    fi
    # Copy index (only if source != destination)
    if [ -f "$SOURCE_CLAUDE/knowledge/tea-index.csv" ]; then
        SOURCE_INDEX="$(cd "$(dirname "$SOURCE_CLAUDE/knowledge/tea-index.csv")" && pwd)/tea-index.csv"
        TARGET_INDEX="$TARGET_CLAUDE/knowledge/tea-index.csv"
        if [ "$SOURCE_INDEX" != "$TARGET_INDEX" ]; then
            cp "$SOURCE_CLAUDE/knowledge/tea-index.csv" "$TARGET_CLAUDE/knowledge/"
            if [ "$UPDATE_MODE" = true ]; then
                echo -e "   ${CYAN}🔄 tea-index.csv${NC}"
            else
                echo -e "   ${GREEN}✅ tea-index.csv${NC}"
            fi
        else
            echo -e "   ${GREEN}✅ tea-index.csv (already in place)${NC}"
        fi
    fi
fi

# Copy skills
echo -e "${GREEN}📁 Installing skills (12)...${NC}"
for skill_dir in "$SOURCE_CLAUDE/skills"/*; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        target_skill="$TARGET_CLAUDE/skills/$skill_name"

        if [ "$UPDATE_MODE" = true ]; then
            # Update mode: always overwrite skills
            rm -rf "$target_skill" 2>/dev/null || true
            mkdir -p "$target_skill"
            cp -r "$skill_dir"/* "$target_skill/" 2>/dev/null || cp -r "$skill_dir"/. "$target_skill/" 2>/dev/null || true
            echo -e "   ${CYAN}🔄 $skill_name${NC}"
        elif [ -d "$target_skill" ] && [ "$MERGE_MODE" = true ]; then
            echo -e "   ${YELLOW}⚠️  Skipping $skill_name (already exists)${NC}"
        else
            mkdir -p "$target_skill"
            cp -r "$skill_dir"/* "$target_skill/" 2>/dev/null || cp -r "$skill_dir"/. "$target_skill/" 2>/dev/null || true
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

        if [ "$UPDATE_MODE" = true ]; then
            # Update mode: always overwrite commands
            cp "$cmd_file" "$TARGET_CLAUDE/commands/"
            echo -e "   ${CYAN}🔄 $cmd_name${NC}"
        elif [ -f "$target_cmd" ] && [ "$MERGE_MODE" = true ]; then
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

            if [ "$UPDATE_MODE" = true ]; then
                # Update mode: always overwrite hooks
                cp "$hook_file" "$TARGET_CLAUDE/hooks/"
                chmod +x "$TARGET_CLAUDE/hooks/$hook_name"
                echo -e "   ${CYAN}🔄 $hook_name${NC}"
            elif [ -f "$target_hook" ] && [ "$MERGE_MODE" = true ]; then
                echo -e "   ${YELLOW}⚠️  Skipping $hook_name (already exists)${NC}"
            else
                cp "$hook_file" "$TARGET_CLAUDE/hooks/"
                chmod +x "$TARGET_CLAUDE/hooks/$hook_name"
                echo -e "   ${GREEN}✅ $hook_name${NC}"
            fi
        fi
    done
fi

# Copy examples
echo -e "${GREEN}📁 Installing examples (3 projects)...${NC}"
mkdir -p "$TARGET_CLAUDE/examples"
if [ -d "$SOURCE_CLAUDE/examples" ]; then
    for example_dir in "$SOURCE_CLAUDE/examples"/*; do
        if [ -d "$example_dir" ]; then
            example_name=$(basename "$example_dir")
            target_example="$TARGET_CLAUDE/examples/$example_name"

            if [ "$UPDATE_MODE" = true ]; then
                # Update mode: always overwrite examples
                rm -rf "$target_example" 2>/dev/null || true
                mkdir -p "$target_example"
                cp -r "$example_dir"/* "$target_example/" 2>/dev/null || cp -r "$example_dir"/. "$target_example/" 2>/dev/null || true
                echo -e "   ${CYAN}🔄 $example_name${NC}"
            elif [ -d "$target_example" ] && [ "$MERGE_MODE" = true ]; then
                echo -e "   ${YELLOW}⚠️  Skipping $example_name (already exists)${NC}"
            else
                mkdir -p "$target_example"
                cp -r "$example_dir"/* "$target_example/" 2>/dev/null || cp -r "$example_dir"/. "$target_example/" 2>/dev/null || true
                echo -e "   ${GREEN}✅ $example_name${NC}"
            fi
        fi
    done
fi

# Copy mcp.json (PRESERVE in update mode)
echo -e "${GREEN}📄 Installing mcp.json...${NC}"
if [ -f "$SOURCE_CLAUDE/mcp.json" ]; then
    if [ -f "$TARGET_CLAUDE/mcp.json" ]; then
        if [ "$UPDATE_MODE" = true ]; then
            echo -e "   ${GREEN}✅ mcp.json (preserved - your config)${NC}"
        else
            echo -e "   ${YELLOW}⚠️  mcp.json exists - creating mcp.d-epct.json${NC}"
            cp "$SOURCE_CLAUDE/mcp.json" "$TARGET_CLAUDE/mcp.d-epct.json"
            echo -e "   ${YELLOW}📝 NOTE: Merge mcp.d-epct.json into your existing mcp.json${NC}"
        fi
    else
        cp "$SOURCE_CLAUDE/mcp.json" "$TARGET_CLAUDE/"
        echo -e "   ${GREEN}✅ mcp.json${NC}"
    fi
fi

# Copy settings.json (PRESERVE in update mode)
echo -e "${GREEN}📄 Installing settings.json...${NC}"
if [ -f "$SOURCE_CLAUDE/settings.json" ]; then
    if [ -f "$TARGET_CLAUDE/settings.json" ]; then
        if [ "$UPDATE_MODE" = true ]; then
            echo -e "   ${GREEN}✅ settings.json (preserved - your config)${NC}"
        else
            echo -e "   ${YELLOW}⚠️  settings.json exists - creating settings.ralph.json${NC}"
            cp "$SOURCE_CLAUDE/settings.json" "$TARGET_CLAUDE/settings.ralph.json"
            echo -e "   ${YELLOW}📝 NOTE: Merge settings.ralph.json into your existing settings.json${NC}"
        fi
    else
        cp "$SOURCE_CLAUDE/settings.json" "$TARGET_CLAUDE/"
        echo -e "   ${GREEN}✅ settings.json${NC}"
    fi
fi

# Handle CLAUDE.md (PRESERVE in update mode)
echo -e "${GREEN}📄 Installing CLAUDE.md...${NC}"
if [ -f "$TARGET_CLAUDE/CLAUDE.md" ]; then
    if [ "$UPDATE_MODE" = true ]; then
        echo -e "   ${GREEN}✅ CLAUDE.md (preserved - your customizations)${NC}"
    else
        echo -e "   ${YELLOW}⚠️  CLAUDE.md exists - creating CLAUDE.d-epct.md instead${NC}"
        cp "$SOURCE_CLAUDE/CLAUDE.md" "$TARGET_CLAUDE/CLAUDE.d-epct.md"
        echo ""
        echo -e "${YELLOW}📝 NOTE: Merge the content of CLAUDE.d-epct.md into your existing CLAUDE.md${NC}"
    fi
else
    cp "$SOURCE_CLAUDE/CLAUDE.md" "$TARGET_CLAUDE/"
    echo -e "   ${GREEN}✅ CLAUDE.md${NC}"
fi

# Create .gitkeep files to preserve empty directories
touch "$TARGET_DOCS/planning/brainstorms/.gitkeep"
touch "$TARGET_DOCS/planning/ux/.gitkeep"
touch "$TARGET_DOCS/planning/prd/.gitkeep"
touch "$TARGET_DOCS/planning/ui/.gitkeep"
touch "$TARGET_DOCS/planning/architecture/.gitkeep"
touch "$TARGET_DOCS/stories/.gitkeep"
touch "$TARGET_DOCS/ralph-logs/.gitkeep"

echo ""
if [ "$UPDATE_MODE" = true ]; then
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════╗"
echo -e "║                       ✅ Update Complete!                            ║"
echo -e "╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}Updated components:${NC}"
echo -e "   ${CYAN}🔄 Skills (12 including UX/UI designers)${NC}"
echo -e "   ${CYAN}🔄 Commands (6)${NC}"
echo -e "   ${CYAN}🔄 Hooks${NC}"
echo -e "   ${CYAN}🔄 Knowledge Base (35+ files)${NC}"
echo -e "   ${CYAN}🔄 Examples (3 projects)${NC}"
echo ""
echo -e "${GREEN}Preserved (your customizations):${NC}"
echo -e "   ${GREEN}✅ CLAUDE.md${NC}"
echo -e "   ${GREEN}✅ settings.json${NC}"
echo -e "   ${GREEN}✅ mcp.json${NC}"
else
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
echo -e "${BLUE}  📂 Examples (3 projects):${NC}"
echo "    simple-api/      API REST simple (mode LIGHT)"
echo "    blog-nextjs/     Blog Next.js (mode FULL)"
echo "    saas-dashboard/  Dashboard SaaS (mode RALPH)"
echo ""
echo -e "${BLUE}  🔌 MCP Servers (3):${NC}"
echo "    context7         Documentation up-to-date"
echo "    figma            Extraction designs"
echo "    chrome-devtools  Tests UI automatisés"
echo ""
echo -e "${BLUE}  Skills (12):${NC}"
echo "    Planning:  idea-brainstorm, pm-prd, architect, pm-stories"
echo "    Design:    ux-designer, ui-designer (auto-triggered)"
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
fi
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
if [ "$UPDATE_MODE" != true ]; then
echo -e "${CYAN}Workflow:${NC}"
echo ""
echo "  Planning:  🧠 Brainstorm → 📋 PRD → 🏗️ Architecture → 📝 Stories"
echo "  Dev:       🔍 Explain → 📝 Plan → 💻 Code → 🧪 Test → 🔄 Review ×3"
echo ""
echo -e "${CYAN}Documentation:${NC}"
echo ""
echo "  Les skills chargent automatiquement le knowledge pertinent."
echo "  Voir .claude/knowledge/tea-index.csv pour l'index complet."
echo "  Voir .claude/examples/ pour des projets exemples complets."
echo ""
fi
echo -e "${CYAN}Update:${NC}"
echo ""
echo "  # Pour mettre à jour vers la dernière version:"
echo "  curl -fsSL https://raw.githubusercontent.com/elsolal/Skillz-Claude/main/install.sh | bash -s -- . --update"
echo ""
