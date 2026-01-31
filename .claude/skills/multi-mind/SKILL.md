---
name: multi-mind
description: Débat multi-agents avec 6 IA pour valider PRD et code. Utiliser pour obtenir des perspectives diverses sur des décisions critiques, après un PRD en mode FULL, ou après une code review de code critique.
model: opus
context: fork
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Write
  - Task
  - WebFetch
argument-hint: <prd|review> <file>
user-invocable: true
knowledge:
  core:
    - .claude/knowledge/multi-mind/agent-personalities.md
    - .claude/knowledge/multi-mind/debate-templates.md
---

# Multi-Mind Debate System v3.5

> Système de débat multi-agents avec 6 IA pour valider PRD et reviewer le code avec des perspectives diverses et des **échanges itératifs**.

## Activation

- [ ] Mode identifié : `prd` ou `review`
- [ ] Fichier cible localisé
- [ ] Agents disponibles détectés (minimum 3)
- [ ] Knowledge base chargée

---

## Rôle & Principes

**Rôle** : Orchestrer un débat structuré entre 6 agents IA avec des perspectives différentes pour valider des décisions critiques (PRD, architecture, code).

**Principes** :
- **Diversité** : Chaque agent a une personnalité et une spécialité distinctes
- **Confrontation** : Les agents débattent réellement avec des ping-pong argumentés
- **Rigueur** : 5 rounds structurés pour une analyse complète
- **Convergence** : Synthèse vers un consensus actionnable
- **Transparence** : Toutes les critiques, échanges et divergences sont documentées

**Règles** :
- ⛔ Ne JAMAIS sauter un round
- ⛔ Ne JAMAIS ignorer une critique majeure
- ⛔ Ne JAMAIS forcer un consensus artificiel
- ⛔ Ne JAMAIS interrompre le débat (mode continu)
- ✅ Documenter les divergences irrésolues
- ✅ Pondérer les avis selon la spécialité
- ✅ Minimum 3 agents pour un débat valide
- ✅ Claude est un **débatteur** comme les autres (pas un modérateur)

---

## Les 6 Agents

| Agent | Provider | Rôle | Connecteur | Coût |
|-------|----------|------|------------|------|
| 🏛️ **Claude** | Anthropic | Architecte Prudent | Orchestrateur natif | Inclus |
| 🤖 **GPT** | OpenAI | Perfectionniste | Codex CLI | 💳 Payant |
| 💎 **Gemini** | Google | Innovateur UX | Gemini CLI | 💳 Payant |
| 🐉 **DeepSeek** | DeepSeek | Provocateur | API REST | 🆓 Gratuit |
| 🔮 **GLM** | Zhipu AI | Craftsman Frontend | API REST | 🆓 Gratuit |
| 🌙 **Kimi** | Moonshot | Product Thinker | OpenRouter | 🆓 Gratuit |

---

## Process

### 0. Chargement des API Keys

Avant de détecter les agents, charger les clés depuis `.env.local` si le fichier existe :

```bash
# Charger .env.local s'il existe (à la racine du projet)
if [ -f ".env.local" ]; then
  export $(grep -v '^#' .env.local | xargs)
  echo "✅ API keys chargées depuis .env.local"
elif [ -f "$HOME/.env.local" ]; then
  export $(grep -v '^#' $HOME/.env.local | xargs)
  echo "✅ API keys chargées depuis ~/.env.local"
fi
```

### 1. Détection des agents

```bash
# Vérifier les agents disponibles
detect_agents() {
  agents=("Claude")  # Toujours disponible

  # CLIs (payants)
  which codex >/dev/null 2>&1 && agents+=("GPT")
  which gemini >/dev/null 2>&1 && agents+=("Gemini")

  # API Keys (gratuits) - depuis .env.local ou environnement
  [ -n "$DEEPSEEK_API_KEY" ] && agents+=("DeepSeek")
  [ -n "$GLM_API_KEY" ] && agents+=("GLM")
  [ -n "$OPENROUTER_API_KEY" ] && agents+=("Kimi")

  echo "${agents[@]}"
}
```

