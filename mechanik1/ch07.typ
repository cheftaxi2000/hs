#import "lib.typ": *

= Parallele Kräfte und Schwerpunkt

Parallele Kräfte sind der häufigste Fall überhaupt: Gewichte zeigen alle nach unten. Nach Kapitel 6 lassen sie sich immer auf eine Einzelkraft reduzieren. Die Frage ist nur noch: _Wo_ greift sie an?

== Kräftemittelpunkt

Gegeben seien Kräfte $vF_i = F_i ve$ mit gemeinsamer Richtung $ve$ und Angriffspunkten $vr_i$ (die $F_i$ dürfen Vorzeichen haben, solange $sum F_i != 0$). Die Resultierende ist $vR = (sum F_i) ve$. Verlangt man, dass eine Einzelkraft $vR$ in einem Punkt $S$ dasselbe Moment hat wie die Gruppe, und zwar *für jede Richtung* $ve$, so folgt

#defn[Kräftemittelpunkt][
  #gl($ vr_S = (sum_i F_i vr_i) / (sum_i F_i), wide "d. h." quad x_S = (sum x_i F_i) / (sum F_i), quad y_S = (sum y_i F_i) / (sum F_i), quad z_S = (sum z_i F_i) / (sum F_i). $)
  Der *Kräftemittelpunkt* $S$ liegt auf der Wirkungslinie der äquivalenten Einzelkraft -- und zwar auch dann noch, wenn man alle Kräfte gemeinsam in eine andere Richtung dreht.
]

#intu[
  Das ist ein gewichteter Mittelwert der Angriffspunkte: Jeder Punkt «stimmt ab», und seine Stimme zählt so viel wie seine Kraft. Zwei Kinder auf einer Wippe: Der Kräftemittelpunkt liegt näher beim schwereren Kind, und genau dort muss die Wippe unterstützt werden, damit sie im Gleichgewicht ist -- egal wie man die Wippe neigt.
]

== Verteilte Kräfte

Bei kontinuierlichen Verteilungen werden die Summen zu Integralen.

=== Linienlast auf einem geraden Träger

#gl($ R = integral_0^L q(x) dif x, wide x_S = (integral_0^L x q(x) dif x) / (integral_0^L q(x) dif x). $)

#merke[
  Die äquivalente Einzelkraft hat als Betrag die *Fläche* unter dem Lastdiagramm und geht durch den *Flächenschwerpunkt* dieses Diagramms.
]

#fig(13, 3.6, caption: [Die zwei Fälle, die man auswendig kennen sollte. Gleichlast: $R = q_0 L$ in der Mitte. Dreieckslast: $R = q_0 L \/ 2$ im Abstand $2 L \/ 3$ von der Spitze.],
  beam((0.6,0.9),(5.6,0.9)), dload((0.6,1.0),(5.6,1.0), hh: 0.9, n: 8),
  arr((3.1,3.3),(3.1,1.95), c: cf, w: 1.5pt), lbl((4.0,3.1), $R = q_0 L$, c: cf, size: 8.5pt), lbl((0.3,1.5), $q_0$, c: cf, size: 8pt),
  bem((0.6,0.9),(3.1,0.9), $L\/2$, off: -0.3), bem((3.1,0.9),(5.6,0.9), $L\/2$, off: -0.3),
  beam((7.6,0.9),(12.6,0.9)), dload((7.6,1.0),(12.6,1.0), hh: 0.0, hh2: 1.4, n: 8),
  arr((10.93,3.3),(10.93,1.95), c: cf, w: 1.5pt), lbl((9.6,3.1), $R = q_0 L \/ 2$, c: cf, size: 8.5pt), lbl((12.95,2.0), $q_0$, c: cf, size: 8pt),
  bem((7.6,0.9),(10.93,0.9), $2L\/3$, off: -0.3), bem((10.93,0.9),(12.6,0.9), $L\/3$, off: -0.3),
)

Ein Trapez zerlegt man in ein Rechteck und ein Dreieck und behandelt beide einzeln.

=== Flächenlast und Flächenmittelpunkt

Für eine parallele Flächenlast $s(vr)$ auf einem Flächenstück gilt entsprechend $R = integral s dif A$ und $vr_S = (integral vr s dif A) \/ (integral s dif A)$. Ist die Last *uniform* ($s = "konst."$), kürzt sich $s$ heraus, und $S$ fällt mit dem rein geometrischen *Flächenmittelpunkt* zusammen:
#gl($ vr_C = 1 / A integral vr dif A. $)

== Schwerpunkt und Massenmittelpunkt

Auf jedes Volumenelement $dif V$ wirkt das Gewicht $dif G = gamma dif V$ mit dem spezifischen Gewicht $gamma = rho g$. Das *Gesamtgewicht* ist $G = integral gamma dif V$.

#defn[Schwerpunkt][
  Der *Schwerpunkt* $S$ ist der Kräftemittelpunkt der Gewichtskräfte:
  #gl($ vr_S = 1 / G integral vr gamma dif V. $)
  Für einen Körper aus Teilkörpern mit Gewichten $G_i$ und Teilschwerpunkten $vr_i$:
  #gl($ vr_S = (sum_i G_i vr_i) / (sum_i G_i). $)
]

