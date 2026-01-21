# Exemple : Blog Next.js

> Projet exemple pour illustrer le workflow D-EPCT+R en mode FULL (v2.6)

## Contexte

Un blog personnel avec Next.js, MDX pour le contenu, et un système de tags.
- **Complexité** : FULL (3-5 jours)
- **Stack** : Next.js 14 + MDX + Tailwind CSS + Vercel

## Fichiers

```
blog-nextjs/
├── README.md              # Ce fichier
├── 01-BRAINSTORM.md       # Session de brainstorming
├── 02-UX-DESIGN.md        # Personas et User Journeys (NEW v2.6)
├── 03-PRD.md              # Product Requirements Document (FULL)
├── 04-ARCHITECTURE.md     # Architecture technique
├── 05-STORIES.md          # Epics et User Stories
└── 06-IMPLEMENTATION.md   # Notes d'implémentation
```

## Workflow utilisé

```bash
# Discovery complet avec validation à chaque étape
/discovery "Blog personnel avec Next.js et MDX"

# Le workflow propose automatiquement UX Design (score 4/5)
# → Personas + User Journeys générés
```

Mode FULL détecté automatiquement (score 4/5) :
- 3+ features distinctes ✅
- Architecture multi-composants ✅
- 3+ pages UI ✅
- Estimation > 1 jour ✅

## Fonctionnalités v2.6 utilisées

| Feature | Usage dans cet exemple |
|---------|------------------------|
| **UX Designer** | Personas lecteur/auteur, journey de lecture |
| **Dynamic Context** | PRD et Architecture chargés automatiquement |
| **Hook coverage** | Coverage affichée après chaque test |
| **Argument hints** | `/test-runner src/` guidé par le hint |

## Commandes utiles v2.6

```bash
# Review une PR
/pr-review #42

# Générer toute la documentation
/docs all

# Refactorer les composants
/refactor src/components/

# Voir l'état du projet
/status
```
