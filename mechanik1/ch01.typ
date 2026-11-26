#import "lib.typ": *

= Bewegung eines materiellen Punktes

#woche(1, [Bewegung materieller Punkt], [10–24])

Mechanik beginnt mit einer einfachen Frage: _Wo ist etwas, und wie ändert sich das?_ Bevor wir irgendeine Kraft anschauen, brauchen wir eine saubere Sprache, um Lage und Bewegung zu beschreiben. Dieses Teilgebiet nennt man *Kinematik*: reine Geometrie der Bewegung, ganz ohne Ursachen.

Dieses Kapitel legt die Begriffe fest (System, Körper, Bezugskörper) und führt die Koordinaten ein, mit denen wir ab jetzt jeden Punkt adressieren. Es ist eher «Vokabeln lernen» als «Rechnen», aber alles Spätere baut darauf auf.

== Systeme, Lagen und starre Körper

Die Mechanik arbeitet mit Modellen. Ein Modell lässt weg, was für die Frage unwichtig ist, und behält, was zählt. Das erste Modell ist das *materielle System*.

#defn[Materielles System][
  Ein *materielles System* $S$ ist eine Menge von *materiellen Punkten* $M$. Jeder materielle Punkt wird im Raum durch einen geometrischen Punkt dargestellt, seine *Lage*. Die Lage des Systems zur Zeit $t$ ist die Menge der Lagen all seiner Punkte.
]

Das Wort «System» ist bewusst unspezifisch. Eine ganze Turbine, ein Wassertropfen, eine Brücke oder ein Felsbrocken kann ein System sein. Besteht $S$ aus einem einzigen wohldefinierten Gegenstand (Kolben, Balken, Rad), sagt man auch *Körper*.

#fg("k01_lage", [Ein materielles System $S$ zu zwei Zeiten, und die Bahnkurve eines seiner Punkte $M$. Verschiedene Lagen $M(t_1) eq.not M(t_2)$ bedeuten: Der Punkt hat sich bewegt.])

Ein materieller Punkt *bewegt sich*, wenn man zu verschiedenen Zeiten $t_1, t_2, dots$ verschiedene geometrische Punkte $M(t_1), M(t_2), dots$ braucht, um ihn darzustellen. Die Menge all dieser Punkte ist seine *Bahnkurve*.

=== Der starre Körper

Ein Körper, dessen Punkte sich beliebig gegeneinander verschieben dürfen, ist schwer zu beschreiben: Man müsste jeden Punkt einzeln verfolgen. Wir vereinfachen so weit wie möglich.

#defn[Starrer Körper][
  Ein Körper $K$ heisst *starr*, wenn die Abstände zwischen je zwei beliebigen Punkten $P, Q in K$ für alle Zeiten konstant bleiben.
]

#intu[
  Stell dir einen Stahlträger vor, den du anhebst und wegträgst. Er biegt sich dabei um Bruchteile eines Millimeters durch -- für die Frage «Wohin bewegt er sich?» ist das völlig bedeutungslos. Der starre Körper ist die Idealisierung, die diese winzigen Verformungen auf null setzt. Das ist kein Fehler im Modell, sondern eine bewusste Entscheidung: Wer weiss, dass er die Verformung nicht braucht, darf sie weglassen und gewinnt dafür eine viel einfachere Beschreibung.

  Was daraus folgt: Sind alle _Abstände_ konstant, sind auch alle _Winkel_ konstant (ein Dreieck mit festen Seitenlängen hat feste Winkel). Der Körper behält also seine Gestalt und kann sich nur noch als Ganzes verschieben und drehen. Genau das wird sich in Kapitel 3 als grosse Vereinfachung erweisen.
]

Wo der starre Körper als Modell zulässig ist, hängt von der Fragestellung ab. Für die Bahn der Erde um die Sonne ist die Erde eine starre Kugel. Für die Ausbreitung eines Erdbebens ist sie es nicht, dort ist ihre Verformbarkeit der springende Punkt. Dasselbe gilt für ein Auto: Für die Fahrt um die Kurve genügt der starre Körper, für das Verhalten bei einem Aufprall nicht.

=== Der Bezugskörper

