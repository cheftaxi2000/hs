#import "lib.typ": *

= Leistung

Die Leistung verbindet die beiden Welten, die wir bisher getrennt aufgebaut haben: Bewegung (Geschwindigkeit) und Kraft. Sie ist eine einfache Zahl, aber sie ist das Werkzeug, mit dem der Rest des Skripts aufgebaut wird. Aus ihr fallen die Begriffe _Resultierende_ und _Moment_ ganz von selbst heraus, und in Kapitel 8 wird sie zum Grundprinzip der Statik.

== Leistung einer Einzelkraft

#defn[Leistung][
  Die *Leistung* einer Kraft ${M | vF}$, deren Angriffspunkt $M$ die Geschwindigkeit $vv_M$ hat, ist das Skalarprodukt
  #gl($ PP := vF dot.c vv_M = |vF| |vv_M| cos alpha, $)
  wobei $alpha$ der Winkel zwischen $vF$ und $vv_M$ ist. Einheit: Watt, $1 "W" = 1 "N m/s"$.
]

In kartesischen Komponenten, $vF = (X, Y, Z)$: $PP = X dot(x) + Y dot(y) + Z dot(z)$.

#fig(13, 3.4, caption: [Nur der Kraftanteil in Bewegungsrichtung leistet etwas. Links positive Leistung (die Kraft treibt an), Mitte null (Kraft senkrecht zur Geschwindigkeit), rechts negative Leistung (die Kraft bremst).],
  ..(1.0, 5.6, 10.2).map(x0 => arr((x0, 1.0), (x0 + 2.2, 1.0), c: cv, w: 1.1pt)),
  ..(1.0, 5.6, 10.2).map(x0 => pt((x0, 1.0))),
  arr((1.0,1.0),(2.6,2.4), c: cf, w: 1.3pt), dl((2.6,2.4),(2.6,1.0)), li((1.0,0.92),(2.6,0.92), s: 2pt + cm),
  arr((5.6,1.0),(5.6,2.7), c: cf, w: 1.3pt),
  arr((10.2,1.0),(8.9,2.4), c: cf, w: 1.3pt), dl((8.9,2.4),(8.9,1.0)), li((8.9,0.92),(10.2,0.92), s: 2pt + cm),
  arc((1.0,1.0), 0.6, 0, 41, w: 0.5pt), lbl((1.85,1.25), $alpha$, size: 8pt),
  lbl((2.9,2.6), $vF$, c: cf), lbl((3.3,0.7), $vv$, c: cv), lbl((5.95,2.6), $vF$, c: cf), lbl((7.9,0.7), $vv$, c: cv), lbl((8.6,2.6), $vF$, c: cf), lbl((12.5,0.7), $vv$, c: cv),
  lbl((2.0,0.2), $PP > 0$, size: 8.5pt), lbl((6.6,0.2), $PP = 0$, size: 8.5pt), lbl((10.6,0.2), $PP < 0$, size: 8.5pt),
)

#intu[
  Du ziehst einen Schlitten an einem schrägen Seil. Nur der Teil deiner Kraft, der _in Fahrtrichtung_ zeigt, bringt den Schlitten voran; der Teil nach oben hebt ihn ein wenig an, leistet aber nichts. Und egal wie stark du ziehst: Bewegt sich der Schlitten nicht, ist die Leistung null. Leistung braucht Kraft _und_ Bewegung, und zwar in dieselbe Richtung.
]

Eine Kraft mit $PP = 0$ heißt *momentan leistungslos*. Das ist der Fall, wenn ihr Angriffspunkt ruht oder wenn sie senkrecht auf seiner Geschwindigkeit steht. Beispiele: die Normalkraft auf einen Körper, der auf einer ruhenden Fläche gleitet; die Kraft im Berührungspunkt eines rollenden Rades (der Punkt ruht); die magnetische Kraft $q vv times vB$ auf eine bewegte Ladung.

== Leistung bei Rotation: das Moment entsteht

Eine Kraft ${A | vF}$ greife an einem Körper an, der mit $vom$ um eine Achse durch $O$ rotiert. Dann ist $vv_A = vom times vr_A$ und
$ PP = vF dot.c (vom times vr_A) = vom dot.c (vr_A times vF). $
(Im Spatprodukt darf man zyklisch vertauschen.) Der Ausdruck in der Klammer hängt nur von der Kraft und ihrer Lage ab, nicht von der Bewegung. Er bekommt einen eigenen Namen:

