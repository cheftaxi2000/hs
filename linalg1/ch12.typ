#import "lib.typ": *

= Linearkombinationen, Erzeugendensysteme und lineare Unabhängigkeit

#woche(12, [Unterräume und LGS, Linearkombinationen, lineare Unabhängigkeit], [Sätze über UR · Kern und Bild · Linearkombination · Erzeugnis · endlich- und unendlichdimensional · lineare Unabhängigkeit])

#vorlesung[Diese Woche gibt den Vektorräumen ihr Skelett: Aus einigen wenigen Vektoren lassen sich durch Linearkombinationen alle anderen aufbauen. Wir fragen, wann eine Familie von Vektoren *alles* erzeugt (Erzeugendensystem) und wann sie *nichts Überflüssiges* enthält (lineare Unabhängigkeit). Beides gemeinsam führt nächste Woche zum Begriff der Basis und der Dimension. Dabei zeigt sich, dass alles, was wir über lineare Gleichungssysteme gelernt haben, sich in der Sprache der Vektorräume neu formulieren lässt.]

== Sätze über Unterräume

#satz[Durchschnitt][Sind $U_1$ und $U_2$ Unterräume von $V$, so ist auch $U_1 inter U_2$ ein Unterraum von $V$. (Der Durchschnitt beliebig vieler Unterräume ist ein Unterraum.)]

#beweis[$bold(0) in U_1$ und $bold(0) in U_2$, also $bold(0) in U_1 inter U_2$. Sind $bold(u), bold(v) in U_1 inter U_2$, so liegen $bold(u) + bold(v)$ und $c bold(u)$ in $U_1$ (da $U_1$ Unterraum) und in $U_2$, also im Durchschnitt.]

Das erklärt, warum die Lösungsmenge eines HLGS mit mehreren Gleichungen ein Unterraum ist: Jede Gleichung liefert einen Unterraum («Hyperebene durch $bold(0)$»), und die Lösungsmenge ist der Durchschnitt aller dieser Unterräume.

#fehler[Die *Vereinigung* zweier Unterräume ist im Allgemeinen *kein* Unterraum. Beispiel: $U_1 = {(x, 0)}$ ($x$-Achse), $U_2 = {(0, y)}$ ($y$-Achse): $(1, 0) + (0, 1) = (1, 1) in.not U_1 union U_2$. (Es ist genau dann ein Unterraum, wenn $U_1 subset.eq U_2$ oder $U_2 subset.eq U_1$.)]

#defn[Summe von Unterräumen][Für Unterräume $U_1, U_2$ von $V$ heisst
$ U_1 + U_2 = {bold(u)_1 + bold(u)_2 : bold(u)_1 in U_1, bold(u)_2 in U_2} $
die *Summe* von $U_1$ und $U_2$. Sie ist ein Unterraum von $V$, und zwar der kleinste, der $U_1$ und $U_2$ enthält.]

Beispiel: $U_1 = {(x, 0, 0)}$ und $U_2 = {(0, y, 0)}$ im $RR^3$. $U_1 + U_2 = {(x, y, 0)}$: die $x y$-Ebene. Die *Vereinigung* wäre nur die Vereinigung der zwei Achsen, die Summe «füllt» die Ebene auf.

== Linearkombinationen und das Erzeugnis

#defn[Linearkombination][Seien $bold(v)_1, dots, bold(v)_k in V$. Ein Vektor der Form
$ bold(w) = c_1 bold(v)_1 + c_2 bold(v)_2 + dots + c_k bold(v)_k, quad c_1, dots, c_k in KK, $
heisst *Linearkombination (LK)* der Vektoren $bold(v)_1, dots, bold(v)_k$ mit den *Koeffizienten* $c_1, dots, c_k$.]

