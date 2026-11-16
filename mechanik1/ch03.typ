#import "lib.typ": *

= Kinematik starrer Körper

Ein starrer Körper besteht aus unendlich vielen Punkten. Müssten wir für jeden einzelnen die Geschwindigkeit angeben, kämen wir nie zu einem Ende. Die gute Nachricht dieses Kapitels: Weil alle Abstände fest sind, genügen *zwei Vektoren*, um die Geschwindigkeit _jedes_ Punktes zu kennen. Dahin arbeiten wir uns in vier Schritten vor: ein Grundsatz (der Satz der projizierten Geschwindigkeiten), drei Spezialbewegungen (Translation, Rotation, Kreiselung), die allgemeine Bewegung und schließlich der für Aufgaben wichtigste Fall, die ebene Bewegung.

Was wir aus Kapitel 1 brauchen: Ein starrer Körper behält alle Abstände. Verbindet man zwei beliebige Punkte $M, M'$ des Körpers durch den Vektor $va := arrow(M M')$, so ändert $va$ im Lauf der Zeit seine Richtung, aber nie seine Länge. Auch alle Winkel zwischen solchen Verbindungsvektoren bleiben konstant, also sind alle Skalarprodukte $va dot.c vb$ von Verbindungsvektoren zeitlich konstant, insbesondere $va dot.c va = "konst."$ -- aber nur, wenn man beide Vektoren zum _gleichen_ Zeitpunkt nimmt.

== Der Satz der projizierten Geschwindigkeiten

#intu[
  Nimm zwei Punkte $M$ und $N$ eines Körpers und denke dir zwischen ihnen eine starre, dünne Stange. Würde sich $M$ in Richtung der Stange schneller bewegen als $N$, so müsste sich die Stange verkürzen oder verlängern. Beim starren Körper darf das nicht geschehen. Also müssen beide Punkte _längs der Stange_ gleich schnell sein. Quer zur Stange sind die Geschwindigkeiten beliebig: Das ist dann Drehung.
]

#satz[Satz der projizierten Geschwindigkeiten (SdpG)][
  Die Geschwindigkeiten $vv_M, vv_N$ zweier beliebiger Punkte $M, N$ eines starren Körpers haben zu jeder Zeit gleiche Projektionen auf die Verbindungsgerade $M N$:
  #gl($ vv_M dot.c arrow(M N) = vv_N dot.c arrow(M N). $)
  Umgekehrt: Gilt dies für alle Punktepaare und alle Zeiten, so ist der Körper starr.
]

#fg("k03_sdpg", [Links: Die Anteile $v'_M$ und $v'_N$ längs $M N$ sind gleich, quer dazu sind die Geschwindigkeiten frei. Rechts: Ein Stab, dessen Enden an Boden und Wand geführt werden.])

#warum[Beweis][
  Mit $vr_M, vr_N$ den Ortsvektoren ist $va := arrow(M N) = vr_N - vr_M$. Weil der Körper starr ist, gilt $va dot.c va = "konst."$ Ableiten mit der Produktregel ergibt $2 va dot.c dot(va) = 0$, also $va dot.c dot(va) = 0$. Nun ist $dot(va) = dot(vr)_N - dot(vr)_M = vv_N - vv_M$. Damit $va dot.c (vv_N - vv_M) = 0$, das heißt $va dot.c vv_N = va dot.c vv_M$. Teilt man durch $|va|$, steht da gerade «gleiche Projektion auf die Richtung von $va$». $square$
]

Der Satz ist ein Handwerkszeug: Kennt man die Geschwindigkeit von $M$ ganz und von $N$ nur die Richtung, so liefert er den Betrag von $vv_N$.

#bsp[Stab an Wand und Boden][
  Die Enden eines starren Stabes $A B$ werden längs zweier senkrechter Geraden geführt ($A$ am Boden, $B$ an der Wand). $A$ habe die Schnelligkeit $v$, der Stab schließe mit dem Boden den Winkel $alpha$ ein. Gesucht: Geschwindigkeit von $B$.

  Die Richtung der Stabgeraden von $A$ nach $B$ ist $(-cos alpha, sin alpha)$. $vv_A = (v, 0)$ hat auf ihr die Projektion $-v cos alpha$. $vv_B$ ist vertikal, $vv_B = (0, -v_B)$ (positiv nach unten angenommen), mit Projektion $-v_B sin alpha$. Gleichsetzen:
  $ v cos alpha = v_B sin alpha quad => quad v_B = v cot alpha. $
  Für $alpha -> 0$ (Stab fast flach) rutscht $B$ beliebig schnell; steht der Stab fast senkrecht, bewegt sich $B$ kaum. Wenn der Stab ganz flach auf dem Boden liegt, würde $v_B$ unendlich groß: Dort verschwindet die Projektion von $vv_B$ auf den Stab ganz, also muss $v$ selbst null sein.
]