#defn[Moment einer Kraft bezüglich eines Punktes][
  #gl($ vM_O := arrow(O A) times vF $)
  heißt *Moment* der Kraft ${A | vF}$ bezüglich des *Bezugspunktes* $O$. Die Projektion auf eine Achse durch $O$, z.~B. $M_z := ve_z dot.c vM_O$, ist das *Moment bezüglich dieser Achse*.
]

Damit wird die Leistung bei Rotation
#gl($ PP = vom dot.c vM_O = omega M_z quad ("für" vom = omega ve_z). $)

#intu[
  Vergleiche $PP = vF dot.c vv$ mit $PP = vM_O dot.c vom$. Das Moment ist für die Drehung, was die Kraft für die Verschiebung ist: die «Drehkraft». Beim Schraubenschlüssel zählt nicht nur, wie fest du drückst, sondern auch, wie weit außen du anfasst und ob du quer zum Griff drückst. Genau das misst $arrow(O A) times vF$: Hebelarm mal Queranteil der Kraft.
]

== Gesamtleistung

#defn[Gesamtleistung][
  Die Gesamtleistung mehrerer Kräfte ist die Summe der Einzelleistungen: $PP = sum_i vF_i dot.c vv_i$.
]

Greifen alle Kräfte am _selben_ Punkt an, so haben sie dieselbe Geschwindigkeit $vv$, und man kann ausklammern: $PP = (sum vF_i) dot.c vv = vR dot.c vv$. Die Summe $vR := sum vF_i$ heißt *Resultierende*.

Bei einem beliebigen, verformbaren System gibt es keine solche Vereinfachung; man muss jede Geschwindigkeit einzeln kennen. Beim *starren Körper* aber kennen wir alle Geschwindigkeiten aus der Kinemate: $vv_i = vv_B + vom times arrow(B A_i)$. Einsetzen und Sortieren:
$ PP = sum_i vF_i dot.c (vv_B + vom times arrow(B A_i)) = vv_B dot.c underbrace(sum_i vF_i, vR) + vom dot.c underbrace(sum_i arrow(B A_i) times vF_i, vM_B). $

#satz[Leistung am starren Körper][
  #gl($ PP = vv_B dot.c vR + vom dot.c vM_B $)
  mit der *Resultierenden* $vR = sum vF_i$ und dem *Gesamtmoment* $vM_B = sum arrow(B A_i) times vF_i$ bezüglich des Bezugspunkts $B$.
]

#merke[
  Das ist die wichtigste Formel des ersten Teils. Sie sagt: Was eine noch so komplizierte Kräftegruppe an einem starren Körper «leisten kann», hängt nur von zwei Vektoren ab, $vR$ und $vM_B$. Alle anderen Details der Kräftegruppe sind für den starren Körper unsichtbar. Es besteht eine vollkommene Entsprechung:

  #align(center, table(columns: 3, stroke: none, inset: (x: 10pt, y: 4pt), align: center,
    [*Bewegung*], [], [*Kräfte*],
    [Translationsgeschwindigkeit $vv_B$], [$<->$], [Resultierende $vR$],
    [Rotationsgeschwindigkeit $vom$], [$<->$], [Moment $vM_B$],
    [Kinemate ${vv_B, vom}$], [$<->$], [Dyname ${vR, vM_B}$],
  ))
]

#bsp[Kranarm][
  Ein Stab $A B$ der Länge $L$ dreht mit $omega$ um das Gelenk $A$ und steht unter dem Winkel $alpha$ zur Horizontalen. An der Spitze $B$ hängt die Last $G$ (vertikal nach unten). _Weg 1:_ $v_B = omega L$, senkrecht zum Stab; der Winkel zwischen $vv_B$ und der Vertikalen nach unten ist $180° - alpha$ bei Aufwärtsdrehung, also $PP = -G omega L cos alpha$. _Weg 2:_ Moment von $G$ bezüglich $A$: Hebelarm $L cos alpha$, dreht im Uhrzeigersinn, $M_z = -G L cos alpha$, also $PP = omega M_z = -G omega L cos alpha$. Beide Wege stimmen überein; der zweite ist meist der schnellere.
]

#kurz[
  - $PP = vF dot.c vv$: Kraftanteil in Bewegungsrichtung mal Schnelligkeit.
  - Leistungslos: Angriffspunkt ruht oder $vF perp vv$.
  - Moment: $vM_O = arrow(O A) times vF$; bei Rotation $PP = vom dot.c vM_O$.
  - Starrer Körper: $PP = vv_B dot.c vR + vom dot.c vM_B$.
  - Kinemate ${vv_B, vom}$ und Dyname ${vR, vM_B}$ sind zueinander dual.
]