Lage und Bewegung sind immer _relativ_. «Der Zug fährt mit 100 km/h» heisst: relativ zum Erdboden. Der Fahrgast, der im Zug sitzt, ruht relativ zum Wagen und bewegt sich relativ zum Boden mit 100 km/h. Beide Aussagen stimmen -- sie beziehen sich nur auf verschiedene Dinge. Eine Lageangabe ohne Bezug ist daher sinnlos.

#defn[Bezugskörper][
  Ein *Bezugskörper* $B$ ist ein starrer Körper, relativ zu dem Lagen und Bewegungen gemessen werden. Man denkt ihn sich in Gedanken auf den ganzen Raum ausgedehnt. Im Bezugskörper legt man einen körperfesten *Ursprung* $O$ und drei zueinander senkrechte, gerichtete Achsen $x, y, z$ fest, die ein *Rechtssystem* bilden: Zeigt der Daumen der rechten Hand in $x$-Richtung und der Zeigefinger in $y$-Richtung, so zeigt der Mittelfinger in $z$-Richtung.
]

Stell dir einen kleinen Beobachter vor, der fest mit dem Bezugskörper verbunden ist, eine Uhr trägt und zu jedem Zeitpunkt die Abstände und Winkel zu «seinen» Punkten messen kann. Was er messen kann, sind die Koordinaten. Welchen Gegenstand man als Bezugskörper nimmt, ist eine Frage der Zweckmässigkeit: Erdboden, Motorgehäuse, Labortisch -- man wählt so, dass sich das Problem am einfachsten beschreiben lässt. Der Bezugskörper darf selbst relativ zu einem anderen Bezugskörper in Bewegung sein.

== Die drei Koordinatensätze

Um die Lage eines Punktes im Raum festzulegen, braucht man *drei* voneinander unabhängige Zahlen. Das ist keine Willkür, sondern eine Eigenschaft des Raums: Er hat drei Dimensionen. Auf einer Landkarte genügen zwei Zahlen (geografische Länge und Breite), will man auch die Höhe wissen, kommt eine dritte dazu. Diese drei Zahlen heissen *Koordinaten* des Punktes. Sie sind Abstände oder Winkel, die der Beobachter im Bezugskörper messen kann.

Welche Zahlen man nimmt, ist frei. Wir verwenden drei Sätze, die jeweils zu einer typischen Geometrie passen. Alle drei beschreiben denselben Punkt, nur mit verschiedenen «Adressen».

#fg("k01_koordinaten", [Derselbe Punkt $M$ in den drei Koordinatensätzen. Die fett gezeichneten Strecken und Winkel sind die Koordinaten. $M_(x y)$ ist die senkrechte Projektion von $M$ in die $x y$-Ebene. Hell gestrichelt die Koordinatenlinien durch $M$: der Kreis um die $z$-Achse ($phi$-Linie), der Breitenkreis ($psi$-Linie) und der Meridian ($theta$-Linie).])

=== Kartesische Koordinaten

Man projiziert $M$ senkrecht auf die drei Achsen. Die Projektionspunkte $M_x, M_y, M_z$ sind jene Punkte der Achsen, die $M$ am nächsten liegen. Die vorzeichenbehafteten Abstände dieser Punkte vom Ursprung,
$ x = overline(O M_x), quad y = overline(O M_y), quad z = overline(O M_z), $
heissen *kartesische Koordinaten* von $M$. Jede der drei Zahlen darf jeden Wert aus $(-oo, oo)$ annehmen, und jedem Tripel gehört genau ein Punkt, und umgekehrt. Das ist die einfachste, eindeutigste Adresse.

Kennt man die drei Funktionen
$ x = f_x (t), quad y = f_y (t), quad z = f_z (t), quad t in [t_1, t_2], $
so kennt man die Bewegung von $M$ vollständig. Dieselben drei Gleichungen sind zugleich die *Parameterdarstellung* der Bahnkurve: Für jedes $t$ liefern sie einen Punkt der Kurve.

