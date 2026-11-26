#import "lib.typ": *

= Rang, homogene Systeme und Matrizen

#woche(4, [Rang, Lösbarkeit, homogene LGS, Matrizen], [Rang · Lösbarkeits- und Eindeutigkeitssätze · HLGS · spezielle Matrizen · Transponierte · Matrixoperationen])

#vorlesung[Diese Woche fassen wir alles, was die Zeilenstufenform über ein System verrät, in einer einzigen Zahl zusammen: dem *Rang*. Mit ihm lassen sich Existenz und Eindeutigkeit der Lösungen *ohne Rechnen im Detail* beantworten. Dann untersuchen wir die einfachsten Systeme, die homogenen, deren Lösungen eine ganz besondere Struktur haben. Schliesslich geben wir den Matrizen ein eigenes Leben: Wir lernen, sie zu addieren, zu strecken und zu multiplizieren.]

== Der Rang einer Matrix

#defn[Rang][Der *Rang* einer Matrix $A$, geschrieben $rang(A)$, ist die Anzahl der Pivots (also der Nicht-Nullzeilen) einer Zeilenstufenform von $A$.]

Damit diese Definition sinnvoll ist, muss die Anzahl der Pivots unabhängig davon sein, *wie* man zur Zeilenstufenform gelangt. Das stimmt (die reduzierte ZSF ist eindeutig); einen einfachen Beweis geben wir in Woche 13, wenn wir den Rang als Dimension der Spalten und Zeilen verstehen. Bis dahin: Es spielt keine Rolle, welchen Weg man wählt, der Rang kommt immer gleich heraus.

#bsp[Rang bestimmen][
$ A = mat(1, 2, 0, 1; 2, 4, 1, 5; 3, 6, 1, 6) zu(Z_2 - 2 Z_1, Z_3 - 3 Z_1) mat(1, 2, 0, 1; 0, 0, 1, 3; 0, 0, 1, 3) zu(Z_3 - Z_2) mat(1, 2, 0, 1; 0, 0, 1, 3; 0, 0, 0, 0). $
Zwei Pivots, also $rang(A) = 2$. Die dritte Zeile von $A$ ist die Summe der beiden ersten ($1 + 2 = 3$, $2 + 4 = 6$, $0 + 1 = 1$, $1 + 5 = 6$): Sie bringt nichts Neues.
]

Aus der Definition folgt sofort: $rang(A) <= m$ (höchstens ein Pivot pro Zeile) und $rang(A) <= n$ (höchstens ein Pivot pro Spalte). Also
$ 0 <= rang(A) <= min(m, n). $
Nur die Nullmatrix hat Rang $0$.

#bsp[Der Rang hängt von einem Parameter ab][
Für welche $a in RR$ hat $A_a = mat(1, 1, a; 1, a, 1; a, 1, 1)$ welchen Rang?
$ mat(1, 1, a; 1, a, 1; a, 1, 1) zu(Z_2 - Z_1, Z_3 - a Z_1) mat(1, 1, a; 0, a - 1, 1 - a; 0, 1 - a, 1 - a^2). $
*Fall $a = 1$:* Die Zeilen 2 und 3 sind Nullzeilen, $rang = 1$ (die Matrix besteht nur aus Einsen). *Fall $a != 1$:* Der Pivot $a - 1 != 0$. Addiere $Z_2$ zu $Z_3$: der Eintrag in Spalte 3 wird $(1 - a) + (1 - a^2) = (1 - a)(2 + a)$ (und in Spalte 2: $(1 - a) + (a - 1) = 0$). Dieser Eintrag ist $0$ genau für $a = -2$ (denn $a = 1$ ist ausgeschlossen). Also: $rang(A_a) = 3$ für $a != 1, -2$; $rang(A_(-2)) = 2$; $rang(A_1) = 1$.
]

Solche «Fallunterscheidungen nach einem Parameter» sind klassische Prüfungsaufgaben. Das Vorgehen: Bis zu der Stelle eliminieren, wo man *durch einen Ausdruck mit dem Parameter teilen* müsste. An dieser Stelle trennt man die Fälle (Ausdruck $= 0$ bzw. $!= 0$).

