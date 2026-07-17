# Brand Assets — TwoFeetUp

## ⚠️ Public repo — alle bestanden staan online

Dit is een **publieke** repository. Alle bestanden zijn direct zichtbaar en downloadbaar op het internet via GitHub Pages.

**Waarschuwing voor uploaders (mens en AI-agent):**
- Upload **alleen goedgekeurde content** — alles wat je commit is onmiddellijk publiek
- **Geen** ongecensureerde, vertrouwelijke of privé-informatie uploaden
- **Geen** foto's zonder toestemming van afgebeelde personen
- **Geen** interne documenten, concepten of werk-in-uitvoering
- **Geen** bestanden met gevoelige metadata (EXIF met locatie, cameragegevens, etc.)
- Bij twijfel: **niet uploaden** — vraag eerst goedkeuring

## Media-instroom: Drive eerst, deze repo daarna

TwoFeetUp media start **altijd** op Google Drive en komt pas hierheen na curatie. Sorteer op **status**, niet op bestandstype.

- **Ruw / onbewerkt / intern / ongereviewd** → Google Drive **Raw footage inbox**: https://drive.google.com/drive/folders/1XJKnZS0_l7f1YKtz5s8tH-kmgMTe9JNZ
  - Volledige event-dumps, foto/video rechtstreeks van toestel, opnames van shows/podcasts. Per event een map met conventie `YYMMDD Event Naam` (bijv. `Teamuitjes/260421 Ribhouse Texas` — workations horen onder `Teamuitjes/`). Privé, niet publiek.
- **Goedgekeurd / public-safe / herbruikbaar** → deze repo. Pas opnemen na: review + goedkeuring, consent van afgebeelde personen, EXIF/metadata gestript, en bedoeld voor hergebruik.

Flow: `Drive Raw footage inbox/{event}` → curated selectie → `raw/{event}/` (JPEG) → review → `edited/{event}/` (WebP, gestript) → `manifest.json`-entry.

Curatie gebeurt **vóór** upload: deze repo is publiek, dus "achteraf opschonen" is te laat. Dump nooit een volledige ruwe set hierheen.

## Doel van deze repo

Centrale mediabibliotheek voor alle TwoFeetUp brand assets: logo's, medewerkersfoto's, evenementfoto's, video's en meer. Wordt gebruikt door Stella Story en andere AI-agents via manifest.json.

## manifest.json is de bron van waarheid

De `manifest.json` is het centrale register voor **alle** brand assets. Het wordt geconsumeerd door:
- De **huisstijl-skill** in `TwoFeetUp/claudecode-plugins` (de Brandon skill)
- AI-agents (Stella Story, etc.)
- Elke toekomstige tool of service die TwoFeetUp assets nodig heeft

