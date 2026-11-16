#import "lib.typ": *

= Beanspruchung

Bis jetzt haben wir gefragt, welche Kräfte _von außen_ auf einen Träger wirken. Für die Frage «Hält er?» muss man wissen, was _im Inneren_ los ist: Welche Kräfte muss das Material an jeder Stelle übertragen? Das ist die *Beanspruchung*. Sie ist die Brücke von der Statik zur Festigkeitslehre.

Wir betrachten *Stabträger*: schlanke Körper, deren Länge viel größer ist als ihre Querabmessungen. Die *Achse* verbindet die Flächenmittelpunkte der Querschnitte. Ist sie gerade, spricht man von einem *Balken*, sonst von einem gekrümmten Stabträger.

== Definition und Zerlegung

Der Träger ruhe unter äußeren Kräften, die im Gleichgewicht sind. Wir trennen ihn in Gedanken an einer Stelle durch einen ebenen Schnitt senkrecht zur Achse. Jedes der beiden Teile muss für sich in Ruhe bleiben. Das geht nur, wenn über die Schnittfläche Kräfte übertragen werden: die *Schnittkräfte*. Vor dem Schnitt waren sie innere Kräfte, durch den Schnitt werden sie zu äußeren Kräften der Teile.

#defn[Beanspruchung][
  Die Dyname ${vR, vM_C}$ der über einen Querschnitt verteilten Schnittkräfte, reduziert auf den Flächenmittelpunkt $C$ des Querschnitts, heißt *Beanspruchung* des Stabträgers in diesem Querschnitt. Nach dem Reaktionsprinzip ist die Beanspruchung am gegenüberliegenden Schnittufer genau entgegengesetzt: ${-vR, -vM_C}$.
]

Mit $ve_x$ in Achsrichtung (äußere Normale des betrachteten Schnittufers) und $ve_y, ve_z$ im Querschnitt zerlegt man:
#gl($ vR = N ve_x + Q_y ve_y + Q_z ve_z, wide vM_C = T ve_x + M_y ve_y + M_z ve_z. $)

#table(columns: (auto, auto, 1fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [*Größe*], [*Name*], [*Wirkung auf den Träger*],
  table.hline(stroke: 0.4pt),
  [$N$], [Normalkraft], [zieht ($N > 0$, Zug) oder staucht ($N < 0$, Druck) längs der Achse],
  [$Q_y, Q_z$], [Querkräfte], [wollen die beiden Teile quer gegeneinander abscheren],
  [$T$], [Torsionsmoment], [verdreht den Träger um seine Achse],
  [$M_y, M_z$], [Biegemomente], [verbiegen den Träger],
  table.hline(stroke: 0.7pt),
)

#fg("k14_schnitt", [Schnittgrößen am ebenen Balken. Am _positiven Schnittufer_ (äußere Normale in $+x$-Richtung, hier das rechte Ende des linken Teils) zeigen positive $N$, $Q_y$, $M_z$ in die positiven Koordinatenrichtungen, am negativen Schnittufer in die negativen.])

#intu[
  Stell dir vor, du sägst den Balken durch und musst die beiden Hälften mit den Händen so zusammenhalten, dass nichts merkt, dass gesägt wurde. Du musst ziehen oder drücken ($N$), ein Abrutschen verhindern ($Q$), und du musst die Schnittflächen gegen Aufklappen festhalten ($M$). Was deine Hände dabei leisten müssen, ist die Beanspruchung: genau das, was vorher das Material leisten musste.
]

#merke[
  Vorzeichenkonventionen für Schnittgrößen sind in Büchern und Vorlesungen *nicht einheitlich*. Dieses Skript verwendet die Konvention der Abbildung (positive Größen am positiven Schnittufer in positive Achsrichtung). Mit $y$ nach oben bedeutet $M_z > 0$: Der Balken hängt durch (Zug an der Unterseite). Verwende in der Prüfung die Konvention deiner Vorlesung und gib sie mit einer kleinen Skizze an.
]

== Ermittlung der Beanspruchung: die Schnittmethode

