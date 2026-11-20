#import "lib.typ": *

= Basis, Dimension und Koordinaten

#woche(13, [Geometrie der Unabhängigkeit, Basis, Dimension, Koordinaten], [geometrische Deutung · Basis · Dimension · Koordinaten · Rang = Zeilenrang = Spaltenrang])

#vorlesung[Jetzt fügen wir zusammen, was wir letzte Woche getrennt betrachtet haben: Ein Erzeugendensystem, das nichts Überflüssiges enthält, heisst *Basis*. Eine Basis ist das «Koordinatensystem» eines Vektorraums: Mit ihr lässt sich jeder Vektor auf genau eine Weise durch Zahlen (Koordinaten) beschreiben. Die Anzahl der Basisvektoren ist eine Eigenschaft des Raums selbst, die *Dimension*. Als Belohnung erhalten wir endlich den Beweis, dass der Rang einer Matrix mit dem Rang ihrer Transponierten übereinstimmt.]

== Geometrische Deutung der linearen Unabhängigkeit

#table(columns: (auto, 1fr, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [*Anzahl der Vektoren*], [*in der Ebene $RR^2$*], [*im Raum $RR^3$*],
  [1 Vektor $bold(v) != bold(0)$], [unabhängig; spannt eine Gerade auf], [unabhängig; spannt eine Gerade auf],
  [2 Vektoren], [abhängig $arrow.l.r.double$ *parallel* (liegen auf einer Geraden durch $bold(0)$)], [abhängig $arrow.l.r.double$ *parallel*; unabhängig: spannen eine Ebene auf],
  [3 Vektoren], [immer abhängig], [abhängig $arrow.l.r.double$ *komplanar* (in einer Ebene durch $bold(0)$); unabhängig: spannen den ganzen Raum auf],
  [4 oder mehr], [immer abhängig], [immer abhängig])

#fgs(("l13_kompl", "l13_nicht"), [Drei Vektoren im Raum: Liegen sie in einer Ebene durch den Nullpunkt, so sind sie linear abhängig (hier ist $bold(a) + bold(b)$ eine Kombination der beiden anderen). Zeigt einer aus der Ebene heraus, so sind sie unabhängig.])

Im $RR^3$ gilt: Drei Vektoren $bold(a), bold(b), bold(c)$ sind genau dann linear abhängig, wenn die Determinante der Matrix $(bold(a) | bold(b) | bold(c))$ null ist, wenn also das von ihnen aufgespannte Spat *das Volumen $0$* hat (Woche 8). Zwei Vektoren im $RR^2$ sind genau dann abhängig, wenn das aufgespannte Parallelogramm den Flächeninhalt $0$ hat.

== Basis

#defn[Basis][Eine Familie $(bold(b)_1, dots, bold(b)_n)$ von Vektoren eines Vektorraums $V$ heisst *Basis* von $V$, wenn sie
+ ein *Erzeugendensystem* von $V$ ist ($erz{bold(b)_1, dots, bold(b)_n} = V$) und
+ *linear unabhängig* ist.]

#intu[Ein Erzeugendensystem ist «genug» Vektoren, eine linear unabhängige Familie ist «nicht zu viele» Vektoren. Eine Basis ist beides: *genau richtig*. Sie ist wie ein vollständiger, aber redundanzfreier Satz von Bausteinen: Man kann jeden Vektor bauen, und zwar nur auf eine einzige Weise.]

#satz[Eindeutige Darstellung][Eine Familie $(bold(b)_1, dots, bold(b)_n)$ ist genau dann eine Basis von $V$, wenn sich *jeder* Vektor $bold(v) in V$ auf *genau eine* Weise als Linearkombination
$ bold(v) = x_1 bold(b)_1 + dots + x_n bold(b)_n $
schreiben lässt.]

