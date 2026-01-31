# Debate Templates

> Templates pour les 4 rounds du système Multi-Mind.

---

## Round 1 : CRITIQUE

### Prompt pour chaque agent

```markdown
Analyse le document suivant en tant que [AGENT_ROLE].

Document à analyser :
---
[DOCUMENT_CONTENT]
---

Fournis une critique structurée :

1. **Score global** : X/10

2. **Points forts** (3 max) :
   - [Point 1]
   - [Point 2]
   - [Point 3]

3. **Points faibles** (5 max) :
   - [Critique 1] - Sévérité: [Critique/Majeure/Mineure]
   - [Critique 2] - Sévérité: [Critique/Majeure/Mineure]
   - ...

4. **Risques identifiés** :
   - [Risque 1] - Probabilité: [Haute/Moyenne/Basse]
   - [Risque 2] - Probabilité: [Haute/Moyenne/Basse]

5. **Recommandations prioritaires** (3 max) :
   - [Recommandation 1]
   - [Recommandation 2]
   - [Recommandation 3]

Sois spécifique et constructif. Chaque critique doit être accompagnée d'une suggestion d'amélioration.
```

### Output attendu

```markdown
### [EMOJI] [AGENT_NAME] - [AGENT_ROLE]

**Score : X/10**

#### Points forts
1. [Description du point fort]
2. [Description du point fort]
3. [Description du point fort]

#### Points faibles
| # | Critique | Sévérité |
|---|----------|----------|
| 1 | [Description] | [Critique/Majeure/Mineure] |
| 2 | [Description] | [Critique/Majeure/Mineure] |

#### Risques
| Risque | Probabilité | Impact |
|--------|-------------|--------|
| [Description] | [H/M/B] | [H/M/B] |

#### Recommandations
1. [Recommandation prioritaire]
2. [Recommandation secondaire]
3. [Recommandation tertiaire]
```

---

## Round 2 : CONFRONTATION

### Prompt pour chaque agent

```markdown
Voici les critiques des autres agents sur le document :

[AUTRES_CRITIQUES]

En tant que [AGENT_ROLE], réponds à ces critiques :

1. **Accords** :
   - Avec qui es-tu d'accord et sur quels points ?
   - Pourquoi ces points sont-ils valides ?

2. **Désaccords** :
   - Avec qui es-tu en désaccord et sur quels points ?
   - Argumente ta position différente

3. **Nouvelle perspective** :
   - Après lecture des autres critiques, as-tu une nouvelle perspective ?
   - Y a-t-il des points que tu avais manqués ?

4. **Points de consensus émergents** :
   - Quels points semblent faire l'unanimité ?
   - Quels points restent fortement contestés ?

Sois constructif dans tes désaccords. L'objectif est d'améliorer le document, pas de "gagner" le débat.
```

### Output attendu

```markdown
### [EMOJI] [AGENT_NAME] répond

#### Accords
- **Avec [Agent]** sur [Point] : [Justification]
- **Avec [Agent]** sur [Point] : [Justification]

#### Désaccords
- **Avec [Agent]** sur [Point] :
  - Leur position : [Résumé]
  - Ma position : [Argument]
  - Proposition de compromis : [Solution]

#### Nouvelle perspective
[Insight après lecture des autres critiques]

#### Points de consensus émergents
- [Point 1] : [Agents d'accord]
- [Point 2] : [Agents d'accord]
```

---

## Round 3 : CONVERGENCE

### Prompt pour chaque agent

```markdown
Après le débat, donne ton TOP 3 des points les plus importants à traiter.

Pour chaque point :
1. **Description** : Qu'est-ce qui doit être changé/amélioré ?
2. **Justification** : Pourquoi ce point est-il prioritaire ?
3. **Effort estimé** : [Faible/Moyen/Élevé]
4. **Impact** : [Critique/Important/Souhaitable]

Classe tes 3 points par ordre de priorité (1 = plus important).
```

### Output attendu

