# PRD Full - Blog Personnel Next.js

**Date:** 2025-01-20
**Mode:** FULL
**Version:** 1.0

---

## 1. Executive Summary

### Vision
Un blog technique personnel, minimaliste et performant, permettant de publier des articles en MDX avec un système de tags et une excellente expérience de lecture.

### Objectifs
| Objectif | Métrique | Cible |
|----------|----------|-------|
| Performance | Lighthouse | > 95 |
| SEO | Articles indexés | 100% |
| Maintenabilité | Temps ajout article | < 5 min |
| Engagement | Temps sur page | > 2 min |

---

## 2. Problème

### Contexte
Les plateformes de blogging existantes (Medium, Dev.to) limitent le contrôle sur le design et monétisent le contenu des auteurs.

### Pain Points
1. **Pas de contrôle** sur le design et l'UX
2. **Dépendance** à une plateforme tierce
3. **Pas de propriété** du contenu et de l'audience
4. **Limitations** sur le code interactif dans les articles

### Opportunité
Créer un blog auto-hébergé avec contrôle total, utilisant MDX pour des articles interactifs.

---

## 3. Solution

### Description
Blog statique généré avec Next.js, contenu en MDX, déployé sur Vercel.

### Différenciateurs
| Feature | Medium | Dev.to | Notre solution |
|---------|--------|--------|----------------|
| Design custom | ❌ | ❌ | ✅ |
| Code interactif | ❌ | Limité | ✅ MDX |
| Propriété données | ❌ | ❌ | ✅ |
| Gratuit | Freemium | ✅ | ✅ |

---

## 4. Scope

### In Scope (MVP)
- [x] Page d'accueil avec liste d'articles
- [x] Page article individuelle (MDX)
- [x] Page à propos
- [x] Système de tags avec pages dédiées
- [x] Dark/Light mode
- [x] RSS feed
- [x] SEO optimisé (metadata, sitemap)
- [x] Responsive design

### Out of Scope (v1)
- [ ] Commentaires
- [ ] Newsletter
- [ ] Recherche full-text
- [ ] Internationalisation
- [ ] Analytics dashboard

### Future (v2)
- Newsletter avec Buttondown
- Recherche avec Algolia
- Série d'articles liés

---

## 5. User Stories Summary

### Epic 1: Core Blog
| Story | Priorité | Taille |
|-------|----------|--------|
| Afficher liste articles | P0 | M |
| Lire un article MDX | P0 | L |
| Naviguer par tags | P1 | M |

### Epic 2: Experience
| Story | Priorité | Taille |
|-------|----------|--------|
| Toggle dark/light mode | P1 | S |
| Page à propos | P2 | S |
| RSS feed | P2 | S |

### Epic 3: SEO
| Story | Priorité | Taille |
|-------|----------|--------|
| Metadata dynamique | P0 | M |
| Sitemap auto-généré | P1 | S |
| Open Graph images | P2 | M |

---

## 6. Exigences non-fonctionnelles

| Catégorie | Exigence | Cible |
|-----------|----------|-------|
| Performance | First Contentful Paint | < 1.5s |
| Performance | Largest Contentful Paint | < 2.5s |
| Accessibilité | WCAG | AA |
| SEO | Core Web Vitals | Tous verts |
| Sécurité | Headers | A+ sur securityheaders.com |

---

## 7. Risques

| Risque | Probabilité | Impact | Mitigation |
|--------|-------------|--------|------------|
| MDX complexe | Medium | Medium | Commencer simple, ajouter composants progressivement |
| Build time long | Low | Low | ISR si besoin |
| Maintenance contenu | Medium | High | Scripts d'aide à la création |

---

## 8. Timeline

| Phase | Durée | Livrables |
|-------|-------|-----------|
| Architecture | 0.5j | Doc architecture |
| Core Blog | 1.5j | Liste + Article |
| Experience | 1j | Dark mode, About, RSS |
| SEO | 0.5j | Metadata, Sitemap |
| Polish | 0.5j | Tests, review |
| **Total** | **4j** | |

---

## 9. Critères de succès

- [ ] Lighthouse > 95 sur toutes les pages
- [ ] 0 erreur console
- [ ] Responsive sur mobile/tablet/desktop
- [ ] RSS valide (validator.w3.org)
- [ ] Sitemap valide
- [ ] Premier article publié
