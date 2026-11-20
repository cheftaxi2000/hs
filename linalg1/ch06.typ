#import "lib.typ": *

= Die inverse Matrix und orthogonale Matrizen

#woche(6, [Inverse, orthogonale Matrizen, Givens, Householder], [inverse Matrix · regulär / singulär · Gauss-Jordan · orthogonale Matrizen · Givens-Rotation · Householder-Matrix])

#vorlesung[Gleichungen wie $2 x = 6$ löst man, indem man mit dem *Kehrwert* $2^(-1)$ multipliziert. Gibt es so etwas auch für $A bold(x) = bold(b)$? Das ist die Frage nach der inversen Matrix. Wir lernen, wann sie existiert, wie man sie ausrechnet (Gauss-Jordan) und welche Rechenregeln gelten. Dann treffen wir eine Klasse von Matrizen, deren Inverse man *geschenkt* bekommt: die orthogonalen Matrizen. Zwei davon (Givens-Rotation und Householder-Spiegelung) sind die Werkzeuge der modernen numerischen Linearen Algebra.]

== Die inverse Matrix

#idee[Zu einer Zahl $a != 0$ gibt es den Kehrwert $a^(-1)$ mit $a a^(-1) = 1$. Die Einheitsmatrix $I$ spielt die Rolle der Eins. Zu einer *quadratischen* Matrix $A$ sucht man deshalb eine Matrix $A^(-1)$ mit $A A^(-1) = I = A^(-1) A$. Wenn es sie gibt, löst $bold(x) = A^(-1) bold(b)$ das System $A bold(x) = bold(b)$: Man multipliziert beide Seiten von links mit $A^(-1)$.]

#defn[Inverse, regulär, singulär][Eine quadratische Matrix $A in RR^(n times n)$ heisst *regulär* (oder *invertierbar*), wenn es eine Matrix $B in RR^(n times n)$ gibt mit
$ A B = B A = I. $
$B$ heisst dann die *inverse Matrix* von $A$, geschrieben $A^(-1)$. Eine Matrix, die nicht invertierbar ist, heisst *singulär*.]

#satz[Eindeutigkeit][Die Inverse einer regulären Matrix ist eindeutig.]

#beweis[Seien $B$ und $C$ beide Inverse von $A$. Dann ist $B = B I = B (A C) = (B A) C = I C = C$.]

Nur *quadratische* Matrizen können invertierbar sein. Nicht jede quadratische Matrix ist es: $A = mat(1, 2; 2, 4)$ ist singulär, denn die Gleichung $A bold(x) = bold(0)$ hat die nichttriviale Lösung $bold(x) = (2, -1)^tp$. Wäre $A$ invertierbar, so folgte $bold(x) = A^(-1) A bold(x) = A^(-1) bold(0) = bold(0)$. Allgemein gilt: *Eine Matrix, die einen Vektor $bold(x) != bold(0)$ auf null abbildet, kann nicht invertierbar sein.*

=== Die Inverse einer $2 times 2$-Matrix

#satz[Formel für $2 times 2$][Die Matrix $A = mat(a, b; c, d)$ ist genau dann regulär, wenn $a d - b c != 0$. Dann ist
$ A^(-1) = 1/(a d - b c) mat(d, -b; -c, a). $]

#beweis[Nachrechnen: $mat(a, b; c, d) mat(d, -b; -c, a) = mat(a d - b c, -a b + a b; c d - c d, -c b + d a) = (a d - b c) I$. Ist $a d - b c != 0$, so teilt man durch diesen Wert. Ist $a d - b c = 0$, so löst $bold(x) = (d, -c)^tp$ bzw. $(-b, a)^tp$ das HLGS $A bold(x) = bold(0)$ (eines der beiden ist $!= bold(0)$, sonst wäre $A = 0$), also ist $A$ singulär.]

Die Zahl $a d - b c$ ist die *Determinante* von $A$ (Woche 8). Beispiel: $mat(2, 1; 5, 3)^(-1) = 1/(6 - 5) mat(3, -1; -5, 2) = mat(3, -1; -5, 2)$. Probe: $mat(2, 1; 5, 3) mat(3, -1; -5, 2) = mat(6 - 5, -2 + 2; 15 - 15, -5 + 6) = I$ ✓.

== Das Gauss-Jordan-Verfahren

