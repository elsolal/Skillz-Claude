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

# D-EPCT+R Workflow v3.8

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

## Commandes (16)

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
/supabase-security <url> # Audit sécurité Supabase complet (NEW v3.7)
/figma-setup [url]       # Configure Code Connect (NEW v3.8)
/figma-to-code <url>     # Génère code depuis Figma (NEW v3.8)
```

### Configuration RALPH

| Commande | Max Iter | Timeout | Completion Promise |
|----------|----------|---------|-------------------|
| `/auto-loop` | 20 | 1h | "DONE" |
| `/auto-discovery` | 30 | 1h | "DISCOVERY COMPLETE" |
| `/auto-feature` | 50 | 2h | "FEATURE COMPLETE" |

**Options :** `--max N`, `--timeout Xh`, `--promise "TEXT"`, `--no-log`, `--verbose`

---

## Skills (20)

### Phase Planning

| Skill | Rôle | Fonctionnalités clés |
|-------|------|----------------------|
| `idea-brainstorm` | Exploration créative | **61 techniques** en 10 catégories, **4 approches** (User/AI/Random/Progressive), **anti-biais protocol**, **auto-trigger UX/UI** (NEW v3.6) |
| `pm-prd` | Product Requirements | Mode **FULL** (complet) ou **LIGHT** (simplifié), auto-détection, **auto-trigger UX/UI** |
| `architect` | Architecture technique | Stack, structure, data model, APIs, ADRs |
| `pm-stories` | Epics + Stories | INVEST, Given/When/Then, **Implementation Readiness Check** (score /15) |
| `api-designer` | Design d'API | **OpenAPI 3.1**, REST/GraphQL, versioning, rate limiting |
| `database-designer` | Design de BDD (NEW v3.0) | **ERD**, migrations, indexes, Prisma/Drizzle |

### Phase Design (optionnelle, auto-triggered)

| Skill | Rôle | Fonctionnalités clés |
|-------|------|----------------------|
| `ux-designer` | Expérience utilisateur | Personas, **user journeys**, wireframes textuels, heuristiques Nielsen |
| `ui-designer` | Design system | **Tokens** (couleurs, typo, spacing), composants UI, **import Figma** (NEW v3.8) |
| `figma-setup` | Config Code Connect (NEW v3.8) | Installation, **mappings .figma.tsx**, publication |
| `figma-to-code` | Génération code (NEW v3.8) | URL Figma → code avec **composants mappés**, tokens CSS |

### Phase Développement

| Skill | Rôle | Fonctionnalités clés |
|-------|------|----------------------|
| `github-issue-reader` | Lecture d'issues | Catégorisation, **ambiguïtés classifiées** (🔴/🟡/🟢), Given/When/Then |
| `codebase-explainer` | Analyse du code | **Impact mapping**, patterns, flux de données, risques |
| `implementation-planner` | Planification | **Complexité S/M/L**, étapes atomiques, timeline, risques, **TaskCreate si 2+ étapes** (NEW v3.3) |
| `code-implementer` | Implémentation | Validation **lint/types obligatoire** par étape, **hook auto-lint**, **TaskUpdate auto** (NEW v3.3) |
| `test-runner` | Tests | Mode **ATDD** (tests first) ou Standard, priorités P0-P3, **hook coverage** |
| `code-reviewer` | Review (3 passes) | Correctness → Readability → Performance |
| `security-auditor` | Audit sécurité | **OWASP Top 10**, dépendances, secrets, scoring |
| `performance-auditor` | Audit performance (NEW v3.1) | **Core Web Vitals**, bundle size, Lighthouse |
| `supabase-security` | Audit Supabase (NEW v3.7) | **RLS**, buckets, auth, keys exposées, **evidence collection**, CVSS |
| `multi-mind` | Débat multi-agents (NEW v3.5) | **6 IA**, **5 rounds avec débat itératif**, consensus/divergences |

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

## Fonctionnalités avancées (v3.8)

### Figma Integration

Intégration complète avec Figma via MCP et Code Connect pour synchroniser designs et code.

```bash
/figma-setup                    # Configure Code Connect
/figma-to-code <figma-url>      # Génère code depuis Figma
/ui-designer --from-figma       # Importe tokens depuis Figma
```

### Nouveaux skills Figma

| Skill | Rôle | Fonctionnalités |
|-------|------|-----------------|
| `figma-setup` | Configuration one-time | Installe Code Connect, génère `figma.config.json`, crée mappings `.figma.tsx` |
| `figma-to-code` | Génération quotidienne | Parse URL, utilise mappings existants, génère code avec composants réels |

### Workflow Figma

```
1. /figma-setup               → Configure Code Connect une fois
   ├── npm install @figma/code-connect
   ├── figma.config.json
   └── *.figma.tsx (mappings)

