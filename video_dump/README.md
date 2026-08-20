# video_dump/

One-off shareable video's. **Uitgesloten van `manifest.json`** om context-bloat te voorkomen voor consuming agents (zelfde patroon als `image_dump/`).

## Waarom video's hier staan (en wanneer dit weg mag)

Deze map is een omweg, geen eindsituatie.

Video's staan hier omdat view.twofeetup.com onze HTML rendert in een sandboxed iframe
zonder `allow-same-origin` en met alleen `microphone` in de allow-lijst. De
YouTube-speler heeft cookie- en storage-toegang nodig, krijgt die daar niet, en weigert
te starten. Een `<video>` met een mp4 heeft dat niet nodig, dus daarom hosten we de
mp4's zelf op de GitHub Pages CDN. De artefact-visualiser in de AI Hub loopt tegen
hetzelfde aan.

De kosten daarvan: elke video moet handmatig deze repo in, en niet iedereen heeft
push-rechten, dus het kost steeds iemand anders een dag.

**Zodra view en de artefact-visualiser wel video-embeds aankunnen (gevraagd aan Sjoerd,
2026-08-20), hoort deze route te verdwijnen.** Dan wordt YouTube (of een echte
media-CDN) de bron en hoeft er geen mp4 meer in git. Ruim bij die omslag ook op wat
hier al staat, in plaats van het te laten staan omdat het toevallig werkt.

## Wanneer gebruiken

Voor video's die je publiek wilt kunnen delen via de GitHub Pages CDN (bijv. embedden in een view.twofeetup.com pagina), maar die je niet hergebruikt — bijvoorbeeld:

- Demo-loops voor één klant
- Screencasts bij een uitleg
- Korte social-clips voor één campagne
- Quick-shares die nooit terugkomen in branding-output

Voor herbruikbare brand-video's blijft `videos/` (met manifest-entry) de juiste plek.

## Structuur

Plaats bestanden in **sub-mappen per onderwerp, klant of datum**:

```
video_dump/
  achmea-2026-q2/
    demo_dashboard_walkthrough.mp4
  hackathon-recap-mei/
    teaser_30s.mp4
  ...
```

## Harde regels (afgedwongen door pre-commit hook)

1. **MP4-only.** Alleen `.mp4` (H.264 + AAC). Geen `.mov`, `.webm`, `.avi`, `.mkv`, `.m4v` — die spelen niet betrouwbaar inline in alle browsers (vooral Safari/iOS). Converteer eerst:
   ```bash
   ffmpeg -i input.mov -c:v libx264 -pix_fmt yuv420p -movflags +faststart -c:a aac -b:a 128k output.mp4
   ```
2. **Max 100MB per bestand.** GitHub blokkeert grotere files hard. Te lang? Trim of comprimeer met ffmpeg, of zet 'm op YouTube/Vimeo en embed die in plaats van het bestand zelf.
3. **Naamgeving:** snake_case, max 5 woorden, beschrijvend, geen camera-namen (`IMG_*`, `MOV_*`, etc.).

## index.json

`video_dump/index.json` wordt **automatisch (her)gegenereerd door de pre-commit hook**. Niet handmatig bewerken.

## Hoe consuming agents het ontdekken

`manifest.json` bevat één pointer:

```json
"videoDump": {
  "path": "/video_dump/",
  "indexUrl": "/video_dump/index.json",
  "description": "..."
}
```

Een agent fetcht `manifest.json` zoals altijd, ziet de pointer, en haalt `indexUrl` **alleen op-aanvraag** op wanneer hij iets uit `video_dump/` nodig heeft.

## Embedden in view.twofeetup.com

Direct via een `<video>` tag:

```html
<video
  src="https://twofeetup.github.io/Brand_Assets/video_dump/achmea-2026-q2/demo_dashboard_walkthrough.mp4"
  controls
  playsinline
  style="max-width: 100%; height: auto;"
></video>
```

CORS is permissief, inline afspelen werkt op alle browsers.

## Public — let op

Net als de rest van deze repo: **alles in `video_dump/` is publiek** zodra het gepushed is. Geen vertrouwelijke recordings, geen klantdata, geen ongecensureerd materiaal.
