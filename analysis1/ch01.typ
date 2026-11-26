#import "lib.typ": *

= Folgen, Reihen und Funktionen

#text(size: 9.5pt, style: "italic")[Vorlesung: Kapitel I. Hier legen wir die Sprache fest, mit der die ganze Analysis arbeitet: Folgen, Grenzwerte und Funktionen. Fast alles in den späteren Kapiteln (Ableitung, Integral, Reihen) ist am Ende ein Grenzwert.]

== Folgen und Reihen

#idee[Eine Folge ist eine unendliche Liste von Zahlen $a_1, a_2, a_3, dots$ Die wichtigste Frage zu einer Folge ist: _Wohin läuft sie?_ Kommen die Glieder einer festen Zahl beliebig nahe, oder wachsen sie über alle Grenzen, oder springen sie hin und her? Eine Reihe ist die Folge der aufaddierten Glieder. Bei ihr fragt man: Ergibt die unendliche Summe eine endliche Zahl?]

=== Folgen

#defn[Folge][Eine *Folge* ist eine Abbildung $NN -> RR$, $n |-> a_n$. Sie ordnet jeder natürlichen Zahl $n$ eine reelle Zahl $a_n$ zu, das *$n$-te Glied*. Man schreibt $(a_n)_(n in NN)$ oder kurz $(a_n)$.]

Eine Folge kann auf zwei Arten angegeben werden:
- *explizit:* eine Formel für $a_n$, in die man $n$ direkt einsetzt, z. B. $a_n = 2n + 1$;
- *rekursiv:* ein Startwert und eine Vorschrift, wie man aus einem (oder mehreren) Vorgängern das nächste Glied berechnet, z. B. $a_1 = 3$, $a_(n+1) = a_n + 2$.

#bsp[Explizit und rekursiv][
  Explizit $a_n = 2n + 1$ und rekursiv $a_1 = 3$, $a_(n+1) = a_n + 2$ beschreiben dieselbe Folge:
  $ a_1 = 3, quad a_2 = 5, quad a_3 = 7, quad a_4 = 9, quad dots $
  Die explizite Form ist praktischer, wenn man ein weit entferntes Glied braucht ($a_(1000) = 2001$ sofort). Die rekursive Form zeigt besser, _wie_ die Folge entsteht (immer $+2$). Für $a_(1000)$ müsste man rekursiv 999 Schritte gehen.
]

=== Reihen

#defn[Reihe, Partialsumme][Die *$n$-te Partialsumme* einer Folge $(a_k)$ ist die Summe der ersten $n$ Glieder:
$ s_n = sum_(k=1)^n a_k = a_1 + a_2 + dots + a_n. $
Die Folge $(s_n)$ der Partialsummen heisst *Reihe*. Existiert $lim_(n -> oo) s_n = S$, so schreibt man $sum_(k=1)^oo a_k = S$ und nennt die Reihe *konvergent*.]

#intu[Eine «unendliche Summe» kann man nicht ausrechnen, indem man unendlich lange addiert. Man addiert deshalb immer nur endlich viele Glieder, schaut, wohin diese Zwischensummen laufen, und _definiert_ den Wert der Reihe als diesen Grenzwert.]

#bsp[Die Reihe $sum 1\/2^k$][
  #grid(columns: (1fr, 4.2cm), column-gutter: 12pt, align: horizon,
  [
    Zur Folge $a_k = 1 \/ 2^k$ gehört die Reihe
    $ sum_(k=1)^oo 1/2^k = 1/2 + 1/4 + 1/8 + dots $
    Die Partialsummen sind
    $ s_1 = 1/2, quad s_2 = 3/4, quad s_3 = 7/8, quad dots, quad s_n = 1 - 1/2^n. $
    Es fehlt immer genau $1\/2^n$ bis zur $1$, und dieser Rest geht gegen $0$. Also ist $sum_(k=1)^oo 1\/2^k = 1$.

    Das Bild rechts zeigt es: Ein Quadrat mit Fläche $1$ wird immer wieder halbiert. Die Stücke $1\/2, 1\/4, 1\/8, dots$ füllen das ganze Quadrat aus.
  ],
  image("figs/a01_geomquadrat.svg", width: 100%))
]

#alltag[*Achilles und die Schildkröte.* Der griechische Philosoph Zenon behauptete, Achilles könne eine Schildkröte mit Vorsprung nie einholen: Bis er an ihrem Startpunkt ist, ist sie schon ein Stück weiter, bis er dort ist, wieder ein Stück, und so unendlich oft. Die Auflösung ist eine konvergente Reihe. Läuft Achilles zehnmal so schnell und hat die Schildkröte 10 m Vorsprung, braucht er für die unendlich vielen Teilstrecken $10 + 1 + 0.1 + dots = 10\/(1 - 0.1) approx 11.1$ m. Unendlich viele Schritte, aber eine endliche Strecke und eine endliche Zeit.]

=== Monotonie und Beschränktheit

#defn[Monotonie einer Folge][
  #table(columns: (auto, auto, auto), stroke: none, inset: (x: 6pt, y: 3pt),
    [monoton wachsend], [$a_(n+1) >= a_n$], [für alle $n$],
    [streng monoton wachsend], [$a_(n+1) > a_n$], [für alle $n$],
    [monoton fallend], [$a_(n+1) <= a_n$], [für alle $n$],
    [streng monoton fallend], [$a_(n+1) < a_n$], [für alle $n$])
]

#rezept[Monotonie nachweisen][
  + Differenz bilden: $a_(n+1) - a_n$. Ist sie für alle $n$ $>= 0$, wächst die Folge.
  + Bei positiven Gliedern mit Produkten oder Potenzen ist der Quotient oft einfacher: $a_(n+1) \/ a_n >= 1$ heisst wachsend.
  + Bei expliziter Formel $a_n = f(n)$: Ist die Funktion $f$ auf $[1, oo)$ monoton (Ableitung!), so ist es auch die Folge.
]

#defn[Beschränktheit][Eine Folge heisst *nach oben beschränkt*, wenn es eine Zahl $M$ gibt mit $a_n <= M$ für alle $n$. Sie heisst *nach unten beschränkt*, wenn es ein $m$ gibt mit $a_n >= m$ für alle $n$. Ist sie beides, heisst sie *beschränkt*: $|a_n| <= C$ für alle $n$.]

=== Konvergenz und Grenzwert

Was heisst «$a_n$ kommt $L$ beliebig nahe» genau? Die Vorlage schreibt nur $lim_(n -> oo) a_n = L$. Die genaue Definition ist kurz, und wer sie einmal als Bild verstanden hat, versteht alle späteren Grenzwerte.

#defn[Grenzwert einer Folge][Die Folge $(a_n)$ *konvergiert* gegen $L$, wenn es zu jeder noch so kleinen Toleranz $epsilon > 0$ eine Stelle $N$ gibt, ab der alle Glieder näher als $epsilon$ bei $L$ liegen:
$ forall epsilon > 0 quad exists N quad forall n >= N: quad |a_n - L| < epsilon. $
Man schreibt $lim_(n -> oo) a_n = L$ oder $a_n -> L$. Eine Folge ohne Grenzwert heisst *divergent*. Eine Folge mit Grenzwert $0$ heisst *Nullfolge*.]

#fg("a01_epsilon", [Der $epsilon$-Schlauch. Wie schmal man den grünen Streifen um $L$ auch wählt, ab einer Stelle $N$ liegen alle weiteren Glieder darin (rot). Davor (blau) darf die Folge machen, was sie will.], w: 88%)

#intu[Stell dir ein Spiel vor. Dein Gegner nennt eine Toleranz $epsilon$, etwa $0.001$. Du musst eine Stelle $N$ angeben, ab der _alle_ Glieder in den Streifen $(L - epsilon, L + epsilon)$ fallen. Konvergenz heisst: Du gewinnst dieses Spiel für jedes $epsilon$, das der Gegner nennt. Je kleiner $epsilon$, desto grösser wird in der Regel dein $N$.]

#alltag[Die $epsilon$-Definition ist genau das, was in jeder technischen Zeichnung steht: «Bohrung $10 plus.minus 0.01$ mm». Der Kunde gibt die Toleranz $epsilon$ vor, und die Fertigung muss zeigen, dass sie ab einem bestimmten Punkt (nach dem Einfahren der Maschine, also ab $N$) jedes Teil innerhalb dieser Toleranz liefert. Ein Prozess «konvergiert», wenn er jede noch so enge Toleranz irgendwann einhalten kann.]

#bsp[Nachweis mit $epsilon$: $a_n = 1\/n -> 0$][
  Gegeben sei $epsilon > 0$. Wir wollen $|1\/n - 0| = 1\/n < epsilon$. Das gilt genau dann, wenn $n > 1\/epsilon$. Wähle also $N$ als eine natürliche Zahl grösser als $1 \/ epsilon$. Für $epsilon = 0.001$ ist das $N = 1001$. Damit ist $1\/n -> 0$ bewiesen.
]

Wenn die Glieder über jede Schranke wachsen ($forall M space exists N space forall n >= N: a_n > M$), schreibt man $lim a_n = oo$ und sagt, die Folge *divergiert bestimmt* gegen $oo$. Das ist trotzdem Divergenz: $oo$ ist keine Zahl.

==== Wie hängen Konvergenz, Beschränktheit und Monotonie zusammen?

#satz[Zusammenhänge][
  + *Konvergent $=>$ beschränkt.* Ab $N$ liegen alle Glieder im Streifen um $L$; davor gibt es nur endlich viele, und die haben ein grösstes und ein kleinstes.
  + *Monoton und beschränkt $=>$ konvergent.* Eine wachsende Folge, die nie über $M$ kommt, muss sich irgendwo «stauen».
  + *Unbeschränkt $=>$ divergent.* Das ist einfach die Umkehrung von 1.
]

#merke[Die Umkehrungen sind *falsch*. Diese zwei Beispiele solltest du für die Prüfung parat haben:
- Konvergent, aber nicht monoton: $a_n = (-1)^n \/ n$ springt hin und her und geht trotzdem gegen $0$.
- Beschränkt, aber divergent: $a_n = (-1)^n$ bleibt zwischen $-1$ und $1$, springt aber für immer zwischen beiden Werten.]