#beweis[«$arrow.r.double$»: Existenz folgt aus «Erzeugendensystem». Eindeutigkeit: Ist $sum x_i bold(b)_i = sum y_i bold(b)_i$, so ist $sum (x_i - y_i) bold(b)_i = bold(0)$, und wegen der Unabhängigkeit $x_i = y_i$ für alle $i$. «$arrow.l.double$»: Dass jeder Vektor darstellbar ist, heisst Erzeugendensystem. Der Nullvektor $bold(0) = 0 bold(b)_1 + dots + 0 bold(b)_n$ ist darstellbar, und wegen der Eindeutigkeit ist dies die einzige Darstellung: Das ist die Unabhängigkeit.]

#bsp[Basen][
- *Standardbasis* des $KK^n$: $bold(e)_1, dots, bold(e)_n$ (Erzeugendensystem und unabhängig, siehe Woche 12). Für $KK^2$: $(1, 0), (0, 1)$.
- Eine andere Basis von $RR^2$: $bold(b)_1 = (1, 1)$, $bold(b)_2 = (1, -1)$. Die Matrix hat $det = -2 != 0$, also sind sie unabhängig und erzeugend.
- $PP_n$ hat die Basis $1, x, x^2, dots, x^n$ ($n + 1$ Elemente). Auch $1, (x - 1), (x - 1)^2, dots, (x - 1)^n$ ist eine Basis von $PP_n$ (Entwicklung nach Potenzen von $x - 1$, Taylor).
- $RR^(m times n)$ hat die Basis $E_(i j)$ ($m n$ Matrizen).
- Die symmetrischen $2 times 2$-Matrizen haben die Basis $mat(1, 0; 0, 0)$, $mat(0, 0; 0, 1)$, $mat(0, 1; 1, 0)$ (drei Matrizen).
- Die Ebene $U = {x + 2y - z = 0}$ hat die Basis $(-2, 1, 0), (1, 0, 1)$ (aus dem Kern der Matrix $(1, 2, -1)$ abgelesen: zwei freie Parameter, zwei Basisvektoren).
- $CC$ als Vektorraum über $RR$ hat die Basis $1, i$; als Vektorraum über $CC$ die Basis $1$.
]

#rezept[Basis des Kerns und des Bildes][
  *Kern:* Löse $A bold(x) = bold(0)$. Jede freie Variable liefert einen Basisvektor: Setze sie $= 1$ und die übrigen freien Variablen $= 0$. Die Anzahl der Basisvektoren ist $n - rang(A)$.
  *Bild:* Bringe $A$ auf Zeilenstufenform. Die *Spalten von $A$* (die ursprünglichen!), die zu den *Pivotspalten* gehören, bilden eine Basis von $Bild(A)$. Die Anzahl ist $rang(A)$.
]

#bsp[Basis von Kern und Bild][
$ A = mat(1, 2, 0, 1; 2, 4, 1, 5; 3, 6, 1, 6) arrow.r mat(1, 2, 0, 1; 0, 0, 1, 3; 0, 0, 0, 0). $
Pivotspalten: 1 und 3. *Bild:* Basis aus den Spalten 1 und 3 von $A$: $(1, 2, 3)$ und $(0, 1, 1)$. *Kern:* Freie Variablen $x_2, x_4$. Mit $x_2 = 1, x_4 = 0$: $x_3 = 0$, $x_1 = -2$, also $(-2, 1, 0, 0)$. Mit $x_2 = 0, x_4 = 1$: $x_3 = -3$, $x_1 = -1$, also $(-1, 0, -3, 1)$. Der Kern hat die Basis $(-2, 1, 0, 0), (-1, 0, -3, 1)$. Rang $2$, Kerndimension $4 - 2 = 2$.
]

== Dimension

Eine Basis ist nicht eindeutig, aber ihre *Länge* ist es. Dafür braucht man ein Schlüssellemma:

#satz[Austauschlemma][Wird $V$ von $k$ Vektoren erzeugt, so sind je $m > k$ Vektoren in $V$ linear abhängig.]

