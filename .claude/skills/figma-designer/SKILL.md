---
name: figma-designer
description: Use when the user wants Claude to create or prototype UI designs directly in Figma using the Figma Console bridge. Triggers on "design this in Figma", "create a screen in Figma", "prototype this page", "make a mockup in Figma", "draw this layout", or when the user asks to visually design something and Figma Console MCP is available.
---

# Figma Designer

Claude creates designs directly in Figma via the Figma Console MCP bridge.

## Prerequisites

Figma Console MCP must be running and connected. Check with `figma_get_status`.
If not available, tell the user to start the Figma Console plugin and bridge.

## Core Rules

- **ALWAYS** call `figma_search_components` at session start — nodeIds are session-specific
- **ALWAYS** take a screenshot after creating/modifying visual elements (validation loop)
- **ALWAYS** place new elements inside a Section or Frame, never on blank canvas
- **ALWAYS** use `figma_instantiate_component` for existing components instead of recreating them
- **NEVER** reuse nodeIds from a previous session
- **NEVER** trigger JavaScript alerts/dialogs through figma_execute

## Visual Validation Loop (mandatory)

After ANY visual change:

```
1. CREATE  → figma_execute / figma_create_child / figma_instantiate_component
2. SCREENSHOT → figma_take_screenshot
3. ANALYZE → Check alignment, spacing, proportions, visual balance
4. ITERATE → Fix issues (max 3 iterations)
5. VERIFY  → Final screenshot to confirm
```

## Workflow

### 1. Setup & Context

```
figma_get_status          → Verify connection
figma_list_open_files     → See what's open
figma_search_components   → Catalog available components (REQUIRED)
figma_get_variables       → Get existing tokens/variables
```

Present to user:

```markdown
**Figma connecté** : [file name]

**Composants disponibles** : [N]
[list key components: Button, Card, Input, etc.]

**Variables/tokens** : [N collections]

Prêt à designer. Qu'est-ce qu'on crée ?
```

### 2. Design Planning

Before touching Figma, plan the layout:

```markdown
**Plan de design** : [screen name]

**Structure** :
├── Header (Auto Layout horizontal, fill)
│   ├── Logo
│   └── Nav items
├── Hero Section (Auto Layout vertical, center)
│   ├── Heading
│   ├── Subtext
│   └── CTA Button (→ composant existant)
└── Content (Grid 3 cols)
    ├── Card ×3 (→ composant existant)
    └── ...

**Composants réutilisés** : [list]
**Composants à créer** : [list or "aucun"]
**Dimensions** : [W × H, device target]

On lance ?
```

**STOP** — Validate plan with user before creating anything.

### 3. Build the Design

#### Container First

Always start with a parent container:

```javascript
// Find or create a Section
let section = figma.currentPage.findOne(
  n => n.type === 'SECTION' && n.name === 'Design'
);
if (!section) {
  section = figma.createSection();
  section.name = 'Design';
  section.x = 0;
  section.y = 0;
}

// Create the main frame inside
const frame = figma.createFrame();
frame.name = 'Screen Name';
frame.resize(1440, 900);
frame.layoutMode = 'VERTICAL';
frame.primaryAxisAlignItems = 'CENTER';
frame.counterAxisAlignItems = 'CENTER';
frame.paddingTop = 40;
frame.paddingBottom = 40;
frame.paddingLeft = 40;
frame.paddingRight = 40;
frame.itemSpacing = 24;
section.appendChild(frame);
```

#### Use Existing Components

```javascript
// ALWAYS search first
const buttons = figma.currentPage.findAll(
  n => n.type === 'COMPONENT' && n.name.includes('Button')
);

// Instantiate, don't recreate
const buttonInstance = buttons[0].createInstance();
parentFrame.appendChild(buttonInstance);
```

#### Create Primitives When Needed