Wie findet man die Inverse bei grösseren Matrizen? Gesucht ist $X$ mit $A X = I$. Schreibt man $X = (bold(x)_1 | dots | bold(x)_n)$ und $I = (bold(e)_1 | dots | bold(e)_n)$ mit den Spalten $bold(e)_j$ der Einheitsmatrix, so bedeutet $A X = I$ nach der Spaltenstruktur (Woche 5):
$ A bold(x)_1 = bold(e)_1, quad A bold(x)_2 = bold(e)_2, quad dots, quad A bold(x)_n = bold(e)_n. $
Das sind $n$ lineare Gleichungssysteme mit *derselben* Koeffizientenmatrix $A$. Man löst sie *gleichzeitig* mit einer erweiterten Matrix mit $n$ rechten Seiten: $(A | I)$.

#rezept[Gauss-Jordan-Algorithmus][
  + Schreibe $(A | I)$ auf.
  + Forme mit Zeilenumformungen so um, dass links die *reduzierte Zeilenstufenform* steht: Erzeuge zuerst Nullen unter den Pivots (Gauss), dann Nullen über den Pivots, und mache die Pivots zu $1$.
  + Steht links die Einheitsmatrix, so steht rechts $A^(-1)$: $(A | I) arrow.r dots arrow.r (I | A^(-1))$.
  + Erscheint links eine Nullzeile (also Rang $< n$), ist $A$ *singulär*; es gibt keine Inverse.
]

#beweis[Warum funktioniert das? Jede Zeilenumformung ist eine Multiplikation von links mit einer Elementarmatrix $E_i$ (Woche 5), und sie wirkt auf beide Hälften der Matrix. Am Ende gilt $E_k dots E_1 A = I$ und rechts steht $E_k dots E_1 I = E_k dots E_1$. Aus $E_k dots E_1 A = I$ folgt, dass $E_k dots E_1$ eine Linksinverse von $A$ ist. Dass sie auch Rechtsinverse ist, zeigt der Satz unten.]

#bsp[Inverse einer $3 times 3$-Matrix][
$ A = mat(1, 2, 3; 0, 1, 4; 5, 6, 0). $
$ mat(1, 2, 3, 1, 0, 0; 0, 1, 4, 0, 1, 0; 5, 6, 0, 0, 0, 1) zu(Z_3 - 5 Z_1) mat(1, 2, 3, 1, 0, 0; 0, 1, 4, 0, 1, 0; 0, -4, -15, -5, 0, 1) zu(Z_3 + 4 Z_2) mat(1, 2, 3, 1, 0, 0; 0, 1, 4, 0, 1, 0; 0, 0, 1, -5, 4, 1). $
Das ist die Zeilenstufenform: drei Pivots, also $rang(A) = 3$ und $A$ ist regulär. Nun von unten nach oben die Nullen *über* den Pivots:
$ zu(Z_2 - 4 Z_3) mat(1, 2, 3, 1, 0, 0; 0, 1, 0, 20, -15, -4; 0, 0, 1, -5, 4, 1) zu(Z_1 - 3 Z_3) mat(1, 2, 0, 16, -12, -3; 0, 1, 0, 20, -15, -4; 0, 0, 1, -5, 4, 1) zu(Z_1 - 2 Z_2) mat(1, 0, 0, -24, 18, 5; 0, 1, 0, 20, -15, -4; 0, 0, 1, -5, 4, 1). $
$ A^(-1) = mat(-24, 18, 5; 20, -15, -4; -5, 4, 1). $
*Probe:* Erste Zeile von $A$ mal erste Spalte von $A^(-1)$: $1 dot (-24) + 2 dot 20 + 3 dot (-5) = -24 + 40 - 15 = 1$ ✓; erste Zeile mal zweite Spalte: $18 - 30 + 12 = 0$ ✓. (Vollständig: $A A^(-1) = I$.)
]

#merke[Die Probe $A A^(-1) = I$ lohnt sich immer, weil man beim Gauss-Jordan-Verfahren leicht ein Vorzeichen verliert.]

== Sätze über die Inverse

#satz[Charakterisierung regulärer Matrizen][Für $A in RR^(n times n)$ sind äquivalent:
+ $A$ ist regulär (invertierbar).
+ $rang(A) = n$.
+ Die reduzierte Zeilenstufenform von $A$ ist $I$.
+ Das HLGS $A bold(x) = bold(0)$ hat nur die triviale Lösung.
+ $A bold(x) = bold(b)$ ist für *jedes* $bold(b) in RR^n$ lösbar.
+ $A bold(x) = bold(b)$ ist für *jedes* $bold(b)$ *eindeutig* lösbar, und die Lösung ist $bold(x) = A^(-1) bold(b)$.
+ $A$ ist ein Produkt von Elementarmatrizen.]

