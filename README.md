# D-EPCT+R Workflow v2.5

> **Skills Claude Code pour un workflow de développement structuré et professionnel**
>
> ✅ **Mode Manuel** - Validation humaine à chaque étape
> ✅ **Mode RALPH** - Boucle autonome jusqu'à complétion
> ✅ **35+ fichiers Knowledge** - Base de connaissances testing & workflows
> ✅ **Structure BMAD-inspired** - Skills avec Activation, Principes, Règles
> ✅ **UX/UI Design** - Skills optionnels auto-triggered pour le design

## Installation

### Installation en une ligne

```bash
curl -fsSL https://raw.githubusercontent.com/elsolal/Skillz-Claude/main/install.sh | bash -s -- .
```

### Mise à jour

```bash
# Met à jour skills, commands, hooks, knowledge, examples
# Préserve tes customisations: CLAUDE.md, settings.json, mcp.json
curl -fsSL https://raw.githubusercontent.com/elsolal/Skillz-Claude/main/install.sh | bash -s -- . --update
```

### Installation manuelle

```bash
# Cloner le repo
git clone https://github.com/elsolal/Skillz-Claude.git

# Installer dans ton projet
cd Skillz-Claude
./install.sh /chemin/vers/ton-projet

# Ou mettre à jour
./install.sh /chemin/vers/ton-projet --update
```

---

## Quick Start (5 minutes)

### 1. Installer dans ton projet
```bash
cd mon-projet
curl -fsSL https://raw.githubusercontent.com/elsolal/Skillz-Claude/main/install.sh | bash -s -- .
```

### 2. Lancer Claude Code
```bash
claude
```

### 3. Démarrer un workflow

**Option A : Planning complet (nouvelle idée)**
```
/discovery
> Décris ton idée : "Une app de suivi de dépenses personnelles"
```

**Option B : Implémenter une feature (issue existante)**
```
/feature #123
```

**Option C : Mode autonome RALPH**
```
/auto-discovery "App de gestion de budget personnel"
# Claude travaille seul jusqu'à créer toutes les issues GitHub
```

### 4. Suivre le workflow

Le workflow te guidera à travers :
1. **Brainstorm** → Explorer l'idée
2. **PRD** → Définir les requirements
3. **Architecture** → Choisir le stack
4. **Stories** → Créer les issues GitHub
5. **Code** → Implémenter
6. **Test** → Valider
7. **Review** → 3 passes de relecture

Chaque étape demande ta validation (sauf en mode RALPH).

### Exemples complets

Voir le dossier [`.claude/examples/`](./.claude/examples/) avec 3 projets documentés :
- [`simple-api/`](./.claude/examples/simple-api/) - API REST simple (mode LIGHT)
- [`blog-nextjs/`](./.claude/examples/blog-nextjs/) - Blog Next.js (mode FULL)
- [`saas-dashboard/`](./.claude/examples/saas-dashboard/) - Dashboard SaaS (mode RALPH)

### Besoin d'aide ?

- [Troubleshooting Guide](./docs/TROUBLESHOOTING.md)
- [Guide Complet](./docs/GUIDE-COMPLET.md)

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
│        │              │                                                     │
│        ▼              ▼                                                     │
│  ┌──────────┐    ┌──────────┐   (optionnel, auto-triggered)                │
│  │   🎨     │ →  │   🖌️     │                                              │
│  │UX Design │    │UI Design │                                              │
│  │ personas │    │  tokens  │                                              │
│  │ journeys │    │components│                                              │
│  └──────────┘    └──────────┘                                              │
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

## Skills (12)

### Phase Planning

| Skill | Rôle | Fonctionnalités v2.5 |
|-------|------|----------------------|
| `idea-brainstorm` | Exploration créative | Mode **Creative** ou **Research-first**, SCAMPER, Five Whys, **auto-trigger UX/UI** |
| `pm-prd` | Product Requirements | Mode **FULL/LIGHT** auto-détecté, templates, **auto-trigger UX/UI** |
| `architect` | Architecture technique | Stack, structure, data model, APIs, ADRs |
| `pm-stories` | Epics + Stories | INVEST, Given/When/Then, **Readiness Check /15** |

