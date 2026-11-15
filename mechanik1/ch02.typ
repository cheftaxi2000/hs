#import "lib.typ": *

= Geschwindigkeit

Die Geschwindigkeit ist die zentrale Größe der Kinematik. Mathematisch ist sie nichts anderes als die Ableitung des Ortsvektors nach der Zeit. Weil der Ortsvektor ein _Vektor_ ist, müssen wir zuerst klären, was es heißt, einen Vektor abzuleiten.

== Ableitung einer Vektorfunktion

#defn[Vektorfunktion, Ableitung, Differential][
  Ordnet man jeder Zahl $t in (t_1, t_2)$ einen Vektor $vr$ zu, so heißt $t |-> vr(t)$ *Vektorfunktion* der skalaren Variablen $t$. Ihre *Ableitung* ist
  $ dot(vr) := (dif vr) / (dif t) := lim_(Delta t -> 0) (vr(t + Delta t) - vr(t)) / (Delta t), $
  ihr *Differential* $dif vr := dot(vr) dif t$. Das Differential ist die lineare Näherung der Differenz $Delta vr = vr(t + Delta t) - vr(t)$.
]

#fig(12, 4.4, caption: [Die Differenz $Delta vr$ ist eine Sehne der Bahnkurve. Für $Delta t -> 0$ dreht sie in die Tangente: $dot(vr)$ liegt immer tangential zur Bahn.],
  graph(t => 0.9 + 1.5 * calc.sin(t * 0.55), 0.4, 5.2, o: (3, 0.6), sx: 1.5, sy: 1, c: cg, w: 0.8pt),
  pt((1.0, 0.5)), lbl((0.75, 0.4), $O$),
  arr((1.0,0.5), (5.1, 2.55), w: 0.7pt), arr((1.0,0.5), (7.65, 3.0), w: 0.7pt),
  arr((5.1, 2.55), (7.65, 3.0), c: cv, w: 1.1pt), arr((5.1, 2.55), (7.4, 3.75), c: cv, w: 1.1pt, dash: "dashed"),
  pt((5.1, 2.55)), pt((7.65, 3.0)),
  lbl((3.0, 1.85), $vr(t)$), lbl((5.3, 1.35), $vr(t + Delta t)$), lbl((6.75, 2.6), $Delta vr$, c: cv), lbl((6.2, 3.65), $dot(vr) Delta t$, c: cv),
  lbl((4.75, 2.85), $M(t)$, size: 8pt), lbl((8.4, 2.85), $M(t + Delta t)$, size: 8pt), lbl((10.6, 2.3), [Bahnkurve $C$], c: cg, size: 8pt),
)

Für das Rechnen gelten dieselben Regeln wie bei gewöhnlichen Funktionen. Für Vektorfunktionen $vq(t), vr(t)$ und eine skalare Funktion $s(t)$:
#gl($ (s vr)^dot.op = dot(s) vr + s dot(vr), wide (vq dot.c vr)^dot.op = dot(vq) dot.c vr + vq dot.c dot(vr), wide (vq times vr)^dot.op = dot(vq) times vr + vq times dot(vr). $)
Und die Kettenregel, wenn $vr$ über eine Zwischengröße $s(t)$ von der Zeit abhängt:
#gl($ (dif vr) / (dif t) = (dif vr) / (dif s) (dif s) / (dif t). $)

#merke[
  Ein Vektor kann sich auf zwei Arten ändern: Er kann *länger oder kürzer* werden, und er kann sich *drehen*. Die Ableitung erfasst beides. Ein Vektor konstanter Länge hat also im Allgemeinen _nicht_ die Ableitung null -- sie steht dann senkrecht auf ihm (aus $vr dot.c vr = "konst."$ folgt $2 vr dot.c dot(vr) = 0$).
]

== Schnelligkeit und Geschwindigkeit

Auf der Bahnkurve $C$ wählen wir einen festen Punkt $A$ und eine positive Richtung. Die entlang der Kurve gemessene, vorzeichenbehaftete Strecke von $A$ bis $M$ ist die *Bogenlänge* $s$.

