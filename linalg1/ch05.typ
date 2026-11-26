#import "lib.typ": *

= Rechnen mit Matrizen

#woche(5, [Summenkonvention, Rechenregeln, Zeilen und Spalten], [Einstein-Konvention · Kronecker-Symbol · Rechenregeln · Spalten- und Zeilenstruktur · Transposition])

#vorlesung[Matrizen lassen sich addieren und multiplizieren, aber nicht alle Rechenregeln der Zahlen bleiben erhalten. Diese Woche lernen wir eine Kurzschreibweise (Einstein), die Beweise mit Matrizen auf wenige Zeilen verkürzt, und stellen fest, welche Regeln gelten (Assoziativität, Distributivität) und welche nicht (Kommutativität, Kürzen). Wir sehen ausserdem, dass jedes Matrixprodukt eine *Zeilen- und Spaltenstruktur* hat, auf der später das ganze Verständnis von Zeilenumformungen beruht.]

== Die Einsteinsche Summenkonvention

Bei Matrizen schreibt man ständig Summen wie $sum_(k=1)^p a_(i k) b_(k j)$. Albert Einstein bemerkte (bei der Arbeit mit Tensoren in der Relativitätstheorie), dass in solchen Ausdrücken über jeden Index, der *doppelt* vorkommt, ohnehin summiert wird, und dass man das Summenzeichen daher weglassen kann.

#defn[Einsteinsche Summenkonvention][In einem Produkt von Termen wird über jeden Index, der *genau zweimal* vorkommt, von $1$ bis zu seinem Höchstwert summiert, ohne dass das Summenzeichen hingeschrieben wird. Indizes, die nur einmal vorkommen (*freie Indizes*), laufen nicht und sind für jede Gleichung «für alle Werte» gemeint.]

Mit dieser Konvention gelten die Schreibweisen:

#table(columns: (1fr, 1fr, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [*Ohne Konvention*], [*Mit Konvention*], [*Bedeutung*],
  [$(A bold(x))_i = sum_j a_(i j) x_j$], [$(A bold(x))_i = a_(i j) x_j$], [Matrix mal Vektor ($i$ frei, $j$ summiert)],
  [$(A B)_(i j) = sum_k a_(i k) b_(k j)$], [$(A B)_(i j) = a_(i k) b_(k j)$], [Matrixprodukt],
  [$bold(x) dot bold(y) = sum_i x_i y_i$], [$bold(x) dot bold(y) = x_i y_i$], [Skalarprodukt],
  [$spur(A) = sum_i a_(i i)$], [$spur(A) = a_(i i)$], [Spur (Summe der Diagonalelemente)])

#merke[*Regeln für den Umgang mit Indizes:*
+ Ein Index darf in einem Term *höchstens zweimal* vorkommen. Kommt er zweimal vor, wird summiert.
+ Ein summierter Index ist ein *stummer Index*, sein Name ist egal: $a_(i k) b_(k j) = a_(i l) b_(l j)$.
+ Auf beiden Seiten einer Gleichung müssen *dieselben freien Indizes* stehen. $(A B)_(i j) = a_(i k) b_(k j)$ hat die freien Indizes $i, j$ auf beiden Seiten.]

Die Konvention wirkt zunächst fremd, aber sie erspart sehr viel Schreibarbeit. Wir benutzen sie in den Beweisen dieser Woche.

== Das Kronecker-Symbol

#defn[Kronecker-Symbol][Das *Kronecker-Symbol* (oder Kronecker-Delta) ist
$ delta_(i j) = cases(1 & "falls" i = j, 0 & "falls" i != j). $
Die Einheitsmatrix ist $I = (delta_(i j))$.]

Das Kronecker-Symbol hat eine Siebeigenschaft, mit der man ganz mechanisch rechnet:

#satz[Siebeigenschaft][Für jede Grösse $x_j$ gilt $delta_(i j) x_j = x_i$: Von der Summe $sum_j delta_(i j) x_j$ bleibt nur der Summand $j = i$ übrig. Insbesondere ist $delta_(i i) = n$ (Summe der Diagonaleinträge von $I_n$).]

Daraus folgt sofort, dass die Einheitsmatrix das «Eins-Element» der Matrizenmultiplikation ist: Für $A in RR^(m times n)$ gilt
$ (I_m A)_(i j) = delta_(i k) a_(k j) = a_(i j), quad (A I_n)_(i j) = a_(i k) delta_(k j) = a_(i j), $
also $I_m A = A = A I_n$.

== Rechenregeln für Matrizen

#satz[Rechenregeln][Für Matrizen passender Grösse und Zahlen $c, d$ gilt:
+ *Assoziativität:* $(A B) C = A (B C)$.
+ *Distributivität:* $A (B + C) = A B + A C$ und $(A + B) C = A C + B C$.
+ *Verträglichkeit mit Zahlen:* $(c A) B = c (A B) = A (c B)$.
+ *Neutrale Elemente:* $I A = A I = A$ und $A + 0 = A$.
Die Addition ist kommutativ und assoziativ: $A + B = B + A$.]

#beweis[Wir beweisen die Assoziativität mit der Summenkonvention. Seien $A in RR^(m times p)$, $B in RR^(p times q)$, $C in RR^(q times n)$. Dann ist
$ ((A B) C)_(i l) = (A B)_(i j) c_(j l) = (a_(i k) b_(k j)) c_(j l) = a_(i k) b_(k j) c_(j l), $
und
$ (A (B C))_(i l) = a_(i k) (B C)_(k l) = a_(i k) (b_(k j) c_(j l)) = a_(i k) b_(k j) c_(j l). $
Beide Ausdrücke stimmen überein, da die Reihenfolge der (endlichen) Summationen keine Rolle spielt. Die Distributivität folgt ebenso: $(A (B + C))_(i j) = a_(i k)(b_(k j) + c_(k j)) = a_(i k) b_(k j) + a_(i k) c_(k j)$.]

Wegen der Assoziativität darf man bei Produkten von mehr als zwei Matrizen die Klammern weglassen: $A B C$ ist eindeutig. (Die *Reihenfolge* der Faktoren muss aber bleiben.) Für quadratische $A$ definiert man Potenzen $A^k = A A dots A$ ($k$ Faktoren), $A^0 = I$.

#bsp[Potenzen einer Matrix: Fibonacci][
Die Fibonacci-Zahlen $F_0 = 0$, $F_1 = 1$, $F_(k+1) = F_k + F_(k-1)$ lassen sich mit Matrixpotenzen berechnen:
$ F = mat(1, 1; 1, 0), quad F^n = mat(F_(n+1), F_n; F_n, F_(n-1)). $
Nachrechnen: $F^2 = mat(2, 1; 1, 1)$, $F^3 = mat(3, 2; 2, 1)$, $F^5 = mat(8, 5; 5, 3)$, $F^(10) = mat(89, 55; 55, 34)$. Der Beweis der Formel geht durch Induktion: $F^(n+1) = F^n F = mat(F_(n+1) + F_n, F_(n+1); F_n + F_(n-1), F_n) = mat(F_(n+2), F_(n+1); F_(n+1), F_n)$.
Man kann $F^n$ durch wiederholtes Quadrieren mit etwa $log_2 n$ Matrixprodukten berechnen: eine sehr schnelle Methode für riesige Fibonacci-Zahlen.]

=== Was *nicht* gilt

