# 📚 Guide Complet : Skills Claude Code

## Table des matières

1. [Comprendre les Skills](#comprendre-les-skills)
2. [Skills vs Agents vs Commands](#skills-vs-agents-vs-commands)
3. [Architecture des Skills](#architecture-des-skills)
4. [Bonnes pratiques](#bonnes-pratiques)
5. [Patterns avancés](#patterns-avancés)

---

## Comprendre les Skills

### Définition

Les **Skills** sont des dossiers contenant des instructions, scripts et ressources que Claude découvre et charge dynamiquement quand c'est pertinent pour une tâche.

C'est comme un **guide d'onboarding** pour un nouveau collègue : au lieu d'expliquer à chaque fois comment faire, tu documentes une fois et Claude l'utilise automatiquement.

### Comment ça marche

```
┌─────────────────────────────────────────────────────────────┐
│                      CONTEXT WINDOW                         │
├─────────────────────────────────────────────────────────────┤
│  1. Au démarrage : Seuls les metadata sont chargés          │
│     (name + description de chaque skill)                    │
│                                                             │
│  2. Quand pertinent : Claude charge le SKILL.md             │
│                                                             │
│  3. Si besoin : Claude charge les fichiers additionnels     │
│     (references/, scripts/, etc.)                           │
└─────────────────────────────────────────────────────────────┘
```

Ce système de **"progressive disclosure"** économise les tokens : on ne charge que ce qui est nécessaire.

### La description est CRUCIALE

La `description` dans le YAML frontmatter détermine **QUAND** Claude utilise le skill.

```yaml
# ❌ Mauvais - trop vague
description: Aide avec le code

# ✅ Bon - spécifique avec mots-clés
description: Effectue une revue de code en 3 passes (correctness, readability, performance). Utiliser après les tests, quand on veut améliorer la qualité du code, ou avant de finaliser une feature.
```

---

## Skills vs Agents vs Commands

### Tableau comparatif

| Aspect | Skills | Commands | Subagents |
|--------|--------|----------|-----------|
| **Déclenchement** | Automatique (Claude décide) | Manuel (`/commande`) | Via Task tool |
| **Scope** | Réutilisable, portable | Projet ou global | Exécution parallèle |
| **Cas d'usage** | Expertise, procédures | Workflows, raccourcis | Tâches background |
| **Tokens** | Chargé à la demande | Chargé à l'invocation | Contexte séparé |
| **Persistence** | Fichiers | Fichiers | Runtime uniquement |

### Quand utiliser quoi ?

#### Skills ✅ (Recommandé pour la plupart des cas)

```
.claude/skills/mon-skill/SKILL.md
```

**Utiliser pour :**
- Expertise domaine ("comment analyser du code Python")
- Procédures répétitives ("comment faire une code review")
- Conventions projet ("nos standards de naming")
- Intégrations outils ("comment utiliser notre API interne")

**Avantages :**
- Se déclenche automatiquement
- Portable entre projets
- Économe en tokens

#### Commands (Pour orchestration)

```
.claude/commands/workflow.md
```

**Utiliser pour :**
- Lancer un workflow complet
- Actions explicites de l'utilisateur
- Raccourcis avec paramètres

**Exemple :** `/feature #123` lance tout le workflow EPCT+R

#### Subagents (Pour parallélisation)

**Utiliser pour :**
- Tâches longues en arrière-plan
- Recherches parallèles
- Travail indépendant qui n'a pas besoin de ton input

---

## Architecture des Skills

### Structure minimale

```
mon-skill/
└── SKILL.md       # Seul fichier obligatoire
```

### Structure complète

```
mon-skill/
├── SKILL.md           # Instructions principales
├── references/        # Documentation additionnelle
│   ├── guide.md
│   └── examples.md
├── scripts/           # Scripts utilitaires
│   └── helper.py
└── assets/            # Fichiers statiques
    └── template.json
```

### Anatomie d'un SKILL.md

```yaml
---
name: mon-skill-name                    # lowercase, hyphens, max 64 chars
description: Description claire...      # max 1024 chars, CRUCIAL pour trigger
---

# Titre du Skill

## Instructions
[Ce que Claude doit faire - étapes claires]

## Output attendu
[Format de sortie]

## Exemples
[Cas concrets]

## Validation
[Checkpoints humains si nécessaire]
```

### Règles importantes

1. **name** : lowercase, chiffres, tirets uniquement
2. **description** : Doit inclure QUOI + QUAND utiliser
3. **Body** : < 500 lignes (sinon split en fichiers)
4. **Pas de README.md** ni docs superflues

---

## Bonnes pratiques

### 1. Un skill = Une responsabilité

```
# ❌ Mauvais
skills/
└── tout-en-un/           # Fait trop de choses

# ✅ Bon
skills/
├── code-reviewer/        # Revue de code
├── test-runner/          # Tests
└── code-implementer/     # Implémentation
```

### 2. Instructions concises

Claude est intelligent. Pas besoin de sur-expliquer.

```markdown
# ❌ Trop verbeux
PDF (Portable Document Format) est un format de fichier courant qui contient
du texte, des images et d'autres contenus. Pour extraire du texte d'un PDF,
vous devez utiliser une bibliothèque. Il existe de nombreuses bibliothèques
disponibles pour le traitement des PDF, mais nous recommandons pdfplumber...

# ✅ Concis
## Extraction PDF

Utiliser pdfplumber :
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
```

### 3. Progressive disclosure

Ne pas tout mettre dans SKILL.md. Utiliser des fichiers séparés.

```markdown
# Dans SKILL.md
## Quick start
[Instructions de base]

## Avancé
Pour les cas complexes, voir [references/advanced.md](references/advanced.md).
```

### 4. Validation humaine explicite

Marquer clairement où l'humain doit valider.

```markdown
## Phase 3 : Implémentation

[Instructions...]

**⏸️ CHECKPOINT** - Attendre validation avant de continuer.
```

### 5. Exemples concrets

Les exemples aident Claude à comprendre le style attendu.

```markdown
## Exemples

**Input:** "Ajouter authentification JWT"
**Output:**
```
feat(auth): implement JWT authentication

Add login endpoint and token validation middleware
```
```

---

## Patterns avancés

### Pattern 1 : Workflow séquentiel

Pour des tâches multi-étapes avec validation.

```markdown
## Workflow

1. **Analyse** → STOP validation
2. **Plan** → STOP validation  
3. **Exécution** → STOP validation
4. **Vérification**

### Checklist
- [ ] Analyse complète
- [ ] Plan validé
- [ ] Exécution terminée
- [ ] Vérification OK
```

### Pattern 2 : Références conditionnelles

Charger des docs selon le contexte.

```markdown
## Traitement selon le type

**Création ?** → Voir [references/creation.md](references/creation.md)
**Édition ?** → Voir [references/edition.md](references/edition.md)
```

### Pattern 3 : Templates d'output

Garantir un format de sortie cohérent.

```markdown
## Output attendu

TOUJOURS utiliser ce format :

```markdown
## Résumé
[1-2 phrases]

## Détails
- Point 1
- Point 2

## Actions requises
1. Action 1
2. Action 2
```
```

### Pattern 4 : Feedback loops

Pour les tâches qui nécessitent itération.

```markdown
## Process

1. Générer → Valider
2. Si erreurs : corriger → retour à 1
3. Si OK : continuer

Maximum 3 itérations avant de demander de l'aide.
```

### Pattern 5 : Skills composés

Un skill peut en appeler d'autres via la description.

```markdown
---
name: full-review
description: Lance une review complète. Utilise code-reviewer puis test-runner.
---

## Process

1. D'abord, effectuer une code review (skill: code-reviewer)
2. Ensuite, lancer les tests (skill: test-runner)
3. Synthétiser les résultats
```

---

## Migration depuis les Agents

Si tu utilisais des agents custom, voici comment migrer :

### Avant (Agent)

```markdown
# .claude/agents/reviewer.md
---
name: reviewer
description: Review code
---
[Instructions longues...]
```

### Après (Skill)

```markdown
# .claude/skills/code-reviewer/SKILL.md
---
name: code-reviewer
description: Effectue une revue de code en 3 passes. Utiliser après implémentation.
---
[Instructions concises...]
```

### Différences clés

1. **Dossier** : `agents/` → `skills/`
2. **Fichier** : `agent.md` → `SKILL.md`
3. **Déclenchement** : Manuel → Automatique
4. **Instructions** : Peuvent être plus concises (Claude les découvre en contexte)

---

## Ressources externes

- [Documentation officielle](https://code.claude.com/docs/en/skills)
- [Best practices Anthropic](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices)
- [Blog: Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)
- [Simon Willison sur les Skills](https://simonwillison.net/2025/Oct/16/claude-skills/)