Die Äquivalenz von (2)-(6) kennen wir schon aus Woche 4 (quadratische Systeme: Rang $n$ genau dann, wenn eindeutig lösbar für alle $bold(b)$). Der neue Inhalt ist die Verbindung zu (1) und (7). Aus Gauss-Jordan folgt: Ist $rang(A) = n$, so führt $E_k dots E_1 A = I$ auf $A = E_1^(-1) dots E_k^(-1)$, und die Inverse einer Elementarmatrix ist wieder eine (die der umgekehrten Umformung). Das zeigt (2) $arrow.r.double$ (7). Dass $A^(-1)$ wirklich von beiden Seiten inverse ist, sagt der folgende Satz.

#satz[Eine Seite genügt][Sind $A, B in RR^(n times n)$ und gilt $A B = I$, so gilt auch $B A = I$. (Bei quadratischen Matrizen muss man nur *eine* der beiden Gleichungen $A B = I$, $B A = I$ prüfen.)]

#beweis[Aus $A B = I$ folgt, dass $B bold(x) = bold(0)$ nur trivial lösbar ist (aus $B bold(x) = bold(0)$ folgt $bold(x) = I bold(x) = A B bold(x) = bold(0)$), also ist $rang(B) = n$, und $B$ ist regulär mit einer Inversen $C$ (Gauss-Jordan). Dann ist $A = A (B C) = (A B) C = C$, und $B A = B C = I$.]

Dieser Satz ist nur für *quadratische* Matrizen richtig: Für $A = mat(1, 0)$ ($1 times 2$) und $B = (1, 0)^tp$ ist $A B = (1)$, aber $B A = mat(1, 0; 0, 0) != I_2$.

#satz[Rechenregeln für Inverse][Sind $A, B in RR^(n times n)$ regulär und $c != 0$, so gilt:
+ $(A^(-1))^(-1) = A$.
+ $(A B)^(-1) = B^(-1) A^(-1)$ (*Reihenfolge dreht sich um!*)
+ $(A^tp)^(-1) = (A^(-1))^tp$.
+ $(c A)^(-1) = c^(-1) A^(-1)$.
Insbesondere ist $A B$ wieder regulär.]

#beweis[(1) $A^(-1) A = A A^(-1) = I$ sagt, dass $A$ die Inverse von $A^(-1)$ ist. (2) $(A B)(B^(-1) A^(-1)) = A (B B^(-1)) A^(-1) = A A^(-1) = I$. (3) Transponiere $A A^(-1) = I$: $(A^(-1))^tp A^tp = I^tp = I$; also ist $(A^(-1))^tp$ die Inverse von $A^tp$. (4) $(c A)(c^(-1) A^(-1)) = (c c^(-1)) A A^(-1) = I$.]

#fehler[
- $(A + B)^(-1) != A^(-1) + B^(-1)$. Es gibt *keine* Formel für die Inverse einer Summe.
- $(A B)^(-1) = A^(-1) B^(-1)$ ist falsch (ausser wenn $A$ und $B$ kommutieren): Es muss $B^(-1) A^(-1)$ heissen.
- Eine Matrix mit *einer* Nullzeile, einer Nullspalte oder zwei gleichen Zeilen ist singulär.
]

#bsp[Ein Produkt invertieren][Mit $A = mat(1, 2; 3, 5)$, $B = mat(2, 1; 1, 1)$: $A^(-1) = mat(-5, 2; 3, -1)$, $B^(-1) = mat(1, -1; -1, 2)$. Dann ist $(A B)^(-1) = B^(-1) A^(-1) = mat(1, -1; -1, 2) mat(-5, 2; 3, -1) = mat(-8, 3; 11, -4)$. (Direkt: $A B = mat(4, 3; 11, 8)$ mit Determinante $32 - 33 = -1$, $(A B)^(-1) = -1 dot mat(8, -3; -11, 4)$ ✓.)]

