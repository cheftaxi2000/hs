#import "lib.typ": *

= Seilstatik

Ein Seil (oder eine Kette) ist das Gegenteil eines starren Körpers: Es ist vollkommen biegsam. Im Modell ist es zusätzlich undehnbar. Aus der Biegsamkeit folgt die eine Eigenschaft, auf der alles aufbaut:

#merke[
  Ein Seil kann nur *Zug* übertragen, und die *Seilkraft* $vS$ ist in jedem Punkt *tangential* zum Seil. Ein Seil kann weder drücken noch quer zu sich eine Kraft oder ein Moment aufnehmen.
]

Daraus folgt sofort:
- Ein *gewichtsloses Seil* zwischen zwei Punkten, an dem dazwischen keine Kraft angreift, ist *gerade*, und die Seilkraft ist überall gleich. Greifen Einzellasten an, bildet es ein *Seilpolygon*: An jedem Knickpunkt herrscht Gleichgewicht zwischen der Last und den beiden Seilkräften.
- Läuft ein gewichtsloses Seil über eine *reibungsfrei gelagerte Rolle*, so ist der Betrag der Seilkraft auf beiden Seiten *gleich* (Momentenbedingung um die Rollenachse). Die Rolle lenkt die Kraft nur um.

== Das schwere Seil: Kettenlinie

Jetzt habe das Seil selbst Gewicht: $p$ sei sein Gewicht pro Längeneinheit (N/m). Wir schneiden ein kurzes Stück der Bogenlänge $dif s$ heraus. An seinen Enden wirken die Seilkräfte, die wir in eine horizontale Komponente $H$ und eine vertikale $V$ zerlegen. Dazu kommt das Gewicht $p dif s$.

#fg("k13_kette", [Links: die Kettenlinie mit Scheitel $A$; die $x$-Achse liegt um $a = H\/p$ unter dem Scheitel. Rechts: Kräfte am Seilelement. Horizontal ändert sich nichts, vertikal kommt das Gewicht $p dif s$ dazu.])

Gleichgewicht am Element:
#gl($ dif H = 0, wide dif V = p dif s. $)

#merke[
  Die *Horizontalkomponente $H$ der Seilkraft ist längs des ganzen Seils konstant* (Horizontalzug). Die Vertikalkomponente wächst um das Gewicht des dazwischenliegenden Seilstücks. Vom Scheitel aus gemessen ($s = 0$; dort ist $V = 0$) gilt einfach $V = p s$: Jeder Punkt trägt das Seil zwischen sich und dem Scheitel.
]

Weil $vS$ tangential ist, gilt für den Neigungswinkel $tau$ des Seils $tan tau = y' = V\/H$. Mit der Abkürzung
#gl($ a := H / p $)
(eine Länge) wird daraus $y' = s\/a$. Mit $dif s = sqrt(1 + y'^2) dif x$ ergibt sich durch Ableiten nach $x$ die Differentialgleichung $a y'' = sqrt(1 + y'^2)$. Ihre Lösung, mit dem Scheitel bei $x = 0$ und der $x$-Achse um $a$ unter dem Scheitel:

#satz[Kettenlinie][
  #gl($ y = a cosh(x / a), wide s = a sinh(x / a), wide y^2 - s^2 = a^2. $)
  Für die Seilkraft gilt
  #gl($ H = p a, wide V = p s, wide S = sqrt(H^2 + V^2) = p y. $)
]

Die letzte Formel ist bemerkenswert einfach: Die Seilkraft in einem Punkt ist das Gewicht eines Seilstücks, dessen Länge gleich der Höhe $y$ des Punkts über der $x$-Achse ist. Am kleinsten ist sie im Scheitel ($S = H$), am größten in den Aufhängepunkten.

#intu[
  Der Parameter $a = H\/p$ sagt, wie «straff» das Seil ist. Ist $a$ groß (starker Horizontalzug, leichtes Seil), ist die Kurve flach; bei kleinem $a$ hängt das Seil tief durch. Ein Seil völlig gerade zu spannen ist unmöglich: Dafür müsste $H$ unendlich werden, denn irgendetwas Vertikales muss das Gewicht tragen, und das geht nur mit einer Neigung.
]

=== Flach gespanntes Seil: Parabel