#defn[Erzeugnis, aufgespannter Unterraum][Die Menge aller Linearkombinationen von $bold(v)_1, dots, bold(v)_k$,
$ erz{bold(v)_1, dots, bold(v)_k} = {c_1 bold(v)_1 + dots + c_k bold(v)_k : c_1, dots, c_k in KK}, $
heisst das *Erzeugnis* (die *lineare Hülle*) der Vektoren; man sagt auch, die $bold(v)_i$ *spannen* diesen Raum *auf*. Das Erzeugnis der leeren Familie ist ${bold(0)}$.]

#satz[Das Erzeugnis ist ein Unterraum][$erz{bold(v)_1, dots, bold(v)_k}$ ist ein Unterraum von $V$, und zwar der *kleinste* Unterraum, der alle $bold(v)_i$ enthält.]

#beweis[Der Nullvektor ist die LK mit allen $c_i = 0$. Zwei LKs addiert ergeben $(sum a_i bold(v)_i) + (sum b_i bold(v)_i) = sum (a_i + b_i) bold(v)_i$, und $c sum a_i bold(v)_i = sum (c a_i) bold(v)_i$: wieder LKs. Ist $U$ ein Unterraum, der alle $bold(v)_i$ enthält, so enthält er (Abgeschlossenheit) auch alle LKs, also $erz{dots} subset.eq U$.]

#fgs(("l12_s1", "l12_s2", "l12_s3"), [Das Erzeugnis eines, zweier und dreier (geeigneter) Vektoren im $RR^3$: Gerade, Ebene, ganzer Raum. Sind die Vektoren ungünstig gewählt (parallel bzw. in einer Ebene), so bleibt das Erzeugnis kleiner.])

#bsp[Ist ein Vektor im Erzeugnis?][
Im $RR^3$ seien $bold(v)_1 = (1, 1, 2)$ und $bold(v)_2 = (0, 1, 1)$. Liegt $bold(b)$ in $erz{bold(v)_1, bold(v)_2}$? Das ist die Frage, ob $c_1 bold(v)_1 + c_2 bold(v)_2 = bold(b)$ lösbar ist, also ein LGS mit der Matrix $(bold(v)_1 | bold(v)_2)$ (Spalten) und rechter Seite $bold(b)$.
- $bold(b) = (2, 3, 5)$: $c_1 = 2$ (erste Zeile), zweite Zeile $c_1 + c_2 = 3$ also $c_2 = 1$; dritte Zeile $2 c_1 + c_2 = 5$ ✓. Ja: $bold(b) = 2 bold(v)_1 + bold(v)_2$.
- $bold(b) = (1, 2, 4)$: $c_1 = 1$, $c_2 = 1$, dritte Zeile: $2 + 1 = 3 != 4$. Nein, $bold(b) in.not erz{dots}$.
]

#satz[Erzeugnis und LGS][Seien $bold(a)_1, dots, bold(a)_k in KK^n$ die Spalten einer Matrix $A in KK^(n times k)$. Dann gilt
$ bold(b) in erz{bold(a)_1, dots, bold(a)_k} quad arrow.l.r.double quad A bold(x) = bold(b) "ist lösbar." $
Die Koeffizienten der LK sind genau die Lösungen $bold(x) = (c_1, dots, c_k)^tp$.]

Das ist die Spaltenschreibweise von Woche 2: $A bold(x) = x_1 bold(a)_1 + dots + x_k bold(a)_k$.

=== Kern und Bild einer Matrix

Zu jeder Matrix $A in RR^(m times n)$ gehören zwei Unterräume:

#defn[Kern und Bild][
- Der *Kern* von $A$ ist $Kern(A) = {bold(x) in RR^n : A bold(x) = bold(0)}$ (Lösungsmenge des HLGS). Er ist ein Unterraum von $RR^n$.
- Das *Bild* (der *Spaltenraum*) von $A$ ist $Bild(A) = {A bold(x) : bold(x) in RR^n} = erz{"Spalten von " A} subset.eq RR^m$. Er ist ein Unterraum von $RR^m$.]

Man kann also die Fragen über LGS so übersetzen:
- «Ist $A bold(x) = bold(b)$ lösbar?» $=$ «Liegt $bold(b)$ im Bild von $A$?»
- «Ist die Lösung eindeutig?» $=$ «Ist $Kern(A) = {bold(0)}$?»
- «Wie viele Parameter hat die Lösungsmenge?» $=$ «Wie gross ist der Kern?»

