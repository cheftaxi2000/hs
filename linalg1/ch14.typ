#import "lib.typ": *

= Lineare Abbildungen und Fraktale

#woche(14, [Koordinatenvektor, lineare Abbildungen, Fraktale], [Basiswechsel · lineare Abbildungen · Projektion · Sampling und Interpolation · affin-lineare Abbildungen · Kontraktionen · Hutchinson-Operator · Barnsleys Farn])

#vorlesung[Zum Schluss öffnen wir das letzte Kapitel der Linearen Algebra I: die *Abbildungen* zwischen Vektorräumen, die deren Struktur respektieren. Wir sehen, dass jede solche Abbildung im $KK^n$ durch eine Matrix gegeben ist und dass viele bekannte Operationen (Drehen, Spiegeln, Projizieren, Ableiten, Abtasten) in diese Sprache passen. Das Ende des Kurses ist ein Höhepunkt: Mit *affin-linearen Kontraktionen* lassen sich Fraktale erzeugen, zum Beispiel Barnsleys Farn, bei dem ein kleines Zahlenfeld von $4 times 6$ Zahlen ein ganzes Blatt beschreibt.]

== Beispiele zu Koordinaten und Basiswechsel

Aus Woche 13: Zu einer Basis $cal(B) = (bold(b)_1, dots, bold(b)_n)$ gehört der Koordinatenvektor $[bold(v)]_(cal(B))$. Verschiedene Basen geben verschiedene Koordinaten für denselben Vektor. Wie rechnet man sie um?

#satz[Basiswechsel][Seien $cal(B) = (bold(b)_1, dots, bold(b)_n)$ und $cal(C) = (bold(c)_1, dots, bold(c)_n)$ Basen von $V$. Die *Basiswechselmatrix* $T in KK^(n times n)$ habe als $j$-te Spalte den Koordinatenvektor $[bold(b)_j]_(cal(C))$ des $j$-ten Vektors der alten Basis. Dann gilt für alle $bold(v) in V$:
$ [bold(v)]_(cal(C)) = T [bold(v)]_(cal(B)). $
$T$ ist regulär.]

#beweis[Ist $[bold(v)]_(cal(B)) = (x_1, dots, x_n)$, so ist $bold(v) = sum_j x_j bold(b)_j$, und weil Koordinaten verträglich sind mit Linearkombinationen (Woche 13): $[bold(v)]_(cal(C)) = sum_j x_j [bold(b)_j]_(cal(C)) = T bold(x)$. Der Basiswechsel in die andere Richtung ist $T^(-1)$.]

#bsp[Basiswechsel im $RR^2$][
$cal(B) = ((1, 1), (1, -1))$ und $cal(C) = ((1, 0), (1, 2))$. Um $T$ zu finden, schreibe $bold(b)_1 = (1, 1) = frac(1, 2) bold(c)_1 + frac(1, 2) bold(c)_2$ (denn $frac(1, 2)(1, 0) + frac(1, 2)(1, 2) = (1, 1)$) und $bold(b)_2 = (1, -1) = frac(3, 2) bold(c)_1 - frac(1, 2) bold(c)_2$. Also
$ T = mat(1\/2, 3\/2; 1\/2, -1\/2). $
Für $bold(v) = (3, 1)$ ist $[bold(v)]_(cal(B)) = (2, 1)$ (Woche 13), und $T (2, 1)^tp = (1 + 3\/2, 1 - 1\/2) = (5\/2, 1\/2)$. Probe: $frac(5, 2) (1, 0) + frac(1, 2) (1, 2) = (3, 1)$ ✓.
Mit den Basismatrizen $B = (bold(b)_1 | bold(b)_2)$, $C = (bold(c)_1 | bold(c)_2)$ als Spalten gilt $T = C^(-1) B$.
]

== Lineare Abbildungen

#defn[Lineare Abbildung][Seien $V, W$ Vektorräume über $KK$. Eine Abbildung $f: V arrow.r W$ heisst *linear*, wenn für alle $bold(u), bold(v) in V$ und $c in KK$ gilt:
+ $f(bold(u) + bold(v)) = f(bold(u)) + f(bold(v))$ (*Additivität*),
+ $f(c bold(v)) = c f(bold(v))$ (*Homogenität*).]

Beide Bedingungen lassen sich zusammenfassen: $f(c bold(u) + d bold(v)) = c f(bold(u)) + d f(bold(v))$: *Linearkombinationen werden auf Linearkombinationen abgebildet.* Daraus folgt sofort $f(bold(0)) = f(0 dot bold(0)) = 0 dot f(bold(0)) = bold(0)$: Jede lineare Abbildung schickt $bold(0)$ auf $bold(0)$.