2. /figma-to-code <url>       → Usage quotidien
   ├── Vérifie mappings existants
   ├── Extrait design (MCP get_design_context)
   ├── Récupère tokens (MCP get_variable_defs)
   └── Génère code avec composants mappés

3. /ui-designer --from-figma  → Import tokens
   ├── Extrait variables Figma
   ├── Transforme en CSS Variables
   └── Propose ajustements manuels
```

### MCP Figma (pré-configuré)

Le serveur MCP Figma est déjà configuré dans `.claude/mcp.json` :

```json
{
  "figma": {
    "type": "http",
    "url": "https://mcp.figma.com/mcp"
  }
}
```

**Outils MCP disponibles** :
- `get_design_context` - Extraire design pour génération
- `get_variable_defs` - Récupérer tokens (couleurs, typo, spacing)
- `get_code_connect_map` - Vérifier mappings existants
- `get_screenshot` - Capture visuelle pour validation

### Knowledge Base Figma

```
.claude/knowledge/figma/
├── code-connect-guide.md    # Guide CLI Code Connect
├── mcp-tools-reference.md   # Référence outils MCP
└── tokens-mapping.md        # Mapping Figma → CSS Variables
```

### Authentification

| Élément | Auth | Méthode |
|---------|------|---------|
| **MCP Figma** | OAuth automatique | Browser popup |
| **CLI Code Connect** | Interactive | `npx figma connect` |

**Pas de token à gérer** - l'auth est automatique via le navigateur.

---

## Fonctionnalités avancées (v3.7)

### Supabase Security Audit

Audit de sécurité complet pour les applications utilisant Supabase :

```bash
/supabase-security https://myapp.com         # Audit complet
/supabase-security https://myapp.com --quick # Audit rapide
/supabase-security https://myapp.com --skip-auth-test  # Sans création user test
```

**Phases d'audit** :

| Phase | Tests effectués |
|-------|-----------------|
| **Detection** | Patterns Supabase dans le code client |
| **Extraction** | Anon key, service key (CRITIQUE), JWT, DB strings |
| **API Audit** | Tables exposées, RLS policies, RPC functions |
| **Storage Audit** | Buckets publics, fichiers sensibles |
| **Auth Audit** | Config, signup, password policy, IDOR (optionnel) |
| **Functions** | Edge Functions, Realtime channels |

**Findings par sévérité** :

| Sévérité | Exemples | Délai |
|----------|----------|-------|
| 🔴 **P0** | Service key exposée, table users sans RLS | Immédiat |
| 🟠 **P1** | Email confirm désactivé, bucket documents public | 7 jours |
| 🟡 **P2** | Source maps exposées, password < 8 chars | 30 jours |

**Output** :

```
docs/security/supabase-audit-YYYY-MM-DD.md  # Rapport
.supabase-audit/                             # Evidence
├── context.json
├── curl-commands.sh                         # Commandes reproductibles
├── timeline.md
└── evidence/
```

**Knowledge base** :

```
.claude/knowledge/supabase-security/
├── audit-checklist.md      # Checklist complète
├── severity-matrix.md      # Matrice CVSS
├── rls-patterns.md         # Patterns RLS corrects/incorrects
└── remediation-templates.md # Templates SQL de fix
```

---

## Fonctionnalités avancées (v3.5)

### Multi-Mind Debate System v3.5

Système de débat multi-agents avec 6 IA pour valider PRD et code avec des **débats itératifs** et des **échanges ping-pong** entre agents.

```bash
/multi-mind prd docs/PRD/PRD-Feature.md    # Valider un PRD
/multi-mind review src/components/Auth.tsx  # Review multi-perspectives
```

### Les 6 Agents

| Agent | Provider | Rôle | Connecteur | Coût |
|-------|----------|------|------------|------|
| 🏛️ **Claude** | Anthropic | Architecte Prudent (débatteur) | Orchestrateur natif | Inclus |
| 🤖 **GPT** | OpenAI | Perfectionniste | Codex CLI | 💳 Payant |
| 💎 **Gemini** | Google | Innovateur UX | Gemini CLI | 💳 Payant |
| 🐉 **DeepSeek** | DeepSeek | Provocateur | API REST | 🆓 Gratuit |
| 🔮 **GLM** | Zhipu AI | Craftsman Frontend | API REST | 🆓 Gratuit |
| 🌙 **Kimi** | Moonshot | Product Thinker | OpenRouter | 🆓 Gratuit |

> **Note** : Claude participe comme **débatteur** (pas comme modérateur). Il argumente, défend ses positions, et ne synthétise qu'à la fin.

### Configuration des agents

#### Option 1 : Fichier `.env.local` (recommandé)

```bash
cp .env.example .env.local
# Éditer .env.local avec tes clés API
```

Contenu de `.env.local` :
```
DEEPSEEK_API_KEY=sk-ta-clé-deepseek
GLM_API_KEY=ta-clé-glm
OPENROUTER_API_KEY=sk-or-v1-ta-clé-openrouter
```

#### Option 2 : Variables d'environnement

```bash
# Ajouter dans ~/.zshrc
export DEEPSEEK_API_KEY="sk-..."      # https://platform.deepseek.com/
export GLM_API_KEY="..."              # https://open.bigmodel.cn/
export OPENROUTER_API_KEY="sk-or-..." # https://openrouter.ai/
source ~/.zshrc
```

#### Agents payants (optionnels)

```bash
npm install -g @openai/codex   # GPT via Codex CLI
npm install -g gemini-cli      # Gemini CLI
```

**Minimum requis** : 3 agents pour un débat valide.

### Workflow 5 Rounds (avec débat itératif)

```
Round 1: CRITIQUE
├─ Chaque agent analyse indépendamment
└─ Output: 6 critiques séparées avec score /10