**Validation** : Si moins de 3 agents disponibles → afficher instructions d'installation et s'arrêter.

**Si 3+ agents disponibles** : Afficher la table des agents et lancer le débat automatiquement.

---

## Mode d'exécution : CONTINU (5 rounds automatiques)

Le débat s'exécute **en continu du Round 1 au Round 5** sans validation intermédiaire. L'utilisateur voit un progress indicator en temps réel :

```
🧠 Multi-Mind Debate en cours...
├─ Round 1: CRITIQUE
│  ├─ 🏛️ Claude ✅
│  ├─ 🤖 GPT ✅
│  ├─ 💎 Gemini ✅
│  ├─ 🐉 DeepSeek ✅
│  ├─ 🔮 GLM ✅
│  └─ 🌙 Kimi ✅
├─ Round 2: FRICTIONS ✅
│  └─ 3 frictions identifiées
├─ Round 3: DÉBAT CIBLÉ ⏳
│  ├─ Friction #1: Tour 2/3 ⏳
│  │  ├─ Camp A (🏛️🤖🔮): "SQL pour intégrité..."
│  │  └─ Camp B (💎🐉🌙): "NoSQL pour flexibilité..."
│  ├─ Friction #2: En attente...
│  └─ Friction #3: En attente...
├─ Round 4: CONVERGENCE ...
└─ Round 5: CONSENSUS ...
```

Le rapport final complet est généré dans `docs/debates/` et affiché à la fin.

---

## ROUND 1 : CRITIQUE

Chaque agent analyse le document **indépendamment**.

**Pour chaque agent disponible** :
1. Envoyer le document avec le system prompt de l'agent
2. Demander une critique structurée :
   - Points forts (3 max)
   - Points faibles (5 max)
   - Risques identifiés
   - Score /10

**Output attendu par agent** :
```markdown
### 🏛️ Claude - Architecte Prudent

**Score : 7/10**

#### ✅ Points forts
1. [Point fort 1]
2. [Point fort 2]
3. [Point fort 3]

#### ⚠️ Points faibles
1. [Point faible 1] - Sévérité: [Critique/Majeure/Mineure]
2. [Point faible 2] - Sévérité: [Critique/Majeure/Mineure]

#### 🚨 Risques
- [Risque 1] - Probabilité: [Haute/Moyenne/Basse]
- [Risque 2] - Probabilité: [Haute/Moyenne/Basse]
```

*→ Continuer automatiquement vers Round 2*

---

## ROUND 2 : IDENTIFICATION DES FRICTIONS

Analyser les critiques du Round 1 pour extraire les **points de désaccord majeurs**.

**Process** :
1. Comparer les critiques de tous les agents
2. Identifier 2-3 frictions majeures (points où les agents divergent)
3. Former les "camps" pour chaque friction

**Output attendu** :
```markdown
## 🔥 Frictions identifiées

### Friction #1 : [Sujet du désaccord]
**Question** : [Question centrale du débat]

| Camp A | Camp B |
|--------|--------|
| 🏛️ Claude, 🤖 GPT, 🔮 GLM | 💎 Gemini, 🐉 DeepSeek, 🌙 Kimi |
| Position : [Résumé position A] | Position : [Résumé position B] |

### Friction #2 : [Sujet du désaccord]
**Question** : [Question centrale du débat]

| Camp A | Camp B |
|--------|--------|
| [Agents] | [Agents] |
| Position : [Résumé] | Position : [Résumé] |

### Friction #3 : [Sujet du désaccord]
...
```

*→ Continuer automatiquement vers Round 3*

---

## ROUND 3 : DÉBAT CIBLÉ (Itératif)

Pour chaque friction identifiée, organiser un **débat avec plusieurs tours d'échange**.

**Règles du débat** :
- Maximum **3 tours** par friction
- Chaque camp argumente puis répond aux arguments de l'autre
- Claude participe comme débatteur dans son camp (pas comme modérateur)
- Arrêt anticipé si consensus atteint

**Structure par friction** :

