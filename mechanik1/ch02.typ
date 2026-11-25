#import "lib.typ": *

= Geschwindigkeit

#woche(2, [Geschwindigkeit], [24–35])

Die Geschwindigkeit ist die zentrale Größe der Kinematik. Mathematisch ist sie nichts anderes als die Ableitung des Ortsvektors nach der Zeit. Weil der Ortsvektor aber ein _Vektor_ ist, der sich in Länge und Richtung ändern kann, müssen wir zuerst klären, was es heißt, einen Vektor abzuleiten. Danach rechnen wir die Geschwindigkeit in jedem der drei Koordinatensätze aus.

== Ableitung einer Vektorfunktion

Eine Vektorfunktion ordnet jeder Zahl $t$ einen Vektor zu, so wie $x = f(t)$ jeder Zahl eine Zahl zuordnet. Für Grenzwert, Stetigkeit und Differenzierbarkeit gelten dieselben Definitionen wie bei gewöhnlichen Funktionen. Einziger Unterschied: Wo bei einer Zahl der Absolutwert $|x|$ steht, steht beim Vektor der Betrag $|vr|$.

#defn[Ableitung und Differential][
  Die *Ableitung* einer differenzierbaren Vektorfunktion $t |-> vr(t)$ ist
  $ dot(vr) := (dif vr) / (dif t) := lim_(Delta t -> 0) (vr(t + Delta t) - vr(t)) / (Delta t). $
  Das *Differential* ist $dif vr := dot(vr) dif t$. Es ist die lineare Näherung der Differenz $Delta vr = vr(t + Delta t) - vr(t)$:
  $ Delta vr = dot(vr) Delta t + bold(u)(t, Delta t) Delta t quad "mit" quad lim_(Delta t -> 0) bold(u)(t, Delta t) = bold(0). $
]

#fg("k02_ableitung", [Geometrische Bedeutung der Ableitung. Die Differenz $Delta vr$ ist die Sehne von $M(t)$ nach $M(t + Delta t)$. Verkleinert man $Delta t$, dreht die Sehne in die Tangente: $dot(vr)$ liegt tangential zur Bahnkurve. Das Differential $dot(vr) Delta t$ ist die Näherung der Sehne durch ein Stück Tangente.])

#intu[
  Der Quotient $Delta vr \/ Delta t$ ist eine «mittlere Geschwindigkeit» über das Zeitintervall: Versatz geteilt durch Zeit. Lässt man das Intervall schrumpfen, wird daraus die Geschwindigkeit _in diesem Augenblick_. Das ist nicht mehr oder weniger als die Ableitung, die man aus der Analysis kennt, nur dass jetzt Pfeile statt Zahlen im Zähler stehen.
]

=== Rechenregeln

Für zwei Vektorfunktionen $vq(t), vr(t)$ und eine skalare Funktion $s(t)$ gelten die gewohnten Produktregeln, jeweils in der Form «erster Faktor abgeleitet mal zweiter plus erster mal zweiter abgeleitet»:
#gl($ (s vr)^dot = dot(s) vr + s dot(vr), wide (vq dot.c vr)^dot = dot(vq) dot.c vr + vq dot.c dot(vr), wide (vq times vr)^dot = dot(vq) times vr + vq times dot(vr). $)
Beim Kreuzprodukt ist die Reihenfolge wichtig: Der abgeleitete Faktor bleibt jeweils an seiner Stelle.

Hängt $vr$ über eine Zwischengröße $s$ von der Zeit ab, $t |-> s(t)$ und $s |-> vr(s)$, so gilt die *Kettenregel*
#gl($ (dif vr) / (dif t) = (dif vr) / (dif s) dot.c (dif s) / (dif t). $)