#fgs(("l14_abb1", "l14_abb2", "l14_abb3"), [Drei lineare Abbildungen der Ebene (angewandt auf das Gitter und auf ein «F»): Drehung, Spiegelung, Streckung. Geraden bleiben Geraden, Parallelen bleiben parallel, der Nullpunkt bleibt fest.])

#fgs(("l14_abb4", "l14_abb5", "l14_abb6"), [Scherung, Projektion (alles landet auf einer Geraden: die Abbildung ist *nicht* umkehrbar) und Drehstreckung. Die Projektion hat die Matrix $(1\/5) mat(1, 2; 2, 4)$ vom Rang 1.])

=== Beispiele linearer Abbildungen

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [*Abbildung*], [*Warum linear?*],
  [$bold(x) arrow.r.bar A bold(x)$ für $A in KK^(m times n)$, $KK^n arrow.r KK^m$], [$A(bold(u) + bold(v)) = A bold(u) + A bold(v)$, $A(c bold(u)) = c A bold(u)$ (Woche 4)],
  [Drehung $R(phi.alt)$, Spiegelung $S(alpha)$ (Woche 7), Streckung, Scherung], [alle von der Form $bold(x) arrow.r.bar A bold(x)$],
  [Ableitung $D: PP_n arrow.r PP_(n-1)$, $p arrow.r.bar p'$], [$(p + q)' = p' + q'$, $(c p)' = c p'$],
  [Integral $I: C[a, b] arrow.r RR$, $f arrow.r.bar integral_a^b f d x$], [Linearität des Integrals],
  [Auswertung $f arrow.r.bar f(a)$, $F(RR, RR) arrow.r RR$], [$(f + g)(a) = f(a) + g(a)$],
  [Transponieren $A arrow.r.bar A^tp$, Spur $A arrow.r.bar spur(A)$], [Rechenregeln Woche 5],
  [$bold(x) arrow.r.bar bold(x) + bold(b)$ mit $bold(b) != bold(0)$], [*nicht linear* ($bold(0) arrow.r.bar bold(b) != bold(0)$), sondern affin],
  [$bold(x) arrow.r.bar |bold(x)|$, $x arrow.r.bar x^2$], [*nicht linear*])

Das Wort «linear» heisst also nicht «Gerade» ($f(x) = x + 1$ ist keine lineare Abbildung im Sinne der Linearen Algebra), sondern: Summen und Vielfache werden respektiert.

#satz[Lineare Abbildungen $KK^n arrow.r KK^m$ sind Matrizen][Jede lineare Abbildung $f: KK^n arrow.r KK^m$ hat die Form $f(bold(x)) = A bold(x)$ mit der *Abbildungsmatrix*
$ A = (f(bold(e)_1) | f(bold(e)_2) | dots | f(bold(e)_n)) in KK^(m times n): $
die Spalten sind die *Bilder der Standardbasisvektoren*.]

#beweis[Sei $bold(x) = sum x_j bold(e)_j$. Dann $f(bold(x)) = sum x_j f(bold(e)_j)$ (Linearität), und das ist die Linearkombination der Spalten $f(bold(e)_j)$ von $A$ mit den Koeffizienten $x_j$, also $A bold(x)$.]

#merke[*Eine lineare Abbildung ist durch die Bilder einer Basis festgelegt.* Es genügt, zu wissen, wohin die Basisvektoren gehen: Das ist das «Wörterbuch» zwischen Geometrie und Matrix. Will man die Matrix einer Drehung, einer Spiegelung oder einer Projektion, schreibt man einfach in die Spalten, wohin $bold(e)_1$ und $bold(e)_2$ abgebildet werden. Dieses Prinzip haben wir bei $R(phi.alt)$ in Woche 7 benutzt.]

#bsp[Die Ableitung als Matrix][
$D: PP_2 arrow.r PP_1$, $p arrow.r.bar p'$ bezüglich der Basen $(1, x, x^2)$ und $(1, x)$. Die Bilder der Basisvektoren: $D(1) = 0 = (0, 0)$, $D(x) = 1 = (1, 0)$, $D(x^2) = 2x = (0, 2)$. Spaltenweise:
$ D = mat(0, 1, 0; 0, 0, 2). $
Für $p(x) = 2 + 3x - x^2$ mit Koordinaten $(2, 3, -1)$ ist $D (2, 3, -1)^tp = (3, -2)^tp$, d. h. $p' = 3 - 2x$ ✓. Differenzieren *ist* eine Matrixmultiplikation (nach Wahl der Basen).
]

