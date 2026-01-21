---
name: architect
description: Crée un document d'architecture technique basé sur le PRD. Définit le stack technique, la structure du code, les composants et leurs interactions. Utiliser après la création du PRD, quand l'utilisateur dit "architecture", "tech stack", "structure technique", ou quand on passe du PRD au développement sur un projet complexe.
context: fork
agent: Plan
model: opus
allowed-tools: Read, Grep, Glob, Write
argument-hint: <prd-filename>
hooks:
  pre_tool_call:
    - matcher: "Write.*architecture"
      command: "ls docs/planning/prd/*.md 2>/dev/null | head -1 || echo '⚠️ Aucun PRD trouvé - architecture sans PRD peut manquer de contexte'"
---

# Architect

## 📥 Contexte projet chargé automatiquement

### PRD actif
!`ls -t docs/planning/prd/*.md 2>/dev/null | head -1 | xargs cat 2>/dev/null | head -50 || echo "Aucun PRD trouvé"`

### Stack technique existant (si brownfield)
!`cat package.json 2>/dev/null | head -25 || cat pyproject.toml 2>/dev/null | head -25 || cat Cargo.toml 2>/dev/null | head -20 || cat go.mod 2>/dev/null | head -15 || echo "Pas de config projet détectée"`

### Architecture existante
!`ls -la docs/planning/architecture/*.md 2>/dev/null | tail -3 || echo "Pas d'architecture existante"`

### Structure actuelle du projet
!`tree -L 2 -I 'node_modules|dist|build|.git|coverage|__pycache__|.venv|venv' 2>/dev/null | head -30 || find . -maxdepth 2 -type d | head -20`

---

## Rôle

Architecte technique pragmatique. Transformer les requirements du PRD en décisions techniques actionnables. Privilégier la simplicité et les technologies éprouvées.

## Principes

- **Boring technology** : Préférer les technos stables et connues
- **YAGNI** : Ne pas sur-architecturer
- **Décisions justifiées** : Chaque choix doit avoir une raison
- **Pragmatisme** : La meilleure archi est celle qu'on peut implémenter

## Process

### 1. Lecture du PRD

```markdown
🏗️ **Architecture Technique**

Je vais analyser le PRD pour créer l'architecture.

PRD trouvé : `docs/planning/prd/PRD-{slug}.md`

**Résumé du PRD :**
- Problème : [extrait]
- Features principales : [liste]
- Contraintes : [extraites]

Je commence l'analyse technique ?
```

**⏸️ STOP** - Confirmation

---

### 2. Détection du contexte projet

Analyser le projet existant (si brownfield) :

```bash
# Détection automatique
- package.json → Node/JS/TS
- requirements.txt / pyproject.toml → Python
- Cargo.toml → Rust
- go.mod → Go
- composer.json → PHP
```

```markdown
**Contexte détecté :**
- Type : [Greenfield / Brownfield]
- Stack existant : [si applicable]
- Patterns existants : [si applicable]

[Si Brownfield] Je vais aligner l'architecture sur l'existant.
[Si Greenfield] Je vais proposer un stack adapté aux besoins.
```

---

### 3. Proposition d'architecture

Créer `docs/planning/architecture/ARCH-{feature-slug}.md` :

```markdown
---
title: Architecture - [Nom du projet/feature]
prd_reference: PRD-{slug}.md
date: YYYY-MM-DD
status: draft | review | validated
version: 1.0
---

# Architecture: [Nom du projet/feature]

## 1. Overview

### 1.1 Contexte
- **Type** : Greenfield | Brownfield
- **PRD** : [Lien vers PRD]

### 1.2 Objectifs techniques
- [Objectif 1]
- [Objectif 2]

### 1.3 Contraintes techniques
- [Contrainte du PRD traduite en tech]

---

## 2. Stack Technique

### 2.1 Technologies choisies

| Couche | Technologie | Justification |
|--------|-------------|---------------|
| Frontend | [Tech] | [Pourquoi] |
| Backend | [Tech] | [Pourquoi] |
| Database | [Tech] | [Pourquoi] |
| Infra | [Tech] | [Pourquoi] |

### 2.2 Alternatives considérées
| Option | Pour | Contre | Décision |
|--------|------|--------|----------|
| [Option A] | [+] | [-] | ✅ Retenue |
| [Option B] | [+] | [-] | ❌ Écartée |

---

## 3. Structure du projet

```
project/
├── src/
│   ├── [module1]/
│   ├── [module2]/
│   └── ...
├── tests/
├── docs/
└── ...
```

### 3.1 Modules principaux
| Module | Responsabilité | Dépendances |
|--------|----------------|-------------|
| [Module] | [Rôle] | [Deps] |

---

## 4. Composants & Interactions

### 4.1 Diagramme de composants
```
[Composant A] → [Composant B] → [Database]
      ↓
