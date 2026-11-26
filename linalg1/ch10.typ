#import "lib.typ": *

= Determinanten und LGS, Inverse und Vektorräume

#woche(10, [Determinanten, Rang, LGS; Adjunkte und Inverse; Vektorräume], [Cramersche Regel · Adjunkte und Inverse · Vektorraum-Axiome · Nullvektor · komplexe Vektorräume · Beispiele und Sätze])

#vorlesung[Der erste Teil dieser Woche schliesst das Thema «Gleichungssysteme und Determinanten» ab: Wir fassen zusammen, was die Determinante über Lösbarkeit sagt, und erhalten eine Formel für die Inverse. Im zweiten Teil beginnt etwas Neues: Wir lösen uns von Zahlentupeln und fragen allgemein, was *Vektoren* ausmacht. Die Antwort sind acht Rechenregeln (Axiome), und überraschend viele Objekte erfüllen sie: Pfeile, Matrizen, Polynome, Funktionen.]

== Determinanten, Rang und lineare Gleichungssysteme

Wir haben nun mehrere Aussagen, die für eine quadratische Matrix alle auf dasselbe hinauslaufen. Die Zusammenfassung ist eine der wichtigsten Listen des Kurses.

#satz[Der grosse Äquivalenzsatz (Teil 1)][Für $A in RR^(n times n)$ sind äquivalent:
+ $det(A) != 0$.
+ $rang(A) = n$.
+ $A$ ist regulär (invertierbar).
+ $A bold(x) = bold(0)$ hat nur die Lösung $bold(x) = bold(0)$.
+ $A bold(x) = bold(b)$ ist für *jedes* $bold(b)$ lösbar.
+ $A bold(x) = bold(b)$ ist für *ein* $bold(b)$ *eindeutig* lösbar (dann für alle).
+ Die Zeilen und die Spalten von $A$ sind linear unabhängig (Woche 12).
]

Ist $det(A) = 0$, so gilt das Gegenteil von allem: Das HLGS hat nichttriviale Lösungen, und $A bold(x) = bold(b)$ ist für manche $bold(b)$ unlösbar und für die übrigen nie eindeutig lösbar.

=== Die Cramersche Regel

Für quadratische Systeme mit $det(A) != 0$ gibt es eine explizite Lösungsformel:

#satz[Cramersche Regel][Sei $A in RR^(n times n)$ regulär und $bold(b) in RR^n$. Bezeichne $A_i$ die Matrix, die aus $A$ entsteht, wenn man die $i$-te *Spalte* durch $bold(b)$ ersetzt. Dann ist die eindeutige Lösung von $A bold(x) = bold(b)$
$ x_i = det(A_i) / det(A), quad i = 1, dots, n. $]

#bsp[Cramersche Regel][
*$2 times 2$:* $3x + 2y = 9$, $x + 4y = 8$ (das Kiosk-Beispiel aus Woche 1). $det A = 12 - 2 = 10$. $x = det mat(9, 2; 8, 4)\/10 = (36 - 16)\/10 = 2$, $y = det mat(3, 9; 1, 8)\/10 = (24 - 9)\/10 = 3\/2$. ✓
*$3 times 3$:* $A = mat(2, 1, 0; 1, 3, 1; 0, 1, 2)$, $det A = 8$, $bold(b) = (1, 2, 3)^tp$. $det A_1 = det mat(1, 1, 0; 2, 3, 1; 3, 1, 2) = 4$, $det A_2 = det mat(2, 1, 0; 1, 2, 1; 0, 3, 2) = 0$, $det A_3 = det mat(2, 1, 1; 1, 3, 2; 0, 1, 3) = 12$. Also $bold(x) = (4\/8, 0, 12\/8) = (1\/2, 0, 3\/2)$. Probe: $2 dot 1\/2 + 0 = 1$ ✓, $1\/2 + 0 + 3\/2 = 2$ ✓, $0 + 0 + 3 = 3$ ✓.
]

