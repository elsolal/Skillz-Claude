# UI Design: SaaS Dashboard

> Généré par le skill `ui-designer` (v2.6)

## Design Principles

1. **Clarity First** - L'information importante est visible immédiatement
2. **Minimal Friction** - Chaque action en minimum de clics
3. **Consistent Patterns** - Mêmes patterns partout dans l'app

## Design Tokens

### Couleurs

#### Palette principale
| Token | Valeur | Usage |
|-------|--------|-------|
| `--color-primary` | #6366F1 | CTA, liens, accents (Indigo) |
| `--color-primary-hover` | #4F46E5 | États hover |
| `--color-primary-light` | #EEF2FF | Backgrounds légers |

#### Palette sémantique
| Token | Valeur | Usage |
|-------|--------|-------|
| `--color-success` | #22C55E | Projets on-track, validations |
| `--color-warning` | #F59E0B | Projets à risque, alertes |
| `--color-error` | #EF4444 | Projets en retard, erreurs |
| `--color-info` | #3B82F6 | Informations, liens |

#### Neutres
| Token | Valeur | Usage |
|-------|--------|-------|
| `--color-gray-900` | #111827 | Texte principal |
| `--color-gray-600` | #4B5563 | Texte secondaire |
| `--color-gray-400` | #9CA3AF | Placeholders |
| `--color-gray-200` | #E5E7EB | Bordures |
| `--color-gray-50` | #F9FAFB | Backgrounds |

### Typographie

| Token | Valeur | Usage |
|-------|--------|-------|
| `--font-sans` | 'Inter', system-ui | Corps de texte |
| `--font-mono` | 'JetBrains Mono' | Code, IDs |
| `--text-xs` | 12px / 16px | Labels, captions |
| `--text-sm` | 14px / 20px | Body small, sidebar |
| `--text-base` | 16px / 24px | Body |
| `--text-lg` | 18px / 28px | Subtitles |
| `--text-xl` | 20px / 28px | Card titles |
| `--text-2xl` | 24px / 32px | Page titles |
| `--text-3xl` | 30px / 36px | Dashboard KPIs |

### Spacing

| Token | Valeur | Usage |
|-------|--------|-------|
| `--space-1` | 4px | Micro |
| `--space-2` | 8px | Tight |
| `--space-3` | 12px | Compact |
| `--space-4` | 16px | Default |
| `--space-6` | 24px | Section |
| `--space-8` | 32px | Large |

### Shadows & Radius

| Token | Valeur |
|-------|--------|
| `--shadow-sm` | 0 1px 2px rgba(0,0,0,0.05) |
| `--shadow-md` | 0 4px 6px rgba(0,0,0,0.1) |
| `--radius-md` | 8px |
| `--radius-lg` | 12px |

---

## Composants

### 1. Sidebar Navigation

```
┌──────────────┐
│ [Logo]       │  height: 64px
├──────────────┤
│ [🏠] Dashboard│  active: bg-primary-light
│ [📁] Projects │  hover: bg-gray-100
│ [👥] Team     │
│ [📊] Reports  │  item-height: 40px
│ [💳] Billing  │  padding: 12px 16px
├──────────────┤
│ [⚙️] Settings │
│ [?] Help     │
└──────────────┘
  width: 240px
```

**États:**
- Default: text-gray-600
- Hover: bg-gray-100
- Active: bg-primary-light, text-primary, font-medium

### 2. KPI Card

```
┌─────────────────────┐
│ 📁 Projets actifs   │  label: text-sm, text-gray-600
│                     │
│ 12                  │  value: text-3xl, font-bold
│ +2 ce mois          │  trend: text-sm, text-success
└─────────────────────┘
  padding: 24px
  bg: white
  shadow: sm
  radius: lg
```

### 3. Project Status Badge

| Status | Couleur | Label |
|--------|---------|-------|
| On Track | `bg-success/10 text-success` | 🟢 On track |
| At Risk | `bg-warning/10 text-warning` | 🟡 À risque |
| Delayed | `bg-error/10 text-error` | 🔴 En retard |
| Completed | `bg-gray-100 text-gray-600` | ✓ Terminé |

### 4. Task Card (Kanban)

```
┌─────────────────────┐
│ [P1] Task title     │  title: text-sm, font-medium
│                     │
│ Description...      │  desc: text-xs, text-gray-500
│                     │  truncate: 2 lines
│ [👤 Julie] [📅 Jan 25]│ meta: text-xs
└─────────────────────┘
  padding: 12px
  bg: white
  shadow: sm
  radius: md
  hover: shadow-md
```

### 5. Button

