---
description: Review une Pull Request GitHub avec 3 subagents parallèles (Correctness, Readability, Performance). Usage: /pr-review #123 ou URL.
---

# PR Review (Multi-Agent)

**PR demandée : $ARGUMENTS**

## Chargement du contexte

1. `gh pr view $ARGUMENTS --json number,title,body,state,author,files,reviews`
2. `gh pr diff $ARGUMENTS --name-only` (fichiers modifiés)
3. `gh pr diff $ARGUMENTS` (diff complet)

---

## Review parallèle (3 subagents)

Dispatcher **3 subagents en parallèle** via `SendMessage` dans un seul message :

### Subagent 1 : Correctness
```
SendMessage(run_in_background: true)
Prompt: "Tu es un reviewer expert en correctness. Review cette PR.

Diff fourni : [diff]

**Focus CORRECTNESS :**
- Logique métier correcte
- Edge cases gérés (null, undefined, empty, boundary)
- Pas de bugs, race conditions, data loss
- Types corrects
- Failles de sécurité (injection, XSS, auth bypass)
- Tests couvrent les changements

Classifie chaque issue : 🔴 Critical | 🟡 Medium | 🟢 Minor
Output : table Sévérité | Fichier | Ligne | Issue | Suggestion

Knowledge: .claude/knowledge/testing/error-handling.md, risk-governance.md, probability-impact.md"
```

### Subagent 2 : Readability
```
SendMessage(run_in_background: true)
Prompt: "Tu es un reviewer expert en lisibilité. Review cette PR.

Diff fourni : [diff]

**Focus READABILITY :**
- Nommage clair et cohérent
- Fonctions de taille raisonnable
- Commentaires utiles (logique complexe uniquement)
- Structure logique, early return
- Pas de code dupliqué (DRY)
- Abstractions appropriées

Output : table Type | Fichier | Suggestion | Impact

Knowledge: .claude/knowledge/testing/test-quality.md, nfr-criteria.md"
```

### Subagent 3 : Performance
```
SendMessage(run_in_background: true)
Prompt: "Tu es un reviewer expert en performance. Review cette PR.

Diff fourni : [diff]

**Focus PERFORMANCE :**
- O(n²) évitables
- Re-renders inutiles (si frontend)
- Queries optimisées (si DB) — N+1, missing indexes
- Memory leaks (event listeners, subscriptions)
- Lazy loading si pertinent
- Caching si pertinent

Output : table Type | Impact | Effort | Suggestion

Knowledge: .claude/knowledge/testing/nfr-criteria.md"
```

---

## Synthèse

Après les 3 subagents, produire le rapport consolidé :

```markdown
## PR Review: #[NUM] - [Titre]

### Résumé
- **Status**: Approved | Changes Requested | Blocked
- **Files reviewed**: X
- **Issues found**: X critical, X medium, X minor

### Pass 1: Correctness
| Sévérité | Fichier | Ligne | Issue | Suggestion |
|----------|---------|-------|-------|------------|

### Pass 2: Readability
| Type | Fichier | Suggestion |
|------|---------|------------|

### Pass 3: Performance
| Type | Impact | Effort | Suggestion |
|------|--------|--------|------------|

### Verdict
[Commentaire global et recommandation]
```

---

## Démarrage

**PR à reviewer :** $ARGUMENTS

Je récupère les infos de la PR puis lance les 3 subagents review en parallèle...