#alltag[Die Cramersche Regel ist schön für *Formeln* (zum Beispiel, um zu sehen, wie die Lösung von den Koeffizienten abhängt, oder um Systeme mit Parametern zu lösen), aber für die Zahlenrechnung *sehr schlecht*: Für $n$ Unbekannte braucht sie $n + 1$ Determinanten. Selbst mit Gauss-Elimination für jede wäre das etwa $n$-mal mehr Arbeit als das Gauss-Verfahren für das ganze System, mit der Entwicklungsformel sogar astronomisch viel. In der Praxis wird sie nur für $n = 2, 3$ benutzt.]

== Adjunkte und Inverse

In Woche 8 haben wir die Adjunkte $adj(A) = (C_(i j))^tp$ definiert und beobachtet, dass $A adj(A) = det(A) I$ gilt. Jetzt beweisen wir das.

#satz[Adjunkte und Inverse][Für jede $A in RR^(n times n)$ gilt
$ A dot adj(A) = adj(A) dot A = det(A) dot I. $
Ist $det(A) != 0$, so ist $A$ regulär mit
$ A^(-1) = 1/det(A) adj(A). $]

#beweis[Der Eintrag $(i, j)$ von $A dot adj(A)$ ist $sum_k a_(i k) (adj A)_(k j) = sum_k a_(i k) C_(j k)$.
*Fall $i = j$:* Das ist $sum_k a_(i k) C_(i k) = det(A)$ nach dem Entwicklungssatz (Entwicklung nach der $i$-ten Zeile).
*Fall $i != j$:* Die Summe $sum_k a_(i k) C_(j k)$ ist die Entwicklung nach der $j$-ten Zeile der Matrix $A'$, die aus $A$ entsteht, indem man die $j$-te Zeile durch die $i$-te Zeile *ersetzt* (die Kofaktoren $C_(j k)$ hängen nicht von der $j$-ten Zeile ab). $A'$ hat zwei gleiche Zeilen, also ist die Summe $det(A') = 0$.
Zusammen: $A adj(A) = det(A) I$. Ebenso (mit Spalten) $adj(A) A = det(A) I$.]

#bsp[Die Inverse einer $3 times 3$-Matrix über die Adjunkte][
Für $A = mat(2, 1, 0; 1, 3, 1; 0, 1, 2)$ ist $det A = 8$ und $adj(A) = mat(5, -2, 1; -2, 4, -2; 1, -2, 5)$ (Woche 8). Also
$ A^(-1) = 1/8 mat(5, -2, 1; -2, 4, -2; 1, -2, 5). $
Probe: $(A A^(-1))_(11) = (2 dot 5 + 1 dot (-2) + 0)\/8 = 1$ ✓. Mit der Inversen lässt sich $A bold(x) = bold(b)$ für $bold(b) = (1, 2, 3)^tp$ lösen: $bold(x) = A^(-1) bold(b) = (1\/8)(5 - 4 + 3, -2 + 8 - 6, 1 - 4 + 15) = (4\/8, 0, 12\/8)$, wie bei der Cramerschen Regel.
Für $2 times 2$ erhält man die bekannte Formel: $adj mat(a, b; c, d) = mat(d, -b; -c, a)$.
]

#fehler[Die Formel $A^(-1) = adj(A)\/det(A)$ ist für Rechnungen mit Zahlen unbrauchbar, wenn $n > 3$ (zu viele Determinanten). Zum Rechnen nimmt man Gauss-Jordan (Woche 6) oder LR. Die Formel ist wertvoll, weil sie zeigt: *Die Einträge der Inversen sind rationale Funktionen der Einträge von $A$* und $A^(-1)$ hat ganzzahlige Einträge, wenn $A$ ganzzahlig ist mit $det A = plus.minus 1$ (siehe $A = mat(1, 2, 3; 0, 1, 4; 5, 6, 0)$ in Woche 6 mit $det = 1$).]

== Vektorräume

#idee[Wir haben viel mit Vektoren im $RR^n$ gerechnet: addiert, mit Zahlen multipliziert, Linearkombinationen gebildet. Dabei wurden nur *wenige Eigenschaften* benutzt, etwa $bold(u) + bold(v) = bold(v) + bold(u)$ oder $c (bold(u) + bold(v)) = c bold(u) + c bold(v)$. Genau diese Eigenschaften erfüllen aber auch viele andere Objekte: Polynome, Matrizen, Funktionen, Folgen. Die Idee der *abstrakten Linearen Algebra* ist: Alles, was sich addieren und mit Zahlen multiplizieren lässt und diese Regeln erfüllt, heisst Vektor, und alle Sätze über Vektoren gelten dann gleichzeitig für alle diese Objekte.]

