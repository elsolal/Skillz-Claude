# Figma Variables to CSS Tokens Mapping

## Overview

Ce document décrit comment transformer les variables Figma (Design Tokens) en CSS Variables utilisables dans le code.

## Structure des variables Figma

### Collections

Figma organise les variables en collections :
- **Colors** : Palette de couleurs
- **Typography** : Polices, tailles, line-height
- **Spacing** : Marges, paddings
- **Effects** : Ombres, blur
- **Radii** : Border-radius

### Modes

Chaque collection peut avoir des modes (ex: Light/Dark) :
```
Collection: Colors
├── Mode: Light
│   ├── Primary/500: #3b82f6
│   └── Background: #ffffff
└── Mode: Dark
    ├── Primary/500: #60a5fa
    └── Background: #0f172a
```

## Mapping Colors

### Figma → CSS

| Figma Path | CSS Variable |
|------------|--------------|
| `Color/Primary/50` | `--color-primary-50` |
| `Color/Primary/500` | `--color-primary-500` |
| `Color/Primary/900` | `--color-primary-900` |
| `Color/Semantic/Success` | `--color-success` |
| `Color/Semantic/Error` | `--color-error` |
| `Color/Neutral/Background` | `--color-background` |
| `Color/Neutral/Text` | `--color-text` |

### Transformation

```javascript
function figmaColorToCSS(figmaPath, value) {
  // Color/Primary/500 → --color-primary-500
  const cssName = figmaPath
    .toLowerCase()
    .replace(/\//g, '-')
    .replace(/\s+/g, '-');
  return `--${cssName}: ${value};`;
}
```

### Output CSS

```css
:root {
  /* Primary palette */
  --color-primary-50: #eff6ff;
  --color-primary-100: #dbeafe;
  --color-primary-500: #3b82f6;
  --color-primary-900: #1e3a8a;

  /* Semantic */
  --color-success: #22c55e;
  --color-warning: #f59e0b;
  --color-error: #ef4444;
  --color-info: #3b82f6;

  /* Neutral */
  --color-background: #ffffff;
  --color-surface: #f8fafc;
  --color-text: #0f172a;
  --color-text-secondary: #64748b;
  --color-border: #e2e8f0;
}
```

## Mapping Typography

### Figma → CSS

| Figma Property | CSS Property |
|----------------|--------------|
| `fontFamily` | `font-family` |
| `fontSize` | `font-size` |
| `fontWeight` | `font-weight` |
| `lineHeight` | `line-height` |
| `letterSpacing` | `letter-spacing` |

### Figma Text Styles

```
Typography/
├── Heading/
│   ├── H1: Inter 32px/1.2 Bold
│   ├── H2: Inter 24px/1.3 Semibold
│   └── H3: Inter 20px/1.3 Semibold
├── Body/
│   ├── Regular: Inter 16px/1.5 Regular
│   └── Small: Inter 14px/1.4 Regular
└── Caption: Inter 12px/1.4 Regular
```

### Output CSS

```css
:root {
  /* Font families */
  --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  --font-mono: 'JetBrains Mono', 'Fira Code', monospace;

  /* Font sizes */
  --font-size-xs: 0.75rem;   /* 12px */
  --font-size-sm: 0.875rem;  /* 14px */
  --font-size-base: 1rem;    /* 16px */
  --font-size-lg: 1.25rem;   /* 20px */
  --font-size-xl: 1.5rem;    /* 24px */
  --font-size-2xl: 2rem;     /* 32px */

  /* Line heights */
  --line-height-tight: 1.2;
  --line-height-snug: 1.3;
  --line-height-normal: 1.5;

  /* Font weights */
  --font-weight-normal: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;
}
```

## Mapping Spacing

### Figma → CSS

| Figma Name | CSS Variable | Value |
|------------|--------------|-------|
| `Spacing/2xs` | `--space-2xs` | 2px |
| `Spacing/xs` | `--space-xs` | 4px |
| `Spacing/sm` | `--space-sm` | 8px |
| `Spacing/md` | `--space-md` | 16px |
| `Spacing/lg` | `--space-lg` | 24px |
| `Spacing/xl` | `--space-xl` | 32px |
| `Spacing/2xl` | `--space-2xl` | 48px |