#warum[Der Betrag eines Vektors konstanter Länge][
  Hat $vr(t)$ konstante Länge, so ist $vr dot.c vr = |vr|^2$ konstant, also nach der Produktregel
  $ 0 = (vr dot.c vr)^dot = 2 vr dot.c dot(vr). $
  Folglich steht $dot(vr)$ senkrecht auf $vr$. Anschaulich: Ändert ein Pfeil nur seine Richtung und nicht seine Länge, so läuft seine Spitze auf einer Kugel, und die Geschwindigkeit der Spitze ist tangential zur Kugel, also senkrecht zum Pfeil. Diese Überlegung begegnet uns gleich bei den Einheitsvektoren wieder.
]

#merke[
  Ein Vektor kann sich auf zwei Arten ändern: Er kann *länger oder kürzer* werden, und er kann sich *drehen*. Die Ableitung erfasst beides. Insbesondere hat ein Vektor konstanter _Länge_ im Allgemeinen nicht die Ableitung null.
]

== Schnelligkeit und Geschwindigkeit

Der Punkt $M$ bewege sich auf einer Bahnkurve $C$. Wir wählen auf $C$ einen festen Punkt $A$ und eine positive Richtung. Die entlang der Kurve gemessene, vorzeichenbehaftete Strecke von $A$ bis $M$ heißt *Bogenlänge* $s$. Sie ist eine krummlinige Koordinate von $M$ auf $C$. Die Bewegung ist dann durch eine einzige Funktion $t |-> s(t)$ beschrieben.

#defn[Schnelligkeit][
  Die Ableitung $dot(s) = dif s \/ dif t$ der Bogenlänge heißt *Schnelligkeit* von $M$ auf $C$. Sie ist ein Skalar mit der Dimension Länge pro Zeit (Einheit m/s). Ihr _Betrag_ sagt, wie rasch der Punkt läuft, ihr _Vorzeichen_, in welchem Richtungssinn.
]

Ist $dot(s)$ konstant, heißt die Bewegung *gleichförmig*: Die Bogenlänge wächst linear, $s = s_0 + dot(s) t$. Ist zusätzlich die Bahn eine Gerade, spricht man von *geradlinig gleichförmiger* Bewegung.

#bsp[Schwingende Bewegung][
  $s(t) = s_0 sin(2 pi t \/ T)$. Dann ist $dot(s) = (2 pi s_0 \/ T) cos(2 pi t \/ T)$. Anfangsschnelligkeit: $dot(s)(0) = 2 pi s_0 \/ T > 0$, der Punkt läuft zu wachsendem $s$. Bei $t = T\/4$ erreicht er die Amplitude $s = s_0$, dort ist $cos(pi\/2) = 0$, also $dot(s) = 0$ -- Umkehrpunkt. Bei $t = T\/2$ läuft er mit negativer Schnelligkeit $-2 pi s_0\/T$ durch den Nullpunkt zurück. Die _Form_ der Bahnkurve kann man aus dieser Beschreibung nicht erkennen: Sie sagt nur, wie weit der Punkt auf der Bahn gelaufen ist, nicht, in welche Richtung im Raum.
]

Genau diese fehlende Richtungsinformation holen wir uns jetzt. Die Schnelligkeit ist ein Skalar; sie weiß nichts davon, _wohin_ sich der Punkt bewegt. Die Richtung der Bewegung ist die Tangente an die Bahnkurve. Wir führen deshalb in jedem Bahnpunkt den *tangentialen Einheitsvektor* $vtau$ ein, der in Richtung wachsender Bogenlänge zeigt. Er hat konstante Länge 1, aber (außer bei Geraden) eine veränderliche Richtung.

#defn[Geschwindigkeit][
  Die *Geschwindigkeit* ist der Vektor
  #gl($ vv := dot(s) vtau. $)
  Sie ist in jedem Punkt tangential zur Bahnkurve, ihr Betrag ist die Schnelligkeit $|dot(s)|$.
]

