#import "lib.typ": *

= Lagerbindungen und Lagerkräfte

Lager sind die äußeren Bindungen von Trägern, Wellen und Tragwerken. Dieses Kapitel ist das handwerkliche Herz der Statik: Lager erkennen, freischneiden, Gleichgewicht ansetzen, auflösen.

== Körper auf ebener Unterlage, Standfestigkeit

Eine (reibungsfreie) Unterlage drückt mit verteilten Normalkräften auf die Berührungsfläche. Sie sind alle parallel und gleich gerichtet -- die Unterlage kann nur drücken, nicht ziehen. Ihre äquivalente Einzelkraft $vN$ muss deshalb *innerhalb der Standfläche* angreifen (genauer: innerhalb der kleinsten konvexen Fläche, die alle Berührungspunkte umschließt).

#defn[Standfestigkeit][
  Ein Körper heißt *standfest*, wenn er nicht kippt. Er ist es genau dann, wenn die Wirkungslinie der Resultierenden aller übrigen Kräfte (Gewicht und Lasten) die Standfläche durchstößt. Geht sie durch den Rand, steht der Körper an der Kippgrenze.
]

#fig(12.5, 3.6, pb: 0.4, caption: [Die Normalkraft muss genau gegenüber der Resultierenden aus Gewicht und Last liegen. Je stärker man seitlich drückt, desto weiter wandert sie zum Rand. Erreicht sie die Kante, kippt der Körper.],
  hatch((0.3,0.5),(4.2,0.5)), rct((1.2,0.5),(3.2,3.0)), pt((2.2,1.75)),
  arr((2.2,1.75),(2.2,0.75), c: cf, w: 1.3pt), arr((2.2,-0.3),(2.2,0.5), c: cf, w: 1.3pt), lbl((2.5,1.2), $vG$, c: cf), lbl((2.55,-0.1), $vN$, c: cf),
  hatch((4.6,0.5),(8.5,0.5)), rct((5.5,0.5),(7.5,3.0)), pt((6.5,1.75)),
  arr((6.5,1.75),(6.5,0.75), c: cf, w: 1.3pt), arr((4.7,2.7),(5.5,2.7), c: cf, w: 1.3pt), arr((7.1,-0.3),(7.1,0.5), c: cf, w: 1.3pt),
  lbl((6.8,1.2), $vG$, c: cf), lbl((4.8,3.0), $vF$, c: cf), lbl((7.45,-0.1), $vN$, c: cf),
  hatch((8.9,0.5),(12.8,0.5)), rct((9.8,0.5),(11.8,3.0)), pt((10.8,1.75)),
  arr((10.8,1.75),(10.8,0.75), c: cf, w: 1.3pt), arr((8.6,2.7),(9.8,2.7), c: cf, w: 1.3pt), arr((11.8,-0.3),(11.8,0.5), c: cf, w: 1.3pt),
  lbl((11.1,1.2), $vG$, c: cf), lbl((8.9,3.0), $vF$, c: cf), lbl((12.4,-0.1), [Kippgrenze], c: cf, size: 8pt),
)

== Lagertypen

Für jeden Lagertyp gilt die Regel aus Kapitel 8: *verhinderte Bewegung $<->$ Kraftkomponente*. Für ebene Probleme (Kräfte in der Zeichenebene) genügt diese Tabelle:

#let cell(..e) = align(center + horizon, sketch(3.0, 1.7, ..e))
#block(breakable: false, table(columns: (auto, 3.2cm, 3.2cm, 1fr), stroke: none, inset: (x: 6pt, y: 5pt), align: (left + horizon, center, center, left + horizon),
  table.hline(stroke: 0.6pt),
  [*Lager*], [*Symbol*], [*Lagerkräfte*], [*verhindert / Unbekannte*],
  table.hline(stroke: 0.3pt),
  [Auflager\ (Loslager,\ Rollenlager)],
    cell(beam((0.3,1.1),(2.7,1.1)), loslager((0.8,1.1), s: 0.3)),
    cell(beam((0.3,1.1),(2.7,1.1), c: cg), arr((0.8,0.1),(0.8,1.05), c: cf, w: 1.2pt), lbl((1.2,0.3), $A_y$, c: cf, size: 8pt)),
    [Verschiebung senkrecht zur Unterlage. *1 Unbekannte.* Einseitig, wenn nur aufgelegt: $A_y >= 0$ prüfen.],
  [Gelenk\ (Festlager)],
    cell(beam((0.3,1.1),(2.7,1.1)), festlager((0.8,1.1), s: 0.3)),
    cell(beam((0.3,1.1),(2.7,1.1), c: cg), arr((0.8,0.1),(0.8,1.05), c: cf, w: 1.2pt), arr((-0.1,1.1),(0.75,1.1), c: cf, w: 1.2pt), lbl((1.2,0.3), $A_y$, c: cf, size: 8pt), lbl((0.2,1.4), $A_x$, c: cf, size: 8pt)),
    [beide Verschiebungen, Drehung frei. *2 Unbekannte.*],
  [Einspannung],
    cell(beam((0.6,1.0),(2.7,1.0)), wand((0.6,1.0), hh: 1.1)),
    cell(beam((0.6,1.0),(2.7,1.0), c: cg), arr((0.6,0.05),(0.6,0.95), c: cf, w: 1.2pt), arr((-0.3,1.0),(0.55,1.0), c: cf, w: 1.2pt), arc((0.6,1.0), 0.45, 30, 150, col: cm, head: true, hs: 0.12), lbl((1.0,0.25), $A_y$, c: cf, size: 8pt), lbl((0.0,0.7), $A_x$, c: cf, size: 8pt), lbl((1.25,1.5), $M_A$, c: cm, size: 8pt)),
    [beide Verschiebungen und die Drehung. *3 Unbekannte* (2 Kräfte, 1 Moment).],
  [Pendelstütze,\ Seil],
    cell(beam((0.3,1.2),(2.7,1.2)), li((1.5,1.2),(2.1,0.2), s: 1pt + black), gelenk((1.5,1.2)), gelenk((2.1,0.2)), hatch((1.7,0.2),(2.5,0.2))),
    cell(beam((0.3,1.2),(2.7,1.2), c: cg), arr((2.0,0.35),(1.52,1.15), c: cf, w: 1.2pt), lbl((2.2,0.75), $S$, c: cf, size: 8pt)),
    [Verschiebung in Stabrichtung. *1 Unbekannte* längs des Stabs (Seil: nur Zug).],
  table.hline(stroke: 0.6pt),
))

Im Raum zählt man genauso:

#table(columns: (auto, 1fr, auto), stroke: none, inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 0.6pt),
  [*Lager (räumlich)*], [*verhindert*], [*Unbekannte*],
  table.hline(stroke: 0.3pt),
  [kurzes Querlager], [Verschiebungen quer zur Wellenachse; Achsverschiebung und alle Drehungen frei], [2 Kräfte],
  [Längslager], [Verschiebung in Achsrichtung (oft einseitig)], [1 Kraft],
  [langes Querlager], [Querverschiebungen und Schiefstellung der Achse], [2 Kräfte, 2 Momente],
  [Kugelgelenk], [alle drei Verschiebungen, alle Drehungen frei], [3 Kräfte],
  [Zylindergelenk (Scharnier)], [alles außer der Drehung um die Zapfenachse], [3 Kräfte, 2 Momente],
  [Einspannung], [alles], [3 Kräfte, 3 Momente],
  table.hline(stroke: 0.6pt),
)

#intu[
  Frag bei jedem Lager: «Wenn ich hier anfasse und schiebe oder drehe -- in welche Richtungen gibt es nach, in welche hält es dagegen?» Wo es dagegenhält, zeichnest du eine unbekannte Kraft (oder ein Moment) ein. Die Richtung des Pfeils darfst du raten: Kommt am Ende eine negative Zahl heraus, zeigt die Kraft in Wirklichkeit andersherum.
]

== Vorgehen zur Ermittlung der Lagerkräfte

