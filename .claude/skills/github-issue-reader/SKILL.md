---
name: github-issue-reader
description: Lit et analyse une issue GitHub pour extraire les requirements, critères d'acceptance et contexte. Utiliser quand on démarre une feature, quand on mentionne une issue GitHub, ou quand on a besoin de comprendre les specs d'une tâche.
---

# GitHub Issue Reader

## Instructions

1. **Récupérer l'issue** via URL ou numéro
2. **Extraire les informations clés** :
   - Titre et description
   - Critères d'acceptance
   - Labels et priorité
   - Commentaires pertinents
   - Liens vers autres issues/PRs

3. **Produire un résumé structuré**

---

## Output attendu

```markdown
## Issue #[NUM]: [TITRE]

### Contexte
[Résumé du problème ou de la demande]

### Requirements extraits
- [ ] Requirement 1
- [ ] Requirement 2
- [ ] Requirement 3

### Critères d'acceptance
1. [Critère 1]
2. [Critère 2]

### Metadata
- **Labels:** [labels]
- **Assignee:** [si assigné]
- **Milestone:** [si défini]

### Questions ouvertes
- [Question si ambiguïté détectée]

### Dépendances
- [Liens vers autres issues/PRs si pertinent]
```

---

## Validation

Avant de passer à l'étape suivante :

1. Les requirements extraits sont-ils corrects ?
2. Y a-t-il des clarifications nécessaires ?
3. Manque-t-il des informations ?

**⏸️ CHECKPOINT** - Attendre validation.
