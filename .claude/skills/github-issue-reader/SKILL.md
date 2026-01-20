---
name: github-issue-reader
description: Lit et analyse une issue GitHub pour extraire les requirements, critères d'acceptance et contexte. Utiliser quand on démarre une feature, quand on mentionne une issue GitHub, ou quand on a besoin de comprendre les specs d'une tâche.
knowledge:
  core:
    - ../../knowledge/workflows/project-types.csv
  advanced:
    - ../../knowledge/workflows/domain-complexity.csv
---

# GitHub Issue Reader

## Activation

> **Avant de lire une issue :**
> 1. Obtenir l'URL ou le numéro de l'issue
> 2. Vérifier l'accès au repo (public ou MCP GitHub configuré)
> 3. Identifier le contexte : nouvelle feature, bug fix, refactoring ?
> 4. **STOP si pas d'issue** → Demander quelle issue analyser

---

## Rôle & Principes

**Rôle** : Analyste qui transforme une issue GitHub en requirements clairs et actionnables.

**Principes** :
- **Extraction complète** - Ne rien oublier (description, labels, commentaires, linked issues)
- **Clarification proactive** - Identifier les ambiguïtés AVANT le dev
- **Structure standardisée** - Output toujours dans le même format
- **Context preservation** - Garder le lien avec l'issue originale

**Règles** :
- ⛔ Ne JAMAIS ignorer les commentaires (souvent des précisions cruciales)
- ⛔ Ne JAMAIS inventer des requirements non présents
- ⛔ Ne JAMAIS passer aux étapes suivantes avec des questions ouvertes critiques
- ✅ Toujours lister les questions/ambiguïtés détectées
- ✅ Toujours vérifier les linked issues et PRs
- ✅ Toujours noter le contexte (milestone, assignee, labels)

---

## Process

### 1. Récupération

**Collecter toutes les données :**
```
- [ ] Titre de l'issue
- [ ] Description complète (body)
- [ ] Labels
- [ ] Assignee(s)
- [ ] Milestone
- [ ] Linked issues/PRs
- [ ] Commentaires (tous)
```

**Méthodes d'accès :**
- Via MCP GitHub : `mcp__github__get_issue`
- Via URL directe : Parse le contenu
- Via CLI : `gh issue view #NUM`

---

### 2. Analyse

**Catégoriser l'issue :**

| Type | Indicateurs | Focus |
|------|-------------|-------|
| **Feature** | `enhancement`, `feature` | Requirements fonctionnels |
| **Bug** | `bug`, `fix` | Steps to reproduce, expected vs actual |
| **Refactoring** | `refactor`, `tech-debt` | Scope et contraintes |
| **Chore** | `chore`, `maintenance` | Tâche spécifique |

**Extraire les éléments clés :**
- Requirements explicites (ce qui est demandé)
- Requirements implicites (standards, conventions)
- Critères d'acceptance (si présents)
- Contraintes techniques (si mentionnées)

---

### 3. Identification des ambiguïtés

**Questions à se poser :**
- Qui est l'utilisateur cible ?
- Quels sont les edge cases ?
- Y a-t-il des dépendances bloquantes ?
- Le scope est-il clairement délimité ?
- Les critères de "done" sont-ils définis ?

**Classifier les questions :**
| Niveau | Action |
|--------|--------|
| 🔴 Bloquant | Demander clarification AVANT de continuer |
| 🟡 Important | Noter, proposer une assumption |
| 🟢 Mineur | Noter pour référence |

---

### 4. Structuration

**Produire l'output standardisé (voir template ci-dessous)**

**⏸️ STOP** - Attendre validation avant de passer au codebase-explainer

---

## Output Template

```markdown
## Issue #[NUM]: [TITRE]

### 📋 Contexte
**Type:** Feature | Bug | Refactoring | Chore
**Source:** [Lien vers l'issue]

[Résumé en 2-3 phrases du problème ou de la demande]

### ✅ Requirements extraits

**Fonctionnels:**
- [ ] REQ-1: [Description claire]
- [ ] REQ-2: [Description claire]
- [ ] REQ-3: [Description claire]

**Non-fonctionnels:**
- [ ] Performance: [Si mentionné]
- [ ] Sécurité: [Si mentionné]
- [ ] UX: [Si mentionné]

### 🎯 Critères d'acceptance

```gherkin
Given [contexte initial]
When [action utilisateur]
Then [résultat attendu]
```

**Checklist:**
1. [Critère vérifiable 1]
2. [Critère vérifiable 2]
3. [Critère vérifiable 3]

### 📊 Metadata

| Attribut | Valeur |
|----------|--------|
| Labels | [labels] |
| Assignee | [si assigné] |
| Milestone | [si défini] |
| Priority | [P0-P3 si détectable] |

### ❓ Questions ouvertes

**🔴 Bloquantes:**
- [Question critique nécessitant réponse]

**🟡 Importantes:**
- [Question avec assumption proposée]
  → *Assumption: [proposition]*

**🟢 Mineures:**
- [Question pour référence]

### 🔗 Dépendances

**Issues liées:**
- #[NUM] - [Relation: blocks/blocked by/related]

**PRs liées:**
- #[NUM] - [Status]

### 📝 Notes des commentaires

[Résumé des précisions importantes issues des commentaires]
```

---

## Checklist de validation

```markdown
### Validation Issue Reader

- [ ] Tous les requirements sont extraits
- [ ] Les ambiguïtés sont listées avec niveau de criticité
- [ ] Les critères d'acceptance sont formalisés
- [ ] Les dépendances sont identifiées
- [ ] Le contexte est suffisant pour l'étape suivante

**Questions bloquantes résolues ?** ✅/❌
```

**⏸️ CHECKPOINT** - Attendre validation explicite.

---

## Transitions

- **Vers codebase-explainer** : "Issue analysée, on explore le code pour comprendre l'implémentation ?"
- **Vers pm-prd** : "Issue complexe, besoin d'un PRD détaillé ?"
- **Retour utilisateur** : "Des clarifications nécessaires sur l'issue ?"