=== Die Matrix bezüglich beliebiger Basen

Allgemein hat eine lineare Abbildung $f: V arrow.r W$ bezüglich Basen $cal(B)$ von $V$ und $cal(C)$ von $W$ die Matrix mit den Spalten $[f(bold(b)_j)]_(cal(C))$, und es gilt $[f(bold(v))]_(cal(C)) = A [bold(v)]_(cal(B))$. Wechselt man die Basis, ändert sich die Matrix (aber nicht die Abbildung). Eine geschickte Basis macht die Matrix einfach, z. B. diagonal (Thema der Linearen Algebra II: Eigenwerte).

=== Projektion

Eine wichtige Abbildung ist die *orthogonale Projektion* auf eine Gerade $erz{bold(a)}$: Der Punkt wird senkrecht auf die Gerade «hinuntergelotet».

#fg("l14_proj", [Projektion von $bold(v)$ auf die Gerade durch $bold(a)$: Der Fusspunkt $P bold(v)$ ist das Vielfache von $bold(a)$, für das $bold(v) - P bold(v)$ senkrecht auf $bold(a)$ steht.], w: 62%)

#satz[Projektion auf eine Gerade][Für $bold(a) != bold(0)$ ist die orthogonale Projektion auf $erz{bold(a)}$
$ P bold(v) = (bold(a) dot bold(v))/(bold(a) dot bold(a)) bold(a), quad "Matrix" quad P = 1/(bold(a)^tp bold(a)) bold(a) bold(a)^tp. $
Es gilt $P^2 = P$ (zweimal projizieren ist einmal projizieren) und $P^tp = P$.]

#beweis[Ansatz $P bold(v) = t bold(a)$. Die Bedingung $(bold(v) - t bold(a)) dot bold(a) = 0$ liefert $t = (bold(a) dot bold(v))\/(bold(a) dot bold(a))$. $P^2 = (bold(a) bold(a)^tp bold(a) bold(a)^tp)\/(bold(a)^tp bold(a))^2 = (bold(a)^tp bold(a)) bold(a) bold(a)^tp\/(bold(a)^tp bold(a))^2 = P$.]

#bsp[Projektion][$bold(a) = (1, 2)$, $bold(v) = (3, 1)$: $bold(a) dot bold(v) = 5$, $bold(a) dot bold(a) = 5$, also $P bold(v) = bold(a) = (1, 2)$. Matrix $P = frac(1, 5) mat(1, 2; 2, 4)$ (Rang $1$). Der Rest $bold(v) - P bold(v) = (2, -1)$ steht senkrecht auf $bold(a)$: $2 - 2 = 0$ ✓. Die Householder-Spiegelung (Woche 6) hängt damit zusammen: $H = I - 2 P_(bold(v))$ mit der Projektion auf $erz{bold(v)}$.]

== Sampling und Interpolation

#idee[Eine Funktion enthält unendlich viel Information, ein Rechner kann nur endlich viele Zahlen speichern. Das *Abtasten* (Sampling) nimmt einer Funktion an endlich vielen Stellen den Wert ab. Die *Interpolation* macht den umgekehrten Weg: Aus den Werten rekonstruiert man eine Funktion. Beide Vorgänge sind lineare Abbildungen.]

Seien $t_0, dots, t_n$ paarweise verschiedene Stellen («Stützstellen»). Die *Abtastabbildung*
$ S: PP_n arrow.r RR^(n+1), quad p arrow.r.bar (p(t_0), p(t_1), dots, p(t_n)) $
ist linear (Auswertung ist linear). Bezüglich der Basis $(1, x, dots, x^n)$ ist ihre Matrix die *Vandermonde-Matrix* $V = (t_i^j)$:
$ V = mat(1, t_0, t_0^2; 1, t_1, t_1^2; 1, t_2, t_2^2) quad (n = 2). $
Ihre Determinante ist das Produkt $product_(i < j) (t_j - t_i)$ (Woche 9, Beispiel mit $a, b, c$): Sie ist $!= 0$, wenn die Stellen verschieden sind. Dann ist $V$ regulär, $S$ umkehrbar:

#satz[Interpolation][Zu $n + 1$ verschiedenen Stellen $t_0, dots, t_n$ und beliebigen Werten $y_0, dots, y_n$ gibt es *genau ein* Polynom $p$ vom Grad $<= n$ mit $p(t_i) = y_i$.]

