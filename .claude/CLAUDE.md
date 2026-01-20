# D-EPCT+R Workflow v2.4

> Skills Claude Code pour un workflow de développement structuré et professionnel.

## Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              WORKFLOW COMPLET                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  PLANNING                                                                   │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐              │
│  │   🧠     │    │   📋     │    │   🏗️     │    │   📝     │              │
│  │Brainstorm│ →  │   PRD    │ →  │  Archi   │ →  │ Stories  │ → GitHub     │
│  │ +Research│    │FULL/LIGHT│    │          │    │+Readiness│              │
│  └──────────┘    └──────────┘    └──────────┘    └──────────┘              │
│                                                                             │
│  DÉVELOPPEMENT                                                              │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────┐  │
│  │   🔍     │    │   📝     │    │   💻     │    │   🧪     │    │  🔄  │  │
│  │ Explain  │ →  │  Plan    │ →  │  Code    │ →  │  Test    │ →  │Review│  │
│  │          │    │          │    │+Lint/Type│    │ATDD/Std  │    │  ×3  │  │
│  └──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────┘  │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│  MODE MANUEL: Validation humaine (⏸️ STOP) à chaque étape                   │
│  MODE RALPH:  Autonome jusqu'à completion promise / max iter / timeout      │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Commandes

### Mode Manuel (avec validation)

```bash
/discovery              # Planning complet avec validation à chaque étape
/feature [issue]        # Implémentation avec validation à chaque étape
```

### Mode RALPH (autonome)

```bash
/auto-loop "prompt"     # Boucle générique sur une tâche
/auto-discovery "idée"  # Planning complet en autonome
/auto-feature #123      # Implémentation complète en autonome
/cancel-ralph           # Arrêter le mode RALPH
```

### Configuration RALPH

| Commande | Max Iter | Timeout | Completion Promise |
|----------|----------|---------|-------------------|
| `/auto-loop` | 20 | 1h | "DONE" |
| `/auto-discovery` | 30 | 1h | "DISCOVERY COMPLETE" |
| `/auto-feature` | 50 | 2h | "FEATURE COMPLETE" |

**Options :** `--max N`, `--timeout Xh`, `--promise "TEXT"`, `--no-log`

---

## Skills (10)

### Phase Planning

| Skill | Rôle | Fonctionnalités clés |
|-------|------|----------------------|
| `idea-brainstorm` | Exploration créative | Mode **Creative** ou **Research-first**, techniques SCAMPER/Five Whys |
| `pm-prd` | Product Requirements | Mode **FULL** (complet) ou **LIGHT** (simplifié), auto-détection |
| `architect` | Architecture technique | Stack, structure, data model, APIs, ADRs |
| `pm-stories` | Epics + Stories | INVEST, Given/When/Then, **Implementation Readiness Check** (score /15) |

### Phase Développement

| Skill | Rôle | Fonctionnalités clés |
|-------|------|----------------------|
| `github-issue-reader` | Lecture d'issues | Catégorisation, **ambiguïtés classifiées** (🔴/🟡/🟢), Given/When/Then |
| `codebase-explainer` | Analyse du code | **Impact mapping**, patterns, flux de données, risques |
| `implementation-planner` | Planification | **Complexité S/M/L**, étapes atomiques, timeline, risques |
| `code-implementer` | Implémentation | Validation **lint/types obligatoire** par étape |
| `test-runner` | Tests | Mode **ATDD** (tests first) ou Standard, priorités P0-P3 |
| `code-reviewer` | Review (3 passes) | Correctness → Readability → Performance |

---

## Structure des Skills (v2.4)

Chaque skill suit une structure standardisée :

```markdown
---
name: skill-name
description: Description + triggers
knowledge:
  core: [fichiers chargés automatiquement]
  advanced: [fichiers chargés si besoin]
  debugging: [fichiers pour troubleshooting]
---

# Skill Name

## Activation
> Checklist de démarrage obligatoire

## Rôle & Principes
**Rôle** : Description du rôle
**Principes** : Mindset et frameworks
**Règles** : ⛔ Interdits + ✅ Obligations

## Process
### 1. Étape 1
**⏸️ STOP** - Validation
### 2. Étape 2
...

## Output Template

## Transitions
- **Vers [skill]** : "Question de transition"
```

---

## Knowledge Base

### Architecture

