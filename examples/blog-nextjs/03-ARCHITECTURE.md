# Architecture - Blog Personnel Next.js

**Date:** 2025-01-20
**Type:** Greenfield
**PRD:** [02-PRD.md](./02-PRD.md)

---

## 1. Vue d'ensemble

```
┌─────────────────────────────────────────────────────────────┐
│                         Vercel                              │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                    Next.js 14                         │  │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  │  │
│  │  │  Pages  │  │   MDX   │  │  API    │  │ Static  │  │  │
│  │  │ (SSG)   │  │ Content │  │ Routes  │  │ Assets  │  │  │
│  │  └────┬────┘  └────┬────┘  └────┬────┘  └────┬────┘  │  │
│  │       │            │            │            │        │  │
│  │       └────────────┴────────────┴────────────┘        │  │
│  │                         │                             │  │
│  │              ┌──────────┴──────────┐                  │  │
│  │              │   Content Layer     │                  │  │
│  │              │  (MDX + Frontmatter)│                  │  │
│  │              └─────────────────────┘                  │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Stack technique

| Couche | Technologie | Justification |
|--------|-------------|---------------|
| Framework | Next.js 14 (App Router) | SSG, excellent DX, écosystème riche |
| Contenu | MDX + Contentlayer | Type-safe, composants React dans MD |
| Style | Tailwind CSS | Utility-first, purge automatique |
| Thème | next-themes | Dark mode simple et robuste |
| Deploy | Vercel | Gratuit, preview branches, analytics |
| Icons | Lucide React | Léger, tree-shakable |

### Alternatives considérées

| Choix | Alternative | Raison du rejet |
|-------|-------------|-----------------|
| Next.js | Astro | Moins de flexibilité pour interactivité |
| Contentlayer | next-mdx-remote | Moins type-safe |
| Tailwind | CSS Modules | Plus de code à maintenir |

---

## 3. Structure du projet

```
blog/
├── app/
│   ├── layout.tsx           # Layout racine (providers)
│   ├── page.tsx             # Home (liste articles)
│   ├── about/
│   │   └── page.tsx         # Page à propos
│   ├── blog/
│   │   ├── page.tsx         # Liste articles (optionnel)
│   │   └── [slug]/
│   │       └── page.tsx     # Article individuel
│   ├── tags/
│   │   ├── page.tsx         # Liste des tags
│   │   └── [tag]/
│   │       └── page.tsx     # Articles par tag
│   └── feed.xml/
│       └── route.ts         # RSS feed
├── components/
│   ├── ui/                  # Composants génériques
│   │   ├── Button.tsx
│   │   ├── Card.tsx
│   │   └── ThemeToggle.tsx
│   ├── blog/                # Composants blog
│   │   ├── ArticleCard.tsx
│   │   ├── ArticleList.tsx
│   │   ├── TagList.tsx
│   │   └── TableOfContents.tsx
│   └── mdx/                 # Composants MDX custom
│       ├── Code.tsx         # Syntax highlighting
│       ├── Callout.tsx      # Notes/warnings
│       └── Image.tsx        # Images optimisées
├── content/
│   └── blog/                # Articles MDX
│       ├── hello-world.mdx
│       └── nextjs-tutorial.mdx
├── lib/
│   ├── content.ts           # Helpers Contentlayer
│   └── utils.ts             # Utilitaires
├── styles/
│   └── globals.css          # Tailwind + customs
├── contentlayer.config.ts   # Config Contentlayer
├── next.config.js
├── tailwind.config.js
└── tsconfig.json
```

---

## 4. Data Model

### Article (MDX Frontmatter)

```typescript
interface Article {
  // Required
  title: string;
  slug: string;           // Auto-généré depuis filename
  date: string;           // ISO 8601
  description: string;    // Meta description

  // Optional
  tags?: string[];
  image?: string;         // OG image
  draft?: boolean;        // Non publié si true
  readingTime?: string;   // Auto-calculé
}
```

### Exemple MDX

```mdx
---
title: "Introduction à Next.js 14"
date: "2025-01-15"
description: "Découvrez les nouvelles fonctionnalités de Next.js 14"
tags: ["nextjs", "react", "tutorial"]
---

# Introduction

Contenu de l'article...

<Callout type="info">
  Ceci est une note importante !
</Callout>
```

---

## 5. Routes et Pages

| Route | Type | Description |
|-------|------|-------------|
| `/` | SSG | Liste des derniers articles |
| `/blog/[slug]` | SSG | Article individuel |
| `/tags` | SSG | Liste de tous les tags |
| `/tags/[tag]` | SSG | Articles filtrés par tag |
| `/about` | SSG | Page à propos |
| `/feed.xml` | Route Handler | RSS feed |
| `/sitemap.xml` | Auto | Généré par Next.js |

---

## 6. Composants clés

### ThemeToggle
```typescript
// Gestion dark/light mode avec next-themes
// Persiste en localStorage
// SSR-safe (évite flash)
```

### ArticleCard
```typescript
// Carte article avec :
// - Titre (lien)
// - Date formatée
// - Description
// - Tags (liens)
// - Reading time
```

### MDX Components
```typescript
// Remplacement des éléments MD par défaut :
// - Code blocks avec syntax highlighting (shiki)
// - Images optimisées (next/image)
// - Callouts custom (info, warning, error)
// - Liens internes/externes différenciés
```

---

## 7. SEO Strategy

### Metadata dynamique
```typescript
export function generateMetadata({ params }): Metadata {
  const article = getArticle(params.slug);
  return {
    title: article.title,
    description: article.description,
    openGraph: {
      title: article.title,
      description: article.description,
      images: [article.image || '/og-default.png'],
    },
  };
}
```

### Sitemap
- Généré automatiquement par Next.js
- Inclut toutes les pages statiques
- Mis à jour à chaque build

### RSS
- Route handler `/feed.xml`
- Inclut titre, description, lien, date
- Valide W3C

---

## 8. Performance

| Optimisation | Implementation |
|--------------|----------------|
| Images | `next/image` avec lazy loading |
| Fonts | `next/font` avec subset |
| CSS | Tailwind purge en production |
| JS | Tree-shaking automatique |
| Caching | Headers Cache-Control |

---

## 9. Décisions d'architecture (ADRs)

### ADR-001: Contentlayer vs next-mdx-remote

**Contexte** : Besoin de parser MDX avec frontmatter typé.

**Décision** : Contentlayer

**Raisons** :
- Type-safety automatique
- Hot reload du contenu
- Validation du frontmatter
- Meilleur DX

**Conséquences** :
- Dépendance supplémentaire
- Config initiale plus complexe

---

### ADR-002: App Router vs Pages Router

**Contexte** : Next.js 14 offre deux modes de routing.

**Décision** : App Router

**Raisons** :
- Server Components par défaut
- Layouts imbriqués
- Meilleur streaming
- Future-proof

**Conséquences** :
- Certaines libs pas encore compatibles
- Learning curve

---

## 10. Risques techniques

| Risque | Mitigation |
|--------|------------|
| Contentlayer en beta | Fallback vers next-mdx-remote si abandon |
| Build time avec beaucoup d'articles | ISR si > 100 articles |
| Changements breaking Next.js | Pin version, tester avant upgrade |
