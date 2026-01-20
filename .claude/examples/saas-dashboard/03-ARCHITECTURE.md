# Architecture - SaaS Dashboard

**Date:** 2025-01-20
**Type:** Greenfield
**PRD:** [02-PRD.md](./02-PRD.md)

---

## 1. Vue d'ensemble

```
┌────────────────────────────────────────────────────────────────────────────┐
│                              ARCHITECTURE                                   │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                            │
│    ┌──────────────┐         ┌──────────────┐        ┌──────────────┐      │
│    │              │         │              │        │              │      │
│    │    Vercel    │────────→│   Supabase   │←───────│    Stripe    │      │
│    │   (Next.js)  │         │   (Backend)  │        │   (Billing)  │      │
│    │              │         │              │        │              │      │
│    └──────┬───────┘         └──────┬───────┘        └──────────────┘      │
│           │                        │                                       │
│           │    ┌───────────────────┼───────────────────┐                  │
│           │    │                   │                   │                  │
│           ▼    ▼                   ▼                   ▼                  │
│    ┌──────────────┐         ┌──────────────┐    ┌──────────────┐         │
│    │   Supabase   │         │  PostgreSQL  │    │   Supabase   │         │
│    │     Auth     │         │   + RLS      │    │   Storage    │         │
│    └──────────────┘         └──────────────┘    └──────────────┘         │
│                                                                            │
└────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Stack technique

| Couche | Technologie | Justification |
|--------|-------------|---------------|
| **Frontend** | Next.js 14 (App Router) | SSR, excellent DX, Vercel native |
| **UI** | Tailwind + shadcn/ui | Composants accessibles, customisables |
| **State** | Zustand + React Query | Simple, performant, cache |
| **Backend** | Supabase | Auth + DB + Storage + Realtime |
| **Database** | PostgreSQL | Robuste, RLS pour multi-tenant |
| **Auth** | Supabase Auth | Magic link, OAuth, JWT |
| **Billing** | Stripe | Standard industrie |
| **Deploy** | Vercel | Preview, Edge, Analytics |
| **Monitoring** | Sentry + Vercel Analytics | Errors + Performance |

### Alternatives rejetées

| Choix | Alternative | Raison du rejet |
|-------|-------------|-----------------|
| Supabase | Firebase | SQL > NoSQL pour relations |
| Supabase | Prisma + PlanetScale | Plus de setup, moins intégré |
| shadcn/ui | Radix seul | shadcn pré-stylé = plus rapide |
| Zustand | Redux | Overkill, plus de boilerplate |
| Stripe | Paddle | Moins de contrôle, plus cher |

---

## 3. Structure du projet

```
dashboard/
├── app/
│   ├── (auth)/
│   │   ├── login/page.tsx
│   │   ├── signup/page.tsx
│   │   └── callback/route.ts      # OAuth callback
│   ├── (dashboard)/
│   │   ├── layout.tsx             # Sidebar + Header
│   │   ├── page.tsx               # Redirect to team
│   │   └── [teamSlug]/
│   │       ├── page.tsx           # Team overview
│   │       ├── settings/
│   │       │   ├── page.tsx       # Team settings
│   │       │   ├── members/page.tsx
│   │       │   └── billing/page.tsx
│   │       └── projects/
│   │           ├── page.tsx       # Projects list
│   │           └── [projectId]/
│   │               ├── page.tsx   # Kanban board
│   │               └── settings/page.tsx
│   ├── api/
│   │   └── webhooks/
│   │       └── stripe/route.ts    # Stripe webhooks
│   └── layout.tsx
├── components/
│   ├── ui/                        # shadcn components
│   ├── auth/
│   ├── dashboard/
│   ├── projects/
│   ├── tasks/
│   │   ├── KanbanBoard.tsx
│   │   ├── KanbanColumn.tsx
│   │   ├── TaskCard.tsx
│   │   └── TaskDialog.tsx
│   └── billing/
├── lib/
│   ├── supabase/
│   │   ├── client.ts              # Browser client
│   │   ├── server.ts              # Server client
│   │   └── middleware.ts          # Auth middleware
│   ├── stripe/
│   │   └── client.ts
│   ├── hooks/
│   │   ├── useTeam.ts
│   │   ├── useProjects.ts
│   │   └── useTasks.ts
│   └── utils/
├── stores/
│   ├── kanban-store.ts            # Zustand pour drag & drop
│   └── ui-store.ts
├── types/
│   └── database.ts                # Types générés Supabase
└── supabase/
    ├── migrations/
    └── seed.sql
```

---

## 4. Database Schema

### Tables

```sql
-- Users (géré par Supabase Auth, mais étendu)
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users PRIMARY KEY,
  email TEXT NOT NULL,
  name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Teams
