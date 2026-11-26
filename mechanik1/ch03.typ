#import "lib.typ": *

= Kinematik starrer Körper

#woche(3, [Starrer Körper], [35–45])

Ein starrer Körper besteht aus unendlich vielen Punkten. Müssten wir für jeden einzelnen die Geschwindigkeit angeben, kämen wir nie zu einem Ende. Die gute Nachricht dieses Kapitels: Weil alle Abstände fest sind, genügen *zwei Vektoren*, um die Geschwindigkeit _jedes_ Punktes zu kennen. Dahin arbeiten wir uns in vier Schritten vor: ein Grundsatz (der Satz der projizierten Geschwindigkeiten), drei Spezialbewegungen (Translation, Rotation, Kreiselung), die allgemeine Bewegung und schliesslich der für Aufgaben wichtigste Fall, die ebene Bewegung.

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
  Mit $vr_M, vr_N$ den Ortsvektoren ist $va := arrow(M N) = vr_N - vr_M$. Weil der Körper starr ist, gilt $va dot.c va = "konst."$ Ableiten mit der Produktregel ergibt $2 va dot.c dot(va) = 0$, also $va dot.c dot(va) = 0$. Nun ist $dot(va) = dot(vr)_N - dot(vr)_M = vv_N - vv_M$. Damit $va dot.c (vv_N - vv_M) = 0$, das heisst $va dot.c vv_N = va dot.c vv_M$. Teilt man durch $|va|$, steht da gerade «gleiche Projektion auf die Richtung von $va$». $square$
]

Der Satz ist ein Handwerkszeug: Kennt man die Geschwindigkeit von $M$ ganz und von $N$ nur die Richtung, so liefert er den Betrag von $vv_N$.

#bsp[Stab an Wand und Boden][
  Die Enden eines starren Stabes $A B$ werden längs zweier senkrechter Geraden geführt ($A$ am Boden, $B$ an der Wand). $A$ habe die Schnelligkeit $v$, der Stab schliesse mit dem Boden den Winkel $alpha$ ein. Gesucht: Geschwindigkeit von $B$.

  Die Richtung der Stabgeraden von $A$ nach $B$ ist $(-cos alpha, sin alpha)$. $vv_A = (v, 0)$ hat auf ihr die Projektion $-v cos alpha$. $vv_B$ ist vertikal, $vv_B = (0, -v_B)$ (positiv nach unten angenommen), mit Projektion $-v_B sin alpha$. Gleichsetzen:
  $ v cos alpha = v_B sin alpha quad => quad v_B = v cot alpha. $
  Für $alpha -> 0$ (Stab fast flach) rutscht $B$ beliebig schnell; steht der Stab fast senkrecht, bewegt sich $B$ kaum. Wenn der Stab ganz flach auf dem Boden liegt, würde $v_B$ unendlich gross: Dort verschwindet die Projektion von $vv_B$ auf den Stab ganz, also muss $v$ selbst null sein.
]

== Drei Grundbewegungen

Wir untersuchen drei einfache Bewegungsarten. Sie unterscheiden sich darin, wie viele Punkte oder Richtungen festgehalten werden.

#fg("k03_transrot", [Translation: alle Punkte haben dieselbe Geschwindigkeit (auch beim Viergelenk, wo die Bahnen Kreise sind). Rotation: Die Schnelligkeit wächst linear mit dem Abstand von der Achse.])

=== Translation

#defn[Translation][
  Bleibt bei der Bewegung eines starren Körpers nicht nur der Betrag, sondern auch die _Richtung_ jedes Verbindungsvektors $arrow(M N)$ konstant, so heisst die Bewegung *Translation*.
]

Der Körper verschiebt sich parallel zu sich selbst, ohne sich zu drehen. Alle Bahnkurven sind dann *kongruent* (deckungsgleich). Sind die Bahnen Geraden, spricht man von geradliniger Translation, sonst von krummliniger.

#intu[
  Translation heisst _nicht_ geradlinig. Die Gondel eines Riesenrads bleibt immer aufrecht: Sie dreht sich nicht. Trotzdem läuft jeder ihrer Punkte auf einem Kreis. Alle diese Kreise sind gleich gross und nur gegeneinander verschoben. Das ist eine _kreisförmige Translation_. Dasselbe passiert bei der Koppel $A A'$ des Viergelenks in der Abbildung: Die beiden gleich langen Kurbeln drehen, aber die Koppel bleibt parallel zu ihrer Anfangslage.
]

Mit $vr_M (t) = vr_M (t_1) + bold(R)_M (t)$ und dem gleichen für $N$ folgt aus der Konstanz von $arrow(M N) = vr_N - vr_M$, dass die Verschiebungen $bold(R)_M (t) = bold(R)_N (t)$ für alle Punkte *gleich* sind (Translationsvektor). Ableiten ergibt:
#gl($ vv_M = vv_N quad "für alle Punkte" M, N in K, "zu jeder Zeit". $)
Die Geschwindigkeiten sind örtlich konstant verteilt (zeitlich dürfen sie sich ändern). Auch die Umkehrung gilt: Ist die Geschwindigkeitsverteilung zu allen Zeiten uniform, so führt das System eine Translation aus. Gilt $vv_M = vv_N$ nur in einem Augenblick, spricht man von *momentaner Translation*.

