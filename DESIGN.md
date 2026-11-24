# Lernstoff DMAVT — Design

Stand der Neugestaltung auf dem Branch `redesign`. Dieses Dokument hält fest, was vorher nicht funktionierte,
für wen die Seite gebaut ist, welche Richtungen geprüft wurden und warum diese gewählt wurde.

## 1  Bestand

**Technik.** Statische Seite ohne Build-Schritt (`index.html`, `assets/`), ein Hash-Router in `assets/js/app.js`,
zwölf interaktive Modelle in `assets/js/viz/` (Canvas, drei davon mit three.js), Mathematik mit MathJax.
Daneben `web/` (React/Vite): «Mechanik 1 in Tafeln» und «Analysis I in Tafeln», veröffentlicht unter `/mechanik/` und `/analysis/`.
`/errors/` ist eine Meldungsübersicht, der Feedback-Dialog liegt auf jeder Seite. GitHub Pages baut alles über `.github/workflows/pages.yml`.

**Inhalt.** Fünf PDFs, je ein vollständiges Lernskript, aus Typst erzeugt:

| Fach | Datei | Seiten | Kapitel | Aufgabenteile | Anhang |
|---|---|---|---|---|---|
| Mechanik 1 | `mechanik1/Mechanik1_Lernskript.pdf` | 131 | 14 | 10 | Formelsammlung |
| Analysis 1 | `analysis1/Analysis1_Lernskript.pdf` | 106 | 5 | 5 | Formelsammlung |
| Lineare Algebra | `linalg1/Lineare_Algebra_Skript.pdf` | 130 | 14 | 14 | Formelsammlung und Rezepte |
| Informatik | `informatics1/Informatics_Script.pdf` | 163 | 14 | 14 | C++ Reference Sheet |
| Chemie | `chemistry1/Chemistry_Script.pdf` | 117 | 10 | 10 | Constants and Formula Sheet |

Es gibt keine einzelnen Übungsblätter oder Prüfungen. Die Dokumentarten stecken *in* den Büchern:
Kapitel (Theorie), «Aufgaben mit Lösungen» bzw. «Problems with solutions» am Kapitelende, und eine Formelsammlung im Anhang.
Alle PDFs haben saubere Lesezeichen: 684 Einträge auf bis zu vier Ebenen, mit Seitenzahlen.

**Was nicht funktioniert.**
1. *Das Dokument ist eine Blackbox.* Die Seite zeigt einen Umschlag und «131 Seiten · 5.3 MB». Was drinsteht, sieht man erst nach dem Herunterladen.
   684 Lesezeichen liegen ungenutzt in den Dateien.
2. *Man findet nichts.* Wer «Kettenlinie» oder «LR-Zerlegung» sucht, muss raten, welches Buch, 5 MB laden und blättern. Es gibt keine Suche.
3. *Aufgaben sind unsichtbar.* Gerade vor Prüfungen sucht man «Aufgaben mit Lösungen». Sie stehen in 53 Unterkapiteln verteilt, ohne jeden Hinweis auf der Seite.
4. *Kein Ort.* Ein Fach hat keine eigene Seite und keine Adresse. Man ist immer auf derselben Startseite, nur mit einem anderen markierten Umschlag.
5. *Die Geste wechselt.* Antippen eines Umschlags hat innerhalb eines Tages dreimal die Bedeutung gewechselt (herunterladen → wählen).
6. *Zwei Welten.* Bibliothek, Modelle und Tafeln sehen verschieden aus und verlinken kaum aufeinander.
7. *Handy.* Fünf Umschläge in Daumennagelgrösse, darunter grosse Bildkacheln. Für «schnell die Formelsammlung im Bus» drei Fehltritte.
8. *Kein Gedächtnis.* Wer gestern bis Kapitel 9 kam, fängt heute wieder bei null an.

## 2  Brief

**Wer, und was will er?** Studierende im ersten Jahr am D-MAVT, oft spät abends, oft auf dem iPad, manchmal im Zug am Handy.
- «Ich brauche die Aufgaben zu Kapitel 6 in Mechanik, jetzt.»
- «Wo stand nochmal die Hessesche Normalform?»
- «Ich will die Formelsammlung von Chemie ansehen, ohne 7 MB zu laden.»
- «Ich lerne seit drei Stunden. Weiter, wo ich war.»

**Die ersten fünf Sekunden.** Ruhig. Eine Suche, die man sofort benutzen kann. Darunter die fünf Fächer als Orte, jeder mit seiner Farbe.
Kein Werbetext, kein Hero-Bild. Man soll das Gefühl haben, eine gute Bibliothek betreten zu haben: es ist alles da, und man sieht, wo.

**Das Hauptobjekt.** Nicht die Datei, sondern das *Buch mit seinem Inhaltsverzeichnis*. Ein Skript wird gezeigt wie ein Buch auf dem Lesetisch:
Umschlag, Umfang, Sprache, und das vollständige Inhaltsverzeichnis mit Seitenzahlen. Jeder Eintrag hat eine Seitenvorschau
(die echte Seite als Bild) und öffnet das PDF genau dort. Aufgaben und Formelsammlung sind als eigene Art markiert und filterbar.

