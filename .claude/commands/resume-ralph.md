---
description: Reprendre une session RALPH interrompue à partir des logs. Usage: /resume-ralph [session-id] ou /resume-ralph (reprend la dernière session)
---

# Resume RALPH Session 🔄

**Session à reprendre :** $ARGUMENTS

## Récupération du contexte

Je vais analyser les logs RALPH pour reprendre là où on s'est arrêté.

### Sessions RALPH disponibles

| Contexte | Action | Priorité |
|----------|--------|----------|
| Logs RALPH | `Glob: docs/ralph-logs/*.md` | Requis |
| Dernière session | Prendre le fichier le plus récent | Requis |

**Instructions :** Utiliser `Glob` pour lister les sessions disponibles, puis `Read` pour charger le log de la session à reprendre.

---

## Process de reprise

### 1. Identification de la session

```markdown
## 🔍 Analyse de la session

**Session ID:** [À déterminer]
**Fichier log:** docs/ralph-logs/[session-id].md

### État récupéré
| Paramètre | Valeur |
|-----------|--------|
| Mode | [auto-loop / auto-discovery / auto-feature] |
| Prompt original | [Récupéré du log] |
| Dernière itération | [N] |
| Max iterations | [M] |
| Completion promise | [Texte] |
| Dernière action | [Description] |
| Status | [Interrompu / Timeout / Erreur] |
```

### 2. Diagnostic de l'interruption

```markdown
## 🔎 Diagnostic

### Raison de l'arrêt
- [ ] Timeout atteint
- [ ] Erreur technique
- [ ] Interruption manuelle (/cancel-ralph)
- [ ] Contexte perdu (compaction)
- [ ] Autre: [...]

### Dernière étape complétée
[Description de ce qui a été fait]

### Prochaine étape prévue
[Ce qui devait être fait ensuite]
```

### 3. Options de reprise

```markdown
## 📋 Options

**[C] Continuer** - Reprendre exactement où on en était
- Restaurer l'état RALPH
- Continuer les itérations restantes
- Même prompt, même objectif

**[R] Restart** - Recommencer depuis le début
- Réinitialiser les itérations
- Utiliser le même prompt
- Fresh start

**[M] Modifier** - Ajuster avant de continuer
- Modifier le prompt
- Changer les paramètres (max, timeout)
- Puis continuer

**[A] Abandonner** - Marquer comme terminé
- Archiver les logs
- Pas de reprise

Ton choix ?
```

**⏸️ STOP** - Attendre le choix

---

## 4. Reprise de la session

### Option C - Continuer

```json
{
  "active": true,
  "iteration": [N+1],
  "maxIterations": [M],
  "completionPromise": "[Promise]",
  "originalPrompt": "[Prompt récupéré]",
  "resumedFrom": "[Session ID]",
  "resumeTime": [TIMESTAMP],
  "previousIterations": [N]
}
```

### Option R - Restart

```json
{
  "active": true,
  "iteration": 1,
  "maxIterations": [M],
  "completionPromise": "[Promise]",
  "originalPrompt": "[Prompt récupéré]",
  "restartedFrom": "[Session ID]",
  "startTime": [TIMESTAMP]
}
```

### Option M - Modifier

```markdown
**Paramètres actuels :**
- Prompt: [...]
- Max iterations: [M]
- Timeout: [T]
- Promise: [...]

**Que veux-tu modifier ?**
1. Le prompt
2. Max iterations (--max N)
3. Timeout (--timeout Xh)
4. Completion promise (--promise "TEXT")

Indique tes modifications :
```

---

## Récupération automatique du contexte

Selon le mode RALPH :

### Si auto-discovery
```markdown
### Contexte Discovery récupéré
- [ ] Brainstorm créé ? → docs/planning/brainstorms/
- [ ] PRD créé ? → docs/planning/prd/
- [ ] Architecture créée ? → docs/planning/architecture/
- [ ] Stories créées ? → docs/stories/
- [ ] Issues GitHub créées ?
```

### Si auto-feature
```markdown
### Contexte Feature récupéré
- [ ] Issue lue ?
- [ ] Codebase analysé ?
- [ ] Plan créé ?
- [ ] Code implémenté ? → Fichiers modifiés
- [ ] Tests écrits ?
- [ ] Review effectuée ?
```

### Si auto-loop
```markdown
### Contexte Loop récupéré
- [ ] Tâche en cours : [...]
- [ ] Progress : [Description]
- [ ] Fichiers modifiés : [Liste]
```

---

## Output de reprise

```markdown
## 🔄 Session RALPH reprise

**Mode:** [auto-loop / auto-discovery / auto-feature]
**Session originale:** [ID]
**Nouvelle session:** ${CLAUDE_SESSION_ID}

### État
| Paramètre | Valeur |
|-----------|--------|
| Itération | [N+1] / [M] |
| Prompt | [Résumé] |
| Contexte | [Restauré] |

### Prochaine action
[Description de ce que je vais faire]

---

**🚀 Reprise en cours...**
```

---

## Exemples d'utilisation

```bash
# Reprendre la dernière session
/resume-ralph

# Reprendre une session spécifique
/resume-ralph abc123-def456

# Voir les sessions disponibles sans reprendre
/status
```

---

## Notes importantes

- Les logs RALPH sont dans `docs/ralph-logs/`
- Chaque session a un ID unique (CLAUDE_SESSION_ID)
- Le contexte est partiellement récupéré depuis les logs
- Certaines informations peuvent être perdues si la session a été compactée
- En cas de doute, préférer l'option **[R] Restart**
