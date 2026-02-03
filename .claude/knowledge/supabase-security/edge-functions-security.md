# Edge Functions Security - Supabase

## Endpoint

```
https://[project].supabase.co/functions/v1/[function-name]
```

## Vulnérabilités communes

| Vulnérabilité | Description | Sévérité |
|---------------|-------------|----------|
| No auth | Function accessible sans JWT | P0-P2 |
| IDOR | User accède aux données d'autres users | P0 |
| Missing role check | User normal accède aux fonctions admin | P0 |
| Input injection | Input non validé | P0-P1 |
| Info disclosure | Erreurs révèlent des détails internes | P1-P2 |
| CORS misconfigured | Accessible depuis origines non prévues | P1-P2 |

---

## Patterns sécurisés

### 1. Authentication Check

```typescript
import { createClient } from '@supabase/supabase-js'

Deno.serve(async (req) => {
  // Get JWT from header
  const authHeader = req.headers.get('Authorization');
  if (!authHeader) {
    return new Response('Unauthorized', { status: 401 });
  }

  // Verify JWT with Supabase
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_ANON_KEY')!,
    { global: { headers: { Authorization: authHeader } } }
  );

  const { data: { user }, error } = await supabase.auth.getUser();
  if (error || !user) {
    return new Response('Unauthorized', { status: 401 });
  }

  // User is authenticated, continue...
});
```

### 2. IDOR Prevention (Authorization Check)

```typescript
// ❌ VULNÉRABLE - IDOR
Deno.serve(async (req) => {
  const { userId } = await req.json();
  // Récupère les données de n'importe quel user !
  const { data } = await supabase
    .from('profiles')
    .select()
    .eq('id', userId);
  return new Response(JSON.stringify(data));
});

// ✅ SÉCURISÉ - Vérifie ownership
Deno.serve(async (req) => {
  const authHeader = req.headers.get('Authorization');
  const { data: { user } } = await supabase.auth.getUser();

  const { userId } = await req.json();

  // Vérifier que l'utilisateur demande SES données
  if (userId !== user.id) {
    return new Response('Forbidden', { status: 403 });
  }

  const { data } = await supabase
    .from('profiles')
    .select()
    .eq('id', user.id);  // Utilise l'ID du JWT, pas de la request
  return new Response(JSON.stringify(data));
});
```

### 3. Role Check (Admin Functions)

```typescript
// ❌ VULNÉRABLE - Pas de vérification de rôle
Deno.serve(async (req) => {
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return new Response('Unauthorized', { status: 401 });

  // Tout utilisateur authentifié a accès admin !
  return new Response(JSON.stringify({ adminData: '...' }));
});

// ✅ SÉCURISÉ - Vérifie le rôle admin
Deno.serve(async (req) => {
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return new Response('Unauthorized', { status: 401 });

  // Vérifier le rôle dans la base
  const { data: profile } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', user.id)
    .single();

  if (profile?.role !== 'admin') {
    return new Response('Forbidden', { status: 403 });
  }

  // Opération admin autorisée
  return new Response(JSON.stringify({ adminData: '...' }));
});
```

### 4. Input Validation avec Zod

```typescript
import { z } from 'zod';

const PaymentSchema = z.object({
  amount: z.number().positive().max(10000),
  currency: z.enum(['usd', 'eur', 'gbp']),
  description: z.string().max(200).optional()
});

Deno.serve(async (req) => {
  const body = await req.json();

  // Valider l'input
  const result = PaymentSchema.safeParse(body);
  if (!result.success) {
    return new Response(
      JSON.stringify({ error: 'Invalid input' }),
      { status: 400 }
    );
  }

  // Input validé, continuer avec result.data
  const { amount, currency } = result.data;
  // ...
});
```

### 5. Safe Error Handling

```typescript
// ❌ VULNÉRABLE - Expose des détails internes
Deno.serve(async (req) => {
  try {
    // ...
  } catch (error) {
    return new Response(
      JSON.stringify({
        error: error.message,
        stack: error.stack,  // ❌ Ne jamais exposer
        query: sqlQuery      // ❌ Ne jamais exposer
      }),
      { status: 500 }
    );
  }
});

// ✅ SÉCURISÉ - Message générique + log serveur
Deno.serve(async (req) => {
  try {
    // ...
  } catch (error) {
    // Log côté serveur pour debugging
    console.error('Function error:', error);

    // Message générique côté client
    return new Response(
      JSON.stringify({ error: 'Internal server error' }),
      { status: 500 }
    );
  }
});
```

### 6. Webhook Signature Validation

```typescript
import { crypto } from "https://deno.land/std/crypto/mod.ts";

Deno.serve(async (req) => {
  const signature = req.headers.get('x-webhook-signature');
  const body = await req.text();
  const secret = Deno.env.get('WEBHOOK_SECRET');

  // Calculer la signature attendue
  const encoder = new TextEncoder();
  const key = await crypto.subtle.importKey(
    "raw",
    encoder.encode(secret),
    { name: "HMAC", hash: "SHA-256" },
    false,
    ["sign"]
  );
  const sig = await crypto.subtle.sign("HMAC", key, encoder.encode(body));
  const expectedSignature = `sha256=${btoa(String.fromCharCode(...new Uint8Array(sig)))}`;

  // ❌ Ne pas révéler les détails en cas d'erreur
  if (signature !== expectedSignature) {
    console.error(`Invalid signature: expected ${expectedSignature}, got ${signature}`);
    return new Response('Unauthorized', { status: 401 });
  }

  // Signature valide, continuer...
});
```

---

## Discovery methods

### 1. Analyse du code client

```javascript
// Chercher dans le code client
supabase.functions.invoke('function-name', {...})
fetch('/functions/v1/function-name', {...})
```

### 2. Noms communs à tester

```
hello-world, hello, test
process-payment, payment, checkout
get-user-data, user, profile
admin, admin-panel, dashboard
webhook, webhook-handler, stripe-webhook
send-email, notify, notification
export, import, sync
```

### 3. Analyse des réponses

```
404 Not Found → Function n'existe pas
401 Unauthorized → Function existe, auth requise
200 OK → Function existe et accessible
```

---

## Checklist sécurité Edge Functions

| Check | Recommandé | Risque si manquant |
|-------|------------|-------------------|
| JWT required | Oui (sauf public) | Accès non autorisé |
| User ownership check | Oui | IDOR |
| Role/permission check | Oui pour admin | Privilege escalation |
| Input validation | Oui (Zod) | Injection |
| Rate limiting | Oui | DoS, brute force |
| Error handling | Generic messages | Info disclosure |
| CORS restricted | Oui | Cross-origin attacks |