#fg("k02_bogen", [Bogenlänge $s$, Tangenteneinheitsvektor $vtau$ und Geschwindigkeit $vv = dot(s) vtau$. Der Pfeil $vv$ zeigt in Bahnrichtung; wäre $dot(s) < 0$, zeigte er gegen $vtau$.])

#intu[
  Die Schnelligkeit ist das, was der Tacho zeigt: eine Zahl. Die Geschwindigkeit ist Tacho _und_ Kompass zusammen: wie schnell und wohin. Ein Auto, das mit konstant 50 km/h im Kreisverkehr fährt, hat konstante Schnelligkeit, aber seine Geschwindigkeit ändert sich ständig, weil sich die Richtung ändert.
]

== Zusammenhang mit dem Ortsvektor

Wie hängt diese Geschwindigkeit mit dem Ortsvektor zusammen? Die einfachste Antwort lautet: Sie _ist_ die Ableitung des Ortsvektors,
#gl($ vv = dot(vr). $)
Das müssen wir uns klar machen, denn eine der beiden Formeln ($vv = dot(s) vtau$ oder $vv = dot(vr)$) kann man als Definition auffassen, die andere ist dann eine Folgerung. Wir zeigen: $dif vr \/ dif s = vtau$.

#warum[Warum $dif vr \/ dif s = vtau$ gilt][
  Betrachte zwei Punkte $M$ und $M'$ nahe beieinander auf der Bahn, mit Bogenabstand $Delta s$. Die Differenz der Ortsvektoren $Delta vr = vr(M') - vr(M)$ ist die _Sehne_ von $M$ nach $M'$. Für $Delta s -> 0$ passiert zweierlei:

  - Die Sehne dreht sich in die Tangente. Also liegt $dif vr\/dif s$ auf der Tangente, ist parallel zu $vtau$.
  - Sehne und Bogen werden gleich lang: Das Verhältnis $|Delta vr| \/ Delta s$ strebt gegen 1. (Das Bogenstück wird von einer Geraden nicht mehr unterscheidbar. Zum Beispiel ist bei einem Kreis mit Radius $R$ und Winkel $Delta phi$ die Sehne $2R sin(Delta phi\/2) approx R Delta phi$, gleich dem Bogen.)

  Ein Vektor, der tangential ist und die Länge 1 hat, ist genau $vtau$ (in Richtung wachsendem $s$). Also $dif vr\/dif s = vtau$.
]

Mit der Kettenregel folgt sofort
$ dot(vr) = (dif vr) / (dif s) (dif s) / (dif t) = vtau dot(s) = vv. $

#satz[Geschwindigkeit und Ortsvektor][
  Die Geschwindigkeit ist die zeitliche Ableitung des Ortsvektors: $vv = dot(vr)$. Aus ihr erhält man die Schnelligkeit $|dot(s)| = |vv|$ und, wenn $s$ in Bewegungsrichtung wächst, die Tangente $vtau = vv \/ |vv|$.
]

== Komponenten der Geschwindigkeit

In der Praxis will man die Geschwindigkeit in den Komponenten einer Basis haben. Der Weg ist immer derselbe: Ortsvektor in der gewünschten Basis hinschreiben, nach der Zeit ableiten mit der Produktregel. Der einzige Punkt, an dem man aufpassen muss: Sind die Einheitsvektoren der Basis konstant oder nicht?

=== Kartesische Komponenten

Die Einheitsvektoren $ve_x, ve_y, ve_z$ sind konstant, ihre Ableitungen null. Man leitet also einfach komponentenweise ab:
#gl($ vr = x ve_x + y ve_y + z ve_z quad => quad vv = dot(x) ve_x + dot(y) ve_y + dot(z) ve_z, wide |vv| = sqrt(dot(x)^2 + dot(y)^2 + dot(z)^2). $)

