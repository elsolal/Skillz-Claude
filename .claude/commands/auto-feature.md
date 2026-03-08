---
description: Implémente une feature GitHub en mode RALPH autonome avec multi-agent parallèle (Explore → Plan → Code+Tests // → Review ×3 //).
---

# Auto-Feature - RALPH Mode

**Session ID:** ${CLAUDE_SESSION_ID}

## Mode RALPH + Multi-Agent activé

```
┌──────────────────────────────────────────────────────────────────────────┐
│                     AUTO-FEATURE (RALPH MODE)                           │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  EXPLORE    →  PLAN     →  IMPLEMENT      →  REVIEW         → DONE     │
│  Agent         Plan        ┌─ Code Agent     ┌─ Correctness            │
│  Explore       Mode        └─ Test Agent     ├─ Readability            │
│  (AUTO)       (AUTO)        (PARALLEL)       └─ Performance            │
│                                               (PARALLEL)               │
│  Pas de validation intermédiaire - Full autonome                       │
└──────────────────────────────────────────────────────────────────────────┘
```

## Configuration RALPH

| Paramètre | Valeur |
|-----------|--------|
| Session | `${CLAUDE_SESSION_ID}` |
| Max iterations | **50** |
| Timeout | **2h** |
| Completion promise | **"FEATURE COMPLETE"** |
| Logs | `docs/ralph-logs/${CLAUDE_SESSION_ID}.md` |

## Exécution automatique

### Phase 1: EXPLORE (Agent Explore natif)
- Lire et parser l'issue GitHub
- Lancer Agent Explore pour analyser le codebase
- Identifier fichiers à modifier, patterns, risques

### Phase 2: PLAN (Plan Mode natif)
- Entrer en Plan Mode, créer le plan
- TaskCreate si 2+ étapes
- Valider automatiquement (pas de STOP)

### Phase 3: IMPLEMENT (2 agents parallèles)
- **Agent Code** : Implémenter selon le plan, lint/types obligatoires
- **Agent Tests** : Écrire tests P0-P3, risk-based
- Les 2 agents tournent en parallèle

### Phase 4: REVIEW (3 agents parallèles)
- **Correctness** : Bugs, logique, sécurité
- **Readability** : Nommage, structure, DRY
- **Performance** : Optimisations
- Corriger automatiquement les issues 🔴 Critical

### Phase 5: FINALIZE
- Vérifier tous les tests passent
- Créer un résumé des changements
- Préparer pour PR

## Critères de succès automatiques

Le loop considère la feature "COMPLETE" quand :
- Code implémenté selon le plan
- Tous les tests passent
- 3 passes de review effectuées
- Aucune issue 🔴 Critical restante

## Métriques RALPH

```markdown
## Métriques Feature

| Métrique | Valeur |
|----------|--------|
| **Durée totale** | [X]m [Y]s |
| **Itérations** | [N] / 50 |
| **Issue** | #[NUM] |

### Temps par phase
| Phase | Durée | Status |
|-------|-------|--------|
| Explore | [X]m | ? |
| Plan | [X]m | ? |
| Code + Tests (parallel) | [X]m | ? |
| Review ×3 (parallel) | [X]m | ? |

### Code Metrics
| Métrique | Valeur |
|----------|--------|
| Fichiers créés | [X] |
| Fichiers modifiés | [X] |
| Lignes ajoutées | +[X] |
| Lignes supprimées | -[X] |

### Review Summary
| Pass | Issues trouvées | Issues résolues |
|------|-----------------|-----------------|
| Correctness | [X] | [X] |
| Readability | [X] | [X] |
| Performance | [X] | [X] |
```

## Arrêt manuel

```bash
/cancel-ralph
```

## Arguments supportés

| Argument | Description |
|----------|-------------|
| `#123` | Numéro d'issue GitHub |
| `URL` | URL complète de l'issue |
| `--max N` | Override max iterations (default: 50) |
| `--timeout Xh` | Override timeout (default: 2h) |
| `--verbose` | Mode debug avec logs détaillés |

---

## Démarrage

**Issue à implémenter :** $ARGUMENTS

### Initialisation RALPH

```json
{
  "active": true,
  "iteration": 1,
  "maxIterations": 50,
  "completionPromise": "FEATURE COMPLETE",
  "originalPrompt": "AUTO-FEATURE: Implement $ARGUMENTS using multi-agent workflow",
  "startTime": [TIMESTAMP],
  "timeoutSeconds": 7200,
  "logEnabled": true,
  "sessionId": "${CLAUDE_SESSION_ID}",
  "mode": "auto-feature"
}
```

Je commence par **Phase 1: EXPLORE** — lecture de l'issue et analyse du codebase...
