#import "lib.typ": *

= Leistung

Die Leistung verbindet die beiden Welten, die wir bisher getrennt aufgebaut haben: Bewegung (Geschwindigkeit) und Kraft. Sie ist eine einfache Zahl, aber sie ist das Werkzeug, aus dem der Rest des Skripts entsteht. Aus ihr fallen die Begriffe _Resultierende_ und _Moment_ ganz von selbst heraus, und in Kapitel 8 wird sie zum Grundprinzip der Statik.

== Leistung einer Einzelkraft

#defn[Leistung][
  Die *Leistung* einer Kraft ${M | vF}$, deren Angriffspunkt $M$ die Geschwindigkeit $vv_M$ hat, ist das Skalarprodukt
  #gl($ PP := vF dot.c vv_M = |vF| |vv_M| cos alpha. $)
  Dabei ist $alpha$ der Winkel zwischen $vF$ und $vv_M$. Einheit: Watt, $1 "W" = 1 "N m/s"$.
]

In kartesischen Komponenten, $vF = (X, Y, Z)$ und $vv = (dot(x), dot(y), dot(z))$, heißt das $PP = X dot(x) + Y dot(y) + Z dot(z)$.

#fg("k05_leistung", [Nur der Anteil der Kraft _in Bewegungsrichtung_ (grün) leistet etwas. Links: Die Kraft treibt an ($PP > 0$). Mitte: Kraft senkrecht zur Bewegung, keine Leistung. Rechts: Die Kraft bremst ($PP < 0$).])

#intu[
  Du ziehst einen Schlitten an einem schrägen Seil. Nur der Teil deiner Kraft, der _in Fahrtrichtung_ zeigt, bringt den Schlitten voran; der Teil nach oben hebt ihn ein wenig an, leistet aber nichts. Und egal, wie stark du ziehst: Wenn sich der Schlitten nicht bewegt, ist die Leistung null. Leistung braucht Kraft _und_ Bewegung, und zwar in dieselbe Richtung. Zieht die Kraft der Bewegung entgegen (Bremse, Reibung), ist die Leistung negativ: Das System verliert Energie.
]

#bsp[Schlitten][
  Du ziehst mit $F = 50$ N unter $alpha = 30°$ zur Fahrtrichtung, der Schlitten fährt mit $v = 2$ m/s. $PP = F v cos alpha = 50 dot 2 dot cos 30° approx 86.6$ W. Würdest du genau waagerecht ziehen, wären es $100$ W; bei senkrechtem Ziehen $0$ W.
]

Die Dimension der Leistung ist $[P] = [F L T^(-1)] = [M L^2 T^(-3)]$. Das Watt ist die Leistung einer Kraft von 1 N, deren Angriffspunkt sich mit 1 m/s in Kraftrichtung bewegt; größer sind das Kilowatt (kW) und das Megawatt (MW). Für $alpha < 90°$ ist die Leistung positiv, die Kraft wirkt als *Antriebskraft*; für $alpha > 90°$ ist sie negativ, die Kraft wirkt als *Widerstandskraft*. Beachte, dass die Leistung eine _momentane_ Größe ist: Sie kann zu jedem Zeitpunkt anders sein, weil $vF$, $vv_M$ und die Lage von $M$ von der Zeit abhängen dürfen. Der Punkt $M$ darf zu einem beliebigen materiellen System gehören (fest, flüssig oder gasförmig).

Eine Kraft mit $PP = 0$ heißt *momentan leistungslos*. Das ist der Fall, wenn ihr Angriffspunkt ruht (Berührungspunkt eines rollenden Rades!) oder wenn sie senkrecht auf der Geschwindigkeit steht. Beispiele: die Normalkraft auf einen Körper, der auf einer ruhenden, glatten Fläche gleitet; die Kraft des Magnetfelds $vq(vv times vB)$ auf eine bewegte Ladung; die Spannkraft des Fadens beim Kreispendel. Diese Eigenschaft wird beim Prinzip der virtuellen Leistungen ausgenutzt: Alle leistungslosen Kräfte fallen heraus.

Zwei Beispiele für leistungslose Kräfte: Die Lorentzkraft $vF = q thin vv times vB$ auf eine bewegte Ladung im Magnetfeld steht immer senkrecht auf $vv$ (Kreuzprodukt!) und leistet nichts. Auch die Kontaktkräfte $vN$ und $-vN$ an einer reibungsfreien punktförmigen Berührung zweier aufeinander gleitender Körper sind leistungslos, denn sie stehen senkrecht auf den Geschwindigkeiten der Berührungspunkte.

== Leistung bei Rotation: Das Moment entsteht

