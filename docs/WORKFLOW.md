# 🚀 D-EPCT+R Workflow - Kit Complet Claude Code

## 📋 Table des matières

1. [Qu'est-ce que c'est ?](#quest-ce-que-cest-)
2. [Structure du bundle](#structure-du-bundle)
3. [Installation pas à pas](#installation-pas-à-pas)
4. [Utilisation](#utilisation)
5. [Le workflow détaillé](#le-workflow-détaillé)
6. [Personnalisation](#personnalisation)
7. [Troubleshooting](#troubleshooting)

---

## Qu'est-ce que c'est ?

Un ensemble de **Skills** et **Commands** pour Claude Code qui automatise ton workflow de développement :

```
DISCOVERY → EXPLAIN → PLAN → CODE → TEST → REVIEW (×3)
```

### Pourquoi Skills plutôt qu'Agents ?

| Aspect | Skills ✅ | Agents (ancien) |
|--------|----------|-----------------|
| Déclenchement | Automatique | Manuel |
| Réutilisabilité | Portable entre projets | Spécifique |
| Maintenance | Modulaire | Monolithique |
| Tokens | Chargé à la demande | Tout en contexte |

**Les Skills sont la nouvelle approche recommandée par Anthropic.**

---

## Structure du bundle

```
d-epct-workflow/
│
├── 📄 README.md                          ← CE FICHIER
├── 📄 GUIDE-COMPLET.md                   ← Documentation détaillée
│
└── 📁 .claude/                           ← À COPIER DANS TON PROJET
    │
    ├── 📄 CLAUDE.md                      ← Instructions globales projet
    │
    ├── 📁 commands/                      ← Commandes /slash
    │   ├── 📄 discovery.md               ← /discovery
    │   └── 📄 feature.md                 ← /feature
    │
    └── 📁 skills/                        ← Skills auto-déclenchés
        ├── 📁 pm-discovery/
        │   └── 📄 SKILL.md               ← 🎯 Session PM
        ├── 📁 github-issue-reader/
        │   └── 📄 SKILL.md               ← 📋 Lecture issues
        ├── 📁 codebase-explainer/
        │   └── 📄 SKILL.md               ← 🔍 Analyse code
        ├── 📁 implementation-planner/
        │   └── 📄 SKILL.md               ← 📝 Planification
        ├── 📁 code-implementer/
        │   └── 📄 SKILL.md               ← 💻 Implémentation
        ├── 📁 test-runner/
        │   └── 📄 SKILL.md               ← 🧪 Tests
        └── 📁 code-reviewer/
            └── 📄 SKILL.md               ← 🔍 Review ×3
```

---

## Installation pas à pas

### Prérequis

- Claude Code installé (`npm install -g @anthropic-ai/claude-code` ou via l'app)
- Git configuré
- Accès GitHub (pour la création d'issues)

### Étape 1 : Télécharger et dézipper

```bash
# Dézipper le bundle
unzip d-epct-workflow.zip
cd d-epct-workflow
```

### Étape 2 : Copier dans ton projet

```bash
# Copier le dossier .claude dans ton projet
cp -r .claude /chemin/vers/ton-projet/

# Vérifier
ls -la /chemin/vers/ton-projet/.claude/
```

Tu dois voir :
```
.claude/
├── CLAUDE.md
├── commands/
│   ├── discovery.md
│   └── feature.md
└── skills/
    ├── pm-discovery/
    ├── github-issue-reader/
    ├── codebase-explainer/
    ├── implementation-planner/
    ├── code-implementer/
    ├── test-runner/
    └── code-reviewer/
```

### Étape 3 : Commit dans ton repo

```bash
cd /chemin/vers/ton-projet
git add .claude/
git commit -m "chore: add D-EPCT+R workflow skills"
git push
```

### Étape 4 : Vérifier l'installation

```bash
# Lancer Claude Code dans ton projet
cd /chemin/vers/ton-projet
claude

# Tester que les skills sont détectés
> Quels skills sont disponibles ?
```

Claude doit lister les 7 skills.

---

## Utilisation

### Scénario 1 : Tu as une idée mais pas d'issue

```bash
# 1. Lancer Claude Code
claude

# 2. Démarrer une session Discovery
/discovery

# 3. Expliquer ton besoin (parle librement)
> J'aimerais qu'on ajoute un système de filtres sur la page produits.
> Les utilisateurs devraient pouvoir filtrer par catégorie, par prix,
> et par note. Et il faudrait que ça se souvienne de leurs préférences.

# 4. Répondre aux questions de Claude PM
# (Il va poser 2-3 questions pour clarifier)

# 5. Valider la synthèse quand il la propose

# 6. Valider les issues avant publication

# 7. Claude crée les issues sur GitHub
# → Epic #42 + Stories #43, #44, #45

# 8. Lancer l'implémentation d'une story
/feature #43
```

### Scénario 2 : Tu as déjà une issue GitHub

```bash
# Directement lancer l'implémentation
/feature https://github.com/ton-org/ton-repo/issues/123

# Ou avec juste le numéro (si tu es dans le bon repo)
/feature #123
```

### Scénario 3 : Juste utiliser un skill spécifique

```bash
# Les skills se déclenchent automatiquement selon le contexte
# Exemples :

> Analyse-moi le codebase pour comprendre l'architecture
# → Déclenche codebase-explainer

> Fais une code review de mes dernières modifications
# → Déclenche code-reviewer

> Aide-moi à planifier l'implémentation de cette feature
# → Déclenche implementation-planner
```

---

## Le workflow détaillé

### Vue d'ensemble

```
┌──────────────────────────────────────────────────────────────────────┐
│                                                                      │
│   🎯 DISCOVERY                                                       │
│   ├─ Tu expliques ton besoin (speech-to-text OK)                    │
│   ├─ Claude PM pose des questions                                    │
│   ├─ Synthèse → Tu valides                                          │
│   ├─ Rédaction Epic + User Stories                                  │
│   └─ Publication GitHub → Tu obtiens #XX                            │
│                                                                      │
│   ⏸️ CHECKPOINT ─────────────────────────────────────────────────    │
│                                                                      │
│   📋 EXPLAIN                                                         │
│   ├─ Lecture de l'issue #XX                                         │
│   ├─ Analyse du codebase                                            │
│   └─ Cartographie des fichiers impactés                             │
│                                                                      │
│   ⏸️ CHECKPOINT ─────────────────────────────────────────────────    │
│                                                                      │
│   📝 PLAN                                                            │
│   ├─ Décomposition en étapes                                        │
│   ├─ Estimation complexité                                          │
│   └─ Identification des risques                                     │
│                                                                      │
│   ⏸️ CHECKPOINT ─────────────────────────────────────────────────    │
│                                                                      │
│   💻 CODE                                                            │
│   ├─ Implémentation étape par étape                                 │
│   ├─ Validation à chaque étape                                      │
│   └─ Respect des conventions                                        │
│                                                                      │
│   ⏸️ CHECKPOINT ─────────────────────────────────────────────────    │
│                                                                      │
│   🧪 TEST                                                            │
│   ├─ Écriture tests unitaires                                       │
│   ├─ Tests d'intégration                                            │
│   └─ Vérification coverage                                          │
│                                                                      │
│   ⏸️ CHECKPOINT ─────────────────────────────────────────────────    │
│                                                                      │
│   🔍 REVIEW ×3                                                       │
│   ├─ Pass 1: Correctness (logique, bugs)                            │
│   │   └─ Corrections → Validation                                   │
│   ├─ Pass 2: Readability (lisibilité, maintenance)                  │
│   │   └─ Améliorations → Validation                                 │
│   └─ Pass 3: Performance (optimisation)                             │
│       └─ Optimisations → Validation                                 │
│                                                                      │
│   ✅ TERMINÉ                                                         │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

### Détail de chaque phase

#### 🎯 DISCOVERY (pm-discovery)

**Objectif** : Transformer une idée vague en issues GitHub structurées.

**Ce que fait Claude** :
1. Écoute ton besoin sans interrompre
2. Pose des questions de clarification (max 3 à la fois)
3. Synthétise et te fait valider
4. Rédige Epic + User Stories au format standard
5. Publie sur GitHub avec les bons labels

**Format User Story produit** :
```markdown
**En tant que** [utilisateur],
**je veux** [fonctionnalité],
**afin de** [bénéfice].

## Critères d'acceptance
- [ ] Given X, when Y, then Z
```

#### 📋 EXPLAIN (github-issue-reader + codebase-explainer)

**Objectif** : Comprendre le contexte avant de coder.

**Ce que fait Claude** :
1. Lit et parse l'issue GitHub
2. Extrait les requirements
3. Analyse l'architecture du projet
4. Identifie les fichiers à modifier
5. Note les patterns existants à respecter

#### 📝 PLAN (implementation-planner)

**Objectif** : Créer un plan d'implémentation validé.

**Ce que fait Claude** :
1. Décompose en étapes atomiques
2. Définit l'ordre des tâches
3. Identifie les risques
4. Propose des critères de validation par étape

#### 💻 CODE (code-implementer)

**Objectif** : Implémenter selon le plan.

**Ce que fait Claude** :
1. Implémente étape par étape
2. Respecte les conventions du projet
3. Montre le diff après chaque modification
4. Attend ta validation avant l'étape suivante

#### 🧪 TEST (test-runner)

**Objectif** : Valider que le code fonctionne.

**Ce que fait Claude** :
1. Écrit les tests unitaires
2. Écrit les tests d'intégration
3. Exécute les tests
4. Vérifie la coverage

#### 🔍 REVIEW ×3 (code-reviewer)

**Objectif** : Optimiser le code en 3 passes.

| Pass | Focus | Questions |
|------|-------|-----------|
| **#1 Correctness** | Le code fait ce qu'il doit ? | Bugs ? Cas limites ? Sécurité ? |
| **#2 Readability** | Le code est maintenable ? | Nommage ? Structure ? DRY ? |
| **#3 Performance** | Le code est optimal ? | Complexité ? Memory ? Scale ? |

---

## Personnalisation

### Modifier le format des User Stories

Édite `.claude/skills/pm-discovery/SKILL.md`, section "Structure User Story".

### Modifier les conventions de code

Édite `.claude/skills/code-implementer/SKILL.md`, section "Principes de code".

### Modifier la checklist de review

Édite `.claude/skills/code-reviewer/SKILL.md`, les 3 sections de Pass.

### Ajouter un nouveau skill

```bash
# Créer le dossier
mkdir .claude/skills/mon-skill

# Créer le SKILL.md
cat > .claude/skills/mon-skill/SKILL.md << 'EOF'
---
name: mon-skill
description: Description claire de ce que fait le skill et QUAND l'utiliser.
---

# Mon Skill

## Instructions
1. Étape 1
2. Étape 2

## Output attendu
...
EOF

# Commit
git add .claude/skills/mon-skill/
git commit -m "feat: add mon-skill"
```

### Utiliser les skills globalement (tous tes projets)

```bash
# Copier dans ton home
cp -r .claude/skills/* ~/.claude/skills/

# Les skills seront disponibles dans TOUS tes projets
```

---

## Troubleshooting

### "Claude n'utilise pas mes skills"

1. **Vérifier que le dossier .claude existe**
   ```bash
   ls -la .claude/skills/
   ```

2. **Vérifier la syntaxe YAML** du SKILL.md
   ```bash
   head -10 .claude/skills/pm-discovery/SKILL.md
   # Doit commencer par ---
   # Puis name: et description:
   # Puis ---
   ```

3. **Vérifier la description** - C'est elle qui déclenche le skill. Si trop vague, Claude ne sait pas quand l'utiliser.

### "Les issues ne se créent pas sur GitHub"

1. **Vérifier que gh CLI est installé et authentifié**
   ```bash
   gh auth status
   ```

2. **Vérifier les permissions du repo**

### "Le workflow s'arrête en plein milieu"

C'est normal ! Le workflow attend ta validation à chaque checkpoint.
Réponds "ok", "continue", "validé" pour passer à l'étape suivante.

### "Je veux skip une étape"

Dis-le à Claude :
```
> Skip la phase de test, on verra ça après
```

---

## Ressources

- [Documentation officielle Skills](https://code.claude.com/docs/en/skills)
- [Best Practices Skills](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices)
- [Blog Anthropic sur les Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

---

## Changelog

- **v1.0.0** - Version initiale
  - 7 skills : pm-discovery, github-issue-reader, codebase-explainer, implementation-planner, code-implementer, test-runner, code-reviewer
  - 2 commands : /discovery, /feature
  - Documentation complète