Round 2: FRICTIONS (NEW)
├─ Identifier 2-3 désaccords majeurs
├─ Former les "camps" (agents pour/contre)
└─ Préparer le débat ciblé

Round 3: DÉBAT CIBLÉ (NEW - itératif)
├─ Pour chaque friction (max 3) :
│   ├─ Tour 1: Camp A argumente / Camp B argumente
│   ├─ Tour 2: Camp A répond à B / Camp B répond à A
│   └─ Tour 3: Positions finales (si pas de résolution)
├─ Max 3 tours par friction
└─ Résultat: RÉSOLU ou DIVERGENCE MAINTENUE

Round 4: CONVERGENCE
├─ Chaque agent donne son TOP 3 (post-débat)
└─ Pondérer par spécialité de l'agent

Round 5: CONSENSUS
├─ Claude synthétise le débat complet
├─ Points de consensus documentés
├─ Résultats des débats (frictions résolues/maintenues)
├─ Divergences avec arguments des deux côtés
└─ Actions prioritaires (TOP 5)
```

### Mode d'exécution : CONTINU

Le débat s'exécute **automatiquement du Round 1 au Round 5** sans interruption :

```
🧠 Multi-Mind Debate en cours...
├─ Round 1: CRITIQUE ✅
├─ Round 2: FRICTIONS ✅ (3 identifiées)
├─ Round 3: DÉBAT CIBLÉ ⏳
│  ├─ Friction #1: Tour 2/3 ⏳
│  │  ├─ Camp A (🏛️🤖🔮): "SQL pour intégrité..."
│  │  └─ Camp B (💎🐉🌙): "NoSQL pour flexibilité..."
│  ├─ Friction #2: En attente...
│  └─ Friction #3: En attente...
├─ Round 4: CONVERGENCE ...
└─ Round 5: CONSENSUS ...
```

### Intégration au workflow

Le skill Multi-Mind est proposé automatiquement :

| Après | Proposition |
|-------|-------------|
| `/pm-prd` (Mode FULL) | "Valider le PRD avec Multi-Mind ?" |
| `/code-reviewer` (3 passes) | "Review multi-perspectives ?" |

### Output

**Terminal** :
```
╔═══════════════════════════════════════╗
║  🧠 MULTI-MIND DEBATE COMPLETE        ║
║  Agents: 6/6 | Duration: 4m 12s       ║
╠═══════════════════════════════════════╣
║  ✅ CONSENSUS (4 points)              ║
║  🔥 FRICTIONS (3 débattues, 2 résolues)║
║  ⚖️ DIVERGENCES (1 point)             ║
║  📋 ACTIONS (5 items)                 ║
╚═══════════════════════════════════════╝
```

**Rapport complet** : `docs/debates/YYYY-MM-DD-topic.md`
- Round 1 : Critiques individuelles
- Round 2 : Frictions identifiées
- Round 3 : Tous les tours de débat détaillés
- Round 4 : Convergence pondérée
- Round 5 : Synthèse finale

### Knowledge Base Multi-Mind

```
.claude/knowledge/multi-mind/
├── agent-personalities.md    # 6 system prompts
└── debate-templates.md       # Templates 5 rounds
```

---

## Fonctionnalités avancées (v3.3)

### Task System intégré au workflow /feature

Le Task System est maintenant **automatiquement utilisé** dans le workflow `/feature` quand il y a 2+ étapes d'implémentation.

**Règle de déclenchement :**

| Nombre d'étapes | Comportement |
|-----------------|--------------|
| 1 étape | Pas de Task (spinner natif suffit) |
| **2+ étapes** | `TaskCreate` automatique pour chaque étape |

**Workflow automatisé :**

```
/feature #123
    │
    ├── EXPLAIN → Analyse de l'issue et du codebase
    │
    ├── PLAN → implementation-planner
    │   └── Si 2+ étapes :
    │       TaskCreate("Étape 1: ...")
    │       TaskCreate("Étape 2: ...")
    │       TaskUpdate(addBlockedBy: [...])  # Dépendances
    │
    ├── CODE → code-implementer
    │   └── Pour chaque étape :
    │       TaskUpdate(in_progress) → Coder → TaskUpdate(completed)
    │
    ├── TEST → test-runner
    │
    └── REVIEW → 3 passes
