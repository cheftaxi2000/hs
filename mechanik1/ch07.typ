#import "lib.typ": *

= Parallele Kräfte und Schwerpunkt

Parallele Kräfte sind der häufigste Fall überhaupt: Alle Gewichtskräfte zeigen nach unten. Nach Kapitel 6 lässt sich eine parallele Kräftegruppe immer auf eine Einzelkraft reduzieren. Die Frage ist nur noch: _Wo_ greift sie an? Die Antwort liefert der Kräftemittelpunkt, und im Spezialfall des Gewichts heißt er Schwerpunkt.

== Kräftemittelpunkt

Gegeben seien Kräfte $vF_i = F_i ve$ mit gemeinsamer Richtung $ve$ und Angriffspunkten $vr_i$. Die $F_i$ dürfen Vorzeichen haben, solange die Summe $sum F_i != 0$ ist. Die Resultierende ist $vR = (sum F_i) ve$. Sie soll in einem Punkt $S$ so angreifen, dass sie dasselbe Moment bezüglich eines beliebigen Punktes $O$ hat wie die ganze Gruppe:
$ vr_S times (sum F_i) ve = sum F_i vr_i times ve quad <=> quad (vr_S sum F_i - sum F_i vr_i) times ve = bold(0). $
Soll das nicht nur für eine Richtung $ve$ gelten, sondern für _jede_ (wir drehen alle Kräfte gemeinsam), muss die Klammer verschwinden:

#defn[Kräftemittelpunkt][
  #gl($ vr_S = (sum_i F_i vr_i) / (sum_i F_i), wide "d. h." quad x_S = (sum x_i F_i) / (sum F_i), quad y_S = (sum y_i F_i) / (sum F_i), quad z_S = (sum z_i F_i) / (sum F_i). $)
  Der Punkt $S$ liegt auf der Wirkungslinie der äquivalenten Einzelkraft $vR$, und zwar auch dann noch, wenn man alle Kräfte gemeinsam in eine andere Richtung dreht.
]

#intu[
  Das ist ein gewichteter Mittelwert der Angriffspunkte: Jeder Punkt «stimmt ab», und seine Stimme zählt so viel wie seine Kraft. Zwei Kinder auf einer Wippe: Der Kräftemittelpunkt liegt näher beim schwereren Kind. Genau dort muss man die Wippe unterstützen, damit sie im Gleichgewicht ist, egal wie man die Wippe neigt. Mit dem Hebelgesetz aus Kapitel 6 stimmt das überein: $a_1 F_1 = a_2 F_2$.
]

#bsp[Wippe][
  Kinder mit 30 kg und 20 kg sitzen auf einer Wippe, 3 m voneinander entfernt. Nimmt man das schwerere Kind als Ursprung, $x_1 = 0$, $x_2 = 3$ m: $x_S = (0 dot.c 30 + 3 dot.c 20)\/(30 + 20) = 1.2$ m. Der Drehpunkt liegt 1.2 m vom schwereren Kind entfernt. Kontrolle mit dem Hebelgesetz: $1.2 dot.c 30 = 36 = 1.8 dot.c 20$ ✓.
]

Für parallele Kräfte $vF_i = Z_i ve_z$ (Basis so gewählt, dass die Wirkungslinien parallel zur $z$-Achse liegen) hat die Reduktion auf den Ursprung eine besonders einfache Gestalt: Die Resultierende ist $vR = (sum Z_i) ve_z$, und das Moment $vM_O$ hat nur Komponenten in der $x y$-Ebene, denn $vM_O = sum arrow(O A_i) times Z_i ve_z$ steht senkrecht auf $ve_z$. Daraus folgt $vR dot.c vM_O = 0$. Nach Kapitel 6 kann man eine parallele Kräftegruppe deshalb *immer* auf eine Einzelkraft oder, für $vR = bold(0)$, auf ein Kräftepaar in einer zur $z$-Achse parallelen Ebene reduzieren. Für $vR != bold(0)$ ist die Wirkungslinie der Einzelkraft die Zentralachse.