#bsp[Schwingende Stabspitze][
  Ein am Ende $N$ eingespannter elastischer Stab schwingt; seine Spitze $M$ bewegt sich gemäss ($t$ in s, Koordinaten in cm)
  $ x = 3 cos(3 pi t), quad y = 4 cos(3 pi t), quad z = sin(3 pi t), quad t in [0, 1]. $
  _Anfangslage:_ $t = 0$ ergibt $(3, 4, 0)$. _Endlage:_ $t = 1$ ergibt $cos 3 pi = -1$, $sin 3 pi = 0$, also $(-3, -4, 0)$.

  _Form der Bahn:_ In allen drei Gleichungen steckt dieselbe Zeitfunktion. Aus den ersten beiden folgt sofort $y = 4x\/3$: Die Bahn liegt in einer *vertikalen Ebene*. In dieser Ebene ist die horizontale Entfernung von der $z$-Achse $u = sqrt(x^2 + y^2) = 5 cos(3 pi t)$ (mit Vorzeichen) und die Höhe $z = sin(3 pi t)$. Wegen $cos^2 + sin^2 = 1$ gilt
  $ (u / 5)^2 + z^2 = 1. $
  Das ist eine *Ellipse* mit dem Mittelpunkt $O$ und den Halbachsen $5$ cm (horizontal) und $1$ cm (vertikal). Die Spitze durchläuft sie in der Zeit $1$ s anderthalbmal, weil $3 pi t$ von $0$ bis $3 pi$ läuft; deshalb liegen Anfangs- und Endlage einander gegenüber.
]

#fg("k01_beispiele", [Beide Bahnen massstäblich. Links die Stabspitze: Ellipse um $O$ in der senkrechten Ebene $y = 4x\/3$, Halbachsen $5$ cm und $1$ cm; bei $t = 0$ ist die Geschwindigkeit senkrecht. Rechts das Elektron aus dem nächsten Abschnitt: Es startet auf der Kathode und windet sich auf dem Kegel $rho = R_1 + z$ nach aussen zur Anode.])

=== Zylindrische Koordinaten

Man projiziert $M$ zuerst senkrecht in die $x y$-Ebene und nennt den Fusspunkt $M_(x y)$. Dann sind

- $rho = overline(O M_(x y)) >= 0$ der Abstand von der $z$-Achse,
- $phi$ der Winkel von der positiven $x$-Achse zu $O M_(x y)$, im Bogenmass, im Gegenuhrzeigersinn positiv,
- $z = overline(M_(x y) M)$ die Höhe über der $x y$-Ebene, genau wie kartesisch.

Das sind die *zylindrischen Koordinaten* $(rho, phi, z)$. Die Bezeichnung kommt daher, dass die Fläche «$rho = "konst."$» ein Kreiszylinder um die $z$-Achse ist.

Aus der Zeichnung liest man die Umrechnung ab:
#gl($ x = rho cos phi, quad y = rho sin phi, quad z = z wide <=> wide rho = sqrt(x^2 + y^2), quad tan phi = y / x. $)

#warum[Umrechnung von $(x, y)$ nach $phi$][
  Im rechtwinkligen Dreieck $O M_x M_(x y)$ sind $x = rho cos phi$ die Ankathete und $y = rho sin phi$ die Gegenkathete. Teilt man die zweite Gleichung durch die erste, kürzt sich $rho$: $tan phi = y\/x$. Aber Vorsicht: Der Tangens wiederholt sich alle $180°$. Zu $(x, y) = (1, 1)$ und $(x, y) = (-1, -1)$ gehört derselbe Wert $y\/x = 1$, aber der erste Punkt liegt bei $phi = 45°$, der zweite bei $225°$. Das Vorzeichen von $x$ und $y$ einzeln entscheidet über den Quadranten. Im Taschenrechner steht dafür meist die Funktion «atan2» oder «arg».
]

Zylindrische Koordinaten sind nicht ganz so eindeutig wie kartesische. Jedes Tripel $(rho, phi, z)$ legt genau eine Lage fest, aber nicht umgekehrt: Der Winkel $phi$ ist nur bis auf Vielfache von $2 pi$ bestimmt, und auf der $z$-Achse selbst ($rho = 0$) ist er überhaupt nicht definiert, denn von dort aus gibt es keine «Richtung». Solche Stellen heissen *Koordinatensingularitäten*.

