#import "lib.typ": *

= Funktionenräume und Unterräume

#woche(11, [Vektorräume von Funktionen, Unterräume], [Funktionenräume · Unterraum · Unterraumkriterium · Beispiele und Nichtbeispiele])

#vorlesung[Letzte Woche haben wir die Vektorraum-Axiome kennengelernt. Diese Woche zeigen wir, dass auch *Funktionen* Vektoren sind: Man kann zwei Funktionen addieren und eine Funktion mit einer Zahl strecken. Das erlaubt, mit Funktionen wie mit Pfeilen zu rechnen. Dann lernen wir den zweiten zentralen Begriff kennen, den *Unterraum*: ein Vektorraum, der in einem grösseren steckt. Mit einem einfachen Test (drei Bedingungen) lässt sich jedes Beispiel prüfen.]

== Vektorräume von Funktionen

Funktionen lassen sich addieren: Aus $f(x) = sin x$ und $g(x) = cos x$ entsteht die Funktion $f + g$ mit $(f + g)(x) = sin x + cos x$. Man rechnet «punktweise»: An jeder Stelle $x$ addiert man die Funktionswerte. Ebenso lassen sich Funktionen strecken: $(c f)(x) = c f(x)$.

#fg("l11_funk", [Punktweise Addition von Funktionen: An jeder Stelle $x_0$ werden die Funktionswerte addiert.], w: 74%)

#defn[Funktionenraum][Sei $X$ eine beliebige Menge und $KK in {RR, CC}$. Die Menge
$ F(X, KK) = {f : X arrow.r KK} $
aller Funktionen von $X$ nach $KK$ ist mit
$ (f + g)(x) = f(x) + g(x), quad (c f)(x) = c dot f(x) quad (x in X) $
ein *Vektorraum über $KK$*. Der Nullvektor ist die Nullfunktion $0(x) = 0$, das Negative von $f$ ist $(-f)(x) = -f(x)$.]

#beweis[Jedes Axiom folgt aus dem entsprechenden für Zahlen, weil man punktweise rechnet. Zum Beispiel (V1): $(f + g)(x) = f(x) + g(x) = g(x) + f(x) = (g + f)(x)$ für alle $x$, also $f + g = g + f$. (V6): $((c + d) f)(x) = (c + d) f(x) = c f(x) + d f(x) = (c f + d f)(x)$. Die anderen Axiome genauso.]

Dieses eine Beispiel enthält viele frühere als Spezialfälle:
- $X = {1, 2, dots, n}$: Eine Funktion $f: {1, dots, n} arrow.r RR$ ist ein Tupel $(f(1), dots, f(n))$. Also ist $F({1, dots, n}, RR) = RR^n$.
- $X = {1, dots, m} times {1, dots, n}$: Funktionen sind Tabellen, also $RR^(m times n)$.
- $X = NN$: Funktionen $NN arrow.r RR$ sind *Folgen*.
- $X = RR$ oder ein Intervall: die eigentlichen Funktionen aus der Analysis.

#intu[Ein Tupel $(x_1, dots, x_n)$ ist eine Funktion, die jedem Index $i$ einen Wert zuordnet. Eine Funktion auf $RR$ ist ein «Tupel mit unendlich (sogar überabzählbar) vielen Einträgen», einer für jeden Punkt. Alles, was man über Tupel-Vektoren lernt, gilt sinngemäss auch hier.]

=== Wichtige Funktionenräume

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [*Raum*], [*Bedeutung*],
  [$F(RR, RR)$], [alle Funktionen $RR arrow.r RR$ (die Summe und das Vielfache einer beliebigen Funktion ist wieder eine)],
  [$C(RR)$ oder $C^0$], [alle *stetigen* Funktionen (Summen und Vielfache stetiger Funktionen sind stetig)],
  [$C^1(RR)$, $C^k(RR)$], [$k$-mal stetig differenzierbare Funktionen],
  [$PP_n$], [Polynome vom Grad $<= n$],
  [$KK[x]$], [alle Polynome])

Zwischen ihnen gibt es Inklusionen: $PP_0 subset PP_1 subset PP_2 subset dots subset KK[x] subset C^infinity (RR) subset dots subset C^1(RR) subset C(RR) subset F(RR, RR)$. Jeder Raum ist ein Vektorraum für sich, und jeder steckt im nächsten grösseren *mit denselben Operationen*. Genau diese Situation beschreibt der Begriff des Unterraums.

== Unterräume

#defn[Unterraum][Sei $V$ ein Vektorraum über $KK$. Eine Teilmenge $U subset.eq V$ heisst *Unterraum* (UR) von $V$, wenn $U$ mit der Addition und Skalarmultiplikation von $V$ selbst ein Vektorraum über $KK$ ist.]