#fehler[Viele Regeln aus dem Zahlenrechnen sind für Matrizen *falsch*:
- *Keine Kommutativität:* $A B != B A$ im Allgemeinen (Woche 4).
- *Nullteiler:* $A B = 0$ bedeutet *nicht* $A = 0$ oder $B = 0$. Beispiel: $A = mat(1, 0; 0, 0)$, $B = mat(0, 0; 0, 1)$ ergibt $A B = mat(0, 0; 0, 0)$, obwohl keine der beiden Matrizen null ist. Es gibt sogar Matrizen $N != 0$ mit $N^2 = 0$: $N = mat(0, 1; 0, 0)$.
- *Keine Kürzungsregel:* Aus $A B = A C$ folgt *nicht* $B = C$. Beispiel: $A = mat(1, 0; 0, 0)$, $B = mat(1, 2; 3, 4)$, $C = mat(1, 2; 5, 6)$: beide Produkte sind $mat(1, 2; 0, 0)$, aber $B != C$.
- *Binomische Formel:* $(A + B)^2 = A^2 + A B + B A + B^2$, und das ist im Allgemeinen *nicht* $A^2 + 2 A B + B^2$. Beispiel: $A = mat(1, 1; 0, 1)$, $B = mat(1, 0; 1, 1)$: $(A + B)^2 = mat(5, 4; 4, 5)$, aber $A^2 + 2 A B + B^2 = mat(6, 4; 4, 4)$. Die binomische Formel gilt nur, wenn $A B = B A$.
]

#warum[Warum keine Kürzungsregel][Aus $A B = A C$ folgt $A (B - C) = 0$. Wäre $A$ eine «Zahl $!= 0$», könnte man teilen. Bei Matrizen kann $A$ aber Nullteiler sein: Es gibt Vektoren $bold(x) != bold(0)$ mit $A bold(x) = bold(0)$ (wenn $rang(A) < n$, Woche 4), und dann «frisst» $A$ Information. Nur für *invertierbare* Matrizen (Woche 6) darf man kürzen: mit $A^(-1)$ von links multiplizieren.]

== Spalten- und Zeilenstruktur des Produkts

Das Matrixprodukt lässt sich auf mehrere Arten lesen. Die wichtigsten zwei sind die Zeilen- und die Spaltensicht.

#fg("l05_falk", [Das *Falk-Schema* zum Rechnen von Hand: $A$ links unten, $B$ rechts oben, das Produkt $C = A B$ in der Mitte rechts. Der Eintrag $c_(i j)$ ist das Skalarprodukt der Zeile $i$ von $A$ und der Spalte $j$ von $B$.], w: 100%)

#satz[Spalten und Zeilen von $A B$][Sei $A in RR^(m times p)$ und $B in RR^(p times n)$ mit Spalten $bold(b)_1, dots, bold(b)_n$ und Zeilen $bold(a)^((1)), dots, bold(a)^((m))$ von $A$. Dann gilt
+ Die *$j$-te Spalte* von $A B$ ist $A bold(b)_j$: $A B = (A bold(b)_1 | A bold(b)_2 | dots | A bold(b)_n)$.
+ Die *$i$-te Zeile* von $A B$ ist (Zeile $i$ von $A$) mal $B$.
+ Jede Spalte von $A B$ ist eine *Linearkombination der Spalten von $A$*; jede Zeile von $A B$ ist eine *Linearkombination der Zeilen von $B$*.]

#beweis[(1) Der $i$-te Eintrag der $j$-ten Spalte von $A B$ ist $(A B)_(i j) = a_(i k) b_(k j)$, und das ist genau $(A bold(b)_j)_i$ (Definition Matrix mal Vektor). (2) Analog: Zeile $i$ von $A B$ hat die Einträge $a_(i k) b_(k j)$, $j = 1, dots, n$, also $sum_k a_(i k) dot (k "-te Zeile von" B)$. (3) Aus (1) und $A bold(x) = x_1 bold(a)_1 + dots + x_p bold(a)_p$ (Woche 2), sowie aus (2).]

