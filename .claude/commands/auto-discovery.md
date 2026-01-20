---
description: Lance le workflow de planning complet en mode RALPH autonome (Brainstorm → PRD → Architecture → Stories). L'IA travaille seule jusqu'à avoir créé toutes les issues GitHub.
---

# Auto-Discovery - RALPH Mode 🔄

## Mode RALPH + Planning activé

Je vais exécuter **tout le workflow de planning en autonome** :

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    AUTO-DISCOVERY (RALPH MODE)                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  🧠 Brainstorm ──→ 📋 PRD ──→ 🏗️ Architecture ──→ 📝 Stories ──→ GitHub     │
│       AUTO          AUTO          AUTO              AUTO         AUTO       │
│                                                                             │
│  ⚠️ Pas de validation intermédiaire - Full autonome                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Configuration RALPH

| Paramètre | Valeur |
|-----------|--------|
| Max iterations | **30** (planning = plus d'étapes) |
| Timeout | **1h** |
| Completion promise | **"DISCOVERY COMPLETE"** |
| Logs | `docs/ralph-logs/` |

## Ce que je vais faire automatiquement

### Phase 1: Analyse & Mode Detection
- Analyser le scope de ton besoin
- Détecter automatiquement FULL vs LIGHT

### Phase 2: Brainstorm (si FULL)
- Explorer les directions possibles
- Choisir la plus pertinente

### Phase 3: PRD
- Poser les questions (et y répondre avec le contexte)
- Rédiger le PRD complet
- Sauvegarder dans `docs/planning/prd/`

### Phase 4: Architecture (si FULL)
- Analyser le codebase existant
- Proposer le stack technique
- Sauvegarder dans `docs/planning/architecture/`

### Phase 5: Stories
- Découper en Epics
- Créer les User Stories
- Sauvegarder dans `docs/stories/`

### Phase 6: Publication GitHub
- Créer les issues Epic
- Créer les issues Stories
- Lier les issues entre elles

## Output attendu

À la fin du loop, tu auras :
- 📄 `docs/planning/prd/PRD-xxx.md`
- 📄 `docs/planning/architecture/ARCH-xxx.md` (si mode FULL)
- 📁 `docs/stories/EPIC-xxx/` avec les stories
- 🐙 Issues GitHub créées et liées

## Arrêt manuel

```bash
/cancel-ralph
```

---

## Démarrage 🚀

**Besoin à traiter :** $ARGUMENTS

### Initialisation RALPH

```json
{
  "active": true,
  "iteration": 1,
  "maxIterations": 30,
  "completionPromise": "DISCOVERY COMPLETE",
  "originalPrompt": "AUTO-DISCOVERY: $ARGUMENTS",
  "startTime": [TIMESTAMP],
  "timeoutSeconds": 3600,
  "logEnabled": true,
  "sessionId": "[SESSION_ID]",
  "mode": "auto-discovery"
}
```

**🚀 Auto-Discovery démarré - Mode RALPH**

Je commence l'analyse de ton besoin : **$ARGUMENTS**

---

## Phase 1: Analyse du besoin

Je vais d'abord comprendre ce que tu veux construire et détecter le mode approprié (FULL ou LIGHT)...