```
Friction #1 : [Sujet]
│
├─ Tour 1
│  ├─ Camp A argumente : [Arguments initiaux]
│  └─ Camp B argumente : [Arguments initiaux]
│
├─ Tour 2
│  ├─ Camp A répond à B : [Contre-arguments]
│  └─ Camp B répond à A : [Contre-arguments]
│
└─ Tour 3 (si pas de résolution)
   ├─ Camp A : [Arguments finaux / concession]
   └─ Camp B : [Arguments finaux / concession]
   └─ Statut : [RÉSOLU vers X / DIVERGENCE MAINTENUE]
```

**Output attendu par friction** :
```markdown
### 🔥 Friction #1 : [Sujet]

#### Tour 1 - Arguments initiaux

**Camp A (🏛️🤖🔮)** :
> [Arguments détaillés du Camp A]

**Camp B (💎🐉🌙)** :
> [Arguments détaillés du Camp B]

---

#### Tour 2 - Réponses croisées

**Camp A répond à Camp B** :
> [Contre-arguments A → B]

**Camp B répond à Camp A** :
> [Contre-arguments B → A]

---

#### Tour 3 - Position finale

**Camp A** :
> [Position finale, éventuelles concessions]

**Camp B** :
> [Position finale, éventuelles concessions]

---

#### 📊 Résultat
- **Statut** : [✅ RÉSOLU / ⚖️ DIVERGENCE]
- **Si résolu** : [Consensus atteint sur X]
- **Si divergence** : [Positions maintenues, à trancher par l'utilisateur]
```

*→ Continuer automatiquement vers Round 4*

---

## ROUND 4 : CONVERGENCE

Après les débats, chaque agent donne son **TOP 3 des points prioritaires**.

**Pour chaque agent** :
1. Demander les 3 points les plus importants à traiter
2. Tenir compte des résultats du Round 3 (débats)
3. Pondérer selon la spécialité de l'agent

**Pondération par spécialité** :

| Agent | PRD | Code Review |
|-------|-----|-------------|
| Claude | 1.5x (architecture) | 1.5x (sécurité) |
| GPT | 1.2x (specs) | 1.5x (qualité) |
| Gemini | 1.5x (UX) | 1.2x (innovation) |
| DeepSeek | 1.0x | 1.2x (edge cases) |
| GLM | 1.3x (frontend) | 1.3x (frontend) |
| Kimi | 1.5x (product) | 1.0x |

**Output attendu** :
```markdown
## 📊 Convergence

### TOP 3 par agent

| Agent | #1 | #2 | #3 |
|-------|-----|-----|-----|
| 🏛️ Claude | [Point] | [Point] | [Point] |
| 🤖 GPT | [Point] | [Point] | [Point] |
| 💎 Gemini | [Point] | [Point] | [Point] |
| 🐉 DeepSeek | [Point] | [Point] | [Point] |
| 🔮 GLM | [Point] | [Point] | [Point] |
| 🌙 Kimi | [Point] | [Point] | [Point] |

### Classement pondéré global

| Rang | Point | Score pondéré | Agents |
|------|-------|---------------|--------|
| 1 | [Point] | 4.5 | 🏛️💎🌙 |
| 2 | [Point] | 3.8 | 🤖🐉 |
| 3 | [Point] | 3.2 | 🏛️🤖🔮 |
| 4 | [Point] | 2.9 | 💎🐉🌙 |
| 5 | [Point] | 2.5 | 🔮🌙 |
```

*→ Continuer automatiquement vers Round 5*

---

## ROUND 5 : CONSENSUS

Claude synthétise **l'ensemble du débat** (en tant que rapporteur, après avoir été débatteur).

**Synthèse** :
1. Points de consensus (unanimité ou majorité)
2. Résultats des débats (Round 3)
3. Divergences irrésolues (documenter les deux positions)
4. Actions prioritaires (TOP 5 actionnable)
5. Recommandation finale

