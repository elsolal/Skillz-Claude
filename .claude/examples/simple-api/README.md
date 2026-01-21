# Exemple : Simple API REST

> Projet exemple pour illustrer le workflow D-EPCT+R en mode LIGHT (v2.6)

## Contexte

Une API REST simple pour gérer une liste de tâches (Todo List).
- **Complexité** : LIGHT (< 1 jour)
- **Stack** : Node.js + Express + SQLite

## Fichiers

```
simple-api/
├── README.md           # Ce fichier
├── 01-PRD.md          # Product Requirements Document (LIGHT)
├── 02-STORIES.md      # User Stories
└── 03-IMPLEMENTATION.md # Notes d'implémentation
```

## Workflow utilisé

```bash
# Méthode 1 : Feature directe (recommandé pour projets simples)
/feature "API REST Todo List"

# Méthode 2 : Quick fix pour petits ajustements
/quick-fix "ajouter endpoint DELETE /todos/:id"
```

Pas besoin de `/discovery` complet pour un projet aussi simple.

## Fonctionnalités v2.6 utilisées

| Feature | Usage dans cet exemple |
|---------|------------------------|
| **Mode LIGHT** | PRD simplifié, pas de brainstorm |
| `/quick-fix` | Pour ajouter des endpoints rapidement |
| **Dynamic Context** | Le skill charge automatiquement le PRD |
| **Hook auto-lint** | Lint automatique après chaque modification |

## Commandes utiles v2.6

```bash
# Générer la documentation API
/docs api

# Refactorer un fichier
/refactor src/routes/todos.js

# Vérifier l'état du projet
/status
```