== Sätze über den Rang und die Lösbarkeit

Jetzt können wir die Fragen aus Woche 1 vollständig beantworten.

#satz[Lösbarkeit][Das System $A bold(x) = bold(b)$ ist genau dann lösbar, wenn $rang(A) = rang(A | bold(b))$.]

#beweis[Eliminiert man $(A | bold(b))$, so ist die ZSF von $(A | bold(b))$ links vom Strich eine ZSF von $A$. Die erweiterte Matrix hat entweder dieselben Pivots wie $A$, oder einen zusätzlichen Pivot in der letzten Spalte. Ein Pivot in der letzten Spalte bedeutet eine Zeile $(0, dots, 0 | c)$ mit $c != 0$: ein Widerspruch. Es gibt also keine Lösung genau dann, wenn $rang(A | bold(b)) = rang(A) + 1$, sonst ist das System lösbar.]

#satz[Eindeutigkeit][Ist $A bold(x) = bold(b)$ lösbar, so gilt:
+ Die Lösung ist *eindeutig* genau dann, wenn $rang(A) = n$ (Anzahl der Unbekannten).
+ Andernfalls hat die Lösungsmenge genau $n - rang(A)$ freie Parameter (unendlich viele Lösungen).]

#satz[Weitere Folgerungen][
+ Ist $rang(A) = m$ (jede Zeile enthält einen Pivot), so ist $A bold(x) = bold(b)$ für *jede* rechte Seite $bold(b) in RR^m$ lösbar.
+ Ist $m < n$ (weniger Gleichungen als Unbekannte), so ist die Lösung *nie* eindeutig: Entweder gibt es keine Lösung oder unendlich viele.
+ Für *quadratische* Systeme ($m = n$) sind äquivalent: (a) $A bold(x) = bold(b)$ ist für ein $bold(b)$ eindeutig lösbar; (b) für jedes $bold(b)$ eindeutig lösbar; (c) $rang(A) = n$.
]

#beweis[(1) Hat jede Zeile einen Pivot, so gibt es keine Nullzeile in der ZSF von $A$, also keine Verträglichkeitsbedingung (Woche 3). (2) $rang(A) <= m < n$, also $n - rang(A) > 0$ freie Parameter. (3) Ist $rang(A) = n$, so hat jede Spalte einen Pivot und es gibt $n$ Pivots in $n$ Zeilen: keine Nullzeile, also für alle $bold(b)$ lösbar, und eindeutig wegen $n - n = 0$ Parametern. Umgekehrt: Ist die Lösung für ein $bold(b)$ eindeutig, so ist nach dem Eindeutigkeitssatz $rang(A) = n$.]

Alle Fälle in einer Tabelle ($r = rang(A)$, $m$ Gleichungen, $n$ Unbekannte):

#table(columns: (auto, auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [*$rang(A)$ vs. $rang(A|bold(b))$*], [*Fall*], [*Lösungsmenge*],
  [$rang(A) < rang(A | bold(b))$], [Widerspruch], [$L = emptyset$],
  [$rang(A) = rang(A | bold(b)) = n$], [alle Spalten mit Pivot], [genau eine Lösung],
  [$rang(A) = rang(A | bold(b)) < n$], [freie Spalten], [unendlich viele, $n - r$ Parameter])

#kontrolle[Ein System hat $5$ Gleichungen und $3$ Unbekannte, und die Koeffizientenmatrix hat den Rang $3$. Was kann man über die Lösungen sagen?][Mit $r = n = 3$ gibt es *höchstens eine* Lösung. Ob es überhaupt eine gibt, hängt von $bold(b)$ ab: Zwei Zeilen der ZSF sind Nullzeilen und liefern zwei Verträglichkeitsbedingungen an die rechte Seite.]

== Homogene lineare Gleichungssysteme

#defn[Homogenes System][Ein LGS $A bold(x) = bold(0)$ (rechte Seite gleich Null) heisst *homogen* (HLGS). Ein System $A bold(x) = bold(b)$ mit $bold(b) != bold(0)$ heisst *inhomogen*.]

