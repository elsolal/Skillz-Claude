---
name: codebase-explainer
description: Analyse le code source du projet pour comprendre l'architecture, les patterns utilisés et le contexte technique. Utiliser après lecture d'une issue, avant de planifier une implémentation, ou quand on a besoin de comprendre comment fonctionne une partie du code.
---

# Codebase Explainer

## Instructions

### 1. Exploration initiale
- Lire la structure (`ls -la`, `tree`)
- Identifier le type de projet (framework, langage)
- Localiser les fichiers de config

### 2. Analyse ciblée
Selon les requirements de l'issue :
- Fichiers/modules concernés
- Dépendances entre composants
- Patterns existants (naming, structure)
- Conventions du projet

### 3. Cartographie des impacts
- Quels fichiers devront être modifiés ?
- Quelles fonctions/classes impliquées ?
- Tests existants à considérer ?

---

## Output attendu

```markdown
## Analyse du Codebase

### Architecture
- **Type:** [monorepo/microservice/monolith]
- **Stack:** [langages, frameworks]
- **Patterns:** [MVC/Clean Architecture/etc.]

### Fichiers pertinents
| Fichier | Rôle | Modification |
|---------|------|--------------|
| `src/...` | Description | Oui/Non |

### Patterns à respecter
1. [Convention 1 observée]
2. [Convention 2 observée]

### Dépendances internes
```
module_a → module_b → module_c
```

### Points d'attention
- [Risque ou complexité identifiée]
```

---

## Validation

Avant de passer au Plan :
- L'analyse couvre-t-elle tous les aspects ?
- Y a-t-il des zones à explorer davantage ?

**⏸️ CHECKPOINT** - Attendre validation.