#bsp[Stabspitze][
  Zur Bewegung aus Kapitel 1, $x = 3 cos 3 pi t$, $y = 4 cos 3 pi t$, $z = sin 3 pi t$, gehört
  $ vv = -9 pi sin(3 pi t) ve_x - 12 pi sin(3 pi t) ve_y + 3 pi cos(3 pi t) ve_z, $
  in cm/s. Für die Schnelligkeit: $|vv|^2 = 81 pi^2 sin^2 + 144 pi^2 sin^2 + 9 pi^2 cos^2 = 9 pi^2 (25 sin^2 + cos^2)$, also
  $ |vv| = 3 pi sqrt(1 + 24 sin^2(3 pi t)) quad "cm/s". $
  _Kontrolle:_ In den Umkehrpunkten der Schwingung ($x = plus.minus 3$, $y = plus.minus 4$, $z = 0$, also $sin = 0$) ist $dot(x) = dot(y) = 0$, die Geschwindigkeit ist rein vertikal mit $|vv| = 3 pi$ cm/s. In den obersten und untersten Lagen ($z = plus.minus 1$, $cos = 0$) ist $dot(z) = 0$, die Geschwindigkeit ist rein horizontal, der Betrag $15 pi$ cm/s ist maximal. Das passt zur Ellipse: oben und unten läuft der Punkt am schnellsten durch.
]

=== Zylindrische Komponenten

Wir leiten $vr = rho ve_rho + z ve_z$ ab. Die Produktregel liefert
$ dot(vr) = dot(rho) ve_rho + rho dot(ve)_rho + dot(z) ve_z. $
Der mittlere Term ist neu: $ve_rho$ hat konstante Länge, aber wegen $phi = phi(t)$ eine zeitlich veränderliche _Richtung_. Wir brauchen $dot(ve)_rho$.

#fg("k02_basisableitung", [Links: $ve_rho$ zu zwei Zeiten, vom selben Punkt aus gezeichnet. Die Spitze läuft auf dem Einheitskreis, und die Änderung $Delta ve_rho$ steht senkrecht auf $ve_rho$, also in Richtung $ve_phi$. Rechts: Das Wegelement $dif vr$ in Polarkoordinaten setzt sich aus einem radialen Teil $dif rho$ und einem Querteil $rho dif phi$ zusammen.])

#warum[Die Ableitung von $ve_rho$][
  _Geometrisch:_ Zeichnet man $ve_rho$ zu allen Zeiten vom selben Anfangspunkt aus, läuft seine Spitze auf dem Einheitskreis (links). Die Ableitung $dot(ve)_rho$ ist nach $vv = dot(vr)$ die «Geschwindigkeit dieser Spitze», denn $ve_rho$ spielt hier die Rolle eines Ortsvektors. Auf dem Einheitskreis ist die Bogenlänge gleich dem Winkel $phi$, also ist die Schnelligkeit $dot(phi)$, und die Richtung ist tangential zum Kreis, das ist $ve_phi$. Ergebnis: $dot(ve)_rho = dot(phi) ve_phi$.

  _Rechnerisch:_ Mit $ve_rho = cos phi thin ve_x + sin phi thin ve_y$ und $ve_phi = -sin phi thin ve_x + cos phi thin ve_y$ gilt nach der Kettenregel $(cos phi)^dot = -sin phi dot.c dot(phi)$ und $(sin phi)^dot = cos phi dot.c dot(phi)$, also
  $ dot(ve)_rho = (-sin phi thin ve_x + cos phi thin ve_y) dot(phi) = dot(phi) ve_phi, wide dot(ve)_phi = (-cos phi thin ve_x - sin phi thin ve_y) dot(phi) = -dot(phi) ve_rho. $
]

Einsetzen liefert die zylindrischen Komponenten:
#gl($ vv = dot(rho) ve_rho + rho dot(phi) ve_phi + dot(z) ve_z. $)