#fgs(("l10_add", "l10_skal"), [Die beiden Grundoperationen für Pfeile in der Ebene. Ein Vektorraum ist jede Menge, in der es zwei solche Operationen mit denselben Rechenregeln gibt.])

=== Der Körper der Skalare

Die Zahlen, mit denen man Vektoren streckt, heissen *Skalare*. Wir benutzen $KK = RR$ (reelle Zahlen) oder $KK = CC$ (komplexe Zahlen). Komplexe Zahlen $z = x + i y$ mit $i^2 = -1$ werden wie Polynome in $i$ multipliziert: $(1 + 2i)(3 - i) = 3 - i + 6i - 2 i^2 = 5 + 5i$. In beiden Fällen kann man addieren, multiplizieren, subtrahieren und durch jede Zahl $!= 0$ dividieren. Was in diesem Kapitel für $KK$ gesagt wird, gilt für beide.

=== Definition

#defn[Vektorraum][Ein *Vektorraum (VR) über $KK$* ist eine Menge $V$ (deren Elemente *Vektoren* heissen) mit zwei Operationen
- *Addition* $V times V arrow.r V$, $(bold(u), bold(v)) arrow.r.bar bold(u) + bold(v)$,
- *Skalarmultiplikation* $KK times V arrow.r V$, $(c, bold(v)) arrow.r.bar c bold(v)$,
so dass für alle $bold(u), bold(v), bold(w) in V$ und $c, d in KK$ gilt:
#table(columns: (auto, 1fr), stroke: none, inset: (x: 5pt, y: 3pt),
  [(V1)], [$bold(u) + bold(v) = bold(v) + bold(u)$ (Kommutativität)],
  [(V2)], [$(bold(u) + bold(v)) + bold(w) = bold(u) + (bold(v) + bold(w))$ (Assoziativität)],
  [(V3)], [Es gibt einen *Nullvektor* $bold(0) in V$ mit $bold(v) + bold(0) = bold(v)$ für alle $bold(v)$],
  [(V4)], [Zu jedem $bold(v)$ gibt es ein *Negatives* $-bold(v)$ mit $bold(v) + (-bold(v)) = bold(0)$],
  [(V5)], [$c (bold(u) + bold(v)) = c bold(u) + c bold(v)$ (Distributivität)],
  [(V6)], [$(c + d) bold(v) = c bold(v) + d bold(v)$ (Distributivität)],
  [(V7)], [$(c d) bold(v) = c (d bold(v))$ (Assoziativität der Skalare)],
  [(V8)], [$1 bold(v) = bold(v)$])]

Die ersten vier Regeln sagen: $(V, +)$ ist eine *abelsche Gruppe*; die letzten vier regeln das Zusammenspiel mit den Skalaren. Dass $c bold(v) in V$ und $bold(u) + bold(v) in V$ gilt, steckt in der Definition der Operationen: Das Ergebnis muss wieder in $V$ liegen («Abgeschlossenheit»).

#merke[Man unterscheidet die Zahl $0 in KK$ vom *Nullvektor* $bold(0) in V$. Das sind verschiedene Dinge (im $RR^3$ ist $0$ eine Zahl und $bold(0) = (0, 0, 0)$). Auch das Plus in «$c + d$» und das in «$bold(u) + bold(v)$» sind verschiedene Operationen, die zufällig gleich geschrieben werden.]

=== Beispiele