=== Rotation

#defn[Rotation][
  Bleiben bei der Bewegung eines starren Körpers zwei Punkte $A, B in K$ für alle Zeiten in Ruhe, so heisst die Bewegung *Rotation*. Die feste Gerade $A B$ heisst *Rotationsachse* (Drehachse).
]

Aus der Definition und der Starrheit folgt (man kann es mit dem SdpG nachrechnen): Jeder Punkt ausserhalb der Achse läuft auf einem Kreis senkrecht zur Achse, dessen Mittelpunkt auf der Achse liegt, und alle diese Punkte drehen sich um denselben Winkel $Phi(t)$. Wir legen die $z$-Achse in die Drehachse. Jeder Punkt führt dann eine Kreisbewegung aus, mit der gemeinsamen Winkelgeschwindigkeit, die wir jetzt *Rotationsgeschwindigkeit* des Körpers nennen:
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

Betrachte einen Kreiszylinder (Rad), der auf einer ruhenden Ebene rollt. Der materielle Punkt $Z$ am Rad, der die Unterlage gerade berührt, ruht definitionsgemäss momentan. Das gilt für alle Punkte der Berührungsgeraden. Diese Gerade ist daher die momentane Rotationsachse. Die Rollbewegung ist eine *momentane Rotation um die Berührungsgerade*, die ihre Lage mit der Zeit parallel verschiebt. Die Geschwindigkeit jedes Radpunkts steht senkrecht auf seiner Verbindung mit $Z$ und ist proportional zu diesem Abstand.

#fg("k03_rollen", [Links: Beim rollenden Rad steht jede Geschwindigkeit senkrecht auf der Verbindung zum Berührungspunkt $Z$ und ist proportional zu ihrer Länge; längs des senkrechten Durchmessers wächst sie linear von $0$ in $Z$ bis $2v$ oben. Rechts: Dieselbe Verteilung als Überlagerung von Translation der Nabe und Drehung um die Nabe. Unten heben sich beide Anteile auf, oben addieren sie sich.])

#intu[
  Unten, im Berührungspunkt, wirken zwei Dinge gegeneinander: «vorwärts mit der Nabe» und «rückwärts durch die Drehung». Sie heben sich genau auf, deshalb steht der Punkt für einen Augenblick still. Oben addieren sich beide, die Geschwindigkeit ist $2v$. Das sieht man auf Fotos fahrender Räder: Die Speichen unten sind scharf, oben verwischt. Rollbedingung: $v_O = omega R$.
]

Wie sich das über eine ganze Umdrehung auswirkt, zeigt die Bildfolge unten. Ein Punkt $P$ am Radumfang läuft auf einer *Zykloide*. Mit dem Drehwinkel $phi$ des Rades (von der untersten Lage aus) gilt
$ x_P = R (phi - sin phi), quad y_P = R (1 - cos phi), quad vv_P = R dot(phi) (1 - cos phi, thin sin phi). $
Für $phi = 0$ und $phi = 2 pi$ ist $vv_P = bold(0)$: Genau wenn $P$ den Boden berührt, steht er still, und die Bahn hat dort eine Spitze mit senkrechter Tangente. Der Punkt setzt nicht schräg auf, sondern senkrecht, und hebt senkrecht wieder ab. Deshalb reibt ein rollendes Rad nicht am Boden.

#fg("k03_zykloide", [Bildfolge über eine Umdrehung: Das Rad rollt nach rechts, $P$ (schwarz) beschreibt eine Zykloide. In jedem Bild ist $Z$ (rot) das Momentanzentrum; $vv_P$ steht senkrecht auf $Z P$ und ist proportional zu $overline(Z P)$. Bei $1\/2$ Umdrehung ist $P$ oben und hat $2 v_O$, bei $0$ und $1$ berührt er den Boden mit $vv_P = bold(0)$.])

#woche(4, [Starrer Körper], [45–54])
=== Kreiselung

#defn[Kreiselung][
  Bleibt bei der Bewegung eines starren Körpers *ein* Punkt $O in K$ in Ruhe, so heisst die Bewegung *Kreiselung* mit dem Kreiselzentrum $O$.
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

#fg("k03_kinemate", [Die Geschwindigkeit von $M$ ist die Summe aus der Geschwindigkeit des Bezugspunkts $B$ und dem Drehanteil $vom times arrow(B M)$, der senkrecht auf $arrow(B M)$ steht (Winkelmarke) und den Betrag $omega overline(B M)$ hat.])

#defn[Kinemate][
  Das Vektorpaar ${vv_B, vom}$ heisst *Kinemate in $B$*. Sie legt die Geschwindigkeit jedes Punktes des starren Körpers fest.
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
  Die *Zentralachse* $zeta$ ist die Gerade aller Punkte $Z$, deren Geschwindigkeit parallel zu $vom$ ist. Die Kinemate in ihren Punkten, ${vv_omega, vom}$, besteht nur aus den beiden Invarianten und heisst *Schraube*.
]

