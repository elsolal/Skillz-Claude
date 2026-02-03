# Auth Configuration Security - Supabase

## Endpoints Auth (GoTrue)

```
https://[project].supabase.co/auth/v1/
```

| Endpoint | Purpose |
|----------|---------|
| `/auth/v1/settings` | Settings publics (limité) |
| `/auth/v1/signup` | Inscription |
| `/auth/v1/token` | Authentication |
| `/auth/v1/user` | Info utilisateur courant |
| `/auth/v1/recover` | Récupération mot de passe |
| `/auth/v1/otp` | OTP / Magic link |

---

## Checklist Authentication

### Email/Password

| Setting | Recommandé | Risque si manquant | Comment vérifier |
|---------|------------|-------------------|------------------|
| Email confirmation | ✅ Activé | Faux comptes | Tenter signup → check response |
| Password min length | ≥ 8 chars | Mots de passe faibles | Tenter signup avec "123456" |
| Password complexity | ✅ Activé | Facile à deviner | Test patterns simples |
| Rate limiting | ✅ Activé | Brute force | Multiple attempts |

### OAuth Providers

| Setting | Recommandé | Risque |
|---------|------------|--------|
| Providers vérifiés uniquement | Oui | Account takeover |
| Redirect URLs spécifiques | URLs exactes | OAuth redirect attacks |
| State parameter | Activé | CSRF attacks |

### Session Security

| Setting | Recommandé | Risque |
|---------|------------|--------|
| JWT expiry court | ≤ 1 heure | Token theft prolongé |
| Refresh token rotation | Activé | Token reuse |
| Secure cookie flags | HttpOnly, Secure, SameSite | XSS, CSRF |

---

## Tests à effectuer

### 1. Signup ouvert ou fermé ?

```bash
curl -X POST "$SUPABASE_URL/auth/v1/signup" \
  -H "apikey: $ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{"email": "test@example.com", "password": "Test123456!"}'
```

| Réponse | Signification |
|---------|---------------|
| 200 + user créé | Signup ouvert |
| 400 "Signups disabled" | Signup fermé ✅ |
| 429 | Rate limited ✅ |

### 2. Email confirmation requise ?

Après signup, vérifier la réponse :

```json
{
  "user": {
    "email_confirmed_at": null  // ⚠️ Non confirmé mais actif
  }
}
```

Si l'utilisateur peut se connecter immédiatement → Email confirmation désactivée.

### 3. Password policy

```bash
# Test mot de passe faible
curl -X POST "$SUPABASE_URL/auth/v1/signup" \
  -H "apikey: $ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{"email": "weak@example.com", "password": "123456"}'
```

| Réponse | Signification |
|---------|---------------|
| 200 OK | ⚠️ Password faible accepté |
| 400 "Password too short" | ✅ Policy active |

### 4. Rate limiting

```bash
# 10 tentatives rapides
for i in {1..10}; do
  curl -X POST "$SUPABASE_URL/auth/v1/token?grant_type=password" \
    -H "apikey: $ANON_KEY" \
    -H "Content-Type: application/json" \
    -d '{"email": "test@example.com", "password": "wrong"}'
done
```

Si pas de 429 → Rate limiting manquant.

### 5. CORS origins

```bash
curl -I "$SUPABASE_URL/auth/v1/settings" \
  -H "Origin: https://malicious-site.com"
```

Vérifier `Access-Control-Allow-Origin` :
- `*` → ⚠️ Trop permissif
- URL spécifique → ✅

---

## Vulnérabilités communes

### 1. Email confirmation désactivée (P1)

```
Finding: 🟠 P1
Issue: Users can signup without email verification
Impact: Fake accounts, typosquatting, spam
```

**Risques :**
- Comptes avec emails invalides
- Typosquatting (user@gmial.com)
- Pas de canal de communication vérifié
- Potentiel d'abus

**Remediation :**
```
Dashboard → Authentication → Settings → Email Auth
✅ Confirm email : ON
```

### 2. Password policy faible (P1/P2)

```
Finding: 🟠 P1 / 🟡 P2
Issue: Minimum 6 characters
Impact: Weak passwords, brute force
```

**Remediation :**
```
Dashboard → Authentication → Settings
Minimum password length : 8+
```

### 3. CORS wildcard (P2)

```
Finding: 🟡 P2
Issue: Access-Control-Allow-Origin: *
Impact: Requests from any origin accepted
```

**Remediation :**
```
Dashboard → Authentication → URL Configuration
Site URL : https://myapp.com
Redirect URLs : Uniquement vos domaines
```

### 4. Anonymous auth activé sans raison (INFO)

```
Finding: ℹ️ INFO
Issue: Anonymous authentication enabled
Impact: Guest access possible
```

**Action :** Vérifier si c'est intentionnel. Si non :
```
Dashboard → Authentication → Providers → Anonymous
Disable
```

---

## OAuth Security

### Redirect URL attacks

**Problème :** Si les redirect URLs sont trop permissives :
```
# Attaquant peut rediriger vers son site
https://app.com/auth?redirect=https://evil.com
```

**Remediation :**
```
Dashboard → Authentication → URL Configuration
Redirect URLs : Liste exacte de vos URLs
❌ https://*.myapp.com (wildcard dangereux)
✅ https://myapp.com/auth/callback
✅ https://app.myapp.com/auth/callback
```

### PKCE pour OAuth

Supabase utilise PKCE par défaut (bien), vérifier que le client ne le désactive pas.

---

## Configuration recommandée

```yaml
# Supabase Auth Settings

email:
  enable_signup: true  # ou false si invite-only
  enable_confirmations: true  # ✅ IMPORTANT
  double_confirm_changes: true

password:
  min_length: 8
  required_characters:
    - lowercase
    - uppercase  # optionnel mais recommandé
    - numbers    # optionnel mais recommandé

rate_limit:
  token_refresh: 360  # per hour
  signup: 3  # per hour per IP

session:
  timebox: 86400  # 24h max session
  inactivity_timeout: 900  # 15min inactivity

jwt:
  exp: 3600  # 1 hour

cors:
  allowed_origins:
    - https://myapp.com
    - https://app.myapp.com
```

---

## Scripts de test

### Test complet de la config auth

```bash
#!/bin/bash
SUPABASE_URL="https://xxx.supabase.co"
ANON_KEY="eyJ..."

echo "=== Testing Auth Configuration ==="

# 1. Signup test
echo -e "\n[1] Testing signup..."
SIGNUP=$(curl -s -X POST "$SUPABASE_URL/auth/v1/signup" \
  -H "apikey: $ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{"email": "test-'$(date +%s)'@test.local", "password": "Test123456!"}')
echo "$SIGNUP" | jq -r '.user.email_confirmed_at // "Not in response"'

# 2. Weak password test
echo -e "\n[2] Testing weak password..."
WEAK=$(curl -s -X POST "$SUPABASE_URL/auth/v1/signup" \
  -H "apikey: $ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{"email": "weak@test.local", "password": "123456"}')
echo "$WEAK" | jq -r '.error_description // "Accepted (BAD)"'

# 3. CORS test
echo -e "\n[3] Testing CORS..."
curl -s -I "$SUPABASE_URL/auth/v1/settings" \
  -H "Origin: https://malicious.com" 2>/dev/null | grep -i "access-control"

echo -e "\n=== Auth Config Test Complete ==="
```
