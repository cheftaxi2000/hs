#import "lib.typ": *

= Reihen, Potenzreihen und Taylor

#text(size: 9.5pt, style: "italic")[Vorlesung: Kapitel VIII. Eine Potenzreihe ist ein «unendlich langes Polynom». Taylorreihen schreiben bekannte Funktionen wie $e^x$, $sin x$ oder $ln x$ als solche Reihen. Damit kann man Funktionen näherungsweise berechnen, Grenzwerte bestimmen und schwierige Integrale lösen.]

== Konvergenz von Reihen

#idee[Bevor man Potenzreihen versteht, muss man wissen, wann eine unendliche Summe von Zahlen überhaupt einen Wert hat. Die Vorlage behandelt das nur kurz. Hier kommen die Kriterien, mit denen man in Prüfungen Konvergenz nachweist.]

=== Wiederholung

Eine Reihe $sum_(k=0)^oo a_k$ *konvergiert* gegen $S$, wenn die Folge der Partialsummen $s_n = a_0 + a_1 + dots + a_n$ gegen $S$ konvergiert (Abschnitt 1.1). Sonst *divergiert* sie.

#satz[Nullfolgenkriterium (notwendige Bedingung)][Konvergiert $sum a_k$, so ist $(a_k)$ eine Nullfolge: $lim_(k -> oo) a_k = 0$.

Umgekehrt formuliert, und so benutzt man es: *Ist $a_k$ keine Nullfolge, so divergiert die Reihe.*]

#fehler[Die Umkehrung ist *falsch*: $a_k -> 0$ heisst noch nicht, dass die Reihe konvergiert. Das klassische Gegenbeispiel ist die *harmonische Reihe*
$ sum_(k=1)^oo 1/k = 1 + 1/2 + 1/3 + 1/4 + dots = oo. $
Die Glieder gehen gegen $0$, aber zu langsam.]

#warum[Die harmonische Reihe divergiert][
  Man fasst Gruppen zusammen, die sich jeweils nach unten durch $1\/2$ abschätzen lassen:
  $ 1 + 1/2 + underbrace((1/3 + 1/4), >= 2 dot 1/4 = 1/2) + underbrace((1/5 + dots + 1/8), >= 4 dot 1/8 = 1/2) + underbrace((1/9 + dots + 1/16), >= 8 dot 1/16 = 1/2) + dots $
  Man bekommt unendlich viele Gruppen, die jede mindestens $1\/2$ beitragen. Die Summe wächst also über jede Grenze, wenn auch sehr langsam: Für $s_n > 10$ braucht man über 12 000 Glieder.
]

#fg("a05_harmonisch", [Partialsummen der harmonischen Reihe (rot) und von $sum 1\/k^2$ (grün). Die Glieder beider Reihen gehen gegen $0$, aber nur die zweite Reihe hat einen endlichen Wert.], w: 64%)

=== Geometrische Reihe

#satz[Geometrische Reihe][
  $ sum_(k=0)^oo x^k = 1 + x + x^2 + x^3 + dots = 1/(1 - x) quad "für" |x| < 1. $
  Für $|x| >= 1$ divergiert sie (die Glieder gehen nicht gegen $0$).
]

#fg("a05_geom", [Die Partialsummen $s_n = 1 + x + dots + x^n$ (gestrichelt) nähern sich $1\/(1-x)$ nur im grünen Bereich $|x| < 1$. Ausserhalb laufen sie davon, obwohl $1\/(1-x)$ dort ganz harmlos ist (z. B. bei $x = -1.5$).], w: 60%)

Das ist die wichtigste Reihe überhaupt. Sie zeigt schon die Grundidee dieses Kapitels: Die Funktion $1\/(1 - x)$ lässt sich als «unendliches Polynom» schreiben, aber nur in einem bestimmten Bereich. Die Vergleichskriterien unten führen viele Reihen auf diese zurück.

=== Konvergenzkriterien