**Kürzester Weg.**
- Mit Suche: ⌘K / Strg+K (oder `/`), «kette» tippen, Enter → Mechanik, Abschnitt 13.1, Vorschau der Seite 114 → «Auf Seite 114 öffnen». Zwei Schritte.
- Ohne Suche: Startseite → Fach → «Aufgaben» → Eintrag. Drei Schritte, jeder sichtbar.
- Weiterlesen: die Startseite zeigt die zuletzt geöffneten Stellen. Ein Schritt.

## 3  Drei Richtungen

### A  Lesesaal
*Jedes Fach ist ein Raum.* Startseite: Suche und fünf Fächer als ruhige Reihen («Buchrücken»), jede mit ihrer Raumfarbe.
Fachseite: links das Inhaltsverzeichnis als Hauptnavigation, rechts mitlaufend die Vorschau der gewählten Seite.
Modelle und Tafeln stehen am Ende des Raums. Schrift: Literata (Lesen, Titel) und Atkinson Hyperlegible Next (Bedienung).
Farbe: Papierweiss und Tinte; pro Fach ein gedämpfter Ton aus seinem Umschlag. Dokument: Buch mit Inhaltsverzeichnis und Seitenvorschau.

### B  Zettelkatalog
*Ein einziger Katalog.* Keine Fachseiten. Die Startseite ist eine durchsuchbare, filterbare Liste aller 684 Einträge,
wie ein Karteikasten: Fach, Art, Kapitel als Filter oben, Treffer als dichte Zeilen. Schrift: eine Grotesk (Atkinson) in zwei Grössen,
Zahlen in Mono. Farbe: fast monochrom, Fach nur als kleines Kürzel. Dokument: eine Karteikarte pro Abschnitt.
Stark für Suchende, schwach für Orientierung: Man weiss nie, *wo* man ist, und es fühlt sich an wie eine Datenbank.

### C  Schreibtisch
*Die Seite ist dein Arbeitsplatz.* Startseite zeigt zuerst dich: Weiterlesen, angeheftete Abschnitte, «heute gelernt».
Fächer als Reiter am oberen Rand. Schrift: Serife für Inhalte, Grotesk für Werkzeuge. Farbe: neutral, ein Akzent.
Dokument: eine Leseliste. Persönlich und schnell für Wiederkehrer, aber leer und rätselhaft beim ersten Besuch, und nah am App-Dashboard.

### Entscheidung: A, mit der Suche aus B und dem Gedächtnis aus C
Der **Lesesaal** gibt jedem Fach einen Ort mit Adresse (`#mechanik`), einer Farbe und dem vollständigen Inhalt.
Das löst die Probleme 1, 3, 4 und 6. Vom **Zettelkatalog** übernehme ich die Suche über alle Einträge (⌘K), damit Problem 2 in zwei Schritten gelöst ist,
ohne dass die ganze Seite zur Datenbank wird. Vom **Schreibtisch** nur «Zuletzt geöffnet», lokal im Browser, als eine Zeile auf der Startseite (Problem 8).
Die Geste ist überall dieselbe: *Antippen zeigt, ein ausdrücklicher Knopf öffnet oder lädt* (Problem 5).

## 4  System

**Schrift.**
- *Literata* (variabel, mit optischer Grösse): Titel, Inhaltsverzeichnis, Erklärtexte. Für langes Lesen am Bildschirm gezeichnet, mit kräftigen Serifen, die auch nachts in Dunkel nicht zerfallen.
- *Atkinson Hyperlegible Next*: Bedienung, Metadaten, Filter. Vom Braille Institute für maximale Unterscheidbarkeit entworfen (Il1, 0O); genau das braucht man bei «1.7» gegen «7.1».
- *Atkinson Hyperlegible Mono*: nur Seitenzahlen und Abschnittsnummern, damit sie in Spalten stehen.
- Skala (rem): 0.8125 · 0.9375 · 1.0625 · 1.25 · 1.625 · 2.25 · 3.25.

**Farbe.** Licht: Papier `#fbfbf8`, Fläche `#ffffff`, Tinte `#17191c`, zwei Grautöne. Dunkel: kein Schwarz, sondern ein tiefes Schiefergrau `#141619`,
Flächen `#1b1e22`, Text `#e4e2dc` (gedämpft, blendet nachts nicht). Je Fach ein Raumton, abgeleitet vom Umschlag, in beiden Modi auf WCAG AA geprüft:
Mechanik Preussischblau, Analysis Tannengrün, Lineare Algebra Indigo, Informatik Ocker, Chemie Weinrot.
Farbe trägt nur zwei Bedeutungen: *welcher Raum* (Fach) und, in Figuren, *welche Grösse* (Geschwindigkeit blau, Kraft rot, Moment grün).

**Form.** Radius 2 px für Felder und Knöpfe, sonst 0. Keine Schatten ausser unter Dialogen. Haarlinien nur, wo sie Spalten oder Zeilen trennen.
Abstände in 4er-Schritten (4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96).

**Bewegung.** Keine Einblendungen beim Scrollen. Nur Rückmeldung auf Handlungen (Vorschau wechselt, Dialog öffnet), höchstens 150 ms, mit `prefers-reduced-motion` ganz aus.

## 5  Daten

`scripts/build_library.py` liest die PDFs und schreibt `assets/library/library.json` (Inhaltsverzeichnis mit Seiten und Art je Eintrag)
und Seitenvorschauen `assets/library/<fach>/p<NNN>.webp`. Nach jeder neuen PDF-Fassung einmal laufen lassen (siehe README).