Bleibt $z$ konstant, bewegt sich der Punkt in einer Ebene, und man nennt $rho, phi$ *Polarkoordinaten* (oft auch $r, phi$ geschrieben). Der wichtigste Sonderfall ist die *Kreisbewegung*: Dann ist $rho = R$ konstant, und die ganze Bewegung steckt in einer einzigen Funktion $phi(t)$. Die Bogenlänge ist $s = R phi$. Zum Beispiel beschreibt
$ phi = phi_0 sin(2 pi t \/ T) $
die harmonische Schwingung eines Kreispendels mit der Winkelamplitude $phi_0$ und der Periode $T$.

#bsp[Elektron zwischen zwei Zylindern][
  Zwischen einer zylindrischen Kathode (Radius $R_1$) und einer koaxialen Anode (Radius $R_2$) bewege sich ein Elektron gemäss
  $ rho = R_1 + a t, quad phi = b t, quad z = a t, $
  mit positiven Konstanten $a, b$. Es verlässt die Kathode bei $t = 0$ in $(rho, phi, z) = (R_1, 0, 0)$ und erreicht die Anode zur Zeit $t_2 = (R_2 - R_1)\/a$.

  Die Bahn ist eine *kegelige Schraubenlinie*: Der Winkel wächst gleichmässig (das Elektron kreist um die Achse), gleichzeitig wachsen $rho$ und $z$ gleichmässig. Wegen $rho - R_1 = z$ liegt sie auf der Kegelfläche $rho = R_1 + z$ mit dem halben Öffnungswinkel $pi\/4$ (rechte Hälfte der Abbildung oben). Eine gewöhnliche Schraubenlinie hätte konstantes $rho$ und läge auf einem Zylinder.
]

=== Sphärische Koordinaten

Hier misst man den Abstand zum Ursprung und zwei Winkel:

- $r = overline(O M) >= 0$ der Abstand vom Ursprung,
- $theta$ der Winkel zwischen der positiven $z$-Achse und $O M$,
- $psi$ der Winkel von der positiven $x$-Achse zu $O M_(x y)$ (wie $phi$ bei den zylindrischen Koordinaten, nur anders bezeichnet, damit man nicht verwechselt, in welchem Satz man gerade ist).

Die Umrechnung folgt aus der Zeichnung (der Abstand $overline(O M_(x y)) = r sin theta$ ist die Projektion von $r$ auf die $x y$-Ebene):
#gl($ x = r sin theta cos psi, quad y = r sin theta sin psi, quad z = r cos theta, $)
#gl($ r = sqrt(x^2 + y^2 + z^2), quad cos theta = z / r, quad tan psi = y / x. $)
Für $theta$ nimmt man besser den Kosinus als den Tangens: $theta$ liegt immer in $[0, pi]$, und dort ist $arccos$ eindeutig. Mit $tan theta = sqrt(x^2 + y^2)\/z$ müsste man für $z < 0$ (untere Halbkugel) $pi$ addieren. Für $psi$ gilt dieselbe Quadrantenregel wie für $phi$.

#intu[
  Das ist die Adresse auf einem Globus. $psi$ ist die geografische Länge, $theta$ zählt vom Nordpol aus nach unten (also $theta = 90° -$ Breite), und $r$ ist der Abstand vom Erdmittelpunkt. Die Fläche «$r = "konst."$» ist eine Kugel -- daher der Name. Sphärische Koordinaten passen immer dann, wenn etwas von einem Punkt ausgeht (Wellen, Strahlung) oder sich um einen festen Punkt dreht (Kugelpendel, Kreisel).
]

Auch hier gibt es Singularitäten: Auf der $z$-Achse ($theta = 0$ oder $pi$) ist $psi$ nicht bestimmt (der Nordpol hat keine Länge), im Ursprung sind $theta$ und $psi$ undefiniert.