### Wat manifest.json bevat
- **`baseUrl`** — de GitHub Pages CDN root: `https://twofeetup.github.io/Brand_Assets`
- **`colors`** — de volledige TwoFeetUp kleurenpalet (primary, secondary, accent, violet, etc.)
- **`fonts`** — Nunito met weights 300, 400, 700 en Google Fonts source URL
- **`logos`** — alle logo- en beeldmerkvariaties met pad, afmetingen, en usage
- **`products`** — product/sub-brand registraties, zoals TalkToCRM, met eigen manifest
- **`imageDump`** — pointer-entry naar `image_dump/index.json` voor one-off shareable images. Inhoud staat **niet** hier; consumers fetchen de aparte index on-demand. Zie [image_dump — uitzondering op de manifest-regel](#image_dump--uitzondering-op-de-manifest-regel).
- **`videoDump`** — pointer-entry naar `video_dump/index.json` voor one-off shareable video's (MP4-only, max 100MB per file). Zelfde patroon als `imageDump`. Zie [video_dump — uitzondering op de manifest-regel](#video_dump--uitzondering-op-de-manifest-regel).
- **`images`** — alle afbeeldingscategorieën (employees, digitalEmployees, partners, office, media, hackathon, previews, raw, edited, external)
- **`videos`** — video assets met afmetingen en duur

### Regels voor manifest.json
- **Elke upload moet een entry krijgen in manifest.json** — dit is een harde afspraak. **Uitzonderingen:** bestanden onder `image_dump/` en `video_dump/` (zie secties hieronder).
- **`lastUpdated` bijwerken bij elke wijziging**
- Secties: `employees`, `digitalEmployees`, `partners`, `office`, `media`, `hackathon`, `previews`, `raw`, `edited`, `external`
- Elke entry bevat minimaal: `path`, `name`, `description`
- Employees bevatten ook: `role`, `description`, `status` (`"active"`, `"temporarily_inactive"` of `"archived"`)
- `"archived"` = uit dienst of uitgefaseerd; bestand verhuist naar de `_archive/` submap van zijn categorie, entry blijft staan (record) maar consumers verbergen het. Geldt ook voor `digitalEmployees`.
- Bij geautomatiseerde uploads ook: `uploadedAt`

### Regels voor kleuren en fonts
- De `colors` sectie in manifest.json en `colors.json` moeten **exact dezelfde waarden** bevatten
- Wijzig kleuren NOOIT zonder ook de `colors.json` bij te werken (en vice versa)
- De huisstijl-skill in claudecode-plugins vertrouwt op deze waarden — als ze afwijken ontstaat inconsistente branding
- De actuele kleurwaarden:
  - Primary: `#414099` (TwoFeetUp Purple)
  - Secondary: `#8ed8f8` (TwoFeetUp Blue)
  - Accent: `#faa61a` (TwoFeetUp Orange)
  - Text: `#050034` (TwoFeetUp Black — NOOIT #000000)
  - Grey: `#f1f2f2`
- Font is **Nunito** (weights 300, 400, 700) — nooit Inter, Roboto, of system fonts

### baseUrl
De `baseUrl` in manifest.json MOET `https://twofeetup.github.io/Brand_Assets` zijn (hoofdlettergevoelig, matcht de GitHub repo naam). Consumers bouwen asset URLs als `{baseUrl}{path}`.

## colors.json

Gedetailleerde kleurenpalet met hex, rgb, hsl per kleur plus:
- `usage` — welke kleur waarvoor (buttons, links, headings, backgrounds)
- `gradients` — Ascent gradient (primary -> secondary) en dark mode gradient
- `contrast` — waarschuwingen over oranje op lichte achtergronden (WCAG FAIL)

**colors.json en manifest.json colors moeten altijd synchroon zijn.**

## Regels voor bestanden

### Naamgeving (afgesproken met Lex Zwakenberg)
- Bestandsnamen moeten **beschrijvend en leesbaar zijn voor AI** — geen cameranamen zoals `IMG_3499.jpg`
- Gebruik `snake_case`, max 5 woorden
- Voorbeelden: `hackathon_team_brainstorm.webp`, `workshop_live_demo_laptop.webp`, `keynote_spreker_groot_publiek.webp`

### Mappenstructuur
- `logos/` — alle logo- en beeldmerkvariaties
- `talktocrm/` — TalkToCRM product/sub-brand assets met eigen `manifest.json`
- `images/employees/` — profielfoto's TwoFeetUp-medewerkers (500x500px PNG, canonieke oranje-ring transparante stijl — zie `docs/avatar-processing.md`)
- `images/employees/_archive/` — profielfoto's van vertrokken medewerkers/gasten (`status: "archived"`)
- `images/digital employees/` — AI-agent avatars (let op: directory bevat spaties)
- `images/digital employees/_archive/` — uitgefaseerde AI-avatars (`status: "archived"`)
- `images/office/` — kantoorlocatie foto's
- `images/media/` — persberichten, media-optredens, workshopfoto's, tegeltjes
- `images/partner companies/` — partnerlogo's (let op: directory bevat spaties)
- `images/hackathon/` — hackathonfoto's (legacy, nieuwe uploads via `raw/` of `edited/`)
- `images/previews/` — OG/social preview images voor tools en applicaties
- `images/external/` — foto's van externe mensen (geen TwoFeetUp-medewerkers)
- `raw/{event}/` — onbewerkte foto's, JPEG, rechtstreeks van Google Drive
- `edited/{event}/` — goedgekeurde foto's na review, WebP, metadata gestript
- `videos/` — video assets
- `image_dump/{onderwerp-of-klant-of-datum}/` — one-off shareables, **uitgesloten van manifest.json**, geïndexeerd via auto-gegenereerde `image_dump/index.json`. Zie sectie hieronder.
- `video_dump/{onderwerp-of-klant-of-datum}/` — one-off shareable video's (MP4-only, max 100MB), **uitgesloten van manifest.json**, geïndexeerd via auto-gegenereerde `video_dump/index.json`. Zie sectie hieronder.

### Spaties in directory- en bestandsnamen
Sommige directories en bestanden bevatten **letterlijke spaties** (bijv. `digital employees/`, `AI colleague Alex.png`). Dit is de bestaande conventie. Consumers moeten `%20` URL-encoding gebruiken bij het bouwen van URLs.

### Employee avatars (canonieke stijl)
Employee-profielfoto's volgen één vaste stijl: 500x500 PNG, vrijgesteld onderwerp op
transparante achtergrond, binnen de oranje TwoFeetUp-ring (`#faa61a`, buitenstraal 200px,
binnenstraal 189px). Genereer ze reproduceerbaar met `scripts/process_avatar.py` (rembg +
ring-overlay); volledige onboarding/offboarding-procedure in `docs/avatar-processing.md`.
Nooit met de hand een witte achtergrond of losse ring inbakken.

### Externe mensen
- Foto's van mensen buiten TwoFeetUp gaan naar `images/external/`
- Naamconventie: `external_[Naam]_[Organisatie].jpg`
- Voorbeeld: `external_Anna_Bakker_Accenture.jpg`

## image_dump — uitzondering op de manifest-regel

`image_dump/` is bedoeld voor **one-off shareable images** die je publiekelijk wilt kunnen delen via de GitHub Pages CDN, maar die je niet hergebruikt — screenshots voor één klant, tegeltjes voor één social post, quick-shares die nooit terugkomen in branding-output. Deze map kan makkelijk 100+ bestanden bevatten.

### Waarom een aparte regel

Als deze 100+ entries in `manifest.json` zouden staan, zou elke fetch door een consuming agent (Brandon, Stella) onnodig veel context verbruiken voor data die in 99% van de gevallen niet relevant is. Daarom is `image_dump/` bewust **uitgezonderd** van de "elke upload = manifest entry"-regel. `video_dump/` volgt hetzelfde patroon (zie volgende sectie); buiten die twee zijn er geen uitzonderingen.

### Hoe het werkt

1. **Upload** — plaats bestanden in een sub-map per onderwerp/klant/datum, bijv. `image_dump/achmea-2026-q2/screenshot_dashboard.png`. Sub-map structuur is conventie, geen hard-enforced regel.
2. **Index** — bij commit regenereert de pre-commit hook automatisch `image_dump/index.json` met een platte lijst `{ path, name }` per file. Mens raakt dit bestand niet aan.
3. **Pointer in main manifest** — `manifest.json.imageDump` bevat één entry met `path`, `indexUrl`, `description`. Geen per-file entries.
4. **Discovery door agents (twee-staps fetch)** — een consuming agent fetcht zoals altijd `manifest.json`. Wanneer hij iets uit `image_dump/` nodig heeft, fetcht hij `imageDump.indexUrl` apart op om de volledige bestandenlijst te krijgen. Default zien agents de 100+ entries dus nooit.

### Regels voor `image_dump/`

- Naamgeving: dezelfde regels als de rest (snake_case, max 5 woorden, geen camera-namen).
- Format: PNG, JPG, of WebP — alle drie toegestaan. WebP-only en EXIF-strip-eisen van `edited/` gelden hier **niet**.
- Public-warning blijft 100% van toepassing: alles in `image_dump/` is publiek zodra het gepushed is.
- `image_dump/index.json` **niet handmatig bewerken** — wordt door de hook geregenereerd op elke commit met image_dump-wijzigingen.

### Wat de hook automatisch doet

- Bij staged toevoegingen, wijzigingen of verwijderingen onder `image_dump/`: regenereert `image_dump/index.json` op basis van `git ls-files --cached image_dump/` en stage't het bijgewerkte bestand.
- Slaat de `MANIFEST_NOT_UPDATED` check over voor bestanden onder `image_dump/` — een commit met alleen image_dump-toevoegingen blokkeert dus niet op het ontbreken van een main-manifest update.

## video_dump — uitzondering op de manifest-regel

`video_dump/` is bedoeld voor **one-off shareable video's** die je publiek wilt kunnen delen via de GitHub Pages CDN (typisch: embedden in een view.twofeetup.com pagina), maar die je niet hergebruikt — demo-loops voor één klant, screencasts bij een uitleg, korte social-clips voor één campagne. Zelfde redenering als `image_dump/`: bewust **uitgezonderd** van de "elke upload = manifest entry"-regel om context-bloat te voorkomen.

Voor herbruikbare brand-video's blijft `videos/` (mét manifest-entry inclusief afmetingen en duur) de juiste plek.

### Hoe het werkt

1. **Upload** — plaats bestanden in een sub-map per onderwerp/klant/datum, bijv. `video_dump/achmea-2026-q2/demo_dashboard_walkthrough.mp4`.
2. **Index** — bij commit regenereert de pre-commit hook automatisch `video_dump/index.json` met dezelfde `{ path, name }` shape als `image_dump/`. Mens raakt dit bestand niet aan.
3. **Pointer in main manifest** — `manifest.json.videoDump` bevat één entry met `path`, `indexUrl`, `description`. Geen per-file entries.
4. **Discovery door agents** — twee-staps fetch: `manifest.json` zien ze altijd, `videoDump.indexUrl` halen ze pas op zodra ze iets uit `video_dump/` nodig hebben.

### Harde regels voor `video_dump/` (afgedwongen door pre-commit hook)

- **MP4-only.** Alleen `.mp4` (H.264 + AAC) — `.mov`, `.webm`, `.avi`, `.mkv`, `.m4v` worden geblokkeerd. Reden: alleen MP4 speelt betrouwbaar inline in alle browsers (vooral Safari/iOS). Convert: `ffmpeg -i input.mov -c:v libx264 -pix_fmt yuv420p -movflags +faststart -c:a aac -b:a 128k output.mp4`.
- **Max 100MB per bestand.** GitHub blokkeert grotere files hard. Te lang? Trim of comprimeer met ffmpeg, of host op YouTube/Vimeo en embed dáár vanaf in plaats van het bestand zelf.
- **Naamgeving** — snake_case, min. 2 woorden, geen camera-namen (`IMG_*`, `MOV_*`, etc.).
- **Public-warning** blijft 100% van toepassing.
- **`video_dump/index.json` niet handmatig bewerken** — wordt door de hook geregenereerd.

### Wat de hook automatisch doet

- Bij staged wijzigingen onder `video_dump/`: regenereert `video_dump/index.json` op basis van `git ls-files --cached video_dump/` en stage't het bijgewerkte bestand.
- Slaat de `MANIFEST_NOT_UPDATED` check over voor bestanden onder `video_dump/`.
- Blokkeert non-MP4 video's, files >100MB, en niet-snake_case / camera-namen met een duidelijke fix-instructie.

### Embedden in view.twofeetup.com

```html
<video
  src="https://twofeetup.github.io/Brand_Assets/video_dump/achmea-2026-q2/demo_dashboard_walkthrough.mp4"
  controls
  playsinline
  style="max-width: 100%; height: auto;"
></video>
```

## Pre-commit hook — automatische validatie

De repo bevat een pre-commit hook die commits blokkeert die de regels overtreden.

**Eenmalig activeren (per machine/clone):**
```bash
git config core.hooksPath .githooks
```

De hook controleert automatisch:
- manifest.json bijgewerkt als er nieuwe mediabestanden worden toegevoegd (uitgezonderd: `image_dump/` en `video_dump/`)
- `edited/` bestanden: snake_case naam (min. 2 woorden), geen cameranamen, alleen .webp
- `images/external/` bestanden: naam begint met `external_[Naam]_[Organisatie]`
- `raw/` bestanden: geen UUID-namen
- `video_dump/` bestanden: alleen `.mp4`, max 100MB, snake_case naam, geen cameranamen

Daarnaast doet de hook automatisch:
- Bij wijzigingen onder `image_dump/`: regenereert `image_dump/index.json` en stage't het mee in de commit. Zie [image_dump — uitzondering op de manifest-regel](#image_dump--uitzondering-op-de-manifest-regel).
- Bij wijzigingen onder `video_dump/`: regenereert `video_dump/index.json` en stage't het mee in de commit. Zie [video_dump — uitzondering op de manifest-regel](#video_dump--uitzondering-op-de-manifest-regel).

Bij overtreding: commit geblokkeerd met duidelijke foutmelding + fix-instructie.

## Sync met huisstijl-skill (Brandon)

De **huisstijl-skill** (Brandon) in `TwoFeetUp/claudecode-plugins` is de primaire consumer van deze repo. De skill fetcht `manifest.json` via WebFetch als bron van waarheid voor alle assets.

### Hardcoded logo bestandsnamen — NIET HERNOEMEN

De skill bevat hardcoded fallback URLs voor deze 9 logo-bestanden. **Hernoem deze bestanden nooit** zonder ook de skill bij te werken (SKILL.md, template.html, componenten.md):

```
logos/TwoFeetUp_Full_Logo_for_bright_backgrounds.png
logos/TwoFeetUp_Full_Logo_Diapositief_for_Dark_backgrounds.png
logos/TwoFeetUp_Full_Logo_Diapositief_Wit_For_dark_background.png
logos/TwoFeetUp_Beeldmerk.svg
logos/TwoFeetUp_Beeldmerk_for_bright_background.png
logos/TwoFeetUp_Beeldmerk_Diapositief_for_dark_brackground.png  ← "brackground" typo is bewust, matcht bestandsnaam
logos/TwoFeetUp_Beeldmerk_Ascent_with_gradient_background.png
logos/TwoFeetUp_Beeldmerk_Licht_with_white_background.png
logos/TwoFeetUp_Beeldmerk_Donker_with_dark_purple_background.png
```

### Verplichte metadata per manifest-categorie

De skill verwacht deze velden per entry. Ontbrekende velden = degraded output.

| Categorie | Verplichte velden |
|-----------|-------------------|
| `logos.*` | `path`, `width`, `height`, `usage` |
| `images.employees[]` | `path`, `name`, `role`, `description`, `status`, `width`, `height` |
| `images.digitalEmployees[]` | `path`, `name`, `description`, `width`, `height` |
| `images.partners[]` | `path`, `name`, `description` |
| `images.office[]` | `path`, `name`, `description` |
| `images.media[]` | `path`, `name`, `description` |
| `images.hackathon[]` | `path`, `width`, `height`, `description` |
| `videos[]` | `path`, `width`, `height`, `duration`, `description` |

### Change impact — wanneer moet de skill ook bijgewerkt worden?

| Wijziging in Brand_Assets | Skill update nodig? | Wat bijwerken in skill |
|---------------------------|---------------------|----------------------|
| Asset toevoegen/verwijderen in bestaande categorie | **Nee** | Manifest-driven |
| Employee status wijzigen | **Nee** | Skill filtert op `status` |
| Nieuwe employee met alle metadata | **Nee** | Manifest-driven |
| **Logo bestand hernoemen** | **Ja** | Alle hardcoded fallback URLs in SKILL.md, template.html, componenten.md |
| **Nieuw asset-categorie toevoegen** (nieuwe key onder `images`) | **Ja** | Toevoegen aan SKILL.md "Manifest asset categorieën" |
| **Kleur hex waarde wijzigen** | **Ja** | design-tokens.md, template.html Tailwind config, componenten.md, reveal-theme-twofeetup.css, SKILL.md Quick Reference |
| **Font wijzigen** | **Ja** | design-tokens.md, template.html, reveal-template.html, reveal-theme-twofeetup.css, componenten.md |
| **CDN/hosting URL wijzigen** | **Ja** | Elke hardcoded URL in SKILL.md, template.html, componenten.md |
| Metadata veld toevoegen aan bestaande categorie | **Nee** | Skill negeert onbekende velden |
| Metadata veld verwijderen dat skill verwacht | **Mogelijk** | Output degradeert (bijv. geen role = geen role getoond) |

### Kleur-sync: drie bronnen synchroon houden

Bij kleurwijzigingen moeten deze drie synchroon zijn:
1. `Brand_Assets/manifest.json` → `colors` object
2. `Brand_Assets/colors.json` → `palette` object
3. Huisstijl-skill → `design-tokens.md`, `template.html`, `componenten.md`, `reveal-theme-twofeetup.css`, `SKILL.md`

### Pad-conventies die de skill verwacht

- **Spaties in paden** — directories en bestanden gebruiken letterlijke spaties (bijv. `/images/digital employees/`). De skill URL-encodeert met `%20`. Wissel NIET naar underscores of dashes.
- **Typos in bestandsnamen** (bijv. "brackground") zijn bevroren — "fixen" breekt de skill fallback URLs.
- **Case-sensitive** — GitHub Pages is hoofdlettergevoelig. `Lex.png` ≠ `lex.png`.

## Branch-strategie

- Werk op `jay/foto-upload` — niet direct op `main`
- Na review: PR aanmaken -> merge naar main
- De foto-uploader tool (in `tools/foto-uploader/`) pusht automatisch naar de ingestelde branch via `GITHUB_BRANCH` in `.env`

## Metadata

- Alle `edited/` en `external/` bestanden zijn WebP met gestripte EXIF/XMP/C2PA-metadata
- `raw/` bestanden zijn JPEG (originele camerabestanden, licht gecomprimeerd)
