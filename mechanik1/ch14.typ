#import "lib.typ": *

= Beanspruchung

#woche(13, [Beanspruchung], [191–204])

Bis jetzt haben wir gefragt, welche Kräfte _von aussen_ auf einen Träger wirken. Für die Frage «Hält er?» muss man wissen, was _im Inneren_ los ist: Welche Kräfte muss das Material an jeder Stelle übertragen? Das ist die *Beanspruchung*. Sie ist die Brücke von der Statik zur Festigkeitslehre.

Tragstrukturen müssen unter den gegebenen Lasten halten. Übersteigen die übertragenen Kräfte örtlich oder in grösseren Bereichen die Festigkeitsgrenzen des Materials, drohen Risse oder grosse bleibende Verformungen, und die Struktur versagt. Um das schon beim Entwurf zu erkennen, muss man die in der Struktur übertragenen Kräfte (die per Definition _inneren_ Kräfte) Punkt für Punkt ausrechnen. Beispiele kennen wir schon: die Stabkräfte der Pendelstützen im Fachwerk (Kapitel 11) und den Seilzug (Kapitel 13), der von jedem Seilelement auf seine Nachbarn übertragen wird.

Die Pendelstütze ist der einfachste Fall einer grösseren Klasse: Bei ihr überträgt jeder Querschnitt nur eine Kraft, die Stabkraft. Bei anderen schlanken Trägern (Balken, Säulen, gekrümmten Stabträgern) lassen sich die von Querschnitt zu Querschnitt übertragenen Kräfte statisch äquivalent auf eine Einzelkraft und ein Kräftepaar reduzieren. Das ist die Beanspruchung, die wir gleich definieren.

Wir betrachten *Stabträger*: schlanke Körper, deren Länge viel grösser ist als ihre Querabmessungen. Die *Achse* verbindet die Flächenmittelpunkte der Querschnitte. Ist sie gerade, spricht man von einem *Balken*, sonst von einem gekrümmten Stabträger.

== Definition und Zerlegung

Besitzen die Lasten Komponenten senkrecht zur Achse, heisst der gerade Stabträger *Balken*. Quer belastete schlanke Prismen und Zylinder sind Sonderfälle; ein Zylinder, der um die eigene Achse rotieren kann, heisst oft *Welle*. Die Querschnitte dürfen sich entlang der Achse ändern. Wir konzentrieren uns auf gerade Träger; gekrümmte folgen am Schluss.

Der Träger ruhe unter äusseren Kräften, die im Gleichgewicht sind. Wir trennen ihn in Gedanken an einer Stelle durch einen ebenen Schnitt senkrecht zur Achse. Jedes der beiden Teile muss für sich in Ruhe bleiben. Das geht nur, wenn über die Schnittfläche Kräfte übertragen werden: die *Schnittkräfte*. Vor dem Schnitt waren sie innere Kräfte, durch den Schnitt werden sie zu äusseren Kräften der Teile.

#defn[Beanspruchung][
  Die Dyname ${vR, vM_C}$ der über einen Querschnitt verteilten Schnittkräfte, reduziert auf den Flächenmittelpunkt $C$ des Querschnitts, heisst *Beanspruchung* des Stabträgers in diesem Querschnitt. Nach dem Reaktionsprinzip ist die Beanspruchung am gegenüberliegenden Schnittufer genau entgegengesetzt: ${-vR, -vM_C}$.
]

Mit $ve_x$ in Achsrichtung (äussere Normale des betrachteten Schnittufers) und $ve_y, ve_z$ im Querschnitt zerlegt man:
#gl($ vR = N ve_x + Q_y ve_y + Q_z ve_z, wide vM_C = T ve_x + M_y ve_y + M_z ve_z. $)

#table(columns: (auto, auto, 1fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [*Grösse*], [*Name*], [*Wirkung auf den Träger*],
  table.hline(stroke: 0.4pt),
  [$N$], [Normalkraft], [zieht ($N > 0$, Zug) oder staucht ($N < 0$, Druck) längs der Achse],
  [$Q_y, Q_z$], [Querkräfte], [wollen die beiden Teile quer gegeneinander abscheren],
  [$T$], [Torsionsmoment], [verdreht den Träger um seine Achse],
  [$M_y, M_z$], [Biegemomente], [verbiegen den Träger],
  table.hline(stroke: 0.7pt),
)

