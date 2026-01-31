# 🧠 MULTI-MIND

**Système de Débat Multi-Agents pour Validation IA**

| Attribut | Valeur |
|----------|--------|
| **Version** | 1.0.0 |
| **Date** | 31 Janvier 2026 |
| **Auteur** | Aymeric |
| **Statut** | 🟢 Prêt pour développement |

---

## 1. Résumé Exécutif

> **💡 Vision**
>
> Multi-Mind est un système de débat multi-agents qui fait collaborer 6 modèles IA de différents providers pour challenger et améliorer la qualité des PRD et du code. L'objectif est d'obtenir un consensus robuste avant tout développement.

### 1.1 Problème à résoudre

Le développement logiciel souffre de plusieurs limitations lorsqu'on utilise un seul modèle IA :

- Biais inhérents à chaque modèle (training data, architecture, fine-tuning)
- Angles morts sur certains aspects (sécurité, UX, performance, business)
- Absence de contradiction et de challenge des propositions
- Validation subjective sans diversité de perspectives

### 1.2 Solution proposée

Un système orchestré par Claude Code qui fait débattre 6 agents IA spécialisés :

| Agent | Provider | Rôle | Accès |
|-------|----------|------|-------|
| 🏛️ Claude | Anthropic | Architecte Prudent + Orchestrateur | Claude Code Max |
| 🤖 GPT | OpenAI | Perfectionniste (qualité code) | Codex CLI (20€/mois) |
| 💎 Gemini | Google | Innovateur UX | Gemini CLI (20€/mois) |
| 🐉 DeepSeek | DeepSeek | Provocateur (alternatives) | API gratuite (5M tokens) |
| 🔮 GLM-4.7 | Zhipu AI | Craftsman Frontend | API gratuite |
| 🌙 Kimi K2 | Moonshot | Product Thinker (ROI) | OpenRouter gratuit |

### 1.3 Bénéfices attendus

- Réduction de 60% des bugs en production grâce à la review multi-perspectives
- Détection précoce des failles de sécurité par l'analyse croisée
- Meilleure qualité architecturale grâce aux alternatives proposées
- Consensus documenté et traçable pour chaque décision

---

## 2. Contexte et Background

### 2.1 Écosystème actuel

Aymeric utilise actuellement le workflow D-EPCT+R (Discovery, Explain, Plan, Code, Test, Review) avec Claude Code Max. Ce workflow fonctionne bien mais manque de diversité de perspectives.

#### 2.1.1 Outils disponibles

| Outil | Statut | Coût mensuel |
|-------|--------|--------------|
| Claude Code Max | ✅ Actif | Inclus abonnement |
| ChatGPT Plus/Pro | ✅ Actif | 20€/mois |
| Codex CLI | 🟡 À activer | Inclus ChatGPT |
| Gemini Advanced | 🟡 À souscrire | 20€/mois |
| DeepSeek API | ✅ Clé disponible | Gratuit (5M tokens) |
| GLM-4.7 API | ✅ Clé disponible | Gratuit |
| OpenRouter | 🟡 À créer | Gratuit |

### 2.2 Recherche et analyse

#### 2.2.1 APIs testées et validées

Les APIs suivantes ont été analysées pour leur compatibilité OpenAI SDK :

- **DeepSeek V3** : Compatible, 5M tokens offerts à l'inscription, excellent en code
- **GLM-4.7** : Compatible, $0.60/M input, leader sur LiveCodeBench (84.9%)
- **Kimi K2** : Via OpenRouter, 1T paramètres, excellent en agentic tasks
- **Codex CLI** : Mode exec pour automatisation, output JSON structuré
- **Gemini CLI** : Mode headless (-p), 1000 req/jour gratuit

#### 2.2.2 Options écartées

- **Browser automation ChatGPT** : Violation TOS, risque de ban
- **Gemini API directe** : Tier gratuit limité à 20 req/jour
- **API OpenAI directe** : Coûteux, Codex CLI plus adapté

---

## 3. Spécifications Fonctionnelles

### 3.1 Cas d'utilisation principaux

#### UC-01 : Débat PRD

