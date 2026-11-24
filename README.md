# Lernstoff DMAVT

Fünf Lernskripte für das erste Studienjahr (Mechanik 1, Analysis 1, Lineare Algebra, Informatik, Chemie) als PDF, dazu zwölf interaktive Modelle im Browser.

- `index.html`, `assets/` – die Website (statisch, kein Build-Schritt)
- `mechanik1/`, `analysis1/`, `linalg1/`, `informatics1/`, `chemistry1/` – Typst-Quellen, Abbildungen und die fertigen PDFs, die die Website verlinkt

- `web/` – «Mechanik 1 in Tafeln» und «Analysis I in Tafeln» (React/Vite), wird beim Veröffentlichen gebaut und unter `/mechanik/` und `/analysis/` eingebunden

## Veröffentlichen mit GitHub Pages

Settings → Pages → Source: **GitHub Actions**. Jeder Push auf `main` startet `.github/workflows/pages.yml`:
Tafeln bauen und testen, dann Lernstoff-Seite, PDFs, `/errors`, `/mechanik/` und `/analysis/` zusammen veröffentlichen.

## Bibliotheksdaten (Inhaltsverzeichnis und Seitenvorschauen)

Die Fachseiten zeigen das Inhaltsverzeichnis jedes Skripts mit Seitenzahlen, die Art jedes Eintrags
(Kapitel, Aufgaben mit Lösungen, Formelsammlung) und eine Vorschau der Seite. Das alles wird aus den
Lesezeichen der PDFs erzeugt. **Nach jeder neuen PDF-Fassung einmal laufen lassen und das Ergebnis committen:**

```sh
pip install pymupdf pillow
python3 scripts/build_library.py
```

Das Skript schreibt `assets/library/library.json` und `assets/library/<fach>/p<NNN>.webp` (eine Vorschau pro
Seite, auf der ein Kapitel oder Abschnitt beginnt; rund 9 MB, geladen erst beim Ansehen). Die Art eines Eintrags
ergibt sich aus dem Titel: «Aufgaben mit Lösungen» / «Problems with solutions» → Aufgaben, alles im Anhang → Formelsammlung.

Gestaltung und Begründungen: `DESIGN.md`.

## Lokal ansehen

```sh
python3 -m http.server 8000
# http://localhost:8000
```

Die Seite lädt Schriften (Google Fonts), MathJax und Three.js von CDNs und braucht deshalb eine Internetverbindung.

**Hinweis:** Unter *Settings → Pages* muss die Quelle «GitHub Actions» sein. Mit «Deploy from a branch»
läuft zusätzlich eine zweite Veröffentlichung ohne die gebauten Tafeln und überschreibt `/mechanik/` und `/analysis/`.