**Output final** :
```markdown
## 🧠 Synthèse Multi-Mind

### ✅ Consensus (X points)
Points sur lesquels tous les agents s'accordent :
1. [Point de consensus 1]
2. [Point de consensus 2]
3. [Point de consensus 3]

### 🔥 Résultats des débats

| Friction | Statut | Conclusion |
|----------|--------|------------|
| #1 : [Sujet] | ✅ Résolu | [Consensus atteint sur X] |
| #2 : [Sujet] | ⚖️ Divergence | [Voir détails ci-dessous] |
| #3 : [Sujet] | ✅ Résolu | [Consensus atteint sur Y] |

### ⚖️ Divergences irrésolues (Y points)
| Point | Position A | Position B | Recommandation |
|-------|------------|------------|----------------|
| [Point] | 🏛️🤖 : [Argument] | 💎🐉 : [Argument] | [Ma recommandation] |

### 📋 Actions Prioritaires
1. [ ] **P0** : [Action critique]
2. [ ] **P1** : [Action importante]
3. [ ] **P1** : [Action importante]
4. [ ] **P2** : [Action souhaitable]
5. [ ] **P2** : [Action souhaitable]

### 💬 Recommandation finale
[Recommandation finale de Claude basée sur le débat complet - 3 à 5 phrases]
```

---

## Output Template

### Terminal (live)

```
╔═══════════════════════════════════════════════════════════════╗
║  🧠 MULTI-MIND DEBATE                                         ║
║  Mode: [prd|review] | File: [filename]                        ║
╠═══════════════════════════════════════════════════════════════╣
║  Agents: [N]/6                                                ║
║  🏛️ Claude ✅  🤖 GPT [✅|❌]  💎 Gemini [✅|❌]              ║
║  🐉 DeepSeek [✅|❌]  🔮 GLM [✅|❌]  🌙 Kimi [✅|❌]          ║
╠═══════════════════════════════════════════════════════════════╣
║  Round 1: CRITIQUE      [⏳|✅]                                ║
║  Round 2: FRICTIONS     [⏳|✅]                                ║
║  Round 3: DÉBAT CIBLÉ   [⏳|✅]  ← 3 frictions, 9 tours       ║
║  Round 4: CONVERGENCE   [⏳|✅]                                ║
║  Round 5: CONSENSUS     [⏳|✅]                                ║
╠═══════════════════════════════════════════════════════════════╣
║  Duration: [X]m [Y]s                                          ║
╚═══════════════════════════════════════════════════════════════╝
```

### Rapport final (terminal)

```
╔═══════════════════════════════════════════════════════════════╗
║  🧠 MULTI-MIND DEBATE COMPLETE                                ║
║  Agents: [N]/6 | Duration: [X]m [Y]s                          ║
╠═══════════════════════════════════════════════════════════════╣
║  ✅ CONSENSUS ([N] points)                                    ║
║  🔥 FRICTIONS ([N] débattues, [M] résolues)                   ║
║  ⚖️ DIVERGENCES ([N] points)                                  ║
║  📋 ACTIONS ([N] items)                                       ║
╠═══════════════════════════════════════════════════════════════╣
║  📄 Rapport: docs/debates/[YYYY-MM-DD]-[topic].md             ║
╚═══════════════════════════════════════════════════════════════╝
```

### Rapport Markdown complet

Sauvegarder dans `docs/debates/YYYY-MM-DD-topic.md` :

```markdown
# Multi-Mind Debate Report

## Métadonnées
- **Date** : [YYYY-MM-DD HH:MM]
- **Mode** : [prd|review]
- **Fichier** : [path/to/file]
- **Agents** : [N]/6
- **Durée** : [X]m [Y]s
- **Frictions** : [N] identifiées, [M] résolues

## Résumé exécutif
[3-5 phrases résumant le débat et ses conclusions]

---

## Round 1 : Critiques individuelles
[Critiques complètes de chaque agent]

---

## Round 2 : Frictions identifiées
[Liste des frictions avec les camps formés]

---

## Round 3 : Débats ciblés

### Friction #1 : [Sujet]
[Tous les tours d'échange détaillés]

### Friction #2 : [Sujet]
[Tous les tours d'échange détaillés]

### Friction #3 : [Sujet]
[Tous les tours d'échange détaillés]

---

## Round 4 : Convergence
[TOP 3 de chaque agent + classement pondéré]

---

## Round 5 : Synthèse finale
[Consensus, résultats débats, divergences, actions]
```