== Drei Grundbewegungen

Wir untersuchen drei einfache Bewegungsarten. Sie unterscheiden sich darin, wie viele Punkte oder Richtungen festgehalten werden.

#fg("k03_transrot", [Translation: alle Punkte haben dieselbe Geschwindigkeit (auch beim Viergelenk, wo die Bahnen Kreise sind). Rotation: Die Schnelligkeit wächst linear mit dem Abstand von der Achse.])

=== Translation

#defn[Translation][
  Bleibt bei der Bewegung eines starren Körpers nicht nur der Betrag, sondern auch die _Richtung_ jedes Verbindungsvektors $arrow(M N)$ konstant, so heißt die Bewegung *Translation*.
]

Der Körper verschiebt sich parallel zu sich selbst, ohne sich zu drehen. Alle Bahnkurven sind dann *kongruent* (deckungsgleich). Sind die Bahnen Geraden, spricht man von geradliniger Translation, sonst von krummliniger.

#intu[
  Translation heißt _nicht_ geradlinig. Die Gondel eines Riesenrads bleibt immer aufrecht: Sie dreht sich nicht. Trotzdem läuft jeder ihrer Punkte auf einem Kreis. Alle diese Kreise sind gleich groß und nur gegeneinander verschoben. Das ist eine _kreisförmige Translation_. Dasselbe passiert bei der Koppel $A A'$ des Viergelenks in der Abbildung: Die beiden gleich langen Kurbeln drehen, aber die Koppel bleibt parallel zu ihrer Anfangslage.
]

Mit $vr_M (t) = vr_M (t_1) + bold(R)_M (t)$ und dem gleichen für $N$ folgt aus der Konstanz von $arrow(M N) = vr_N - vr_M$, dass die Verschiebungen $bold(R)_M (t) = bold(R)_N (t)$ für alle Punkte *gleich* sind (Translationsvektor). Ableiten ergibt:
#gl($ vv_M = vv_N quad "für alle Punkte" M, N in K, "zu jeder Zeit". $)
Die Geschwindigkeiten sind örtlich konstant verteilt (zeitlich dürfen sie sich ändern). Auch die Umkehrung gilt: Ist die Geschwindigkeitsverteilung zu allen Zeiten uniform, so führt das System eine Translation aus. Gilt $vv_M = vv_N$ nur in einem Augenblick, spricht man von *momentaner Translation*.

=== Rotation

#defn[Rotation][
  Bleiben bei der Bewegung eines starren Körpers zwei Punkte $A, B in K$ für alle Zeiten in Ruhe, so heißt die Bewegung *Rotation*. Die feste Gerade $A B$ heißt *Rotationsachse* (Drehachse).
]

Aus der Definition und der Starrheit folgt (man kann es mit dem SdpG nachrechnen): Jeder Punkt außerhalb der Achse läuft auf einem Kreis senkrecht zur Achse, dessen Mittelpunkt auf der Achse liegt, und alle diese Punkte drehen sich um denselben Winkel $Phi(t)$. Wir legen die $z$-Achse in die Drehachse. Jeder Punkt führt dann eine Kreisbewegung aus, mit der gemeinsamen Winkelgeschwindigkeit, die wir jetzt *Rotationsgeschwindigkeit* des Körpers nennen:
#gl($ vom = dot(Phi) ve_z = omega ve_z, wide vv(vr, t) = vom(t) times vr. $)
Hier ist $omega$ die *Rotationsschnelligkeit* und $vr$ der Ortsvektor von einem beliebigen Achsenpunkt aus. Die Richtung von $vom$ ist durch die feste Achse bestimmt und ändert sich nicht, nur der Betrag $dot(Phi)(t)$ darf zeitabhängig sein. Ist er konstant, liegt eine *gleichförmige Rotation* vor.

