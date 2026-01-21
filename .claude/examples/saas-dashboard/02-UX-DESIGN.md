# UX Design: SaaS Dashboard

> Généré par le skill `ux-designer` (v2.6)

## Personas

### Persona 1: Sophie - Admin

| Attribut | Détail |
|----------|--------|
| **Nom** | Sophie Laurent |
| **Âge** | 35-45 ans |
| **Profession** | CEO / Fondatrice |
| **Contexte** | Gère une équipe de 15 personnes |

**Bio:**
Sophie a fondé sa startup il y a 3 ans. Elle a besoin de visibilité sur tous les projets et les performances de l'équipe. Elle vérifie le dashboard chaque matin.

**Objectifs:**
- Vue d'ensemble de tous les projets
- Métriques de performance équipe
- Gestion de la facturation

**Frustrations:**
- Trop de clics pour avoir une vue globale
- Rapports difficiles à exporter
- Pas d'alertes proactives

**Citation typique:**
> "Je veux voir en 30 secondes si tout va bien."

---

### Persona 2: Thomas - Manager

| Attribut | Détail |
|----------|--------|
| **Nom** | Thomas Moreau |
| **Âge** | 30-40 ans |
| **Profession** | Project Manager |
| **Contexte** | Gère 3 projets et 5 personnes |

**Bio:**
Thomas passe sa journée entre réunions et suivi de projets. Il a besoin d'outils pour assigner des tâches et suivre l'avancement sans micro-manager.

**Objectifs:**
- Assigner et suivre les tâches
- Communiquer avec l'équipe
- Respecter les deadlines

**Frustrations:**
- Notifications trop nombreuses
- Pas de vue timeline claire
- Difficile de voir la charge de travail

**Citation typique:**
> "Qui travaille sur quoi et est-ce qu'on est dans les temps?"

---

### Persona 3: Julie - Member

| Attribut | Détail |
|----------|--------|
| **Nom** | Julie Chen |
| **Âge** | 25-30 ans |
| **Profession** | Développeuse |
| **Contexte** | Travaille sur 2 projets en parallèle |

**Bio:**
Julie veut se concentrer sur son travail sans être distraite. Elle vérifie ses tâches le matin et met à jour le soir.

**Objectifs:**
- Voir ses tâches du jour
- Mettre à jour le statut facilement
- Logger son temps

**Frustrations:**
- Interface trop complexe
- Trop de champs à remplir
- Pas de raccourcis clavier

**Citation typique:**
> "Je veux update ma tâche en 2 clics et retourner coder."

---

## User Journeys

### Journey 1: Morning Check (Sophie - Admin)

**Persona:** Sophie
**Objectif:** Vérifier l'état global en 5 minutes
**Contexte:** 8h30, café en main, avant le daily

| Étape | Action | Pensée | Émotion | Opportunité |
|-------|--------|--------|---------|-------------|
| 1. Login | Ouvre le dashboard | "Voyons voir" | 😐 | SSO rapide |
| 2. Overview | Regarde les KPIs | "3 projets en retard" | 😟 | Alertes visuelles |
| 3. Drill-down | Clique sur un projet | "Pourquoi ce retard?" | 😟 | Détails rapides |
| 4. Action | Envoie un message | "Je demande un point" | 😐 | Message in-app |
| 5. Check | Vérifie le billing | "On est bon ce mois" | 😊 | Widget financier |

**Moments clés:**
- ⭐ **Moment de vérité:** Étape 2 - Doit voir les problèmes immédiatement
- 🎯 **Moment de succès:** Étape 5 - Vue complète en < 5 min

---

### Journey 2: Task Assignment (Thomas - Manager)

**Persona:** Thomas
**Objectif:** Assigner les tâches de la semaine
**Contexte:** Lundi matin, planning hebdo