#fgs(("a01_folge_alt", "a01_folge_pm1"), [Links konvergent, aber nicht monoton. Rechts beschränkt, aber divergent.])

=== Grenzwerte von Folgen berechnen

#satz[Rechenregeln für Grenzwerte][Existieren $lim a_n = A$ und $lim b_n = B$ (als endliche Zahlen), dann gilt
$ lim (a_n plus.minus b_n) = A plus.minus B, quad lim (c dot a_n) = c dot A, quad lim (a_n dot b_n) = A dot B, quad lim a_n / b_n = A / B quad (B != 0). $
Ausserdem darf man den Grenzwert in stetige Funktionen hineinziehen: $lim sqrt(a_n) = sqrt(A)$, $lim e^(a_n) = e^A$ usw.]

#fehler[Die Regeln gelten nur, wenn beide Grenzwerte _endlich_ existieren. Bei den *unbestimmten Formen*
$ oo - oo, quad 0 dot oo, quad oo / oo, quad 0 / 0, quad 1^oo, quad 0^0, quad oo^0 $
kann alles herauskommen. Beispiel: $n - n = 0 -> 0$, aber $n^2 - n -> oo$, obwohl beide Male «$oo - oo$» dasteht. Bei einer unbestimmten Form muss man immer erst umformen.]

#trick[Brüche: durch die höchste Potenz teilen][
  Bei Brüchen aus Polynomen in $n$ teilt man Zähler und Nenner durch die *höchste Potenz des Nenners*. Danach gehen alle Terme der Form $c\/n^k$ gegen $0$, und es bleibt ein bestimmter Ausdruck stehen.
]

#intu[Warum das funktioniert: Für grosse $n$ ist in $7n^3 + 5$ der Summand $5$ völlig bedeutungslos, der Ausdruck ist praktisch $7n^3$. Nur der _führende Term_ zählt. Das Teilen ist die saubere Art, das hinzuschreiben.]

#bsp[Bruch kürzen 1: Zählergrad kleiner][
  $ lim_(n -> oo) (7n^2 + 5)/(2n^3) = lim_(n -> oo) (7/n + 5/n^3)/2 = (0 + 0)/2 = 0. $
  Wir haben durch $n^3$ geteilt (höchste Potenz im Nenner). Faustregel: Ist der Zählergrad kleiner als der Nennergrad, ist der Grenzwert $0$.
]

#bsp[Bruch kürzen 2: gleicher Grad][
  $ lim_(n -> oo) (7n^3 + 5)/(2n^3) = lim_(n -> oo) (7 + 5/n^3)/2 = 7/2. $
  Bei gleichem Grad ist der Grenzwert das Verhältnis der Leitkoeffizienten. Ist der Zählergrad grösser, divergiert der Bruch gegen $plus.minus oo$.
]

#trick[Wurzeln: mit der 3. binomischen Formel erweitern][
  Bei Differenzen mit Wurzeln (Form $oo - oo$ oder $0 dot oo$) erweitert man mit der «Gegen-Summe», damit $(a - b)(a + b) = a^2 - b^2$ die Wurzel verschwinden lässt.
]

#bsp[Wurzeln erweitern][
  Gesucht ist $lim_(n -> oo) n (sqrt(1 + 1/n) - 1)$. Einsetzen gibt $oo dot 0$, also unbestimmt. Erweitern mit $sqrt(1 + 1\/n) + 1$:
  $ n (sqrt(1 + 1/n) - 1) dot (sqrt(1 + 1/n) + 1)/(sqrt(1 + 1/n) + 1) = n ((1 + 1/n) - 1)/(sqrt(1 + 1/n) + 1) = (n dot 1/n)/(sqrt(1 + 1/n) + 1) = 1/(sqrt(1 + 1/n) + 1). $
  Jetzt ist alles bestimmt: Für $n -> oo$ geht der Nenner gegen $sqrt(1) + 1 = 2$. Der Grenzwert ist $1\/2$.
]

#satz[Einschliessungskriterium (Sandwich)][Gilt $b_n <= a_n <= c_n$ für alle $n$ ab einer Stelle, und haben $(b_n)$ und $(c_n)$ denselben Grenzwert $L$, dann gilt auch $a_n -> L$.]

#bsp[Sandwich mit Sinus][
  $a_n = sin(n) \/ n$. Der Sinus springt unregelmässig, aber er bleibt zwischen $-1$ und $1$:
  $ -1/n <= sin(n)/n <= 1/n. $
  Beide Schranken gehen gegen $0$, also auch $sin(n)\/n -> 0$. Merke: *beschränkt mal Nullfolge ist Nullfolge.*
]

#formel[Standardgrenzwerte von Folgen][
  #table(columns: (1fr, 1fr), stroke: none, inset: (x: 4pt, y: 4pt),
    [$display(lim_(n -> oo) 1/n^alpha = 0) quad (alpha > 0)$], [$display(lim_(n -> oo) q^n = 0) quad (|q| < 1)$],
    [$display(lim_(n -> oo) root(n, n) = 1)$], [$display(lim_(n -> oo) root(n, a) = 1) quad (a > 0)$],
    [$display(lim_(n -> oo) (1 + 1/n)^n = e)$], [$display(lim_(n -> oo) (1 + x/n)^n = e^x)$],
    [$display(lim_(n -> oo) n^k / q^n = 0) quad (q > 1)$], [$display(lim_(n -> oo) q^n / n! = 0)$],
  )
  Die letzte Zeile ist eine Rangliste des Wachstums: $ln n << n^k << q^n << n! << n^n$.
]

=== Arithmetische Folgen und Reihen

#defn[Arithmetische Folge][Die Differenz benachbarter Glieder ist konstant, $a_(n+1) - a_n = d$. Explizit: $a_n = a_1 + (n-1) d$.]

#satz[Arithmetische Reihe][
  $ s_n = sum_(k=1)^n (a_1 + (k-1) d) = n dot (a_1 + a_n)/2, wide "speziell" quad sum_(k=1)^n k = 1 + 2 + dots + n = (n(n+1))/2. $
]

#warum[Der Trick des jungen Gauss][Schreibe die Summe einmal vorwärts und einmal rückwärts untereinander:
$ s_n &= a_1 &+ a_2 &+ dots &+ a_n \
  s_n &= a_n &+ a_(n-1) &+ dots &+ a_1 $
Jede Spalte ergibt dasselbe, nämlich $a_1 + a_n$ (geht man oben einen Schritt nach rechts, kommt $d$ dazu, unten geht $d$ weg). Es gibt $n$ Spalten, also $2 s_n = n (a_1 + a_n)$. In Worten: *Anzahl Glieder mal Mittelwert von erstem und letztem Glied.*]

#bsp[Umformung einer arithmetischen Reihe][
  Gesucht ist $sum_(k=2)^5 3k$. Die Schwierigkeit: Die Summe beginnt bei $k = 2$, die Formel braucht aber erstes Glied, letztes Glied und Anzahl.
  - Erstes Glied: $a_1 = 3 dot 2 = 6$. Letztes Glied: $3 dot 5 = 15$.
  - Anzahl Glieder: $k = 2, 3, 4, 5$, also $n = 5 - 2 + 1 = 4$. (Häufiger Fehler: $5 - 2 = 3$.)
  - Differenz $d = 3$.
  $ sum_(k=2)^5 3k = 4 dot (6 + 15)/2 = 42. $
  Kontrolle: $6 + 9 + 12 + 15 = 42$. #h(1fr)
]

#alltag[Arithmetische Folgen sind alles, was jeden Tag (Monat, Stockwerk) um denselben Betrag wächst: ein Sparplan mit fixem Betrag ohne Zins, die Höhe der Stufen einer Treppe, ein Stapel Rohre oder Baumstämme, bei dem jede Lage ein Stück weniger hat. Wie viele Stämme liegen in einem Stapel mit 12 unten und 1 oben? $12 dot (12 + 1)\/2 = 78$.]

=== Geometrische Folgen und Reihen

#defn[Geometrische Folge][Der Quotient benachbarter Glieder ist konstant, $a_(n+1) = q dot a_n$. Explizit $a_n = a_1 q^(n-1)$ (oder $a_n = a_0 q^n$, wenn man bei $n = 0$ zu zählen beginnt).]

#satz[Geometrische Reihe][
  $ s_n = sum_(k=1)^n a_1 q^(k-1) = a_1 (1 - q^n)/(1 - q) quad (q != 1), wide sum_(k=1)^oo a_1 q^(k-1) = a_1/(1 - q) quad "für" |q| < 1. $
  Für $|q| >= 1$ divergiert die unendliche Reihe (ausser $a_1 = 0$).
]

#warum[Multiplizieren und abziehen][
  $ s_n &= a_1 + a_1 q + a_1 q^2 + dots + a_1 q^(n-1) \
  q s_n &= quad quad a_1 q + a_1 q^2 + dots + a_1 q^(n-1) + a_1 q^n $
  Zieht man die zweite Zeile von der ersten ab, fällt fast alles weg: $(1 - q) s_n = a_1 - a_1 q^n$. Teilen durch $1 - q$ gibt die Formel. Für $|q| < 1$ geht $q^n -> 0$, und es bleibt $a_1\/(1-q)$.
]

#merke[Formel in Worten: *erstes Glied durch (1 minus Quotient).* Bei Summen, die nicht bei $k = 1$ beginnen, nie die Indizes umrechnen, sondern einfach das erste Glied hinschreiben. Beispiel: $sum_(k=3)^oo (1/2)^k = (1\/8)/(1 - 1\/2) = 1/4$.]

#bsp[Unendliche geometrische Reihe][
  $a_n = 24 dot (1/2)^(n-1)$: die Glieder $24, 12, 6, 3, dots$ mit $q = 1\/2$.
  $ s_4 = 24 + 12 + 6 + 3 = 45, wide s_oo = 24 dot 1/(1 - 1/2) = 48. $
  Probe mit der Formel für $s_4$: $24 (1 - 1\/16)\/(1\/2) = 48 dot 15\/16 = 45$. #h(1fr)
]