#bsp[Spalten- und Zeilensicht][
$ A = mat(1, 2, 3; 0, 1, -1), quad B = mat(1, 0; 2, 1; 0, 3), quad A B = mat(5, 11; 2, -2). $
Zweite Spalte von $A B$: $A vec(0, 1, 3) = 0 vec(1, 0) + 1 vec(2, 1) + 3 vec(3, -1) = vec(11, -2)$ ✓. Zweite Zeile von $A B$: $(0, 1, -1) B = 0 (1, 0) + 1 (2, 1) + (-1)(0, 3) = (2, -2)$ ✓.
]

=== Zeilenumformungen sind Matrixmultiplikationen

Aus (2) folgt etwas sehr Schönes: Wenn man eine Matrix *von links* mit einer geeigneten Matrix multipliziert, kann man damit *Zeilenumformungen* ausführen.

#defn[Elementarmatrizen][Eine *Elementarmatrix* entsteht aus der Einheitsmatrix $I$ durch *eine* elementare Zeilenumformung.]

#bsp[Elementarmatrizen in Aktion][Sei $M = mat(1, 2, 3; 4, 5, 6; 7, 8, 9)$.
- *Vertauschen* $Z_1 arrow.l.r Z_2$: $E_1 = mat(0, 1, 0; 1, 0, 0; 0, 0, 1)$. Dann ist $E_1 M = mat(4, 5, 6; 1, 2, 3; 7, 8, 9)$: die Zeilen 1 und 2 sind vertauscht.
- *Skalieren* $Z_2 arrow.r 3 Z_2$: $E_2 = mat(1, 0, 0; 0, 3, 0; 0, 0, 1)$. $E_2 M$ hat die zweite Zeile $(12, 15, 18)$.
- *Addieren* $Z_2 arrow.r Z_2 - 4 Z_1$: $E_3 = mat(1, 0, 0; -4, 1, 0; 0, 0, 1)$. $E_3 M = mat(1, 2, 3; 0, -3, -6; 7, 8, 9)$.
Multipliziert man dieselben Matrizen *von rechts*, so wirken sie auf die *Spalten*: $M E_1 = mat(2, 1, 3; 5, 4, 6; 8, 7, 9)$ (Spalten 1 und 2 vertauscht).]

#satz[Zeilenumformung = Linksmultiplikation][Führt man eine elementare Zeilenumformung an $A$ aus, so erhält man $E A$, wobei $E$ die Elementarmatrix zur selben Umformung ist. Das Gauss-Verfahren ist also eine Folge von Multiplikationen von links: $E_k dots E_2 E_1 A = R$ (mit $R$ in Zeilenstufenform).]

Das ist die Brücke zur *LR-Zerlegung* (Woche 7/8) und zur Inversen (Woche 6): Wenn man das Produkt $E_k dots E_1$ als *eine* Matrix zusammenfasst, hat man die gesamte Elimination in einer Matrix gespeichert.

== Transpositionsregeln

#satz[Regeln für die Transponierte][Für Matrizen passender Grösse und $c in RR$ gilt:
+ $(A^tp)^tp = A$
+ $(A + B)^tp = A^tp + B^tp$
+ $(c A)^tp = c A^tp$
+ $(A B)^tp = B^tp A^tp$ (*Reihenfolge dreht sich um!*)
]

#beweis[(1)-(3) sind klar aus $(A^tp)_(i j) = a_(j i)$. Zu (4): Mit Summenkonvention ist
$ ((A B)^tp)_(i j) = (A B)_(j i) = a_(j k) b_(k i) = b_(k i) a_(j k) = (B^tp)_(i k) (A^tp)_(k j) = (B^tp A^tp)_(i j). $]

Die Reihenfolge-Umkehr kennt man aus dem Alltag: Wer die Socken *und dann* die Schuhe anzieht, muss zum Ausziehen *erst* die Schuhe und *dann* die Socken ausziehen. Ganz entsprechend gilt $(A B C)^tp = C^tp B^tp A^tp$.

