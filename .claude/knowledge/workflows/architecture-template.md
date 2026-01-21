# Template Architecture

> Template pour la documentation d'architecture technique générée par le skill `architect`.

## Structure du document

```markdown
# Architecture: [Nom du projet]

## Vue d'ensemble

### Contexte
[Description du contexte business et technique]

### Objectifs architecturaux
- [ ] Scalabilité : [cible]
- [ ] Performance : [cible]
- [ ] Disponibilité : [cible]
- [ ] Sécurité : [niveau requis]

---

## Stack technique

### Frontend
| Technologie | Version | Justification |
|-------------|---------|---------------|
| [Framework] | [X.Y.Z] | [Pourquoi ce choix] |
| [UI Library] | [X.Y.Z] | [Pourquoi ce choix] |
| [State Management] | [X.Y.Z] | [Pourquoi ce choix] |

### Backend
| Technologie | Version | Justification |
|-------------|---------|---------------|
| [Runtime] | [X.Y.Z] | [Pourquoi ce choix] |
| [Framework] | [X.Y.Z] | [Pourquoi ce choix] |
| [ORM/DB Client] | [X.Y.Z] | [Pourquoi ce choix] |

### Infrastructure
| Service | Provider | Justification |
|---------|----------|---------------|
| [Hosting] | [Provider] | [Pourquoi ce choix] |
| [Database] | [Provider] | [Pourquoi ce choix] |
| [Storage] | [Provider] | [Pourquoi ce choix] |

---

## Structure du projet

\`\`\`
project-root/
├── src/
│   ├── components/       # Composants UI réutilisables
│   ├── features/         # Features par domaine
│   │   └── [feature]/
│   │       ├── api/      # Endpoints API
│   │       ├── hooks/    # Hooks React
│   │       ├── store/    # State management
│   │       └── types/    # Types TypeScript
│   ├── lib/              # Utilitaires partagés
│   ├── pages/            # Routes/Pages
│   └── styles/           # Styles globaux
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── docs/
└── scripts/
\`\`\`

---

## Data Model

### Entités principales

\`\`\`
┌─────────────┐       ┌─────────────┐
│   Entity1   │       │   Entity2   │
├─────────────┤       ├─────────────┤
│ id: UUID    │───┐   │ id: UUID    │
│ name: str   │   │   │ entity1_id  │◄──┘
│ created_at  │   └──►│ data: json  │
└─────────────┘       └─────────────┘
\`\`\`

### Schéma détaillé

| Table | Champ | Type | Contraintes | Description |
|-------|-------|------|-------------|-------------|
| entity1 | id | UUID | PK | Identifiant unique |
| entity1 | name | VARCHAR(255) | NOT NULL | Nom de l'entité |
| entity1 | created_at | TIMESTAMP | DEFAULT NOW() | Date de création |

---

## APIs

### Endpoints REST

| Méthode | Endpoint | Description | Auth |
|---------|----------|-------------|------|
| GET | /api/v1/entities | Liste les entités | Bearer |
| POST | /api/v1/entities | Crée une entité | Bearer |
| GET | /api/v1/entities/:id | Récupère une entité | Bearer |
| PUT | /api/v1/entities/:id | Met à jour une entité | Bearer |
| DELETE | /api/v1/entities/:id | Supprime une entité | Bearer |

### Contrats API

\`\`\`typescript
// GET /api/v1/entities
interface ListEntitiesResponse {
  data: Entity[];
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
}

// POST /api/v1/entities
interface CreateEntityRequest {
  name: string;
  // ...
}

interface CreateEntityResponse {
  data: Entity;
}
\`\`\`

---

## Sécurité

### Authentification
- [ ] JWT avec refresh tokens
- [ ] Sessions côté serveur
- [ ] OAuth2 / OIDC
- [ ] API Keys

### Autorisation
| Rôle | Permissions |
|------|-------------|
| admin | CRUD sur toutes les ressources |
| user | R sur ressources publiques, CRUD sur ses ressources |
| guest | R sur ressources publiques |

### Mesures de sécurité
- [ ] HTTPS obligatoire
- [ ] Rate limiting
- [ ] Input validation
- [ ] SQL injection protection
- [ ] XSS protection
- [ ] CSRF protection

---

## Architecture Decision Records (ADR)

### ADR-001: [Titre de la décision]

**Statut:** Accepté | En discussion | Déprécié

**Contexte:**
[Description du contexte qui a mené à cette décision]

**Décision:**
[La décision prise]

**Conséquences:**
- Positives: [...]
- Négatives: [...]
- Risques: [...]

---

## Diagrammes

### Architecture globale

\`\`\`
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Client     │────►│   API GW     │────►│   Backend    │
│   (Browser)  │     │   (nginx)    │     │   (Node.js)  │
└──────────────┘     └──────────────┘     └──────┬───────┘
                                                  │
                     ┌──────────────┐     ┌───────▼───────┐
                     │   Cache      │◄────│   Database    │
                     │   (Redis)    │     │   (Postgres)  │
                     └──────────────┘     └───────────────┘
\`\`\`

### Flux de données

\`\`\`
User Action → Component → Hook → API Call → Server → Database
                                    ↓
User ← Component ← State Update ← Response
\`\`\`

---

## Performance

### Objectifs
| Métrique | Cible | Mesure |
|----------|-------|--------|
| Time to First Byte | < 200ms | Lighthouse |
| First Contentful Paint | < 1.5s | Lighthouse |
| Time to Interactive | < 3s | Lighthouse |
| API Response Time (p95) | < 500ms | APM |

### Stratégies
- [ ] CDN pour assets statiques
- [ ] Lazy loading des composants
- [ ] Database indexing
- [ ] Query optimization
- [ ] Caching (Redis)

---

## Monitoring & Observabilité

### Logs
- Format: JSON structuré
- Niveaux: ERROR, WARN, INFO, DEBUG
- Rétention: 30 jours

### Métriques
- CPU, Memory, Disk usage
- Request rate, Error rate
- Response time (p50, p95, p99)

### Alerting
| Condition | Sévérité | Action |
|-----------|----------|--------|
| Error rate > 1% | Critical | PagerDuty |
| Response time p95 > 2s | Warning | Slack |
| CPU > 80% | Warning | Slack |

---

## Environnements

| Environnement | URL | Usage |
|---------------|-----|-------|
| Development | localhost:3000 | Dev local |
| Staging | staging.example.com | Tests QA |
| Production | app.example.com | Utilisateurs |

---

## Checklist de validation

- [ ] Stack technique justifié
- [ ] Structure projet définie
- [ ] Data model complet
- [ ] APIs documentées
- [ ] Sécurité adressée
- [ ] Performance planifiée
- [ ] Monitoring prévu
```

## Critères de qualité

| Critère | Description |
|---------|-------------|
| **Complétude** | Tous les composants majeurs sont documentés |
| **Clarté** | Un nouveau dev comprend l'architecture en 15 min |
| **Justification** | Chaque choix technique est justifié |
| **Évolutivité** | L'architecture permet la croissance |
| **Testabilité** | L'architecture facilite les tests |
