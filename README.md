# Lernstoff DMAVT

Fünf Lernskripte für das erste Studienjahr (Mechanik 1, Analysis 1, Lineare Algebra, Informatik, Chemie) als PDF.

Website: https://cheftaxi2000.github.io/hs/

- `index.html`, `assets/` – die Website (statisch, kein Build-Schritt): die fünf Skripte zum Herunterladen
- `mechanik1/`, `analysis1/`, `linalg1/`, `informatics1/`, `chemistry1/` – Typst-Quellen, Abbildungen und die fertigen PDFs, die die Website verlinkt
- `errors/`, `feedback/` – «Verbesserung vorschlagen» und die Übersicht der Meldungen

Die interaktiven Animationen («Mechanik 1 in Tafeln», «Analysis I in Tafeln» und die zwölf Modelle) sind nicht mehr auf der Website.
Sie liegen unverändert im Branch [`animationen`](https://github.com/cheftaxi2000/hs/tree/animationen).

## Veröffentlichen mit GitHub Pages

Settings → Pages → Source: **GitHub Actions**. Jeder Push auf `main` startet `.github/workflows/pages.yml`
und veröffentlicht die Seite, die PDFs und `/errors`.

## Lokal ansehen

```sh
python3 -m http.server 8000
# http://localhost:8000
```
