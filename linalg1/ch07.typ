#import "lib.typ": *

= Orthogonale Matrizen geometrisch, Isometrien und LR-Zerlegung

#woche(7, [Geometrie orthogonaler Matrizen, LR-Zerlegung], [Skalarprodukt · Isometrien · Drehungen und Spiegelungen in der Ebene · LR-Zerlegung])

#vorlesung[Orthogonale Matrizen haben wir letzte Woche algebraisch eingeführt ($Q^tp Q = I$). Heute erfahren wir, was sie *geometrisch* tun: Sie sind genau die Matrizen, die Längen und Winkel nicht verändern, also Drehungen und Spiegelungen. Danach kehren wir zum Rechnen zurück: Das Gauss-Verfahren lässt sich als Produkt zweier Dreiecksmatrizen aufschreiben, die *LR-Zerlegung*. Sie ist der Grund, warum Computer Gleichungssysteme so schnell lösen.]

== Skalarprodukt, Länge und Winkel

Wir brauchen zuerst saubere Begriffe. Für $bold(x), bold(y) in RR^n$ ist das *Skalarprodukt* $bold(x) dot bold(y) = bold(x)^tp bold(y) = x_1 y_1 + dots + x_n y_n$ und die *Länge* $|bold(x)| = sqrt(bold(x) dot bold(x))$ (Woche 3).

#satz[Eigenschaften des Skalarprodukts][Für $bold(x), bold(y), bold(z) in RR^n$ und $c in RR$ gilt:
+ *Symmetrie:* $bold(x) dot bold(y) = bold(y) dot bold(x)$.
+ *Linearität:* $(bold(x) + c bold(y)) dot bold(z) = bold(x) dot bold(z) + c (bold(y) dot bold(z))$.
+ *Positivität:* $bold(x) dot bold(x) >= 0$, und $bold(x) dot bold(x) = 0$ nur für $bold(x) = bold(0)$.
+ *Cauchy-Schwarz-Ungleichung:* $|bold(x) dot bold(y)| <= |bold(x)| |bold(y)|$.
]

#beweis[(1)-(3) folgen aus der Definition. Zu (4): Für $bold(y) = bold(0)$ ist nichts zu zeigen. Sonst betrachte für $t in RR$ die Zahl $0 <= |bold(x) - t bold(y)|^2 = |bold(x)|^2 - 2t (bold(x) dot bold(y)) + t^2 |bold(y)|^2$. Setzt man $t = (bold(x) dot bold(y))\/|bold(y)|^2$ ein, so wird das zu $|bold(x)|^2 - (bold(x) dot bold(y))^2\/|bold(y)|^2 >= 0$, und das ist die Behauptung.]

Wegen Cauchy-Schwarz liegt $(bold(x) dot bold(y))\/(|bold(x)| |bold(y)|)$ immer zwischen $-1$ und $1$. Das macht die folgende Definition möglich, die in der Ebene und im Raum mit dem gewohnten Winkel übereinstimmt (Kosinussatz):

#defn[Winkel][Der *Winkel* $theta in [0, pi]$ zwischen $bold(x) != bold(0)$ und $bold(y) != bold(0)$ ist durch
$ cos theta = (bold(x) dot bold(y)) / (|bold(x)| |bold(y)|) $
festgelegt. Insbesondere stehen $bold(x)$ und $bold(y)$ senkrecht genau dann, wenn $bold(x) dot bold(y) = 0$.]

Beispiel: $bold(x) = (1, 1, 0)$ und $bold(y) = (0, 1, 1)$ haben $bold(x) dot bold(y) = 1$ und $|bold(x)| = |bold(y)| = sqrt(2)$, also $cos theta = 1\/2$ und $theta = pi\/3 = 60 degree$.

== Orthogonale Matrizen erhalten Längen und Winkel

