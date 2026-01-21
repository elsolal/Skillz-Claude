# Risk Assessment Framework

## Matrice de risques

### Grille Probabilité × Impact

```
Impact →    Faible(1)   Moyen(2)   Élevé(3)   Critique(4)
Probabilité
↓
Très probable(4)   4 🟡      8 🟠      12 🔴      16 🔴
Probable(3)        3 🟢      6 🟡       9 🟠      12 🔴
Possible(2)        2 🟢      4 🟡       6 🟡       8 🟠
Peu probable(1)    1 🟢      2 🟢       3 🟢       4 🟡
```

### Niveaux de risque

| Score | Niveau | Action requise |
|-------|--------|----------------|
| 1-3 | 🟢 Faible | Accepter, monitorer |
| 4-6 | 🟡 Moyen | Plan de mitigation |
| 7-9 | 🟠 Élevé | Action prioritaire |
| 10-16 | 🔴 Critique | Blocker, escalade |

---

## Catégories de risques

### 1. Risques techniques

```markdown
## Risques Techniques

| Risque | P | I | Score | Mitigation |
|--------|---|---|-------|------------|
| Legacy code fragile | 3 | 3 | 9 🟠 | Tests d'abord, refactor progressif |
| Dépendance obsolète | 2 | 3 | 6 🟡 | Audit deps, plan de migration |
| Performance insuffisante | 2 | 4 | 8 🟠 | Benchmarks early, cache strategy |
| Sécurité vulnérable | 2 | 4 | 8 🟠 | Security review, pen test |
| Scalabilité limitée | 2 | 3 | 6 🟡 | Load tests, architecture review |
| Intégration API externe | 3 | 2 | 6 🟡 | Mocks, circuit breaker |
```

### 2. Risques planning

```markdown
## Risques Planning

| Risque | P | I | Score | Mitigation |
|--------|---|---|-------|------------|
| Estimation optimiste | 4 | 2 | 8 🟠 | Buffer 30%, three-point |
| Scope creep | 3 | 3 | 9 🟠 | Change request process |
| Dépendance externe | 3 | 3 | 9 🟠 | Identifier early, parallel work |
| Ressources indisponibles | 2 | 3 | 6 🟡 | Cross-training, docs |
| Blockers techniques | 2 | 4 | 8 🟠 | Spike early, alternatives |
```

### 3. Risques équipe

```markdown
## Risques Équipe

| Risque | P | I | Score | Mitigation |
|--------|---|---|-------|------------|
| Bus factor = 1 | 3 | 4 | 12 🔴 | Pair programming, docs |
| Turnover | 2 | 3 | 6 🟡 | Knowledge sharing, docs |
| Skill gap | 2 | 2 | 4 🟡 | Formation, mentoring |
| Communication | 2 | 2 | 4 🟡 | Daily standups, docs |
| Motivation | 2 | 3 | 6 🟡 | Ownership, reconnaissance |
```

### 4. Risques business

```markdown
## Risques Business

| Risque | P | I | Score | Mitigation |
|--------|---|---|-------|------------|
| Requirements change | 3 | 3 | 9 🟠 | Agile, releases fréquentes |
| Stakeholder absent | 2 | 3 | 6 🟡 | RACI, backup décideur |
| Budget coupé | 2 | 4 | 8 🟠 | MVP first, ROI visible |
| Priorités conflictuelles | 3 | 2 | 6 🟡 | Product owner unique |
| Compliance/Legal | 2 | 4 | 8 🟠 | Review legal early |
```

---

## Process d'évaluation

### 1. Identification

```markdown
## Session d'identification des risques

### Participants
- [ ] Tech lead
- [ ] PM/PO
- [ ] Dev senior
- [ ] QA (si applicable)

### Méthodes
1. **Brainstorming** - Lister tous les risques possibles
2. **Pre-mortem** - "Le projet a échoué, pourquoi ?"
3. **Checklist** - Parcourir les catégories standard
4. **Historique** - Risques des projets similaires

### Output
Liste brute de 10-20 risques potentiels
```

### 2. Analyse

```markdown
## Analyse des risques

Pour chaque risque identifié :

### Template
| Attribut | Valeur |
|----------|--------|
| **ID** | R-001 |
| **Description** | [Qu'est-ce qui peut mal tourner] |
| **Catégorie** | Tech / Planning / Équipe / Business |
| **Probabilité** | 1-4 |
| **Impact** | 1-4 |
| **Score** | P × I |
| **Trigger** | [Signe avant-coureur] |
| **Mitigation** | [Action préventive] |
| **Contingency** | [Plan B si ça arrive] |
| **Owner** | [Qui surveille] |
```

