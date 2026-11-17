#import "lib.typ": *

= Äquivalenz und Reduktion von Kräftegruppen

#woche(7, [Äquivalenz, Gleichgewicht], [83–97])

An einem Bauteil greifen oft Dutzende von Kräften an: Gewicht, Lasten, Lagerkräfte, Reibung. Die Frage dieses Kapitels lautet: Kann man sie durch etwas Einfacheres ersetzen, ohne dass der (starre) Körper einen Unterschied merkt? Die Antwort ist ja, und sie ist erstaunlich handlich. Es kommt nur auf die Summe der Kräfte und die Summe ihrer Momente an.

Der Gedanke ist uns schon aus Kapitel 5 vertraut. Dort haben wir gesehen, dass die Leistung einer Kräftegruppe an einem starren Körper nur von zwei Vektoren abhängt, $vR$ und $vM_B$. Jetzt machen wir daraus ein Prinzip.

== Statische Äquivalenz

#defn[Statisch äquivalent][
  Zwei am selben Körper $K$ angreifende Kräftegruppen ${G}$ und ${G^*}$ heißen *statisch äquivalent*, wenn für *jede* Starrkörperbewegung von $K$ die Gesamtleistung beider Gruppen gleich ist.
]

Das ist eine Definition über das, was die Kräfte _leisten_, nicht über ihr Aussehen. Zwei Kräftegruppen dürfen ganz verschieden aussehen (andere Anzahl, andere Angriffspunkte) und sind trotzdem äquivalent, wenn der starre Körper sie nicht unterscheiden kann. Der Test ist einfach, weil wir die Leistung am starren Körper schon kennen: $PP = vv_O dot.c vR + vom dot.c vM_O$.

#bsp[Zwei Kräfte auf einem Balkenstück][
  Zwei Kräfte mit demselben Vektor $vF$ greifen an den Punkten $A_1$ und $A_2$ eines Balkenstücks an. Die Einzelkraft $2 vF$ in der Mitte zwischen $A_1$ und $A_2$ ist ihnen statisch äquivalent: Ihre Leistung stimmt bei jeder Starrkörperbewegung überein (nach der Formel $PP = vv_O dot.c vR + vom dot.c vM_O$). Ersetzt man dagegen die zweite Kraft durch $2 vF$ in $A_2$, so haben die beiden Gruppen zwar bei einer Drehung um das Ende $P$ des Stücks dieselbe Leistung, aber nicht bei jeder Bewegung. Sie sind nicht äquivalent.
]

#intu[
  Hinter der Definition stecken physikalische Ideen. In der Statik betrachtet man Kräftegruppen an ruhenden Körpern, deren Verformbarkeit man vernachlässigt. Setzt sich der erstarrte Körper aus irgendeinem Grund (zum Beispiel wegen Stabilitätsverlust) in Bewegung, ist es naheliegend, nur solche Kräftegruppen gleichwertig zu nennen, die bei _allen_ denkbaren Starrkörperbewegungen im nächsten Augenblick gleich viel Energie pro Zeit zuführen (Antrieb) oder entziehen (Widerstand). Statische Äquivalenz ist also eine augenblickliche _energetische_ Gleichwertigkeit.
]

#satz[Kriterium der statischen Äquivalenz][
  Zwei Kräftegruppen sind genau dann statisch äquivalent, wenn ihre Resultierenden und ihre Momente bezüglich eines (beliebigen) Punktes $O$ übereinstimmen:
  #gl($ vR = vR^*, wide vM_O = vM_O^*. $)
]

#warum[Beweis][
  Äquivalenz heißt $vv_O dot.c vR + vom dot.c vM_O = vv_O dot.c vR^* + vom dot.c vM_O^*$ für _alle_ Kinematen ${vv_O, vom}$, also $vv_O dot.c (vR - vR^*) + vom dot.c (vM_O - vM_O^*) = 0$ für alle Werte von $vv_O$ und $vom$. Wählt man zuerst $vom = bold(0)$ (reine Translation) und $vv_O$ beliebig, folgt $vR = vR^*$. Wählt man dann $vv_O = bold(0)$ (reine Rotation), folgt $vM_O = vM_O^*$. Umgekehrt ist klar, dass dann die Leistungen gleich sind. $square$
]

