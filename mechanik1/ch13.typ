#import "lib.typ": *

= Seilstatik

Ein Seil (oder eine Kette) ist das Gegenteil eines starren Körpers: Es ist vollkommen biegsam. Im Modell ist es zusätzlich undehnbar. Aus der Biegsamkeit folgt die eine Eigenschaft, auf der alles aufbaut:

#merke[
  Ein Seil kann nur *Zug* übertragen, und die *Seilkraft* $vS$ ist in jedem Punkt *tangential* zum Seil. Ein Seil kann weder drücken noch quer zu sich eine Kraft oder ein Moment aufnehmen.
]

Daraus folgt sofort:
- Ein *gewichtsloses Seil* zwischen zwei Punkten, an dem dazwischen keine Kraft angreift, ist *gerade*, und die Seilkraft ist überall gleich. Greifen Einzellasten an, bildet es ein *Seilpolygon*; an jedem Knickpunkt herrscht Gleichgewicht zwischen der Last und den beiden Seilkräften.
- Läuft ein gewichtsloses Seil über eine *reibungsfrei gelagerte Rolle*, so ist der Betrag der Seilkraft auf beiden Seiten *gleich* (Momentenbedingung um die Rollenachse). Die Rolle lenkt die Kraft nur um.

== Das schwere Seil: Kettenlinie

Jetzt habe das Seil selbst Gewicht: $p$ sei sein Gewicht pro Länge (N/m). Wir schneiden ein kurzes Stück der Bogenlänge $dif s$ heraus. An seinen Enden wirken die Seilkräfte, die wir in eine horizontale Komponente $H$ und eine vertikale $V$ zerlegen; dazu kommt das Gewicht $p dif s$.

#fig(13.4, 4.8, caption: [Links: die Kettenlinie mit Scheitel $A$. Die $x$-Achse liegt um $a = H\/p$ unter dem Scheitel. Rechts: Kräfte am Seilelement. Horizontal ändert sich nichts, vertikal kommt das Gewicht $p dif s$ dazu.],
  arr((0.4,0.5),(7.0,0.5), w: 0.5pt, hs: 0.14), arr((3.6,0.3),(3.6,4.5), w: 0.5pt, hs: 0.14), lbl((7.2,0.5), $x$), lbl((3.6,4.7), $y$),
  graph(t => 1.2 * calc.cosh(t / 1.2), -2.3, 2.3, o: (3.6,0.5), c: black, w: 1.4pt),
  pt((3.6,1.7)), lbl((3.35,1.95), $A$),
  bem((3.6,0.5),(3.6,1.7), $a$, off: 0.3),
  pt((5.4,2.33)), arr((5.4,2.33),(6.3,3.33), c: cf, w: 1.3pt), lbl((6.2,3.65), $vS$, c: cf),
  arr((5.4,2.33),(6.3,2.33), c: cf, w: 0.8pt, dash: "dashed"), arr((6.3,2.33),(6.3,3.33), c: cf, w: 0.8pt, dash: "dashed"),
  lbl((5.9,2.1), $H$, c: cf, size: 8pt), lbl((6.55,2.8), $V$, c: cf, size: 8pt),
  arc((5.4,2.33), 0.5, 0, 48, w: 0.5pt), lbl((6.05,2.55), $tau$, size: 8pt),
  dl((5.4,0.5),(5.4,2.33)), lbl((5.6,1.3), $y$, size: 8pt),
  // Element
  pl(((9.4,1.4),(10.2,1.75),(11.0,2.3),(11.6,2.9)), s: 1.6pt + black),
  arr((9.4,1.4),(8.5,1.4), c: cf, w: 1.1pt), arr((9.4,1.4),(9.4,0.8), c: cf, w: 1.1pt),
  arr((11.6,2.9),(12.5,2.9), c: cf, w: 1.1pt), arr((11.6,2.9),(11.6,3.9), c: cf, w: 1.1pt),
  arr((10.5,1.95),(10.5,0.95), c: cf, w: 1.1pt),
  lbl((8.6,1.7), $H$, c: cf, size: 8pt), lbl((9.15,0.9), $V$, c: cf, size: 8pt), lbl((12.4,3.2), $H$, c: cf, size: 8pt), lbl((12.4,3.8), $V + dif V$, c: cf, size: 8pt), lbl((11.0,1.1), $p dif s$, c: cf, size: 8pt),
)

