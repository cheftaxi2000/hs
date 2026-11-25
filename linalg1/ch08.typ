#import "lib.typ": *

= LR-Zerlegung mit Vertauschungen und Determinanten

#woche(8, [Anwendungen der LR-Zerlegung, Determinanten], [Lösen mit LR · Permutationsmatrizen · $P A = L R$ · Determinante · Sarrus · Minoren, Kofaktoren, Adjunkte · Entwicklungssatz])

#vorlesung[Zuerst nutzen wir die LR-Zerlegung, um Gleichungssysteme schnell zu lösen, und reparieren sie für den Fall, dass ein Pivot null ist (Zeilenvertauschungen, Permutationsmatrizen). Dann führen wir eine der berühmtesten Zahlen der Linearen Algebra ein: die *Determinante*. Sie ordnet jeder quadratischen Matrix eine einzige Zahl zu, die verrät, ob die Matrix invertierbar ist, und die geometrisch ein *Volumen* misst.]

== Anwendungen der LR-Zerlegung

Hat man $A = L R$, so zerfällt das System $A bold(x) = bold(b)$ in zwei Dreieckssysteme:
$ A bold(x) = L (R bold(x)) = bold(b) quad arrow.l.r.double quad cases(L bold(y) = bold(b) & "(Vorwärtseinsetzen)", R bold(x) = bold(y) & "(Rückwärtseinsetzen)".) $
Beide Dreieckssysteme sind einfach: $L bold(y) = bold(b)$ löst man von oben nach unten, $R bold(x) = bold(y)$ von unten nach oben.

#bsp[Mehrere rechte Seiten][
$A = mat(2, 1, 1; 4, 3, 3; 8, 7, 9) = L R$ mit $L = mat(1, 0, 0; 2, 1, 0; 4, 3, 1)$ und $R = mat(2, 1, 1; 0, 1, 1; 0, 0, 2)$ (Woche 7). Für $bold(b) = (1, 2, 3)^tp$:
*Vorwärts:* $y_1 = 1$; $y_2 = 2 - 2 dot 1 = 0$; $y_3 = 3 - 4 dot 1 - 3 dot 0 = -1$. *Rückwärts:* $2 x_3 = -1$, $x_3 = -1\/2$; $x_2 = 0 - x_3 = 1\/2$; $2 x_1 = 1 - x_2 - x_3 = 1 - 1\/2 + 1\/2 = 1$, $x_1 = 1\/2$. Lösung $(1\/2, 1\/2, -1\/2)$.
Für eine *andere* rechte Seite, etwa $bold(b) = (2, 4, 8)^tp$, muss man $A$ nicht neu eliminieren: nur die zwei Dreieckssysteme sind neu zu lösen. Ergebnis $(1, 0, 0)$ (denn $bold(b)$ ist die erste Spalte von $A$).
]

#table(columns: (1fr, auto), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Schritt*], [*Aufwand (Multiplikationen)*],
  [LR-Zerlegung berechnen], [$approx n^3 \/ 3$ (einmal)],
  [Vorwärtseinsetzen $L bold(y) = bold(b)$], [$approx n^2 \/ 2$ (je rechte Seite)],
  [Rückwärtseinsetzen $R bold(x) = bold(y)$], [$approx n^2 \/ 2$ (je rechte Seite)])

Für $n = 1000$ kostet die Zerlegung etwa $3 dot 10^8$, jede weitere rechte Seite nur etwa $10^6$ Operationen: ein Faktor $300$. Deshalb löst man Systeme mit wechselnden rechten Seiten *immer* mit gespeicherter LR-Zerlegung. Auch die *Inverse* erhält man damit: Man löst $A bold(x)_j = bold(e)_j$ für $j = 1, dots, n$ mit den Spalten der Einheitsmatrix.

== Permutationsmatrizen

Was tun, wenn bei der Elimination ein Pivot $0$ ist (oder winzig, Woche 2)? Man vertauscht Zeilen. Zeilenvertauschungen sind Multiplikationen mit *Permutationsmatrizen*.

