# D-EPCT+R Workflow

> **Skills Claude Code pour un workflow de développement structuré et professionnel**
>
> **🧠 Intelligence**
>
> - **Multi-Mind** - Débat avec 6 IA (Claude, GPT, Gemini, DeepSeek, GLM, Kimi)
> - **Brainstorming** - 61 techniques créatives, anti-biais, 4 approches
> - **Claude Opus** - Modèle le plus intelligent sur tous les skills
>
> **🔒 Sécurité** _(NEW v3.7)_
>
> - **Supabase Audit** - RLS, buckets, auth, keys exposées, CVSS scoring
> - **Security Auditor** - OWASP Top 10, CVE, secrets
> - **51 fichiers Knowledge** - Base de connaissances testing, workflows, sécurité
>
> **⚡ Automatisation**
>
> - **Mode RALPH** - Boucle autonome jusqu'à completion
> - **Task System** - Tracking auto si 2+ étapes
> - **Plan Mode** - Explore → Plan → Code
>
> **🛠️ DevOps**
>
> - **Git Hooks** - pre-commit, commit-msg, conventional commits
> - **DevContainer** - Docker dev environment prêt à l'emploi
> - **18 skills** - Du brainstorm au déploiement
>
> **🤖 Multi-Agent** _(NEW v3.7)_
>
> - **Compatible** - Claude, Codex, Gemini, OpenCode
> - **Symlinks** - Un seul source of truth (`.claude/`)
> - **Portable** - Même skills/knowledge partout

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
/resume-ralph [session-id]  # Reprendre une session RALPH
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
```

### Configuration RALPH

| Commande          | Max Iter | Timeout | Completion Promise   |
| ----------------- | -------- | ------- | -------------------- |
| `/auto-loop`      | 20       | 1h      | "DONE"               |
| `/auto-discovery` | 30       | 1h      | "DISCOVERY COMPLETE" |
| `/auto-feature`   | 50       | 2h      | "FEATURE COMPLETE"   |

**Options:** `--max N`, `--timeout Xh`, `--promise "TEXT"`, `--no-log`, `--verbose`

---

## Skills (18)

### Phase Planning

| Skill               | Rôle                   | Fonctionnalités clés                                                                                            |
| ------------------- | ---------------------- | --------------------------------------------------------------------------------------------------------------- |
| `idea-brainstorm`   | Exploration créative   | **61 techniques** en 10 catégories, **4 approches**, **anti-biais protocol**, **auto-trigger UX/UI** (NEW v3.6) |
| `pm-prd`            | Product Requirements   | Mode **FULL/LIGHT** auto-détecté, templates, **auto-trigger UX/UI**                                             |
| `architect`         | Architecture technique | Stack, structure, data model, APIs, ADRs                                                                        |
| `pm-stories`        | Epics + Stories        | INVEST, Given/When/Then, **Readiness Check /15**                                                                |
| `api-designer`      | Design d'API           | **OpenAPI 3.1**, REST/GraphQL, versioning, rate limiting                                                        |
| `database-designer` | Design de BDD (NEW)    | **ERD**, migrations, indexes, Prisma/Drizzle                                                                    |

### Phase Design (optionnelle, auto-triggered)

| Skill         | Rôle                   | Fonctionnalités clés                                                          |
| ------------- | ---------------------- | ----------------------------------------------------------------------------- |
| `ux-designer` | Expérience utilisateur | Personas, **user journeys**, wireframes textuels, heuristiques Nielsen        |
| `ui-designer` | Design system          | **Tokens** (couleurs, typo, spacing), composants UI, guidelines accessibilité |

### Phase Développement

| Skill                    | Rôle                 | Fonctionnalités clés                                              |
| ------------------------ | -------------------- | ----------------------------------------------------------------- |
| `github-issue-reader`    | Lecture d'issues     | Catégorisation, **ambiguïtés classifiées** (🔴/🟡/🟢), G/W/T      |
| `codebase-explainer`     | Analyse du code      | **Impact mapping**, patterns, flux, risques                       |
| `implementation-planner` | Planification        | **Complexité S/M/L**, étapes atomiques, **TaskCreate auto** (NEW) |
| `code-implementer`       | Implémentation       | **Lint/types obligatoires**, **TaskUpdate auto** (NEW)            |
| `test-runner`            | Tests                | Mode **ATDD** (tests first), priorités P0-P3, **hook coverage**   |
| `code-reviewer`          | Review (3 passes)    | Correctness → Readability → Performance                           |
| `security-auditor`       | Audit sécurité       | **OWASP Top 10**, dépendances, secrets, scoring                   |
| `performance-auditor`    | Audit performance    | **Core Web Vitals**, bundle size, Lighthouse                      |
| `supabase-security`      | Audit Supabase (NEW) | **RLS**, buckets, auth, keys exposées, **CVSS**                   |
| `multi-mind`             | Débat multi-agents   | **6 IA**, 5 rounds itératifs, consensus/divergences               |

---

## Fonctionnalités v3.5

### Multi-Mind Debate System

Système de débat multi-agents avec 6 IA pour valider PRD et code :

```bash
/multi-mind prd docs/PRD/PRD-Feature.md    # Valider un PRD
/multi-mind review src/components/Auth.tsx  # Review multi-perspectives
```

### Les 6 Agents

| Agent           | Provider  | Rôle               | Coût       |
| --------------- | --------- | ------------------ | ---------- |
| 🏛️ **Claude**   | Anthropic | Architecte Prudent | Inclus     |
| 🤖 **GPT**      | OpenAI    | Perfectionniste    | 💳 Payant  |
| 💎 **Gemini**   | Google    | Innovateur UX      | 💳 Payant  |
| 🐉 **DeepSeek** | DeepSeek  | Provocateur        | 🆓 Gratuit |
| 🔮 **GLM**      | Zhipu AI  | Craftsman Frontend | 🆓 Gratuit |
| 🌙 **Kimi**     | Moonshot  | Product Thinker    | 🆓 Gratuit |

### Configuration des agents

#### Option 1 : Fichier `.env.local` (recommandé)

```bash
# Copier le template
cp .env.example .env.local

