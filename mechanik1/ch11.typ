#import "lib.typ": *

= Statisch bestimmte Fachwerke

#woche(11, [Fachwerke], [158–169])

Fachwerke sind Tragwerke aus Stäben, die in *Knoten* verbunden sind: Brücken, Kräne, Dachbinder, Strommasten. Sie sind leicht und trotzdem steif, weil ihre Stäbe fast nur auf Zug oder Druck beansprucht werden, die Belastungsart, die das Material am besten ausnutzt. Für die Statik haben Fachwerke einen riesigen Vorteil: Man kann sie mit sehr einfachen Mitteln vollständig berechnen.

== Ideale Fachwerke und Pendelstützen

#defn[Ideales Fachwerk][
  Ein *ideales Fachwerk* erfüllt:
  - die Stäbe sind gerade und gewichtslos,
  - sie sind an ihren Enden durch *reibungsfreie Gelenke* (die Knoten) verbunden,
  - alle Lasten greifen *nur in den Knoten* an (Knotenlasten).
]

Diese Voraussetzungen idealisieren die Wirklichkeit: Echte Knoten sind oft geschweißt oder genietet und übertragen auch ein wenig Biegemoment, und Stäbe haben Eigengewicht. Für die Frage «Welche Kräfte tragen die Stäbe?» ist das Modell aber meist genau genug.

Die Verbindungsstellen der Stäbe und die Lager heißen *Knoten*. Sie können als Gelenke, durch Verschweißen oder durch kleinere Platten mit Nieten ausgeführt sein. Das Modell des idealen Fachwerks nimmt an, dass die Knoten so «weich» sind, dass sie als reibungsfreie Gelenke gelten, dass die Stäbe so leicht sind, dass man ihre Gewichte gegen die übrigen Lasten vernachlässigen darf, und dass alle Lasten nur in den Knoten angreifen. Das idealisiert die Wirklichkeit stark, liefert aber als erste Abschätzung der Haupteinflüsse brauchbare Ergebnisse.

Schneidet man einen einzelnen Stab frei, greifen an ihm nur zwei Kräfte an, je eine an jedem Ende. Nach Kapitel 6 können zwei Kräfte nur im Gleichgewicht sein, wenn sie auf derselben Wirkungslinie liegen, also auf der Stabachse:

#satz[Pendelstütze][
  Ein gewichtsloser, an beiden Enden reibungsfrei gelenkig gelagerter und nur dort belasteter Stab (*Pendelstütze*) überträgt nur eine Kraft *in Stabrichtung*, die *Stabkraft* $S$. Vereinbarung:
  $ S > 0: quad "Zugstab", wide S < 0: quad "Druckstab". $
  Ein ideales Fachwerk besteht ausschließlich aus Pendelstützen.
]

Ob eine Stabkraft Zug oder Druck ist, legt man an der _äußeren Normalen des Stabquerschnitts_ fest: Zeigt die Kraft am Stabende in Richtung der äußeren Normalen (vom Stab weg), liegt Zug vor, sonst Druck. Zwei Kräfte $\{A | vS\}$ und $\{A' | -vS\}$ genügen, daher charakterisiert man beide durch die einzige skalare Größe $S$ mit $vS = S ve_N$. Ein Fachwerk, bei dem ein Stab zwischen seinen Enden quer belastet wird oder mit einer Platte fest verschweißt ist, ist _nicht ideal_.

#fg("k11_stab", [Links: Zug- und Druckstab. Rechts: Am freigeschnittenen Knoten trägt man jede Stabkraft als Zug ein, also vom Knoten weg. Ergibt die Rechnung $S < 0$, ist der Stab ein Druckstab.])

#intu[
  Ein Stab mit zwei Gelenken kann weder etwas quer zu sich abstützen noch verdrehen: Er würde einfach um sein Gelenk schwenken. Er kann nur ziehen oder schieben, wie ein Seil, das zusätzlich auch drücken darf. Das macht Fachwerke so einfach: Pro Stab gibt es genau _eine_ Unbekannte.
]

Zur Beurteilung der Tragfähigkeit eines ruhenden Fachwerks braucht man einzelne oder alle Stabkräfte. Wir lernen drei Verfahren: Knotengleichgewicht, Dreikräfteschnitt und PdvL. Bei allen setzen wir ein _statisch bestimmtes_ ideales Fachwerk voraus, denn nur solche Systeme lassen sich ohne Verformungen allein mit der Statik berechnen. Fachwerke, die innerlich oder äußerlich statisch unbestimmt sind, brauchen die Festigkeitslehre (Mechanik 2).

== Abzählen: statische Bestimmtheit

Mit $s$ Stäben, $r$ Lagerkraftkomponenten und $k$ Knoten hat man $s + r$ Unbekannte. Pro Knoten stehen zwei (eben) bzw. drei (räumlich) Gleichgewichtsbedingungen zur Verfügung, denn alle Kräfte am Knoten gehen durch ihn (die Momentenbedingung ist automatisch erfüllt). Also:
#gl($ u = s + r - 2k quad ("eben"), wide u = s + r - 3k quad ("räumlich"). $)
$u = 0$ ist notwendig für statische Bestimmtheit (aber wie in Kapitel 10 nicht hinreichend). Für das Beispiel unten: $s = 7$, $r = 3$ (zwei Kräfte im Gelenk, eine im Loslager), $k = 5$, also $u = 7 + 3 - 10 = 0$.

