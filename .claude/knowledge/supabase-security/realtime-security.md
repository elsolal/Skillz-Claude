# Realtime Security - Supabase

## Endpoint

```
wss://[project].supabase.co/realtime/v1/websocket
```

## Fonctionnalités Realtime

| Feature | Description | Risque si mal configuré |
|---------|-------------|------------------------|
| **Postgres Changes** | Stream des changements DB | Données sensibles streamées |
| **Broadcast** | Pub/sub messaging | Messages non autorisés |
| **Presence** | Tracking utilisateurs connectés | Enumération users |

---

## Modèle de sécurité

### Postgres Changes + RLS

Realtime respecte les policies RLS :

```sql
-- Cette policy RLS s'applique aussi au Realtime
CREATE POLICY "Users see own data"
  ON users FOR SELECT
  USING (auth.uid() = id);

-- Avec cette policy :
-- - API SELECT : Uniquement ses données
-- - Realtime : Uniquement les changements de ses données
```

### ⚠️ Si RLS manquant

```sql
-- ❌ Table sans RLS
-- Realtime stream TOUS les changements à TOUS les clients !
```

---

## Tests à effectuer

### 1. Postgres Changes - Test subscription anonyme

```javascript
// Test : subscriber aux changements d'une table sensible
const channel = supabase
  .channel('test')
  .on('postgres_changes', {
    event: '*',
    schema: 'public',
    table: 'users'  // Table sensible
  }, (payload) => {
    console.log('Change received:', payload);
  })
  .subscribe();

// Si on reçoit les changements → RLS manquant/mal configuré
```

### 2. Broadcast - Test accès aux channels

```javascript
// Tester l'accès à des channels sensibles
const channels = ['admin', 'notifications', 'payments', 'internal'];

for (const name of channels) {
  const channel = supabase.channel(name);
  channel.subscribe((status) => {
    if (status === 'SUBSCRIBED') {
      console.log(`⚠️ Channel '${name}' accessible !`);
    }
  });
}
```

### 3. Presence - Test exposition des données

```javascript
const channel = supabase.channel('online-users');

channel.on('presence', { event: 'sync' }, () => {
  const state = channel.presenceState();
  console.log('Users online:', state);
  // Vérifier quelles données sont exposées
  // (email, user_id, données sensibles ?)
});

channel.subscribe();
```

---

## Vulnérabilités courantes

### 1. Données utilisateur streamées sans RLS

```
Finding: 🔴 P0
Table: users
Event: Tous les INSERT/UPDATE/DELETE reçus
Impact: PII exposé en temps réel
```

**Remediation :**

```sql
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users see only themselves"
  ON users FOR SELECT
  USING (auth.uid() = id);
```

### 2. Channel admin accessible publiquement

```
Finding: 🟠 P1
Channel: admin
Status: Accessible à tous les users authentifiés
Impact: Messages admin visibles
```

**Remediation :**

```sql
-- Realtime authorization policies
CREATE POLICY "Admin channel for admins only"
  ON realtime.channels FOR SELECT
  USING (
    name != 'admin' OR
    (SELECT is_admin FROM profiles WHERE id = auth.uid())
  );
```

### 3. Presence expose trop de données

```
Finding: 🟠 P1
Channel: online-users
Data exposed: email, user_id, full_name
Impact: Enumération des utilisateurs
```

**Remediation :**

```javascript
// ❌ Avant - trop de données
channel.track({
  user_id: userId,
  email: email,
  name: fullName,
  avatar: avatarUrl
});

// ✅ Après - données minimales
channel.track({
  online_at: new Date().toISOString()
  // Détails récupérés séparément si besoin
});
```

---

## Sécuriser les Broadcast Channels

### Option 1 : RLS sur realtime.channels

```sql
-- Requiert auth pour tous les channels
CREATE POLICY "Authenticated users join channels"
  ON realtime.channels FOR SELECT
  USING (auth.role() = 'authenticated');

-- Restreindre certains channels
CREATE POLICY "Restrict sensitive channels"
  ON realtime.channels FOR SELECT
  USING (
    name NOT IN ('admin', 'internal', 'payments') OR
    (SELECT role FROM profiles WHERE id = auth.uid()) = 'admin'
  );
```

### Option 2 : Vérification côté client

```javascript
// Vérifier l'accès avant de subscribe
const { data: canAccess } = await supabase
  .from('channel_permissions')
  .select('*')
  .eq('channel', 'admin')
  .eq('user_id', userId)
  .single();

if (canAccess) {
  const channel = supabase.channel('admin');
  channel.subscribe();
}
```

### Option 3 : Channel naming convention

```javascript
// Channels privés avec user_id
const privateChannel = supabase.channel(`user:${userId}`);

// Channels publics clairement identifiés
const publicChannel = supabase.channel('public:lobby');
```

---

## Checklist Realtime

| Check | Table/Channel | Action |
|-------|--------------|--------|
| Tables sensibles | users, profiles, orders | RLS obligatoire |
| Tables publiques | posts, comments | RLS avec filtre published |
| Broadcast admin | admin, internal | Policy restriction |
| Broadcast user | notifications | Channel par user |
| Presence | online-users | Données minimales |

---

## Code de test reproductible

```bash
# Test Realtime via wscat
npm install -g wscat

wscat -c "wss://[PROJECT].supabase.co/realtime/v1/websocket?apikey=[ANON_KEY]&vsn=1.0.0"

# Une fois connecté, envoyer :
{"topic":"realtime:public:users","event":"phx_join","payload":{},"ref":"1"}

# Observer si des changements arrivent
```

```javascript
// Script de test complet
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(SUPABASE_URL, ANON_KEY);

// Test toutes les tables
const tables = ['users', 'profiles', 'orders', 'posts'];

for (const table of tables) {
  const channel = supabase
    .channel(`test-${table}`)
    .on('postgres_changes',
      { event: '*', schema: 'public', table },
      (payload) => {
        console.log(`⚠️ [${table}] Change received:`, payload.eventType);
      }
    )
    .subscribe((status) => {
      console.log(`[${table}] Status: ${status}`);
    });
}

// Attendre et observer
setTimeout(() => process.exit(), 60000);
```