#alltag[Praktischer Hinweis: *Um $A bold(x) = bold(b)$ zu lösen, berechnet man in der Praxis nie $A^(-1)$.* Das Eliminationsverfahren braucht etwa $n^3\/3$ Multiplikationen, das Gauss-Jordan-Verfahren für die Inverse etwa $n^3$ und ist zudem numerisch ungenauer. Die Inverse ist ein Werkzeug zum *Denken* (Formeln, Beweise), nicht zum Rechnen mit grossen Matrizen. In einem Computerprogramm schreibt man deshalb «löse $A x = b$», nicht «$x = A^(-1) b$».]

== Orthogonale Matrizen

Es gibt Matrizen, deren Inverse man ohne jede Rechnung kennt:

#defn[Orthogonale Matrix][Eine quadratische Matrix $Q in RR^(n times n)$ heisst *orthogonal*, wenn $Q^tp Q = I$.]

#satz[Eigenschaften orthogonaler Matrizen][Für $Q in RR^(n times n)$ sind äquivalent:
+ $Q$ ist orthogonal ($Q^tp Q = I$).
+ $Q$ ist regulär und $Q^(-1) = Q^tp$ (und damit auch $Q Q^tp = I$).
+ Die *Spalten* von $Q$ sind *orthonormal*: Jede Spalte hat Länge $1$, und verschiedene Spalten stehen senkrecht aufeinander ($bold(q)_i dot bold(q)_j = delta_(i j)$).
+ Die *Zeilen* von $Q$ sind orthonormal.
Produkte und Inverse orthogonaler Matrizen sind orthogonal.]

#beweis[(1) $arrow.l.r.double$ (3): Der Eintrag $(i, j)$ von $Q^tp Q$ ist (Zeile $i$ von $Q^tp$) mal (Spalte $j$ von $Q$) $= bold(q)_i dot bold(q)_j$. Dass dies gleich $delta_(i j)$ ist, heisst genau: Spalten orthonormal. (1) $arrow.l.r.double$ (2): Nach dem Satz «Eine Seite genügt» folgt aus $Q^tp Q = I$ sofort $Q Q^tp = I$. (2) $arrow.l.r.double$ (4): Wende (3) auf $Q^tp$ an. Produkt: $(Q_1 Q_2)^tp (Q_1 Q_2) = Q_2^tp Q_1^tp Q_1 Q_2 = Q_2^tp Q_2 = I$. Inverse: $Q^(-1) = Q^tp$ ist ebenfalls orthogonal, da $(Q^tp)^tp Q^tp = Q Q^tp = I$.]

#bsp[Orthogonale Matrizen][
- $Q = mat(3\/5, 4\/5; -4\/5, 3\/5)$: Beide Spalten haben die Länge $sqrt(9\/25 + 16\/25) = 1$, und $(3\/5)(4\/5) + (-4\/5)(3\/5) = 0$ ✓. Ihre Inverse ist $Q^tp = mat(3\/5, -4\/5; 4\/5, 3\/5)$.
- Jede *Permutationsmatrix* (jede Zeile und Spalte enthält genau eine $1$), z. B. $mat(0, 1, 0; 0, 0, 1; 1, 0, 0)$.
- Die Einheitsmatrix; Drehungen und Spiegelungen (Woche 7).
]

Orthogonale Matrizen sind rechnerisch ein Geschenk: Die Inverse ist die Transponierte (also *gratis*), und, wie wir nächste Woche sehen, sie *verändern keine Längen und Winkel*, sodass sich Rundungsfehler nicht aufschaukeln.

=== Die Givens-Rotation

#idee[Wir wollen in einem Vektor einen Eintrag gezielt *zu null machen*, ohne ihn dabei zu verzerren. Das gelingt durch eine *Drehung* in der Ebene der beiden betroffenen Koordinaten.]

#defn[Givens-Rotation][Für Indizes $i < k$ und Zahlen $c, s$ mit $c^2 + s^2 = 1$ ist die *Givens-Rotation* $G_(i k)$ die Matrix, die aus $I_n$ entsteht, indem man die Einträge $(i,i)$, $(i,k)$, $(k,i)$, $(k,k)$ ersetzt:
$ G_(i k) = mat(1, , , , ; , c, , s, ; , , 1, , ; , -s, , c, ; , , , , 1) quad "(Zeilen und Spalten " i " und " k " sind die mit " c, s ")". $
Dabei ist $c = cos phi.alt$ und $s = sin phi.alt$ für einen Winkel $phi.alt$.]