# Éditer avec tes clés
code .env.local
```

Contenu de `.env.local` :

```
DEEPSEEK_API_KEY=sk-ta-clé-deepseek
GLM_API_KEY=ta-clé-glm
OPENROUTER_API_KEY=sk-or-v1-ta-clé-openrouter
```

#### Option 2 : Variables d'environnement

```bash
# Ajouter dans ~/.zshrc ou ~/.bashrc
export DEEPSEEK_API_KEY="sk-..."      # https://platform.deepseek.com/
export GLM_API_KEY="..."              # https://open.bigmodel.cn/
export OPENROUTER_API_KEY="sk-or-..." # https://openrouter.ai/

# Recharger
source ~/.zshrc
```

#### Agents payants (optionnels)

```bash
npm install -g @openai/codex   # GPT via Codex CLI
npm install -g gemini-cli      # Gemini CLI
```

**Minimum requis** : 3 agents pour un débat valide.

### Architecture Multi-Mind (5 Rounds)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           MULTI-MIND DEBATE SYSTEM                              │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  │
│  │   🏛️    │  │   🤖    │  │   💎    │  │   🐉    │  │   🔮    │  │   🌙    │  │
│  │ Claude  │  │   GPT   │  │ Gemini  │  │DeepSeek │  │   GLM   │  │  Kimi   │  │
│  │Architecte│  │Perfec-  │  │Innovateur│  │Provoca- │  │Craftsman│  │Product  │  │
│  │ Prudent │  │tionniste│  │   UX    │  │  teur   │  │Frontend │  │Thinker  │  │
│  └────┬────┘  └────┬────┘  └────┬────┘  └────┬────┘  └────┬────┘  └────┬────┘  │
│       │            │            │            │            │            │        │
│       ▼            ▼            ▼            ▼            ▼            ▼        │
│  ╔═════════════════════════════════════════════════════════════════════════╗   │
│  ║  ROUND 1: CRITIQUE INDIVIDUELLE                                         ║   │
│  ║  ┌──────────────────────────────────────────────────────────────────┐   ║   │
│  ║  │  Chaque agent analyse le document INDÉPENDAMMENT                 │   ║   │
│  ║  │  → Points forts (3) + Points faibles (5) + Risques + Score /10   │   ║   │
│  ║  └──────────────────────────────────────────────────────────────────┘   ║   │
│  ╚═════════════════════════════════════════════════════════════════════════╝   │
│                                      │                                          │
│                                      ▼                                          │
│  ╔═════════════════════════════════════════════════════════════════════════╗   │
│  ║  ROUND 2: IDENTIFICATION DES FRICTIONS                                  ║   │
│  ║  ┌──────────────────────────────────────────────────────────────────┐   ║   │
│  ║  │  Analyser les critiques → Extraire 2-3 DÉSACCORDS MAJEURS        │   ║   │
│  ║  │  Former les "camps" pour chaque friction                          │   ║   │
│  ║  │                                                                   │   ║   │
│  ║  │  Friction #1: [Sujet]     Friction #2: [Sujet]                    │   ║   │
│  ║  │  ┌─────────┬─────────┐    ┌─────────┬─────────┐                   │   ║   │
│  ║  │  │ Camp A  │ Camp B  │    │ Camp A  │ Camp B  │                   │   ║   │
│  ║  │  │ 🏛️🤖🔮  │ 💎🐉🌙  │    │ 🏛️💎🌙  │ 🤖🐉🔮  │                   │   ║   │
│  ║  │  └─────────┴─────────┘    └─────────┴─────────┘                   │   ║   │
│  ║  └──────────────────────────────────────────────────────────────────┘   ║   │
│  ╚═════════════════════════════════════════════════════════════════════════╝   │
│                                      │                                          │
│                                      ▼                                          │
│  ╔═════════════════════════════════════════════════════════════════════════╗   │
│  ║  ROUND 3: DÉBAT CIBLÉ (Itératif - max 3 tours par friction)             ║   │
│  ║  ┌──────────────────────────────────────────────────────────────────┐   ║   │
│  ║  │  Pour chaque friction:                                            │   ║   │
│  ║  │                                                                   │   ║   │
│  ║  │  Tour 1    Camp A ◄──────────────────────► Camp B                 │   ║   │
│  ║  │            "Arguments initiaux"    "Arguments initiaux"           │   ║   │
│  ║  │                      │                      │                     │   ║   │
│  ║  │  Tour 2    Camp A ◄──────────────────────► Camp B                 │   ║   │
│  ║  │            "Contre-arguments"      "Contre-arguments"             │   ║   │
│  ║  │                      │                      │                     │   ║   │
│  ║  │  Tour 3    Camp A ◄──────────────────────► Camp B                 │   ║   │
│  ║  │            "Position finale"       "Position finale"              │   ║   │
│  ║  │                      │                      │                     │   ║   │
│  ║  │                      ▼                      ▼                     │   ║   │
│  ║  │              ┌─────────────┐  ou  ┌─────────────────┐             │   ║   │
│  ║  │              │ ✅ RÉSOLU   │      │ ⚖️ DIVERGENCE   │             │   ║   │
│  ║  │              └─────────────┘      └─────────────────┘             │   ║   │
│  ║  └──────────────────────────────────────────────────────────────────┘   ║   │
│  ╚═════════════════════════════════════════════════════════════════════════╝   │
│                                      │                                          │
│                                      ▼                                          │
│  ╔═════════════════════════════════════════════════════════════════════════╗   │
│  ║  ROUND 4: CONVERGENCE                                                   ║   │
│  ║  ┌──────────────────────────────────────────────────────────────────┐   ║   │
│  ║  │  Chaque agent donne son TOP 3 (post-débat)                        │   ║   │
│  ║  │  Pondération par spécialité:                                      │   ║   │
│  ║  │                                                                   │   ║   │
│  ║  │  PRD Mode:    Claude 1.5x │ Gemini 1.5x │ Kimi 1.5x │ GLM 1.3x   │   ║   │
│  ║  │  Review Mode: Claude 1.5x │ GPT 1.5x    │ GLM 1.3x  │ DeepSeek 1.2x│  ║   │
│  ║  └──────────────────────────────────────────────────────────────────┘   ║   │
│  ╚═════════════════════════════════════════════════════════════════════════╝   │
│                                      │                                          │
│                                      ▼                                          │
│  ╔═════════════════════════════════════════════════════════════════════════╗   │
│  ║  ROUND 5: CONSENSUS (Claude synthétise)                                 ║   │
│  ║  ┌──────────────────────────────────────────────────────────────────┐   ║   │
│  ║  │                                                                   │   ║   │
│  ║  │    ✅ CONSENSUS          🔥 FRICTIONS         ⚖️ DIVERGENCES      │   ║   │
│  ║  │    Points unanimes       Résolues/Maintenues   Arguments A vs B   │   ║   │
│  ║  │                                                                   │   ║   │
│  ║  │                    📋 ACTIONS PRIORITAIRES                        │   ║   │
│  ║  │                    P0: [Action critique]                          │   ║   │
│  ║  │                    P1: [Action importante]                        │   ║   │
│  ║  │                    P2: [Action souhaitable]                       │   ║   │
│  ║  │                                                                   │   ║   │
│  ║  └──────────────────────────────────────────────────────────────────┘   ║   │
│  ╚═════════════════════════════════════════════════════════════════════════╝   │
│                                      │                                          │
│                                      ▼                                          │
│                        ┌─────────────────────────────┐                          │
│                        │  📄 docs/debates/           │                          │
│                        │     YYYY-MM-DD-topic.md     │                          │
│                        │                             │                          │
│                        │  Rapport complet avec tous  │                          │
│                        │  les échanges documentés    │                          │
│                        └─────────────────────────────┘                          │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Résumé des Rounds

| Round | Nom             | Description                                         |
| ----- | --------------- | --------------------------------------------------- |
| 1     | **CRITIQUE**    | Chaque agent analyse indépendamment (score /10)     |
| 2     | **FRICTIONS**   | Identifier 2-3 désaccords majeurs, former les camps |
| 3     | **DÉBAT**       | Échanges ping-pong (max 3 tours par friction)       |
| 4     | **CONVERGENCE** | TOP 3 par agent, pondéré par spécialité             |
| 5     | **CONSENSUS**   | Claude synthétise + actions prioritaires            |

### Intégration au workflow

Multi-Mind est proposé (optionnel) après :

- `/pm-prd` (Mode FULL) → Option **[M]** Multi-Mind
- `/code-reviewer` (3 passes) → Option **[M]** Multi-Mind
- `/refactor` (3 passes) → Option **[M]** Multi-Mind

**Output** : Rapport dans `docs/debates/YYYY-MM-DD-topic.md`

---

## Fonctionnalités v3.7

### Supabase Security Audit

Audit de sécurité complet pour les applications utilisant Supabase :

```bash
/supabase-security https://myapp.com         # Audit complet
/supabase-security https://myapp.com --quick # Audit rapide
/supabase-security https://myapp.com --skip-auth-test  # Sans création user test
```

**Phases d'audit :**

| Phase             | Tests effectués                                   |
| ----------------- | ------------------------------------------------- |
| **Detection**     | Patterns Supabase dans le code client             |
| **Extraction**    | Anon key, service key (CRITIQUE), JWT, DB strings |
| **API Audit**     | Tables exposées, RLS policies, RPC functions      |
| **Storage Audit** | Buckets publics, fichiers sensibles               |
| **Auth Audit**    | Config, signup, password policy, IDOR             |
| **Functions**     | Edge Functions, Realtime channels                 |

**Findings par sévérité :**

| Sévérité  | Exemples                                         | Délai    |
| --------- | ------------------------------------------------ | -------- |
| 🔴 **P0** | Service key exposée, table users sans RLS        | Immédiat |
| 🟠 **P1** | Email confirm désactivé, bucket documents public | 7 jours  |
| 🟡 **P2** | Source maps exposées, password < 8 chars         | 30 jours |

**Output :**

- `docs/security/supabase-audit-YYYY-MM-DD.md` - Rapport complet
- `.supabase-audit/` - Evidence et commandes curl reproductibles

**Knowledge base (7 fichiers) :**

- `audit-checklist.md` - Checklist complète des 7 phases
- `severity-matrix.md` - P0/P1/P2 avec scores CVSS
- `rls-patterns.md` - Patterns corrects/incorrects + bypass tests
- `remediation-templates.md` - Templates SQL de fix
- `edge-functions-security.md` - Auth, IDOR, role check
- `realtime-security.md` - WebSocket, Broadcast, Presence
- `auth-configuration.md` - GoTrue endpoints, OAuth, CORS

### Multi-Agent Compatibility

Compatibilité avec d'autres outils IA via symlinks vers `.claude/` :

```
.agents/           # Generic fallback
├── README.md      # Documentation
├── AGENTS.md      # Instructions
├── skills/        → .claude/skills/
└── knowledge/     → .claude/knowledge/