### Phase Design (optionnelle, auto-triggered)

| Skill | Rôle | Fonctionnalités v2.5 |
|-------|------|----------------------|
| `ux-designer` | Expérience utilisateur | Personas, **user journeys**, wireframes textuels, heuristiques Nielsen |
| `ui-designer` | Design system | **Tokens** (couleurs, typo, spacing), composants UI, guidelines accessibilité |

### Phase Développement

| Skill | Rôle | Fonctionnalités v2.5 |
|-------|------|----------------------|
| `github-issue-reader` | Lecture d'issues | Catégorisation, **ambiguïtés classifiées** (🔴/🟡/🟢), G/W/T |
| `codebase-explainer` | Analyse du code | **Impact mapping**, patterns, flux, risques |
| `implementation-planner` | Planification | **Complexité S/M/L**, étapes atomiques, timeline |
| `code-implementer` | Implémentation | **Lint/types obligatoires** par étape |
| `test-runner` | Tests | Mode **ATDD** (tests first), priorités P0-P3 |
| `code-reviewer` | Review (3 passes) | Correctness → Readability → Performance |

---

## Structure SKILL.md (v2.5)

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
└── skills/                          # 12 skills
    ├── idea-brainstorm/
    ├── pm-prd/
    ├── ux-designer/                 # NEW - UX Design
    ├── ui-designer/                 # NEW - UI Design
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
│   ├── ux/                          # NEW - UX docs
│   ├── prd/
│   ├── ui/                          # NEW - UI docs
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
| *UX Design* | `ux-designer` | *(optionnel)* Personas et journeys validés |
| PRD | `pm-prd` | Scope défini |
| *UI Design* | `ui-designer` | *(optionnel)* Tokens et composants validés |
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

## Fonctionnalités v2.5

### Nouvelles fonctionnalités

| Skill | Feature | Description |
|-------|---------|-------------|
| `ux-designer` | **NEW** | Personas, user journeys, wireframes textuels, heuristiques Nielsen |
| `ui-designer` | **NEW** | Design tokens, composants UI specs, guidelines accessibilité |
| `idea-brainstorm` | **Auto-trigger UX/UI** | Évalue et recommande automatiquement les phases design |
| `pm-prd` | **Auto-trigger UX/UI** | Évalue et recommande automatiquement les phases design |

### Déclenchement automatique UX/UI

| Skill | Critères de déclenchement | Mots-clés |
|-------|--------------------------|-----------|
| `ux-designer` | 3+ écrans, parcours multi-étapes, onboarding | "parcours", "navigation", "UX" |
| `ui-designer` | 5+ composants, pas de design system existant | "design", "composants", "style" |

### Structure enrichie

Tous les skills ont maintenant :
- `## Activation` - Checklist de démarrage
- `## Rôle & Principes` - Mindset et frameworks
- `## Règles` - ⛔ Interdits + ✅ Obligations
- `## Transitions` - Liens vers skills suivants

---

## Changelog

### v2.5.0
- **NEW: UX Designer** : Personas, user journeys, wireframes textuels, heuristiques Nielsen
- **NEW: UI Designer** : Design tokens, composants UI specs, guidelines accessibilité
- **Auto-trigger UX/UI** : Brainstorm et PRD évaluent et recommandent automatiquement les phases design
- **Workflow enrichi** : Phase design optionnelle intégrée entre Planning et Architecture

### v2.4.1
- **Skills dev enrichis** : github-issue-reader, codebase-explainer, implementation-planner
- **Ambiguïtés classifiées** (🔴/🟡/🟢) dans issue-reader
- **Impact mapping** et flux de données dans codebase-explainer
- **Matrice complexité S/M/L** et timeline dans implementation-planner

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

## Contributing

Ce projet est partagé en **lecture seule**. Les Pull Requests et Issues ne sont pas acceptées.

Tu es libre d'utiliser, copier et adapter ce workflow pour tes propres projets.

---

## Credits

- **[BMAD-METHOD](https://github.com/bmadcode/BMAD-METHOD)** - 32 fichiers knowledge + structure agents
- **[RALPH Protocol](https://ghuntley.com/ralph/)** - Mode autonome