### 3. Priorisation

```markdown
## Risques priorisés

### 🔴 Critiques (traiter immédiatement)
| ID | Risque | Score | Owner | Deadline |
|----|--------|-------|-------|----------|
| R-005 | Bus factor | 12 | Tech Lead | Sprint 1 |

### 🟠 Élevés (plan d'action cette semaine)
| ID | Risque | Score | Owner | Deadline |
|----|--------|-------|-------|----------|
| R-001 | Estimation | 8 | PM | Day 1 |
| R-003 | Performance | 8 | Dev | Sprint 2 |

### 🟡 Moyens (monitorer)
| ID | Risque | Score | Owner | Review |
|----|--------|-------|-------|--------|
| R-007 | API externe | 6 | Dev | Weekly |

### 🟢 Faibles (accepter)
| ID | Risque | Score | Notes |
|----|--------|-------|-------|
| R-012 | Typos docs | 2 | Fix as we go |
```

---

## Plans de mitigation

### Template plan de mitigation

```markdown
## Plan de Mitigation: [Risque]

### Risque
**ID:** R-XXX
**Description:** [...]
**Score actuel:** X (P×I)

### Stratégie
- [ ] **Éviter** - Éliminer la cause
- [ ] **Réduire** - Diminuer P ou I
- [ ] **Transférer** - Assurance, sous-traitance
- [ ] **Accepter** - Buffer, contingency

### Actions préventives
| Action | Responsable | Deadline | Status |
|--------|-------------|----------|--------|
| [Action 1] | [Qui] | [Date] | 🔄 |
| [Action 2] | [Qui] | [Date] | ✅ |

### Plan de contingence
**Si le risque se matérialise :**
1. [Action immédiate]
2. [Communication]
3. [Escalade si nécessaire]

### Indicateurs
- **Trigger:** [Signe que ça arrive]
- **Monitoring:** [Comment surveiller]
- **Fréquence:** [Daily/Weekly/Sprint]

### Score après mitigation
**Nouveau score:** Y (P×I)
**Réduction:** -Z points
```

---

## Risk Register

### Template registre complet

```markdown
## Risk Register: [Projet]

**Date:** YYYY-MM-DD
**Version:** 1.0
**Owner:** [PM]

### Synthèse
| Niveau | Count | Trend |
|--------|-------|-------|
| 🔴 Critique | 1 | ↓ |
| 🟠 Élevé | 3 | → |
| 🟡 Moyen | 5 | ↓ |
| 🟢 Faible | 4 | → |
| **Total** | **13** | - |

### Registre détaillé
| ID | Risque | Cat | P | I | Score | Status | Owner |
|----|--------|-----|---|---|-------|--------|-------|
| R-001 | [Desc] | Tech | 3 | 3 | 9 🟠 | Mitigating | Alice |
| R-002 | [Desc] | Plan | 2 | 4 | 8 🟠 | Monitoring | Bob |
| ... | ... | ... | ... | ... | ... | ... | ... |

### Actions en cours
| ID | Action | Owner | Due | Status |
|----|--------|-------|-----|--------|
| A-001 | [Action] | Alice | MM/DD | 🔄 |

### Risques fermés
| ID | Risque | Raison | Date |
|----|--------|--------|------|
| R-010 | [Desc] | Mitigé | MM/DD |

### Next Review
**Date:** [Date]
**Participants:** [Liste]
```

---

## Checklist pré-projet

```markdown
## Risk Assessment Checklist

### ✅ Avant kickoff
- [ ] Risques techniques identifiés
- [ ] Risques planning identifiés
- [ ] Risques équipe identifiés
- [ ] Risques business identifiés
- [ ] Top 5 risques priorisés
- [ ] Owners assignés
- [ ] Plans de mitigation pour 🔴/🟠

### ✅ Weekly review
- [ ] Nouveaux risques ?
- [ ] Scores mis à jour ?
- [ ] Actions en cours trackées ?
- [ ] Risques fermés documentés ?

### ✅ Triggers d'escalade
- [ ] Score passe à 🔴 → Escalade PM
- [ ] Risque matérialisé → Plan contingence
- [ ] Nouveau risque critique → Session urgente
```
