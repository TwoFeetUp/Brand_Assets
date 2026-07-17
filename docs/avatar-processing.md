# Avatar-verwerking — employees & digital employees

Hoe een medewerkersfoto de canonieke TwoFeetUp-avatar wordt, en hoe je iemand
netjes archiveert bij vertrek. Volg dit elke keer, dan blijven alle avatars
identiek in stijl (dat was het probleem dat dit document oplost: half wit-vierkant,
half transparant, half witte-schijf door elkaar).

## De canonieke stijl

Een employee-avatar is:

- **500 x 500 px, PNG, RGBA** met een **volledig transparante achtergrond**
- Onderwerp vrijgestaan (achtergrond weg), zwart-wit
- Binnen de **oranje TwoFeetUp-ring**: kleur `#faa61a` (= `manifest.colors.accent`),
  buitenstraal 200 px, binnenstraal 189 px (ring ~11 px dik), gecentreerd
- Geen witte schijf, geen witte hoeken, geen ingebakken achtergrond

Referentie: Wouter, Thomas, Sjoerd, Lex, Leonie, Roel, Wilfred in
`images/employees/` zijn allemaal in deze stijl.

De digital-employee **agents** (Stella Story, Duco, Pieter, Brandon) zijn een
andere categorie: geïllustreerde badges met een eigen gekleurde cirkel-achtergrond.
Die achtergrond hoort er bewust bij en wordt **niet** vrijgesteld.

## Onboarding — nieuwe collega toevoegen

Benodigde tool (staat niet in de repo, installeer in een wegwerp-venv):

```bash
python3 -m venv .venv && . .venv/bin/activate
pip install "rembg[cpu]" onnxruntime pillow
```

1. **Foto** — vraag een frontale head-and-shoulders foto, egale achtergrond,
   liefst al zwart-wit. Ruwe foto hoort op Google Drive (Raw footage inbox), niet
   in deze repo.
2. **Genereer de avatar**:

   ```bash
   python scripts/process_avatar.py bron-foto.jpg "images/employees/Voornaam.png"
   ```

   `process_avatar.py` verwijdert de achtergrond (rembg, `u2net_human_seg` +
   alpha matting), zet het onderwerp op een 500x500 transparant canvas en legt de
   canonieke oranje ring eroverheen. Klopt de uitsnede of de framing niet, gebruik
   `--scale`, `--dx`, `--dy` om bij te sturen, of `--no-ring` voor een kale
   transparante uitsnede.
3. **Verifieer op donker én licht** — plak de PNG op een donkere en een lichte
   achtergrond en controleer: geen witte halo, schone haarrand, ring op zijn plek.
   Op een felle kleur (magenta) zie je residu-wit meteen.
4. **manifest.json** — voeg een entry toe onder `images.employees` (bij de actieve
   groep, vóór de gearchiveerde). Verplichte velden: `path`, `width` (500),
   `height` (500), `name`, `role`, `status: "active"`, `description`. Optioneel
   `linkedin`. Werk `lastUpdated` bij.
5. **Commit** op een branch, laat de pre-commit hook valideren, PR naar `main`.

## Offboarding — vertrekker of gast archiveren

Niet verwijderen (we houden het record), maar archiveren:

1. **Verplaats het bestand** naar de archief-map:

   ```bash
   git mv "images/employees/Voornaam.png" "images/employees/_archive/Voornaam.png"
   ```
2. **manifest.json** — zet bij die entry `status` op `"archived"`, pas de `path`
   aan naar `/images/employees/_archive/...`, en zet in `description` kort waarom
   plus de datum. Verplaats de entry naar onderaan de lijst (na de actieve). Werk
   `lastUpdated` bij.
3. Consumers (de huisstijl-skill) tonen standaard alleen `status: "active"`, dus
   gearchiveerde mensen verdwijnen vanzelf uit gegenereerde output.

Zelfde patroon voor digital-employee avatars die je uitfaseert:
`images/digital employees/_archive/` + `status: "archived"` in het manifest.

## Statuswaarden (employees en digitalEmployees)

- `active` — in gebruik, wordt getoond
- `temporarily_inactive` — tijdelijk afwezig, standaard verborgen
- `archived` — uit dienst / uitgefaseerd, verplaatst naar `_archive/`, standaard verborgen
