#import "lib.typ": *

= Kinematik starrer Körper

Ein starrer Körper besteht aus unendlich vielen Punkten. Müssten wir für jeden einzeln die Geschwindigkeit angeben, wären wir nie fertig. Die gute Nachricht dieses Kapitels: Weil alle Abstände fest sind, genügen *zwei Vektoren*, um die Geschwindigkeit _jedes_ Punktes zu kennen. Dahin arbeiten wir uns in vier Schritten vor: ein Grundsatz, drei Spezialbewegungen, der allgemeine Fall, und schließlich der für Aufgaben wichtigste Fall, die ebene Bewegung.

== Satz der projizierten Geschwindigkeiten

#satz[Satz der projizierten Geschwindigkeiten (SdpG)][
  Die Geschwindigkeiten $vv_M, vv_N$ zweier beliebiger Punkte $M, N$ eines starren Körpers haben zu jeder Zeit gleiche Projektionen auf ihre Verbindungsgerade $M N$:
  #gl($ vv_M dot.c arrow(M N) = vv_N dot.c arrow(M N). $)
  Umgekehrt: Gilt das für alle Punktepaare und alle Zeiten, so ist der Körper starr.
]

#fig(13, 4.2, caption: [Links: Die Anteile $v'_M$ und $v'_N$ längs $M N$ sind gleich; quer dazu dürfen sich die Geschwindigkeiten beliebig unterscheiden. Rechts: Ein Stab, dessen Enden an Boden und Wand geführt sind.],
  pl(((0.5,1.0),(1.4,0.4),(4.6,0.7),(5.6,1.8),(5.0,3.3),(2.2,3.6),(0.7,2.6)), fill: cl, s: 0.5pt + cg, close: true),
  li((1.5,1.5),(4.6,2.5), s: 0.5pt + cg, dash: "dashed"),
  arr((1.5,1.5),(2.3,2.9), c: cv, w: 1.1pt), arr((4.6,2.5),(6.2,2.25), c: cv, w: 1.1pt),
  arr((1.5,1.5),(2.63,1.865), c: cm, w: 1.4pt), arr((4.6,2.5),(5.73,2.865), c: cm, w: 1.4pt),
  dl((2.3,2.9),(2.63,1.865)), dl((6.2,2.25),(5.73,2.865)),
  pt((1.5,1.5)), pt((4.6,2.5)), lbl((1.25,1.3), $M$), lbl((4.5,2.2), $N$),
  lbl((2.0,3.1), $vv_M$, c: cv), lbl((6.45,2.1), $vv_N$, c: cv), lbl((2.45,1.5), $v'_M$, c: cm, size: 8pt), lbl((5.3,3.05), $v'_N$, c: cm, size: 8pt),
  // Stab
  hatch((8.2,0.6),(12.6,0.6)), hatch((8.2,4.0),(8.2,0.6)),
  beam((11.4,0.6),(8.2,3.3)), pt((11.4,0.6), r: 0.07), pt((8.2,3.3), r: 0.07),
  arr((11.4,0.6),(12.5,0.6), c: cv, w: 1.2pt), arr((8.2,3.3),(8.2,2.0), c: cv, w: 1.2pt),
  arc((11.4,0.6), 0.8, 139.8, 180, w: 0.5pt), lbl((10.85,0.85), $alpha$, size: 8pt),
  lbl((11.5,0.95), $A$), lbl((8.5,3.5), $B$), lbl((12.4,0.95), $vv_A$, c: cv), lbl((8.6,2.3), $vv_B$, c: cv),
)

#intu[
  Stell dir zwischen $M$ und $N$ eine starre Stange vor. Würde $M$ längs der Stange schneller laufen als $N$, müsste die Stange kürzer oder länger werden. Das darf sie nicht. Also müssen beide Punkte längs der Stange gleich schnell sein. Quer zur Stange ist alles erlaubt -- das ist dann Drehung.
]

Der Beweis ist eine Zeile: Mit $va := arrow(M N) = vr_N - vr_M$ ist $va dot.c va = "konst."$, abgeleitet $2 va dot.c dot(va) = 0$ und $dot(va) = vv_N - vv_M$.