#alltag[
  - *Springender Ball.* Ein Ball fällt aus 2 m Höhe und springt jedes Mal auf 60 % der vorherigen Höhe zurück. Welche Strecke legt er insgesamt zurück? Herunter 2 m, dann jeweils hinauf und wieder hinunter: $2 + 2 (1.2 + 0.72 + dots) = 2 + 2 dot 1.2\/(1 - 0.6) = 8$ m. Unendlich viele Sprünge, aber nur 8 m.
  - *Medikamentenspiegel.* Wer täglich 100 mg eines Medikaments nimmt, von dem der Körper pro Tag die Hälfte abbaut, hat nach der $n$-ten Dosis $100 (1 + 1\/2 + 1\/4 + dots + 1\/2^(n-1))$ mg im Körper. Der Spiegel steigt nicht endlos, sondern nähert sich $100\/(1 - 1\/2) = 200$ mg. Genau so legt man Dosierungen fest.
  - *Zinseszins und Leasing.* Raten, Renten und Kredite werden mit der Formel $a_1 (1 - q^n)\/(1 - q)$ berechnet; $q$ ist dort der Zinsfaktor $1 + p$.
]

#formel[Weitere nützliche Summen][
  $ sum_(k=1)^n k^2 = (n(n+1)(2n+1))/6, wide sum_(k=1)^n k^3 = ((n(n+1))/2)^2 = (sum_(k=1)^n k)^2. $
]

== Funktionen

=== Definition

#idee[Eine Funktion ist eine eindeutige Zuordnung: Jedem erlaubten Input wird _genau ein_ Output zugeordnet. Die meiste Arbeit bei «Bestimme $D$ und $W$» besteht darin herauszufinden, welche Inputs erlaubt sind und welche Outputs überhaupt vorkommen.]

#defn[Funktion][Eine *Funktion* $f: A -> B$, $x |-> f(x)$ ordnet jedem Element $x$ der Menge $A$ *genau ein* Element $f(x)$ der Menge $B$ zu.
- *Definitionsbereich* $D$: alle $x$, die man einsetzen darf.
- *Wertebereich* $W$ (Bild): alle Werte $f(x)$, die tatsächlich herauskommen.]

#intu[Eine Funktion ist wie ein Getränkeautomat: Du drückst eine Taste ($x$) und bekommst ein Getränk ($f(x)$). Eine Taste darf nie zwei verschiedene Getränke liefern, sonst wäre der Automat kaputt. Zwei Tasten dürfen aber dasselbe Getränk liefern, und manche Getränke im Sortiment gibt es vielleicht gar nicht zu kaufen. Der Definitionsbereich sind die Tasten, die funktionieren; der Wertebereich die Getränke, die tatsächlich herauskommen.]

#fg("a01_abbildung", [Eine Funktion. Von jedem $x in D$ geht genau ein Pfeil aus. Zwei Pfeile dürfen im selben Ziel enden ($b$ und $c$), und nicht jedes Element der Zielmenge muss getroffen werden ($3$).], w: 62%)

#merke[«Genau ein Pfeil pro $x$» ist die ganze Definition. Ein Kreis $x^2 + y^2 = 1$ ist deshalb _kein_ Graph einer Funktion $y = f(x)$: Zu $x = 0$ gehören zwei Werte $y = plus.minus 1$. *Vertikaler-Linien-Test:* Jede senkrechte Gerade schneidet den Graphen einer Funktion höchstens einmal.]

#rezept[Definitionsbereich bestimmen][
  Suche alle Stellen, an denen ein Ausdruck nicht erlaubt ist, und nimm sie heraus:
  + *Nenner* $!= 0$.
  + *Gerade Wurzeln* $sqrt(dots)$, $root(4, dots)$: Argument $>= 0$.
  + *Logarithmus* $ln(dots)$: Argument $> 0$.
  + $tan x$: $x != pi\/2 + k pi$. $arcsin$, $arccos$: Argument in $[-1, 1]$.
  Alle Bedingungen gelten gleichzeitig.
]

#rezept[Wertebereich bestimmen][
  Der Wertebereich ist meist schwieriger. Bewährte Wege:
  + *Graph skizzieren* und ablesen.
  + *Verhalten an den Rändern* des Definitionsbereichs und an Definitionslücken untersuchen (Grenzwerte).
  + *Extremwerte* mit der Ableitung bestimmen (Kapitel 2).
  + Oder rechnerisch: Für welche $y$ hat die Gleichung $y = f(x)$ eine Lösung $x in D$?
]

#bsp[$D$ und $W$ von $f(x) = 1\/(x - 3)$][
  #grid(columns: (1fr, 6.2cm), column-gutter: 12pt, align: horizon,
  [
    - *$D$:* Nenner $x - 3 != 0$, also $D = RR without {3}$.
    - *$W$:* Ein Bruch $1\/(dots)$ kann jeden Wert annehmen ausser $0$, denn der Zähler ist $1 != 0$. Rechnerisch: $y = 1\/(x-3) <=> x = 3 + 1\/y$, lösbar für jedes $y != 0$.
    $ W = RR without {0}. $
  ],
  image("figs/a01_dw1.svg", width: 100%))
]

#bsp[$D$ und $W$ von $g(x) = (x - 15)\/(sqrt(x) - 4)$][
  *Definitionsbereich.* Die Wurzel verlangt $x >= 0$, der Nenner $sqrt(x) != 4$, also $x != 16$:
  $ D = RR_0^+ without {16}. $
  *Wertebereich.* Hier lohnt eine Substitution. Setze $u = sqrt(x) - 4$, also $sqrt(x) = u + 4$ mit $u >= -4$, $u != 0$. Dann ist $x = (u + 4)^2$ und
  $ g = ((u+4)^2 - 15)/u = (u^2 + 8u + 1)/u = u + 1/u + 8. $
  - Für $u > 0$ ist $u + 1\/u >= 2$ (Minimum bei $u = 1$, also $x = 25$). Also $g >= 10$, und für $u -> 0^+$ oder $u -> oo$ geht $g -> oo$. Werte: $[10, oo)$.
  - Für $-4 <= u < 0$ ist $u + 1\/u <= -2$ (Maximum bei $u = -1$, also $x = 9$). Also $g <= 6$. Für $u -> 0^-$ geht $g -> -oo$. Werte: $(-oo, 6]$.
  $ W = (-oo, 6] union [10, oo) = RR without (6, 10). $
  #align(center, image("figs/a01_dw2.svg", width: 62%))
  Im Bild sieht man es: Der linke Ast erreicht höchstens $6$ (bei $x = 9$), der rechte Ast fällt nie unter $10$ (bei $x = 25$). Der rote Streifen dazwischen wird nie getroffen.
]

=== Wichtige Funktionen

==== Potenzfunktionen

$ f(x) = a dot x^r, quad r in RR. $
Für ganzzahlige $r >= 0$ ist $D = RR$. Für negative $r$ muss $x != 0$ sein, für gebrochene $r$ (Wurzeln) meist $x >= 0$.

#fg("a01_potenz", [Potenzfunktionen. Alle gehen durch $(1, 1)$. Gerade Potenzen sind symmetrisch zur $y$-Achse, ungerade punktsymmetrisch zum Ursprung.], w: 60%)

#formel[Potenz- und Wurzelregeln ($a, b > 0$)][
  #table(columns: (1fr, 1fr, 1fr), stroke: none, inset: (x: 4pt, y: 4pt),
    [$a^m dot a^n = a^(m+n)$], [$a^m / a^n = a^(m-n)$], [$(a^m)^n = a^(m n)$],
    [$a^n dot b^n = (a b)^n$], [$a^n / b^n = (a/b)^n$], [$a^(-n) = 1/a^n$],
    [$root(n, a^m) = a^(m\/n)$], [$root(n, a) dot root(n, b) = root(n, a b)$], [$root(m, root(n, a)) = root(m n, a)$],
  )
]

#fehler[$(a + b)^2 != a^2 + b^2$ und $sqrt(a + b) != sqrt(a) + sqrt(b)$. Potenzen und Wurzeln vertragen sich mit Produkten, nie mit Summen. Ebenso: $sqrt(x^2) = |x|$, nicht $x$.]

==== Polynome

$ p(x) = a_0 + a_1 x + a_2 x^2 + dots + a_n x^n, quad a_n != 0. $
$n$ heisst *Grad*, $a_n$ *Leitkoeffizient*. Ein Polynom vom Grad $n$ hat höchstens $n$ reelle Nullstellen. Ist $x_1$ eine Nullstelle, kann man den Faktor $(x - x_1)$ abspalten (Polynomdivision). Über $CC$ zerfällt jedes Polynom ganz in Linearfaktoren (Kapitel 3):
$ p(x) = a_n (x - x_1)(x - x_2) dots (x - x_n). $

#fg("a01_poly", [Polynome vom Grad 2, 3 und 4. Für $|x| -> oo$ bestimmt allein der höchste Term $a_n x^n$, wohin der Graph geht.], w: 62%)

#merke[Verhalten für $x -> plus.minus oo$: Nur $a_n x^n$ zählt. Gerader Grad: beide Enden gehen in dieselbe Richtung. Ungerader Grad: die Enden gehen in entgegengesetzte Richtungen, und deshalb hat ein Polynom ungeraden Grades immer mindestens eine reelle Nullstelle.]

==== Rationale Funktionen

$ f(x) = p(x) / q(x), quad p, q "Polynome", quad D = {x : q(x) != 0}. $
An Nullstellen des Nenners entstehen *Polstellen* (der Graph schiesst nach $plus.minus oo$), ausser die Nullstelle kürzt sich mit einer des Zählers weg (*hebbare Lücke*). Für $x -> plus.minus oo$ verhält sich $f$ wie der Quotient der führenden Terme (Abschnitt 1.6).

