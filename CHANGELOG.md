# Changelog

Noemenswaardige wijzigingen aan deze repo, met impact op consumers (huisstijl-skill,
prototype-pitch footers, Stella, en alles wat `manifest.json` of directe CDN-URLs gebruikt).
Nieuwste bovenaan.

## 2026-07-17 — Avatar-consistentie + archivering (PR #8)

**Wat**
- `images/employees/Wilfred.png` rechtgetrokken naar de canonieke stijl (vrijgesteld
  onderwerp op transparant, oranje TwoFeetUp-ring). Was een massief wit RGB-vierkant.
- Vertrokken/gast-medewerkers verplaatst naar `images/employees/_archive/`:
  **Fahim**, **Jay** (voormalig stagiair), **Eva** (VR Nederland-gast, geen TFU-medewerker).
- Zeven generieke AI-avatars verplaatst naar `images/digital employees/_archive/`:
  **AI colleague Alex / Charlie / Max / Sam / Jordan / Robin / Extra custom**. Uitgefaseerd.
  De vier named agents (Stella Story, Duco Declaratie, Pieter Post, Brandon Branding)
  blijven actief en op hun plek.
- Manifest: bovenstaande entries op `status: "archived"` met `_archive/`-pad; nieuwe
  `archived`-statuswaarde gedocumenteerd in `CLAUDE.md`.
- Nieuw: `scripts/process_avatar.py` + `docs/avatar-processing.md` (reproduceerbare
  on/offboarding van avatars).

**Waarom deze noot bestaat (consumer-impact)**
Bestanden die naar `_archive/` zijn verplaatst, geven op hun **oude** CDN-pad nu een 404.
Zie je een gebroken avatar-afbeelding, bijvoorbeeld
`.../images/digital employees/AI colleague Alex.png` of een oude employee-foto: dat komt
door deze verplaatsing. Dit raakt vooral **al eerder gegenereerde/verstuurde
prototype-pitch HTML** die die paden hardcodet. Nieuwe output volgt de bijgewerkte
footer-template (claudecode-plugins, `pitch` plugin) en `manifest.json` (`status: "active"`).

Fix voor een gebroken referentie: gebruik een actieve avatar uit `manifest.json`, of het
verplaatste bestand op zijn nieuwe `_archive/`-pad.
