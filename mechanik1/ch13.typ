#import "lib.typ": *

= Seilstatik

#ohnewoche[Seilmodell und Kettenlinie stehen nicht im Wochenplan der Vorlesung (Buch S. 185–188); die Seilreibung gehört zu Woche 12.]

Ein Seil (oder eine Kette) ist das Gegenteil eines starren Körpers: Es ist vollkommen biegsam. Im Modell ist es zusätzlich undehnbar. Aus der Biegsamkeit folgt die eine Eigenschaft, auf der alles aufbaut:

#merke[
  Ein Seil kann nur *Zug* übertragen, und die *Seilkraft* $vS$ ist in jedem Punkt *tangential* zum Seil. Ein Seil kann weder drücken noch quer zu sich eine Kraft oder ein Moment aufnehmen.
]

Das Seil wirkt als Verbindungselement vor allem durch seinen Dehnungswiderstand. Es ist sehr biegsam, weil seine Querabmessungen viel kleiner sind als seine Länge. Im Modell des _inextensiblen_ Seils idealisieren wir es deshalb als vollkommen biegsamen, eindimensionalen Körper unveränderlicher Länge: Biegewiderstand null, Dehnungswiderstand «unendlich». Weil es keine Druckkraft aufnehmen kann, ist die Seilkraft immer eine Zugkraft; ihren Betrag nennt man den *Seilzug*.

Daraus folgt sofort:
- Ein *gewichtsloses Seil* zwischen zwei Punkten, an dem dazwischen keine Kraft angreift, ist *gerade*, und die Seilkraft ist überall gleich. Greifen Einzellasten an, bildet es ein *Seilpolygon*: An jedem Knickpunkt herrscht Gleichgewicht zwischen der Last und den beiden Seilkräften.
- Läuft ein gewichtsloses Seil über eine *reibungsfrei gelagerte Rolle*, so ist der Betrag der Seilkraft auf beiden Seiten *gleich* (Momentenbedingung um die Rollenachse). Die Rolle lenkt die Kraft nur um.

Wie bildet sich das *Seilpolygon*? Ein gewichtsloses Seil werde in $A$ durch die Kraft ${A | vS_0}$ gehalten. Das Seilstück $A B$ nimmt die Richtung dieser Kraft an, der Seilzug in $A B$ ist ihr Betrag. Greift in $B$ eine Last ${B | vF_1}$ an, muss am Knoten $B$ Gleichgewicht herrschen: Das Seilstück $B C$ stellt sich parallel zum negativen Summenvektor $vS_1 = -(vS_0 + vF_1)$ ein, und dessen Betrag ist der Seilzug in $B C$. Eine weitere Last ${C | vF_2}$ richtet das Stück $C D$ parallel zu $-(vS_0 + vF_1 + vF_2)$. Jede Last «knickt» das Seil also in die Richtung, die das Knotengleichgewicht verlangt.

Den Beweis für die Rolle erhält man durch die Momentenbedingung um die Rollenachse: Betrachtet man Rolle und angrenzende Seilstücke als System, ist die Lagerkraft in der reibungsfreien Achse ohne Moment. Die Seilzüge links und rechts haben denselben Hebelarm (den Rollenradius), also müssen sie gleich groß sein, egal in welche Richtung das Seil läuft.

Lässt man die Zahl der Lasten über alle Grenzen wachsen, ihre Beträge und die Abstände gegen null gehen, wird aus dem Vieleck eine Kurve, die nur noch dort Ecken hat, wo Einzelkräfte angreifen. Diesen Grenzfall (das kontinuierlich belastete Seil) behandeln wir jetzt für das Eigengewicht.

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

*Folgerung aus $S = p y$.* Ein Seil, das in $B$ befestigt und in $C$ über eine kleine, reibungsfrei drehbare Rolle gelegt wird, hängt mit seinem freien Ende genau bis zur Leitlinie, der $x$-Achse. Denn am Ende ist $S = p y$ das Gewicht des freien Stücks, das von der Rolle bis zum Ende herunterhängt, und das ist gerade die Länge $y$ der Rolle über der Leitlinie.

*Aufhängen zwischen zwei Punkten.* Mit der Gleichung $y = a cosh(x\/a)$ ist die Gleichgewichtsform eines Seils gegebener Länge zwischen zwei Punkten $B, C$ noch nicht ganz gefunden, denn der Parameter $a$ und die Lage der Achsen sind unbekannt. Man schreibt $y = a cosh(x\/a)$ und $s = a sinh(x\/a)$ für beide Punkte an und nutzt, dass man die _Differenzen_ $x_C - x_B$, $y_C - y_B$ und $s_C - s_B$ (die Länge des Seils) kennt. Das ergibt Gleichungen für $a$ und die Lage der Achsen (nur numerisch lösbar).

=== Flach gespanntes Seil: Parabel