Warum heißt $S$ «Mittelpunkt»? Dreht man alle Kräfte einer _gleich gerichteten_ Gruppe um ihre Angriffspunkte um denselben Winkel, ändert sich die Resultierende nur in der Richtung, und ihre Wirkungslinie dreht sich um den festen Punkt $S$. Genau diesen Punkt meinen wir. Er hängt auch nicht davon ab, wo man den Ursprung des Koordinatensystems hinlegt: Verschiebt man ihn nach $O'$, haben alle Ortsvektoren den Zusatz $arrow(O' O)$, und die Formel liefert $vr'_S = vr_S + arrow(O' O)$. Der Punkt $S$ bleibt also am selben materiellen Ort des Körpers. Er ist eine Eigenschaft der Kräftegruppe, nicht des Koordinatensystems.

== Linien- und flächenverteilte Kräfte

Bei kontinuierlichen Verteilungen werden die Summen zu Integralen, der Beitrag jedes Elements ist $dif F = q dif x$:
#gl($ R = integral q(x) dif x, wide x_S = (integral x q(x) dif x) / (integral q(x) dif x). $)

#merke[
  Die äquivalente Einzelkraft einer Linienlast hat als Betrag die *Fläche* unter dem Lastdiagramm und greift im *Flächenschwerpunkt* dieses Diagramms an. Man rechnet nicht jedes Mal das Integral aus, sondern kennt die beiden Standardfälle.
]

#fg("k07_last", [Gleichlast: $R = q_0 L$, Mitte. Dreieckslast: $R = q_0 L\/2$, im Abstand $2L\/3$ von der Spitze (also $L\/3$ von der großen Seite).])

#warum[Die Dreieckslast][
  $q(x) = q_0 x \/ L$ steigt linear von null auf $q_0$. Dann ist $R = integral_0^L (q_0 x\/L) dif x = q_0 L\/2$ (Dreiecksfläche), und $x_S = (integral_0^L x (q_0 x\/L) dif x)\/R = (q_0 L^2\/3)\/(q_0 L\/2) = 2L\/3$.
]

Eine Dreieckslast tritt zum Beispiel als Schneelast auf einem Dach oder als Wasserdruck auf einer senkrechten Wand auf.

Ein Trapez zerlegt man in ein Rechteck und ein Dreieck (zwei Ersatzkräfte), ein beliebiger Verlauf in einfache Teile oder man integriert.

Für eine parallele Flächenlast $s(vr)$ auf einer Fläche gilt entsprechend $R = integral s dif A$ und $vr_S = (integral vr s dif A) \/ (integral s dif A)$. Ist die Last *uniform* ($s = "konst."$), kürzt sich $s$ heraus, und $S$ fällt mit dem rein geometrischen *Flächenmittelpunkt* zusammen:
#gl($ vr_C = 1 / A integral vr dif A. $)

#bsp[Flächenmittelpunkt einer Halbkugelfläche][
  Bei einer Halbkugelfläche mit Radius $R$ liegen die Flächenmittelpunkte der dünnen ringförmigen Streifen (Dicke $dif z$) auf der $z$-Achse; also liegt auch der Flächenmittelpunkt $C$ der ganzen Fläche auf ihr. Mit dem Höhenwinkel $beta$: $z = R sin beta$, $dif s = R dif beta$, $dif A = 2 pi (R cos beta) dif s = 2 pi R^2 cos beta dif beta$:
  $ z_C = 1 / A integral z dif A = (2 pi R^3) / (2 pi R^2) integral_0^(pi\/2) sin beta cos beta dif beta = R/2. $
  Der Flächenmittelpunkt einer gekrümmten Fläche liegt im Allgemeinen nicht auf der Fläche selbst, hier schwebt er in der halben Höhe über der Grundfläche.
]

Für kontinuierlich verteilte parallele Fernkräfte (Gravitation in Erdnähe, parallele elektromagnetische Kräfte) geht man von der Raumkraftdichte $vf = f ve$ aus. Die Resultierende ist $vR = (integral f dif V) ve$, das Moment $vM_O = (integral vr f dif V) times ve$, und der Kräftemittelpunkt folgt wie in den letzten Abschnitten. Bei _uniformer_ Raumkraftverteilung ($f = f_0$) fällt $f_0$ heraus.

== Schwerpunkt und Massenmittelpunkt

Jedes Volumenelement $dif V$ eines Körpers hat das Gewicht $dif G = gamma dif V$ mit dem spezifischen Gewicht $gamma = rho g$. Das *Gesamtgewicht* ist $G = integral gamma dif V$.

#defn[Schwerpunkt][
  Der *Schwerpunkt* $S$ ist der Kräftemittelpunkt der Gewichtskräfte:
  #gl($ vr_S = 1 / G integral vr gamma dif V. $)
  Besteht der Körper aus Teilkörpern mit Gewichten $G_i$ und Teilschwerpunkten $vr_i$, gilt
  #gl($ vr_S = (sum_i G_i vr_i) / (sum_i G_i). $)
]