Ein HLGS ist *immer lösbar*: $bold(x) = bold(0)$ (die *triviale Lösung*) erfüllt alle Gleichungen. Interessant ist die Frage, ob es *nichttriviale* Lösungen $bold(x) != bold(0)$ gibt. Die rechte Spalte $bold(0)$ ändert sich bei Zeilenumformungen nicht, deshalb rechnet man mit $A$ allein.

#satz[Nichttriviale Lösungen][Für ein HLGS $A bold(x) = bold(0)$ mit $A in RR^(m times n)$ gilt:
+ Es hat eine nichttriviale Lösung genau dann, wenn $rang(A) < n$.
+ Ist $m < n$, so gibt es stets nichttriviale Lösungen (und dann unendlich viele).
+ Für $m = n$: Nichttriviale Lösung $arrow.l.r.double$ $rang(A) < n$.
Die Lösungsmenge hat $n - rang(A)$ freie Parameter.]

Das folgt unmittelbar aus den Sätzen oben ($bold(0)$ ist stets eine Lösung, also ist das System lösbar; die Lösung ist genau dann eindeutig, wenn $rang(A) = n$).

#satz[Struktur der Lösungen eines HLGS][Sind $bold(u)$ und $bold(v)$ Lösungen von $A bold(x) = bold(0)$ und $lambda in RR$, so sind auch $bold(u) + bold(v)$ und $lambda bold(u)$ Lösungen.]

#beweis[$A(bold(u) + bold(v)) = A bold(u) + A bold(v) = bold(0) + bold(0) = bold(0)$ und $A(lambda bold(u)) = lambda A bold(u) = bold(0)$. (Wir benutzen die Rechenregeln $A(bold(u) + bold(v)) = A bold(u) + A bold(v)$ und $A(lambda bold(u)) = lambda (A bold(u))$, die sofort aus der Definition $(A bold(x))_i = sum_j a_(i j) x_j$ folgen.)]

Man sagt: Die Lösungen eines HLGS lassen sich beliebig *überlagern* (Superposition) und strecken. Mit dem Begriff aus Woche 11: Die Lösungsmenge ist ein *Unterraum*.

#bsp[Ein homogenes System][
$ x_1 + 2x_2 + x_4 = 0, quad 2x_1 + 4x_2 + x_3 + 5x_4 = 0. $
$ mat(1, 2, 0, 1; 2, 4, 1, 5) zu(Z_2 - 2 Z_1) mat(1, 2, 0, 1; 0, 0, 1, 3). $
$rang = 2 < 4$, also gibt es $4 - 2 = 2$ Parameter. Pivotspalten 1 und 3; frei: $x_2 = s$, $x_4 = t$. Dann $x_3 = -3t$ und $x_1 = -2s - t$:
$ bold(x) = vec(-2s - t, s, -3t, t) = s vec(-2, 1, 0, 0) + t vec(-1, 0, -3, 1). $
Die Lösungsmenge besteht aus allen Linearkombinationen der zwei Vektoren $(-2, 1, 0, 0)$ und $(-1, 0, -3, 1)$. Man liest ab: *Jeder freie Parameter bringt einen eigenen Basisvektor.*
]

=== Inhomogenes System = partikuläre Lösung + homogene Lösung

#satz[Struktur der Lösungsmenge][Ist $bold(x)_p$ *eine* Lösung des Systems $A bold(x) = bold(b)$ (eine *partikuläre Lösung*) und bezeichnet $L_("hom")$ die Lösungsmenge von $A bold(x) = bold(0)$, so gilt für die Lösungsmenge $L$ von $A bold(x) = bold(b)$:
$ L = bold(x)_p + L_("hom") = {bold(x)_p + bold(x)_h : bold(x)_h in L_("hom")}. $]

#beweis[«$supset.eq$»: $A(bold(x)_p + bold(x)_h) = bold(b) + bold(0) = bold(b)$. «$subset.eq$»: Ist $bold(x)$ irgendeine Lösung, so ist $bold(x)_h = bold(x) - bold(x)_p$ eine Lösung des homogenen Systems, denn $A(bold(x) - bold(x)_p) = bold(b) - bold(b) = bold(0)$; und $bold(x) = bold(x)_p + bold(x)_h$.]

