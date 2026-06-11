---
date: 2026-05-06
topic: image-dump-folder
---

# image_dump Folder

## Summary

Een nieuwe top-level folder `image_dump/` voor one-off shareable images (100+ verwacht), met sub-mappen per onderwerp/klant/datum. De folder wordt **niet** in `manifest.json` opgenomen om main-manifest bloat te voorkomen; in plaats daarvan houdt een auto-gegenereerde `image_dump/index.json` (geschreven door de pre-commit hook) de inhoud bij. `manifest.json` krijgt één pointer-entry zodat consuming agents image_dump op-aanvraag kunnen ontdekken zonder de inhoud default mee te laden.

---

## Problem Frame

Brand_Assets is een publieke media-bibliotheek waarvan `manifest.json` de bron van waarheid is voor alle consuming agents (Brandon huisstijl-skill, Stella Story, etc.). De huidige regel uit CLAUDE.md is hard: *"Elke upload moet een entry krijgen in manifest.json."* Dat werkt voor een paar honderd zorgvuldig gecategoriseerde assets — logos, employees, partners, hackathon — die regelmatig worden hergebruikt.

Maar er is een nieuw soort asset: one-off afbeeldingen die we publiekelijk willen kunnen delen (een screenshot voor klant X, een tegeltje voor één social post) zonder dat ze ooit hergebruikt worden. Lex verwacht dat zo'n bucket binnen korte tijd 100+ items kan bevatten. Als die allemaal in `manifest.json` worden opgenomen, groeit het bestand met honderden regels JSON die elke fetch door een agent zwaarder maken — terwijl niemand er specifiek naar zoekt. De context-kosten compounden: elke conversatie waarin Brandon de manifest fetcht, betaalt voor onderhoudsdata van een bucket die in 99% van de gevallen niet relevant is.

---

## Requirements

**Folder structuur**

- R1. Nieuwe top-level folder `image_dump/` in de repo root, public via GitHub Pages CDN net als de rest.
- R2. Bestanden in `image_dump/` worden in sub-mappen per onderwerp, klant of datum geplaatst (bijv. `image_dump/achmea-2026-q2/`, `image_dump/social-shares/`). Sub-map structuur is conventie — niet hard afgedwongen door de hook.
- R3. Bestaande naamgevingsregels (snake_case, max 5 woorden, geen camera-namen) gelden ook in `image_dump/`. WebP-only en EXIF-strip-eisen van `edited/` gelden hier **niet**.

**Indexering**

- R4. `image_dump/index.json` bevat een lijst van alle bestanden onder `image_dump/`, met minimaal `path` per entry. Geen handgeschreven beschrijvingen of metadata.
- R5. `image_dump/index.json` wordt door de pre-commit hook automatisch (her)gegenereerd op basis van een directory-walk van `image_dump/`. Mensen bewerken het bestand niet handmatig.
- R6. De regenerated `index.json` wordt automatisch toegevoegd aan de commit (`git add`) zodat hij synchroon is met de werkelijk gecommitte bestanden.

**Pointer in main manifest**

- R7. `manifest.json` krijgt één nieuwe top-level key `imageDump` met `path`, `indexUrl`, en `description`. Geen per-file entries.
- R8. `lastUpdated` in `manifest.json` wordt bij deze wijziging bijgewerkt.

**Hook-aanpassing**

- R9. De `MANIFEST_NOT_UPDATED` check in `.githooks/pre-commit` slaat bestanden onder `image_dump/` over. Een commit met alleen image_dump-toevoegingen blokkeert dus niet op het ontbreken van een main-manifest update.
- R10. De hook regenereert `image_dump/index.json` wanneer er staged toevoegingen, wijzigingen of verwijderingen onder `image_dump/` zijn.

**Documentatie & verankering**

- R11. CLAUDE.md krijgt een eigen sectie "image_dump — uitzondering op de manifest-regel" met: het doel, de uitzondering op "elke upload = manifest entry", de auto-gegenereerde index, en hoe consuming agents image_dump moeten ontdekken (twee-staps fetch).
- R12. CLAUDE.md's `Mappenstructuur`-lijst wordt uitgebreid met `image_dump/`.

---

## Acceptance Examples