#bsp[Parabel durch drei Punkte][
Gesucht ist $p(x) = a x^2 + b x + c$ durch $(0, 1)$, $(1, 0)$, $(2, 3)$. Das LGS $V bold(x) = bold(y)$ mit $bold(x) = (c, b, a)$:
$ mat(1, 0, 0; 1, 1, 1; 1, 2, 4) vec(c, b, a) = vec(1, 0, 3). $
Aus der ersten Zeile $c = 1$. Zweite: $1 + b + a = 0$, also $a + b = -1$. Dritte: $1 + 2b + 4a = 3$, also $4a + 2b = 2$, d. h. $2a + b = 1$. Subtrahiert: $a = 2$, $b = -3$. $p(x) = 2 x^2 - 3 x + 1$ (Probe: $p(1) = 0$ ✓, $p(2) = 8 - 6 + 1 = 3$ ✓).
]

#fg("l14_interp", [Das Interpolationspolynom durch drei Punkte.], w: 66%)

#alltag[Sampling ist die Grundlage der digitalen Welt: Eine CD tastet das Tonsignal $44100$-mal pro Sekunde ab, ein Foto tastet ein Bild an Millionen von Pixeln ab. Das *Abtasttheorem* (Shannon, Nyquist) sagt, wann man aus den Abtastwerten das Signal vollständig zurückgewinnen kann. Interpolation brauchen Grafik (Kurven durch Punkte, Skalieren von Bildern), die Numerik (Näherung von Funktionen durch Polynome) und die Statistik. Bei vielen Stützstellen verwendet man statt eines Polynoms hohen Grades lieber stückweise Polynome (Splines), weil hohe Grade stark schwingen.]

== Kern, Bild und der Rangsatz für Abbildungen

#defn[Kern und Bild einer Abbildung][Für lineare $f: V arrow.r W$ ist
$ Kern(f) = {bold(v) in V : f(bold(v)) = bold(0)} subset.eq V, quad Bild(f) = {f(bold(v)) : bold(v) in V} subset.eq W. $
Beide sind Unterräume. Für $f(bold(x)) = A bold(x)$ stimmen sie mit $Kern(A)$ und $Bild(A)$ überein.]

#satz[$f$ injektiv $arrow.l.r.double$ Kern trivial][Eine lineare Abbildung $f$ ist genau dann *injektiv* (verschiedene Vektoren haben verschiedene Bilder), wenn $Kern(f) = {bold(0)}$.]

#beweis[Ist $f$ injektiv und $f(bold(v)) = bold(0) = f(bold(0))$, so $bold(v) = bold(0)$. Ist umgekehrt $Kern(f) = {bold(0)}$ und $f(bold(u)) = f(bold(v))$, so $f(bold(u) - bold(v)) = bold(0)$, also $bold(u) = bold(v)$.]

#satz[Rangsatz][Für eine lineare Abbildung $f: V arrow.r W$ mit $dimn V < infinity$ gilt
$ dimn V = dimn Kern(f) + dimn Bild(f). $]

#beweis[Sei $(bold(k)_1, dots, bold(k)_p)$ eine Basis von $Kern(f)$. Ergänze sie zu einer Basis $(bold(k)_1, dots, bold(k)_p, bold(w)_1, dots, bold(w)_q)$ von $V$ (Basisergänzung). Dann ist $dimn V = p + q$. Wir zeigen: $(f(bold(w)_1), dots, f(bold(w)_q))$ ist eine Basis von $Bild(f)$, also $dimn Bild(f) = q$. *Erzeugend:* $f(bold(v)) = f(sum a_i bold(k)_i + sum b_j bold(w)_j) = sum b_j f(bold(w)_j)$, da $f(bold(k)_i) = bold(0)$. *Unabhängig:* Aus $sum b_j f(bold(w)_j) = bold(0)$ folgt $f(sum b_j bold(w)_j) = bold(0)$, also $sum b_j bold(w)_j in Kern(f)$, d. h. $= sum a_i bold(k)_i$ für gewisse $a_i$. Die Basiseigenschaft von $(bold(k), bold(w))$ liefert $a_i = 0$ und $b_j = 0$.]

Die Formel sagt: *Was der Kern an Dimension schluckt, fehlt im Bild.* Beispiele: Die Projektion $P$ auf eine Gerade im $RR^2$ hat $dimn Bild = 1$ und $dimn Kern = 1$ (die Gerade senkrecht dazu): $1 + 1 = 2$ ✓. Die Ableitung $D: PP_2 arrow.r PP_1$ hat den Kern der konstanten Polynome (Dim. $1$) und das Bild $PP_1$ (Dim. $2$): $1 + 2 = 3 = dimn PP_2$ ✓.