```javascript
// Text
const heading = figma.createText();
await figma.loadFontAsync({ family: "Inter", style: "Bold" });
heading.characters = "Welcome";
heading.fontSize = 48;
heading.fontName = { family: "Inter", style: "Bold" };

// Rectangle (background, card, etc.)
const card = figma.createFrame();
card.name = 'Card';
card.resize(400, 300);
card.cornerRadius = 12;
card.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];

// Auto Layout
card.layoutMode = 'VERTICAL';
card.itemSpacing = 16;
card.paddingTop = 24;
card.paddingBottom = 24;
card.paddingLeft = 24;
card.paddingRight = 24;
```

#### Apply Variables/Tokens

```javascript
// Bind to existing variables instead of hardcoding colors
const colorVars = await figma.variables.getLocalVariablesAsync('COLOR');
const primaryVar = colorVars.find(v => v.name.includes('primary'));
if (primaryVar) {
  frame.setBoundVariable('fills', 0, 'color', primaryVar.id);
}
```

### 4. Common Patterns

#### Responsive Layout

```javascript
// Fill container (not fixed width)
childFrame.layoutSizingHorizontal = 'FILL'; // NOT 'FIXED' or 'HUG'
childFrame.layoutSizingVertical = 'HUG';
```

#### Grid of Cards

```javascript
const grid = figma.createFrame();
grid.name = 'Cards Grid';
grid.layoutMode = 'HORIZONTAL';
grid.layoutWrap = 'WRAP';
grid.itemSpacing = 24;
grid.counterAxisSpacing = 24;
grid.layoutSizingHorizontal = 'FILL';

for (let i = 0; i < 3; i++) {
  const card = cardComponent.createInstance();
  card.layoutSizingHorizontal = 'FIXED';
  card.resize(400, 300);
  grid.appendChild(card);
}
```

#### Navigation Bar

```javascript
const nav = figma.createFrame();
nav.name = 'Navbar';
nav.layoutMode = 'HORIZONTAL';
nav.layoutSizingHorizontal = 'FILL';
nav.primaryAxisAlignItems = 'SPACE_BETWEEN';
nav.counterAxisAlignItems = 'CENTER';
nav.paddingLeft = 24;
nav.paddingRight = 24;
nav.resize(nav.width, 64);
nav.layoutSizingVertical = 'FIXED';
```

### 5. Screenshot & Validate

After building, ALWAYS:

```
figma_take_screenshot → Inspect result
```

Check for:
- Elements using "hug contents" that should "fill container" (lopsided layouts)
- Inconsistent padding
- Text/inputs not filling available width
- Items not centered in their containers
- Components floating outside their parent

Fix issues and re-screenshot (max 3 iterations).

### 6. Present Result

```markdown
## Design créé : [Name]

**Screenshot** : [attached]

**Structure** :
- [N] composants réutilisés
- [N] éléments créés
- Dimensions : [W × H]

**Composants utilisés** : Button, Card, Input...

Le design te convient ? Je peux :
- [A] Ajuster des éléments
- [C] Créer un autre écran
- [E] Exporter vers du code (`/figma-to-code`)
```

## Common Mistakes to Avoid

| Mistake | Fix |
|---------|-----|
| Fixed width on elements that should fill | Use `layoutSizingHorizontal = 'FILL'` |
| Hug contents on containers | Check if fill is more appropriate |
| Forgetting `await figma.loadFontAsync()` before setting text | Always load fonts first |
| Creating components from scratch when they exist | Search first with `figma_search_components` |
| Placing elements on blank canvas | Always use a Section or Frame parent |
| Not using Auto Layout | Use `layoutMode` on all container frames |
| Hardcoding colors instead of using variables | Bind to existing variables when available |

## Batch Operations

When creating multiple variables or updating many elements, use batch tools:
- `figma_batch_create_variables` — up to 100 variables in one call
- `figma_batch_update_variables` — up to 100 updates in one call
- `figma_setup_design_tokens` — create collection + modes + variables atomically

These are 10-50x faster than individual calls.

## Auto-Chain

After design is complete:
- → `/figma-to-code <url>` — Convert to code
- → `/figma-design-code-sync` — Set up sync mappings
- → Create another screen