Ist das Seil straff ($|x| << a$), entwickelt man $cosh$ und $sinh$ in eine Reihe:
#gl($ y - a approx x^2 / (2a), wide s approx x + x^3 / (6 a^2). $)
Die Kettenlinie wird zur *Parabel*. Für ein flaches Seil mit Spannweite $l$ zwischen gleich hohen Aufhängepunkten ist der Durchhang damit $f approx l^2 \/ (8a) = p l^2 \/ (8H)$. Verdoppelt man den Horizontalzug, halbiert sich der Durchhang.

#bsp[Hochspannungsleitung][
  Ein Leiterseil mit $p = 20$ N/m hängt zwischen zwei Masten im Abstand $l = 300$ m mit einem Horizontalzug von $H = 20$ kN. Durchhang: $f approx p l^2\/(8H) = 20 dot 300^2\/(8 dot 20000) approx 11.3$ m. Die größte Seilkraft liegt an den Masten: $S = p y = H cosh(l\/(2a))$ mit $a = H\/p = 1000$ m, also $S approx H(1 + (l\/2a)^2\/2) = 20000 dot (1 + 0.0113) approx 20.2$ kN.
]

#woche(12, [Reibung, Statik (Fortsetzung)], [188–190])
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

Ein Hinweis zur Annahme: Das Modell vernachlässigt die Biegesteifigkeit des Seils und sein Gewicht gegenüber den übrigen Kräften. Gleitet das Seil nicht auf der Trommel, ist der Zug auf der auflaufenden Seite größer als auf der ablaufenden ($S_2 > S_1$, weil $mu_1, alpha > 0$), und das Verhältnis $S_2\/S_1$ wächst mit dem Umschlingungswinkel exponentiell. Die Formel legt nur das _Verhältnis_ der beiden Kräfte fest; über eine davon kann man frei verfügen. Wird die Trommel gedreht und soll das Seil mitgenommen werden, so tritt die Mitnahme ein, solange $S_2 < S_1 e^(mu alpha)$ gilt.

#intu[
  Jedes Stück Umschlingung vervielfacht die Haltekraft um denselben Faktor, wie Zinseszins. Bei $mu_0 = 0.3$ ergibt eine halbe Umschlingung den Faktor $e^(0.3 pi) approx 2.6$, eine ganze $6.6$, zwei ganze $43$, drei ganze $286$. Deshalb kann ein Matrose ein Schiff halten, indem er das Tau ein paar Mal um den Poller legt. Der Radius des Pollers spielt keine Rolle, nur der Winkel.
]

#bsp[Schiff am Poller][
  Schiffe werden an Land festgehalten, indem man das Tau mehrmals um einen kurzen Poller schlingt. Weil der Umschlingungswinkel sehr groß ist, genügt eine kleine Kraft $S_1$, die schon die Haftreibung des Seilendes am Boden (oder die Hand des Matrosen) liefert, um eine große Kraft $S_2$ am anderen Ende auszuhalten. Schon bei einer fünffachen Umschlingung ($alpha = 10 pi$) und $mu = 0.4$ ist $S_2\/S_1 = e^(0.4 dot 10 pi) = e^(4 pi) approx 2.9 dot 10^5$. Eine Hand mit 100 N hält damit rechnerisch 29 Millionen Newton, die Reibung gibt also praktisch beliebig viel Haltekraft her.
]

#bsp[Bandbremse][
  Ein Band umschlingt eine drehende Trommel (Radius $r = 0.2$ m) über $alpha = 3 pi\/2$ ($270°$), $mu_1 = 0.4$. Auf der schlaffen Seite wirkt $S_1 = 100$ N. Dann ist $S_2 = S_1 e^(mu_1 alpha) = 100 e^(0.4 dot 4.71) approx 100 dot 6.6 = 660$ N, und das Bremsmoment auf die Trommel ist $M = r (S_2 - S_1) = 0.2 dot 560 = 112$ N m. Mit einem Hebel, der nur die kleine Kraft $S_1$ aufbringen muss, erzeugt man ein großes Bremsmoment. Man zerlegt das System in die Trommel samt Last und den Bremshebel und löst mit den Momentenbedingungen beider Körper. Der Hebel spannt dabei den _ablaufenden_ Seilteil, weil dort der Zug kleiner ist und man mit einer geringeren Bremskraft auskommt.
]

#kurz[
  - Seil: nur Zug, tangential. Reibungsfreie Rolle: gleiche Seilkraft auf beiden Seiten.
  - Schweres Seil: $H = "konst."$, $V = p s$, $a = H\/p$.
  - Kettenlinie: $y = a cosh(x\/a)$, $s = a sinh(x\/a)$, $S = p y$.
  - Flach: Parabel, Durchhang $f approx p l^2 \/ (8H)$.
  - Seilreibung: $S_2 <= S_1 e^(mu_0 alpha)$.
]