Eine Kraft ${A | vF}$ greife an einem Körper an, der mit der Winkelgeschwindigkeit $vom$ um eine Achse durch $O$ rotiert. Die Geschwindigkeit des Angriffspunkts ist $vv_A = vom times vr_A$ (Kapitel 3). Damit
$ PP = vF dot.c (vom times vr_A) = vom dot.c (vr_A times vF). $
Im zweiten Schritt wurde das Spatprodukt zyklisch vertauscht, $vF dot.c (vom times vr_A) = vom dot.c (vr_A times vF)$. Beachte, was dabei passiert ist: Der Klammerausdruck $vr_A times vF$ enthält nur die Kraft und ihre Lage, und nicht die Bewegung. Die Leistung ist das Skalarprodukt aus der Rotation $vom$ und einer Größe, die allein von der Kraft und dem Ort abhängt. Diese Größe bekommt einen eigenen Namen.

#defn[Moment einer Kraft][
  Das Vektorprodukt
  #gl($ vM_O := arrow(O A) times vF $)
  heißt *Moment* der Kraft ${A | vF}$ bezüglich des Punktes $O$ (des *Bezugspunktes*). Die Projektion auf eine Achse durch $O$ in Richtung $ve_z$, $M_z := ve_z dot.c vM_O$, heißt *Moment bezüglich dieser Achse*.
]

Mit $vom = omega ve_z$ wird die Leistung bei Rotation um die $z$-Achse
#gl($ PP = vom dot.c vM_O = omega M_z. $)

#fg("k05_hebel", [Das Moment $vM_O$ der Kraft ${A | vF}$ bezüglich $O$. Sein Betrag ist Kraft mal Hebelarm; der Hebelarm $a$ ist der senkrechte Abstand von $O$ zur Wirkungslinie.])

#intu[
  Vergleiche die beiden Formeln: $PP = vF dot.c vv$ bei Translation und $PP = vM_O dot.c vom$ bei Rotation. Das Moment ist für die Drehung, was die Kraft für die Verschiebung ist: die «Drehkraft». Beim Schraubenschlüssel zählt nicht nur, wie fest du drückst, sondern auch, wie weit außen du anfasst und ob du quer zum Griff drückst. Genau das misst $arrow(O A) times vF$: Der Betrag ist $|vF| |arrow(O A)| sin theta = F a$, also Kraft mal _Hebelarm_, wobei der Hebelarm $a$ der senkrechte Abstand von $O$ zur Wirkungslinie ist. Die Richtung steht senkrecht auf der Ebene durch $O$ und die Wirkungslinie, im Drehsinn nach der Rechte-Hand-Regel.
]

#bsp[Schraubenschlüssel][
  Der Schlüssel hat die Länge $0.25$ m, du drückst am Ende mit $100$ N. Senkrecht zum Schlüssel: $M = 100 dot 0.25 = 25$ N m. Drückst du unter $60°$ zur Schlüsselachse, so hat die Wirkungslinie den Abstand $a = 0.25 sin 60° approx 0.217$ m von der Schraube, $M approx 21.7$ N m. Längs des Schlüssels ($0°$) ist $a = 0$ und damit $M = 0$: Eine Kraft, deren Wirkungslinie durch den Bezugspunkt geht, hat dort kein Moment.
]

Die Einheit des Moments ist N m. Sie stimmt dimensionsmäßig mit der Energie überein, aber ein Moment ist eine Kraftwirkung, keine Energie (man schreibt deshalb nicht «Joule»).

#bsp[Endlose Schraube][
  Auf die reibungsfreie endlose Schraube (Schraubenwinkel $gamma$) wirke die zur Schraubenfläche normale Antriebskraft $F$, die Drehzahl um die Wellenachse sei $n$ (in Umdrehungen pro Minute), der Angriffspunkt habe den Abstand $R$ von der Achse. In der zylindrischen Basis ist $vF = F sin gamma thin ve_phi + F cos gamma thin ve_z$, und die Rotationsgeschwindigkeit ist $vom = (pi n \/ 30) ve_z$. _Weg 1:_ Die Geschwindigkeit des Angriffspunkts ist $vv = vom times vr = (pi n R\/30) ve_phi$, also $PP = vF dot.c vv = pi n F R sin gamma \/ 30$. _Weg 2:_ Das Moment bezüglich der Achse ist $M_z = F R sin gamma$ (nur der tangentiale Kraftanteil dreht), und $PP = omega M_z = (pi n\/30) F R sin gamma$. Beide Wege stimmen überein.
]

== Gesamtleistung