== Affin-lineare Abbildungen

#defn[Affin-lineare Abbildung][Eine Abbildung $g: RR^n arrow.r RR^m$ der Form $g(bold(x)) = A bold(x) + bold(b)$ mit einer Matrix $A$ und einem Vektor $bold(b)$ heisst *affin-linear*.]

Sie ist eine lineare Abbildung gefolgt von einer Verschiebung. Sie ist genau dann linear, wenn $bold(b) = bold(0)$. Affin-lineare Abbildungen bilden Geraden auf Geraden ab (oder auf Punkte), bewahren Parallelität und Streckenverhältnisse und sind abgeschlossen unter Verkettung: $g_2(g_1(bold(x))) = A_2 (A_1 bold(x) + bold(b)_1) + bold(b)_2 = (A_2 A_1) bold(x) + (A_2 bold(b)_1 + bold(b)_2)$.

#bsp[Drehung um einen beliebigen Punkt][
Die Drehung um $90 degree$ um den Punkt $bold(p) = (1, 0)$ ist $g(bold(x)) = R(90 degree)(bold(x) - bold(p)) + bold(p) = R bold(x) + (bold(p) - R bold(p))$, also $A = R$ und $bold(b) = (1, 0) - (0, 1) = (1, -1)$. Der Punkt $(2, 0)$ geht über in $R (1, 0) + (1, 0) = (0, 1) + (1, 0) = (1, 1)$ ✓. Der Fixpunkt ist $bold(p)$ selbst. Alle Isometrien der Ebene (Woche 7) sind affin-linear.]

== Kontraktionen

#defn[Kontraktion][Eine Abbildung $f: RR^n arrow.r RR^n$ heisst *Kontraktion*, wenn es eine Zahl $q < 1$ gibt mit
$ |f(bold(x)) - f(bold(y))| <= q |bold(x) - bold(y)| quad "für alle" bold(x), bold(y). $
Sie zieht also je zwei Punkte um mindestens den Faktor $q$ zusammen.]

Für eine affin-lineare Abbildung $f(bold(x)) = A bold(x) + bold(b)$ ist $f(bold(x)) - f(bold(y)) = A (bold(x) - bold(y))$. Sie ist also eine Kontraktion, wenn $A$ alle Vektoren um höchstens den Faktor $q < 1$ verkürzt. Beispiele: Die Drehstreckung $s dot R(phi.alt)$ mit $|s| < 1$ hat $q = |s|$; $A = 1\/2 dot I$ hat $q = 1\/2$.

#satz[Banachscher Fixpunktsatz][Eine Kontraktion $f: RR^n arrow.r RR^n$ hat *genau einen Fixpunkt* $bold(x)^* = f(bold(x)^*)$. Für *jeden* Startpunkt $bold(x)_0$ konvergiert die Iteration $bold(x)_(k+1) = f(bold(x)_k)$ gegen $bold(x)^*$.]

#beweisidee[Aus der Kontraktionseigenschaft folgt $|bold(x)_(k+1) - bold(x)_k| <= q^k |bold(x)_1 - bold(x)_0|$. Die Abstände aufeinander folgender Iterierter bilden eine geometrische Reihe, deshalb ist $(bold(x)_k)$ eine Cauchy-Folge und konvergiert gegen ein $bold(x)^*$. Wegen der Stetigkeit von $f$ ist $f(bold(x)^*) = bold(x)^*$. Zwei Fixpunkte $bold(x)^*, bold(y)^*$ hätten $|bold(x)^* - bold(y)^*| <= q |bold(x)^* - bold(y)^*|$, also gleich sein müssen.]

#bsp[Iteration][$f(bold(x)) = (1\/2) bold(x) + (1, 1)$ ist eine Kontraktion mit $q = 1\/2$. Fixpunkt: $bold(x) = bold(x)\/2 + (1, 1)$, $bold(x) = (2, 2)$. Iteration von $bold(x)_0 = (0, 0)$: $(1, 1), (1.5, 1.5), (1.75, 1.75), (1.875, 1.875), dots arrow.r (2, 2)$. Der Fehler halbiert sich bei jedem Schritt.
Für $f(bold(x)) = A bold(x) + bold(b)$ ist der Fixpunkt die Lösung des LGS $(I - A) bold(x) = bold(b)$. Die Iteration ist ein Verfahren zum näherungsweisen Lösen von LGS (Jacobi- und Gauss-Seidel-Verfahren funktionieren so).]

