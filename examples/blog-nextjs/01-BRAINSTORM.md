# Brainstorm - Blog Personnel

**Date:** 2025-01-20
**Mode:** Creative
**Durée:** 15 minutes

---

## 1. Idée initiale

> "Je veux créer un blog personnel pour partager mes articles techniques"

## 2. Questions d'exploration

### Pourquoi ? (Five Whys)
1. **Pourquoi un blog ?** → Pour partager mes connaissances
2. **Pourquoi partager ?** → Pour aider d'autres développeurs
3. **Pourquoi des articles techniques ?** → C'est mon domaine d'expertise
4. **Pourquoi un blog personnel vs Medium ?** → Contrôle total sur le design et le contenu
5. **Pourquoi maintenant ?** → J'ai accumulé assez de contenu à partager

### Pour qui ?
- Développeurs junior/mid cherchant des tutoriels
- Moi-même (notes personnelles structurées)
- Recruteurs potentiels (portfolio)

### Quoi exactement ?
- Articles techniques (tutoriels, guides)
- Notes courtes (TIL - Today I Learned)
- Projets showcase

## 3. Exploration créative (SCAMPER)

| Technique | Application |
|-----------|-------------|
| **Substitute** | MDX au lieu de CMS classique → plus de contrôle |
| **Combine** | Blog + Portfolio + CV en un seul site |
| **Adapt** | S'inspirer de blogs comme Dan Abramov, Josh Comeau |
| **Modify** | Dark mode par défaut, toggle clair |
| **Put to other use** | Réutiliser les composants pour d'autres projets |
| **Eliminate** | Pas de commentaires (utiliser Twitter/GitHub) |
| **Reverse** | Écrire d'abord en markdown, site généré après |

## 4. Contraintes identifiées

| Contrainte | Impact | Mitigation |
|------------|--------|------------|
| Temps limité | Doit être simple à maintenir | MDX = juste des fichiers |
| SEO important | Doit être bien référencé | Next.js SSG + metadata |
| Performance | Doit charger vite | Images optimisées, minimal JS |

## 5. Décisions clés

- [x] **Framework** : Next.js 14 (App Router)
- [x] **Contenu** : MDX (Markdown + JSX)
- [x] **Style** : Tailwind CSS
- [x] **Hébergement** : Vercel (gratuit)
- [x] **Commentaires** : Non (liens vers Twitter)
- [x] **Analytics** : Plausible (privacy-friendly)

## 6. Synthèse validée ✅

**Vision** : Un blog technique minimaliste, rapide, et facile à maintenir.

**Scope MVP** :
1. Page d'accueil avec liste d'articles
2. Page article avec MDX
3. Page à propos
4. Système de tags
5. RSS feed
6. Dark/Light mode

**Prochaine étape** : PRD détaillé
