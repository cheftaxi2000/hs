#import "lib.typ": *

= Statisch bestimmte Fachwerke

Fachwerke sind Tragwerke aus Stäben, die in *Knoten* verbunden sind: Brücken, Kräne, Dachbinder, Strommasten. Sie sind leicht und trotzdem steif, weil ihre Stäbe fast nur auf Zug oder Druck beansprucht werden -- die Belastungsart, die Material am besten ausnutzt.

== Ideale Fachwerke und Pendelstützen

#defn[Ideales Fachwerk][
  Ein *ideales Fachwerk* erfüllt:
  - die Stäbe sind gerade und gewichtslos,
  - sie sind an ihren Enden durch *reibungsfreie Gelenke* (Knoten) verbunden,
  - alle Lasten greifen *nur in den Knoten* an (Knotenlasten).
]

Schneidet man einen einzelnen Stab frei, greifen an ihm nur zwei Kräfte an, je eine an jedem Ende. Nach Kapitel 6 können zwei Kräfte nur im Gleichgewicht sein, wenn sie auf derselben Wirkungslinie liegen:

#satz[Pendelstütze][
  Ein gewichtsloser, an beiden Enden reibungsfrei gelenkig gelagerter und nur dort belasteter Stab (*Pendelstütze*) überträgt nur eine Kraft *in Stabrichtung*, die *Stabkraft* $S$. Vereinbarung:
  $ S > 0: quad "Zugstab", wide S < 0: quad "Druckstab". $
]

#fig(12.5, 2.5, caption: [Vorzeichenkonvention. Man trägt jede Stabkraft als Zug ein: Am freigeschnittenen Knoten zeigt der Pfeil _vom Knoten weg_. Ergibt die Rechnung $S < 0$, ist es ein Druckstab.],
  beam((1.0,1.3),(4.0,1.3)), gelenk((1.0,1.3)), gelenk((4.0,1.3)),
  arr((1.0,1.3),(0.0,1.3), c: cf, w: 1.3pt), arr((4.0,1.3),(5.0,1.3), c: cf, w: 1.3pt),
  lbl((2.5,0.7), [Zugstab: $S > 0$], size: 8.5pt), lbl((0.3,1.65), $S$, c: cf), lbl((4.7,1.65), $S$, c: cf),
  pt((9.0,1.3), r: 0.08), li((9.0,1.3),(9.5,1.3), s: 2.4pt + cg), li((9.0,1.3),(9.35,1.65), s: 2.4pt + cg),
  arr((9.6,1.3),(10.7,1.3), c: cf, w: 1.3pt), arr((9.42,1.72),(10.2,2.5), c: cf, w: 1.3pt), arr((9.0,2.4),(9.0,1.4), c: cf, w: 1.3pt),
  lbl((10.9,1.0), $S_1$, c: cf), lbl((10.5,2.4), $S_2$, c: cf), lbl((8.65,2.2), $vF$, c: cf), lbl((9.6,0.5), [Knoten freigeschnitten], size: 8.5pt),
)

#intu[
  Ein Stab mit zwei Gelenken kann weder etwas quer zu sich abstützen noch verdrehen -- er würde einfach um sein Gelenk schwenken. Er kann nur ziehen oder schieben, wie ein Seil, das zusätzlich auch drücken darf. Das macht Fachwerke so einfach: Pro Stab gibt es genau _eine_ Unbekannte.
]

== Abzählen: statische Bestimmtheit

Mit $s$ Stäben, $r$ Lagerkraftkomponenten und $k$ Knoten hat man $s + r$ Unbekannte und pro Knoten zwei (eben) bzw. drei (räumlich) Gleichgewichtsbedingungen:
#gl($ u = s + r - 2k quad ("eben"), wide u = s + r - 3k quad ("räumlich"). $)
$u = 0$ ist notwendig für statische Bestimmtheit (aber wie in Kapitel 10 nicht hinreichend). Das Grundbauelement ist das Dreieck: Es ist die einfachste in sich unverschiebliche Stabfigur. Jeder weitere Knoten, der mit zwei neuen Stäben angeschlossen wird, erhält die Bestimmtheit.

== Knotengleichgewicht

Jeder Knoten wird freigeschnitten. An ihm greifen die Stabkräfte der anschließenden Stäbe (alle als Zug, vom Knoten weg), eventuelle Knotenlasten und Lagerkräfte an. Alle Wirkungslinien gehen durch den Knoten, die Momentenbedingung ist also von selbst erfüllt; es bleiben $sum X = 0$ und $sum Y = 0$.