#table(columns: (auto, 1fr, auto), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [*Vektorraum*], [*Vektoren, Operationen*], [*Nullvektor*],
  [$RR^n$ (über $RR$)], [$n$-Tupel, komponentenweise], [$(0, dots, 0)$],
  [$CC^n$ (über $CC$)], [komplexe $n$-Tupel, komponentenweise, komplexe Skalare], [$(0, dots, 0)$],
  [$RR^(m times n)$], [$m times n$-Matrizen, eintragsweise (Woche 4)], [Nullmatrix],
  [$PP_n$ (Polynome vom Grad $<= n$)], [$a_0 + a_1 x + dots + a_n x^n$, koeffizientenweise], [Nullpolynom $0$],
  [$KK[x]$ (alle Polynome)], [wie oben, beliebiger Grad], [$0$],
  [Folgen $(a_k)_(k in NN)$], [gliedweise], [Nullfolge],
  [Funktionen $f: X arrow.r RR$], [$(f + g)(x) = f(x) + g(x)$, $(c f)(x) = c f(x)$], [Nullfunktion $x arrow.r.bar 0$],
  [Lösungen eines HLGS $A bold(x) = bold(0)$], [Lösungsvektoren (Woche 4)], [$bold(0)$],
  [$CC$ als VR über $RR$], [komplexe Zahlen, reelle Skalare], [$0$])

(Die Menge der Funktionen und ihre Unterräume besprechen wir ausführlich in Woche 11.)

Merkwürdige Beispiele zeigen, wie *abstrakt* die Axiome sind:

#bsp[Die positiven reellen Zahlen als Vektorraum][Sei $V = {x in RR : x > 0}$ mit der «Addition» $x plus.o y = x y$ (gewöhnliche Multiplikation) und der «Skalarmultiplikation» $c dot.o x = x^c$ ($c in RR$). Das ist ein Vektorraum über $RR$! Der Nullvektor ist die Zahl $1$ (denn $x plus.o 1 = x dot 1 = x$), das Negative von $x$ ist $1\/x$. Distributivität: $c dot.o (x plus.o y) = (x y)^c = x^c y^c = (c dot.o x) plus.o (c dot.o y)$ ✓. $(c + d) dot.o x = x^(c+d) = x^c x^d = (c dot.o x) plus.o (d dot.o x)$ ✓. Der Logarithmus macht daraus den gewöhnlichen Vektorraum $RR$ (aus Multiplikation wird Addition).]

#bsp[Keine Vektorräume][
- $U = {(x, y) in RR^2 : x + y = 1}$ (eine Gerade, die nicht durch $bold(0)$ geht): Der Nullvektor $(0, 0)$ liegt nicht in $U$, und die Summe zweier Elemente, etwa $(1, 0) + (0, 1) = (1, 1)$ ($1 + 1 = 2 != 1$), liegt nicht in $U$.
- $ZZ^2$ (ganzzahlige Paare) über $RR$: $0.5 dot (1, 0) = (0.5, 0) in.not ZZ^2$. Nicht abgeschlossen unter Skalarmultiplikation.
- Der erste Quadrant ${(x, y): x, y >= 0}$: Es gibt kein Negatives: $-(1, 1) = (-1, -1)$ liegt nicht darin.
]

=== Sätze über Vektorräume

Aus den acht Axiomen folgen die gewohnten Rechenregeln, ohne dass man sie extra fordern müsste.

#satz[Folgerungen aus den Axiomen][In jedem Vektorraum $V$ über $KK$ gilt:
+ Der Nullvektor ist *eindeutig*, und das Negative $-bold(v)$ zu $bold(v)$ ist eindeutig.
+ $0 dot bold(v) = bold(0)$ für alle $bold(v)$, und $c dot bold(0) = bold(0)$ für alle $c$.
+ $(-1) bold(v) = -bold(v)$.
+ Aus $c bold(v) = bold(0)$ folgt $c = 0$ oder $bold(v) = bold(0)$.
+ Aus $bold(u) + bold(w) = bold(v) + bold(w)$ folgt $bold(u) = bold(v)$ (Kürzen).
]