#bsp[Stab an Wand und Boden][
  $A$ gleitet mit Schnelligkeit $v$ nach rechts, der Stab schließt mit dem Boden den Winkel $alpha$ ein (Abb. rechts). Projektion von $vv_A$ auf den Stab: $v cos alpha$. Projektion von $vv_B$ (vertikal, Betrag $v_B$) auf den Stab: $v_B sin alpha$. Gleichsetzen: $v_B = v cot alpha$. Liegt der Stab fast am Boden ($alpha -> 0$), wird $B$ beliebig schnell; steht er fast senkrecht, bewegt sich $B$ kaum.
]

== Drei Grundbewegungen

#table(columns: (auto, 1fr, 1.15fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.6pt),
  [*Bewegung*], [*Definition*], [*Geschwindigkeitsverteilung*],
  table.hline(stroke: 0.3pt),
  [Translation], [Jeder Verbindungsvektor $arrow(M N)$ behält Betrag _und_ Richtung.], [$vv_M = vv_N$ für alle Punkte: örtlich konstant.],
  [Rotation], [Zwei Punkte $A, B$ (und damit die ganze *Rotationsachse* $A B$) bleiben in Ruhe.], [$vv = vom times vr$, $vr$ von einem Achsenpunkt aus. $vom$ liegt fest auf der Achse.],
  [Kreiselung], [Ein Punkt $O$ bleibt in Ruhe.], [$vv = vom times vr$, $vr$ von $O$ aus. Die Richtung von $vom$ darf sich ändern.],
  table.hline(stroke: 0.6pt),
)

=== Translation

Alle Bahnkurven sind kongruent, der Körper verschiebt sich parallel zu sich selbst. Wichtig: Translation heißt *nicht* «geradlinig». Die Gondel eines Riesenrads bleibt immer aufrecht; jeder ihrer Punkte läuft auf einem Kreis, aber alle Kreise sind gleich groß und nur gegeneinander verschoben. Das ist eine _kreisförmige Translation_.

Gilt $vv_M = vv_N$ nur in einem Augenblick $t_0$, spricht man von *momentaner Translation*.

=== Rotation

Jeder Punkt außerhalb der Achse läuft auf einem Kreis senkrecht zur Achse, und alle drehen um denselben Winkel $Phi(t)$. Also haben alle dieselbe Winkelgeschwindigkeit
#gl($ vom = dot(Phi) ve_z = omega ve_z, wide vv(vr, t) = vom(t) times vr. $)
$vom$ heißt *Rotationsgeschwindigkeit*, $omega$ *Rotationsschnelligkeit*. Bei Drehzahl $n$ in Umdrehungen pro Minute ist $omega = 2 pi n \/ 60$ (in rad/s).

#fig(13, 3.9, caption: [Translation: alle Pfeile gleich. Rotation: Die Schnelligkeit wächst linear mit dem Abstand von der Achse, $|vv| = omega r$, und $vv$ steht senkrecht auf dem Radius.],
  rct((0.6,0.9),(4.4,2.9)),
  ..((1.2,1.4),(2.5,1.4),(3.8,1.4),(1.2,2.4),(2.5,2.4),(3.8,2.4)).map(q => arr(q, add(q,(0.75,0.45)), c: cv)),
  lbl((2.5,0.45), [Translation], size: 8.5pt),
  circ((9.4,1.95), 1.7, fill: cl), pt((9.4,1.95)),
  li((9.4,1.95),(11.1,1.95), s: 0.5pt + cg),
  ..(0.55,1.1,1.7).map(r => arr((9.4 + r,1.95),(9.4 + r,1.95 + 0.75 * r), c: cv)),
  dl((9.4,1.95),(11.1,3.225)),
  ..(120,210,300).map(a => arr(pol((9.4,1.95),1.7,a), add(pol((9.4,1.95),1.7,a), pol((0,0),1.275,a + 90)), c: cv)),
  arc((9.4,1.95), 0.35, 20, 320, col: cm, head: true, hs: 0.12), lbl((8.85,1.55), $vom$, c: cm, size: 8pt),
  lbl((9.4,-0.05), [Rotation (Blick längs der Achse)], size: 8.5pt),
)

