# Brainstorm - SaaS Dashboard

**Date:** 2025-01-20
**Mode:** Research-first → Creative
**Durée:** 30 minutes

---

## Phase 1: Research-first (15 min)

### Analyse de la concurrence

| Produit | Forces | Faiblesses | Prix |
|---------|--------|------------|------|
| Linear | UX excellent, rapide | Cher, complexe | $8/user |
| Notion | Flexible, tout-en-un | Lent, learning curve | $8/user |
| Asana | Complet, intégrations | UI chargée | $10/user |
| Trello | Simple, visuel | Limité, basique | $5/user |

### Tendances identifiées

1. **Simplicité** : Les users veulent moins de features mais mieux exécutées
2. **Vitesse** : Performance = différenciateur (Linear)
3. **Collaboration** : Real-time editing, mentions, notifications
4. **Intégrations** : GitHub, Slack, Figma sont essentiels
5. **AI** : Tous ajoutent des features AI (résumés, suggestions)

### Hypothèses à valider

| Hypothèse | Validation | Statut |
|-----------|------------|--------|
| PME veulent un outil simple | 5 interviews | ✅ Validé |
| Prix < $5/user attire | Survey 50 réponses | ✅ Validé |
| Intégration GitHub critique | 80% demandent | ✅ Validé |
| AI est un nice-to-have | 60% indifférents | ⚠️ Partiel |

---

## Phase 2: Creative (15 min)

### Idée affinée

> "Un dashboard de gestion de projets ultra-simple et rapide pour les petites équipes tech,
> avec intégration GitHub native et prix agressif."

### Positionnement

```
                    Complexité
                        ↑
            Asana  •    │    • Notion
                        │
         ───────────────┼───────────────→ Prix
                        │
            Trello •    │    • NOUS
                        │
            Linear •    ↓
                    Simplicité
```

### Features prioritaires (MoSCoW)

| Must Have | Should Have | Could Have | Won't Have |
|-----------|-------------|------------|------------|
| Auth (email + OAuth) | Notifications | AI summaries | Gantt charts |
| Projects CRUD | File attachments | Time tracking | Resource planning |
| Tasks + Kanban | GitHub sync | Mobile app | Custom workflows |
| Team invite | Search | API public | |
| Billing (Stripe) | Activity feed | | |

### Différenciateurs

1. **Performance** : < 100ms pour toutes les interactions
2. **Prix** : $3/user/mois (le moins cher)
3. **GitHub-first** : Sync bidirectionnel issues/PRs
4. **Setup** : Onboarding en 2 minutes

---

## Synthèse

### Vision

> "Le Linear des petites équipes - rapide, simple, abordable."

### MVP Scope

1. **Auth** : Email magic link + GitHub OAuth
2. **Teams** : Création, invitation, rôles (admin/member)
3. **Projects** : CRUD avec Kanban board
4. **Tasks** : CRUD, assignation, statuts, priorités
5. **Billing** : Stripe Checkout, plans Free/Pro

### Architecture high-level

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Next.js   │───→│  Supabase   │───→│   Stripe    │
│  Frontend   │    │  Backend    │    │   Billing   │
└─────────────┘    └─────────────┘    └─────────────┘
       │                  │
       │           ┌──────┴──────┐
       │           │  PostgreSQL │
       │           │  + RLS      │
       └───────────┴─────────────┘
```

### Risques identifiés

| Risque | Impact | Mitigation |
|--------|--------|------------|
| Supabase limites free tier | Medium | Monitor usage, upgrade early |
| Stripe complexité | Medium | Utiliser Stripe Checkout (simple) |
| Real-time coûteux | Low | Commencer sans, ajouter après |
| Multi-tenant sécurité | High | RLS strict, tests de sécurité |

---

## Prochaine étape

**PRD détaillé** avec :
- User personas
- User journeys
- Wireframes low-fi
- Métriques de succès