**Variants:**
| Variant | Style |
|---------|-------|
| Primary | bg-primary text-white |
| Secondary | bg-white border text-gray-700 |
| Ghost | bg-transparent text-gray-600 |
| Danger | bg-error text-white |

**Sizes:**
| Size | Height | Padding |
|------|--------|---------|
| sm | 32px | 8px 12px |
| md | 40px | 10px 16px |
| lg | 48px | 12px 24px |

### 6. Input

```
  [Label]
┌─────────────────────┐
│ Placeholder...      │  height: 40px
└─────────────────────┘  padding: 10px 12px
  [Helper or error]      border: 1px gray-200
                         focus: ring-2 primary
```

### 7. Avatar

| Size | Dimension | Font |
|------|-----------|------|
| xs | 24px | 10px |
| sm | 32px | 12px |
| md | 40px | 14px |
| lg | 56px | 18px |

**Style:** rounded-full, bg-primary-light, text-primary

### 8. Modal

```
┌─────────────────────────────────────┐
│ [Title]                         [X] │  header: p-4 border-b
├─────────────────────────────────────┤
│                                     │
│ [Content]                           │  body: p-4
│                                     │
├─────────────────────────────────────┤
│               [Cancel] [Confirm]    │  footer: p-4 border-t
└─────────────────────────────────────┘
  max-width: 500px
  radius: lg
  shadow: xl
```

### 9. Toast Notification

| Type | Icon | Color |
|------|------|-------|
| Success | ✓ | success |
| Error | ✕ | error |
| Warning | ⚠ | warning |
| Info | ℹ | info |

**Position:** top-right
**Auto-dismiss:** 5s

### 10. Empty State

```
┌─────────────────────────────────────┐
│                                     │
│           [Illustration]            │
│                                     │
│        Aucun projet trouvé          │  text-lg font-medium
│   Créez votre premier projet pour   │  text-sm text-gray-500
│   commencer à collaborer            │
│                                     │
│         [+ Créer un projet]         │  Button primary
│                                     │
└─────────────────────────────────────┘
```

### 11. Data Table

```
┌────┬──────────────┬──────────┬─────────┬────────┐
│ ☐  │ Nom          │ Status   │ Owner   │ Actions│
├────┼──────────────┼──────────┼─────────┼────────┤
│ ☐  │ Projet 1     │ 🟢 On    │ Sophie  │ [···]  │
│ ☐  │ Projet 2     │ 🟡 Risk  │ Thomas  │ [···]  │
│ ☑  │ Projet 3     │ 🔴 Late  │ Julie   │ [···]  │
├────┴──────────────┴──────────┴─────────┴────────┤
│ 3 sélectionnés           [1] [2] [3] [...] [10] │
└─────────────────────────────────────────────────┘
```

### 12. Dropdown Menu

```
┌─────────────────┐
│ [👁️] Voir       │
│ [✏️] Modifier   │
│ [📋] Dupliquer  │
├─────────────────┤
│ [🗑️] Supprimer  │  text-error
└─────────────────┘
  min-width: 160px
  shadow: lg
  radius: md
```

---

## tokens.css

```css
:root {
  /* Colors - Primary */
  --color-primary: #6366F1;
  --color-primary-hover: #4F46E5;
  --color-primary-light: #EEF2FF;

  /* Colors - Semantic */
  --color-success: #22C55E;
  --color-warning: #F59E0B;
  --color-error: #EF4444;
  --color-info: #3B82F6;

  /* Colors - Neutral */
  --color-gray-900: #111827;
  --color-gray-600: #4B5563;
  --color-gray-400: #9CA3AF;
  --color-gray-200: #E5E7EB;
  --color-gray-50: #F9FAFB;
  --color-white: #FFFFFF;

  /* Typography */
  --font-sans: 'Inter', system-ui, sans-serif;
  --font-mono: 'JetBrains Mono', monospace;

  /* Spacing */
  --space-1: 0.25rem;
  --space-2: 0.5rem;
  --space-3: 0.75rem;
  --space-4: 1rem;
  --space-6: 1.5rem;
  --space-8: 2rem;

  /* Border Radius */
  --radius-sm: 0.25rem;
  --radius-md: 0.5rem;
  --radius-lg: 0.75rem;

  /* Shadows */
  --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
  --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
  --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
  --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1);

  /* Transitions */
  --transition-fast: 150ms ease;
  --transition-base: 200ms ease;
}
```

---

## Accessibilité

- Contraste minimum : 4.5:1
- Focus ring visible : 2px solid primary
- Touch targets : 44x44px minimum
- Keyboard navigation : Tab order logique