#beweis[(1) Seien $bold(0)$ und $bold(0)'$ Nullvektoren. Dann $bold(0)' = bold(0)' + bold(0) = bold(0) + bold(0)' = bold(0)$. Seien $bold(w), bold(w)'$ beide negativ zu $bold(v)$: $bold(w) = bold(w) + bold(0) = bold(w) + (bold(v) + bold(w)') = (bold(w) + bold(v)) + bold(w)' = bold(0) + bold(w)' = bold(w)'$.
(2) $0 bold(v) = (0 + 0) bold(v) = 0 bold(v) + 0 bold(v)$ nach (V6). Addiere $-(0 bold(v))$ auf beiden Seiten: $bold(0) = 0 bold(v)$. Ebenso $c bold(0) = c (bold(0) + bold(0)) = c bold(0) + c bold(0)$, also $c bold(0) = bold(0)$.
(3) $bold(v) + (-1) bold(v) = 1 bold(v) + (-1) bold(v) = (1 - 1) bold(v) = 0 bold(v) = bold(0)$, also ist $(-1) bold(v)$ das (eindeutige) Negative.
(4) Sei $c bold(v) = bold(0)$ und $c != 0$. Dann $bold(v) = 1 bold(v) = (c^(-1) c) bold(v) = c^(-1) (c bold(v)) = c^(-1) bold(0) = bold(0)$.
(5) Addiere $-bold(w)$ auf beiden Seiten.]

Dass diese Folgerungen ohne Rechnen aus den Axiomen kommen, ist das Wesen der Axiomatik: Man beweist einmal und gewinnt Resultate für *alle* Beispiele.

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Cramer'sche Regel: schön, aber nur für kleine Systeme.* Die Formel $x_i = det A_i \/ det A$ löst ein $2 times 2$- oder $3 times 3$-System in einer Zeile und zeigt sofort, wann es keine eindeutige Lösung gibt ($det A = 0$). Für grosse Systeme ist sie hoffnungslos langsam: Die Determinante nach Definition braucht $n!$ Terme, bei $n = 20$ sind das $2.4 dot 10^18$. Darum nimmt man in der Praxis immer Gauss. Cramer nutzt man in der Mechanik oder Elektrotechnik, wenn eine Formel mit Parametern gewünscht ist.]

#alltag[*Vektorräume sind überall, wo man addieren und skalieren darf.* Ein Audiosignal ist ein Vektor aus $44 thin 100$ Zahlen pro Sekunde, ein Foto ein Vektor aus Millionen Pixelwerten, eine Farbe ein Vektor $(R, G, B)$. Zwei Signale addieren (Mischpult), eines mit einer Zahl multiplizieren (Lautstärke): Das sind genau die Vektorraum-Operationen. Weil sie die Axiome erfüllen, darf man die ganze Theorie anwenden, egal wie «exotisch» die Vektoren sind.]
// ALLTAG-END

#kurz[
- Für quadratische $A$ gilt: $det A != 0$ $arrow.l.r.double$ $rang A = n$ $arrow.l.r.double$ regulär $arrow.l.r.double$ $A bold(x) = bold(b)$ ist für alle $bold(b)$ eindeutig lösbar. *Cramersche Regel:* $x_i = det(A_i)\/det(A)$. *Inverse:* $A^(-1) = adj(A)\/det(A)$ (nur für kleine $n$ praktikabel).
- *Vektorraum* über $KK in {RR, CC}$: Menge mit Addition und Skalarmultiplikation, die acht Axiome (V1)-(V8) erfüllt. Nullvektor $bold(0) != 0$.
- Beispiele: $RR^n$, $CC^n$, Matrizen, Polynome, Folgen, Funktionen, Lösungsmengen von HLGS. Nichtbeispiele: Mengen ohne $bold(0)$, nicht abgeschlossene Mengen.
- Folgerungen: $0 bold(v) = bold(0)$, $(-1) bold(v) = -bold(v)$, $c bold(v) = bold(0) arrow.r c = 0$ oder $bold(v) = bold(0)$.
]

#aufgaben()

#aufg("Cramersche Regel", [Löse $x + 2y + z = 4$, $2x + 5y + 3z = 11$, $x + y + 2z = 3$ mit der Cramerschen Regel.],
[$det A = det mat(1, 2, 1; 2, 5, 3; 1, 1, 2) = (10 + 6 + 2) - (5 + 3 + 8) = 18 - 16 = 2$. $det A_1 = det mat(4, 2, 1; 11, 5, 3; 3, 1, 2) = (40 + 18 + 11) - (15 + 12 + 44) = 69 - 71 = -2$. $det A_2 = det mat(1, 4, 1; 2, 11, 3; 1, 3, 2) = (22 + 12 + 6) - (11 + 9 + 16) = 40 - 36 = 4$. $det A_3 = det mat(1, 2, 4; 2, 5, 11; 1, 1, 3) = (15 + 22 + 8) - (20 + 11 + 12) = 45 - 43 = 2$. Also $x = -1$, $y = 2$, $z = 1$ (wie in Woche 2).])

