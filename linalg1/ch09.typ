#import "lib.typ": *

= Sätze über Determinanten

#woche(9, [Sätze zu Determinanten], [Rechenregeln · allgemeiner Entwicklungssatz · Produktsatz · Blocksatz · Berechnung via LR · Determinante und Rang])

#vorlesung[Die rekursive Definition der Determinante ist für Rechnungen ungeeignet: Eine $n times n$-Determinante hätte $n!$ Summanden. Diese Woche lernen wir, wie sich die Determinante bei Zeilenumformungen verhält. Damit lässt sie sich mit dem Gauss-Verfahren in etwa $n^3\/3$ Schritten berechnen. Wir beweisen den Produktsatz $det(A B) = det(A) det(B)$ und zeigen, dass $det(A) != 0$ genau dann gilt, wenn $A$ vollen Rang hat.]

== Rechenregeln für Determinanten

#satz[Verhalten bei Zeilenumformungen][Für $A in RR^(n times n)$ gilt:
+ $det(I) = 1$.
+ *Zeilen vertauschen:* Vertauscht man zwei Zeilen, so ändert die Determinante ihr *Vorzeichen*.
+ *Zeile mit $c$ multiplizieren:* Multipliziert man *eine* Zeile mit $c$, so wird die Determinante mit $c$ multipliziert.
+ *Additivität in einer Zeile:* Ist die $i$-te Zeile von $A$ die Summe zweier Zeilen $bold(r) + bold(s)$, so ist $det(A) = det(A_(bold(r))) + det(A_(bold(s)))$, wobei $A_(bold(r))$ und $A_(bold(s))$ die Matrizen mit der Zeile $bold(r)$ bzw. $bold(s)$ an Stelle $i$ sind (und sonst gleich $A$).
+ *Vielfaches addieren:* Addiert man das $c$-fache einer Zeile zu einer *anderen* Zeile, so *ändert sich die Determinante nicht*.
+ Hat $A$ zwei *gleiche* Zeilen oder eine *Nullzeile*, so ist $det(A) = 0$.
+ $det(A^tp) = det(A)$. Daher gelten alle Aussagen auch für *Spalten*.
+ $det(c A) = c^n det(A)$.
+ Für eine *Dreiecksmatrix* (oben oder unten) ist $det(A)$ das *Produkt der Diagonaleinträge*.
]

Eigenschaften (3) und (4) zusammen sagen: Die Determinante ist *linear in jeder einzelnen Zeile* (bei festgehaltenen übrigen Zeilen). Sie ist aber *nicht* linear als Ganzes: $det(A + B) != det(A) + det(B)$ und $det(c A) = c^n det(A)$.

#beweisidee[(1), (2), (3), (4) und (7) beweist man durch Induktion nach $n$ mit der Entwicklung nach der ersten Zeile (bzw. einer Zeile, die von der Veränderung nicht betroffen ist). Wir führen die Induktion nicht im Detail vor und leiten dafür alles Weitere daraus her:
- (6): Hat $A$ zwei gleiche Zeilen, so ändert das Vertauschen dieser beiden Zeilen die Matrix nicht, aber nach (2) das Vorzeichen der Determinante: $det A = -det A$, also $det A = 0$. Eine Nullzeile folgt aus (3) mit $c = 0$.
- (5): Addiert man $c Z_j$ zu $Z_i$, so teilt (4) die neue Determinante in $det A + c det A'$, wobei $A'$ zwei gleiche Zeilen ($Z_j$ an Stelle $i$ und $j$) hat; nach (6) ist $det A' = 0$.
- (9): Bei einer oberen Dreiecksmatrix entwickelt man nach der ersten Spalte, in der nur $a_(11)$ steht: $det A = a_(11) det A_(11)$, dann induktiv. Für untere Dreiecksmatrizen entwickelt man nach der ersten Zeile.
- (8): Wende (3) auf alle $n$ Zeilen an.
(7): Die Determinante der Transponierten stimmt mit der von $A$ überein, weil die Entwicklung nach der ersten Zeile von $A$ und die Entwicklung nach der ersten Spalte von $A^tp$ dieselben Terme liefern (Induktion).]