### Output CSS

```css
:root {
  --space-2xs: 0.125rem;  /* 2px */
  --space-xs: 0.25rem;    /* 4px */
  --space-sm: 0.5rem;     /* 8px */
  --space-md: 1rem;       /* 16px */
  --space-lg: 1.5rem;     /* 24px */
  --space-xl: 2rem;       /* 32px */
  --space-2xl: 3rem;      /* 48px */
}
```

## Mapping Effects

### Border Radius

| Figma | CSS |
|-------|-----|
| `Radius/sm` | `--radius-sm: 4px` |
| `Radius/md` | `--radius-md: 8px` |
| `Radius/lg` | `--radius-lg: 16px` |
| `Radius/full` | `--radius-full: 9999px` |

### Shadows

| Figma | CSS |
|-------|-----|
| `Shadow/sm` | `--shadow-sm: 0 1px 2px rgba(0,0,0,0.05)` |
| `Shadow/md` | `--shadow-md: 0 4px 6px rgba(0,0,0,0.1)` |
| `Shadow/lg` | `--shadow-lg: 0 10px 15px rgba(0,0,0,0.1)` |

## Gestion des modes (Light/Dark)

### CSS avec modes

```css
/* Mode Light (default) */
:root {
  --color-background: #ffffff;
  --color-text: #0f172a;
  --color-primary: #3b82f6;
}

/* Mode Dark */
[data-theme="dark"],
.dark {
  --color-background: #0f172a;
  --color-text: #f8fafc;
  --color-primary: #60a5fa;
}

/* Ou avec prefers-color-scheme */
@media (prefers-color-scheme: dark) {
  :root {
    --color-background: #0f172a;
    --color-text: #f8fafc;
  }
}
```

### Tailwind Config

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: {
          50: 'var(--color-primary-50)',
          500: 'var(--color-primary-500)',
          900: 'var(--color-primary-900)',
        },
        background: 'var(--color-background)',
        foreground: 'var(--color-text)',
      },
      spacing: {
        '2xs': 'var(--space-2xs)',
        'xs': 'var(--space-xs)',
        'sm': 'var(--space-sm)',
        'md': 'var(--space-md)',
        'lg': 'var(--space-lg)',
        'xl': 'var(--space-xl)',
      },
    },
  },
}
```

## Template de sortie complet

```css
/* ============================================
   Design Tokens - Generated from Figma
   Source: [Figma File Name]
   Generated: YYYY-MM-DD
   ============================================ */

:root {
  /* ─── Colors ─────────────────────────────── */

  /* Primary */
  --color-primary-50: #eff6ff;
  --color-primary-100: #dbeafe;
  --color-primary-500: #3b82f6;
  --color-primary-600: #2563eb;
  --color-primary-900: #1e3a8a;

  /* Semantic */
  --color-success: #22c55e;
  --color-warning: #f59e0b;
  --color-error: #ef4444;
  --color-info: #3b82f6;

  /* Neutral */
  --color-background: #ffffff;
  --color-surface: #f8fafc;
  --color-text: #0f172a;
  --color-text-secondary: #64748b;
  --color-border: #e2e8f0;

  /* ─── Typography ─────────────────────────── */

  --font-sans: 'Inter', -apple-system, sans-serif;
  --font-mono: 'JetBrains Mono', monospace;

  --font-size-xs: 0.75rem;
  --font-size-sm: 0.875rem;
  --font-size-base: 1rem;
  --font-size-lg: 1.25rem;
  --font-size-xl: 1.5rem;
  --font-size-2xl: 2rem;

  /* ─── Spacing ────────────────────────────── */

  --space-xs: 0.25rem;
  --space-sm: 0.5rem;
  --space-md: 1rem;
  --space-lg: 1.5rem;
  --space-xl: 2rem;
  --space-2xl: 3rem;

  /* ─── Effects ────────────────────────────── */

  --radius-sm: 0.25rem;
  --radius-md: 0.5rem;
  --radius-lg: 1rem;
  --radius-full: 9999px;

  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
  --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
}
```
