#import "lib.typ": *

= Beanspruchung

Bis jetzt haben wir gefragt, welche Kräfte _von außen_ auf einen Träger wirken. Für die Frage «Hält er?» muss man wissen, was _im Inneren_ los ist: Welche Kräfte muss das Material an jeder Stelle übertragen? Das ist die *Beanspruchung*. Sie ist die Brücke von der Statik zur Festigkeitslehre.

Wir betrachten *Stabträger*: schlanke Körper, deren Länge viel größer ist als ihre Querabmessungen. Die *Achse* verbindet die Flächenmittelpunkte der Querschnitte. Ist sie gerade, spricht man von einem *Balken*, sonst von einem gekrümmten Stabträger.

== Definition und Zerlegung

Der Träger ruhe unter äußeren Kräften, die im Gleichgewicht sind. Wir trennen ihn in Gedanken an einer Stelle durch einen ebenen Schnitt senkrecht zur Achse. Jedes der beiden Teile muss für sich in Ruhe bleiben. Das geht nur, wenn über die Schnittfläche Kräfte übertragen werden -- die *Schnittkräfte*. Vor dem Schnitt waren sie innere Kräfte; durch den Schnitt werden sie zu äußeren Kräften der Teile.

#defn[Beanspruchung][
  Die Dyname ${vR, vM_C}$ der über einen Querschnitt verteilten Schnittkräfte, reduziert auf den Flächenmittelpunkt $C$ des Querschnitts, heißt *Beanspruchung* des Stabträgers in diesem Querschnitt. Nach dem Reaktionsprinzip ist die Beanspruchung am gegenüberliegenden Schnittufer genau entgegengesetzt: ${-vR, -vM_C}$.
]

Mit $ve_x$ in Achsrichtung (äußere Normale des betrachteten Schnittufers) und $ve_y, ve_z$ im Querschnitt zerlegt man:
#gl($ vR = N ve_x + Q_y ve_y + Q_z ve_z, wide vM_C = T ve_x + M_y ve_y + M_z ve_z. $)

#table(columns: (auto, auto, 1fr), stroke: none, inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 0.6pt),
  [*Größe*], [*Name*], [*Wirkung auf den Träger*],
  table.hline(stroke: 0.3pt),
  [$N$], [Normalkraft], [zieht ($N > 0$, Zug) oder staucht ($N < 0$, Druck) längs der Achse],
  [$Q_y, Q_z$], [Querkräfte], [wollen die beiden Teile quer gegeneinander abscheren],
  [$T$], [Torsionsmoment], [verdreht den Träger um seine Achse],
  [$M_y, M_z$], [Biegemomente], [verbiegen den Träger],
  table.hline(stroke: 0.6pt),
)

#fig(13.4, 3.6, caption: [Schnittgrößen am ebenen Balken. Am *positiven Schnittufer* (äußere Normale in $+x$-Richtung, hier das rechte Ende des linken Teils) zeigen positive $N$, $Q_y$, $M_z$ in die positiven Koordinatenrichtungen, am negativen Schnittufer in die negativen.],
  axes((0.4,0.4), 0.9, 0.9),
  rct((1.8,1.6),(5.6,2.2)), rct((7.6,1.6),(11.4,2.2)),
  dl((6.6,0.6),(6.6,3.3), c: cv), lbl((6.6,3.5), [Schnitt bei $x$], c: cv, size: 8pt),
  arr((5.6,1.9),(6.4,1.9), c: cf, w: 1.3pt), arr((5.6,1.9),(5.6,2.9), c: cf, w: 1.3pt), arc((5.6,1.9), 0.5, -70, 70, col: cm, head: true, hs: 0.13),
  lbl((6.25,1.6), $N$, c: cf, size: 8pt), lbl((5.25,2.85), $Q_y$, c: cf, size: 8pt), lbl((6.15,2.6), $M_z$, c: cm, size: 8pt),
  arr((7.6,1.9),(6.8,1.9), c: cf, w: 1.3pt), arr((7.6,1.9),(7.6,0.9), c: cf, w: 1.3pt), arc((7.6,1.9), 0.5, 110, 250, col: cm, head: true, hs: 0.13),
  lbl((6.95,2.2), $N$, c: cf, size: 8pt), lbl((7.95,0.95), $Q_y$, c: cf, size: 8pt), lbl((7.05,1.2), $M_z$, c: cm, size: 8pt),
  lbl((3.7,1.2), [linker Teil], size: 8pt, c: cg), lbl((9.5,1.2), [rechter Teil], size: 8pt, c: cg),
  lbl((3.7,2.6), [positives Schnittufer $->$], size: 8pt), lbl((9.5,2.6), [$<-$ negatives Schnittufer], size: 8pt),
)