Die Herleitung nochmals ausgeschrieben: Jeder Stab ist eine Pendelstütze und bringt genau eine Unbekannte, die Stabkraft; dazu kommen $r$ Lagerkraftkomponenten, also $n = s + r$ Unbekannte. Jeder Knoten liefert zwei Komponentenbedingungen, also $m = 2k$ Gleichungen. Damit $u = n - m = s + r - 2k$. Die Bedingung $u = 0$ ist notwendig, aber nicht hinreichend (eine ungünstige äußere Lagerung, zum Beispiel mit Wirkungslinien durch einen Punkt, kann das System trotzdem beweglich machen). Beispiele: Ein Fachwerk mit $s = 9$ Stäben, $k = 5$ Knoten und $r = 3$ hat $u = 9 + 3 - 10 = 2$: es ist innerlich zweifach unbestimmt, aber statisch bestimmt gelagert. Eines mit $s = 7$, $k = 5$ und $r = 4$ hat $u = 7 + 4 - 10 = 1$: innerlich bestimmt, aber äußerlich einfach unbestimmt gelagert. Im Raum liefert jeder Knoten drei Gleichungen: $u = s + r - 3k$.

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

*Das erste Beispiel aus dem Buch.* Zehn gleich lange Stäbe, zusammengesetzt zu einem *Dreigelenkbogen* (zwei Teilfachwerke, in $A$ und $B$ gelagert und in $C$ verbunden), tragen zwei Knotenlasten. Die Lagerkräfte in den festen Gelenken $A$ und $B$ haben je zwei unbekannte Komponenten. Die vertikalen folgen aus den Momentenbedingungen um $B$ und $A$. Die horizontalen Komponenten $A_x, B_x$ lassen sich ohne Zerlegung in $C$ nicht bestimmen. Zerlegt man in $C$ und stellt die Momentenbedingung um $C$ am linken Teil auf, braucht man die dort unbekannte Gelenkkraft in $C$ nicht, denn sie hat bezüglich $C$ keinen Hebelarm. Daraus folgt $A_x$, und aus der Komponentenbedingung am Gesamtsystem $B_x$.

Im zweiten Schritt schneidet man die Stäbe von den Knoten ab und trägt an jedem Knoten die Kräfte ein, die auf ihn wirken. Am Lager kommen zu den Lagerkräften auch die Kräfte der Stäbe dazu. Die Stabkräfte werden grundsätzlich so eingetragen, dass ihre _Reaktionen an den Stäben_ Zugkräfte sind. Ist das Rechenergebnis $S_i > 0$, ist der Stab tatsächlich auf Zug beansprucht. Mit je zwei Komponentenbedingungen pro Knoten bestimmt man die Stabkräfte der Reihe nach. Die letzten Knotengleichungen enthalten nur noch bekannte Werte und dienen als *Kontrolle*: Von den $2k$ Gleichungen werden nur $s + r$ gebraucht, der Rest bestätigt die bisherigen Ergebnisse. Im Beispiel sind die Stäbe 3, 6, 9 und 10 gezogen, die übrigen sechs gedrückt.

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

Sind die beiden anderen geschnittenen Stäbe _parallel_, hat man keinen Schnittpunkt für die Momentenbedingung. Dann hilft die Komponentenbedingung in Richtung senkrecht zu diesen beiden Stäben: Sie enthält nur die dritte Stabkraft.

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

Beim Wählen des virtuellen Zustands achtet man darauf, dass er den Satz der projizierten Geschwindigkeiten _am entfernten Stab verletzt_ und sonst mit allen übrigen Bindungen (inneren und äußeren) verträglich ist. Dann erscheinen bei reibungsfreien Bindungen keine überflüssigen Unbekannten: Auch die Lagerkräfte tragen nichts bei und müssen für die gesuchte Stabkraft gar nicht berechnet werden. Der Zustand ist ein wirklicher Bewegungszustand des Mechanismus, deshalb kann man die Tildes zur Vereinfachung weglassen.

== Räumliche Fachwerke

Alles überträgt sich: Knotengleichgewicht mit drei Gleichungen pro Knoten ($sum X = sum Y = sum Z = 0$), Beginn an einem Knoten mit höchstens drei Unbekannten. Die Komponenten einer Stabkraft erhält man, indem man $S$ mit dem Einheitsvektor in Stabrichtung multipliziert:
$ vS = S (arrow(P Q)) / (|arrow(P Q)|) wide ("Stab von Knoten" P "nach" Q, "Kraft auf Knoten" P). $
Beispiel aus dem Buch: Ein räumliches Fachwerk aus zwölf Stäben und sechs Knoten (ein Prisma, aufgebaut aus einem Tetraeder und weiteren Stäben) ist in $A$ in einem Kugelgelenk (3 Komponenten), in $C$ und $H$ in Auflagern und in $B$ durch ein Seil (je eine Komponente) gelagert, also $r = 6$. Dann ist $u = s + r - 3k = 12 + 6 - 18 = 0$. Die Lagerkräfte folgen aus Momentenbedingungen um geeignete Achsen. Für das Knotengleichgewicht braucht man die Komponenten jeder Stabkraft: Man berechnet aus den Koordinaten der Endpunkte den Einheitsvektor in Zugrichtung und multipliziert mit $S$. Man beginnt an einem Knoten mit drei Unbekannten und arbeitet sich vor. Es zeigt sich, dass ein Stab (Nr. 7) bei der gegebenen Last gar keine Kraft trägt. Man behält ihn trotzdem, sonst wäre die Ruhelage instabil. Handrechnungen mit beiden Methoden sind aufwendig und fehleranfällig; in der Praxis rechnet man mit dem Computer.

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
