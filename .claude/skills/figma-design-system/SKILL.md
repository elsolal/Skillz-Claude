---
name: figma-design-system
description: Use when managing a design system in Figma — creating/updating tokens, auditing component consistency, syncing code components back to Figma, detecting drift between code and Figma design system, or when a user says "create design system", "sync tokens to Figma", "audit design system", "update Figma components from code", or "the design system is inconsistent".
---

# Figma Design System Manager

Manages the design system in Figma: tokens, components, parity with code, and drift correction. This is the **reverse direction** of `figma-design-code-sync` — it pushes code truth INTO Figma.

## Prerequisites

Figma Console MCP must be running and connected. Check with `figma_get_status`.

## When to Use

- **Create** — Build a design system from scratch in Figma (tokens, component library)
- **Audit** — Check consistency of the existing DS (missing tokens, orphan styles, drift)
- **Sync code→Figma** — Code component evolved, update the Figma counterpart
- **Uniformize** — Detect and fix inconsistencies across Figma components

**When NOT to use:**
- Figma→code direction → use `figma-to-code` or `figma-design-code-sync`
- Creating UI screens/prototypes → use `figma-designer`
- Initial Code Connect installation → use `figma-setup`

## Core Rules

- **ALWAYS** call `figma_search_components` at session start
- **ALWAYS** use batch tools for multi-variable operations (`figma_batch_create_variables`, `figma_batch_update_variables`, `figma_setup_design_tokens`)
- **ALWAYS** screenshot after modifications to validate visually
- **ALWAYS** audit before modifying — understand current state first
- **NEVER** delete existing variables/components without explicit user approval
- **NEVER** overwrite Figma values without showing the diff first

## Workflow: Create Design System

### 1. Analyze Source of Truth

Determine where tokens come from:

```markdown
**Source des tokens** :

| Source | Trouvé | Fichier |
|--------|--------|---------|
| CSS variables | ✅/❌ | `src/styles/tokens.css` |
| Tailwind config | ✅/❌ | `tailwind.config.ts` |
| Theme file | ✅/❌ | `src/theme.ts` |
| Design doc | ✅/❌ | `docs/planning/ui/` |
| Existing Figma vars | ✅/❌ | [file] |

**Stratégie** : [which source is the reference]
```

### 2. Create Token Collections

Use `figma_setup_design_tokens` for atomic creation:

```
Collection: "Design Tokens"
Modes: ["Light", "Dark"]

Variables:
├── Color/
│   ├── primary-50 → primary-950
│   ├── neutral-50 → neutral-950
│   ├── success, warning, error, info
│   └── background, foreground, border, muted
├── Spacing/
│   ├── xs (4), sm (8), md (16), lg (24), xl (32), 2xl (48)
│   └── ...
├── Radius/
│   ├── sm (4), md (8), lg (12), xl (16), full (9999)
│   └── ...
├── Typography/
│   ├── font-size: xs → 5xl
│   ├── font-weight: normal, medium, semibold, bold
│   └── line-height: tight, normal, relaxed
└── Shadows/
    ├── sm, md, lg, xl
    └── ...
```

#### Mapping Code Tokens → Figma Variables

| Code (CSS/Tailwind) | Figma Variable | Type |
|---------------------|----------------|------|
| `--color-primary-500` / `colors.primary.500` | `Color/primary-500` | COLOR |
| `--space-md` / `spacing.4` | `Spacing/md` | FLOAT |
| `--radius-lg` / `borderRadius.lg` | `Radius/lg` | FLOAT |
| `--font-size-base` / `fontSize.base` | `Typography/font-size-base` | FLOAT |

### 3. Create Component Library

For each code component, create its Figma counterpart:

```javascript
// Create a component set (variants)
const componentSet = figma.combineAsVariants(variants, parentFrame);
componentSet.name = 'Button';

// Or create a single component
const component = figma.createComponent();
component.name = 'Button';

// Add component properties
// → use figma_add_component_property for each prop
```

**STOP** — Present component plan before creating.

### 4. Validate

```
figma_take_screenshot → Visual check
figma_audit_design_system → Automated audit
```

---

## Workflow: Audit Design System

### 1. Gather Current State

```
figma_get_design_system_summary  → Overview of DS
figma_get_variables              → All token values
figma_search_components          → All components
figma_get_styles                 → All styles
```

### 2. Run Automated Audit

```
figma_audit_design_system → Get issues
```

### 3. Cross-Reference with Code

Read code tokens and compare:

```markdown
## Audit Report

### Tokens

| Token | Figma | Code | Status |
|-------|-------|------|--------|
| primary-500 | #3b82f6 | #3b82f6 | ✅ Match |
| primary-600 | #2563eb | missing | 🔴 Code only |
| accent-gold | #f59e0b | #fbbf24 | ⚠️ Value mismatch |
| spacing-md | 16px | 16px | ✅ Match |
| old-blue | #0000ff | missing | ⚠️ Figma orphan |

### Components

| Component | Figma | Code | Status |
|-----------|-------|------|--------|
| Button | 7 variants | 5 variants | ⚠️ Drift (+2 in Figma) |
| Card | 3 variants | 3 variants | ✅ Synced |
| Input | missing | exists | 🔴 Missing in Figma |
| Badge | exists | missing | ⚠️ Figma orphan |

### Issues Found
- 🔴 Critical: [N] tokens missing in Figma
- ⚠️ Warning: [N] value mismatches
- ℹ️ Info: [N] orphan elements
```

### 4. Propose Fixes

```markdown
## Corrections proposées

**Priority 1 — Tokens manquants** :
- [ ] Créer primary-600 dans Figma (valeur: #2563eb)
- [ ] Créer spacing-xl dans Figma (valeur: 32px)

**Priority 2 — Valeurs divergentes** :
- [ ] accent-gold: Figma #f59e0b → Code #fbbf24 (lequel est correct ?)

**Priority 3 — Nettoyage** :
- [ ] Supprimer old-blue (orphelin, pas utilisé dans le code)

Appliquer les corrections ?
```

**STOP** — User must approve before applying changes.

### 5. Apply Corrections

Use batch tools for efficiency:

```
figma_batch_create_variables  → New tokens
figma_batch_update_variables  → Fix mismatched values
figma_take_screenshot         → Validate
```

---

## Workflow: Code → Figma Sync

When a code component has changed and Figma needs updating.

### 1. Detect What Changed in Code

```
Read component file → Extract current props, variants, tokens
Compare with last known state (or Figma current state)
```

### 2. Map Changes to Figma Actions

| Code Change | Figma Action |
|-------------|-------------|
| New variant added | `figma_add_component_property` or create new variant in component set |
| Variant renamed | `figma_edit_component_property` |
| Variant removed | `figma_delete_component_property` (with approval) |
| Token value changed | `figma_update_variable` |
| New token added | `figma_create_variable` |
| Component restyled | Update fills, strokes, text styles via `figma_execute` |

### 3. Apply & Validate

```
Apply changes via appropriate tools
figma_take_screenshot → Visual validation
figma_check_design_parity → Automated parity check
```

### 4. Report

```markdown
## Sync Report: Code → Figma

**Component** : [Name]
**Direction** : Code → Figma

### Changes Applied
| Change | Type | Status |
|--------|------|--------|
| Added variant "brand-primary" | Component | ✅ |
| Updated primary-500 value | Token | ✅ |
| Renamed "outline" → "ghost" | Component prop | ✅ |

### Validation
- Screenshot: [attached]
- Parity check: ✅ Pass
```

---

## Workflow: Uniformize

Detect and fix inconsistencies within the Figma DS itself.

### 1. Scan for Issues

```
figma_audit_design_system → Get issues
figma_browse_tokens → Check naming conventions
figma_search_components → Find duplicates
```

Common issues:
- **Naming inconsistencies** — `Color/Primary/500` vs `color-primary-500` vs `Primary 500`
- **Detached styles** — Elements using raw colors instead of variables
- **Duplicate components** — Multiple versions of the same component
- **Missing descriptions** — Components without documentation
- **Unused variables** — Tokens defined but not applied anywhere

### 2. Report & Fix

```markdown
## Uniformité Report

### Naming Conventions
Convention détectée : `Category/name-kebab` (ex: `Color/primary-500`)
Violations : [N]

| Variable | Current Name | Suggested Name |
|----------|-------------|----------------|
| [id] | Primary 500 | Color/primary-500 |
| [id] | spacingMd | Spacing/md |

### Detached Styles
[N] elements using raw values instead of variables

### Duplicates
[N] component duplicates found
```

**STOP** — Approve before batch renaming/fixing.

---

## Batch Operations Reference

| Tool | Use Case | Limit |
|------|----------|-------|
| `figma_setup_design_tokens` | Create collection + modes + variables atomically | Full system |
| `figma_batch_create_variables` | Create up to 100 variables | 100/call |
| `figma_batch_update_variables` | Update up to 100 variable values | 100/call |
| `figma_audit_design_system` | Automated DS audit | Full file |
| `figma_check_design_parity` | Check code↔Figma parity | Per component |

Always prefer batch over individual calls (10-50x faster).

## Auto-Chain

After DS management:
- → `figma-design-code-sync` — Sync mappings in Code Connect direction
- → `figma-designer` — Create screens using the updated DS
- → `/figma-to-code` — Generate code from updated components
- → `/code-reviewer` — Review any code changes made during sync