#defn[Permutationsmatrix][Eine *Permutationsmatrix* $P in RR^(n times n)$ ist eine Matrix, die in jeder Zeile und in jeder Spalte genau eine $1$ und sonst nur Nullen enthält. Sie entsteht aus $I$ durch Vertauschen von Zeilen.]

Es gibt $n!$ Permutationsmatrizen der Grösse $n$ (für $n = 3$ sind es $6$). Für jede Permutationsmatrix gilt:
+ $P A$ entsteht aus $A$ durch *Vertauschen der Zeilen* (und $A P$ durch Vertauschen der Spalten).
+ $P$ ist orthogonal: $P^tp P = I$, also $P^(-1) = P^tp$.
+ Produkte von Permutationsmatrizen sind Permutationsmatrizen.

Beispiel: $P = mat(0, 0, 1; 0, 1, 0; 1, 0, 0)$ vertauscht die Zeilen 1 und 3. Es gilt $P^2 = I$ (zweimal vertauschen heisst: nichts tun) und damit $P^(-1) = P = P^tp$.

== LR-Zerlegung mit Zeilenvertauschungen

#satz[$P A = L R$][Zu jeder *regulären* Matrix $A in RR^(n times n)$ gibt es eine Permutationsmatrix $P$, eine untere Dreiecksmatrix $L$ mit Einsen auf der Diagonale und eine obere Dreiecksmatrix $R$ mit
$ P A = L R. $]

Man führt das Gauss-Verfahren aus und tauscht, wann immer nötig (oder ratsam: den betragsgrössten Eintrag nach oben, Woche 2), die Zeilen. Die Vertauschungen sammelt man in $P$. Der Trick: Man kann *alle* Vertauschungen so behandeln, als hätte man sie schon *vor* der Elimination durchgeführt.

#bsp[Zerlegung mit Zeilentausch][
$ A = mat(0, 2, 1; 1, 1, 1; 2, 1, 3). $
Der erste Eintrag ist $0$: kein Pivot möglich. Wir tauschen $Z_1 arrow.l.r Z_3$ (der grösste Eintrag der Spalte, $2$, kommt nach oben): $P = mat(0, 0, 1; 0, 1, 0; 1, 0, 0)$, $P A = mat(2, 1, 3; 1, 1, 1; 0, 2, 1)$. Jetzt eliminiert man *ohne weitere Vertauschung*:
- Spalte 1, Pivot $2$: $l_(21) = 1\/2$, $l_(31) = 0$. $Z_2 - (1\/2) Z_1$: $(0, 1\/2, -1\/2)$.
- Spalte 2, Pivot $1\/2$: $l_(32) = 2 \/ (1\/2) = 4$. $Z_3 - 4 Z_2$: $(0, 0, 1 + 2) = (0, 0, 3)$.
$ R = mat(2, 1, 3; 0, 1\/2, -1\/2; 0, 0, 3), quad L = mat(1, 0, 0; 1\/2, 1, 0; 0, 4, 1). $
*Probe:* $L R = mat(2, 1, 3; 1, 1\/2 + 1\/2, 3\/2 - 1\/2; 0, 2, -2 + 3) = mat(2, 1, 3; 1, 1, 1; 0, 2, 1) = P A$ ✓.
Lösen von $A bold(x) = bold(b)$: Multipliziere mit $P$: $P A bold(x) = P bold(b)$, also $L R bold(x) = P bold(b)$: Man vertauscht zuerst die Einträge von $bold(b)$ und löst dann wie gewohnt.
]

#merke[Mit der LR-Zerlegung inklusive Zeilentausch kann man *jedes* reguläre System lösen. (Bei singulärem $A$ findet das Verfahren irgendwann keinen Pivot, und dann hört es dort auf.) Dies ist, was Programme wie MATLAB, NumPy oder Mathematica im Inneren tun, wenn man «löse $A x = b$» schreibt.]

== Determinanten

#idee[Eine reelle Zahl $a$ hat genau dann einen Kehrwert, wenn $a != 0$. Für eine $2 times 2$-Matrix haben wir gesehen: Die Inverse existiert genau dann, wenn $a d - b c != 0$ (Woche 6). Diese Zahl ist die *Determinante*. Gesucht ist eine solche «Test-Zahl» für beliebig grosse quadratische Matrizen, die zugleich eine anschauliche Bedeutung hat.]

