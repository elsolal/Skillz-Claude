# Epics & Stories - SaaS Dashboard

**PRD:** [02-PRD.md](./02-PRD.md)
**Architecture:** [03-ARCHITECTURE.md](./03-ARCHITECTURE.md)

---

## Vue d'ensemble

| Epic | Stories | Priorité | Durée |
|------|---------|----------|-------|
| Epic 1: Authentication | 5 | P0 | 2j |
| Epic 2: Core (Teams, Projects, Tasks) | 8 | P0 | 4j |
| Epic 3: Billing | 4 | P0 | 2j |
| **Total** | **17** | | **8j** |

---

# Epic 1: Authentication
> Inscription, connexion, et gestion du profil

## Story 1.1: Inscription par email (Magic Link)
**Taille:** M | **Priorité:** P0 | **Tags:** `auth`, `signup`

**En tant que** nouveau visiteur,
**Je veux** m'inscrire avec mon email,
**Afin de** créer un compte sans mot de passe.

**Critères d'acceptance:**
```gherkin
Given je suis sur /signup
When je saisis mon email et clique "Continue"
Then je reçois un email avec un magic link
And le lien m'authentifie et me redirige vers /onboarding

Given je clique sur un magic link expiré (> 1h)
Then je vois un message d'erreur
And je peux demander un nouveau lien
```

**Tâches techniques:**
- [ ] Page `/signup` avec formulaire email
- [ ] Intégration Supabase Auth `signInWithOtp`
- [ ] Page `/auth/callback` pour traitement du lien
- [ ] Création automatique du profile
- [ ] Tests E2E avec email de test

---

## Story 1.2: Inscription via GitHub OAuth
**Taille:** S | **Priorité:** P0 | **Tags:** `auth`, `oauth`

**En tant que** développeur,
**Je veux** m'inscrire avec GitHub,
**Afin d'** avoir un onboarding encore plus rapide.

**Critères d'acceptance:**
```gherkin
Given je suis sur /signup
When je clique "Continue with GitHub"
Then je suis redirigé vers GitHub pour autorisation
And après autorisation, je reviens sur /onboarding
And mon nom et avatar sont pré-remplis depuis GitHub
```

---

## Story 1.3: Connexion
**Taille:** S | **Priorité:** P0 | **Tags:** `auth`, `login`

**En tant que** utilisateur existant,
**Je veux** me connecter,
**Afin d'** accéder à mon dashboard.

**Critères d'acceptance:**
```gherkin
Given je suis sur /login
When je saisis mon email
Then je reçois un magic link
And après clic, je suis sur /dashboard

Given je suis déjà connecté
When je visite /login
Then je suis redirigé vers /dashboard
```

---

## Story 1.4: Déconnexion
**Taille:** XS | **Priorité:** P0 | **Tags:** `auth`, `logout`

**En tant que** utilisateur connecté,
**Je veux** me déconnecter,
**Afin de** sécuriser mon compte.

**Critères d'acceptance:**
```gherkin
Given je suis connecté
When je clique "Logout" dans le menu
Then ma session est terminée
And je suis redirigé vers /login
```

---

## Story 1.5: Gestion du profil
**Taille:** S | **Priorité:** P1 | **Tags:** `auth`, `profile`

**En tant que** utilisateur,
**Je veux** modifier mon profil,
**Afin de** personnaliser mon compte.

**Critères d'acceptance:**
```gherkin
Given je suis sur /settings/profile
When je modifie mon nom et sauvegarde
Then mon nom est mis à jour partout
And je vois une confirmation

Given je veux supprimer mon compte
When je clique "Delete account" et confirme
Then mon compte est supprimé
And mes données sont anonymisées
And je suis redirigé vers /
```

---

# Epic 2: Core (Teams, Projects, Tasks)
> Fonctionnalités principales du dashboard

## Story 2.1: Créer une équipe
**Taille:** M | **Priorité:** P0 | **Tags:** `teams`, `onboarding`

**En tant que** nouvel utilisateur,
**Je veux** créer mon équipe,
**Afin de** commencer à utiliser le produit.

**Critères d'acceptance:**
```gherkin
Given je viens de m'inscrire
When je suis sur /onboarding
Then je dois créer une équipe (nom requis)
And un slug unique est généré automatiquement
And je deviens owner de l'équipe
And je suis redirigé vers /[teamSlug]
```

