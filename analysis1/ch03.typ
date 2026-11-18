#import "lib.typ": *

= Komplexe Zahlen

#text(size: 9.5pt, style: "italic")[Vorlesung: Kapitel A (Anhang). Komplexe Zahlen erweitern die reelle Zahlengerade zu einer Ebene. Rechnen heisst dann: verschieben, drehen und strecken. Das macht viele Rechnungen mit Winkeln und Schwingungen einfacher und erklärt, warum jedes Polynom Nullstellen hat.]

== Komplexe Zahlen

#idee[Die Gleichung $x^2 = -1$ hat keine reelle Lösung, denn Quadrate sind nie negativ. Man führt deshalb eine neue Zahl $i$ ein, die genau diese Gleichung löst, und rechnet mit ihr wie gewohnt. Das Überraschende: Diese eine neue Zahl genügt. Mit ihr hat _jede_ Polynomgleichung eine Lösung.]

#defn[Komplexe Zahl][Eine komplexe Zahl hat die Form
$ z = x + i y, wide x, y in RR, wide i^2 = -1. $
- *Realteil:* $Re(z) = x$
- *Imaginärteil:* $Im(z) = y$ (eine reelle Zahl, _ohne_ das $i$!)
Die Menge aller komplexen Zahlen heisst $CC$. Zwei komplexe Zahlen sind gleich, wenn Real- _und_ Imaginärteil übereinstimmen.]

#intu[Eine komplexe Zahl ist ein Punkt in der Ebene, der *Gaussschen Zahlenebene*: $x$ nach rechts, $y$ nach oben. Die reellen Zahlen sind die waagrechte Achse. $i$ liegt eine Einheit über der $0$. Man kann $z$ auch als Pfeil vom Ursprung zum Punkt $(x, y)$ sehen.]

#alltag[Komplexe Zahlen sind kein Gedankenspiel, sondern Werkzeug: In der *Elektrotechnik* (wo man $j$ statt $i$ schreibt) rechnet man Wechselstromkreise mit komplexen Widerständen; eine Spule hat den Widerstand $j omega L$, ein Kondensator $1\/(j omega C)$. Ohne sie bräuchte man Differentialgleichungen, mit ihnen reicht das Ohmsche Gesetz. *Signalverarbeitung* (Handy, WLAN, MP3, JPEG), *Regelungstechnik* (Autopilot, Tempomat) und die *Quantenmechanik* sind ohne komplexe Zahlen nicht denkbar.]

=== Darstellungsformen

#grid(columns: (1fr, 5.0cm), column-gutter: 12pt, align: horizon,
  [
    Einen Punkt der Ebene kann man auf zwei Arten angeben: mit seinen Koordinaten $(x, y)$ oder mit Abstand $r$ vom Ursprung und Winkel $phi$ zur positiven reellen Achse. Daraus entstehen drei Schreibweisen:

    #table(columns: (auto, auto, auto), stroke: (x, y) => if y == 0 { (bottom: 0.5pt) }, inset: (x: 5pt, y: 4pt),
      [*Form*], [*allgemein*], [*Beispiel*],
      [kartesisch], [$x + i y$], [$3 + 4i$],
      [polar], [$r(cos phi + i sin phi)$], [$5(cos 53.13 degree + i sin 53.13 degree)$],
      [exponentiell], [$r e^(i phi)$], [$5 e^(0.93 i)$])
  ],
  image("figs/a03_ebene.svg", width: 100%))

$r = |z|$ heisst *Betrag*, $phi = arg(z)$ *Argument* von $z$. Das Argument ist nur bis auf Vielfache von $2 pi$ bestimmt: $e^(i phi) = e^(i (phi + 2 pi))$. Meist wählt man $phi in (-pi, pi]$ oder $phi in [0, 2 pi)$.

=== Die Eulerformel

#satz[Eulerformel][
  $ e^(i phi) = cos phi + i sin phi $
  Daraus folgt die Exponentialform $r(cos phi + i sin phi) = r e^(i phi)$.
]