=== Geometrische Motivation

Zwei Vektoren $bold(a) = (a_1, a_2)$ und $bold(b) = (b_1, b_2)$ im $RR^2$ spannen ein Parallelogramm auf.

#fgs(("l08_det2", "l08_det3"), [Links: Der Flächeninhalt des von $bold(a), bold(b)$ aufgespannten Parallelogramms ist $|a_1 b_2 - a_2 b_1|$. Rechts: Das Volumen eines Spats ist der Betrag der $3 times 3$-Determinante.])

Der Flächeninhalt ist $|a_1 b_2 - a_2 b_1|$. Ohne Betrag, mit Vorzeichen, ist $a_1 b_2 - a_2 b_1$ die Determinante der Matrix mit den Spalten $bold(a), bold(b)$. Das Vorzeichen sagt, ob $bold(b)$ links ($+$) oder rechts ($-$) von $bold(a)$ liegt (Orientierung). Ist die Determinante $0$, so ist das Parallelogramm flach: $bold(a)$ und $bold(b)$ sind parallel, also linear abhängig, und die Matrix ist nicht invertierbar. Im $RR^3$ ist die Determinante das (orientierte) Volumen des aufgespannten *Spats*; sie ist genau dann null, wenn die drei Vektoren in einer Ebene liegen.

=== Definition

Für $n = 1$ ist $det (a) = a$, für $n = 2$ ist $det mat(a, b; c, d) = a d - b c$. Für grössere Matrizen *führt man die Berechnung rekursiv auf kleinere Matrizen zurück*.

#defn[Minor, Kofaktor][Sei $A in RR^(n times n)$ und $A_(i j) in RR^((n-1) times (n-1))$ die Matrix, die man erhält, wenn man in $A$ die $i$-te Zeile und die $j$-te Spalte *streicht*. Dann heissen
$ M_(i j) = det(A_(i j)) quad "(Minor)" quad "und" quad C_(i j) = (-1)^(i+j) M_(i j) quad "(Kofaktor)". $
Das Vorzeichen $(-1)^(i+j)$ folgt einem *Schachbrettmuster*: $+$ auf der Position $(1, 1)$, und es wechselt in jedem Schritt nach rechts oder unten.]

#fg("l08_vorz", [Das Vorzeichenmuster $(-1)^(i+j)$ der Kofaktoren.], w: 34%)

#defn[Determinante][Die *Determinante* einer $n times n$-Matrix $A = (a_(i j))$ ist (rekursiv, *Entwicklung nach der ersten Zeile*)
$ det(A) = sum_(j=1)^n a_(1 j) C_(1 j) = sum_(j=1)^n (-1)^(1+j) a_(1 j) det(A_(1 j)), $
mit $det (a) = a$ im Fall $n = 1$. Man schreibt auch $|A|$ oder $mat(delim: "|", a_(11), dots, a_(1n); dots.v, , dots.v; a_(n 1), dots, a_(n n))$.]

Für $n = 2$ erhält man $det A = a_(11) a_(22) - a_(12) a_(21)$, die bekannte Formel. Für $n = 3$:
$ det mat(a, b, c; d, e, f; g, h, i) = a (e i - f h) - b (d i - f g) + c (d h - e g). $
Ausmultipliziert ergibt das die Regel von Sarrus.

=== Die Regel von Sarrus

#satz[Regel von Sarrus (nur für $3 times 3$!)][Für eine $3 times 3$-Matrix gilt
$ det mat(a, b, c; d, e, f; g, h, i) = a e i + b f g + c d h - c e g - a f h - b d i. $
Merkregel: Schreibe die ersten beiden Spalten rechts neben die Matrix. Die Produkte der drei Diagonalen von links oben nach rechts unten zählen $+$, die der drei Diagonalen von rechts oben nach links unten zählen $-$.]

#fg("l08_sarrus", [Die Regel von Sarrus: Diagonalen der erweiterten Matrix.], w: 70%)

