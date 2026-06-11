# file_dump/

One-off shareable files (PDFs, decks, attachments). **Uitgesloten van `manifest.json`** om context-bloat te voorkomen voor consuming agents (zelfde patroon als `image_dump/` en `video_dump/`).

## Wanneer gebruiken

Voor bestanden die je publiek wilt kunnen downloaden of embedden via de GitHub Pages CDN, maar die je niet hergebruikt - bijvoorbeeld:

- Workshop decks (PDF/PPTX) gekoppeld aan een specifieke sessie
- One-page handouts voor een klantgesprek
- White papers of leaflets bij een campagne
- Bijlagen voor view.twofeetup.com pagina's

Voor herbruikbare brand-templates (huisstijl-decks, generieke handouts) blijft een nette plek in `raw/` of een dedicated folder beter.

## Structuur

Plaats bestanden in **sub-mappen per onderwerp, klant of datum**:

```
file_dump/
  260513-ing-aiday/
    ing-ai-day-copilot-agents-deck.pdf
    ing-ai-day-copilot-agents-deck.pptx
  ...
```

## Harde regels

1. **Geen vertrouwelijke data.** Alles hier is publiek zodra het gepushed is.
2. **Max 100MB per bestand.** GitHub blokkeert grotere files hard.
3. **Naamgeving:** kebab-case of snake_case, beschrijvend, geen camera-namen of generieke "deck.pdf".

## Embedden in view.twofeetup.com

PDF preview via iframe:

```html
<iframe
  src="https://twofeetup.github.io/Brand_Assets/file_dump/260513-ing-aiday/ing-ai-day-copilot-agents-deck.pdf"
  style="width: 100%; height: 700px; border: none;"
></iframe>
```

Download knop:

```html
<a href="https://twofeetup.github.io/Brand_Assets/file_dump/260513-ing-aiday/ing-ai-day-copilot-agents-deck.pdf" download>
  Download PDF
</a>
```

## Public - let op

Net als de rest van deze repo: alles in `file_dump/` is publiek zodra het gepushed is. Geen vertrouwelijke decks, klantdata of NDA-materiaal.