Das ist auch direkt aus dem Wegelement (rechts in der Abbildung) ablesbar: $dif vr = dif rho thin ve_rho + rho dif phi thin ve_phi + dif z thin ve_z$. Jeder Term hat eine klare Bedeutung: $dot(rho)$ ist die Bewegung weg von der Achse, $rho dot(phi)$ die Bewegung quer dazu um die Achse (Hebelarm mal Winkelschnelligkeit), $dot(z)$ die Bewegung längs der Achse.

#bsp[Elektron][
  Zu $rho = R_1 + a t$, $phi = b t$, $z = a t$ gehört $dot(rho) = a$, $dot(phi) = b$, $dot(z) = a$, also
  $ vv = a ve_rho + b (R_1 + a t) ve_phi + a ve_z, wide |vv| = sqrt(2 a^2 + b^2 (R_1 + a t)^2). $
  Beim Start ($t = 0$) ist der Querteil $b R_1$, an der Anode ($t = t_2$) ist er $b R_2$: Bei gleicher Winkelschnelligkeit ist die Umfangsgeschwindigkeit außen größer. Der radiale und der axiale Anteil bleiben dagegen konstant $= a$.
]

=== Sphärische Komponenten

Für $vr = r ve_r$ gilt $dot(vr) = dot(r) ve_r + r dot(ve)_r$. Den Einheitsvektor $ve_r$ schreiben wir in kartesischen Komponenten: $ve_r = sin theta cos psi thin ve_x + sin theta sin psi thin ve_y + cos theta thin ve_z$. Ableiten mit Kettenregel nach $theta$ und $psi$ und Vergleich mit den Komponenten von $ve_theta = cos theta cos psi thin ve_x + cos theta sin psi thin ve_y - sin theta thin ve_z$ und $ve_psi = -sin psi thin ve_x + cos psi thin ve_y$ ergibt
#gl($ dot(ve)_r = dot(theta) ve_theta + dot(psi) sin theta thin ve_psi. $)
Der Faktor $sin theta$ erscheint, weil der Breitenkreis, auf dem sich $psi$ ändert, den Radius $r sin theta$ hat. Damit ist
#gl($ vv = dot(r) ve_r + r dot(theta) ve_theta + r sin theta thin dot(psi) ve_psi. $)

#bsp[Achsenspitze des Kreisels][
  Zu $r = R$, $theta = pi\/6 + theta_0 sin(Omega_1 t)$, $psi = Omega_2 t$ (Beispiel aus Kapitel 1) gehört
  $ vv = R theta_0 Omega_1 cos(Omega_1 t) ve_theta + R Omega_2 sin[pi\/6 + theta_0 sin(Omega_1 t)] ve_psi. $
  Es gibt keinen radialen Anteil, weil die Spitze auf der Kugel bleibt. Die Geschwindigkeit ist horizontal ($ve_theta$-Anteil null), wenn $cos(Omega_1 t) = 0$, also in den Umkehrlagen $theta = pi\/6 plus.minus theta_0$.
]

== Kreisbewegung und Winkelgeschwindigkeit

Der wichtigste Spezialfall: Ein Punkt läuft auf einem Kreis mit Radius $R$ um die $z$-Achse. Dann ist $rho = R$ und $z = z_0$ konstant, $dot(rho) = dot(z) = 0$, und die zylindrische Formel reduziert sich auf
$ vv = R dot(phi) ve_phi. $
Die Größe $dot(phi)$ heißt *Winkelschnelligkeit*. Die Schnelligkeit ist $R dot(phi)$ (der Weg pro Zeit auf dem Kreis), und die Richtung ist tangential, $vtau = ve_phi$.

Diese Formel hängt noch an der Wahl der Zylinderkoordinaten. Es gibt eine koordinatenfreie Form, und die ist der Schlüssel zum nächsten Kapitel. Mit $ve_phi = ve_z times ve_rho$ ist $vv = dot(phi) ve_z times R ve_rho$. Der Ortsvektor von $O$ auf der Achse zum Punkt ist $vr = R ve_rho + z_0 ve_z$. Weil $ve_z times ve_z = bold(0)$ ist, darf man $R ve_rho$ durch $vr$ ersetzen:
$ vv = dot(phi) ve_z times vr. $

