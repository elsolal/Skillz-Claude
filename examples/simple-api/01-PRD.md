# PRD Light - API REST Todo List

**Date:** 2025-01-20
**Mode:** LIGHT
**Durée estimée:** 4 heures

---

## 1. Problème

Les développeurs ont besoin d'un exemple simple d'API REST pour apprendre ou prototyper rapidement.

## 2. Solution

API CRUD minimaliste pour gérer des tâches (todos).

## 3. Scope

### In Scope
- CRUD complet (Create, Read, Update, Delete)
- Persistance SQLite
- Validation des inputs
- Gestion d'erreurs basique

### Out of Scope
- Authentification
- Multi-utilisateurs
- Interface web

## 4. Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/todos` | Liste toutes les tâches |
| GET | `/todos/:id` | Récupère une tâche |
| POST | `/todos` | Crée une tâche |
| PUT | `/todos/:id` | Met à jour une tâche |
| DELETE | `/todos/:id` | Supprime une tâche |

## 5. Data Model

```typescript
interface Todo {
  id: number;
  title: string;
  completed: boolean;
  createdAt: string;
  updatedAt: string;
}
```

## 6. Critères de succès

- [ ] Tous les endpoints fonctionnent
- [ ] Tests passent (unit + integration)
- [ ] Documentation API générée
