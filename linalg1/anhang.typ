#import "lib.typ": *
#set heading(numbering: none)
#show heading.where(level: 2): it => block(sticky: true, above: 1.8em, below: 0.9em, text(font: sans, size: 14.5pt, weight: "bold", it.body))

= Anhang: Formelsammlung und Rezepte

#nowoche

#vorlesung[Die wichtigsten Sätze, Rechenregeln und Verfahren des Kurses auf einen Blick. Kapitelverweise nennen die Woche, in der der Satz erklärt und bewiesen wird.]

== Der grosse Äquivalenzsatz (Wochen 4, 6, 9, 10, 12, 13)

Für $A in KK^(n times n)$ sind folgende Aussagen *alle gleichwertig*:

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [*$A$ ist regulär*], [*Gegenteil: $A$ ist singulär*],
  [$det(A) != 0$], [$det(A) = 0$],
  [$rang(A) = n$], [$rang(A) < n$],
  [$A^(-1)$ existiert], [keine Inverse],
  [$A bold(x) = bold(0)$ nur trivial lösbar, $Kern(A) = {bold(0)}$], [nichttriviale Lösungen von $A bold(x) = bold(0)$],
  [$A bold(x) = bold(b)$ für jedes $bold(b)$ eindeutig lösbar], [für manche $bold(b)$ unlösbar, sonst unendlich viele Lösungen],
  [Spalten (Zeilen) linear unabhängig, bilden eine Basis des $KK^n$], [Spalten (Zeilen) linear abhängig],
  [$Bild(A) = KK^n$], [$Bild(A) != KK^n$])

== Rechenregeln für Matrizen (Wochen 4, 5, 6)

#table(columns: (1fr, 1fr), stroke: none, inset: (x: 5pt, y: 4pt), align: left,
  [$(A B) C = A (B C)$], [$A (B + C) = A B + A C$],
  [$A B != B A$ im Allgemeinen], [$A B = 0$ heisst nicht $A = 0$ oder $B = 0$],
  [$(A B)^tp = B^tp A^tp$], [$(A B)^(-1) = B^(-1) A^(-1)$],
  [$(A^tp)^(-1) = (A^(-1))^tp$], [$spur(A B) = spur(B A)$],
  [$A$ orthogonal: $A^tp A = I$, $A^(-1) = A^tp$], [$P$ Permutationsmatrix: $P^(-1) = P^tp$],
  [$(A B)_(i j) = a_(i k) b_(k j)$], [$delta_(i j) x_j = x_i$])

== Determinanten (Wochen 8, 9, 10)

#table(columns: (1fr, 1fr), stroke: none, inset: (x: 5pt, y: 4pt), align: left,
  [$det mat(a, b; c, d) = a d - b c$], [$det A = sum_k a_(i k) C_(i k)$ (nach Zeile $i$), $C_(i k) = (-1)^(i+k) M_(i k)$],
  [Sarrus ($3 times 3$): $a e i + b f g + c d h - c e g - a f h - b d i$], [$det(A B) = det A det B$, $det A^tp = det A$],
  [$det(c A) = c^n det A$, $det A^(-1) = 1\/det A$], [Dreiecksmatrix: Produkt der Diagonale],
  [Zeilen vertauschen: Vorzeichen $-$], [Vielfaches einer Zeile addieren: unverändert],
  [Zeile mit $c$ multiplizieren: mal $c$], [$det mat(A, B; 0, D) = det A det D$],
  [$A^(-1) = adj(A)\/det(A)$, $adj(A) = (C_(i j))^tp$], [Cramer: $x_i = det(A_i)\/det(A)$],
  [$det A = (-1)^s product r_(i i)$ aus $P A = L R$], [$|det|$ = Fläche / Volumen])

== Vektorräume (Wochen 10 bis 13)