#grid(columns: (1fr, 4.6cm), column-gutter: 12pt, align: horizon,
  [
    *Bedeutung:* $e^(i phi)$ ist der Punkt auf dem *Einheitskreis* beim Winkel $phi$. Lässt man $phi$ wachsen, läuft $e^(i phi)$ gegen den Uhrzeigersinn im Kreis. Einige Werte, die man sofort sehen sollte:
    $ e^(i 0) = 1, quad e^(i pi\/2) = i, quad e^(i pi) = -1, quad e^(i 3pi\/2) = -i, quad e^(i 2 pi) = 1. $
    Die berühmteste Formel der Mathematik ist ein Spezialfall: $e^(i pi) + 1 = 0$.
  ],
  image("figs/a03_euler.svg", width: 100%))

#warum[Eulerformel mit Taylorreihen][
  Setzt man $i phi$ in die Reihe $e^x = 1 + x + x^2\/2! + x^3\/3! + dots$ ein (Kapitel 5) und benutzt $i^2 = -1$, $i^3 = -i$, $i^4 = 1$, so sortieren sich die Terme in zwei Gruppen:
  $ e^(i phi) = underbrace((1 - phi^2/2! + phi^4/4! - dots), cos phi) + i underbrace((phi - phi^3/3! + phi^5/5! - dots), sin phi). $
]

#formel[Sinus und Kosinus aus der Eulerformel][
  $ cos phi = (e^(i phi) + e^(-i phi))/2, wide sin phi = (e^(i phi) - e^(-i phi))/(2 i). $
  Man vergleiche mit $cosh x = (e^x + e^(-x))\/2$: Der Kosinus ist der «hyperbolische Kosinus auf der imaginären Achse», $cos x = cosh(i x)$.
]

=== Umrechnungen

#formel[Kartesisch $<->$ polar][
  $ r = |z| = sqrt(x^2 + y^2), wide x = r cos phi, quad y = r sin phi $
  $ phi = cases(arctan(y\/x) & "für" x > 0 "(rechte Halbebene)",
               arctan(y\/x) + pi & "für" x < 0"," y >= 0 "(2. Quadrant)",
               arctan(y\/x) - pi & "für" x < 0"," y < 0 "(3. Quadrant)",
               plus.minus pi\/2 & "für" x = 0"," y != 0 " (Vorzeichen von " y ")") $
]

#grid(columns: (1fr, 4.8cm), column-gutter: 12pt, align: horizon,
  fehler[*Die Quadranten-Falle.* $arctan$ liefert nur Winkel in $(-pi\/2, pi\/2)$, also nur die rechte Halbebene. $1 + i$ und $-1 - i$ haben beide $y\/x = 1$ und damit $arctan(y\/x) = pi\/4$, liegen aber gegenüber. Für $-1 - i$ ist $phi = pi\/4 - pi = -3pi\/4$. *Immer eine Skizze machen* und prüfen, in welchem Quadranten $z$ liegt.],
  image("figs/a03_quadrant.svg", width: 100%))

#bsp[Umrechnen][
  - $z = 3 + 4i$: $r = sqrt(9 + 16) = 5$, $x > 0$, also $phi = arctan(4\/3) approx 0.927 approx 53.13 degree$. $z = 5 e^(0.927 i)$.
  - $z = -sqrt(3) + i$: $r = 2$. 2. Quadrant, also $phi = arctan(-1\/sqrt(3)) + pi = -pi\/6 + pi = 5pi\/6$. $z = 2 e^(i 5pi\/6)$.
  - $z = 4 e^(-i pi\/3)$: $x = 4 cos(-pi\/3) = 2$, $y = 4 sin(-pi\/3) = -2 sqrt(3)$. $z = 2 - 2sqrt(3) i$.
]

=== Konjugiert komplexe Zahl

#grid(columns: (1fr, 4.6cm), column-gutter: 12pt, align: horizon,
  defn[Konjugation][Die *konjugiert komplexe Zahl* $overline(z)$ entsteht durch Spiegelung an der reellen Achse:
  $ z = x + i y & quad -> quad overline(z) = x - i y \
    z = r e^(i phi) & quad -> quad overline(z) = r e^(-i phi) $
  Das Vorzeichen des Imaginärteils (bzw. des Winkels) kehrt sich um.],
  image("figs/a03_konj.svg", width: 100%))

