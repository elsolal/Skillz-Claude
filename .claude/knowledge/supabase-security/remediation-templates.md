# Remediation Templates - Supabase Security

## P0 - Actions immédiates

### Service Key Exposée

**Problème :** La clé `service_role` est visible dans le code client.

**Impact :** Accès complet à la base de données, bypass de tous les RLS.

**Remediation immédiate :**

```bash
# 1. Aller dans Supabase Dashboard
#    Settings → API → Regenerate service_role key

# 2. Supprimer la clé du code source
#    Chercher et supprimer toute occurrence

# 3. Redéployer l'application
```

**Remediation long terme :**

```typescript
// ❌ AVANT - Service key côté client
const supabase = createClient(url, process.env.NEXT_PUBLIC_SERVICE_KEY);

// ✅ APRÈS - Utiliser Edge Function pour opérations privilégiées
// Client
const { data } = await supabase.functions.invoke('admin-action', {
  body: { action: 'delete-user', userId: '123' }
});

// Edge Function (supabase/functions/admin-action/index.ts)
import { createClient } from '@supabase/supabase-js';

Deno.serve(async (req) => {
  // Vérifier que l'appelant est admin
  const authHeader = req.headers.get('Authorization');
  const token = authHeader?.replace('Bearer ', '');

  const supabaseAuth = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_ANON_KEY')!
  );

  const { data: { user } } = await supabaseAuth.auth.getUser(token);

  // Vérifier le rôle admin
  if (user?.app_metadata?.role !== 'admin') {
    return new Response('Unauthorized', { status: 403 });
  }

  // Maintenant utiliser service_role
  const supabaseAdmin = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  );

  // Effectuer l'action admin
  // ...
});
```

---

### Table sans RLS (données sensibles)

**Problème :** Une table avec données personnelles n'a pas de RLS activé.

**Impact :** Toutes les données accessibles à n'importe qui avec la clé anon.

**Remediation :**

```sql
-- 1. Activer RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- 2. Créer les policies appropriées

-- Users voient uniquement leurs propres données
CREATE POLICY "Users see own data"
  ON users FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

-- Users peuvent modifier uniquement leurs propres données
CREATE POLICY "Users update own data"
  ON users FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Pas de DELETE direct (ou restreint)
CREATE POLICY "Users cannot delete"
  ON users FOR DELETE
  TO authenticated
  USING (false);  -- Utiliser une Edge Function pour soft delete

-- 3. Vérifier que ça fonctionne
-- En tant qu'anon :
SELECT * FROM users;  -- Devrait retourner 0 lignes

-- En tant qu'authenticated (user A) :
SELECT * FROM users;  -- Devrait retourner uniquement le user A
```

---

### Bucket public avec fichiers sensibles

**Problème :** Un bucket contenant des backups/secrets est configuré comme public.

**Impact :** N'importe qui peut télécharger les fichiers via URL directe.

**Remediation :**

```sql
-- 1. Rendre le bucket privé
UPDATE storage.buckets
SET public = false
WHERE name = 'backups';

-- 2. Ajouter RLS pour le storage
CREATE POLICY "Only admins access backups"
  ON storage.objects FOR ALL
  TO authenticated
  USING (
    bucket_id = 'backups'
    AND (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin'
  );

-- 3. Supprimer ou déplacer les fichiers sensibles exposés
-- Via Dashboard ou CLI
```

**Actions complémentaires :**

```bash
# Rotation de tous les secrets qui étaient dans les fichiers exposés
# - Clés API
# - Passwords
# - JWT secrets
```

---

## P1 - Cette semaine

### Email confirmation désactivée

**Problème :** Les utilisateurs peuvent créer des comptes sans vérifier leur email.

**Impact :** Risque de spam, comptes non vérifiés, abus.

**Remediation :**

```
Supabase Dashboard → Authentication → Settings → Email Auth

✅ Enable email confirmations : ON
✅ Secure email change : ON
```

**Code pour vérifier le status :**

```typescript
const { data: { user } } = await supabase.auth.getUser();

if (!user?.email_confirmed_at) {
  // Rediriger vers page de confirmation
  // ou restreindre les fonctionnalités
}
```

---

### Password policy faible

**Problème :** Minimum de caractères trop bas (< 8).

**Remediation :**

```
Supabase Dashboard → Authentication → Settings → Password requirements

✅ Minimum password length : 8 (ou plus)
```

**Validation côté client (en plus) :**

