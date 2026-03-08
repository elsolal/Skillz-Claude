<!-- PROJECT-RULES-START -->
# Project Rules

> **Cette section est préservée lors des updates.** Ajoutez vos règles projet ici.

<!-- PROJECT-RULES-END -->

---

# D-EPCT+R v4.0 — Instructions de travail

## Quel workflow utiliser ?

```
Utilisateur dit...                    → Workflow
─────────────────────────────────────────────────
"j'ai une idée / on pourrait..."      → /discovery (ou /auto-discovery)
"implémente l'issue #XX"              → /feature #XX (ou /auto-feature #XX)
"fix ce bug / ce truc est cassé"      → /quick-fix "desc"
"refactorise ce fichier"              → /refactor <file>
"review cette PR"                     → /pr-review #123
"génère la doc"                       → /docs [type]
"crée un nouveau projet"              → /init [template]
"importe ce design Figma"             → /figma-to-code <url>
"design ça dans Figma"                → skill figma-designer
"crée/audite le design system"        → skill figma-design-system
"le composant est différent en prod"  → skill figma-design-code-sync
```

### Discovery (planning)

Mode FULL (gros scope) : `Brainstorm → [UX] → PRD → [UI] → Architecture → Stories → GitHub`
Mode LIGHT (petit scope) : `PRD simplifié → Stories → GitHub`

Le mode est auto-détecté. UX/UI sont optionnels et auto-triggered si pertinent.

### Feature (développement multi-agent)

```
EXPLORE (Agent Explore) → PLAN (Plan Mode) → IMPLEMENT (2 agents //) → REVIEW (3 agents //) → FINALIZE
```

Les phases Code+Tests et Review ×3 tournent en **agents parallèles** pour aller plus vite.

### Mode RALPH (autonome)

Préfixer avec `auto-` : `/auto-loop`, `/auto-discovery`, `/auto-feature`.
Options : `--max N`, `--timeout Xh`, `--promise "TEXT"`
Logger chaque itération dans `docs/ralph-logs/`.

---

## Commandes

```bash
# Planning
/discovery                  # Planning complet (validation à chaque étape)
/auto-discovery "idée"      # Planning autonome

# Développement
/feature [issue]            # Implémentation multi-agent guidée
/auto-feature #123          # Implémentation multi-agent autonome
/quick-fix "desc"           # Fix rapide sans workflow
/refactor <file>            # Refactoring ciblé

# Utilitaires
/status                     # État du projet
/pr-review #123             # Review PR (3 agents parallèles)
/docs [type]                # Documentation (readme|api|guide|all)
/changelog [version]        # CHANGELOG.md
/metrics                    # Dashboard métriques
/init [template]            # Scaffolding (next|express|api|cli|lib)

# Design (nécessite Figma Console MCP pour designer/figma-design-system)
/figma-setup [url]          # Configure Code Connect
/figma-to-code <url>        # Figma → Code
# Skills auto-triggered :
# figma-designer            # Claude crée des designs dans Figma
# figma-design-system       # Gestion DS (tokens, audit, code→Figma)
# figma-design-code-sync    # Sync bidirectionnelle composants

# Sécurité
/supabase-security <url>    # Audit Supabase

# RALPH
/auto-loop "prompt"         # Boucle autonome générique
/cancel-ralph               # Arrêter RALPH
/resume-ralph [session-id]  # Reprendre une session
```

---

## Règles non-négociables

### Toujours

- Explorer le codebase AVANT de planifier (Agent Explore natif)
- Planifier AVANT de coder (sauf fix trivial) — utiliser Plan Mode natif
- Valider le plan avec l'utilisateur en mode manuel
- Utiliser TaskCreate si 2+ étapes d'implémentation
- Lint + types OK à chaque étape de code
- 3 passes de review : Correctness → Readability → Performance

### Jamais

- Commit/push directement sur main — toujours branche + PR
- Committer sans tests qui passent
- Merger sans les 3 passes de review
- Enchaîner les skills sans validation en mode manuel
- Coder sans avoir compris l'existant

---

## Conventions

### Commits

```
type(scope): description courte

Refs: #XX
```

Types : `feat`, `fix`, `refactor`, `test`, `docs`, `chore`

### Branches

```
feature/[issue-number]-description-courte
fix/[issue-number]-description-courte
```

### PRs

- Lier à l'issue : `Closes #XX`
- Description claire + screenshots si UI

### Output docs

| Type | Emplacement |
|------|-------------|
| Planning (brainstorms, PRD, archi, UX, UI) | `docs/planning/` |
| Stories | `docs/stories/EPIC-{num}-{slug}/` |
| Logs RALPH | `docs/ralph-logs/` |

---

## Principes

- **KISS / DRY / YAGNI** — simplicité, pas d'over-engineering
- **Tests** : risk-based, P0-P3, déterministes, ATDD quand possible
- **Préférer la simplicité** à la complexité