#rezept[Lagerkräfte in acht Schritten][
  + *System abgrenzen.* Was genau ist «mein» System?
  + *Äußere Kräfte einführen:* Lasten (Gewicht im Schwerpunkt, verteilte Lasten durch ihre Ersatzkraft) und Lagerkräfte. Das Bild dazu heißt *Freischnitt*: das System allein, ohne Lager, nur mit Kräften.
  + *Basis* $ve_x, ve_y, ve_z$ und Koordinaten wählen.
  + *Abzählen:* Unbekannte $n$ gegen Gleichungen $m$ (eben: 3 pro Körper). Statisch bestimmt?
  + *Gleichgewichtsbedingungen* komponentenweise aufschreiben.
  + Wenn nötig: System *zerlegen* und die Schritte 1--5 für die Teile wiederholen.
  + *Auflösen.*
  + *Diskutieren:* Vorzeichen, Grenzfälle, Einheiten. Sind einseitige Bindungen eingehalten?
]

#merke[
  Die Kunst liegt in Schritt 5. Wähle den *Bezugspunkt der Momentenbedingung dort, wo sich möglichst viele unbekannte Kräfte schneiden* -- sie haben dort keinen Hebelarm und fallen heraus. Oft erhält man so pro Gleichung nur eine Unbekannte. In der Ebene darf man statt der zwei Komponentenbedingungen auch weitere Momentenbedingungen um andere Punkte verwenden; es bleiben aber immer nur *drei* unabhängige Gleichungen pro Körper.
]

#fig(13, 4.0, caption: [Vom System zum Freischnitt. Lager entfernen, Lagerkräfte dafür eintragen.],
  beam((1.0,2.4),(6.0,2.4)), festlager((1.0,2.4)), loslager((6.0,2.4)),
  arr((3.0,3.6),(3.0,2.5), c: cf, w: 1.4pt), lbl((3.3,3.4), $vF$, c: cf),
  bem((1.0,1.6),(3.0,1.6), $a$), bem((3.0,1.6),(6.0,1.6), $b$),
  lbl((0.75,2.7), $A$), lbl((6.25,2.7), $B$),
  beam((8.0,2.4),(13.0,2.4)),
  arr((10.0,3.6),(10.0,2.5), c: cf, w: 1.4pt), lbl((10.3,3.4), $vF$, c: cf),
  arr((8.0,1.3),(8.0,2.33), c: cf, w: 1.4pt), arr((7.0,2.4),(7.93,2.4), c: cf, w: 1.4pt), arr((13.0,1.3),(13.0,2.33), c: cf, w: 1.4pt),
  lbl((8.4,1.5), $A_y$, c: cf), lbl((7.2,2.7), $A_x$, c: cf), lbl((12.6,1.5), $B_y$, c: cf),
  axes((10.3,0.3), 0.8, 0.8),
)

#bsp[Balken auf zwei Stützen][
  Unbekannte: $A_x, A_y, B_y$ (3), Gleichungen: 3. Statisch bestimmt.
  $ sum X: quad A_x = 0, wide sum M_A: quad -a F + (a + b) B_y = 0, wide sum M_B: quad b F - (a + b) A_y = 0. $
  $ => quad B_y = a / (a + b) F, wide A_y = b / (a + b) F. $
  Kontrolle: $A_y + B_y = F$ ✓. Deutung: Das Lager, das _näher_ an der Last ist, trägt den größeren Teil. Steht die Last direkt über $A$ ($a = 0$), trägt $A$ alles.
]

#bsp[Kragarm mit Gleichlast][
  Ein Balken der Länge $L$ ist links eingespannt und trägt die Gleichlast $q_0$. Ersatzkraft: $q_0 L$ in der Mitte. Unbekannte: $A_x, A_y, M_A$.
  $ A_x = 0, wide A_y = q_0 L, wide M_A - L/2 dot.c q_0 L = 0 quad => quad M_A = (q_0 L^2) / 2. $
  Die Einspannung muss ein Moment aufbringen, weil sonst nichts die Drehung um $A$ verhindert.
]

== Statische Bestimmtheit

#defn[Statisch bestimmt, unbestimmt][
  Sei $n$ die Anzahl unbekannter Lagerkraftkomponenten und $m$ die Anzahl unabhängiger Gleichgewichtsbedingungen. Für $m = n$ (und eindeutig lösbares Gleichungssystem) heißt das Problem *statisch bestimmt*. Für $m < n$ ist es *statisch unbestimmt*: Die Statik allein reicht nicht, man braucht zusätzlich die Verformungen. Für $m > n$ ist das System beweglich (Mechanismus) und nur für spezielle Lasten in Ruhe.
]