#satz[Vergleichskriterium][Gilt $0 <= a_k <= b_k$ für alle grossen $k$:
- $sum b_k$ konvergiert $=>$ $sum a_k$ konvergiert (*Majorante*).
- $sum a_k$ divergiert $=>$ $sum b_k$ divergiert (*Minorante*).
Wichtige Vergleichsreihen: $sum 1\/k^p$ konvergiert genau für $p > 1$; geometrische Reihen $sum q^k$ für $|q| < 1$.]

#satz[Quotientenkriterium][Existiert $L = lim_(k -> oo) |a_(k+1) \/ a_k|$, dann gilt:
$ L < 1 => "absolut konvergent", wide L > 1 => "divergent", wide L = 1 => "keine Aussage". $]

#satz[Wurzelkriterium][Existiert $L = lim_(k -> oo) root(k, |a_k|)$, dann gilt dasselbe: $L < 1$ konvergent, $L > 1$ divergent, $L = 1$ keine Aussage.]

#intu[Beide Kriterien fragen: Verhält sich die Reihe für grosse $k$ wie eine geometrische Reihe mit Quotient $L$? Wenn ja, entscheidet $L$ wie bei der geometrischen Reihe. Bei $L = 1$ (z. B. bei $1\/k$ und $1\/k^2$) wachsen oder fallen die Glieder langsamer als jede geometrische Folge, und die Kriterien sind blind.]

#satz[Leibniz-Kriterium für alternierende Reihen][Ist $(b_k)$ eine *monoton fallende Nullfolge*, so konvergiert
$ sum_(k=0)^oo (-1)^k b_k = b_0 - b_1 + b_2 - b_3 + dots $
Der Fehler beim Abbrechen nach dem $n$-ten Glied ist höchstens so gross wie das erste weggelassene Glied: $|S - s_n| <= b_(n+1)$.]

#fg("a05_leibniz", [Die alternierende harmonische Reihe $1 - 1\/2 + 1\/3 - dots$. Die Partialsummen springen abwechselnd über und unter den Grenzwert $ln 2$, und die Sprünge werden immer kleiner.], w: 62%)

#defn[Absolute Konvergenz][$sum a_k$ heisst *absolut konvergent*, wenn $sum |a_k|$ konvergiert. Absolut konvergent $=>$ konvergent. Die alternierende harmonische Reihe ist konvergent, aber nicht absolut konvergent (*bedingt konvergent*).]

#rezept[Welches Kriterium wann?][
  + *Nullfolge?* Geht $a_k$ nicht gegen $0$, ist man fertig: divergent.
  + *Bekannte Reihe?* Geometrisch, $sum 1\/k^p$, Teleskopsumme.
  + *Fakultäten oder $c^k$ im Glied?* Quotientenkriterium (Fakultäten kürzen sich schön).
  + *Alles hoch $k$*, z. B. $(dots)^k$? Wurzelkriterium.
  + *Wechselndes Vorzeichen $(-1)^k$?* Leibniz.
  + *Bruch aus Potenzen von $k$?* Vergleich mit $sum 1\/k^p$, wobei $p$ = Nennergrad minus Zählergrad.
]

#bsp[Konvergenz prüfen][
  - $display(sum k/(2k + 1))$: Glieder $-> 1\/2 != 0$. Divergent.
  - $display(sum (2^k)/k!)$: Quotient $display((2^(k+1) \/ (k+1)!)/(2^k \/ k!) = 2/(k + 1) -> 0 < 1)$. Konvergent (sogar gegen $e^2 - 1$ bzw. $e^2$ ab $k = 0$).
  - $display(sum ((k)/(2k + 1))^k)$: Wurzel $k\/(2k+1) -> 1\/2 < 1$. Konvergent.
  - $display(sum (-1)^k/sqrt(k))$: $1\/sqrt(k)$ fällt monoton gegen $0$. Konvergent nach Leibniz (aber nicht absolut, da $sum 1\/sqrt(k)$ mit $p = 1\/2$ divergiert).
  - $display(sum (k + 1)/(k^3 + 2))$: verhält sich wie $k\/k^3 = 1\/k^2$; genauer $(k+1)\/(k^3+2) <= 2k\/k^3 = 2\/k^2$. Konvergent.
]

== Potenzreihen