```markdown
### [EMOJI] [AGENT_NAME] - TOP 3

| Rang | Point | Justification | Effort | Impact |
|------|-------|---------------|--------|--------|
| 1 | [Point] | [Pourquoi] | [F/M/É] | [C/I/S] |
| 2 | [Point] | [Pourquoi] | [F/M/É] | [C/I/S] |
| 3 | [Point] | [Pourquoi] | [F/M/É] | [C/I/S] |
```

### Calcul du score pondéré

```
Score = Σ (Points × Pondération_Agent × Impact_Weight)

Impact_Weight :
- Critique = 3
- Important = 2
- Souhaitable = 1

Pondération_Agent : Voir agent-personalities.md
```

---

## Round 4 : CONSENSUS

### Template de synthèse (Claude)

```markdown
## Synthèse Multi-Mind

### Métadonnées
- **Document** : [Nom du fichier]
- **Mode** : [PRD/Review]
- **Agents actifs** : [N]/6
- **Durée totale** : [X]m [Y]s

### Scores des agents

| Agent | Score | Focus principal |
|-------|-------|-----------------|
| [Agent 1] | X/10 | [Focus] |
| [Agent 2] | X/10 | [Focus] |
| ... | ... | ... |

**Score moyen** : X.X/10

### Points de consensus ([N] points)

Points sur lesquels la majorité des agents s'accordent :

| # | Point | Agents d'accord | Priorité |
|---|-------|-----------------|----------|
| 1 | [Description] | [Emojis agents] | P0 |
| 2 | [Description] | [Emojis agents] | P1 |
| ... | ... | ... | ... |

### Divergences ([N] points)

Points où les agents ne s'accordent pas :

| Point | Position A | Position B | Recommandation |
|-------|------------|------------|----------------|
| [Point] | [Agents] : [Position] | [Agents] : [Position] | [Ma recommandation] |

### TOP 5 Actions prioritaires

Actions concrètes à entreprendre, classées par priorité :

| # | Priorité | Action | Effort | Responsable suggéré |
|---|----------|--------|--------|---------------------|
| 1 | **P0** | [Action critique] | [F/M/É] | [Dev/PM/Design] |
| 2 | **P1** | [Action importante] | [F/M/É] | [Dev/PM/Design] |
| 3 | **P1** | [Action importante] | [F/M/É] | [Dev/PM/Design] |
| 4 | **P2** | [Action souhaitable] | [F/M/É] | [Dev/PM/Design] |
| 5 | **P2** | [Action souhaitable] | [F/M/É] | [Dev/PM/Design] |

### Recommandation finale

[Synthèse de 3-5 phrases avec la recommandation principale de Claude basée sur le débat complet]

### Risques résiduels

Points d'attention qui méritent un suivi :

- [ ] [Risque 1]
- [ ] [Risque 2]
- [ ] [Risque 3]
```

---

## Matrice des accords/désaccords

Template pour visualiser les positions après le Round 2 :

```markdown
### Matrice des positions

|  | Claude | GPT | Gemini | DeepSeek | GLM | Kimi |
|--|--------|-----|--------|----------|-----|------|
| Point A | | | | | | |
| Point B | | | | | | |
| Point C | | | | | | |

Légende :
- : D'accord
-  : Mitigé
-  : En désaccord
```

---

## Format du rapport final

```markdown
# Multi-Mind Debate Report

**Date** : [YYYY-MM-DD HH:MM]
**Mode** : [PRD|Review]
**Fichier** : [path/to/file]
**Agents** : [N]/6
**Durée** : [X]m [Y]s

---

## Résumé exécutif

[3-5 phrases résumant le débat et ses conclusions principales]

---

## Round 1 : Critiques individuelles

[Critiques complètes de chaque agent, format détaillé]

---

## Round 2 : Confrontations

[Réponses et débats entre agents]

### Matrice des positions
[Matrice visuelle]

---

## Round 3 : Convergence

### TOP 3 par agent
[Liste des TOP 3 de chaque agent]

### Classement pondéré global
[TOP 5 après pondération]

---

## Round 4 : Synthèse finale

[Synthèse complète avec consensus, divergences, actions]

---

## Annexes

### Prompts utilisés
[Référence aux prompts de chaque round]

### Configuration des agents
[API utilisées, modèles, tokens]
```