#merke[
  «Statisch äquivalent» heißt: gleich _für den starren Körper als Ganzes_, das heißt für Gleichgewicht und Bewegung. Es heißt *nicht*, dass die Wirkung im Inneren dieselbe ist. Ob du einen Balken in der Mitte oder verteilt belastest, ändert vielleicht an den Lagerkräften nichts. Für Durchbiegung, Verformung und die Kräfte im Inneren des Balkens ist es aber ein großer Unterschied. Sobald es um Verformung geht, darfst du Kräfte nicht mehr einfach ersetzen.
]

== Resultierende und Moment einer Kräftegruppe

#defn[Resultierende][
  Die *Resultierende* einer Kräftegruppe aus $n$ Kräften ist die Summe der Vektoranteile:
  $ vR := sum_(i=1)^n vF_i, quad "komponentenweise" quad R_x = sum X_i, space R_y = sum Y_i, space R_z = sum Z_i. $
  Sie ist zunächst nur ein Vektor, _ohne_ Angriffspunkt.
]

Graphisch bildet man die Resultierende, indem man die Kraftpfeile aneinanderhängt (_Kräftepolygon_, Parallelogrammregel für zwei Kräfte); die Resultierende ist der Pfeil vom Anfang des ersten zum Ende des letzten.

Ein Beispiel für kontinuierliche Verteilungen: Ein Massenpunkt $M$ liege im Mittelpunkt eines halbkreisförmigen Drahtes vom Radius $r$ und ziehe ihn mit einer radial gerichteten Linienkraftdichte konstanten Betrags $f$ an. Auf das Bogenelement $r dif phi$ entfällt die Kraft $f r dif phi$, radial gerichtet. Die Komponenten der Resultierenden sind Integrale: $R_x = -f r integral cos phi dif phi = 0$, $R_y = -f r integral sin phi dif phi = -2 f r$. Die Resultierende liegt (wie man aus der Symmetrie schon sieht) in $y$-Richtung, ihr Betrag ist die Kraftdichte mal die Länge $2 r$ der Projektion des Drahtes auf die $y$-Achse.

=== Das Moment einer Einzelkraft

#defn[Moment][
  Das Moment einer Einzelkraft ${A | vF}$ bezüglich eines frei wählbaren Bezugspunktes $O$ ist $vM_O := arrow(O A) times vF$. Sein Betrag ist $|vM_O| = |vF| dot.c overline(O A) sin theta = F a$ mit dem *Hebelarm* $a$ (senkrechter Abstand von $O$ zur Wirkungslinie).
]

Die Dimension des Moments ist $[F L] = M L^2 T^(-2)$, die Einheit N m. Kartesisch, mit $arrow(O A) = (x, y, z)$ und $vF = (X, Y, Z)$, ergibt das Kreuzprodukt
#gl($ M_x = y Z - z Y, quad M_y = z X - x Z, quad M_z = x Y - y X. $)
In ebenen Aufgaben (Kräfte und Hebelarme in der $x y$-Ebene) bleibt nur $M_z = x Y - y X$ übrig; man rechnet mit dieser Zahl und legt fest, dass der Gegenuhrzeigersinn positiv ist.

#intu[
  Der Hebelarm ist ein Hilfsmittel, um das Kreuzprodukt ohne Rechnung zu bestimmen. Zeichne die Wirkungslinie der Kraft, fälle das Lot von $O$ auf sie, und miss die Länge $a$ des Lots. Dann ist $|M_O| = F a$. Die Kraft kann dabei an beliebiger Stelle _auf_ ihrer Wirkungslinie angreifen, ohne dass sich das Moment ändert, denn der Hebelarm bleibt gleich (rechts in der Abbildung unten). Das ist der Verschiebungssatz.
]

#fg("k06_verschieben", [Verschiebt man eine Kraft längs ihrer Wirkungslinie von $A$ nach $A'$, ändern sich weder Resultierende noch Moment. Der Hebelarm $a$ bleibt derselbe.])