#rezept[Knotengleichgewicht][
  + Lagerkräfte am Gesamtfachwerk bestimmen (drei Gleichungen).
  + Mit einem Knoten beginnen, an dem höchstens *zwei* unbekannte Stabkräfte angreifen.
  + $sum X = 0$, $sum Y = 0$ liefern diese beiden. Zum nächsten Knoten mit höchstens zwei Unbekannten weitergehen.
  + Die letzten Knoten liefern Kontrollgleichungen.
]

#fig(13.4, 4.0, caption: [Beispielfachwerk: 7 Stäbe, 5 Knoten, 3 Lagerkomponenten, $u = 7 + 3 - 10 = 0$. Rechts der Ritter-Schnitt durch die Stäbe 2, 3 und 6 (linker Teil).],
  li((0.8,0.9),(2.2,2.3)), li((2.2,2.3),(3.6,0.9)), li((3.6,0.9),(5.0,2.3)), li((5.0,2.3),(6.4,0.9)), li((0.8,0.9),(6.4,0.9)), li((2.2,2.3),(5.0,2.3)),
  festlager((0.8,0.9), s: 0.28), loslager((6.4,0.9), s: 0.28), gelenk((2.2,2.3)), gelenk((3.6,0.9)), gelenk((5.0,2.3)),
  arr((3.6,0.8),(3.6,-0.1), c: cf, w: 1.3pt), lbl((3.95,0.1), $vF$, c: cf),
  lbl((0.5,1.2), $A$), lbl((6.7,1.2), $B$), lbl((3.6,1.25), $C$), lbl((2.0,2.6), $D$), lbl((5.2,2.6), $E$),
  lbl((1.3,1.8), $1$, size: 8pt, c: cg), lbl((2.2,0.7), $2$, size: 8pt, c: cg), lbl((3.1,1.75), $3$, size: 8pt, c: cg), lbl((4.1,1.75), $4$, size: 8pt, c: cg), lbl((5.0,0.7), $5$, size: 8pt, c: cg), lbl((3.6,2.55), $6$, size: 8pt, c: cg), lbl((5.9,1.8), $7$, size: 8pt, c: cg),
  bem((0.8,3.0),(2.2,3.0), $a$, off: 0.2), bem((0.3,0.9),(0.3,2.3), $a$, off: 0.2),
  // Schnitt
  li((8.0,0.9),(9.4,2.3)), li((8.0,0.9),(9.6,0.9)), li((9.4,2.3),(9.9,2.3)), li((9.4,2.3),(9.75,1.95)), gelenk((9.4,2.3)), pt((8.0,0.9)),
  arr((8.0,-0.2),(8.0,0.8), c: cf, w: 1.3pt), lbl((8.55,0.0), $F\/2$, c: cf),
  arr((10.0,2.3),(11.0,2.3), c: cf, w: 1.3pt), arr((9.8,1.9),(10.5,1.2), c: cf, w: 1.3pt), arr((9.7,0.9),(10.7,0.9), c: cf, w: 1.3pt),
  lbl((11.3,2.3), $S_6$, c: cf), lbl((10.8,1.25), $S_3$, c: cf), lbl((11.0,0.9), $S_2$, c: cf),
  pt((10.8,0.9), r: 0.07, c: cm), lbl((11.6,0.5), [$C$: Bezugspunkt], c: cm, size: 8pt),
  dl((9.5,3.0),(10.1,0.3), c: cv),
  pb: 0.3,
)

#bsp[Knotengleichgewicht][
  Untergurt $A(0,0)$, $C(2a,0)$, $B(4a,0)$; Obergurt $D(a,a)$, $E(3a,a)$. Last $F$ nach unten in $C$. Lager: $A_x = 0$, $A_y = B_y = F\/2$.

  _Knoten $A$_ (Stäbe 1 nach $D$ unter 45°, 2 nach $C$):
  $ sum Y: quad F/2 + S_1/sqrt(2) = 0 quad => quad S_1 = -F/sqrt(2), wide sum X: quad S_2 + S_1/sqrt(2) = 0 quad => quad S_2 = F/2. $
  _Knoten $D$_ (Stäbe 1, 3 nach $C$, 6 nach $E$):
  $ sum Y: quad -S_1/sqrt(2) - S_3/sqrt(2) = 0 quad => quad S_3 = F/sqrt(2), wide sum X: quad -S_1/sqrt(2) + S_3/sqrt(2) + S_6 = 0 quad => quad S_6 = -F. $
  Aus Symmetrie: $S_4 = S_3$, $S_5 = S_2$, $S_7 = S_1$. Kontrolle am Knoten $C$: $sum Y = S_3\/sqrt(2) + S_4\/sqrt(2) - F = 0$ ✓.

  Deutung: Der Obergurt (6) und die äußeren Diagonalen (1, 7) sind gedrückt, der Untergurt (2, 5) und die inneren Diagonalen (3, 4) gezogen -- wie bei einem Balken, der sich durchbiegt: oben Druck, unten Zug.
]