Die Verteilung $vv = vom times vr$ ist in $vr$ *linear*: doppelter Abstand, doppelte Schnelligkeit. Gilt sie nur in einem Augenblick, liegt eine *momentane Rotation* vor.

=== Rollen: das wichtigste Beispiel einer momentanen Rotation

#defn[Rollen und Gleiten][
  Ein Körper *rollt* auf einem ruhenden Körper, wenn seine materiellen Berührungspunkte momentan in Ruhe sind. Haben sie eine (tangentiale) Geschwindigkeit, so *gleitet* er.
]

#fig(13, 4.3, caption: [Rollendes Rad. Links die wirklichen Geschwindigkeiten: Alle stehen senkrecht auf der Verbindung zum Berührungspunkt $Z$ und wachsen mit dem Abstand von $Z$. Rechts dieselbe Verteilung zerlegt in Translation der Nabe plus Drehung um die Nabe.],
  hatch((0.3,0.5),(5.0,0.5)),
  circ((2.6,2.0), 1.5), pt((2.6,2.0)), pt((2.6,0.5), r: 0.07, c: cf),
  arr((2.6,2.0),(3.7,2.0), c: cv, w: 1.1pt), arr((2.6,3.5),(4.8,3.5), c: cv, w: 1.1pt),
  arr((1.1,2.0),(2.2,3.1), c: cv, w: 1.1pt), arr((4.1,2.0),(5.2,0.9), c: cv, w: 1.1pt),
  dl((2.6,0.5),(4.8,3.5)), dl((2.6,0.5),(2.6,3.5)),
  lbl((2.35,2.15), $O$), lbl((2.6,0.2), $Z$, c: cf), lbl((3.75,2.3), $v$, c: cv), lbl((4.6,3.8), $2 v$, c: cv),
  // zerlegt
  hatch((6.3,0.5),(12.8,0.5)),
  circ((7.8,2.0), 1.3, s: 0.5pt + cg), circ((11.2,2.0), 1.3, s: 0.5pt + cg), lbl((9.5,2.0), $+$, size: 12pt),
  ..((7.8,2.0),(7.8,3.3),(7.8,0.7)).map(q => arr(q, add(q,(0.9,0)), c: cv)),
  arr((11.2,3.3),(12.1,3.3), c: cv), arr((11.2,0.7),(10.3,0.7), c: cv), pt((11.2,2.0)),
  arc((11.2,2.0), 0.4, 160, -140, col: cm, head: true, hs: 0.12),
  lbl((7.8,3.75), [Translation $vv_O$], size: 8pt), lbl((11.2,3.75), [Drehung $omega R$ um $O$], size: 8pt),
)

#intu[
  Unten, im Berührungspunkt, heben sich «vorwärts mit der Nabe» und «rückwärts durch die Drehung» genau auf. Deshalb steht der Punkt für einen Augenblick still, und deshalb sieht man auf Fotos von fahrenden Rädern die Speichen unten scharf und oben verwischt. Oben addieren sich beide Anteile zu $2 v$. Die Rollbedingung lautet $v_O = omega R$.
]

=== Kreiselung

Bleibt nur ein einziger Punkt $O$ fest, läuft jeder Punkt auf einer Kugel um $O$. Zu jedem Zeitpunkt gibt es trotzdem eine Gerade durch $O$, deren Punkte momentan ruhen: die *momentane Rotationsachse*. Die Geschwindigkeitsverteilung ist wieder $vv = vom times vr$ mit
#gl($ vom = omega ve_mu, $)
nur dass die Achsrichtung $ve_mu$ jetzt mit der Zeit wandern darf (Spielzeugkreisel, dessen Achse taumelt). $omega$ ist dann nicht mehr die Ableitung eines einzelnen Winkels.

== Die allgemeinste Bewegung: Kinemate

Wähle irgendeinen Punkt $B$ des Körpers als *Bezugspunkt*. Ein Beobachter, der mit $B$ mitfliegt (ohne sich zu drehen), sieht $B$ in Ruhe -- für ihn macht der Körper eine Kreiselung um $B$. Für uns kommt die Geschwindigkeit von $B$ dazu:

