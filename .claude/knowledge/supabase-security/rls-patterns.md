# RLS Patterns - Supabase

## Concepts de base

### Qu'est-ce que RLS ?

Row Level Security (RLS) est une fonctionnalité PostgreSQL qui permet de contrôler l'accès aux lignes d'une table selon des règles définies.

```sql
-- Activer RLS sur une table
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Créer une policy
CREATE POLICY "policy_name" ON table_name
  FOR operation -- SELECT, INSERT, UPDATE, DELETE, ALL
  TO role -- anon, authenticated, service_role
  USING (condition) -- Filtre les lignes visibles
  WITH CHECK (condition); -- Valide les écritures
```

### Différence USING vs WITH CHECK

| Clause | Usage | Opérations |
|--------|-------|------------|
| `USING` | Filtre les lignes accessibles | SELECT, UPDATE, DELETE |
| `WITH CHECK` | Valide les nouvelles valeurs | INSERT, UPDATE |

---

## Patterns corrects

### 1. Users voient leurs propres données

```sql
-- ✅ CORRECT
CREATE POLICY "Users see own data"
  ON profiles FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users update own data"
  ON profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
```

### 2. Public read, authenticated write

```sql
-- ✅ CORRECT - Posts publics
CREATE POLICY "Anyone can read published posts"
  ON posts FOR SELECT
  TO anon, authenticated
  USING (published = true);

CREATE POLICY "Authors can manage own posts"
  ON posts FOR ALL
  TO authenticated
  USING (auth.uid() = author_id)
  WITH CHECK (auth.uid() = author_id);
```

### 3. Admin-only access

```sql
-- ✅ CORRECT - Via custom claim dans JWT
CREATE POLICY "Admins only"
  ON admin_settings FOR ALL
  TO authenticated
  USING (
    (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin'
  );
```

### 4. Organisation-based access

```sql
-- ✅ CORRECT - Multi-tenant
CREATE POLICY "Users see org data"
  ON documents FOR SELECT
  TO authenticated
  USING (
    org_id IN (
      SELECT org_id FROM org_members
      WHERE user_id = auth.uid()
    )
  );
```

### 5. Hierarchical access (manager voit son équipe)

```sql
-- ✅ CORRECT
CREATE POLICY "Managers see team"
  ON employees FOR SELECT
  TO authenticated
  USING (
    manager_id = auth.uid()
    OR id = auth.uid()
  );
```

---

## Anti-patterns (à éviter)

### 1. Policy trop permissive

```sql
-- ❌ WRONG - Tous les users auth voient tout
CREATE POLICY "Authenticated can read"
  ON users FOR SELECT
  TO authenticated
  USING (true);  -- Pas de filtre !

-- ✅ FIX
CREATE POLICY "Users see own"
  ON users FOR SELECT
  TO authenticated
  USING (auth.uid() = id);
```

### 2. Oubli du WITH CHECK

```sql
-- ❌ WRONG - Users peuvent INSERT avec n'importe quel user_id
CREATE POLICY "Users insert"
  ON posts FOR INSERT
  TO authenticated
  WITH CHECK (true);  -- Pas de validation !

-- ✅ FIX
CREATE POLICY "Users insert own"
  ON posts FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = author_id);
```

### 3. RLS activé mais pas de policy

```sql
-- ❌ WRONG - RLS activé mais aucune policy
ALTER TABLE secrets ENABLE ROW LEVEL SECURITY;
-- Résultat : AUCUN accès (même pour service_role par défaut)

-- ✅ FIX - Ajouter les policies nécessaires
CREATE POLICY "..."
```

### 4. Policy SELECT sans UPDATE/DELETE correspondante

```sql
-- ❌ INCOMPLETE
CREATE POLICY "Users see own"
  ON profiles FOR SELECT
  USING (auth.uid() = user_id);
-- Users peuvent voir mais pas modifier !

-- ✅ COMPLETE
CREATE POLICY "Users see own"
  ON profiles FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users update own"
  ON profiles FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users delete own"
  ON profiles FOR DELETE
  USING (auth.uid() = user_id);
```