#bsp[Umrechnen][
  Der Punkt habe kartesisch die Koordinaten $(x, y, z) = (1, 1, sqrt(2))$.

  _Zylindrisch:_ $rho = sqrt(1 + 1) = sqrt(2)$, $phi = 45°$, $z = sqrt(2)$.

  _Sphärisch:_ $r = sqrt(1 + 1 + 2) = 2$, $cos theta = sqrt(2)\/2$ also $theta = 45°$, $psi = 45°$.

  Kontrolle der Rückrechnung: $x = 2 sin 45° cos 45° = 2 dot.c 1\/2 = 1$ ✓, $z = 2 cos 45° = sqrt(2)$ ✓.
]

#bsp[Präzession mit Nutation: Achsenspitze eines Kreisels][
  Die Achsenspitze $A$ eines im Ursprung drehbar gelagerten Spielzeugkreisels bewege sich gemäss
  $ r = R = "konst.", quad theta = pi/6 + theta_0 sin(Omega_1 t), quad psi = Omega_2 t. $
  Der Abstand zum Ursprung bleibt gleich: $A$ bleibt auf der Kugel mit Radius $R$. Der Winkel $theta$ pendelt um $30°$ hin und her (mit Amplitude $theta_0$), während $psi$ gleichmässig läuft: Die Spitze zeichnet eine *Sinuskurve auf der Kugel*, begrenzt von den Breitenkreisen $theta = pi\/6 plus.minus theta_0$.

  Ist $Omega_1 \/ Omega_2 = n$ eine ganze Zahl, schliesst sich die Bahn nach einem vollen Umlauf $psi = 2 pi$. Für rationales, nicht ganzes $n$ erst nach mehreren Umläufen, für irrationales $n$ nie.
]

=== Koordinatenlinien und Koordinatenflächen

Hält man in einem Koordinatensatz zwei Koordinaten fest und lässt nur die dritte laufen, so beschreibt der Punkt eine *Koordinatenlinie*. Hält man nur eine fest, entsteht eine *Koordinatenfläche*.

#table(columns: (auto, 1fr, 1fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [], [*Koordinatenlinien* (zwei fest)], [*Koordinatenflächen* (eine fest)],
  table.hline(stroke: 0.4pt),
  [kartesisch], [drei Geraden parallel zu den Achsen], [drei Ebenen parallel zu den Koordinatenebenen],
  [zylindrisch], [$rho$-Linie: radialer Strahl \ $phi$-Linie: Kreis um die $z$-Achse \ $z$-Linie: Gerade parallel zur $z$-Achse], [$rho = "konst."$: Kreiszylinder \ $phi = "konst."$: Halbebene durch die $z$-Achse \ $z = "konst."$: Ebene],
  [sphärisch], [$r$-Linie: radialer Strahl \ $theta$-Linie: Meridian (Längenkreis) \ $psi$-Linie: Breitenkreis], [$r = "konst."$: Kugel \ $theta = "konst."$: Kegel \ $psi = "konst."$: Halbebene],
  table.hline(stroke: 0.7pt),
)

In allen drei Fällen stehen die drei Koordinatenlinien in jedem Punkt *senkrecht aufeinander*. Man nennt die Koordinaten deshalb *orthogonal*. Bei kartesischen Koordinaten sind die Linien Geraden (_geradlinig_ orthogonal), bei den anderen beiden mindestens eine ein Kreis (_krummlinig_ orthogonal). Genau diese Orthogonalität macht die Basisvektoren des nächsten Abschnitts so handlich.

== Die vektorielle Darstellung

Koordinaten sind drei Zahlen. Es geht auch mit einem einzigen Objekt: einem Pfeil vom Ursprung zum Punkt.

#defn[Ortsvektor][
  Der Vektor $vr := arrow(O M)$ vom Ursprung $O$ zur Lage von $M$ heisst *Ortsvektor* von $M$. Ist $vr(t)$ für alle $t in [t_1, t_2]$ bekannt, so kennt man die Bewegung. Man schreibt sie als *Vektorfunktion* $t |-> vr(t)$.
]

Der Pfeil $vr$ ist vom Koordinatensystem unabhängig: Er ist ein geometrisches Objekt mit Länge und Richtung. Die Vektorfunktion beschreibt beides zugleich, wie sich die Länge $|vr|$ _und_ wie sich die Richtung ändert. Ändert sich nur die Länge, läuft der Punkt auf einer Geraden durch $O$ (geradlinige Bewegung). Ändert sich nur die Richtung, läuft er auf einer Kugel um $O$.

