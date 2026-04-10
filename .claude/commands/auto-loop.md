---
description: Lance Claude en mode RALPH (boucle autonome) jusqu'à complétion de la tâche. Usage: /auto-loop "prompt" [--max N] [--timeout Xh] [--promise "TEXT"]
---

# RALPH Mode - Autonomous Loop

## Mode activé : RALPH 🔄

**Session ID:** ${CLAUDE_SESSION_ID}

Je vais travailler en **boucle autonome** jusqu'à complétion de ta tâche.

## Configuration

```
┌─────────────────────────────────────────────────────────────────┐
│                    RALPH LOOP ACTIVE                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  🆔 Session      : ${CLAUDE_SESSION_ID}                         │
│  📋 Tâche        : $ARGUMENTS                                   │
│  🔄 Max iterations: 20 (default)                                │
│  ⏱️  Timeout      : 1h (default)                                 │
│  ✅ Promise      : "DONE" (default)                             │
│  📝 Logs         : docs/ralph-logs/${CLAUDE_SESSION_ID}.md      │
│  🔍 Verbose      : OFF (use --verbose to enable)                │
│                                                                 │
│  ⚠️  Dangerous permissions: ENABLED                             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## Comment ça marche

```
   Prompt
     ↓
┌─────────────┐
│   Claude    │←──────────────────┐
│   travaille │                   │
└─────────────┘                   │
     ↓                            │
   Veut s'arrêter                 │
     ↓                            │
┌─────────────┐                   │
│  Stop Hook  │                   │
│  vérifie    │                   │
└─────────────┘                   │
     ↓                            │
   Promise trouvée ?              │
     │                            │
     ├─ NON ──→ Réinjecte prompt ─┘
     │
     └─ OUI ──→ Arrêt ✅
```

## Conditions d'arrêt

Le loop s'arrête quand :
1. ✅ **Completion promise** trouvée dans ma réponse
2. 🔢 **Max iterations** atteint
3. ⏱️ **Timeout** dépassé

## Quand utiliser /auto-loop vs /loop vs /schedule

| | RALPH (`/auto-loop`) | `/loop` (natif) | `/schedule` (cloud) |
|---|---|---|---|
| **Mécanisme** | Stop hook — empêche Claude de s'arrêter tant que la promise n'est pas trouvée | Session scheduler — relance un prompt toutes les X min | Cron cloud — tourne sur l'infra Anthropic |
| **Durée de vie** | Jusqu'à completion, max iterations, ou timeout | Meurt quand Claude Code ferme | Survit au laptop fermé, tourne 24/7 |
| **Accès local** | ✅ Fichiers non commités, état local du checkout | ✅ Session courante | ❌ Clone frais du repo (état GitHub uniquement) |
| **Best for** | Implémenter une feature complète, refactoring profond, migration | Monitoring : vérifier un deploy, watcher CI, polling | Récurrent non-local : audit quotidien, PR review, doc sync, triage CI |
| **Métriques/Logs** | ✅ Logs structurés dans `docs/ralph-logs/` | ❌ Pas de logging natif | ✅ Logs sur le web Anthropic |

**Règle simple :**
- "Continue jusqu'à done" → **RALPH** (`/auto-loop`)
- "Vérifie toutes les X minutes" → **`/loop`**
- "Fais ça tous les jours à 8h, même si je dors" → **`/schedule`**

## Arguments supportés

| Argument | Default | Description |
|----------|---------|-------------|
| `--max N` | 20 | Nombre max d'itérations |
| `--timeout Xh` | 1h | Timeout global (1h, 2h, 30m) |
| `--promise "TEXT"` | "DONE" | Texte de complétion |
| `--no-log` | false | Désactiver les logs |
| `--verbose` | false | Mode debug avec logs détaillés |

## Exemples

```bash
# Simple
/auto-loop "Implémente les tests pour le module auth"

# Avec options
/auto-loop "Refactor le composant Button" --max 30 --promise "REFACTOR COMPLETE"

# Long running
/auto-loop "Migre la base de données vers le nouveau schéma" --max 50 --timeout 2h

# Mode verbose (debug)
/auto-loop "Debug le problème de performance" --verbose
```

## Métriques RALPH

Le log inclut automatiquement les métriques suivantes :

```markdown
## 📊 Métriques Session

| Métrique | Valeur |
|----------|--------|
| **Durée totale** | [X]m [Y]s |
| **Itérations** | [N] / [Max] |
| **Phases** | [Liste des phases traversées] |

### Temps par phase
| Phase | Durée | % Total |
|-------|-------|---------|
| [Phase 1] | [X]m | [Y]% |
| [Phase 2] | [X]m | [Y]% |

### Auto-corrections
| Type | Count |
|------|-------|
| Lint errors corrigés | [X] |
| Type errors corrigés | [X] |
| Tests fixés | [X] |
| Retours arrière | [X] |

### Fichiers
| Métrique | Valeur |
|----------|--------|
| Fichiers créés | [X] |
| Fichiers modifiés | [X] |
| Lignes ajoutées | +[X] |
| Lignes supprimées | -[X] |
```

---

## Initialisation

Je vais maintenant :
1. ✅ Créer le fichier de configuration `.claude/ralph-state.json`
2. ✅ Activer le mode RALPH
3. 📊 Initialiser le tracking des métriques
4. 🚀 Commencer à travailler sur ta tâche

---

**⚠️ IMPORTANT** : Pour arrêter manuellement, utilise `/cancel-ralph`

---

## Démarrage

**Tâche à accomplir :** $ARGUMENTS

Je commence maintenant. Quand j'aurai terminé, j'inclurai "DONE" dans ma réponse pour signaler la complétion.

---

### Initialisation RALPH

```json
{
  "active": true,
  "iteration": 1,
  "maxIterations": 20,
  "completionPromise": "DONE",
  "originalPrompt": "$ARGUMENTS",
  "startTime": [TIMESTAMP],
  "timeoutSeconds": 3600,
  "logEnabled": true,
  "sessionId": "${CLAUDE_SESSION_ID}"
}
```

Création du fichier de configuration et log dans `docs/ralph-logs/${CLAUDE_SESSION_ID}.md`...

**🚀 RALPH Loop démarré - Iteration 1/20**

Je travaille maintenant sur : **$ARGUMENTS**