#fg("k03_schraube", [Die Zentralachse $zeta$ liegt parallel zu $vom$ im Abstand $d_Z$ von $B$, senkrecht zu $vom$ und zu $(vv_B)_perp$; hier mit $vom$ in $y$- und $(vv_B)_perp$ in $x$-Richtung liegt sie _unter_ $B$, denn $arrow(B Z) = vom times vv_B \/ omega^2$ zeigt in $-z$-Richtung. Auf $zeta$ hat jeder Punkt nur $vv_omega$. Entlang der Senkrechten durch $Z$ wächst der Queranteil linear: das Geschwindigkeitsfeld einer Schraubung.])

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

#woche(5, [Starrer Körper, Kraft], [54–68])
== Die ebene Bewegung

#defn[Ebene Bewegung][
  Die Bewegung eines starren Körpers heisst *eben*, wenn die Bahnkurven aller Punkte eben sind und in parallelen Ebenen liegen.
]

Das ist der Normalfall in den Aufgaben: ein Rad, ein Stab, ein Kolben, eine Kurbel. Alle Punkte auf einer Senkrechten zur Bewegungsebene bewegen sich gleich, es genügt also, einen _ebenen Schnitt_ des Körpers in der $x y$-Ebene zu betrachten. Seine Lage ist durch drei Zahlen bestimmt: $x_B, y_B$ eines Punktes $B$ und den Winkel $phi$ einer festen Verbindungsstrecke $B M$ gegen die $x$-Achse.

Mit $vrho = rho(cos phi ve_x + sin phi ve_y)$ ($rho$ konstant) ist $dot(vrho) = dot(phi) ve_z times vrho$. Vergleich mit der Grundgleichung liefert für die Kinemate
#gl($ vom = dot(phi) ve_z, wide vv_B = dot(x)_B ve_x + dot(y)_B ve_y perp vom. $)
Die Rotationsgeschwindigkeit steht senkrecht auf der Bewegungsebene, die Translationsgeschwindigkeit liegt in ihr. Also ist immer $vom dot.c vv_B = 0$: Wir sind im dritten Spezialfall oben. Die Zentralachse wird zur *momentanen Drehachse*, und sie durchstösst die Bewegungsebene in einem Punkt.

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

Das Momentanzentrum $Z$ ist nur _momentan_ in Ruhe. Im nächsten Augenblick ist ein anderer Punkt Momentanzentrum. Die Menge der Lagen von $Z$ im ruhenden Bezugssystem heisst *feste Polbahn*. Die Menge der Lagen von $Z$, wie sie ein mit dem Körper mitbewegter Beobachter sieht, heisst *bewegliche Polbahn*. Beide Kurven berühren sich in $Z$, und die bewegliche Polbahn *rollt* ohne zu gleiten auf der festen ab. Jede ebene Bewegung lässt sich so durch das Abrollen zweier Kurven erzeugen.

Beim rollenden Rad ist die feste Polbahn die Strasse, die bewegliche der Radumfang. Beim geführten Stab hat $Z$ die Koordinaten $(L cos alpha, L sin alpha)$, liegt also immer im Abstand $L$ von der Ecke $O$: Die feste Polbahn ist ein Viertelkreis mit Radius $L$. Aus Sicht des Stabes sieht man $Z$ stets unter einem rechten Winkel auf die Strecke $A B$: Die bewegliche Polbahn ist der Kreis mit Durchmesser $A B$ (Satz des Thales), Radius $L\/2$. Man kann die Stabbewegung also erzeugen, indem man einen kleinen Kreis im doppelt so grossen abrollen lässt.

#fg("k03_polbahnen", w: 62%, [Bildfolge des geführten Stabes bei drei Neigungen. Der Thaleskreis über $A B$ (bewegliche Polbahn, blau) rollt innen im Viertelkreis mit Radius $L$ (feste Polbahn, grau) ab; die roten Punkte sind die jeweiligen Momentanzentren. Ein anderer Stabpunkt $C$ läuft auf einer Ellipse.])

=== Die Polbahnen des Stabes: analytisch

Bei einfachen Problemen liest man die Polbahnen aus der Zeichnung. Bei schwierigeren rechnet man: Man drückt die Koordinaten von $Z$ durch eine Lagekoordinate aus (hier den Winkel $phi$ des Stabes) und eliminiert sie.

#warum[Feste und bewegliche Polbahn des geführten Stabes][
  _Fest._ In $O x y$ (Ecke $O$, Wand = $y$-Achse, Boden = $x$-Achse) ist $A = (L cos phi, 0)$, $B = (0, L sin phi)$ und damit $Z = (x_Z, y_Z) = (L cos phi, L sin phi)$. Elimination von $phi$ liefert $x_Z^2 + y_Z^2 = L^2$: ein Kreis um $O$ mit Radius $L$.

  _Beweglich._ Wir führen ein körperfestes System $A xi eta$ ein ($xi$ entlang des Stabes von $A$ nach $B$, $eta$ senkrecht dazu). Der Vektor $arrow(A Z) = (0, L sin phi)$ hat dort die Komponenten $xi_Z = L sin^2 phi = (L\/2)(1 - cos 2 phi)$ und $eta_Z = L sin phi cos phi = (L\/2) sin 2 phi$. Elimination von $phi$: $(xi_Z - L\/2)^2 + eta_Z^2 = (L\/2)^2$. Das ist der Kreis um die Stabmitte mit Radius $L\/2$.
]