== Fraktale und selbstähnliche Mengen

#idee[Betrachtet man nicht eine Kontraktion, sondern *mehrere gleichzeitig*, so ergeben sich Mengen von überraschender Gestalt: Fraktale. Die Idee von John Hutchinson (1981): Eine Menge $K$ wird durch $m$ verkleinerte Kopien ihrer selbst ersetzt. Die Menge, die dabei *nicht mehr verändert* wird, ist das Fraktal.]

#defn[Hutchinson-Operator][Seien $f_1, dots, f_m: RR^n arrow.r RR^n$ Kontraktionen. Für eine beschränkte, abgeschlossene (kompakte) Menge $K subset RR^n$ ist der *Hutchinson-Operator*
$ H(K) = f_1(K) union f_2(K) union dots union f_m(K). $
Er ersetzt $K$ durch die Vereinigung der $m$ Bilder. Man nennt $(f_1, dots, f_m)$ ein *iteriertes Funktionensystem* (IFS).]

#satz[Hutchinson][Zu jedem IFS aus Kontraktionen gibt es *genau eine* nichtleere kompakte Menge $A$ mit
$ H(A) = A. $
Sie heisst *Attraktor*. Für jede nichtleere kompakte Startmenge $K$ konvergieren die Mengen $K, H(K), H(H(K)), dots$ gegen $A$ (im Abstandsbegriff für Mengen, der Hausdorff-Metrik).]

Der Satz ist eine Version des Banachschen Fixpunktsatzes, nur nicht für Punkte, sondern für *Mengen*: $H$ ist eine Kontraktion auf dem Raum der kompakten Mengen. Der Attraktor $A = f_1(A) union dots union f_m(A)$ besteht aus $m$ verkleinerten Kopien von sich selbst: Er ist *selbstähnlich*.

=== Das Sierpinski-Dreieck

Sei $P_1 = (0, 0)$, $P_2 = (1, 0)$, $P_3 = (1\/2, sqrt(3)\/2)$ die Ecken eines gleichseitigen Dreiecks und $f_i(bold(x)) = (bold(x) + P_i)\/2$ für $i = 1, 2, 3$. Jedes $f_i$ ist eine affin-lineare Kontraktion mit $A = frac(1, 2) I$: Es zieht den Punkt $bold(x)$ zur Ecke $P_i$ hin, auf halbem Weg.

#fgs(("l14_h0", "l14_h1", "l14_h2", "l14_h3", "l14_h4"), [Das Dreieck $K$, dann $H(K)$, $H^2(K)$, $H^3(K)$, $H^4(K)$ für das IFS des Sierpinski-Dreiecks. Egal, mit welcher Menge man startet: Die Folge nähert sich immer derselben Figur.])

Der Attraktor ist das *Sierpinski-Dreieck* (nach Wacław Sierpiński, 1915): Er besteht aus drei halb so grossen Kopien seiner selbst. Er hat den Flächeninhalt $0$ und trotzdem unendlich viele Punkte und überall Löcher. Seine Dimension im Sinne der Selbstähnlichkeit ist die Zahl $s$ mit $3 (1\/2)^s = 1$, also
$ s = (ln 3)/(ln 2) approx 1.585: $
mehr als eine Kurve ($s = 1$), weniger als eine Fläche ($s = 2$). Ebenso entsteht die *Cantor-Menge* aus $f_1(x) = x\/3$, $f_2(x) = x\/3 + 2\/3$ auf $RR$ mit $s = ln 2\/ln 3 approx 0.631$.

=== Das Chaosspiel

Es gibt eine überraschend einfache Methode, den Attraktor zu *zeichnen*: Wähle einen beliebigen Startpunkt. Wähle in jedem Schritt zufällig eines der $f_i$ und wende es auf den aktuellen Punkt an. Zeichne die Folge der Punkte. Nach wenigen Schritten liegen sie (beliebig nah) auf dem Attraktor, und mit der Zeit füllen sie ihn. Im Fall des Sierpinski-Dreiecks: «Gehe immer zur Hälfte des Weges zu einer zufällig gewählten Ecke.»

=== Barnsleys Farn

Michael Barnsley zeigte 1988 in seinem Buch «Fractals Everywhere», dass man mit nur *vier* affin-linearen Kontraktionen im $RR^2$ das Bild eines Farnblatts erzeugen kann. Die Abbildungen $f_i(bold(x)) = A_i bold(x) + bold(b)_i$ haben die Daten