| Étape | Action | Pensée | Émotion | Opportunité |
|-------|--------|--------|---------|-------------|
| 1. View | Ouvre la vue projet | "Qu'est-ce qui reste?" | 😐 | Backlog clair |
| 2. Check | Vérifie les dispos | "Qui est libre?" | 😐 | Vue capacité |
| 3. Assign | Drag & drop tâches | "Facile" | 😊 | Kanban intuitif |
| 4. Notify | Notifie l'équipe | "Ils sont prévenus" | 😊 | Notif auto |
| 5. Save | Sauvegarde la vue | "Pour la prochaine fois" | 😊 | Vues sauvées |

---

### Journey 3: Daily Update (Julie - Member)

**Persona:** Julie
**Objectif:** Mettre à jour ses tâches
**Contexte:** 18h, fin de journée

| Étape | Action | Pensée | Émotion | Opportunité |
|-------|--------|--------|---------|-------------|
| 1. Open | Ouvre "Mes tâches" | "Vite fait" | 😐 | Raccourci clavier |
| 2. Update | Change statut → Done | "1 clic, nickel" | 😊 | Statut rapide |
| 3. Log | Logge 6h de travail | "Simple" | 😊 | Timer intégré |
| 4. Comment | Ajoute une note | "Pour Thomas" | 😐 | @ mentions |
| 5. Close | Ferme l'app | "À demain" | 😊 | Fermeture rapide |

---

## Wireframes

### Dashboard Admin

```
┌─────────────────────────────────────────────────────────┐
│ [Logo] Dashboard          [🔔] [Sophie ▼]               │
├────────────┬────────────────────────────────────────────┤
│            │                                            │
│ Dashboard  │  ┌─────────┐ ┌─────────┐ ┌─────────┐       │
│ Projects   │  │ Projets │ │ Tâches  │ │ Budget  │       │
│ Team       │  │   12    │ │  45/60  │ │  78%    │       │
│ Reports    │  └─────────┘ └─────────┘ └─────────┘       │
│ Billing    │                                            │
│            │  ┌───────────────────────────────────────┐ │
│ ─────────  │  │ Projets en cours                      │ │
│ Settings   │  ├───────────────────────────────────────┤ │
│            │  │ [🔴] Refonte API     - 3j retard      │ │
│            │  │ [🟡] Mobile App      - À risque       │ │
│            │  │ [🟢] Landing Page    - On track       │ │
│            │  └───────────────────────────────────────┘ │
│            │                                            │
│            │  ┌─────────────────┐ ┌─────────────────┐   │
│            │  │ Activité récente│ │ Team workload   │   │
│            │  │ ...             │ │ [chart]         │   │
│            │  └─────────────────┘ └─────────────────┘   │
└────────────┴────────────────────────────────────────────┘
```

### Vue Kanban (Manager)

```
┌─────────────────────────────────────────────────────────┐
│ [←] Projet: Refonte API    [👤+] [⚙️] [📊]              │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  To Do         In Progress      Review        Done      │
│  ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐ │
│  │ Task 1  │   │ Task 4  │   │ Task 6  │   │ Task 8  │ │
│  │ Julie   │   │ Marc    │   │ Julie   │   │ Marc    │ │
│  └─────────┘   └─────────┘   └─────────┘   └─────────┘ │
│  ┌─────────┐   ┌─────────┐                 ┌─────────┐ │
│  │ Task 2  │   │ Task 5  │                 │ Task 9  │ │
│  │ ---     │   │ Julie   │                 │ Julie   │ │
│  └─────────┘   └─────────┘                 └─────────┘ │
│  ┌─────────┐                                           │
│  │ + Add   │                                           │
│  └─────────┘                                           │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## Métriques UX

| Métrique | Cible |
|----------|-------|
| Time to Insight (Admin) | < 30 sec |
| Task Assignment Time | < 5 sec/tâche |
| Task Update Time | < 3 sec |
| Daily Active Users | > 80% |
| NPS | > 50 |
