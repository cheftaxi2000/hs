# Lernskripte

Fünf Lernskripte für das erste Studienjahr (Mechanik 1, Analysis 1, Lineare Algebra, Informatik, Chemie) als PDF, dazu zwölf interaktive Modelle im Browser.

- `index.html`, `assets/` – die Website (statisch, kein Build-Schritt)
- `mechanik1/`, `analysis1/`, `linalg1/`, `informatics1/`, `chemistry1/` – Typst-Quellen, Abbildungen und die fertigen PDFs, die die Website verlinkt

## Veröffentlichen mit GitHub Pages

Settings → Pages → Source: *Deploy from a branch*, Branch `main`, Ordner `/ (root)`.

## Lokal ansehen

```sh
python3 -m http.server 8000
# http://localhost:8000
```

Die Seite lädt Schriften (Google Fonts), MathJax und Three.js von CDNs und braucht deshalb eine Internetverbindung.