Man müsste jetzt alle acht Axiome prüfen. Zum Glück gibt es eine Abkürzung: Die Axiome gelten in $U$ automatisch, weil sie in $V$ gelten. Nur die *Abgeschlossenheit* ist zu prüfen.

#satz[Unterraumkriterium][Eine Teilmenge $U subset.eq V$ ist genau dann ein Unterraum, wenn
+ $bold(0) in U$ (oder allgemeiner: $U != emptyset$),
+ $bold(u), bold(v) in U arrow.r.double bold(u) + bold(v) in U$ (*abgeschlossen unter Addition*),
+ $c in KK, bold(u) in U arrow.r.double c bold(u) in U$ (*abgeschlossen unter Skalarmultiplikation*).]

#beweis[«$arrow.r.double$» ist klar. «$arrow.l.double$»: Die Axiome (V1), (V2), (V5), (V6), (V7), (V8) sind Gleichungen zwischen Vektoren von $V$ und gelten daher erst recht für Vektoren in $U$. (V3): Der Nullvektor liegt nach 1 in $U$. (V4): Zu $bold(u) in U$ ist $-bold(u) = (-1) bold(u) in U$ nach 3 (siehe Satz in Woche 10). Dass die Operationen nicht aus $U$ herausführen, sagen 2 und 3.]

Die beiden Bedingungen 2 und 3 lassen sich zu einer zusammenfassen: $bold(u), bold(v) in U$, $c, d in KK$ $arrow.r.double$ $c bold(u) + d bold(v) in U$. («Linearkombinationen bleiben in $U$.»)

#rezept[Unterraum nachweisen oder widerlegen][
  + *Nullvektor:* Liegt $bold(0)$ in $U$? Wenn nicht, ist $U$ kein Unterraum (schneller Test!).
  + *Addition:* Seien $bold(u), bold(v) in U$ beliebig. Ist $bold(u) + bold(v)$ wieder in $U$? Beweis in allgemeiner Form mit der definierenden Bedingung von $U$.
  + *Skalare:* Seien $bold(u) in U$ und $c in KK$ beliebig. Ist $c bold(u) in U$?
  + Zum *Widerlegen* genügt ein einziges *Gegenbeispiel* für eine der drei Bedingungen.
]

#bsp[Ein Unterraum des $RR^3$][
$U = {(x, y, z) in RR^3 : x + 2y - z = 0}$ ist ein Unterraum von $RR^3$.
(1) $(0, 0, 0)$: $0 + 0 - 0 = 0$ ✓. (2) Seien $(x, y, z)$ und $(x', y', z')$ in $U$, also $x + 2y - z = 0$ und $x' + 2y' - z' = 0$. Dann ist $(x + x') + 2(y + y') - (z + z') = (x + 2y - z) + (x' + 2y' - z') = 0 + 0 = 0$ ✓. (3) $c x + 2 c y - c z = c (x + 2y - z) = 0$ ✓.
Geometrisch: $U$ ist die Ebene durch den Nullpunkt mit Normalenvektor $(1, 2, -1)$. Aufgelöst nach $z = x + 2y$: $U = {(x, y, x + 2y)} = {x (1, 0, 1) + y (0, 1, 2)}$.
]

#fgs(("l11_ebene", "l11_gerade", "l11_affin"), [Ebenen und Geraden *durch den Nullpunkt* sind Unterräume des $RR^3$; verschobene nicht.])

#bsp[Keine Unterräume][
- $A = {(x, y) in RR^2 : x + y = 1}$: $bold(0) in.not A$. Kein Unterraum. (Das ist die Schwäche *aller* «verschobenen» Geraden und Ebenen.)
- $B = {(x, y) in RR^2 : x y = 0}$ (die beiden Koordinatenachsen): $(1, 0) in B$ und $(0, 1) in B$, aber $(1, 0) + (0, 1) = (1, 1) in.not B$. Nicht abgeschlossen unter Addition.
- $C = {(x, y) in RR^2 : x^2 + y^2 <= 1}$ (Einheitskreisscheibe): $(1, 0) in C$, aber $2 (1, 0) = (2, 0) in.not C$. Nicht abgeschlossen unter Skalarmultiplikation.
- $D = {(x, y) : x >= 0, y >= 0}$: $(1, 1) in D$, aber $-1 dot (1, 1) in.not D$.
]

#fehler[
- Zu behaupten, eine Menge sei ein Unterraum, weil sie «den Nullvektor enthält». Der Nullvektor ist notwendig, aber nicht hinreichend.
- Beim Prüfen der Abgeschlossenheit konkrete Zahlen einsetzen statt allgemeiner Elemente. Ein Beispiel *beweist* keine Abgeschlossenheit (aber *widerlegt* sie).
- Zu vergessen, dass «$U subset V$» alleine nichts über Unterräume sagt: Jede Teilmenge ist eine Teilmenge, aber nur wenige sind Unterräume.
]