### 5. Exposer des champs sensibles

```sql
-- ❌ WRONG - Policy OK mais expose tout
CREATE POLICY "Users see own"
  ON users FOR SELECT
  USING (auth.uid() = id);
-- Expose : email, password_hash, etc.

-- ✅ FIX - Utiliser une VIEW
CREATE VIEW public.user_profiles AS
  SELECT id, display_name, avatar_url
  FROM users;

-- Appliquer RLS sur la view ou table source
```

---

## Tests de bypass courants

### 1. OR condition bypass

```sql
-- Tentative de bypass avec OR
SELECT * FROM posts WHERE published = true OR published = false;

-- Policy correcte bloque cela :
USING (published = true)  -- Le OR dans la query n'aide pas
```

### 2. Join exploitation

```sql
-- Tentative via join
SELECT c.*, p.* FROM comments c
JOIN posts p ON c.post_id = p.id;

-- Si posts a RLS et comments non :
-- comments expose les post_id même si posts est protégé
```

**Fix :** Appliquer RLS sur TOUTES les tables liées.

### 3. RPC bypass

```sql
-- ❌ Function qui bypass RLS
CREATE FUNCTION get_all_users()
RETURNS SETOF users AS $$
  SELECT * FROM users;
$$ LANGUAGE sql SECURITY DEFINER;

-- ✅ Function qui respecte RLS
CREATE FUNCTION get_all_users()
RETURNS SETOF users AS $$
  SELECT * FROM users;
$$ LANGUAGE sql SECURITY INVOKER;  -- Utilise les permissions du caller
```

### 4. Trigger bypass

```sql
-- ❌ Trigger qui expose des données
CREATE TRIGGER audit_trigger
AFTER INSERT ON orders
FOR EACH ROW EXECUTE FUNCTION log_order();
-- La function log_order pourrait exposer des données

-- ✅ Toujours vérifier les permissions dans les triggers
```

---

## Fonctions utiles

### auth.uid()

Retourne l'UUID de l'utilisateur authentifié.

```sql
auth.uid() -- UUID ou NULL si non authentifié
```

### auth.jwt()

Retourne le JWT complet (claims inclus).

```sql
auth.jwt() -> 'app_metadata' ->> 'role'  -- Custom claims
auth.jwt() ->> 'email'  -- Email de l'utilisateur
```

### auth.role()

Retourne le rôle PostgreSQL actuel.

```sql
auth.role()  -- 'anon', 'authenticated', ou 'service_role'
```

---

## Checklist RLS par type de table

### Tables utilisateurs (users, profiles)

```sql
-- ✅ Checklist
[ ] RLS activé
[ ] SELECT : own data only
[ ] UPDATE : own data only
[ ] DELETE : own data only (ou désactivé)
[ ] INSERT : généralement via auth.users, pas direct
[ ] Pas de champs sensibles exposés (password_hash, etc.)
```

### Tables de contenu (posts, comments)

```sql
-- ✅ Checklist
[ ] RLS activé
[ ] SELECT : public ou filtré (published, visibility)
[ ] INSERT : authenticated + WITH CHECK author_id
[ ] UPDATE : author only
[ ] DELETE : author only ou admin
```

### Tables financières (orders, payments)

```sql
-- ✅ Checklist
[ ] RLS activé (STRICT)
[ ] SELECT : own orders only
[ ] INSERT : via Edge Function (pas direct)
[ ] UPDATE : limité ou via Edge Function
[ ] DELETE : généralement interdit
[ ] Audit trail activé
```

### Tables de configuration (settings)

```sql
-- ✅ Checklist
[ ] RLS activé
[ ] SELECT : admin only ou filtered
[ ] INSERT : admin only
[ ] UPDATE : admin only
[ ] DELETE : admin only
```
