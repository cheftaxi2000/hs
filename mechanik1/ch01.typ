#import "lib.typ": *

= Bewegung eines materiellen Punktes

Bevor wir über Kräfte reden, müssen wir sagen können, _wo_ etwas ist und _wie_ es sich bewegt. Das ist die Aufgabe der Kinematik: reine Geometrie der Bewegung, noch ganz ohne Kräfte. In diesem Kapitel legen wir die Sprache dafür fest.

== Materielles System, Lage, starrer Körper

#defn[Materielles System][
  Ein *materielles System* $S$ ist eine Menge von *materiellen Punkten* $M$. Jeder materielle Punkt wird im Raum durch einen geometrischen Punkt dargestellt, seine *Lage*. Die Lage von $S$ zur Zeit $t$ ist die Menge der Lagen aller seiner Punkte. Besteht $S$ aus einem einzigen, wohldefinierten Gegenstand (Kolben, Balken, Rad), nennt man es *Körper*.
]

Ein materieller Punkt _bewegt sich_, wenn man zu verschiedenen Zeiten $t_1, t_2, dots$ verschiedene geometrische Punkte $M(t_1), M(t_2), dots$ braucht, um ihn darzustellen.

#defn[Starrer Körper][
  Ein Körper $K$ heißt *starr*, wenn die Abstände zwischen je zwei beliebigen Punkten $P, Q in K$ für alle Zeiten konstant bleiben.
]

#intu[
  Ein starrer Körper ist ein Gegenstand, der sich nicht verbiegt, staucht oder dehnt, egal was man mit ihm macht. So etwas gibt es in Wirklichkeit nicht -- aber ein Stahlträger verformt sich unter normaler Last so wenig, dass man die Verformung für die Frage «Wie bewegt er sich?» oder «Welche Kräfte halten ihn?» getrost vergessen darf. Das Modell ist eine bewusste Vereinfachung, kein Fehler.
]

=== Bezugskörper

Lage und Bewegung sind immer _relativ_. «Der Zug fährt mit 100 km/h» heißt: relativ zum Erdboden. Ein Fahrgast, der im Zug sitzt, ruht relativ zum Wagen. Deshalb gilt:

#merke[
  Jede Aussage über Lage oder Bewegung braucht einen *Bezugskörper* $B$. Er muss starr sein. Man denkt ihn sich auf den ganzen Raum ausgedehnt und legt in ihm einen Ursprung $O$ und drei zueinander senkrechte Achsen $x, y, z$ fest, die ein Rechtssystem bilden. Welchen Bezugskörper man wählt (Erdboden, Motorgehäuse, Labortisch), ist eine Frage der Zweckmäßigkeit.
]

Um die Lage eines Punktes im dreidimensionalen Raum festzulegen, braucht man *drei* voneinander unabhängige Zahlen, die *Koordinaten*. Wir verwenden drei Sätze davon. Alle drei beschreiben denselben Punkt -- nur mit einer anderen «Adresse».

== Die drei Koordinatensätze