#fg("k14_schnitt", [Schnittgrössen am ebenen Balken. Am _positiven Schnittufer_ (äussere Normale in $+x$-Richtung, hier das rechte Ende des linken Teils) zeigen positive $N$, $Q_y$, $M_z$ in die positiven Koordinatenrichtungen, am negativen Schnittufer in die negativen.])

#intu[
  Stell dir vor, du sägst den Balken durch und musst die beiden Hälften mit den Händen so zusammenhalten, dass nichts merkt, dass gesägt wurde. Du musst ziehen oder drücken ($N$), ein Abrutschen verhindern ($Q$), und du musst die Schnittflächen gegen Aufklappen festhalten ($M$). Was deine Hände dabei leisten müssen, ist die Beanspruchung: genau das, was vorher das Material leisten musste.
]

#merke[
  Vorzeichenkonventionen für Schnittgrössen sind in Büchern und Vorlesungen *nicht einheitlich*. Dieses Skript verwendet die Konvention der Abbildung (positive Grössen am positiven Schnittufer in positive Achsrichtung). Mit $y$ nach oben bedeutet $M_z > 0$: Der Balken hängt durch (Zug an der Unterseite). Verwende in der Prüfung die Konvention deiner Vorlesung und gib sie mit einer kleinen Skizze an.
]

== Ermittlung der Beanspruchung: die Schnittmethode

#rezept[Schnittmethode][
  + Lagerkräfte am ganzen Träger bestimmen (bei einem Kragarm kann man sie umgehen, indem man das freie Ende betrachtet).
  + Den Träger in *Bereiche* einteilen. Bereichsgrenzen sind alle Stellen, an denen sich die Belastung sprunghaft ändert: Einzelkräfte, Einzelmomente, Lager, Anfang und Ende von Streckenlasten, Knicke.
  + In jedem Bereich an einer allgemeinen Stelle $x$ schneiden und *einen* der beiden Teile freischneiden (den mit weniger Kräften).
  + Schnittgrössen in positiver Richtung eintragen, Gleichgewicht am Teil: liefert $N(x)$, $Q(x)$, $M(x)$. Momentenbedingung um den Schnittpunkt $C$.
  + Die Verläufe als Diagramme aufzeichnen und kontrollieren (siehe 14.3).
]

Genau gesagt gibt es vier gleichwertige Wege, die Beanspruchung an einem Schnitt zu berechnen: (1) aus dem Gleichgewicht der äusseren Kräfte des linken Teils mit der Beanspruchung, (2) aus dem Gleichgewicht der äusseren Kräfte des rechten Teils mit der entgegengesetzten Beanspruchung, (3) aus der Reduktion der äusseren Kräfte des rechten Teils auf den Flächenmittelpunkt, (4) aus der Reduktion der äusseren Kräfte des linken Teils (mit umgekehrtem Vorzeichen). Man wählt den Weg, der am wenigsten Rechnung bedeutet.

Beim Eintragen der Schnittgrössen am Freischnitt hilft eine Regel: Der Basisvektor $ve_1$ liegt in Richtung der _äusseren Normalen_ der Schnittfläche des betrachteten Teils. Dann liegen positive Beanspruchungskomponenten in positiver Richtung der Basisvektoren. Die Richtung der äusseren Normalen kann man durch Schraffur auf der Innenseite (der mit Material gefüllten Seite) des Schnitts markieren. Treten Einzelkräfte oder Einzelmomente auf, braucht man in _jedem_ Bereich zwischen zwei Lasten einen eigenen Schnitt in allgemeiner Lage. Statt zuerst alle Lagerkräfte zu berechnen, kann man sie auch zunächst als Unbekannte stehen lassen und aus den Randbedingungen (zum Beispiel: Moment am gelenkigen Ende null, alle Schnittgrössen an einem lastfreien Ende null) bestimmen.

Gleichwertig und oft schneller: Die Beanspruchung am positiven Schnittufer bei $x$ ist die Dyname _aller äusseren Kräfte am abgeschnittenen Teil jenseits des Schnitts_ ($> x$), reduziert auf $C$.