---

## Connecteurs par Agent

### Claude (natif)
Utilise le contexte courant de Claude Code (claude-opus-4.5).

### GPT via Codex CLI
```bash
codex --model gpt-5.2 --prompt "[system prompt]" --input "[document]"
```

### Gemini via Gemini CLI
```bash
gemini --model gemini-3 --prompt "[system prompt + document]"
```

### DeepSeek via API REST
```bash
curl -X POST "https://api.deepseek.com/v1/chat/completions" \
  -H "Authorization: Bearer $DEEPSEEK_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model": "deepseek-reasoner", "messages": [...]}'
# Alternative: "deepseek-chat" pour DeepSeek-V3
```

### GLM via API REST
```bash
curl -X POST "https://open.bigmodel.cn/api/paas/v4/chat/completions" \
  -H "Authorization: Bearer $GLM_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model": "glm-4-0520", "messages": [...]}'
# Dernière version: glm-4-0520 (GLM-4.7)
```

### Kimi via OpenRouter
```bash
curl -X POST "https://openrouter.ai/api/v1/chat/completions" \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model": "moonshotai/kimi-k2.5", "messages": [...]}'
# Kimi K2.5 via OpenRouter
```

---

## Instructions d'installation des agents

Si moins de 3 agents disponibles, afficher :

```markdown
## ⚠️ Agents insuffisants

Multi-Mind nécessite minimum 3 agents. Actuellement : [N] agent(s).

### Option 1 : Fichier .env.local (recommandé)

Copier le template et ajouter tes clés :

```bash
cp .env.example .env.local
# Éditer .env.local avec tes clés API
```

Contenu de `.env.local` :
```
DEEPSEEK_API_KEY=sk-ta-clé-deepseek
GLM_API_KEY=ta-clé-glm
OPENROUTER_API_KEY=sk-or-v1-ta-clé-openrouter
```

### Option 2 : Variables d'environnement

Ajouter dans `~/.zshrc` ou `~/.bashrc` :

```bash
export DEEPSEEK_API_KEY="sk-..."
export GLM_API_KEY="..."
export OPENROUTER_API_KEY="sk-or-..."
```

Puis : `source ~/.zshrc`

### Où obtenir les clés (gratuit)

| Agent | URL |
|-------|-----|
| DeepSeek | https://platform.deepseek.com/api_keys |
| GLM | https://open.bigmodel.cn/usercenter/apikeys |
| OpenRouter | https://openrouter.ai/keys |

### Agents payants (optionnel)

#### GPT via Codex CLI
```bash
npm install -g @openai/codex
codex auth
```

#### Gemini CLI
```bash
npm install -g gemini-cli
gemini auth
```
```

---

## Output Validation

### Checklist

| Critère | Status |
|---------|--------|
| Minimum 3 agents actifs | ✅/❌ |
| 5 rounds complétés | ✅/❌ |
| Toutes critiques documentées | ✅/❌ |
| Frictions identifiées | ✅/❌ |
| Débats itératifs exécutés | ✅/❌ |
| Consensus identifié | ✅/❌ |
| Divergences documentées | ✅/❌ |
| Actions prioritaires listées | ✅/❌ |
| Rapport Markdown généré | ✅/❌ |

**Score minimum : 8/9**

---

## Auto-Chain

Après le débat Multi-Mind :

```markdown
## 🔗 Prochaine étape

✅ Multi-Mind Debate terminé.

### Si mode PRD :
→ 🏗️ **Lancer `/architect` ?** (architecture technique)

### Si mode Review :
→ 📝 **Appliquer les corrections ?** (code-implementer)

---

**[Y] Oui, continuer** | **[N] Non, je choisis** | **[P] Pause**
```

---

## Transitions

- **Depuis `/pm-prd`** : "Valider le PRD avec Multi-Mind ?"
- **Depuis `/code-reviewer`** : "Review multi-perspectives ?"
- **Vers `/architect`** : "Passer à l'architecture ?"
- **Vers `/code-implementer`** : "Appliquer les corrections ?"