#bsp[Kern und Bild][
$ A = mat(1, 2, 1; 2, 4, 3; 3, 6, 4). $
*Kern:* $x_2 = s$ frei (Pivotspalten 1 und 3); $x_3 = 0$ und $x_1 = -2s$: $Kern(A) = erz{(-2, 1, 0)}$, eine Gerade.
*Bild:* Die Spalten sind $(1, 2, 3)$, $(2, 4, 6)$, $(1, 3, 4)$. Die zweite ist das Doppelte der ersten, also ist $Bild(A) = erz{(1, 2, 3), (1, 3, 4)}$, eine Ebene. Aus Woche 3 kennen wir die *Verträglichkeitsbedingung* $b_1 + b_2 - b_3 = 0$ für die Lösbarkeit: Sie beschreibt genau diese Ebene, in Gleichungsform statt in Parameterform. ($(1, 2, 3)$: $1 + 2 - 3 = 0$ ✓, $(1, 3, 4)$: $1 + 3 - 4 = 0$ ✓.)
]

Eine Ebene im Erzeugnis-Format («aufgespannt von ...») und in Gleichungsform («alle Punkte mit ...») sind zwei Beschreibungen desselben Objekts. Der Gauss-Algorithmus verwandelt die eine in die andere: Von der Gleichungsform zu Parametern über den Kern; von den Parametern zu Gleichungen über Verträglichkeitsbedingungen.

== Erzeugendensysteme

#defn[Erzeugendensystem][Eine Familie $(bold(v)_1, dots, bold(v)_k)$ von Vektoren in $V$ heisst *Erzeugendensystem* von $V$, wenn $erz{bold(v)_1, dots, bold(v)_k} = V$, wenn also *jeder* Vektor von $V$ eine LK der $bold(v)_i$ ist.]

#bsp[Erzeugendensysteme][
- Die Einheitsvektoren $bold(e)_1, dots, bold(e)_n$ erzeugen $KK^n$: $(x_1, dots, x_n) = x_1 bold(e)_1 + dots + x_n bold(e)_n$.
- Die Polynome $1, x, x^2, dots, x^n$ erzeugen $PP_n$ (nach Definition eines Polynoms).
- Die Matrizen $E_(i j)$ (eine $1$ an Position $(i, j)$, sonst $0$) erzeugen $RR^(m times n)$.
- Die symmetrischen $2 times 2$-Matrizen werden von $mat(1, 0; 0, 0)$, $mat(0, 0; 0, 1)$, $mat(0, 1; 1, 0)$ erzeugt: $mat(a, b; b, d) = a dot mat(1, 0; 0, 0) + d dot mat(0, 0; 0, 1) + b dot mat(0, 1; 1, 0)$.
- $(1, 1, 0), (0, 1, 1), (1, 0, -1)$ erzeugen *nicht* den ganzen $RR^3$: Die dritte ist die Differenz der beiden ersten ($(1, 1, 0) - (0, 1, 1) = (1, 0, -1)$), das Erzeugnis ist nur eine Ebene.
]

#rezept[Erzeugen $k$ Vektoren des $KK^n$ den ganzen Raum?][
  Schreibe die Vektoren als *Spalten* in eine Matrix $A in KK^(n times k)$. Sie erzeugen den $KK^n$ genau dann, wenn $A bold(x) = bold(b)$ für *jedes* $bold(b)$ lösbar ist, also genau dann, wenn $rang(A) = n$ (Woche 4: jede Zeile hat einen Pivot). Insbesondere braucht man dafür *mindestens $n$* Vektoren.
]

=== Endlich und unendlich viele Erzeuger

#defn[Endlichdimensional][Ein Vektorraum heisst *endlich erzeugt* oder *endlichdimensional*, wenn er ein Erzeugendensystem aus endlich vielen Vektoren hat, sonst *unendlichdimensional*.]