Die wichtigste Folgerung für die Rechnung ist (5): *Das Gauss-Verfahren ändert die Determinante nicht*, solange man nur Vielfache von Zeilen zu anderen addiert.

#fg("l09_scher", [Geometrie hinter Regel (5): Addiert man zu $bold(b)$ ein Vielfaches von $bold(a)$, so wird das Parallelogramm geschert; Grundlinie und Höhe, also die Fläche, bleiben gleich.], w: 70%)

#table(columns: (auto, auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [*Zeilenumformung*], [*Wirkung auf $det$*], [*Elementarmatrix $E$ hat $det E$ =*],
  [$Z_i arrow.l.r Z_j$], [mal $(-1)$], [$-1$],
  [$Z_i arrow.r c Z_i$], [mal $c$], [$c$],
  [$Z_i arrow.r Z_i + c Z_j$], [unverändert], [$1$])

== Der allgemeine Entwicklungssatz

Jetzt können wir den Entwicklungssatz von Woche 8 beweisen.

#satz[Entwicklung nach beliebiger Zeile oder Spalte][Für jede Zeile $i$ und jede Spalte $j$ gilt
$ det(A) = sum_(k=1)^n (-1)^(i+k) a_(i k) M_(i k) = sum_(k=1)^n (-1)^(k+j) a_(k j) M_(k j). $]

#beweis[Wir bringen die $i$-te Zeile durch $i - 1$ *Vertauschungen benachbarter Zeilen* nach oben (die übrigen Zeilen behalten ihre Reihenfolge). Die neue Matrix $A'$ hat nach (2) die Determinante $(-1)^(i-1) det(A)$. In $A'$ ist die erste Zeile gleich der $i$-ten Zeile von $A$, und streicht man in $A'$ die erste Zeile und die Spalte $k$, so erhält man genau $A_(i k)$. Entwicklung von $A'$ nach der ersten Zeile liefert $det(A') = sum_k (-1)^(1+k) a_(i k) det(A_(i k))$. Also $det(A) = (-1)^(i-1) det(A') = sum_k (-1)^(i+k) a_(i k) M_(i k)$. Die Spaltenentwicklung folgt durch Transponieren und (7).]

== Der Produktsatz

#satz[Produktsatz][Für $A, B in RR^(n times n)$ gilt
$ det(A B) = det(A) dot det(B). $]

#beweis[*Schritt 1:* Für eine Elementarmatrix $E$ gilt $det(E A) = det(E) det(A)$. Denn $E A$ entsteht aus $A$ durch eine Zeilenumformung, und die Tabelle oben zeigt, dass sich $det$ genau um den Faktor $det(E)$ ändert. Daraus folgt für Elementarmatrizen $E_1, dots, E_k$: $det(E_1 dots E_k A) = det(E_1) dots det(E_k) det(A)$.
*Schritt 2:* Ist $A$ regulär, so ist $A$ ein Produkt von Elementarmatrizen (Woche 6), $A = E_1 dots E_k$. Dann $det(A B) = det(E_1 dots E_k B) = det(E_1) dots det(E_k) det(B) = det(A) det(B)$, wobei im letzten Schritt Schritt 1 mit $B$ gleich $I$ benutzt wurde: $det(A) = det(E_1 dots E_k I) = det(E_1) dots det(E_k)$.
*Schritt 3:* Ist $A$ singulär, so ist $A B$ singulär (wäre $A B$ regulär, so hätte $A$ eine Rechtsinverse $B (A B)^(-1)$, also wäre $A$ regulär). Beide Seiten sind $0$ (nach Satz unten: singuläre Matrizen haben $det = 0$).]

#bsp[Produktsatz][$A = mat(1, 2; 3, 4)$, $B = mat(0, 1; 1, 5)$: $det A = -2$, $det B = -1$, und $A B = mat(2, 11; 4, 23)$ hat $det = 46 - 44 = 2 = (-2)(-1)$ ✓.]