#merke[
  Die Geschwindigkeitsverteilung der Rotation ist _linear in $vr$_: Verdoppelt man den Abstand von der Achse, verdoppelt sich die Schnelligkeit; und $vv$ steht immer senkrecht auf $vom$ und $vr$. Das ist genau die rechte Seite der Abbildung oben. Mathematisch ist $vr |-> vom times vr$ eine lineare homogene Funktion: $f(vr_1 + vr_2) = f(vr_1) + f(vr_2)$ und $f(k vr) = k f(vr)$.
]

Technisch wird die Drehzahl meist als Umdrehungen pro Minute $n$ angegeben. Umrechnung: $omega = 2 pi n\/60$ in rad/s. Zwei Wellen mit gleichem $omega$ haben Umfangsgeschwindigkeiten im Verhältnis ihrer Radien: Die dickere Welle läuft am Rand schneller. Zum Beispiel $n = 3000$ U/min $-> omega approx 314$ rad/s, bei $R = 5$ cm also $v = omega R approx 15.7$ m/s.

Auch die Umkehrung gilt: Ist die Geschwindigkeitsverteilung eines Systems zu jeder Zeit durch $vv = vom times vr$ gegeben, so ist es ein starrer Körper in Rotation. Zum Nachprüfen genügt der SdpG: Für zwei Punkte $M, N$ ist $vv_M dot.c arrow(M N) = (vom times vr_M) dot.c (vr_N - vr_M) = (vom times vr_M) dot.c vr_N = vom dot.c (vr_M times vr_N)$ (der Term mit $vr_M$ fällt weg, weil $(vom times vr_M) perp vr_M$). Dasselbe kommt für $vv_N dot.c arrow(M N)$ heraus: $- (vom times vr_N) dot.c vr_M = - vom dot.c (vr_N times vr_M) = vom dot.c (vr_M times vr_N)$. Beide Projektionen sind gleich.

Gilt $vv = vom times vr$ nur in einem Augenblick, nennt man das *momentane Rotation*. Davor und danach darf die Bewegung beliebig sein; im unendlich kleinen Zeitintervall um $t_0$ verhält sich der Körper aber wie ein rotierender.

=== Rollen: die wichtigste momentane Rotation

#defn[Rollen und Gleiten][
  Ein Körper *rollt* auf einem ruhenden Körper, wenn seine materiellen Berührungspunkte momentan in Ruhe sind. Haben diese Punkte eine (tangentiale) Geschwindigkeit, so *gleitet* er.
]

Betrachte einen Kreiszylinder (Rad), der auf einer ruhenden Ebene rollt. Der materielle Punkt $Z$ am Rad, der die Unterlage gerade berührt, ruht definitionsgemäß momentan. Das gilt für alle Punkte der Berührungsgeraden. Diese Gerade ist daher die momentane Rotationsachse. Die Rollbewegung ist eine *momentane Rotation um die Berührungsgerade*, die ihre Lage mit der Zeit parallel verschiebt. Die Geschwindigkeit jedes Radpunkts steht senkrecht auf seiner Verbindung mit $Z$ und ist proportional zu diesem Abstand.

#fg("k03_rollen", [Links: Beim rollenden Rad stehen alle Geschwindigkeiten senkrecht auf der Verbindung zum Berührungspunkt $Z$. Rechts: Dieselbe Verteilung als Überlagerung von Translation der Nabe und Drehung um die Nabe. Unten heben sich beide Anteile auf.])

#intu[
  Unten, im Berührungspunkt, wirken zwei Dinge gegeneinander: «vorwärts mit der Nabe» und «rückwärts durch die Drehung». Sie heben sich genau auf, deshalb steht der Punkt für einen Augenblick still. Oben addieren sich beide, die Geschwindigkeit ist $2v$. Das sieht man auf Fotos fahrender Räder: Die Speichen unten sind scharf, oben verwischt. Rollbedingung: $v_O = omega R$. Die Bahnen der Radpunkte sind Zykloiden.
]

=== Kreiselung

#defn[Kreiselung][
  Bleibt bei der Bewegung eines starren Körpers *ein* Punkt $O in K$ in Ruhe, so heißt die Bewegung *Kreiselung* mit dem Kreiselzentrum $O$.
]