Gleichgewicht am Element:
#gl($ dif H = 0, wide dif V = p dif s. $)

#merke[
  Die *Horizontalkomponente $H$ der Seilkraft ist längs des ganzen Seils konstant* (Horizontalzug). Die Vertikalkomponente wächst um das Gewicht des dazwischenliegenden Seilstücks. Vom Scheitel aus gemessen ($s = 0$, dort ist $V = 0$) gilt also einfach $V = p s$: Jeder Punkt trägt das Seil zwischen sich und dem Scheitel.
]

Weil $vS$ tangential ist, gilt für den Neigungswinkel $tau$ des Seils $tan tau = y' = V \/ H$. Mit der Abkürzung
#gl($ a := H / p $)
(eine Länge) wird daraus $y' = s \/ a$. Ableiten nach $x$ und $dif s = sqrt(1 + y'^2) dif x$ einsetzen gibt die Differentialgleichung $a y'' = sqrt(1 + y'^2)$. Ihre Lösung, mit dem Scheitel bei $x = 0$ und der $x$-Achse um $a$ unter dem Scheitel:

#satz[Kettenlinie][
  #gl($ y = a cosh(x / a), wide s = a sinh(x / a), wide y^2 - s^2 = a^2. $)
  Für die Seilkraft gilt
  #gl($ H = p a, wide V = p s, wide S = sqrt(H^2 + V^2) = p y. $)
]

Die letzte Formel ist bemerkenswert einfach: Die Seilkraft in einem Punkt ist das Gewicht eines Seilstücks, dessen Länge gleich der Höhe $y$ des Punkts über der $x$-Achse ist. Am kleinsten ist sie im Scheitel ($S = H$), am größten in den Aufhängepunkten.

#intu[
  Der Parameter $a = H\/p$ sagt, wie «straff» das Seil ist. Großes $a$ (starker Horizontalzug, leichtes Seil): flache Kurve. Kleines $a$: Das Seil hängt tief durch. Ein Seil völlig gerade zu spannen ist unmöglich -- dafür müsste $H$ unendlich werden, denn irgendetwas Vertikales muss das Gewicht tragen, und das geht nur mit einer Neigung.
]

=== Flach gespanntes Seil: Parabel

Ist das Seil straff ($|x| << a$), entwickelt man $cosh$ und $sinh$:
#gl($ y - a approx x^2 / (2a), wide s approx x + x^3 / (6 a^2). $)
Die Kettenlinie wird zur *Parabel*. Für ein flaches Seil mit Spannweite $l$ zwischen gleich hohen Aufhängepunkten ist der Durchhang damit $f approx l^2 \/ (8a) = p l^2 \/ (8H)$. Doppelter Horizontalzug, halber Durchhang.

== Seilreibung

Ein Seil ist über einen ruhenden rauen Zylinder (Poller, Trommel) gelegt und umschlingt ihn über den Winkel $alpha$. Am einen Ende wirkt $S_1$, am anderen $S_2 > S_1$. Wie groß darf $S_2$ werden, bevor das Seil rutscht?