Die Matrix $G_(i k)$ ist orthogonal (die beiden betroffenen Spalten sind orthonormal, alle anderen sind Einheitsvektoren), und sie *verändert nur die Koordinaten $i$ und $k$*: $(G_(i k) bold(x))_i = c x_i + s x_k$, $(G_(i k) bold(x))_k = -s x_i + c x_k$, alle anderen Einträge bleiben.

#satz[Eliminieren mit einer Givens-Rotation][Seien $x_i, x_k$ nicht beide $0$ und $r = sqrt(x_i^2 + x_k^2)$. Mit $c = x_i \/ r$ und $s = x_k \/ r$ gilt
$ (G_(i k) bold(x))_i = r, quad (G_(i k) bold(x))_k = 0. $]

#beweis[$(G bold(x))_i = (x_i^2 + x_k^2)\/r = r$ und $(G bold(x))_k = (-x_k x_i + x_i x_k)\/r = 0$. Ausserdem $c^2 + s^2 = (x_i^2 + x_k^2)\/r^2 = 1$.]

#fg("l06_givens", [Die Rotation dreht $bold(x) = (3, 4)$ auf die $x_1$-Achse. Die Länge bleibt erhalten: $5$.], w: 62%)

#bsp[Givens-Rotation][
$bold(x) = (3, 4)$: $r = 5$, $c = 3\/5$, $s = 4\/5$, $G = mat(3\/5, 4\/5; -4\/5, 3\/5)$, und $G bold(x) = (9\/5 + 16\/5, -12\/5 + 12\/5) = (5, 0)$ ✓. In $RR^3$ für $bold(x) = (3, 2, 4)$ mit $i = 1$, $k = 3$: $r = 5$, $c = 3\/5$, $s = 4\/5$, $G_(13) bold(x) = (5, 2, 0)$: Der dritte Eintrag ist weg, der zweite unverändert.
]

Mit einer Folge von Givens-Rotationen kann man ganze Matrizen auf Dreiecksform bringen ($Q^tp A = R$, die *QR-Zerlegung*). Das ist numerisch sehr stabil und besonders effizient für *dünn besetzte* Matrizen, weil jede Rotation nur zwei Zeilen anfasst.

=== Die Householder-Matrix

Die Givens-Rotation löscht einen Eintrag. Die *Householder-Spiegelung* löscht auf einen Schlag *alle Einträge unterhalb des ersten*.

#defn[Householder-Matrix][Zu einem Vektor $bold(v) in RR^n$, $bold(v) != bold(0)$, heisst
$ H = I - 2/(bold(v)^tp bold(v)) bold(v) bold(v)^tp $
die *Householder-Matrix* (oder Householder-Spiegelung) zu $bold(v)$.]

Hier ist $bold(v) bold(v)^tp$ eine $n times n$-Matrix (Spaltenvektor mal Zeilenvektor) und $bold(v)^tp bold(v) = |bold(v)|^2$ eine Zahl.

#satz[Eigenschaften][Für die Householder-Matrix $H$ gilt:
+ $H$ ist *symmetrisch*: $H^tp = H$.
+ $H$ ist *orthogonal* und $H^2 = I$, also $H^(-1) = H$.
+ $H bold(v) = -bold(v)$, und $H bold(w) = bold(w)$ für alle $bold(w)$ mit $bold(v)^tp bold(w) = 0$.
$H$ ist also die *Spiegelung an der Hyperebene durch $bold(0)$ mit Normalenvektor $bold(v)$*.]

#beweis[Sei $P = (bold(v) bold(v)^tp)\/(bold(v)^tp bold(v))$. Dann ist $P^tp = P$ und $P^2 = bold(v)(bold(v)^tp bold(v)) bold(v)^tp \/ (bold(v)^tp bold(v))^2 = P$. Also (1): $H = I - 2P$ ist symmetrisch. (2): $H^2 = I - 4P + 4P^2 = I$. Wegen $H^tp = H$ ist $H^tp H = H^2 = I$, also orthogonal. (3): $P bold(v) = bold(v)$ und $P bold(w) = bold(0)$, falls $bold(v)^tp bold(w) = 0$.]

#satz[Spiegeln auf die erste Achse][Sei $bold(x) != bold(0)$ und $bold(v) = bold(x) - |bold(x)| bold(e)_1$ (mit $bold(v) != bold(0)$). Dann gilt für die zugehörige Householder-Matrix
$ H bold(x) = |bold(x)| bold(e)_1 = (|bold(x)|, 0, dots, 0)^tp. $]