#defn[Potenzreihe][
  $ sum_(k=0)^oo a_k (x - x_0)^k = a_0 + a_1 (x - x_0) + a_2 (x - x_0)^2 + a_3 (x - x_0)^3 + dots $
  $x_0$ heisst *Entwicklungspunkt*, die $a_k$ sind die *Koeffizienten*. Für jedes feste $x$ ist das eine gewöhnliche Reihe von Zahlen, die konvergieren kann oder nicht.
]

#idee[Polynome sind die einfachsten Funktionen: Man kann sie mit den Grundrechenarten auswerten, ableiten und integrieren. Die Idee der Potenzreihe ist, kompliziertere Funktionen durch Polynome immer höheren Grades anzunähern. Im Grenzfall «Grad unendlich» wird die Näherung exakt, zumindest in der Nähe von $x_0$.]

#bsp[Die Kosinusreihe][
  $ cos x = sum_(k=0)^oo (-1)^k x^(2k)/(2k)! = 1 - x^2/2! + x^4/4! - x^6/6! + dots $
  Bricht man nach dem Glied mit $x^n$ ab, erhält man das Polynom $P_n$. Schon $P_2 = 1 - x^2\/2$ stimmt in der Nähe von $0$ gut mit $cos x$ überein. Je höher der Grad, desto grösser der Bereich, in dem man keinen Unterschied sieht:
  #align(center, image("figs/a05_cos.svg", width: 82%))
  $P_(10) = 1 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^(10)/10!$ ist bis etwa $|x| = 4$ kaum vom Kosinus zu unterscheiden.
]

=== Konvergenzradius

#satz[Konvergenzradius][Zu jeder Potenzreihe gibt es ein $rho in [0, oo]$, den *Konvergenzradius*, mit:
- für $|x - x_0| < rho$ konvergiert die Reihe (absolut),
- für $|x - x_0| > rho$ divergiert sie,
- für $|x - x_0| = rho$ (die beiden Randpunkte) ist keine allgemeine Aussage möglich.]

#fg("a05_intervall", [Das Konvergenzintervall ist symmetrisch um $x_0$. An den Randpunkten muss man einzeln prüfen.], w: 70%)

#formel[Berechnung des Konvergenzradius][
  $ rho = lim_(k -> oo) |a_k / a_(k+1)| wide "oder" wide rho = 1/(lim_(k -> oo) root(k, |a_k|)) $
  (falls die Grenzwerte existieren; $1\/0 = oo$, $1\/oo = 0$). Achtung: Beim Quotienten steht $a_k$ *oben*, umgekehrt als beim Quotientenkriterium.
]

#warum[Konvergenzradius aus dem Quotientenkriterium][Wende das Quotientenkriterium auf die Glieder $a_k (x - x_0)^k$ an: $display(|(a_(k+1)(x - x_0)^(k+1))/(a_k (x - x_0)^k)| -> |x - x_0| dot lim |a_(k+1)/a_k|)$. Konvergenz für Werte $< 1$, also $|x - x_0| < lim |a_k \/ a_(k+1)|$.]

#bsp[Konvergenzradius][
  $display(sum_(k=0)^oo 3^k/(k + 1) x^k)$, also $a_k = 3^k\/(k+1)$, $x_0 = 0$.
  $ |a_k/a_(k+1)| = 3^k/(k + 1) dot (k + 2)/3^(k+1) = (k + 2)/(3(k + 1)) -> 1/3. $
  Also $rho = 1\/3$: konvergent für $|x| < 1\/3$, divergent für $|x| > 1\/3$.

  *Randpunkte* (die Vorlage lässt sie weg, in Prüfungen werden sie oft gefragt):
  - $x = 1\/3$: $display(sum 3^k/(k+1) dot 1/3^k = sum 1/(k + 1))$, die harmonische Reihe. Divergent.
  - $x = -1\/3$: $display(sum (-1)^k/(k + 1))$, alternierend mit fallender Nullfolge. Konvergent nach Leibniz.
  Konvergenzbereich: $[-1\/3, 1\/3)$.
]