=== Wichtige Beispiele für Unterräume

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [*Unterraum*], [*In welchem Raum, Begründung*],
  [$\{bold(0)\}$ und $V$], [die beiden *trivialen* Unterräume jedes Vektorraums $V$],
  [Geraden und Ebenen durch $bold(0)$ im $RR^3$], [Lösungsmengen homogener Gleichungen $a x + b y + c z = 0$],
  [$Kern(A) = {bold(x) : A bold(x) = bold(0)}$], [Lösungsmenge eines HLGS: Unterraum von $RR^n$ (Woche 4: Summe und Vielfache von Lösungen sind Lösungen)],
  [symmetrische Matrizen $A^tp = A$], [Unterraum von $RR^(n times n)$, denn $(A + B)^tp = A^tp + B^tp = A + B$, $(c A)^tp = c A$],
  [antisymmetrische Matrizen $A^tp = -A$], [Unterraum von $RR^(n times n)$],
  [obere Dreiecksmatrizen, Diagonalmatrizen], [Unterräume von $RR^(n times n)$],
  [Matrizen mit Spur $0$], [Unterraum von $RR^(n times n)$, da $spur$ linear ist],
  [$PP_n$], [Unterraum von $PP_(n+1)$, von $KK[x]$, von $C(RR)$, \dots],
  [$\{f in C(RR) : f(0) = 0\}$], [Unterraum von $C(RR)$: Summe und Vielfache behalten $f(0) = 0$],
  [$\{p in PP_2 : p(1) = 0\}$], [Unterraum von $PP_2$; $p(x) = (x - 1)(alpha x + beta)$, d. h. aufgespannt von $x - 1$ und $x^2 - x$])

#bsp[Lösungen einer Differentialgleichung][
Die Menge $L = {f in C^2(RR) : f'' + f = 0}$ der Lösungen von $f'' + f = 0$ ist ein Unterraum von $C^2(RR)$ (Differentialgleichungen der Form «lineare Ausdrücke in $f, f', f''$ gleich null» haben diese Eigenschaft: sind $f, g$ Lösungen, so ist $(f + g)'' + (f + g) = (f'' + f) + (g'' + g) = 0$, und $(c f)'' + c f = c(f'' + f) = 0$). Man kennt zwei Lösungen: $sin$ und $cos$ (denn $(sin x)'' = -sin x$). Alle Linearkombinationen $a sin x + b cos x$ sind Lösungen, und in der Analysis-Vorlesung (Differentialgleichungen) zeigt man, dass es keine anderen gibt: $L = {a sin + b cos}$. Dieser Raum hat «zwei Dimensionen», genau wie die Lösungsmenge eines HLGS mit zwei freien Parametern.
Dagegen ist die Lösungsmenge von $f'' + f = x$ (inhomogen) *kein* Unterraum: $bold(0)$ (die Nullfunktion) löst sie nicht. Sie ist eine Lösung $x$ *plus* ein Element von $L$, genau wie bei LGS (Woche 4: partikuläre plus homogene Lösung).
]

#alltag[Die Ingenieurmathematik lebt von dieser Beobachtung: Schwingungen, elektrische Netzwerke und viele Regelkreise werden durch *lineare homogene* Differentialgleichungen beschrieben, deren Lösungen einen Vektorraum bilden. Daher darf man Lösungen überlagern (Superposition): Zwei Schwingungen, die die Gleichung erfüllen, ergeben addiert wieder eine Lösung. In der Akustik heisst das: Töne überlagern sich ungestört. Bei nichtlinearen Gleichungen (z. B. Pendel mit grossem Ausschlag) gilt das nicht.]

#kontrolle[Ist $U = {A in RR^(2 times 2) : A = A^tp, spur(A) = 0}$ ein Unterraum von $RR^(2 times 2)$? Wie sieht ein Element aus?][Ja: Es sind genau die Matrizen $mat(a, b; b, -a)$ (symmetrisch, Spur $0$). Summe und Vielfache haben wieder diese Form. $U = {a mat(1, 0; 0, -1) + b mat(0, 1; 1, 0)}$.]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Das Superpositionsprinzip.* Die Lösungen einer homogenen linearen Differentialgleichung bilden einen Unterraum: Summen und Vielfache von Lösungen sind wieder Lösungen. Das ist der Grund, warum Töne sich überlagern können, ohne einander zu stören, warum Wellen im Wasser durcheinander laufen und warum in der Elektrotechnik jede Schaltung aus «Teilschaltungen» berechnet wird. Eine Gitarrensaite schwingt als Summe von Obertönen, und der Klang jedes Instruments ist die Mischung.]

