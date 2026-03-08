# Agent Instructions

> **Source of truth**: `.claude/CLAUDE.md`
>
> This file provides compatibility for non-Claude AI tools.
> All skills, knowledge, and workflows are defined in the `.claude/` directory.

## Quick Reference

### Available Skills (21)

| Skill | Purpose |
|-------|---------|
| `idea-brainstorm` | Creative exploration with 61 techniques |
| `pm-prd` | Product Requirements Document |
| `architect` | Technical architecture |
| `pm-stories` | Epics + User Stories |
| `ux-designer` | UX design (personas, journeys) |
| `ui-designer` | UI design (tokens, components, Figma import) |
| `api-designer` | API design (OpenAPI) |
| `database-designer` | Database schema (ERD) |
| `figma-setup` | Configure Figma Code Connect |
| `figma-to-code` | Generate code from Figma designs |
| `figma-designer` | Create designs in Figma (NEW v4.0) |
| `figma-design-system` | Design system management (NEW v4.0) |
| `figma-design-code-sync` | Bidirectional design-code sync (NEW v4.0) |
| `github-issue-reader` | Parse GitHub issues |
| `code-implementer` | Write code (multi-agent worker) |
| `test-runner` | Run tests (multi-agent worker) |
| `code-reviewer` | Review code (3 passes, parallel-ready) |
| `security-auditor` | Security audit (OWASP) |
| `performance-auditor` | Performance audit |
| `supabase-security` | Supabase security audit |
| `multi-mind` | Multi-AI debate (6 agents) |

### Workflows

**Planning** (Discovery):
```
Brainstorm → PRD → Architecture → Stories → GitHub Issues
```

**Development** (Feature) — Multi-Agent v4.0:
```
Explore (native) → Plan (native) → Code+Tests (2 agents //) → Review ×3 (3 agents //)
```

### Key Principles

1. **Always read before edit** - Understand existing code first
2. **Validate at each step** - Wait for user approval
3. **Lint + Types** - Mandatory validation after code changes
4. **3 review passes** - Correctness → Readability → Performance
5. **Test everything** - No untested code

### Accessing Skills

Skills are in `./skills/` (symlinked to `.claude/skills/`).

### Accessing Knowledge

Knowledge files are in `./knowledge/` (symlinked to `.claude/knowledge/`).

---

**For complete instructions, see**: `.claude/CLAUDE.md`
