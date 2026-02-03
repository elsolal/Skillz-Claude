---
description: Review une Pull Request GitHub avec les 3 passes (Correctness, Readability, Performance). Usage: /pr-review #123 ou /pr-review https://github.com/owner/repo/pull/123
---

# PR Review

**Session ID:** ${CLAUDE_SESSION_ID}

## 📥 Contexte à charger

**PR demandée : $ARGUMENTS**

| Contexte | Action | Priorité |
|----------|--------|----------|
| Détails PR | `Bash: gh pr view $ARGUMENTS --json number,title,body,state,author,files,reviews` | Requis |
| Fichiers modifiés | `Bash: gh pr diff $ARGUMENTS --name-only` | Requis |
| Diff complet | `Bash: gh pr diff $ARGUMENTS` (200 premières lignes) | Requis |

### Instructions de chargement
1. Utiliser `gh pr view` pour récupérer les métadonnées de la PR
2. Lister les fichiers modifiés avec `gh pr diff --name-only`
3. Obtenir le diff complet pour l'analyse
4. Si `gh` CLI non configuré, demander l'URL de la PR

---

## Mode Review PR activé

Je vais effectuer une review complète de la PR en **3 passes** :

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           PR REVIEW (3 PASSES)                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Pass 1: CORRECTNESS                                                        │
│  - Le code fait-il ce qu'il doit faire ?                                    │
│  - Bugs, edge cases, sécurité                                               │
│                                                                             │
│  Pass 2: READABILITY                                                        │
│  - Le code est-il facile à comprendre ?                                     │
│  - Nommage, structure, DRY                                                  │
│                                                                             │
│  Pass 3: PERFORMANCE                                                        │
│  - Le code est-il optimal ?                                                 │
│  - N+1 queries, re-renders, memory leaks                                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Classification des issues

| Sévérité | Critères | Action |
|----------|----------|--------|
| 🔴 **Critical** | Bugs, failles sécurité, data loss | Bloquer la PR |
| 🟡 **Medium** | Performance, code smells | Demander correction |
| 🟢 **Minor** | Style, nommage | Suggestion |

---

## Process

### Pass 1: Correctness

Je vérifie :
- [ ] Logique métier correcte
- [ ] Tous les edge cases gérés
- [ ] Pas de bugs évidents
- [ ] Types corrects
- [ ] Pas de failles de sécurité
- [ ] Tests couvrent les changements

**⏸️ STOP** - Présenter les issues Pass 1 → Correction → Pass 2

---

### Pass 2: Readability

Je vérifie :
- [ ] Nommage clair et cohérent
- [ ] Fonctions de taille raisonnable
- [ ] Commentaires utiles (pas évidents)
- [ ] Structure logique
- [ ] Pas de code dupliqué
- [ ] Abstractions appropriées

**⏸️ STOP** - Présenter les suggestions Pass 2 → Amélioration → Pass 3

---

### Pass 3: Performance

Je vérifie :
- [ ] Pas d'opérations O(n²) évitables
- [ ] Pas de re-renders inutiles (si frontend)
- [ ] Queries optimisées (si DB)
- [ ] Pas de memory leaks
- [ ] Lazy loading si pertinent

---

## Output Final

```markdown
## PR Review: #[NUM] - [Titre]

### Résumé
- **Status**: ✅ Approved / ⚠️ Changes Requested / ❌ Blocked
- **Files reviewed**: X
- **Issues found**: X critical, X medium, X minor

### Pass 1: Correctness
| Sévérité | Fichier | Ligne | Issue | Suggestion |
|----------|---------|-------|-------|------------|
| [emoji] | [file] | [line] | [desc] | [fix] |

### Pass 2: Readability
| Type | Fichier | Suggestion |
|------|---------|------------|
| [type] | [file] | [suggestion] |

### Pass 3: Performance
| Type | Impact | Effort | Suggestion |
|------|--------|--------|------------|
| [type] | [impact] | [effort] | [suggestion] |

### Verdict
[Commentaire global et recommandation]
```

---

## Démarrage

**PR à reviewer :** $ARGUMENTS

Je commence l'analyse de la PR...
