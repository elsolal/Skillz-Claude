# PRD Patterns par type de projet

## Patterns par domaine

### 1. SaaS B2B

```markdown
## Pattern SaaS B2B

### Sections critiques
- Multi-tenancy requirements
- Rôles et permissions
- Intégrations (SSO, API)
- Billing/subscription model
- Compliance (GDPR, SOC2)

### Métriques typiques
| Métrique | Cible type |
|----------|------------|
| Time to value | < 5 min |
| Activation rate | > 40% |
| MRR churn | < 5% |
| NPS | > 50 |

### Questions essentielles
1. Quel est le modèle de pricing ? (per seat, usage, flat)
2. Quels rôles utilisateurs ? (admin, membre, viewer)
3. Quelles intégrations day-1 ?
4. Self-service ou sales-assisted ?
```

### 2. E-commerce

```markdown
## Pattern E-commerce

### Sections critiques
- Catalogue produits
- Panier / Checkout
- Paiement (PSP)
- Gestion des stocks
- Shipping / Fulfillment

### Métriques typiques
| Métrique | Cible type |
|----------|------------|
| Conversion rate | 2-3% |
| Cart abandonment | < 70% |
| AOV (Average Order Value) | +10% YoY |
| Page load time | < 2s |

### Questions essentielles
1. Combien de SKUs à gérer ?
2. Marketplace ou mono-vendor ?
3. Quels moyens de paiement ?
4. Zones de livraison ?
```

### 3. Mobile App

```markdown
## Pattern Mobile App

### Sections critiques
- Plateformes (iOS, Android, cross-platform)
- Offline-first capabilities
- Push notifications
- App Store requirements
- Deep linking

### Métriques typiques
| Métrique | Cible type |
|----------|------------|
| DAU/MAU | > 20% |
| Retention D1 | > 40% |
| Retention D7 | > 20% |
| Crash-free rate | > 99.5% |

### Questions essentielles
1. Native, hybrid ou cross-platform ?
2. Offline required ?
3. Background tasks ?
4. Permissions nécessaires ?
```

### 4. API / Backend Service

```markdown
## Pattern API

### Sections critiques
- API design (REST, GraphQL, gRPC)
- Authentication / Authorization
- Rate limiting
- Versioning strategy
- Documentation

### Métriques typiques
| Métrique | Cible type |
|----------|------------|
| Latency P99 | < 200ms |
| Availability | 99.9% |
| Error rate | < 0.1% |
| Time to first call | < 10 min |

### Questions essentielles
1. Public ou internal API ?
2. Sync ou async ?
3. Expected QPS ?
4. Breaking changes policy ?
```

### 5. Data Pipeline

```markdown
## Pattern Data Pipeline

### Sections critiques
- Sources de données
- Transformations
- Storage (data lake, warehouse)
- Scheduling / Orchestration
- Data quality

### Métriques typiques
| Métrique | Cible type |
|----------|------------|
| Freshness | < 1h |
| Completeness | > 99% |
| Processing time | < 30 min |
| Data quality score | > 95% |

### Questions essentielles
1. Batch ou streaming ?
2. Volume de données ?
3. Fréquence de refresh ?
4. Lineage tracking required ?
```

---

## Structure PRD par complexité

### Simple (1-2 features)
```
1. Problème
2. Solution
3. Features (liste)
4. Critères de succès
5. Hors scope
```

### Medium (3-5 features)
```
1. Overview
2. Utilisateurs & Personas
3. Features détaillées
4. Requirements fonctionnels
5. Contraintes
6. Métriques
7. Timeline
```

### Complexe (6+ features)
```
1. Executive Summary
2. Context & Background
3. Problem Statement
4. Goals & Non-Goals
5. User Research
6. Detailed Requirements
7. Technical Constraints
8. Dependencies
9. Risks & Mitigations
10. Success Metrics
11. Launch Plan
12. Appendix
```

---

## Anti-patterns PRD

| Anti-pattern | Problème | Solution |
|--------------|----------|----------|
| Solution-first | Saute le problème | Toujours commencer par "Pourquoi" |
| Feature soup | Trop de features sans priorisation | MoSCoW ou P0/P1/P2 |
| Vague metrics | "Améliorer l'UX" | Métriques quantifiables |
| No scope | Scope illimité | Toujours définir hors-scope |
| Tech leak | Details techniques dans PRD | QUOI, pas COMMENT |

---

## Checklist PRD Quality

```markdown
## PRD Quality Score

### Clarté (0-5)
- [ ] Problème clairement défini
- [ ] Solution compréhensible
- [ ] Personas identifiés
- [ ] Success metrics mesurables
- [ ] Scope explicite

### Complétude (0-5)
- [ ] Toutes sections remplies
- [ ] Questions ouvertes listées
- [ ] Contraintes documentées
- [ ] Timeline estimée
- [ ] Risques identifiés

### Actionnabilité (0-5)
- [ ] Features priorisées
- [ ] Requirements testables
- [ ] MVP défini
- [ ] Next steps clairs
- [ ] Ownership assigné

**Score total : X/15**
- 12+ : Prêt pour Architecture
- 8-11 : Révision recommandée
- <8 : Refonte nécessaire
```