#fig(15, 5.2, caption: [Derselbe Punkt $M$ in kartesischen, zylindrischen und sphärischen Koordinaten. $M_(x y)$ ist die Projektion von $M$ in die $x y$-Ebene.],
  // kartesisch
  axes3((1.6, 1.3), l: 2.6),
  dl(p3((1.6,1.3),1.6,0,0), p3((1.6,1.3),1.6,2.0,0)), dl(p3((1.6,1.3),0,2.0,0), p3((1.6,1.3),1.6,2.0,0)),
  dl(p3((1.6,1.3),1.6,2.0,0), p3((1.6,1.3),1.6,2.0,2.0)),
  pt(p3((1.6,1.3),1.6,2.0,2.0)), lbl(add(p3((1.6,1.3),1.6,2.0,2.0),(0.25,0.15)), $M$),
  lbl(add(p3((1.6,1.3),0.8,0,0),(-0.25,0.1)), $x$, c: cv), lbl(add(p3((1.6,1.3),1.6,1.0,0),(0,-0.22)), $y$, c: cv), lbl(add(p3((1.6,1.3),1.6,2.0,1.0),(0.2,0)), $z$, c: cv),
  lbl(add(p3((1.6,1.3),1.6,2.0,0),(0.4,-0.15)), $M_(x y)$, size: 8pt),
  lbl((3.1, 0.0), [kartesisch $(x, y, z)$], size: 8.5pt),
  // zylindrisch
  axes3((6.6, 1.3), l: 2.6),
  li((6.6,1.3), p3((6.6,1.3),1.6,2.0,0), s: 0.9pt + cv), dl(p3((6.6,1.3),1.6,2.0,0), p3((6.6,1.3),1.6,2.0,2.0)),
  pt(p3((6.6,1.3),1.6,2.0,2.0)), lbl(add(p3((6.6,1.3),1.6,2.0,2.0),(0.25,0.15)), $M$),
  lbl(add(p3((6.6,1.3),0.8,1.0,0),(0.05,0.2)), $rho$, c: cv), lbl(add(p3((6.6,1.3),1.6,2.0,1.0),(0.2,0)), $z$, c: cv),
  pl((p3((6.6,1.3),0.9,0,0), p3((6.6,1.3),0.95,0.35,0), p3((6.6,1.3),0.8,0.75,0), p3((6.6,1.3),0.6,0.75,0)), s: 0.7pt + cv),
  lbl(add(p3((6.6,1.3),1.15,0.55,0),(0.0,-0.02)), $phi$, c: cv),
  lbl((8.1, 0.0), [zylindrisch $(rho, phi, z)$], size: 8.5pt),
  // sphärisch
  axes3((11.6, 1.3), l: 2.6),
  li((11.6,1.3), p3((11.6,1.3),1.6,2.0,2.0), s: 0.9pt + cv), dl((11.6,1.3), p3((11.6,1.3),1.6,2.0,0)), dl(p3((11.6,1.3),1.6,2.0,0), p3((11.6,1.3),1.6,2.0,2.0)),
  pt(p3((11.6,1.3),1.6,2.0,2.0)), lbl(add(p3((11.6,1.3),1.6,2.0,2.0),(0.25,0.15)), $M$),
  lbl(add(p3((11.6,1.3),0.8,1.0,1.0),(-0.2,0.15)), $r$, c: cv),
  arc((11.6,1.3), 0.9, 90, 56, col: cv, w: 0.7pt), lbl((11.95, 2.45), $theta$, c: cv),
  pl((p3((11.6,1.3),0.9,0,0), p3((11.6,1.3),0.95,0.35,0), p3((11.6,1.3),0.8,0.75,0), p3((11.6,1.3),0.6,0.75,0)), s: 0.7pt + cv),
  lbl(add(p3((11.6,1.3),1.15,0.55,0),(0.0,-0.02)), $psi$, c: cv),
  lbl((13.1, 0.0), [sphärisch $(r, theta, psi)$], size: 8.5pt),
)

=== Kartesische Koordinaten $(x, y, z)$

Man projiziert $M$ senkrecht auf die drei Achsen. Die (vorzeichenbehafteten) Abstände der Projektionen vom Ursprung sind $x, y, z$, jeweils aus $(-oo, oo)$. Die Zuordnung Punkt $<->$ Tripel ist eindeutig.

Kennt man die drei Funktionen
$ x = f_x (t), quad y = f_y (t), quad z = f_z (t) $
für alle $t in [t_1, t_2]$, so kennt man die *Bewegung* von $M$. Dieselben drei Gleichungen sind die Parameterdarstellung einer Kurve: der *Bahnkurve* von $M$.

#bsp[Schwingende Stabspitze][
  $x = 3 cos(3 pi t)$, $y = 4 cos(3 pi t)$, $z = sin(3 pi t)$ (in cm, $t$ in s). Weil $y = 4 x \/ 3$ für alle $t$ gilt, liegt die Bahn in einer vertikalen Ebene. In dieser Ebene ist der horizontale Abstand $sqrt(x^2 + y^2) = 5 |cos(3 pi t)|$ und die Höhe $sin(3 pi t)$: eine Ellipse mit den Halbachsen 5 cm und 1 cm.
]

=== Zylindrische Koordinaten $(rho, phi, z)$

Man projiziert $M$ zuerst in die $x y$-Ebene ($M_(x y)$). Dann ist
- $rho >= 0$ der Abstand $O M_(x y)$ (Abstand von der $z$-Achse),
- $phi$ der Winkel von der $x$-Achse zu $O M_(x y)$, im Bogenmaß, im Gegenuhrzeigersinn positiv,
- $z$ die Höhe wie im kartesischen Fall.