#fehler[Bei Reihen, in denen nur jede zweite Potenz vorkommt (z. B. $sum x^(2k) \/ 4^k$), ist $a_(k+1)$ in der Formel nicht der nächste vorhandene Koeffizient. Am sichersten wendet man dann das Quotientenkriterium direkt auf die ganzen Glieder an: $|x^(2k+2)\/4^(k+1) dot 4^k\/x^(2k)| = |x|^2\/4 < 1 <=> |x| < 2$.]

#satz[Rechnen mit Potenzreihen][Innerhalb des Konvergenzradius darf man Potenzreihen gliedweise ableiten und integrieren. Der Konvergenzradius bleibt dabei gleich:
$ dif/(dif x) sum a_k x^k = sum k a_k x^(k-1), wide integral_0^x sum a_k t^k dif t = sum a_k/(k+1) x^(k+1). $]

#bsp[Neue Reihen aus der geometrischen Reihe][
  - Ableiten von $sum x^k = 1\/(1 - x)$ gibt $display(sum_(k=1)^oo k x^(k-1) = 1/(1-x)^2)$.
  - $x -> -x$: $display(1/(1 + x) = sum (-1)^k x^k)$. Integrieren: $display(ln(1 + x) = sum_(k=1)^oo (-1)^(k+1) x^k/k)$.
  - $x -> -x^2$: $display(1/(1 + x^2) = sum (-1)^k x^(2k))$. Integrieren: $display(arctan x = sum_(k=0)^oo (-1)^k x^(2k+1)/(2k+1))$.
  Alle mit $rho = 1$. Mit $x = 1$ (Randpunkt, Leibniz) folgt daraus sogar $1 - 1\/3 + 1\/5 - dots = pi\/4$.
]

== Taylorpolynome und Taylorreihen

=== Ableitungen bestimmen die Koeffizienten

#idee[Welches Polynom vom Grad $n$ passt am besten zu $f$ in der Nähe von $x_0$? Die Antwort: das Polynom, das mit $f$ im Punkt $x_0$ übereinstimmt *und* dieselbe Steigung, dieselbe Krümmung und so weiter bis zur $n$-ten Ableitung hat.]

Für $P(x) = a_0 + a_1 x + a_2 x^2 + dots + a_n x^n$ (Entwicklung um $0$) gilt:
$ P(0) = a_0, quad P'(0) = a_1, quad P''(0) = 2 a_2, quad P'''(0) = 3 dot 2 dot a_3, quad dots, quad P^((k))(0) = k! a_k. $
Jeder Koeffizient bestimmt genau eine Ableitung im Entwicklungspunkt. Fordert man $P^((k))(0) = f^((k))(0)$, so folgt
$ a_k = (f^((k))(0))/k!. $

=== Taylorpolynom

#defn[Taylorpolynom vom Grad $n$ um $x_0$][
  $ P_n (x) = sum_(k=0)^n (f^((k))(x_0))/k! (x - x_0)^k = f(x_0) + f'(x_0)(x - x_0) + (f''(x_0))/2! (x - x_0)^2 + dots + (f^((n))(x_0))/n! (x - x_0)^n $
  $P_1$ ist die Tangente, $P_2$ die Schmiegparabel.
]

#fg("a05_exp", [$e^x$ und seine Taylorpolynome um $0$. Alle gehen durch $(0, 1)$, und jedes weitere Glied verbessert die Näherung.], w: 56%)

#rezept[Taylorpolynom berechnen][
  + Ableitungen $f, f', f'', dots, f^((n))$ bestimmen.
  + Im Entwicklungspunkt $x_0$ auswerten.
  + Durch $k!$ teilen und mit $(x - x_0)^k$ multiplizieren.
  + *Oft schneller:* bekannte Reihen einsetzen, multiplizieren, substituieren (siehe unten). Ableiten ist bei Produkten und Verkettungen sehr fehleranfällig.
]

#bsp[$P_2$ von $sqrt(x)$ um $x_0 = 4$][
  $f(4) = 2$. $f'(x) = 1/(2 sqrt(x))$, $f'(4) = 1\/4$. $f''(x) = -1/(4 x^(3\/2))$, $f''(4) = -1\/32$.
  $ P_2(x) = 2 + 1/4 (x - 4) - 1/64 (x - 4)^2. $
  *Anwendung:* $sqrt(4.2) approx 2 + 0.05 - 0.000625 = 2.049375$. Der exakte Wert ist $2.049390 dots$
]