Allgemein heisst das: Die ebene Bewegung eines starren Körpers lässt sich als *Rollbewegung der beweglichen Polbahn auf der festen* auffassen. Man kann sich den starren Körper (hier den Stab) in Gedanken durch die bewegliche Polbahn (den kleinen Kreis) ersetzen und das Bezugssystem durch die feste (den grossen Kreis): Die Stabbewegung ist dann das Abrollen des kleinen Kreises im grossen.

Daraus folgt ein schönes Ergebnis, das man in der Bildfolge sieht. Rollt ein Kreis innen in einem doppelt so grossen, so laufen alle Punkte seines Umfangs auf _Geraden_ durch den Mittelpunkt des grossen Kreises (Satz von Cardano). $A$ und $B$ liegen auf dem kleinen Kreis und bleiben deshalb auf Boden und Wand. Jeder andere Stabpunkt $C$ mit $overline(B C) = t L$ hat die Koordinaten $x_C = t L cos phi$, $y_C = (1 - t) L sin phi$ und läuft auf einer Ellipse mit den Halbachsen $t L$ und $(1 - t) L$. Genau so funktioniert der Ellipsenzirkel.

=== Systeme aus mehreren starren Körpern

Technische Mechanismen (Getriebe, Fachwerke mit entferntem Stab, Kurbeltriebe) bestehen aus mehreren starren Körpern. Jeder hat sein *eigenes* Momentanzentrum und seine eigene Rotationsschnelligkeit.

#rezept[Mechanismus mit mehreren starren Körpern][
  + *Starre Körper identifizieren.* Stäbe, die so verbunden sind, dass keine Relativbewegung möglich ist (zum Beispiel ein Dreieck aus drei Stäben), bilden zusammen _einen_ starren Körper.
  + Für jeden Körper das Momentanzentrum bestimmen. Ist ein Körper in einem ruhenden Gelenk gelagert, ist dieses Gelenk sein $Z$. Daraus folgt sofort die Richtung der Geschwindigkeit jedes seiner Punkte (senkrecht zur Verbindung mit $Z$).
  + Ein Gelenkpunkt gehört zu zwei Körpern: Seine Geschwindigkeit ist für beide dieselbe. Das verknüpft die Momentanzentren der Nachbarn.
  + Wo man ein $Z$ nicht direkt findet, hilft der Satz der projizierten Geschwindigkeiten für den Betrag.
]

Ein vollständig durchgerechnetes Beispiel mit Abbildung ist die Aufgabe «Gelenkwerk mit einem Freiheitsgrad» am Ende des Kapitels: Dort bilden die Stäbe 1 bis 5 einen einzigen starren Körper, und die übrigen drei Stäbe werden mit Momentanzentren und dem SdpG nacheinander erledigt.

#satz[Parallelogrammregel][
  Vier gelenkig zu einem (nicht entarteten) Parallelogramm verbundene Stäbe haben gegenüberliegend jeweils gleiche Rotationsgeschwindigkeit: $vom_(A B) = vom_(C D)$ und $vom_(B C) = vom_(D A)$. Die Lage der Momentanzentren spielt dabei keine Rolle.
]

#warum[Beweis über die Schliessbedingung][
  Läuft man einmal um das Viereck herum, $A -> B -> C -> D -> A$, so ist man wieder am Ausgangspunkt. Für die Geschwindigkeiten heisst das: Die Relativgeschwindigkeiten längs des Umlaufs summieren sich zu null. Mit der Grundgleichung für jeden Stab,
  $ vv_B - vv_A = omega_1 ve_z times arrow(A B), quad vv_C - vv_B = omega_2 ve_z times arrow(B C), quad dots, $
  ergibt die Summe aller vier Gleichungen
  $ bold(0) = ve_z times (omega_1 arrow(A B) + omega_2 arrow(B C) + omega_3 arrow(C D) + omega_4 arrow(D A)). $
  Im Parallelogramm ist $arrow(C D) = -arrow(A B)$ und $arrow(D A) = -arrow(B C)$, also
  $ bold(0) = (omega_1 - omega_3) thin ve_z times arrow(A B) + (omega_2 - omega_4) thin ve_z times arrow(B C). $
  Die beiden Vektoren $ve_z times arrow(A B)$ und $ve_z times arrow(B C)$ sind nicht parallel (das Parallelogramm ist nicht entartet). Eine Summe zweier nicht paralleler Vektoren verschwindet nur, wenn beide Koeffizienten null sind: $omega_1 = omega_3$ und $omega_2 = omega_4$. $square$

  Anschaulich: Gegenüberliegende Seiten eines Parallelogramms bleiben parallel, also ändern sich ihre Richtungswinkel gleich schnell.
]

