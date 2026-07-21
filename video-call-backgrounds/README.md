# Video Call Backgrounds

TwoFeetUp-branded backgrounds voor Google Meet, Microsoft Teams en Zoom (image slot). 1920×1080 (16:9) PNG, ≤16 MB.

Drie diverging visual varianten met identieke logo + slogan placement:

| File | Variant | Vibe |
|---|---|---|
| `ambient.png` | Ascent gradient (paars → blauw) met soft drifting orbs en diagonaal beeldmerk-tile patroon | Warm, atmospheric |
| `studio.png` | Donkere editorial backdrop met oversized TFU beeldmerk-vorm aan de linker zijde | Magazine / podcast-studio |
| `studio.gif` | Geanimeerde versie van `studio.png` — beeldmerk drift heel langzaam in elliptische baan, 10s loop, 1280×720, 15fps | Animated background voor decks, social, embeds |
| `mono.png` | Bijna-zwart met subtiele paars/blauw spotlight glows | Ultra-minimal, executive |

Zes cinematische varianten (AI-gegenereerd, logo + tekst los overheen gecompositeerd, top-left only — geen TalkToCRM):

| File | Variant | Vibe |
|---|---|---|
| `brain-network.png` | Circuit-brein linksboven, tagline "Your agents need a brain." | Flat vector, techy |
| `brain-hub.png` | Gloeiende oranje brein-hub met orbiterende agent-nodes, tagline in onderbalk | Flat vector, warm |
| `ecosystem-quiet.png` | Subtiel spinnenweb/sterrenbeeld, geen tekst | Flat vector, rustig |
| `aurora-brain.png` | Volumetrische aurora-linten die samentrekken tot een breinvormige lichtwolk, dun oranje lichtdraadje, tagline "Your agents need a *brain*." | Cinematisch, atmospheric |
| `glass-mind.png` | Fotorealistisch sculptuur van een brein in vloeibaar glas/chroom, warm tegen koel licht, scherptediepte | Cinematisch, premium |
| `quiet-ascent.png` | Grote mesh-gradient met filmkorrel, nauwelijks zichtbare "traptrede"-vorm (logo-metafoor), slogan "We spark the sense of *wonder*" | Cinematisch, executive |

`brain-network`/`brain-hub`/`ecosystem-quiet` zijn de eerste (platte) iteratie; `aurora-brain`/`glass-mind`/`quiet-ascent` de cinematische herwerking op basis van de eigen OG-beeldstijl van twofeetup.com. `glass-mind.png` is de sterkste van de zes.

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

`ambient.png` / `studio.png` / `studio.gif` / `mono.png`: gegenereerd via Remotion in `remotion-podcast/src/templates/video-call-background/`. Voor de animated MP4-varianten of portrait 9:16 outputs: regenereer in die repo met `npm run vcb:render -- --variant=<ambient|studio|mono>`.

`brain-network.png` / `brain-hub.png` / `ecosystem-quiet.png` / `aurora-brain.png` / `glass-mind.png` / `quiet-ascent.png`: AI-gegenereerd via Gemini (`gemini-3-pro-image`, 2K), logo nadien los gecompositeerd met PIL. Geen Remotion-source, dus niet regenereerbaar via `vcb:render`.