#defn[Winkelgeschwindigkeit][
  Der Vektor $vom := dot(phi) ve_z$ heißt *Winkelgeschwindigkeit* der Kreisbewegung um die $z$-Achse. Er liegt _auf der Drehachse_, sein Betrag ist die Winkelschnelligkeit, sein Richtungssinn folgt der Rechte-Hand-Regel: Finger in Drehrichtung, Daumen zeigt in Richtung $vom$.
]

#fg("k02_kreis", [Kreisbewegung. Die Winkelgeschwindigkeit $vom$ liegt auf der Drehachse, die Geschwindigkeit $vv$ steht senkrecht auf $vom$ und auf $vr$.])

#satz[Geschwindigkeit bei Kreisbewegung][
  #gl($ vv = vom times vr. $)
  Dabei darf $vr$ von _irgendeinem_ Punkt der Drehachse aus gemessen werden. Der Betrag ist $|vv| = omega R$ mit dem Abstand $R$ von der Achse.
]

#intu[
  Das Kreuzprodukt schneidet automatisch den Anteil von $vr$ weg, der parallel zur Achse liegt (dort ist es null), und lässt nur den Abstand von der Achse übrig. Deshalb ist es egal, welchen Achsenpunkt man als Ursprung nimmt. Und weil das Kreuzprodukt senkrecht auf beiden Faktoren steht, ist $vv$ automatisch tangential zum Kreis. Die Formel $vv = vom times vr$ enthält also die ganze Geometrie der Kreisbewegung.
]

#fehler[
  - $dot(ve)_rho$ vergessen und $vv = dot(rho) ve_rho + dot(z) ve_z$ schreiben. Der Term $rho dot(phi) ve_phi$ entsteht genau aus der Drehung von $ve_rho$.
  - Schnelligkeit (Skalar $dot(s)$) und Geschwindigkeit (Vektor $vv$) verwechseln.
  - Bei $vv = vom times vr$ die Reihenfolge vertauschen: $vr times vom$ hat das falsche Vorzeichen.
  - Die Winkelgeschwindigkeit in Grad pro Sekunde einsetzen. In allen Formeln muss $phi$ im _Bogenmaß_ sein.
]

#bsp[Aufgabe: Bewegung mit $s^2 prop t$][
  Ein Punkt bewege sich so auf einer Geraden, dass er bei $t = 0$ in $O$ ist und das Quadrat der Bogenlänge der Zeit proportional ist: $s^2 = k t$. Auf der Geraden liegen die Punkte $A$ bei $s = L$ und $B$ bei $s = 2L$. Die Strecke $A B$ wird in der Zeit $T$ durchlaufen. Gesucht: Bewegungsgleichung, Durchlaufzeiten, Schnelligkeiten.

  _Konstante $k$:_ Zeit bis $A$: $t_A = L^2\/k$; bis $B$: $t_B = 4L^2\/k$. Differenz $= T$: $3L^2\/k = T$, also $k = 3L^2\/T$.

  _Bewegungsgleichung:_ $s(t) = sqrt(k t) = L sqrt(3t\/T)$.

  _Zeiten:_ $t_A = T\/3$, $t_B = 4T\/3$.

  _Schnelligkeit:_ $dot(s) = (1\/2) sqrt(k\/t)$. In $A$: $dot(s) = (1\/2) sqrt((3L^2\/T)\/(T\/3)) = 3L\/(2T)$. In $B$: $dot(s) = (1\/2) sqrt((3L^2\/T)\/(4T\/3)) = 3L\/(4T)$. Der Punkt wird unterwegs langsamer, wie man es bei einer Wurzelfunktion erwartet.
]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Tacho, Blitzer und Fahrtschreiber.* Der Tacho zeigt die Momentangeschwindigkeit, also die Ableitung $dot(vr)$ des Ortes. Ein Blitzer auf der Autobahn misst sie direkt (Radar nutzt den Doppler-Effekt). Ein Abschnittskontrolle dagegen misst die _mittlere_ Geschwindigkeit: Strecke durch Zeit zwischen zwei Kameras. Beides ist richtig, aber es sind zwei verschiedene Grössen. Wer gerade 30 s lang 140 km/h gefahren ist, kann trotzdem im Mittel unter 100 km/h liegen.]