Das Moment hat dieselbe Dimension wie die Arbeit (das zeitliche Integral der Leistung), man schreibt trotzdem N m und nicht J. Die Richtung von $vM_O$ steht senkrecht auf der Ebene durch $O$ und die Wirkungslinie, der Drehsinn folgt der Rechte-Hand-Regel.

=== Moment bezüglich einer Achse

Oft interessiert nicht das ganze Momentvektor, sondern nur, wie stark die Kraft um eine bestimmte _Achse_ dreht (Türscharnier, Welle).

#defn[Moment bezüglich einer Achse][
  Das Moment einer Kraft ${A | vF}$ bezüglich einer Achse $zeta$ mit Einheitsvektor $ve_zeta$ ist die Projektion des Moments $vM_B$ bezüglich eines beliebigen Punktes $B$ auf der Achse: $M_zeta := ve_zeta dot.c vM_B$. Das Ergebnis hängt nicht von der Wahl von $B$ auf der Achse ab.
]

Für zwei Punkte $B, B'$ auf der Achse ist $vM_(B') = vM_B + arrow(B' B) times vF$, und der Zusatzterm steht senkrecht auf $arrow(B' B) parallel ve_zeta$, hat also die Projektion null. Das erklärt die Unabhängigkeit von $B$.

#satz[Wann das Achsenmoment verschwindet][
  $M_zeta = 0$ genau dann, wenn die Wirkungslinie der Kraft die Achse *schneidet* oder zu ihr *parallel* ist. Sonst ist $|M_zeta| = a |vF_perp|$ mit dem Kraftanteil $vF_perp$ senkrecht zur Achse und seinem Abstand $a$ von der Achse.
]

#intu[
  Eine Tür dreht um ihre Scharnierachse. Drückst du in Richtung der Scharniere (die Wirkungslinie trifft die Achse) oder ziehst du die Tür nach oben (parallel zur Achse), bewegt sie sich nicht. Nur der Anteil, der quer zur Achse an ihr vorbeizielt, dreht. Daraus folgt eine Regel, die in räumlichen Aufgaben viel Arbeit spart: Wähle Momentenachsen, die möglichst viele unbekannte Kräfte schneiden. Deren Momente fallen dann aus der Gleichung.
]

=== Moment einer Kräftegruppe und Wechsel des Bezugspunkts

#defn[Moment einer Kräftegruppe][
  $vM_O := sum_(i=1)^n arrow(O A_i) times vF_i$: die Summe der Momente der Einzelkräfte bezüglich desselben Punktes.
]

Wie verändert sich das Moment, wenn man den Bezugspunkt wechselt? Von $O$ nach $P$:
$ vM_P = sum arrow(P A_i) times vF_i = sum (arrow(P O) + arrow(O A_i)) times vF_i = arrow(P O) times sum vF_i + sum arrow(O A_i) times vF_i, $
also
#gl($ vM_P = vM_O + arrow(P O) times vR. $)

#intu[
  Lies das so: Das Moment bezüglich $P$ ist das Moment bezüglich $O$ plus das Moment der in $O$ angreifend gedachten Resultierenden bezüglich $P$. Vergleiche mit der Formel der Kinematik, $vv_P = vv_O + vom times arrow(O P)$: Es ist dieselbe Struktur, mit den Rollen $vom <-> vR$ und $vv <-> vM$. Das ist die Dualität von Kapitel 5 in Formelgestalt.
]

#defn[Dyname][
  Das Paar ${vR, vM_O}$ aus Resultierender und Moment bezüglich $O$ heißt *Dyname* der Kräftegruppe in $O$. Nach dem Kriterium oben haben statisch äquivalente Kräftegruppen dieselbe Dyname.
]

== Wichtige Spezialfälle

=== Wann dürfen Kräfte ersetzt werden? Zwei Bemerkungen