#defn[Schnelligkeit][
  $dot(s) = dif s \/ dif t$ heißt *Schnelligkeit* von $M$ auf $C$. Sie ist ein Skalar (Einheit m/s). Ihr Betrag sagt, wie rasch der Punkt läuft, ihr Vorzeichen in welche Richtung der Bahn. Ist $dot(s)$ konstant, heißt die Bewegung *gleichförmig*; ist die Bahn zusätzlich eine Gerade, *geradlinig gleichförmig*.
]

#defn[Geschwindigkeit][
  Sei $vtau$ der tangentiale Einheitsvektor der Bahn in positiver $s$-Richtung. Die *Geschwindigkeit* ist der Vektor
  #gl($ vv := dot(s) vtau. $)
  Sie ist in jedem Punkt tangential zur Bahnkurve.
]

#intu[
  Die Schnelligkeit ist das, was der Tacho zeigt: nur eine Zahl. Die Geschwindigkeit ist Tacho _und_ Kompass zusammen: wie schnell und wohin. Ein Auto, das mit konstant 50 km/h durch einen Kreisel fährt, hat konstante Schnelligkeit, aber seine Geschwindigkeit ändert sich ständig, weil sich die Richtung ändert.
]

=== Geschwindigkeit ist die Ableitung des Ortsvektors

Fasst man $vr$ als Funktion der Bogenlänge auf, so ist $dif vr \/ dif s = vtau$: Für ein winziges Bahnstück sind Sehne und Bogen gleich lang, also hat $dif vr \/ dif s$ die Länge 1 und zeigt tangential. Mit der Kettenregel folgt sofort
#gl($ vv = dot(s) vtau = (dif s) / (dif t) (dif vr) / (dif s) = dot(vr). $)

#satz[Geschwindigkeit][
  Die Geschwindigkeit ist die zeitliche Ableitung des Ortsvektors: $vv = dot(vr)$. Umgekehrt erhält man aus $vv$ die Schnelligkeit $|dot(s)| = |vv|$ und die Tangente $vtau = vv \/ |vv|$ (wenn $s$ in Bewegungsrichtung positiv zählt).
]

== Komponenten der Geschwindigkeit

Jetzt leiten wir den Ortsvektor in jeder der drei Basen ab. Der einzige Punkt, an dem man aufpassen muss: Sind die Einheitsvektoren konstant oder nicht?

=== Kartesisch

Die Einheitsvektoren sind konstant ($dot(ve)_x = dot(ve)_y = dot(ve)_z = bold(0)$), also wird einfach komponentenweise abgeleitet:
#gl($ vr = x ve_x + y ve_y + z ve_z quad => quad vv = dot(x) ve_x + dot(y) ve_y + dot(z) ve_z, wide |vv| = sqrt(dot(x)^2 + dot(y)^2 + dot(z)^2). $)

=== Zylindrisch

Aus $vr = rho ve_rho + z ve_z$ folgt mit der Produktregel $dot(vr) = dot(rho) ve_rho + rho dot(ve)_rho + dot(z) ve_z$. Wir brauchen $dot(ve)_rho$.

