# Video Call Backgrounds

TwoFeetUp-branded backgrounds voor Google Meet, Microsoft Teams en Zoom (image slot). 1920×1080 (16:9) PNG, ≤16 MB.

Drie diverging visual varianten met identieke logo + slogan placement:

| File | Variant | Vibe |
|---|---|---|
| `ambient.png` | Ascent gradient (paars → blauw) met soft drifting orbs en diagonaal beeldmerk-tile patroon | Warm, atmospheric |
| `studio.png` | Donkere editorial backdrop met oversized TFU beeldmerk-vorm aan de linker zijde | Magazine / podcast-studio |
| `mono.png` | Bijna-zwart met subtiele paars/blauw spotlight glows | Ultra-minimal, executive |

## Design rules

- **Center is dead zone**: het midden van een call-tile is waar de spreker staat — branding zit daarom uitsluitend in de hoeken (landscape)
- **Top-left**: TFU full-logo wit (primair) + slogan `We spark the sense of wonder` (wonder in TFU-oranje)
- **Top-right**: TalkToCRM horizontal logo white+lime variant (secundair) + slogan `You Talk, Timmy Logs`
- **Beide logos**: identieke pixel-hoogte zodat ze visueel op één lijn staan

## Upload-instructies

- **Google Meet**: Effects → Backgrounds → `+` → selecteer PNG
- **Microsoft Teams**: Background settings → Add new
- **Zoom**: Settings → Backgrounds & Filters → `+`

## Bron

Gegenereerd via Remotion in `remotion-podcast/src/templates/video-call-background/`. Voor de animated MP4-varianten of portrait 9:16 outputs: regenereer in die repo met `npm run vcb:render -- --variant=<ambient|studio|mono>`.