#fg("a01_rational", [Zwei rationale Funktionen. $(x-2)\/(x+1)$ hat einen Pol bei $x = -1$ und nähert sich für $x -> plus.minus oo$ der Geraden $y = 1$. $4\/(x^2+1)$ hat keinen Pol, weil der Nenner nie $0$ wird.], w: 60%)

==== Trigonometrische Funktionen

#grid(columns: (4.6cm, 1fr), column-gutter: 14pt, align: horizon,
  image("figs/a01_einheitskreis.svg", width: 100%),
  [Am *Einheitskreis* sind $cos phi$ und $sin phi$ die Koordinaten des Punktes, der zum Winkel $phi$ gehört. Daraus folgt sofort alles Wichtige: $sin^2 + cos^2 = 1$ (Pythagoras), $|sin|, |cos| <= 1$, und beide sind $2 pi$-periodisch (eine Runde). Winkel werden in der Analysis immer im *Bogenmass* gemessen: $180 degree = pi$.])

#fg("a01_sincos", [$sin x$ und $cos x$. Der Kosinus ist der um $pi\/2$ nach links verschobene Sinus: $cos x = sin(x + pi\/2)$.], w: 82%)

#formel[Werte, die man kennen muss][
  #align(center, table(columns: 6, stroke: (x, y) => if y == 0 { (bottom: 0.5pt) }, inset: (x: 8pt, y: 4pt), align: center,
    [$x$], [$0$], [$pi\/6$], [$pi\/4$], [$pi\/3$], [$pi\/2$],
    [$sin x$], [$0$], [$1\/2$], [$sqrt(2)\/2$], [$sqrt(3)\/2$], [$1$],
    [$cos x$], [$1$], [$sqrt(3)\/2$], [$sqrt(2)\/2$], [$1\/2$], [$0$],
    [$tan x$], [$0$], [$sqrt(3)\/3$], [$1$], [$sqrt(3)$], [--]))
  Eselsbrücke: $sin = sqrt(0)\/2, sqrt(1)\/2, sqrt(2)\/2, sqrt(3)\/2, sqrt(4)\/2$; der Kosinus ist dieselbe Liste rückwärts.
]

#formel[Identitäten][
  #table(columns: (1fr, 1fr), stroke: none, inset: (x: 4pt, y: 3pt),
    [$sin^2 x + cos^2 x = 1$], [$tan x = sin x \/ cos x$],
    [$sin(-x) = -sin x$ (ungerade)], [$cos(-x) = cos x$ (gerade)],
    [$sin(x + y) = sin x cos y + cos x sin y$], [$cos(x + y) = cos x cos y - sin x sin y$],
    [$sin(2x) = 2 sin x cos x$], [$cos(2x) = cos^2 x - sin^2 x$],
    [$cos^2 x = (1 + cos 2x)\/2$], [$sin^2 x = (1 - cos 2x)\/2$],
  )
  Mit der Eulerformel (Kapitel 3): $sin x = 1/(2i) (e^(i x) - e^(-i x))$, $cos x = 1/2 (e^(i x) + e^(-i x))$.
]

#trick[Additionstheoreme nicht auswendig lernen][Wer $e^(i x) = cos x + i sin x$ kennt, kann sie jederzeit herleiten: $e^(i(x+y)) = e^(i x) e^(i y)$ ausmultiplizieren und Real- und Imaginärteil vergleichen. Das kommt in Kapitel 3.]

#alltag[Sinus und Kosinus beschreiben alles, was schwingt oder sich dreht: Der Strom aus der Steckdose ist $230 sqrt(2) sin(2 pi dot 50 t)$ Volt; ein Ton ist eine Schwingung des Luftdrucks (der Kammerton a hat 440 Schwingungen pro Sekunde); die Höhe eines Punktes auf einem Riesenrad, Ebbe und Flut, die Tageslänge über das Jahr. Jede periodische Bewegung lässt sich aus Sinus- und Kosinusschwingungen zusammensetzen (Fourier), und darauf beruhen MP3 und JPEG.]

==== Hyperbolische Funktionen

$ sinh x = (e^x - e^(-x))/2, quad cosh x = (e^x + e^(-x))/2, quad tanh x = (sinh x)/(cosh x). $

#grid(columns: (1fr, 6.2cm), column-gutter: 12pt, align: horizon,
  [
    *Woher der Name?* Für Sinus und Kosinus gilt $cos^2 + sin^2 = 1$: Der Punkt $(cos t, sin t)$ liegt auf dem Kreis. Für die hyperbolischen Funktionen gilt
    $ cosh^2 x - sinh^2 x = 1, $
    also liegt $(cosh t, sinh t)$ auf der *Hyperbel* $x^2 - y^2 = 1$. Daher der Name.

    $cosh$ ist gerade und hat sein Minimum $1$ bei $x = 0$. Er beschreibt die Form einer durchhängenden Kette (Kettenlinie). $sinh$ ist ungerade und streng wachsend. $tanh$ läuft von $-1$ nach $1$.
  ],
  image("figs/a01_hyp.svg", width: 100%))

#alltag[Eine Kette, ein Stromkabel zwischen zwei Masten oder ein Seilbahnseil hängt *nicht* als Parabel durch, sondern als Kosinus hyperbolicus, $y = a cosh(x\/a)$, die *Kettenlinie*. Dreht man die Form um, erhält man einen Bogen, in dem nur Druck und keine Biegung herrscht. Deshalb hat der Gateway Arch in St. Louis diese Form, und Gaudí hat seine Gewölbe mit hängenden Ketten entworfen.]

#formel[Identitäten der hyperbolischen Funktionen][
  #table(columns: (1fr, 1fr), stroke: none, inset: (x: 4pt, y: 3pt),
    [$cosh^2 x - sinh^2 x = 1$], [$sinh(-x) = -sinh x, quad cosh(-x) = cosh x$],
    [$sinh(x+y) = sinh x cosh y + cosh x sinh y$], [$cosh(x+y) = cosh x cosh y + sinh x sinh y$],
    [$arsinh x = ln(x + sqrt(x^2 + 1))$], [$arcosh x = ln(x + sqrt(x^2 - 1)), quad x >= 1$],
  )
  Merkhilfe: Die Formeln sehen aus wie die trigonometrischen, nur mit anderen Vorzeichen bei Termen mit zwei $sinh$.
]

#warum[$arsinh x = ln(x + sqrt(x^2 + 1))$][
  Löse $y = sinh x = (e^x - e^(-x))\/2$ nach $x$ auf. Mit $u = e^x > 0$: $2y = u - 1\/u$, also $u^2 - 2 y u - 1 = 0$ und $u = y plus.minus sqrt(y^2 + 1)$. Weil $u > 0$ sein muss, gilt nur das Plus. Also $x = ln u = ln(y + sqrt(y^2+1))$.
]

==== Exponential- und Logarithmusfunktion

$ f(x) = a^x = e^(x ln a), wide log_a x = (ln x)/(ln a). $
Der natürliche Logarithmus $ln$ ist die Umkehrfunktion von $e^x$: $e^(ln x) = x$ für $x > 0$ und $ln(e^x) = x$ für alle $x$.

#grid(columns: (5.6cm, 1fr), column-gutter: 14pt, align: horizon,
  image("figs/a01_explog.svg", width: 100%),
  [
    #formel[Logarithmusregeln][
      $ ln(x y) = ln x + ln y $
      $ ln(x / y) = ln x - ln y $
      $ ln(x^b) = b ln x $
      $ ln 1 = 0, quad ln e = 1 $
    ]
    $e^x$ ist überall positiv und wächst schneller als jede Potenz. $ln x$ existiert nur für $x > 0$ und wächst langsamer als jede Potenz. Die Graphen sind Spiegelbilder an $y = x$.
  ])

#alltag[
  - *Exponentielles Wachstum und Zerfall:* Bakterien, die sich alle 20 Minuten teilen; Zinseszins; radioaktiver Zerfall (C-14 hat eine Halbwertszeit von 5730 Jahren, daraus bestimmt man das Alter von Funden); ein heisser Kaffee, dessen Temperaturunterschied zum Raum exponentiell abnimmt.
  - *Logarithmische Skalen* machen riesige Bereiche handlich, weil der Logarithmus Faktoren in Summanden verwandelt: Dezibel (plus 10 dB heisst zehnfache Schallleistung, plus 3 dB etwa doppelte), der pH-Wert ($-log_(10)$ der Säurekonzentration), die Richterskala bei Erdbeben, Blendenzahlen bei Kameras.
  - *Faustregel 72:* Bei $p$ % Zins verdoppelt sich ein Kapital in etwa $72\/p$ Jahren. Grund: Verdopplung heisst $(1 + p\/100)^n = 2$, also $n = ln 2 \/ ln(1 + p\/100) approx 0.69 dot 100\/p$, mit der Näherung $ln(1 + x) approx x$ aus Kapitel 2.
]

#fehler[$ln(x + y) != ln x + ln y$. Und $ln(x)^2$ ist mehrdeutig: $(ln x)^2 != ln(x^2) = 2 ln x$. Klammern setzen!]

=== Eigenschaften von Funktionen

==== Gerade und ungerade Funktionen

#defn[Symmetrie][
  $f$ heisst *gerade*, wenn $f(-x) = f(x)$ für alle $x$: Der Graph ist spiegelsymmetrisch zur $y$-Achse.\
  $f$ heisst *ungerade*, wenn $f(-x) = -f(x)$ für alle $x$: Der Graph ist punktsymmetrisch zum Ursprung.
]

#fgs(("a01_gerade", "a01_ungerade"), [Links gerade: $f(-x) = f(x)$, die beiden roten Punkte liegen gleich hoch. Rechts ungerade: $f(-x) = -f(x)$, die Punkte liegen gleich weit oben und unten.])

#bsp[Gerade oder ungerade?][
  - $f(x) = x^2$: $f(-x) = (-x)^2 = x^2 = f(x)$, also gerade.
  - $f(x) = x^3$: $f(-x) = (-x)^3 = -x^3 = -f(x)$, also ungerade.
  - $f(x) = x^2 + x$: $f(-x) = x^2 - x$. Das ist weder $f(x)$ noch $-f(x)$, also weder gerade noch ungerade. Die meisten Funktionen sind weder noch.
]