#satz[Grundgleichung des Bewegungszustandes][
  #gl($ vv_M = vv_B + vom times arrow(B M) wide "für alle" B, M in K. $)
  Das Vektorpaar ${vv_B, vom}$ heißt *Kinemate in $B$*. Sie legt die Geschwindigkeit jedes Punktes des starren Körpers fest.
]

#fig(12, 4.3, caption: [Geschwindigkeit von $M$ = Geschwindigkeit des Bezugspunkts $B$ (Translationsanteil) + Drehanteil $vom times arrow(B M)$, der senkrecht auf $arrow(B M)$ steht.],
  pl(((0.8,0.9),(2.6,0.4),(6.4,0.8),(7.4,2.2),(6.4,3.7),(3.0,3.8),(1.0,2.8)), fill: cl, s: 0.5pt + cg, close: true),
  li((2.2,1.6),(5.6,2.6), s: 0.5pt + cg),
  arr((2.2,1.6),(3.5,1.9), c: cv, w: 1.1pt), arr((5.6,2.6),(6.9,2.9), c: cv, w: 0.8pt, dash: "dashed"),
  arr((6.9,2.9),(6.55,4.09), c: cm, w: 1.1pt), arr((5.6,2.6),(6.55,4.09), c: cv, w: 1.4pt),
  pt((2.2,1.6)), pt((5.6,2.6)), lbl((1.95,1.4), $B$), lbl((5.55,2.3), $M$),
  lbl((3.2,2.15), $vv_B$, c: cv), lbl((6.6,2.55), $vv_B$, c: cv, size: 8pt), lbl((7.65,3.6), $vom times arrow(B M)$, c: cm, size: 8pt), lbl((5.7,3.6), $vv_M$, c: cv),
  arc((2.2,1.6), 0.4, 60, 330, col: cm, head: true, hs: 0.12), lbl((1.75,2.2), $vom$, c: cm, size: 8pt),
  lbl((10.0,2.9), [$vom = bold(0)$: Translation], size: 8.5pt), lbl((10.0,2.3), [$vv_B = bold(0)$: Kreiselung um $B$], size: 8.5pt), lbl((10.0,1.7), [sonst: beides überlagert], size: 8.5pt),
)

=== Was hängt vom Bezugspunkt ab?

Derselbe Bewegungszustand lässt sich mit jedem Bezugspunkt beschreiben. Wechselt man von $B$ zu $B'$, so gilt:
#gl($ vv_(B') = vv_B + vom times arrow(B B'), wide vom' = vom. $)

#merke[
  - Die *Rotationsgeschwindigkeit $vom$* ist für alle Bezugspunkte gleich. Sie gehört zum Körper, nicht zu einem Punkt. Das ist die *1. Invariante*.
  - Die Translationsgeschwindigkeit $vv_B$ ändert sich mit dem Bezugspunkt -- aber nur ihr Anteil senkrecht zu $vom$. Der Anteil *in Richtung von $vom$* ist überall gleich: die *2. Invariante* $vv_omega$. Das folgt aus $vom dot.c vv_M = vom dot.c vv_B$ (das Skalarprodukt mit $vom$ löscht den Kreuzproduktterm).
]

=== Zentralachse und Schraube

Wenn der Anteil senkrecht zu $vom$ vom Bezugspunkt abhängt: Gibt es einen Punkt, in dem er verschwindet? Ja.

#defn[Zentralachse, Schraube][
  Die *Zentralachse* $zeta$ ist die Menge aller Punkte $Z$, deren Geschwindigkeit parallel zu $vom$ ist. Sie ist eine Gerade parallel zu $vom$. Die Kinemate in ihren Punkten, ${vv_Z = vv_omega, vom}$, besteht nur aus den beiden Invarianten und heißt *Schraube*.
]

Von einem beliebigen Bezugspunkt $B$ aus findet man die Zentralachse so: Zerlege $vv_B$ in $vv_omega$ (parallel zu $vom$) und $(vv_B)_perp$ (senkrecht dazu). Dann liegt $Z$ senkrecht zu beiden im Abstand
#gl($ d_Z = (|(vv_B)_perp|) / omega, wide "kompakt:" quad arrow(B Z) = (vom times vv_B) / omega^2. $)

