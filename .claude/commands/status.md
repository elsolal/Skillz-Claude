---
description: Affiche l'état actuel du projet - documents existants, issues GitHub, et état RALPH. Usage: /status
---

# Status

**Session ID:** ${CLAUDE_SESSION_ID}

## 📥 Contexte à charger

**Découvrir l'état complet du projet.**

| Contexte | Pattern/Action | Priorité |
|----------|----------------|----------|
| Brainstorms | `Glob: docs/planning/brainstorms/*.md` | Optionnel |
| UX Design | `Glob: docs/planning/ux/*.md` | Optionnel |
| PRD | `Glob: docs/planning/prd/*.md` | Optionnel |
| UI Design | `Glob: docs/planning/ui/*.md` | Optionnel |
| Architecture | `Glob: docs/planning/architecture/*.md` | Optionnel |
| Stories | `Glob: docs/stories/*/STORY-*.md` | Optionnel |
| GitHub Issues | `Bash: gh issue list --limit 10` | Optionnel |
| Logs RALPH | `Glob: docs/ralph-logs/*.md` | Optionnel |
| Git Status | `Bash: git status --short` | Optionnel |
| Derniers commits | `Bash: git log --oneline -5` | Optionnel |

### Instructions de chargement
1. Utiliser `Glob` pour scanner tous les documents de planning
2. Vérifier les stories et logs RALPH
3. Utiliser `Bash` pour les commandes git et GitHub CLI

---

## Mode Status activé

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              PROJECT STATUS                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Ce résumé montre l'état actuel de ton projet D-EPCT+R.                    │
│                                                                             │
│  Documents         : Brainstorm → UX → PRD → UI → Architecture → Stories   │
│  GitHub            : Issues ouvertes et leur état                           │
│  RALPH             : Dernières sessions autonomes                           │
│  Git               : Changements en cours                                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Analyse

Je vais analyser l'état du projet et te donner un résumé...

### Checklist Planning

| Document | Status | Fichier |
|----------|--------|---------|
| Brainstorm | ✅/❌ | [path ou "Manquant"] |
| UX Design | ✅/❌/⏭️ | [path ou "Manquant" ou "Optionnel"] |
| PRD | ✅/❌ | [path ou "Manquant"] |
| UI Design | ✅/❌/⏭️ | [path ou "Manquant" ou "Optionnel"] |
| Architecture | ✅/❌ | [path ou "Manquant"] |
| Stories | ✅/❌ | [count stories ou "Manquant"] |

### GitHub Sync

| Métrique | Valeur |
|----------|--------|
| Issues ouvertes | X |
| Issues fermées récemment | X |
| PRs ouvertes | X |

### RALPH Sessions

| Session | Date | Status |
|---------|------|--------|
| [Type] | [Date] | [Completed/In Progress] |

### Recommandations

Basé sur l'état actuel :

1. **Prochaine étape suggérée** : [Suggestion basée sur ce qui manque]
2. **Commande recommandée** : `/[commande]`

---

## Actions rapides

```bash
# Continuer le workflow
/discovery          # Si pas de planning
/feature #XX        # Si stories prêtes

# Utilitaires
/docs all           # Générer la documentation
/pr-review #XX      # Review une PR
```