CREATE TABLE public.teams (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  owner_id UUID REFERENCES public.profiles NOT NULL,
  plan TEXT DEFAULT 'free' CHECK (plan IN ('free', 'pro')),
  stripe_customer_id TEXT,
  stripe_subscription_id TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Team Members
CREATE TABLE public.team_members (
  team_id UUID REFERENCES public.teams ON DELETE CASCADE,
  user_id UUID REFERENCES public.profiles ON DELETE CASCADE,
  role TEXT DEFAULT 'member' CHECK (role IN ('owner', 'admin', 'member')),
  joined_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (team_id, user_id)
);

-- Projects
CREATE TABLE public.projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  team_id UUID REFERENCES public.teams ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  color TEXT DEFAULT '#6366f1',
  archived BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tasks
CREATE TABLE public.tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID REFERENCES public.projects ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  status TEXT DEFAULT 'backlog' CHECK (status IN ('backlog', 'todo', 'in_progress', 'done')),
  priority TEXT DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high', 'urgent')),
  assignee_id UUID REFERENCES public.profiles,
  due_date DATE,
  position INTEGER DEFAULT 0,
  created_by UUID REFERENCES public.profiles NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Labels
CREATE TABLE public.labels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID REFERENCES public.projects ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL,
  color TEXT NOT NULL
);

-- Task Labels (junction)
CREATE TABLE public.task_labels (
  task_id UUID REFERENCES public.tasks ON DELETE CASCADE,
  label_id UUID REFERENCES public.labels ON DELETE CASCADE,
  PRIMARY KEY (task_id, label_id)
);

-- Team Invitations
CREATE TABLE public.invitations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  team_id UUID REFERENCES public.teams ON DELETE CASCADE NOT NULL,
  email TEXT NOT NULL,
  role TEXT DEFAULT 'member',
  invited_by UUID REFERENCES public.profiles NOT NULL,
  expires_at TIMESTAMPTZ DEFAULT NOW() + INTERVAL '7 days',
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### Row Level Security (RLS)

```sql
-- Profiles: Users can only see/edit their own profile
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own profile"
  ON public.profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON public.profiles FOR UPDATE
  USING (auth.uid() = id);

-- Teams: Members can view, admins+ can edit
ALTER TABLE public.teams ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Team members can view team"
  ON public.teams FOR SELECT
  USING (
    id IN (
      SELECT team_id FROM public.team_members
      WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Team admins can update team"
  ON public.teams FOR UPDATE
  USING (
    id IN (
      SELECT team_id FROM public.team_members
      WHERE user_id = auth.uid()
      AND role IN ('owner', 'admin')
    )
  );

-- Tasks: Team members can CRUD tasks in their projects
ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Team members can manage tasks"
  ON public.tasks FOR ALL
  USING (
    project_id IN (
      SELECT p.id FROM public.projects p
      JOIN public.team_members tm ON tm.team_id = p.team_id
      WHERE tm.user_id = auth.uid()
    )
  );
```

---

## 5. API Routes

### Supabase (auto-generated)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/rest/v1/teams` | List user's teams |
| POST | `/rest/v1/teams` | Create team |
| GET | `/rest/v1/projects?team_id=X` | List projects |
| GET | `/rest/v1/tasks?project_id=X` | List tasks |
| PATCH | `/rest/v1/tasks?id=X` | Update task |

### Custom API Routes (Next.js)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/webhooks/stripe` | Stripe webhooks |
| POST | `/api/invitations/[id]/accept` | Accept team invite |
| POST | `/api/teams/[slug]/billing/portal` | Stripe portal |

---

## 6. Auth Flow

```
┌─────────┐     ┌─────────┐     ┌─────────┐     ┌─────────┐
│  User   │────→│ Signup  │────→│ Verify  │────→│Dashboard│
│         │     │  Page   │     │  Email  │     │         │
└─────────┘     └────┬────┘     └─────────┘     └─────────┘
                     │
                     │ GitHub OAuth
                     ▼
               ┌─────────┐
               │ Callback│────→ Create Profile → Dashboard
               │  Route  │
               └─────────┘
```

### Middleware

```typescript
// middleware.ts
export async function middleware(request: NextRequest) {
  const supabase = createMiddlewareClient({ req, res });
  const { data: { session } } = await supabase.auth.getSession();

  // Protect dashboard routes
  if (request.nextUrl.pathname.startsWith('/dashboard')) {
    if (!session) {
      return NextResponse.redirect(new URL('/login', request.url));
    }
  }

  // Redirect logged-in users from auth pages
  if (['/login', '/signup'].includes(request.nextUrl.pathname)) {
    if (session) {
      return NextResponse.redirect(new URL('/dashboard', request.url));
    }
  }

  return NextResponse.next();
}
```

---

## 7. Billing Architecture