#aufg("Inverse mit der Adjunkten", [Berechne $A^(-1)$ für $A = mat(1, 2; 3, 7)$ und für $B = mat(1, 0, 2; 0, 1, 0; 0, 0, 1)$ mit der Adjunkten.],
[$A$: $det = 7 - 6 = 1$, $adj A = mat(7, -2; -3, 1)$, $A^(-1) = mat(7, -2; -3, 1)$. Probe: $mat(1, 2; 3, 7) mat(7, -2; -3, 1) = mat(7 - 6, -2 + 2; 21 - 21, -6 + 7) = I$ ✓. $B$: Dreiecksmatrix mit $det = 1$. Kofaktoren: $C_(13) = 0$, $C_(11) = 1$, $C_(12) = 0$, $C_(21) = -(0 - 0) = 0$, $C_(22) = 1$, $C_(23) = -(0 - 0) = 0$, $C_(31) = 0 - 2 = -2$, $C_(32) = -(0 - 0) = 0$, $C_(33) = 1$. $adj B = (C_(i j))^tp = mat(1, 0, -2; 0, 1, 0; 0, 0, 1) = B^(-1)$. Probe: $B B^(-1) = mat(1, 0, -2 + 2; 0, 1, 0; 0, 0, 1) = I$ ✓.])

#aufg("Ist das ein Vektorraum?", [Entscheide, ob $V$ mit den üblichen Operationen ein Vektorraum über $RR$ ist: (a) $V = {(x, y) in RR^2 : y = 2 x}$; (b) $V = {(x, y) in RR^2 : x y = 0}$; (c) $V = {f in PP_2 : f(1) = 0}$ (Polynome vom Grad $<= 2$ mit Nullstelle bei $1$); (d) $V = {A in RR^(2 times 2): det A = 0}$.],
[(a) Ja: eine Gerade durch $bold(0)$ (abgeschlossen: $(x, 2x) + (x', 2x') = (x + x', 2(x + x'))$). (b) Nein: $(1, 0) + (0, 1) = (1, 1)$ hat $x y = 1 != 0$ (die Vereinigung zweier Achsen). (c) Ja: $f(1) = 0$ und $g(1) = 0$ geben $(f + g)(1) = 0$ und $(c f)(1) = 0$. (d) Nein: $mat(1, 0; 0, 0) + mat(0, 0; 0, 1) = I$ hat $det = 1$.])

#aufg("Axiome", [Beweise aus den Axiomen: Ist $bold(v) + bold(w) = bold(v)$, so ist $bold(w) = bold(0)$.],
[Addiere $-bold(v)$: $(-bold(v)) + (bold(v) + bold(w)) = (-bold(v)) + bold(v)$. Links: $((-bold(v)) + bold(v)) + bold(w) = bold(0) + bold(w) = bold(w)$ (V2, V1, V3). Rechts: $bold(0)$. Also $bold(w) = bold(0)$.])

#aufg("Komplexe Skalare", [Ist $CC^2$ ein Vektorraum über $RR$? Über $CC$? Was ändert sich, wenn man den Vektor $(1, i)$ mit $i$ multipliziert?],
[Über beiden: ja, die Axiome gelten für reelle wie für komplexe Skalare. Über $CC$ ist $i (1, i) = (i, -1) in CC^2$ ein Vielfaches von $(1, i)$ (die beiden liegen auf derselben «komplexen Geraden»). Über $RR$ sind $(1, i)$ und $(i, -1)$ dagegen linear unabhängig (kein reelles Vielfaches des einen ist das andere). Der gleiche Raum hat also über $RR$ *doppelt so viele* Dimensionen (Woche 13): $dimn_RR CC^2 = 4$, $dimn_CC CC^2 = 2$.])