$KK^n$, $PP_n$ und $RR^(m times n)$ sind endlichdimensional. Der Raum $KK[x]$ aller Polynome ist es *nicht*:

#beweis[Angenommen, $p_1, dots, p_k$ erzeugen $KK[x]$. Sei $d$ der grösste Grad unter ihnen. Jede LK hat dann Grad $<= d$. Das Polynom $x^(d+1)$ ist keine LK. Widerspruch.]

Ebenso sind $C(RR)$, $F(RR, RR)$ und der Raum der Folgen unendlichdimensional. (Mit unendlichdimensionalen Räumen arbeitet die Analysis, mit endlichdimensionalen die Lineare Algebra I.)

== Lineare Unabhängigkeit

Bei den $erz{(1, 1, 0), (0, 1, 1), (1, 0, -1)}$ ist ein Erzeuger *überflüssig*, denn er lässt sich aus den anderen bauen. Das Gegenteil davon nennt man lineare Unabhängigkeit.

#defn[Lineare Unabhängigkeit][Die Vektoren $bold(v)_1, dots, bold(v)_k in V$ heissen *linear unabhängig*, wenn die Gleichung
$ c_1 bold(v)_1 + c_2 bold(v)_2 + dots + c_k bold(v)_k = bold(0) $
*nur* die triviale Lösung $c_1 = dots = c_k = 0$ hat. Gibt es eine Lösung mit mindestens einem $c_i != 0$, heissen sie *linear abhängig*.]

Anders gesagt: *Der Nullvektor lässt sich nur auf die triviale Weise als LK darstellen.*

#satz[Charakterisierung der Abhängigkeit][Die Vektoren $bold(v)_1, dots, bold(v)_k$ ($k >= 2$) sind genau dann linear abhängig, wenn *einer von ihnen eine LK der übrigen* ist.]

#beweis[«$arrow.r.double$»: Aus $sum c_i bold(v)_i = bold(0)$ mit $c_j != 0$ folgt $bold(v)_j = -sum_(i != j) (c_i \/ c_j) bold(v)_i$. «$arrow.l.double$»: Ist $bold(v)_j = sum_(i != j) d_i bold(v)_i$, so ist $sum_(i != j) d_i bold(v)_i - 1 dot bold(v)_j = bold(0)$ eine nichttriviale LK (der Koeffizient von $bold(v)_j$ ist $-1 != 0$).]

#fgs(("l12_abh", "l12_unabh"), [Zwei Vektoren der Ebene sind genau dann linear abhängig, wenn sie parallel sind (einer ein Vielfaches des anderen).])

#rezept[Lineare Unabhängigkeit im $KK^n$ testen][
  + Schreibe die Vektoren als *Spalten* in eine Matrix $A in KK^(n times k)$.
  + Die Vektoren sind linear unabhängig genau dann, wenn das HLGS $A bold(c) = bold(0)$ nur die triviale Lösung hat, also genau dann, wenn *$rang(A) = k$* (jede Spalte hat einen Pivot, es gibt keine freie Variable).
  + Für $k = n$ (quadratisch): genau dann, wenn $det(A) != 0$.
  + Ist $A bold(c) = bold(0)$ nichttrivial lösbar, so *liest man die Abhängigkeit* aus der Lösung ab.
]

#bsp[Abhängig oder unabhängig?][
(a) $bold(v)_1 = (1, 2, 1)$, $bold(v)_2 = (2, 1, 0)$, $bold(v)_3 = (0, 3, 2)$. Matrix mit diesen Spalten und Elimination:
$ mat(1, 2, 0; 2, 1, 3; 1, 0, 2) zu(Z_2 - 2 Z_1, Z_3 - Z_1) mat(1, 2, 0; 0, -3, 3; 0, -2, 2) zu(Z_3 - (2\/3) Z_2) mat(1, 2, 0; 0, -3, 3; 0, 0, 0). $
Rang $2 < 3$: *linear abhängig*. Das HLGS: $c_3 = t$ frei, $c_2 = t$, $c_1 = -2t$. Mit $t = 1$: $-2 bold(v)_1 + bold(v)_2 + bold(v)_3 = bold(0)$. (Probe: $(-2 + 2 + 0, -4 + 1 + 3, -2 + 0 + 2) = (0, 0, 0)$ ✓.)
(b) $bold(e)_1, bold(e)_2, bold(e)_3$ sind linear unabhängig (Matrix $I$, Rang $3$).
(c) $(1, 2, 3)$ und $(2, 4, 6)$ sind abhängig (zweiter = $2 times$ erster).
]

