---
description: Affiche l'état actuel du projet - documents existants, issues GitHub, et état RALPH. Usage: /status
---

# Status

**Session ID:** ${CLAUDE_SESSION_ID}

## 📥 État du projet chargé automatiquement

### Documents Planning
!`echo "=== Brainstorms ===" && ls -la docs/planning/brainstorms/*.md 2>/dev/null | tail -5 || echo "Aucun brainstorm"`
!`echo "=== UX Design ===" && ls -la docs/planning/ux/*.md 2>/dev/null | tail -5 || echo "Aucun UX design"`
!`echo "=== PRD ===" && ls -la docs/planning/prd/*.md 2>/dev/null | tail -5 || echo "Aucun PRD"`
!`echo "=== UI Design ===" && ls -la docs/planning/ui/*.md 2>/dev/null | tail -5 || echo "Aucun UI design"`
!`echo "=== Architecture ===" && ls -la docs/planning/architecture/*.md 2>/dev/null | tail -5 || echo "Aucune architecture"`

### Stories
!`echo "=== Stories ===" && ls -la docs/stories/*/STORY-*.md 2>/dev/null | tail -10 || echo "Aucune story locale"`

### GitHub Issues (si configuré)
!`gh issue list --limit 10 2>/dev/null || echo "GitHub CLI non configuré ou pas de repo"`

### Logs RALPH
!`echo "=== Derniers logs RALPH ===" && ls -lt docs/ralph-logs/*.md 2>/dev/null | head -5 || echo "Aucun log RALPH"`

### Git Status
!`git status --short 2>/dev/null | head -15 || echo "Pas de repo git"`

### Derniers commits
!`git log --oneline -5 2>/dev/null || echo "Pas d'historique"`

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