```

**Bénéfices :**
- Visualisation en temps réel de la progression
- Reprise automatique en cas d'interruption (timeout, crash)
- Coordination multi-sessions (CLAUDE_CODE_TASK_LIST_ID)
- Documentation du travail effectué

**Format TaskCreate dans implementation-planner :**

```typescript
TaskCreate({
  subject: "Étape N: [Titre court impératif]",
  description: `
    **Objectif:** [Ce que cette étape accomplit]
    **Fichiers:** [Liste des fichiers à modifier]
    **Validation:** [Commandes de vérification]
    **Dépendances:** [Étapes préalables]
  `,
  activeForm: "[Action]ing [objet]..."  // Ex: "Creating user types..."
})
```

**Mise à jour dans code-implementer :**

```typescript
// Avant de commencer une étape
TaskUpdate({ taskId: "X", status: "in_progress" })

// Après avoir terminé une étape
TaskUpdate({ taskId: "X", status: "completed" })
TaskList()  // Voir la prochaine tâche
```

---

## Fonctionnalités avancées (v3.2)

### Task System (documentation générale)

Claude Code utilise le système **Tasks** pour tracker les projets complexes et coordonner le travail multi-sessions.

**Quand utiliser les Tasks :**
- Travail multi-étapes où tu pourrais oublier une étape
- Dépendances entre actions (X doit être fait avant Y)
- Travail interruptible (multi-sessions, risque de timeout)
- L'utilisateur demande explicitement un suivi de progression

**Quand NE PAS utiliser les Tasks :**
- Action unique évidente (ajouter un import, corriger une typo)
- Fix trivial < 1 minute
- Exploration/recherche sans modification de code
- Le spinner natif suffit à montrer l'activité en cours

**Outils disponibles :**

| Outil | Usage |
|-------|-------|
| `TaskCreate` | Créer une nouvelle tâche avec subject, description, activeForm |
| `TaskList` | Lister toutes les tâches et leur statut |
| `TaskGet` | Récupérer les détails d'une tâche par ID |
| `TaskUpdate` | Mettre à jour statut, description, dépendances |

**Workflow Tasks :**

```
1. TaskCreate → Créer les tâches avec dépendances
2. TaskUpdate(status: in_progress) → Marquer le début
3. [Exécution du travail]
4. TaskUpdate(status: completed) → Marquer la fin
5. TaskList → Vérifier la prochaine tâche
```

**Multi-sessions :**

```bash
# Partager une liste de tâches entre sessions
CLAUDE_CODE_TASK_LIST_ID=mon-projet claude
```

Toutes les sessions avec le même ID partagent les Tasks et sont notifiées des mises à jour.

**Champs TaskCreate :**
- `subject` : Titre court en forme impérative ("Implémenter X")
- `description` : Détails, contexte, critères d'acceptance
- `activeForm` : Forme progressive pour le spinner ("Implementing X")

**Statuts :**
- `pending` : En attente
- `in_progress` : En cours (un seul à la fois recommandé)
- `completed` : Terminé

> ⚠️ **Note** : `TodoWrite` est obsolète et remplacé par `TaskCreate`.

---

### Plan Mode Obligatoire

Pour les tâches d'implémentation non-triviales, Claude DOIT utiliser le Plan Mode.

**Quand activer Plan Mode :**

| Situation | Plan Mode ? |
|-----------|-------------|
| Nouvelle feature | ✅ Oui |
| Bug fix simple (< 10 lignes) | ❌ Non |
| Refactoring | ✅ Oui |
| Documentation | ❌ Non |
| Architecture | ✅ Oui |
| Changement multi-fichiers | ✅ Oui |
| Choix technique à faire | ✅ Oui |

**Workflow recommandé :**

```
1. Explore (agent: Explore) → Recherche dans le codebase
2. EnterPlanMode → Designer la solution
3. Validation utilisateur (⏸️ STOP)
4. Exécution avec Tasks pour tracking
5. Output Scoring → Validation qualité
```

**Règles :**
- ✅ Toujours explorer avant de planifier
- ✅ Toujours planifier avant de coder (sauf fix trivial)
- ✅ Toujours valider le plan avec l'utilisateur
- ✅ Utiliser Tasks pour tracker l'exécution
- ⛔ Ne JAMAIS coder sans avoir compris l'existant

---

### Subagents et Context

**Types de subagents :**

| Agent | Usage |
|-------|-------|
| `Explore` | Recherche dans le codebase, analyse de fichiers |
| `Plan` | Conception de plans d'implémentation |
| `Bash` | Exécution de commandes shell |

**Context modes :**

| Mode | Usage |
|------|-------|
| `context: fork` | Isolation complète, contexte forké |
| `context: default` | Contexte partagé avec la session principale |

**Recommandations :**
- Skills de planification → `context: fork` (isolation)
- Skills d'implémentation → `context: fork` (protection)
- Skills de lecture simple → `context: default`

---

### Skills + Slash Commands (Merger)

Les Slash Commands et Skills sont maintenant fusionnés. Chaque skill peut être invoqué avec `/skill-name`.

**Frontmatter d'invocation :**

```yaml
user-invocable: true        # Peut être appelé via /skill-name
# Si false, le skill ne peut être appelé que par Claude ou un subagent
```

**Utilisation :**
- `/idea-brainstorm "mon idée"` → Invoque le skill idea-brainstorm
- `/feature #123` → Invoque le workflow feature
- `/pr-review #456` → Invoque le skill pr-review