Jeder Punkt $M$ bewegt sich dann auf einer Kugel mit Radius $overline(O M)$, seine Geschwindigkeit steht zu jeder Zeit senkrecht auf $arrow(O M)$. Das Beispiel ist der Spielzeugkreisel oder jede Drehbewegung eines Körpers um einen festen Punkt (Kugelgelenk).

Der Unterschied zur Rotation: Die Drehachse ist nicht mehr fest. Man kann aber zeigen (Satz von Euler), dass es zu jedem Zeitpunkt trotzdem eine Gerade $O mu$ durch $O$ gibt, deren Punkte momentan ruhen -- die *momentane Rotationsachse*. Zum Beweis betrachtet man zwei Punkte $M, N$ und die zu $vv_M, vv_N$ senkrechten Ebenen durch $O$. Ihre Schnittgerade besteht aus Punkten, deren Geschwindigkeit nach dem SdpG verschwinden muss. Dann sind die Geschwindigkeiten aller anderen Punkte nach dem SdpG proportional zu ihrem Abstand von $O mu$: Es liegt wieder $vv = vom times vr$ vor, mit
#gl($ vom = omega ve_mu, $)
aber jetzt mit einem Einheitsvektor $ve_mu$, dessen Richtung _zeitabhängig_ ist. $omega$ ist dann nicht mehr die Ableitung eines einzelnen Winkels, denn die kleinen Drehwinkel aufeinanderfolgender Augenblicke liegen in verschiedenen Ebenen.

Technisch begegnet man der Kreiselung bei Kreiselgeräten (Kompass, Kurskreisel in Flugzeugen, Satellitensteuerung) und, wie wir gleich sehen, bei fast jeder Bewegung, die mit einer Drehung verbunden ist.

== Die allgemeinste Bewegung: Kinemate

Ein starrer Körper $K$ bewege sich völlig frei. Wir wählen einen beliebigen Punkt $B in K$ als *Bezugspunkt* und beobachten einen zweiten Punkt $M in K$. Mit $vrho := arrow(B M)$ gilt $vr_M = vr_B + vrho$. Ableiten:
$ vv_M = vv_B + dot(vrho). $
Was ist $dot(vrho)$? Der Vektor $vrho$ hat konstanten Betrag (Starrheit). Denkt man sich einen Beobachter, der mit $B$ mitfliegt, ohne sich zu drehen, so ist für ihn $B$ in Ruhe, und der Körper erscheint ihm als Kreiselung um $B$. Also gilt für $dot(vrho)$ die Formel der Kreiselung, $dot(vrho) = vom times vrho$:

#satz[Grundgleichung des Bewegungszustandes][
  #gl($ vv_M = vv_B + vom times arrow(B M) quad "für alle" B, M in K. $)
]

Die Geschwindigkeit jedes Punktes besteht also aus einem *Translationsanteil* $vv_B$ (alle Punkte machen die Bewegung des Bezugspunktes mit) und einem *Drehanteil* $vom times arrow(B M)$ (Kreiselung um $B$).

#fg("k03_kinemate", [Die Geschwindigkeit von $M$ ist die Summe aus der Geschwindigkeit des Bezugspunkts $B$ und dem Drehanteil $vom times arrow(B M)$.])

#defn[Kinemate][
  Das Vektorpaar ${vv_B, vom}$ heißt *Kinemate in $B$*. Sie legt die Geschwindigkeit jedes Punktes des starren Körpers fest.
]

Das ist die Antwort auf die Eingangsfrage: Zwei Vektoren genügen. Es gibt drei Spezialfälle: Ist $vom = bold(0)$, haben wir eine Translation. Ist $vv_B = bold(0)$, eine Kreiselung um $B$. Sind beide ungleich null, liegt die allgemeine Bewegung vor (zum Beispiel Erde: Translation des Mittelpunkts auf der Bahn um die Sonne mit etwa 2.6 Mio km/Tag, überlagert von der Eigendrehung, die an der Oberfläche höchstens 40 000 km/Tag beiträgt).

=== Der Wechsel des Bezugspunkts