#formel[Eigenschaften][
  #table(columns: (1fr, 1fr, 1fr), stroke: none, inset: (x: 4pt, y: 4pt),
    [$z overline(z) = |z|^2 = x^2 + y^2$], [$overline(z + w) = overline(z) + overline(w)$], [$overline(z w) = overline(z) dot overline(w)$],
    [$overline(z \/ w) = overline(z) \/ overline(w)$], [$overline(overline(z)) = z$], [$z + overline(z) = 2 Re(z), quad z - overline(z) = 2i Im(z)$],
  )
  Und: $z$ ist reell $<=>$ $z = overline(z)$.
]

#merke[$z overline(z) = |z|^2$ ist _immer reell und nicht negativ_. Das ist der Grund, warum man beim Dividieren mit dem Konjugierten des Nenners erweitert: Der Nenner wird dadurch reell.]

== Rechenarten

=== Addition und Subtraktion

#grid(columns: (1fr, 5.2cm), column-gutter: 12pt, align: horizon,
  [
    Man addiert Real- und Imaginärteil getrennt:
    $ z_1 plus.minus z_2 = (x_1 plus.minus x_2) + i (y_1 plus.minus y_2). $
    Geometrisch ist das die *Vektoraddition*: Pfeile aneinanderhängen (Parallelogramm). Die Polarform hilft hier nicht, also immer kartesisch rechnen.

    #bsp[Addition][
      $z_1 = 3 + i$, $z_2 = 1 + 2i$:
      $ z_1 + z_2 = 4 + 3i, quad z_1 - z_2 = 2 - i. $
    ]
  ],
  image("figs/a03_add.svg", width: 100%))

=== Multiplikation

#formel[Multiplikation][
  $ "kartesisch:" quad (x_1 + i y_1)(x_2 + i y_2) = (x_1 x_2 - y_1 y_2) + i(x_1 y_2 + x_2 y_1) $
  $ "polar/exponentiell:" quad z_1 z_2 = r_1 r_2 e^(i (phi_1 + phi_2)) = r_1 r_2 [cos(phi_1 + phi_2) + i sin(phi_1 + phi_2)] $
  *Beträge multiplizieren, Winkel addieren.*
]

#intu[Multiplizieren mit $z_2 = r_2 e^(i phi_2)$ ist eine *Drehstreckung*: um den Winkel $phi_2$ drehen und um den Faktor $r_2$ strecken. Spezialfall: Multiplikation mit $i = e^(i pi\/2)$ dreht um $90 degree$ gegen den Uhrzeigersinn. Zweimal mit $i$ multiplizieren dreht um $180 degree$, und das ist $-1$. Darum ist $i^2 = -1$ ganz natürlich.]

#bsp[Kartesisch][
  $(3 + i)(1 + 2 i) = 3 + 6i + i + 2i^2 = 3 + 7i - 2 = 1 + 7i$. Einfach ausmultiplizieren und $i^2 = -1$ benutzen.
]

#bsp[Polar und exponentiell][
  #grid(columns: (1fr, 4.6cm), column-gutter: 12pt, align: horizon,
  [
    $z_1 = 3(cos pi/3 + i sin pi/3) = 3 e^(i pi\/3)$, $quad z_2 = 2(cos pi/6 + i sin pi/6) = 2 e^(i pi\/6)$.
    $ z_1 z_2 = 6 e^(i (pi\/3 + pi\/6)) = 6 e^(i pi\/2) = 6 i. $
    Im Bild: $z_1$ (Länge 3, $60 degree$) wird um weitere $30 degree$ gedreht und mit $2$ gestreckt. Ergebnis: Länge 6, Winkel $90 degree$.

    Zum Vergleich kartesisch: $z_1 = 3\/2 + (3sqrt(3))\/2 i$, $z_2 = sqrt(3) + i$, Ausmultiplizieren gibt nach einigem Rechnen auch $6i$. Die Exponentialform ist viel schneller.
  ],
  image("figs/a03_mult.svg", width: 100%))
]