Physikalisch: Ein System ist statisch bestimmt gelagert, wenn es gerade so viele Bindungen hat, dass es sich nicht mehr bewegen kann. Jede weitere Bindung ist «überzählig»; löst man in Gedanken $u$ Bindungskomponenten, bis das System gerade noch unbeweglich ist, so ist es *$u$-fach statisch unbestimmt*.

#fig(13.4, 2.6, caption: [Links statisch bestimmt (3 Unbekannte). Mitte: zwei Gelenke, 4 Unbekannte, einfach unbestimmt. Rechts: Einspannung plus Auflager, 4 Unbekannte, einfach unbestimmt.],
  beam((0.5,1.6),(3.7,1.6)), festlager((0.5,1.6)), loslager((3.7,1.6)), lbl((2.1,0.4), $n = 3$, size: 8.5pt),
  beam((5.0,1.6),(8.2,1.6)), festlager((5.0,1.6)), festlager((8.2,1.6)), lbl((6.6,0.4), $n = 4$, size: 8.5pt),
  beam((9.8,1.6),(13.0,1.6)), wand((9.8,1.6), hh: 1.0), loslager((13.0,1.6)), lbl((11.4,0.4), $n = 4$, size: 8.5pt),
)

== Ergänzungen

=== Lagerkraft oder Lagerreaktion?

Die *Lagerkraft* ist die Kraft, die das Lager _auf den Träger_ ausübt -- das ist, was wir im Freischnitt des Trägers eintragen. Die *Lagerreaktion* ist ihre Gegenkraft, die der Träger auf das Lager (das Fundament) ausübt. Für die Dimensionierung des Fundaments braucht man die zweite; sie ist gleich groß und entgegengesetzt.

=== Federn und nachgiebige Lager

Eine lineare Feder mit *Federkonstante* $k$ (N/m) übt bei der Längenänderung $Delta x$ gegenüber ihrer ungespannten Länge die Kraft
#gl($ F = k Delta x $)
aus, immer so gerichtet, dass sie in die ungespannte Länge zurückwill. Eine Drehfeder liefert entsprechend ein Moment $M = k_phi Delta phi$. Ein elastisch nachgiebiges Lager ist nichts anderes als ein Lager mit Feder: Die Lagerkraft ist dann keine freie Unbekannte mehr, sondern durch die Einsenkung bestimmt.

=== Die Ruhelage ist gesucht

Manchmal sind nicht die Kräfte unbekannt, sondern die Lage selbst (ein Winkel, eine Auslenkung). Das Vorgehen bleibt gleich: Man schreibt die Gleichgewichtsbedingungen in einer _allgemeinen_ Lage mit dem unbekannten Winkel $phi$ auf. Die Gleichungen bestimmen dann $phi$ zusammen mit den Lagerkräften -- oft als trigonometrische Gleichung.

#fehler[
  - Lagerkräfte vergessen oder zu viele eintragen. Ein Loslager hat _eine_ Unbekannte, nicht zwei.
  - Im Freischnitt die Lager stehen lassen. Lager _oder_ Lagerkräfte, nie beides.
  - Das Einspannmoment vergessen.
  - Bei verteilten Lasten die Ersatzkraft am falschen Ort ansetzen (Dreieck: $2\/3$ von der Spitze).
  - Mehr als drei Gleichungen pro ebenem Körper aufstellen und sich wundern, dass sie nichts Neues bringen.
]

#kurz[
  - Loslager 1, Gelenk 2, Einspannung 3 Unbekannte (eben).
  - Freischnitt, Gleichgewicht: $sum X = 0$, $sum Y = 0$, $sum M = 0$.
  - Momentenbezugspunkt dort wählen, wo viele Unbekannte durchgehen.
  - Statisch bestimmt: $n = m$. Sonst unbestimmt ($n > m$) oder beweglich ($n < m$).
  - Standfest, solange die Resultierende die Standfläche trifft.
]