#defn[Massenmittelpunkt][
  Mit $dif m = rho dif V$ und $m = integral rho dif V$ heißt $vr_C := 1/m integral vr dif m$ der *Massenmittelpunkt*. Im homogenen Schwerefeld ($g$ überall gleich) fällt er mit dem Schwerpunkt zusammen. Ist der Körper zusätzlich homogen ($rho = "konst."$), ist er der geometrische *Volumenmittelpunkt* $vr_C = 1/V integral vr dif V$.
]

#intu[
  Der Schwerpunkt ist der Punkt, an dem du einen Körper auf einer Fingerspitze balancieren könntest, in jeder Orientierung. Für alle Gleichgewichtsfragen darfst du das gesamte, über den Körper verschmierte Gewicht durch _eine_ Kraft $vG$ im Schwerpunkt ersetzen. Der Schwerpunkt muss dabei nicht im Material liegen: Bei einem Ring liegt er in der Mitte des Lochs. Bei Körpern in der Nähe der Erdoberfläche ist $g$ praktisch konstant, deshalb ist dort der Massenmittelpunkt der Schwerpunkt.
]

Drei Dinge zum Schwerpunkt:

- Er ist der Kräftemittelpunkt der Gewichtskräfte, also der Angriffspunkt des resultierenden Gewichts _unabhängig davon, wie der Körper zur Schwerkraft orientiert ist_ (solange er in Erdnähe bleibt). Bei Starrkörperbewegungen ändert sich seine Lage im Körper nicht. Das lässt sich mit den Formeln nachrechnen; am elegantesten gelingt es mit Drehmatrizen.
- Wie jeder Kräftemittelpunkt muss er nicht im Material liegen. Eine homogene Hohlkugel hat ihren Schwerpunkt im Zentrum, in der Luft.
- Der Betrag des spezifischen Gewichts folgt aus der spezifischen Masse (Dichte) $rho$ und der Erdbeschleunigung: $gamma = rho g$. Streng genommen müsste man zwischen träger und schwerer Masse unterscheiden; Einstein hat ihre Gleichheit postuliert, sie ist eine Grundlage der allgemeinen Relativitätstheorie.

Der *Massenmittelpunkt* $vr_C$ ist wie der Schwerpunkt definiert, aber mit der Masse statt mit dem Gewicht. Bei Körpern, deren Abmessungen viel kleiner als der Erdradius sind, fallen beide zusammen. Bei großen Körpern und in der Astronomie ist das Gravitationsfeld nicht mehr aus parallelen Kräften aufgebaut, der Begriff des Kräftemittelpunkts (und damit der Schwerpunkt) entfällt, aber der Massenmittelpunkt existiert trotzdem, weil er nicht aus einer Momentenbedingung, sondern aus der Massenverteilung allein definiert ist. Ein Körper heißt *homogen*, wenn $rho = rho_0$ im ganzen Körper konstant ist; dann ist $m = rho_0 V$, und $rho_0$ kürzt sich aus allen Formeln.

#rezept[Schwerpunkt bestimmen][
  + *Symmetrie nutzen.* Hat der (homogene) Körper eine Symmetrieebene oder -achse, liegt der Schwerpunkt darauf. Mit zwei Symmetrieachsen: Schnittpunkt, fertig.
  + *Zerlegen* in einfache Teile mit bekanntem Schwerpunkt und Formel $x_S = (sum x_i A_i)\/(sum A_i)$. Bei homogenen Flächen genügen die Flächeninhalte als Gewichte, bei Körpern die Volumina.
  + *Löcher* sind Teile mit *negativer* Fläche (Vollkörper minus Ausschnitt).
  + Nur wenn das nicht geht: integrieren, mit Streifen oder Ringen, deren Schwerpunkt offensichtlich ist.
]

#fg("k07_schwerpunkte", [Schwerpunkte homogener Flächen und Linien, die immer wieder vorkommen (rot: $S$).])

Weitere nützliche Werte: Halbkugelschale $R\/2$ über der Grundfläche, Halbkugelkörper $3R\/8$, Kegel und Pyramide $h\/4$ über der Grundfläche.