#alltag[Eine Drehung um $90 degree$ in einem Grafikprogramm ist nichts anderes als die Multiplikation aller Punkte mit $i$; eine Drehung um den Winkel $alpha$ ist die Multiplikation mit $e^(i alpha)$. Im Stromnetz sind Strom und Spannung oft zeitlich gegeneinander verschoben (Phasenverschiebung); diese Verschiebung ist einfach das Argument einer komplexen Zahl.]

=== Division

#formel[Division][
  $ "kartesisch:" quad z_1/z_2 = (z_1 overline(z_2))/(z_2 overline(z_2)) = (z_1 overline(z_2))/(|z_2|^2) wide "exponentiell:" quad z_1/z_2 = r_1/r_2 e^(i (phi_1 - phi_2)) $
  *Beträge dividieren, Winkel subtrahieren.* Kartesisch: mit dem Konjugierten des Nenners erweitern.
]

#bsp[Kartesisch][
  $ (3 + i)/(1 + 2 i) = ((3 + i)(1 - 2 i))/((1 + 2 i)(1 - 2 i)) = (3 - 6i + i - 2i^2)/(1 + 4) = (5 - 5i)/5 = 1 - i. $
]

#bsp[Polar und exponentiell][
  $z_1 = 4 e^(i pi\/6)$, $z_2 = 2 e^(i pi\/3)$:
  $ z_1/z_2 = 2 e^(i(pi\/6 - pi\/3)) = 2 e^(-i pi\/6) = 2(cos pi/6 - i sin pi/6) = sqrt(3) - i. $
]

#merke[$1\/i = -i$, denn $i dot (-i) = -i^2 = 1$. Und allgemein $1\/z = overline(z)\/|z|^2$; für $|z| = 1$ ist also $1\/z = overline(z)$.]

=== Potenzieren

#satz[Formel von de Moivre][
  $ z^n = r^n e^(i n phi) = r^n [cos(n phi) + i sin(n phi)] $
  *Betrag hoch $n$, Winkel mal $n$.*
]

#bsp[$(sqrt(3) + i)^6$][
  #grid(columns: (1fr, 6.4cm), column-gutter: 12pt, align: horizon,
  [
    Erst umrechnen: $r = sqrt(3 + 1) = 2$, $phi = arctan(1\/sqrt(3)) = pi\/6$. Also $z = 2 e^(i pi\/6)$.
    $ z^6 = 2^6 e^(i 6 pi\/6) = 64 e^(i pi) = -64. $
    Jede Potenz dreht um weitere $30 degree$ und verdoppelt die Länge; nach sechs Schritten ist man bei $180 degree$ angekommen. Kartesisch müsste man $(sqrt(3) + i)$ sechsmal mit sich selbst multiplizieren.
  ],
  image("figs/a03_potenz.svg", width: 100%))
]

#trick[Trigonometrische Formeln herleiten][
  Mit de Moivre für $r = 1$: $(cos phi + i sin phi)^n = cos(n phi) + i sin(n phi)$. Links mit dem binomischen Lehrsatz ausmultiplizieren und Real- und Imaginärteil vergleichen. Für $n = 2$:
  $ cos^2 phi - sin^2 phi + 2i sin phi cos phi = cos 2 phi + i sin 2 phi, $
  also $cos 2phi = cos^2 phi - sin^2 phi$ und $sin 2 phi = 2 sin phi cos phi$. Ebenso folgen die Additionstheoreme aus $e^(i(alpha + beta)) = e^(i alpha) e^(i beta)$.
]

=== Wurzelziehen

#satz[$n$-te Wurzeln][Die Gleichung $w^n = z$ mit $z = r e^(i phi) != 0$ hat *genau $n$ verschiedene Lösungen*:
$ w_k = root(n, r) e^(i (phi + 2 pi k)\/n), wide k = 0, 1, dots, n - 1. $
Sie liegen auf einem Kreis mit Radius $root(n, r)$ und bilden die Ecken eines regelmässigen $n$-Ecks.]