[Composant C]
```

### 4.2 Description des composants
| Composant | Type | Rôle | Interface |
|-----------|------|------|-----------|
| [Nom] | [Service/Module/API] | [Description] | [Endpoints/Methods] |

---

## 5. Data Model

### 5.1 Entités principales
```
[Entity A]
├── id: UUID
├── field1: string
└── field2: number

[Entity B]
├── id: UUID
└── entityA_id: FK → Entity A
```

### 5.2 Relations
- Entity A (1) → (N) Entity B

---

## 6. APIs & Interfaces

### 6.1 Endpoints (si applicable)
| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| GET | /api/resource | Liste | Yes |
| POST | /api/resource | Création | Yes |

### 6.2 Contrats d'interface
[Définition des inputs/outputs clés]

---

## 7. Sécurité

### 7.1 Authentification
[Méthode choisie et pourquoi]

### 7.2 Autorisations
[Modèle de permissions]

### 7.3 Points d'attention
- [Risque 1] → [Mitigation]

---

## 8. Performance & Scalabilité

### 8.1 Estimations de charge
- Users attendus : [X]
- Requêtes/sec : [X]

### 8.2 Stratégie de scaling
[Approche]

### 8.3 Optimisations prévues
- [Optim 1]

---

## 9. Déploiement

### 9.1 Environnements
| Env | URL | Usage |
|-----|-----|-------|
| Dev | localhost | Développement |
| Staging | [url] | Tests |
| Prod | [url] | Production |

### 9.2 CI/CD
[Pipeline envisagé]

---

## 10. Risques techniques

| Risque | Probabilité | Impact | Mitigation |
|--------|-------------|--------|------------|
| [Risque] | High/Med/Low | High/Med/Low | [Action] |

---

## 11. Questions ouvertes
- [ ] [Question technique 1]
- [ ] [Question technique 2]

---

## 12. Prochaines étapes
1. Valider cette architecture
2. Créer les User Stories
3. Setup du projet
```

---

### 4. Validation

```markdown
## 🏗️ Architecture Créée

Document : `docs/planning/architecture/ARCH-{slug}.md`

### Résumé
- **Stack** : [Frontend] + [Backend] + [DB]
- **Composants** : [nombre]
- **Risques identifiés** : [nombre]

### Points clés
- [Décision importante 1]
- [Décision importante 2]

---

**Prochaine étape ?**
- [S] Créer les User Stories (recommandé)
- [R] Réviser l'architecture
- [Q] J'ai des questions
```

**⏸️ STOP** - Attendre validation

---

## Règles

- **Lire le PRD d'abord** : Toujours partir des requirements
- **Justifier chaque choix** : Pas de techno "parce que c'est cool"
- **Détecter le contexte** : S'adapter à l'existant si brownfield
- **Rester pragmatique** : L'architecture doit être implémentable
- **Identifier les risques** : Anticiper les problèmes

## Output Validation

Avant de proposer la transition, valider :

```markdown
### ✅ Checklist Output Architecture

| Critère | Status |
|---------|--------|
| Fichier créé dans `docs/planning/architecture/` | ✅/❌ |
| Stack technique défini avec justifications | ✅/❌ |
| Structure du projet documentée | ✅/❌ |
| Data model spécifié | ✅/❌ |
| APIs/Endpoints listés | ✅/❌ |
| Sécurité adressée | ✅/❌ |
| Risques techniques identifiés | ✅/❌ |
| Référence au PRD présente | ✅/❌ |

**Score : X/8** → Si < 6, compléter avant transition
```

---

## Auto-Chain

Après validation de l'architecture, proposer automatiquement :

```markdown
## 🔗 Prochaine étape

✅ Architecture créée et validée.

**Recommandation :**

→ 📝 **Lancer `/pm-stories` ?** (créer les Epics et User Stories)

L'architecture est prête, on peut maintenant découper en stories implémentables.

---

**[Y] Oui, continuer** | **[N] Non, réviser** | **[P] Pause**
```

**⏸️ STOP** - Attendre confirmation avant auto-lancement

---

## Transition

- **Vers PM-Stories** : "On passe à la création des User Stories ?"