#satz[Allgemeinste Bewegung][
  Der Bewegungszustand eines starren Körpers ist in jedem Augenblick eine *momentane Schraubung*: Drehung mit $vom$ um die Zentralachse und gleichzeitig Verschiebung mit $vv_omega$ längs dieser Achse.
]

#intu[
  Denk an eine Schraube, die du in ein Brett drehst, oder an einen Korkenzieher: Sie dreht sich um ihre Achse und wandert gleichzeitig entlang dieser Achse. Die Aussage des Satzes ist verblüffend stark: _Jede_ noch so wilde Bewegung eines starren Körpers sieht in jedem einzelnen Augenblick so aus -- man muss nur die richtige Achse finden.
]

Die Schraube degeneriert, wenn $vom dot.c vv_B = 0$ ist:

#table(columns: (auto, 1fr), stroke: none, inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 0.6pt),
  [$vom = bold(0)$], [momentane *Translation*; die Zentralachse «wandert ins Unendliche».],
  [$vv_B = bold(0)$], [momentane *Rotation* um die Achse durch $B$ in Richtung $vom$.],
  [$vv_B perp vom$, beide $!= bold(0)$], [ebenfalls momentane *Rotation*, aber um eine Achse, die nicht durch $B$ geht. Das ist der Fall der ebenen Bewegung.],
  table.hline(stroke: 0.6pt),
)

#bsp[Kinemate und Zentralachse aus drei Punkten][
  Gegeben $A(a,0,0)$, $B(0,a,0)$, $C(0,0,a)$ mit $vv_A = (-v, v, -v)$, $vv_B = (-v, v, 0)$, $vv_C = (-v, 0, -v)$.

  _Schritt 1 -- Kontrolle mit dem SdpG_, z.~B. für $A, B$: $arrow(A B) = (-a, a, 0)$, $vv_A dot.c arrow(A B) = 2 a v = vv_B dot.c arrow(A B)$ ✓.

  _Schritt 2 -- $vom$ bestimmen_ aus $vv_A = vv_B + vom times arrow(B A)$ und $vv_C = vv_B + vom times arrow(B C)$. Komponentenweise ergibt sich $vom = (v \/ a, 0, 0)$.

  _Schritt 3 -- Invarianten:_ $vv_omega = -v ve_x$ (Anteil von $vv_B$ längs $vom$), $(vv_B)_perp = v ve_y$.

  _Schritt 4 -- Zentralachse:_ $arrow(B Z) = (vom times vv_B) \/ omega^2 = (0, 0, a)$, also $Z(0, a, a)$. Die Zentralachse ist die Parallele zur $x$-Achse durch $Z$; der Körper schraubt sich mit $omega = v\/a$ um sie und gleitet dabei mit $v$ in negativer $x$-Richtung.
]

== Ebene Bewegung und Momentanzentrum

#defn[Ebene Bewegung][
  Die Bewegung eines starren Körpers heißt *eben*, wenn die Bahnkurven aller Punkte eben sind und in parallelen Ebenen liegen.
]

Es genügt dann, einen Schnitt des Körpers in einer dieser Ebenen (der $x y$-Ebene) zu betrachten. Seine Lage ist durch drei Zahlen festgelegt: $x_B, y_B$ eines Punktes und einen Drehwinkel $phi$. Für die Kinemate folgt
#gl($ vom = dot(phi) ve_z, wide vv_B perp vom. $)
$vom$ steht immer senkrecht auf der Bewegungsebene. Damit sind wir automatisch im dritten Spezialfall oben: Die 2. Invariante verschwindet, die Zentralachse wird zur momentanen Drehachse und durchstößt die Ebene in einem Punkt.

#satz[Satz vom Momentanzentrum][
  Bei jeder ebenen Bewegung mit $vom != bold(0)$ gibt es genau einen momentan ruhenden Punkt $Z$ (des in Gedanken auf die ganze Ebene ausgedehnten Körpers), das *Momentanzentrum*. Der Körper dreht sich momentan um $Z$: Für jeden Punkt $M$ ist
  #gl($ vv_M perp arrow(Z M), wide |vv_M| = omega dot.c overline(Z M). $)
]

