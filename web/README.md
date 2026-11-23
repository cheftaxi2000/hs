# Bewegte Tafeln: Mechanik 1 und Analysis I

Eine Seite mit bewegten Figuren zu den Lernskripten `../mechanik1` und `../analysis1`: pro Begriff eine Tafel, darunter nur Name und Formel.
Jede Bewegung wird aus den Gleichungen berechnet (`src/phys/`, mit Tests), nicht von Hand animiert.

```
npm install
npm run dev              # lokale Vorschau (veröffentlicht unter /hs/mechanik/)
npm run check            # Typen, Physik-Tests, Build
npm run build:artifact   # eine einzige HTML-Datei (dist-artifact/)
```

## Aufbau

- `src/phys/` Kinematik und Statik (Rollen, Leiter, Schubkurbel, Fachwerk-Löser, Kettenlinie, Seilreibung, Schnittgrössen …), jede Formel in `*.test.ts` numerisch geprüft.
- `src/ui/` Tafel (Uhr, Abspielen/Anhalten, pausiert ausserhalb des Bildschirms), SVG-Grundformen (Pfeile, Fest- und Loslager, Schraffur), KaTeX-Beschriftungen, 3D-Projektion zum Ziehen.
- `src/math/` Analysis (Folgen, Bisektion, Krümmung und Evolute, komplexe Zahlen, Ober-/Untersummen, Taylor), ebenfalls getestet.
- `src/plates/` die Tafeln, nach Kapiteln der Skripte. Fachwahl über `#mechanik` / `#analysis`.

## Regeln

- Farben wie im Skript: Geschwindigkeiten blau, Kräfte rot, Drehungen und Momente grün; Koordinaten und Bahnen violett. Vektoren fett.
- Wenig Text: Titel, eine Formel, höchstens ein Satz. Die Figur erklärt.
- Alle Mathematik in KaTeX, auch in den Figuren.
- Hell und dunkel, Handy bis Desktop. Mit «Bewegung reduzieren» steht jede Tafel still auf ihrem aussagekräftigsten Bild.