#warum[Woher kommen $n$ Lösungen?][
  Der Winkel von $z$ ist nicht eindeutig: $z = r e^(i phi) = r e^(i (phi + 2pi)) = r e^(i (phi + 4 pi)) = dots$ Beim Potenzieren mit $n$ werden Winkel mit $n$ multipliziert. Also führt jeder der Winkel $(phi + 2 pi k)\/n$ nach dem Potenzieren auf $phi + 2 pi k$, und das ist derselbe Punkt $z$. Für $k = 0, dots, n-1$ sind die Winkel $(phi + 2pi k)\/n$ verschieden (sie unterscheiden sich um $2pi\/n$), ab $k = n$ wiederholen sie sich.
]

#alltag[*Drehstrom.* Die drei Phasen des Stromnetzes («Starkstrom» am Kochherd) sind um je $120 degree$ gegeneinander verschoben, genau wie die drei dritten Einheitswurzeln $1$, $e^(i 2pi\/3)$, $e^(i 4pi\/3)$. Ihre Summe ist $0$ (sie bilden ein gleichseitiges Dreieck um den Ursprung). Bei gleich belasteten Phasen fliesst deshalb im Neutralleiter kein Strom.]

#rezept[Wurzeln einer komplexen Zahl][
  + $z$ in Exponentialform bringen: $r$ und $phi$ bestimmen (Quadrant beachten!).
  + Betrag der Wurzeln: $root(n, r)$ (die gewöhnliche reelle Wurzel).
  + Erster Winkel: $phi\/n$. Die weiteren erhält man durch wiederholtes Addieren von $2 pi\/n$.
  + Falls verlangt, in kartesische Form zurückrechnen.
]

#bsp[Die 5. Wurzeln von $sqrt(3) + i$][
  #grid(columns: (1fr, 5.0cm), column-gutter: 12pt, align: horizon,
  [
    $r = 2$, $phi = pi\/6$. Betrag der Wurzeln: $root(5, 2) approx 1.149$. Winkel:
    $ (pi\/6 + 2 pi k)/5 = pi/30 + (2 pi k)/5 = ((1 + 12 k) pi)/30. $
    $ z_0 = root(5, 2) e^(i pi\/30), quad z_1 = root(5, 2) e^(i 13 pi\/30), quad z_2 = root(5, 2) e^(i 25 pi\/30), $
    $ z_3 = root(5, 2) e^(i 37 pi\/30), quad z_4 = root(5, 2) e^(i 49 pi\/30). $
    Die fünf Punkte bilden ein regelmässiges Fünfeck; benachbarte Wurzeln liegen $2pi\/5 = 72 degree$ auseinander.
  ],
  image("figs/a03_wurzel.svg", width: 100%))
]

#bsp[Quadratwurzel kartesisch: $sqrt(3 + 4i)$][
  Bei Quadratwurzeln geht es oft auch ohne Polarform. Ansatz $(a + i b)^2 = 3 + 4i$ mit reellen $a, b$:
  $ a^2 - b^2 = 3 quad "(Realteil)", wide 2 a b = 4 quad "(Imaginärteil)". $
  Aus der zweiten Gleichung $b = 2\/a$, eingesetzt $a^2 - 4\/a^2 = 3$, also $a^4 - 3a^2 - 4 = 0$ und $a^2 = 4$ (die Lösung $a^2 = -1$ ist für reelles $a$ unmöglich). Damit $a = plus.minus 2$, $b = plus.minus 1$:
  $ w = plus.minus (2 + i). $
  Probe: $(2 + i)^2 = 4 + 4i - 1 = 3 + 4i$. #sym.checkmark Hilfreich ist die zusätzliche Gleichung $a^2 + b^2 = |3 + 4i| = 5$; zusammen mit $a^2 - b^2 = 3$ folgt sofort $a^2 = 4$, $b^2 = 1$.
]

#fehler[$sqrt(z)$ ist für komplexe Zahlen nicht eindeutig. Regeln wie $sqrt(a b) = sqrt(a) sqrt(b)$ gelten nicht mehr: $1 = sqrt(1) = sqrt((-1)(-1)) != sqrt(-1) sqrt(-1) = i^2 = -1$. Immer mit der Wurzel-Formel arbeiten und alle $n$ Lösungen angeben.]

=== Die komplexe Exponentialfunktion