#beweis[Seien $bold(v)_1, dots, bold(v)_k$ ein Erzeugendensystem und $bold(w)_1, dots, bold(w)_m$ Vektoren mit $m > k$. Jedes $bold(w)_j$ ist LK der $bold(v)_i$: $bold(w)_j = sum_(i=1)^k a_(i j) bold(v)_i$. Für Koeffizienten $c_1, dots, c_m$ ist dann
$ sum_(j=1)^m c_j bold(w)_j = sum_(i=1)^k (sum_(j=1)^m a_(i j) c_j) bold(v)_i. $
Das HLGS $sum_j a_(i j) c_j = 0$ ($i = 1, dots, k$) hat $k$ Gleichungen und $m > k$ Unbekannte, also (Woche 4) eine *nichttriviale* Lösung $(c_1, dots, c_m)$. Für sie ist $sum c_j bold(w)_j = bold(0)$: Die $bold(w)_j$ sind linear abhängig.]

#satz[Alle Basen sind gleich lang][Hat ein Vektorraum $V$ eine Basis aus $n$ Vektoren, so hat *jede* Basis von $V$ genau $n$ Vektoren.]

#beweis[Seien $(bold(b)_1, dots, bold(b)_n)$ und $(bold(c)_1, dots, bold(c)_m)$ Basen. Da die $bold(b)_i$ erzeugen und die $bold(c)_j$ unabhängig sind, folgt $m <= n$ (Lemma). Vertauscht man die Rollen, folgt $n <= m$.]

#defn[Dimension][Hat der Vektorraum $V$ eine Basis aus $n$ Vektoren, so heisst $n$ die *Dimension* von $V$, $dimn(V) = n$. Für $V = {bold(0)}$ ist $dimn V = 0$ (leere Basis). Hat $V$ keine endliche Basis, so ist $dimn V = infinity$.]

#table(columns: (auto, auto), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [*Vektorraum*], [*Dimension*],
  [$KK^n$], [$n$],
  [$KK^(m times n)$], [$m n$],
  [$PP_n$ (Polynome vom Grad $<= n$)], [$n + 1$],
  [symmetrische $n times n$-Matrizen], [$n(n + 1)\/2$],
  [antisymmetrische $n times n$-Matrizen], [$n(n - 1)\/2$],
  [$CC^n$ über $CC$ / über $RR$], [$n$ / $2n$],
  [$KK[x]$, $C(RR)$], [$infinity$])

=== Sätze über die Dimension

#satz[Basiskriterien][Sei $dimn V = n$. Dann gilt:
+ Jede linear unabhängige Familie in $V$ hat höchstens $n$ Vektoren. Jedes Erzeugendensystem hat mindestens $n$ Vektoren.
+ Eine Familie aus $n$ *linear unabhängigen* Vektoren ist schon eine Basis.
+ Ein Erzeugendensystem aus $n$ Vektoren ist schon eine Basis.
+ *Basisergänzung:* Jede linear unabhängige Familie lässt sich zu einer Basis ergänzen.
+ *Basisauswahl:* Aus jedem endlichen Erzeugendensystem kann man eine Basis auswählen (indem man überflüssige Vektoren weglässt).
]

#beweis[(1) ist das Austauschlemma. (2) Wäre eine unabhängige Familie $(bold(v)_1, dots, bold(v)_n)$ nicht erzeugend, so gäbe es $bold(w) in.not erz{bold(v)_i}$, und $(bold(v)_1, dots, bold(v)_n, bold(w))$ wäre unabhängig (sonst wäre $bold(w)$ LK der $bold(v)_i$): $n + 1$ unabhängige Vektoren, im Widerspruch zu (1). (3) Wäre ein Erzeugendensystem aus $n$ Vektoren abhängig, so könnte man einen Vektor weglassen (er ist LK der anderen) und hätte ein Erzeugendensystem aus $n - 1$ Vektoren, im Widerspruch zu (1). (4) Füge der unabhängigen Familie so lange einen Vektor ausserhalb des Erzeugnisses hinzu, bis sie erzeugt; der Prozess endet nach spätestens $n$ Schritten. (5) Lasse wiederholt einen Vektor weg, der LK der anderen ist, bis die Familie unabhängig ist.]

