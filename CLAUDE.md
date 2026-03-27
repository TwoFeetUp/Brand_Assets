# Brand Assets — TwoFeetUp

## Doel van deze repo

Centrale mediabibliotheek voor alle TwoFeetUp brand assets: logo's, medewerkersfoto's, evenementfoto's, video's en meer. Wordt gebruikt door Stella Story en andere AI-agents via manifest.json.

## Regels voor bestanden

### Naamgeving (afgesproken met Lex Zwakenberg)
- Bestandsnamen moeten **beschrijvend en leesbaar zijn voor AI** — geen cameranamen zoals `IMG_3499.jpg`
- Gebruik `snake_case`, max 5 woorden
- Voorbeelden: `hackathon_team_brainstorm.webp`, `workshop_live_demo_laptop.webp`, `keynote_spreker_groot_publiek.webp`

### Mappenstructuur
- `raw/{event}/` — onbewerkte foto's, JPEG, rechtstreeks van Google Drive
- `edited/{event}/` — goedgekeurde foto's na review, WebP, metadata gestript
- `images/employees/` — profielfoto's TwoFeetUp-medewerkers
- `images/external/` — foto's van externe mensen (geen TwoFeetUp-medewerkers)
- `images/digital employees/` — AI-agent avatars
- `images/office/` — kantoorlocatie foto's
- `images/media/` — persberichten, media-optredens, tegeltjes
- `images/partner companies/` — partnerlogo's
- `images/hackathon/` — hackathonfoto's (legacy, nieuwe uploads via `raw/` of `edited/`)

### Externe mensen
- Foto's van mensen buiten TwoFeetUp gaan naar `images/external/`
- Naamconventie: `external_[Naam]_[Organisatie].jpg`
- Voorbeeld: `external_Anna_Bakker_Accenture.jpg`

## manifest.json — altijd bijwerken

**Elke upload moet een entry krijgen in manifest.json.** Dit is een harde afspraak.

- Secties: `employees`, `digitalEmployees`, `partners`, `office`, `media`, `hackathon`, `raw`, `edited`, `external`
- Elke entry bevat minimaal: `path`, `name`, `description`
- Bij geautomatiseerde uploads ook: `uploadedAt`
- `lastUpdated` bijwerken bij elke wijziging

## Branch-strategie

- Werk op `jay/foto-upload` — niet direct op `main`
- Na review: PR aanmaken → merge naar main
- De foto-uploader tool (in `tools/foto-uploader/`) pusht automatisch naar de ingestelde branch via `GITHUB_BRANCH` in `.env`

## Metadata

- Alle `edited/` en `external/` bestanden zijn WebP met gestripte EXIF/XMP/C2PA-metadata
- `raw/` bestanden zijn JPEG (originele camerabestanden, licht gecomprimeerd)