#fg("l04_affin", [Die Lösungsmenge $L$ eines inhomogenen Systems ist die um $bold(x)_p$ *verschobene* Lösungsmenge des homogenen Systems.], w: 62%)

Das erklärt die Parameterdarstellung aus Woche 3: Der Stützvektor ist eine partikuläre Lösung, die Richtungsvektoren (mit Parametern) lösen das homogene System. Ausserdem sieht man, warum es nie genau zwei Lösungen gibt: Zwei verschiedene Lösungen $bold(x)_1 != bold(x)_2$ liefern die nichttriviale homogene Lösung $bold(x)_1 - bold(x)_2$, und deren Vielfache sind alle homogen lösend.

#intu[Die Lösungsmenge eines HLGS geht immer durch den Nullpunkt. Die eines inhomogenen Systems sieht genauso aus (gleiche Richtung, gleiche «Dicke»), ist aber verschoben, sodass sie nicht mehr durch den Nullpunkt geht. Das gilt für Gleichungssysteme, aber auch für lineare Differentialgleichungen: «allgemeine Lösung = partikuläre Lösung + homogene Lösung».]

== Matrizen

Bisher war eine Matrix nur ein Schreibhilfsmittel für Gleichungssysteme. Jetzt behandeln wir sie als eigenständige mathematische Objekte, mit denen man *rechnen* kann.

#defn[Matrix, Gleichheit][Eine *$m times n$-Matrix* $A = (a_(i j))$ hat $m$ Zeilen und $n$ Spalten mit Einträgen $a_(i j) in RR$ (oder $CC$). Zwei Matrizen sind *gleich*, wenn sie gleich gross sind und alle Einträge übereinstimmen. Für $n = 1$ erhält man *Spaltenvektoren*, für $m = 1$ *Zeilenvektoren*.]

#fg("l04_matrix", [Eine $3 times 4$-Matrix. Der Eintrag $a_(i j)$ steht in Zeile $i$ und Spalte $j$.], w: 74%)

=== Spezielle Matrizen

#table(columns: (auto, 1fr, auto), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: (left, left, left + horizon),
  [*Name*], [*Eigenschaft*], [*Beispiel*],
  [quadratisch], [$m = n$], [$mat(1, 2; 3, 4)$],
  [Nullmatrix $0$], [alle Einträge $0$], [$mat(0, 0; 0, 0)$],
  [Einheitsmatrix $I$ (oder $I_n$)], [quadratisch, Einsen auf der Hauptdiagonalen, sonst $0$], [$mat(1, 0, 0; 0, 1, 0; 0, 0, 1)$],
  [Diagonalmatrix], [quadratisch, $a_(i j) = 0$ für $i != j$], [$mat(2, 0, 0; 0, -1, 0; 0, 0, 5)$],
  [obere Dreiecksmatrix], [quadratisch, $a_(i j) = 0$ für $i > j$ (alles unter der Diagonalen ist $0$)], [$mat(1, 2, 3; 0, 4, 5; 0, 0, 6)$],
  [untere Dreiecksmatrix], [quadratisch, $a_(i j) = 0$ für $i < j$], [$mat(1, 0, 0; 2, 3, 0; 4, 5, 6)$])

Die *Hauptdiagonale* besteht aus den Einträgen $a_(11), a_(22), dots$. Eine Matrix in Zeilenstufenform ist (wenn quadratisch) automatisch eine obere Dreiecksmatrix.

=== Die Transponierte

#defn[Transponierte][Die *transponierte Matrix* $A^tp$ einer $m times n$-Matrix $A$ ist die $n times m$-Matrix mit
$ (A^tp)_(i j) = a_(j i). $
Aus Zeilen werden Spalten und umgekehrt: Man spiegelt $A$ an der Hauptdiagonalen.]

#fg("l04_transp", [Transponieren: Die erste Zeile von $A$ wird zur ersten Spalte von $A^tp$.], w: 66%)