#bsp[L-Profil][
  Ein L besteht aus dem liegenden Rechteck $4a times a$ (Schwerpunkt $(2a, a\/2)$, Fläche $4a^2$) und dem stehenden $a times 3a$ darüber am linken Rand (Schwerpunkt $(a\/2, 5a\/2)$, Fläche $3a^2$). Der Ursprung liegt in der linken unteren Ecke.
  $ x_S = (2a dot.c 4a^2 + (a\/2) dot.c 3a^2) / (7a^2) = 19/14 a approx 1.36 a, wide y_S = ((a\/2) dot.c 4a^2 + (5a\/2) dot.c 3a^2) / (7a^2) = 19/14 a. $
  Kontrolle: Das L ist symmetrisch zur Diagonalen $y = x$, also muss $x_S = y_S$ herauskommen ✓.
]

#bsp[Kreisscheibe mit Loch][
  Scheibe mit Radius $R$ um den Ursprung, kreisförmiges Loch mit Radius $R\/2$ um $(R\/2, 0)$. Die Flächen sind $pi R^2$ und $-pi R^2\/4$ (das Loch zählt negativ).
  $ x_S = (0 dot.c pi R^2 + (R\/2) dot.c (-pi R^2\/4)) / (pi R^2 - pi R^2\/4) = (-pi R^3\/8) / (3 pi R^2\/4) = -R/6. $
  Der Schwerpunkt wandert vom Loch weg, wie man erwartet.
]

#fg("k07_beispiele", [Die beiden Beispiele: $S$ des L-Profils (links) und der Scheibe mit Loch (rechts).])

#aufgaben()

#aufg(fig: "a07_rahmen", fw: 6.6cm)[Kräftemittelpunkt paralleler Kräfte][
  An einem quadratischen Rahmen (Raster 1 m) greifen fünf Kräfte parallel zur $x$-Achse an (Koordinaten in m, positiv in $+x$-Richtung):

  #align(center, table(columns: 6, stroke: none, inset: (x: 5pt, y: 2.5pt), align: center,
    [], [$A_1$], [$A_2$], [$A_3$], [$A_4$], [$A_5$],
    table.hline(stroke: 0.4pt),
    [Ort], [(4, 4)], [(0, 3)], [(3, 2)], [(1, 1)], [(2, 0)],
    [Kraft], [$-3F$], [$+F$], [$-3F$], [$+3F$], [$-2F$]))

  Gesucht sind die Resultierende, ihre Wirkungslinie und der Kräftemittelpunkt $S$.
][
  _Resultierende._ $R_x = (-3 + 1 - 3 + 3 - 2) F = -4 F$.

  _Wirkungslinie._ Die Einzelkraft $vR$ auf der Geraden $y = y_S$ muss dasselbe Moment um $O$ haben wie die Gruppe: $y_S R_x = sum y_i F_i$, also
  $ y_S = (4 dot (-3) + 3 dot 1 + 2 dot (-3) + 1 dot 3 + 0) / (-4) "m" = (-12)/(-4) "m" = 3 "m". $

  _Kräftemittelpunkt._ Er muss auch dann auf der Wirkungslinie liegen, wenn man alle Kräfte um denselben Winkel dreht. Dreht man sie um 90° in die $y$-Richtung, zählt der Hebelarm $x_i$:
  $ x_S = (4 dot (-3) + 0 dot 1 + 3 dot (-3) + 1 dot 3 + 2 dot (-2)) / (-4) "m" = (-22)/(-4) "m" = 5,5 "m". $
  Also $S = (5,5 "m"; thick 3 "m")$. Der Punkt liegt außerhalb des Rahmens. Das ist möglich, weil die Kräfte verschiedene Vorzeichen haben; bei gleichgerichteten Kräften (Gewichten) liegt $S$ immer «zwischen» den Angriffspunkten.
]

#kurz[
  - Kräftemittelpunkt paralleler Kräfte: $vr_S = (sum F_i vr_i)\/(sum F_i)$, ein gewichteter Mittelwert.
  - Linienlast: $R$ = Fläche des Lastdiagramms, Wirkungslinie durch dessen Schwerpunkt. Gleichlast: Mitte. Dreieck: $2\/3$ von der Spitze.
  - Schwerpunkt: $vr_S = (sum G_i vr_i)\/(sum G_i)$; Symmetrie, Zerlegen, negative Flächen.
  - Homogen und $g$ konstant: Schwerpunkt = Massenmittelpunkt = Volumenmittelpunkt.
]