```
.claude/knowledge/
├── tea-index.csv              # Index des 32 fragments testing
├── testing/                   # 32 fichiers
│   ├── test-levels-framework.md
│   ├── test-priorities-matrix.md
│   ├── test-quality.md
│   ├── data-factories.md
│   ├── fixture-architecture.md
│   ├── network-first.md
│   ├── test-healing-patterns.md
│   └── ... (25 autres)
└── workflows/                 # 3 fichiers
    ├── prd-template.md
    ├── domain-complexity.csv
    └── project-types.csv
```

### Chargement progressif

| Niveau | Quand charger | Exemple |
|--------|---------------|---------|
| **core** | Automatiquement avec le skill | `test-levels-framework.md` |
| **advanced** | Si situation complexe | `fixture-architecture.md` |
| **debugging** | Si problème (flaky tests) | `test-healing-patterns.md` |

---

## Modes de scope

### Mode FULL (projet complexe)

**Critères (score ≥ 3)** :
- 3+ features distinctes (+1)
- Architecture multi-composants (+1)
- 3+ écrans/pages UI (+1)
- Intégrations externes (+1)
- Estimation > 1 jour (+1)

**Workflow** :
```
Brainstorm → PRD complet → Architecture → Stories → Readiness Check → GitHub
```

### Mode LIGHT (feature simple)

**Critères** : Feature isolée, petit scope, < 1 jour

**Workflow** :
```
PRD simplifié → Stories → GitHub
```

---

## Checkpoints obligatoires

### Planning

| Checkpoint | Skill | Validation |
|------------|-------|------------|
| Brainstorm validé | `idea-brainstorm` | Synthèse acceptée |
| PRD validé | `pm-prd` | Mode choisi, scope défini |
| Architecture validée | `architect` | Stack et structure approuvés |
| **Readiness Check** | `pm-stories` | Score ≥ 13/15 |

### Développement

| Checkpoint | Skill | Validation |
|------------|-------|------------|
| Code expliqué | `codebase-explainer` | Architecture comprise |
| Plan validé | `implementation-planner` | Étapes approuvées |
| Code implémenté | `code-implementer` | Lint ✅ Types ✅ |
| Tests passent | `test-runner` | 100% pass, 3 runs |
| Review OK | `code-reviewer` | 3 passes complètes |

---

## Principes

### Qualité du code

- **KISS** : Keep It Simple
- **DRY** : Don't Repeat Yourself
- **YAGNI** : You Aren't Gonna Need It
- Tout code doit être testé
- 3 passes de review obligatoires

### Tests

- **Risk-based testing** : Profondeur selon impact business
- **Priorités P0-P3** : P0 d'abord (fail fast)
- **Déterminisme** : Pas de flaky, pas de hard waits
- **Mode ATDD** : Tests AVANT code quand possible

### Documentation

| Type | Emplacement |
|------|-------------|
| Brainstorms | `docs/planning/brainstorms/` |
| PRD | `docs/planning/prd/` |
| Architecture | `docs/planning/architecture/` |
| Stories | `docs/stories/EPIC-{num}-{slug}/` |
| Logs RALPH | `docs/ralph-logs/` |

---

## Conventions

### Commits

```
type(scope): description courte

Description détaillée si nécessaire

Refs: #XX
```

**Types:** `feat`, `fix`, `refactor`, `test`, `docs`, `chore`

### Branches

```
feature/[issue-number]-description-courte
fix/[issue-number]-description-courte
```

### Pull Requests

- Lier à l'issue avec "Closes #XX"
- Description claire du changement
- Screenshots si UI

---

## Règles globales

### Mode Manuel

- ⛔ Ne JAMAIS enchaîner sans validation explicite
- ⛔ Ne JAMAIS skip le Readiness Check
- ✅ Attendre "ok", "continue", "validé" avant de continuer
- ✅ En cas de doute, demander clarification

### Mode RALPH

- ⛔ Ne JAMAIS ignorer les erreurs (s'auto-corriger)
- ✅ Travailler en boucle jusqu'à completion promise
- ✅ Logger chaque itération dans `docs/ralph-logs/`
- ✅ S'arrêter sur : completion promise, max iterations, ou timeout

### Tous modes

- ⛔ Ne JAMAIS committer sans tests qui passent
- ⛔ Ne JAMAIS merger sans les 3 passes de review
- ✅ Respecter les conventions du projet existant
- ✅ Préférer la simplicité à la complexité