*Nur am starren Körper.* Schon bei statisch äquivalenten Einzelkräften sieht man, dass Kräftegruppen nur an einem _erstarrten_ System durch andere statisch äquivalente ersetzt werden dürfen. An verformbaren Systemen können statisch äquivalente Kräfte verschiedene Verformungs- oder Bewegungszustände erzeugen. Am Viergelenk-Mechanismus würde die Kraft ${A | vF}$ das ruhende System in Bewegung setzen, die statisch äquivalente Kraft in einem Lagerpunkt ${O | vF}$ dagegen nicht. An einem verformbaren Fachwerk kann eine Kraft einen Stab ohne Verbiegung verlängern, die längs der Wirkungslinie verschobene Kraft verbiegt ihn (siehe Kapitel 11).

*Ein Bezugspunkt genügt.* Beim Kriterium der Äquivalenz genügt es, die Momente bezüglich _eines einzigen_ Punktes zu vergleichen, sofern die Resultierenden gleich sind: Nach der Formel $vM_P = vM_O + arrow(P O) times vR$ sind die Momente dann automatisch auch bezüglich aller anderen Punkte gleich.

*Das Grundverfahren der graphischen Statik.* Zwei Kräfte in einer Ebene, deren Wirkungslinien sich in $S$ schneiden, kann man längs ihrer Wirkungslinien nach $S$ verschieben, dort nach der Parallelogrammregel addieren und die Summe wieder längs ihrer eigenen Wirkungslinie an einen beliebigen Punkt schieben. So reduziert man ebene Kräftegruppen geometrisch zu einer Einzelkraft. Das war früher ein Standardwerkzeug der Ingenieure; heute rechnet man meist. Für zwei nicht parallele Kräfte in _verschiedenen_ Ebenen gibt es dagegen keine äquivalente Einzelkraft (denn $vR dot.c vM != 0$: es entsteht eine echte Schraube, siehe Abschnitt 6.5).

=== Parallelverschiebung einer Kraft

Eine einzelne Kraft ${A | vF}$ soll nach $B$ verschoben werden. Man fügt in $B$ die _Nullgruppe_ $vF, -vF$ hinzu (sie ändert nichts, denn ihre Resultierende und ihr Moment sind null). Dann bleiben die Kraft $vF$ in $B$ und das Kräftepaar aus der ursprünglichen Kraft in $A$ und der entgegengesetzten in $B$.

#fg("k06_parallel", [Parallelverschiebung: Man fügt in $B$ die Nullgruppe $vF, -vF$ hinzu. Übrig bleiben die Kraft in $B$ und ein Kräftepaar mit dem Versetzungsmoment $M = d F$.])

Das ist dasselbe wie $vM_B = arrow(B A) times vF$. Die Kraft darf an jeden Punkt verschoben werden, wenn man das dabei «verlorene» Moment als Kräftepaar dazugibt.

=== Parallele Kräfte und Hebelgesetz

Zwei parallele Kräfte $vF_1, vF_2$ mit $vF_1 + vF_2 != bold(0)$ sind einer Einzelkraft $vR = vF_1 + vF_2$ äquivalent, deren Wirkungslinie parallel ist. Wo liegt sie? Das Moment bezüglich eines Punktes auf der gesuchten Wirkungslinie muss verschwinden, denn dort hat $vR$ keinen Hebelarm. Daraus folgt das *Hebelgesetz*
#gl($ a_1 |vF_1| = a_2 |vF_2|, $)
wobei $a_1, a_2$ die Abstände der Wirkungslinie von $vR$ zu den Wirkungslinien von $vF_1, vF_2$ sind. Bei gleich gerichteten Kräften liegt $vR$ dazwischen (näher bei der größeren Kraft), bei entgegengesetzt gerichteten außerhalb, auf der Seite der größeren.

=== Das Kräftepaar

#defn[Kräftepaar][
  Zwei parallele Kräfte mit $vF_1 + vF_2 = bold(0)$ (gleich groß, entgegengesetzt, verschiedene Wirkungslinien) bilden ein *Kräftepaar*. Sein Moment
  #gl($ vM = arrow(A' A) times vF, quad |vM| = b |vF|, $)
  hängt nicht vom Bezugspunkt ab ($b$: Abstand der Wirkungslinien, die «Breite»).
]