#fig(13, 4.3, caption: [Links: Dreht sich $ve_rho$ um $Delta phi$, so wandert seine Spitze auf dem Einheitskreis um die Bogenlänge $Delta phi$ in Richtung $ve_phi$. Rechts: Das Wegstück $dif vr$ in Polarkoordinaten besteht aus einem radialen Teil $dif rho$ und einem Querteil $rho dif phi$.],
  // links: Einheitskreis
  axes((1.0, 0.6), 3.6, 3.4),
  arc((1.0,0.6), 2.6, 0, 90, col: cg, w: 0.4pt, dash: "dashed"),
  arr((1.0,0.6), pol((1.0,0.6), 2.6, 30), c: black), arr((1.0,0.6), pol((1.0,0.6), 2.6, 55), c: cg),
  arr(pol((1.0,0.6), 2.6, 30), pol((1.0,0.6), 2.6, 55), c: cv, w: 1.1pt),
  arr(pol((1.0,0.6), 2.6, 30), add(pol((1.0,0.6), 2.6, 30), pol((0,0),1.0,120)), c: cm, w: 0.8pt),
  arc((1.0,0.6), 0.9, 0, 30, w: 0.5pt), lbl((2.15, 0.85), $phi$), arc((1.0,0.6), 1.3, 30, 55, w: 0.5pt), lbl((2.05, 1.75), $Delta phi$, size: 8pt),
  lbl((3.0, 1.35), $ve_rho (t)$), lbl((1.6, 2.6), $ve_rho (t + Delta t)$, c: cg, size: 8pt), lbl((3.35, 2.6), $Delta ve_rho$, c: cv), lbl((2.45, 3.05), $ve_phi$, c: cm),
  // rechts: dr
  axes((7.6, 0.6), 4.8, 3.4),
  li((7.6,0.6), pol((7.6,0.6), 3.0, 25), s: 0.5pt + cg), li((7.6,0.6), pol((7.6,0.6), 4.0, 48), s: 0.5pt + cg),
  arc((7.6,0.6), 3.0, 25, 48, col: cg, w: 0.4pt, dash: "dashed"),
  arr(pol((7.6,0.6), 3.0, 25), pol((7.6,0.6), 3.0, 48), c: cm, w: 0.9pt), arr(pol((7.6,0.6), 3.0, 48), pol((7.6,0.6), 4.0, 48), c: cm, w: 0.9pt),
  arr(pol((7.6,0.6), 3.0, 25), pol((7.6,0.6), 4.0, 48), c: cv, w: 1.2pt),
  pt(pol((7.6,0.6), 3.0, 25)), pt(pol((7.6,0.6), 4.0, 48)),
  lbl((10.75, 2.7), $dif vr$, c: cv), lbl((9.55, 2.25), $rho dif phi$, c: cm, size: 8pt), lbl((9.65, 3.4), $dif rho$, c: cm, size: 8pt),
  arc((7.6,0.6), 1.2, 25, 48, w: 0.5pt), lbl((9.05, 1.6), $dif phi$, size: 8pt), lbl((9.2, 1.05), $rho$, size: 8pt),
)

#intu[
  Zeichne $ve_rho$ zu allen Zeiten vom selben Punkt aus. Seine Spitze läuft dann auf einem Kreis mit Radius 1. Auf dem Einheitskreis ist die Bogenlänge gleich dem Winkel, also läuft die Spitze mit der Schnelligkeit $dot(phi)$, und zwar quer zu $ve_rho$, in Richtung $ve_phi$. Mehr steckt nicht dahinter.
]

#gl($ dot(ve)_rho = dot(phi) ve_phi, wide dot(ve)_phi = -dot(phi) ve_rho. $)
Rechnerisch bestätigt man das mit $ve_rho = cos phi ve_x + sin phi ve_y$ und $ve_phi = -sin phi ve_x + cos phi ve_y$. Eingesetzt:
#gl($ vv = dot(rho) ve_rho + rho dot(phi) ve_phi + dot(z) ve_z. $)

Jeder Term hat eine klare Bedeutung: $dot(rho)$ ist «weg von der Achse», $rho dot(phi)$ ist «quer, um die Achse herum» (Hebelarm mal Winkelschnelligkeit), $dot(z)$ ist «entlang der Achse».

=== Sphärisch

Analog gilt $dot(ve)_r = dot(theta) ve_theta + dot(psi) sin theta ve_psi$ und damit
#gl($ vv = dot(r) ve_r + r dot(theta) ve_theta + r sin theta dot(psi) ve_psi. $)
Der Faktor $r sin theta$ ist der Abstand von der $z$-Achse, also der Radius des Breitenkreises, auf dem der Punkt bei einer $psi$-Drehung läuft.

#bsp[Elektron zwischen zwei Zylindern][
  $rho = R_1 + a t$, $phi = b t$, $z = a t$. Dann ist $dot(rho) = a$, $dot(phi) = b$, $dot(z) = a$ und
  $ vv = a ve_rho + b (R_1 + a t) ve_phi + a ve_z, wide |vv| = sqrt(2 a^2 + b^2 (R_1 + a t)^2). $
  Der Querteil wächst mit der Zeit, weil das Elektron bei gleicher Winkelschnelligkeit immer weiter außen läuft.
]

== Kreisbewegung und Winkelgeschwindigkeit