> **Scénario**
>
> En tant que Product Manager, je veux soumettre un PRD à 6 agents IA pour obtenir un consensus sur l'architecture et les risques avant de commencer le développement.

**Flux détaillé :**

1. L'utilisateur lance `/multi-mind prd ./docs/mon-prd.md`
2. **Pré-check CLIs** : Vérification et mise à jour automatique des CLIs (Codex, Gemini)
3. Claude lit le PRD et prépare le contexte
4. Les 6 agents reçoivent le PRD avec leur personnalité
5. Round 1 : Chaque agent critique indépendamment
6. Round 2 : Les agents répondent aux critiques des autres
7. Round 3 : Chaque agent propose son TOP 3
8. Round 4 : Claude synthétise le consensus
9. Output : Résumé terminal + rapport Markdown

> **⚠️ Note** : Claude Code se met à jour automatiquement, mais Codex CLI et Gemini CLI nécessitent une vérification manuelle pour bénéficier des dernières features des modèles.

#### UC-02 : Code Review Multi-Perspectives

> **Scénario**
>
> En tant que développeur, je veux faire reviewer mon code par 6 agents spécialisés pour identifier bugs, failles de sécurité, problèmes de performance et opportunités de refactoring.

**Critères de review par agent :**

- **Claude** : Sécurité, patterns, dette technique
- **GPT** : Qualité code, tests, conventions
- **Gemini** : UX, accessibilité, DX
- **DeepSeek** : Simplification, YAGNI, alternatives
- **GLM** : Esthétique code, performance frontend
- **Kimi** : ROI, impact business, priorisation

### 3.2 Workflow de débat

Le débat se déroule en 4 rounds structurés :

| Round | Objectif | Input | Output |
|-------|----------|-------|--------|
| 1. Critique | Analyse indépendante | PRD/Code | 6 critiques séparées |
| 2. Confrontation | Réponses croisées | Critiques R1 | Défenses/ajustements |
| 3. Convergence | Priorisation | Débat R2 | 6 × TOP 3 |
| 4. Consensus | Synthèse finale | Priorités R3 | Rapport unifié |

### 3.3 Les 6 personnalités

#### 🏛️ Claude - L'Architecte Prudent

- **Focus** : Sécurité, maintenabilité, patterns de design, dette technique
- **Style** : Sceptique par défaut, demande des justifications, méthodique
- **Questions types** : "Quelle est la surface d'attaque ?", "Comment ça scale à 10x ?", "Où est la dette technique ?"

#### 🤖 GPT - Le Perfectionniste

- **Focus** : Qualité du code, tests, conventions, refactoring
- **Style** : Exigeant sur les standards, montre le avant/après
- **Questions types** : "Ce nommage est-il explicite ?", "Où sont les tests edge case ?", "Peut-on simplifier ce pattern ?"

#### 💎 Gemini - L'Innovateur UX

- **Focus** : Expérience utilisateur, accessibilité, DX, innovation
- **Style** : Centré utilisateur, design thinking, propose des flows alternatifs
- **Questions types** : "Quel feedback pour l'utilisateur ?", "Est-ce accessible au clavier ?", "L'API est-elle intuitive ?"

#### 🐉 DeepSeek - Le Provocateur

- **Focus** : Alternatives radicales, YAGNI, simplification extrême
- **Style** : Provocateur, challenge tout, propose toujours une alternative
- **Questions types** : "Pourquoi pas serverless ?", "Peut-on supprimer 50% du code ?", "Cette abstraction est-elle nécessaire ?"

#### 🔮 GLM - Le Craftsman Frontend

- **Focus** : Esthétique du code, UI/UX, performance perçue, polish
- **Style** : Attentif aux détails, voit ce que les autres ne voient pas
- **Questions types** : "Le loading state est-il élégant ?", "Les animations sont-elles fluides ?", "Le code est-il beau ?"

#### 🌙 Kimi - Le Product Thinker

- **Focus** : ROI, MVP, time-to-market, valeur business
- **Style** : Pragmatique, orienté résultats, accepte la dette si justifiée
- **Questions types** : "Quel problème utilisateur ça résout ?", "Le coût dev est-il justifié ?", "Peut-on livrer une V1 plus simple ?"

