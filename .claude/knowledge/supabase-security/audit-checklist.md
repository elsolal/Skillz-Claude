# Supabase Security Audit Checklist

## Phase 1: Detection

- [ ] HTML source analysé pour patterns Supabase
- [ ] Fichiers JS téléchargés et analysés
- [ ] URL projet Supabase extraite
- [ ] Project reference identifié
- [ ] Evidence sauvegardée dans `01-detection/`

## Phase 2: Extraction

### Credentials

- [ ] Anon key extraite et décodée
- [ ] Vérifier que c'est bien `role: anon`
- [ ] Chercher service_role key (CRITIQUE si trouvé)
- [ ] Chercher JWT secrets
- [ ] Chercher DB connection strings
- [ ] Chercher dans les source maps (.js.map)

### Questions critiques

| Question | Si OUI |
|----------|--------|
| Service key exposée ? | 🔴 P0 - Rotation immédiate |
| DB string exposée ? | 🔴 P0 - Changer le password |
| JWT secret exposé ? | 🔴 P0 - Rotation |
| Source maps accessibles ? | 🟡 P2 - Désactiver en prod |

## Phase 3: API Audit

### Tables

- [ ] Récupérer le schéma OpenAPI
- [ ] Lister toutes les tables exposées
- [ ] Pour chaque table, tester SELECT anonyme
- [ ] Pour chaque table, tester INSERT anonyme
- [ ] Identifier les tables sans RLS

### RLS Tests

- [ ] Test unauthenticated access
- [ ] Test filter bypass (OR conditions)
- [ ] Test join exploitation
- [ ] Test RPC bypass

### Classification des tables

| Type | Exemples | RLS requis |
|------|----------|------------|
| PII | users, profiles, accounts | ✅ Strict |
| Financial | orders, payments, invoices | ✅ Strict |
| Content | posts, comments | ✅ ou ✅ partiel |
| Config | settings, features | ✅ Admin only |
| Public | categories, tags | ❌ Optionnel |

## Phase 4: Storage Audit

### Buckets

- [ ] Lister tous les buckets
- [ ] Identifier buckets publics vs privés
- [ ] Tester accès aux fichiers

### Patterns de fichiers sensibles

**🔴 P0 - Jamais public :**
- `*.sql` - Database dumps
- `*.env*` - Environment files
- `*backup*` - Backups
- `*secret*`, `*credential*` - Secrets
- `*export*` - Data exports

**🟠 P1 - Généralement privé :**
- `*invoice*`, `*payment*` - Financial
- `*contract*`, `*agreement*` - Legal
- `*passport*`, `*id*`, `*license*` - Identity
- Documents PDF uploadés par users

**🟡 P2 - À revoir :**
- Config files
- Log files
- Debug exports

## Phase 5: Auth Audit

### Configuration

- [ ] Récupérer auth settings
- [ ] Vérifier email confirmation
- [ ] Vérifier password policy
- [ ] Vérifier rate limiting

### Tests

- [ ] Tester si signup ouvert
- [ ] Tester weak password acceptance
- [ ] Tester rate limiting

### Checklist Auth

| Setting | Recommandé | Check |
|---------|------------|-------|
| `email_confirm` | `true` | |
| `password_min_length` | `>= 8` | |
| `enable_signup` | Selon besoin | |
| `rate_limit_enabled` | `true` | |
| `captcha_enabled` | Recommandé | |

## Phase 6: Realtime & Functions

### Edge Functions

- [ ] Découvrir les functions exposées
- [ ] Tester accès sans auth
- [ ] Tester avec auth basique
- [ ] Vérifier validation des inputs

### Realtime

- [ ] Tester subscription sans auth
- [ ] Vérifier quelles tables sont streamables

## Phase 7: Report

### Vérifications finales

- [ ] Tous les findings documentés
- [ ] Toutes les evidences sauvegardées
- [ ] curl-commands.sh complet
- [ ] timeline.md à jour
- [ ] Score calculé
- [ ] Remediation pour chaque finding
- [ ] Rapport markdown généré

### Format du rapport

- [ ] Executive summary
- [ ] Score et grade
- [ ] Findings P0 avec PoC
- [ ] Findings P1 avec PoC
- [ ] Findings P2 avec PoC
- [ ] Tableaux par composant
- [ ] Plan de remediation
- [ ] Annexe méthodologie
