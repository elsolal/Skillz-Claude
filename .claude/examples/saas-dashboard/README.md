# Exemple : SaaS Dashboard

> Projet exemple pour illustrer le workflow D-EPCT+R complet avec mode RALPH (v2.6)

## Contexte

Dashboard SaaS pour une application de gestion de projets avec authentification,
équipes, et analytics.
- **Complexité** : FULL+ (1-2 semaines)
- **Stack** : Next.js 14 + Supabase + Stripe + Tailwind

## Fichiers

```
saas-dashboard/
├── README.md              # Ce fichier
├── 01-BRAINSTORM.md       # Research-first + Creative
├── 02-UX-DESIGN.md        # Personas et User Journeys (NEW v2.6)
├── 03-PRD.md              # PRD Full détaillé
├── 04-UI-DESIGN.md        # Design Tokens et Composants (NEW v2.6)
├── 05-ARCHITECTURE.md     # Architecture complète avec ADRs
├── 06-STORIES.md          # 3 Epics, 15+ Stories
└── 07-IMPLEMENTATION.md   # Notes avec mode RALPH
```

## Workflow utilisé

```bash
# Mode RALPH pour discovery complet avec verbose
/auto-discovery "Dashboard SaaS pour gestion de projets" --verbose

# Le workflow génère automatiquement :
# - Brainstorm (Research-first)
# - UX Design (Personas: Admin, Manager, Member)
# - PRD Full
# - UI Design (Design tokens, composants)
# - Architecture (ADRs inclus)
# - Stories (15+ avec Readiness Check)

# Mode RALPH pour chaque Epic avec verbose
/auto-feature #epic-1 --max 50 --verbose
/auto-feature #epic-2 --max 50 --verbose
/auto-feature #epic-3 --max 50 --verbose
```

## Particularités de cet exemple

1. **Research-first** : Analyse de la concurrence avant brainstorm
2. **UX/UI Design** : Auto-triggered car 5+ écrans et design system nécessaire
3. **Architecture complexe** : Multi-tenant, Row Level Security
4. **Mode RALPH verbose** : Logs détaillés dans `docs/ralph-logs/`
5. **3 Epics** : Auth, Projects, Billing

## Fonctionnalités v2.6 utilisées

| Feature | Usage dans cet exemple |
|---------|------------------------|
| **UX Designer** | 3 personas, 5 user journeys |
| **UI Designer** | Design tokens, 12 composants spécifiés |
| **Mode --verbose** | Logs détaillés pour debugging |
| **Dynamic Context** | Tous les docs chargés automatiquement |
| **Hook GitHub auth** | Vérifie auth avant création d'issues |
| **Hook auto-lint** | Lint automatique à chaque modification |
| **Hook coverage** | Coverage après chaque test run |

## Commandes utiles v2.6

```bash
# Voir l'état complet du projet
/status

# Review une PR avec les 3 passes
/pr-review #123

# Générer toute la documentation
/docs all

# Quick fix pour hotfix urgent
/quick-fix "corriger le bug de refresh token"

# Refactorer un module
/refactor src/features/auth/
```

## Logs RALPH

Avec `--verbose`, les logs sont sauvegardés dans :
```
docs/ralph-logs/
├── auto-discovery-2024-01-20-143022.md
├── auto-feature-epic-1-2024-01-21-091500.md
├── auto-feature-epic-2-2024-01-22-140000.md
└── auto-feature-epic-3-2024-01-23-100000.md
```