#fg("k14_diagramme", [Die beiden wichtigsten Grundfälle mit Querkraft- und Momentenverlauf (Lasten nach unten, Konvention dieses Skripts mit $y$ nach oben). Die Querkraft beginnt am linken Lager negativ, $Q_y (0) = -A_y$. Das Biegemoment ist dort extremal, wo die Querkraft null ist oder das Vorzeichen wechselt.])

#bsp[Kragarm mit aussermittiger Last][
  Greift die Endkraft $F ve_y$ am Kragarm (eingespannt bei $x = 0$, Länge $L$) nicht in der Achse an, sondern um $e$ in $+z$-Richtung versetzt (bei quadratischem Querschnitt der Seite $a$ ist $e < a\/2$), so hat sie bezüglich des Flächenmittelpunkts $C$ beim Schnitt $x$ das Moment $(L - x, 0, e) times (0, F, 0) = (-e F, 0, (L - x) F)$. Zur Querkraft $Q_y = F$ und zum Biegemoment $M_z = (L - x) F$ kommt also ein *Torsionsmoment* $T = -e F$ hinzu: Die Last verdreht den Träger um seine Achse. Die Einspannung muss dann $A_y = -F$ und das Moment $(M_(A x), M_(A y), M_(A z)) = (e F, 0, -L F)$ aufbringen.
]

#bsp[Vertikale Säule unter Eigengewicht][
  Bei verteilten Lasten darf man äquivalente Einzelkräfte einsetzen, aber erst _nach_ der Zerlegung. Eine homogene Säule (Gewicht $G$, Länge $L$) steht auf einer Unterlage. Schnitt im Abstand $x$ vom unteren Ende: Das Gewicht des oberen Stücks der Länge $L - x$ ist $G (L - x)\/L$ und wirkt nach unten, also $N(x) = -G (L - x)\/L$. Die Säule ist nur auf Druck beansprucht (negative Normalkraft), und zwar unten am stärksten ($N(0) = -G$), wo sie das ganze Gewicht trägt, oben null.
]

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
  Bei $x = a$ springt die Querkraft um $F$, das Moment hat einen Knick und seinen Grösstwert $M_"max" = F a b \/ L$.
]

#bsp[Kragarm mit Endlast][
  Balken bei $x = 0$ eingespannt, am freien Ende $x = L$ die Kraft $F$ in $+y$-Richtung. Der rechte Teil trägt nur $F$:
  $ Q_y (x) = F, wide M_z (x) = (L - x) F. $
  Das Moment ist an der Einspannung am grössten: Dort bricht ein überlasteter Kragarm. Die Lagerkräfte musste man dafür gar nicht ausrechnen. Umgekehrt liest man sie aus den Schnittgrössen bei $x = 0$ ab.
]

#bsp[Statisch unbestimmt gelagerter Träger][
  Ein horizontaler Balken $A B$ (Eigengewicht vernachlässigt) trägt die Dreieckslast $q(x) = q_0 x\/L$. In der Mitte $M$ ist ein vertikaler Kragarm $M E$ der Länge $h$ angeschweisst, der am freien Ende die horizontale Kraft $F$ trägt. $A$ und $B$ sind reibungsfreie, aber nicht verschiebbare Gelenke: einfach statisch unbestimmt. Man trennt den Kragarm ab; sein Einfluss auf den Balken ist die Reduktion von $F$ auf $M$: eine horizontale Kraft $F$ und das Moment $h F$ in $M$. Dann schneidet man zwischen $A$ und $M$; links vom Schnitt darf die Last durch ihre Resultierende $q_0 x^2\/(2L)$ im Abstand $2x\/3$ von $A$ ersetzt werden. Liegt der Schnitt zwischen $M$ und $B$, kommen die Kraft $F$ und das Moment $h F$ dazu. Die Randbedingung «am Gelenk $B$ verschwindet das Biegemoment» liefert eine Beziehung zwischen $A_y$ und $B_y$, die gleich der Momentenbedingung am ganzen Balken ist. Die horizontale Komponente $B_x$ (gleich $N(L)$) bleibt unbestimmt, weil $A_x$ unbekannt ist: Das Problem bleibt einfach statisch unbestimmt. Das zeigt, dass die Schnittmethode die Unbestimmtheit nicht beseitigt, sondern nur sichtbar macht.
]

