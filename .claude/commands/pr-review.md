---
description: Review une Pull Request GitHub avec 3 agents parallèles (Correctness, Readability, Performance). Usage: /pr-review #123 ou URL.
---

# PR Review (Multi-Agent)

**PR demandée : $ARGUMENTS**

## Chargement du contexte

1. `gh pr view $ARGUMENTS --json number,title,body,state,author,files,reviews`
2. `gh pr diff $ARGUMENTS --name-only` (fichiers modifiés)
3. `gh pr diff $ARGUMENTS` (diff complet)

---

## Review parallèle (3 agents)

Lancer **3 agents en parallèle** dans un seul message :

### Agent 1 : Correctness
```
Agent(subagent_type: "general-purpose")
Prompt: "Review PR - Pass CORRECTNESS.
Diff fourni : [diff]
Vérifie : logique métier, edge cases, bugs, types, failles sécurité, tests couvrent les changements.
Classifie chaque issue : 🔴 Critical | 🟡 Medium | 🟢 Minor
Knowledge: .claude/knowledge/testing/error-handling.md, risk-governance.md, probability-impact.md
Output : table Sévérité | Fichier | Ligne | Issue | Suggestion"
```

### Agent 2 : Readability
```
Agent(subagent_type: "general-purpose")
Prompt: "Review PR - Pass READABILITY.
Diff fourni : [diff]
Vérifie : nommage clair, fonctions raisonnables, commentaires utiles, structure logique, DRY, abstractions.
Knowledge: .claude/knowledge/testing/test-quality.md, nfr-criteria.md
Output : table Type | Fichier | Suggestion | Impact"
```

### Agent 3 : Performance
```
Agent(subagent_type: "general-purpose")
Prompt: "Review PR - Pass PERFORMANCE.
Diff fourni : [diff]
Vérifie : O(n²) évitables, re-renders, queries optimisées, memory leaks, lazy loading.
Knowledge: .claude/knowledge/testing/nfr-criteria.md
Output : table Type | Impact | Effort | Suggestion"
```

---

## Synthèse

Après les 3 agents, produire le rapport consolidé :

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

Je récupère les infos de la PR puis lance les 3 agents review en parallèle...