#fig(13, 4.3, caption: [Links: Seil auf der Trommel. Rechts: Kräfte an einem Seilelement mit dem Öffnungswinkel $dif phi$. Die beiden Seilkräfte drücken das Element mit $dif N = S dif phi$ an; die Reibung $mu dif N$ trägt den Unterschied $dif S$.],
  circ((2.6,2.0), 1.4, fill: cl),
  arc((2.6,2.0), 1.4, 0, 180, w: 1.6pt),
  li((1.2,2.0),(1.2,0.5), s: 1.6pt + black), li((4.0,2.0),(4.0,0.5), s: 1.6pt + black),
  arr((1.2,0.5),(1.2,-0.2), c: cf, w: 1.3pt), arr((4.0,0.5),(4.0,-0.5), c: cf, w: 1.3pt),
  lbl((0.8,0.0), $S_1$, c: cf), lbl((4.45,-0.2), $S_2$, c: cf),
  arc((2.6,2.0), 0.6, 0, 180, w: 0.5pt), lbl((2.6,2.85), $alpha$, size: 8pt), pt((2.6,2.0)),
  // Element
  arc((9.6,-0.6), 3.4, 70, 110, w: 1.8pt),
  dl((9.6,-0.6),(8.44,2.6)), dl((9.6,-0.6),(10.76,2.6)),
  arr((8.44,2.6),(7.5,2.26), c: cf, w: 1.2pt), arr((10.76,2.6),(11.9,2.19), c: cf, w: 1.2pt),
  arr((9.6,1.9),(9.6,2.75), c: cf, w: 1.2pt), arr((10.2,3.05),(9.3,3.05), c: cf, w: 1.2pt),
  lbl((7.35,2.55), $S$, c: cf), lbl((12.3,2.45), $S + dif S$, c: cf), lbl((9.95,2.2), $dif N$, c: cf, size: 8pt), lbl((9.6,3.35), $mu dif N$, c: cf, size: 8pt),
  arc((9.6,-0.6), 1.2, 70, 110, w: 0.5pt), lbl((9.6,0.9), $dif phi$, size: 8pt),
  pb: 0.5,
)

Gleichgewicht am Element (kleine Winkel): radial $dif N = S dif phi$, tangential $dif S = dif F_R$. An der Haftgrenze ist $dif F_R = mu_0 dif N$, also
#gl($ dif S = mu_0 S dif phi quad => quad (dif S) / S = mu_0 dif phi. $)
Der Zuwachs ist proportional zum schon vorhandenen Wert: Das ist die Gleichung des exponentiellen Wachstums.

#satz[Seilreibungsformel (Euler--Eytelwein)][
  Das Seil haftet auf dem Zylinder, solange
  #gl($ S_2 <= S_1 e^(mu_0 alpha) $)
  ist ($alpha$ im Bogenmaß, $S_2$ die größere Kraft). Gleitet das Seil (oder dreht die Trommel unter dem Seil durch), gilt $S_2 = S_1 e^(mu_1 alpha)$.
]

#intu[
  Jedes Stück Umschlingung vervielfacht die Haltekraft um denselben Faktor -- wie Zinseszins. Bei $mu_0 = 0.3$ ergibt eine halbe Umschlingung den Faktor $e^(0.3 pi) approx 2.6$, eine ganze $6.6$, zwei ganze $43$, drei ganze $286$. Deshalb kann ein Matrose ein Schiff halten, indem er das Tau ein paar Mal um den Poller legt. Der Radius des Pollers spielt keine Rolle, nur der Winkel.
]

#bsp[Bandbremse, Prinzip][
  Ein Band umschlingt eine drehende Trommel (Radius $r$) über den Winkel $alpha$. Die Trommel gleitet unter dem Band, also $S_2 = S_1 e^(mu_1 alpha)$, wobei $S_2$ auf der Seite liegt, zu der die Trommel das Band mitziehen will. Das Bremsmoment auf die Trommel ist
  $ M = r (S_2 - S_1) = r S_1 (e^(mu_1 alpha) - 1). $
  Mit einem Hebel, der nur die kleine Kraft $S_1$ aufbringen muss, erzeugt man ein großes Bremsmoment.
]

#kurz[
  - Seil: nur Zug, tangential. Reibungsfreie Rolle: gleiche Seilkraft auf beiden Seiten.
  - Schweres Seil: $H = "konst."$, $V = p s$, $a = H\/p$.
  - Kettenlinie: $y = a cosh(x\/a)$, $s = a sinh(x\/a)$, $S = p y$.
  - Flach: Parabel, Durchhang $f approx p l^2 \/ (8H)$.
  - Seilreibung: $S_2 <= S_1 e^(mu_0 alpha)$.
]