#merke[Produktregeln für Symmetrie: gerade · gerade = gerade, ungerade · ungerade = gerade, gerade · ungerade = ungerade. Beispiel: $x sin x$ ist gerade. Nützlich bei Integralen (Kapitel 4) und Taylorreihen (Kapitel 5): Über ein symmetrisches Intervall $[-a, a]$ ist das Integral einer ungeraden Funktion null.]

==== Monotonie

#defn[Monotonie einer Funktion][Für alle $x_1 < x_2$ im betrachteten Intervall gilt:
#table(columns: (auto, auto), stroke: none, inset: (x: 6pt, y: 3pt),
  [monoton wachsend], [$f(x_1) <= f(x_2)$],
  [streng monoton wachsend], [$f(x_1) < f(x_2)$],
  [monoton fallend], [$f(x_1) >= f(x_2)$],
  [streng monoton fallend], [$f(x_1) > f(x_2)$])]

#text(size: 9pt, style: "italic")[Korrektur gegenüber der Vorlage: Dort sind die Ungleichungszeichen bei «wachsend» und «fallend» vertauscht.]

Für differenzierbare Funktionen prüft man Monotonie mit der Ableitung: $f' >= 0$ auf einem Intervall heisst wachsend, $f' > 0$ streng wachsend (Kapitel 2).

== Grenzwerte von Funktionen und Stetigkeit

=== Grenzwerte von Funktionen

#idee[Bei Folgen läuft $n$ gegen $oo$. Bei Funktionen kann $x$ gegen eine beliebige Stelle $a$ laufen, von links oder von rechts, oder gegen $plus.minus oo$. Gefragt ist immer: Welchem Wert nähert sich $f(x)$? Der Wert $f(a)$ selbst spielt dabei keine Rolle, er muss nicht einmal existieren.]

#defn[Grenzwert einer Funktion][$lim_(x -> a) f(x) = L$ heisst: Für _jede_ Folge $x_n -> a$ mit $x_n != a$ gilt $f(x_n) -> L$. Gleichwertig: Zu jedem $epsilon > 0$ gibt es ein $delta > 0$ mit $|f(x) - L| < epsilon$, sobald $0 < |x - a| < delta$.

Lässt man nur $x > a$ zu, erhält man den *rechtsseitigen Grenzwert* $lim_(x -> a^+) f(x)$, mit $x < a$ den *linksseitigen* $lim_(x -> a^-) f(x)$. Der Grenzwert existiert genau dann, wenn beide einseitigen Grenzwerte existieren und gleich sind.]

Es gelten *dieselben Rechenregeln wie bei Folgen*, mit denselben unbestimmten Formen.

=== Wichtige Grenzwerte

#formel[Grundlegende Grenzwerte][
  $ lim_(x -> oo) 1/x = 0, quad lim_(x -> 0^+) 1/x = +oo, quad lim_(x -> 0^-) 1/x = -oo, quad lim_(x -> 0^+) ln x = -oo $
]

#formel[Trigonometrische Grenzwerte][
  $ lim_(x -> 0) (sin x)/x = 1, quad lim_(x -> 0) x/(sin x) = 1, quad lim_(x -> 0) (sin(a x))/x = a, quad lim_(x -> 0) (1 - cos x)/x^2 = 1/2 $
]

#warum[$sin x \/ x -> 1$][
  Für kleine Winkel ist der Bogen $x$ auf dem Einheitskreis fast gleich lang wie die Höhe $sin x$; der Unterschied ist von höherer Ordnung klein. Genauer zeigt man am Einheitskreis die Ungleichung $cos x <= sin(x)\/x <= 1$ für kleine $x > 0$ und wendet das Sandwich-Kriterium an: Beide Schranken gehen gegen $1$. Mit Taylor (Kapitel 5) sieht man es sofort: $sin x = x - x^3\/6 + dots$, also $sin(x)\/x = 1 - x^2\/6 + dots -> 1$.
]

#formel[Wachstum im Vergleich ($a, m > 0$)][
  $ lim_(x -> oo) e^(m x)/x^a = oo, quad lim_(x -> oo) x^a/e^(m x) = 0, quad lim_(x -> oo) (ln x)/x^a = 0, quad lim_(x -> oo) x^a/(ln x) = oo, quad lim_(x -> 0^+) x^a ln x = 0 $
  *Merke:* $e^x$ wächst schneller als jede Potenz, $ln x$ langsamer als jede Potenz.
]

#formel[Die Zahl $e$][
  $ lim_(x -> oo) (1 + 1/x)^x = e, quad lim_(x -> oo) (1 - 1/x)^x = 1/e, quad lim_(x -> oo) (1 + a/x)^x = e^a, quad lim_(x -> 0) (e^x - 1)/x = 1, quad lim_(x -> 0) (ln(1 + x))/x = 1 $
]

#intu[$(1 + 1\/n)^n$ ist Zinseszins: Ein Franken wird zu 100 % Jahreszins angelegt, aber der Zins wird $n$-mal im Jahr anteilig gutgeschrieben. Bei $n = 1$ hat man Ende Jahr 2 Franken, bei $n = 12$ schon 2.61, bei täglicher Gutschrift 2.71. Mehr als $e approx 2.718$ wird es nie, auch bei «stetiger» Verzinsung nicht.]

=== Grenzwerte berechnen

#rezept[Grenzwert einer Funktion][
  + *Einsetzen.* Kommt eine Zahl heraus (oder $c\/0$ mit $c != 0$, dann $plus.minus oo$ mit Vorzeichen prüfen), ist man fertig.
  + *Unbestimmte Form $0\/0$ oder $oo\/oo$?* Dann Bernoulli–de l'Hôpital (Abschnitt 2.1.5) oder umformen.
  + *Umformen* ohne l'Hôpital:
    - Bruch: durch die höchste Potenz teilen;
    - Bruch mit gemeinsamer Nullstelle: faktorisieren und kürzen;
    - Wurzeln: mit der 3. binomischen Formel erweitern;
    - Standardgrenzwerte wie $sin(x)\/x -> 1$ herausarbeiten;
    - Formen $1^oo$, $0^0$, $oo^0$: mit $f^g = e^(g ln f)$ umschreiben und den Exponenten untersuchen.
  + *Taylor* (Kapitel 5) ist bei hartnäckigen Fällen oft der schnellste Weg.
]

#bsp[Durch die höchste Potenz teilen][
  $ lim_(x -> oo) (7x^3 + 5)/(2x^3) = lim_(x -> oo) (7 + 5/x^3)/2 = 7/2 $
]

#bsp[Faktorisieren und kürzen][
  Einsetzen von $x = 2$ in $(x^2 + x - 6)\/(x - 2)$ gibt $0\/0$. Also hat der Zähler auch die Nullstelle $2$, und man kann $(x - 2)$ abspalten:
  $ lim_(x -> 2) (x^2 + x - 6)/(x - 2) = lim_(x -> 2) ((x - 2)(x + 3))/(x - 2) = lim_(x -> 2) (x + 3) = 5. $
  Kürzen ist erlaubt, weil beim Grenzwert $x != 2$ ist.
]

#bsp[Mit der 3. binomischen Formel][
  $ lim_(x -> 7) (sqrt(x + 2) - 3)/(x - 7) = lim_(x -> 7) ((sqrt(x+2) - 3)(sqrt(x+2) + 3))/((x - 7)(sqrt(x+2) + 3)) = lim_(x -> 7) ((x+2) - 9)/((x-7)(sqrt(x+2) + 3)) = lim_(x -> 7) 1/(sqrt(x+2) + 3) = 1/6. $
  Der Faktor $x - 7$ hat sich weggekürzt, danach ist Einsetzen möglich.
]

#bsp[Form $1^oo$][
  $lim_(x -> oo) (1 + 2/x)^(3x)$. Umschreiben: $(1 + 2/x)^(3x) = ((1 + 2/x)^x)^3 -> (e^2)^3 = e^6$. Allgemein hilft $f^g = e^(g ln f)$: Hier ist $g ln f = 3x ln(1 + 2\/x)$, und mit $ln(1 + u) approx u$ für kleine $u$ geht das gegen $3x dot 2\/x = 6$.
]

=== Stetigkeit

#idee[Eine stetige Funktion kann man zeichnen, ohne den Stift abzusetzen. Mathematisch: Was der Graph «ankündigt», wenn man sich einer Stelle nähert, ist auch der tatsächliche Funktionswert dort.]

#defn[Stetigkeit][$f$ heisst *stetig in $c$*, wenn $f(c)$ definiert ist und
$ lim_(x -> c^-) f(x) = f(c) = lim_(x -> c^+) f(x). $
$f$ heisst *stetig*, wenn $f$ in jedem Punkt ihres Definitionsbereichs stetig ist.]

Drei Dinge müssen also stimmen: Der Funktionswert existiert, der Grenzwert existiert (links = rechts), und beide sind gleich.

#bsp[Stetig: $f(x) = x^2$ bei $x = 1$][
  $lim_(x -> 1^-) x^2 = 1$, $lim_(x -> 1^+) x^2 = 1$ und $f(1) = 1$. Alle drei stimmen überein, $f$ ist stetig in $1$. Allgemein sind Polynome, $e^x$, $sin$, $cos$ überall stetig, und Summen, Produkte, Quotienten (wo der Nenner $!= 0$) und Verkettungen stetiger Funktionen sind wieder stetig.
]

#bsp[Nicht stetig: Sprung][
  #grid(columns: (1fr, 5.6cm), column-gutter: 12pt, align: horizon,
  [
    $ g(x) = cases(-1 & "für" x < 0, 1 & "für" x >= 0) $
    $lim_(x -> 0^-) g(x) = -1$, aber $lim_(x -> 0^+) g(x) = 1$. Die einseitigen Grenzwerte sind verschieden, also existiert $lim_(x -> 0) g(x)$ nicht, und $g$ ist bei $0$ nicht stetig. Dass $g(0) = 1$ definiert ist, hilft nicht.
  ],
  image("figs/a01_sprung.svg", width: 100%))
]