---

## Story 2.2: Inviter des membres
**Taille:** M | **Priorité:** P0 | **Tags:** `teams`, `members`

**En tant que** admin d'équipe,
**Je veux** inviter des collaborateurs,
**Afin de** travailler ensemble.

**Critères d'acceptance:**
```gherkin
Given je suis admin sur /[team]/settings/members
When je saisis un email et clique "Invite"
Then un email d'invitation est envoyé
And l'invitation apparaît comme "pending"

Given je reçois une invitation
When je clique le lien dans l'email
Then je rejoins l'équipe
And je suis redirigé vers le dashboard de l'équipe
```

---

## Story 2.3: Gérer les rôles des membres
**Taille:** S | **Priorité:** P1 | **Tags:** `teams`, `roles`

**En tant que** owner,
**Je veux** gérer les rôles des membres,
**Afin de** contrôler les permissions.

**Critères d'acceptance:**
```gherkin
Given je suis owner sur /[team]/settings/members
When je change le rôle d'un membre (admin ↔ member)
Then le rôle est mis à jour
And les permissions changent immédiatement

Given je veux transférer l'ownership
When je clique "Transfer ownership" sur un admin
Then il devient owner
And je deviens admin
```

---

## Story 2.4: CRUD Projets
**Taille:** M | **Priorité:** P0 | **Tags:** `projects`

**En tant que** membre d'équipe,
**Je veux** créer et gérer des projets,
**Afin d'** organiser mon travail.

**Critères d'acceptance:**
```gherkin
Given je suis sur /[team]/projects
When je clique "New project"
Then un dialog s'ouvre pour créer le projet (nom, couleur)
And le projet apparaît dans la liste

Given je suis sur un projet
When je clique "Settings"
Then je peux modifier nom, description, couleur
And je peux archiver le projet
```

---

## Story 2.5: Vue Kanban
**Taille:** L | **Priorité:** P0 | **Tags:** `tasks`, `kanban`

**En tant que** membre d'équipe,
**Je veux** voir les tâches en Kanban,
**Afin de** visualiser l'avancement.

**Critères d'acceptance:**
```gherkin
Given je suis sur /[team]/projects/[id]
Then je vois 4 colonnes: Backlog, Todo, In Progress, Done
And chaque colonne affiche les tâches correspondantes
And les tâches sont triées par position

Given une tâche existe
When je drag & drop vers une autre colonne
Then la tâche change de statut instantanément
And l'ordre est préservé
```

**Notes techniques:**
- Utiliser @dnd-kit pour drag & drop
- Optimistic updates avec Zustand
- Position = integer, recalculer si gap < 1

---

## Story 2.6: CRUD Tâches
**Taille:** M | **Priorité:** P0 | **Tags:** `tasks`

**En tant que** membre d'équipe,
**Je veux** créer et gérer des tâches,
**Afin de** suivre mon travail.

**Critères d'acceptance:**
```gherkin
Given je suis sur le Kanban
When je clique "+ Add task" dans une colonne
Then un dialog s'ouvre avec le formulaire
And je peux saisir titre, description, priorité, assignee, due date
And la tâche apparaît dans la colonne

Given une tâche existe
When je clique dessus
Then le dialog s'ouvre en mode édition
And je peux modifier tous les champs
And je peux supprimer la tâche
```

---

## Story 2.7: Filtrer et trier les tâches
**Taille:** S | **Priorité:** P1 | **Tags:** `tasks`, `filter`

**En tant que** membre d'équipe,
**Je veux** filtrer les tâches,
**Afin de** me concentrer sur ce qui m'intéresse.

**Critères d'acceptance:**
```gherkin
Given je suis sur le Kanban
When je filtre par "Assigned to me"
Then seules mes tâches sont visibles

When je filtre par priorité "High" ou "Urgent"
Then seules ces tâches sont visibles

When je filtre par label
Then seules les tâches avec ce label sont visibles
```

---

## Story 2.8: Labels personnalisés
**Taille:** S | **Priorité:** P2 | **Tags:** `tasks`, `labels`

**En tant que** membre d'équipe,
**Je veux** créer des labels custom,
**Afin de** catégoriser mes tâches.