Der Spezialfall ist uns schon begegnet: Das Viergelenk mit zwei gleich langen Kurbeln (Abbildung 3.2) ist ein Parallelogramm, dessen vierte Seite das ruhende Gestell mit $omega = 0$ ist. Also hat auch die gegenüberliegende Koppel $A A'$ die Rotationsgeschwindigkeit null: Sie führt eine Translation aus.

#fg("k03_kurbel", [Schubkurbelgetriebe: Kurbel 1 dreht um $O$, der Kolben 2 gleitet geradlinig, die Pleuelstange 3 verbindet beide. $Z_3$ ist ihr Momentanzentrum: Schnittpunkt der Geraden $O B$ (Senkrechte zu $vv_B$) mit der Senkrechten zur Kolbenbahn in $A$. Die Pfeillängen sind massstäblich, $v_A : v_B = overline(Z_3 A) : overline(Z_3 B)$.])

#bsp[Schubkurbelgetriebe][
  Die Kurbel ($O B = r$) dreht mit $omega$ um $O$, der Kolben bewegt sich in einer Geraden durch $O$, die Pleuelstange hat die Länge $l$. Gesucht: die Schnelligkeit des Kolbens als Funktion des Kurbelwinkels $phi$ gegen die Gerade $O A$.

  _Momentanzentren._ Kurbel: $Z_1 = O$. Kolben (Translation): $Z_2$ im Unendlichen. Pleuel: $v_B$ steht senkrecht auf $O B$, also liegt $Z_3$ auf der Geraden $O B$ (verlängert). $v_A$ ist horizontal, also liegt $Z_3$ auch auf der Senkrechten zur Bahn des Kolbens durch $A$. Schnittpunkt: $Z_3$ (rot in der Abbildung).

  _Rechnung mit dem SdpG._ Der Pleuelwinkel $beta$ gegen die Gerade erfüllt $sin beta = (r\/l) sin phi$. Der Einheitsvektor von $A$ nach $B$ ist $(-cos beta, sin beta)$. $vv_A = (v_A, 0)$ hat dort die Projektion $-v_A cos beta$, $vv_B = omega r (-sin phi, cos phi)$ die Projektion $omega r sin(phi + beta)$. Gleichsetzen:
  $ v_A = -omega r (sin(phi + beta)) / (cos beta). $
  Das Minuszeichen sagt: Für kleines positives $phi$ bewegt sich der Kolben auf $O$ zu. Für $phi = 0$ ist $v_A = 0$ (Totpunkt), und für $l >> r$ ist $beta approx 0$ und $|v_A| approx omega r sin phi$.
]

=== Anwendung: Planetengetriebe

Ein Planetengetriebe enthält ein Sonnenrad 1 (Radius $R_1$), ein Hohlrad 2 (Innenradius $R_2$) und dazwischen ein Planetenrad 3 mit Radius $R_3 = (R_2 - R_1)\/2$, das auf beiden abrollt. Das Planetenrad sitzt in einem um $O$ drehbaren Arm der Länge $L = (R_1 + R_2)\/2$. Die Räder 1, 2 drehen mit $omega_1, omega_2$ um $O$; gesucht ist die Rotationsschnelligkeit $omega$ des Arms.

#fg("k03_planet", [Planetengetriebe. Die Berührungspunkte $P$ und $Q$ haben die Geschwindigkeiten der Räder 1 und 2. Weil Rad 3 eben bewegt ist, wachsen die Geschwindigkeiten längs $P Q$ linear; die Mitte $O'$ hat den Mittelwert, und sie ist zugleich Punkt des Arms.])

_Lösung:_ Die Punkte $P$ und $Q$, in denen Rad 3 die Räder 1 und 2 berührt, haben (als Punkte von 1 bzw. 2) die Schnelligkeiten $R_1 omega_1$ bzw. $R_2 omega_2$, senkrecht zum Arm. Weil das Planetenrad abrollt, haben $P$ und $Q$ als Punkte des Planetenrades _dieselben_ Geschwindigkeiten. Die Geschwindigkeit eines ebenen Körpers wächst linear mit dem Abstand vom Momentanzentrum. Der Mittelpunkt $O'$ des Planetenrades liegt genau in der Mitte zwischen $P$ und $Q$, also hat er die mittlere Schnelligkeit
$ v_(O') = (R_1 omega_1 + R_2 omega_2) / 2. $
$O'$ gehört auch zum Arm, der um $O$ mit dem Abstand $L$ dreht, also $v_(O') = omega L$:
$ omega = (R_1 omega_1 + R_2 omega_2) / (R_1 + R_2). $
Die Rotationsschnelligkeit des Planetenrads selbst folgt aus dem Geschwindigkeitsunterschied zwischen $P$ und $Q$ (Abstand $2R_3 = R_2 - R_1$): $omega_3 = (R_2 omega_2 - R_1 omega_1)\/(R_2 - R_1)$.

