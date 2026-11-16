#import "lib.typ": *

= Statisch bestimmte Fachwerke

Fachwerke sind Tragwerke aus Stäben, die in *Knoten* verbunden sind: Brücken, Kräne, Dachbinder, Strommasten. Sie sind leicht und trotzdem steif, weil ihre Stäbe fast nur auf Zug oder Druck beansprucht werden, die Belastungsart, die das Material am besten ausnutzt. Für die Statik haben Fachwerke einen riesigen Vorteil: Man kann sie mit sehr einfachen Mitteln vollständig berechnen.

== Ideale Fachwerke und Pendelstützen

#defn[Ideales Fachwerk][
  Ein *ideales Fachwerk* erfüllt:
  - die Stäbe sind gerade und gewichtslos,
  - sie sind an ihren Enden durch *reibungsfreie Gelenke* (die Knoten) verbunden,
  - alle Lasten greifen *nur in den Knoten* an (Knotenlasten).
]

Diese Voraussetzungen idealisieren die Wirklichkeit: Echte Knoten sind oft geschweißt oder genietet und übertragen auch ein wenig Biegemoment, und Stäbe haben Eigengewicht. Für die Frage «Welche Kräfte tragen die Stäbe?» ist das Modell aber meist genau genug.

Schneidet man einen einzelnen Stab frei, greifen an ihm nur zwei Kräfte an, je eine an jedem Ende. Nach Kapitel 6 können zwei Kräfte nur im Gleichgewicht sein, wenn sie auf derselben Wirkungslinie liegen, also auf der Stabachse:

#satz[Pendelstütze][
  Ein gewichtsloser, an beiden Enden reibungsfrei gelenkig gelagerter und nur dort belasteter Stab (*Pendelstütze*) überträgt nur eine Kraft *in Stabrichtung*, die *Stabkraft* $S$. Vereinbarung:
  $ S > 0: quad "Zugstab", wide S < 0: quad "Druckstab". $
  Ein ideales Fachwerk besteht ausschließlich aus Pendelstützen.
]

#fg("k11_stab", [Links: Zug- und Druckstab. Rechts: Am freigeschnittenen Knoten trägt man jede Stabkraft als Zug ein, also vom Knoten weg. Ergibt die Rechnung $S < 0$, ist der Stab ein Druckstab.])

#intu[
  Ein Stab mit zwei Gelenken kann weder etwas quer zu sich abstützen noch verdrehen: Er würde einfach um sein Gelenk schwenken. Er kann nur ziehen oder schieben, wie ein Seil, das zusätzlich auch drücken darf. Das macht Fachwerke so einfach: Pro Stab gibt es genau _eine_ Unbekannte.
]

== Abzählen: statische Bestimmtheit

Mit $s$ Stäben, $r$ Lagerkraftkomponenten und $k$ Knoten hat man $s + r$ Unbekannte. Pro Knoten stehen zwei (eben) bzw. drei (räumlich) Gleichgewichtsbedingungen zur Verfügung, denn alle Kräfte am Knoten gehen durch ihn (die Momentenbedingung ist automatisch erfüllt). Also:
#gl($ u = s + r - 2k quad ("eben"), wide u = s + r - 3k quad ("räumlich"). $)
$u = 0$ ist notwendig für statische Bestimmtheit (aber wie in Kapitel 10 nicht hinreichend). Für das Beispiel unten: $s = 7$, $r = 3$ (zwei Kräfte im Gelenk, eine im Loslager), $k = 5$, also $u = 7 + 3 - 10 = 0$.

Das Grundbauelement ist das *Dreieck*: die einfachste in sich unverschiebliche Stabfigur (ein Viereck aus Stäben ist ein Mechanismus). Jeder weitere Knoten, der mit zwei neuen Stäben an bestehende Knoten angeschlossen wird, erhält die Bestimmtheit.

== Knotengleichgewicht

Jeder Knoten wird freigeschnitten. An ihm greifen die Stabkräfte der anschließenden Stäbe an (alle als Zug, vom Knoten weg), eventuell eine Knotenlast und Lagerkräfte. Alle Wirkungslinien gehen durch den Knoten; es bleiben $sum X = 0$ und $sum Y = 0$.