Umrechnung:
$ x = rho cos phi, quad y = rho sin phi, quad z = z wide <=> wide rho = sqrt(x^2 + y^2), quad phi = arctan(y / x). $

#intu[
  Denk an einen runden Turm mit Wendeltreppe. Um einen Punkt zu finden, sagst du: «So weit weg von der Turmachse ($rho$), in diese Himmelsrichtung ($phi$), in dieser Höhe ($z$).» Immer wenn in einer Aufgabe etwas um eine Achse dreht oder rund ist (Welle, Rohr, Rad), sind zylindrische Koordinaten die natürliche Wahl.
]

Bleibt der Punkt in einer Ebene $z = "konst."$, heißen $rho, phi$ *Polarkoordinaten*. Wichtigster Sonderfall ist die *Kreisbewegung*: $rho = R$ ist konstant, die ganze Bewegung steckt in $phi(t)$. Die zurückgelegte Bogenlänge ist $s = R phi$.

=== Sphärische Koordinaten $(r, theta, psi)$

- $r >= 0$ ist der Abstand $O M$,
- $theta$ der Winkel von der $z$-Achse hinunter zu $O M$,
- $psi$ der Winkel von der $x$-Achse zu $O M_(x y)$ (wie $phi$ oben, nur anders benannt).

$ x = r sin theta cos psi, quad y = r sin theta sin psi, quad z = r cos theta. $

#intu[
  Das ist die Adresse auf einem Globus: $psi$ ist die geografische Länge, $theta$ zählt vom Nordpol aus nach unten (also $90° -$ Breite), und $r$ ist der Abstand vom Erdmittelpunkt. Sphärische Koordinaten passen, wenn etwas von einem Punkt ausstrahlt oder sich um einen festen Punkt dreht.
]

=== Koordinatenlinien und Singularitäten

Hält man zwei der drei Koordinaten fest und ändert nur die dritte, läuft der Punkt auf einer *Koordinatenlinie*. Kartesisch sind das drei Geraden. Zylindrisch: ein radialer Strahl ($rho$), ein Kreis um die $z$-Achse ($phi$), eine Parallele zur $z$-Achse ($z$). Sphärisch: ein radialer Strahl ($r$), ein Meridian ($theta$), ein Breitenkreis ($psi$).

In allen drei Fällen stehen die Koordinatenlinien in jedem Punkt senkrecht aufeinander: Die Koordinaten sind *orthogonal*. Kartesische sind _geradlinig_ orthogonal, die anderen beiden _krummlinig_ orthogonal.

Auf der $z$-Achse ($rho = 0$) ist $phi$ nicht bestimmt, im Ursprung sind weder $theta$ noch $psi$ bestimmt. Solche Stellen heißen *Koordinatensingularitäten*. Am Nordpol hat «geografische Länge» keinen Sinn -- genau das ist gemeint.

== Vektorielle Darstellung

Statt drei Zahlen kann man die Lage auch mit einem einzigen Pfeil angeben.

#defn[Ortsvektor][
  Der Vektor $vr := arrow(O M)$ vom Ursprung $O$ des Bezugskörpers zur Lage von $M$ heißt *Ortsvektor*. Die Bewegung ist die Vektorfunktion $t |-> vr(t)$.
]

Der Pfeil selbst hängt nicht davon ab, welche Koordinaten man benutzt. Um mit ihm zu rechnen, zerlegt man ihn in einer *Basis*. Wir nehmen immer drei *orthonormierte* Vektoren (paarweise senkrecht, Länge 1), die tangential zu den Koordinatenlinien im Punkt $M$ liegen:
#gl($ ve_i dot.c ve_i = 1, quad ve_i dot.c ve_j = 0 space (i != j), wide ve_1 = ve_2 times ve_3, quad ve_2 = ve_3 times ve_1, quad ve_3 = ve_1 times ve_2. $)

