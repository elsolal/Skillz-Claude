<!-- PROJECT-RULES-START -->
# Project Rules

> **Cette section est préservée lors des updates.** Ajoutez vos règles projet ici.

```markdown
# Exemple de règles à ajouter :
# - Stack technique spécifique
# - Conventions de nommage
# - Règles métier
# - Intégrations tierces
```

<!-- PROJECT-RULES-END -->

---

# D-EPCT+R Workflow v3.1

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
│  MODE MANUEL: Validation humaine (⏸️ STOP) à chaque étape                   │
│  MODE RALPH:  Autonome jusqu'à completion promise / max iter / timeout      │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Commandes (15)

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
/resume-ralph [session-id]  # Reprendre une session RALPH interrompue
```

### Utilitaires

```bash
/status                 # État du projet (docs, issues, RALPH)
/pr-review #123         # Review une PR GitHub (3 passes)
/quick-fix "desc"       # Fix rapide sans workflow complet
/refactor <file>        # Refactoring ciblé avec review
/docs [type]            # Génère documentation (readme|api|guide|all)
/changelog [version]    # Génère CHANGELOG.md
/metrics                # Dashboard métriques projet
/init [template]        # Scaffolding projet (NEW v3.0)
```

### Configuration RALPH

| Commande | Max Iter | Timeout | Completion Promise |
|----------|----------|---------|-------------------|
| `/auto-loop` | 20 | 1h | "DONE" |
| `/auto-discovery` | 30 | 1h | "DISCOVERY COMPLETE" |
| `/auto-feature` | 50 | 2h | "FEATURE COMPLETE" |

**Options :** `--max N`, `--timeout Xh`, `--promise "TEXT"`, `--no-log`, `--verbose`

---

## Skills (16)

### Phase Planning

| Skill | Rôle | Fonctionnalités clés |
|-------|------|----------------------|
| `idea-brainstorm` | Exploration créative | Mode **Creative** ou **Research-first**, techniques SCAMPER/Five Whys, **auto-trigger UX/UI** |
| `pm-prd` | Product Requirements | Mode **FULL** (complet) ou **LIGHT** (simplifié), auto-détection, **auto-trigger UX/UI** |
| `architect` | Architecture technique | Stack, structure, data model, APIs, ADRs |
| `pm-stories` | Epics + Stories | INVEST, Given/When/Then, **Implementation Readiness Check** (score /15) |
| `api-designer` | Design d'API | **OpenAPI 3.1**, REST/GraphQL, versioning, rate limiting |
| `database-designer` | Design de BDD (NEW v3.0) | **ERD**, migrations, indexes, Prisma/Drizzle |

### Phase Design (optionnelle, auto-triggered)

| Skill | Rôle | Fonctionnalités clés |
|-------|------|----------------------|
| `ux-designer` | Expérience utilisateur | Personas, **user journeys**, wireframes textuels, heuristiques Nielsen |
| `ui-designer` | Design system | **Tokens** (couleurs, typo, spacing), composants UI, guidelines accessibilité |

### Phase Développement

| Skill | Rôle | Fonctionnalités clés |
|-------|------|----------------------|
| `github-issue-reader` | Lecture d'issues | Catégorisation, **ambiguïtés classifiées** (🔴/🟡/🟢), Given/When/Then |
| `codebase-explainer` | Analyse du code | **Impact mapping**, patterns, flux de données, risques |
| `implementation-planner` | Planification | **Complexité S/M/L**, étapes atomiques, timeline, risques |
| `code-implementer` | Implémentation | Validation **lint/types obligatoire** par étape, **hook auto-lint** |
| `test-runner` | Tests | Mode **ATDD** (tests first) ou Standard, priorités P0-P3, **hook coverage** |
| `code-reviewer` | Review (3 passes) | Correctness → Readability → Performance |
| `security-auditor` | Audit sécurité | **OWASP Top 10**, dépendances, secrets, scoring |
| `performance-auditor` | Audit performance (NEW v3.1) | **Core Web Vitals**, bundle size, Lighthouse |

---

## Fonctionnalités avancées (v3.1)

### Git Hooks

Templates de hooks Git dans `.claude/templates/git-hooks/` :

| Hook | Description |
|------|-------------|
| `pre-commit` | ESLint, TypeScript, Prettier, Tests, Secrets |
| `commit-msg` | Validation Conventional Commits |

**Installation** :
```bash
cp .claude/templates/git-hooks/pre-commit .git/hooks/
cp .claude/templates/git-hooks/commit-msg .git/hooks/
chmod +x .git/hooks/*
```

### Templates DevContainer

Configuration Docker dev environment dans `.claude/templates/devcontainer/` :

| Fichier | Description |
|---------|-------------|
| `devcontainer.json` | Config VS Code + extensions |
| `Dockerfile` | Node.js 20 + outils |
| `docker-compose.yml` | PostgreSQL, Redis |

**Installation** :
```bash
mkdir -p .devcontainer
cp .claude/templates/devcontainer/* .devcontainer/
```

### Skill performance-auditor

Audit de performance avec Core Web Vitals et bundle analysis :

```bash
/performance-auditor https://example.com    # Audit URL
/performance-auditor ./dist                 # Audit build
```

**Analyses** :
- **Core Web Vitals** : LCP, INP, CLS
- **Bundle** : JS/CSS size, chunks, tree-shaking
- **Lighthouse** : Score complet
- **Dependencies** : Packages lourds, alternatives

---

## Fonctionnalités avancées (v3.0)

### Skill database-designer

Nouveau skill pour concevoir des schémas de base de données :

```bash
/database-designer blog-platform    # Design DB
/database-designer --orm prisma     # Avec ORM spécifique
```

**Fonctionnalités** :
- **ERD** : Diagramme entité-relation en ASCII
- **Migrations** : SQL, Prisma, ou Drizzle
- **Indexes** : Stratégie d'indexation optimale
- **Relations** : 1:1, 1:N, N:M avec FK
- **Seed Data** : Données de test

### Commande /init

Scaffolding de projet avec templates :

```bash
/init next              # Next.js 14 + TypeScript
/init express           # Express.js API
/init api               # API minimaliste (Hono)
/init cli               # CLI avec Commander.js
/init lib               # Library npm
```

**Options** : `--db postgres`, `--auth`, `--docker`, `--ci`

### Issue Templates GitHub

Templates pour les issues dans `.claude/templates/github/ISSUE_TEMPLATE/` :

| Template | Description | Label |
|----------|-------------|-------|
| `bug_report.md` | Rapport de bug | `bug` |
| `feature_request.md` | Demande de feature | `enhancement` |
| `config.yml` | Configuration | - |

**Installation** : `cp -r .claude/templates/github/ISSUE_TEMPLATE .github/`

---

## Fonctionnalités avancées (v2.9)

### Skill api-designer

Nouveau skill pour concevoir des APIs REST/GraphQL :

```bash
/api-designer user-management    # Design API
/api-designer --type graphql     # API GraphQL
```

**Fonctionnalités** :
- **OpenAPI 3.1** : Spec complète avec exemples
- **REST Best Practices** : CRUD, pagination, filtres
- **Error Handling** : Format standard, codes d'erreur
- **Versioning** : URL path, headers, deprecation policy
- **Rate Limiting** : Headers, quotas

### Commande /metrics

Dashboard des métriques projet :

```bash
/metrics                # Dashboard standard
/metrics --full         # Toutes les métriques
/metrics --compare main # Compare avec une branche
```

**Métriques affichées** :
- **Codebase** : Files, lines, commits
- **Tests** : Coverage, passing, skipped
- **GitHub** : Issues, PRs, labels
- **Dependencies** : Total, outdated, vulnerabilities
- **Documentation** : PRDs, architecture, stories
- **RALPH** : Sessions, iterations, completions

**Health Score** : `Coverage + Tests + Docs + Security + Activity`

### PR Template GitHub

Template standard pour les Pull Requests dans `.claude/templates/github/` :

```markdown
## Summary
## Changes
## Type of change
## Testing
## Screenshots
Closes #
```

**Installation** : `cp .claude/templates/github/PULL_REQUEST_TEMPLATE.md .github/`

---

## Fonctionnalités avancées (v2.8)

### Security Auditor

Nouveau skill pour auditer la sécurité du code :

```bash
/security-auditor src/          # Audit un dossier
/security-auditor               # Audit tout le projet
```

**Analyses effectuées** :
- **OWASP Top 10** : Injection, Auth, XSS, SSRF, etc.
- **Dépendances** : CVE connus, versions obsolètes
- **Secrets** : API keys, passwords, tokens exposés
- **Configuration** : Headers, CORS, debug mode

**Score** : `100 - (Critical×25) - (High×10) - (Medium×5) - (Low×1)`

### GitHub Actions Templates

Templates CI/CD prêts à l'emploi dans `.claude/templates/github-actions/` :

| Template | Description |
|----------|-------------|
| `ci.yml` | Lint, Typecheck, Test, Build |
| `release.yml` | Changelog + GitHub Release |
| `security.yml` | npm audit, CodeQL, Secret scanning |
| `deploy.yml` | Vercel, Netlify, AWS, Kubernetes |
| `dependabot.yml` | Mises à jour automatiques |

### Commande /changelog

Génère CHANGELOG.md depuis les commits :

```bash
/changelog 2.8.0              # Version spécifique
/changelog --since v2.7.0     # Depuis un tag
/changelog --dry-run          # Prévisualiser
```

**Formats** : `conventional` (default), `keep-a-changelog`

---

## Fonctionnalités avancées (v2.7)

### Skill Chaining (Auto-Chain)

Chaque skill propose automatiquement le skill suivant après validation de son output :

```markdown
## 🔗 Prochaine étape

✅ [Skill actuel] terminé et sauvegardé.

→ 📋 **Lancer `/[next-skill]` ?** (recommandé)

---

**[Y] Oui, continuer** | **[N] Non, je choisis** | **[P] Pause**
```

| Skill actuel | Propositions (selon contexte) |
|--------------|------------------------------|
| `idea-brainstorm` | `/ux-designer` (si UI) ou `/pm-prd` |
| `pm-prd` | `/ui-designer` (si design) ou `/architect` |
| `architect` | `/pm-stories` |
| `pm-stories` | `/feature` ou `/auto-feature` |
| `github-issue-reader` | `/codebase-explainer` |
| `codebase-explainer` | `/implementation-planner` |
| `implementation-planner` | `/code-implementer` |
| `code-implementer` | `/test-runner` |
| `test-runner` | `/code-reviewer` |
| `code-reviewer` | Commit/PR (fin du cycle) |

### Output Validation

Chaque skill valide son output avant de proposer la transition :

```markdown
### ✅ Checklist Output [Skill]

| Critère | Status |
|---------|--------|
| [Critère 1] | ✅/❌ |
| [Critère 2] | ✅/❌ |
| [Critère 3] | ✅/❌ |

**Score : X/N** → Si < seuil, compléter avant transition
```

| Skill | Seuil minimum |
|-------|--------------|
| `idea-brainstorm` | 4/5 |
| `pm-prd` | 6/7 |
| `architect` | 5/6 |
| `pm-stories` | 13/15 (Readiness Check) |
| `implementation-planner` | 5/6 |
| `code-implementer` | 4/5 |
| `test-runner` | 4/5 |
| `code-reviewer` | Toutes passes OK |

### RALPH Metrics

Les commandes RALPH trackent automatiquement les métriques :

```markdown
## 📊 Métriques RALPH

| Métrique | Valeur |
|----------|--------|
| **Durée totale** | [X]m [Y]s |
| **Itérations** | [N] / [Max] |

### Temps par phase
| Phase | Durée | Status |
|-------|-------|--------|
| [Phase 1] | [X]m | ✅ |
| [Phase 2] | [X]m | ✅ |

### Auto-corrections
| Type | Count |
|------|-------|
| Lint errors corrigés | [X] |
| Type errors corrigés | [X] |
| Tests fixés | [X] |
| Retours arrière | [X] |
```

### Commande /resume-ralph

Reprendre une session RALPH interrompue :

```bash
/resume-ralph                 # Reprend la dernière session
/resume-ralph <session-id>    # Reprend une session spécifique
```

Options disponibles :
- **Continue** : Reprendre où on s'est arrêté
- **Restart** : Recommencer la phase en cours
- **Modify** : Changer les paramètres (max iter, timeout)
- **Abandon** : Abandonner et archiver

---

## Fonctionnalités avancées (v2.6)

### Dynamic Context Injection

Tous les skills chargent automatiquement le contexte pertinent au démarrage :

| Skill | Contexte auto-chargé |
|-------|---------------------|
| `github-issue-reader` | Issue GitHub, PRs liées |
| `codebase-explainer` | Structure projet, package.json, CLAUDE.md |
| `idea-brainstorm` | Brainstorms existants, PRDs |
| `implementation-planner` | PRD, architecture, stories, analyse codebase |
| `test-runner` | Config test, tests existants, scripts npm |
| `code-implementer` | CLAUDE.md, ESLint, tsconfig, plan actif |
| `pm-prd` | Brainstorms, PRDs existants, UX design |
| `architect` | PRD actif, stack existant, structure projet |
| `pm-stories` | PRD, architecture, stories existantes, GitHub repo |
| `code-reviewer` | Fichiers modifiés, diff git, erreurs lint |
| `ux-designer` | PRD, brainstorm, UX existant |
| `ui-designer` | UX design, tokens existants, framework détecté |

### Hooks automatiques

| Skill | Type | Trigger | Action |
|-------|------|---------|--------|
| `code-implementer` | post | Edit/Write | Auto-lint |
| `test-runner` | post | npm test | Affiche coverage |
| `pm-stories` | pre | create_issue | Vérifie GitHub auth |
| `code-reviewer` | pre | Read (code files) | Exécute tests |
| `architect` | pre | Write (architecture) | Vérifie PRD existe |

### Model Opus

Tous les skills utilisent **Claude Opus** pour une intelligence maximale.

### Argument Hints

Chaque skill affiche un hint pour guider l'utilisateur :

```bash
/idea-brainstorm <idea-description>
/github-issue-reader <issue-number-or-url>
/implementation-planner <prd-or-issue-reference>
/test-runner <file-or-directory-to-test>
/code-reviewer <file-or-pr-number>
```

---

## Structure des Skills (v2.8)

Chaque skill suit une structure standardisée :

```markdown
---
name: skill-name
description: Description + triggers
model: opus
context: fork                    # Exécution isolée
agent: Plan | Explore           # Type d'agent
allowed-tools: [tools]          # Outils autorisés
argument-hint: <hint>           # Guide pour l'utilisateur
user-invocable: true | false    # Appelable directement
hooks:                          # Hooks automatiques
  pre_tool_call: [...]
  post_tool_call: [...]
knowledge:
  core: [fichiers auto-chargés]
  advanced: [fichiers si besoin]
  debugging: [fichiers troubleshooting]
---

# Skill Name

## 📥 Contexte chargé automatiquement
!`commande shell pour charger contexte`

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

## Output Validation (NEW v2.7)
> Checklist de validation avant transition

## Auto-Chain (NEW v2.7)
> Proposition automatique du skill suivant

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
└── workflows/                 # 10 fichiers
    ├── prd-template.md
    ├── prd-patterns.md            # NEW v2.7 - Patterns par domaine
    ├── architecture-template.md
    ├── stories-template.md
    ├── ux-template.md
    ├── ui-template.md
    ├── estimation-techniques.md   # NEW v2.7 - Techniques d'estimation
    ├── risk-assessment.md         # NEW v2.7 - Framework de risques
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
Brainstorm → [UX Design] → PRD complet → [UI Design] → Architecture → Stories → GitHub
              (auto/manual)              (auto/manual)
```

### Mode LIGHT (feature simple)

**Critères** : Feature isolée, petit scope, < 1 jour

**Workflow** :
```
PRD simplifié → Stories → GitHub
```

---

## Déclenchement UX/UI (auto-trigger)

Les skills `ux-designer` et `ui-designer` peuvent être déclenchés automatiquement ou manuellement.

### Critères de déclenchement automatique

| Skill | Critères (seuil de score) | Mots-clés détectés |
|-------|--------------------------|-------------------|
| `ux-designer` | Interface UI (3+ écrans), parcours multi-étapes, onboarding | "parcours", "navigation", "tunnel", "UX" |
| `ui-designer` | 5+ composants UI, pas de design system existant, branding | "design", "composants", "couleurs", "style" |

### Modes de déclenchement

| Mode | Comportement |
|------|--------------|
| **auto** | Le PM évalue et recommande automatiquement si score ≥ seuil |
| **manual** | L'utilisateur demande explicitement `/ux-designer` ou `/ui-designer` |
| **skip** | L'utilisateur refuse la recommandation → passage direct à l'étape suivante |

### Points de déclenchement

1. **Après Brainstorm** → Évaluation UX/UI avant PRD
2. **Après PRD** → Évaluation UX/UI avant Architecture

### Output des skills UX/UI

| Skill | Documents générés | Emplacement |
|-------|------------------|-------------|
| `ux-designer` | Personas, journeys, wireframes | `docs/planning/ux/UX-{slug}.md` |
| `ui-designer` | Tokens, composants, guidelines | `docs/planning/ui/UI-{slug}.md`, `tokens.css` |

---

## Checkpoints obligatoires

### Planning

| Checkpoint | Skill | Validation |
|------------|-------|------------|
| Brainstorm validé | `idea-brainstorm` | Synthèse acceptée |
| *UX Design validé* | `ux-designer` | *(optionnel)* Personas et journeys approuvés |
| PRD validé | `pm-prd` | Mode choisi, scope défini |
| *UI Design validé* | `ui-designer` | *(optionnel)* Tokens et composants approuvés |
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
| UX Design | `docs/planning/ux/` |
| PRD | `docs/planning/prd/` |
| UI Design | `docs/planning/ui/` |
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
