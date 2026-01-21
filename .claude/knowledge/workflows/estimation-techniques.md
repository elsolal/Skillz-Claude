# Techniques d'estimation

## Vue d'ensemble

| Technique | Quand utiliser | Précision | Effort |
|-----------|----------------|-----------|--------|
| T-shirt sizing | Early planning | Faible | Très faible |
| Story points | Sprint planning | Moyenne | Faible |
| Planning poker | Team estimation | Moyenne | Moyen |
| Three-point | Risques élevés | Haute | Moyen |
| Bottom-up | Devis/contrats | Haute | Élevé |

---

## 1. T-shirt Sizing

### Définition des tailles

| Taille | Complexité | Durée indicative | Exemple |
|--------|------------|------------------|---------|
| **XS** | Trivial | < 2h | Fix typo, config change |
| **S** | Simple | 2h - 1 jour | CRUD basique, bug simple |
| **M** | Moyen | 1-3 jours | Feature avec tests |
| **L** | Complexe | 3-5 jours | Feature multi-composants |
| **XL** | Très complexe | 1-2 semaines | Nouvelle architecture |
| **XXL** | Epic | > 2 semaines | À découper |

### Usage
```markdown
| Story | Taille | Raison |
|-------|--------|--------|
| Login basique | S | Pattern existant |
| Auth OAuth | M | Intégration externe |
| Multi-tenant | XL | Changement archi |
```

---

## 2. Story Points (Fibonacci)

### Échelle

| Points | Signification |
|--------|---------------|
| 1 | Je sais exactement quoi faire, < 2h |
| 2 | Clair, quelques heures |
| 3 | Clair mais effort moyen |
| 5 | Complexité modérée, ~1 jour |
| 8 | Complexe, plusieurs jours |
| 13 | Très complexe, risques |
| 21 | Epic, à découper |
| ? | Besoin de clarification |

### Facteurs de complexité

```markdown
## Grille de complexité

| Facteur | +1 point | +2 points | +3 points |
|---------|----------|-----------|-----------|
| Code nouveau | Modification | Nouveau fichier | Nouveau module |
| Tests | Unit seul | Unit + Integration | E2E requis |
| Dépendances | Aucune | 1-2 | 3+ |
| Incertitude | Faible | Moyenne | Élevée |
| Review | Standard | Security | Architecture |
```

---

## 3. Three-Point Estimation

### Formule

```
Estimation = (O + 4M + P) / 6
Écart-type = (P - O) / 6

O = Optimiste (tout se passe bien)
M = Most likely (cas normal)
P = Pessimiste (problèmes)
```

### Exemple

```markdown
## Estimation: Feature Authentication

| Scénario | Durée | Hypothèses |
|----------|-------|------------|
| Optimiste | 2 jours | Libs existantes, pas de bugs |
| Probable | 4 jours | Quelques ajustements |
| Pessimiste | 8 jours | Refactor nécessaire, bugs |

**Estimation:** (2 + 4×4 + 8) / 6 = **4.3 jours**
**Écart-type:** (8 - 2) / 6 = **1 jour**
**Range:** 3.3 - 5.3 jours
```

---

## 4. Planning Poker

### Process

```markdown
## Session Planning Poker

### Préparation
1. Chaque participant a les cartes : 1, 2, 3, 5, 8, 13, 21, ?, ☕
2. PM présente la story
3. Clarifications (timeboxed 2 min)

### Vote
1. Tous révèlent en même temps
2. Si consensus → valider
3. Si écart → discussion
   - Plus haut et plus bas expliquent
   - Re-vote
4. Max 3 rounds

### Règles
- Pas de influence (vote simultané)
- Timeboxé (5 min/story max)
- ☕ = pause needed
- ? = besoin de clarification
```

---

## 5. Bottom-up Estimation

### Template

```markdown
## Estimation détaillée: [Feature]

### Décomposition

| Tâche | Junior | Mid | Senior | Buffer |
|-------|--------|-----|--------|--------|
| Design API | - | 4h | 2h | +20% |
| Implémentation | 16h | 8h | 4h | +30% |
| Tests unitaires | 8h | 4h | 2h | +10% |
| Tests intégration | 4h | 2h | 1h | +20% |
| Documentation | 2h | 1h | 0.5h | +10% |
| Code review | 2h | 1h | 0.5h | +10% |
| **Total** | **32h** | **20h** | **10h** | - |

### Avec buffer
- Junior: 32h × 1.20 = **38h** (~5 jours)
- Mid: 20h × 1.20 = **24h** (~3 jours)
- Senior: 10h × 1.20 = **12h** (~1.5 jours)

### Risques
| Risque | Impact | Buffer additionnel |
|--------|--------|-------------------|
| API externe indisponible | 🔴 | +50% |
| Specs incomplètes | 🟡 | +30% |
| Nouveau framework | 🟡 | +40% |
```

---

## Vélocité et capacité

### Calcul vélocité équipe

```markdown
## Vélocité: [Équipe]

### Historique (derniers 6 sprints)
| Sprint | Points planifiés | Points livrés | Ratio |
|--------|-----------------|---------------|-------|
| S-5 | 40 | 35 | 87% |
| S-4 | 45 | 42 | 93% |
| S-3 | 38 | 40 | 105% |
| S-2 | 42 | 38 | 90% |
| S-1 | 40 | 41 | 102% |
| S0 | 43 | 40 | 93% |

**Vélocité moyenne:** 39 points/sprint
**Écart-type:** 2.5 points
**Range réaliste:** 36-42 points/sprint
```

### Capacité sprint

```markdown
## Capacité Sprint [N]

### Disponibilité
| Membre | Jours dispo | Ratio | Capacity |
|--------|-------------|-------|----------|
| Alice | 10 | 100% | 10 |
| Bob | 8 | 100% | 8 |
| Carol | 10 | 50% | 5 |
| **Total** | - | - | **23 jours** |

### Réduction standard
- Meetings: -15%
- Support: -10%
- Imprévus: -10%
- **Capacité nette:** 23 × 0.65 = **15 jours**
```

---

## Patterns d'erreurs communes

| Erreur | Symptôme | Solution |
|--------|----------|----------|
| Optimisme | Toujours en retard | Multiplier par 1.5 |
| Effet tunnel | "Presque fini" | Milestones intermédiaires |
| Scope creep | Features ajoutées | Change request process |
| Hero mode | Une personne fait tout | Bus factor > 1 |
| No buffer | Aucune marge | 20-30% buffer minimum |

---

## Règles d'or

1. **Qui fait, estime** - Les développeurs estiment, pas les managers
2. **Timeboxer** - Max 5 min par estimation
3. **Incertitude = gros** - Si doute, arrondir vers le haut
4. **Track & learn** - Comparer estimations vs réel
5. **Buffer explicite** - Toujours ajouter une marge visible
