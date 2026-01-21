---
description: Implémente une feature GitHub en mode RALPH autonome (Explain → Plan → Code → Test → Review ×3). L'IA travaille seule jusqu'à ce que tout soit terminé et testé.
---

# Auto-Feature - RALPH Mode 🔄

**Session ID:** ${CLAUDE_SESSION_ID}

## Mode RALPH + Implémentation activé

Je vais exécuter **tout le workflow de développement en autonome** :

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     AUTO-FEATURE (RALPH MODE)                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  🔍 Explain ──→ 📝 Plan ──→ 💻 Code ──→ 🧪 Test ──→ 🔄 Review ×3            │
│      AUTO         AUTO        AUTO        AUTO         AUTO                 │
│                                                                             │
│  ⚠️ Pas de validation intermédiaire - Full autonome                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Configuration RALPH

| Paramètre | Valeur |
|-----------|--------|
| Session | `${CLAUDE_SESSION_ID}` |
| Max iterations | **50** (dev = beaucoup d'itérations possibles) |
| Timeout | **2h** |
| Completion promise | **"FEATURE COMPLETE"** |
| Logs | `docs/ralph-logs/${CLAUDE_SESSION_ID}.md` |
| Verbose | OFF (use `--verbose` to enable) |

## Ce que je vais faire automatiquement

### Phase 1: EXPLAIN 🔍
- Lire et parser l'issue GitHub
- Analyser le codebase existant
- Identifier les fichiers à modifier
- Comprendre les patterns en place

### Phase 2: PLAN 📝
- Décomposer en étapes atomiques
- Définir l'ordre d'implémentation
- Identifier les risques

### Phase 3: CODE 💻
- Implémenter étape par étape
- Respecter les conventions du projet
- Commiter régulièrement

### Phase 4: TEST 🧪
- Écrire les tests unitaires
- Écrire les tests d'intégration
- S'assurer que tout passe

### Phase 5: REVIEW ×3 🔄
- **Pass 1**: Correctness - Bugs, logique, sécurité
- **Pass 2**: Readability - Nommage, structure, DRY
- **Pass 3**: Performance - Optimisations

### Phase 6: Finalisation
- Vérifier que tous les tests passent
- Créer un résumé des changements
- Préparer pour PR

## Critères de succès automatiques

Le loop considère la feature "COMPLETE" quand :
- ✅ Code implémenté selon le plan
- ✅ Tous les tests passent
- ✅ 3 passes de review effectuées
- ✅ Aucune issue critique restante

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

## Exemples

```bash
# Par numéro
/auto-feature #123

# Par URL
/auto-feature https://github.com/owner/repo/issues/123

# Avec options
/auto-feature #123 --max 100 --timeout 4h

# Mode verbose (debug)
/auto-feature #123 --verbose
```

---

## Démarrage 🚀

**Issue à implémenter :** $ARGUMENTS

### Initialisation RALPH

```json
{
  "active": true,
  "iteration": 1,
  "maxIterations": 50,
  "completionPromise": "FEATURE COMPLETE",
  "originalPrompt": "AUTO-FEATURE: Implement $ARGUMENTS following the full EPCT+R workflow",
  "startTime": [TIMESTAMP],
  "timeoutSeconds": 7200,
  "logEnabled": true,
  "sessionId": "${CLAUDE_SESSION_ID}",
  "mode": "auto-feature"
}
```

**🚀 Auto-Feature démarré - Mode RALPH**

Je commence par lire l'issue : **$ARGUMENTS**

---

## Phase 1: EXPLAIN

Je vais d'abord récupérer et analyser l'issue GitHub...