#defn[Gesamtleistung][
  Die *Gesamtleistung* mehrerer Kräfte ist die Summe der Einzelleistungen: $PP = sum_i vF_i dot.c vv_i$.
]

Greifen alle Kräfte am _selben_ Punkt an, haben sie dieselbe Geschwindigkeit $vv$, und man kann ausklammern: $PP = (sum_i vF_i) dot.c vv = vR dot.c vv$. Die Summe $vR := sum_i vF_i$ heißt *Resultierende*. Sie ersetzt die ganze Kräftegruppe, soweit es die Leistung betrifft.

Bei einem beliebigen, verformbaren System gibt es keine solche Vereinfachung; man muss jede Geschwindigkeit einzeln kennen. Beim *starren Körper* dagegen kennen wir alle Geschwindigkeiten aus der Kinemate: $vv_i = vv_B + vom times arrow(B A_i)$. Setzt man das ein und sortiert, entsteht
$ PP = sum_i vF_i dot.c (vv_B + vom times arrow(B A_i)) = vv_B dot.c underbrace(sum_i vF_i, vR) + vom dot.c underbrace(sum_i arrow(B A_i) times vF_i, vM_B). $

#satz[Leistung am starren Körper][
  #gl($ PP = vv_B dot.c vR + vom dot.c vM_B $)
  mit der *Resultierenden* $vR = sum_i vF_i$ und dem *Gesamtmoment* $vM_B = sum_i arrow(B A_i) times vF_i$ bezüglich des Bezugspunkts $B$.
]

Das ist die wichtigste Formel des ganzen ersten Teils. Sie sagt: Was eine noch so komplizierte Kräftegruppe an einem starren Körper «leisten kann», hängt nur von zwei Vektoren ab, $vR$ und $vM_B$. Alle anderen Einzelheiten der Kräftegruppe sind für den starren Körper unsichtbar.

#merke[
  Es besteht eine vollkommene Entsprechung zwischen Bewegung und Kraft:

  #align(center, table(columns: 3, stroke: none, inset: (x: 12pt, y: 5pt), align: center,
    [*Bewegung*], [], [*Kräfte*],
    [Translationsgeschwindigkeit $vv_B$], [$<->$], [Resultierende $vR$],
    [Rotationsgeschwindigkeit $vom$], [$<->$], [Moment $vM_B$],
    [Kinemate ${vv_B, vom}$], [$<->$], [Dyname ${vR, vM_B}$],
  ))

  Die Leistung ist das «Skalarprodukt der Dualen». Diese Dualität wird in Kapitel 6 vollständig ausgenutzt.
]

Die Formel gilt nicht nur für zwei Kräfte. Man erweitert sie ohne Weiteres auf beliebig viele Einzelkräfte und sogar auf verteilte Flächen- und Raumkräfte (die Summen werden zu Integralen); ihre Gestalt bleibt dabei dieselbe. Sie ist der Ausgangspunkt der gesamten Statik im folgenden Teil.

#bsp[Kranarm][
  Ein Stab $A B$ der Länge $L$ dreht mit der Schnelligkeit $omega$ gegen den Uhrzeigersinn um das Gelenk $A$ und steht unter dem Winkel $alpha$ zur Horizontalen. An der Spitze $B$ hängt die Last $G$ (senkrecht nach unten). Gesucht: die Leistung der Last.

  _Weg 1 (Geschwindigkeit):_ $vv_B = omega L (-sin alpha, cos alpha)$, senkrecht zum Stab; $vG = (0, -G)$. Also $PP = vG dot.c vv_B = -G omega L cos alpha$.

  _Weg 2 (Moment):_ Das Moment von $vG$ bezüglich $A$ hat den Hebelarm $L cos alpha$ und dreht im Uhrzeigersinn: $M_z = -G L cos alpha$. Also $PP = omega M_z = -G omega L cos alpha$.

  Beide Wege stimmen überein. Das Ergebnis ist negativ: Hebt der Arm die Last, bremst die Last den Arm. Der zweite Weg ist meist der schnellere, wenn die Geschwindigkeit des Angriffspunkts nicht schon gegeben ist.
]

#kurz[
  - $PP = vF dot.c vv$: Kraftanteil in Bewegungsrichtung mal Schnelligkeit.
  - Leistungslos: Angriffspunkt ruht oder $vF perp vv$.
  - Moment: $vM_O = arrow(O A) times vF$, $|vM_O| = F a$ (Hebelarm). Bei Rotation $PP = vom dot.c vM_O$.
  - Starrer Körper: $PP = vv_B dot.c vR + vom dot.c vM_B$.
  - Kinemate ${vv_B, vom}$ und Dyname ${vR, vM_B}$ sind zueinander dual.
]