Dieselbe Bewegung lässt sich in jedem Bezugspunkt darstellen. Wie hängen die Kinematen ${vv_B, vom}$ und ${vv_(B'), vom'}$ zusammen? Aus der Grundgleichung für den Punkt $B'$:
#gl($ vv_(B') = vv_B + vom times arrow(B B'). $)
Für die Rotation: Für einen beliebigen weiteren Punkt $M$ gilt $vv_M = vv_B + vom times arrow(B M) = vv_(B') + vom' times arrow(B' M)$. Setzt man $arrow(B M) = arrow(B B') + arrow(B' M)$ und $vv_(B')$ von oben ein, bleibt $(vom - vom') times arrow(B' M) = bold(0)$ für alle $M$. Das geht nur für
#gl($ vom' = vom. $)

#satz[Die beiden Invarianten][
  - *1. Invariante:* Die Rotationsgeschwindigkeit $vom$ ist für alle Bezugspunkte dieselbe. Sie gehört zum Körper, nicht zu einem Punkt.
  - *2. Invariante:* Der Anteil der Geschwindigkeit in Richtung von $vom$ ist für alle Punkte gleich: $vv_omega := ((vom dot.c vv_B) / omega^2) vom$, denn $vom dot.c vv_M = vom dot.c vv_B$ (das Skalarprodukt mit $vom$ löscht den Term $vom times arrow(B M)$).
]

Beim Wechsel des Bezugspunkts ändert sich also nur der Anteil von $vv_B$ _senkrecht_ zu $vom$.

=== Zentralachse und Schraube

Wenn der senkrechte Anteil vom Bezugspunkt abhängt: Gibt es einen Bezugspunkt, in dem er verschwindet? Ja. Zerlege $vv_B = vv_omega + (vv_B)_perp$ mit $vv_omega parallel vom$ und $(vv_B)_perp perp vom$. Wir suchen einen Punkt $Z$ mit $vv_Z parallel vom$, also $(vv_Z)_perp = bold(0)$. Mit $arrow(B Z) perp vom$ ansetzen:
$ (vv_B)_perp + vom times arrow(B Z) = bold(0). $

#warum[Der Punkt $Z$][
  Wir wollen $arrow(B Z)$ ausrechnen. Kreuzen wir die Gleichung von links mit $vom$: $vom times (vv_B)_perp + vom times (vom times arrow(B Z)) = bold(0)$. Weil $arrow(B Z) perp vom$ ist, gilt $vom times (vom times arrow(B Z)) = -omega^2 arrow(B Z)$ (ausgeschriebene Entwicklungsformel). Also
  #gl($ arrow(B Z) = (vom times (vv_B)_perp) / omega^2 = (vom times vv_B) / omega^2, $)
  und das Weglassen von $vv_omega$ im letzten Schritt ist erlaubt, weil $vom times vv_omega = bold(0)$. Der Abstand ist $d_Z = |(vv_B)_perp| \/ omega$.
]

Alle Punkte auf der Parallelen zu $vom$ durch $Z$ haben dieselbe Eigenschaft (der Zusatzterm $vom times arrow(Z Z')$ verschwindet für $arrow(Z Z') parallel vom$).

#defn[Zentralachse und Schraube][
  Die *Zentralachse* $zeta$ ist die Gerade aller Punkte $Z$, deren Geschwindigkeit parallel zu $vom$ ist. Die Kinemate in ihren Punkten, ${vv_omega, vom}$, besteht nur aus den beiden Invarianten und heißt *Schraube*.
]

#fg("k03_schraube", [Vom Bezugspunkt $B$ aus findet man die Zentralachse im Abstand $d_Z$, senkrecht zu $vom$ und $(vv_B)_perp$. Auf ihr hat jeder Punkt nur die Geschwindigkeit $vv_omega$ in Richtung der Achse.])

#satz[Allgemeinste Bewegung][
  Der Bewegungszustand eines starren Körpers ist in jedem Augenblick eine *momentane Schraubung*: eine Drehung mit $vom$ um die Zentralachse und gleichzeitig eine Verschiebung mit $vv_omega$ längs dieser Achse.
]

#intu[
  Stell dir eine Schraube vor, die du ins Holz drehst, oder einen Korkenzieher: Er dreht sich um seine Achse und wandert gleichzeitig entlang der Achse. Die Aussage ist verblüffend stark: _Jede_ noch so wilde Bewegung eines starren Körpers sieht in jedem Augenblick wie eine solche Schraubenbewegung aus. Man muss nur die richtige Achse finden.
]

