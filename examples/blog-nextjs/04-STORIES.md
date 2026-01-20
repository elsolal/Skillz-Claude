# Epics & Stories - Blog Personnel Next.js

**PRD:** [02-PRD.md](./02-PRD.md)
**Architecture:** [03-ARCHITECTURE.md](./03-ARCHITECTURE.md)

---

## Epic 1: Core Blog Infrastructure
> Setup du projet et affichage des articles

### Story 1.1: Setup projet Next.js
**Taille:** M | **Priorité:** P0 | **Tags:** `setup`, `infra`

**En tant que** développeur,
**Je veux** un projet Next.js 14 configuré,
**Afin de** commencer le développement.

**Critères d'acceptance:**
```gherkin
Given un nouveau projet
When je lance npm run dev
Then le serveur démarre sans erreur
And Tailwind CSS fonctionne
And TypeScript compile
```

**Tâches techniques:**
- [ ] `npx create-next-app@latest` avec App Router
- [ ] Configurer Tailwind CSS
- [ ] Configurer Contentlayer
- [ ] Structure des dossiers
- [ ] ESLint + Prettier

---

### Story 1.2: Afficher liste d'articles
**Taille:** M | **Priorité:** P0 | **Tags:** `feature`, `home`

**En tant que** visiteur,
**Je veux** voir la liste des articles sur la home,
**Afin de** découvrir le contenu du blog.

**Critères d'acceptance:**
```gherkin
Given des articles MDX existent dans content/blog/
When je visite la page d'accueil
Then je vois les articles triés par date décroissante
And chaque article affiche titre, date, description, tags
And les drafts ne sont pas affichés
```

**Dépendances:** Story 1.1

---

### Story 1.3: Lire un article MDX
**Taille:** L | **Priorité:** P0 | **Tags:** `feature`, `article`

**En tant que** visiteur,
**Je veux** lire un article complet,
**Afin de** consommer le contenu.

**Critères d'acceptance:**
```gherkin
Given un article "hello-world" existe
When je visite /blog/hello-world
Then je vois le contenu MDX rendu en HTML
And les composants custom (Callout, Code) fonctionnent
And le reading time est affiché
And les liens vers tags sont cliquables
```

**Dépendances:** Story 1.1

---

## Epic 2: Navigation & Tags
> Système de tags et navigation

### Story 2.1: Naviguer par tags
**Taille:** M | **Priorité:** P1 | **Tags:** `feature`, `navigation`

**En tant que** visiteur,
**Je veux** filtrer les articles par tag,
**Afin de** trouver du contenu sur un sujet précis.

**Critères d'acceptance:**
```gherkin
Given des articles avec le tag "nextjs" existent
When je visite /tags/nextjs
Then je vois uniquement les articles avec ce tag
And le nombre d'articles est affiché

Given je suis sur /tags
Then je vois tous les tags avec leur count
```

**Dépendances:** Story 1.2

---

### Story 2.2: Page à propos
**Taille:** S | **Priorité:** P2 | **Tags:** `feature`, `page`

**En tant que** visiteur,
**Je veux** en savoir plus sur l'auteur,
**Afin de** connaître qui écrit le blog.

**Critères d'acceptance:**
```gherkin
Given je visite /about
Then je vois une présentation de l'auteur
And des liens vers réseaux sociaux
And une photo (optionnel)
```

---

## Epic 3: User Experience
> Dark mode et améliorations UX

### Story 3.1: Toggle Dark/Light mode
**Taille:** S | **Priorité:** P1 | **Tags:** `ux`, `theme`

**En tant que** visiteur,
**Je veux** choisir le thème du site,
**Afin d'** avoir un confort de lecture adapté.

**Critères d'acceptance:**
```gherkin
Given je suis sur le site
When je clique sur le toggle de thème
Then le thème change immédiatement
And mon choix est persisté (localStorage)
And pas de flash au rechargement (SSR-safe)
```

---

### Story 3.2: RSS Feed
**Taille:** S | **Priorité:** P2 | **Tags:** `feature`, `feed`

**En tant que** lecteur,
**Je veux** m'abonner au RSS,
**Afin de** recevoir les nouveaux articles.

**Critères d'acceptance:**
```gherkin
Given je visite /feed.xml
Then je reçois un XML RSS valide
And il contient tous les articles publiés
And le feed passe la validation W3C
```

---

## Epic 4: SEO & Performance
> Optimisation pour les moteurs de recherche

### Story 4.1: Metadata dynamique
**Taille:** M | **Priorité:** P0 | **Tags:** `seo`, `meta`

**En tant que** moteur de recherche,
**Je veux** des metadata correctes sur chaque page,
**Afin d'** indexer correctement le contenu.

**Critères d'acceptance:**
```gherkin
Given je visite un article
Then la balise <title> contient le titre de l'article
And <meta description> est présente
And Open Graph tags sont corrects
And Twitter Card tags sont présents
```

---

### Story 4.2: Sitemap automatique
**Taille:** S | **Priorité:** P1 | **Tags:** `seo`, `sitemap`

**En tant que** moteur de recherche,
**Je veux** un sitemap à jour,
**Afin de** découvrir toutes les pages.

**Critères d'acceptance:**
```gherkin
Given je visite /sitemap.xml
Then je reçois un sitemap XML valide
And toutes les pages sont listées
And les dates de modification sont correctes
```

---

## Readiness Check: 15/15 ✅

| Critère | Score | Détail |
|---------|-------|--------|
| Stories INVEST | 3/3 | Indépendantes, Négociables, Valuable, Estimables, Small, Testables |
| Critères Given/When/Then | 3/3 | Tous les AC en Gherkin |
| Estimations cohérentes | 2/2 | S/M/L appropriés |
| Priorités définies | 2/2 | P0 > P1 > P2 claire |
| Dépendances identifiées | 3/3 | Dépendances explicites |
| Risques techniques | 2/2 | Contentlayer beta, App Router |

**Prêt pour implémentation !**

---

## Ordre d'implémentation recommandé

```
1. Story 1.1 (Setup)           ─────┐
2. Story 1.2 (Liste articles)  ─────┼─→ MVP Core
3. Story 1.3 (Article MDX)     ─────┘
4. Story 4.1 (Metadata)        ─────→ SEO de base
5. Story 3.1 (Dark mode)       ─────→ UX
6. Story 2.1 (Tags)            ─────→ Navigation
7. Story 4.2 (Sitemap)         ─────┐
8. Story 3.2 (RSS)             ─────┼─→ Finalisation
9. Story 2.2 (About)           ─────┘
```
