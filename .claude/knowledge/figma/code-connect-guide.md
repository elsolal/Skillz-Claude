# Code Connect Guide

## Overview

Code Connect est un système de Figma qui permet de mapper des composants Figma vers des composants de code existants. Quand un développeur inspecte un composant dans Figma, il voit directement le code du composant mappé.

**Principe clé** : Code Connect ne génère pas de code - il **connecte** les designs Figma aux composants existants de votre codebase.

## Installation

### Prérequis

- Node.js 18+
- Package.json existant
- Accès Figma (compte gratuit suffit)

### Installation du package

```bash
npm install -D @figma/code-connect
```

### Authentification

```bash
npx figma connect
```

Cette commande :
1. Ouvre le navigateur pour OAuth
2. Crée `~/.figma/credentials.json`
3. Valide l'accès

## Configuration

### Fichier figma.config.json

```json
{
  "$schema": "https://figma.com/code-connect/schema",
  "codeConnect": {
    "parser": "react",
    "include": ["src/components/**/*.figma.tsx"],
    "exclude": ["**/*.test.tsx", "**/*.stories.tsx"]
  }
}
```

### Parsers disponibles

| Parser | Usage |
|--------|-------|
| `react` | React (JSX/TSX) |
| `html` | HTML/CSS/Web Components |
| `swiftui` | SwiftUI (iOS) |
| `compose` | Jetpack Compose (Android) |

## Commandes CLI

### Créer un mapping

```bash
# Depuis une URL Figma
npx figma connect create "https://figma.com/design/FILE_KEY/DESIGN_NAME?node-id=NODE_ID"

# Mode interactif
npx figma connect create
```

### Publier les mappings

```bash
npx figma connect publish
```

### Vérifier les mappings

```bash
npx figma connect verify
```

### Unpublish

```bash
npx figma connect unpublish
```

## Structure des fichiers .figma.tsx

### Exemple basique

```tsx
// src/components/ui/button.figma.tsx
import figma from "@figma/code-connect";
import { Button } from "./button";

figma.connect(Button, "https://figma.com/design/xxx?node-id=1:234", {
  props: {
    label: figma.string("Label"),
    variant: figma.enum("Variant", {
      Primary: "primary",
      Secondary: "secondary",
      Ghost: "ghost",
    }),
    size: figma.enum("Size", {
      Small: "sm",
      Medium: "md",
      Large: "lg",
    }),
    disabled: figma.boolean("Disabled"),
  },
  example: (props) => (
    <Button variant={props.variant} size={props.size} disabled={props.disabled}>
      {props.label}
    </Button>
  ),
});
```

### Props disponibles

| Fonction | Usage | Exemple |
|----------|-------|---------|
| `figma.string("Name")` | Texte | Labels, placeholders |
| `figma.boolean("Name")` | Booléen | disabled, loading |
| `figma.enum("Name", mapping)` | Énumération | variants, sizes |
| `figma.instance("Name")` | Sous-composant | icons, slots |
| `figma.children("Name")` | Children React | Contenu slot |

### Mapping de variants

```tsx
// Mapper les valeurs Figma vers les valeurs code
figma.enum("Variant", {
  // Nom dans Figma: valeur dans le code
  "Primary": "primary",
  "Secondary": "secondary",
  "Outline": "outline",
  "Ghost": "ghost",
  "Link": "link",
});
```

### Exemple avec icône

```tsx
figma.connect(Button, "https://figma.com/design/xxx?node-id=1:234", {
  props: {
    label: figma.string("Label"),
    leftIcon: figma.instance("Left Icon"),
    rightIcon: figma.instance("Right Icon"),
  },
  example: (props) => (
    <Button leftIcon={props.leftIcon} rightIcon={props.rightIcon}>
      {props.label}
    </Button>
  ),
});
```

## Workflows

### Nouveau projet (greenfield)

1. Créer les composants UI dans le code
2. Créer le design system dans Figma
3. Mapper avec Code Connect
4. Publier

### Projet existant (brownfield)

1. Scanner les composants existants
2. Identifier les correspondances avec Figma
3. Créer les fichiers .figma.tsx
4. Publier

### Mise à jour des designs

1. Designer modifie dans Figma
2. Si nouvelle prop → mettre à jour le .figma.tsx
3. Re-publier

## Bonnes pratiques

### Organisation des fichiers

```
src/
├── components/
│   └── ui/
│       ├── button.tsx          # Composant
│       ├── button.figma.tsx    # Mapping Code Connect
│       └── button.test.tsx     # Tests
```

### Naming conventions

- Fichier : `{component-name}.figma.tsx`
- Un fichier par composant principal
- Inclure les variants dans le même fichier

### Gestion des variants

```tsx
// Variant par boolean
figma.connect(Button, "URL_VARIANT_PRIMARY", {
  variant: { hasPrimary: true },
  example: () => <Button variant="primary">Click</Button>,
});

figma.connect(Button, "URL_VARIANT_SECONDARY", {
  variant: { hasPrimary: false },
  example: () => <Button variant="secondary">Click</Button>,
});
```

## Debugging

### Vérifier la connexion

```bash
npx figma connect verify --verbose
```

### Erreurs courantes

| Erreur | Cause | Solution |
|--------|-------|----------|
| `Unauthorized` | Token expiré | Re-run `figma connect` |
| `Component not found` | URL incorrecte | Vérifier node-id |
| `Parser error` | Syntax incorrecte | Vérifier le fichier .figma.tsx |

### Logs

```bash
DEBUG=figma:* npx figma connect publish
```

## Intégration CI/CD

### GitHub Action

```yaml
name: Publish Code Connect
on:
  push:
    paths:
      - 'src/**/*.figma.tsx'

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm ci
      - run: npx figma connect publish
        env:
          FIGMA_ACCESS_TOKEN: ${{ secrets.FIGMA_ACCESS_TOKEN }}
```

### Token pour CI

1. Aller dans Figma Settings > Personal Access Tokens
2. Créer un token avec scope `code_connect:write`
3. Ajouter comme secret `FIGMA_ACCESS_TOKEN`

## Ressources

- [Documentation officielle](https://www.figma.com/developers/api#code-connect)
- [GitHub Code Connect](https://github.com/figma/code-connect)
- [Exemples React](https://github.com/figma/code-connect/tree/main/examples/react)