#bsp[Kinemate, Invarianten und Zentralachse][
  In einer Lage seien drei Punkte $A(a, 0, 0)$, $B(0, a, 0)$, $C(0, 0, a)$ mit den Geschwindigkeiten $vv_A = (-v, v, -v)$, $vv_B = (-v, v, 0)$, $vv_C = (-v, 0, -v)$ gegeben.

  _Schritt 1: Kontrolle._ Der SdpG für $A, B$: $arrow(A B) = (-a, a, 0)$, $vv_A dot.c arrow(A B) = a v + a v = 2 a v$ und $vv_B dot.c arrow(A B) = a v + a v = 2 a v$ ✓. Entsprechend für die anderen Paare.

  _Schritt 2: $vom$._ Mit $arrow(B A) = (a, -a, 0)$ und $vv_A - vv_B = (0, 0, -v)$: $vom times arrow(B A) = (a omega_z, a omega_z, -a(omega_x + omega_y))$. Vergleich ergibt $omega_z = 0$ und $omega_x + omega_y = v\/a$. Mit $arrow(B C) = (0, -a, a)$ und $vv_C - vv_B = (0, -v, -v)$: $vom times arrow(B C) = (a(omega_y + omega_z), -a omega_x, -a omega_x)$, also $omega_y = 0$ und $omega_x = v\/a$. Ergebnis: $vom = (v\/a, 0, 0)$.

  _Schritt 3: Invarianten._ $vom dot.c vv_B = -v^2\/a$, $omega^2 = v^2\/a^2$, also $vv_omega = -a vom = (-v, 0, 0)$ und $(vv_B)_perp = vv_B - vv_omega = (0, v, 0)$.

  _Schritt 4: Zentralachse._ $arrow(B Z) = (vom times vv_B)\/omega^2 = (0, 0, v^2\/a) \/ (v^2\/a^2) = (0, 0, a)$, also $Z = (0, a, a)$. Die Zentralachse ist die Parallele zur $x$-Achse durch $Z$. Der Körper dreht mit $omega = v\/a$ um sie und gleitet dabei mit $v$ in negativer $x$-Richtung.
]

Die Schraube *degeneriert*, wenn $vom dot.c vv_B = 0$ ist, also $vv_omega = bold(0)$:

#table(columns: (auto, 1fr), stroke: none, inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 0.7pt),
  [$vom = bold(0)$], [momentane *Translation*; die Zentralachse wandert ins Unendliche.],
  [$vv_B = bold(0)$], [momentane *Rotation* um die Achse durch $B$ in Richtung $vom$.],
  [$vv_B perp vom$, beide $!= bold(0)$], [ebenfalls momentane *Rotation*, aber um eine Achse, die nicht durch $B$ geht. Das ist der Fall der ebenen Bewegung.],
  table.hline(stroke: 0.7pt),
)

== Die ebene Bewegung

#defn[Ebene Bewegung][
  Die Bewegung eines starren Körpers heißt *eben*, wenn die Bahnkurven aller Punkte eben sind und in parallelen Ebenen liegen.
]

Das ist der Normalfall in den Aufgaben: ein Rad, ein Stab, ein Kolben, eine Kurbel. Alle Punkte auf einer Senkrechten zur Bewegungsebene bewegen sich gleich, es genügt also, einen _ebenen Schnitt_ des Körpers in der $x y$-Ebene zu betrachten. Seine Lage ist durch drei Zahlen bestimmt: $x_B, y_B$ eines Punktes $B$ und den Winkel $phi$ einer festen Verbindungsstrecke $B M$ gegen die $x$-Achse.

Mit $vrho = rho(cos phi ve_x + sin phi ve_y)$ ($rho$ konstant) ist $dot(vrho) = dot(phi) ve_z times vrho$. Vergleich mit der Grundgleichung liefert für die Kinemate
#gl($ vom = dot(phi) ve_z, wide vv_B = dot(x)_B ve_x + dot(y)_B ve_y perp vom. $)
Die Rotationsgeschwindigkeit steht senkrecht auf der Bewegungsebene, die Translationsgeschwindigkeit liegt in ihr. Also ist immer $vom dot.c vv_B = 0$: Wir sind im dritten Spezialfall oben. Die Zentralachse wird zur *momentanen Drehachse*, und sie durchstößt die Bewegungsebene in einem Punkt.

