# Severity Matrix - Supabase Security

## Niveaux de sévérité

| Niveau | Couleur | CVSS | Description | Délai de correction |
|--------|---------|------|-------------|---------------------|
| **P0** | 🔴 | 9.0-10.0 | Critique - Compromission totale possible | Immédiat (aujourd'hui) |
| **P1** | 🟠 | 7.0-8.9 | Haute - Données sensibles exposées | 7 jours |
| **P2** | 🟡 | 4.0-6.9 | Moyenne - Best practices non respectées | 30 jours |
| **P3** | 🟢 | 0.1-3.9 | Basse - Améliorations recommandées | Backlog |

---

## Findings par catégorie

### Credentials Exposure

| Finding | Sévérité | CVSS | Impact |
|---------|----------|------|--------|
| Service role key exposée côté client | 🔴 P0 | 9.8 | Bypass total RLS, accès complet BDD |
| DB connection string exposée | 🔴 P0 | 9.8 | Accès direct PostgreSQL |
| JWT secret exposé | 🔴 P0 | 9.5 | Forge de tokens, impersonation |
| Anon key exposée | ✅ OK | - | Attendu côté client |
| Source maps accessibles | 🟡 P2 | 5.0 | Peut révéler du code sensible |

### API / Tables

| Finding | Sévérité | CVSS | Impact |
|---------|----------|------|--------|
| Table users sans RLS | 🔴 P0 | 9.1 | Toutes les données utilisateurs exposées |
| Table avec PII sans RLS | 🔴 P0 | 9.1 | Données personnelles exposées |
| Table avec données financières sans RLS | 🔴 P0 | 9.1 | Données financières exposées |
| RLS avec policy `USING (true)` | 🟠 P1 | 7.5 | Données accessibles à tous les users auth |
| RLS SELECT only (pas de policy INSERT/UPDATE/DELETE) | 🟠 P1 | 7.0 | Modification possible sans contrôle |
| Table de config sans RLS | 🟠 P1 | 7.5 | Config modifiable |
| RPC function sans vérification auth | 🟠 P1 | 7.5 | Exécution non autorisée |
| Table non-sensible sans RLS | 🟡 P2 | 4.0 | Best practice non respectée |

### Storage

| Finding | Sévérité | CVSS | Impact |
|---------|----------|------|--------|
| Bucket backups public | 🔴 P0 | 9.8 | Dump BDD téléchargeable |
| Fichiers .env publics | 🔴 P0 | 9.8 | Secrets exposés |
| Bucket documents users public | 🟠 P1 | 7.5 | Documents privés accessibles |
| Bucket uploads sans RLS storage | 🟠 P1 | 7.0 | Fichiers d'autres users accessibles |
| Bucket avatars public | ✅ OK | - | Acceptable pour images profil |
| Bucket assets public | ✅ OK | - | Acceptable pour assets statiques |

### Authentication

| Finding | Sévérité | CVSS | Impact |
|---------|----------|------|--------|
| Email confirmation désactivée | 🟠 P1 | 6.5 | Création de comptes non vérifiés |
| Password policy < 8 chars | 🟠 P1 | 6.0 | Passwords faibles acceptés |
| Signup ouvert sans CAPTCHA | 🟡 P2 | 5.0 | Risque de spam/bots |
| Rate limiting désactivé | 🟡 P2 | 5.5 | Brute force possible |
| User enumeration via timing | 🟡 P2 | 4.0 | Découverte d'emails existants |

### Edge Functions

| Finding | Sévérité | CVSS | Impact |
|---------|----------|------|--------|
| Function admin sans vérification role | 🔴 P0 | 8.8 | Privilege escalation |
| Function avec service key hardcodée | 🔴 P0 | 9.0 | Accès admin exposé |
| IDOR dans function | 🔴 P0 | 8.5 | Accès données autres users |
| Function sans rate limiting | 🟡 P2 | 5.0 | DoS possible |
| Function sans validation input | 🟡 P2 | 6.0 | Injection possible |

### Realtime

| Finding | Sévérité | CVSS | Impact |
|---------|----------|------|--------|
| Subscription sans RLS | 🟠 P1 | 7.0 | Stream de toutes les modifications |
| Broadcast channel non protégé | 🟠 P1 | 6.5 | Messages visibles par tous |
| Presence data exposant users | 🟡 P2 | 5.0 | Enumération des users connectés |

---

## Calcul du Security Score

### Formule

```
Score = 100 - (P0 × 25) - (P1 × 10) - (P2 × 5)

Bonus (max +20) :
+ 10 si RLS sur 100% des tables
+ 5 si email confirmation activée
+ 5 si password >= 8 chars
```

### Grille de notation

| Score | Grade | Interprétation |
|-------|-------|----------------|
| 90-100 | **A** | Excellent - Prêt pour production sécurisée |
| 80-89 | **B** | Bon - Quelques améliorations mineures |
| 70-79 | **C** | Acceptable - Problèmes à traiter avant prod |
| 60-69 | **D** | Faible - Problèmes significatifs |
| 0-59 | **F** | Critique - Ne pas déployer en production |

### Exemples

**Score A (95/100) :**
- 0 P0, 0 P1, 1 P2
- RLS 100%, auth hardened
- `100 - 0 - 0 - 5 + 20 = 115 → cap 100 = 95`

**Score D (60/100) :**
- 1 P0, 2 P1, 2 P2
- RLS partiel, pas de bonus
- `100 - 25 - 20 - 10 + 0 = 45 → 60 (floor)`

**Score F (35/100) :**
- 2 P0, 2 P1, 2 P2
- `100 - 50 - 20 - 10 = 20 → 35`

---

## Priorités de remediation

### Immédiat (Jour 0)

1. Rotation des credentials exposés
2. Activer RLS sur tables avec PII
3. Rendre privés les buckets sensibles
4. Désactiver/protéger functions admin

### Cette semaine

1. Activer email confirmation
2. Renforcer password policy
3. Ajouter RLS manquants
4. Corriger IDOR dans functions

### Ce mois

1. Activer rate limiting
2. Ajouter CAPTCHA
3. Désactiver source maps
4. Audit des RLS policies existantes