=== Restglied: Wie gut ist die Näherung?

#satz[Taylorformel mit Restglied nach Lagrange][Ist $f$ $(n+1)$-mal differenzierbar, so gilt $f(x) = P_n (x) + R_n (x)$ mit
$ R_n (x) = (f^((n+1))(xi))/(n + 1)! (x - x_0)^(n+1) $
für ein $xi$ zwischen $x_0$ und $x$.]

#intu[Das Restglied sieht aus wie das nächste Glied der Reihe, nur wird die Ableitung an einer unbekannten Zwischenstelle $xi$ ausgewertet. Für $n = 0$ ist das genau der Mittelwertsatz. Um den Fehler abzuschätzen, setzt man für $|f^((n+1))(xi)|$ den grössten Wert ein, den die Ableitung zwischen $x_0$ und $x$ haben kann.]

#bsp[Fehlerabschätzung][
  Wie genau ist $e^(0.1) approx P_2(0.1) = 1 + 0.1 + 0.005 = 1.105$?
  $ |R_2| = (e^xi)/3! dot 0.1^3 quad "mit" 0 < xi < 0.1, quad "also" |R_2| <= e^(0.1)/6 dot 0.001 < 3/6 dot 0.001 = 0.0005. $
  (Wir haben $e^(0.1) < 3$ grob abgeschätzt.) Der wahre Fehler ist $1.10517 - 1.105 = 0.00017$.
]

=== Taylorreihe

#defn[Taylorreihe][Das «Taylorpolynom vom Grad unendlich»:
$ f(x) = sum_(k=0)^oo (f^((k))(x_0))/k! (x - x_0)^k. $
Sie stellt $f$ dort dar, wo sie konvergiert und das Restglied gegen $0$ geht. Bei allen Funktionen in dieser Vorlesung ist das innerhalb des Konvergenzradius der Fall.]

#formel[Die wichtigsten Taylorreihen (um $x_0 = 0$)][
  #table(columns: (1fr, auto), stroke: none, inset: (x: 4pt, y: 5pt),
    [$display(e^x = sum_(k=0)^oo x^k/k! = 1 + x + x^2/2! + x^3/3! + dots)$], [$x in RR$],
    [$display(sin x = sum_(k=0)^oo (-1)^k x^(2k+1)/(2k+1)! = x - x^3/3! + x^5/5! - dots)$], [$x in RR$],
    [$display(cos x = sum_(k=0)^oo (-1)^k x^(2k)/(2k)! = 1 - x^2/2! + x^4/4! - dots)$], [$x in RR$],
    [$display(sinh x = x + x^3/3! + x^5/5! + dots), quad display(cosh x = 1 + x^2/2! + x^4/4! + dots)$], [$x in RR$],
    [$display(1/(1 - x) = sum_(k=0)^oo x^k = 1 + x + x^2 + dots)$], [$|x| < 1$],
    [$display(ln(1 + x) = sum_(k=1)^oo (-1)^(k+1) x^k/k = x - x^2/2 + x^3/3 - dots)$], [$-1 < x <= 1$],
    [$display(arctan x = sum_(k=0)^oo (-1)^k x^(2k+1)/(2k+1) = x - x^3/3 + x^5/5 - dots)$], [$|x| <= 1$],
    [$display((1 + x)^alpha = sum_(k=0)^oo binom(alpha, k) x^k = 1 + alpha x + (alpha(alpha - 1))/2! x^2 + dots)$], [$|x| < 1$],
  )
]

#merke[*Symmetrie:* Bei einer ungeraden Funktion ($sin$, $tan$, $arctan$, $sinh$) fehlen alle geraden Potenzen, bei einer geraden Funktion ($cos$, $cosh$) alle ungeraden (Entwicklung um $0$). Das ist eine schnelle Kontrolle.]

=== Taylorreihen mit bekannten Reihen

