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
- **`images`** — alle afbeeldingscategorieën (employees, digitalEmployees, partners, office, media, hackathon, previews, raw, edited, external)
- **`videos`** — video assets met afmetingen en duur

### Regels voor manifest.json
- **Elke upload moet een entry krijgen in manifest.json** — dit is een harde afspraak
- **`lastUpdated` bijwerken bij elke wijziging**
- Secties: `employees`, `digitalEmployees`, `partners`, `office`, `media`, `hackathon`, `previews`, `raw`, `edited`, `external`
- Elke entry bevat minimaal: `path`, `name`, `description`
- Employees bevatten ook: `role`, `description`, `status` (`"active"` of `"temporarily_inactive"`)
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
- `images/employees/` — profielfoto's TwoFeetUp-medewerkers (500x500px PNG)
- `images/digital employees/` — AI-agent avatars (let op: directory bevat spaties)
- `images/office/` — kantoorlocatie foto's
- `images/media/` — persberichten, media-optredens, tegeltjes
- `images/partner companies/` — partnerlogo's (let op: directory bevat spaties)
- `images/hackathon/` — hackathonfoto's (legacy, nieuwe uploads via `raw/` of `edited/`)
- `images/previews/` — OG/social preview images voor tools en applicaties
- `images/external/` — foto's van externe mensen (geen TwoFeetUp-medewerkers)
- `raw/{event}/` — onbewerkte foto's, JPEG, rechtstreeks van Google Drive
- `edited/{event}/` — goedgekeurde foto's na review, WebP, metadata gestript
- `videos/` — video assets

### Spaties in directory- en bestandsnamen
Sommige directories en bestanden bevatten **letterlijke spaties** (bijv. `digital employees/`, `AI colleague Alex.png`). Dit is de bestaande conventie. Consumers moeten `%20` URL-encoding gebruiken bij het bouwen van URLs.

### Externe mensen
- Foto's van mensen buiten TwoFeetUp gaan naar `images/external/`
- Naamconventie: `external_[Naam]_[Organisatie].jpg`
- Voorbeeld: `external_Anna_Bakker_Accenture.jpg`

## Pre-commit hook — automatische validatie

De repo bevat een pre-commit hook die commits blokkeert die de regels overtreden.

**Eenmalig activeren (per machine/clone):**
```bash
git config core.hooksPath .githooks
```

De hook controleert automatisch:
- manifest.json bijgewerkt als er nieuwe mediabestanden worden toegevoegd
- `edited/` bestanden: snake_case naam (min. 2 woorden), geen cameranamen, alleen .webp
- `images/external/` bestanden: naam begint met `external_[Naam]_[Organisatie]`
- `raw/` bestanden: geen UUID-namen

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