#satz[Dimension von Unterräumen][Ist $U$ ein Unterraum des endlichdimensionalen $V$, so gilt $dimn U <= dimn V$. Aus $dimn U = dimn V$ folgt $U = V$.]

#beweis[Eine Basis von $U$ ist eine unabhängige Familie in $V$, hat also höchstens $dimn V$ Elemente. Hat sie genau $dimn V$ Elemente, so ist sie nach Satz (2) eine Basis von $V$, also $U = V$.]

#merke[Das macht Dimensionsvergleiche zu einem mächtigen Beweiswerkzeug: Will man zeigen, dass zwei Unterräume $U subset.eq W$ gleich sind, genügt es, $dimn U = dimn W$ nachzuweisen. In der Ebene $RR^2$ sind die Unterräume: ${bold(0)}$ (Dimension 0), Geraden durch $bold(0)$ (Dim. 1), und $RR^2$ (Dim. 2). Nichts anderes. Im $RR^3$: Punkt $bold(0)$, Geraden, Ebenen durch $bold(0)$, $RR^3$.]

== Rang, Zeilenrang, Spaltenrang

Jetzt lösen wir das Versprechen von Woche 4 ein.

#satz[Rang = Zeilenrang = Spaltenrang][Für $A in KK^(m times n)$ sei $r$ die Anzahl der Pivots einer Zeilenstufenform. Dann gilt:
+ $dimn Bild(A) = r$ (der *Spaltenraum* hat die Dimension $r$).
+ Der *Zeilenraum* (das Erzeugnis der Zeilen) hat die Dimension $r$.
+ Insbesondere ist $r$ unabhängig vom Weg der Elimination, und $rang(A) = rang(A^tp)$.
+ $dimn Kern(A) = n - r$.]

#beweis[(2) Zeilenumformungen ändern den Zeilenraum nicht (jede neue Zeile ist LK der alten und umgekehrt, weil die Umformungen umkehrbar sind). Die von null verschiedenen Zeilen einer Zeilenstufenform sind linear unabhängig (jede hat einen Pivot in einer Spalte, in der alle anderen unterhalb Null sind; ein LK, die null ergibt, hat sukzessive alle Koeffizienten $= 0$) und erzeugen den Zeilenraum: Sie bilden eine Basis, also $dimn = r$. Insbesondere ist $r$ eine Eigenschaft von $A$ (die Dimension des Zeilenraums) und nicht des Eliminationsweges.
(1) Die Spalten von $A$, die zu Pivotspalten gehören, sind linear unabhängig (das HLGS mit nur diesen Spalten hat in der ZSF in jeder Spalte einen Pivot, also nur die triviale Lösung) und erzeugen $Bild(A)$ (jede andere Spalte lässt sich nach Auflösen des HLGS als LK der Pivotspalten schreiben). Also $dimn Bild(A) = r$.
(3) Aus (1) und (2): Zeilenrang $= r =$ Spaltenrang. Die Zeilen von $A$ sind die Spalten von $A^tp$, also $rang(A^tp) = rang(A)$.
(4) Der Kern hat nach dem Rezept oben eine Basis aus $n - r$ Vektoren (eine pro freier Variablen).]

#satz[Rangsatz (Dimensionsformel)][Für $A in KK^(m times n)$ gilt
$ dimn Kern(A) + dimn Bild(A) = n. $]

Das ist die Aussage: «Was der Kern an Dimension verschluckt, fehlt im Bild.» Wir benutzen diese Formel in Woche 14 für lineare Abbildungen.

== Koordinaten

#defn[Koordinaten][Sei $cal(B) = (bold(b)_1, dots, bold(b)_n)$ eine Basis von $V$. Nach dem Satz über die eindeutige Darstellung gibt es für jedes $bold(v) in V$ eindeutig bestimmte Zahlen $x_1, dots, x_n$ mit $bold(v) = x_1 bold(b)_1 + dots + x_n bold(b)_n$. Sie heissen die *Koordinaten* von $bold(v)$ bezüglich $cal(B)$, und der Vektor
$ [bold(v)]_(cal(B)) = vec(x_1, dots.v, x_n) in KK^n $
heisst der *Koordinatenvektor* von $bold(v)$ bezüglich $cal(B)$.]