#satz[Folgerungen][
+ $det(A B) = det(B A)$ (obwohl $A B != B A$ sein kann).
+ Ist $A$ regulär, so ist $det(A^(-1)) = 1\/det(A)$, und $det(A) != 0$.
+ $det(A^k) = (det A)^k$.
+ Ist $Q$ orthogonal, so ist $det(Q) = plus.minus 1$.
]

#beweis[(1) $det(A B) = det A det B = det B det A = det(B A)$. (2) $1 = det(I) = det(A A^(-1)) = det(A) det(A^(-1))$. (4) $1 = det(Q^tp Q) = det(Q^tp) det(Q) = det(Q)^2$.]

Orthogonale Matrizen mit $det = 1$ sind die *Drehungen* (inklusive Drehungen im Raum), solche mit $det = -1$ enthalten eine Spiegelung (Woche 7).

== Der Blocksatz

Matrizen, die nach einem Muster «in Blöcke» zerfallen, haben besonders einfache Determinanten.

#satz[Blocksatz][Hat $M$ die Blockform $M = mat(A, B; 0, D)$ mit quadratischen Blöcken $A in RR^(k times k)$, $D in RR^(l times l)$, einem beliebigen Block $B in RR^(k times l)$ und einem Nullblock unten links, so gilt
$ det(M) = det(A) dot det(D). $
Dasselbe gilt für $mat(A, 0; C, D)$ (Nullblock oben rechts).]

#beweis[Eliminiert man $M$ mit dem Gauss-Verfahren so, dass in den ersten $k$ Spalten nur Zeilenoperationen innerhalb der ersten $k$ Zeilen benutzt werden (sie bringen $A$ auf $R_A$) und in den hinteren Spalten innerhalb der unteren $l$ Zeilen ($D$ auf $R_D$), so ändert sich $det$ nur durch eventuelle Vorzeichen der Vertauschungen, die in beiden Faktoren gleich mitgezählt werden. Die Endmatrix $mat(R_A, B'; 0, R_D)$ ist obere Dreiecksmatrix, ihre Determinante das Produkt der Diagonalen, also $det R_A dot det R_D$. Alternativ beweist man es durch wiederholte Entwicklung nach der ersten Spalte.]

#bsp[Block-Dreiecksmatrix][
$ M = mat(1, 2, 5, 6; 3, 4, 7, 8; 0, 0, 2, 1; 0, 0, 3, 5) $
hat die Blockform mit $A = mat(1, 2; 3, 4)$, $B = mat(5, 6; 7, 8)$, $D = mat(2, 1; 3, 5)$. $det M = det A dot det D = (4 - 6)(10 - 3) = (-2)(7) = -14$. (Der Block $B$ spielt keine Rolle.)
]

#fehler[Der Blocksatz gilt *nicht* für beliebige Blockmatrizen. Bei $mat(A, B; C, D)$ ist im Allgemeinen $det != det A det D - det B det C$. Er gilt nur, wenn ein Nullblock vorhanden ist.]

== Determinanten mit dem Gauss-Verfahren berechnen

Die Entwicklung nach Zeilen braucht für $n times n$ etwa $n!$ Operationen: für $n = 20$ sind das $20! approx 2.4 dot 10^(18)$, für den schnellsten Rechner Jahrzehnte. Mit dem Gauss-Verfahren braucht man etwa $n^3\/3 = 2700$.

#satz[Determinante via LR][Ist $P A = L R$ (Woche 8) mit $s$ Zeilenvertauschungen, so gilt
$ det(A) = (-1)^s dot r_(11) r_(22) dots r_(n n) $
(das Produkt der Diagonaleinträge von $R$, mal $(-1)$ für jede Zeilenvertauschung).]

#beweis[$det(P) det(A) = det(L) det(R)$ nach dem Produktsatz. Es ist $det(L) = 1$ (Dreiecksmatrix mit Einsen), $det(R) = r_(11) dots r_(n n)$, und $det(P) = (-1)^s$, da $P$ aus $s$ Zeilenvertauschungen entsteht. Wegen $det(P) = plus.minus 1$ folgt $det(A) = (-1)^s r_(11) dots r_(n n)$.]