Spezialfälle (Zahlen für $R_2 = 3 R_1$):
- *Hohlrad fest* ($omega_2 = 0$): $omega = R_1 omega_1\/(R_1 + R_2) = omega_1\/4$. Das ist die übliche, kräftige Untersetzung: Antrieb am Sonnenrad, Abtrieb am Arm.
- *Sonnenrad fest* ($omega_1 = 0$): $omega = R_2 omega_2\/(R_1 + R_2) = 3 omega_2\/4$, eine milde Untersetzung. Allgemein liegt das Verhältnis $R_2\/(R_1 + R_2)$ immer zwischen $1\/2$ und $1$.
- *Arm fest* ($omega = 0$): $omega_2 = -(R_1\/R_2) omega_1 = -omega_1\/3$. Das Hohlrad dreht gegensinnig, das Getriebe arbeitet wie ein gewöhnliches Stirnradgetriebe.

=== Polkegel und Kollergang

Die Begriffe Polbahn lassen sich auf die Kreiselung verallgemeinern. Bei einer Kreiselung um $O$ durchläuft die momentane Rotationsachse im Raum eine Kegelfläche mit Spitze $O$, den *festen Polkegel*, und im Körper eine zweite Kegelfläche, den *beweglichen Polkegel*. Beide Kegel haben in jedem Augenblick die Momentanachse als gemeinsame Mantellinie, deren Punkte die Geschwindigkeit null haben. Die Kreiselung ist also ein Abrollen des beweglichen auf dem festen Polkegel.

Ein Beispiel ist der *Kollergang* (Mühle): Ein Rad mit Radius $R$ rollt auf einer horizontalen Ebene, während sich seine horizontale Achse der Länge $L$ um die senkrechte Achse durch $O$ dreht. Die Momentanachse ist durch die beiden momentan ruhenden Punkte $O$ und den Berührungspunkt $A$ des Rades bestimmt. Die Polkegel sind gerade Kreiskegel. Die momentane Rotation lässt sich in zwei Teile zerlegen: die Drehung des Rades mit $omega_1$ um seine Achse und die Drehung der Achse mit $omega_2$ um die Senkrechte. Weil der Berührungspunkt ruht, müssen sich beide Anteile dort aufheben: $omega_1 R = omega_2 L$.

#fehler[
  - Das Momentanzentrum für einen _festen_ Punkt halten. Es hat nur momentan die Geschwindigkeit null (und im Allgemeinen keineswegs die Beschleunigung null), und es wandert.
  - Bei einem Mechanismus mit mehreren Körpern ein gemeinsames $Z$ suchen. *Jeder* starre Körper hat sein eigenes Momentanzentrum und sein eigenes $omega$.
  - Beim Wechsel des Bezugspunkts $vom$ verändern. $vom$ ist die 1. Invariante und bleibt gleich.
  - In $vom times arrow(B M)$ den Vektor in der falschen Richtung nehmen: Er zeigt vom Bezugspunkt $B$ zum Punkt $M$, dessen Geschwindigkeit gesucht ist.
]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Das rollende Rad.* Der Auflagepunkt eines Rades, das auf der Strasse rollt, steht in diesem Augenblick still: Er ist das Momentanzentrum. Darum kann ein Reifen Kraft auf die Strasse übertragen, ohne zu rutschen. Der oberste Punkt des Rades bewegt sich dagegen doppelt so schnell wie das Auto. Das sieht man auf Fotos mit langer Belichtung: Unten sind die Speichen scharf, oben verschmiert.]

#alltag[*Kurbeltrieb und Getriebe.* In jedem Benzin- und Dieselmotor verwandelt ein Kurbeltrieb die geradlinige Bewegung des Kolbens in eine Drehung der Kurbelwelle. Die Kinematik starrer Körper sagt, wie schnell der Kolben in jeder Stellung ist, und damit, welche Kräfte die Pleuelstange aushalten muss. Ein Planetengetriebe (Automatikgetriebe, Nabenschaltung am Fahrrad, Antrieb von Windkraftanlagen) ist ein Zusammenspiel von Körpern, die gleichzeitig drehen und um einen anderen Körper laufen, genau die Bewegungen, die dieses Kapitel beschreibt.]

#photo(("m_kurbel",), [Kurbelwelle eines Verbrennungsmotors: Die Kolben bewegen sich geradlinig, die Welle dreht sich. Die Kinematik starrer Körper verbindet beide Bewegungen. #credit[Seedlesslime, CC BY-SA 4.0, Wikimedia Commons]], ht: 5cm)
// ALLTAG-END

#aufgaben()