.codex/            # OpenAI Codex CLI
.gemini/           # Google Gemini CLI
.opencode/         # OpenCode
```

**Principe** : Un seul source of truth (`.claude/`), les autres dossiers contiennent des symlinks.

**Utilisation** :

| Outil | Commande | Config lue |
|-------|----------|------------|
| Claude Code | `claude` | `.claude/CLAUDE.md` |
| OpenAI Codex | `codex` | `.codex/AGENTS.md` |
| Gemini CLI | `gemini` | `.gemini/GEMINI.md` |
| OpenCode | `opencode` | `.opencode/AGENTS.md` |

**Ajouter un nouvel outil** :

```bash
mkdir .newtool
ln -sf ../.claude/skills .newtool/skills
ln -sf ../.claude/knowledge .newtool/knowledge
# Créer .newtool/AGENTS.md avec les instructions
```

---

## Fonctionnalités v3.3

### Task System automatique dans /feature

Le Task System est maintenant **automatiquement utilisé** dans le workflow `/feature` :

| Étapes        | Comportement                               |
| ------------- | ------------------------------------------ |
| 1 étape       | Spinner natif (pas de Task)                |
| **2+ étapes** | `TaskCreate` automatique pour chaque étape |

**Workflow :**

```
/feature #123
    │
    ├── PLAN → TaskCreate pour chaque étape (avec dépendances)
    │
    └── CODE → TaskUpdate(in_progress) → Coder → TaskUpdate(completed)