#woche(14, [Beanspruchung], [205–212])
== Differentialbeziehungen am geraden Balken

Zwischen Belastung, Querkraft und Biegemoment bestehen feste Zusammenhänge. Man erhält sie aus dem Gleichgewicht an einem Balkenelement der Länge $dif x$ unter der Streckenlast $q_y (x)$.

#fg("k14_element", [Balkenelement der Länge $dif x$, alle Grössen in positiver Richtung eingezeichnet. Rechts ist das positive Schnittufer: $Q_y + dif Q_y$ nach oben, $M_z + dif M_z$ im Gegenuhrzeigersinn. Links das negative Schnittufer mit den entgegengesetzten Grössen. Die Streckenlast $q_y$ zeigt in $+y$-Richtung; eine Last nach unten hat $q_y < 0$.])

Kräftegleichgewicht in $y$-Richtung: $Q_y (x + dif x) - Q_y (x) + q_y dif x = 0$, also $dif Q_y = -q_y dif x$. Momentengleichgewicht um die rechte Schnittstelle (bis auf Grössen höherer Ordnung in $dif x$): $M_z (x + dif x) - M_z (x) + Q_y dif x = 0$, also $dif M_z = -Q_y dif x$.

#satz[Differentialbeziehungen][
  #gl($ Q_y' = -q_y, wide M_z' = -Q_y, wide "also" quad M_z'' = q_y. $)
  Für die andere Biegeebene gilt entsprechend $Q_z' = -q_z$ und $M_y' = Q_z$.
]

#intu[
  Die Querkraft «sammelt» die Last auf: Gehst du am Balken entlang, ändert sie sich um genau die Last, an der du vorbeikommst. Das Moment sammelt wiederum die Querkraft auf. Es ist zweimal dasselbe Spiel, wie bei Beschleunigung, Geschwindigkeit und Weg. Deshalb ist der Momentenverlauf immer um einen Grad «glatter» als der Querkraftverlauf, und dieser um einen Grad glatter als die Last.
]

Zur Herleitung der Differentialbeziehungen setzt man voraus, dass $Q_y$ und $M_z$ differenzierbar sind. Dann ist das Balkenelement zwischen den Schnitten bei $x$ und $x + dif x$ in Ruhe, und die Gleichgewichtsbedingungen liefern bis auf Grössen höherer Ordnung in $dif x$ die obigen Beziehungen. Der Lastvektor soll durch die Flächenmittelpunkte gehen, damit keine Torsion entsteht. Die Beziehungen gelten nicht an Stellen, wo eine Einzellast oder ein Einzelmoment angreift. Dort springen die Funktionen, und man schneidet ein Element heraus, das die Unstetigkeit umfasst:

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
  Randbedingungen $M_z (0) = 0$ und $M_z (L) = 0$ geben $C_2 = 0$ und $C_1 = 0$. Das grösste Moment liegt in der Mitte: $q_0 L^2 \/ pi^2$. Die Lagerkräfte liest man aus der Querkraft an den Enden ab: je $q_0 L \/ pi$.
]

#bsp[Dreipunktbiegung durch Integration][
  In den Bereichen $x in [0, a)$ und $x in (a, L]$ verschwindet die Last, also $Q_y' = 0$ und $M_z'' = 0$: Die Querkraft ist dort jeweils konstant, das Moment linear. Das sind vier Integrationskonstanten. Die Randbedingungen $M_z(0) = M_z(L) = 0$ (gelenkige Lager) fixieren zwei davon. Die übrigen zwei folgen aus den Übergangsbedingungen bei $x = a$: dem Sprung $Q_y(a^+) - Q_y(a^-) = -F$ und der Stetigkeit des Moments ($M = 0$ im Punkt). Man bekommt wieder dieselben Ergebnisse wie mit der Schnittmethode, aber systematischer.
]

