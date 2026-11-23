# Lernstoff DMAVT

Fünf Lernskripte für das erste Studienjahr (Mechanik 1, Analysis 1, Lineare Algebra, Informatik, Chemie) als PDF, dazu zwölf interaktive Modelle im Browser.

- `index.html`, `assets/` – die Website (statisch, kein Build-Schritt)
- `mechanik1/`, `analysis1/`, `linalg1/`, `informatics1/`, `chemistry1/` – Typst-Quellen, Abbildungen und die fertigen PDFs, die die Website verlinkt

- `web/` – «Mechanik 1 in Tafeln» und «Analysis I in Tafeln» (React/Vite), wird beim Veröffentlichen gebaut und unter `/mechanik/` und `/analysis/` eingebunden

## Veröffentlichen mit GitHub Pages

Settings → Pages → Source: **GitHub Actions**. Jeder Push auf `main` startet `.github/workflows/pages.yml`:
Tafeln bauen und testen, dann Lernstoff-Seite, PDFs, `/errors`, `/mechanik/` und `/analysis/` zusammen veröffentlichen.

## Lokal ansehen

```sh
python3 -m http.server 8000
# http://localhost:8000
```

Die Seite lädt Schriften (Google Fonts), MathJax und Three.js von CDNs und braucht deshalb eine Internetverbindung.