#table(columns: (auto, auto, auto, auto), align: center, stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Abbildung*], [*$A_i$*], [*$bold(b)_i$*], [*Wahrscheinlichkeit*],
  [$f_1$ (Stiel)], [$mat(0, 0; 0, 0.16)$], [$(0, 0)$], [$0.01$],
  [$f_2$ (Hauptteil)], [$mat(0.85, 0.04; -0.04, 0.85)$], [$(0, 1.6)$], [$0.85$],
  [$f_3$ (linkes Blättchen)], [$mat(0.2, -0.26; 0.23, 0.22)$], [$(0, 1.6)$], [$0.07$],
  [$f_4$ (rechtes Blättchen)], [$mat(-0.15, 0.28; 0.26, 0.24)$], [$(0, 0.44)$], [$0.07$])

#fg("l14_farn", [Der Barnsley-Farn: Attraktor des IFS mit den vier Abbildungen oben, gezeichnet mit dem Chaosspiel (120 000 Punkte). Die Wahrscheinlichkeiten steuern, wie oft welche Abbildung gewählt wird. Sie ändern den Attraktor nicht, aber die Dichte der Punkte.], w: 52%)

Man kann die Abbildungen *lesen*:
- $f_1$ quetscht alles auf die senkrechte Strecke: $A$ hat den Rang $1$ (die Determinante ist $0$), das ist der *Stiel*. Es ist trotzdem eine Kontraktion (Faktor $0.16$).
- $f_2$ ist eine leichte Drehung (um etwa $2.7 degree$ im Uhrzeigersinn) mit Streckung $0.85$ und Verschiebung nach oben: Es bildet den ganzen Farn auf den Farn ohne die untersten Blätter ab (der *Hauptteil*, die «Fortsetzung» nach oben).
- $f_3$ und $f_4$ bilden den ganzen Farn auf das *untere linke* und *untere rechte* Blättchen ab.
Alle vier Abbildungen sind Kontraktionen (die Spektralnormen der Matrizen sind $0.16$, $0.85$, $0.34$, $0.38$, jeweils $< 1$). Der Attraktor $A = f_1(A) union f_2(A) union f_3(A) union f_4(A)$ ist der Farn: Er ist *selbstähnlich*, denn jedes Blättchen ist wieder ein kleiner Farn.

#alltag[Dies ist die Idee der *fraktalen Bildkompression* (Barnsley, 1988): Statt eines Bildes speichert man die wenigen Zahlen $A_i, bold(b)_i$ eines IFS, dessen Attraktor das Bild ist. Ein Farn braucht $4 times 6 = 24$ Zahlen, während als Pixelbild Tausende. Auch in der Computergrafik erzeugt man mit solchen Systemen Berge, Wolken und Pflanzen (Lindenmayer-Systeme und IFS). Die Natur selbst verwendet Selbstähnlichkeit: Küstenlinien, Blutgefässe, Bronchien, Blitze, Brokkoli. Deshalb sehen die Computerbilder täuschend echt aus.]

#merke[Alles, was in diesem Kapitel passiert, ist Lineare Algebra: Die $A_i$ sind Matrizen, die Kontraktionseigenschaft ist eine Aussage über deren Wirkung auf Längen, die Fixpunkte von $f_i$ lösen LGS $(I - A_i) bold(x) = bold(b)_i$, und die Selbstähnlichkeit verbindet die ganze Vorlesung, von Gleichungssystemen über Matrizen, Determinanten und Vektorräume bis zu den linearen Abbildungen.]

#kurz[
- *Basiswechsel:* $[bold(v)]_(cal(C)) = T [bold(v)]_(cal(B))$; $T = C^(-1) B$ im $KK^n$.
- *Lineare Abbildung* $f(c bold(u) + d bold(v)) = c f(bold(u)) + d f(bold(v))$. In $KK^n$: $f(bold(x)) = A bold(x)$ mit den Bildern der Standardbasis als Spalten. Beispiele: Drehung, Spiegelung, Streckung, Scherung, Projektion $P = bold(a) bold(a)^tp\/(bold(a)^tp bold(a))$, Ableitung, Abtastung.
- *Sampling* $PP_n arrow.r RR^(n+1)$ ist linear mit Vandermonde-Matrix; *Interpolation* durch $n + 1$ Punkte ist eindeutig lösbar.
- *Kern, Bild, Rangsatz:* $dimn V = dimn Kern f + dimn Bild f$. $f$ injektiv $arrow.l.r.double$ $Kern f = {bold(0)}$.
- *Affin-linear* $bold(x) arrow.r.bar A bold(x) + bold(b)$. *Kontraktion:* $|f(bold(x)) - f(bold(y))| <= q |bold(x) - bold(y)|$, $q < 1$; *Banach:* genau ein Fixpunkt, Iteration konvergiert.
- *Hutchinson-Operator* $H(K) = union f_i(K)$ hat genau einen Attraktor $A = H(A)$: selbstähnlich. Beispiele: Sierpinski-Dreieck, Cantor-Menge, *Barnsleys Farn* (4 affine Kontraktionen).
]

