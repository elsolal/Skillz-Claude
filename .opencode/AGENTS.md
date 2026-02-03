# Agent Instructions

> **Source of truth**: `.claude/CLAUDE.md`
>
> This file provides compatibility for non-Claude AI tools.
> All skills, knowledge, and workflows are defined in the `.claude/` directory.

## Quick Reference

### Available Skills (20)

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
| `figma-setup` | Configure Figma Code Connect (NEW v3.8) |
| `figma-to-code` | Generate code from Figma designs (NEW v3.8) |
| `github-issue-reader` | Parse GitHub issues |
| `codebase-explainer` | Analyze codebase |
| `implementation-planner` | Plan implementation |
| `code-implementer` | Write code |
| `test-runner` | Run tests |
| `code-reviewer` | Review code (3 passes) |
| `security-auditor` | Security audit (OWASP) |
| `performance-auditor` | Performance audit |
| `supabase-security` | Supabase security audit |
| `multi-mind` | Multi-AI debate (6 agents) |

### Workflows

**Planning** (Discovery):
```
Brainstorm → PRD → Architecture → Stories → GitHub Issues
```

**Development** (Feature):
```
Explain → Plan → Code → Test → Review ×3
```

### Key Principles

1. **Always read before edit** - Understand existing code first
2. **Validate at each step** - Wait for user approval
3. **Lint + Types** - Mandatory validation after code changes
4. **3 review passes** - Correctness → Readability → Performance
5. **Test everything** - No untested code

### Accessing Skills

Skills are in `./skills/` (symlinked to `.claude/skills/`).

Each skill has a `SKILL.md` file with:
- Activation checklist
- Process steps
- Output template
- Validation criteria

### Accessing Knowledge

Knowledge files are in `./knowledge/` (symlinked to `.claude/knowledge/`).

Categories:
- `testing/` - 32 files (test patterns, fixtures, etc.)
- `workflows/` - 10 files (templates)
- `brainstorming/` - 1 file (61 techniques)
- `multi-mind/` - 2 files (agent personalities)
- `supabase-security/` - 7 files (audit, RLS, remediation)
- `figma/` - 3 files (Code Connect, MCP tools, tokens mapping) (NEW v3.8)

---

**For complete instructions, see**: `.claude/CLAUDE.md`
