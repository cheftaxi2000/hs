#import "lib.typ": *

= Lagerbindungen und Lagerkräfte

Lager sind die äußeren Bindungen von Trägern, Wellen und Tragwerken. Dieses Kapitel ist das handwerkliche Herz der Statik: Lager erkennen, Lagerkräfte einzeichnen, Gleichgewicht ansetzen, auflösen. Nach dem letzten Kapitel wissen wir _warum_ das funktioniert; jetzt üben wir _wie_.

== Körper auf ebener Unterlage, Standfestigkeit

Eine reibungsfreie Unterlage drückt mit verteilten Normalkräften auf die Berührungsfläche. Sie sind alle parallel und gleich gerichtet: Die Unterlage kann nur drücken, nicht ziehen. Ihre äquivalente Einzelkraft $vN$ (Kapitel 7: Kräftemittelpunkt) muss deshalb *innerhalb der Standfläche* angreifen, genauer: innerhalb der kleinsten konvexen Fläche, die alle Berührungspunkte umschließt.

#defn[Standfestigkeit][
  Ein Körper auf einer Unterlage heißt *standfest*, wenn er nicht kippt. Das ist genau dann der Fall, wenn die Wirkungslinie der Resultierenden aller übrigen Kräfte (Gewicht, Lasten) die Standfläche durchstößt. Geht sie durch den Rand, steht der Körper an der Kippgrenze.
]

#fg("k09_standfest", [Die Normalkraft liegt immer genau gegenüber der Resultierenden aus Gewicht und Last. Je stärker man seitlich drückt, desto weiter wandert $vN$ zum Rand. Erreicht sie die Kante, kippt der Körper.])

#intu[
  Eine Kiste, die du seitlich anschiebst, drückt ihre Last immer stärker auf die vordere Kante. Die Unterlage kann nur dort drücken, wo Kontakt ist, also muss die Gegenkraft $vN$ nach vorne wandern, um das Kippmoment aufzufangen. Wenn sie die Kante erreicht, ist kein Platz mehr, und die Kiste kippt.
]

== Lagertypen

Für jedes Lager gilt die Regel aus Kapitel 8: *verhinderte Bewegung $<->$ Kraftkomponente*. Für ebene Probleme (alle Kräfte in der Zeichenebene) genügt diese Übersicht.

#fg("k09_lager", [Die vier wichtigsten Lager für ebene Probleme. Oben das Lager mit Symbol, unten der Träger «freigeschnitten» mit den Lagerkräften, die das Lager auf ihn ausübt. Die Zahl der Unbekannten entspricht der Zahl der verhinderten Bewegungsmöglichkeiten.])

#table(columns: (auto, 1fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [*Loslager* (Auflager)], [verhindert die Verschiebung senkrecht zur Unterlage. Die Unterlage kann nur drücken (einseitig). *1 Unbekannte*.],
  [*Festlager* (Gelenk)], [verhindert beide Verschiebungen, die Drehung bleibt frei: kein Moment. *2 Unbekannte*.],
  [*Einspannung*], [verhindert alle Bewegungen des Trägerquerschnitts: zwei Verschiebungen und die Drehung. *3 Unbekannte* (2 Kräfte, 1 Moment).],
  [*Pendelstütze*, Seil], [ein Stab mit zwei Gelenken: verhindert die Verschiebung in Stabrichtung. *1 Unbekannte* längs des Stabs (beim Seil nur Zug).],
  table.hline(stroke: 0.7pt),
)

Im Raum zählt man genauso:

#table(columns: (auto, 1fr, auto), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [*Lager (räumlich)*], [*verhindert*], [*Unbekannte*],
  table.hline(stroke: 0.4pt),
  [kurzes Querlager], [Verschiebungen quer zur Wellenachse; Achsverschiebung und alle Drehungen frei], [2 Kräfte],
  [Längslager], [Verschiebung in Achsrichtung (oft einseitig)], [1 Kraft],
  [langes Querlager], [Querverschiebungen und Schiefstellung der Achse], [2 Kräfte, 2 Momente],
  [Kugelgelenk], [alle drei Verschiebungen, alle Drehungen frei], [3 Kräfte],
  [Zylindergelenk (Scharnier)], [alles außer der Drehung um die Zapfenachse], [3 Kräfte, 2 Momente],
  [Einspannung], [alles], [3 Kräfte, 3 Momente],
  table.hline(stroke: 0.7pt),
)

#intu[
  Frag bei jedem Lager: «Wenn ich hier anfasse und schiebe oder drehe: In welche Richtungen gibt es nach, in welche hält es dagegen?» Wo es dagegenhält, zeichnest du eine unbekannte Kraft (oder ein Moment) ein. Die Pfeilrichtung darfst du raten. Kommt am Ende eine negative Zahl heraus, zeigt die Kraft in Wirklichkeit in die Gegenrichtung.
]

== Vorgehen zur Ermittlung der Lagerkräfte

#rezept[Lagerkräfte in acht Schritten][
  + *System abgrenzen.* Was genau ist «mein» System?
  + *Äußere Kräfte einführen:* Lasten (Gewicht im Schwerpunkt, verteilte Lasten durch ihre Ersatzkraft) und Lagerkräfte. Das Bild dazu heißt *Freischnitt*: das System allein, ohne Lager, nur mit Kräften.
  + *Basis* $ve_x, ve_y, ve_z$ und Koordinaten wählen.
  + *Abzählen:* Unbekannte $n$ gegen Gleichungen $m$ (eben: 3 pro Körper). Statisch bestimmt?
  + *Gleichgewichtsbedingungen* komponentenweise aufschreiben.
  + Wenn nötig: System *zerlegen* und die Schritte 1 bis 5 für die Teile wiederholen.
  + *Auflösen.*
  + *Diskutieren:* Vorzeichen, Grenzfälle, Einheiten. Sind einseitige Bindungen eingehalten?
]

