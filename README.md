# TwoFeetUp Brand Assets

Centrale repository voor alle goedgekeurde TwoFeetUp brand assets.

**Deze repo is public.** Alleen definitief, bewerkt materiaal dat bewust gepubliceerd mag worden hoort hier. Ruwe of onverwerkte content (teamfoto's van telefoon, onbewerkte visuals, etc.) gaat naar de gezamenlijke Google Drive folder.

## Wat zit erin?

- **Logo's** - Beeldmerk en volledig logo in verschillende varianten (licht/donker/gradient)
- **Afbeeldingen** - Teamfoto's, AI colleagues, hackathon, media, kantoor, partners
- **Video's** - Brand video's
- **Kleuren** - Kleurenpalet in `colors.json`
- **Manifest** - Centrale index van alle assets in `manifest.json`
- **Product brands** - Sub-brand assets, zoals TalkToCRM, onder hun eigen subfolder

## Structuur

```
Brand_Assets/
├── README.md
├── manifest.json          # Centrale index van alle assets
├── colors.json            # Kleurenpalet met gebruiksrichtlijnen
│
├── logos/                  # Beeldmerk en volledig logo (SVG, PNG)
│   ├── TwoFeetUp_Beeldmerk.svg
│   ├── TwoFeetUp_Beeldmerk_for_bright_background.png
│   ├── TwoFeetUp_Beeldmerk_Diapositief_for_dark_brackground.png
│   ├── TwoFeetUp_Full_Logo_for_bright_backgrounds.png
│   ├── TwoFeetUp_Full_Logo_Diapositief_Wit_For_dark_background.png
│   └── ...
│
├── images/
│   ├── employees/          # Teamfoto's (voornaam als bestandsnaam)
│   ├── digital employees/  # AI colleague avatars
│   ├── hackathon/          # Hackathon fotografie
│   ├── media/              # Pers, keynotes, tegeltjes
│   ├── office/             # Kantoorlocatie foto's
│   └── partner companies/  # Logo's van partners
│
├── talktocrm/               # TalkToCRM product/sub-brand assets
│   ├── manifest.json        # Product-specifieke asset index
│   ├── design.md            # Fonts, colors, sizes en usage
│   ├── logos/               # SVG en PNG logo/icon/favicon exports
│   ├── fonts/               # Lokale fontbestanden en licenties
│   ├── tokens/              # CSS/JSON design tokens
│   └── downloads/           # Zip-downloads voor handoff
│
└── videos/                 # Video bestanden
```

## Beleid

### Wat hoort hier
- Definitieve, bewerkte assets die public mogen zijn
- Logo's in alle benodigde varianten (SVG bij voorkeur, anders PNG met transparantie)
- Teamfoto's die goedgekeurd zijn voor extern gebruik
- Partner/klant logo's die we mogen tonen

### Wat hoort hier NIET
- Ruwe, onverwerkte content (die gaat naar Google Drive)
- Afbeeldingen met AI-metadata die niet gestript is
- Werk-in-uitvoering of concepten
- Vertrouwelijke of interne documenten

### Bestandsnamen
- Wees beschrijvend: `Wouter.png`, niet `IMG_1234.jpg`
- Voeg geen datums toe (versie wordt bijgehouden in Git)
- Logo's: gebruik de officiele naamconventie `TwoFeetUp_[Variant]_[Context].png`

### Afbeeldingen
- **Logo's**: SVG waar mogelijk, anders PNG met transparantie
- **Foto's**: JPEG of PNG
- **AI-gegenereerde afbeeldingen**: altijd metadata strippen voor plaatsing (`exiftool -all= bestand.png`)

## Assets Toevoegen

1. Bewerk en keur het materiaal goed (lokaal of in Google Drive)
2. Plaats het bestand in de juiste map
3. Update `manifest.json` met pad, dimensies en beschrijving
4. Commit en push naar main

## Manifest en Colors

`manifest.json` bevat een centrale index van alle assets. `colors.json` bevat het kleurenpalet. Beide zijn beschikbaar via GitHub raw URLs voor gebruik in tools en applicaties.