#fehler[*Sarrus gilt nur für $3 times 3$-Matrizen.* Für $4 times 4$ gibt es (mehr als) $24$ Summanden, und eine solche einfache Diagonalenregel existiert nicht. Wer das bei einer $4 times 4$-Matrix versucht, bekommt ein falsches Ergebnis.]

#bsp[Determinante einer $3 times 3$-Matrix][
$ A = mat(2, 1, 0; 1, 3, 1; 0, 1, 2). $
Sarrus: $2 dot 3 dot 2 + 1 dot 1 dot 0 + 0 dot 1 dot 1 - 0 dot 3 dot 0 - 2 dot 1 dot 1 - 1 dot 1 dot 2 = 12 + 0 + 0 - 0 - 2 - 2 = 8$.
Entwicklung nach der ersten Zeile: $2 dot det mat(3, 1; 1, 2) - 1 dot det mat(1, 1; 0, 2) + 0 = 2 (6 - 1) - 1 (2 - 0) = 10 - 2 = 8$ ✓. Also $det A = 8 != 0$: $A$ ist regulär.
]

== Der Entwicklungssatz

Die Definition entwickelt nach der ersten Zeile. Man darf aber nach *jeder* Zeile und *jeder* Spalte entwickeln. Das ist bei Nullen in der Matrix sehr bequem.

#satz[Entwicklungssatz][Für jede $n times n$-Matrix $A$ und jedes $i, j in {1, dots, n}$ gilt
$ det(A) = sum_(k=1)^n a_(i k) C_(i k) quad "(Entwicklung nach der " i "-ten Zeile)" $
$ det(A) = sum_(k=1)^n a_(k j) C_(k j) quad "(Entwicklung nach der " j "-ten Spalte)". $]

(Der Beweis folgt nächste Woche zusammen mit den Rechenregeln der Determinante.) Man wählt die Zeile oder Spalte mit den *meisten Nullen*: Jede Null spart einen Kofaktor.

#bsp[Eine $4 times 4$-Determinante][
$ A = mat(1, 0, 2, 0; 3, 1, 0, 2; 0, 2, 1, 0; 1, 0, 0, 3). $
Die vierte Spalte hat zwei Nullen: Entwicklung nach der vierten Spalte ($a_(24) = 2$, $a_(44) = 3$):
$ det A = a_(24) C_(24) + a_(44) C_(44) = 2 (-1)^(2+4) M_(24) + 3 (-1)^(4+4) M_(44). $
$M_(24) = det mat(1, 0, 2; 0, 2, 1; 1, 0, 0)$ (Zeile 2 und Spalte 4 gestrichen). Entwicklung nach der ersten Spalte: $1 dot (0 - 0) - 0 + 1 dot (0 - 4) = -4$. $M_(44) = det mat(1, 0, 2; 3, 1, 0; 0, 2, 1) = 1 (1 - 0) - 0 + 2 (6 - 0) = 13$.
$ det A = 2 dot (-4) + 3 dot 13 = -8 + 39 = 31. $
]

=== Adjunkte

Die Kofaktoren, zu einer Matrix zusammengefasst, haben eine wichtige Anwendung (nächste Woche: die Inverse).

#defn[Adjunkte][Die *Adjunkte* (auch: komplementäre Matrix) von $A in RR^(n times n)$ ist die *transponierte* Kofaktormatrix:
$ adj(A) = (C_(i j))^tp, quad "also" quad (adj(A))_(i j) = C_(j i). $]