#satz[Satz vom Momentanzentrum][
  Bei jeder ebenen Bewegung eines starren Körpers mit $vom != bold(0)$ gibt es genau einen momentan ruhenden Punkt $Z$ des (in Gedanken auf die ganze Ebene ausgedehnten) Körpers, das *Momentanzentrum*. Der Körper dreht sich momentan um $Z$: Für jeden Punkt $M$ ist
  #gl($ vv_M perp arrow(Z M), wide |vv_M| = omega dot.c overline(Z M), $)
  mit dem Richtungssinn von $vom = dot(phi) ve_z$.
]

Lage: Aus $arrow(B Z) = (vom times vv_B)\/omega^2$ folgt $overline(B Z) = |vv_B|\/omega$.

#fg("k03_momentanzentrum", [Links: Kennt man die _Richtungen_ der Geschwindigkeiten in zwei Punkten, so liegt $Z$ im Schnittpunkt der beiden Senkrechten. Rechts: Beim geführten Stab ist $Z$ die vierte Ecke des Rechtecks über $A$ und $B$.])

#rezept[Momentanzentrum finden][
  + Kennst du die *Richtungen* der Geschwindigkeit in zwei Punkten $P, Q$: Zeichne in jedem die Senkrechte zur Geschwindigkeit. Der Schnittpunkt ist $Z$.
  + Sind die beiden Senkrechten *parallel* und verschieden: momentane Translation, $Z$ im Unendlichen, $omega = 0$.
  + Liegen beide Senkrechten *auf derselben Geraden*: $Z$ liegt darauf; seine Lage folgt aus den Beträgen der Geschwindigkeiten, die linear mit dem Abstand von $Z$ wachsen (Strahlensatz).
  + Rollt der Körper auf einer ruhenden Unterlage: $Z$ ist der Berührungspunkt.
  + Ist ein Punkt des Körpers in einem ruhenden Gelenk gelagert: $Z$ ist dieser Punkt.
  + Dann: $omega = |vv_P| \/ overline(Z P)$, und jede weitere Geschwindigkeit folgt aus $|vv_M| = omega overline(Z M)$, senkrecht zu $Z M$, im Drehsinn von $vom$.
]

#bsp[Stab an Wand und Boden: zweiter Blick][
  Die Geschwindigkeit von $A$ ist horizontal, die Senkrechte in $A$ also vertikal. $vv_B$ ist vertikal, die Senkrechte in $B$ also horizontal. $Z$ ist die vierte Ecke des Rechtecks $O A Z B$ ($O$ die Ecke zwischen Wand und Boden). Aus $v = omega dot.c overline(Z A) = omega L sin alpha$ folgt $omega = v\/(L sin alpha)$, und $v_B = omega dot.c overline(Z B) = omega L cos alpha = v cot alpha$. Dasselbe wie mit dem SdpG, aber man bekommt $omega$ und die Geschwindigkeit _jedes_ Stabpunktes gleich mit.
]

=== Polbahnen

Das Momentanzentrum $Z$ ist nur _momentan_ in Ruhe. Im nächsten Augenblick ist ein anderer Punkt Momentanzentrum. Die Menge der Lagen von $Z$ im ruhenden Bezugssystem heißt *feste Polbahn*. Die Menge der Lagen von $Z$, wie sie ein mit dem Körper mitbewegter Beobachter sieht, heißt *bewegliche Polbahn*. Beide Kurven berühren sich in $Z$, und die bewegliche Polbahn *rollt* ohne zu gleiten auf der festen ab. Jede ebene Bewegung lässt sich so durch das Abrollen zweier Kurven erzeugen.

Beim rollenden Rad ist die feste Polbahn die Straße, die bewegliche der Radumfang. Beim geführten Stab hat $Z$ die Koordinaten $(L cos alpha, L sin alpha)$, liegt also immer im Abstand $L$ von der Ecke $O$: Die feste Polbahn ist ein Viertelkreis mit Radius $L$. Aus Sicht des Stabes sieht man $Z$ stets unter einem rechten Winkel auf die Strecke $A B$: Die bewegliche Polbahn ist der Kreis mit Durchmesser $A B$ (Satz des Thales), Radius $L\/2$. Man kann die Stabbewegung also erzeugen, indem man einen kleinen Kreis im doppelt so großen abrollen lässt.

#fg("k03_polbahnen", [Der geführte Stab: Der Thaleskreis (bewegliche Polbahn) rollt im Viertelkreis mit Radius $L$ (feste Polbahn) ab. Die Punkte auf dem Viertelkreis sind die Momentanzentren bei verschiedenen Neigungen.])