#satz[Orthogonale Matrizen sind winkel- und längentreu][Für $Q in RR^(n times n)$ sind äquivalent:
+ $Q$ ist orthogonal ($Q^tp Q = I$).
+ $Q$ erhält das Skalarprodukt: $(Q bold(x)) dot (Q bold(y)) = bold(x) dot bold(y)$ für alle $bold(x), bold(y)$.
+ $Q$ erhält die Länge: $|Q bold(x)| = |bold(x)|$ für alle $bold(x)$.
Dann erhält $Q$ auch alle Winkel.]

#beweis[(1) $arrow.r$ (2): $(Q bold(x)) dot (Q bold(y)) = (Q bold(x))^tp (Q bold(y)) = bold(x)^tp Q^tp Q bold(y) = bold(x)^tp bold(y)$. (2) $arrow.r$ (3): Setze $bold(y) = bold(x)$. (3) $arrow.r$ (2): Man kann das Skalarprodukt aus Längen berechnen (*Polarisation*): $bold(x) dot bold(y) = 1/2 (|bold(x) + bold(y)|^2 - |bold(x)|^2 - |bold(y)|^2)$. Erhält $Q$ alle Längen, so auch $|Q bold(x) + Q bold(y)|^2 = |Q(bold(x) + bold(y))|^2 = |bold(x) + bold(y)|^2$, und es folgt (2). (2) $arrow.r$ (1): Mit den Einheitsvektoren $bold(x) = bold(e)_i$, $bold(y) = bold(e)_j$ ist $(Q bold(e)_i) dot (Q bold(e)_j) = bold(q)_i dot bold(q)_j = bold(e)_i dot bold(e)_j = delta_(i j)$: Die Spalten sind orthonormal, also $Q^tp Q = I$. Winkel: $cos$ des Winkels besteht aus Skalarprodukt und Längen, die alle erhalten bleiben.]

#intu[Eine orthogonale Matrix ist ein «starrer Körper»-Vorgang: Man dreht und spiegelt die ganze Ebene oder den ganzen Raum, ohne etwas zu dehnen oder zu scheren. Abstände, Winkel und Flächeninhalte bleiben, wie sie sind.]

== Isometrien

#defn[Isometrie][Eine Abbildung $f: RR^n arrow.r RR^n$ heisst *Isometrie* (abstandserhaltend), wenn $|f(bold(x)) - f(bold(y))| = |bold(x) - bold(y)|$ für alle $bold(x), bold(y)$ gilt.]

Beispiele: Verschiebungen $bold(x) arrow.r.bar bold(x) + bold(b)$, Drehungen, Spiegelungen und alle Hintereinanderausführungen davon (die «Bewegungen» der Geometrie).

#satz[Lineare Isometrien][Eine *lineare* Abbildung $bold(x) arrow.r.bar Q bold(x)$ ist genau dann eine Isometrie, wenn $Q$ orthogonal ist.]

#beweis[Wegen $|Q bold(x) - Q bold(y)| = |Q(bold(x) - bold(y))|$ ist die Isometrie-Bedingung die Längentreue von $Q$ aus dem vorigen Satz.]

Allgemeiner gilt (ohne Beweis): *Jede* Isometrie des $RR^n$ hat die Form $bold(x) arrow.r.bar Q bold(x) + bold(b)$ mit orthogonalem $Q$ und einem Vektor $bold(b)$. Isometrien sind also «orthogonale Matrix plus Verschiebung».

== Drehungen und Spiegelungen in der Ebene

Wie sehen die orthogonalen $2 times 2$-Matrizen aus? Die erste Spalte ist ein Einheitsvektor, also $(cos phi.alt, sin phi.alt)^tp$ für einen Winkel $phi.alt$. Die zweite Spalte ist ein Einheitsvektor senkrecht dazu, also $plus.minus (-sin phi.alt, cos phi.alt)^tp$. Es gibt genau zwei Möglichkeiten:

#satz[Orthogonale $2 times 2$-Matrizen][Jede orthogonale $2 times 2$-Matrix hat eine der beiden Formen
$ R(phi.alt) = mat(cos phi.alt, -sin phi.alt; sin phi.alt, cos phi.alt) quad "oder" quad S(alpha) = mat(cos 2 alpha, sin 2 alpha; sin 2 alpha, -cos 2 alpha). $
$R(phi.alt)$ ist die *Drehung um den Nullpunkt um den Winkel $phi.alt$* (gegen den Uhrzeigersinn), $S(alpha)$ ist die *Spiegelung an der Geraden durch den Nullpunkt mit Richtung $(cos alpha, sin alpha)$*. Es gilt $det R = 1$ und $det S = -1$.]