#rezept[Knotengleichgewicht][
  + Lagerkräfte am Gesamtfachwerk bestimmen (drei Gleichungen).
  + Mit einem Knoten beginnen, an dem höchstens *zwei* unbekannte Stabkräfte angreifen.
  + $sum X = 0$ und $sum Y = 0$ liefern diese beiden. Zum nächsten Knoten mit höchstens zwei Unbekannten weitergehen.
  + Die letzten Knoten liefern Kontrollgleichungen.
]

#fg("k11_fachwerk", [Beispielfachwerk: 7 Stäbe, 5 Knoten, 3 Lagerkomponenten, $u = 0$. Die Last $vF$ greift in $C$ an. Rechts der freigeschnittene linke Teil für den Ritter-Schnitt durch die Stäbe 2, 3 und 6.])

#bsp[Knotengleichgewicht][
  Koordinaten (mit $a$ als Maßeinheit): $A(0, 0)$, $C(2a, 0)$, $B(4a, 0)$, $D(a, a)$, $E(3a, a)$. Last $F$ nach unten in $C$.

  _Lagerkräfte:_ Momentenbedingung um $A$: $4a B_y - 2a F = 0$, also $B_y = F\/2$; $A_y = F\/2$; $A_x = 0$.

  _Knoten $A$_ (Stab 1 nach $D$ unter 45°, Stab 2 nach $C$):
  $ sum Y: quad F/2 + S_1/sqrt(2) = 0 quad => quad S_1 = -F/sqrt(2). wide sum X: quad S_2 + S_1/sqrt(2) = 0 quad => quad S_2 = F/2. $
  _Knoten $D$_ (Stäbe 1, 3 nach $C$, 6 nach $E$):
  $ sum Y: quad -S_1/sqrt(2) - S_3/sqrt(2) = 0 quad => quad S_3 = F/sqrt(2). wide sum X: quad -S_1/sqrt(2) + S_3/sqrt(2) + S_6 = 0 quad => quad S_6 = -F. $
  Aus der Symmetrie: $S_4 = S_3$, $S_5 = S_2$, $S_7 = S_1$. _Kontrolle am Knoten $C$:_ $sum Y = S_3\/sqrt(2) + S_4\/sqrt(2) - F = F\/2 + F\/2 - F = 0$ ✓.

  _Deutung:_ Der Obergurt (6) und die äußeren Diagonalen (1, 7) sind gedrückt, der Untergurt (2, 5) und die inneren Diagonalen (3, 4) gezogen. Das ist genau wie bei einem durchgebogenen Balken: oben Druck, unten Zug.
]

=== Nullstäbe erkennen

Stäbe mit $S = 0$ heißen *Nullstäbe*. Man findet sie oft ohne Rechnung:
- *Unbelasteter Knoten mit zwei Stäben*, die nicht in einer Linie liegen: Beide sind Nullstäbe.
- *Unbelasteter Knoten mit drei Stäben*, von denen zwei in einer Linie liegen: Der dritte ist ein Nullstab.
- *Belasteter Knoten mit zwei Stäben*, Last in Richtung des einen Stabs: Der andere ist ein Nullstab.
Nullstäbe sind nicht überflüssig. Sie halten die Knoten fest, verhindern Beweglichkeit bei anderen Lasten und verkürzen die Knicklänge gedrückter Stäbe.

== Dreikräfteschnitt (Ritter-Schnitt)

Will man nur einzelne Stabkräfte, ist es mühsam, sich Knoten für Knoten vorzuarbeiten. Schneller ist ein Schnitt durch das ganze Fachwerk.

#rezept[Dreikräfteschnitt][
  + Lagerkräfte bestimmen.
  + Das Fachwerk durch einen Schnitt in zwei Teile trennen, der *drei Stäbe* durchtrennt, die *nicht alle vom selben Knoten* ausgehen.
  + Einen der beiden Teile freischneiden; die drei Stabkräfte als Zug eintragen. Das Teil ist ein starrer Körper im Gleichgewicht, mit drei Gleichgewichtsbedingungen für drei Unbekannte.
  + Für jede gesuchte Stabkraft die *Momentenbedingung um den Schnittpunkt der beiden anderen* Stäbe ansetzen. Sind die beiden anderen parallel, nimmt man stattdessen die Komponentenbedingung senkrecht zu ihnen.
]