#trick[Nicht ableiten, sondern umformen][Man bringt die Funktion in die Form einer bekannten Reihe, meist der geometrischen $1\/(1 - q)$ oder $ln(1 + z)$, und setzt den passenden Ausdruck für $q$ bzw. $z$ ein. Das ist schneller und liefert direkt die allgemeine Formel für alle Koeffizienten.]

#bsp[$1\/(2x + 5)$ um $x_0 = -1$][
  Ziel: Form $c dot 1/(1 - q)$ mit $q$ proportional zu $(x - x_0) = (x + 1)$.
  $ 1/(2x + 5) = 1/(2(x + 1) + 3) = 1/3 dot 1/(1 + 2/3 (x + 1)) = 1/3 dot 1/(1 - q), quad q = -2/3 (x + 1). $
  Geometrische Reihe einsetzen:
  $ 1/(2x + 5) = 1/3 sum_(k=0)^oo (-2/3)^k (x + 1)^k = sum_(k=0)^oo (-2)^k/3^(k+1) (x + 1)^k. $
  *Konvergenz:* $|q| < 1 <=> |x + 1| < 3\/2$, also $rho = 3\/2$. Das ist genau der Abstand von $x_0 = -1$ zur Polstelle $x = -5\/2$.
]

#bsp[$ln x$ um $x_0 = 3$][
  Ziel: Form $ln(1 + z)$ mit $z$ proportional zu $(x - 3)$.
  $ ln x = ln(3 + (x - 3)) = ln(3 (1 + (x - 3)/3)) = ln 3 + ln(1 + (x - 3)/3). $
  Reihe von $ln(1 + z)$ mit $z = (x - 3)\/3$ einsetzen:
  $ ln x = ln 3 + sum_(k=1)^oo (-1)^(k+1) 1/k ((x - 3)/3)^k = ln 3 + (x - 3)/3 - (x - 3)^2/18 + (x - 3)^3/81 - dots $
  *Konvergenzradius* mit der Formel, $a_k = (-1)^(k+1)\/(k 3^k)$:
  $ |a_k/a_(k+1)| = ((k + 1) 3^(k+1))/(k 3^k) = 3 (k + 1)/k -> 3. $
  Also $rho = 3$, Konvergenz für $|x - 3| < 3 <=> 0 < x < 6$. (Am rechten Rand $x = 6$ konvergiert die Reihe sogar noch, nach Leibniz.)
  #align(center, image("figs/a05_ln.svg", width: 72%))
  Im Bild sieht man es: Innerhalb von $(0, 6)$ schmiegen sich die Polynome immer besser an $ln x$. Ausserhalb laufen sie weg, egal wie hoch der Grad ist.
]

#trick[Konvergenzradius ohne Rechnung][In den allermeisten Fällen ist der Konvergenzradius der *Abstand vom Entwicklungspunkt zur nächsten Stelle, an der $f$ «kaputt» ist*: Polstelle, Definitionslücke, Rand des Definitionsbereichs. Bei $ln x$ um $3$: nächste Problemstelle $x = 0$, Abstand $3$. Bei $1\/(2x + 5)$ um $-1$: Pol bei $-5\/2$, Abstand $3\/2$.

Vorsicht: Die Problemstelle kann auch komplex sein. $1\/(1 + x^2)$ ist auf ganz $RR$ harmlos, hat aber $rho = 1$ um $0$, weil der Nenner bei $x = plus.minus i$ null wird.]

#bsp[Produkte und Verkettungen][
  - $x^2 e^(-x) = x^2 (1 - x + x^2/2 - dots) = x^2 - x^3 + x^4/2 - dots$
  - $e^(-x^2) = 1 - x^2 + x^4/2! - x^6/3! + dots$ (in $e^u$ einfach $u = -x^2$ einsetzen).
  - $sin(x)\/x = 1 - x^2/3! + x^4/5! - dots$ (Reihe durch $x$ teilen). Daraus sofort $lim_(x -> 0) sin(x)\/x = 1$.
]

=== Koeffizientenvergleich

