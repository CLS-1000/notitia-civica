# Notitia Civica — Design System

`notitia/notitia.css` is the shared design system file for all Notitia Civica web templates. It defines every `--nc-*` CSS custom property (design token), base typographic defaults, and a Google Fonts import.

## Usage

Add this single `<link>` to any Notitia Civica template `<head>`:

```html
<!-- From a root-level file: -->
<link rel="stylesheet" href="notitia/notitia.css">

<!-- From templates/web/: -->
<link rel="stylesheet" href="../../notitia/notitia.css">

<!-- From templates/print/: -->
<link rel="stylesheet" href="../../notitia/notitia.css">
```

Then add `class="nc"` to `<body>` to activate base styles.

## Design Tokens

### Warm Neutrals (base palette)

| Token | Value | Role |
|---|---|---|
| `--nc-plaster` | `#F7F4EE` | Page ground (background) |
| `--nc-bone` | `#EFEAE0` | Panels, alternate sections |
| `--nc-oat` | `#E2DACA` | Deeper field, table stripes |
| `--nc-ink` | `#26241F` | Primary text (charcoal) |
| `--nc-ink-2` | `#555147` | Secondary text |
| `--nc-ink-3` | `#8B8578` | Metadata, captions |
| `--nc-line` | `#C9C1B1` | Hairline rules |
| `--nc-line-dark` | `#26241F` | Structural rules |

### Series Accents

Each editorial series has one saturated accent color used for kickers, labels, and decorative rules. Set `--nc-accent` in the page-level `<body>` style.

| Token | Value | Series |
|---|---|---|
| `--nc-sienna` | `#B4552D` | World State Brief — geopolitical gravity |
| `--nc-ochre` | `#C79A2E` | Narrative Operations — unease |
| `--nc-teal` | `#3E7C74` | Civic Intelligence Brief — civic clarity |
| `--nc-olive` | `#6E7040` | Economic / Financial — measured, material |
| `--nc-navy` | `#3A4A5E` | Congressional — institutional weight |
| `--nc-verm` | `#D6482B` | SWITCHBOARD tick — engine mark only |
| `--nc-accent` | *(per-page)* | Override with a series hue in `body { }` |

### Typography

| Token | Value | Role |
|---|---|---|
| `--nc-serif` | `'Newsreader', 'Times New Roman', serif` | Body copy, headlines |
| `--nc-sans` | `'Archivo', 'Helvetica Neue', sans-serif` | Labels, UI, metadata |
| `--nc-mono` | `'IBM Plex Mono', monospace` | Data, run IDs, technical values |

### Layout

| Token | Value | Role |
|---|---|---|
| `--nc-measure` | `64ch` | Maximum line length for readable columns |

## Fonts

Loaded via Google Fonts: **Newsreader** (optical-size serif), **Archivo** (variable grotesque), **IBM Plex Mono**.

Templates that need offline or print-safe rendering should embed the fonts directly or use system fallbacks.