=== Nullstäbe erkennen

Stäbe mit $S = 0$ heißen *Nullstäbe*. Man findet sie oft ohne Rechnung:
- *Unbelasteter Knoten mit zwei Stäben*, die nicht in einer Linie liegen: beide sind Nullstäbe.
- *Unbelasteter Knoten mit drei Stäben*, von denen zwei in einer Linie liegen: Der dritte ist ein Nullstab.
- *Belasteter Knoten mit zwei Stäben*, Last in Richtung des einen Stabs: Der andere ist ein Nullstab.
Nullstäbe sind nicht überflüssig. Sie verhindern, dass das Fachwerk bei anderer Last oder kleinen Störungen beweglich wird.

== Dreikräfteschnitt (Ritter-Schnitt)

Will man nur einzelne Stabkräfte, ist es mühsam, sich Knoten für Knoten vorzuarbeiten. Schneller ist ein Schnitt durch das ganze Fachwerk.

#rezept[Dreikräfteschnitt][
  + Lagerkräfte bestimmen.
  + Das Fachwerk durch einen Schnitt in zwei Teile trennen, der *drei Stäbe* durchtrennt, die *nicht alle vom selben Knoten* ausgehen.
  + Einen der beiden Teile freischneiden; die drei Stabkräfte als Zug eintragen.
  + Für jede gesuchte Stabkraft die *Momentenbedingung um den Schnittpunkt der beiden anderen* Stäbe ansetzen. Sind die beiden anderen parallel, nimmt man stattdessen die Komponentenbedingung senkrecht zu ihnen.
]

#bsp[Stabkraft 6 direkt][
  Schnitt durch die Stäbe 2, 3, 6, linker Teil (Abb. rechts). Die Stäbe 2 und 3 schneiden sich in $C$. Momentenbedingung um $C$: Die Lagerkraft $F\/2$ in $A$ hat den Hebelarm $2a$ (dreht im Uhrzeigersinn), $S_6$ wirkt in $D$ auf der Höhe $a$ über $C$ nach rechts (dreht ebenfalls im Uhrzeigersinn):
  $ -2a dot.c F/2 - a S_6 = 0 quad => quad S_6 = -F. $
  Dasselbe wie oben, in einer Zeile.
]

== PdvL am Fachwerk

Entfernt man den Stab mit der gesuchten Kraft und ersetzt ihn durch die beiden Kräfte $S$ an seinen Endknoten, wird das statisch bestimmte Fachwerk zu einem Mechanismus mit einem Freiheitsgrad. Man bestimmt für eine zulässige virtuelle Bewegung die Geschwindigkeiten der belasteten Knoten und der beiden Endknoten des entfernten Stabs (Momentanzentren der starr bleibenden Teilfachwerke!) und setzt $tilde(PP) = 0$. Der Aufwand lohnt sich, wenn die Kinematik einfach ist.

== Räumliche Fachwerke

Alles überträgt sich: Knotengleichgewicht mit drei Gleichungen pro Knoten ($sum X = sum Y = sum Z = 0$), Beginn an einem Knoten mit höchstens drei Unbekannten. Die Komponenten einer Stabkraft erhält man, indem man $S$ mit dem Einheitsvektor in Stabrichtung multipliziert:
$ vS = S (arrow(P Q)) / (|arrow(P Q)|) wide ("Stab von Knoten" P "nach" Q, "Kraft auf Knoten" P). $
Die räumliche Grundfigur ist das Tetraeder.

#fehler[
  - Stabkräfte am Knoten mal als Zug, mal als Druck eintragen und die Vorzeichen durcheinanderbringen. Immer als Zug ansetzen.
  - Lasten auf Stabmitte: Dann ist es kein ideales Fachwerk mehr, der Stab wird gebogen.
  - Ritter-Schnitt durch drei Stäbe, die sich in einem Knoten treffen: liefert nichts.
]

#kurz[
  - Ideales Fachwerk: gelenkige Knoten, Lasten nur in Knoten, Stäbe sind Pendelstützen.
  - Eine Unbekannte pro Stab; $S > 0$ Zug, $S < 0$ Druck.
  - $u = s + r - 2k$ (eben), $u = s + r - 3k$ (räumlich).
  - Knotengleichgewicht für alle Stabkräfte, Ritter-Schnitt für einzelne.
]