#fig(13.4, 5.0, caption: [Links: Konstruktion von $Z$ als Schnittpunkt der Senkrechten zu zwei bekannten Geschwindigkeitsrichtungen. Rechts: Beim geführten Stab liegt $Z$ in der Ecke des Rechtecks über $A$ und $B$.],
  pl(((0.6,0.8),(3.4,0.5),(5.2,1.6),(4.6,3.2),(1.8,3.4),(0.5,2.3)), fill: cl, s: 0.5pt + cg, close: true),
  pt((1.5,1.3)), pt((4.2,2.5)),
  arr((1.5,1.3),(2.6,0.75), c: cv, w: 1.1pt), arr((4.2,2.5),(4.9,3.55), c: cv, w: 1.1pt),
  dl((1.5,1.3),(3.0,4.3), c: cf), dl((4.2,2.5),(2.25,3.8), c: cf),
  pt((2.71,3.72), r: 0.07, c: cf), lbl((2.45,4.0), $Z$, c: cf),
  lbl((1.25,1.1), $P$), lbl((4.45,2.3), $Q$), lbl((2.7,0.5), $vv_P$, c: cv), lbl((5.2,3.5), $vv_Q$, c: cv),
  arc((2.71,3.72), 0.45, 200, 340, col: cm, head: true, hs: 0.12), lbl((2.75,3.0), $vom$, c: cm, size: 8pt),
  // Stab
  hatch((7.6,0.6),(13.0,0.6)), hatch((7.6,4.8),(7.6,0.6)),
  beam((11.4,0.6),(7.6,3.6)), pt((11.4,0.6), r: 0.07), pt((7.6,3.6), r: 0.07),
  arr((11.4,0.6),(12.6,0.6), c: cv, w: 1.2pt), arr((7.6,3.6),(7.6,2.2), c: cv, w: 1.2pt),
  dl((11.4,0.6),(11.4,3.6), c: cf), dl((7.6,3.6),(11.4,3.6), c: cf),
  pt((11.4,3.6), r: 0.07, c: cf), lbl((11.7,3.8), $Z$, c: cf),
  lbl((11.5,0.25), $A$), lbl((7.95,3.85), $B$), lbl((12.5,0.95), $vv_A$, c: cv), lbl((8.0,2.5), $vv_B$, c: cv),
  arc((11.4,0.6), 0.8, 141.7, 180, w: 0.5pt), lbl((10.85,0.85), $alpha$, size: 8pt),
  lbl((11.95,2.1), $L sin alpha$, c: cg, size: 8pt), lbl((9.5,3.85), $L cos alpha$, c: cg, size: 8pt),
  arc((11.4,3.6), 0.45, 190, 260, col: cm, head: true, hs: 0.12),
)

#rezept[Momentanzentrum finden][
  + Kennst du die *Richtungen* der Geschwindigkeit in zwei Punkten $P, Q$: Zeichne in jedem die Senkrechte zur Geschwindigkeit. Der Schnittpunkt ist $Z$.
  + Sind die beiden Senkrechten *parallel* (und verschieden): momentane Translation, $Z$ liegt im Unendlichen, $omega = 0$.
  + *Fallen* die Senkrechten *zusammen*: $Z$ liegt auf dieser Geraden; seine Lage folgt aus den Beträgen (Strahlensatz, $|vv| prop$ Abstand).
  + Rollt der Körper auf einer ruhenden Unterlage: $Z$ ist der Berührungspunkt.
  + Ist ein Punkt des Körpers gelenkig an einem ruhenden Lager befestigt: $Z$ ist dieser Punkt.
  + Dann $omega = |vv_P| \/ overline(Z P)$, und jede weitere Geschwindigkeit folgt aus $|vv_M| = omega overline(Z M)$, senkrecht zu $Z M$, Drehsinn wie $vom$.
]