Ist das Seil straff ($|x| << a$), entwickelt man $cosh$ und $sinh$ in eine Reihe:
#gl($ y - a approx x^2 / (2a), wide s approx x + x^3 / (6 a^2). $)
Die Kettenlinie wird zur *Parabel*. Für ein flaches Seil mit Spannweite $l$ zwischen gleich hohen Aufhängepunkten ist der Durchhang damit $f approx l^2 \/ (8a) = p l^2 \/ (8H)$. Verdoppelt man den Horizontalzug, halbiert sich der Durchhang.

#bsp[Hochspannungsleitung][
  Ein Leiterseil mit $p = 20$ N/m hängt zwischen zwei Masten im Abstand $l = 300$ m mit einem Horizontalzug von $H = 20$ kN. Durchhang: $f approx p l^2\/(8H) = 20 dot 300^2\/(8 dot 20000) approx 11.3$ m. Die größte Seilkraft liegt an den Masten: $S = p y = H cosh(l\/(2a))$ mit $a = H\/p = 1000$ m, also $S approx H(1 + (l\/2a)^2\/2) = 20000 dot (1 + 0.0113) approx 20.2$ kN.
]

== Seilreibung

Ein Seil sei über einen ruhenden rauen Zylinder (Poller, Trommel) gelegt und umschlinge ihn über den Winkel $alpha$. Am einen Ende wirkt $S_1$, am anderen $S_2 > S_1$. Wie groß darf $S_2$ werden, bevor das Seil rutscht?

#fg("k13_seilreibung", [Links: Seil auf der Trommel. Rechts: Kräfte an einem Seilelement mit dem Öffnungswinkel $dif phi$. Die Seilkräfte drücken das Element mit $dif N = S dif phi$ auf die Trommel; die Reibung $mu dif N$ trägt den Unterschied $dif S$.])

Gleichgewicht am Element (kleine Winkel): radial $dif N = S dif phi$, tangential $dif S = dif F_R$. An der Haftgrenze ist $dif F_R = mu_0 dif N$, also
#gl($ dif S = mu_0 S dif phi quad => quad (dif S) / S = mu_0 dif phi. $)
Der Zuwachs ist proportional zum schon vorhandenen Wert: Das ist die Gleichung des exponentiellen Wachstums.

#satz[Seilreibungsformel (Euler--Eytelwein)][
  Das Seil haftet auf dem Zylinder, solange
  #gl($ S_2 <= S_1 e^(mu_0 alpha) $)
  ist ($alpha$ im Bogenmaß, $S_2$ die größere Kraft). Gleitet das Seil auf der Trommel, gilt $S_2 = S_1 e^(mu_1 alpha)$.
]

#intu[
  Jedes Stück Umschlingung vervielfacht die Haltekraft um denselben Faktor, wie Zinseszins. Bei $mu_0 = 0.3$ ergibt eine halbe Umschlingung den Faktor $e^(0.3 pi) approx 2.6$, eine ganze $6.6$, zwei ganze $43$, drei ganze $286$. Deshalb kann ein Matrose ein Schiff halten, indem er das Tau ein paar Mal um den Poller legt. Der Radius des Pollers spielt keine Rolle, nur der Winkel.
]

#bsp[Bandbremse][
  Ein Band umschlingt eine drehende Trommel (Radius $r = 0.2$ m) über $alpha = 3 pi\/2$ ($270°$), $mu_1 = 0.4$. Auf der schlaffen Seite wirkt $S_1 = 100$ N. Dann ist $S_2 = S_1 e^(mu_1 alpha) = 100 e^(0.4 dot 4.71) approx 100 dot 6.6 = 660$ N, und das Bremsmoment auf die Trommel ist $M = r (S_2 - S_1) = 0.2 dot 560 = 112$ N m. Mit einem Hebel, der nur die kleine Kraft $S_1$ aufbringen muss, erzeugt man ein großes Bremsmoment.
]

#kurz[
  - Seil: nur Zug, tangential. Reibungsfreie Rolle: gleiche Seilkraft auf beiden Seiten.
  - Schweres Seil: $H = "konst."$, $V = p s$, $a = H\/p$.
  - Kettenlinie: $y = a cosh(x\/a)$, $s = a sinh(x\/a)$, $S = p y$.
  - Flach: Parabel, Durchhang $f approx p l^2 \/ (8H)$.
  - Seilreibung: $S_2 <= S_1 e^(mu_0 alpha)$.
]
