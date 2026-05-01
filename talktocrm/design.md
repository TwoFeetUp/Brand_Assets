# TalkToCRM Design

## Brand

Name: TalkToCRM  
Direction: Lime Jet  
Primary lockup: horizontal logo with waveform mark and `TalkToCRM` wordmark.

## Logo Files

| Use | Files |
| --- | --- |
| Primary logo on dark backgrounds | `logos/svg/logo-horizontal-dark.svg` |
| Primary logo on light backgrounds | `logos/svg/logo-horizontal-light.svg` |
| One-color logo | `logos/svg/logo-horizontal-mono-ink.svg`, `logos/svg/logo-horizontal-mono-white.svg` |
| Wordmark only | `logos/svg/wordmark-dark.svg`, `logos/svg/wordmark-light.svg` |
| Transparent mark | `logos/svg/mark-light.svg`, `logos/svg/mark-dark.svg`, `logos/png/mark-light-512.png`, `logos/png/mark-dark-512.png` |
| Outline mark | `logos/svg/mark-outline-ink.svg`, `logos/svg/mark-outline-white.svg` |
| App icon | `logos/svg/app-icon.svg`, `logos/png/app-icon-256.png`, `logos/png/app-icon-512.png`, `logos/png/app-icon-1024.png` |
| Favicon | `logos/svg/favicon.svg`, `logos/png/favicon-16.png`, `logos/png/favicon-32.png`, `logos/png/favicon-48.png`, `logos/png/favicon-64.png`, `logos/png/favicon-96.png`, `logos/png/favicon-128.png`, `logos/png/favicon-256.png`, `logos/png/favicon-512.png` |
| Web app icons | `logos/png/apple-touch-icon-180.png`, `logos/png/android-chrome-192.png`, `logos/png/android-chrome-512.png` |

The SVG logo, wordmark and mark files use transparent backgrounds unless the file is specifically an app icon. App icons are intentionally filled and include safe area.

## Colors

| Token | Hex / Value | Use |
| --- | --- | --- |
| `--ttc-ink` | `#0a0a0a` | Jet black, primary text and dark surfaces |
| `--ttc-ink-2` | `#1a1a1c` | Secondary dark text |
| `--ttc-bg-dark` | `#050505` | Deep dark page background |
| `--ttc-paper` | `#ffffff` | White surfaces and reverse logo fill |
| `--ttc-bg` | `#ededed` | Cool grey page background |
| `--ttc-lime` | `#a3d931` | Voice waveform, active state, CRM on dark |
| `--ttc-lime-deep` | `#6e9420` | CRM on light backgrounds for readability |
| `--ttc-lime-soft` | `rgba(163, 217, 49, 0.18)` | Soft lime UI background |
| `--ttc-red` | `#ff5a4f` | Signal Coral, end-call / stop / destructive UI |
| `--ttc-red-soft` | `rgba(255, 90, 79, 0.14)` | Soft critical UI background |
| `--ttc-blue` | `#007aff` | Informational UI accent |
| `--ttc-orange` | `#ff9500` | Warning UI accent |

Token files live in `tokens/brand-tokens.css` and `tokens/brand-tokens.json`.

## Typography

| Use | Font | Weights |
| --- | --- | --- |
| Primary UI, headings and wordmark | Inter | 400, 500, 600, 700, 800 |
| Editorial accent | Instrument Serif | 400 regular, 400 italic |
| Technical labels and code-like UI | IBM Plex Mono | 400, 500, 600 |

Local font files live in `fonts/`. Use `fonts/font-face.css` for standalone CSS loading.

Wordmark specification: Inter ExtraBold 800. Always write the name as `TalkToCRM`, with no spaces. On dark backgrounds, `CRM` uses Electric Lime `#a3d931`. On light backgrounds, `CRM` uses Deep Lime `#6e9420` for readability.

## Logo Dimensions

| Asset type | Native dimensions |
| --- | --- |
| Horizontal logo SVG | `1152 x 288`, viewBox `0 0 384 96` |
| Wordmark SVG | `984 x 240`, viewBox `0 0 328 80` |
| Mark SVG | `512 x 512`, viewBox `0 0 64 64` |
| App icon SVG | `1024 x 1024`, viewBox `0 0 1024 1024` |
| Favicon SVG | `64 x 64`, viewBox `0 0 64 64` |

## Suggested UI Scale

| Token | Size |
| --- | --- |
| Compact label | `12px` |
| Body text | `16px` |
| Large body | `18px` |
| Section heading | `42px` to `68px` |
| Hero heading | `56px` to `96px` |
| Small radius | `8px` |
| Standard spacing step | `8px` |

Keep UI practical and dense: quiet surfaces, clear information hierarchy, and minimal decoration.
