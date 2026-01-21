---
description: Fix rapide sans passer par tout le workflow EPCT+R. Pour les petits bugs, typos, et corrections mineures. Usage: /quick-fix "description du problème"
---

# Quick Fix

**Session ID:** ${CLAUDE_SESSION_ID}

## 📥 Contexte projet chargé automatiquement

### État git actuel
!`git status --short 2>/dev/null | head -10 || echo "Pas de repo git"`

### Fichiers modifiés récemment
!`git diff --name-only HEAD~3 2>/dev/null | head -10 || echo "Pas de commits récents"`

### Erreurs lint/types actuelles
!`npm run lint 2>&1 | grep -E "error|warning" | head -10 || npm run typecheck 2>&1 | grep -E "error" | head -10 || echo "Pas d'erreurs détectées"`

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