#fg("k06_paare", [Links: Zwei gleich gerichtete parallele Kräfte sind einer Einzelkraft $vR = vF_1 + vF_2$ äquivalent, deren Lage das Hebelgesetz festlegt. Rechts: das Kräftepaar, Resultierende null, aber Moment $M = b F$.])

Weil $vR = bold(0)$ ist, fällt in $vM_P = vM_O + arrow(P O) times vR$ der Zusatzterm weg. Das Moment eines Kräftepaars ist ein *freier Vektor*. Man darf ein Kräftepaar am starren Körper beliebig verschieben und in seiner Ebene drehen, und man darf $F$ und $b$ verändern, solange das Produkt $b F$ gleich bleibt. Deshalb zeichnet man ein Kräftepaar oft nur als gebogenen Pfeil mit dem Wert $M$.

#intu[
  Ein Kräftepaar ist «reine Drehwirkung». Zwei Hände am Lenkrad: Die eine zieht, die andere drückt. Das Lenkrad wird nirgendwohin geschoben, es wird nur gedreht. Ein Kräftepaar lässt sich nie durch eine einzelne Kraft ersetzen, und umgekehrt kann eine Einzelkraft nie ein reines Moment sein. Kraft und Kräftepaar sind die beiden Grundbausteine jeder Belastung.
]

#bsp[Zahnrad][
  Der Zahnflankendruck $F$ greift am Zahnrad (Radius $R$) tangential am Umfang an. Parallel verschoben in den Mittelpunkt $O$ ergibt sich die Kraft $F$ in $O$ (sie wird vom Lager aufgenommen) und das Versetzungsmoment $M = R F$. Das Lager muss also _beides_ leisten: die Kraft $F$ aufnehmen und das Rad gegen das Antriebsmoment $M$ festhalten.
]

== Gleichgewicht einer Kräftegruppe

#defn[Gleichgewicht, Nullgruppe][
  Eine Kräftegruppe ist im *Gleichgewicht* (sie ist eine *Nullgruppe*), wenn ihre Resultierende und ihr Moment bezüglich eines Punktes verschwinden:
  #gl($ vR = bold(0), wide vM_O = bold(0). $)
]

Ist $vR = bold(0)$, so verschwindet $vM_O$ entweder für alle Bezugspunkte oder für keinen (denn $vM_P = vM_O + arrow(P O) times bold(0) = vM_O$). Die erste Gleichung heißt *Komponentenbedingung*, die zweite *Momentenbedingung*. Eine Nullgruppe hat bei jeder Starrkörperbewegung die Leistung null. Man darf sie zu jeder Kräftegruppe hinzufügen oder weglassen, ohne die Äquivalenz zu ändern. Im Raum sind das 6 skalare Gleichungen, in der Ebene 3: $R_x = 0$, $R_y = 0$, $M_z = 0$.

#satz[Zwei und drei Kräfte im Gleichgewicht][
  - *Zwei* Kräfte sind nur dann im Gleichgewicht, wenn sie gleich groß, entgegengesetzt sind und auf *derselben Wirkungslinie* liegen.
  - *Drei* nichtparallele Kräfte in einer Ebene sind nur dann im Gleichgewicht, wenn sich ihre Wirkungslinien in *einem Punkt* schneiden und ihre Vektoren ein geschlossenes Dreieck bilden.
]

#warum[Zwei bzw. drei Kräfte][
  _Zwei Kräfte:_ $vR = bold(0)$ erzwingt $vF_2 = -vF_1$. Dann bilden sie ein Kräftepaar mit Moment $b F$; es verschwindet nur für $b = 0$, also gleiche Wirkungslinie.

  _Drei Kräfte:_ Schneiden sich zwei Wirkungslinien im Punkt $S$, wähle $S$ als Bezugspunkt. Deren Momente sind null; die Momentenbedingung verlangt dann auch für die dritte $a F = 0$: Ihre Wirkungslinie muss ebenfalls durch $S$ gehen. Mit $vR = bold(0)$ schließt sich das Kräftedreieck.
]