#fgs(("l07_orig", "l07_rot", "l07_spieg"), [Ein «F» und seine Bilder unter einer Drehung um $60 degree$ und einer Spiegelung an der Geraden mit Winkel $30 degree$. Die Spiegelung kehrt die Orientierung um (das F steht danach spiegelverkehrt), die Drehung nicht.])

#warum[Warum diese Matrix dreht][Die Spalten einer Matrix sind die *Bilder der Einheitsvektoren*: $A bold(e)_1 = $ erste Spalte, $A bold(e)_2 = $ zweite Spalte. Eine Drehung um $phi.alt$ schickt $bold(e)_1 = (1, 0)$ auf $(cos phi.alt, sin phi.alt)$ und $bold(e)_2 = (0, 1)$ auf $(-sin phi.alt, cos phi.alt)$. Das sind genau die Spalten von $R(phi.alt)$. (Dass jede *lineare* Abbildung durch die Bilder der Einheitsvektoren festgelegt ist, sehen wir in Woche 14.) Bei der Spiegelung an der Geraden mit Winkel $alpha$ wird $bold(e)_1$ auf den Punkt mit Winkel $2 alpha$ gespiegelt, also auf $(cos 2 alpha, sin 2 alpha)$.]

#bsp[Spezielle Fälle][
- $R(90 degree) = mat(0, -1; 1, 0)$: Der Vektor $(1, 2)$ wird zu $(-2, 1)$. Die Drehung um $180 degree$ ist $R(180 degree) = -I$.
- $S(0) = mat(1, 0; 0, -1)$: Spiegelung an der $x_1$-Achse. $S(45 degree) = mat(0, 1; 1, 0)$: Spiegelung an der Winkelhalbierenden $x_2 = x_1$ (vertauscht die Koordinaten).
- Die Givens-Rotation aus Woche 6 mit $c = cos phi.alt$ und $s = sin phi.alt$ ist $mat(c, s; -s, c) = R(-phi.alt)$: eine Drehung im Uhrzeigersinn.
- Die Householder-Matrix $H = I - 2 bold(v) bold(v)^tp\/(bold(v)^tp bold(v))$ in der Ebene ist eine Spiegelung (an der Geraden senkrecht zu $bold(v)$), $det H = -1$.
]

#satz[Zusammensetzen][Es gilt:
+ $R(phi.alt) R(psi) = R(phi.alt + psi)$: Drehungen addieren ihre Winkel (und kommutieren).
+ $S(alpha) S(beta) = R(2 (alpha - beta))$: *Zwei Spiegelungen ergeben eine Drehung* um den doppelten Winkel zwischen den Achsen.
+ $R(phi.alt) S(alpha) = S(alpha + phi.alt\/2)$ und $S(alpha) R(phi.alt) = S(alpha - phi.alt\/2)$: Spiegelung und Drehung ergeben eine Spiegelung.
+ $S(alpha)^2 = I$ und $R(phi.alt)^(-1) = R(-phi.alt) = R(phi.alt)^tp$.]

#beweis[Alles folgt durch Ausmultiplizieren mit den Additionstheoremen $cos(a + b) = cos a cos b - sin a sin b$ und $sin(a + b) = sin a cos b + cos a sin b$. Zum Beispiel ist der Eintrag $(1, 1)$ von $R(phi.alt) R(psi)$ gleich $cos phi.alt cos psi - sin phi.alt sin psi = cos(phi.alt + psi)$, und der Eintrag $(2, 1)$ ist $sin phi.alt cos psi + cos phi.alt sin psi = sin(phi.alt + psi)$. Die anderen Fälle sind analog.]