#formel[$e^z$ für $z = x + i y$][
  $ e^(x + i y) = e^x e^(i y) = e^x (cos y + i sin y), wide |e^z| = e^x, quad arg(e^z) = y. $
  Der Realteil steuert die Länge, der Imaginärteil den Winkel. Folge: $e^z$ ist $2 pi i$-periodisch, $e^(z + 2 pi i) = e^z$, und $e^z$ wird nie $0$.
]

#bsp[Alle Lösungen von $e^z = -2$][
  $-2 = 2 e^(i pi)$. Mit $z = x + i y$: $e^x = 2$ und $y = pi + 2 pi k$. Also $z = ln 2 + i (2k + 1) pi$, $k in ZZ$. Unendlich viele Lösungen, weil $e^z$ periodisch ist.
]

== Polynomgleichungen

=== Quadratische Gleichungen

#satz[Mitternachtsformel über $CC$][$a z^2 + b z + c = 0$ hat die Lösungen
$ z_(1,2) = (-b plus.minus sqrt(b^2 - 4 a c))/(2a). $
Ist die Diskriminante $D = b^2 - 4 a c < 0$ (bei reellen Koeffizienten), so ist $sqrt(D) = i sqrt(|D|)$, und es gibt zwei *konjugiert komplexe* Lösungen.]

#bsp[$x^2 + 2x + 3 = 0$][
  $ x_(1,2) = (-2 plus.minus sqrt(4 - 12))/2 = (-2 plus.minus sqrt(-8))/2 = (-2 plus.minus i 2 sqrt(2))/2 = -1 plus.minus sqrt(2) i. $
  Die beiden Lösungen sind konjugiert zueinander, wie es bei reellen Koeffizienten sein muss.
]

#bsp[Komplexe Koeffizienten: $z^2 - 2i z - 2 = 0$][
  Die Formel gilt weiter, nur ist die Wurzel jetzt die einer komplexen Zahl:
  $ z = (2i plus.minus sqrt((2 i)^2 + 8))/2 = (2i plus.minus sqrt(-4 + 8))/2 = (2 i plus.minus 2)/2 = plus.minus 1 + i. $
  Hier sind die Lösungen _nicht_ konjugiert: Die Paar-Regel gilt nur bei reellen Koeffizienten. Ist die Diskriminante selbst komplex, berechnet man ihre Wurzel wie in Abschnitt 3.2.
]

#trick[Quadratisch ergänzen][Statt der Formel kann man auch ergänzen: $z^2 - 2 i z - 2 = (z - i)^2 - i^2 - 2 = (z - i)^2 - 1 = 0$, also $z - i = plus.minus 1$. Oft schneller und weniger fehleranfällig.]

=== Polynome höherer Ordnung

#satz[Fundamentalsatz der Algebra][Jedes Polynom vom Grad $n >= 1$ hat in $CC$ genau $n$ Nullstellen (mit Vielfachheit gezählt) und zerfällt in Linearfaktoren:
$ p(z) = a_n (z - z_1)(z - z_2) dots (z - z_n). $]

#satz[Konjugierte Paare][Hat ein Polynom *reelle* Koeffizienten, so sind seine Nullstellen entweder reell, oder sie treten in konjugierten Paaren auf: Ist $z_1$ eine Nullstelle, dann auch $overline(z_1)$. Das Produkt $(z - z_1)(z - overline(z_1)) = z^2 - 2 Re(z_1) z + |z_1|^2$ ist ein reelles quadratisches Polynom.]

#warum[Konjugierte Paare][
  Konjugieren ändert reelle Koeffizienten nicht. Aus $p(z_1) = 0$ folgt $0 = overline(p(z_1)) = sum overline(a_k) overline(z_1)^k = sum a_k overline(z_1)^k = p(overline(z_1))$.
]

#merke[Folgerung: Ein reelles Polynom von *ungeradem* Grad hat mindestens eine *reelle* Nullstelle, weil die komplexen Nullstellen paarweise auftreten.]

