# TalkToCRM Brand Assets

This folder is the self-contained brand handoff for TalkToCRM.

## Contents

| Folder | Contents |
| --- | --- |
| `logos/svg/` | Primary logo, mono logo, wordmark, mark, app icon and favicon SVGs |
| `logos/png/` | Raster app icons, favicons and transparent mark exports |
| `fonts/` | Local font files, `font-face.css`, source Google Fonts CSS and OFL license files |
| `tokens/` | Brand color and typography tokens in CSS and JSON |
| `design.md` | Practical brand specs: fonts, colors, logo sizes, favicon sizes and usage |

## Typography

| Use | Font | Weights |
| --- | --- | --- |
| Primary UI and wordmark | Inter | 400, 500, 600, 700, 800 |
| Editorial accent | Instrument Serif | 400 regular, 400 italic |
| Technical labels and code-like UI | IBM Plex Mono | 400, 500, 600 |

The wordmark SVGs use live text with `Inter` as the intended font. For final legal, print or agency distribution, create outlined SVG/PDF versions from the same geometry in Figma or Illustrator so the wordmark is not font-dependent.

## Colors

| Token | Value | Role |
| --- | --- | --- |
| `--ttc-ink` | `#0a0a0a` | Jet black, primary text and dark surfaces |
| `--ttc-paper` | `#ffffff` | White surfaces and reverse logo fill |
| `--ttc-bg` | `#ededed` | Cool grey page background |
| `--ttc-lime` | `#a3d931` | Voice waveform, active state, CRM on dark |
| `--ttc-lime-deep` | `#6e9420` | CRM on light backgrounds for readability |
| `--ttc-red` | `#ff5a4f` | Signal Coral, end-call / stop / destructive UI |

## Usage Notes

- Use `logos/svg/logo-horizontal-dark.svg` on dark or jet backgrounds.
- Use `logos/svg/logo-horizontal-light.svg` on white or light grey backgrounds.
- Use the mono SVGs when only one color is allowed.
- Use `logos/svg/app-icon.svg` for platform/app icon contexts.
- Use `logos/svg/favicon.svg` for browser favicon contexts.
- Use the PNG exports for app icons, favicons and transparent mark contexts where SVG is not accepted.
- Import `fonts/font-face.css` when a standalone environment needs local font loading.