#alltag[Dass zwei Spiegelungen eine Drehung ergeben, steckt in jedem Kaleidoskop und im Strahlengang zweier Spiegel (Periskop). In der Computergrafik zerlegt man Drehungen im Raum gern in Spiegelungen (Householder). In der Robotik, auch beim Ballbot, beschreibt man die Lage jedes Roboterglieds durch Drehmatrizen; die Verkettung der Gelenke ist ein Produkt solcher Matrizen.]

#kontrolle[Welche Matrix beschreibt «erst um $90 degree$ drehen, dann an der $x_1$-Achse spiegeln»? Ist das eine Drehung oder eine Spiegelung?][$S(0) R(90 degree) = mat(1, 0; 0, -1) mat(0, -1; 1, 0) = mat(0, -1; -1, 0)$. Die Determinante ist $-1$: eine Spiegelung (und zwar an der Geraden $x_2 = -x_1$, also $S(-45 degree)$).]

== Die LR-Zerlegung

#idee[Wenn man viele Gleichungssysteme $A bold(x) = bold(b)$ mit *derselben* Matrix $A$ und verschiedenen rechten Seiten lösen muss (Simulation mit wechselnden Kräften, Zeitschritte, ...), wäre es Verschwendung, jedes Mal von vorn zu eliminieren. Die LR-Zerlegung *merkt sich* die Eliminationsschritte als Matrix.]

Bringt man $A$ durch Zeilenumformungen vom Typ «Vielfaches einer *oberen* Zeile zu einer *unteren* addieren» (ohne Vertauschen) auf obere Dreiecksform $R$, so ist das $E_k dots E_2 E_1 A = R$ mit Elementarmatrizen $E_j$ (Woche 5). Also
$ A = E_1^(-1) E_2^(-1) dots E_k^(-1) R = L R, quad L = E_1^(-1) dots E_k^(-1). $
Die Inverse von «$Z_i arrow.r Z_i - l Z_k$» ist «$Z_i arrow.r Z_i + l Z_k$». Das Besondere: Das Produkt $L$ dieser Matrizen ist *untere Dreiecksmatrix mit Einsen auf der Diagonale*, und die Faktoren $l_(i k)$ stehen einfach *unverändert* an der Stelle $(i, k)$ von $L$.

#defn[LR-Zerlegung][Eine *LR-Zerlegung* von $A in RR^(n times n)$ ist eine Darstellung $A = L R$ mit einer *unteren Dreiecksmatrix* $L$ mit lauter Einsen auf der Diagonale und einer *oberen Dreiecksmatrix* $R$. (Im Englischen: LU-Zerlegung, «lower» und «upper».)]

#fg("l07_lr", [Form der LR-Zerlegung: $L$ unten links (mit Einsen auf der Diagonale), $R$ oben rechts.], w: 90%)

#rezept[LR-Zerlegung berechnen][
  + Eliminiere $A$ mit dem Gauss-Verfahren zur oberen Dreiecksform $R$, *ohne Zeilen zu vertauschen*.
  + Beim Umformen $Z_i arrow.r Z_i - l_(i k) Z_k$ (mit $l_(i k) = a_(i k)^((k)) \/ a_(k k)^((k))$, der aktuelle Eintrag geteilt durch den Pivot) schreibe den *Faktor* $l_(i k)$ an die Stelle $(i, k)$ von $L$.
  + $L$ hat Einsen auf der Diagonale und Nullen oberhalb.
]

#bsp[LR-Zerlegung einer $3 times 3$-Matrix][
$ A = mat(2, 1, 1; 4, 3, 3; 8, 7, 9). $
*Spalte 1* (Pivot $2$): $l_(21) = 4\/2 = 2$ und $l_(31) = 8\/2 = 4$. Mit $Z_2 - 2 Z_1$ und $Z_3 - 4 Z_1$:
$ mat(2, 1, 1; 0, 1, 1; 0, 3, 5). $
*Spalte 2* (Pivot $1$): $l_(32) = 3\/1 = 3$. Mit $Z_3 - 3 Z_2$:
$ R = mat(2, 1, 1; 0, 1, 1; 0, 0, 2), quad L = mat(1, 0, 0; 2, 1, 0; 4, 3, 1). $
*Probe:* $L R = mat(1, 0, 0; 2, 1, 0; 4, 3, 1) mat(2, 1, 1; 0, 1, 1; 0, 0, 2) = mat(2, 1, 1; 4, 2 + 1, 2 + 1; 8, 4 + 3, 4 + 3 + 2) = mat(2, 1, 1; 4, 3, 3; 8, 7, 9) = A$ ✓.
]