### Plans

| Plan | Prix | Limites |
|------|------|---------|
| Free | $0 | 1 projet, 3 membres |
| Pro | $3/user/mois | Illimité |

### Stripe Flow

```
1. User clicks "Upgrade to Pro"
2. Frontend calls /api/teams/[slug]/billing/checkout
3. API creates Stripe Checkout Session
4. User redirected to Stripe
5. User pays
6. Stripe webhook → /api/webhooks/stripe
7. Update team.plan = 'pro'
8. User redirected to success page
```

### Webhook Events

| Event | Action |
|-------|--------|
| `checkout.session.completed` | Activate subscription |
| `invoice.paid` | Log payment |
| `invoice.payment_failed` | Send email, grace period |
| `customer.subscription.deleted` | Downgrade to free |

---

## 8. Performance Optimizations

### Frontend

| Optimization | Implementation |
|--------------|----------------|
| Optimistic updates | Zustand + React Query mutation |
| Lazy loading | `dynamic()` pour composants lourds |
| Prefetching | `<Link prefetch>` pour navigation |
| Image optimization | `next/image` |

### Database

| Optimization | Implementation |
|--------------|----------------|
| Indexes | `team_id`, `project_id`, `status` |
| Connection pooling | Supabase managed |
| Query optimization | Select only needed columns |

### Kanban

```typescript
// Optimistic update pour drag & drop
const moveTask = async (taskId, newStatus, newPosition) => {
  // 1. Update local state immédiatement
  kanbanStore.moveTask(taskId, newStatus, newPosition);

  // 2. Sync avec serveur en background
  await supabase
    .from('tasks')
    .update({ status: newStatus, position: newPosition })
    .eq('id', taskId);
};
```

---

## 9. Sécurité

### Checklist

- [x] **RLS** : Toutes les tables ont des policies
- [x] **Auth** : Supabase Auth (JWT, refresh tokens)
- [x] **HTTPS** : Vercel force HTTPS
- [x] **CORS** : Configuré dans Supabase
- [x] **Input validation** : Zod schemas côté serveur
- [x] **Rate limiting** : Vercel Edge + Supabase
- [x] **Secrets** : Env vars, jamais dans le code
- [x] **Stripe** : Webhook signature verification

### Tests de sécurité

```typescript
// Test RLS: User A ne peut pas voir les tasks de User B
test('RLS prevents cross-team access', async () => {
  const userA = await signIn('userA@test.com');
  const userB = await signIn('userB@test.com');

  // User B crée une task
  const task = await createTask(userB, { title: 'Secret' });

  // User A essaie de la lire
  const { data, error } = await supabase
    .from('tasks')
    .select()
    .eq('id', task.id)
    .single();

  expect(data).toBeNull();
  expect(error.code).toBe('PGRST116'); // Row not found
});
```

---

## 10. ADRs (Architecture Decision Records)

### ADR-001: Supabase vs Custom Backend

**Contexte** : Besoin d'un backend avec auth, database, et realtime.

**Décision** : Supabase

**Raisons** :
- Auth intégré (magic link, OAuth)
- PostgreSQL avec RLS = multi-tenant simple
- Realtime subscriptions inclus
- Moins de code à maintenir
- Free tier généreux

**Conséquences** :
- Vendor lock-in partiel (mitigé: PostgreSQL standard)
- Moins de flexibilité que custom

---

### ADR-002: Stripe Checkout vs Custom Payment Form

**Décision** : Stripe Checkout (hosted)

**Raisons** :
- PCI compliance géré par Stripe
- Moins de code (pas de formulaire)
- Support cartes, Apple Pay, etc. automatique
- Meilleur taux de conversion

**Conséquences** :
- Redirection vers Stripe (UX légèrement moins fluide)
- Moins de contrôle sur le design

---

### ADR-003: Zustand vs Redux vs Context

**Décision** : Zustand pour UI state, React Query pour server state

**Raisons** :
- Zustand : Simple, pas de boilerplate, performant
- React Query : Cache, refetch, optimistic updates
- Séparation claire UI state / server state

**Conséquences** :
- Deux librairies au lieu d'une
- Pattern à apprendre

---

## 11. Monitoring & Observabilité

| Outil | Usage |
|-------|-------|
| **Sentry** | Error tracking |
| **Vercel Analytics** | Web vitals, traffic |
| **Supabase Dashboard** | DB metrics, auth logs |
| **Stripe Dashboard** | Revenue, churn |
| **Uptime Robot** | Alertes downtime |

### Alertes configurées

| Alerte | Seuil | Action |
|--------|-------|--------|
| Error rate | > 1% | Slack + Email |
| P95 latency | > 2s | Slack |
| Auth failures | > 10/min | Email |
| Stripe webhook fail | Any | PagerDuty |
