# TwoFeetUp Huisstijl Skill - Implementatieplan

Dit document beschrijft hoe je de TwoFeetUp brand assets repository kunt gebruiken in combinatie met een Claude skill, zodat anderen eenvoudig de TwoFeetUp huisstijl kunnen toepassen in hun projecten.

## Architectuur Overzicht

```
┌─────────────────────────────────────────────────────────────────┐
│                    GitHub Pages (CDN)                           │
│         https://twofeetup.github.io/brand/                      │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │ manifest.json│  │  colors.json │  │   logos/    │             │
│  │             │  │              │  │   images/   │             │
│  └─────────────┘  └──────────────┘  └─────────────┘             │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │ WebFetch
                              │
┌─────────────────────────────────────────────────────────────────┐
│                    Claude Skill                                  │
│            .claude/skills/twofeetup-huisstijl/                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │  SKILL.md   │  │  templates/ │  │  examples/  │             │
│  │(instructies)│  │(componenten)│  │ (voorbeelden)│             │
│  └─────────────┘  └─────────────┘  └─────────────┘             │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                   Gebruiker's Project                           │
│  - Website                                                      │
│  - React/Vue/Next.js app                                        │
│  - Landing page                                                 │
│  - Marketing materiaal                                          │
└─────────────────────────────────────────────────────────────────┘
```

## Hoe het werkt

### 1. Brand Assets Repository (Deze Repo)

De brand assets staan op GitHub Pages en zijn toegankelijk via URLs:

```
https://twofeetup.github.io/brand/manifest.json   → Centrale index
https://twofeetup.github.io/brand/colors.json    → Kleurenpalet
https://twofeetup.github.io/brand/logos/...      → Logo bestanden
https://twofeetup.github.io/brand/images/...     → Afbeeldingen
```

### 2. Claude Skill Leest de Assets

De skill bevat instructies die Claude vertellen:
- Waar de assets te vinden zijn (manifest URL)
- Hoe de kleuren toe te passen
- Welke logo's te gebruiken voor welke situatie
- Hoe componenten te bouwen met de huisstijl

### 3. Claude Genereert Code voor Gebruikers

Wanneer een gebruiker vraagt om iets te bouwen met TwoFeetUp styling:
1. Claude leest de skill instructies
2. Claude fetcht de manifest.json voor actuele waardes
3. Claude genereert code met de juiste kleuren, logo URLs, etc.

---

## Stap 1: GitHub Pages Activeren

1. Ga naar je `Brand_Assets` repository op GitHub
2. Settings → Pages
3. Source: "Deploy from a branch"
4. Branch: `main`, folder: `/ (root)`
5. Save

Na ~2 minuten zijn je assets beschikbaar op:
`https://[username].github.io/Brand_Assets/`

**Update de baseUrl in manifest.json:**
```json
{
  "baseUrl": "https://[username].github.io/Brand_Assets"
}
```

---

## Stap 2: Claude Skill Structuur Maken

Maak deze structuur in je project of een aparte skills repo:

```
.claude/skills/twofeetup-huisstijl/
├── SKILL.md                    # Hoofd instructies
├── BRAND_GUIDELINES.md         # Gedetailleerde richtlijnen
├── templates/
│   ├── tailwind-config.js      # Tailwind configuratie
│   ├── css-variables.css       # CSS custom properties
│   ├── button.jsx              # React button component
│   ├── header.jsx              # React header component
│   └── landing-page.html       # HTML template
└── examples/
    ├── react-app-setup.md      # React integratie guide
    └── nextjs-setup.md         # Next.js integratie guide
```

---

## Stap 3: SKILL.md Schrijven

De SKILL.md is het hart van je skill. Hier een voorbeeld:

```markdown
---
name: twofeetup-huisstijl
description: Apply TwoFeetUp brand identity to websites and apps. Use when building TwoFeetUp-branded interfaces, landing pages, or components.
---

# TwoFeetUp Huisstijl

## Brand Assets Location

All brand assets are hosted on GitHub Pages:

- **Manifest**: https://twofeetup.github.io/Brand_Assets/manifest.json
- **Colors**: https://twofeetup.github.io/Brand_Assets/colors.json

## Before Building

ALWAYS fetch the latest brand manifest first:

```javascript
const manifest = await fetch('https://twofeetup.github.io/Brand_Assets/manifest.json')
  .then(res => res.json());
```

## Brand Colors

Apply these CSS variables to any project:

```css
:root {
  --tfu-primary: #[from manifest.colors.primary];
  --tfu-secondary: #[from manifest.colors.secondary];
  --tfu-accent: #[from manifest.colors.accent];
  --tfu-background: #[from manifest.colors.background];
  --tfu-text: #[from manifest.colors.text];
}
```

## Logo Usage

| Context | Logo Key | Usage |
|---------|----------|-------|
| Light backgrounds | `logos.primary` | Default logo |
| Dark backgrounds | `logos.primaryWhite` | White logo |
| Favicon/small | `logos.icon` | SVG beeldmerk |

Example:
```jsx
<img
  src={`${manifest.baseUrl}${manifest.logos.primary.path}`}
  alt="TwoFeetUp"
  width={manifest.logos.primary.width / 10}
  height={manifest.logos.primary.height / 10}
/>
```

## Component Templates

See the templates/ folder for ready-to-use components:
- [Button Component](templates/button.jsx)
- [Header Component](templates/header.jsx)
- [Landing Page](templates/landing-page.html)

## When to Use This Skill

Use this skill when the user asks for:
- "TwoFeetUp styling"
- "Huisstijl toepassen"
- "Brand colors/logo's"
- Building any TwoFeetUp-branded interface
```

