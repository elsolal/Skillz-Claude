# PRD Full - SaaS Dashboard

**Date:** 2025-01-20
**Mode:** FULL
**Version:** 1.0
**Brainstorm:** [01-BRAINSTORM.md](./01-BRAINSTORM.md)

---

## 1. Executive Summary

### Vision
Créer le dashboard de gestion de projets le plus simple et rapide du marché,
ciblant les petites équipes tech (2-15 personnes) avec un prix imbattable.

### Proposition de valeur
> "Gérez vos projets en équipe sans la complexité - setup en 2 min, $3/user/mois"

### Objectifs business

| Objectif | Métrique | Cible M6 | Cible M12 |
|----------|----------|----------|-----------|
| Acquisition | Users inscrits | 1,000 | 10,000 |
| Activation | Teams créées | 200 | 2,000 |
| Revenue | MRR | $500 | $5,000 |
| Retention | Churn mensuel | < 5% | < 3% |

---

## 2. Problème

### Personas

#### Persona 1: Sarah - Tech Lead
- **Âge:** 32 ans
- **Équipe:** 5 développeurs
- **Pain points:**
  - Jira est trop complexe pour son équipe
  - Trello manque de features (pas de sprint)
  - Linear est trop cher ($40/mois pour l'équipe)
- **Quote:** "Je veux juste voir qui fait quoi cette semaine"

#### Persona 2: Marc - Fondateur Startup
- **Âge:** 28 ans
- **Équipe:** 3 personnes (lui + 2 devs)
- **Pain points:**
  - Pas le temps de configurer des outils
  - Budget serré (bootstrap)
  - Veut tout au même endroit
- **Quote:** "J'ai besoin d'un truc qui marche en 5 minutes"

### Jobs to be Done

1. **Quand** je planifie un sprint, **je veux** voir toutes les tâches de l'équipe, **pour** distribuer le travail équitablement
2. **Quand** je code, **je veux** que mes PRs soient liées aux tâches, **pour** avoir un historique clair
3. **Quand** je rejoins l'équipe, **je veux** comprendre le projet rapidement, **pour** être productif vite

---

## 3. Solution

### Features MVP

| Feature | Description | Priorité |
|---------|-------------|----------|
| **Auth** | Magic link + GitHub OAuth | P0 |
| **Teams** | Création, invitations, rôles | P0 |
| **Projects** | CRUD, settings, archive | P0 |
| **Kanban** | Board avec drag & drop | P0 |
| **Tasks** | CRUD, assignation, labels | P0 |
| **Billing** | Free tier, Pro $3/user | P0 |
| **Notifications** | In-app + email digest | P1 |
| **Search** | Full-text sur tasks | P1 |
| **Activity** | Feed des changements | P2 |

### User Journey - Onboarding

```
1. Landing page → "Start free"
2. Sign up (GitHub OAuth) [30s]
3. Create team (nom) [10s]
4. Create first project [20s]
5. Add first task [30s]
6. Invite teammate [30s]
═══════════════════════════
Total: < 2 minutes
```

---

## 4. Scope détaillé

### In Scope (MVP)

#### Auth & Users
- [x] Sign up avec email (magic link)
- [x] Sign up avec GitHub OAuth
- [x] Login / Logout
- [x] Profile settings (nom, avatar)
- [x] Delete account

#### Teams
- [x] Créer une team
- [x] Inviter par email
- [x] Rôles: Owner, Admin, Member
- [x] Supprimer un membre
- [x] Transférer ownership
- [x] Supprimer la team

#### Projects
- [x] CRUD projects
- [x] Project settings (nom, description, couleur)
- [x] Archiver/Désarchiver
- [x] Membres du projet (subset de la team)

#### Tasks
- [x] CRUD tasks
- [x] Titre, description (markdown)
- [x] Statut: Backlog, Todo, In Progress, Done
- [x] Priorité: Low, Medium, High, Urgent
- [x] Assignee (1 personne)
- [x] Labels (custom par projet)
- [x] Due date
- [x] Drag & drop sur Kanban

#### Billing
- [x] Free tier: 1 projet, 3 membres
- [x] Pro tier: Illimité, $3/user/mois
- [x] Stripe Checkout
- [x] Gestion subscription (upgrade/downgrade)
- [x] Invoices

### Out of Scope (v1)

- [ ] GitHub sync (v2)
- [ ] Time tracking (v2)
- [ ] Comments sur tasks (v2)
- [ ] File attachments (v2)
- [ ] Mobile app (v3)
- [ ] API publique (v3)
- [ ] Webhooks (v3)
- [ ] Custom fields (v3)

---

## 5. Data Model

```typescript
interface User {
  id: string;
  email: string;
  name: string;
  avatar_url?: string;
  created_at: Date;
}

interface Team {
  id: string;
  name: string;
  slug: string;
  owner_id: string;
  plan: 'free' | 'pro';
  stripe_customer_id?: string;
  created_at: Date;
}

interface TeamMember {
  team_id: string;
  user_id: string;
  role: 'owner' | 'admin' | 'member';
  joined_at: Date;
}

interface Project {
  id: string;
  team_id: string;
  name: string;
  description?: string;
  color: string;
  archived: boolean;
  created_at: Date;
}

interface Task {
  id: string;
  project_id: string;
  title: string;
  description?: string;
  status: 'backlog' | 'todo' | 'in_progress' | 'done';
  priority: 'low' | 'medium' | 'high' | 'urgent';
  assignee_id?: string;
  due_date?: Date;
  position: number; // Pour l'ordre dans le Kanban
  created_by: string;
  created_at: Date;
  updated_at: Date;
}

interface Label {
  id: string;
  project_id: string;
  name: string;
  color: string;
}

interface TaskLabel {
  task_id: string;
  label_id: string;
}
```

---

## 6. Exigences non-fonctionnelles

| Catégorie | Exigence | Cible |
|-----------|----------|-------|
| **Performance** | Time to Interactive | < 2s |
| **Performance** | API response time | < 200ms p95 |
| **Performance** | Drag & drop latency | < 100ms |
| **Sécurité** | Auth | Supabase Auth (SOC2) |
| **Sécurité** | Data isolation | RLS PostgreSQL |
| **Sécurité** | Encryption | TLS 1.3, AES-256 at rest |
| **Disponibilité** | Uptime | 99.9% |
| **Scalabilité** | Users concurrent | 1,000 |

---

## 7. Risques et mitigations

| Risque | Prob. | Impact | Mitigation |
|--------|-------|--------|------------|
| RLS mal configuré → data leak | Medium | Critical | Tests de sécurité, audit |
| Stripe webhook fail → billing broken | Low | High | Retry logic, alerting |
| Supabase outage | Low | High | Status page monitoring |
| Performance Kanban 1000+ tasks | Medium | Medium | Virtualisation, pagination |
| Churn élevé | Medium | High | Onboarding email sequence |

---

## 8. Métriques de succès

### North Star Metric
**Weekly Active Teams** - Équipes avec ≥ 1 tâche créée/modifiée cette semaine

### Métriques secondaires

| Métrique | Définition | Cible |
|----------|------------|-------|
| Activation rate | % users → team created | > 60% |
| Task velocity | Tasks completed / week / team | > 10 |
| Invite rate | % teams avec ≥ 2 membres | > 40% |
| Conversion free→pro | % teams qui upgrade | > 5% |
| NPS | Net Promoter Score | > 40 |

---

## 9. Timeline

| Phase | Durée | Livrables |
|-------|-------|-----------|
| **Architecture** | 1j | Doc architecture, ADRs |
| **Epic 1: Auth** | 2j | Login, signup, profile |
| **Epic 2: Core** | 4j | Teams, Projects, Tasks, Kanban |
| **Epic 3: Billing** | 2j | Stripe integration |
| **Polish** | 2j | Tests, review, bugfix |
| **Launch** | 1j | Deploy, monitoring |
| **Total** | **12j** | |

---

## 10. Critères de succès MVP

- [ ] User peut s'inscrire en < 30s
- [ ] Team peut être créée et invitations envoyées
- [ ] Kanban board fonctionnel avec drag & drop fluide
- [ ] Billing Stripe fonctionne (test + prod)
- [ ] 0 faille de sécurité (data isolation)
- [ ] Lighthouse > 90
- [ ] 10 beta testers satisfaits