```

**Bénéfices :**

- Visualisation en temps réel de la progression
- Reprise en cas d'interruption (timeout, crash)
- Documentation automatique du travail

**Skills mis à jour :**

- `implementation-planner` : Crée les Tasks si 2+ étapes
- `code-implementer` : Met à jour les Tasks automatiquement

---

## Fonctionnalités v3.2

### Task System (général)

Claude Code utilise le système **Tasks** pour tracker les projets complexes :

| Outil        | Usage                                                 |
| ------------ | ----------------------------------------------------- |
| `TaskCreate` | Créer une tâche avec subject, description, activeForm |
| `TaskList`   | Lister toutes les tâches et leur statut               |
| `TaskGet`    | Récupérer les détails d'une tâche par ID              |
| `TaskUpdate` | Mettre à jour statut, description, dépendances        |

**Quand utiliser :**

- Travail multi-étapes où tu pourrais oublier une étape
- Dépendances entre actions (X avant Y)
- Travail interruptible (multi-sessions)

**Quand NE PAS utiliser :**

- Action unique évidente (typo, import)
- Fix trivial < 1 minute
- Le spinner natif suffit

**Multi-sessions :**

```bash
CLAUDE_CODE_TASK_LIST_ID=mon-projet claude
```

### Plan Mode

Pour les tâches non-triviales, Claude utilise le workflow :

1. **Explore** → Recherche dans le codebase
2. **Plan** → Designer la solution
3. **Validate** → Approbation utilisateur
4. **Execute** → Implémentation avec Tasks

---

## Fonctionnalités v3.1

### Git Hooks

Templates de hooks Git :

```bash
# Installation
cp .claude/templates/git-hooks/* .git/hooks/
chmod +x .git/hooks/*
```

| Hook         | Checks                                       |
| ------------ | -------------------------------------------- |
| `pre-commit` | ESLint, TypeScript, Prettier, Tests, Secrets |
| `commit-msg` | Conventional Commits format                  |

### DevContainer Templates

Configuration Docker pour VS Code / GitHub Codespaces :

```bash
mkdir -p .devcontainer
cp .claude/templates/devcontainer/* .devcontainer/
```

**Inclus** : Node.js 20, PostgreSQL, Redis, extensions VS Code

### Skill performance-auditor

Audit de performance :

```bash
/performance-auditor https://example.com
```

**Analyses** : Core Web Vitals (LCP, INP, CLS), Bundle size, Lighthouse, Dependencies

---

## Fonctionnalités v3.0

### Skill database-designer

Design de schémas de base de données :

```bash
/database-designer blog-platform    # Design DB
/database-designer --orm prisma     # Avec ORM
```

**Fonctionnalités** : ERD ASCII, Migrations (SQL/Prisma/Drizzle), Indexes, Relations, Seed data

### Commande /init

Scaffolding de projet :

```bash
/init next              # Next.js 14 + TypeScript
/init express           # Express.js API
/init api               # API minimaliste (Hono)
/init cli               # CLI avec Commander.js
/init lib               # Library npm
```

**Options** : `--db postgres`, `--auth`, `--docker`, `--ci`

### Issue Templates GitHub

Templates pour issues dans `.claude/templates/github/ISSUE_TEMPLATE/` :

| Template             | Label         |
| -------------------- | ------------- |
| `bug_report.md`      | `bug`         |
| `feature_request.md` | `enhancement` |

---

## Fonctionnalités v2.9

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

**Métriques** : Codebase, Tests, GitHub, Dependencies, RALPH
**Health Score** : `Coverage + Tests + Docs + Security + Activity`

### PR Template GitHub

Template standard pour les Pull Requests :

```
.claude/templates/github/PULL_REQUEST_TEMPLATE.md
```

**Installation** : `cp .claude/templates/github/PULL_REQUEST_TEMPLATE.md .github/`

---

## Fonctionnalités v2.8

### Security Auditor

Nouveau skill pour auditer la sécurité du code :

```bash
/security-auditor src/          # Audit un dossier
/security-auditor               # Audit tout le projet
```

**Analyses** : OWASP Top 10, CVE, Secrets, Configuration
**Score** : `100 - (Critical×25) - (High×10) - (Medium×5) - (Low×1)`

### GitHub Actions Templates

Templates CI/CD dans `.claude/templates/github-actions/` :

| Template         | Description                  |
| ---------------- | ---------------------------- |
| `ci.yml`         | Lint, Typecheck, Test, Build |
| `release.yml`    | Changelog + GitHub Release   |
| `security.yml`   | npm audit, CodeQL, Secrets   |
| `deploy.yml`     | Vercel, Netlify, AWS, K8s    |
| `dependabot.yml` | Auto-updates                 |

### Commande /changelog

```bash
/changelog 2.8.0              # Version spécifique
/changelog --since v2.7.0     # Depuis un tag
/changelog --dry-run          # Prévisualiser
```

---

## Fonctionnalités v2.7

### Skill Chaining (Auto-Chain)

Chaque skill propose automatiquement le skill suivant après validation :

```
✅ Brainstorm terminé → Lancer /ux-designer ou /pm-prd ?
✅ PRD validé → Lancer /ui-designer ou /architect ?
✅ Code implémenté → Lancer /test-runner ?
```

### Output Validation

Chaque skill valide son output avec un score minimum avant transition :

| Skill              | Seuil |
| ------------------ | ----- |
| `idea-brainstorm`  | 4/5   |
| `pm-prd`           | 6/7   |
| `pm-stories`       | 13/15 |
| `code-implementer` | 4/5   |

### RALPH Metrics

Les commandes RALPH trackent automatiquement :

- Temps par phase
- Auto-corrections (lint, types, tests)
- Fichiers créés/modifiés
- Retours arrière

### Commande /resume-ralph

Reprendre une session RALPH interrompue :

```bash
/resume-ralph                 # Dernière session
/resume-ralph <session-id>    # Session spécifique
```

---

## Fonctionnalités v2.6

### Dynamic Context Injection

Tous les skills chargent automatiquement le contexte pertinent au démarrage :

| Skill                    | Contexte auto-chargé                               |
| ------------------------ | -------------------------------------------------- |
| `github-issue-reader`    | Issue GitHub, PRs liées                            |
| `codebase-explainer`     | Structure projet, package.json, CLAUDE.md          |
| `idea-brainstorm`        | Brainstorms existants, PRDs                        |
| `implementation-planner` | PRD, architecture, stories, analyse codebase       |
| `test-runner`            | Config test, tests existants, scripts npm          |
| `code-implementer`       | CLAUDE.md, ESLint, tsconfig, plan actif            |
| `pm-prd`                 | Brainstorms, PRDs existants, UX design             |
| `architect`              | PRD actif, stack existant, structure projet        |
| `pm-stories`             | PRD, architecture, stories existantes, GitHub repo |
| `code-reviewer`          | Fichiers modifiés, diff git, erreurs lint          |
| `ux-designer`            | PRD, brainstorm, UX existant                       |
| `ui-designer`            | UX design, tokens existants, framework détecté     |

### Hooks automatiques

| Skill              | Type | Trigger              | Action              |
| ------------------ | ---- | -------------------- | ------------------- |
| `code-implementer` | post | Edit/Write           | Auto-lint           |
| `test-runner`      | post | npm test             | Affiche coverage    |
| `pm-stories`       | pre  | create_issue         | Vérifie GitHub auth |
| `code-reviewer`    | pre  | Read (code files)    | Exécute tests       |
| `architect`        | pre  | Write (architecture) | Vérifie PRD existe  |

### Claude Opus

Tous les skills utilisent **Claude Opus** (`model: opus`) pour une intelligence maximale.

### Argument Hints

Chaque skill affiche un hint pour guider l'utilisateur :

```bash
/idea-brainstorm <idea-description>
/github-issue-reader <issue-number-or-url>
/implementation-planner <prd-or-issue-reference>
/test-runner <file-or-directory-to-test>
/code-reviewer <file-or-pr-number>
```

### Nouvelles commandes utilitaires

| Commande            | Description                                                                      |
| ------------------- | -------------------------------------------------------------------------------- |
| `/status`           | Vue d'ensemble du projet : documents, issues GitHub, sessions RALPH              |
| `/pr-review #123`   | Review une PR GitHub avec les 3 passes (Correctness → Readability → Performance) |
| `/quick-fix "desc"` | Fix rapide sans workflow complet - idéal pour typos, config, petits bugs         |
| `/refactor <file>`  | Refactoring ciblé avec validation des tests avant/après                          |
| `/docs [type]`      | Génère documentation : `readme`, `api`, `guide`, ou `all`                        |

---

## Structure SKILL.md (v2.8)

Chaque skill suit une structure standardisée :

```yaml
---
name: skill-name
description: Description + triggers
model: opus                       # Intelligence maximale
context: fork                     # Exécution isolée
agent: Plan | Explore             # Type d'agent
allowed-tools: [tools]            # Outils autorisés
argument-hint: <hint>             # Guide utilisateur
user-invocable: true | false      # Appelable directement
hooks:                            # Hooks automatiques
  pre_tool_call: [...]
  post_tool_call: [...]
knowledge:
  core: [...]                     # Chargé automatiquement
  advanced: [...]                 # Chargé si besoin
  debugging: [...]                # Chargé si problème
---

# Skill Name

## 📥 Contexte chargé automatiquement
!`commande shell pour charger contexte`

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
├── CLAUDE.md                        # Instructions projet
├── settings.json                    # Config hooks RALPH
├── hooks/
│   └── stop-hook.sh                 # Hook RALPH (intercepte exit)
├── commands/                        # 17 commandes
│   ├── discovery.md
│   ├── feature.md
│   ├── auto-loop.md
│   ├── auto-discovery.md
│   ├── auto-feature.md
│   ├── cancel-ralph.md
│   ├── resume.md
│   ├── status.md
│   ├── pr-review.md
│   ├── quick-fix.md
│   ├── refactor.md
│   ├── docs.md
│   ├── changelog.md
│   ├── metrics.md
│   └── init.md                      # NEW v3.0
├── templates/
│   ├── github-actions/              # CI/CD templates
│   │   ├── ci.yml
│   │   ├── release.yml
│   │   ├── security.yml
│   │   ├── deploy.yml
│   │   └── dependabot.yml
│   ├── github/
│   │   ├── PULL_REQUEST_TEMPLATE.md
│   │   └── ISSUE_TEMPLATE/
│   │       ├── bug_report.md
│   │       ├── feature_request.md
│   │       └── config.yml
│   ├── git-hooks/                   # NEW v3.1
│   │   ├── pre-commit
│   │   └── commit-msg
│   └── devcontainer/                # NEW v3.1
│       ├── devcontainer.json
│       ├── Dockerfile
│       └── docker-compose.yml
├── knowledge/                       # 51 fichiers
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
│   ├── workflows/                   # 10 fichiers
│   │   ├── prd-template.md
│   │   ├── prd-patterns.md
│   │   ├── architecture-template.md
│   │   ├── stories-template.md
│   │   ├── ux-template.md
│   │   ├── ui-template.md
│   │   ├── estimation-techniques.md
│   │   ├── risk-assessment.md
│   │   ├── domain-complexity.csv
│   │   └── project-types.csv
│   ├── brainstorming/               # NEW v3.6 - Techniques brainstorming
│   │   └── brain-techniques.csv     # 61 techniques en 10 catégories
│   ├── multi-mind/                  # NEW v3.4 - Débat multi-agents
│   │   ├── agent-personalities.md
│   │   └── debate-templates.md
│   └── supabase-security/           # NEW v3.7 - Audit Supabase
│       ├── audit-checklist.md
│       ├── severity-matrix.md
│       ├── rls-patterns.md
│       ├── remediation-templates.md
│       ├── edge-functions-security.md
│       ├── realtime-security.md
│       └── auth-configuration.md
└── skills/                          # 18 skills
    ├── idea-brainstorm/
    ├── pm-prd/
    ├── ux-designer/
    ├── ui-designer/
    ├── architect/
    ├── pm-stories/
    ├── github-issue-reader/
    ├── codebase-explainer/
    ├── implementation-planner/
    ├── code-implementer/
    ├── test-runner/
    ├── code-reviewer/
    ├── security-auditor/
    ├── api-designer/
    ├── database-designer/
    ├── performance-auditor/
    ├── supabase-security/           # NEW v3.7
    └── multi-mind/

docs/                                # Output documents
├── planning/
│   ├── brainstorms/
│   ├── ux/
│   ├── prd/
│   ├── ui/
│   └── architecture/
├── stories/
│   └── EPIC-{num}-{slug}/
├── debates/                         # NEW v3.4 - Rapports Multi-Mind
├── security/                        # NEW v3.7 - Rapports Supabase Audit
└── ralph-logs/

.agents/                             # NEW v3.7 - Multi-agent compatibility
├── README.md                        # Documentation du système
├── AGENTS.md                        # Instructions génériques
├── skills/                          → symlink vers .claude/skills/
└── knowledge/                       → symlink vers .claude/knowledge/

.codex/                              # OpenAI Codex CLI
├── AGENTS.md
├── skills/                          → symlink
└── knowledge/                       → symlink

.gemini/                             # Google Gemini CLI
├── GEMINI.md
├── skills/                          → symlink
└── knowledge/                       → symlink

.opencode/                           # OpenCode
├── AGENTS.md
├── skills/                          → symlink
└── knowledge/                       → symlink
```

---

## Knowledge System

### Chargement progressif

| Niveau        | Quand           | Exemple                    |
| ------------- | --------------- | -------------------------- |
| **core**      | Automatiquement | `test-levels-framework.md` |
| **advanced**  | Si complexe     | `fixture-architecture.md`  |
| **debugging** | Si problème     | `test-healing-patterns.md` |

### Contenu (51 fichiers)

#### Testing (32 fichiers)

| Catégorie               | Fichiers | Description                           |
| ----------------------- | -------- | ------------------------------------- |
| **Levels & Priorities** | 3        | Unit/Int/E2E, P0-P3 matrix, DoD       |
| **Data & Fixtures**     | 4        | Factories, fixtures, composition      |
| **Network**             | 5        | Intercept, HAR, recorder              |
| **Debugging**           | 4        | Healing patterns, selectors, timing   |
| **CI/CD**               | 3        | Burn-in, selective testing            |
| **Advanced**            | 13       | Contract testing, feature flags, auth |

#### Workflows (10 fichiers)

- `prd-template.md` - Template PRD complet
- `prd-patterns.md` - Patterns PRD par domaine (NEW v2.7)
- `architecture-template.md` - Template architecture
- `stories-template.md` - Template stories
- `ux-template.md` - Template UX design
- `ui-template.md` - Template UI design
- `estimation-techniques.md` - Techniques d'estimation (NEW v2.7)
- `risk-assessment.md` - Framework de risques (NEW v2.7)
- `domain-complexity.csv` - Matrice complexité
- `project-types.csv` - Types de projets

#### Multi-Mind (2 fichiers) - NEW v3.4

- `agent-personalities.md` - System prompts pour les 6 agents IA
- `debate-templates.md` - Templates pour les 5 rounds de débat itératif

#### Supabase Security (7 fichiers) - NEW v3.7

- `audit-checklist.md` - Checklist complète des 7 phases d'audit
- `severity-matrix.md` - P0/P1/P2 avec scores CVSS
- `rls-patterns.md` - Patterns RLS corrects/incorrects + bypass tests
- `remediation-templates.md` - Templates SQL de fix par sévérité
- `edge-functions-security.md` - Auth, IDOR, role check, validation
- `realtime-security.md` - WebSocket, Broadcast, Presence
- `auth-configuration.md` - GoTrue endpoints, OAuth, CORS

---

## Checkpoints obligatoires

### Planning

| Checkpoint    | Skill             | Gate                                       |
| ------------- | ----------------- | ------------------------------------------ |
| Brainstorm    | `idea-brainstorm` | Synthèse validée                           |
| _UX Design_   | `ux-designer`     | _(optionnel)_ Personas et journeys validés |
| PRD           | `pm-prd`          | Scope défini                               |
| _UI Design_   | `ui-designer`     | _(optionnel)_ Tokens et composants validés |
| Architecture  | `architect`       | Stack approuvé                             |
| **Readiness** | `pm-stories`      | **Score ≥ 13/15**                          |

### Développement

| Checkpoint | Skill                    | Gate                  |
| ---------- | ------------------------ | --------------------- |
| Explain    | `codebase-explainer`     | Architecture comprise |
| Plan       | `implementation-planner` | Étapes approuvées     |
| Code       | `code-implementer`       | **Lint ✅ Types ✅**  |
| Test       | `test-runner`            | **100% pass, 3 runs** |
| Review     | `code-reviewer`          | **3 passes OK**       |

---

## Changelog

### v3.7.0 (Current)

**Supabase Security Audit**

- Nouveau skill `/supabase-security` pour audit complet des projets Supabase
- 7 phases : Detection, Extraction, API, Storage, Auth, Realtime, Functions
- Scoring sévérité P0/P1/P2 aligné sur CVSS
- Evidence collection avec commandes curl reproductibles
- 7 fichiers knowledge : checklist, severity matrix, RLS patterns, remediation templates
- Support RLS bypass tests, Edge Functions security, Realtime channels

**Multi-Agent Compatibility**

- Nouveaux dossiers `.agents/`, `.codex/`, `.gemini/`, `.opencode/`
- Symlinks vers `.claude/skills/` et `.claude/knowledge/`
- Instructions adaptées pour chaque outil (AGENTS.md, GEMINI.md)
- Un seul source of truth : `.claude/`
- install.sh mis à jour pour créer automatiquement la structure

### v3.6.0

**Brainstorming Enhanced (inspiré BMAD)**

- **61 techniques** de brainstorming en **10 catégories** (collaborative, creative, deep, introspective, structured, theatrical, wild, biomimetic, quantum, cultural)
- **4 approches de session** : User-Selected, AI-Recommended, Random Discovery, Progressive Flow
- **Anti-Bias Protocol** : Pivot de domaine tous les 10 idées pour éviter le clustering sémantique
- **Energy Checkpoints** : Toutes les 4-5 échanges pour maintenir le momentum
- **Idea Format Template** : Capture structurée avec Novelty tracking
- **Objectif quantité** : Viser 50-100+ idées avant organisation
- **Mindset facilitateur** : Coach créatif interactif, pas Q&A

**Knowledge Base**

- Nouveau fichier `.claude/knowledge/brainstorming/brain-techniques.csv`

### v3.5.0

**Multi-Mind v3.5 - Débat Itératif**

- **5 rounds** au lieu de 4 : nouveau Round "Frictions" + débat ping-pong
- Round 2 : Identification des frictions (désaccords majeurs)
- Round 3 : Débat ciblé itératif (max 3 tours par friction)
- Échanges arguments/contre-arguments entre "camps"
- Résolution : RÉSOLU ou DIVERGENCE MAINTENUE

**Améliorations techniques**

- Compatibilité macOS (workaround `timeout`)
- Règles anti-substitution strictes (modèles EXACTS obligatoires)
- Retry logic (2x avant échec)
- Outputs plus verbeux et argumentés
- Rapport .md OBLIGATOIRE

**Modèles mis à jour**

- DeepSeek via OpenRouter (`deepseek/deepseek-v3.2`)
- GLM via Z.AI (`glm-4.7`)
- Kimi via OpenRouter (`moonshotai/kimi-k2.5`)
- GPT via Codex CLI (`gpt-5.2-codex`)
- Gemini via CLI (`gemini-3`)

### v3.4.0

**Multi-Mind Debate System (initial)**

- Nouveau skill `multi-mind` pour débat multi-agents
- 6 IA : Claude, GPT, Gemini, DeepSeek, GLM, Kimi
- Workflow 4 rounds initial
- Intégration dans pm-prd, code-reviewer, refactor (option [M])
- Rapports générés dans `docs/debates/`
- Knowledge base : agent-personalities.md, debate-templates.md

### v3.3.0

**Task System automatique dans /feature**

- `implementation-planner` crée automatiquement des Tasks si 2+ étapes
- `code-implementer` met à jour les Tasks (in_progress → completed)
- Règle claire : 1 étape = pas de Task, 2+ étapes = Tasks automatiques
- Dépendances entre Tasks (addBlockedBy) pour séquençage
- Checklist de validation mise à jour dans les deux skills

**Skills modifiés :**

- `implementation-planner/SKILL.md` : Nouvelle section "Création des Tasks"
- `code-implementer/SKILL.md` : Nouvelle section "Gestion des Tasks"
- `feature.md` : Documentation du Task System

### v3.2.0

**Task System Integration**

- Nouveau système Tasks (TaskCreate, TaskList, TaskUpdate, TaskGet)
- Remplace TodoWrite obsolète dans tous les skills
- Support multi-sessions avec CLAUDE_CODE_TASK_LIST_ID
- Coordination entre subagents

**Plan Mode Obligatoire**

- Documentation du workflow Explore → Plan → Code
- Tableau de décision pour activer Plan Mode
- Intégration avec le système Tasks

**Skills Merger Compliance**

- Ajout de `user-invocable: true` à tous les skills
- Standardisation de l'ordre des champs frontmatter
- Conversion allowed-tools en format liste YAML
- Ajout de `context: fork` aux skills manquants

**Améliorations techniques**

- 16 skills mis à jour avec frontmatter standardisé
- Meilleure isolation avec context: fork
- Documentation Subagents et Context

### v3.1.0

**Git Hooks**

- Templates pre-commit et commit-msg
- Checks : ESLint, TypeScript, Prettier, Secrets, Conventional Commits
- Compatible Husky

**DevContainer Templates**

- Configuration VS Code Dev Containers
- Dockerfile avec Node.js 20, Zsh, outils
- docker-compose.yml avec PostgreSQL et Redis

**Skill performance-auditor**

- Audit Core Web Vitals (LCP, INP, CLS)
- Analyse bundle (JS/CSS size, chunks)
- Intégration Lighthouse
- Détection des dépendances lourdes
- Recommandations avec impact quantifié

### v3.0.0

**Skill database-designer**

- Nouveau skill pour concevoir des schémas de base de données
- Génération ERD en ASCII art
- Migrations SQL, Prisma, ou Drizzle
- Stratégie d'indexation automatique
- Support relations 1:1, 1:N, N:M

**Commande /init**

- Scaffolding de projets avec 5 templates
- Next.js, Express, API (Hono), CLI, Library
- Options : --db, --auth, --docker, --ci

**Issue Templates GitHub**

- Templates bug_report.md et feature_request.md
- Configuration config.yml pour liens et options
- Labels automatiques (bug, enhancement)

### v2.9.0

**Skill api-designer**

- Nouveau skill pour concevoir des APIs REST/GraphQL
- Génération de specs OpenAPI 3.1 complètes avec exemples
- Best practices : CRUD, pagination, error handling, versioning
- Rate limiting et deprecation policy

**Commande /metrics**

- Dashboard des métriques projet en ASCII art
- Health Score combinant Coverage, Tests, Docs, Security, Activity
- Mode `--full` pour détails complets
- Mode `--compare <branch>` pour comparaison

**PR Template GitHub**

- Template standard pour Pull Requests
- Sections : Summary, Changes, Type, Testing, Screenshots
- Installation simple vers `.github/`

### v2.8.0

**Security Auditor**

- Nouveau skill `security-auditor` pour audit de sécurité
- Analyse OWASP Top 10, dépendances vulnérables, secrets exposés
- Scoring automatique avec classification par sévérité

**GitHub Actions Templates**

- Templates CI/CD prêts à l'emploi
- ci.yml, release.yml, security.yml, deploy.yml, dependabot.yml
- Support Vercel, Netlify, AWS, Kubernetes

**Commande /changelog**

- Génération automatique de CHANGELOG.md
- Formats : Conventional Commits, Keep a Changelog
- Détection automatique de version (major/minor/patch)

### v2.7.0

**Skill Chaining (Auto-Chain)**

- Chaque skill propose automatiquement le skill suivant après validation
- Transitions intelligentes basées sur le contexte (UX/UI triggers)

**Output Validation**

- Chaque skill valide son output avec une checklist et un score minimum
- Les 12 skills ont maintenant des critères de validation explicites

**RALPH Metrics**

- Tracking automatique du temps par phase
- Comptage des auto-corrections (lint, types, tests)
- Métriques fichiers créés/modifiés

**Commande /resume-ralph**

- Reprendre une session RALPH interrompue
- Options : Continue, Restart, Modify, Abandon

**Knowledge Base Planning**

- `prd-patterns.md` - Patterns PRD par domaine (SaaS, E-commerce, Mobile, API)
- `estimation-techniques.md` - T-shirt sizing, Story points, Three-point
- `risk-assessment.md` - Matrice Probabilité × Impact

**Examples avec code réel**

- 3 exemples (simple-api, blog-nextjs, saas-dashboard) enrichis avec du code complet

### v2.6.0

**Dynamic Context Injection**

- Tous les 12 skills chargent automatiquement le contexte pertinent au démarrage
- Utilisation de la syntaxe `!`shell command`` pour injection dynamique

**Hooks automatiques**

- `code-implementer` : Auto-lint après chaque Edit/Write
- `test-runner` : Affiche coverage après npm test
- `pm-stories` : Vérifie GitHub auth avant create_issue

**Claude Opus partout**

- Tous les skills utilisent `model: opus` pour une intelligence maximale

**Nouvelles commandes utilitaires**

- `/pr-review #123` : Review PR GitHub avec 3 passes
- `/quick-fix "desc"` : Fix rapide sans workflow complet
- `/refactor <file>` : Refactoring ciblé avec review
- `/docs [type]` : Génère documentation (readme|api|guide|all)

**Argument Hints**

- Tous les skills affichent un hint pour guider l'utilisateur

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