#fg("k09_freischnitt", [Vom System zum Freischnitt: Lager entfernen, Lagerkräfte dafür eintragen. Bei $A$ ein Festlager (2 Kräfte), bei $B$ ein Loslager (1 Kraft).])

#merke[
  Die Kunst liegt in Schritt 5. Wähle den *Bezugspunkt der Momentenbedingung dort, wo sich möglichst viele unbekannte Kräfte schneiden*: Sie haben dort keinen Hebelarm und fallen heraus. Oft erhält man so pro Gleichung nur eine Unbekannte. In der Ebene darf man statt der zwei Komponentenbedingungen auch weitere Momentenbedingungen um andere Punkte verwenden; es bleiben aber immer nur *drei* unabhängige Gleichungen pro Körper.
]

#bsp[Balken auf zwei Stützen][
  Ein Balken der Länge $L = a + b$, in $A$ gelenkig und in $B$ auf einem Loslager, trägt im Abstand $a$ von $A$ die Last $F$. Unbekannte: $A_x, A_y, B_y$ (3), Gleichungen: 3. Statisch bestimmt.
  $ sum X: quad A_x = 0, wide sum M_A: quad -a F + (a + b) B_y = 0, wide sum M_B: quad b F - (a + b) A_y = 0. $
  $ => quad B_y = a / (a + b) F, wide A_y = b / (a + b) F. $
  _Kontrolle:_ $A_y + B_y = F$ ✓. _Deutung:_ Das Lager, das näher an der Last liegt, trägt den größeren Teil. Steht die Last direkt über $A$ ($a = 0$), trägt $A$ alles. Außerdem muss $B_y >= 0$ sein, weil das Loslager nur drücken kann; das ist hier für $F > 0$ erfüllt.
]

#bsp[Kragarm mit Gleichlast][
  Ein Balken der Länge $L$ ist links eingespannt und trägt die Gleichlast $q_0$. Ersatzkraft $q_0 L$ in der Mitte. Unbekannte: $A_x, A_y, M_A$.
  $ A_x = 0, wide A_y = q_0 L, wide M_A - (L\/2) dot.c q_0 L = 0 quad => quad M_A = (q_0 L^2) / 2. $
  Die Einspannung muss ein Moment aufbringen, weil sonst nichts die Drehung um $A$ verhindert.
]

== Statische Bestimmtheit

#defn[Statisch bestimmt, unbestimmt][
  Sei $n$ die Anzahl der unbekannten Lagerkraftkomponenten und $m$ die Anzahl unabhängiger Gleichgewichtsbedingungen. Für $m = n$ (und eindeutig lösbares Gleichungssystem) heißt das Problem *statisch bestimmt*. Für $m < n$ ist es *statisch unbestimmt*: Die Statik allein reicht nicht, man braucht zusätzlich die Verformungen. Für $m > n$ ist das System beweglich und nur für spezielle Lasten in Ruhe.
]

Physikalisch: Ein System ist statisch bestimmt gelagert, wenn es gerade so viele Bindungen hat, dass es sich nicht mehr bewegen kann. Jede weitere Bindung ist «überzählig». Löst man in Gedanken $u$ Bindungskomponenten, bis das System gerade noch unbeweglich ist, so ist es *$u$-fach statisch unbestimmt*.

#fg("k09_bestimmt", [Links statisch bestimmt (3 Unbekannte). Mitte: zwei Gelenke, 4 Unbekannte, einfach unbestimmt (die horizontale Kraft kann beliebig auf die zwei Gelenke verteilt werden). Rechts: Einspannung plus Auflager, 4 Unbekannte, einfach unbestimmt.])

== Ergänzungen

=== Lagerkraft oder Lagerreaktion?

Die *Lagerkraft* ist die Kraft, die das Lager _auf den Träger_ ausübt; sie tragen wir im Freischnitt des Trägers ein. Die *Lagerreaktion* ist ihre Gegenkraft, die der Träger auf das Lager (das Fundament) ausübt. Für die Dimensionierung des Fundaments braucht man die zweite; sie ist gleich groß und entgegengesetzt.

=== Federn und nachgiebige Lager

Eine lineare Feder mit *Federkonstante* $k$ (N/m) übt bei der Längenänderung $Delta x$ gegenüber ihrer ungespannten Länge die Kraft
#gl($ F = k Delta x $)
aus, so gerichtet, dass sie in die ungespannte Länge zurückwill. Eine Drehfeder liefert entsprechend ein Moment $M = k_phi Delta phi$. Ein elastisch nachgiebiges Lager ist ein Lager mit Feder: Die Lagerkraft ist dann keine freie Unbekannte mehr, sondern durch die Einsenkung bestimmt. Damit bekommt man zusätzliche Gleichungen, die auch statisch unbestimmte Probleme lösbar machen (Beispiel: Feder zwischen zwei Stäben, Kapitel 10).

=== Gesucht ist die Ruhelage

Manchmal sind nicht die Kräfte unbekannt, sondern die Lage selbst (ein Winkel, eine Auslenkung). Das Vorgehen bleibt gleich: Man schreibt die Gleichgewichtsbedingungen in einer _allgemeinen_ Lage mit dem unbekannten Winkel $phi$ auf. Die Gleichungen bestimmen dann $phi$ zusammen mit den Lagerkräften, oft als trigonometrische Gleichung.

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