#bsp[Rechnen mit Transponierten][Mit $A = mat(1, 2, 3; 0, 1, -1)$ und $B = mat(1, 0; 2, 1; 0, 3)$ ist $A B = mat(5, 11; 2, -2)$, also $(A B)^tp = mat(5, 2; 11, -2)$. Andererseits $B^tp A^tp = mat(1, 2, 0; 0, 1, 3) mat(1, 0; 2, 1; 3, -1) = mat(5, 2; 11, -2)$ ✓.]

#satz[$A^tp A$ ist symmetrisch][Für jede Matrix $A in RR^(m times n)$ sind $A^tp A in RR^(n times n)$ und $A A^tp in RR^(m times m)$ symmetrisch.]

#beweis[$(A^tp A)^tp = A^tp (A^tp)^tp = A^tp A$. Analog für $A A^tp$.]

Für einen Spaltenvektor $bold(x)$ ist $bold(x)^tp bold(x) = x_1^2 + dots + x_n^2 = |bold(x)|^2$ eine $1 times 1$-Matrix (eine Zahl): das Quadrat der Länge. Das Skalarprodukt ist $bold(x) dot bold(y) = bold(x)^tp bold(y)$. Die Matrizen $A^tp A$ tauchen in der Statistik ständig auf (Methode der kleinsten Quadrate, Kovarianz).

=== Die Spur

#defn[Spur][Die *Spur* einer quadratischen Matrix ist die Summe der Diagonaleinträge, $spur(A) = a_(i i)$.]

Es gilt $spur(A + B) = spur(A) + spur(B)$, $spur(c A) = c spur(A)$, $spur(A^tp) = spur(A)$ und, interessant, $spur(A B) = spur(B A)$, obwohl $A B != B A$ im Allgemeinen gilt. Beweis: $spur(A B) = a_(i k) b_(k i) = b_(k i) a_(i k) = spur(B A)$. (Man vertauscht nur die Namen der stummen Indizes und die Reihenfolge der Zahlen.)

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Neuronale Netze sind Matrizenprodukte.* Eine Schicht eines neuronalen Netzes rechnet $y = W x + b$ mit einer grossen Matrix $W$. Ein Sprachmodell oder ein Bilderkenner besteht aus Tausenden solcher Produkte hintereinander. Darum bauen Grafikkarten ihre Hardware speziell für das Multiplizieren von Matrizen: Moderne Karten schaffen Billionen solcher Operationen pro Sekunde. Dass $(A B) x = A (B x)$ gilt (Assoziativität), erlaubt dabei, die Reihenfolge so zu wählen, dass die Rechnung am billigsten ist.]

#alltag[*PageRank: das Netz als Matrix.* Jede Webseite ist eine Zeile und eine Spalte; der Eintrag $a_(i j)$ sagt, wie wahrscheinlich es ist, von Seite $j$ auf Seite $i$ zu klicken. Wer das Produkt $A x$ immer wieder bildet, erhält eine Reihenfolge der wichtigsten Seiten. So hat Google angefangen. Das Beispiel zeigt, warum man Matrizen als «Zustände ändern» versteht: $A x$ ist der Zustand nach einem Schritt, $A^2 x$ nach zwei.]

#alltag[*Summenkonvention in der Physik.* Die Einstein'sche Schreibweise $a_i b^i$ (über doppelte Indizes summieren) hat Albert Einstein eingeführt, weil er in der Relativitätstheorie hunderte Summen schreiben musste. Heute ist sie Alltag in der Physik, in der Kontinuumsmechanik und in Programmen wie NumPy (`einsum`). Wer sie versteht, schreibt Tensorrechnungen in einer Zeile.]
// ALLTAG-END

