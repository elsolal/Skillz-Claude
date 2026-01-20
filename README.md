# D-EPCT+R Workflow v2.4

> **Skills Claude Code pour un workflow de développement structuré et professionnel**
>
> ✅ **Mode Manuel** - Validation humaine à chaque étape
> ✅ **Mode RALPH** - Boucle autonome jusqu'à complétion
> ✅ **35+ fichiers Knowledge** - Base de connaissances testing & workflows
> ✅ **Structure BMAD-inspired** - Skills avec Activation, Principes, Règles

## Installation

```bash
# Cloner le repo
git clone https://github.com/ton-user/d-epct-workflow.git

# Installer dans ton projet
cd d-epct-workflow
./install.sh /chemin/vers/ton-projet
```

---

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
│  MODE MANUEL: ⏸️ Validation humaine à chaque étape                          │
│  MODE RALPH:  🔄 Autonome jusqu'à completion promise / max iter / timeout   │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2 Modes d'exécution

### Mode Manuel (défaut)

Validation humaine à chaque étape du workflow.

```bash
/discovery              # Planning complet avec validation
/feature #123           # Développement avec validation
```

### Mode RALPH (autonome)

Boucle automatique jusqu'à complétion - inspiré du [protocole RALPH](https://ghuntley.com/ralph/).

```bash
/auto-loop "prompt"     # Boucle générique
/auto-discovery "idée"  # Planning autonome
/auto-feature #123      # Dev autonome
/cancel-ralph           # Arrêter la boucle
```

| Commande | Max Iter | Timeout | Completion Promise |
|----------|----------|---------|-------------------|
| `/auto-loop` | 20 | 1h | "DONE" |
| `/auto-discovery` | 30 | 1h | "DISCOVERY COMPLETE" |
| `/auto-feature` | 50 | 2h | "FEATURE COMPLETE" |

**Options:** `--max N`, `--timeout Xh`, `--promise "TEXT"`, `--no-log`

---

## Skills (10)

### Phase Planning

| Skill | Rôle | Fonctionnalités v2.4 |
|-------|------|----------------------|
| `idea-brainstorm` | Exploration créative | Mode **Creative** ou **Research-first**, SCAMPER, Five Whys |
| `pm-prd` | Product Requirements | Mode **FULL/LIGHT** auto-détecté, templates |
| `architect` | Architecture technique | Stack, structure, data model, APIs, ADRs |
| `pm-stories` | Epics + Stories | INVEST, Given/When/Then, **Readiness Check /15** |

### Phase Développement

| Skill | Rôle | Fonctionnalités v2.4 |
|-------|------|----------------------|
| `github-issue-reader` | Lecture d'issues | Parse et structure les issues |
| `codebase-explainer` | Analyse du code | Architecture, patterns, conventions |
| `implementation-planner` | Planification | Plan step-by-step, estimation |
| `code-implementer` | Implémentation | **Lint/types obligatoires** par étape |
| `test-runner` | Tests | Mode **ATDD** (tests first), priorités P0-P3 |
| `code-reviewer` | Review (3 passes) | Correctness → Readability → Performance |

---

## Structure SKILL.md (v2.4)

