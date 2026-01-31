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

# Multi-Mind Debate System

> Système de débat multi-agents avec 6 IA pour valider PRD et reviewer le code avec des perspectives diverses.

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
- **Rigueur** : 4 rounds structurés pour une analyse complète
- **Convergence** : Synthèse vers un consensus actionnable
- **Transparence** : Toutes les critiques et divergences sont documentées

**Règles** :
- ⛔ Ne JAMAIS sauter un round
- ⛔ Ne JAMAIS ignorer une critique majeure
- ⛔ Ne JAMAIS forcer un consensus artificiel
- ✅ Documenter les divergences irrésolues
- ✅ Pondérer les avis selon la spécialité
- ✅ Minimum 3 agents pour un débat valide

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

**Si 3+ agents disponibles** : Afficher la table des agents et continuer automatiquement.

---

## Mode d'exécution : CONTINU

Le débat s'exécute en continu sans validation intermédiaire. L'utilisateur voit un progress indicator :

```
🧠 Multi-Mind Debate en cours...
├─ Round 1: CRITIQUE
│  ├─ 🏛️ Claude ✅
│  ├─ 🤖 GPT ✅
│  ├─ 💎 Gemini ✅
│  ├─ 🐉 DeepSeek ⏳
│  ├─ 🔮 GLM ...
│  └─ 🌙 Kimi ...
├─ Round 2: CONFRONTATION ...
├─ Round 3: CONVERGENCE ...
└─ Round 4: CONSENSUS ...
```

Le rapport final est généré dans `docs/debates/` et affiché à la fin.

---

### 2. Round 1 : CRITIQUE

Chaque agent analyse le document indépendamment.

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
1. [Point faible 1]
2. [Point faible 2]

#### 🚨 Risques
- [Risque 1]
- [Risque 2]
```

*Continuer automatiquement vers Round 2*

---

### 3. Round 2 : CONFRONTATION

Partager les critiques entre agents et les faire réagir.

**Pour chaque agent** :
1. Envoyer les critiques des autres agents
2. Demander :
   - Accords explicites (avec qui et sur quoi)
   - Désaccords argumentés (avec qui et pourquoi)
   - Nouvelles perspectives après lecture des autres

**Output attendu** :
```markdown
### 🏛️ Claude répond

#### ✅ Accords
- Avec 🤖 GPT sur [point]
- Avec 💎 Gemini sur [point]

#### ❌ Désaccords
- Avec 🐉 DeepSeek : [argument]

#### 💡 Nouvelle perspective
[Insight après lecture des autres critiques]
```

*Continuer automatiquement vers Round 3*

---

### 4. Round 3 : CONVERGENCE

Chaque agent donne son TOP 3 des points prioritaires.

**Pour chaque agent** :
1. Demander les 3 points les plus importants à traiter
2. Pondérer selon la spécialité de l'agent

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
### TOP 3 pondéré

| Rang | Point | Score | Agents |
|------|-------|-------|--------|
| 1 | [Point] | 4.5 | 🏛️💎🌙 |
| 2 | [Point] | 3.8 | 🤖🐉 |
| 3 | [Point] | 3.2 | 🏛️🤖🔮 |
```

---

### 5. Round 4 : CONSENSUS

Claude synthétise le débat.

**Synthèse** :
1. Points de consensus (unanimité ou majorité)
2. Divergences irrésolues (documenter les deux positions)
3. Actions prioritaires (TOP 5 actionnable)
4. Recommandation finale

**Output final** :
```markdown
## 🧠 Synthèse Multi-Mind

### ✅ Consensus (X points)
1. [Point de consensus 1]
2. [Point de consensus 2]

### ⚖️ Divergences (Y points)
| Point | Position A | Position B |
|-------|------------|------------|
| [Point] | 🏛️🤖 : [Argument] | 💎🐉 : [Argument] |

### 📋 Actions Prioritaires
1. [ ] **P0** : [Action critique]
2. [ ] **P1** : [Action importante]
3. [ ] **P1** : [Action importante]
4. [ ] **P2** : [Action souhaitable]
5. [ ] **P2** : [Action souhaitable]

### 💬 Recommandation
[Recommandation finale de Claude basée sur le débat]
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
║  Round 2: CONFRONTATION [⏳|✅]                                ║
║  Round 3: CONVERGENCE   [⏳|✅]                                ║
║  Round 4: CONSENSUS     [⏳|✅]                                ║
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
║  ⚖️ DIVERGENCES ([N] points)                                  ║
║  📋 ACTIONS ([N] items)                                       ║
╠═══════════════════════════════════════════════════════════════╣
║  📄 Rapport: docs/debates/[YYYY-MM-DD]-[topic].md             ║
╚═══════════════════════════════════════════════════════════════╝
```

### Rapport Markdown

Sauvegarder dans `docs/debates/YYYY-MM-DD-topic.md` :

```markdown
# Multi-Mind Debate Report

## Métadonnées
- **Date** : [YYYY-MM-DD HH:MM]
- **Mode** : [prd|review]
- **Fichier** : [path/to/file]
- **Agents** : [N]/6
- **Durée** : [X]m [Y]s

## Résumé exécutif
[3-5 phrases résumant le débat et ses conclusions]

## Round 1 : Critiques
[Critiques complètes de chaque agent]

## Round 2 : Confrontations
[Réponses et débats entre agents]

## Round 3 : TOP 3 par agent
[Liste pondérée des priorités]

## Round 4 : Synthèse finale
[Consensus, divergences, actions]
```

---

## Connecteurs par Agent

### Claude (natif)
Utilise le contexte courant de Claude Code.

### GPT via Codex CLI
```bash
codex --model gpt-4o --prompt "[system prompt]" --input "[document]"
```

### Gemini via Gemini CLI
```bash
gemini --model gemini-2.0-flash --prompt "[system prompt + document]"
```

### DeepSeek via API REST
```bash
curl -X POST "https://api.deepseek.com/v1/chat/completions" \
  -H "Authorization: Bearer $DEEPSEEK_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model": "deepseek-chat", "messages": [...]}'
```

### GLM via API REST
```bash
curl -X POST "https://open.bigmodel.cn/api/paas/v4/chat/completions" \
  -H "Authorization: Bearer $GLM_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model": "glm-4-flash", "messages": [...]}'
```

### Kimi via OpenRouter
```bash
curl -X POST "https://openrouter.ai/api/v1/chat/completions" \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model": "moonshot/kimi", "messages": [...]}'
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
| 4 rounds complétés | ✅/❌ |
| Toutes critiques documentées | ✅/❌ |
| Consensus identifié | ✅/❌ |
| Divergences documentées | ✅/❌ |
| Actions prioritaires listées | ✅/❌ |
| Rapport Markdown généré | ✅/❌ |

**Score minimum : 6/7**

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