#intu[
  Stell dir vor, du sägst den Balken durch und musst die beiden Hälften mit den Händen so zusammenhalten, dass nichts merkt, dass gesägt wurde. Du musst ziehen oder drücken ($N$), ein Abrutschen verhindern ($Q$), und du musst die Schnittflächen gegen Aufklappen festhalten ($M$). Was deine Hände dabei leisten müssen, ist die Beanspruchung -- genau das, was vorher das Material leisten musste.
]

#merke[
  Vorzeichenkonventionen für Schnittgrößen sind in Büchern und Vorlesungen *nicht einheitlich*. Dieses Skript verwendet die Konvention der Abbildung oben (positive Größen am positiven Schnittufer in positive Achsrichtung). Mit $y$ nach oben bedeutet $M_z > 0$: Der Balken hängt durch, Zug an der Unterseite. Verwende in der Prüfung die Konvention deiner Vorlesung -- und gib sie mit einer kleinen Skizze an.
]

== Ermittlung der Beanspruchung: die Schnittmethode

#rezept[Schnittmethode][
  + Lagerkräfte am ganzen Träger bestimmen (bei einem Kragarm kann man sie umgehen, indem man das freie Ende betrachtet).
  + Träger in *Bereiche* einteilen. Bereichsgrenzen sind alle Stellen, an denen sich die Belastung sprunghaft ändert: Einzelkräfte, Einzelmomente, Lager, Anfang und Ende von Streckenlasten, Knicke.
  + In jedem Bereich an einer allgemeinen Stelle $x$ schneiden und *einen* der beiden Teile freischneiden (den mit weniger Kräften).
  + Schnittgrößen in positiver Richtung eintragen, Gleichgewicht am Teil: liefert $N(x)$, $Q(x)$, $M(x)$. Momentenbedingung um den Schnittpunkt $C$.
  + Verläufe als Diagramme aufzeichnen und kontrollieren (siehe 14.3).
]

Gleichwertig und oft schneller: Die Beanspruchung am positiven Schnittufer bei $x$ ist die Dyname _aller äußeren Kräfte am abgeschnittenen Teil jenseits des Schnitts_ ($> x$), reduziert auf $C$.