#fg("l13_koord", [Dasselbe Wort «Vektor» kann man in verschiedenen Koordinatensystemen beschreiben. Bezüglich der Standardbasis hat $bold(v)$ die Koordinaten $(3, 1)$, bezüglich der Basis $cal(B) = ((1, 1), (1, -1))$ die Koordinaten $(2, 1)$.], w: 72%)

#bsp[Koordinaten berechnen][
Gesucht: Koordinaten von $bold(v) = (3, 1)$ bezüglich $cal(B) = ((1, 1), (1, -1))$. Ansatz $x_1 (1, 1) + x_2 (1, -1) = (3, 1)$: $x_1 + x_2 = 3$, $x_1 - x_2 = 1$, also $x_1 = 2$, $x_2 = 1$. $[bold(v)]_(cal(B)) = (2, 1)^tp$.
Ein Koordinatenvektor ist also die Lösung eines LGS: Mit der Matrix $B = (bold(b)_1 | dots | bold(b)_n)$ (Basisvektoren als Spalten) gilt $B [bold(v)]_(cal(B)) = bold(v)$ (für $V = KK^n$), also $[bold(v)]_(cal(B)) = B^(-1) bold(v)$.
]

#bsp[Koordinaten von Polynomen][
Das Polynom $p(x) = 2 + 3 x - x^2$ hat bezüglich der Basis $(1, x, x^2)$ die Koordinaten $(2, 3, -1)$ (die Koeffizienten). Bezüglich der Basis $(1, x - 1, (x - 1)^2)$ hat es die Koordinaten $(4, 1, -1)$: $p(x) = 4 + (x - 1) - (x - 1)^2$. (Das ist die Taylor-Entwicklung von $p$ bei $1$: $p(1) = 4$, $p'(1) = 1$, $p''(1)\/2 = -1$. Nachrechnen: $4 + x - 1 - (x^2 - 2x + 1) = 2 + 3x - x^2$ ✓.)
Der Raum der Polynome vom Grad $<= 2$ «ist» also (nach Wahl einer Basis) der Raum $RR^3$: Addieren und Strecken von Polynomen geschieht koeffizientenweise.
]

#satz[Koordinaten sind verträglich mit den Operationen][$[bold(u) + bold(v)]_(cal(B)) = [bold(u)]_(cal(B)) + [bold(v)]_(cal(B))$ und $[c bold(v)]_(cal(B)) = c [bold(v)]_(cal(B))$. Eine Familie $(bold(v)_1, dots, bold(v)_k)$ ist genau dann linear unabhängig, wenn ihre Koordinatenvektoren es sind.]

Das Wesentliche: *Jeder $n$-dimensionale Vektorraum über $KK$ verhält sich (nach Wahl einer Basis) wie $KK^n$.* Man sagt, er sei *isomorph* zu $KK^n$. Der abstrakte Begriff des Vektorraums bringt also, wenn man nur endliche Dimension betrachtet, keine neuen Räume, aber eine neue Freiheit: Man darf die Basis passend zum Problem wählen. Eine kluge Basis kann ein schwieriges Problem einfach machen.

#kurz[
- Geometrisch: 2 Vektoren abhängig $arrow.l.r.double$ parallel; 3 Vektoren im Raum abhängig $arrow.l.r.double$ komplanar $arrow.l.r.double$ $det = 0$.
- *Basis* = Erzeugendensystem + linear unabhängig $arrow.l.r.double$ jeder Vektor hat genau eine Darstellung $sum x_i bold(b)_i$.
- Alle Basen haben gleich viele Elemente: *Dimension*. $dimn KK^n = n$, $dimn PP_n = n + 1$, $dimn KK^(m times n) = m n$. In Dimension $n$: $n$ unabhängige oder $n$ erzeugende Vektoren genügen. Basisergänzung, Basisauswahl. $dimn U <= dimn V$, Gleichheit $arrow.r.double$ $U = V$.
- *Rang = Zeilenrang = Spaltenrang*; $dimn Kern(A) + dimn Bild(A) = n$.
- *Koordinatenvektor* $[bold(v)]_(cal(B))$: eindeutige Koeffizienten; $B [bold(v)]_(cal(B)) = bold(v)$.
]