#kurz[
- *Einstein:* Über doppelt vorkommende Indizes wird summiert. $delta_(i j)$ ist das Kronecker-Symbol; $delta_(i j) x_j = x_i$.
- Es gelten: Assoziativität, Distributivität, $I A = A I = A$. Es gelten *nicht*: Kommutativität, Kürzen ($A B = A C arrow.r.not B = C$), Nullteilerfreiheit, binomische Formeln.
- *Spaltenstruktur:* Spalte $j$ von $A B$ ist $A dot$ (Spalte $j$ von $B$). *Zeilenstruktur:* Zeile $i$ von $A B$ ist (Zeile $i$ von $A$) $dot B$. Zeilenumformungen = Multiplikation von links mit Elementarmatrizen.
- *Transposition:* $(A B)^tp = B^tp A^tp$. $A^tp A$ ist symmetrisch. $spur(A B) = spur(B A)$.
]

#aufgaben()

#aufg("Beweis mit Summenkonvention", [Beweise mit der Einsteinschen Summenkonvention: $(A B C)^tp = C^tp B^tp A^tp$ und die Verträglichkeit $(c A) B = c (A B)$.],
[$((A B C)^tp)_(i j) = (A B C)_(j i) = a_(j k) b_(k l) c_(l i) = c_(l i) b_(k l) a_(j k) = (C^tp)_(i l) (B^tp)_(l k) (A^tp)_(k j) = (C^tp B^tp A^tp)_(i j)$. Zweitens: $((c A) B)_(i j) = (c a_(i k)) b_(k j) = c (a_(i k) b_(k j)) = (c (A B))_(i j)$, da $c$ eine Zahl ist.])

#aufg("Nullteiler", [Finde $A, B in RR^(2 times 2)$ mit $A B = 0$, $B A != 0$.],
[$A = mat(0, 1; 0, 0)$ und $B = mat(1, 0; 0, 0)$. Dann $A B = mat(0, 0; 0, 0)$ (Zeile 1 von $A$ mal Spalte 1 von $B$: $0 dot 1 + 1 dot 0 = 0$, alle anderen Einträge ebenso), aber $B A = mat(0, 1; 0, 0) != 0$ ✓.])

#aufg("Elementarmatrizen", [Gib die Elementarmatrix $E in RR^(3 times 3)$ an, die $Z_3 arrow.r Z_3 + 2 Z_1$ ausführt, und berechne $E M$ für $M = mat(1, 0, 2; 0, 1, 1; 3, 1, 0)$. Welche Matrix führt die Umkehrung aus?],
[$E = mat(1, 0, 0; 0, 1, 0; 2, 0, 1)$, $E M = mat(1, 0, 2; 0, 1, 1; 5, 1, 4)$ (dritte Zeile $(3, 1, 0) + 2 (1, 0, 2) = (5, 1, 4)$). Die Umkehrung $Z_3 arrow.r Z_3 - 2 Z_1$ gehört zu $E' = mat(1, 0, 0; 0, 1, 0; -2, 0, 1)$ und es gilt $E' E = I$.])

#aufg("Potenzen", [Berechne $A^n$ für $A = mat(1, 1; 0, 1)$ (vermute eine Formel und beweise sie mit Induktion). Und für $A = mat(2, 0; 0, 3)$.],
[$A^2 = mat(1, 2; 0, 1)$, $A^3 = mat(1, 3; 0, 1)$, Vermutung $A^n = mat(1, n; 0, 1)$. Induktion: $A^(n+1) = A^n A = mat(1, n; 0, 1) mat(1, 1; 0, 1) = mat(1, n + 1; 0, 1)$ ✓. Für die Diagonalmatrix ist $A^n = mat(2^n, 0; 0, 3^n)$ (Diagonalmatrizen werden eintragsweise potenziert).])

#aufg("Spur und Produkt", [Zeige, dass es keine Matrizen $A, B in RR^(n times n)$ mit $A B - B A = I$ gibt.],
[Wende die Spur an: $spur(A B - B A) = spur(A B) - spur(B A) = 0$, aber $spur(I) = n != 0$. Widerspruch.])