#alltag[*Polynome und Splines.* Die Polynome höchstens vom Grad $n$ bilden einen Vektorraum der Dimension $n + 1$. Ein CAD-Programm, das eine glatte Kurve durch Punkte legt (Autokarosserie, Schriftart, Strassenverlauf), baut sie aus Stücken von Polynomen dritten Grades, den Splines. Dass man sie addieren und strecken darf, ohne den Raum zu verlassen, macht sie rechenbar. Auch die Buchstaben, die du gerade liest, sind solche Kurven.]
// ALLTAG-END

#kurz[
- Funktionen $X arrow.r KK$ bilden mit punktweiser Addition und Skalarmultiplikation einen *Vektorraum* $F(X, KK)$. Er enthält $KK^n$, Matrizen und Folgen als Spezialfälle; ebenso $C(RR)$, $C^k(RR)$, Polynome.
- *Unterraum* $U subset.eq V$: ein Vektorraum mit den Operationen von $V$. *Kriterium:* $bold(0) in U$, abgeschlossen unter $+$ und unter Skalarmultiplikation.
- Verschobene Geraden und Ebenen, Mengen mit Ungleichungen, Vereinigungen von Achsen sind *keine* Unterräume. Kern einer Matrix, symmetrische Matrizen, Lösungen linearer homogener Differentialgleichungen *sind* Unterräume.
]

#aufgaben()

#aufg("Unterraum oder nicht?", [Entscheide und begründe, ob $U$ ein Unterraum des angegebenen Raums ist: (a) $U = {(x, y, z) in RR^3 : x = z}$; (b) $U = {(x, y, z) in RR^3 : x + y + z = 1}$; (c) $U = {A in RR^(2 times 2) : det A = 0}$; (d) $U = {p in PP_3 : p(0) = p(1)}$; (e) $U = {f in C(RR) : f(x) >= 0 "für alle" x}$.],
[(a) Ja: Ebene durch $bold(0)$ ($x - z = 0$ ist homogen linear). (b) Nein: $bold(0) in.not U$. (c) Nein (Woche 10: $mat(1, 0; 0, 0) + mat(0, 0; 0, 1) = I$ hat $det = 1$). (d) Ja: $(p + q)(0) = p(0) + q(0) = p(1) + q(1) = (p + q)(1)$ und $(c p)(0) = c p(0) = c p(1)$. (e) Nein: $f = 1 in U$, aber $(-1) f = -1 in.not U$.])

#aufg("Kern einer Matrix", [Bestimme den Unterraum $U = Kern(A)$ für $A = mat(1, 2, 1; 2, 4, 2)$ und beschreibe ihn geometrisch.],
[Die zweite Zeile ist das Doppelte der ersten: Es bleibt $x + 2y + z = 0$. Dies ist eine Ebene durch $bold(0)$ im $RR^3$. Parametrisiert: $y = s$, $z = t$, $x = -2s - t$, $U = {s (-2, 1, 0) + t (-1, 0, 1)}$.])

#aufg("Funktionenraum", [Zeige, dass $U = {f in F(RR, RR) : f(-x) = f(x) "für alle" x}$ (die *geraden* Funktionen) ein Unterraum ist. Gilt das auch für die Menge der Funktionen mit $f(0) = 1$?],
[Gerade Funktionen: Die Nullfunktion ist gerade. Für gerade $f, g$ ist $(f + g)(-x) = f(-x) + g(-x) = f(x) + g(x) = (f + g)(x)$, und $(c f)(-x) = c f(-x) = c f(x)$. Also Unterraum. Die Menge $\{f : f(0) = 1\}$ enthält die Nullfunktion nicht ($0(0) = 0 != 1$): kein Unterraum.])

#aufg("Axiome prüfen", [Warum ist die Menge der Polynome *genau* vom Grad $2$ kein Unterraum von $PP_2$?],
[Die Nullfunktion hat keinen Grad $2$ (und die Summe $(x^2 + x) + (-x^2) = x$ hat Grad $1$): Weder $bold(0)$ noch die Abgeschlossenheit unter Addition gelten. Der Unterraum «Grad *höchstens* $2$» ist dagegen $PP_2$ selbst.])

#aufg("Spur-null-Matrizen", [Zeige, dass $U = {A in RR^(n times n) : spur(A) = 0}$ ein Unterraum von $RR^(n times n)$ ist.],
[$spur(0) = 0$. Für $A, B in U$: $spur(A + B) = spur(A) + spur(B) = 0$ (Woche 5), und $spur(c A) = c spur(A) = 0$.])