#fig(13.4, 6.6, caption: [Die beiden wichtigsten Grundfälle mit Querkraft- und Momentenverlauf ($y$ nach oben, Lasten nach unten). Das Biegemoment ist dort extremal, wo die Querkraft null ist oder springt.],
  // Gleichlast
  beam((0.8,5.4),(5.8,5.4)), festlager((0.8,5.4), s: 0.25), loslager((5.8,5.4), s: 0.25), dload((0.8,5.5),(5.8,5.5), hh: 0.5, n: 8),
  lbl((3.3,6.35), $q_0$, c: cf, size: 8pt), bem((0.8,4.75),(5.8,4.75), $L$, off: -0.1),
  li((0.8,3.3),(5.8,3.3), s: 0.4pt + cg), poly(((0.8,3.3),(0.8,2.6),(3.3,3.3)), fill: rgb("#1b5fa622"), s: none), poly(((3.3,3.3),(5.8,4.0),(5.8,3.3)), fill: rgb("#1b5fa622"), s: none),
  li((0.8,2.6),(5.8,4.0), s: 1.1pt + cv), lbl((0.3,3.3), $Q_y$, size: 8pt), lbl((1.5,2.45), $-q_0 L\/2$, size: 7.5pt, c: cv), lbl((5.2,4.2), $q_0 L\/2$, size: 7.5pt, c: cv),
  li((0.8,0.7),(5.8,0.7), s: 0.4pt + cg), pl(range(31).map(i => (0.8 + 5 * i / 30, 0.7 + 1.1 * 4 * (i / 30) * (1 - i / 30))), s: none, fill: rgb("#1d7a4c22"), close: true),
  graph(t => 1.1 * 4 * t * (1 - t), 0, 1, o: (0.8,0.7), sx: 5, c: cm, w: 1.1pt), lbl((0.3,0.7), $M_z$, size: 8pt), lbl((3.3,2.05), $q_0 L^2 \/ 8$, size: 7.5pt, c: cm),
  dl((3.3,0.7),(3.3,5.4)),
  // Einzellast
  beam((7.6,5.4),(12.6,5.4)), festlager((7.6,5.4), s: 0.25), loslager((12.6,5.4), s: 0.25),
  arr((9.6,6.4),(9.6,5.5), c: cf, w: 1.3pt), lbl((9.9,6.25), $F$, c: cf, size: 8pt),
  bem((7.6,4.75),(9.6,4.75), $a$, off: -0.1), bem((9.6,4.75),(12.6,4.75), $b$, off: -0.1),
  li((7.6,3.3),(12.6,3.3), s: 0.4pt + cg), rct((7.6,3.3),(9.6,2.7), fill: rgb("#1b5fa622"), s: none), rct((9.6,3.3),(12.6,3.7), fill: rgb("#1b5fa622"), s: none),
  pl(((7.6,2.7),(9.6,2.7),(9.6,3.7),(12.6,3.7)), s: 1.1pt + cv), lbl((8.6,2.45), $-F b\/L$, size: 7.5pt, c: cv), lbl((11.1,3.95), $F a\/L$, size: 7.5pt, c: cv),
  li((7.6,0.7),(12.6,0.7), s: 0.4pt + cg), poly(((7.6,0.7),(9.6,1.8),(12.6,0.7)), fill: rgb("#1d7a4c22"), s: none),
  pl(((7.6,0.7),(9.6,1.8),(12.6,0.7)), s: 1.1pt + cm), lbl((9.6,2.05), $F a b\/L$, size: 7.5pt, c: cm),
  dl((9.6,0.7),(9.6,5.4)),
)

#bsp[Balken auf zwei Stützen unter Gleichlast][
  Länge $L$, Gleichlast $q_0$ nach unten, also $q_y = -q_0$. Lagerkräfte: $A_y = B_y = q_0 L\/2$. Schnitt bei $x$, betrachte den rechten Teil (Länge $L - x$): Auf ihn wirken $B_y$ am Ende und die Teillast $q_0 (L - x)$ in seiner Mitte.
  $ Q_y (x) = (q_0 L)/2 - q_0 (L - x) = q_0 (x - L/2), $
  $ M_z (x) = (L - x) (q_0 L)/2 - (L - x)/2 dot.c q_0 (L - x) = (q_0)/2 x (L - x). $
  Die Querkraft ist linear und wechselt in der Mitte das Vorzeichen; das Biegemoment ist eine Parabel, an den Lagern null (ein Gelenk überträgt kein Moment) und in der Mitte maximal: $M_"max" = q_0 L^2 \/ 8$.
]

#bsp[Dreipunktbiegung][
  Einzellast $F$ nach unten bei $x = a$, $b = L - a$. Lagerkräfte: $A_y = F b\/L$, $B_y = F a\/L$. Zwei Bereiche.

  $0 <= x < a$ (rechter Teil trägt $-F$ bei $a$ und $B_y$ bei $L$):
  $ Q_y = -F + (F a)/L = -(F b)/L, wide M_z = -F (a - x) + (F a)/L (L - x) = (F b)/L x. $
  $a < x <= L$ (rechter Teil trägt nur $B_y$):
  $ Q_y = (F a)/L, wide M_z = (F a)/L (L - x). $
  Bei $x = a$ springt die Querkraft um $F$, das Moment hat einen Knick und seinen Größtwert $M_"max" = F a b \/ L$.
]