#defn[Symmetrisch, antisymmetrisch][Eine quadratische Matrix $A$ heisst
- *symmetrisch*, wenn $A^tp = A$, d. h. $a_(i j) = a_(j i)$ (spiegelsymmetrisch zur Diagonalen);
- *antisymmetrisch* (schiefsymmetrisch), wenn $A^tp = -A$, d. h. $a_(i j) = -a_(j i)$.]

Bei einer antisymmetrischen Matrix gilt für die Diagonaleinträge $a_(i i) = -a_(i i)$, also $a_(i i) = 0$: *Die Diagonale ist null.*

#satz[Zerlegung][Jede quadratische Matrix $A$ ist Summe einer symmetrischen und einer antisymmetrischen Matrix: $A = S + K$ mit
$ S = 1/2 (A + A^tp) quad "(symmetrisch)", quad K = 1/2 (A - A^tp) quad "(antisymmetrisch)". $]

#beweis[Offensichtlich ist $S + K = A$. Es gilt $S^tp = 1/2 (A^tp + A) = S$ und $K^tp = 1/2 (A^tp - A) = -K$ (wir benutzen $(A + B)^tp = A^tp + B^tp$, $(A^tp)^tp = A$ und $(c A)^tp = c A^tp$; siehe Woche 5).]

#bsp[Zerlegung][$ A = mat(1, 2, 3; 4, 5, 6; 7, 8, 10) = underbrace(mat(1, 3, 5; 3, 5, 7; 5, 7, 10), S) + underbrace(mat(0, -1, -2; 1, 0, -1; 2, 1, 0), K). $
$S$ ist symmetrisch ($s_(12) = s_(21) = 3$, ...), $K$ antisymmetrisch (Diagonale $0$, $k_(12) = -1 = -k_(21)$).]

#alltag[Symmetrische Matrizen sind in den Anwendungen allgegenwärtig: Die Steifigkeitsmatrix eines Tragwerks, die Kovarianzmatrix in der Statistik, die Trägheitstensoren der Mechanik und der Hesse-Matrix in der Analysis sind alle symmetrisch. Symmetrie spart Speicher (man muss nur die Hälfte ablegen) und garantiert schöne Eigenschaften, die wir in Lineare Algebra II sehen werden (reelle Eigenwerte, Orthogonaldiagonalisierung).]

== Operationen mit Matrizen

#defn[Summe und Vielfaches][Für Matrizen $A, B in RR^(m times n)$ und $c in RR$ sind $A + B$ und $c A$ *eintragsweise* definiert:
$ (A + B)_(i j) = a_(i j) + b_(i j), quad (c A)_(i j) = c a_(i j). $
Man kann nur Matrizen *derselben Grösse* addieren.]

Beispiel: $mat(1, 2; 3, 4) + mat(0, 1; 1, 0) = mat(1, 3; 4, 4)$ und $3 mat(1, 2; 3, 4) = mat(3, 6; 9, 12)$.

=== Das Matrixprodukt

Die interessante Operation ist die Multiplikation. Sie ist so gebaut, dass sie das Hintereinanderausführen zweier Matrix-Vektor-Produkte beschreibt: Zuerst $B bold(x)$, dann $A (B bold(x))$. (Dass das mit dem unten definierten Produkt $A B$ funktioniert, zeigen wir nächste Woche.)

#defn[Matrixprodukt][Sei $A in RR^(m times p)$ und $B in RR^(p times n)$. Das *Produkt* $A B in RR^(m times n)$ hat die Einträge
$ (A B)_(i j) = sum_(k=1)^p a_(i k) b_(k j) = a_(i 1) b_(1 j) + a_(i 2) b_(2 j) + dots + a_(i p) b_(p j). $
Der Eintrag $(i, j)$ ist also «Zeile $i$ von $A$ mal Spalte $j$ von $B$» (Skalarprodukt). Das Produkt $A B$ existiert nur, wenn *die Spaltenzahl von $A$ gleich der Zeilenzahl von $B$ ist*.]

Merkregel für die Grössen: $(m times p) dot (p times n) = (m times n)$: Die inneren Zahlen müssen übereinstimmen und verschwinden, die äusseren bleiben.