#warum[Warum stehen die Faktoren unverändert in $L$][Die Elementarmatrix zu $Z_i arrow.r Z_i - l Z_k$ ist $E = I - l bold(e)_i bold(e)_k^tp$, ihre Inverse $E^(-1) = I + l bold(e)_i bold(e)_k^tp$. Multipliziert man diese Inversen in der Reihenfolge der Eliminationsschritte, so treten in den Produkten $bold(e)_i bold(e)_k^tp bold(e)_(i') bold(e)_(k')^tp$ nur dann Terme $!= 0$ auf, wenn $k = i'$. Weil man in Spalte $k$ nur Zeilen $i > k$ bearbeitet und die Spalten der Reihe nach, ist das nie der Fall. Alle Kreuzterme verschwinden und $L = I + sum l_(i k) bold(e)_i bold(e)_k^tp$: die Faktoren stehen einfach in $L$.]

#satz[Existenz und Eindeutigkeit][
+ Ist bei der Elimination ohne Zeilenvertauschung nie ein Pivot $0$, so existiert die LR-Zerlegung $A = L R$ mit $L$ wie oben.
+ Ist $A$ regulär und existiert eine LR-Zerlegung, so ist sie *eindeutig*.]

#beweis[(1) siehe oben. (2) Seien $A = L_1 R_1 = L_2 R_2$ mit regulären $L_i, R_i$ (regulär, da $A$ regulär ist). Dann ist $L_2^(-1) L_1 = R_2 R_1^(-1)$. Links steht eine untere Dreiecksmatrix mit Einsen auf der Diagonale (Produkt und Inverse solcher Matrizen haben wieder diese Form), rechts eine obere Dreiecksmatrix. Eine Matrix, die beides ist, ist eine Diagonalmatrix, und mit den Einsen auf der Diagonale gleich $I$. Also $L_1 = L_2$ und $R_1 = R_2$.]

Eine Zerlegung existiert aber *nicht immer*: Bei $A = mat(0, 1; 1, 1)$ ist schon der erste Pivot $0$. Dafür braucht man Zeilenvertauschungen (nächste Woche: $P A = L R$).

#kurz[
- *Skalarprodukt* $bold(x)^tp bold(y)$, Länge $sqrt(bold(x) dot bold(x))$, Winkel $cos theta = (bold(x) dot bold(y))\/(|bold(x)||bold(y)|)$; Cauchy-Schwarz $|bold(x) dot bold(y)| <= |bold(x)||bold(y)|$.
- $Q$ orthogonal $arrow.l.r.double$ $Q$ erhält Skalarprodukt $arrow.l.r.double$ $Q$ erhält Längen. Lineare Isometrien sind genau die orthogonalen Matrizen.
- In der Ebene: $R(phi.alt)$ (Drehung, $det = 1$) und $S(alpha)$ (Spiegelung, $det = -1$). $R(phi.alt) R(psi) = R(phi.alt + psi)$, $S(alpha) S(beta) = R(2(alpha - beta))$.
- *LR-Zerlegung* $A = L R$: $R$ = Ergebnis des Gauss-Verfahrens, $L$ speichert die Eliminationsfaktoren (Einsen auf der Diagonale). Eindeutig, wenn sie existiert und $A$ regulär ist; existiert nicht, wenn ein Pivot $0$ ist.
]

#aufgaben()

#aufg("Winkel und Länge", [Berechne den Winkel zwischen $bold(x) = (1, 2, 2)$ und $bold(y) = (2, 1, -2)$ und die Längen beider Vektoren. Sind sie orthogonal?],
[$bold(x) dot bold(y) = 2 + 2 - 4 = 0$. Also stehen sie senkrecht: $theta = 90 degree$. $|bold(x)| = sqrt(1 + 4 + 4) = 3$, $|bold(y)| = sqrt(4 + 1 + 4) = 3$.])

