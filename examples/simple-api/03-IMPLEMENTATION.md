# Notes d'implémentation - API REST Todo List

## Structure finale

```
src/
├── index.ts           # Entry point
├── routes/
│   └── todos.ts       # Routes CRUD
├── db/
│   └── sqlite.ts      # Connexion SQLite
├── models/
│   └── todo.ts        # Type Todo
└── middleware/
    └── validation.ts  # Validation inputs

tests/
├── unit/
│   └── todo.test.ts
└── integration/
    └── api.test.ts
```

## Commandes utilisées

```bash
# Explain
/feature #1

# Plan validé, puis Code
# Lint ✅ Types ✅ à chaque étape

# Tests
npm test  # 12 tests, 100% pass

# Review (3 passes)
# Pass 1: Correctness ✅
# Pass 2: Readability ✅
# Pass 3: Performance ✅
```

## Leçons apprises

1. **SQLite** : Utiliser `better-sqlite3` pour la simplicité (sync)
2. **Validation** : `zod` est overkill pour ce projet, validation manuelle suffit
3. **Tests** : Vitest + supertest pour les tests d'intégration API

## Temps réel

| Phase | Estimé | Réel |
|-------|--------|------|
| PRD | 15min | 10min |
| Stories | 30min | 25min |
| Code | 2h | 2h30 |
| Tests | 1h | 45min |
| Review | 30min | 20min |
| **Total** | **4h15** | **4h10** |