#satz[Weitere Sätze über Unabhängigkeit][
+ Jede Familie, die den *Nullvektor* enthält, ist linear abhängig. Ein einzelner Vektor $bold(v)$ ist unabhängig genau dann, wenn $bold(v) != bold(0)$.
+ Teilfamilien linear unabhängiger Vektoren sind linear unabhängig; Oberfamilien linear abhängiger Vektoren sind linear abhängig.
+ *Mehr als $n$ Vektoren im $KK^n$ sind immer linear abhängig.* (Die Matrix hat $k > n$ Spalten, also $rang <= n < k$: es gibt freie Variablen.)
+ Gehört $bold(w)$ zu $erz{bold(v)_1, dots, bold(v)_k}$, so sind $bold(v)_1, dots, bold(v)_k, bold(w)$ linear abhängig.
]

#bsp[Vier Vektoren im $RR^3$][$(1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 1, 1)$ sind abhängig (vier Vektoren im $RR^3$): $(1, 1, 1) = bold(e)_1 + bold(e)_2 + bold(e)_3$, also $bold(e)_1 + bold(e)_2 + bold(e)_3 - (1, 1, 1) = bold(0)$.]

=== Funktionen

Die Definition gilt auch in Funktionenräumen. Die Gleichung $c_1 f_1 + dots + c_k f_k = 0$ ist dort eine Gleichung zwischen *Funktionen*, sie muss also für *alle* $x$ gelten.

#bsp[Unabhängigkeit von Funktionen][
- $1, x, x^2$ in $PP_2$: $c_0 + c_1 x + c_2 x^2 = 0$ für alle $x$ heisst, dass das Polynom null ist (Koeffizientenvergleich, oder: ein Polynom vom Grad $<= 2$ hat höchstens $2$ Nullstellen, wenn es nicht null ist). Also unabhängig.
- $sin$ und $cos$ sind unabhängig: Aus $a sin x + b cos x = 0$ für alle $x$ folgt mit $x = 0$: $b = 0$, und mit $x = pi\/2$: $a = 0$.
- $1, cos^2 x, sin^2 x$ sind *abhängig*: $cos^2 x + sin^2 x - 1 = 0$ für alle $x$.
]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Farben mischen.* Jede Bildschirmfarbe ist eine Linearkombination $r e_R + g e_G + b e_B$ der drei Grundfarben Rot, Grün und Blau. Drei Farben reichen, weil unser Auge drei Arten von Farbrezeptoren hat. Dass kein Grundfarbenpaar ausreicht, ist die Aussage «zwei Vektoren spannen nur eine Ebene auf». Und damit alle Farben eindeutig gemischt werden können, müssen die Grundfarben linear unabhängig sein. Der Farbdrucker nutzt Cyan, Magenta, Gelb (und Schwarz) aus demselben Grund.]

#alltag[*Redundanz und Unabhängigkeit bei Sensoren.* Ein Flugzeug misst seine Lage mit mehreren Sensoren. Sind drei Sensoren linear abhängig (der dritte liefert nur eine Mischung der beiden anderen), ist er redundant: nützlich zur Kontrolle, aber ohne neue Information. Ingenieure prüfen die lineare Unabhängigkeit der Messrichtungen, bevor sie ein System bauen: Zeigen sie alle in einer Ebene, ist die dritte Raumrichtung blind.]
// ALLTAG-END