Beides sind in Aufgaben mächtige Werkzeuge: Kennt man zwei Wirkungslinien, kennt man die Richtung der dritten Kraft.

#woche(8, [Reduktion, Schwerpunkt, Ruhe], [98–118])
== Reduktion einer Kräftegruppe

*Reduktion* heißt: die einfachste statisch äquivalente Kräftegruppe finden. Erster Schritt ist stets die Dyname ${vR, vM_B}$ in einem bequemen Punkt $B$: eine Einzelkraft $vR$ in $B$ plus ein Kräftepaar mit dem Moment $vM_B$.

#fg("k06_dyname", [Reduktion: Jede Kräftegruppe ist äquivalent zu ihrer Dyname (Kraft $vR$ in $B$ plus Kräftepaar $vM_B$). Wählt man den Bezugspunkt auf der Zentralachse, wird daraus die einfachste Form, die Schraube.])

Wie bei der Kinemate gibt es *Invarianten*, die nicht vom Bezugspunkt abhängen:
#gl($ "1. Invariante:" quad vR, wide "2. Invariante:" quad vR dot.c vM_P = vR dot.c vM_O. $)
Die zweite folgt aus $vM_P = vM_O + arrow(P O) times vR$, denn $vR dot.c (arrow(P O) times vR) = 0$. Sie sagt: Der Anteil von $vM$ _in Richtung von $vR$_ ist überall gleich. Nur der Anteil senkrecht zu $vR$ hängt vom Bezugspunkt ab, und man kann ihn durch geschickte Wahl zum Verschwinden bringen. Die Punkte, wo das gelingt, bilden die *Zentralachse* (parallel zu $vR$):
#gl($ arrow(B Z) = (vR times vM_B) / R^2, wide vM_Z = vM^((R)) = lambda vR. $)
Die Dyname ${vR, vM_Z}$ auf der Zentralachse heißt (Kraft-)*Schraube*: eine Kraft und ein Kräftepaar, das um die Richtung dieser Kraft dreht (wie beim Anziehen einer Schraube mit dem Schraubenzieher).

#table(columns: (auto, auto, 1fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [$vR$], [$vM_B$], [*einfachste äquivalente Kräftegruppe*],
  table.hline(stroke: 0.4pt),
  [$= bold(0)$], [$= bold(0)$], [nichts: Gleichgewicht (Nullgruppe)],
  [$= bold(0)$], [$!= bold(0)$], [ein *Kräftepaar* mit Moment $vM_B$],
  [$!= bold(0)$], [$vR dot.c vM_B = 0$], [eine *Einzelkraft* $vR$ auf der Zentralachse],
  [$!= bold(0)$], [$vR dot.c vM_B != 0$], [eine *Schraube*: $vR$ auf der Zentralachse plus Kräftepaar $vM^((R)) parallel vR$],
  table.hline(stroke: 0.7pt),
)

#merke[
  Bei *ebenen* Kräftegruppen und bei *parallelen* Kräften steht das Moment immer senkrecht auf $vR$, also $vR dot.c vM_B = 0$. Solche Gruppen lassen sich daher immer auf eine Einzelkraft reduzieren (oder auf ein Kräftepaar, wenn $vR = bold(0)$). Die echte Schraube gibt es nur im Raum.
]

#rezept[Ebene Kräftegruppe reduzieren][
  + Koordinaten wählen, alle Kräfte in Komponenten $X_i, Y_i$ zerlegen.
  + $R_x = sum X_i$, $R_y = sum Y_i$.
  + Bezugspunkt $O$ wählen (möglichst dort, wo viele Wirkungslinien durchgehen) und $M_O = sum (x_i Y_i - y_i X_i)$ bilden, oder direkt «Kraft mal Hebelarm» mit Vorzeichen nach Drehsinn.
  + Ist $vR != bold(0)$: Die Wirkungslinie der äquivalenten Einzelkraft erfüllt $x R_y - y R_x = M_O$. Ihr Abstand von $O$ ist $a = |M_O| \/ |vR|$.
]