#bsp[Adjunkte][Für $A = mat(2, 1, 0; 1, 3, 1; 0, 1, 2)$ sind die Kofaktoren $C_(11) = 3 dot 2 - 1 dot 1 = 5$, $C_(12) = -(1 dot 2 - 1 dot 0) = -2$, $C_(13) = 1 dot 1 - 3 dot 0 = 1$, $C_(21) = -(1 dot 2 - 0 dot 1) = -2$, $C_(22) = 2 dot 2 - 0 = 4$, $C_(23) = -(2 dot 1 - 1 dot 0) = -2$, $C_(31) = 1 dot 1 - 0 dot 3 = 1$, $C_(32) = -(2 dot 1 - 0 dot 1) = -2$, $C_(33) = 2 dot 3 - 1 dot 1 = 5$.
$ adj(A) = mat(5, -2, 1; -2, 4, -2; 1, -2, 5). $
(Die Matrix ist symmetrisch, weil $A$ symmetrisch ist.) Nachrechnen: $A adj(A) = 8 I$ (der Eintrag $(1, 1)$: $2 dot 5 + 1 dot (-2) + 0 = 8$ ✓, der Eintrag $(1, 2)$: $2 dot (-2) + 1 dot 4 + 0 dot (-2) = 0$ ✓). Das ist genau $det(A) dot I$. Dieser Zusammenhang ist der Inhalt von Woche 10: $A^(-1) = adj(A)\/det(A)$.]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Die Determinante ist ein Volumenfaktor.* $|det A|$ sagt, um welchen Faktor die Abbildung $x |-> A x$ Flächen (in der Ebene) oder Volumen (im Raum) ändert. Ist $det A = 2$, werden Flächen verdoppelt; ist $det A = 0$, wird alles auf eine Gerade oder einen Punkt zusammengedrückt. Das Vorzeichen sagt, ob die Orientierung erhalten bleibt oder gespiegelt wird. Das nutzen CAD-Programme, um Spiegelungen zu erkennen, und Computerspiele, um zu entscheiden, ob ein Dreieck dem Betrachter zu- oder abgewandt ist.]

#alltag[*Landvermessung mit Determinanten.* Die Fläche eines Grundstücks mit Eckpunkten $(x_1, y_1), dots, (x_n, y_n)$ berechnet der Vermesser mit der «Gauss'schen Flächenformel»: $A = 1\/2 |sum (x_i y_(i+1) - x_(i+1) y_i)|$. Jeder Summand ist eine $2 times 2$-Determinante, nämlich die Fläche eines Dreiecks vom Ursprung. Dieselbe Formel arbeitet in GIS-Software, wenn sie die Fläche eines Waldes oder Sees aus Koordinaten berechnet.]
// ALLTAG-END

#kurz[
- LR löst $A bold(x) = bold(b)$ in zwei Dreieckssystemen; die Zerlegung ($approx n^3\/3$) wird einmal berechnet, jede weitere rechte Seite kostet nur $approx n^2$.
- *Permutationsmatrix* $P$: $P A$ vertauscht Zeilen; $P^(-1) = P^tp$. *$P A = L R$* existiert für jede reguläre Matrix.
- *Determinante:* $n = 2$: $a d - b c$; allgemein rekursiv durch Entwicklung. Geometrisch: orientierter Flächeninhalt / Volumen; $det = 0$ heisst «flach».
- *Minor* $M_(i j)$ (Streichen), *Kofaktor* $C_(i j) = (-1)^(i+j) M_(i j)$, *Adjunkte* $adj(A) = (C_(i j))^tp$.
- *Sarrus* nur für $3 times 3$. *Entwicklungssatz:* nach jeder Zeile oder Spalte, am besten mit vielen Nullen.
]

#aufgaben()

#aufg("Lösen mit LR", [Für $A = mat(1, 2, 1; 3, 8, 5; 2, 7, 7) = L R$ mit $L = mat(1, 0, 0; 3, 1, 0; 2, 3\/2, 1)$, $R = mat(1, 2, 1; 0, 2, 2; 0, 0, 2)$ löse $A bold(x) = bold(b)$ für $bold(b) = (1, 0, 0)^tp$ und $bold(b) = (0, 1, 0)^tp$ (das sind die ersten zwei Spalten von $A^(-1)$).],
[$bold(b) = (1, 0, 0)$: $L bold(y) = bold(b)$: $y_1 = 1$, $y_2 = -3$, $y_3 = -2 + 9\/2 = 5\/2$. $R bold(x) = bold(y)$: $x_3 = 5\/4$, $x_2 = (-3 - 2 dot 5\/4)\/2 = -11\/4$, $x_1 = 1 - 2 x_2 - x_3 = 1 + 11\/2 - 5\/4 = 21\/4$. Probe der ersten Gleichung: $21\/4 - 22\/4 + 5\/4 = 1$ ✓. Entsprechend für $(0, 1, 0)$: $bold(y) = (0, 1, -3\/2)$, $x_3 = -3\/4$, $x_2 = (1 + 3\/2)\/2 = 5\/4$, $x_1 = -2 x_2 - x_3 = -5\/2 + 3\/4 = -7\/4$.])