#bsp[Taylorreihe von $tan x$ um $0$][
  $tan$ abzuleiten wird schnell mühsam. Stattdessen: $tan x = sin x \/ cos x$, also $tan x dot cos x = sin x$. Da $tan$ ungerade ist, setzen wir gleich nur ungerade Potenzen an:
  $ (a_1 x + a_3 x^3 + a_5 x^5 + dots)(1 - x^2/2 + x^4/24 - dots) = x - x^3/6 + x^5/120 - dots $
  Ausmultiplizieren und Koeffizienten gleicher Potenzen vergleichen:
  - $x^1$: $a_1 = 1$.
  - $x^3$: $a_3 - a_1\/2 = -1\/6$, also $a_3 = 1\/2 - 1\/6 = 1\/3$.
  - $x^5$: $a_5 - a_3\/2 + a_1\/24 = 1\/120$, also $a_5 = 1/120 + 1/6 - 1/24 = (1 + 20 - 5)/120 = 2/15$.
  $ tan x = x + x^3/3 + (2 x^5)/15 + dots $
  (Die Vorlage setzt auch die geraden Koeffizienten an und zeigt, dass sie $0$ sind. Mit dem Symmetrie-Argument spart man diese Arbeit.)
]

=== Grenzwerte mit Taylor

#trick[Grenzwerte mit Taylorreihen][Bei Grenzwerten $x -> 0$ der Form $0\/0$ ersetzt man jede Funktion durch die ersten Glieder ihrer Taylorreihe. Was übrig bleibt, ist ein Bruch aus Polynomen, und der niedrigste Grad entscheidet. Oft viel schneller als mehrfaches l'Hôpital.]

#bsp[Grenzwerte mit Taylor][
  $ lim_(x -> 0) (x - sin x)/x^3 = lim_(x -> 0) (x - (x - x^3\/6 + x^5\/120 - dots))/x^3 = lim_(x -> 0) (x^3\/6 - x^5\/120 + dots)/x^3 = 1/6. $
  $ lim_(x -> 0) (cos x - 1 + x^2\/2)/x^4 = lim_(x -> 0) (x^4\/24 - x^6\/720 + dots)/x^4 = 1/24. $
  Mit l'Hôpital bräuchte man für den zweiten Grenzwert viermal Ableiten.
]

#rezept[Wie viele Glieder braucht man?][So viele, bis nach dem Kürzen ein Glied übrig bleibt, das nicht verschwindet. Steht im Nenner $x^4$, muss man im Zähler alle Reihen mindestens bis $x^4$ mitnehmen.]

#aufgaben()

#aufg[Konvergenz von Reihen][
  Konvergent oder divergent? (a) $display(sum_(k=1)^oo k^2/2^k)$, (b) $display(sum_(k=1)^oo (k!)/k^k)$, (c) $display(sum_(k=2)^oo (-1)^k/(ln k))$, (d) $display(sum_(k=1)^oo 1/sqrt(k^2 + 1))$.
][
  (a) Quotient: $display(((k+1)^2\/2^(k+1))/(k^2\/2^k) = 1/2 ((k+1)/k)^2 -> 1/2 < 1)$. Konvergent.

  (b) Quotient: $display(((k+1)! \/ (k+1)^(k+1))/(k! \/ k^k) = (k+1) k^k/(k+1)^(k+1) = (k/(k+1))^k = 1/(1 + 1\/k)^k -> 1/e < 1)$. Konvergent.

  (c) $1\/ln k$ ist eine monoton fallende Nullfolge. Konvergent nach Leibniz.

  (d) $1\/sqrt(k^2 + 1) >= 1\/sqrt(2k^2) = 1/(sqrt(2) k)$ für $k >= 1$. Minorante ist (ein Vielfaches der) harmonische(n) Reihe: divergent.
]

