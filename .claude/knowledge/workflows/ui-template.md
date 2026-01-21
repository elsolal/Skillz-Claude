# Template UI Design

> Template pour la documentation UI et Design System générée par le skill `ui-designer`.

## Structure du document UI

```markdown
# UI Design: [Nom du projet]

## Design Principles

### Principes directeurs
1. **[Principe 1]** - [Description - ex: Clarté avant tout]
2. **[Principe 2]** - [Description - ex: Cohérence visuelle]
3. **[Principe 3]** - [Description - ex: Accessibilité native]

### Personnalité de marque
| Attribut | Description |
|----------|-------------|
| **Ton** | [Professionnel / Décontracté / Playful] |
| **Émotion** | [Confiance / Énergie / Calme] |
| **Audience** | [Description de l'audience cible] |

---

## Design Tokens

### Couleurs

#### Palette principale
| Token | Valeur | Usage |
|-------|--------|-------|
| `--color-primary` | #[hex] | CTA, liens, accents |
| `--color-primary-hover` | #[hex] | États hover |
| `--color-primary-light` | #[hex] | Backgrounds légers |
| `--color-secondary` | #[hex] | Éléments secondaires |

#### Palette sémantique
| Token | Valeur | Usage |
|-------|--------|-------|
| `--color-success` | #22C55E | Confirmations, succès |
| `--color-warning` | #F59E0B | Alertes, attention |
| `--color-error` | #EF4444 | Erreurs, danger |
| `--color-info` | #3B82F6 | Informations |

#### Neutres
| Token | Valeur | Usage |
|-------|--------|-------|
| `--color-gray-900` | #111827 | Texte principal |
| `--color-gray-700` | #374151 | Texte secondaire |
| `--color-gray-500` | #6B7280 | Texte désactivé |
| `--color-gray-300` | #D1D5DB | Bordures |
| `--color-gray-100` | #F3F4F6 | Backgrounds |
| `--color-white` | #FFFFFF | Surfaces |

### Typographie

#### Font Family
| Token | Valeur | Usage |
|-------|--------|-------|
| `--font-sans` | 'Inter', system-ui, sans-serif | Corps de texte |
| `--font-mono` | 'JetBrains Mono', monospace | Code |

#### Font Sizes
| Token | Valeur | Line Height | Usage |
|-------|--------|-------------|-------|
| `--text-xs` | 12px | 16px | Labels, captions |
| `--text-sm` | 14px | 20px | Body small |
| `--text-base` | 16px | 24px | Body |
| `--text-lg` | 18px | 28px | Body large |
| `--text-xl` | 20px | 28px | H4 |
| `--text-2xl` | 24px | 32px | H3 |
| `--text-3xl` | 30px | 36px | H2 |
| `--text-4xl` | 36px | 40px | H1 |

#### Font Weights
| Token | Valeur | Usage |
|-------|--------|-------|
| `--font-normal` | 400 | Corps de texte |
| `--font-medium` | 500 | Labels, emphasis |
| `--font-semibold` | 600 | Sous-titres |
| `--font-bold` | 700 | Titres |

### Spacing

| Token | Valeur | Usage |
|-------|--------|-------|
| `--space-1` | 4px | Micro spacing |
| `--space-2` | 8px | Tight spacing |
| `--space-3` | 12px | Compact spacing |
| `--space-4` | 16px | Default spacing |
| `--space-5` | 20px | Relaxed spacing |
| `--space-6` | 24px | Section spacing |
| `--space-8` | 32px | Large spacing |
| `--space-10` | 40px | XL spacing |
| `--space-12` | 48px | XXL spacing |
| `--space-16` | 64px | Page sections |

### Border Radius

| Token | Valeur | Usage |
|-------|--------|-------|
| `--radius-sm` | 4px | Badges, tags |
| `--radius-md` | 8px | Inputs, cards small |
| `--radius-lg` | 12px | Cards, modals |
| `--radius-xl` | 16px | Large cards |
| `--radius-full` | 9999px | Pills, avatars |

### Shadows

| Token | Valeur | Usage |
|-------|--------|-------|
| `--shadow-sm` | 0 1px 2px rgba(0,0,0,0.05) | Subtle elevation |
| `--shadow-md` | 0 4px 6px rgba(0,0,0,0.1) | Cards |
| `--shadow-lg` | 0 10px 15px rgba(0,0,0,0.1) | Dropdowns |
| `--shadow-xl` | 0 20px 25px rgba(0,0,0,0.1) | Modals |

### Transitions

| Token | Valeur | Usage |
|-------|--------|-------|
| `--transition-fast` | 150ms ease | Hovers |
| `--transition-base` | 200ms ease | Interactions |
| `--transition-slow` | 300ms ease | Animations |

### Breakpoints

| Token | Valeur | Usage |
|-------|--------|-------|
| `--screen-sm` | 640px | Mobile landscape |
| `--screen-md` | 768px | Tablet |
| `--screen-lg` | 1024px | Desktop |
| `--screen-xl` | 1280px | Large desktop |
| `--screen-2xl` | 1536px | Extra large |

---

## Composants UI

### Button

**Variants:**
| Variant | Usage |
|---------|-------|
| Primary | CTA principal, action importante |
| Secondary | Action secondaire |
| Outline | Action tertiaire |
| Ghost | Action minimale, liens |
| Danger | Actions destructives |

**Sizes:**
| Size | Height | Padding | Font |
|------|--------|---------|------|
| sm | 32px | 12px 16px | 14px |
| md | 40px | 16px 24px | 16px |
| lg | 48px | 20px 32px | 18px |

**States:**
- Default
- Hover
- Active/Pressed
- Focus (ring)
- Disabled
- Loading

**Specs:**
\`\`\`
┌─────────────────────────┐
│    [Icon]  Label        │  height: 40px
└─────────────────────────┘  padding: 16px 24px
                             border-radius: 8px
                             font-weight: 500
\`\`\`

---

### Input

**Variants:**
| Variant | Usage |
|---------|-------|
| Text | Texte court |
| Email | Adresses email |
| Password | Mots de passe |
| Number | Valeurs numériques |
| Textarea | Texte long |
| Select | Choix dans une liste |

**States:**
- Default
- Focus
- Error
- Disabled
- Read-only

**Anatomy:**
\`\`\`
  [Label]                    (optionnel)
┌─────────────────────────┐
│ [Icon] Placeholder      │  height: 40px
└─────────────────────────┘  padding: 12px 16px
  [Helper text or error]     border-radius: 8px
\`\`\`

---

### Card

**Variants:**
| Variant | Usage |
|---------|-------|
| Default | Container standard |
| Interactive | Cliquable |
| Elevated | Plus de shadow |
| Outlined | Bordure sans shadow |

**Specs:**
\`\`\`
┌─────────────────────────────────┐
│  [Header]                       │
├─────────────────────────────────┤
│                                 │
│  [Content]                      │  padding: 24px
│                                 │  border-radius: 12px
│                                 │  shadow: md
├─────────────────────────────────┤
│  [Footer/Actions]               │
└─────────────────────────────────┘
\`\`\`

---

### Modal

**Sizes:**
| Size | Max Width |
|------|-----------|
| sm | 400px |
| md | 500px |
| lg | 600px |
| xl | 800px |
| full | 100% - 48px |

**Anatomy:**
\`\`\`
┌─────────────────────────────────┐
│  [Title]                    [X] │  Header
├─────────────────────────────────┤
│                                 │
│  [Content]                      │  Body (scrollable)
│                                 │
├─────────────────────────────────┤
│            [Cancel] [Confirm]   │  Footer
└─────────────────────────────────┘
\`\`\`

---

### Toast / Notification

**Variants:**
| Variant | Icône | Couleur |
|---------|-------|---------|
| Success | ✓ | Green |
| Error | ✕ | Red |
| Warning | ⚠ | Yellow |
| Info | ℹ | Blue |

**Behavior:**
- Position: Top-right ou Bottom-center
- Auto-dismiss: 3-5 secondes
- Stacking: Max 3 visible

---

## Iconographie

### Style
- **Style:** Outlined / Filled
- **Taille base:** 24px
- **Stroke:** 1.5px
- **Library:** [Lucide / Heroicons / Custom]

### Tailles
| Size | Valeur | Usage |
|------|--------|-------|
| xs | 16px | Inline, badges |
| sm | 20px | Boutons, inputs |
| md | 24px | Default |
| lg | 32px | Empty states |
| xl | 48px | Features |

---

## Grille et Layout

### Container
| Breakpoint | Max Width | Padding |
|------------|-----------|---------|
| Mobile | 100% | 16px |
| Tablet | 768px | 24px |
| Desktop | 1024px | 32px |
| Large | 1280px | 48px |

### Grid
- Colonnes: 12
- Gutter: 24px (desktop), 16px (mobile)
- Margin: Auto-centered

---

## Accessibilité

### Contraste
| Élément | Ratio minimum |
|---------|---------------|
| Texte normal | 4.5:1 |
| Texte large (18px+) | 3:1 |
| Éléments UI | 3:1 |

### Focus
- Ring visible: 2px solid primary
- Offset: 2px
- Ne jamais masquer le focus

### Touch targets
- Minimum: 44x44px
- Espacement: 8px minimum

---

## Fichier tokens.css

\`\`\`css
:root {
  /* Colors - Primary */
  --color-primary: #[hex];
  --color-primary-hover: #[hex];
  --color-primary-light: #[hex];

  /* Colors - Semantic */
  --color-success: #22C55E;
  --color-warning: #F59E0B;
  --color-error: #EF4444;
  --color-info: #3B82F6;

  /* Colors - Neutral */
  --color-gray-900: #111827;
  --color-gray-700: #374151;
  --color-gray-500: #6B7280;
  --color-gray-300: #D1D5DB;
  --color-gray-100: #F3F4F6;
  --color-white: #FFFFFF;

  /* Typography */
  --font-sans: 'Inter', system-ui, sans-serif;
  --font-mono: 'JetBrains Mono', monospace;

  /* Font Sizes */
  --text-xs: 0.75rem;
  --text-sm: 0.875rem;
  --text-base: 1rem;
  --text-lg: 1.125rem;
  --text-xl: 1.25rem;
  --text-2xl: 1.5rem;
  --text-3xl: 1.875rem;
  --text-4xl: 2.25rem;

  /* Spacing */
  --space-1: 0.25rem;
  --space-2: 0.5rem;
  --space-3: 0.75rem;
  --space-4: 1rem;
  --space-6: 1.5rem;
  --space-8: 2rem;
  --space-12: 3rem;
  --space-16: 4rem;

  /* Border Radius */
  --radius-sm: 0.25rem;
  --radius-md: 0.5rem;
  --radius-lg: 0.75rem;
  --radius-xl: 1rem;
  --radius-full: 9999px;

  /* Shadows */
  --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
  --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
  --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
  --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1);

  /* Transitions */
  --transition-fast: 150ms ease;
  --transition-base: 200ms ease;
  --transition-slow: 300ms ease;
}
\`\`\`

---

## Livrables

- [ ] Design tokens documentés
- [ ] Fichier tokens.css généré
- [ ] Composants principaux spécifiés
- [ ] Guidelines accessibilité
- [ ] Grille et breakpoints définis
```

---

## Checklist de qualité UI

| Critère | Description |
|---------|-------------|
| **Tokens complets** | Couleurs, typo, spacing, radius, shadows |
| **Composants documentés** | États, tailles, variants |
| **Accessibilité** | Contraste, focus, touch targets |
| **Responsive** | Breakpoints et comportements définis |
| **Cohérence** | Tokens utilisés partout, pas de valeurs hardcodées |