#aufg(fig: "a03_wuerfelrot", fw: 5.8cm)[Würfel, momentane Rotation][
  Ein Würfel (Kantenlänge $a$) führt momentan eine Rotation aus. Bekannt sind
  $ vv_A = (v, 0, -v), quad vv_B = (v_(B x), v, -v), quad vv_E = bold(0) $
  in den Ecken $A(0,0,0)$, $B(a,0,0)$, $E(0,a,0)$. Gesucht sind $v_(B x)$, die Rotationsgeschwindigkeit $vom$ und die Rotationsachse $mu$.
][
  _$v_(B x)$ mit dem SdpG._ $arrow(A B) = (a, 0, 0)$, also $vv_A dot.c arrow(A B) = a v$ und $vv_B dot.c arrow(A B) = a v_(B x)$. Gleichsetzen: $v_(B x) = v$.

  _$vom$._ $E$ ruht, liegt also auf der Achse, und für jeden Punkt $P$ gilt $vv_P = vom times arrow(E P)$. (Achtung: $vv_P = vom times vr_P$ wäre hier falsch, weil der Ursprung nicht auf der Achse liegt.) Mit $arrow(E A) = (0, -a, 0)$:
  $ vom times arrow(E A) = (a omega_z, thick 0, thick -a omega_x) = (v, 0, -v) quad => quad omega_z = omega_x = v\/a. $
  $omega_y$ bleibt hier offen, weil ein Anteil von $vom$ parallel zu $arrow(E A)$ im Kreuzprodukt verschwindet. Mit $arrow(E B) = (a, -a, 0)$:
  $ vom times arrow(E B) = (a omega_z, thick a omega_z, thick -a(omega_x + omega_y)) = (v, v, -v) quad => quad omega_y = 0. $
  Also $vom = (v\/a)(1, 0, 1)$ mit $omega = sqrt(2) v\/a$.

  _Achse._ Sie geht durch $E$ in Richtung $vom$: $mu: thick vr = (0, a, 0) + lambda (1, 0, 1)$. Für $lambda = a$ trifft sie die Ecke $C(a, a, a)$: Die Drehachse ist die Diagonale der Seitenfläche $y = a$.

  _Kontrolle:_ $vv_B = vom times arrow(E B) = (v, v, -v)$ ✓, und $vv_C = bold(0)$, weil $C$ auf der Achse liegt.
]

#aufg(fig: "a03_tetraeder", fw: 5.8cm)[Pyramide, allgemeine Bewegung][
  Eine Pyramide mit der quadratischen Fläche $D(0,0,0)$, $A(a,0,0)$, $B(a,a,0)$, $C(0,a,0)$ und der Spitze $E(a\/2, a\/2, -a)$ gleitet mit der Spitze auf der ruhenden Ebene $z = -a$. Momentan ist
  $ vom = (omega, omega, 0), quad vv_B = (a omega, 0, v_(B z)). $
  Gesucht sind $vv_B$, $vv_E$ und $vv_D$.
][
  _Bindung._ Die Spitze bleibt in der Ebene, also hat $vv_E$ keine $z$-Komponente: $vv_E = (v_(E x), v_(E y), 0)$.

  _Grundgleichung._ $vv_E = vv_B + vom times arrow(B E)$ mit $arrow(B E) = (-a\/2, -a\/2, -a)$ und $vom times arrow(B E) = (-a omega, a omega, 0)$:
  $ (v_(E x), v_(E y), 0) = (a omega - a omega, thick a omega, thick v_(B z)). $
  Also $v_(B z) = 0$, $vv_B = (a omega, 0, 0)$ und $vv_E = (0, a omega, 0)$.

  _Punkt $D$._ $arrow(B D) = (-a, -a, 0)$ ist parallel zu $vom$, das Kreuzprodukt verschwindet: $vv_D = vv_B = (a omega, 0, 0)$. Das ist allgemein so: Punkte auf einer Geraden parallel zu $vom$ haben gleiche Geschwindigkeit.

  _Einordnung._ $vom dot.c vv_B = a omega^2 != 0$: Die 2. Invariante verschwindet nicht, der Bewegungszustand ist eine echte Schraubung.
]

#aufg(fig: "a03_wuerfelallg", fw: 5.8cm)[Würfel, allgemeine Bewegung][
  Von einem Würfel (Kantenlänge $L$, Ecke $B$ im Ursprung) kennt man die Geschwindigkeiten dreier Ecken $P_1(L, L, 0)$, $P_2(0, L, L)$, $P_3(0, 0, L)$:
  $ vv_1 = (-v, 0, 0), quad vv_2 = (0, 0, v), quad vv_3 = (-v, 0, 0). $
  Gesucht sind $vom$ und $vv_B$.
][
  _Richtung von $vom$._ $vv_3 - vv_1 = bold(0) = vom times arrow(P_1 P_3)$ mit $arrow(P_1 P_3) = (-L, -L, L)$. Ein Kreuzprodukt verschwindet nur bei parallelen Vektoren, also $omega_x = omega_y = -omega_z$.

  _Betrag._ $vv_2 - vv_3 = (v, 0, v) = vom times arrow(P_3 P_2)$ mit $arrow(P_3 P_2) = (0, L, 0)$ und $vom times arrow(P_3 P_2) = (-L omega_z, 0, L omega_x)$. Also $omega_x = v\/L$, $omega_z = -v\/L$ und damit
  $ vom = v/L (1, 1, -1). $

  _$vv_B$._ $vv_B = vv_3 + vom times arrow(P_3 B)$ mit $arrow(P_3 B) = (0, 0, -L)$ und $vom times arrow(P_3 B) = (-L omega_y, L omega_x, 0) = (-v, v, 0)$:
  $ vv_B = (-2v, v, 0). $
  Kontrolle mit dem SdpG längs $arrow(B P_3) = (0, 0, L)$: beide Projektionen sind null ✓.
]