#alltag[Wie eine Brücke, ein Gebäude oder ein Auto schwingt, steht in den Nullstellen eines Polynoms (dem «charakteristischen Polynom» seiner Schwingungsgleichung). Der Imaginärteil einer Nullstelle ist die Schwingungsfrequenz, der Realteil sagt, ob die Schwingung abklingt (negativ) oder sich aufschaukelt (positiv). Ingenieure prüfen deshalb, dass alle Nullstellen in der linken Halbebene liegen. Dass sie paarweise konjugiert auftreten, kommt daher, dass die Koeffizienten (Massen, Federn, Dämpfer) reell sind.]

#rezept[Alle Nullstellen eines Polynoms finden][
  + Ist eine komplexe Nullstelle $z_1$ gegeben, ist bei reellen Koeffizienten auch $overline(z_1)$ eine. Das Produkt $(z - z_1)(z - overline(z_1))$ ausrechnen (es ist reell).
  + Polynomdivision durch dieses quadratische Polynom.
  + Im Restpolynom Nullstellen *raten*: Bei ganzzahligen Koeffizienten und Leitkoeffizient $1$ sind ganzzahlige Nullstellen Teiler des konstanten Terms. Probiere $plus.minus 1$, $plus.minus 2$, $dots$, auch $plus.minus i$.
  + Gefundene Nullstelle abspalten, wiederholen, bis ein quadratisches Polynom übrig bleibt; dieses mit der Mitternachtsformel lösen.
]

#bsp[$x^5 - 4x^4 + 10x^3 - 14x^2 + 9x - 10 = 0$, gegeben $x_1 = 1 + 2i$][
  *Schritt 1.* Die Koeffizienten sind reell, also ist auch $x_2 = 1 - 2i$ eine Nullstelle. Das Produkt der Faktoren:
  $ (x - (1 + 2 i))(x - (1 - 2 i)) = (x - 1)^2 - (2 i)^2 = x^2 - 2x + 1 + 4 = x^2 - 2x + 5. $
  (Dritte binomische Formel mit $a = x - 1$, $b = 2i$.)

  *Schritt 2.* Polynomdivision:
  $ (x^5 - 4x^4 + 10x^3 - 14x^2 + 9x - 10) : (x^2 - 2x + 5) = x^3 - 2x^2 + x - 2. $
  Kontrolle durch Ausmultiplizieren: $(x^2 - 2x + 5)(x^3 - 2x^2 + x - 2) = x^5 - 4x^4 + 10x^3 - 14x^2 + 9x - 10$. #sym.checkmark

  *Schritt 3.* Nullstellen von $x^3 - 2x^2 + x - 2$ raten. Teiler von $-2$: $plus.minus 1$, $plus.minus 2$. $x = 2$: $8 - 8 + 2 - 2 = 0$. #sym.checkmark Oder man sieht die Faktorisierung durch Gruppieren:
  $ x^3 - 2x^2 + x - 2 = x^2 (x - 2) + (x - 2) = (x^2 + 1)(x - 2). $
  *Schritt 4.* $x^2 + 1 = 0 <=> x = plus.minus i$.

  #grid(columns: (1fr, 5.4cm), column-gutter: 12pt, align: horizon,
  [
    *Alle fünf Nullstellen:*
    $ x_1 = 1 + 2i, quad x_2 = 1 - 2i, quad x_3 = 2, quad x_4 = i, quad x_5 = -i. $
    Rechts der reelle Graph: Er schneidet die $x$-Achse nur einmal, bei $x = 2$. Die vier komplexen Nullstellen sieht man im reellen Bild nicht.
  ],
  image("figs/a03_poly.svg", width: 100%))
]

#aufgaben()

#aufg[Grundrechenarten][
  Bestimme Real- und Imaginärteil von (a) $display((2 + i)/(1 - i))$, (b) $(1 + i)^(10)$, (c) $i^(2026)$.
][
  (a) Mit $1 + i$ erweitern: $display(((2 + i)(1 + i))/((1-i)(1+i)) = (2 + 2i + i - 1)/2 = 1/2 + 3/2 i)$. Re $= 1\/2$, Im $= 3\/2$.

  (b) $1 + i = sqrt(2) e^(i pi\/4)$, also $(1 + i)^(10) = 2^5 e^(i 10 pi\/4) = 32 e^(i 5pi\/2) = 32 e^(i pi\/2) = 32 i$. Re $= 0$, Im $= 32$.

  (c) Die Potenzen von $i$ wiederholen sich mit Periode 4: $i, -1, -i, 1$. $2026 = 4 dot 506 + 2$, also $i^(2026) = i^2 = -1$.
]