#kurz[
- Durchschnitte von UR sind UR; Vereinigungen nicht. Die Summe $U_1 + U_2$ ist der kleinste UR, der beide enthält.
- *LK:* $sum c_i bold(v)_i$. *Erzeugnis* $erz{bold(v)_i}$ = Menge aller LKs: kleinster UR, der alle $bold(v)_i$ enthält. $bold(b) in erz{"Spalten von " A} arrow.l.r.double A bold(x) = bold(b)$ lösbar.
- $Kern(A)$ (Lösungen von $A bold(x) = bold(0)$) und $Bild(A) = erz{"Spalten"}$ sind UR.
- *Erzeugendensystem:* erzeugt ganz $V$. $KK^n$ braucht mindestens $n$ Erzeuger. $KK[x]$ ist unendlichdimensional.
- *Linear unabhängig:* $sum c_i bold(v)_i = bold(0)$ nur trivial. Test im $KK^n$: $rang(A) = k$. Abhängig $arrow.l.r.double$ ein Vektor ist LK der anderen. Mehr als $n$ Vektoren im $KK^n$ sind abhängig.
]

#aufgaben()

#aufg("Linear unabhängig?", [Sind $bold(v)_1 = (1, 2, 1)$, $bold(v)_2 = (1, 3, 1)$, $bold(v)_3 = (1, 1, 0)$ linear unabhängig? Falls nicht, gib eine Abhängigkeit an.],
[$det mat(1, 1, 1; 2, 3, 1; 1, 1, 0) = (0 + 1 + 2) - (3 + 1 + 0) = 3 - 4 = -1 != 0$. Also unabhängig. (Es gibt keine nichttriviale LK, die den Nullvektor ergibt.)])

#aufg("Ist der Vektor im Erzeugnis?", [Liegt $bold(b) = (1, 2, 3)$ im Erzeugnis von $(1, 0, 1)$ und $(0, 1, 2)$? Und $(1, 1, 1)$?],
[$c_1 (1, 0, 1) + c_2 (0, 1, 2) = (c_1, c_2, c_1 + 2 c_2)$. Für $(1, 2, 3)$: $c_1 = 1$, $c_2 = 2$, dritte Komponente $1 + 4 = 5 != 3$: nein. Für $(1, 1, 1)$: $c_1 = 1$, $c_2 = 1$, $3 != 1$: nein. (Das Erzeugnis ist die Ebene $z = x + 2y$, d. h. $x + 2y - z = 0$: $1 + 4 - 3 = 2 != 0$, $1 + 2 - 1 = 2 != 0$.)])

#aufg("Kern und Bild", [Bestimme Kern und Bild von $A = mat(1, 1; 1, 1; 0, 0)$ und beschreibe beide geometrisch.],
[$Kern(A)$: $x + y = 0$, also $erz{(1, -1)}$ (Gerade im $RR^2$). $Bild(A) = erz{(1, 1, 0)}$ (beide Spalten sind gleich), eine Gerade im $RR^3$ in der $x y$-Ebene. Gleichungsform des Bildes: $b_1 = b_2$ und $b_3 = 0$.])

#aufg("Erzeugnis gleich?", [Zeige $erz{(1, 1), (1, -1)} = RR^2$ und $erz{(1, 2), (2, 4)} != RR^2$.],
[Die Matrix mit Spalten $(1, 1)$, $(1, -1)$ hat $det = -2 != 0$: Rang $2$, also erzeugend. Bei $(1, 2), (2, 4)$ ist $det = 4 - 4 = 0$: Rang $1$, das Erzeugnis ist nur die Gerade $y = 2x$.])

#aufg("Funktionen", [Zeige: $e^x$ und $e^(2x)$ sind in $C(RR)$ linear unabhängig.],
[Aus $a e^x + b e^(2x) = 0$ für alle $x$: $x = 0$ liefert $a + b = 0$, $x = 1$ liefert $a e + b e^2 = 0$, also $a + b e = 0$. Subtrahiert: $b (e - 1) = 0$, also $b = 0$ und damit $a = 0$. Unabhängig.])
