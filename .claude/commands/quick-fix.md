---
description: Fix rapide sans passer par tout le workflow EPCT+R. Pour les petits bugs, typos, et corrections mineures. Usage: /quick-fix "description du problème"
---

# Quick Fix

**Session ID:** ${CLAUDE_SESSION_ID}

## 📥 Contexte à charger

**Identifier rapidement le problème à corriger.**

| Contexte | Action | Priorité |
|----------|--------|----------|
| État git | `Bash: git status --short` | Optionnel |
| Fichiers récents | `Bash: git diff --name-only HEAD~3` | Optionnel |
| Erreurs lint/types | `Bash: npm run lint` et `npm run typecheck` | Optionnel |

### Instructions de chargement
1. Vérifier l'état git actuel
2. Identifier les erreurs lint/types existantes
3. Localiser rapidement le fichier concerné

---

## Mode Quick Fix activé

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              QUICK FIX MODE                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  🎯 Objectif : Fix rapide, sans overhead                                    │
│                                                                             │
│  ✅ Pour :                                                                  │
│     - Typos et erreurs de frappe                                            │
│     - Petits bugs évidents                                                  │
│     - Ajustements mineurs                                                   │
│     - Corrections de lint/types                                             │
│                                                                             │
│  ❌ Pas pour :                                                              │
│     - Nouvelles features (utiliser /feature)                                │
│     - Refactoring important (utiliser /refactor)                            │
│     - Changements architecturaux                                            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Process simplifié

### 1. Analyse rapide
- Identifier le problème
- Localiser le(s) fichier(s) concerné(s)
- Évaluer l'impact

### 2. Fix
- Appliquer la correction
- Vérifier lint/types

### 3. Validation
```bash
npm run lint && npm run typecheck && npm test
```

---

## Règles Quick Fix

- ⛔ **Max 3 fichiers** - Si plus, utiliser `/feature`
- ⛔ **Max 50 lignes modifiées** - Si plus, utiliser `/feature`
- ⛔ **Pas de nouvelle dépendance** - Si besoin, utiliser `/feature`
- ✅ **Toujours vérifier lint/types** après le fix
- ✅ **Commit atomique** avec message clair

---

## Output

```markdown
## Quick Fix: [Description courte]

### Problème
[Description du problème]

### Solution
[Ce qui a été fait]

### Fichiers modifiés
- `path/to/file.ts` - [Description]

### Vérifications
- Lint: ✅/❌
- Types: ✅/❌
- Tests: ✅/❌

### Commit suggéré
fix(scope): [description courte]
```

---

## Démarrage

**Problème à fixer :** $ARGUMENTS

Je localise et corrige le problème...