#bsp[Ein Matrixprodukt][
$ A = mat(1, 2, 3; 0, 1, -1) in RR^(2 times 3), quad B = mat(1, 0; 2, 1; 0, 3) in RR^(3 times 2). $
$A B$ ist $2 times 2$. $(A B)_(11) = 1 dot 1 + 2 dot 2 + 3 dot 0 = 5$, $(A B)_(12) = 1 dot 0 + 2 dot 1 + 3 dot 3 = 11$, $(A B)_(21) = 0 dot 1 + 1 dot 2 + (-1) dot 0 = 2$, $(A B)_(22) = 0 dot 0 + 1 dot 1 + (-1) dot 3 = -2$. Also $A B = mat(5, 11; 2, -2)$. Das Produkt in der anderen Reihenfolge, $B A$, ist $3 times 3$ und eine ganz andere Matrix: $B A = mat(1, 2, 3; 2, 5, 5; 0, 3, -3)$.
]

#fehler[
- *Das Matrixprodukt ist nicht kommutativ:* Selbst wenn $A B$ und $B A$ beide definiert und gleich gross sind, gilt im Allgemeinen $A B != B A$. Beispiel: $A = mat(1, 2; 3, 4)$, $B = mat(0, 1; 1, 0)$ ergibt $A B = mat(2, 1; 4, 3)$ (Spalten von $A$ vertauscht) und $B A = mat(3, 4; 1, 2)$ (Zeilen von $A$ vertauscht).
- Das Produkt eintragsweise zu bilden ($a_(i j) b_(i j)$) ist *nicht* das Matrixprodukt.
- Dimensionen prüfen: $(2 times 3)(2 times 3)$ ist *nicht* definiert.
]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Rang als Informationsgehalt.* Der Rang einer Matrix sagt, wie viele wirklich unabhängige Zeilen sie enthält. Ein Foto der Grösse $1000 times 1000$ Pixel hat $10^6$ Zahlen, aber oft ist es annähernd Rang $50$. Man kann es dann mit $2 dot 1000 dot 50 = 10^5$ Zahlen speichern, also mit einem Zehntel des Platzes. Solche «Niedrigrang-Näherungen» stecken in der Bildkompression, in der Gesichtserkennung und in Empfehlungssystemen: Die Matrix «Nutzer mal Film» ist näherungsweise von niedrigem Rang, weil Geschmäcker sich in wenigen Mustern wiederholen. So empfiehlt dir ein Streamingdienst einen Film.]

#alltag[*Homogene Systeme: Gleichgewichte und Schwingungen.* $A x = 0$ beschreibt, was «nichts bewirkt»: Ströme, die sich aufheben, Kräfte, die im Gleichgewicht sind, Eigenschwingungen einer Brücke. Gibt es nur $x = 0$, ist das System stabil. Gibt es mehr Lösungen, ist etwas «frei beweglich». Ein Bauingenieur prüft mit dem Rang der Steifigkeitsmatrix, ob ein Tragwerk nicht doch wackelt: Hat sie nicht vollen Rang, gibt es einen Mechanismus, also eine Bewegung ohne Widerstand.]
// ALLTAG-END

#kurz[
- *Rang* = Anzahl der Pivots. $0 <= rang(A) <= min(m, n)$.
- $A bold(x) = bold(b)$ lösbar $arrow.l.r.double$ $rang(A) = rang(A | bold(b))$. Dann $n - rang(A)$ freie Parameter; eindeutig genau dann, wenn $rang(A) = n$. Bei $m < n$ nie eindeutig. $rang(A) = m$ $arrow.r$ immer lösbar.
- *HLGS:* stets lösbar (triviale Lösung); nichttrivial $arrow.l.r.double$ $rang(A) < n$; Lösungen sind überlagerbar. $L = bold(x)_p + L_("hom")$.
- Spezielle Matrizen (quadratisch, $0$, $I$, Diagonal-, Dreiecksmatrizen); *Transponierte* $A^tp$; *(anti-)symmetrisch* $A^tp = plus.minus A$; jede quadratische Matrix = symmetrisch + antisymmetrisch.
- Summe, Vielfaches eintragsweise; *Produkt* $(A B)_(i j) = sum_k a_(i k) b_(k j)$, Grössen $(m times p)(p times n)$; *nicht kommutativ*.
]