- *Unterraumkriterium:* $bold(0) in U$, $bold(u) + bold(v) in U$, $c bold(u) in U$.
- *Erzeugnis* $erz{bold(v)_i}$ = alle Linearkombinationen; kleinster UR, der alle $bold(v)_i$ enthält.
- *Linear unabhängig:* $sum c_i bold(v)_i = bold(0)$ nur für $c_i = 0$. Im $KK^n$: Matrix mit Spalten $bold(v)_i$ hat Rang $k$.
- *Basis* = linear unabhängiges Erzeugendensystem; *Dimension* = Länge einer Basis. $dimn KK^n = n$, $dimn PP_n = n + 1$, $dimn KK^(m times n) = m n$.
- In Dimension $n$: $n$ unabhängige oder $n$ erzeugende Vektoren sind schon eine Basis.
- *Rangsatz:* $dimn V = dimn Kern(f) + dimn Bild(f)$. Zeilenrang $=$ Spaltenrang $= rang(A)$.
- *Koordinaten:* $bold(v) = sum x_i bold(b)_i$, $[bold(v)]_(cal(B)) = x$. Basiswechsel: $[bold(v)]_(cal(C)) = T [bold(v)]_(cal(B))$, $T = C^(-1) B$.

== Geometrie in der Ebene (Wochen 3, 7)

#table(columns: (1fr, 1fr), stroke: none, inset: (x: 5pt, y: 4pt), align: left,
  [Drehung $R(phi.alt) = mat(cos phi.alt, -sin phi.alt; sin phi.alt, cos phi.alt)$], [Spiegelung $S(alpha) = mat(cos 2 alpha, sin 2 alpha; sin 2 alpha, -cos 2 alpha)$],
  [$R(phi.alt) R(psi) = R(phi.alt + psi)$], [$S(alpha) S(beta) = R(2(alpha - beta))$],
  [Skalarprodukt $bold(x) dot bold(y) = x_1 y_1 + dots$], [$cos theta = (bold(x) dot bold(y))\/(|bold(x)||bold(y)|)$],
  [HNF: $bold(n) dot bold(x) = d$, $|bold(n)| = 1$], [Abstand von $bold(p)$: $|bold(n) dot bold(p) - d|$],
  [Projektion auf $bold(a)$: $P = bold(a) bold(a)^tp\/(bold(a)^tp bold(a))$], [Householder: $H = I - 2 bold(v) bold(v)^tp\/(bold(v)^tp bold(v))$])

== Die wichtigsten Verfahren

#rezept[Gauss-Algorithmus][Pivot wählen (Zeile tauschen, falls nötig; numerisch: betragsgrösster), darunter Nullen erzeugen, mit der Restmatrix weitermachen. Erweiterte Matrix $(A | bold(b))$ $arrow.r$ Zeilenstufenform. Zeile $(0 dots 0 | c)$, $c != 0$: keine Lösung. Sonst: Spalten ohne Pivot $arrow.r$ freie Parameter, von unten nach oben auflösen.]

#rezept[Inverse (Gauss-Jordan)][$(A | I) arrow.r (I | A^(-1))$. Erscheint links eine Nullzeile, ist $A$ singulär. Probe: $A A^(-1) = I$.]

#rezept[Determinante][Entwickeln nach Zeile oder Spalte mit vielen Nullen, oder Gauss auf Dreiecksform (Vielfaches addieren ändert nichts, Vertauschen: Vorzeichen) und Diagonale multiplizieren.]

#rezept[Basis des Kerns und des Bildes][ZSF bilden. *Kern:* je freie Variable ein Basisvektor (diese $= 1$, übrige freie $= 0$). *Bild:* die Spalten von $A$ (ursprüngliche!) zu den Pivotspalten.]

#rezept[Lineare Unabhängigkeit prüfen][Vektoren als Spalten in $A$; unabhängig genau dann, wenn $rang(A) = $ Anzahl der Vektoren (bei quadratischem $A$: $det A != 0$).]

#rezept[LR-Zerlegung][Gauss ohne Tausch; Faktoren $l_(i k) = a_(i k)^((k))\/a_(k k)^((k))$ in $L$ (Einsen auf der Diagonale), Ergebnis in $R$. Mit Tausch: $P A = L R$. Lösen: $L bold(y) = P bold(b)$ vorwärts, $R bold(x) = bold(y)$ rückwärts.]