```typescript
const passwordSchema = z.string()
  .min(8, 'Minimum 8 caractères')
  .regex(/[A-Z]/, 'Au moins une majuscule')
  .regex(/[a-z]/, 'Au moins une minuscule')
  .regex(/[0-9]/, 'Au moins un chiffre');
```

---

### RLS policy trop permissive

**Problème :** Policy avec `USING (true)` ou `auth.role() = 'authenticated'`.

**Impact :** Tous les utilisateurs authentifiés voient toutes les données.

**Remediation :**

```sql
-- ❌ AVANT
CREATE POLICY "bad_policy"
  ON profiles FOR SELECT
  TO authenticated
  USING (true);

-- Supprimer l'ancienne policy
DROP POLICY "bad_policy" ON profiles;

-- ✅ APRÈS
CREATE POLICY "Users see own profile"
  ON profiles FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);
```

---

### IDOR dans Edge Function

**Problème :** Une Edge Function permet d'accéder aux données d'autres utilisateurs.

**Remediation :**

```typescript
// ❌ AVANT - IDOR
Deno.serve(async (req) => {
  const { userId } = await req.json();

  // Récupère les données de n'importe quel user !
  const { data } = await supabase
    .from('profiles')
    .select()
    .eq('id', userId);

  return new Response(JSON.stringify(data));
});

// ✅ APRÈS - Vérifie que c'est l'utilisateur lui-même
Deno.serve(async (req) => {
  // Extraire l'utilisateur du token
  const authHeader = req.headers.get('Authorization');
  const token = authHeader?.replace('Bearer ', '');

  const { data: { user } } = await supabase.auth.getUser(token);

  if (!user) {
    return new Response('Unauthorized', { status: 401 });
  }

  // Utiliser l'ID de l'utilisateur authentifié, pas celui de la request
  const { data } = await supabase
    .from('profiles')
    .select()
    .eq('id', user.id);  // Force l'ID de l'utilisateur connecté

  return new Response(JSON.stringify(data));
});
```

---

## P2 - Ce mois

### Source maps exposées

**Problème :** Les fichiers `.js.map` sont accessibles en production.

**Remediation (Next.js) :**

```javascript
// next.config.js
module.exports = {
  productionBrowserSourceMaps: false,
};
```

**Remediation (Vite) :**

```javascript
// vite.config.js
export default {
  build: {
    sourcemap: false, // ou 'hidden' pour garder côté serveur
  },
};
```

---

### Rate limiting manquant

**Problème :** Pas de protection contre le brute force.

**Remediation côté Supabase :**

```
Dashboard → Authentication → Rate Limits

✅ Activer les rate limits par défaut
```

**Remediation côté Edge Function :**

```typescript
import { Ratelimit } from '@upstash/ratelimit';
import { Redis } from '@upstash/redis';

const ratelimit = new Ratelimit({
  redis: Redis.fromEnv(),
  limiter: Ratelimit.slidingWindow(10, '10 s'),
});

Deno.serve(async (req) => {
  const ip = req.headers.get('x-forwarded-for') ?? 'anonymous';
  const { success } = await ratelimit.limit(ip);

  if (!success) {
    return new Response('Too many requests', { status: 429 });
  }

  // Continue...
});
```

---

### Signup ouvert sans CAPTCHA

**Problème :** Bots peuvent créer des comptes en masse.

**Remediation :**

```
Dashboard → Authentication → Settings → Security

✅ Enable CAPTCHA protection : ON
```

**Intégration Turnstile (Cloudflare) :**

```typescript
const { data, error } = await supabase.auth.signUp({
  email,
  password,
  options: {
    captchaToken: turnstileToken,
  },
});
```

---

## Templates SQL réutilisables

### Activer RLS sur toutes les tables

```sql
DO $$
DECLARE
  tbl RECORD;
BEGIN
  FOR tbl IN
    SELECT tablename
    FROM pg_tables
    WHERE schemaname = 'public'
  LOOP
    EXECUTE format('ALTER TABLE %I ENABLE ROW LEVEL SECURITY', tbl.tablename);
    RAISE NOTICE 'RLS enabled on %', tbl.tablename;
  END LOOP;
END $$;
```

### Audit des tables sans RLS

```sql
SELECT
  schemaname,
  tablename,
  rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
  AND rowsecurity = false;
```

### Lister toutes les policies

```sql
SELECT
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd,
  qual,
  with_check
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;
```

### Vérifier les buckets publics

```sql
SELECT
  id,
  name,
  public,
  created_at
FROM storage.buckets
WHERE public = true;
```