**Critères d'acceptance:**
```gherkin
Given je suis sur les settings d'un projet
When je crée un label (nom, couleur)
Then il est disponible pour toutes les tâches du projet

Given j'édite une tâche
When j'ajoute/retire des labels
Then ils apparaissent sur la TaskCard
```

---

# Epic 3: Billing
> Gestion des abonnements et paiements

## Story 3.1: Afficher les limites du plan Free
**Taille:** S | **Priorité:** P0 | **Tags:** `billing`, `limits`

**En tant que** utilisateur Free,
**Je veux** voir mes limites,
**Afin de** savoir quand upgrader.

**Critères d'acceptance:**
```gherkin
Given je suis sur le plan Free
Then je vois "1/1 projet utilisé" ou "3/3 membres"
And un bouton "Upgrade to Pro" est visible

Given j'essaie de créer un 2e projet
Then un message m'indique la limite
And un CTA vers upgrade est affiché
```

---

## Story 3.2: Upgrade vers Pro (Stripe Checkout)
**Taille:** M | **Priorité:** P0 | **Tags:** `billing`, `stripe`

**En tant que** utilisateur Free,
**Je veux** upgrader vers Pro,
**Afin d'** avoir un usage illimité.

**Critères d'acceptance:**
```gherkin
Given je suis sur /[team]/settings/billing
When je clique "Upgrade to Pro"
Then je suis redirigé vers Stripe Checkout
And le prix affiché est $3 × nombre de membres

Given je complète le paiement sur Stripe
Then je reviens sur /[team]/settings/billing?success=true
And mon plan est maintenant "Pro"
And les limites sont levées
```

---

## Story 3.3: Gérer l'abonnement (Customer Portal)
**Taille:** S | **Priorité:** P1 | **Tags:** `billing`, `portal`

**En tant que** utilisateur Pro,
**Je veux** gérer mon abonnement,
**Afin de** modifier ma carte ou annuler.

**Critères d'acceptance:**
```gherkin
Given je suis Pro sur /[team]/settings/billing
When je clique "Manage subscription"
Then je suis redirigé vers Stripe Customer Portal
And je peux changer ma carte de paiement
And je peux annuler l'abonnement
And je peux voir mes factures
```

---

## Story 3.4: Downgrade vers Free
**Taille:** S | **Priorité:** P1 | **Tags:** `billing`, `downgrade`

**En tant que** utilisateur Pro,
**Je veux** pouvoir downgrade,
**Afin de** réduire mes coûts.

**Critères d'acceptance:**
```gherkin
Given j'annule mon abonnement dans Stripe Portal
Then à la fin de la période payée, mon plan devient Free
And si j'ai > 1 projet, je dois en archiver
And si j'ai > 3 membres, je vois un avertissement
```

---

# Readiness Check: 15/15 ✅

| Critère | Score | Détail |
|---------|-------|--------|
| Stories INVEST | 3/3 | Toutes indépendantes et testables |
| Critères Given/When/Then | 3/3 | AC complets en Gherkin |
| Estimations cohérentes | 2/2 | XS → L appropriés |
| Priorités définies | 2/2 | P0 (MVP) > P1 > P2 |
| Dépendances identifiées | 3/3 | Epic 1 avant Epic 2 |
| Risques techniques | 2/2 | RLS, Stripe webhooks |

**Prêt pour implémentation !**

---

## Ordre d'implémentation

```
EPIC 1: Auth (2j)
├── 1.1 Magic Link signup     ─┐
├── 1.2 GitHub OAuth          ─┼─→ Auth de base
├── 1.3 Login                 ─┘
├── 1.4 Logout
└── 1.5 Profile

EPIC 2: Core (4j)
├── 2.1 Create team           ─┐
├── 2.2 Invite members        ─┼─→ Teams
├── 2.3 Manage roles          ─┘
├── 2.4 CRUD Projects         ─┐
├── 2.5 Kanban view           ─┼─→ Projects & Tasks
├── 2.6 CRUD Tasks            ─┘
├── 2.7 Filters
└── 2.8 Labels

EPIC 3: Billing (2j)
├── 3.1 Show limits           ─┐
├── 3.2 Upgrade (Checkout)    ─┼─→ Billing
├── 3.3 Manage subscription   ─┘
└── 3.4 Downgrade
```