#alltag[*Warum man in der Kurve nach aussen gedrückt wird.* Auf einer Kreisbahn ändert sich die Richtung der Geschwindigkeit ständig, obwohl der Betrag konstant bleibt. Eine Richtungsänderung ist eine Beschleunigung, nämlich $a = v^2\/r$ nach innen. Bei 90 km/h ($25$ m/s) in einer Kurve mit $r = 100$ m sind das $6.25$ m/s², fast zwei Drittel der Erdbeschleunigung. Das spürt der Körper als «Kraft nach aussen»; in Wahrheit will er nur geradeaus weiter.]
// ALLTAG-END

#aufgaben()

#aufg(fig: "a02_bahn", fw: 5.4cm)[Bahnkurve, Schnelligkeit und Tangente][
  Ein Punkt $M$ bewegt sich gemäß
  $ vr(t) = (a t, thick a t, thick b a^2 t^2) $
  (kartesische Komponenten, $a, b > 0$ konstant). Gesucht sind die Form der Bahn, die Geschwindigkeit $vv(t)$, die Schnelligkeit $dot(s)(t)$, der Tangenteneinheitsvektor $vtau(t)$ und die Schnelligkeit im Punkt $P = (a, a, b a^2)$.
][
  _Bahn._ Aus $x = a t$, $y = a t$, $z = b a^2 t^2$ folgt $x = y$ und $z = b x^2$: eine Parabel in der vertikalen Ebene $x = y$.

  _Geschwindigkeit._ Komponentenweise ableiten: $vv = dot(vr) = (a, thick a, thick 2 b a^2 t)$.

  _Schnelligkeit._ $dot(s) = |vv| = sqrt(a^2 + a^2 + 4 b^2 a^4 t^2) = a sqrt(2 + 4 b^2 a^2 t^2)$. Sie wächst mit der Zeit, weil die $z$-Komponente wächst.

  _Tangente._ $vtau = vv \/ |vv| = (1, thick 1, thick 2 b a t) \/ sqrt(2 + 4 b^2 a^2 t^2)$. Kontrolle: Bei $t = 0$ ist $vtau = (1, 1, 0)\/sqrt(2)$, horizontal längs der Diagonalen, wie es zum Scheitel der Parabel passt.

  _Punkt $P$._ $vr(t_P) = (a, a, b a^2)$ verlangt $t_P = 1$, also $dot(s)_P = a sqrt(2 + 4 b^2 a^2)$.
]

#kurz[
  - $vv = dot(vr) = dot(s) vtau$, immer tangential zur Bahn. Schnelligkeit $|dot(s)|$ = Betrag der Geschwindigkeit.
  - Produktregeln gelten wie gewohnt; Vektor konstanter Länge: $dot(vr) perp vr$.
  - Kartesisch: $vv = dot(x) ve_x + dot(y) ve_y + dot(z) ve_z$.
  - Zylindrisch: $vv = dot(rho) ve_rho + rho dot(phi) ve_phi + dot(z) ve_z$, weil $dot(ve)_rho = dot(phi) ve_phi$ und $dot(ve)_phi = -dot(phi) ve_rho$.
  - Sphärisch: $vv = dot(r) ve_r + r dot(theta) ve_theta + r sin theta dot(psi) ve_psi$.
  - Kreisbewegung: $vv = vom times vr$ mit $vom = dot(phi) ve_z$ auf der Achse, $|vv| = omega R$.
]
