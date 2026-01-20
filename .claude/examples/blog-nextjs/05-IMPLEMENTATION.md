# Notes d'implémentation - Blog Next.js

## Commandes utilisées

```bash
# Phase Discovery
/discovery "Blog personnel avec Next.js et MDX"

# Workflow automatique :
# 1. Brainstorm (mode Creative)
# 2. PRD (mode FULL détecté)
# 3. Architecture
# 4. Stories (Readiness Check 15/15)

# Phase Développement
/feature #1  # Story 1.1 - Setup
/feature #2  # Story 1.2 - Liste articles
# ... etc
```

## Temps réel vs estimé

| Phase | Estimé | Réel | Notes |
|-------|--------|------|-------|
| Brainstorm | 15min | 12min | Idée claire dès le départ |
| PRD | 1h | 1h15 | Ajout section NFR |
| Architecture | 1h | 45min | Stack familier |
| Stories | 1h | 1h | Readiness Check utile |
| Setup (1.1) | 2h | 2h30 | Contentlayer config |
| Liste (1.2) | 2h | 1h30 | Plus simple que prévu |
| Article (1.3) | 3h | 4h | Syntax highlighting |
| Dark mode (3.1) | 1h | 45min | next-themes simple |
| Tags (2.1) | 2h | 2h | Comme prévu |
| SEO (4.1, 4.2) | 2h | 1h30 | Next.js fait le travail |
| RSS (3.2) | 1h | 1h | |
| About (2.2) | 30min | 30min | |
| **Total** | **4j** | **3.5j** | |

## Leçons apprises

### Ce qui a bien marché

1. **Contentlayer** : Excellent DX, types auto-générés
2. **next-themes** : Dark mode sans flash, 5 lignes de code
3. **Tailwind Typography** : Prose class pour articles
4. **generateStaticParams** : Build time rapide

### Difficultés rencontrées

1. **Syntax highlighting** : Shiki vs Prism
   - Solution : Rehype-pretty-code avec Shiki
   - Config dans contentlayer.config.ts

2. **Images MDX** : next/image dans MDX
   - Solution : Composant Image custom dans mdx-components.tsx

3. **RSS avec App Router** : Route handler vs API route
   - Solution : `app/feed.xml/route.ts` avec Response

### Code notable

```typescript
// lib/content.ts - Helper pour articles
export function getArticles() {
  return allPosts
    .filter((post) => !post.draft)
    .sort((a, b) =>
      new Date(b.date).getTime() - new Date(a.date).getTime()
    );
}

// Metadata dynamique
export async function generateMetadata({ params }): Promise<Metadata> {
  const post = allPosts.find((p) => p.slug === params.slug);
  if (!post) return {};

  return {
    title: post.title,
    description: post.description,
    openGraph: {
      title: post.title,
      description: post.description,
      type: 'article',
      publishedTime: post.date,
      authors: ['Ton Nom'],
    },
  };
}
```

## Checklist finale

- [x] Lighthouse > 95 (Score: 98)
- [x] 0 erreur console
- [x] Responsive mobile/tablet/desktop
- [x] RSS valide (validator.w3.org)
- [x] Sitemap valide
- [x] Dark mode fonctionne
- [x] Premier article "Hello World" publié
- [x] Tests passent (Vitest)
- [x] Review 3 passes OK

## Déploiement

```bash
# Push sur GitHub
git push origin main

# Vercel auto-deploy
# Preview: blog-xyz.vercel.app
# Prod: blog.mondomaine.com
```

## Prochaines améliorations (v2)

- [ ] Newsletter (Buttondown)
- [ ] Recherche (Algolia)
- [ ] Série d'articles liés
- [ ] Commentaires (Giscus)
- [ ] OG images générées (Satori)