#merke[
  *Extremum des Biegemoments:* Aus $M_z' = -Q_y$ folgt, dass $M_z$ dort extremal ist, wo die Querkraft verschwindet (ausser bei Randextrema und an Unstetigkeiten). In den Diagrammen oben sieht man das direkt: Bei der Gleichlast ist $Q_y = 0$ in der Mitte, dort liegt das Maximum.
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

#fg("k14_bogen", [Halbkreisträger, bei $phi = pi$ eingespannt, am freien Ende $phi = 0$ durch $vF$ belastet. Schnitt beim Winkel $phi$: Am freien Stück (schwarz) greifen am positiven Schnittufer $N$ (tangential, in Richtung wachsender $phi$), $Q_r$ (radial nach aussen) und $M_z$ an.])

#bsp[Halbkreisträger][
  Schneidet man beim Winkel $phi$ und betrachtet das freie Stück, so muss die Schnittstelle die Kraft $F$ aufnehmen. In tangentiale und radiale Richtung zerlegt ergibt sich $N = F cos phi$ und $Q_r = F sin phi$. Der Hebelarm von $F$ bezüglich der Schnittstelle ist $R (1 - cos phi)$, also $M_z = R F (1 - cos phi)$. Kontrolle mit den Differentialbeziehungen ($q = 0$): $N' + Q_r = -F sin phi + F sin phi = 0$ ✓, $M_z' - R Q_r = R F sin phi - R F sin phi = 0$ ✓. An der Einspannung ($phi = pi$) ist das Moment am grössten, $2 R F$.
]

#fehler[
  - Zu wenige Bereiche: An jeder Einzelkraft, jedem Lager und jedem Lastwechsel beginnt ein neuer Bereich.
  - Am Teil, das man betrachtet, Kräfte vergessen (besonders Lagerkräfte und Einspannmomente).
  - Für die Schnittgrössen die Streckenlast durch ihre Ersatzkraft am _ganzen Träger_ ersetzen. Man darf nur den Teil der Last ersetzen, der am freigeschnittenen Stück wirkt.
  - Vorzeichen: positives und negatives Schnittufer verwechseln.
]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Biegen und Schneiden: warum Balken hochkant stehen.* Ein Brett als Regalboden biegt sich viel weniger, wenn man es hochkant einbaut. Die Schnittgrössen (Querkraft $Q$, Biegemoment $M$) sagen, wo und wie stark ein Balken beansprucht ist; die Spannung hängt dann von der Querschnittsform ab. Ein I-Profil legt das Material weit nach aussen, wo die Biegespannung am grössten ist, und spart in der Mitte Gewicht. Deshalb sehen Stahlträger auf Baustellen so aus, und deshalb sind auch Röhrenknochen hohl.]

#alltag[*Das Sprungbrett.* Ein Sprungbrett ist ein Kragarm: einseitig eingespannt, am freien Ende belastet. Das Biegemoment wächst linear von null am freien Ende bis zum Maximum an der Einspannung $M_("max") = F l$. Dort bricht ein überbelastetes Brett auch. Dieselbe Rechnung entscheidet, wie weit ein Balkon über die Fassade ragen darf, wie viel Last ein Kranausleger hat und wo man bei einem Haken in der Wand am meisten Kraft braucht.]

#photo(("m_traeger",), [Stahlträger bei der Montage einer Brücke: Das Material liegt oben und unten, wo die Biegespannung am grössten ist. #credit[MassDOT, Public Domain, Wikimedia Commons]], ht: 4.6cm)
// ALLTAG-END

#aufgaben()

#merke[
  In der Vorlesung zeigt bei Balken $ve_y$ oft nach unten und $ve_z$ in die Zeichenebene hinein. Das ist ebenfalls ein Rechtssystem, die Definitionen und die Beziehungen $Q'_y = -q_y$, $M'_z = -Q_y$ gelten unverändert. Nur zeigen positive $Q_y$ und $M_z$ dann anders im Bild, und die Ergebnisse haben das umgekehrte Vorzeichen wie in den Beispielen weiter oben (dort zeigt $ve_y$ nach oben). Das Achsenkreuz steht deshalb in jedem Bild.
]