#rezept[Schnittmethode][
  + Lagerkräfte am ganzen Träger bestimmen (bei einem Kragarm kann man sie umgehen, indem man das freie Ende betrachtet).
  + Den Träger in *Bereiche* einteilen. Bereichsgrenzen sind alle Stellen, an denen sich die Belastung sprunghaft ändert: Einzelkräfte, Einzelmomente, Lager, Anfang und Ende von Streckenlasten, Knicke.
  + In jedem Bereich an einer allgemeinen Stelle $x$ schneiden und *einen* der beiden Teile freischneiden (den mit weniger Kräften).
  + Schnittgrößen in positiver Richtung eintragen, Gleichgewicht am Teil: liefert $N(x)$, $Q(x)$, $M(x)$. Momentenbedingung um den Schnittpunkt $C$.
  + Die Verläufe als Diagramme aufzeichnen und kontrollieren (siehe 14.3).
]

Gleichwertig und oft schneller: Die Beanspruchung am positiven Schnittufer bei $x$ ist die Dyname _aller äußeren Kräfte am abgeschnittenen Teil jenseits des Schnitts_ ($> x$), reduziert auf $C$.

#fg("k14_diagramme", [Die beiden wichtigsten Grundfälle mit Querkraft- und Momentenverlauf (Lasten nach unten). Das Biegemoment ist dort extremal, wo die Querkraft null ist oder springt.])

#bsp[Balken auf zwei Stützen unter Gleichlast][
  Länge $L$, Gleichlast $q_0$ nach unten, also $q_y = -q_0$. Lagerkräfte: $A_y = B_y = q_0 L\/2$. Schnitt bei $x$, wir betrachten den rechten Teil (Länge $L - x$): Auf ihn wirken $B_y$ am Ende und die Teillast $q_0 (L - x)$ in seiner Mitte.
  $ Q_y (x) = (q_0 L)/2 - q_0 (L - x) = q_0 (x - L/2), $
  $ M_z (x) = (L - x) (q_0 L)/2 - ((L - x)/2) q_0 (L - x) = (q_0)/2 x (L - x). $
  Die Querkraft ist linear und wechselt in der Mitte das Vorzeichen. Das Biegemoment ist eine Parabel, an den Lagern null (ein Gelenk überträgt kein Moment) und in der Mitte maximal: $M_"max" = q_0 L^2 \/ 8$.
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
  Das Moment ist an der Einspannung am größten: Dort bricht ein überlasteter Kragarm. Die Lagerkräfte musste man dafür gar nicht ausrechnen. Umgekehrt liest man sie aus den Schnittgrößen bei $x = 0$ ab.
]

== Differentialbeziehungen am geraden Balken

Zwischen Belastung, Querkraft und Biegemoment bestehen feste Zusammenhänge. Man erhält sie aus dem Gleichgewicht an einem Balkenelement der Länge $dif x$ unter der Streckenlast $q_y (x)$.

#fg("k14_element", [Balkenelement der Länge $dif x$. An den Schnittufern greifen die Schnittgrößen an, in der Mitte die Streckenlast. Das Element ist in Ruhe.])

Kräftegleichgewicht in $y$-Richtung: $Q_y (x + dif x) - Q_y (x) + q_y dif x = 0$, also $dif Q_y = -q_y dif x$. Momentengleichgewicht um die rechte Schnittstelle (bis auf Größen höherer Ordnung in $dif x$): $M_z (x + dif x) - M_z (x) + Q_y dif x = 0$, also $dif M_z = -Q_y dif x$.

#satz[Differentialbeziehungen][
  #gl($ Q_y' = -q_y, wide M_z' = -Q_y, wide "also" quad M_z'' = q_y. $)
  Für die andere Biegeebene gilt entsprechend $Q_z' = -q_z$ und $M_y' = Q_z$.
]

#intu[
  Die Querkraft «sammelt» die Last auf: Gehst du am Balken entlang, ändert sie sich um genau die Last, an der du vorbeikommst. Das Moment sammelt wiederum die Querkraft auf. Es ist zweimal dasselbe Spiel, wie bei Beschleunigung, Geschwindigkeit und Weg. Deshalb ist der Momentenverlauf immer um einen Grad «glatter» als der Querkraftverlauf, und dieser um einen Grad glatter als die Last.
]

An Stellen mit Einzellasten gelten *Sprungbedingungen*: Greift bei $x = a$ eine Einzelkraft mit der Komponente $F_y$ an und bei $x = b$ ein Einzelmoment $M$ (in $+z$-Richtung), so ist
#gl($ Q_y (a^+) - Q_y (a^-) = -F_y, wide M_z (b^+) - M_z (b^-) = -M. $)

Daraus ergeben sich Regeln, mit denen man jedes Diagramm skizzieren und jede Rechnung kontrollieren kann:

#table(columns: (1.2fr, 1fr, 1fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [*Belastung im Bereich*], [*Querkraft $Q$*], [*Biegemoment $M$*],
  table.hline(stroke: 0.4pt),
  [keine Last ($q = 0$)], [konstant], [linear],
  [Gleichlast ($q = "konst."$)], [linear], [Parabel],
  [Dreieckslast], [Parabel], [kubisch],
  [Einzelkraft], [Sprung um die Kraft], [Knick],
  [Einzelmoment], [unverändert], [Sprung um das Moment],
  table.hline(stroke: 0.7pt),
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
  Randbedingungen $M_z (0) = 0$ und $M_z (L) = 0$ geben $C_2 = 0$ und $C_1 = 0$. Das größte Moment liegt in der Mitte: $q_0 L^2 \/ pi^2$. Die Lagerkräfte liest man aus der Querkraft an den Enden ab: je $q_0 L \/ pi$.
]

== Gekrümmte Stabträger

Für einen ebenen, kreisförmig gekrümmten Träger (Radius $R$, Lagewinkel $phi$) verwendet man die zylindrische Basis: $N$ tangential, $Q_r$ radial, $Q_z$ und die Momente $T$ (um die Tangente), $M_r$, $M_z$. Am Element der Länge $R dif phi$ ergeben die Gleichgewichtsbedingungen (Strich = Ableitung nach $phi$; $q_phi, q_r, q_z$ Streckenlasten):

#gl($ N' + Q_r + R q_phi = 0, wide Q_r' - N + R q_r = 0, wide M_z' - R Q_r = 0 $)
für Belastung in der Trägerebene, und
#gl($ Q_z' + R q_z = 0, wide T' + M_r = 0, wide M_r' - T + R Q_z = 0 $)
für Belastung senkrecht dazu.

#merke[
  Neu gegenüber dem geraden Balken ist die *Kopplung durch die Krümmung*: Weil die Tangente ihre Richtung ändert, speist die Normalkraft die Querkraft und umgekehrt, ebenso Torsion und Biegung. Ein Bogen kann deshalb Querlasten zu einem guten Teil über Normalkraft (Druck) abtragen: das Prinzip der Bogenbrücke.
]

#fg("k14_bogen", [Halbkreisträger, bei $phi = pi$ eingespannt, am freien Ende $phi = 0$ durch $vF$ belastet. Schnitt beim Winkel $phi$.])

#bsp[Halbkreisträger][
  Schneidet man beim Winkel $phi$ und betrachtet das freie Stück, so muss die Schnittstelle die Kraft $F$ aufnehmen. In tangentiale und radiale Richtung zerlegt ergibt sich $N = F cos phi$ und $Q_r = F sin phi$. Der Hebelarm von $F$ bezüglich der Schnittstelle ist $R (1 - cos phi)$, also $M_z = R F (1 - cos phi)$. Kontrolle mit den Differentialbeziehungen ($q = 0$): $N' + Q_r = -F sin phi + F sin phi = 0$ ✓, $M_z' - R Q_r = R F sin phi - R F sin phi = 0$ ✓. An der Einspannung ($phi = pi$) ist das Moment am größten, $2 R F$.
]

#fehler[
  - Zu wenige Bereiche: An jeder Einzelkraft, jedem Lager und jedem Lastwechsel beginnt ein neuer Bereich.
  - Am Teil, das man betrachtet, Kräfte vergessen (besonders Lagerkräfte und Einspannmomente).
  - Für die Schnittgrößen die Streckenlast durch ihre Ersatzkraft am _ganzen Träger_ ersetzen. Man darf nur den Teil der Last ersetzen, der am freigeschnittenen Stück wirkt.
  - Vorzeichen: positives und negatives Schnittufer verwechseln.
]

#kurz[
  - Beanspruchung = Dyname der Schnittkräfte im Flächenmittelpunkt: $N$, $Q_y$, $Q_z$, $T$, $M_y$, $M_z$.
  - Schnittmethode: Bereiche bilden, schneiden, Gleichgewicht am Teil.
  - $Q_y' = -q_y$, $M_z' = -Q_y$; Sprünge bei Einzelkräften und -momenten.
  - $M$ extremal bei $Q = 0$; $M = 0$ an Gelenken und freien Enden.
  - Gleichlast auf zwei Stützen: $M_"max" = q_0 L^2 \/ 8$. Einzellast: $M_"max" = F a b \/ L$. Kragarm mit Endlast: $M_"max" = F L$.
]
