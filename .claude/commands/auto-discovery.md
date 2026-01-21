---
description: Lance le workflow de planning complet en mode RALPH autonome (Brainstorm → PRD → Architecture → Stories). L'IA travaille seule jusqu'à avoir créé toutes les issues GitHub.
---

# Auto-Discovery - RALPH Mode 🔄

**Session ID:** ${CLAUDE_SESSION_ID}

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
| Session | `${CLAUDE_SESSION_ID}` |
| Max iterations | **30** (planning = plus d'étapes) |
| Timeout | **1h** |
| Completion promise | **"DISCOVERY COMPLETE"** |
| Logs | `docs/ralph-logs/${CLAUDE_SESSION_ID}.md` |
| Verbose | OFF (use `--verbose` to enable) |

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

---

## 📊 Métriques RALPH

Le log inclut automatiquement les métriques suivantes :

```markdown
## 📊 Métriques Discovery

| Métrique | Valeur |
|----------|--------|
| **Durée totale** | [X]m [Y]s |
| **Itérations** | [N] / 30 |
| **Mode détecté** | FULL / LIGHT |

### Temps par phase
| Phase | Durée | Status |
|-------|-------|--------|
| Analyse initiale | [X]m | ✅ |
| Brainstorm | [X]m | ✅/⏭️ |
| UX Design | [X]m | ✅/⏭️ |
| PRD | [X]m | ✅ |
| UI Design | [X]m | ✅/⏭️ |
| Architecture | [X]m | ✅/⏭️ |
| Stories | [X]m | ✅ |
| GitHub | [X]m | ✅ |

### Documents générés
| Type | Fichier | Status |
|------|---------|--------|
| Brainstorm | `BRAINSTORM-xxx.md` | ✅/❌ |
| UX Design | `UX-xxx.md` | ✅/⏭️ |
| PRD | `PRD-xxx.md` | ✅ |
| UI Design | `UI-xxx.md` | ✅/⏭️ |
| Architecture | `ARCH-xxx.md` | ✅/⏭️ |
| Stories | `EPIC-xxx/` | ✅ |

### Issues GitHub
| Type | Count | Numéros |
|------|-------|---------|
| Epics | [X] | #[nums] |
| Stories | [X] | #[nums] |

### Auto-corrections
| Type | Count |
|------|-------|
| Questions résolues auto | [X] |
| Modes ajustés | [X] |
| Retours phases | [X] |
```

## Arguments supportés

| Argument | Default | Description |
|----------|---------|-------------|
| `--max N` | 30 | Nombre max d'itérations |
| `--timeout Xh` | 1h | Timeout global |
| `--verbose` | false | Mode debug avec logs détaillés |

## Mode Verbose

Avec `--verbose`, chaque étape affiche :
- État du contexte chargé
- Décisions prises et pourquoi
- Temps passé par phase
- Problèmes rencontrés et solutions

```bash
# Exemple avec verbose
/auto-discovery "Mon idée de projet" --verbose
```

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
  "sessionId": "${CLAUDE_SESSION_ID}",
  "mode": "auto-discovery"
}
```

**🚀 Auto-Discovery démarré - Mode RALPH**

Je commence l'analyse de ton besoin : **$ARGUMENTS**

---

## Phase 1: Analyse du besoin

Je vais d'abord comprendre ce que tu veux construire et détecter le mode approprié (FULL ou LIGHT)...
