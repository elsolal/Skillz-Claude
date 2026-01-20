---
name: implementation-planner
description: Crée un plan d'implémentation détaillé basé sur les requirements et l'analyse du code. Utiliser après l'étape Explain, quand on a besoin de structurer le travail de développement, ou avant de commencer à coder.
---

# Implementation Planner

## Instructions

### 1. Synthèse des inputs
- Requirements de l'issue
- Contexte technique de l'analyse
- Contraintes identifiées

### 2. Décomposition
- Découper en étapes atomiques
- Estimer la complexité
- Identifier l'ordre des dépendances

### 3. Critères de validation
- Comment vérifier chaque étape ?
- Quels tests écrire ?

---

## Template de Plan

```markdown
## Plan d'Implémentation: [Feature]

### Résumé
[1-2 phrases sur l'objectif]

### Checklist
- [ ] Étape 1: [Description]
- [ ] Étape 2: [Description]
- [ ] Étape 3: [Description]
- [ ] Tests unitaires
- [ ] Tests d'intégration
- [ ] Review #1, #2, #3

### Détail des étapes

#### Étape 1: [Titre]
**Fichiers:** `path/to/file`
**Actions:**
1. Action spécifique 1
2. Action spécifique 2

**Validation:** [Comment vérifier]
**Complexité:** S/M/L

#### Étape 2: [Titre]
...

### Risques et mitigations
| Risque | Impact | Mitigation |
|--------|--------|------------|
| [Risque 1] | High/Med/Low | [Solution] |

### Questions
1. [Question sur design]
2. [Question technique]
```

---

## Validation humaine requise

**⏸️ STOP** - Attendre validation explicite avant implémentation.

Questions à poser :
- Le plan couvre-t-il tous les requirements ?
- L'ordre est-il logique ?
- Étapes manquantes ?
- Estimations réalistes ?