---

## 4. Architecture Technique

### 4.1 Vue d'ensemble

Le système est composé de 3 couches principales :

- **Couche Orchestration** : Claude Code gère le flux des rounds
- **Couche Agents** : 6 connecteurs vers les différentes APIs/CLIs
- **Couche Output** : Génération du résumé terminal et rapport Markdown

### 4.2 Structure des fichiers

Le skill Claude Code sera organisé ainsi :

```
~/.claude/skills/multi-mind/
├── SKILL.md              # Instructions Claude Code
├── package.json
├── tsconfig.json
│
├── src/
│   ├── index.ts          # Entry point
│   ├── orchestrator.ts   # Gestion des rounds
│   │
│   ├── agents/
│   │   ├── base-agent.ts      # Interface commune
│   │   ├── claude-agent.ts
│   │   ├── gpt-agent.ts       # Via Codex CLI exec
│   │   ├── gemini-agent.ts    # Via Gemini CLI -p
│   │   ├── deepseek-agent.ts  # Via API REST
│   │   ├── glm-agent.ts       # Via API REST
│   │   └── kimi-agent.ts      # Via OpenRouter
│   │
│   ├── debate/
│   │   ├── round-manager.ts   # Gestion 4 rounds
│   │   ├── personalities.ts   # System prompts
│   │   └── consensus.ts       # Synthèse finale
│   │
│   └── output/
│       ├── terminal.ts        # Résumé live
│       └── markdown.ts        # Rapport détaillé
│
├── config/
│   └── api-keys.example.json  # Template config
│
└── templates/
    ├── debate-prd.md          # Template débat PRD
    └── debate-review.md       # Template code review
```

### 4.3 Connecteurs par agent

#### 4.3.0 Pré-check : Mise à jour des CLIs

Avant chaque débat, l'orchestrateur vérifie et met à jour les CLIs pour garantir l'accès aux dernières features des modèles :

```bash
# 🔄 Mise à jour automatique des CLIs (exécuté au lancement)
npm update -g @openai/codex 2>/dev/null || echo "Codex CLI: à jour"
npm update -g @google/gemini-cli 2>/dev/null || echo "Gemini CLI: à jour"

# 📋 Vérification des versions installées
codex --version
gemini --version
```

> **Pourquoi ?** Claude Code se met à jour automatiquement, mais les CLIs tiers (Codex, Gemini) nécessitent une mise à jour manuelle. Les nouvelles versions peuvent inclure de nouveaux modèles, des corrections de bugs, ou des options de sortie améliorées.

#### 4.3.1 Agents via CLI (Tier 1)

GPT et Gemini utilisent leurs CLI officiels en mode non-interactif :

```bash
# 🤖 GPT via Codex CLI
codex exec --full-auto \
  -p "Review ce PRD en tant que Perfectionniste..." \
  --output-format json \
  -o /tmp/gpt-response.json

# 💎 Gemini via Gemini CLI
gemini -p "Review ce PRD en tant qu'Innovateur UX..." \
  --output-format json > /tmp/gemini-response.json
```

#### 4.3.2 Agents via API REST (Tier 2)

DeepSeek, GLM et Kimi utilisent l'OpenAI SDK compatible :

```typescript
import OpenAI from 'openai';

// 🐉 DeepSeek V3
const deepseek = new OpenAI({
  baseURL: 'https://api.deepseek.com/v1',
  apiKey: process.env.DEEPSEEK_API_KEY,
});

// 🔮 GLM-4.7
const glm = new OpenAI({
  baseURL: 'https://open.bigmodel.cn/api/paas/v4',
  apiKey: process.env.GLM_API_KEY,
});

// 🌙 Kimi K2 via OpenRouter
const kimi = new OpenAI({
  baseURL: 'https://openrouter.ai/api/v1',
  apiKey: process.env.OPENROUTER_API_KEY,
  defaultHeaders: { 'HTTP-Referer': 'multi-mind' }
});
```

### 4.4 Modèles à utiliser

