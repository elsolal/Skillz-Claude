# Exemple : SaaS Dashboard

> Projet exemple pour illustrer le workflow D-EPCT+R complet avec mode RALPH

## Contexte

Dashboard SaaS pour une application de gestion de projets avec authentification,
équipes, et analytics.
- **Complexité** : FULL+ (1-2 semaines)
- **Stack** : Next.js 14 + Supabase + Stripe + Tailwind

## Fichiers

```
saas-dashboard/
├── README.md              # Ce fichier
├── 01-BRAINSTORM.md       # Research-first + Creative
├── 02-PRD.md              # PRD Full détaillé
├── 03-ARCHITECTURE.md     # Architecture complète avec ADRs
├── 04-STORIES.md          # 3 Epics, 15+ Stories
└── 05-IMPLEMENTATION.md   # Notes avec mode RALPH
```

## Workflow utilisé

```bash
# Mode RALPH pour discovery complet
/auto-discovery "Dashboard SaaS pour gestion de projets avec auth, équipes, et billing"

# Mode RALPH pour chaque Epic
/auto-feature #epic-1 --max 50
/auto-feature #epic-2 --max 50
/auto-feature #epic-3 --max 50
```

## Particularités de cet exemple

1. **Research-first** : Analyse de la concurrence avant brainstorm
2. **Architecture complexe** : Multi-tenant, Row Level Security
3. **Mode RALPH** : Utilisation du mode autonome pour l'implémentation
4. **3 Epics** : Auth, Projects, Billing