#aufg("Drehung und Spiegelung", [Bestimme die Matrix der Drehung um $60 degree$ und der Spiegelung an der Geraden mit Winkel $30 degree$. Zeige, dass das Produkt der beiden (in beiden Reihenfolgen) eine Spiegelung ist und gib die Spiegelachse an.],
[$R(60 degree) = mat(1\/2, -sqrt(3)\/2; sqrt(3)\/2, 1\/2)$, $S(30 degree) = mat(1\/2, sqrt(3)\/2; sqrt(3)\/2, -1\/2)$. Nach dem Satz: $R(60 degree) S(30 degree) = S(30 degree + 30 degree) = S(60 degree)$ und $S(30 degree) R(60 degree) = S(30 degree - 30 degree) = S(0) = mat(1, 0; 0, -1)$. Beide sind Spiegelungen (Determinante $-1$), aber an *verschiedenen* Achsen (Winkel $60 degree$ bzw. $0 degree$): Das Produkt ist nicht kommutativ.])

#aufg("Zwei Spiegelungen", [Zeige: Die Matrix $mat(0, 1; 1, 0) mat(1, 0; 0, -1)$ ist eine Drehung. Um welchen Winkel?],
[$mat(0, 1; 1, 0) mat(1, 0; 0, -1) = mat(0, -1; 1, 0) = R(90 degree)$. Das ist $S(45 degree) S(0) = R(2 (45 degree - 0)) = R(90 degree)$ ✓.])

#aufg("LR-Zerlegung", [Berechne die LR-Zerlegung von $A = mat(1, 2, 1; 3, 8, 5; 2, 7, 7)$ und löse damit $A bold(x) = bold(b)$ für $bold(b) = (4, 16, 14)^tp$.],
[Spalte 1: $l_(21) = 3$, $l_(31) = 2$. $Z_2 - 3 Z_1$: $(0, 2, 2)$; $Z_3 - 2 Z_1$: $(0, 3, 5)$. Spalte 2: $l_(32) = 3\/2$. $Z_3 - (3\/2) Z_2$: $(0, 0, 5 - 3) = (0, 0, 2)$. $R = mat(1, 2, 1; 0, 2, 2; 0, 0, 2)$, $L = mat(1, 0, 0; 3, 1, 0; 2, 3\/2, 1)$. Lösen: $L bold(y) = bold(b)$ (vorwärts): $y_1 = 4$, $y_2 = 16 - 12 = 4$, $y_3 = 14 - 8 - 6 = 0$. $R bold(x) = bold(y)$ (rückwärts): $x_3 = 0$, $x_2 = (4 - 0)\/2 = 2$, $x_1 = 4 - 4 - 0 = 0$. Lösung $(0, 2, 0)$. Probe: $A (0, 2, 0)^tp = (4, 16, 14)^tp$ ✓.])

#aufg("Orthogonal oder nicht?", [Ist $A = 1/3 mat(1, 2, 2; 2, 1, -2; 2, -2, 1)$ orthogonal? Berechne $A^tp A$.],
[Die Spalten haben die Länge $sqrt(1 + 4 + 4)\/3 = 1$. Skalarprodukt der ersten und zweiten Spalte: $(2 + 2 - 4)\/9 = 0$; erste und dritte: $(2 - 4 + 2)\/9 = 0$; zweite und dritte: $(4 - 2 - 2)\/9 = 0$. Also $A^tp A = I$: $A$ ist orthogonal. Sie ist ausserdem symmetrisch ($a_(12) = a_(21) = 2\/3$, $a_(13) = a_(31) = 2\/3$, $a_(23) = a_(32) = -2\/3$), also gilt $A^(-1) = A^tp = A$: $A$ ist die Householder-Matrix zu $bold(v) = (1, -1, -1)$, also die Spiegelung des $RR^3$ an der Ebene senkrecht zu $bold(v)$.])