#aufg[Zentralachse aus der Kinemate][
  Ein starrer Körper hat im Punkt $B$ die Kinemate $vv_B = (0, 2, 2)$ m/s, $vom = (0, 2, 0)$ s#super[−1]. Gesucht sind die Zentralachse $zeta$ und die Schraube.
][
  _2. Invariante._ $ve_omega = (0, 1, 0)$, also $vv_omega = (vv_B dot.c ve_omega) ve_omega = (0, 2, 0)$ m/s.

  _Punkte der Zentralachse_ haben genau diese Geschwindigkeit. Mit $arrow(B P) = (x, y, z)$ ist $vom times arrow(B P) = (2 z, 0, -2 x)$ und
  $ vv_P = (2 z, thick 2, thick 2 - 2 x) = (0, 2, 0) quad => quad z = 0, quad x = 1 "m", quad y "beliebig". $
  Die Zentralachse ist $zeta: thick arrow(B P) = (1, 0, 0) "m" + lambda (0, 1, 0)$: parallel zu $vom$, um 1 m in $x$-Richtung gegen $B$ versetzt.

  _Kontrolle mit der Formel._ $arrow(B Z) = (vom times vv_B)\/omega^2 = (4, 0, 0)\/4 = (1, 0, 0)$ m ✓.

  _Schraube._ ${vv_omega, vom}$: Drehung mit 2 s#super[−1] um $zeta$, gleichzeitig Vorschub mit 2 m/s längs $zeta$. Die Zentralachse muss kein materieller Teil des Körpers sein, und sie ändert sich im Allgemeinen mit der Zeit.
]

#aufg(fig: "a03_fachwerk", fw: 7cm)[Gelenkwerk mit einem Freiheitsgrad][
  Acht Stäbe sind in den Knoten $A(0,0)$, $C(L,0)$, $D(L,-L)$, $E(2L,-L)$, $F(2L,-2L)$, $B(3L,-2L)$ gelenkig verbunden. $A$ ist fest gelagert, $B$ horizontal geführt und hat momentan die Geschwindigkeit $vv_B = (-v, 0)$.

  Gesucht sind die Rotationsschnelligkeiten und Momentanzentren aller Stäbe sowie $vv_E$. (Positiv = Gegenuhrzeigersinn.)
][
  _Starre Teile erkennen._ Die Dreiecke $A C D$ und $C D E$ teilen sich Stab 3. Die Stäbe 1 bis 5 bilden also einen einzigen starren Körper $K$, der in $A$ gelagert ist: $Z_K = A$. Übrig bleiben die Stäbe 6, 7, 8.

  _Körper $K$._ Mit $omega_K$ ist $vv_E = omega_K ve_z times arrow(A E) = omega_K (L, 2L)$. Der SdpG für Stab 8 mit $arrow(E B) = (L, -L)$ gibt $vv_E dot.c arrow(E B) = -omega_K L^2$ und $vv_B dot.c arrow(E B) = -v L$, also
  $ omega_K = v/L, quad vv_E = (v, 2v), quad |vv_E| = sqrt(5) v, quad vv_D = omega_K ve_z times arrow(A D) = (v, v). $

  _Stab 8._ $vv_B - vv_E = (-2v, -2v) = omega_8 ve_z times arrow(E B) = omega_8 (L, L)$, also $omega_8 = -2v\/L$. $Z_8$ liegt auf der Senkrechten zu $vv_B$ durch $B$ im Abstand $v\/|omega_8| = L\/2$: $Z_8 = (3L, -3L\/2)$.

  _Stäbe 6 und 7._ SdpG für Stab 7 (horizontal): $v_(F x) = -v$. SdpG für Stab 6 mit $arrow(D F) = (L, -L)$: $vv_F dot.c arrow(D F) = vv_D dot.c arrow(D F) = 0$. Zusammen $vv_F = (-v, -v)$. Dann
  $ omega_6 = -(2v)/L quad (Z_6 = "Mitte von" D F), wide omega_7 = v/L quad (Z_7 = (3L, -3L)). $

  _Kontrolle mit der Parallelogrammregel._ $D E B F$ ist ein Parallelogramm. Gegenüberliegende Stäbe drehen gleich: $omega_6 = omega_8$ ✓ und $omega_7 = omega_5 = omega_K$ ✓.
]

#kurz[
  - SdpG: $vv_M dot.c arrow(M N) = vv_N dot.c arrow(M N)$ -- gleiche Anteile längs der Verbindung.
  - Translation: $vv_M = vv_N$. Rotation: $vv = vom times vr$ (Achse fest). Kreiselung: ein Punkt fest, $vom$ darf wandern.
  - Rollen: Berührungspunkt in Ruhe, momentane Rotation um die Berührungsgerade, $v_O = omega R$.
  - Allgemein: $vv_M = vv_B + vom times arrow(B M)$, Kinemate ${vv_B, vom}$. Bezugspunktwechsel: $vv_(B') = vv_B + vom times arrow(B B')$, $vom' = vom$.
  - Invarianten: $vom$ und $vv_omega$ (Anteil längs $vom$). Zentralachse: $arrow(B Z) = (vom times vv_B)\/omega^2$; Schraube ${vv_omega, vom}$.
  - Eben: $vom = dot(phi) ve_z$; Momentanzentrum $Z$ mit $vv_M perp arrow(Z M)$, $|vv_M| = omega overline(Z M)$.
]