#aufg(fig: "a14_kragarm", fw: 6.6cm)[Kragarm mit Längs- und Querkraft][
  Ein Balken (Länge $L$) ist rechts eingespannt. Am freien linken Ende wirken die Kraft $F$ nach oben und die Kraft $S$ nach links. Gesucht sind $N$, $Q_y$ und $M_z$ als Funktion von $x$ ($ve_y$ nach unten).
][
  Man schneidet bei $x$ und betrachtet den *linken* Teil. Dann braucht man die Einspannreaktionen nicht. Seine Schnittfläche hat die Normale $+ve_x$ (positives Schnittufer), die Schnittgrössen werden dort in positiver Achsenrichtung angesetzt.
  $ sum X: quad N - S = 0 quad => quad N = S, wide sum Y: quad Q_y - F = 0 quad => quad Q_y = F, $
  $ sum M "um die Schnittstelle": quad M_z + F x = 0 quad => quad M_z = -F x. $
  $N > 0$ bedeutet Zug. Kontrolle: $M'_z = -F = -Q_y$ ✓. $N$ und $Q_y$ sind konstant, $M_z$ wächst linear und ist an der Einspannung am grössten, $|M_z| = F L$: Dort ist der Balken gefährdet.
]

#aufg(fig: "a14_einfeld", fw: 6.4cm)[Balken auf zwei Stützen mit Einzellast][
  Ein Balken liegt in $A$ (Gelenk) und $B$ (Auflager) auf. Im Abstand $a$ von $A$ und $b$ von $B$ greift die Kraft $F$ nach unten an. Gesucht sind $Q_y (x)$ und $M_z (x)$ ($ve_y$ nach unten).
][
  _Lagerkräfte_ (beide nach oben): $A = F b\/(a+b)$, $B = F a\/(a+b)$.

  _Bereich $x < a$_, linker Teil (nur $A$):
  $ Q_y = F b/(a+b), wide M_z = -F (b x)/(a+b). $
  _Bereich $x > a$_, rechter Teil (nur $B$, negatives Schnittufer):
  $ Q_y = -F a/(a+b), wide M_z = -F (a (a + b - x))/(a+b). $
  Die Querkraft springt bei $x = a$ um $F$. Das Moment hat dort einen Knick und seinen Extremwert $M_z = -F a b\/(a+b)$. Das ist das Beispiel «Dreipunktbiegung» von oben mit umgekehrter $y$-Achse: gleiche Beträge, umgekehrte Vorzeichen.
]