- AE1. **Covers R9, R10.** Given een schone working tree, when een gebruiker een nieuw bestand `image_dump/achmea-q2/screenshot_dashboard.png` toevoegt en commit, then de pre-commit hook (a) blokkeert niet op `MANIFEST_NOT_UPDATED`, (b) regenereert `image_dump/index.json` zodat het pad in de lijst staat, (c) staged het bijgewerkte index-bestand zodat de commit consistent is.
- AE2. **Covers R7, R8.** Given een agent fetcht `manifest.json`, when de agent op zoek is naar een specifieke image_dump-file, then de agent vindt onder de top-level key `imageDump` een `indexUrl` die hij apart kan fetchen om de volledige bestandenlijst te krijgen.

---

## Success Criteria

- 100+ items kunnen onder `image_dump/` worden geplaatst zonder dat `manifest.json` significant groeit (alleen één pointer-entry).
- Een nieuwe medewerker die een one-off image wil delen voegt het bestand toe aan een sub-map en hoeft `manifest.json` niet aan te raken — de hook regelt de rest.
- Een consuming agent (Brandon, Stella) kan bestaande gedrag blijven gebruiken: main manifest fetchen levert geen 100+ image_dump-entries op. Wanneer image_dump nodig is, is het pad om de sub-index op te halen expliciet beschreven in CLAUDE.md en in de pointer-entry zelf.
- `git status` na een test-commit met alleen image_dump-toevoegingen toont een schone working tree (index.json is meegenomen).

---

## Scope Boundaries

- Bestaande images migreren naar `image_dump/` is geen onderdeel van deze wijziging — de regel geldt alleen voor nieuwe uploads die expliciet niet hergebruikt worden.
- Pull-through van image_dump-entries in default agent-output (Brandon huisstijl-output, Stella Story) wordt niet gewijzigd. De index is on-demand discoverable, niet default included.
- Acces control of private sharing van image_dump valt buiten scope. De folder is, net als de rest van de repo, volledig publiek via GitHub Pages.
- Tagging, search, of taxonomie binnen `index.json` wordt niet toegevoegd. Het is een platte lijst van paden.
- Image-transformaties (thumbnails, resizing, format-conversie) worden niet door de hook of door tooling in deze repo uitgevoerd.
- Aanpassing van consuming agents (Brandon skill in `TwoFeetUp/claudecode-plugins`) om de `imageDump.indexUrl` te leren fetchen valt buiten deze repo. Wel wordt de conventie hier vastgelegd zodat die aanpassing later eenvoudig is.

---

## Key Decisions

- **Auto-gegenereerde index in plaats van sub-manifest met handgeschreven entries.** Een talktocrm-stijl `image_dump/manifest.json` met `path/name/description` per file zou bij 100+ one-off uploads dezelfde maintenance-druk geven die we juist willen vermijden. Door de hook een platte index te laten genereren is "discipline" niet meer nodig — de waarheid komt altijd uit de directory-walk.
- **Sub-mappen als conventie, niet als hard requirement.** De hook valideert geen sub-map structuur. Een snelle één-shot share mag direct in `image_dump/` — gebruiker kiest. Wanneer het volume groeit kan de regel later strenger worden.
- **Geen description per file.** Filenames moeten beschrijvend zijn (snake_case-regel geldt al). Beschrijvingen toevoegen voor 100+ one-offs wordt sloppy en is niet de moeite waard voor consumers — die hebben filename + URL nodig, niet metadata.
- **Pointer in main manifest in plaats van pure CLAUDE.md-discovery.** Agents die de manifest al fetchen vinden de pointer automatisch. Dat is robuuster dan vertrouwen op het lezen van CLAUDE.md.

---

## Dependencies / Assumptions

- Pre-commit hook is Node.js (`.githooks/pre-commit`) en draait stabiel; uitbreiding kan in dezelfde stijl met `child_process` en `fs`.
- GitHub Pages serveert nieuwe top-level folders en geneste sub-mappen automatisch onder `baseUrl`. Geen extra configuratie nodig.
- Consuming agents (Brandon, Stella) zullen later worden bijgewerkt om de `imageDump.indexUrl` op te volgen wanneer dat nodig is. Voor de eerste roll-out is het voldoende dat de pointer en index correct gegenereerd worden.