#aufg[Dritte Wurzeln][
  Löse $z^3 = -8$ und gib alle Lösungen kartesisch an.
][
  $-8 = 8 e^(i pi)$. Betrag $root(3, 8) = 2$, Winkel $(pi + 2pi k)\/3$:
  $ z_0 = 2 e^(i pi\/3) = 1 + sqrt(3) i, quad z_1 = 2 e^(i pi) = -2, quad z_2 = 2 e^(i 5pi\/3) = 1 - sqrt(3) i. $
  Probe: Die reelle Lösung $-2$ ist offensichtlich. Die anderen beiden sind konjugiert, wie es bei der reellen Gleichung $z^3 + 8 = 0$ sein muss.
]

#aufg[Quadratische Gleichung][
  Löse $z^2 - (3 + i) z + (2 + 2 i) = 0$.
][
  Diskriminante: $(3 + i)^2 - 4(2 + 2 i) = 9 + 6i - 1 - 8 - 8i = -2i$.

  Wurzel aus $-2i = 2 e^(-i pi\/2)$: $plus.minus sqrt(2) e^(-i pi\/4) = plus.minus (1 - i)$.
  $ z_(1,2) = ((3 + i) plus.minus (1 - i))/2 quad => quad z_1 = 2, quad z_2 = 1 + i. $
  Probe: $z_1 + z_2 = 3 + i$ und $z_1 z_2 = 2 + 2i$ (Satz von Vieta). #sym.checkmark
]

#aufg[Gebiete in der Ebene][
  Skizziere die Menge aller $z in CC$ mit (a) $|z - i| <= 1$, (b) $Re(z^2) = 0$.
][
  (a) $|z - i|$ ist der Abstand von $z$ zum Punkt $i$. Also die abgeschlossene Kreisscheibe mit Mittelpunkt $i$ und Radius $1$. Sie berührt den Ursprung.

  (b) $z^2 = (x + i y)^2 = x^2 - y^2 + 2 i x y$, also $Re(z^2) = x^2 - y^2 = 0 <=> y = plus.minus x$. Die beiden Winkelhalbierenden.
]

#aufg[Dreifacher Winkel][
  Drücke $cos 3 phi$ durch $cos phi$ aus.
][
  De Moivre: $cos 3phi + i sin 3phi = (cos phi + i sin phi)^3$. Mit $c = cos phi$, $s = sin phi$:
  $ (c + i s)^3 = c^3 + 3 c^2 (i s) + 3 c (i s)^2 + (i s)^3 = (c^3 - 3 c s^2) + i(3 c^2 s - s^3). $
  Realteil vergleichen und $s^2 = 1 - c^2$ einsetzen:
  $ cos 3 phi = c^3 - 3c(1 - c^2) = 4 cos^3 phi - 3 cos phi. $
]

#kurz[
  - $z = x + i y = r e^(i phi)$, $r = sqrt(x^2 + y^2)$, $phi$ aus $arctan(y\/x)$ *mit Quadrantenkorrektur*.
  - Eulerformel $e^(i phi) = cos phi + i sin phi$: Punkt auf dem Einheitskreis.
  - Konjugieren spiegelt an der reellen Achse; $z overline(z) = |z|^2$.
  - Addieren kartesisch (Vektoren), Multiplizieren/Dividieren exponentiell: Beträge multiplizieren/dividieren, Winkel addieren/subtrahieren.
  - Potenz: $z^n = r^n e^(i n phi)$. Wurzeln: $n$ Lösungen $root(n, r) e^(i(phi + 2pi k)\/n)$, ein regelmässiges $n$-Eck.
  - Polynom vom Grad $n$: genau $n$ komplexe Nullstellen. Reelle Koeffizienten: komplexe Nullstellen in konjugierten Paaren.
]
