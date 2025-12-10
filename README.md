# TwoFeetUp Brand Assets

Centrale repository voor alle TwoFeetUp brand assets, gehost via GitHub Pages.

## Wat is dit?

Deze repository bevat alle visuele assets van TwoFeetUp:
- **Logo's** - In verschillende formaten en varianten
- **Afbeeldingen** - Achtergronden, iconen, teamfoto's
- **Video's** - Brand video's en animaties
- **Fonts** - Huisstijl lettertypen
- **Kleuren** - Complete kleurenpalet met gebruiksrichtlijnen

Alle assets zijn beschikbaar via een centrale `manifest.json` die automatisch wordt bijgewerkt.

## GitHub Pages Activeren

1. Ga naar **Settings** → **Pages** in deze repository
2. Onder "Source", selecteer **Deploy from a branch**
3. Kies de **main** branch en **/ (root)** folder
4. Klik op **Save**

Na een paar minuten zijn je assets beschikbaar op:
```
https://twofeetup.github.io/brand/
```

## Structuur

```
twofeetup-brand/
├── README.md           # Deze documentatie
├── manifest.json       # Centrale index van alle assets
├── colors.json         # Uitgebreide kleurinformatie
├── logos/              # Logo bestanden (SVG, PNG)
├── images/
│   ├── backgrounds/    # Achtergrondafbeeldingen
│   ├── icons/          # Iconen en symbolen
│   ├── team/           # Teamfoto's
│   └── misc/           # Overige afbeeldingen
├── videos/             # Video bestanden
└── fonts/              # Font bestanden
```

## Assets Toevoegen

### 1. Plaats het bestand in de juiste map

| Type | Map |
|------|-----|
| Logo's | `logos/` |
| Achtergronden | `images/backgrounds/` |
| Iconen | `images/icons/` |
| Teamfoto's | `images/team/` |
| Overige afbeeldingen | `images/misc/` |
| Video's | `videos/` |
| Fonts | `fonts/` |

### 2. Update manifest.json

Voeg een entry toe aan de juiste sectie in `manifest.json`:

**Voor logo's:**
```json
"logos": {
  "primary": {
    "path": "/logos/twofeetup-logo.svg",
    "width": 200,
    "height": 50,
    "usage": "Default logo voor lichte achtergronden"
  }
}
```

**Voor afbeeldingen:**
```json
"images": {
  "backgrounds": [
    {
      "path": "/images/backgrounds/hero-gradient.jpg",
      "width": 1920,
      "height": 1080,
      "description": "Gradient achtergrond voor hero secties"
    }
  ]
}
```

**Voor video's:**
```json
"videos": [
  {
    "path": "/videos/intro.mp4",
    "duration": 30,
    "description": "TwoFeetUp introductie video"
  }
]
```

### 3. Update de `lastUpdated` datum

Vergeet niet de `lastUpdated` waarde aan te passen:
```json
"lastUpdated": "2024-12-10"
```

## Manifest.json Gebruiken

### In JavaScript/TypeScript

```javascript
// Manifest ophalen
const response = await fetch('https://twofeetup.github.io/brand/manifest.json');
const manifest = await response.json();

// Logo URL samenstellen
const logoUrl = manifest.baseUrl + manifest.logos.primary.path;
// → https://twofeetup.github.io/brand/logos/twofeetup-logo.svg

// Kleuren gebruiken
const primaryColor = manifest.colors.primary;
// → #000000

// Alle achtergronden ophalen
const backgrounds = manifest.images.backgrounds.map(bg => ({
  url: manifest.baseUrl + bg.path,
  ...bg
}));
```

### In CSS

```css
:root {
  /* Kleuren direct uit colors.json */
  --color-primary: #000000;
  --color-secondary: #000000;
  --color-accent: #000000;
  --color-background: #ffffff;
  --color-text: #000000;
}
```

### In React/Vue

```jsx
// React voorbeeld
const BrandLogo = () => {
  const [manifest, setManifest] = useState(null);

  useEffect(() => {
    fetch('https://twofeetup.github.io/brand/manifest.json')
      .then(res => res.json())
      .then(setManifest);
  }, []);

  if (!manifest) return null;

  return (
    <img
      src={manifest.baseUrl + manifest.logos.primary.path}
      alt={manifest.brand.name}
      width={manifest.logos.primary.width}
      height={manifest.logos.primary.height}
    />
  );
};
```

## Colors.json Gebruiken

Het `colors.json` bestand bevat uitgebreide kleurinformatie:

```javascript
const colors = await fetch('https://twofeetup.github.io/brand/colors.json')
  .then(res => res.json());

// Verschillende formaten beschikbaar
console.log(colors.palette.primary.hex);  // #000000
console.log(colors.palette.primary.rgb);  // 0, 0, 0
console.log(colors.palette.primary.hsl);  // 0, 0%, 0%

// Gebruiksrichtlijnen
console.log(colors.usage.buttons.background);  // "primary"
```

## Best Practices

### Bestandsnamen
- Gebruik lowercase en kebab-case: `hero-background.jpg`
- Wees beschrijvend: `team-photo-wouter.jpg` in plaats van `IMG_1234.jpg`
- Voeg geen datums toe aan bestandsnamen (versie wordt bijgehouden in Git)

### Afbeeldingen
- **Logo's**: Gebruik SVG waar mogelijk, anders PNG met transparantie
- **Achtergronden**: JPEG voor foto's, PNG voor graphics met transparantie
- **Iconen**: SVG of PNG (minimaal 2x resolutie voor retina)

### Optimalisatie
- Comprimeer afbeeldingen voor web gebruik
- Gebruik juiste formaat: WebP/AVIF voor moderne browsers met fallback

## Automatische Updates

Als je bestanden aanlevert, worden ze automatisch:
1. In de juiste map geplaatst
2. Toegevoegd aan `manifest.json` met:
   - Correct pad
   - Bestandsnaam
   - Dimensies (voor afbeeldingen)
   - Beschrijving gebaseerd op bestandsnaam

## CORS

GitHub Pages staat cross-origin requests toe, dus je kunt de manifest en assets direct fetchen vanuit elke website of applicatie.

## Vragen?

Neem contact op met het TwoFeetUp team voor vragen over brand assets of het gebruik van deze repository.
