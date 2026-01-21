# UX Design: Blog Next.js

> Généré par le skill `ux-designer` (v2.6)

## Personas

### Persona 1: Marie - La Lectrice

| Attribut | Détail |
|----------|--------|
| **Nom** | Marie Dubois |
| **Âge** | 28-35 ans |
| **Profession** | Développeuse Frontend |
| **Contexte** | Cherche à apprendre et se tenir à jour |

**Bio:**
Marie est développeuse frontend depuis 5 ans. Elle lit des blogs techniques pendant sa pause déjeuner et le soir. Elle préfère les articles concis avec des exemples de code.

**Objectifs:**
- Trouver rapidement des articles pertinents
- Apprendre de nouvelles techniques
- Sauvegarder des articles pour plus tard

**Frustrations:**
- Articles trop longs sans structure
- Pas de filtrage par tags
- Code non copiable facilement

**Citation typique:**
> "Je veux aller droit au but, pas lire 10 paragraphes d'intro."

---

### Persona 2: Alex - L'Auteur

| Attribut | Détail |
|----------|--------|
| **Nom** | Alex Martin |
| **Âge** | 32 ans |
| **Profession** | Tech Lead / Auteur du blog |
| **Contexte** | Partage son expertise et construit sa marque personnelle |

**Bio:**
Alex écrit des articles techniques pour partager ses apprentissages. Il veut un workflow simple : écrire en Markdown, push, publié.

**Objectifs:**
- Publier facilement en MDX
- Avoir des stats de lecture
- Être trouvé via Google

**Frustrations:**
- CMS complexes
- Pas de syntax highlighting
- SEO difficile à configurer

**Citation typique:**
> "Je veux écrire du Markdown, pas me battre avec un CMS."

---

## User Journeys

### Journey 1: Découverte d'un article (Marie)

**Persona:** Marie
**Objectif:** Trouver et lire un article sur React Server Components
**Contexte:** Pause déjeuner, 15 minutes disponibles

| Étape | Action | Pensée | Émotion | Opportunité |
|-------|--------|--------|---------|-------------|
| 1. Arrivée | Arrive via Google | "Voyons si c'est pertinent" | 😐 | SEO + preview claire |
| 2. Scan | Scanne le titre et intro | "Ça a l'air bien structuré" | 😊 | Table des matières |
| 3. Lecture | Lit l'article | "Les exemples sont clairs" | 😊 | Code copiable |
| 4. Action | Copie un snippet | "Je garde ça pour plus tard" | 😊 | Bouton copier |
| 5. Explore | Cherche articles liés | "Quoi d'autre sur ce sujet?" | 😊 | Tags + Related |

**Moments clés:**
- ⭐ **Moment de vérité:** Étape 2 - Décide de lire ou partir
- 🎯 **Moment de succès:** Étape 4 - Trouve ce qu'elle cherchait

---

### Journey 2: Publication d'un article (Alex)

**Persona:** Alex
**Objectif:** Publier un nouvel article technique
**Contexte:** Week-end, 2h disponibles pour écrire

| Étape | Action | Pensée | Émotion | Opportunité |
|-------|--------|--------|---------|-------------|
| 1. Création | Crée fichier .mdx | "Simple, j'aime ça" | 😊 | Template starter |
| 2. Rédaction | Écrit en Markdown | "Le live preview aide" | 😊 | Hot reload |
| 3. Code | Ajoute des snippets | "Syntax highlighting auto" | 😊 | Shiki/Prism |
| 4. Metadata | Ajoute frontmatter | "SEO facile" | 😊 | Frontmatter typé |
| 5. Publish | Git push | "C'est tout?" | 😊 | Deploy auto |

**Moments clés:**
- ⭐ **Moment de vérité:** Étape 3 - Le code doit être beau
- 🎯 **Moment de succès:** Étape 5 - Article live en 2 minutes

---

## Wireframes

### Page d'accueil

```
┌─────────────────────────────────────┐
│ [Logo]           Blog    About  [🔍]│
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────────────────────┐    │
│  │     Derniers articles       │    │
│  └─────────────────────────────┘    │
│                                     │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐│
│  │ Article │ │ Article │ │ Article ││
│  │ Card 1  │ │ Card 2  │ │ Card 3  ││
│  │ [tags]  │ │ [tags]  │ │ [tags]  ││
│  └─────────┘ └─────────┘ └─────────┘│
│                                     │
│  [Tags populaires: React, Next, TS] │
│                                     │
└─────────────────────────────────────┘
```

### Page Article

```
┌─────────────────────────────────────┐
│ [←]              Blog    About  [🔍]│
├─────────────────────────────────────┤
│                                     │
│  [Tag] [Tag]           5 min read   │
│                                     │
│  # Titre de l'article               │
│                                     │
│  Par Alex · 20 Jan 2024             │
│                                     │
│  ┌─ Table des matières ───────────┐ │
│  │ 1. Introduction                │ │
│  │ 2. Section 1                   │ │
│  │ 3. Section 2                   │ │
│  └────────────────────────────────┘ │
│                                     │
│  [Contenu de l'article...]          │
│                                     │
│  ```code``` [📋 Copier]             │
│                                     │
│  ─────────────────────────────────  │
│  Articles liés:                     │
│  [Card] [Card] [Card]               │
│                                     │
└─────────────────────────────────────┘
```

---

## Architecture de l'information

```
[Accueil]
├── [Blog] (liste des articles)
│   ├── [Article 1]
│   ├── [Article 2]
│   └── ...
├── [Tags]
│   ├── [/tags/react]
│   ├── [/tags/nextjs]
│   └── ...
├── [About]
└── [RSS]
```

---

## Métriques UX

| Métrique | Cible |
|----------|-------|
| Time to First Article | < 3 clics |
| Bounce Rate | < 40% |
| Avg. Time on Page | > 3 min |
| Code Copy Rate | > 20% des lecteurs |