#bsp[Stabkraft 6 direkt][
  Schnitt durch die Stäbe 2, 3, 6; linker Teil (Abbildung oben rechts). Die Stäbe 2 und 3 schneiden sich in $C$. Momentenbedingung um $C$ (positiv gegen den Uhrzeigersinn): Die Lagerkraft $F\/2$ in $A$ hat den Hebelarm $2a$ und dreht im Uhrzeigersinn, also $-2a dot.c F\/2 = -a F$. $S_6$ wirkt im Abstand $a$ über $C$ nach rechts, auch im Uhrzeigersinn: $-a S_6$.
  $ -a F - a S_6 = 0 quad => quad S_6 = -F. $
  Dasselbe wie oben, in einer Zeile und ohne die Stäbe 1, 2, 3 zu berechnen.
]

== PdvL am Fachwerk

Entfernt man den Stab mit der gesuchten Kraft und ersetzt ihn durch die beiden Kräfte $S$ an seinen Endknoten, wird das statisch bestimmte Fachwerk zu einem Mechanismus mit einem Freiheitsgrad. Man bestimmt für eine zulässige virtuelle Bewegung die Geschwindigkeiten der belasteten Knoten und der beiden Endknoten des entfernten Stabs (Momentanzentren der starr bleibenden Teilfachwerke!) und setzt $tilde(PP) = 0$.

#bsp[Stab 6 mit dem PdvL][
  Stab 6 entfernen. Das linke Dreieck $A D C$ dreht sich um das Lager $A$ mit $tilde(omega)$ (gegen den Uhrzeigersinn). Dann ist $vv_C = (0, 2a tilde(omega))$ vertikal und $vv_D = tilde(omega) a (-1, 1)$. Das rechte Dreieck $C E B$ hat $vv_C$ vertikal und $vv_B$ horizontal (Loslager); die Senkrechten schneiden sich in $B$, also ist $B$ sein Momentanzentrum mit Rotation $-tilde(omega)$, und $vv_E = tilde(omega) a (1, 1)$.

  Leistungen: $S_6$ zieht $D$ nach rechts und $E$ nach links, $F$ nach unten in $C$:
  $ tilde(PP) = S_6 (-tilde(omega) a) + (-S_6)(tilde(omega) a) + (-F)(2 a tilde(omega)) = 0 quad => quad S_6 = -F. $
]

== Räumliche Fachwerke

Alles überträgt sich: Knotengleichgewicht mit drei Gleichungen pro Knoten ($sum X = sum Y = sum Z = 0$), Beginn an einem Knoten mit höchstens drei Unbekannten. Die Komponenten einer Stabkraft erhält man, indem man $S$ mit dem Einheitsvektor in Stabrichtung multipliziert:
$ vS = S (arrow(P Q)) / (|arrow(P Q)|) wide ("Stab von Knoten" P "nach" Q, "Kraft auf Knoten" P). $
Die räumliche Grundfigur ist das Tetraeder (vier Knoten, sechs Stäbe).

#fehler[
  - Stabkräfte am Knoten mal als Zug, mal als Druck eintragen und die Vorzeichen durcheinanderbringen. Immer als Zug ansetzen.
  - Lasten mitten auf einem Stab: Dann ist es kein ideales Fachwerk mehr, der Stab wird gebogen.
  - Ritter-Schnitt durch drei Stäbe, die sich in einem Knoten treffen: liefert nichts.
]

#kurz[
  - Ideales Fachwerk: gelenkige Knoten, Lasten nur in Knoten, Stäbe sind Pendelstützen.
  - Eine Unbekannte pro Stab; $S > 0$ Zug, $S < 0$ Druck.
  - $u = s + r - 2k$ (eben), $u = s + r - 3k$ (räumlich).
  - Knotengleichgewicht für alle Stabkräfte, Ritter-Schnitt für einzelne, PdvL für einzelne bei einfacher Kinematik.
]