Für einen Punkt auf einem Kreis mit Radius $R$ um die $z$-Achse ist $rho = R$, $z = z_0$ konstant, also
$ vv = R dot(phi) ve_phi. $
$dot(phi)$ heißt *Winkelschnelligkeit*. Mit $ve_phi = ve_z times ve_rho$ lässt sich das umschreiben zu $vv = dot(phi) ve_z times R ve_rho$, und weil $ve_z times ve_z = bold(0)$ ist, darf man $R ve_rho$ durch den vollen Ortsvektor $vr = R ve_rho + z_0 ve_z$ ersetzen.

#defn[Winkelgeschwindigkeit][
  Der Vektor $vom := dot(phi) ve_z$ heißt *Winkelgeschwindigkeit* der Kreisbewegung um die $z$-Achse. Er liegt _auf der Drehachse_, sein Betrag ist die Winkelschnelligkeit, sein Richtungssinn folgt der Rechte-Hand-Regel.
]

#gl($ vv = vom times vr $)

#fig(12.5, 4.6, caption: [Kreisbewegung. $vom$ liegt auf der Achse, $vv$ steht senkrecht auf $vom$ und auf $vr$. Rechte Hand: Finger in Drehrichtung, Daumen zeigt in Richtung $vom$.],
  // Achse
  li((4.2, 0.3), (4.2, 4.3), s: 0.5pt + cg, dash: "dash-dotted"),
  // Kreis als Ellipse
  graph(t => 0.55 * calc.sin(t), 0, 6.283, o: (4.2, 2.6), sx: 0, sy: 1, c: white),
  pl(range(61).map(i => (4.2 + 2.3 * calc.cos(i / 60 * 6.283), 2.6 + 0.6 * calc.sin(i / 60 * 6.283))), s: 0.5pt + cg),
  pt((4.2, 0.9)), lbl((3.95, 0.8), $O$),
  arr((4.2, 0.9), (6.1, 2.27), w: 0.8pt), lbl((5.45, 1.45), $vr$),
  arr((4.2, 2.6), (6.1, 2.27), w: 0.5pt, hs: 0.12), lbl((5.1, 2.65), $R$, size: 8pt),
  arr((6.1, 2.27), (7.2, 3.05), c: cv, w: 1.2pt), lbl((7.4, 3.2), $vv$, c: cv),
  arr((4.2, 2.6), (4.2, 4.0), c: cm, w: 1.2pt), lbl((4.55, 3.9), $vom$, c: cm),
  pt((6.1, 2.27)), lbl((6.3, 2.0), $M$),
  arc((4.2, 4.15), 0.35, 200, 500, col: cm, head: true, hs: 0.13),
  // rechts Text
  lbl((10.3, 3.2), $|vv| = omega R$), lbl((10.3, 2.5), $vv perp vom, quad vv perp vr$), lbl((10.3, 1.8), $vom = dot(phi) ve_z$, c: cm),
)

#merke[
  $vv = vom times vr$ ist unabhängig vom Koordinatensystem. $vr$ darf von _irgendeinem_ Punkt auf der Drehachse aus gemessen werden -- das Kreuzprodukt schneidet den achsenparallelen Anteil ohnehin weg. Übrig bleibt $|vv| = omega dot.c ("Abstand von der Achse")$.
]

#fehler[
  - $dot(ve)_rho$ vergessen und $vv = dot(rho) ve_rho + dot(z) ve_z$ schreiben. Der Term $rho dot(phi) ve_phi$ entsteht genau aus der Drehung von $ve_rho$.
  - Schnelligkeit (Skalar, $dot(s)$) und Geschwindigkeit (Vektor, $vv$) verwechseln.
  - Reihenfolge im Kreuzprodukt: Es heißt $vom times vr$, nicht $vr times vom$ (das gäbe das falsche Vorzeichen).
]

#kurz[
  - $vv = dot(vr) = dot(s) vtau$, immer tangential zur Bahn.
  - Kartesisch: $vv = dot(x) ve_x + dot(y) ve_y + dot(z) ve_z$
  - Zylindrisch: $vv = dot(rho) ve_rho + rho dot(phi) ve_phi + dot(z) ve_z$, weil $dot(ve)_rho = dot(phi) ve_phi$
  - Sphärisch: $vv = dot(r) ve_r + r dot(theta) ve_theta + r sin theta dot(psi) ve_psi$
  - Kreisbewegung: $vv = vom times vr$ mit $vom = dot(phi) ve_z$ auf der Drehachse, $|vv| = omega R$.
]
