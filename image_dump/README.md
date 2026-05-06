# image_dump/

One-off shareable images. **Uitgesloten van `manifest.json`** om context-bloat te voorkomen voor consuming agents.

## Wanneer gebruiken

Voor afbeeldingen die je publiek wilt kunnen delen via de GitHub Pages CDN, maar die je niet hergebruikt — bijvoorbeeld:

- Screenshots voor een specifieke klant
- Tegeltjes voor één social post
- Quick-shares die nooit terugkomen in branding-output

Voor herbruikbare assets (logos, employee photos, partners, frameworks, etc.) blijft `manifest.json` de juiste plek.

## Structuur

Plaats bestanden in **sub-mappen per onderwerp, klant of datum**:

```
image_dump/
  achmea-2026-q2/
    screenshot_inlogscherm.png
    screenshot_dashboard.png
  social-shares/
    keynote_promo_juni.png
  ...
```

Sub-mappen zijn conventie, geen hard-enforced regel — direct in `image_dump/` mag, maar bij volume wordt scannen lastig.

## Naamgeving

Dezelfde regels als de rest van de repo:

- snake_case
- max 5 woorden
- geen camera-namen (`IMG_*`, `DSC_*`, etc.)
- beschrijvend en leesbaar

WebP-only en EXIF-strip-eisen van `edited/` gelden hier **niet** — PNG/JPG/WebP mogen allemaal.

## index.json

`image_dump/index.json` wordt **automatisch (her)gegenereerd door de pre-commit hook**. Niet handmatig bewerken.

Bij elke commit met wijzigingen onder `image_dump/` doet de hook een `git ls-files --cached image_dump/`, schrijft de lijst naar `index.json`, en stage't het bestand mee.

## Hoe consuming agents het ontdekken

`manifest.json` bevat één pointer:

```json
"imageDump": {
  "path": "/image_dump/",
  "indexUrl": "/image_dump/index.json",
  "description": "..."
}
```

Een agent fetcht `manifest.json` zoals altijd, ziet de pointer, en haalt `indexUrl` **alleen op-aanvraag** op wanneer hij iets uit `image_dump/` nodig heeft. Default zien agents de 100+ entries dus nooit.

## Public — let op

Net als de rest van deze repo: **alles in `image_dump/` is publiek** zodra het gepushed is. Geen vertrouwelijke screenshots, geen klantdata, geen ongecensureerd materiaal.