#bsp[Kragarm mit Endlast][
  Balken bei $x = 0$ eingespannt, am freien Ende $x = L$ die Kraft $F$ in $+y$-Richtung. Der rechte Teil trägt nur $F$:
  $ Q_y (x) = F, wide M_z (x) = (L - x) F. $
  Das Moment ist an der Einspannung am größten -- dort bricht ein überlasteter Kragarm. Die Lagerkräfte musste man dafür gar nicht ausrechnen; umgekehrt liest man sie aus den Schnittgrößen bei $x = 0$ ab.
]

== Differentialbeziehungen am geraden Balken

Zwischen Belastung, Querkraft und Biegemoment bestehen feste Zusammenhänge. Man erhält sie aus dem Gleichgewicht an einem Balkenelement der Länge $dif x$ unter der Streckenlast $q_y (x)$:

#satz[Differentialbeziehungen][
  #gl($ Q'_y = -q_y, wide M'_z = -Q_y, wide "also" quad M''_z = q_y. $)
  Für die andere Biegeebene gilt entsprechend $Q'_z = -q_z$ und $M'_y = Q_z$.
]

#intu[
  Die Querkraft «sammelt» die Last auf: Gehst du am Balken entlang, ändert sie sich um genau die Last, an der du vorbeikommst. Das Moment sammelt wiederum die Querkraft auf. Es ist zweimal dasselbe Spiel -- wie Beschleunigung, Geschwindigkeit, Weg. Deshalb ist der Momentenverlauf immer um einen Grad «glatter» als der Querkraftverlauf, und dieser um einen Grad glatter als die Last.
]

An Stellen mit Einzellasten gelten *Sprungbedingungen*: Greift bei $x = a$ eine Einzelkraft mit der Komponente $F_y$ an, und bei $x = b$ ein Einzelmoment $M$ (in $+z$-Richtung), so ist
#gl($ Q_y (a^+) - Q_y (a^-) = -F_y, wide M_z (b^+) - M_z (b^-) = -M. $)

Daraus ergeben sich Regeln, mit denen man jedes Diagramm skizzieren und jede Rechnung kontrollieren kann:

#table(columns: (1.2fr, 1fr, 1fr), stroke: none, inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 0.6pt),
  [*Belastung im Bereich*], [*Querkraft $Q$*], [*Biegemoment $M$*],
  table.hline(stroke: 0.3pt),
  [keine Last ($q = 0$)], [konstant], [linear],
  [Gleichlast ($q = "konst."$)], [linear], [Parabel],
  [Dreieckslast], [Parabel], [kubisch],
  [Einzelkraft], [Sprung um die Kraft], [Knick],
  [Einzelmoment], [unverändert], [Sprung um das Moment],
  table.hline(stroke: 0.6pt),
)

#merke[
  - *Das Biegemoment ist extremal, wo die Querkraft null ist* (oder das Vorzeichen wechselt). Dort ist der Balken am stärksten auf Biegung beansprucht.
  - An einem *freien Ende* ohne Last und an einem *gelenkigen Endlager* ist $M = 0$. An einem freien Ende ohne Einzelkraft ist auch $Q = 0$.
  - An einem *Gelenk im Träger* ist $M = 0$.
  - Mit diesen Randbedingungen kann man $Q$ und $M$ auch durch *Integration* von $q$ gewinnen, ohne zu schneiden.
]

#bsp[Sinusförmige Last durch Integration][
  Balken auf zwei Stützen, $q_y (x) = -q_0 sin(pi x \/ L)$. Zweimal integrieren:
  $ Q_y = -(q_0 L)/pi cos((pi x)/L) + C_1, wide M_z = (q_0 L^2)/pi^2 sin((pi x)/L) - C_1 x + C_2. $
  Randbedingungen $M_z (0) = 0$ und $M_z (L) = 0$ geben $C_2 = 0$, $C_1 = 0$. Größtes Moment in der Mitte: $q_0 L^2 \/ pi^2$. Die Lagerkräfte liest man aus der Querkraft an den Enden ab: je $q_0 L \/ pi$.
]

== Gekrümmte Stabträger

Für einen ebenen, kreisförmig gekrümmten Träger (Radius $R$, Lagewinkel $phi$) verwendet man die zylindrische Basis: $N$ tangential, $Q_r$ radial, $Q_z$ und die Momente $T$ (um die Tangente), $M_r$, $M_z$. Am Element $R dif phi$ ergeben die Gleichgewichtsbedingungen (Strich = Ableitung nach $phi$; $q_phi, q_r, q_z$ Streckenlasten):

