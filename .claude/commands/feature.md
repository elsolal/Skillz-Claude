---
description: Lance le workflow EPCT+R complet pour implémenter une feature à partir d'une issue GitHub.
---

# 🚀 Feature Implementation: $ARGUMENTS

## Workflow EPCT+R

```
┌─────────────────────────────────────────────────────────────────┐
│  📋 EXPLAIN  →  📝 PLAN  →  💻 CODE  →  🧪 TEST  →  🔍 REVIEW   │
│       ↓            ↓           ↓           ↓         ↓×3       │
│    [STOP]       [STOP]      [STOP]      [STOP]     [STOP]      │
│   Validation   Validation  Validation  Validation  Validation  │
└─────────────────────────────────────────────────────────────────┘
```

### Task System (tracking automatique)

Si la feature a **2+ étapes**, des Tasks sont créées automatiquement pour :
- Visualiser la progression en temps réel
- Permettre la reprise en cas d'interruption
- Documenter le travail effectué

Utiliser `TaskList` à tout moment pour voir l'état des Tasks.

---

## Phase 1: EXPLAIN 📋

### 1.1 Lecture de l'issue
Récupérer et analyser: **$ARGUMENTS**

Extraire:
- Requirements et critères d'acceptance
- Contexte et dépendances
- Questions ouvertes

### 1.2 Analyse du codebase
- Architecture existante
- Fichiers impactés
- Patterns à suivre

**⏸️ CHECKPOINT 1** - Validation avant de planifier.

---

## Phase 2: PLAN 📝

### 2.1 Plan d'implémentation
- Décomposition en étapes atomiques
- Ordre des tâches
- Risques identifiés

### 2.2 Critères de validation
- Comment vérifier chaque étape ?
- Quels tests écrire ?

**⏸️ CHECKPOINT 2** - Validation du plan avant implémentation.

---

## Phase 3: CODE 💻

### Pour chaque étape du plan :
1. Implémenter
2. Vérifier lint/types
3. Montrer le diff
4. Obtenir validation

**⏸️ CHECKPOINT 3** - Validation à chaque étape.

---

## Phase 4: TEST 🧪

### 4.1 Écrire les tests
- Tests unitaires
- Tests d'intégration
- Edge cases

### 4.2 Exécuter
- Tous les tests doivent passer
- Coverage acceptable

**⏸️ CHECKPOINT 4** - Validation des tests.

---

## Phase 5: REVIEW 🔍 (×3)

### Pass 1: Correctness
Logique correcte ? Bugs ? Sécurité ?
→ Corrections → Validation

### Pass 2: Readability
Code lisible ? Maintenable ? DRY ?
→ Améliorations → Validation

### Pass 3: Performance
Optimal ? Memory leaks ? Scale ?
→ Optimisations → Validation finale

---

## Checklist globale

```markdown
## Feature: $ARGUMENTS

### EXPLAIN
- [ ] Issue comprise
- [ ] Codebase analysé
- [ ] ✅ Validé

### PLAN
- [ ] Plan créé
- [ ] Tasks créées (si 2+ étapes)
- [ ] ✅ Validé

### CODE
- [ ] Étapes implémentées
- [ ] Tasks mises à jour (completed)
- [ ] ✅ Validé

### TEST
- [ ] Tests écrits et passent
- [ ] ✅ Validé

### REVIEW
- [ ] Pass 1: Correctness ✅
- [ ] Pass 2: Readability ✅
- [ ] Pass 3: Performance ✅

### 🎉 COMPLETE
```

---

## Démarrage

Commençons par **Phase 1: EXPLAIN**.

Issue à traiter : **$ARGUMENTS**
