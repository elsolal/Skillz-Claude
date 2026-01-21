---
description: Refactoring ciblé avec les 3 passes de review. Améliore la qualité du code sans changer le comportement. Usage: /refactor <file-or-pattern> [--scope function|file|module]
---

# Refactor

**Session ID:** ${CLAUDE_SESSION_ID}

## 📥 Contexte refactoring chargé automatiquement

### Cible du refactoring : $ARGUMENTS
!`cat $ARGUMENTS 2>/dev/null | head -100 || echo "Fichier non trouvé, je vais chercher..."`

### Tests existants pour cette cible
!`find . -name "*.test.*" -o -name "*.spec.*" | xargs grep -l "$ARGUMENTS" 2>/dev/null | head -5 || echo "Pas de tests trouvés pour cette cible"`

### Dépendances de ce fichier
!`grep -r "from.*$ARGUMENTS\|import.*$ARGUMENTS" --include="*.ts" --include="*.tsx" --include="*.js" 2>/dev/null | head -10 || echo "Pas de dépendances trouvées"`

### État lint/types actuel
!`npm run lint -- $ARGUMENTS 2>&1 | tail -15 || npm run typecheck 2>&1 | grep "$ARGUMENTS" | head -10 || echo "Lint OK ou non configuré"`

---

## Mode Refactoring activé

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                            REFACTORING MODE                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  🎯 Objectif : Améliorer la qualité SANS changer le comportement            │
│                                                                             │
│  Scope :                                                                    │
│  ├── function : Une seule fonction                                          │
│  ├── file     : Un fichier entier                                          │
│  └── module   : Un module/dossier complet                                  │
│                                                                             │
│  Process :                                                                  │
│  1. Analyse du code existant                                               │
│  2. Identification des améliorations                                        │
│  3. Refactoring avec les 3 passes                                          │
│  4. Validation (tests doivent passer)                                       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Principes de refactoring

### SOLID
- **S**ingle Responsibility - Une classe/fonction = une responsabilité
- **O**pen/Closed - Ouvert à l'extension, fermé à la modification
- **L**iskov Substitution - Les sous-types sont substituables
- **I**nterface Segregation - Interfaces spécifiques > interfaces générales
- **D**ependency Inversion - Dépendre des abstractions

### Code Smells à éliminer
| Smell | Symptôme | Refactoring |
|-------|----------|-------------|
| Long Method | > 20 lignes | Extract Method |
| Large Class | > 200 lignes | Extract Class |
| Duplicate Code | Copier-coller | Extract Method/Class |
| Long Parameter List | > 3 params | Introduce Parameter Object |
| Feature Envy | Utilise trop d'une autre classe | Move Method |
| Data Clumps | Données toujours ensemble | Extract Class |

---

## Process

### 1. Analyse
- Comprendre le code existant
- Identifier les tests existants
- Repérer les code smells

### 2. Plan de refactoring
| # | Smell | Location | Refactoring | Risk |
|---|-------|----------|-------------|------|
| 1 | [smell] | [line] | [action] | Low/Med/High |

**⏸️ STOP** - Validation du plan avant exécution

### 3. Exécution (3 passes)

#### Pass 1: Correctness
- Le refactoring ne change pas le comportement
- Tous les tests passent encore

#### Pass 2: Readability
- Nommage amélioré
- Structure clarifiée
- Commentaires utiles ajoutés

#### Pass 3: Performance
- Optimisations si pertinent
- Suppression du code mort

### 4. Validation finale
```bash
npm run lint && npm run typecheck && npm test
```

---

## Règles de refactoring

- ⛔ **JAMAIS changer le comportement** - Les tests doivent passer avant ET après
- ⛔ **Pas de refactoring sans tests** - Si pas de tests, les écrire d'abord
- ✅ **Petits pas** - Commit après chaque refactoring atomique
- ✅ **Un seul type de refactoring à la fois** - Rename OU Extract, pas les deux

---

## Output

```markdown
## Refactoring: [Cible]

### Avant/Après

#### Code smell: [Nom]
**Avant:**
\`\`\`typescript
// Code original
\`\`\`

**Après:**
\`\`\`typescript
// Code refactoré
\`\`\`

### Améliorations appliquées
| # | Type | Description | Impact |
|---|------|-------------|--------|
| 1 | Extract Method | [desc] | Readability |
| 2 | Rename | [desc] | Clarity |

### Métriques
- Lignes avant : X
- Lignes après : Y
- Complexité cyclomatique : X → Y

### Validation
- Lint: ✅
- Types: ✅
- Tests: ✅ (X tests, tous passent)

### Commits suggérés
refactor(scope): extract [function] for better readability
refactor(scope): rename [old] to [new] for clarity
```

---

## Démarrage

**Cible du refactoring :** $ARGUMENTS

J'analyse le code pour identifier les améliorations possibles...