#aufg(fig: "a14_winkel", fw: 6.4cm)[Räumlich belasteter Winkelträger][
  Der Balken $B C$ (Länge $L$, längs $x$) ist in $C$ eingespannt. In $B$ ist rechtwinklig der Arm $B A$ (Länge $a$, längs $y$) angeschlossen. In $A$ greifen drei Kräfte an: $F_1$ in Richtung $-x$, $F_2$ in Richtung $+y$, $F_3$ in Richtung $+z$. Auf $B C$ wirkt in $y$-Richtung eine Dreieckslast $q_y (x) = q x\/L$.

  Gesucht sind alle sechs Schnittgrössen im Balken $B C$.
][
  Schnitt bei $x$, linker Teil (mit dem Arm $B A$). Die Last bis $x$ hat die Resultierende $q x^2\/(2L)$, sie greift bei $2x\/3$ an, also im Abstand $x\/3$ vor der Schnittstelle.

  _Kräfte._
  $ N = F_1, wide Q_y = -F_2 - (q x^2)/(2L), wide Q_z = -F_3. $
  _Momente um die Schnittstelle._ $A$ liegt von dort aus in $(-x, a, 0)$:
  $ T = -F_3 a, wide M_y = -F_3 x, wide M_z = F_2 x - F_1 a + (q x^3)/(6L). $

  _Deutung._ $F_3$ verdreht den Balken mit dem Hebelarm $a$ (Torsion) und biegt ihn um die $y$-Achse. $F_2$ und die verteilte Last biegen ihn um die $z$-Achse; $F_1$ gibt Zug und, weil sie um $a$ aussermittig angreift, ein konstantes Biegemoment $-F_1 a$.

  _Kontrolle mit den Differentialbeziehungen._ $Q'_y = -q x\/L = -q_y$ ✓ und $M'_z = F_2 + q x^2\/(2L) = -Q_y$ ✓. In der $x z$-Ebene lauten die Beziehungen $Q'_z = -q_z$ und $M'_y = +Q_z$ (anderes Vorzeichen, weil $ve_x, ve_z, ve_y$ kein Rechtssystem bilden): $M'_y = -F_3 = Q_z$ ✓.

  $N$, $Q_z$ und $T$ sind konstant, $|Q_y|$ und $|M_y|$ wachsen bis zur Einspannung $x = L$. Bei $M_z$ hängt es vom Verhältnis der Beiträge ab: $M_z$ wächst monoton (denn $M'_z = F_2 + q x^2\/(2L) > 0$) von $-F_1 a$ bis $L F_2 - F_1 a + q L^2\/6$. Für $2 F_1 a > L F_2 + q L^2\/6$ ist $|M_z|$ am freien Ende grösser als an der Einspannung.
]

#aufg(fig: "a14_ltraeger", fw: 7cm)[Winkelträger mit Gelenk][
  Der Träger $A B C$ (Länge $2L$) ist in $A$ eingespannt, hat in der Mitte $B$ ein Gelenk und liegt in $C$ auf. In $C$ ist biegesteif der Pfosten $C D$ (Länge $L$) angeschlossen, auf den die gleichmässige Last $q = P\/L$ in $x$-Richtung wirkt ($ve_y$ nach oben).

  Gesucht sind die Lagerreaktionen und die Schnittgrössen im Träger und im Pfosten.
][
  _Lagerreaktionen._ Das Gelenk überträgt kein Moment. Für den Teil rechts von $B$ gilt um $B$: $C_y L - P dot L/2 = 0$ (die Last hat die Resultierende $P$ in der Höhe $L\/2$), also $C_y = P\/2$. Am Ganzen folgt $A_x = -P$, $A_y = -P\/2$ und das Einspannmoment $M_A = -P L\/2$ (im Uhrzeigersinn).

  _Träger, $0 < x < 2L$_ (linker Teil):
  $ N = P, wide Q_y = P/2, wide M_z = P/2 (L - x). $
  Kontrolle: $M_z (L) = 0$ im Gelenk ✓, $M'_z = -Q_y$ ✓. Am rechten Ende ist $M_z (2L) = -P L\/2$.

  _Pfosten, $0 < y < L$_ (von $C$ aus gemessen). Am einfachsten betrachtet man den *oberen* Teil der Länge $L - y$, auf den nur die Last $q (L - y)$ wirkt. Er braucht an der Schnittstelle eine Kraft $q(L - y)$ in $-x$-Richtung und ein Moment, das die Last im Gleichgewicht hält:
  $ N = 0, wide |Q| = q (L - y) = P (1 - y/L), wide M_z = -q (L - y)^2/2 = P (y - L/2 - y^2/(2L)). $
  ($M_z$ wie im Träger um die globale $z$-Achse gezählt, als Moment auf das untere Schnittufer.)
  Am Fuss des Pfostens ist $M_z (0) = -P L\/2$, derselbe Wert wie am Trägerende: In der biegesteifen Ecke $C$ geht das Moment vollständig vom Pfosten in den Träger über.

  Mit dem unteren Teil (Träger, Lager und Pfostenstück) kommt dasselbe heraus, die Rechnung ist nur länger. Es lohnt sich immer, den Teil mit weniger Kräften zu wählen.
]

#kurz[
  - Beanspruchung = Dyname der Schnittkräfte im Flächenmittelpunkt: $N$, $Q_y$, $Q_z$, $T$, $M_y$, $M_z$.
  - Schnittmethode: Bereiche bilden, schneiden, Gleichgewicht am Teil.
  - $Q_y' = -q_y$, $M_z' = -Q_y$; Sprünge bei Einzelkräften und -momenten.
  - $M$ extremal bei $Q = 0$; $M = 0$ an Gelenken und freien Enden.
  - Gleichlast auf zwei Stützen: $M_"max" = q_0 L^2 \/ 8$. Einzellast: $M_"max" = F a b \/ L$. Kragarm mit Endlast: $M_"max" = F L$.
]