#merke[Arten von Unstetigkeiten:
- *Sprungstelle:* beide einseitigen Grenzwerte existieren, sind aber verschieden.
- *Polstelle:* mindestens ein einseitiger Grenzwert ist $plus.minus oo$ (z. B. $1\/x$ bei $0$).
- *Hebbare Unstetigkeit:* der Grenzwert existiert, aber $f(c)$ fehlt oder ist falsch. Beispiel: $sin(x)\/x$ ist bei $0$ nicht definiert, aber mit $f(0) := 1$ wird die Funktion stetig.
- *Oszillation:* $sin(1\/x)$ bei $0$ schwankt immer schneller, kein Grenzwert.]

#alltag[Unstetige Funktionen sind im Alltag häufiger, als man denkt: Das Porto eines Briefes springt bei 100 g auf den nächsten Tarif, ein Billett kostet ab einer Zone mehr, ein Schalter ist an oder aus. Physikalische Grössen wie Temperatur, Ort oder Druck ändern sich dagegen stetig. Darum funktioniert der Zwischenwertsatz in der Natur so gut.]

=== Was stetige Funktionen können

#satz[Zwischenwertsatz][Ist $f$ stetig auf $[a, b]$ und liegt $c$ zwischen $f(a)$ und $f(b)$, dann gibt es (mindestens) ein $x in [a, b]$ mit $f(x) = c$.

Spezialfall *Nullstellensatz*: Haben $f(a)$ und $f(b)$ verschiedene Vorzeichen, so hat $f$ in $(a, b)$ eine Nullstelle.]

#fg("a01_zws", [Zwischenwertsatz: Wer stetig von $f(a)$ unten nach $f(b)$ oben läuft, muss die Höhe $c$ dazwischen mindestens einmal kreuzen. Hier sogar dreimal.], w: 58%)

#bsp[Existenz einer Lösung][
  Hat $x^5 + x = 1$ eine reelle Lösung? Setze $f(x) = x^5 + x - 1$. Es ist $f(0) = -1 < 0$ und $f(1) = 1 > 0$. $f$ ist stetig (Polynom), also gibt es nach dem Nullstellensatz ein $x in (0, 1)$ mit $f(x) = 0$. Da $f'(x) = 5x^4 + 1 > 0$, ist $f$ streng wachsend, und die Lösung ist sogar eindeutig.
]

#alltag[
  - *Der wackelnde Tisch.* Ein Tisch mit vier gleich langen Beinen wackelt auf unebenem Boden. Dreht man ihn um seine Mitte, steht er irgendwann (spätestens nach einer Vierteldrehung) auf allen vier Beinen. Der Grund ist der Zwischenwertsatz: Man betrachtet, wie weit ein Bein über dem Boden schwebt, als stetige Funktion des Drehwinkels; diese wechselt beim Drehen das Vorzeichen, also hat sie dazwischen eine Nullstelle.
  - *Die Bergwanderung.* Du steigst am Samstag von 8 bis 16 Uhr auf einen Berg und am Sonntag auf demselben Weg von 8 bis 16 Uhr hinunter. Dann gibt es eine Uhrzeit, zu der du an beiden Tagen an genau derselben Stelle warst. (Stell dir beide Wanderungen gleichzeitig vor: Die beiden Personen müssen sich begegnen.)
]

#satz[Satz vom Maximum und Minimum][Eine stetige Funktion auf einem *abgeschlossenen und beschränkten* Intervall $[a, b]$ nimmt dort ein Maximum und ein Minimum an.]

#merke[Beide Voraussetzungen sind nötig. $f(x) = 1\/x$ auf $(0, 1]$ hat kein Maximum (Intervall nicht abgeschlossen), $f(x) = x$ auf $[0, oo)$ auch nicht (nicht beschränkt). Auf $[a, b]$ dagegen ist das Maximum garantiert, und man findet es mit dem Rezept aus Abschnitt 2.2.]

== Transformationen von Graphen

#idee[Aus dem Graphen von $f$ entstehen durch einfache Änderungen der Formel verschobene, gespiegelte und gestreckte Graphen. Wer die sieben Regeln kennt, kann viele Funktionen skizzieren, ohne eine Wertetabelle zu machen. Als Beispiel dient immer $f(x) = 2x^3 - 3x^2 - 6x + 6$ (grau).]

#formel[Die Regeln auf einen Blick][
  #table(columns: (auto, 1fr), stroke: none, inset: (x: 5pt, y: 3.5pt),
    [$-f(x)$], [Spiegelung an der $x$-Achse],
    [$f(-x)$], [Spiegelung an der $y$-Achse],
    [$f(x + a)$], [Verschiebung um $a$ nach *links* ($a > 0$)],
    [$f(x) + b$], [Verschiebung um $b$ nach oben],
    [$f(c x)$], [Stauchung in $x$-Richtung um den Faktor $c$ ($c > 1$), Streckung für $0 < c < 1$],
    [$d dot f(x)$], [Streckung in $y$-Richtung ($d > 1$), Stauchung für $0 < d < 1$],
    [$1 \/ f(x)$], [Kehrwert: Nullstellen werden zu Polen, Pole zu Nullstellen],
  )
]

#merke[*Was innen steht, wirkt umgekehrt.* Änderungen _am Argument_ ($x + a$, $c x$, $-x$) wirken auf die $x$-Richtung, und zwar «verkehrt herum»: $f(x + 2)$ verschiebt nach _links_, $f(2x)$ _staucht_. Der Grund: $f(x + 2)$ erreicht den Wert, den $f$ bei $x = 0$ hat, schon bei $x = -2$. Änderungen _aussen_ ($+ b$, $d dot$) wirken direkt und intuitiv auf die $y$-Richtung.]

#figure(grid(columns: 4, column-gutter: 6pt, row-gutter: 8pt,
  image("figs/a01_t_spx.svg"), image("figs/a01_t_spy.svg"), image("figs/a01_t_vx.svg"), image("figs/a01_t_vy.svg"),
  image("figs/a01_t_sx.svg"), image("figs/a01_t_dx.svg"), image("figs/a01_t_dy.svg"), image("figs/a01_t_kw.svg")),
  caption: [Die sieben Transformationen am Beispiel $f(x) = 2x^3 - 3x^2 - 6x + 6$ (grau). Beim Kehrwert (unten rechts) entsteht an jeder Nullstelle von $f$ eine Polstelle, und wo $f$ gross ist, ist $1\/f$ nahe bei $0$.])

#alltag[In der Audiotechnik sind das alltägliche Operationen an einem Signal $f(t)$: $d dot f(t)$ ist Lautstärke aufdrehen, $f(t - a)$ ist eine Verzögerung (Echo, Delay), $f(2t)$ spielt die Aufnahme doppelt so schnell ab (alles eine Oktave höher, der «Mickey-Mouse-Effekt»), $f(-t)$ spielt sie rückwärts ab. Auch die Umrechnung Celsius in Fahrenheit, $F = 1.8 C + 32$, ist eine Streckung mit anschliessender Verschiebung.]

#bsp[Ausgeschrieben][
  Mit $f_1(x) = 2x^3 - 3x^2 - 6x + 6$:
  - $f_1(x + 2) = 2(x+2)^3 - 3(x+2)^2 - 6(x+2) + 6$: Überall $x$ durch $(x + 2)$ ersetzen, nicht nur beim ersten Term.
  - $f_1(-x) = 2(-x)^3 - 3(-x)^2 - 6(-x) + 6 = -2x^3 - 3x^2 + 6x + 6$.
  - $2 f_1(x) = 4x^3 - 6x^2 - 12x + 12$: Jeder Term wird verdoppelt.
]

#rezept[Mehrere Transformationen nacheinander][
  Für $g(x) = d dot f(c(x + a)) + b$ in dieser Reihenfolge vorgehen: erst in $x$-Richtung verschieben ($a$), dann in $x$-Richtung stauchen ($c$, bezogen auf die verschobene Achse), dann in $y$-Richtung strecken ($d$), zuletzt nach oben verschieben ($b$). Achtung: $f(2x + 4) = f(2(x + 2))$ ist um $2$ nach links verschoben, nicht um $4$!
]

== Injektiv, surjektiv, bijektiv

#idee[Diese drei Wörter beantworten die Frage: Kann man eine Funktion rückgängig machen? Dazu muss jeder Output von genau einem Input kommen. «Injektiv» kümmert sich um «höchstens einer», «surjektiv» um «mindestens einer».]

#intu[*Der Kinosaal.* Die Besucher sind $D$, die Sitzplätze $W$, und $f$ ordnet jedem Besucher seinen Platz zu.
- *Injektiv:* Nie sitzen zwei Besucher auf demselben Platz.
- *Surjektiv:* Kein Platz bleibt leer.
- *Bijektiv:* ausverkauft, und jeder sitzt allein. Nur dann kann man umgekehrt von jedem Platz eindeutig auf seinen Besucher schliessen; das ist die Umkehrfunktion.]

=== Surjektiv

#grid(columns: (1fr, 4.2cm), column-gutter: 12pt, align: horizon,
  defn[Surjektiv][$f: D -> W$ heisst *surjektiv*, wenn jedes Element von $W$ *mindestens einmal* getroffen wird:
  $ forall y in W space exists x in D: quad f(x) = y. $],
  image("figs/a01_m_surj.svg", width: 100%))

#bsp[Surjektivität hängt von der Zielmenge ab][
  #grid(columns: (1fr, 5.4cm), column-gutter: 12pt, align: horizon,
  [
    - $f: RR -> RR$, $f(x) = x$ ist surjektiv: Zu jedem $y$ ist $x = y$ ein Urbild.
    - $g: RR -> RR$, $g(x) = x^2$ ist *nicht* surjektiv: $y = -1.3$ wird nie erreicht, weil $x^2 >= 0$.
    - Aber $g: RR -> RR_0^+$, $g(x) = x^2$ _ist_ surjektiv. Gleiche Formel, andere Zielmenge!
  ],
  image("figs/a01_g_surj.svg", width: 100%))
]

=== Injektiv