#aufgaben()

#aufg("Matrix einer linearen Abbildung", [Die lineare Abbildung $f: RR^2 arrow.r RR^3$ erfüllt $f(1, 0) = (1, 2, 3)$ und $f(0, 1) = (0, 1, -1)$. Bestimme die Abbildungsmatrix und $f(2, -1)$. Bestimme Kern und Bild.],
[$A = mat(1, 0; 2, 1; 3, -1)$. $f(2, -1) = 2 (1, 2, 3) - (0, 1, -1) = (2, 3, 7)$. Kern: $A bold(x) = bold(0)$ hat nur die triviale Lösung (die Spalten sind unabhängig, Rang $2$): $Kern(f) = {bold(0)}$, $f$ ist injektiv. Bild: $erz{(1, 2, 3), (0, 1, -1)}$, eine Ebene in $RR^3$. Rangsatz: $2 = 0 + 2$ ✓.])

#aufg("Ist die Abbildung linear?", [Welche der folgenden Abbildungen $RR^2 arrow.r RR^2$ sind linear? (a) $(x, y) arrow.r.bar (x + y, x - y)$; (b) $(x, y) arrow.r.bar (x y, y)$; (c) $(x, y) arrow.r.bar (x + 1, y)$; (d) $(x, y) arrow.r.bar (2 y, 0)$.],
[(a) Ja ($A = mat(1, 1; 1, -1)$). (b) Nein: $x y$ ist nicht linear ($f(2 (1, 1)) = (4, 2) != 2 f(1, 1) = (2, 2)$). (c) Nein: $f(0, 0) = (1, 0) != (0, 0)$, nur affin. (d) Ja ($A = mat(0, 2; 0, 0)$).])

#aufg("Projektion", [Bestimme die Matrix der orthogonalen Projektion auf die Gerade $erz{(2, 1)}$ und projiziere $(1, 3)$. Zeige $P^2 = P$.],
[$bold(a) = (2, 1)$, $bold(a)^tp bold(a) = 5$, $P = frac(1, 5) mat(4, 2; 2, 1)$. $P (1, 3) = frac(1, 5) (4 + 6, 2 + 3) = (2, 1)$. $P^2 = frac(1, 25) mat(16 + 4, 8 + 2; 8 + 2, 4 + 1) = frac(1, 25) mat(20, 10; 10, 5) = P$ ✓.])

#aufg("Interpolation", [Bestimme das Polynom vom Grad $<= 2$ durch $(-1, 6)$, $(0, 1)$, $(1, 0)$.],
[$p(x) = a x^2 + b x + c$. $p(0) = c = 1$. $p(1) = a + b + 1 = 0$, $p(-1) = a - b + 1 = 6$. Addieren: $2a + 2 = 6$, $a = 2$; dann $b = -3$. $p(x) = 2 x^2 - 3 x + 1$. (Probe: $p(-1) = 2 + 3 + 1 = 6$ ✓. Es ist dasselbe Polynom wie im Beispiel im Text: Der Punkt $(-1, 6)$ liegt zufällig auch auf jener Parabel.)])

#aufg("Fixpunkt einer affinen Kontraktion", [Bestimme den Fixpunkt von $f(bold(x)) = mat(0.5, 0; 0, 0.25) bold(x) + (1, 3)$ und zeige, dass $f$ eine Kontraktion ist.],
[Fixpunkt: $(I - A) bold(x) = bold(b)$ mit $I - A = mat(0.5, 0; 0, 0.75)$: $bold(x) = (1\/0.5, 3\/0.75) = (2, 4)$. Probe: $f(2, 4) = (1 + 1, 1 + 3) = (2, 4)$ ✓. Kontraktion: $|A (bold(x) - bold(y))|^2 = 0.25 d_1^2 + 0.0625 d_2^2 <= 0.25 (d_1^2 + d_2^2)$, also $q = 0.5 < 1$.])