| Agent | Modèle | Context Window | Notes |
|-------|--------|----------------|-------|
| Claude | claude-sonnet-4-5-20250929 | 200K | Orchestrateur principal |
| GPT | gpt-5-codex (default) | 128K | Via Codex CLI |
| Gemini | gemini-2.5-pro | 1M | Via Gemini CLI |
| DeepSeek | deepseek-chat | 64K | V3, MoE efficient |
| GLM | glm-4.7 | 200K | Vibe Coding |
| Kimi | moonshotai/kimi-k2 | 128K | Via OpenRouter |

---

## 5. Spécifications des Outputs

### 5.1 Résumé Terminal (live)

Pendant le débat, un résumé live s'affiche dans Claude Code :

```
╔═══════════════════════════════════════════════════════════════╗
║            🧠 MULTI-MIND DEBATE COMPLETE                      ║
║            Topic: PRD Feature Authentication                  ║
║            Duration: 4 rounds (2m 34s)                        ║
╠═══════════════════════════════════════════════════════════════╣
║  ✅ CONSENSUS (3 points)                                      ║
║  • Utiliser OAuth2 + PKCE (6/6 agents)                        ║
║  • Ajouter rate limiting sur /auth (6/6 agents)               ║
║  • Séparer service auth du monolithe (5/6 agents)             ║
╠═══════════════════════════════════════════════════════════════╣
║  ⚖️ DIVERGENCES (2 points)                                    ║
║  • Session: Redis vs JWT stateless                            ║
║    └─ 🏛️🤖🔮 Redis | 🐉💎🌙 JWT                                ║
║  • MFA obligatoire dès MVP?                                   ║
║    └─ 🏛️🤖 Oui | 🐉💎🔮🌙 Phase 2                              ║
╠═══════════════════════════════════════════════════════════════╣
║  📋 ACTIONS (5 items)                                         ║
║  🔴 [CRITICAL] Implémenter PKCE flow                          ║
║  🔴 [CRITICAL] Rate limiting /auth endpoints                  ║
║  🟡 [IMPORTANT] Extraire auth-service                         ║
║  🟡 [IMPORTANT] Ajouter refresh token rotation                ║
║  🟢 [OPTIONAL] Dashboard admin sessions                       ║
╠═══════════════════════════════════════════════════════════════╣
║  📄 Rapport: ./debates/2026-01-31-auth-prd.md                 ║
╚═══════════════════════════════════════════════════════════════╝
```

### 5.2 Rapport Markdown (détaillé)

Un rapport complet est généré dans `./debates/` avec :

- **Métadonnées** : date, durée, agents, topic
- **Résumé exécutif** : consensus, divergences, actions
- **Round 1** : Critiques complètes de chaque agent
- **Round 2** : Confrontations et réponses
- **Round 3** : TOP 3 de chaque agent avec justifications
- **Round 4** : Synthèse finale et recommandations
- **Métriques** : tokens utilisés, coût estimé, temps par agent

---

## 6. Configuration et Setup

### 6.1 Prérequis

#### 6.1.1 Abonnements requis

| Service | Plan | Coût | Action |
|---------|------|------|--------|
| Claude Code | Max | Inclus | ✅ Déjà actif |
| ChatGPT | Plus ou Pro | 20€/mois | ✅ Déjà actif |
| Gemini | Advanced (One AI) | 20€/mois | 🟡 À souscrire |
| DeepSeek | Free tier | 0€ | 🟡 Créer compte |
| GLM/Zhipu | Free tier | 0€ | ✅ Clé disponible |
| OpenRouter | Free tier | 0€ | 🟡 Créer compte |

#### 6.1.2 CLIs à installer

```bash
# Codex CLI (OpenAI)
npm install -g @openai/codex
codex login  # OAuth avec ton compte ChatGPT

# Gemini CLI (Google)
npm install -g @google/gemini-cli
gemini  # OAuth avec ton compte Google
```

### 6.2 Variables d'environnement

Ajouter dans `~/.zshrc` ou `~/.bashrc` :

```bash
# Multi-Mind API Keys
export DEEPSEEK_API_KEY="sk-..."
export GLM_API_KEY="..."
export OPENROUTER_API_KEY="sk-or-..."
```

### 6.3 Installation du skill