#bsp[Stab an Wand und Boden, zweiter Blick][
  $vv_A$ ist horizontal, die Senkrechte in $A$ also vertikal. $vv_B$ ist vertikal, die Senkrechte in $B$ also horizontal. $Z$ ist die vierte Ecke des Rechtecks. Aus $v = omega dot.c overline(Z A) = omega L sin alpha$ folgt $omega = v \/ (L sin alpha)$ und $v_B = omega dot.c overline(Z B) = omega L cos alpha = v cot alpha$ -- dasselbe wie mit dem SdpG, aber man bekommt $omega$ gleich mit.
]

#bsp[Planetengetriebe][
  Zwei koaxiale Räder (Radien $R_1 < R_2$, Rotationsschnelligkeiten $omega_1, omega_2$) drehen um $O$; dazwischen rollt ein Planetenrad auf beiden ab, gehalten von einem Arm der Länge $L = (R_1 + R_2) \/ 2$. Die Berührungspunkte $P, Q$ des Planetenrads haben die Schnelligkeiten $R_1 omega_1$ und $R_2 omega_2$ (Rollen: gleiche Geschwindigkeit wie der Partner). Der Mittelpunkt des Planetenrads liegt in der Mitte zwischen $P$ und $Q$, hat also die Schnelligkeit $(R_1 omega_1 + R_2 omega_2) \/ 2$ -- die Verteilung ist linear. Geteilt durch $L$ ergibt sich die Rotationsschnelligkeit des Arms:
  $ omega = (R_1 omega_1 + R_2 omega_2) / (R_1 + R_2). $
]

=== Polbahnen

$Z$ ist nur _momentan_ in Ruhe; im nächsten Augenblick ist ein anderer Punkt Momentanzentrum. Die Spur von $Z$ im ruhenden Bezugssystem heißt *feste Polbahn*, die Spur von $Z$ aus Sicht eines mit dem Körper mitbewegten Beobachters *bewegliche Polbahn*. Beide berühren sich in $Z$, und die bewegliche Polbahn *rollt* auf der festen ab.

Beim rollenden Rad ist die feste Polbahn die Straße und die bewegliche der Radumfang. Beim geführten Stab ist $overline(O Z) = L$ (Diagonale des Rechtecks): Die feste Polbahn ist ein Kreis um $O$ mit Radius $L$, die bewegliche ein Kreis mit Durchmesser $A B$, also Radius $L\/2$. Man kann die Stabbewegung erzeugen, indem man den kleinen Kreis im großen abrollen lässt.

=== Mehrere Drehungen übereinander

Dreht ein Körper mit $vom_2$ relativ zu einem Träger, der selbst mit $vom_1$ dreht, und schneiden sich die beiden Achsen, so ist seine Rotationsgeschwindigkeit die Vektorsumme $vom = vom_1 + vom_2$ (Parallelogrammregel). Rotationsgeschwindigkeiten addieren sich wie gewöhnliche Vektoren.

#fehler[
  - Das Momentanzentrum für einen festen Punkt halten. Es hat momentan die Geschwindigkeit null, aber im Allgemeinen _nicht_ die Beschleunigung null, und es wandert.
  - Bei mehreren Körpern (Mechanismus) ein gemeinsames $Z$ suchen. *Jeder* starre Körper hat sein eigenes Momentanzentrum und sein eigenes $omega$.
  - $vom times arrow(B M)$ mit dem Vektor vom falschen Punkt aus bilden. Der Vektor zeigt vom Bezugspunkt $B$ zum Punkt $M$, dessen Geschwindigkeit gesucht ist.
]

#kurz[
  - SdpG: $vv_M dot.c arrow(M N) = vv_N dot.c arrow(M N)$ -- gleiche Geschwindigkeitsanteile längs der Verbindung.
  - Grundgleichung: $vv_M = vv_B + vom times arrow(B M)$. Kinemate ${vv_B, vom}$.
  - Invarianten: $vom$ (überall gleich) und $vv_omega$ (Anteil der Geschwindigkeit längs $vom$).
  - Zentralachse: $arrow(B Z) = (vom times vv_B) \/ omega^2$; dort Schraube ${vv_omega, vom}$.
  - Eben: $vom = dot(phi) ve_z$, Momentanzentrum $Z$ mit $vv_M perp arrow(Z M)$ und $|vv_M| = omega overline(Z M)$.
  - Rollen: Berührungspunkt ist Momentanzentrum, $v_O = omega R$.
]