---

## Stap 4: Template Bestanden Toevoegen

### templates/css-variables.css
```css
/* TwoFeetUp Brand Variables */
/* Generated from: https://twofeetup.github.io/Brand_Assets/manifest.json */

:root {
  /* Colors - update these from manifest.json */
  --tfu-primary: #000000;
  --tfu-secondary: #000000;
  --tfu-accent: #000000;
  --tfu-background: #ffffff;
  --tfu-text: #000000;

  /* Typography */
  --tfu-font-primary: 'Inter', sans-serif;
  --tfu-font-heading: 'Inter', sans-serif;

  /* Spacing */
  --tfu-space-xs: 0.25rem;
  --tfu-space-sm: 0.5rem;
  --tfu-space-md: 1rem;
  --tfu-space-lg: 2rem;
  --tfu-space-xl: 4rem;

  /* Border radius */
  --tfu-radius-sm: 0.25rem;
  --tfu-radius-md: 0.5rem;
  --tfu-radius-lg: 1rem;
}
```

### templates/tailwind-config.js
```javascript
// TwoFeetUp Tailwind Configuration
// Fetch colors from: https://twofeetup.github.io/Brand_Assets/colors.json

module.exports = {
  theme: {
    extend: {
      colors: {
        'tfu-primary': '#000000',    // Update from manifest
        'tfu-secondary': '#000000',  // Update from manifest
        'tfu-accent': '#000000',     // Update from manifest
      },
      fontFamily: {
        'tfu': ['Inter', 'sans-serif'],
      },
    },
  },
};
```

### templates/button.jsx
```jsx
// TwoFeetUp Button Component
export function TFUButton({ children, variant = 'primary', ...props }) {
  const baseStyles = "px-4 py-2 rounded-md font-medium transition-colors";

  const variants = {
    primary: "bg-[var(--tfu-primary)] text-white hover:opacity-90",
    secondary: "bg-[var(--tfu-secondary)] text-white hover:opacity-90",
    outline: "border-2 border-[var(--tfu-primary)] text-[var(--tfu-primary)] hover:bg-[var(--tfu-primary)] hover:text-white",
  };

  return (
    <button className={`${baseStyles} ${variants[variant]}`} {...props}>
      {children}
    </button>
  );
}
```

---

## Stap 5: Skill Distribueren

### Optie A: In je project (lokaal)
Plaats de skill in `.claude/skills/` van je project. Werkt alleen voor dat project.

### Optie B: Als Plugin (gedeeld)
Publiceer als Claude Code plugin zodat anderen het kunnen installeren:

```bash
# In de skills directory
claude plugins publish twofeetup-huisstijl
```

### Optie C: Via GitHub (handmatig)
Deel de skill via een GitHub repo. Gebruikers kopiëren de skill naar hun `.claude/skills/` map.

---

## Gebruik door Anderen

### Voor Eindgebruikers

Zodra de skill is geïnstalleerd, kunnen gebruikers simpelweg vragen:

> "Maak een landing page met TwoFeetUp styling"

> "Voeg de TwoFeetUp huisstijl toe aan mijn React app"

> "Genereer een header component met het TwoFeetUp logo"

Claude zal dan:
1. De manifest.json fetchen voor actuele waardes
2. De juiste kleuren en logo's toepassen
3. Code genereren die direct werkt

### Voor Developers

```javascript
// In je project kun je de assets direct fetchen:
async function loadTwoFeetUpBrand() {
  const manifest = await fetch(
    'https://twofeetup.github.io/Brand_Assets/manifest.json'
  ).then(r => r.json());

  return {
    colors: manifest.colors,
    logos: {
      primary: manifest.baseUrl + manifest.logos.primary.path,
      white: manifest.baseUrl + manifest.logos.primaryWhite.path,
      icon: manifest.baseUrl + manifest.logos.icon.path,
    },
    images: manifest.images,
  };
}
```

---

## Onderhoud

### Assets Updaten

1. Voeg nieuwe bestanden toe aan de juiste map
2. Update `manifest.json` met paden en metadata
3. Commit en push naar GitHub
4. GitHub Pages update automatisch (~2 min)

### Skill Updaten

1. Pas SKILL.md of templates aan
2. Test lokaal
3. Publiceer nieuwe versie (als plugin)

---

## Checklist

- [ ] GitHub Pages geactiveerd
- [ ] baseUrl in manifest.json aangepast
- [ ] Kleuren in manifest.json ingevuld (niet placeholder #000000)
- [ ] SKILL.md geschreven met duidelijke instructies
- [ ] Templates toegevoegd voor common use cases
- [ ] Skill getest met verschillende prompts
- [ ] Skill gedistribueerd (lokaal/plugin/github)

---

## Voorbeeld Conversatie

**Gebruiker:** "Ik wil een nieuwe landing page bouwen voor TwoFeetUp"

**Claude (met skill):**
1. Fetcht manifest.json
2. Leest skill instructies
3. Genereert complete HTML/React met:
   - Juiste kleuren als CSS variables
   - Logo's met correcte URLs
   - Hackathon afbeeldingen indien relevant
   - Responsive design volgens brand guidelines

---

## Vragen?

De skill en brand assets zijn ontworpen om samen te werken. De assets repo is de "single source of truth" voor alle visuele elementen, terwijl de skill Claude vertelt hoe deze toe te passen.