#gl($ N' + Q_r + R q_phi = 0, wide Q'_r - N + R q_r = 0, wide M'_z - R Q_r = 0 $)
für Belastung in der Trägerebene, und
#gl($ Q'_z + R q_z = 0, wide T' + M_r = 0, wide M'_r - T + R Q_z = 0 $)
für Belastung senkrecht dazu.

#merke[
  Neu gegenüber dem geraden Balken ist die *Kopplung durch die Krümmung*: Weil die Tangente ihre Richtung ändert, speist die Normalkraft die Querkraft und umgekehrt, ebenso Torsion und Biegung. Ein Bogen kann deshalb Querlasten zu einem guten Teil über Normalkraft (Druck) abtragen -- das Prinzip der Bogenbrücke.
]

#fig(11, 4.2, caption: [Halbkreisträger, bei $phi = pi$ eingespannt, am freien Ende $phi = 0$ durch $F$ belastet. Schnitt beim Winkel $phi$.],
  arc((4.0,0.8), 2.6, 0, 180, w: 2.2pt),
  hatch((0.8,0.8),(2.0,0.8)),
  arr((6.6,0.8),(6.6,-0.2), c: cf, w: 1.3pt), lbl((6.95,0.0), $vF$, c: cf),
  dl((4.0,0.8),(6.6,0.8)), dl((4.0,0.8),(5.3,3.05)), pt((4.0,0.8)), pt((5.3,3.05), c: cv),
  arc((4.0,0.8), 0.8, 0, 60, w: 0.5pt), lbl((4.95,1.25), $phi$, size: 8pt), lbl((4.45,2.1), $R$, size: 8pt, c: cg),
  lbl((9.2,3.0), $N = F cos phi$, size: 9pt), lbl((9.2,2.3), $Q_r = F sin phi$, size: 9pt), lbl((9.2,1.6), $M_z = R F (1 - cos phi)$, size: 9pt),
  pb: 0.3,
)

#bsp[Halbkreisträger][
  Schneidet man beim Winkel $phi$ und betrachtet das freie Stück, so muss die Schnittstelle die Kraft $F$ aufnehmen. Zerlegt in tangentiale und radiale Richtung ergibt sich $N = F cos phi$ und $Q_r = F sin phi$; der Hebelarm von $F$ bezüglich der Schnittstelle ist $R (1 - cos phi)$, also $M_z = R F (1 - cos phi)$. Kontrolle mit den Differentialbeziehungen ($q = 0$): $N' + Q_r = -F sin phi + F sin phi = 0$ ✓, $M'_z - R Q_r = R F sin phi - R F sin phi = 0$ ✓. An der Einspannung ($phi = pi$) ist das Moment am größten: $2 R F$.
]

#fehler[
  - Zu wenige Bereiche: An jeder Einzelkraft, jedem Lager und jedem Lastwechsel beginnt ein neuer Bereich.
  - Am Teil, das man betrachtet, Kräfte vergessen (besonders Lagerkräfte und Einspannmomente).
  - Für die Schnittgrößen eine Streckenlast durch ihre Ersatzkraft _am ganzen Träger_ ersetzen. Man darf nur den Teil der Last ersetzen, der am freigeschnittenen Stück wirkt.
  - Vorzeichen: positives und negatives Schnittufer verwechseln.
]

#kurz[
  - Beanspruchung = Dyname der Schnittkräfte im Flächenmittelpunkt: $N$, $Q_y$, $Q_z$, $T$, $M_y$, $M_z$.
  - Schnittmethode: Bereiche bilden, schneiden, Gleichgewicht am Teil.
  - $Q'_y = -q_y$, $M'_z = -Q_y$; Sprünge bei Einzelkräften und -momenten.
  - $M$ extremal bei $Q = 0$; $M = 0$ an Gelenken und freien Enden.
  - Gleichlast auf zwei Stützen: $M_"max" = q_0 L^2 \/ 8$. Einzellast: $M_"max" = F a b \/ L$.
]