#block(breakable: false, table(columns: (auto, 1fr, auto), stroke: none, inset: (x: 6pt, y: 5pt), align: (left, left, left),
  table.hline(stroke: 0.6pt),
  [*Basis*], [*Einheitsvektoren*], [*Ortsvektor*],
  table.hline(stroke: 0.3pt),
  [kartesisch], [$ve_x, ve_y, ve_z$ -- überall gleich, zeitlich konstant], [$vr = x ve_x + y ve_y + z ve_z$],
  [zylindrisch], [$ve_rho$ (radial), $ve_phi$ (azimutal), $ve_z$ (axial) -- $ve_rho, ve_phi$ drehen mit $phi$ mit], [$vr = rho ve_rho + z ve_z$],
  [sphärisch], [$ve_r$ (radial), $ve_theta$ (meridional), $ve_psi$ (azimutal) -- alle drei hängen von $theta, psi$ ab], [$vr = r ve_r$],
  table.hline(stroke: 0.6pt),
))

#fig(13, 4.6, caption: [Die zylindrische Basis ist «mitgeführt»: In jedem Punkt zeigt $ve_rho$ von der Achse weg und $ve_phi$ in Drehrichtung. Die kartesische Basis (grau) sieht überall gleich aus.],
  axes((1.2, 0.6), 4.6, 3.6),
  arc((1.2,0.6), 3.0, 0, 90, col: cg, w: 0.4pt, dash: "dashed"),
  // Punkt 1 bei 25°
  li((1.2,0.6), pol((1.2,0.6),3.0,25), s: 0.5pt + cg),
  arr(pol((1.2,0.6),3.0,25), add(pol((1.2,0.6),3.0,25), pol((0,0),0.9,25)), c: cv), arr(pol((1.2,0.6),3.0,25), add(pol((1.2,0.6),3.0,25), pol((0,0),0.9,115)), c: cv),
  pt(pol((1.2,0.6),3.0,25)), lbl(add(pol((1.2,0.6),3.0,25),(1.05,0.2)), $ve_rho$, c: cv), lbl(add(pol((1.2,0.6),3.0,25),(-0.2,1.0)), $ve_phi$, c: cv),
  // Punkt 2 bei 65°
  li((1.2,0.6), pol((1.2,0.6),3.0,65), s: 0.5pt + cg),
  arr(pol((1.2,0.6),3.0,65), add(pol((1.2,0.6),3.0,65), pol((0,0),0.9,65)), c: cv), arr(pol((1.2,0.6),3.0,65), add(pol((1.2,0.6),3.0,65), pol((0,0),0.9,155)), c: cv),
  pt(pol((1.2,0.6),3.0,65)), lbl(add(pol((1.2,0.6),3.0,65),(0.65,0.95)), $ve_rho$, c: cv), lbl(add(pol((1.2,0.6),3.0,65),(-1.0,0.25)), $ve_phi$, c: cv),
  arc((1.2,0.6), 0.8, 0, 25, w: 0.5pt), lbl((2.25, 0.8), $phi$),
  // kartesisch rechts
  axes((8.2, 0.6), 4.2, 3.6),
  ..((9.4,1.4),(11.0,1.2),(10.2,2.8)).map(q => arr(q, add(q,(0.8,0)), c: cg)), ..((9.4,1.4),(11.0,1.2),(10.2,2.8)).map(q => arr(q, add(q,(0,0.8)), c: cg)),
  ..((9.4,1.4),(11.0,1.2),(10.2,2.8)).map(q => pt(q)),
  lbl((11.2, 2.75), $ve_x$, c: cg), lbl((10.0, 3.75), $ve_y$, c: cg),
)

#merke[
  In $vr = rho ve_rho + z ve_z$ fehlt $phi$ nur scheinbar: Der Winkel steckt in der _Richtung_ von $ve_rho$. Genauso stecken $theta$ und $psi$ in $ve_r$. Das wird im nächsten Kapitel entscheidend: Beim Ableiten nach der Zeit muss man diese Einheitsvektoren *mit ableiten*, weil sie sich mit dem Punkt mitdrehen.
]

#kurz[
  - Bewegung ist immer relativ zu einem starren *Bezugskörper* mit Achsen $O x y z$.
  - Drei Zahlen legen einen Punkt fest: $(x,y,z)$, $(rho, phi, z)$ oder $(r, theta, psi)$.
  - Ortsvektor: $vr = x ve_x + y ve_y + z ve_z = rho ve_rho + z ve_z = r ve_r$.
  - Kartesische Einheitsvektoren sind konstant; zylindrische und sphärische drehen mit dem Punkt mit.
  - Wahl der Koordinaten nach der Geometrie des Problems: gerade $->$ kartesisch, Drehung um eine Achse $->$ zylindrisch, Drehung um einen Punkt $->$ sphärisch.
]