#bsp[Determinante aus der LR-Zerlegung][
$A = mat(2, 1, 1; 4, 3, 3; 8, 7, 9)$ hat $R = mat(2, 1, 1; 0, 1, 1; 0, 0, 2)$ ohne Vertauschungen (Woche 7). $det A = 2 dot 1 dot 2 = 4$.
$A = mat(0, 2, 1; 1, 1, 1; 2, 1, 3)$ (Woche 8): $P$ vertauschte einmal ($s = 1$), $R = mat(2, 1, 3; 0, 1\/2, -1\/2; 0, 0, 3)$. $det A = (-1)^1 dot 2 dot (1\/2) dot 3 = -3$. Direkt mit Sarrus: $0 dot 1 dot 3 + 2 dot 1 dot 2 + 1 dot 1 dot 1 - 1 dot 1 dot 2 - 0 - 2 dot 1 dot 3 = 4 + 1 - 2 - 6 = -3$ ✓.
]

#rezept[Determinanten per Hand][
  + Suche eine Zeile oder Spalte mit *vielen Nullen*; wenn es sehr viele sind, entwickle direkt.
  + Sonst: Forme mit *Typ-(5)-Operationen* (Vielfaches addieren) auf Dreiecksform um. Das ändert $det$ nicht. Notiere jede Vertauschung ($times (-1)$) und jede Skalierung ($times c$, später durch $c$ teilen).
  + Multipliziere die Diagonale.
]

#bsp[Eine Vandermonde-Determinante][
$ det mat(1, a, a^2; 1, b, b^2; 1, c, c^2) = det mat(1, a, a^2; 0, b - a, b^2 - a^2; 0, c - a, c^2 - a^2) = (b - a)(c - a) det mat(1, a, a^2; 0, 1, b + a; 0, 1, c + a). $
Dabei wurde $Z_2 - Z_1$, $Z_3 - Z_1$ gerechnet (ändert $det$ nicht) und aus den Zeilen $2$ und $3$ die Faktoren $(b - a)$ bzw. $(c - a)$ herausgezogen (Regel (3)). Die verbleibende $3 times 3$-Determinante ist $1 dot (c + a - (b + a)) = c - b$. Also $det = (b - a)(c - a)(c - b)$. Sie ist genau dann $0$, wenn zwei der Zahlen $a, b, c$ gleich sind. (Das ist der Grund, warum man durch drei Punkte mit verschiedenen $x$-Werten genau eine Parabel legen kann, Woche 14.)
]

== Determinante und Rang

#satz[Determinante und Rang][Für $A in RR^(n times n)$ sind äquivalent:
+ $det(A) != 0$.
+ $rang(A) = n$.
+ $A$ ist regulär (invertierbar).
+ Die Zeilen (bzw. Spalten) von $A$ sind linear unabhängig.]

#beweis[Bringe $A$ mit Zeilenumformungen auf Zeilenstufenform $R'$. Dabei ändert sich $det$ höchstens um *Faktoren $!= 0$* (Vorzeichen, $c != 0$). Also gilt $det(A) = 0$ genau dann, wenn $det(R') = 0$. $R'$ ist obere Dreiecksmatrix, und $det(R')$ ist das Produkt ihrer Diagonale. Dieses Produkt ist $!= 0$ genau dann, wenn alle $n$ Diagonaleinträge Pivots sind, also $rang(A) = n$. Die Äquivalenz mit (3) ist Woche 6. (4) wird in Woche 12 behandelt.]

#intu[Die Determinante ist der *Test auf Eindeutigkeit*: Die Gleichung $A bold(x) = bold(b)$ ist eindeutig lösbar genau dann, wenn $det(A) != 0$. Geometrisch: $A$ presst den Raum zu einem niederdimensionalen Gebilde zusammen (Volumen $0$) genau dann, wenn $det(A) = 0$. Dann gehen Informationen verloren, und man kann nicht zurück.]