#grid(columns: (1fr, 4.2cm), column-gutter: 12pt, align: horizon,
  defn[Injektiv][$f$ heisst *injektiv*, wenn jedes Element von $W$ *höchstens einmal* getroffen wird. Verschiedene Inputs geben verschiedene Outputs:
  $ x_1 != x_2 => f(x_1) != f(x_2). $
  Gleichwertig (und zum Beweisen praktischer): $f(x_1) = f(x_2) => x_1 = x_2$.],
  image("figs/a01_m_inj.svg", width: 100%))

#merke[*Horizontaler-Linien-Test:* $f$ ist injektiv genau dann, wenn jede waagrechte Gerade den Graphen höchstens einmal schneidet. Und: *Jede streng monotone Funktion ist injektiv.* Das ist meist der schnellste Nachweis: Ableitung $> 0$ (oder $< 0$) auf dem ganzen Intervall.]

#bsp[Injektiv oder nicht?][
  #grid(columns: (1fr, 5.4cm), column-gutter: 12pt, align: horizon,
  [
    - $f(x) = x^3$ ist injektiv: Die grüne Linie schneidet den blauen Graphen nur einmal. Beweis: $x_1^3 = x_2^3 => x_1 = x_2$ (dritte Wurzel ist eindeutig).
    - $g(x) = x^2$ auf $RR$ ist nicht injektiv: $g(-sqrt(2)) = g(sqrt(2)) = 2$, zwei rote Punkte auf derselben Höhe.
  ],
  image("figs/a01_g_inj.svg", width: 100%))
]

=== Bijektiv

#grid(columns: (1fr, 4.2cm), column-gutter: 12pt, align: horizon,
  defn[Bijektiv][$f$ heisst *bijektiv*, wenn jedes Element von $W$ *genau einmal* getroffen wird, also wenn $f$ injektiv _und_ surjektiv ist.],
  image("figs/a01_m_bij.svg", width: 100%))

#satz[Bijektiv heisst umkehrbar][$f: D -> W$ besitzt genau dann eine Umkehrfunktion $f^(-1): W -> D$, wenn $f$ bijektiv ist. Durch Einschränken von $D$ (macht injektiv) und Wahl von $W$ als Bild (macht surjektiv) kann man jede Funktion bijektiv machen.]

#bsp[Bijektiv durch Einschränken][
  - $f: RR_0^+ -> RR_0^+$, $f(x) = x^2$ ist bijektiv. Auf $x >= 0$ ist $x^2$ streng wachsend (injektiv), und jedes $y >= 0$ hat das Urbild $sqrt(y)$ (surjektiv). Umkehrfunktion: $f^(-1)(y) = sqrt(y)$.
  - $g: RR_0^+ -> RR_0^+$, $g(x) = sin x$ ist weder injektiv (z. B. $sin 0 = sin pi$) noch surjektiv (Werte $> 1$ und negative Werte fehlen bzw. liegen ausserhalb der Zielmenge).
]

=== Umkehrfunktionen

#defn[Umkehrfunktion][Ist $f: D -> W$ bijektiv, so ist $f^(-1): W -> D$ die Funktion, die jedem $y$ sein eindeutiges Urbild zuordnet:
$ f^(-1)(f(x)) = x quad (forall x in D), wide f(f^(-1)(y)) = y quad (forall y in W). $]

#merke[*Geometrisch* ist der Graph von $f^(-1)$ das Spiegelbild des Graphen von $f$ an der Winkelhalbierenden $y = x$. Liegt $(a, b)$ auf $f$, dann liegt $(b, a)$ auf $f^(-1)$. Definitions- und Wertebereich tauschen die Rollen.]

#fehler[$f^(-1)(x)$ bedeutet die Umkehrfunktion, *nicht* $1\/f(x)$. Insbesondere ist $sin^(-1) x = arcsin x$, nicht $1\/sin x$.]

#alltag[Jedes Messgerät benutzt eine Umkehrfunktion. Ein Temperatursensor liefert eine Spannung $U = f(T)$; angezeigt werden soll aber $T = f^(-1)(U)$. Das geht nur, wenn $f$ im Messbereich streng monoton ist, sonst gehörten zu einer Spannung zwei Temperaturen. Auch Verschlüsselung muss bijektiv sein, sonst kann man nicht eindeutig entschlüsseln. Passwörter speichert man dagegen absichtlich mit einer Funktion, die man praktisch nicht umkehren kann (Hashfunktion).]

#rezept[Umkehrfunktion bestimmen][
  + *Bijektivität sicherstellen:* nötigenfalls $D$ einschränken (auf ein Intervall, auf dem $f$ streng monoton ist) und $W$ als Bild wählen.
  + *Gleichung aufstellen:* $y = f(x)$.
  + *Nach $x$ auflösen:* $x = g(y)$. Bei mehreren Lösungen (z. B. $plus.minus$) diejenige wählen, die in $D$ liegt.
  + *Variablen tauschen:* $f^(-1)(x) = g(x)$.
]

#bsp[Ganzrationale Funktion $f(x) = x^3 - 1$][
  #grid(columns: (1fr, 5.6cm), column-gutter: 12pt, align: horizon,
  [
    *Bijektiv?* Injektiv: $f'(x) = 3x^2 >= 0$ und nur in einem Punkt $0$, also streng wachsend. Surjektiv: $f(x) -> plus.minus oo$ für $x -> plus.minus oo$, und $f$ ist stetig, also wird nach dem Zwischenwertsatz jedes $y in RR$ erreicht. Also $f: RR -> RR$ bijektiv.

    *Auflösen:* $y = x^3 - 1 <=> x^3 = y + 1 <=> x = root(3, y + 1)$.

    *Tauschen:* $f^(-1)(x) = root(3, x + 1)$.

    Probe: $f(f^(-1)(x)) = (root(3, x+1))^3 - 1 = x$. #sym.checkmark
  ],
  image("figs/a01_umkehr1.svg", width: 100%))
]

#bsp[Sinus und Arkussinus][
  #grid(columns: (1fr, 5.6cm), column-gutter: 12pt, align: horizon,
  [
    *Problem:* $sin x$ ist auf $RR$ periodisch, also nicht injektiv.

    *Lösung:* Einschränken auf $[-pi\/2, pi\/2]$. Dort ist $sin$ streng wachsend und nimmt alle Werte in $[-1, 1]$ an:
    $ f: [-pi/2, pi/2] -> [-1, 1], quad f(x) = sin x $
    ist bijektiv. Die Umkehrfunktion heisst *Arkussinus*:
    $ f^(-1) = arcsin: [-1, 1] -> [-pi/2, pi/2]. $
    Genauso: $arccos: [-1, 1] -> [0, pi]$ und $arctan: RR -> (-pi\/2, pi\/2)$.
  ],
  image("figs/a01_umkehr2.svg", width: 100%))
]

#fehler[$arcsin(sin x) = x$ gilt nur für $x in [-pi\/2, pi\/2]$! Beispiel: $arcsin(sin pi) = arcsin 0 = 0 != pi$. Dagegen gilt $sin(arcsin y) = y$ für alle $y in [-1, 1]$.]

== Asymptoten

#idee[Eine Asymptote ist eine einfache Kurve (meist eine Gerade), an die sich der Graph immer enger anschmiegt. Sie zeigt das Verhalten «weit draussen» oder in der Nähe einer Polstelle. Beim Skizzieren sind Asymptoten das Gerüst, in das man den Graphen hineinzeichnet.]

#defn[Asymptote][$g(x)$ heisst *Asymptote* von $f(x)$ für $x -> plus.minus oo$, wenn
$ lim_(x -> plus.minus oo) (f(x) - g(x)) = 0. $
Eine *vertikale Asymptote* $x = a$ liegt vor, wenn $f(x) -> plus.minus oo$ für $x -> a^+$ oder $x -> a^-$.]

#rezept[Asymptoten einer rationalen Funktion $f = p\/q$][
  + *Vertikal:* Nullstellen des Nenners, die sich nicht mit dem Zähler wegkürzen.
  + *Grad Zähler < Grad Nenner:* waagrechte Asymptote $y = 0$.
  + *Grad Zähler = Grad Nenner:* waagrechte Asymptote $y = a_n \/ b_n$ (Verhältnis der Leitkoeffizienten).
  + *Grad Zähler > Grad Nenner:* Polynomdivision $f(x) = Q(x) + R(x)\/q(x)$ mit $deg R < deg q$. Der Rest geht gegen $0$, also ist $Q(x)$ die Asymptote: eine schiefe Gerade, wenn der Zählergrad um $1$ grösser ist, eine Parabel bei $2$ usw.
]

#bsp[Vertikal und waagrecht: $f(x) = 1\/(x - 1)$][
  Nenner null bei $x = 1$, Zähler dort $1 != 0$: vertikale Asymptote $x = 1$. Zählergrad $0$ < Nennergrad $1$: waagrechte Asymptote $y = 0$, denn $lim_(x -> plus.minus oo) 1\/(x-1) = 0$.
]

#bsp[Gleicher Grad: $f(x) = (4x^2 + 3)\/(2x^2 - 1)$][
  $ lim_(x -> plus.minus oo) (4x^2 + 3)/(2x^2 - 1) = lim_(x -> plus.minus oo) (4 + 3\/x^2)/(2 - 1\/x^2) = 4/2 = 2. $
  Waagrechte Asymptote $y = 2$. Vertikale Asymptoten bei $2x^2 - 1 = 0$, also $x = plus.minus 1\/sqrt(2)$.
]

#bsp[Zählergrad grösser: $f(x) = x^2\/(x + 1)$][
  *Polynomdivision* Schritt für Schritt:
  - $x^2 : x = x$. Zurückmultiplizieren: $x(x + 1) = x^2 + x$. Abziehen: $x^2 - (x^2 + x) = -x$.
  - $-x : x = -1$. Zurückmultiplizieren: $-1 dot (x + 1) = -x - 1$. Abziehen: $-x - (-x - 1) = 1$. Rest $1$.
  $ x^2/(x + 1) = x - 1 + 1/(x + 1). $
  Der Rest $1\/(x+1)$ geht für $x -> plus.minus oo$ gegen $0$. Also ist $g(x) = x - 1$ eine *schiefe Asymptote*. Dazu kommt die vertikale Asymptote $x = -1$.
  #align(center, image("figs/a01_asymptote.svg", width: 60%))
  Das Vorzeichen des Rests sagt sogar, von welcher Seite sich der Graph anschmiegt: Für $x -> +oo$ ist $1\/(x+1) > 0$, der Graph liegt _über_ der Asymptote; für $x -> -oo$ darunter.
]