#aufg[Konvergenzbereich][
  Bestimme den Konvergenzbereich (mit Randpunkten) von $display(sum_(k=1)^oo (x - 2)^k/(k dot 5^k))$.
][
  $a_k = 1\/(k 5^k)$: $|a_k \/ a_(k+1)| = ((k+1) 5^(k+1))/(k 5^k) -> 5$. Also $rho = 5$, Konvergenz für $|x - 2| < 5 <=> -3 < x < 7$.
  - $x = 7$: $sum 5^k\/(k 5^k) = sum 1\/k$. Divergent.
  - $x = -3$: $sum (-5)^k\/(k 5^k) = sum (-1)^k\/k$. Konvergent (Leibniz).
  Konvergenzbereich $[-3, 7)$.
]

#aufg[Taylorpolynom][
  Bestimme das Taylorpolynom 3. Grades von $f(x) = e^x cos x$ um $x_0 = 0$.
][
  Reihen multiplizieren statt dreimal ableiten:
  $ (1 + x + x^2/2 + x^3/6)(1 - x^2/2) = 1 + x + (1/2 - 1/2) x^2 + (1/6 - 1/2) x^3 + dots $
  $ P_3(x) = 1 + x - x^3/3. $
]

#aufg[Taylorreihe mit bekannten Reihen][
  Bestimme die Taylorreihe von $f(x) = x\/(1 + x^2)$ um $0$ und ihren Konvergenzradius. Was ist $f^((7))(0)$?
][
  $ x/(1 + x^2) = x sum_(k=0)^oo (-x^2)^k = sum_(k=0)^oo (-1)^k x^(2k+1) = x - x^3 + x^5 - x^7 + dots $
  Konvergenz für $|x^2| < 1$, also $rho = 1$ (Pole bei $plus.minus i$).

  Der Koeffizient von $x^7$ ist $-1$ und gleichzeitig $f^((7))(0)\/7!$. Also $f^((7))(0) = -7! = -5040$. Ohne Reihe müsste man siebenmal ableiten.
]

#aufg[Grenzwert mit Taylor][
  Berechne $display(lim_(x -> 0) (e^x - 1 - ln(1 + x) - x^2)/x^3)$.
][
  $e^x - 1 = x + x^2/2 + x^3/6 + dots$ und $ln(1 + x) = x - x^2/2 + x^3/3 - dots$. Also
  $ e^x - 1 - ln(1+x) - x^2 = (x - x) + (x^2/2 + x^2/2 - x^2) + (x^3/6 - x^3/3) + dots = -x^3/6 + dots $
  Der Grenzwert ist $-1\/6$.
]

#aufg[Integral mit Reihe][
  Berechne $display(integral_0^(1\/2) e^(-x^2) dif x)$ auf drei Nachkommastellen.
][
  $e^(-x^2)$ hat keine elementare Stammfunktion, aber gliedweise integrieren geht:
  $ integral_0^(1\/2) (1 - x^2 + x^4/2 - x^6/6 + dots) dif x &= [x - x^3/3 + x^5/10 - x^7/42 + dots]_0^(1\/2) \
  &= 0.5 - 0.04167 + 0.00313 - 0.00019 + dots $
  Die Reihe alterniert mit fallenden Gliedern; der Fehler nach drei Gliedern ist kleiner als das vierte Glied $0.00019$. Also $integral approx 0.461$.
]

#kurz[
  - Nullfolge ist notwendig, nicht hinreichend: $sum 1\/k$ divergiert, $sum 1\/k^p$ konvergiert für $p > 1$.
  - Geometrische Reihe $sum x^k = 1\/(1 - x)$ für $|x| < 1$.
  - Kriterien: Vergleich, Quotient ($k!$, $c^k$), Wurzel ($(dots)^k$), Leibniz (alternierend). Bei $L = 1$ keine Aussage.
  - Potenzreihe: Konvergenzradius $rho = lim |a_k \/ a_(k+1)|$; Randpunkte einzeln prüfen.
  - Taylor: $a_k = f^((k))(x_0)\/k!$. Restglied $f^((n+1))(xi)\/(n+1)! dot (x - x_0)^(n+1)$.
  - Taylorreihen am besten aus bekannten Reihen bauen: einsetzen, multiplizieren, ableiten, integrieren.
  - $rho$ = Abstand zur nächsten (auch komplexen) Singularität.
  - Grenzwerte $x -> 0$: Taylor einsetzen, niedrigste Potenz entscheidet.
]