#aufgaben()

#aufg("Rang in Abhängigkeit von einem Parameter", [Bestimme $rang(A)$ in Abhängigkeit von $t in RR$ für $A = mat(1, 2, 1; 2, 4, t; 1, 3, 2)$ und löse für $t = 2$ das System $A bold(x) = bold(0)$.],
[$ mat(1, 2, 1; 2, 4, t; 1, 3, 2) zu(Z_2 - 2 Z_1, Z_3 - Z_1) mat(1, 2, 1; 0, 0, t - 2; 0, 1, 1) zu(Z_2 arrow.l.r Z_3) mat(1, 2, 1; 0, 1, 1; 0, 0, t - 2). $
Für $t != 2$ ist $rang = 3$, für $t = 2$ ist $rang = 2$. Für $t = 2$: $x_3 = s$ frei, $x_2 = -s$, $x_1 = -2x_2 - x_3 = 2s - s = s$. $L_("hom") = {s(1, -1, 1)^tp}$. Probe: $1 - 2 + 1 = 0$, $2 - 4 + 2 = 0$, $1 - 3 + 2 = 0$ ✓.])

#aufg("Lösbarkeit und Eindeutigkeit", [Ein System $A bold(x) = bold(b)$ hat $A in RR^(4 times 5)$ mit $rang(A) = 4$. Welche Aussagen sind wahr? (a) Für jedes $bold(b)$ lösbar. (b) Für jedes $bold(b)$ eindeutig lösbar. (c) $A bold(x) = bold(0)$ hat eine nichttriviale Lösung. (d) Die Lösungsmenge hat 1 Parameter.],
[(a) wahr: $rang = m = 4$. (b) falsch: $n - r = 1 > 0$. (c) wahr: $rang < n = 5$. (d) wahr, wenn lösbar (und es ist lösbar nach (a)): $n - rang = 1$ freier Parameter.])

#aufg("Struktur der Lösungsmenge", [Das System $A bold(x) = bold(b)$ hat die Lösungen $bold(u) = (1, 2, 0)^tp$ und $bold(v) = (0, 1, 1)^tp$. Gib eine weitere Lösung an. Was weisst du über $rang(A)$ (für $A in RR^(3 times 3))$?],
[$bold(u) - bold(v) = (1, 1, -1)^tp$ löst das HLGS, also ist $bold(u) + t(bold(u) - bold(v))$ für jedes $t$ eine Lösung, z. B. $t = 2$: $(3, 4, -2)^tp$. Da $A bold(x) = bold(0)$ eine nichttriviale Lösung hat, ist $rang(A) < 3$.])

#aufg("Matrixprodukte", [Berechne, falls möglich, $A B$ und $B A$ für (a) $A = mat(2, 1; 0, -1)$, $B = mat(1, 3; 2, 0)$ und (b) $A = mat(1, 2, 3)$ (eine Zeile), $B = (1, 0, -1)^tp$ (eine Spalte).],
[(a) $A B = mat(2 dot 1 + 1 dot 2, 2 dot 3 + 0; 0 - 2, 0) = mat(4, 6; -2, 0)$; $B A = mat(2, 1 - 3; 4, 2) = mat(2, -2; 4, 2)$. Verschieden! (b) $A B = 1 - 3 = (-2)$, eine $1 times 1$-Matrix, also die Zahl $-2$ (das Skalarprodukt). $B A$ ist eine $3 times 3$-Matrix: $mat(1, 2, 3; 0, 0, 0; -1, -2, -3)$.])

#aufg("Symmetrische und antisymmetrische Matrizen", [Zeige: Ist $A$ antisymmetrisch, so ist $A^2$ symmetrisch. (Hinweis: $(A B)^tp = B^tp A^tp$, Woche 5.)],
[$(A^2)^tp = (A A)^tp = A^tp A^tp = (-A)(-A) = A^2$. Also ist $A^2$ symmetrisch.])
