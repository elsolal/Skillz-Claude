# Template UX Design

> Template pour la documentation UX générée par le skill `ux-designer`.

## Structure du document UX

```markdown
# UX Design: [Nom du projet]

## Vue d'ensemble

### Problème utilisateur
[Description du problème que le produit résout]

### Objectifs UX
- [ ] [Objectif UX 1 - ex: Réduire le temps d'onboarding à < 2 min]
- [ ] [Objectif UX 2 - ex: Taux de complétion du tunnel > 80%]
- [ ] [Objectif UX 3 - ex: Score SUS > 70]

---

## Personas

### Persona 1: [Nom]

| Attribut | Détail |
|----------|--------|
| **Nom** | [Prénom Nom fictif] |
| **Âge** | [Tranche d'âge] |
| **Profession** | [Métier/Rôle] |
| **Contexte** | [Situation personnelle/professionnelle] |

**Bio:**
[2-3 phrases décrivant le persona]

**Objectifs:**
- [Objectif principal]
- [Objectif secondaire]

**Frustrations:**
- [Pain point 1]
- [Pain point 2]

**Comportements:**
- [Habitude digitale 1]
- [Habitude digitale 2]

**Citation typique:**
> "[Citation qui résume l'état d'esprit du persona]"

---

### Persona 2: [Nom]

[Même structure...]

---

## User Journeys

### Journey 1: [Nom du parcours]

**Persona:** [Nom du persona]
**Objectif:** [Ce que l'utilisateur veut accomplir]
**Contexte:** [Situation de départ]

| Étape | Action | Pensée | Émotion | Opportunité |
|-------|--------|--------|---------|-------------|
| 1. [Nom] | [Ce que fait l'user] | [Ce qu'il pense] | 😊/😐/😟 | [Amélioration possible] |
| 2. [Nom] | [Action] | [Pensée] | [Émotion] | [Opportunité] |
| 3. [Nom] | [Action] | [Pensée] | [Émotion] | [Opportunité] |
| 4. [Nom] | [Action] | [Pensée] | [Émotion] | [Opportunité] |
| 5. [Nom] | [Action] | [Pensée] | [Émotion] | [Opportunité] |

**Moments clés:**
- ⭐ **Moment de vérité:** [Étape critique où l'user décide de continuer ou abandonner]
- 🎯 **Moment de succès:** [Étape où l'user atteint son objectif]

**Métriques à suivre:**
- Taux de conversion étape X → Y
- Temps moyen sur l'étape Z
- Taux d'abandon à l'étape W

---

### Journey 2: [Nom du parcours]

[Même structure...]

---

## Wireframes

### Écran 1: [Nom de l'écran]

**Objectif:** [But de cet écran]
**Entrée:** [Comment l'user arrive ici]
**Sortie:** [Où l'user peut aller ensuite]

\`\`\`
┌─────────────────────────────────────┐
│ [Header]                        [≡] │
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────────────────────┐    │
│  │        [Titre H1]           │    │
│  └─────────────────────────────┘    │
│                                     │
│  [Description ou instruction]       │
│                                     │
│  ┌─────────────────────────────┐    │
│  │ [Input field]               │    │
│  └─────────────────────────────┘    │
│                                     │
│  ┌─────────────────────────────┐    │
│  │ [Input field]               │    │
│  └─────────────────────────────┘    │
│                                     │
│  ┌─────────────────────────────┐    │
│  │      [Primary Button]       │    │
│  └─────────────────────────────┘    │
│                                     │
│  [Lien secondaire]                  │
│                                     │
├─────────────────────────────────────┤
│ [Footer / Navigation]               │
└─────────────────────────────────────┘
\`\`\`

**Éléments:**
1. **Header:** [Description]
2. **Titre:** [Contenu et ton]
3. **Inputs:** [Champs requis et validation]
4. **CTA:** [Texte et action]

**États:**
- Default: [Description]
- Loading: [Description]
- Error: [Description]
- Success: [Description]

---

### Écran 2: [Nom de l'écran]

[Même structure...]

---

## Architecture de l'information

### Sitemap

\`\`\`
[Accueil]
├── [Section 1]
│   ├── [Page 1.1]
│   └── [Page 1.2]
├── [Section 2]
│   ├── [Page 2.1]
│   ├── [Page 2.2]
│   └── [Page 2.3]
├── [Section 3]
└── [Profil/Settings]
    ├── [Compte]
    ├── [Préférences]
    └── [Déconnexion]
\`\`\`

### Navigation

| Type | Éléments | Comportement |
|------|----------|--------------|
| **Principale** | [Items de nav] | [Desktop: header / Mobile: bottom bar] |
| **Secondaire** | [Items] | [Sidebar ou sous-menu] |
| **Contextuelle** | [Items] | [Breadcrumbs, back button] |

---

## Heuristiques de Nielsen

### Évaluation

| # | Heuristique | Score | Notes |
|---|-------------|-------|-------|
| 1 | Visibilité du statut système | ⭐⭐⭐ | [Feedback sur actions] |
| 2 | Correspondance système/monde réel | ⭐⭐⭐ | [Langage utilisateur] |
| 3 | Contrôle et liberté utilisateur | ⭐⭐⭐ | [Undo, cancel, back] |
| 4 | Cohérence et standards | ⭐⭐⭐ | [Patterns familiers] |
| 5 | Prévention des erreurs | ⭐⭐⭐ | [Confirmation, validation] |
| 6 | Reconnaissance plutôt que rappel | ⭐⭐⭐ | [Options visibles] |
| 7 | Flexibilité et efficacité | ⭐⭐⭐ | [Raccourcis experts] |
| 8 | Design esthétique et minimaliste | ⭐⭐⭐ | [Pas de bruit visuel] |
| 9 | Aide à reconnaître les erreurs | ⭐⭐⭐ | [Messages clairs] |
| 10 | Aide et documentation | ⭐⭐⭐ | [Aide contextuelle] |

---

## Micro-interactions

| Interaction | Trigger | Feedback | Règle |
|-------------|---------|----------|-------|
| [Bouton submit] | Click | Loading spinner → Success/Error | < 300ms ou loader |
| [Toggle] | Click | Animation slide | Immédiat |
| [Input validation] | On blur | Icône + message | Inline, non bloquant |
| [Notification] | Système | Toast 3s | Auto-dismiss |

---

## Accessibilité (a11y)

### Checklist WCAG 2.1 AA

**Perceptible:**
- [ ] Contraste texte/fond ≥ 4.5:1
- [ ] Texte redimensionnable jusqu'à 200%
- [ ] Alternatives textuelles pour images
- [ ] Sous-titres pour vidéos

**Utilisable:**
- [ ] Navigation au clavier complète
- [ ] Focus visible
- [ ] Pas de piège au clavier
- [ ] Temps suffisant pour lire/agir

**Compréhensible:**
- [ ] Langage clair et simple
- [ ] Navigation cohérente
- [ ] Labels explicites sur les inputs
- [ ] Messages d'erreur utiles

**Robuste:**
- [ ] HTML valide et sémantique
- [ ] Compatible lecteurs d'écran
- [ ] ARIA labels si nécessaire

---

## Métriques UX

| Métrique | Cible | Comment mesurer |
|----------|-------|-----------------|
| **Task Success Rate** | > 90% | Tests utilisateurs |
| **Time on Task** | < X min | Analytics |
| **Error Rate** | < 5% | Logs + Analytics |
| **SUS Score** | > 70 | Questionnaire |
| **NPS** | > 50 | Enquête |

---

## Livrables

- [ ] Personas validés
- [ ] User journeys documentés
- [ ] Wireframes des écrans clés
- [ ] Architecture de l'information
- [ ] Évaluation heuristique
- [ ] Checklist accessibilité
```

---

## Checklist de qualité UX

| Critère | Description |
|---------|-------------|
| **Personas réalistes** | Basés sur données/recherche, pas d'hypothèses |
| **Journeys complets** | Couvrent les parcours critiques |
| **Wireframes clairs** | Compréhensibles sans explication |
| **Cohérence** | Patterns réutilisés entre écrans |
| **Accessibilité** | WCAG 2.1 AA minimum |
| **Métriques définies** | Objectifs mesurables |