#beweis[Es ist $bold(v)^tp bold(v) = |bold(x)|^2 - 2 |bold(x)| x_1 + |bold(x)|^2 = 2 |bold(x)| (|bold(x)| - x_1)$ und $bold(v)^tp bold(x) = |bold(x)|^2 - |bold(x)| x_1 = |bold(x)| (|bold(x)| - x_1)$. Damit ist $(2 bold(v)^tp bold(x))\/(bold(v)^tp bold(v)) = 1$ und $H bold(x) = bold(x) - bold(v) = |bold(x)| bold(e)_1$.]

#fg("l06_householder", [Die Spiegelung an der Ebene (hier: Gerade) senkrecht zu $bold(v) = bold(x) - |bold(x)| bold(e)_1$ bildet $bold(x) = (3, 4)$ auf $(5, 0)$ ab.], w: 62%)

#bsp[Householder][
*In $RR^2$:* $bold(x) = (3, 4)$, $|bold(x)| = 5$, $bold(v) = (-2, 4)$, $bold(v)^tp bold(v) = 20$. $H = I - (2\/20) mat(4, -8; -8, 16) = mat(3\/5, 4\/5; 4\/5, -3\/5)$ und $H bold(x) = (9\/5 + 16\/5, 12\/5 - 12\/5) = (5, 0)$ ✓. Diese Matrix ist symmetrisch, $H^2 = I$.
*In $RR^3$:* $bold(x) = (2, 1, 2)$, $|bold(x)| = 3$, $bold(v) = (-1, 1, 2)$, $bold(v)^tp bold(v) = 6$:
$ H = I - 1/3 mat(1, -1, -2; -1, 1, 2; -2, 2, 4) = 1/3 mat(2, 1, 2; 1, 2, -2; 2, -2, -1), quad H bold(x) = 1/3 vec(4 + 1 + 4, 2 + 2 - 4, 4 - 2 - 2) = vec(3, 0, 0). $
]


#merke[*Numerisch:* Damit bei $v = x - |x| e_1$ keine Auslöschung (Differenz fast gleicher Zahlen) auftritt, wählt man in der Praxis das Vorzeichen so, dass die erste Komponente grösser wird: $bold(v) = bold(x) + "sgn"(x_1) |bold(x)| bold(e)_1$. Dann ist $H bold(x) = -"sgn"(x_1) |bold(x)| bold(e)_1$.]

#table(columns: (auto, 1fr, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [], [*Givens-Rotation*], [*Householder-Matrix*],
  [Wirkung], [dreht in einer Koordinatenebene], [spiegelt an einer Hyperebene],
  [Löscht], [einen Eintrag], [alle Einträge unter dem ersten],
  [Determinante], [$+1$ (Drehung)], [$-1$ (Spiegelung)],
  [Gut für], [dünn besetzte Matrizen, gezielte Eingriffe], [volle (dichte) Matrizen])

#kurz[
- $A$ *regulär* $arrow.l.r.double$ $exists A^(-1)$ mit $A A^(-1) = A^(-1) A = I$ $arrow.l.r.double$ $rang(A) = n$ $arrow.l.r.double$ $A bold(x) = bold(0)$ nur trivial lösbar $arrow.l.r.double$ $A bold(x) = bold(b)$ für alle $bold(b)$ eindeutig lösbar. Sonst *singulär*.
- *Gauss-Jordan:* $(A | I) arrow.r (I | A^(-1))$. Für $2 times 2$: $A^(-1) = 1/(a d - b c) mat(d, -b; -c, a)$.
- $(A^(-1))^(-1) = A$; $(A B)^(-1) = B^(-1) A^(-1)$; $(A^tp)^(-1) = (A^(-1))^tp$. Bei quadratischen Matrizen genügt $A B = I$.
- *Orthogonal:* $Q^tp Q = I$, also $Q^(-1) = Q^tp$; Spalten (und Zeilen) orthonormal.
- *Givens-Rotation* löscht einen Eintrag ($c = x_i \/ r$, $s = x_k \/ r$). *Householder* $H = I - 2 bold(v) bold(v)^tp \/ (bold(v)^tp bold(v))$ ist eine Spiegelung, symmetrisch, orthogonal, $H^2 = I$; mit $bold(v) = bold(x) - |bold(x)| bold(e)_1$ gilt $H bold(x) = |bold(x)| bold(e)_1$.
]

#aufgaben()