#defn[Massenmittelpunkt][
  Mit $dif m = rho dif V$ und $m = integral rho dif V$ ist $vr_C := 1/m integral vr dif m$ der *Massenmittelpunkt*. Im homogenen Schwerefeld ($g$ überall gleich) fällt er mit dem Schwerpunkt zusammen. Ist der Körper zusätzlich homogen ($rho = "konst."$), so ist er der geometrische *Volumenmittelpunkt* $vr_C = 1/V integral vr dif V$.
]

#intu[
  Der Schwerpunkt ist der Punkt, an dem du einen Körper auf einer Fingerspitze balancieren könntest -- in jeder Orientierung. Für alle Gleichgewichtsfragen darfst du das gesamte, über den Körper verschmierte Gewicht durch _eine_ Kraft $vG$ im Schwerpunkt ersetzen. Der Schwerpunkt muss dabei nicht im Material liegen: Bei einem Ring liegt er in der Mitte des Lochs.
]

#rezept[Schwerpunkt bestimmen][
  + *Symmetrie nutzen.* Hat der (homogene) Körper eine Symmetrieebene oder -achse, liegt der Schwerpunkt darauf. Zwei Symmetrieachsen: Schnittpunkt, fertig.
  + *Zerlegen* in einfache Teile mit bekanntem Schwerpunkt, dann $x_S = (sum x_i A_i) \/ (sum A_i)$ (bei homogenen Flächen genügen die Flächeninhalte als Gewichte, bei Körpern die Volumina).
  + *Löcher* sind Teile mit *negativer* Fläche: Vollkörper minus Ausschnitt.
  + Nur wenn das nicht geht: integrieren. Streifen oder Ringe so wählen, dass ihr Schwerpunkt offensichtlich ist.
]

#fig(13.6, 3.2, caption: [Schwerpunkte, die immer wieder vorkommen (homogene Flächen bzw. Linien).],
  // Dreieck
  poly(((0.4,0.6),(3.0,0.6),(2.2,2.6))), pt((1.87,1.27)), dl((0.4,1.27),(3.0,1.27)),
  lbl((3.3,0.95), $h\/3$, size: 8pt, c: cg), lbl((1.7,0.15), [Dreieck], size: 8pt),
  // Halbkreisfläche
  pl(range(31).map(i => pol((5.4,0.6), 1.3, i * 6)), fill: cl, close: true), pt((5.4,1.15)),
  lbl((5.4,1.45), $(4R)/(3 pi)$, size: 7.5pt, c: cg), lbl((5.4,0.15), [Halbkreisfläche], size: 8pt),
  // Halbkreisbogen
  arc((8.6,0.6), 1.3, 0, 180, w: 1.4pt), dl((7.3,0.6),(9.9,0.6)), pt((8.6,1.43)),
  lbl((8.6,1.1), $(2R)/pi$, size: 7.5pt, c: cg), lbl((8.6,0.15), [Halbkreisbogen], size: 8pt),
  // Viertelkreis
  pl(((11.0,0.6),) + range(16).map(i => pol((11.0,0.6), 1.7, i * 6)), fill: cl, close: true), pt((11.72,1.32)),
  lbl((12.35,2.35), $x_C = y_C = (4R)/(3 pi)$, size: 7.5pt, c: cg), lbl((11.9,0.15), [Viertelkreis], size: 8pt),
)

Weitere nützliche Werte: Halbkugel-_Schale_ $R\/2$ über der Grundfläche, Halbkugel-_Körper_ $3R\/8$, Kegel und Pyramide $h\/4$ über der Grundfläche.

#bsp[L-Profil][
  Ein L aus zwei Rechtecken: liegendes Rechteck $4a times a$ (Schwerpunkt bei $(2a, a\/2)$, Fläche $4a^2$) und stehendes Rechteck $a times 3a$ darüber am linken Rand (Schwerpunkt bei $(a\/2, 5a\/2)$, Fläche $3a^2$).
  $ x_S = (2a dot.c 4a^2 + a/2 dot.c 3a^2) / (7a^2) = 19/14 a approx 1.36 a, wide y_S = (a/2 dot.c 4a^2 + (5a)/2 dot.c 3a^2) / (7a^2) = 19/14 a. $
  Kontrolle: Das L ist symmetrisch zur Diagonalen $y = x$ -- also muss $x_S = y_S$ herauskommen. ✓
]

#bsp[Kreisscheibe mit Loch][
  Scheibe mit Radius $R$ um den Ursprung, kreisförmiges Loch mit Radius $R\/2$ um $(R\/2, 0)$. Flächen: $pi R^2$ und $-pi R^2 \/ 4$.
  $ x_S = (0 dot.c pi R^2 - R/2 dot.c (pi R^2)/4) / (pi R^2 - (pi R^2)/4) = -R/6. $
  Der Schwerpunkt wandert vom Loch weg, wie erwartet.
]

#kurz[
  - Kräftemittelpunkt paralleler Kräfte: $vr_S = (sum F_i vr_i) \/ (sum F_i)$, ein gewichteter Mittelwert.
  - Linienlast: $R$ = Fläche des Lastdiagramms, Wirkungslinie durch dessen Schwerpunkt. Gleichlast: Mitte. Dreieck: $2\/3$ von der Spitze.
  - Schwerpunkt: $vr_S = (sum G_i vr_i) \/ (sum G_i)$; Symmetrie, Zerlegen, negative Flächen.
  - Homogen und $g$ konstant: Schwerpunkt = Massenmittelpunkt = Volumenmittelpunkt.
]
