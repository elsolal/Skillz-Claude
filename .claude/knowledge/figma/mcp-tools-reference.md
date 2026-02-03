# MCP Figma Tools Reference

## Overview

Le serveur MCP Figma expose des outils pour interagir avec les designs Figma depuis Claude. Ces outils permettent d'extraire des informations de design, générer du code, et gérer les mappings Code Connect.

**URL du serveur** : `https://mcp.figma.com/mcp`

**Authentification** : OAuth automatique via le navigateur (pas de token à gérer)

## Outils disponibles

### 1. get_design_context

Extrait le contexte de design d'un fichier ou d'une sélection Figma pour la génération de code.

**Usage** :
```
get_design_context(file_key, node_id?, framework?)
```

**Paramètres** :
| Param | Type | Description |
|-------|------|-------------|
| `file_key` | string | Clé du fichier Figma (dans l'URL) |
| `node_id` | string? | ID du node spécifique (optionnel) |
| `framework` | string? | Framework cible (react, vue, html) |

**Retourne** :
- Structure du composant
- Props détectées
- Styles (couleurs, typo, spacing)
- Hierarchy des éléments

**Exemple d'URL** :
```
https://figma.com/design/ABC123/MyDesign?node-id=1:234
                         ^^^^^^                  ^^^^^
                         file_key                node_id
```

### 2. get_variable_defs

Récupère les définitions de variables (tokens) d'un fichier Figma.

**Usage** :
```
get_variable_defs(file_key)
```

**Retourne** :
- Variables de couleur
- Variables typographiques
- Variables d'espacement
- Collections et modes (light/dark)

**Mapping vers CSS** :
```css
/* Figma: Color/Primary/500 */
--color-primary-500: #3b82f6;

/* Figma: Spacing/md */
--spacing-md: 16px;

/* Figma: Font/Body/Regular */
--font-body: 400 16px/1.5 'Inter';
```

### 3. get_metadata

Récupère les métadonnées légères d'un fichier Figma.

**Usage** :
```
get_metadata(file_key, node_id?)
```

**Retourne** :
- Nom du fichier/composant
- Structure XML légère
- Dimensions
- Type de node

**Utilisation** : Inspection rapide sans télécharger tout le design.

### 4. get_screenshot

Capture une image d'un node ou d'une sélection Figma.

**Usage** :
```
get_screenshot(file_key, node_id, format?, scale?)
```

**Paramètres** :
| Param | Type | Default | Description |
|-------|------|---------|-------------|
| `format` | string | png | png, jpg, svg, pdf |
| `scale` | number | 1 | 0.01 à 4 |

**Utilisation** : Validation visuelle, documentation, debugging.

### 5. get_code_connect_map

Récupère les mappings Code Connect existants pour un fichier.

**Usage** :
```
get_code_connect_map(file_key)
```

**Retourne** :
```json
{
  "mappings": [
    {
      "node_id": "1:234",
      "component_name": "Button",
      "file_path": "src/components/ui/button.tsx",
      "published_at": "2024-01-15T10:00:00Z"
    }
  ]
}
```

**Utilisation** : Vérifier quels composants sont déjà mappés avant de générer du code.

### 6. add_code_connect_map

Crée ou met à jour un mapping Code Connect.

**Usage** :
```
add_code_connect_map(file_key, node_id, component_path, props_mapping)
```

**Paramètres** :
| Param | Type | Description |
|-------|------|-------------|
| `file_key` | string | Clé du fichier Figma |
| `node_id` | string | ID du node à mapper |
| `component_path` | string | Chemin vers le composant code |
| `props_mapping` | object | Mapping des props |

**Note** : Préférer la CLI Code Connect pour les mappings complexes.

## Workflow recommandé

### 1. Analyse d'un design

```
1. get_metadata       → Comprendre la structure
2. get_variable_defs  → Récupérer les tokens
3. get_design_context → Extraire les détails pour le code
4. get_screenshot     → Valider visuellement
```

### 2. Génération avec mappings existants

```
1. get_code_connect_map → Voir les composants déjà mappés
2. get_design_context   → Extraire le design
3. Générer le code en utilisant les composants mappés
```

### 3. Création de nouveaux mappings

```
1. get_design_context → Analyser le composant
2. Créer le fichier .figma.tsx localement
3. npx figma connect publish → Publier via CLI
```

## Parsing d'URL Figma

### Format standard

```
https://figma.com/design/{file_key}/{file_name}?node-id={node_id}
https://figma.com/file/{file_key}/{file_name}?node-id={node_id}
```

### Extraction regex

```javascript
const figmaUrlRegex = /figma\.com\/(design|file)\/([a-zA-Z0-9]+)/;
const nodeIdRegex = /node-id=([0-9]+[-:][0-9]+)/;
```

### Exemples

| URL | file_key | node_id |
|-----|----------|---------|
| `figma.com/design/ABC123/...?node-id=1:234` | ABC123 | 1:234 |
| `figma.com/file/XYZ789/...?node-id=5-10` | XYZ789 | 5-10 |

## Gestion des erreurs

| Code | Signification | Action |
|------|---------------|--------|
| 401 | Non authentifié | Re-authentifier via OAuth |
| 403 | Accès refusé au fichier | Vérifier les permissions |
| 404 | Fichier/node non trouvé | Vérifier l'URL |
| 429 | Rate limit | Attendre et réessayer |

## Limitations

- **Rate limiting** : ~30 requêtes/minute par utilisateur
- **Taille des fichiers** : Fichiers volumineux peuvent timeout
- **Complexité** : Designs très complexes peuvent être tronqués
- **Variables** : Uniquement si le fichier a des variables définies

## Intégration avec les skills

### Dans figma-to-code

```markdown
1. Parser l'URL Figma fournie
2. get_code_connect_map → Vérifier mappings existants
3. get_variable_defs → Récupérer tokens
4. get_design_context → Extraire le design
5. Générer code avec composants mappés
```

### Dans ui-designer

```markdown
1. get_variable_defs → Importer tokens existants
2. Transformer en format tokens.css
3. Permettre ajustements manuels
```
