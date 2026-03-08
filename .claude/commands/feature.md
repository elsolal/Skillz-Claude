---
description: Lance le workflow multi-agent pour implémenter une feature. Explore → Plan → Code+Tests parallèles → Review ×3 parallèle → Commit+PR.
---

# Feature Implementation: $ARGUMENTS

## Workflow Multi-Agent

```
┌──────────────────────────────────────────────────────────────────────────┐
│  EXPLORE       PLAN         IMPLEMENT          REVIEW        FINALIZE   │
│  (natif)     (natif)      (2 agents //)     (3 agents //)              │
│                                                                         │
│  Agent    →  Plan Mode  →  ┌─ Code Agent  →  ┌─ Correctness  → Commit  │
│  Explore     + Tasks       └─ Test Agent     ├─ Readability     + PR   │
│                                               └─ Performance            │
│                                                                         │
│  [STOP]      [STOP]         [STOP]             [STOP]        [STOP]    │
└──────────────────────────────────────────────────────────────────────────┘
```

---

## Phase 1: EXPLORE

Utiliser **Agent Explore** (natif) pour comprendre le codebase :

1. Lancer un agent `subagent_type: Explore` avec comme prompt :
   - "Analyse le codebase pour comprendre comment implémenter **$ARGUMENTS**. Identifie : architecture, fichiers impactés, patterns existants, dépendances, risques."
2. Récupérer et lire l'issue GitHub si `$ARGUMENTS` contient un numéro d'issue
3. Synthétiser : requirements, fichiers à modifier, patterns à suivre

**⏸️ CHECKPOINT 1** — Présenter la synthèse. Validation avant de planifier.

---

## Phase 2: PLAN

Utiliser **Plan Mode** (natif) :

1. Entrer en Plan Mode (`EnterPlanMode`)
2. Créer un plan d'implémentation avec étapes atomiques
3. Si **2+ étapes** → créer des Tasks (`TaskCreate`) pour tracking
4. Faire valider le plan

**⏸️ CHECKPOINT 2** — Validation du plan avant implémentation.

---

## Phase 3: IMPLEMENT (2 agents parallèles)

Lancer **2 agents en parallèle** dans un seul message :

### Agent 1 : Code
```
Agent(subagent_type: "general-purpose", mode: "auto")
Prompt: "Implémente le plan validé. Respecte les conventions du projet.
Vérifie lint + types après chaque modification.
Knowledge refs: .claude/knowledge/testing/error-handling.md, feature-flags.md"
```

### Agent 2 : Tests
```
Agent(subagent_type: "general-purpose", mode: "auto")
Prompt: "Écris les tests pour la feature. Priorités P0-P3, risk-based.
Knowledge refs: .claude/knowledge/testing/test-levels-framework.md,
test-priorities-matrix.md, test-quality.md, data-factories.md,
fixture-architecture.md, network-first.md, component-tdd.md,
test-healing-patterns.md, selector-resilience.md"
```

> **Note :** Si la feature est simple (1 étape), les 2 agents peuvent être fusionnés en un seul.

**⏸️ CHECKPOINT 3** — Vérifier que code + tests passent. Validation.

---

## Phase 4: REVIEW (3 agents parallèles)

Lancer **3 agents review en parallèle** dans un seul message :

### Agent Correctness
```
Agent(subagent_type: "general-purpose")
Prompt: "Review Pass 1 - CORRECTNESS. Vérifie : logique métier, edge cases, bugs,
types, failles sécurité. Classifie : 🔴 Critical, 🟡 Medium, 🟢 Minor.
Knowledge: .claude/knowledge/testing/error-handling.md, risk-governance.md,
probability-impact.md"
```

### Agent Readability
```
Agent(subagent_type: "general-purpose")
Prompt: "Review Pass 2 - READABILITY. Vérifie : nommage, taille des fonctions,
commentaires utiles, structure logique, DRY, abstractions.
Knowledge: .claude/knowledge/testing/test-quality.md, nfr-criteria.md"
```

### Agent Performance
```
Agent(subagent_type: "general-purpose")
Prompt: "Review Pass 3 - PERFORMANCE. Vérifie : O(n²) évitables, re-renders,
queries optimisées, memory leaks, lazy loading, caching.
Knowledge: .claude/knowledge/testing/nfr-criteria.md"
```

Synthétiser les 3 rapports. Corriger les issues 🔴 Critical.

**⏸️ CHECKPOINT 4** — Présenter le résumé review. Validation.

---

## Phase 5: FINALIZE

1. Vérifier que tous les tests passent après corrections review
2. Proposer : **[C] Commit** | **[P] Commit + PR** | **[R] Réviser encore**

---

## Démarrage

Issue à traiter : **$ARGUMENTS**

Je commence par **Phase 1: EXPLORE**.