Um mit dem Pfeil zu rechnen, zerlegt man ihn in einer *Basis*, das sind drei nicht in einer Ebene liegende Vektoren $vb_1, vb_2, vb_3$. Dann ist
$ vr = r_1 vb_1 + r_2 vb_2 + r_3 vb_3, $
wobei $r_i$ die *skalaren Komponenten* und $r_i vb_i$ die *vektoriellen Komponenten* heissen. Am bequemsten sind Basen aus Vektoren der Länge 1 und paarweise senkrecht:

#defn[Orthonormierte Basis][
  Drei Vektoren $ve_1, ve_2, ve_3$ bilden eine *orthonormierte Basis* (orthogonale Einheitsvektoren), wenn
  #gl($ ve_i dot.c ve_i = 1, quad ve_i dot.c ve_j = 0 space (i != j), \
  ve_1 = ve_2 times ve_3, quad ve_2 = ve_3 times ve_1, quad ve_3 = ve_1 times ve_2. $)
]

Die erste Gruppe sagt «Länge 1» und «senkrecht», die zweite, dass die Vektoren ein Rechtssystem bilden. Wir wählen sie stets so, dass sie _tangential an die Koordinatenlinien_ des gewählten Koordinatensatzes liegen und in Richtung wachsender Koordinate zeigen.

#fg("k01_basis", [Die zylindrische Basis ist «mitgeführt»: $ve_rho$ zeigt von der Achse weg, $ve_phi$ in Umlaufrichtung. Deshalb dreht sie sich, wenn der Punkt umläuft. Die kartesische Basis dagegen ist überall gleich.])

#table(columns: (auto, 1fr, auto), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [*Basis*], [*Einheitsvektoren*], [*Ortsvektor*],
  table.hline(stroke: 0.4pt),
  [kartesisch], [$ve_x, ve_y, ve_z$ -- parallel zu den Achsen, überall gleich, zeitlich konstant], [$vr = x ve_x + y ve_y + z ve_z$],
  [zylindrisch], [$ve_rho$ (radial), $ve_phi$ (azimutal), $ve_z$ (axial) -- $ve_rho, ve_phi$ drehen mit $phi$], [$vr = rho ve_rho + z ve_z$],
  [sphärisch], [$ve_r$ (radial), $ve_theta$ (meridional), $ve_psi$ (azimutal) -- $ve_r, ve_theta$ hängen von $theta$ und $psi$ ab, $ve_psi$ nur von $psi$], [$vr = r ve_r$],
  table.hline(stroke: 0.7pt),
)

#merke[
  In $vr = rho ve_rho + z ve_z$ kommt $phi$ scheinbar gar nicht vor. Es steckt in der _Richtung_ von $ve_rho$: Dreht sich der Punkt, dreht sich $ve_rho$ mit. Genauso stecken $theta$ und $psi$ in $ve_r$. Die Beschreibung ist daher gleichwertig zu den Koordinaten aus dem letzten Abschnitt.

  Das hat eine wichtige Konsequenz für das nächste Kapitel: Beim Ableiten nach der Zeit sind $ve_rho$ und $ve_phi$ *keine Konstanten*. Man muss sie mitableiten, und gerade daraus entstehen später die «Zusatzterme» der Geschwindigkeit.
]

Welche Koordinaten man wählt, hängt von der Aufgabe ab. Kartesische passen zu geraden, rechtwinkligen Geometrien. Für Bewegungen um eine Achse (Wellen, Rohre, Kreisbahnen, ein Stempel, der in einen Untergrund eindringt, ein Elektron zwischen Zylinderelektroden) lohnen sich zylindrische. Für Bewegungen auf der Erdoberfläche im grossen Massstab, für Ausbreitung von Wellen aus einer Punktquelle oder für Kuppeln sind sphärische die natürliche Wahl. Kartesische Koordinaten haben eine Sonderstellung: Die beiden anderen Sätze sind über die Umrechnungsformeln auf ihnen aufgebaut.

== Hilfsmittel: Skalar- und Kreuzprodukt

Im ganzen Skript benutzen wir zwei Produkte von Vektoren. Hier die Kurzfassung, weil später ständig darauf zurückgegriffen wird.