=== Anwendung: Planetengetriebe

Ein Planetengetriebe enthält ein Sonnenrad 1 (Radius $R_1$), ein Hohlrad 2 (Innenradius $R_2$) und dazwischen ein Planetenrad 3 mit Radius $R_3 = (R_2 - R_1)\/2$, das auf beiden abrollt. Das Planetenrad sitzt in einem um $O$ drehbaren Arm der Länge $L = (R_1 + R_2)\/2$. Die Räder 1, 2 drehen mit $omega_1, omega_2$ um $O$; gesucht ist die Rotationsschnelligkeit $omega$ des Arms.

#fg("k03_planet", [Planetengetriebe. Die Berührungspunkte $P$ und $Q$ haben die Geschwindigkeiten der Räder 1 und 2.])

_Lösung:_ Die Punkte $P$ und $Q$, in denen Rad 3 die Räder 1 und 2 berührt, haben (als Punkte von 1 bzw. 2) die Schnelligkeiten $R_1 omega_1$ bzw. $R_2 omega_2$, senkrecht zum Arm. Weil das Planetenrad abrollt, haben $P$ und $Q$ als Punkte des Planetenrades _dieselben_ Geschwindigkeiten. Die Geschwindigkeit eines ebenen Körpers wächst linear mit dem Abstand vom Momentanzentrum. Der Mittelpunkt $O'$ des Planetenrades liegt genau in der Mitte zwischen $P$ und $Q$, also hat er die mittlere Schnelligkeit
$ v_(O') = (R_1 omega_1 + R_2 omega_2) / 2. $
$O'$ gehört auch zum Arm, der um $O$ mit dem Abstand $L$ dreht, also $v_(O') = omega L$:
$ omega = (R_1 omega_1 + R_2 omega_2) / (R_1 + R_2). $
Die Rotationsschnelligkeit des Planetenrads selbst folgt aus dem Geschwindigkeitsunterschied zwischen $P$ und $Q$ (Abstand $2R_3 = R_2 - R_1$): $omega_3 = (R_2 omega_2 - R_1 omega_1)\/(R_2 - R_1)$.

Spezialfälle: Hält man das Sonnenrad fest ($omega_1 = 0$), ist $omega = R_2 omega_2\/(R_1 + R_2)$ -- ein kräftiges Untersetzungsgetriebe. Hält man den Arm fest ($omega = 0$), gilt $omega_2 = -(R_1\/R_2) omega_1$: Das Hohlrad dreht gegensinnig.

#fehler[
  - Das Momentanzentrum für einen _festen_ Punkt halten. Es hat nur momentan die Geschwindigkeit null (und im Allgemeinen keineswegs die Beschleunigung null), und es wandert.
  - Bei einem Mechanismus mit mehreren Körpern ein gemeinsames $Z$ suchen. *Jeder* starre Körper hat sein eigenes Momentanzentrum und sein eigenes $omega$.
  - Beim Wechsel des Bezugspunkts $vom$ verändern. $vom$ ist die 1. Invariante und bleibt gleich.
  - In $vom times arrow(B M)$ den Vektor in der falschen Richtung nehmen: Er zeigt vom Bezugspunkt $B$ zum Punkt $M$, dessen Geschwindigkeit gesucht ist.
]

#kurz[
  - SdpG: $vv_M dot.c arrow(M N) = vv_N dot.c arrow(M N)$ -- gleiche Anteile längs der Verbindung.
  - Translation: $vv_M = vv_N$. Rotation: $vv = vom times vr$ (Achse fest). Kreiselung: ein Punkt fest, $vom$ darf wandern.
  - Rollen: Berührungspunkt in Ruhe, momentane Rotation um die Berührungsgerade, $v_O = omega R$.
  - Allgemein: $vv_M = vv_B + vom times arrow(B M)$, Kinemate ${vv_B, vom}$. Bezugspunktwechsel: $vv_(B') = vv_B + vom times arrow(B B')$, $vom' = vom$.
  - Invarianten: $vom$ und $vv_omega$ (Anteil längs $vom$). Zentralachse: $arrow(B Z) = (vom times vv_B)\/omega^2$; Schraube ${vv_omega, vom}$.
  - Eben: $vom = dot(phi) ve_z$; Momentanzentrum $Z$ mit $vv_M perp arrow(Z M)$, $|vv_M| = omega overline(Z M)$.
]