#kurz[
- Verhalten: Vertauschen $arrow.r$ Vorzeichen; Zeile mal $c$ $arrow.r$ mal $c$; Vielfaches addieren $arrow.r$ unverändert; gleiche Zeilen oder Nullzeile $arrow.r$ $0$; $det A^tp = det A$; $det(c A) = c^n det A$; Dreiecksmatrix $arrow.r$ Produkt der Diagonale.
- *Entwicklung* nach jeder Zeile/Spalte (Beweis durch Hochtauschen).
- *Produktsatz* $det(A B) = det A det B$; $det A^(-1) = 1\/det A$; orthogonal $arrow.r$ $det = plus.minus 1$.
- *Blocksatz:* Blockdreiecksform $arrow.r$ $det = det A dot det D$.
- *Berechnung:* $det A = (-1)^s product r_(i i)$ aus $P A = L R$ in etwa $n^3\/3$ Schritten.
- $det A != 0$ $arrow.l.r.double$ $rang A = n$ $arrow.l.r.double$ $A$ regulär.
]

#aufgaben()

#aufg("Determinante mit Zeilenumformungen", [Berechne $det mat(1, 2, 3, 4; 2, 3, 4, 1; 3, 4, 1, 2; 4, 1, 2, 3)$ mit dem Gauss-Verfahren.],
[$Z_2 - 2 Z_1$, $Z_3 - 3 Z_1$, $Z_4 - 4 Z_1$: $mat(1, 2, 3, 4; 0, -1, -2, -7; 0, -2, -8, -10; 0, -7, -10, -13)$. Weiter $Z_3 - 2 Z_2$: $(0, 0, -4, 4)$; $Z_4 - 7 Z_2$: $(0, 0, 4, 36)$. Dann $Z_4 + Z_3$: $(0, 0, 0, 40)$. Dreiecksform mit Diagonale $1, -1, -4, 40$: $det = 1 dot (-1) dot (-4) dot 40 = 160$. Es wurden keine Vertauschungen und keine Skalierungen benutzt.])

#aufg("Determinante mit Parameter", [Für welche $t in RR$ ist $A = mat(1, t, t; t, 1, t; t, t, 1)$ regulär?],
[Addiere die Zeilen 2 und 3 zu Zeile 1: Die erste Zeile wird $(1 + 2t)(1, 1, 1)$. $det A = (1 + 2t) det mat(1, 1, 1; t, 1, t; t, t, 1)$. Mit $Z_2 - t Z_1$, $Z_3 - t Z_1$: $mat(1, 1, 1; 0, 1 - t, 0; 0, 0, 1 - t)$. Also $det A = (1 + 2t)(1 - t)^2$. Regulär genau für $t != 1$ und $t != -1\/2$.])

#aufg("Rechenregeln anwenden", [Es sei $A in RR^(3 times 3)$ mit $det A = 4$. Berechne $det(2 A)$, $det(A^(-1))$, $det(A^2)$, $det(A^tp A)$, und $det(-A)$.],
[$det(2A) = 2^3 dot 4 = 32$. $det(A^(-1)) = 1\/4$. $det(A^2) = 16$. $det(A^tp A) = 4 dot 4 = 16$. $det(-A) = (-1)^3 dot 4 = -4$.])

#aufg("Blocksatz", [Berechne $det mat(2, 1, 0, 0; 1, 2, 0, 0; 5, 7, 3, 1; 4, 6, 1, 3)$.],
[Blockform $mat(A, 0; C, D)$ mit $A = mat(2, 1; 1, 2)$, $D = mat(3, 1; 1, 3)$: $det = (4 - 1)(9 - 1) = 3 dot 8 = 24$. Der Block $C$ spielt keine Rolle.])

#aufg("Orthogonal und Determinante", [Zeige, dass das Produkt zweier orthogonaler Matrizen mit $det = -1$ die Determinante $+1$ hat und folgere: Zwei Spiegelungen ergeben eine Drehung (Woche 7).],
[$det(Q_1 Q_2) = det Q_1 det Q_2 = (-1)(-1) = 1$. Eine orthogonale $2 times 2$-Matrix mit $det = +1$ ist eine Drehung $R(phi.alt)$ (Satz Woche 7). Also ist das Produkt zweier Spiegelungen $S(alpha) S(beta)$ eine Drehung, im Einklang mit $S(alpha) S(beta) = R(2(alpha - beta))$.])