#aufgaben()

#aufg("Basis des Lösungsraums", [Bestimme eine Basis und die Dimension von $U = {(x_1, x_2, x_3, x_4) in RR^4 : x_1 + x_2 + x_3 + x_4 = 0, x_1 - x_2 + x_3 - x_4 = 0}$.],
[Matrix $mat(1, 1, 1, 1; 1, -1, 1, -1) arrow.r mat(1, 1, 1, 1; 0, -2, 0, -2)$, Rang $2$. Freie Variablen $x_3, x_4$. $x_2 = -x_4$, $x_1 = -x_2 - x_3 - x_4 = -x_3$. Mit $(x_3, x_4) = (1, 0)$: $(-1, 0, 1, 0)$; mit $(0, 1)$: $(0, -1, 0, 1)$. Basis: $(-1, 0, 1, 0), (0, -1, 0, 1)$, $dimn U = 2$ ($= 4 - 2$).])

#aufg("Ist es eine Basis?", [Ist $((1, 2, 1), (0, 1, 1), (1, 0, -1))$ eine Basis des $RR^3$?],
[$det mat(1, 0, 1; 2, 1, 0; 1, 1, -1) = 1 dot (-1 - 0) - 0 + 1 dot (2 - 1) = -1 + 1 = 0$. Die Familie ist abhängig, also keine Basis ($(1, 0, -1) = (1, 2, 1) - 2 (0, 1, 1)$: $(1, 2 - 2, 1 - 2) = (1, 0, -1)$ ✓).])

#aufg("Basisergänzung", [Ergänze $(1, 1, 0), (0, 1, 1)$ zu einer Basis des $RR^3$.],
[Die beiden sind unabhängig. Man ergänzt mit einem Vektor ausserhalb ihrer Ebene, z. B. $bold(e)_1 = (1, 0, 0)$: $det mat(1, 0, 1; 1, 1, 0; 0, 1, 0) = 1 dot 0 - 0 + 1 dot (1 - 0) = 1 != 0$. Also ist $((1, 1, 0), (0, 1, 1), (1, 0, 0))$ eine Basis.])

#aufg("Koordinaten", [Bestimme die Koordinaten von $bold(v) = (1, 2, 3)$ bezüglich der Basis $cal(B) = ((1, 0, 0), (1, 1, 0), (1, 1, 1))$.],
[$x_1 (1, 0, 0) + x_2 (1, 1, 0) + x_3 (1, 1, 1) = (x_1 + x_2 + x_3, x_2 + x_3, x_3) = (1, 2, 3)$: $x_3 = 3$, $x_2 = -1$, $x_1 = 1 + 1 - 3 = -1$. $[bold(v)]_(cal(B)) = (-1, -1, 3)$. Probe: $-(1, 0, 0) - (1, 1, 0) + 3 (1, 1, 1) = (-2 + 3, -1 + 3, 3) = (1, 2, 3)$ ✓.])

#aufg("Zeilenrang gleich Spaltenrang", [Bestimme $rang(A)$ und $rang(A^tp)$ für $A = mat(1, 2, 3; 2, 4, 6; 1, 0, 1)$ und gib je eine Basis von Zeilen- und Spaltenraum an.],
[Zeilenumformung: $Z_2 - 2 Z_1 = (0, 0, 0)$, $Z_3 - Z_1 = (0, -2, -2)$; Tausch: $mat(1, 2, 3; 0, -2, -2; 0, 0, 0)$: Rang $2$. $A^tp$ hat dann ebenfalls Rang $2$. Basis des Zeilenraums: $(1, 2, 3), (0, 1, 1)$ (aus der ZSF); Basis des Spaltenraums: die Pivotspalten $1, 2$ von $A$: $(1, 2, 1)$ und $(2, 4, 0)$.])