#alltag[
  - *Fallschirmspringer:* Die Geschwindigkeit nähert sich der Endgeschwindigkeit (etwa 200 km/h ohne Schirm), bei der der Luftwiderstand das Gewicht aufhebt. Waagrechte Asymptote.
  - *Kaffee:* Seine Temperatur nähert sich der Raumtemperatur, erreicht sie aber nie ganz.
  - *Stückkosten:* Kostet eine Produktion $F$ Franken Fixkosten plus $c$ pro Stück, sind die Kosten pro Stück $F\/n + c$. Für grosse Stückzahlen nähern sie sich $c$, darunter kommt man nie.
]

#merke[Auch nicht-rationale Funktionen haben Asymptoten: $e^x$ hat $y = 0$ für $x -> -oo$, $arctan x$ hat $y = plus.minus pi\/2$, $ln x$ hat die vertikale Asymptote $x = 0$. Allgemein findet man eine schiefe Asymptote $y = m x + b$ über $m = lim f(x)\/x$ und $b = lim (f(x) - m x)$.]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Zinseszins, Hypothek und die Zweiundsiebziger-Regel.* Ein Konto mit Zinssatz $p$ wächst nach $n$ Jahren auf $K_n = K_0 (1 + p)^n$, eine geometrische Folge. Bei $2 %$ Zins verdoppelt sich das Geld nach etwa $72\/2 = 36$ Jahren; die «72er-Regel» ist die Näherung $ln 2 approx 0.69$. Eine Hypothek ist die dazugehörige geometrische Reihe: Wer $500 thin 000$ CHF zu $2 %$ über $25$ Jahre zurückzahlt, zahlt jedes Jahr $K q^n (q-1)\/(q^n - 1) approx 25 thin 600$ CHF mit $q = 1.02$. Jede Bank, jede Pensionskasse und jedes Leasing rechnet mit dieser Summenformel.]

#alltag[*Logarithmen: Dezibel, Richter und pH.* Wo Grössen über viele Zehnerpotenzen laufen, misst man den Logarithmus. $+10$ dB heisst zehnmal mehr Schallintensität, $+3$ dB ungefähr doppelt so viel; ein Presslufthammer ($approx 100$ dB) ist deshalb nicht «ein bisschen» lauter als Flüstern ($approx 30$ dB), sondern $10^7$-mal intensiver. Bei der Richterskala bedeutet eine Magnitude mehr $10 times$ grössere Bodenbewegung und rund $32 times$ mehr Energie. Ein pH-Wert um eins kleiner heisst zehnmal mehr $H^+$. Immer, wenn eine Skala logarithmisch ist, steckt diese Funktion dahinter.]

#alltag[*Wie der Taschenrechner Wurzeln zieht.* Die Folge $x_(n+1) = (x_n + 2\/x_n)\/2$ mit $x_0 = 1$ liefert $1$, $1.5$, $1.41667$, $1.414216$, also schon nach drei Schritten $sqrt(2)$ auf sechs Stellen. Sie konvergiert so schnell, dass die Zahl der richtigen Stellen sich pro Schritt etwa verdoppelt. Das ist das Newton-Verfahren, und es steckt (in Varianten) in den Grafikkarten- und Taschenrechner-Routinen für Wurzel und Kehrwert. Jedes Programm, das eine Zahl «auf Genauigkeit $epsilon$ berechnen» soll, läuft nach demselben Muster: iterieren, bis sich die Folge nicht mehr nennenswert ändert.]

#photo(("a_romanesco",), [Romanesco: Jede Spitze besteht aus kleineren Spitzen derselben Form. Selbstähnlichkeit ist das Bild einer Iteration, und die Zahl der Spiralen ist oft eine Fibonacci-Zahl. #credit[Ivar Leidus, CC BY-SA 4.0, Wikimedia Commons]], ht: 5.5cm)
// ALLTAG-END

#aufgaben()

#aufg[Grenzwerte von Folgen][
  Berechne (a) $display(lim_(n -> oo) (3n^2 - n)/(5 n^2 + 2))$, (b) $display(lim_(n -> oo) (sqrt(n^2 + n) - n))$, (c) $display(lim_(n -> oo) (1 + 3/n)^(2n))$.
][
  (a) Durch $n^2$ teilen: $(3 - 1\/n)\/(5 + 2\/n^2) -> 3\/5$.

  (b) Form $oo - oo$, also erweitern:
  $ sqrt(n^2 + n) - n = (n^2 + n - n^2)/(sqrt(n^2 + n) + n) = n/(sqrt(n^2 + n) + n) = 1/(sqrt(1 + 1\/n) + 1) -> 1/2. $
  Im letzten Schritt haben wir durch $n$ geteilt; $sqrt(n^2 + n)\/n = sqrt(1 + 1\/n)$.

  (c) $(1 + 3\/n)^(2n) = ((1 + 3\/n)^n)^2 -> (e^3)^2 = e^6$.
]

#aufg[Geometrische Reihe][
  Berechne $display(sum_(k=2)^oo 3 dot (-2/5)^k)$.
][
  Geometrische Reihe mit $q = -2\/5$, $|q| < 1$, also konvergent. Erstes Glied ($k = 2$): $3 dot 4\/25 = 12\/25$. Formel «erstes Glied durch $(1 - q)$»:
  $ sum_(k=2)^oo 3 (-2/5)^k = (12\/25)/(1 + 2\/5) = 12/25 dot 5/7 = 12/35. $
]

#aufg[Definitions- und Wertebereich][
  Bestimme den maximalen Definitionsbereich und den Wertebereich von $f(x) = ln(4 - x^2)$.
][
  *$D$:* Das Argument des Logarithmus muss positiv sein: $4 - x^2 > 0 <=> |x| < 2$, also $D = (-2, 2)$.

  *$W$:* Auf $D$ nimmt $u = 4 - x^2$ alle Werte in $(0, 4]$ an (Maximum $4$ bei $x = 0$, gegen den Rand $-> 0$). $ln$ ist streng wachsend und bildet $(0, 4]$ auf $(-oo, ln 4]$ ab. Also $W = (-oo, ln 4]$.
]

#aufg[Stetigkeit mit Parameter][
  Für welches $a$ ist $f(x) = cases((sin(3x))/x & "für" x != 0, a & "für" x = 0)$ stetig?
][
  Für $x != 0$ ist $f$ als Quotient stetiger Funktionen stetig. Bei $0$ braucht man $lim_(x -> 0) f(x) = f(0) = a$. Mit $sin(a x)\/x -> a$:
  $ lim_(x -> 0) (sin 3x)/x = 3. $
  Also muss $a = 3$ sein.
]

#aufg[Umkehrfunktion][
  Zeige, dass $f: RR -> (0, oo)$, $f(x) = e^(2x + 1)$ bijektiv ist, und bestimme $f^(-1)$.
][
  *Injektiv:* $f'(x) = 2 e^(2x+1) > 0$, also streng wachsend. *Surjektiv:* Zu jedem $y > 0$ löst $x = (ln y - 1)\/2$ die Gleichung $f(x) = y$. Also bijektiv.

  *Umkehrfunktion:* $y = e^(2x+1) <=> ln y = 2x + 1 <=> x = (ln y - 1)\/2$. Tauschen: $f^(-1)(x) = (ln x - 1)\/2$ für $x > 0$.
]

#aufg[Asymptoten][
  Bestimme alle Asymptoten von $f(x) = (2x^2 - 3x + 1)\/(x - 2)$.
][
  *Vertikal:* Nenner null bei $x = 2$; Zähler dort $8 - 6 + 1 = 3 != 0$. Also $x = 2$.

  *Schief:* Zählergrad $2$ > Nennergrad $1$, Polynomdivision:
  $(2x^2 - 3x + 1) : (x - 2) = 2x + 1$ Rest $3$, denn $(2x + 1)(x - 2) = 2x^2 - 3x - 2$ und $2x^2 - 3x + 1 - (2x^2 - 3x - 2) = 3$.
  $ f(x) = 2x + 1 + 3/(x - 2). $
  Schiefe Asymptote $y = 2x + 1$.
]

#kurz[
  - Folge konvergiert gegen $L$: ab einer Stelle bleiben alle Glieder beliebig nahe bei $L$ ($epsilon$-Schlauch).
  - Konvergent $=>$ beschränkt. Monoton und beschränkt $=>$ konvergent. Die Umkehrungen gelten nicht.
  - Unbestimmte Formen ($oo - oo$, $0 dot oo$, $0\/0$, $oo\/oo$, $1^oo$, $0^0$, $oo^0$) immer erst umformen: höchste Potenz teilen, faktorisieren, mit 3. binomischer Formel erweitern, $f^g = e^(g ln f)$.
  - Arithmetische Reihe: Anzahl mal Mittelwert. Geometrische Reihe: erstes Glied durch $(1 - q)$, falls $|q| < 1$.
  - $D$: Nenner $!= 0$, Wurzel $>= 0$, $ln > 0$. $W$: Graph, Ränder, Extrema.
  - Stetig in $c$: links-Limes = rechts-Limes = $f(c)$. Zwischenwertsatz garantiert Nullstellen bei Vorzeichenwechsel.
  - Transformationen: innen (am $x$) wirkt umgekehrt, aussen direkt.
  - Bijektiv = injektiv + surjektiv = umkehrbar. Umkehrfunktion: nach $x$ auflösen, Variablen tauschen; Graph an $y = x$ spiegeln.
  - Asymptoten rationaler Funktionen: Nennernullstellen (vertikal), Gradvergleich, Polynomdivision (schief).
]