Chaque skill suit une structure standardisée inspirée de [BMAD-METHOD](https://github.com/bmadcode/BMAD-METHOD) :

```yaml
---
name: skill-name
description: Description + triggers
knowledge:
  core: [...]      # Chargé automatiquement
  advanced: [...]  # Chargé si besoin
  debugging: [...] # Chargé si problème
---

# Skill Name

## Activation
> Checklist de démarrage obligatoire

## Rôle & Principes
**Rôle** : Description
**Principes** : Mindset et frameworks
**Règles** : ⛔ Interdits + ✅ Obligations

## Process
### 1. Étape 1
**⏸️ STOP** - Validation
...

## Output Template

## Transitions
- **Vers [skill]** : "Question de transition"
```

---

## Structure du projet

```
.claude/
├── CLAUDE.md                        # Instructions projet (ce fichier)
├── settings.json                    # Config hooks RALPH
├── hooks/
│   └── stop-hook.sh                 # Hook RALPH (intercepte exit)
├── commands/                        # 6 commandes
│   ├── discovery.md
│   ├── feature.md
│   ├── auto-loop.md
│   ├── auto-discovery.md
│   ├── auto-feature.md
│   └── cancel-ralph.md
├── knowledge/                       # 📚 35+ fichiers
│   ├── tea-index.csv                # Index des fragments
│   ├── testing/                     # 32 fichiers
│   │   ├── test-levels-framework.md
│   │   ├── test-priorities-matrix.md
│   │   ├── test-quality.md
│   │   ├── data-factories.md
│   │   ├── fixture-architecture.md
│   │   ├── network-first.md
│   │   ├── test-healing-patterns.md
│   │   └── ... (25 autres)
│   └── workflows/                   # 3 fichiers
│       ├── prd-template.md
│       ├── domain-complexity.csv
│       └── project-types.csv
└── skills/                          # 10 skills
    ├── idea-brainstorm/
    ├── pm-prd/
    ├── architect/
    ├── pm-stories/
    ├── github-issue-reader/
    ├── codebase-explainer/
    ├── implementation-planner/
    ├── code-implementer/
    ├── test-runner/
    └── code-reviewer/

docs/                                # Output documents
├── planning/
│   ├── brainstorms/
│   ├── prd/
│   └── architecture/
├── stories/
│   └── EPIC-{num}-{slug}/
└── ralph-logs/
```

---

## Knowledge System

### Chargement progressif

| Niveau | Quand | Exemple |
|--------|-------|---------|
| **core** | Automatiquement | `test-levels-framework.md` |
| **advanced** | Si complexe | `fixture-architecture.md` |
| **debugging** | Si problème | `test-healing-patterns.md` |

### Contenu (35+ fichiers)

#### Testing (32 fichiers)

| Catégorie | Fichiers | Description |
|-----------|----------|-------------|
| **Levels & Priorities** | 3 | Unit/Int/E2E, P0-P3 matrix, DoD |
| **Data & Fixtures** | 4 | Factories, fixtures, composition |
| **Network** | 5 | Intercept, HAR, recorder |
| **Debugging** | 4 | Healing patterns, selectors, timing |
| **CI/CD** | 3 | Burn-in, selective testing |
| **Advanced** | 13 | Contract testing, feature flags, auth |

#### Workflows (3 fichiers)

- `prd-template.md` - Template PRD complet
- `domain-complexity.csv` - Matrice complexité
- `project-types.csv` - Types de projets

---

## Checkpoints obligatoires

### Planning

| Checkpoint | Skill | Gate |
|------------|-------|------|
| Brainstorm | `idea-brainstorm` | Synthèse validée |
| PRD | `pm-prd` | Scope défini |
| Architecture | `architect` | Stack approuvé |
| **Readiness** | `pm-stories` | **Score ≥ 13/15** |

### Développement

| Checkpoint | Skill | Gate |
|------------|-------|------|
| Explain | `codebase-explainer` | Architecture comprise |
| Plan | `implementation-planner` | Étapes approuvées |
| Code | `code-implementer` | **Lint ✅ Types ✅** |
| Test | `test-runner` | **100% pass, 3 runs** |
| Review | `code-reviewer` | **3 passes OK** |

---

## Fonctionnalités v2.4

### Nouvelles fonctionnalités

| Skill | Feature | Description |
|-------|---------|-------------|
| `idea-brainstorm` | **Research-first** | Valider hypothèses avant brainstorm |
| `pm-stories` | **Readiness Check** | Score /15 obligatoire avant GitHub |
| `test-runner` | **Mode ATDD** | Tests AVANT code (Red-Green-Refactor) |
| `code-implementer` | **Validation stricte** | Lint/types obligatoires par étape |

### Structure enrichie

Tous les skills ont maintenant :
- `## Activation` - Checklist de démarrage
- `## Rôle & Principes` - Mindset et frameworks
- `## Règles` - ⛔ Interdits + ✅ Obligations
- `## Transitions` - Liens vers skills suivants

---

## Changelog

### v2.4.0
- **Structure SKILL.md enrichie** inspirée BMAD agents
- **Research-first** dans brainstorm
- **Implementation Readiness Check** (score /15)
- **Mode ATDD** dans test-runner
- **Validation lint/types** obligatoire

### v2.3.0
- **Knowledge Base centralisée** : 35+ fichiers
- **Chargement progressif** : core → advanced → debugging

### v2.1.0
- **Mode RALPH** : Boucle autonome avec stop-hook

### v2.0.0
- Workflow Planning : Brainstorm → PRD → Architecture → Stories
- Mode FULL / LIGHT automatique

### v1.0.0
- Version initiale avec 7 skills

---

## Credits

- **[BMAD-METHOD](https://github.com/bmadcode/BMAD-METHOD)** - 32 fichiers knowledge + structure agents
- **[RALPH Protocol](https://ghuntley.com/ralph/)** - Mode autonome

## License

MIT