#aufg("PA = LR", [Bestimme eine Zerlegung $P A = L R$ für $A = mat(0, 1, 2; 1, 2, 3; 2, 1, 1)$. (Es gibt mehrere Möglichkeiten; wähle als Pivot immer den *ersten* von null verschiedenen Eintrag der Pivotspalte von oben her.) Prüfe dein Ergebnis durch $L R = P A$.],
[Der erste Eintrag der ersten Spalte ist $0$; der erste Eintrag $!= 0$ unter ihm ist in Zeile 2 ($1$). Tausche $Z_1 arrow.l.r Z_2$: $P = mat(0, 1, 0; 1, 0, 0; 0, 0, 1)$, $P A = mat(1, 2, 3; 0, 1, 2; 2, 1, 1)$. $l_(21) = 0$, $l_(31) = 2$: $Z_3 - 2 Z_1 = (0, -3, -5)$. $l_(32) = -3$: $Z_3 + 3 Z_2 = (0, 0, 1)$. $R = mat(1, 2, 3; 0, 1, 2; 0, 0, 1)$, $L = mat(1, 0, 0; 0, 1, 0; 2, -3, 1)$. Probe: $L R = mat(1, 2, 3; 0, 1, 2; 2, 4 - 3, 6 - 6 + 1) = mat(1, 2, 3; 0, 1, 2; 2, 1, 1) = P A$ ✓.])

#aufg("Determinanten berechnen", [Berechne (a) $det mat(1, 2, 3; 4, 5, 6; 7, 8, 10)$ (Sarrus) und (b) $det mat(3, 1, 2; 0, 2, 0; 1, 4, 1)$ durch Entwicklung nach einer geeigneten Zeile. (c) Was ergibt Sarrus für $mat(1, 2, 3; 4, 5, 6; 7, 8, 9)$?],
[(a) $50 + 84 + 96 - 105 - 48 - 80 = 230 - 233 = -3$. (b) Die zweite Zeile hat zwei Nullen: $det = 2 dot (-1)^(2+2) det mat(3, 2; 1, 1) = 2 (3 - 2) = 2$. (c) $45 + 84 + 96 - 105 - 48 - 72 = 225 - 225 = 0$: Die Matrix ist singulär (die Zeilen bilden eine arithmetische Folge: $Z_3 - Z_2 = Z_2 - Z_1$).])

#aufg("Flächeninhalt und Volumen", [(a) Welchen Flächeninhalt hat das Parallelogramm mit den Seitenvektoren $(3, 1)$ und $(1, 2)$? (b) Welches Volumen hat der Spat mit den Kanten $(1, 1, 1)$, $(0, 2, 1)$, $(0, 0, 3)$?],
[(a) $|3 dot 2 - 1 dot 1| = 5$. (b) Die Matrix mit diesen Spalten ist eine Dreiecksmatrix: $det mat(1, 0, 0; 1, 2, 0; 1, 1, 3) = 1 dot 2 dot 3 = 6$ (Entwicklung nach der ersten Zeile). Volumen $6$.])

#aufg("Adjunkte einer 2x2-Matrix", [Zeige für $A = mat(a, b; c, d)$: $adj(A) = mat(d, -b; -c, a)$ und $A adj(A) = det(A) I$.],
[Kofaktoren: $C_(11) = d$, $C_(12) = -c$, $C_(21) = -b$, $C_(22) = a$. Transponiert: $adj(A) = mat(d, -b; -c, a)$. Dann $A adj(A) = mat(a d - b c, -a b + b a; c d - d c, -c b + d a) = (a d - b c) I$.])