**Avec subagents :**

Les skills peuvent spawner des subagents avec `agent: <type>` :
```yaml
agent: Explore  # Spawn un subagent Explore pour la recherche
agent: Plan     # Spawn un subagent Plan pour la conception
```

Avec `context: fork`, le subagent hérite du contexte actuel mais travaille de manière isolée.

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

Tous les skills incluent une section `## 📥 Contexte à charger` qui liste les fichiers et patterns à découvrir au démarrage. Cette approche utilise les outils natifs de Claude Code (`Glob`, `Read`, `Grep`, `Bash`) au lieu de commandes shell inline.

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

## Structure des Skills (v3.5)

Chaque skill suit une structure standardisée avec le frontmatter dans cet ordre :

```markdown
---
name: skill-name                 # Nom kebab-case
description: Description + triggers
model: opus                      # Modèle Claude
context: fork | default          # Isolation (fork) ou partagé (default)
agent: Plan | Explore            # Type de subagent (optionnel)
allowed-tools:                   # Outils autorisés (liste YAML)
  - Read
  - Write
  - Bash
  - Task                         # Nouveau système Tasks
argument-hint: <hint>            # Guide pour l'utilisateur
user-invocable: true             # Appelable via /skill-name
hooks:                           # Hooks automatiques (optionnel)
  pre_tool_call: [...]
  post_tool_call: [...]
knowledge:                       # Knowledge base (optionnel)
  core: [fichiers auto-chargés]
  advanced: [fichiers si besoin]
  debugging: [fichiers troubleshooting]
triggers_ux_ui:                  # Auto-trigger UX/UI (optionnel)
  auto: true
  criteria: {...}
---

# Skill Name

## 📥 Contexte à charger

**Au démarrage, découvrir et charger le contexte pertinent.**

| Contexte | Pattern/Action | Priorité |
|----------|----------------|----------|
| [Nom] | `Glob: pattern` ou `Read: fichier` ou `Bash: commande` | Requis/Optionnel |

### Instructions de chargement
1. Utiliser `Glob` pour découvrir les fichiers par pattern
2. Utiliser `Read` pour charger le contenu (avec limite si volumineux)
3. Si fichier absent, continuer sans erreur

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
├── workflows/                 # 10 fichiers
│   ├── prd-template.md
│   ├── prd-patterns.md            # NEW v2.7 - Patterns par domaine
│   ├── architecture-template.md
│   ├── stories-template.md
│   ├── ux-template.md
│   ├── ui-template.md
│   ├── estimation-techniques.md   # NEW v2.7 - Techniques d'estimation
│   ├── risk-assessment.md         # NEW v2.7 - Framework de risques
│   ├── domain-complexity.csv
│   └── project-types.csv
├── brainstorming/             # NEW v3.6 - Techniques de brainstorming
│   └── brain-techniques.csv       # 61 techniques en 10 catégories
├── multi-mind/                # NEW v3.5 - Débat multi-agents
│   ├── agent-personalities.md     # 6 system prompts
│   └── debate-templates.md        # Templates 5 rounds (itératif)
└── figma/                     # NEW v3.8 - Intégration Figma
    ├── code-connect-guide.md      # Guide CLI Code Connect
    ├── mcp-tools-reference.md     # Référence outils MCP Figma
    └── tokens-mapping.md          # Mapping Figma Variables → CSS
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

- ⛔ Ne JAMAIS commit/push directement sur main (toujours utiliser une branche dédiée + PR)
- ⛔ Ne JAMAIS committer sans tests qui passent
- ⛔ Ne JAMAIS merger sans les 3 passes de review
- ✅ Respecter les conventions du projet existant
- ✅ Préférer la simplicité à la complexité
