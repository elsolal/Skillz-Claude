---
name: code-reviewer
description: Effectue une revue de code approfondie en 3 passes successives pour optimiser et améliorer le code. Utiliser après les tests, quand on veut améliorer la qualité du code, ou avant de finaliser une feature.
knowledge:
  quality:
    - ../../knowledge/testing/test-quality.md
    - ../../knowledge/testing/nfr-criteria.md
  risk:
    - ../../knowledge/testing/risk-governance.md
    - ../../knowledge/testing/probability-impact.md
  patterns:
    - ../../knowledge/testing/error-handling.md
    - ../../knowledge/testing/feature-flags.md
---

# Code Reviewer (3 Passes)

## Knowledge Base

**Fichiers de knowledge disponibles dans `../../knowledge/testing/`**

### Quality (charger pour review)
| Fichier | Description |
|---------|-------------|
| `test-quality.md` | Definition of Done, anti-patterns de tests |
| `nfr-criteria.md` | Security, performance, reliability criteria |

### Risk Assessment
| Fichier | Description |
|---------|-------------|
| `risk-governance.md` | Scoring matrix, gate decision rules |
| `probability-impact.md` | Probability/Impact scale definitions |

### Best Practices
| Fichier | Description |
|---------|-------------|
| `error-handling.md` | Exception handling, retry validation |
| `feature-flags.md` | Feature flag governance, cleanup |

## Process

La review se fait en **3 passes obligatoires**, chacune avec un focus différent.
Entre chaque passe : appliquer les corrections, puis passer à la suivante.

## Severity Classification

| Sévérité | Critères | Action |
|----------|----------|--------|
| 🔴 **Critical** | Bugs, failles sécurité, data loss | Fix obligatoire |
| 🟡 **Medium** | Performance, code smells | Fix recommandé |
| 🟢 **Minor** | Style, nommage | Nice-to-have |

---

## Pass 1: Correctness & Logic

**Focus:** Le code fait-il ce qu'il doit faire ?

### Checklist
- [ ] Logique métier correcte
- [ ] Tous les cas gérés (nominal + erreurs)
- [ ] Pas de bugs évidents
- [ ] Types corrects
- [ ] Pas de failles de sécurité

### Questions
- Que se passe-t-il si input null/undefined ?
- Erreurs propagées correctement ?
- Race conditions possibles ?

### Output

```markdown
## Review Pass 1: Correctness

### Issues trouvées
| Sévérité | Fichier | Ligne | Description | Fix |
|----------|---------|-------|-------------|-----|
| 🔴 Critical | ... | ... | ... | ... |
| 🟡 Medium | ... | ... | ... | ... |
| 🟢 Minor | ... | ... | ... | ... |

### Actions avant Pass 2
1. [Fix 1]
2. [Fix 2]
```

**⏸️ STOP** - Appliquer corrections → Validation → Pass 2

---

## Pass 2: Readability & Maintainability

**Focus:** Le code est-il facile à comprendre et maintenir ?

### Checklist
- [ ] Nommage clair et cohérent
- [ ] Fonctions de taille raisonnable
- [ ] Commentaires utiles (pas évidents)
- [ ] Structure logique
- [ ] Pas de code dupliqué
- [ ] Abstractions appropriées

### Questions
- Un nouveau dev comprendrait-il ce code ?
- Noms explicites ?
- Code smells ?

### Output

```markdown
## Review Pass 2: Readability

### Améliorations suggérées
| Type | Fichier | Suggestion | Impact |
|------|---------|------------|--------|
| Naming | ... | Renommer X → Y | Clarté |
| Structure | ... | Extraire fonction | DRY |
| Comments | ... | Ajouter doc | Maintenance |

### Refactoring
1. [Before/After exemple 1]
2. [Before/After exemple 2]
```

**⏸️ STOP** - Appliquer améliorations → Validation → Pass 3

---

## Pass 3: Performance & Optimization

**Focus:** Le code est-il optimal ?

### Checklist
- [ ] Pas d'opérations O(n²) évitables
- [ ] Pas de re-renders inutiles (si frontend)
- [ ] Queries optimisées (si DB)
- [ ] Pas de memory leaks
- [ ] Lazy loading si pertinent
- [ ] Caching si pertinent

### Questions
- Ce code scale-t-il ?
- Calculs redondants ?
- Ressources libérées ?

### Output

```markdown
## Review Pass 3: Performance

### Optimisations
| Type | Impact estimé | Effort | Priorité |
|------|--------------|--------|----------|
| [Optim 1] | -Xms latence | Low | P1 |
| [Optim 2] | -X% memory | Medium | P2 |

### Code optimisé
[Before/After pour chaque optimisation]
```

**⏸️ STOP** - Appliquer optimisations → Validation finale

---

## Résumé Final

```markdown
## ✅ Code Review Complete

### Métriques
- Issues critiques: X (toutes résolues)
- Refactoring: X appliqués
- Optimisations: X faites

### Changements
- Fichiers modifiés: X
- Lignes: +X / -X

### Qualité finale
- Correctness: ✅
- Readability: ✅
- Performance: ✅

### Prêt pour merge: ✅
```