#bsp[Drei Kräfte an einer Platte][
  An einer quadratischen Platte (Seitenlänge $a$, Ecken $O(0,0)$, $P(a,0)$, $Q(a,a)$, $S(0,a)$) greifen an: in $P$ die Kraft $(0, F)$, in $Q$ die Kraft $(-F, 0)$, in $S$ die Kraft $(0, -2F)$.

  _Resultierende:_ $R_x = -F$, $R_y = F - 2F = -F$.

  _Moment bezüglich $O$_ ($x Y - y X$ für jede Kraft): in $P$: $a dot.c F - 0 = a F$; in $Q$: $a dot.c 0 - a dot.c (-F) = a F$; in $S$: $0 dot.c (-2F) - a dot.c 0 = 0$. Also $M_O = 2 a F$.

  _Ergebnis:_ Die Gruppe ist einer Einzelkraft $vR = (-F, -F)$ äquivalent. Ihre Wirkungslinie erfüllt $x(-F) - y(-F) = 2 a F$, also $y = x + 2a$. Ihr Abstand von $O$ ist $2 a F \/ (sqrt(2) F) = sqrt(2) a$.
]

#fehler[
  - Das Moment einer Kräftegruppe als «Moment der Resultierenden» berechnen, ohne zu wissen, wo die Resultierende angreift. $vR$ allein hat keinen Angriffspunkt.
  - Bei $vR = bold(0)$ auf Gleichgewicht schließen. Es kann ein Kräftepaar übrig bleiben.
  - Den Hebelarm bis zum Angriffspunkt statt senkrecht bis zur Wirkungslinie messen.
  - In der Ebene die Vorzeichen der Momente nicht konsequent nach einem festen Drehsinn vergeben.
]

#aufgaben()

#aufg(fig: "a06_wuerfel", fw: 5.8cm)[Ist die Kräftegruppe im Gleichgewicht?][
  An einem Würfel (Kantenlänge $a$) greifen vier Kräfte an:
  - in $A(0,0,0)$: $vF_A = (-F, 0, 0)$,
  - in $B(a,a,0)$: $vF_B = (0, F, 0)$,
  - in $C(a,0,0)$: $vF_C = (0, 0, F)$,
  - in $D(0,a,a)$: $vF_D = (F, -F, -F)$.
  Ist die Kräftegruppe im Gleichgewicht?
][
  _Komponentenbedingungen._ $vR = (-F + F, thick F - F, thick F - F) = bold(0)$ ✓.

  _Momentenbedingungen_ bezüglich $A$ ($vF_A$ hat dort kein Moment):
  $ arrow(A C) times vF_C &= (a, 0, 0) times (0, 0, F) = (0, -a F, 0), \
    arrow(A B) times vF_B &= (a, a, 0) times (0, F, 0) = (0, 0, a F), \
    arrow(A D) times vF_D &= (0, a, a) times (F, -F, -F) = (0, a F, -a F). $
  Die Summe ist $vM_A = bold(0)$ ✓.

  Beide Bedingungen sind erfüllt, die Kräftegruppe ist im Gleichgewicht (eine Nullgruppe). Weil $vR = bold(0)$ ist, hängt das Moment nicht vom Bezugspunkt ab; ein einziger Bezugspunkt genügt für die Prüfung.
]

#kurz[
  - Statisch äquivalent $<=>$ gleiche Dyname: $vR = vR^*$, $vM_O = vM_O^*$.
  - $vM_O = arrow(O A) times vF$, Betrag = Kraft $times$ Hebelarm. $vM_P = vM_O + arrow(P O) times vR$.
  - Kraft längs ihrer Wirkungslinie verschiebbar; Parallelverschiebung kostet ein Versetzungsmoment.
  - Kräftepaar: $vR = bold(0)$, Moment $b F$, freier Vektor.
  - Gleichgewicht: $vR = bold(0)$ und $vM_O = bold(0)$. Zwei Kräfte: gleiche Wirkungslinie. Drei Kräfte: ein gemeinsamer Schnittpunkt.
  - Reduktion: Nullgruppe, Kräftepaar, Einzelkraft oder Schraube; Zentralachse $arrow(B Z) = (vR times vM_B)\/R^2$.
]