```bash
# Créer le dossier skill
mkdir -p ~/.claude/skills/multi-mind
cd ~/.claude/skills/multi-mind

# Initialiser le projet
npm init -y
npm install openai typescript tsx @types/node

# Copier les fichiers générés par Claude
```

---

## 7. Intégration Workflow D-EPCT+R

### 7.1 Points d'intégration

Multi-Mind s'intègre à 2 moments clés du workflow D-EPCT+R :

| Phase | Moment | Commande | Objectif |
|-------|--------|----------|----------|
| Discovery | Après rédaction PRD | `/multi-mind prd [fichier]` | Valider architecture |
| Review | Avant merge | `/multi-mind review [dossier]` | Audit code multi-perspectives |

### 7.2 Workflow complet

1. **DISCOVERY** : Claude génère le PRD initial
2. **MULTI-MIND PRD** : Débat 6 agents sur l'architecture
3. **EXPLAIN** : Claude intègre le feedback consensus
4. **PLAN** : Planification avec les risques identifiés
5. **CODE** : Développement guidé
6. **TEST** : Tests unitaires et intégration
7. **MULTI-MIND REVIEW** : Audit croisé avant merge
8. **REVIEW FINAL** : Claude valide avec le consensus

---

## 8. Risques et Mitigations

| Risque | Impact | Probabilité | Mitigation |
|--------|--------|-------------|------------|
| Rate limiting APIs | Moyen | Moyenne | Retry avec backoff, cache |
| Codex CLI instable | Faible | Faible | Fallback API directe |
| Coût tokens élevé | Moyen | Faible | Monitoring, alertes |
| Consensus impossible | Faible | Moyenne | Timeout + décision humaine |
| Latence totale | Moyen | Moyenne | Parallélisation rounds |
| Clé API expirée | Élevé | Faible | Check au démarrage |

---

## 9. Roadmap

### Phase 1 : MVP (Semaine 1)

- Setup des 6 connecteurs agents
- Implémentation 4 rounds de base
- Output terminal simple
- Test sur un PRD réel

### Phase 2 : Polish (Semaine 2)

- Rapport Markdown détaillé
- Personnalités affinées
- Gestion erreurs robuste
- Métriques et analytics

### Phase 3 : Évolutions (Mois 2+)

- Mode review code complet
- Intégration CI/CD
- Dashboard web (optionnel)
- Agents custom configurables

---

## 10. Critères d'Acceptation

### 10.1 Fonctionnels

- ✅ 6 agents répondent correctement
- ✅ 4 rounds s'enchaînent sans erreur
- ✅ Consensus généré en < 5 minutes
- ✅ Rapport Markdown lisible et complet
- ✅ Commande `/multi-mind` disponible

### 10.2 Techniques

- ✅ Gestion des erreurs API (retry, fallback)
- ✅ Timeout configurable par round
- ✅ Logs détaillés pour debug
- ✅ Coût < 0.10€ par débat en moyenne

### 10.3 UX

- ✅ Feedback live pendant le débat
- ✅ Résumé clair et actionnable
- ✅ Personnalités distinctes et utiles

---

## Annexe A : Référence APIs

### A.1 Endpoints

| Agent | Base URL | Modèle |
|-------|----------|--------|
| DeepSeek | https://api.deepseek.com/v1 | deepseek-chat |
| GLM | https://open.bigmodel.cn/api/paas/v4 | glm-4.7 |
| Kimi | https://openrouter.ai/api/v1 | moonshotai/kimi-k2 |

### A.2 Pricing

| Agent | Input | Output | Cache Hit |
|-------|-------|--------|-----------|
| DeepSeek | $0.28/M | $0.42/M | $0.028/M |
| GLM-4.7 | $0.60/M | $2.20/M | $0.11/M |
| Kimi K2 | $0.60/M | $2.50/M | $0.15/M |

---

## Annexe B : Glossaire

- **PRD** : Product Requirements Document
- **D-EPCT+R** : Discovery, Explain, Plan, Code, Test, Review
- **MoE** : Mixture of Experts (architecture modèle)
- **CLI** : Command Line Interface
- **OpenAI SDK** : Bibliothèque compatible avec plusieurs providers

---

*--- Fin du document ---*