#aufg("Inverse berechnen", [Berechne die Inverse von $A = mat(1, 1, 0; 0, 1, 1; 1, 0, 1)$ oder zeige, dass sie nicht existiert.],
[$ mat(1, 1, 0, 1, 0, 0; 0, 1, 1, 0, 1, 0; 1, 0, 1, 0, 0, 1) zu(Z_3 - Z_1) mat(1, 1, 0, 1, 0, 0; 0, 1, 1, 0, 1, 0; 0, -1, 1, -1, 0, 1) zu(Z_3 + Z_2) mat(1, 1, 0, 1, 0, 0; 0, 1, 1, 0, 1, 0; 0, 0, 2, -1, 1, 1). $
Drei Pivots: regulär. $Z_3 arrow.r Z_3\/2$: $(0, 0, 1 | -1\/2, 1\/2, 1\/2)$. $Z_2 - Z_3$: $(0, 1, 0 | 1\/2, 1\/2, -1\/2)$. $Z_1 - Z_2$: $(1, 0, 0 | 1\/2, -1\/2, 1\/2)$. $A^(-1) = 1/2 mat(1, -1, 1; 1, 1, -1; -1, 1, 1)$. Probe, erste Zeile von $A$ mal erste Spalte: $(1 + 1 + 0)\/2 = 1$ ✓, mal zweite Spalte: $(-1 + 1)\/2 = 0$ ✓.])

#aufg("Singulär oder regulär?", [Für welche $t in RR$ ist $A = mat(1, 2; t, 4)$ regulär? Gib dann $A^(-1)$ an.],
[$a d - b c = 4 - 2t$. Regulär genau für $t != 2$. Dann $A^(-1) = 1\/(4 - 2t) mat(4, -2; -t, 1)$. Für $t = 2$ ist die zweite Zeile $(2, 4)$ das Doppelte der ersten: singulär.])

#aufg("Gleichungssystem mit der Inversen", [Löse $A bold(x) = bold(b)$ mit $A = mat(2, 1; 5, 3)$ für $bold(b) = (3, 8)^tp$ und für $bold(b) = (1, 0)^tp$ mit Hilfe von $A^(-1)$.],
[$A^(-1) = mat(3, -1; -5, 2)$. Erste rechte Seite: $bold(x) = (9 - 8, -15 + 16)^tp = (1, 1)^tp$. Zweite: $bold(x) = (3, -5)^tp$. Beide Male dieselbe Inverse, nur zwei Matrix-Vektor-Produkte. Probe: $2 dot 3 + (-5) = 1$ ✓, $5 dot 3 + 3 dot (-5) = 0$ ✓.])

#aufg("Orthogonale Matrizen", [Bestimme $a$ und $b$, so dass $Q = mat(0.6, a; b, 0.6)$ orthogonal ist ($a, b != 0$ mit der ersten Spalte positiv).],
[Spalte 1 hat die Länge $sqrt(0.36 + b^2) = 1$, also $b = plus.minus 0.8$. Spalte 2: $sqrt(a^2 + 0.36) = 1$, also $a = plus.minus 0.8$. Orthogonalität: $0.6 a + 0.6 b = 0$, also $a = -b$. Lösungen: $(a, b) = (-0.8, 0.8)$ oder $(0.8, -0.8)$. Z. B. $Q = mat(0.6, -0.8; 0.8, 0.6)$ (Drehung) und $Q = mat(0.6, 0.8; -0.8, 0.6)$.])

#aufg("Givens und Householder", [Bestimme eine Givens-Rotation, die in $bold(x) = (5, 12)$ die zweite Komponente zu null macht, und die Householder-Matrix, die $bold(x)$ auf ein Vielfaches von $bold(e)_1$ abbildet.],
[$r = 13$, $c = 5\/13$, $s = 12\/13$: $G = (1\/13) mat(5, 12; -12, 5)$, $G bold(x) = (13, 0)$. Householder: $bold(v) = bold(x) - 13 bold(e)_1 = (-8, 12)$, $bold(v)^tp bold(v) = 208$. $H = I - (2\/208) mat(64, -96; -96, 144) = mat(1 - 128\/208, 192\/208; 192\/208, 1 - 288\/208) = (1\/13) mat(5, 12; 12, -5)$. $H bold(x) = (1\/13)(25 + 144, 60 - 60) = (13, 0)$ ✓. Beide Matrizen sind orthogonal; $det G = 1$, $det H = -1$.])