#fg("k01_produkte", [Links das Skalarprodukt (Projektion), rechts das Kreuzprodukt (senkrechter Vektor, dessen Länge die Parallelogrammfläche ist).])

*Skalarprodukt.* $va dot.c vb = |va| |vb| cos theta$ ist eine Zahl. Sie misst, wie weit $va$ und $vb$ «in dieselbe Richtung zeigen»: Sie ist null für senkrechte Vektoren, maximal für parallele und negativ für gegenläufige. In einer orthonormierten Basis gilt komponentenweise $va dot.c vb = a_1 b_1 + a_2 b_2 + a_3 b_3$. Der Betrag eines Vektors ist $|va| = sqrt(va dot.c va)$.

*Kreuzprodukt (Vektorprodukt).* $va times vb$ ist ein Vektor. Er steht senkrecht auf $va$ _und_ $vb$, und die drei Vektoren $va, vb, va times vb$ bilden in dieser Reihenfolge ein Rechtssystem (Rechte-Hand-Regel: Finger von $va$ nach $vb$ krümmen, Daumen zeigt in Richtung $va times vb$). Sein Betrag ist $|va||vb| sin theta$, die Fläche des von $va$ und $vb$ aufgespannten Parallelogramms. Das Kreuzprodukt ist *nicht kommutativ*: $vb times va = -va times vb$. Parallele Vektoren haben das Kreuzprodukt null. Komponentenweise:
$ va times vb = (a_2 b_3 - a_3 b_2,thick a_3 b_1 - a_1 b_3,thick a_1 b_2 - a_2 b_1). $

*Spatprodukt.* $va dot.c (vb times vc)$ darf man zyklisch vertauschen: $va dot.c (vb times vc) = vb dot.c (vc times va) = vc dot.c (va times vb)$. Das wird in Kapitel 5 gebraucht.

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Navigation und Roboter.* Jedes Navi rechnet mit Ortsvektoren: Die Position wird als Punkt in einem Koordinatensystem (Länge, Breite, Höhe) gespeichert, die Strecke als Bahnkurve $vr(t)$. Wer Sensordaten eines Smartphones auswertet, wechselt dauernd zwischen Koordinatensystemen: Die Beschleunigung wird im Gerätesystem gemessen, die Karte lebt im Erdsystem. Ein Industrieroboter macht dasselbe mit seinem Greifer: Die Software kennt die Gelenkwinkel und rechnet daraus die Lage der Spitze aus, also eine Basiswechsel-Kette, wie sie in diesem Kapitel steht.]

#alltag[*Polarkoordinaten im Alltag.* Ein Radar (Flugsicherung, Wetterradar) misst Abstand und Richtung, also Polarkoordinaten $(r, phi)$. Der Fluglotse sieht aber ein kartesisches Bild. Die Umrechnung $x = r cos phi$, $y = r sin phi$ läuft pro Sekunde tausendfach im Hintergrund. Auch der Plattenspieler und das Karussell beschreiben Bewegungen in Polarkoordinaten viel einfacher als in $x, y$.]
// ALLTAG-END

#kurz[
  - Bewegung ist immer *relativ* zu einem starren *Bezugskörper* mit Achsen $O x y z$ (Rechtssystem).
  - Drei Zahlen legen eine Lage fest: kartesisch $(x, y, z)$, zylindrisch $(rho, phi, z)$, sphärisch $(r, theta, psi)$.
  - Umrechnung: $x = rho cos phi$, $y = rho sin phi$; $x = r sin theta cos psi$, $y = r sin theta sin psi$, $z = r cos theta$.
  - Ortsvektor $vr = x ve_x + y ve_y + z ve_z = rho ve_rho + z ve_z = r ve_r$ in orthonormierten Basen.
  - Kartesische Einheitsvektoren sind konstant; $ve_rho, ve_phi, ve_r, ve_theta, ve_psi$ ändern ihre Richtung mit dem Punkt.
  - Koordinatenwahl nach der Geometrie: gerade, eckig $->$ kartesisch; um eine Achse $->$ zylindrisch; um einen Punkt $->$ sphärisch.
]
