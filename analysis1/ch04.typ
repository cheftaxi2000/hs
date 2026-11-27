#import "lib.typ": *

= Integralrechnung

#text(size: 9.5pt, style: "italic")[Vorlesung: Kapitel III. Das Integral addiert unendlich viele unendlich kleine Beiträge: Flächenstreifen, Bogenstücke, Volumenscheiben. Der Hauptsatz verbindet es mit der Ableitung, und dadurch wird Integrieren zu «rückwärts ableiten». Ein grosser Teil der Prüfung besteht aus Integralen.]

== Das Integral

=== Fläche als Grenzwert

#idee[Wie berechnet man die Fläche unter einer krummen Kurve? Man zerlegt sie in schmale Rechtecke, deren Fläche man kennt, und addiert sie. Je schmaler die Rechtecke, desto genauer. Das Integral ist der Grenzwert dieser Summen.]

#fg("a04_riemann", [Riemann-Summe: $n$ Rechtecke der Breite $Delta x = (b - a)\/n$ und der Höhe $f(xi_k)$ an einer Stelle $xi_k$ im $k$-ten Teilintervall.], w: 60%)

#defn[Bestimmtes Integral][
  $ integral_a^b f(x) dif x = lim_(n -> oo) sum_(k=1)^n f(xi_k) Delta x, wide Delta x = (b - a)/n. $
  Existiert der Grenzwert (unabhängig von der Wahl der $xi_k$), heisst $f$ *integrierbar* auf $[a, b]$. Jede stetige Funktion auf $[a, b]$ ist integrierbar.
]

#intu[Die Schreibweise erzählt die Herleitung nach: $integral$ ist ein langgezogenes S für «Summe», $f(x) dif x$ ist die Fläche eines unendlich schmalen Rechtecks mit Höhe $f(x)$ und Breite $dif x$. In Anwendungen (Bogenlänge, Volumen, Schwerpunkt) überlegt man sich immer zuerst: Was ist der Beitrag eines kleinen Stücks $dif x$? Dann integriert man.]

#grid(columns: (1fr, 6.2cm), column-gutter: 12pt, align: horizon,
  [
    *Das Integral misst Fläche mit Vorzeichen.*
    - Teile oberhalb der $x$-Achse zählen positiv.
    - Teile unterhalb zählen negativ.
    Will man die *geometrische* Fläche, muss man an den Nullstellen aufteilen und die Beträge der Teilintegrale addieren.
  ],
  image("figs/a04_flaeche.svg", width: 100%))

#alltag[
  - Der *Stromzähler* integriert: Die Leistung $P(t)$ (in kW) ändert sich ständig, abgerechnet wird die Energie $integral P dif t$ in kWh.
  - Ein *Fahrtenschreiber* zeichnet die Geschwindigkeit auf; der Weg ist das Integral darüber.
  - Die *Wassermenge*, die durch ein Rohr fliesst, ist das Integral der Durchflussrate; der Regen eines Tages das Integral der Regenintensität.
  Das Vorzeichen hat dabei eine Bedeutung: Fährst du zurück, ist $v < 0$, und das Integral gibt die Verschiebung, nicht die gefahrene Strecke.
]

#bsp[Integral ist nicht gleich Fläche][
  $integral_0^(2pi) sin x dif x = 0$, weil sich die positive und die negative Hälfte aufheben. Die Fläche zwischen Sinus und $x$-Achse ist dagegen
  $ integral_0^pi sin x dif x + |integral_pi^(2pi) sin x dif x| = 2 + 2 = 4. $
]

=== Stammfunktion und Hauptsatz

#defn[Stammfunktion, unbestimmtes Integral][Eine Funktion $F$ heisst *Stammfunktion* von $f$, wenn $F'(x) = f(x)$. Mit $F$ ist auch jedes $F + C$ eine Stammfunktion, und andere gibt es (auf einem Intervall) nicht. Man schreibt
$ integral f(x) dif x = F(x) + C. $]

#satz[Hauptsatz der Differential- und Integralrechnung][
  *Teil 1:* Ist $f$ stetig, so ist die Flächenfunktion $F(x) = integral_a^x f(t) dif t$ differenzierbar mit
  $ dif/(dif x) integral_a^x f(t) dif t = f(x). $
  *Teil 2:* Ist $F$ irgendeine Stammfunktion von $f$, so gilt
  $ integral_a^b f(x) dif x = [F(x)]_a^b = F(b) - F(a). $
]

#fg("a04_hauptsatz", [Warum Teil 1 gilt: Schiebt man die rechte Grenze von $x$ nach $x + h$, wächst die Fläche um einen schmalen Streifen der Fläche $approx f(x) h$. Also $(F(x + h) - F(x))\/h approx f(x)$, und für $h -> 0$ wird daraus $F'(x) = f(x)$.], w: 60%)

#intu[Teil 1 sagt: Die Fläche wächst gerade so schnell, wie die Kurve hoch ist. Teil 2 ist die praktische Folgerung: Um eine Fläche zu berechnen, muss man keine Grenzwerte von Summen bilden, sondern nur eine Funktion finden, deren Ableitung $f$ ist. Integrieren ist «rückwärts ableiten».]

#alltag[*Die Badewanne.* $f(t)$ ist die Menge Wasser pro Minute, die gerade einläuft, $F(t)$ die Wassermenge in der Wanne. Der Hauptsatz sagt: Die Wassermenge steigt genau so schnell, wie Wasser zufliesst, $F' = f$. Und wie viel Wasser zwischen zwei Zeitpunkten dazugekommen ist, ist der Unterschied der Füllstände $F(b) - F(a)$, egal wie der Zufluss dazwischen geschwankt hat.]

#bsp[Hauptsatz am Beispiel][
  $f(t) = 3t^2$, $G(x) = integral_1^x 3t^2 dif t$. Eine Stammfunktion ist $t^3$, also
  $ G(x) = [t^3]_1^x = x^3 - 1, wide G'(x) = 3x^2 = f(x). #sym.checkmark $
]

#satz[Ableitung mit variablen Grenzen][
  $ F(x) = integral_(h(x))^(g(x)) f(t) dif t quad => quad F'(x) = f(g(x)) g'(x) - f(h(x)) h'(x). $
]

#warum[Ableitung mit variablen Grenzen][Mit einer Stammfunktion $Phi$ von $f$ ist $F(x) = Phi(g(x)) - Phi(h(x))$. Kettenregel: $F' = Phi'(g) g' - Phi'(h) h' = f(g) g' - f(h) h'$.]

#bsp[Variable Grenzen][
  $ dif/(dif x) integral_0^(x^2) sin(t) dif t = sin(x^2) dot 2x, wide dif/(dif x) integral_x^(2x) e^(-t^2) dif t = e^(-4x^2) dot 2 - e^(-x^2) dot 1. $
  Man muss das Integral dafür nicht ausrechnen können. $integral e^(-t^2) dif t$ hat gar keine elementare Stammfunktion.
]

=== Rechenregeln

#formel[Rechenregeln][
  #table(columns: (1fr, 1fr), stroke: none, inset: (x: 4pt, y: 4.5pt),
    [$integral_a^b (f + g) dif x = integral_a^b f dif x + integral_a^b g dif x$], [$integral_a^b c f dif x = c integral_a^b f dif x$],
    [$integral_a^b f dif x = -integral_b^a f dif x$], [$integral_a^a f dif x = 0$],
    [$integral_a^b f dif x + integral_b^c f dif x = integral_a^c f dif x$], [$f <= g => integral_a^b f dif x <= integral_a^b g dif x$],
  )
  Symmetrie: Ist $f$ ungerade, so ist $integral_(-a)^a f dif x = 0$. Ist $f$ gerade, so ist $integral_(-a)^a f dif x = 2 integral_0^a f dif x$.
]

#fehler[Es gibt *keine* Produkt- oder Quotientenregel für Integrale: $integral f g dif x != integral f dif x dot integral g dif x$. Für Produkte braucht man partielle Integration oder Substitution.]

#formel[Grundintegrale][
  #table(columns: (1fr, 1fr), stroke: none, inset: (x: 4pt, y: 5pt),
    [$integral x^n dif x = x^(n+1)/(n+1) + C quad (n != -1)$], [$integral 1/x dif x = ln|x| + C$],
    [$integral e^x dif x = e^x + C$], [$integral a^x dif x = a^x/(ln a) + C$],
    [$integral sin x dif x = -cos x + C$], [$integral cos x dif x = sin x + C$],
    [$integral 1/(cos^2 x) dif x = tan x + C$], [$integral tan x dif x = -ln|cos x| + C$],
    [$integral sinh x dif x = cosh x + C$], [$integral cosh x dif x = sinh x + C$],
    [$integral 1/(1 + x^2) dif x = arctan x + C$], [$integral 1/sqrt(1 - x^2) dif x = arcsin x + C$],
    [$integral 1/sqrt(x^2 + 1) dif x = arsinh x + C$], [$integral ln x dif x = x ln x - x + C$],
  )
]

#bsp[Der Betrag in $ln|x|$][
  $integral 1/(x - 1) dif x = ln|x - 1| + C$. Warum der Betrag? Für $x > 1$ ist $(ln(x - 1))' = 1\/(x-1)$. Für $x < 1$ ist $ln(x-1)$ nicht definiert, aber $(ln(1 - x))' = 1/(1-x) dot (-1) = 1/(x - 1)$. Beide Fälle fasst $ln|x - 1|$ zusammen.
]

== Integrationsmethoden

#idee[Ableiten ist Handwerk: Mit den Regeln bekommt man jede Ableitung. Integrieren ist eher Detektivarbeit: Man muss erkennen, aus welcher Regel ein Integrand «entstanden» ist. Die partielle Integration ist die Produktregel rückwärts, die Substitution die Kettenregel rückwärts, und für Brüche gibt es die Partialbruchzerlegung.]

=== Partielle Integration

#satz[Partielle Integration][
  $ integral u'(x) v(x) dif x = u(x) v(x) - integral u(x) v'(x) dif x, wide integral_a^b u' v dif x = [u v]_a^b - integral_a^b u v' dif x. $
]

#warum[Produktregel rückwärts][$(u v)' = u' v + u v'$. Integrieren: $u v = integral u' v dif x + integral u v' dif x$. Umstellen gibt die Formel.]

#rezept[Wer wird abgeleitet ($v$), wer integriert ($u'$)?][
  Ziel: Das neue Integral $integral u v' dif x$ soll einfacher sein als das alte. Also den Faktor *ableiten*, der dadurch einfacher wird, und den *integrieren*, der dabei nicht schwieriger wird. Faustregel *LIATE*, in dieser Reihenfolge bevorzugt ableiten:
  #align(center)[#strong[L]ogarithmus #h(0.5em) > #h(0.5em) #strong[I]nverse Trig. ($arctan$, ...) #h(0.5em) > #h(0.5em) #strong[A]lgebraisch ($x^n$) #h(0.5em) > #h(0.5em) #strong[T]rigonometrisch #h(0.5em) > #h(0.5em) #strong[E]xponential]
]

#bsp[$integral x e^x dif x$][
  $x$ wird durch Ableiten einfacher, $e^x$ ändert sich beim Integrieren nicht. Also $v = x$, $u' = e^x$; damit $v' = 1$, $u = e^x$.
  $ integral x e^x dif x = x e^x - integral 1 dot e^x dif x = x e^x - e^x + C = (x - 1) e^x + C. $
  Probe: $((x-1) e^x)' = e^x + (x - 1) e^x = x e^x$. #sym.checkmark
]

#bsp[$integral ln x dif x$: der Trick mit dem Faktor $1$][
  Es gibt nur einen Faktor. Man schreibt $ln x = 1 dot ln x$ mit $u' = 1$, $v = ln x$:
  $ integral 1 dot ln x dif x = x ln x - integral x dot 1/x dif x = x ln x - x + C. $
  Genauso: $integral arctan x dif x = x arctan x - 1/2 ln(1 + x^2) + C$.
]

#bsp[Mehrfach: $integral x^2 cos x dif x$][
  Zweimal partiell, jedes Mal wird die Potenz von $x$ kleiner:
  $ integral x^2 cos x dif x &= x^2 sin x - integral 2x sin x dif x = x^2 sin x - (-2x cos x + integral 2 cos x dif x) \
  &= x^2 sin x + 2x cos x - 2 sin x + C. $
]

#bsp[Der Bumerang: $integral e^x sin x dif x$][
  Zweimal partiell integrieren (immer $e^x$ integrieren):
  $ I = integral e^x sin x dif x &= e^x sin x - integral e^x cos x dif x = e^x sin x - (e^x cos x + integral e^x sin x dif x) \
  &= e^x (sin x - cos x) - I. $
  Das gesuchte Integral $I$ taucht rechts wieder auf. Nach $I$ auflösen: $2I = e^x (sin x - cos x)$, also
  $ integral e^x sin x dif x = e^x/2 (sin x - cos x) + C. $
]

=== Substitution

#satz[Substitutionsregel][
  $ integral_a^b f(g(x)) g'(x) dif x = integral_(g(a))^(g(b)) f(u) dif u wide (u = g(x), quad dif u = g'(x) dif x). $
]

#intu[Die Kettenregel rückwärts. Man sucht im Integranden eine «innere Funktion» $g(x)$, deren Ableitung $g'(x)$ als Faktor danebensteht. Dann ersetzt man $g(x)$ durch eine neue Variable $u$, und $g'(x) dif x$ wird zu $dif u$.]

#rezept[Substitution][
  + Substitution wählen: $u = g(x)$, meist die innere Funktion, ein Exponent oder ein Wurzelinhalt.
  + Ableiten: $(dif u)\/(dif x) = g'(x)$, nach $dif x$ auflösen: $dif x = (dif u)\/g'(x)$.
  + *Grenzen anpassen:* $x = a -> u = g(a)$, $x = b -> u = g(b)$. (Oder: am Schluss zurücksubstituieren und die alten Grenzen benutzen. Nie mischen!)
  + Alles ersetzen. Es darf kein $x$ übrig bleiben; sonst war die Substitution ungünstig oder man muss $x$ durch $u$ ausdrücken.
  + Integral in $u$ lösen.
]

#bsp[Substitution 1: $integral_0^(pi\/2) sin(x) e^(cos x) dif x$][
  + $u = cos x$ (der Exponent).
  + $(dif u)/(dif x) = -sin x$, also $dif x = -(dif u)\/sin x$.
  + Grenzen: $x = 0 -> u = 1$, $x = pi\/2 -> u = 0$.
  + Ersetzen: $sin(x) e^u dot (-(dif u)/(sin x)) = -e^u dif u$. Das $sin x$ kürzt sich, das ist das Zeichen, dass die Substitution passt.
  + $ integral_0^(pi\/2) sin(x) e^(cos x) dif x = integral_1^0 -e^u dif u = integral_0^1 e^u dif u = [e^u]_0^1 = e - 1. $
  Beim Vertauschen der Grenzen ist das Minuszeichen verschwunden.
]

#bsp[Substitution 2: $integral_0^2 x cos(x^2 + 1) dif x$][
  $u = x^2 + 1$, $dif u = 2x dif x$, also $x dif x = 1/2 dif u$. Grenzen: $u(0) = 1$, $u(2) = 5$.
  $ integral_0^2 x cos(x^2 + 1) dif x = 1/2 integral_1^5 cos u dif u = 1/2 [sin u]_1^5 = (sin 5 - sin 1)/2. $
  (Die Vorlage geht hier den Umweg über $x = sqrt(u - 1)$. Das ist nicht falsch, aber unnötig: Es genügt, $x dif x$ als Ganzes zu ersetzen.)
]

#formel[Substitutionen, die man direkt sehen sollte][
  #table(columns: (1fr, 1fr), stroke: none, inset: (x: 4pt, y: 5pt),
    [*Linear:* $integral f(a x + b) dif x = 1/a F(a x + b) + C$], [z. B. $integral e^(3x - 1) dif x = 1/3 e^(3x - 1) + C$],
    [*Logarithmisch:* $integral (f'(x))/(f(x)) dif x = ln|f(x)| + C$], [z. B. $integral (2x)/(x^2 + 1) dif x = ln(x^2 + 1) + C$],
    [*Potenz:* $integral f'(x) f(x)^n dif x = (f(x)^(n+1))/(n+1) + C$], [z. B. $integral sin x cos^3 x dif x = -(cos^4 x)/4 + C$],
  )
]

#trick[Trigonometrische Substitution][Bei $sqrt(1 - x^2)$ substituiert man $x = sin u$, denn dann ist $sqrt(1 - sin^2 u) = cos u$. Ebenso bei $sqrt(1 + x^2)$: $x = sinh u$; bei $sqrt(x^2 - 1)$: $x = cosh u$.]

#bsp[Viertelkreis: $integral_0^1 sqrt(1 - x^2) dif x$][
  $x = sin u$, $dif x = cos u dif u$, Grenzen $u = 0$ bis $u = pi\/2$:
  $ integral_0^(pi\/2) cos u dot cos u dif u = integral_0^(pi\/2) (1 + cos 2u)/2 dif u = [u/2 + (sin 2u)/4]_0^(pi\/2) = pi/4. $
  Kein Zufall: Das ist die Fläche eines Viertels des Einheitskreises.
]

=== Integrale rationaler Funktionen

#idee[Jede rationale Funktion $p(x)\/q(x)$ lässt sich integrieren. Der Weg: erst durch Polynomdivision den Grad des Zählers unter den des Nenners drücken, dann den Rest in einfache Brüche zerlegen, deren Integrale man kennt ($ln$, $arctan$, Potenzen).]

#intu[Partialbruchzerlegung ist Bruchrechnen rückwärts. In der Schule rechnet man $1\/2 + 1\/3 = 5\/6$. Hier geht man den umgekehrten Weg: Gegeben ist ein komplizierter Bruch wie $5\/6$, gesucht sind die einfachen Brüche, aus denen er zusammengesetzt ist. Die Nenner der Bausteine sind die Faktoren des grossen Nenners, so wie $6 = 2 dot 3$.]

#rezept[Partialbruchzerlegung][
  + *Grad prüfen.* Ist $deg p >= deg q$: Polynomdivision, $p\/q = "Polynom" + r\/q$ mit $deg r < deg q$.
  + *Nenner faktorisieren* in Linearfaktoren $(x - x_0)$ und nicht weiter zerlegbare quadratische Faktoren $(x^2 + p x + q)$ mit $p^2 - 4q < 0$.
  + *Ansatz* je nach Faktor (siehe Tabelle).
  + *Koeffizienten bestimmen:* mit dem Hauptnenner multiplizieren, dann geeignete $x$-Werte einsetzen (die Nullstellen!) oder Koeffizientenvergleich.
  + *Jeden Teilbruch einzeln integrieren.*
]

#formel[Ansätze][
  *Einfache reelle Nullstellen:*
  $ (r(x))/((x - x_0)(x - x_1)) = A/(x - x_0) + B/(x - x_1) $
  *Mehrfache Nullstelle* (hier 3-fach):
  $ (r(x))/((x - x_0)^3 (x - x_1)) = A/(x - x_0) + B/(x - x_0)^2 + C/(x - x_0)^3 + D/(x - x_1) $
  *Quadratischer Faktor:*
  $ (r(x))/((x^2 + p x + q)(x - x_0)) = (A x + B)/(x^2 + p x + q) + C/(x - x_0) $
  *Mehrfacher quadratischer Faktor:*
  $ (A x + B)/(x^2 + p x + q) + (C x + D)/(x^2 + p x + q)^2 + dots $
  Merke: Über einem quadratischen Faktor steht ein linearer Zähler $A x + B$, über einem linearen Faktor eine Konstante.
]

#formel[Die Bausteine integrieren][
  #table(columns: (1fr, 1fr), stroke: none, inset: (x: 4pt, y: 5pt),
    [$integral 1/(x - a) dif x = ln|x - a| + C$], [$integral 1/(x - a)^s dif x = -1/((s-1)(x-a)^(s-1)) + C quad (s != 1)$],
    [$integral 1/(a^2 + x^2) dif x = 1/a arctan(x/a) + C$], [$integral 1/(a^2 - x^2) dif x = 1/a artanh(x/a) + C quad (|x| < a)$],
  )
  $ integral 1/(x^2 + 2 b x + c) dif x = 1/sqrt(c - b^2) arctan((x + b)/sqrt(c - b^2)) + C quad "für" c - b^2 > 0 $
  (quadratisch ergänzen: $x^2 + 2 b x + c = (x + b)^2 + (c - b^2)$, dann lineare Substitution)
]

#bsp[Polynomdivision und Partialbrüche: $integral (x^3 - 4x^2)/(x^2 - 4) dif x$][
  *1. Polynomdivision* (Zählergrad 3 > Nennergrad 2):
  $ (x^3 - 4x^2) : (x^2 - 4) = x - 4 quad "Rest" quad 4x - 16, wide (x^3 - 4x^2)/(x^2 - 4) = x - 4 + (4x - 16)/(x^2 - 4). $
  *2. Nenner faktorisieren:* $x^2 - 4 = (x - 2)(x + 2)$.

  *3. Ansatz:* $display((4x - 16)/((x - 2)(x + 2)) = A/(x - 2) + B/(x + 2))$. Mit dem Hauptnenner multiplizieren:
  $ 4x - 16 = A(x + 2) + B(x - 2). $
  *4a. Einsetzen (schnell):* $x = 2$: $-8 = 4A$, also $A = -2$. $x = -2$: $-24 = -4B$, also $B = 6$.

  *4b. Oder Koeffizientenvergleich:* $4x - 16 = (A + B) x + (2A - 2B)$, also $A + B = 4$ und $2A - 2B = -16$. Gleiches Ergebnis.

  *5. Integrieren:*
  $ integral (x - 4 - 2/(x - 2) + 6/(x + 2)) dif x = x^2/2 - 4x - 2 ln|x - 2| + 6 ln|x + 2| + C. $
]

#bsp[Mit quadratischem Faktor: $integral 1/(x(x^2 + 1)) dif x$][
  Ansatz $display(1/(x(x^2+1)) = A/x + (B x + C)/(x^2 + 1))$, also $1 = A(x^2 + 1) + (B x + C) x$.
  - $x = 0$: $A = 1$.
  - Koeffizient von $x^2$: $0 = A + B$, also $B = -1$. Koeffizient von $x$: $0 = C$.
  $ integral (1/x - x/(x^2 + 1)) dif x = ln|x| - 1/2 ln(x^2 + 1) + C. $
  Den zweiten Teil löst die logarithmische Substitution: Im Zähler steht bis auf den Faktor $1\/2$ die Ableitung des Nenners.
]

== Anwendungen der Integralrechnung

#idee[Alle Anwendungen folgen demselben Muster: Zerlege das Objekt in kleine Stücke, schreibe den Beitrag $dif A$, $dif s$, $dif V$ eines Stücks auf, und integriere. Wer dieses Muster versteht, muss die Formeln nicht auswendig lernen.]

=== Flächen

#formel[Fläche zwischen Kurve und $x$-Achse][
  $ A = integral_(x_1)^(x_2) f(x) dif x = integral_(t_1)^(t_2) y(t) dot(x)(t) dif t $
  (Parameterform: $y$ ist die Höhe, $dif x = dot(x) dif t$ die Breite des Streifens.)
]

#formel[Fläche zwischen Kurve und $y$-Achse][
  $ A = integral_(y_1)^(y_2) x dif y = integral_(t_1)^(t_2) x(t) dot(y)(t) dif t = integral_(x_1)^(x_2) x f'(x) dif x $
  (Waagrechte Streifen der Länge $x$ und der Dicke $dif y = dot(y) dif t = f'(x) dif x$.)
]

#fgs(("a04_param_x", "a04_param_y"), [Links senkrechte Streifen $y dif x$ bis zur $x$-Achse, rechts waagrechte Streifen $x dif y$ bis zur $y$-Achse.])

#formel[Fläche zwischen zwei Kurven][
  $ A = integral_a^b (g(x) - f(x)) dif x quad "mit" g >= f "auf" [a, b] $
  Die Grenzen sind meist die Schnittpunkte. Wechseln $f$ und $g$ die Rolle, muss man aufteilen.
]

#alltag[
  - Die Fläche eines Grundstücks, das an einen Bach grenzt, misst ein Geometer mit genau dieser Formel: Bachufer als Funktion, Integral bis zur geraden Grundstücksgrenze.
  - Die *Arbeit eines Motors* pro Takt ist die Fläche, die die Kurve im Druck-Volumen-Diagramm einschliesst. Je grösser die Fläche, desto mehr Arbeit.
]

#bsp[Zwischen Gerade und Parabel][
  #grid(columns: (1fr, 5.6cm), column-gutter: 12pt, align: horizon,
  [
    Fläche zwischen $f(x) = x^2$ und $g(x) = x + 2$.

    *Schnittpunkte:* $x^2 = x + 2 <=> x^2 - x - 2 = 0 <=> x = -1$ oder $x = 2$.

    *Wer liegt oben?* Bei $x = 0$: $g = 2 > f = 0$.
    $ A = integral_(-1)^2 (x + 2 - x^2) dif x = [x^2/2 + 2x - x^3/3]_(-1)^2 $
    $ = (2 + 4 - 8/3) - (1/2 - 2 + 1/3) = 10/3 + 7/6 = 9/2. $
  ],
  image("figs/a04_zwischen.svg", width: 100%))
]

#bsp[Ellipse und $y$-Achse][
  #grid(columns: (1fr, 5.0cm), column-gutter: 12pt, align: horizon,
  [
    Ellipse $x(t) = a cos t$, $y(t) = b sin t$. Gesucht ist die Fläche zwischen dem Bogen für $t in [0, pi\/3]$ und der $y$-Achse.

    $x(t) dot(y)(t) = a cos t dot b cos t = a b cos^2 t$, also
    $ A = a b integral_0^(pi\/3) cos^2 t dif t. $
  ],
  image("figs/a04_ellipse_y.svg", width: 100%))
  Mit $cos^2 t = (1 + cos 2t)\/2$:
  $ A = (a b)/2 [t + (sin 2t)/2]_0^(pi\/3) = (a b)/2 (pi/3 + sqrt(3)/4) = a b (4 pi + 3 sqrt(3))/24. $
  Kontrolle: Für $t in [0, pi\/2]$ käme $a b pi\/4$ heraus, ein Viertel der Ellipsenfläche $pi a b$. Unser Wert $approx 0.74 a b$ ist etwas kleiner als $pi\/4 approx 0.785$, das passt.
]

#bsp[Fläche unter einem Zykloidenbogen][
  Ein Rad mit Radius $1$ rollt auf der $x$-Achse. Ein Punkt am Rand beschreibt die Zykloide $x(t) = t - sin t$, $y(t) = 1 - cos t$; ein Bogen gehört zu einer Umdrehung, $t in [0, 2 pi]$. Mit der Parameterform $A = integral y dot(x) dif t$ und $dot(x) = 1 - cos t$:
  $ A = integral_0^(2 pi) (1 - cos t)^2 dif t = integral_0^(2 pi) (1 - 2 cos t + cos^2 t) dif t = 2 pi - 0 + pi = 3 pi. $
  Dabei ist $integral_0^(2 pi) cos^2 t dif t = pi$, weil $cos^2$ über eine Periode im Mittel $1\/2$ ist.
  #align(center, image("figs/a04_zykloide.svg", width: 82%))
  Die Fläche unter einem Bogen ist genau *dreimal die Fläche des rollenden Rades* (Roberval, um 1634). Die Formel funktioniert hier ohne Aufteilen, weil $x(t)$ monoton wächst ($dot(x) = 1 - cos t >= 0$): Jeder Streifen $y dif x$ wird genau einmal und mit positivem Vorzeichen gezählt. Läuft eine Kurve stellenweise nach links ($dot(x) < 0$), zählen die Streifen dort negativ.
]

#formel[Sektorfläche][
  Fläche, die der Ortsvektor beim Durchlaufen der Kurve überstreicht (vom Ursprung aus):
  $ A = 1/2 integral_(t_1)^(t_2) (x dot(y) - dot(x) y) dif t = 1/2 integral_(phi_1)^(phi_2) r(phi)^2 dif phi. $
]

#grid(columns: (1fr, 4.4cm), column-gutter: 12pt, align: horizon,
  warum[Sektorformel][Ein schmaler Sektor mit Winkel $dif phi$ ist fast ein Dreieck mit zwei Seiten der Länge $r$ und dem Winkel $dif phi$ dazwischen. Seine Fläche ist $1/2 r dot r dif phi = 1/2 r^2 dif phi$. Für einen Kreis ($r = R$) und den vollen Winkel $2 pi$ ergibt das $pi R^2$. #sym.checkmark],
  image("figs/a04_sektor.svg", width: 100%))

#bsp[Sektorfläche der archimedischen Spirale][
  #grid(columns: (1fr, 6.0cm), column-gutter: 12pt, align: horizon,
  [
    $r(phi) = 1 + phi$, gesucht ist der Sektor zwischen $phi_1 = pi\/6$ und $phi_2 = 5 pi\/6$.
    $ A = 1/2 integral_(pi\/6)^(5pi\/6) (1 + phi)^2 dif phi = 1/2 [(1 + phi)^3/3]_(pi\/6)^(5pi\/6). $
    Die Stammfunktion $(1+phi)^3\/3$ (lineare Substitution) spart das Ausmultiplizieren.
  ],
  image("figs/a04_spirale.svg", width: 100%))
  Ausgerechnet (oder über $(phi^2 + 2phi + 1)$ wie in der Vorlage):
  $ A = 1/2 [(125 pi^3 - pi^3)/(3 dot 216) + (25 pi^2 - pi^2)/36 + (5pi - pi)/6] = (31 pi^3)/324 + pi^2/3 + pi/3 approx 7.30. $
]

#merke[*Vorzeichen.* Ohne Betrag liefert die Sektorformel eine Fläche mit Vorzeichen: In Polarkoordinaten ist $x dot(y) - y dot(x) = r^2 dot(phi)$. Dreht der Ortsvektor im Gegenuhrzeigersinn ($dot(phi) > 0$), ist der Beitrag positiv, im Uhrzeigersinn negativ. Deshalb steht in der Formel für geschlossene Kurven unten der Betrag.]

#formel[Fläche zwischen zwei Polarkurven][Liegt für $phi in [phi_1, phi_2]$ die Kurve $r_1(phi)$ innen und $r_2(phi)$ aussen, so ist die Fläche dazwischen
$ A = 1/2 integral_(phi_1)^(phi_2) (r_2(phi)^2 - r_1(phi)^2) dif phi. $
Bei zwei aufeinanderfolgenden Windungen derselben Spirale ist $r_2(phi) = r(phi + 2 pi)$.]

#bsp[Zwischen zwei Windungen der Spirale $r = e^phi$][
  #grid(columns: (1fr, 5.0cm), column-gutter: 12pt, align: horizon,
  [
    Gesucht ist die Fläche im ersten Quadranten zwischen der ersten Windung ($0 <= phi <= pi\/2$) und der zweiten ($2 pi <= phi <= 5 pi\/2$). Äussere minus innere Windung, beide über denselben Winkelbereich:
    $ A &= 1/2 integral_0^(pi\/2) (e^(2(phi + 2 pi)) - e^(2 phi)) dif phi \
      &= 1/2 (e^(4 pi) - 1) integral_0^(pi\/2) e^(2 phi) dif phi \
      &= 1/4 (e^(4 pi) - 1)(e^pi - 1). $
  ],
  image("figs/a04_windungen.svg", width: 100%))
  Ausmultipliziert ist das die Form aus der Übung, $A = 1/4 (e^(5 pi) - e^(4 pi) - e^pi + 1) approx 1.59 dot 10^6$. Die Zahl ist riesig, weil $r$ bei jeder Umdrehung um den Faktor $e^(2 pi) approx 535$ wächst. Die Abbildung zeigt deshalb das Prinzip an der flacheren Spirale $r = e^(phi\/5)$; massstäblich wäre die innere Windung nicht zu sehen.
]

#formel[Fläche einer geschlossenen Kurve][Ist $vr(t_1) = vr(t_2)$ (die Kurve schliesst sich), so ist die eingeschlossene Fläche
$ A = |integral_(t_1)^(t_2) x dot(y) dif t| = |integral_(t_1)^(t_2) y dot(x) dif t| = 1/2 |integral_(t_1)^(t_2) (x dot(y) - y dot(x)) dif t|. $
Beispiel Ellipse: $integral_0^(2pi) a cos t dot b cos t dif t = pi a b$.]

#bsp[Ellipse, deren Rand durch den Ursprung geht][
  #grid(columns: (1fr, 5.2cm), column-gutter: 12pt, align: horizon,
  [
    $x = 2 cos t$, $y = 1 + sin t$, $t in [0, 2 pi]$: eine Ellipse mit Mittelpunkt $(0, 1)$ und Halbachsen $2$ und $1$. Der Ursprung liegt _auf_ dem Rand (bei $t = 3 pi\/2$).

    $dot(x) = -2 sin t$, $dot(y) = cos t$, also
    $ x dot(y) - y dot(x) = 2 cos^2 t + 2 (1 + sin t) sin t = 2 + 2 sin t. $
  ],
  image("figs/a04_ellipse_sektor.svg", width: 100%))
  $ A = 1/2 integral_0^(2 pi) (2 + 2 sin t) dif t = 1/2 [2 t - 2 cos t]_0^(2 pi) = 2 pi. $
  Kontrolle: Ellipsenfläche $pi a b = pi dot 2 dot 1 = 2 pi$ #sym.checkmark
]

#warum[Bei geschlossenen Kurven ist die Lage des Ursprungs egal][
  Verschiebt man den Ursprung um $(c_1, c_2)$, so wird aus $x dot(y) - y dot(x)$ der Ausdruck $(x - c_1) dot(y) - (y - c_2) dot(x)$. Der Unterschied $-c_1 dot(y) + c_2 dot(x)$ hat das Integral $-c_1 (y(t_2) - y(t_1)) + c_2 (x(t_2) - x(t_1))$, und das ist null, weil die Kurve dort endet, wo sie angefangen hat. Anschaulich: Was der Ortsvektor ausserhalb der Kurve überstreicht, überstreicht er später in umgekehrter Richtung wieder, und die beiden Beiträge heben sich auf. Darum darf der Ursprung innen, aussen oder wie hier auf dem Rand liegen. Bei einem _offenen_ Kurvenstück gilt das nicht: Dort hängt die Sektorfläche vom Ursprung ab.
]

=== Bogenlänge

#grid(columns: (1fr, 4.6cm), column-gutter: 12pt, align: horizon,
  [
    Ein kurzes Kurvenstück ist fast gerade. Nach Pythagoras ist seine Länge
    $ dif s = sqrt((dif x)^2 + (dif y)^2) = sqrt(dot(x)^2 + dot(y)^2) dif t. $
    Alle Stücke aufaddiert:
  ],
  image("figs/a04_bogen.svg", width: 100%))

#formel[Bogenlänge][
  $ L = integral_(t_1)^(t_2) |dot(vr)(t)| dif t = integral_(t_1)^(t_2) sqrt(dot(x)^2 + dot(y)^2) dif t = integral_(x_1)^(x_2) sqrt(1 + f'(x)^2) dif x = integral_(phi_1)^(phi_2) sqrt(r^2 + dot(r)^2) dif phi $
  In Worten: Geschwindigkeit (Betrag) mal Zeit.
]

#bsp[Zwei Kontrollen][
  - *Kreisumfang:* $vr(t) = (R cos t, R sin t)$, $|dot(vr)| = sqrt(R^2 sin^2 t + R^2 cos^2 t) = R$, also $L = integral_0^(2pi) R dif t = 2 pi R$. #sym.checkmark
  - *Strecke:* $y = 3\/4 thin x$ für $0 <= x <= 4$. $sqrt(1 + f'^2) = sqrt(1 + 9\/16) = 5\/4$, also $L = 5\/4 dot 4 = 5$: die Hypotenuse des Dreiecks mit den Katheten $4$ und $3$. #sym.checkmark
  Solche Kontrollen an Kurven mit bekannter Länge sind die schnellste Art, eine Formel oder eine Rechnung zu prüfen.
]

#bsp[Länge eines Zykloidenbogens][
  $x = t - sin t$, $y = 1 - cos t$, $t in [0, 2 pi]$ wie oben. $dot(x) = 1 - cos t$, $dot(y) = sin t$:
  $ dot(x)^2 + dot(y)^2 = 1 - 2 cos t + cos^2 t + sin^2 t = 2 - 2 cos t = 4 sin^2 (t/2), $
  mit der Halbwinkelformel $1 - cos t = 2 sin^2 (t\/2)$. Also $sqrt(dot(x)^2 + dot(y)^2) = 2 |sin(t\/2)|$. Für $t in [0, 2 pi]$ liegt $t\/2$ in $[0, pi]$, dort ist $sin(t\/2) >= 0$, und der Betrag fällt weg. Mit $u = t\/2$, $dif t = 2 dif u$:
  $ L = integral_0^(2 pi) 2 sin(t/2) dif t = integral_0^pi 4 sin u dif u = [-4 cos u]_0^pi = 8. $
  Ein Bogen ist genau *vier Raddurchmesser* lang (Wren, 1658), mehr als der Weg $2 pi approx 6.28$, den die Nabe in derselben Zeit zurücklegt. Der Randpunkt ist mal schneller, mal langsamer als die Nabe (oben doppelt so schnell, unten steht er still), im Mittel aber schneller.
]

#fehler[Den Betrag unter der Wurzel vergessen: $sqrt(4 sin^2 u) = 2 |sin u|$, nicht $2 sin u$. Über zwei Zykloidenbögen ($t in [0, 4 pi]$) gäbe $integral 2 sin(t\/2) dif t$ null statt $16$. Immer prüfen, welches Vorzeichen der Ausdruck auf dem Intervall hat, und notfalls aufteilen.]

#bsp[Bogenlänge einer logarithmischen Spirale][
  #grid(columns: (1fr, 5.6cm), column-gutter: 12pt, align: horizon,
  [
    $r(phi) = e^(0.5 phi)$, $phi in [0, 1]$.

    $dot(r) = 0.5 e^(0.5 phi)$, also
    $ r^2 + dot(r)^2 = e^phi + 0.25 e^phi = 5/4 e^phi, $
    $ sqrt(r^2 + dot(r)^2) = sqrt(5)/2 e^(phi\/2). $
  ],
  image("figs/a04_logspirale.svg", width: 100%))
  $ L = sqrt(5)/2 integral_0^1 e^(phi\/2) dif phi = sqrt(5)/2 [2 e^(phi\/2)]_0^1 = sqrt(5) (e^(1\/2) - 1) approx 1.45. $
  Allgemein gilt für $r = e^(c phi)$: $sqrt(r^2 + dot(r)^2) = sqrt(1 + c^2) thin r$, also $L = sqrt(1 + c^2)\/c dot (r(phi_2) - r(phi_1))$. Die Bogenlänge ist proportional zum Zuwachs des Radius. Für $r = e^phi$ und $phi in [0, pi\/2]$ ergibt das $L = sqrt(2) (e^(pi\/2) - 1) approx 5.39$.
]

#alltag[Wie viel Kabel braucht eine Stromleitung zwischen zwei Masten, die 300 m auseinanderstehen und deren Kabel durchhängt? Die Bogenlänge der Kettenlinie $y = a cosh(x\/a)$; dank $1 + sinh^2 = cosh^2$ lässt sich das Integral exakt lösen. Auch ein Velocomputer misst eine Bogenlänge: Er zählt Radumdrehungen und multipliziert mit dem Umfang, egal wie kurvig der Weg ist.]

#merke[Bogenlängen führen oft auf schwierige Integrale, weil die Wurzel stört. Aufgaben sind deshalb meist so gebaut, dass unter der Wurzel ein vollständiges Quadrat entsteht, z. B. $1 + sinh^2 = cosh^2$ oder $(a + b)^2$. Wenn sich die Wurzel nicht auflöst, nochmals rechnen!]

=== Volumen

#formel[Rotationskörper um die $x$-Achse (Scheibenmethode)][
  $ V = pi integral_(x_1)^(x_2) f(x)^2 dif x = pi integral_(t_1)^(t_2) y(t)^2 dot(x)(t) dif t $
]

#fg("a04_rotx", [Der Körper wird in dünne Scheiben zerschnitten. Eine Scheibe an der Stelle $x$ ist ein Zylinder mit Radius $f(x)$ und Dicke $dif x$, ihr Volumen also $pi f(x)^2 dif x$.], w: 62%)

#formel[Rotationskörper um die $y$-Achse][
  $ V = pi integral_(y_1)^(y_2) x^2 dif y = pi integral_(t_1)^(t_2) x(t)^2 dot(y)(t) dif t = pi integral_(x_1)^(x_2) x^2 f'(x) dif x quad "(Scheiben)" $
  $ V = 2 pi integral_a^b x f(x) dif x quad "(Zylinderschalen: Fläche unter " f " zwischen " a " und " b " um die " y "-Achse)" $
]

#intu[Bei der *Schalenmethode* zerlegt man in dünne Zylinderröhren statt in Scheiben. Eine Röhre im Abstand $x$ hat den Umfang $2 pi x$, die Höhe $f(x)$ und die Dicke $dif x$; aufgeschnitten und flach gelegt ist sie ein Quader mit Volumen $2 pi x f(x) dif x$.]

#alltag[Johannes Kepler kam 1613 auf die Volumenrechnung mit dünnen Scheiben, weil ihn bei seiner Hochzeit ärgerte, wie grob die Weinhändler den Inhalt von Fässern schätzten. Heute rechnen so Ingenieure das Volumen von Tanks, Flaschen und Drehteilen. Ein Füllstandsanzeiger in einem liegenden zylindrischen Tank zeigt nicht linear an, weil das Volumen bis zur Höhe $h$ ein solches Integral ist.]

#bsp[Rotationsvolumen][
  #grid(columns: (1fr, 4.4cm), column-gutter: 12pt, align: horizon,
  [
    Die Fläche wird begrenzt von der Strecke von $(0, -1)$ nach $(0, 1)$ und zwei nach rechts geöffneten Parabelbögen, die in $(0, plus.minus 1)$ die $y$-Achse berühren und sich in $(1, 0)$ treffen. Sie rotiert um die $x$-Achse.

    *Kurve bestimmen.* Der obere Bogen ist eine Parabel $x = (y - 1)^2$: Scheitel in $(0, 1)$ (dort berührt sie die $y$-Achse), und $y = 0$ gibt $x = 1$. #sym.checkmark
  ],
  image("figs/a04_rotbsp.svg", width: 100%))
  Nach $y$ auflösen: $y - 1 = plus.minus sqrt(x)$. Der obere Bogen läuft von $y = 1$ nach $y = 0$, also gilt das Minus: $f(x) = 1 - sqrt(x)$, $x in [0, 1]$. Der untere Bogen ist das Spiegelbild und liefert beim Rotieren nichts Neues.
  $ V = pi integral_0^1 (1 - sqrt(x))^2 dif x = pi integral_0^1 (1 - 2 sqrt(x) + x) dif x = pi [x - 4/3 x^(3\/2) + x^2/2]_0^1 = pi (1 - 4/3 + 1/2) = pi/6. $
]

#formel[Volumen aus der Querschnittsfläche (Prinzip von Cavalieri)][Hat der Körper an der Stelle $z$ den Querschnitt mit Fläche $F(z)$:
$ V = integral_(z_1)^(z_2) F(z) dif z. $]

#bsp[Kegel][
  #grid(columns: (1fr, 4.6cm), column-gutter: 12pt, align: horizon,
  [
    Kegel der Höhe $4$ mit Grundkreisradius $1$. Jeder waagrechte Schnitt ist ein Kreis, dessen Radius linear von $1$ (unten, $z = 0$) auf $0$ (oben, $z = 4$) abnimmt:
    $ r(z) = 1 - z/4 = (4 - z)/4, wide F(z) = pi ((4 - z)/4)^2. $
    $ V = pi/16 integral_0^4 (4 - z)^2 dif z = pi/16 [-(4 - z)^3/3]_0^4 = pi/16 dot 64/3 = (4 pi)/3. $
    Kontrolle mit der Kegelformel $V = 1/3 pi r^2 h = 1/3 pi dot 1 dot 4$. #sym.checkmark
  ],
  image("figs/a04_kegel.svg", width: 100%))
]

=== Oberflächen

#formel[Mantelfläche eines Rotationskörpers][
  um die $x$-Achse: $ A = 2 pi integral_(t_1)^(t_2) y(t) sqrt(dot(x)^2 + dot(y)^2) dif t = 2 pi integral_(x_1)^(x_2) f(x) sqrt(1 + f'(x)^2) dif x $
  um die $y$-Achse: $ A = 2 pi integral_(t_1)^(t_2) x(t) sqrt(dot(x)^2 + dot(y)^2) dif t $
]

#intu[Ein Bogenstück $dif s$ im Abstand $y$ von der Achse beschreibt beim Rotieren ein schmales Band mit Umfang $2 pi y$ und Breite $dif s$. Fläche: $2 pi y dif s$. Achtung: Man nimmt $dif s$ (die schräge Länge), nicht $dif x$. Mit $dif x$ würde man bei steilen Kurven viel zu wenig Fläche zählen.]

#alltag[Die Mantelfläche braucht man, um zu wissen, wie viel Blech für einen Trichter, Stoff für einen Lampenschirm oder Lack für eine Kuppel nötig ist. Wichtig ist hier, dass man $dif s$ und nicht $dif x$ nimmt; ein Lackierer, der mit $dif x$ rechnet, kauft bei steilen Formen viel zu wenig Farbe.]

#bsp[Oberfläche][
  #grid(columns: (1fr, 5.2cm), column-gutter: 12pt, align: horizon,
  [
    Die Kurve $gamma(t) = (2t, 2(cosh t - 1))$, $t in [0, 1]$, rotiert um die $x$-Achse.

    $dot(x) = 2$, $dot(y) = 2 sinh t$. Unter der Wurzel:
    $ sqrt(4 + 4 sinh^2 t) = 2 sqrt(1 + sinh^2 t) = 2 cosh t. $
    (Das vollständige Quadrat, siehe oben.)
  ],
  image("figs/a04_flbsp.svg", width: 100%))
  $ A = 2 pi integral_0^1 2(cosh t - 1) dot 2 cosh t dif t = 8 pi integral_0^1 (cosh^2 t - cosh t) dif t. $
  Mit $cosh^2 t = (cosh 2t + 1)\/2$ ist $integral cosh^2 t dif t = (sinh 2t)\/4 + t\/2$. Also
  $ A = 8 pi [(sinh 2t)/4 + t/2 - sinh t]_0^1 = 8 pi ((sinh 2)/4 + 1/2 - sinh 1) approx 5.82. $
]

=== Flächenschwerpunkt

#formel[Schwerpunkt einer ebenen Fläche][
  $ A = integral_(x_1)^(x_2) H(x) dif x = integral_(y_1)^(y_2) B(y) dif y, wide x_S = 1/A integral_(x_1)^(x_2) x H(x) dif x, wide y_S = 1/A integral_(y_1)^(y_2) y B(y) dif y $
  $H(x)$: Höhe der Fläche an der Stelle $x$. $B(y)$: Breite der Fläche auf der Höhe $y$.\
  Für die Fläche unter einem Graphen $f >= 0$ gilt zusätzlich $y_S = display(1/(2A) integral_(x_1)^(x_2) f(x)^2 dif x)$.
]

#grid(columns: (1fr, 5.0cm), column-gutter: 12pt, align: horizon,
  intu[Der Schwerpunkt ist der gewichtete Mittelwert der Positionen. Jeder senkrechte Streifen bei $x$ hat die Fläche $H(x) dif x$ und zählt mit diesem Gewicht. Die Formel für $y_S$ unter einem Graphen kommt daher, dass der Schwerpunkt eines senkrechten Streifens auf halber Höhe $f\/2$ liegt: $integral (f\/2) dot f dif x$.],
  image("figs/a04_schwerpunkt.svg", width: 100%))

#alltag[Ein Gegenstand kippt, sobald sein Schwerpunkt über die Kante hinausragt. Deshalb sind Lastwagen mit hoher Ladung in Kurven gefährlich, und deshalb liegt bei Schiffen schwerer Ballast unten. Ein Lineal kannst du auf dem Finger balancieren, wenn der Finger genau unter dem Schwerpunkt ist. In der Mechanik ersetzt man das Gewicht eines ganzen Körpers durch eine einzige Kraft im Schwerpunkt; dafür braucht man diese Integrale.]

#bsp[Halbkreisscheibe][
  $f(x) = sqrt(r^2 - x^2)$ auf $[-r, r]$, $A = pi r^2\/2$. Aus Symmetrie $x_S = 0$.
  $ y_S = 1/(2A) integral_(-r)^r (r^2 - x^2) dif x = 1/(pi r^2) [r^2 x - x^3/3]_(-r)^r = 1/(pi r^2) dot (4 r^3)/3 = (4 r)/(3 pi) approx 0.42 r. $
]

#merke[*Symmetrie zuerst!* Hat die Fläche eine Symmetrieachse, liegt der Schwerpunkt darauf. Das spart oft die Hälfte der Rechnung.]

=== Trägheitsmomente

#formel[Flächenträgheitsmomente][
  $ I_x = integral_(y_1)^(y_2) y^2 B(y) dif y, wide I_y = integral_(x_1)^(x_2) x^2 H(x) dif x, wide I_p = I_x + I_y "(polar)" $
]

#intu[Wie der Schwerpunkt, nur werden die Flächenstücke mit dem *Quadrat* des Abstands gewichtet. Weit entfernte Teile zählen deshalb besonders viel. Darum sind Doppel-T-Träger so steif: Das Material sitzt möglichst weit weg von der Mitte.]

#alltag[
  - *Eiskunstläuferin:* Zieht sie bei der Pirouette die Arme an, bringt sie Masse näher an die Drehachse, das Trägheitsmoment sinkt, und weil der Drehimpuls $Theta omega$ gleich bleibt, dreht sie schneller.
  - *Stahlträger* haben die Form eines I (Doppel-T): Fast das ganze Material sitzt oben und unten, weit weg von der Mitte. Weil der Abstand im Quadrat zählt, ist der Träger damit viel steifer als ein Vollprofil gleichen Gewichts.
  - Ein *Schwungrad* hat seine Masse aussen im Kranz, um möglichst viel Energie $1/2 Theta omega^2$ zu speichern.
]

#bsp[Rechteck][
  Rechteck der Breite $b$ und Höhe $h$, Unterkante auf der $x$-Achse. $B(y) = b$:
  $ I_x = integral_0^h y^2 b dif y = (b h^3)/3. $
  Bezogen auf die Schwerachse (von $-h\/2$ bis $h\/2$) ergibt sich die bekannte Formel $b h^3\/12$.
]

#formel[Massenträgheitsmoment][
  Rotationskörper mit Dichte $rho$, der durch Rotation von $f$ um die $x$-Achse entsteht, bezüglich der $x$-Achse:
  $ Theta_x = (pi rho)/2 integral_a^b f(x)^4 dif x. $
  Allgemeiner (Dichte $rho(x)$, Breite $G(x)$ senkrecht zur $x$-Achse), bezüglich der $y$-Achse: $Theta_y = integral_a^b rho(x) x^2 G(x) dif x$. Rotationsenergie: $T = 1/2 Theta omega^2$.
]

#warum[Woher $f^4$?][Eine dünne Scheibe mit Radius $f$ und Dicke $dif x$ hat die Masse $dif m = rho pi f^2 dif x$ und als Vollzylinder das Trägheitsmoment $1/2 dif m dot f^2 = (pi rho)/2 f^4 dif x$. Probe: Zylinder ($f = R$ auf $[0, L]$) gibt $(pi rho)/2 R^4 L = 1/2 m R^2$. #sym.checkmark]

== Uneigentliche Integrale

#idee[Bisher waren Integrationsintervall und Integrand beschränkt. Was ist mit $integral_1^oo 1\/x^2 dif x$ (unendlich langes Intervall) oder $integral_0^1 1\/sqrt(x) dif x$ (Integrand wird unendlich)? Man rechnet zuerst mit einer endlichen Grenze und lässt diese dann gegen die kritische Stelle laufen. Erstaunlich: Eine unendlich lange Fläche kann endlich gross sein.]

#text(size: 9pt, style: "italic")[Zur Benennung: Die Vorlage nennt Integrale mit unbeschränktem Integrand «1. Gattung» und solche mit unendlichem Intervall «2. Gattung». In vielen Büchern ist es genau umgekehrt. Merke dir lieber den Typ als die Nummer.]

=== Unbeschränkter Integrand

#defn[Uneigentliches Integral, Integrand unbeschränkt][Ist $f$ auf $[a, b)$ stetig, aber bei $b$ nicht definiert (Pol, Definitionslücke), so setzt man
$ integral_a^b f(x) dif x := lim_(epsilon -> b^-) integral_a^epsilon f(x) dif x = lim_(epsilon -> b^-) [F(x)]_a^epsilon. $
Existiert der Grenzwert, heisst das Integral *konvergent*, sonst *divergent*. Analog an der unteren Grenze.]

#bsp[Konvergent: $integral_0^1 ln x dif x$][
  #grid(columns: (1fr, 4.6cm), column-gutter: 12pt, align: horizon,
  [
    $ln x$ ist bei $0$ nicht definiert ($-> -oo$). Mit der Stammfunktion $x(ln x - 1)$:
    $ integral_0^1 ln x dif x = lim_(epsilon -> 0^+) [x(ln x - 1)]_epsilon^1 = lim_(epsilon -> 0^+) ((0 - 1) - epsilon ln epsilon + epsilon). $
    Mit l'Hôpital: $display(lim epsilon ln epsilon = lim (ln epsilon)/(1\/epsilon) = lim (1\/epsilon)/(-1\/epsilon^2) = lim (-epsilon) = 0)$.
    $ integral_0^1 ln x dif x = -1. $
  ],
  image("figs/a04_ln.svg", width: 100%))
  Die Fläche reicht unendlich tief hinunter und ist trotzdem endlich (mit Vorzeichen $-1$).
]

#bsp[Divergent: $integral_0^1 1/x dif x$][
  $ lim_(epsilon -> 0^+) [ln x]_epsilon^1 = lim_(epsilon -> 0^+) (0 - ln epsilon) = +oo. $
  Das Integral divergiert.
]

=== Unendliches Intervall

#defn[Uneigentliches Integral, unendliches Intervall][
  $ integral_a^oo f(x) dif x := lim_(R -> oo) integral_a^R f(x) dif x = lim_(R -> oo) [F(x)]_a^R. $
  Bei zwei unendlichen Grenzen teilt man an einer beliebigen Stelle $c$ auf:
  $ integral_(-oo)^oo f dif x = integral_(-oo)^c f dif x + integral_c^oo f dif x. $
  Konvergent ist das nur, wenn *beide* Teile einzeln konvergieren.
]

#fehler[Nicht $lim_(R -> oo) integral_(-R)^R f dif x$ rechnen! Für $f(x) = x$ gibt das $0$, obwohl $integral_0^oo x dif x$ divergiert. Die beiden Grenzen müssen unabhängig voneinander gegen $plus.minus oo$ gehen.]

#bsp[Zwei unendliche Grenzen: $integral_(-oo)^oo 1/(1 + x^2) dif x$][
  Aufteilen bei $c = 0$:
  $ integral_(-oo)^0 1/(1+x^2) dif x = lim_(R -> -oo) [arctan x]_R^0 = 0 - (-pi/2) = pi/2, wide integral_0^oo 1/(1+x^2) dif x = lim_(R -> oo) [arctan x]_0^R = pi/2. $
  Beide konvergieren, also $integral_(-oo)^oo 1\/(1 + x^2) dif x = pi$.
  #align(center, image("figs/a04_lorentz.svg", width: 62%))
]

#bsp[Divergent: $integral_1^oo 1/x dif x$][
  $ lim_(R -> oo) [ln x]_1^R = lim_(R -> oo) ln R = oo. $
  Obwohl $1\/x -> 0$, fällt die Funktion zu langsam: Die Fläche wird unendlich.
]

=== Konvergenzkriterien

#satz[Die wichtigsten Vergleichsintegrale][
  $ integral_1^oo 1/x^p dif x quad "konvergiert genau dann, wenn" p > 1 quad ("dann" = 1/(p - 1)) $
  $ integral_0^1 1/x^p dif x quad "konvergiert genau dann, wenn" p < 1 quad ("dann" = 1/(1 - p)) $
  Ausserdem $integral_0^oo e^(-a x) dif x = 1\/a$ für $a > 0$.
]

#fg("a04_px", [$1\/x$ und $1\/x^2$ sehen ähnlich aus, aber $1\/x^2$ fällt schnell genug: Die grüne Fläche ab $x = 1$ ist $1$, die rote (unter $1\/x$) ist unendlich.], w: 62%)

#satz[Vergleichskriterium][Ist $0 <= f(x) <= g(x)$ für alle grossen $x$, dann gilt:
- $integral^oo g$ konvergiert $=>$ $integral^oo f$ konvergiert (Majorante).
- $integral^oo f$ divergiert $=>$ $integral^oo g$ divergiert (Minorante).]

#bsp[Vergleichskriterium][
  - $integral_1^oo e^(-x^2) dif x$: Für $x >= 1$ ist $x^2 >= x$, also $e^(-x^2) <= e^(-x)$, und $integral_1^oo e^(-x) dif x = 1\/e$ konvergiert. Also konvergiert auch $integral_1^oo e^(-x^2) dif x$, obwohl man es nicht elementar ausrechnen kann.
  - $integral_1^oo (2 + sin x)/x dif x$: Es ist $(2 + sin x)\/x >= 1\/x$, und $integral_1^oo 1\/x$ divergiert. Also divergiert auch dieses Integral.
  - $integral_1^oo 1/(x^2 + x) dif x$: $1\/(x^2 + x) <= 1\/x^2$, konvergent. (Mit Partialbrüchen findet man den Wert $ln 2$.)
]

#alltag[
  - *Fluchtgeschwindigkeit.* Um eine Rakete der Masse $m$ aus dem Schwerefeld der Erde zu bringen, muss man gegen die Kraft $G M m\/r^2$ bis ins Unendliche Arbeit leisten. Das Integral $integral_R^oo G M m\/r^2 dif r = G M m\/R$ ist endlich (vom Typ $1\/x^2$). Setzt man diese Arbeit gleich der Bewegungsenergie $1/2 m v^2$, folgt $v = sqrt(2 G M\/R) approx 11.2$ km/s. Wer so schnell startet, kommt nie zurück.
  - *Gabriels Horn.* Dreht man $y = 1\/x$ für $x >= 1$ um die $x$-Achse, entsteht ein unendlich langes Horn mit dem endlichen Volumen $pi integral_1^oo 1\/x^2 dif x = pi$, aber unendlicher Oberfläche (sie ist grösser als $2 pi integral_1^oo 1\/x dif x$). Man könnte es also mit Farbe füllen, aber nicht anmalen.
]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Wasserdruck auf die Staumauer.* Der Druck im Wasser wächst mit der Tiefe: $p(y) = rho g y$. Die Kraft auf einen Meter Mauerbreite ist deshalb das Integral $F = integral_0^h rho g y thin dif y = rho g h^2\/2$. Bei $h = 100$ m sind das $approx 49$ MN, also das Gewicht von rund $5000$ Tonnen, die an jedem Meter Mauer drücken. Wegen des Faktors $h^2$ verdoppelt sich die Kraft nicht, wenn die Mauer doppelt so hoch ist, sondern vervierfacht sich. Darum werden Staumauern unten dick gebaut. Ohne Integral wäre diese Rechnung nur durch Raten möglich.]

#alltag[*Effektivwert: warum die Steckdose $230$ V und nicht $325$ V heisst.* Die Spannung schwingt zwischen $-325$ V und $+325$ V. Wichtig ist, wie viel Leistung sie im Mittel liefert, und das ist der quadratische Mittelwert $U_("eff") = sqrt(1\/T integral_0^T u(t)^2 thin dif t) = hat(u)\/sqrt(2)$. Mit $hat(u) = 325$ V ergibt das $325\/1.414 approx 230$ V. Der «Effektivwert» ist das, was auf dem Typenschild jedes Geräts steht. Dasselbe Prinzip steckt im Mittel von Lärm (Schallpegel), von Vibrationen und von Messfehlern.]

#alltag[*Wahrscheinlichkeiten als Flächen.* Wie gross ist die Chance, dass eine Maschine ein Teil produziert, das mehr als $0.1$ mm zu gross ist? Dafür integriert man die Dichtefunktion der Normalverteilung von $0.1$ bis unendlich. Die Fläche unter der Glockenkurve zwischen $mu - sigma$ und $mu + sigma$ beträgt $68 %$, zwischen $mu plus.minus 2 sigma$ sind es $95 %$, zwischen $mu plus.minus 3 sigma$ $99.7 %$. Qualitätssicherung («Six Sigma»), Versicherungen, Wetterprognosen und jede Umfrage mit «Fehlermarge» beruhen darauf. Ein bestimmtes Integral ist hier buchstäblich eine Wahrscheinlichkeit.]

#photo(("a_hoover",), [Die Hoover-Staumauer ist 221 m hoch. Der Wasserdruck wächst linear mit der Tiefe, die Gesamtkraft ist ein Integral. #credit[Dietmar Rabich, CC BY-SA 4.0, Wikimedia Commons]], ht: 5cm)
// ALLTAG-END

#aufgaben()

#aufg[Partielle Integration und Substitution][
  Berechne (a) $display(integral_0^1 x e^(2x) dif x)$, (b) $display(integral_1^e (ln x)^2/x dif x)$, (c) $display(integral x^3 sqrt(1 + x^2) dif x)$.
][
  (a) $v = x$, $u' = e^(2x)$, $u = e^(2x)\/2$:
  $ [x e^(2x)/2]_0^1 - integral_0^1 e^(2x)/2 dif x = e^2/2 - [e^(2x)/4]_0^1 = e^2/2 - e^2/4 + 1/4 = (e^2 + 1)/4. $
  (b) $u = ln x$, $dif u = dif x \/ x$, Grenzen $0$ bis $1$: $integral_0^1 u^2 dif u = 1\/3$.

  (c) $u = 1 + x^2$, $dif u = 2x dif x$, $x^2 = u - 1$:
  $ integral x^2 sqrt(1 + x^2) dot x dif x &= 1/2 integral (u - 1) sqrt(u) dif u = 1/2 (2/5 u^(5\/2) - 2/3 u^(3\/2)) + C \
  &= (1 + x^2)^(5\/2)/5 - (1 + x^2)^(3\/2)/3 + C. $
]

#aufg[Partialbruchzerlegung][
  Berechne $display(integral (3x + 1)/((x - 1)^2 (x + 2)) dif x)$.
][
  Ansatz für die doppelte Nullstelle: $display(A/(x - 1) + B/(x - 1)^2 + C/(x + 2))$, also
  $ 3x + 1 = A(x - 1)(x + 2) + B(x + 2) + C(x - 1)^2. $
  - $x = 1$: $4 = 3B$, $B = 4\/3$.
  - $x = -2$: $-5 = 9C$, $C = -5\/9$.
  - Koeffizient von $x^2$: $0 = A + C$, $A = 5\/9$.
  $ integral dots dif x = 5/9 ln|x - 1| - 4/(3(x - 1)) - 5/9 ln|x + 2| + C. $
]

#aufg[Fläche, Volumen, Bogenlänge][
  Gegeben $f(x) = sqrt(x)$ auf $[0, 4]$. Berechne (a) die Fläche unter $f$, (b) das Volumen bei Rotation um die $x$-Achse, (c) die Länge der Kurve $y = 2\/3 x^(3\/2)$ von $x = 0$ bis $x = 3$.
][
  (a) $A = integral_0^4 x^(1\/2) dif x = [2/3 x^(3\/2)]_0^4 = 16/3$.

  (b) $V = pi integral_0^4 x dif x = 8 pi$.

  (c) $f'(x) = x^(1\/2)$, $sqrt(1 + f'^2) = sqrt(1 + x)$:
  $ L = integral_0^3 sqrt(1 + x) dif x = [2/3 (1 + x)^(3\/2)]_0^3 = 2/3 (8 - 1) = 14/3. $
]

#aufg[Flächen in Polarkoordinaten (Serie 11, Aufgabe 1)][
  Berechne für $0 <= phi <= 2 pi$ die vom Ortsvektor überstrichene Fläche von (a) $r = sqrt(phi)$, (b) $r = 1\/(1 + phi)$, (c) $r = |sin phi|$, (d) $r = 2 a (1 + cos phi)$ mit $a > 0$.
  #align(center, image("figs/a04_polar4.svg", width: 100%))
  #text(size: 8.5pt)[(Die vier Skizzen sind nicht im gleichen Massstab.)]
][
  Überall $A = 1/2 integral_0^(2 pi) r^2 dif phi$. Bei (a) und (b) schliesst sich die Kurve nicht; gemeint ist die Fläche zwischen Kurve und Ursprung, wie oben bei der Sektorfläche.

  (a) $r^2 = phi$: $A = 1/2 integral_0^(2 pi) phi dif phi = 1/2 dot (2 pi)^2/2 = pi^2 approx 9.87$.

  (b) $r^2 = (1 + phi)^(-2)$: $A = 1/2 [-(1 + phi)^(-1)]_0^(2 pi) = 1/2 (1 - 1/(1 + 2 pi)) = pi/(1 + 2 pi) approx 0.43$.

  (c) $r^2 = sin^2 phi = (1 - cos 2 phi)\/2$: $A = 1/2 dot pi = pi\/2$. Kontrolle: Die Kurve besteht aus zwei Kreisen mit Durchmesser $1$, zusammen $2 dot pi\/4 = pi\/2$ #sym.checkmark

  (d) $r^2 = 4 a^2 (1 + 2 cos phi + cos^2 phi)$. Über eine Periode ist $integral cos phi = 0$ und $integral cos^2 phi = pi$:
  $ A = 2 a^2 (2 pi + 0 + pi) = 6 pi a^2. $
  Die Herzkurve (Kardioide) hat also sechsmal die Fläche eines Kreises mit Radius $a$.
]

#aufg(fig: "a04_kleeblatt", fw: 4.6cm)[Das Kleeblatt (Serie 11, Aufgabe 2)][
  Gegeben ist $r(phi) = a |cos(2 phi)|$ mit $a > 0$. Gesucht sind die Gesamtfläche und die Breite $b$ des rechten Blattes (Abstand zwischen höchstem und tiefstem Punkt).
][
  *Fläche.* Das rechte Blatt beginnt und endet im Ursprung, also bei $cos 2 phi = 0$: $phi = plus.minus pi\/4$. Mit der Symmetrie zur $x$-Achse und $cos^2 2 phi = (1 + cos 4 phi)\/2$:
  $ A_"Blatt" = 1/2 integral_(-pi\/4)^(pi\/4) a^2 cos^2 2 phi dif phi = a^2 integral_0^(pi\/4) (1 + cos 4 phi)/2 dif phi = a^2 [phi/2 + (sin 4 phi)/8]_0^(pi\/4) = (pi a^2)/8. $
  Vier gleiche Blätter: $A = pi a^2 \/ 2$, genau die Hälfte des umschriebenen Kreises mit Radius $a$.

  *Breite.* Höhe eines Punktes: $y(phi) = r sin phi = a cos(2 phi) sin phi$ für $0 <= phi <= pi\/4$. Mit $s = sin phi$ und $cos 2 phi = 1 - 2 s^2$ wird daraus $y = a (s - 2 s^3)$. Da $s$ mit $phi$ monoton wächst, genügt $dif y \/ dif s = a (1 - 6 s^2) = 0$, also $s = 1\/sqrt(6)$ ($phi approx 24.1°$):
  $ y_max = a (1/sqrt(6) - 2/(6 sqrt(6))) = (2 a)/(3 sqrt(6)) = (sqrt(6))/9 a, wide b = 2 y_max = (2 sqrt(6))/9 a approx 0.544 a. $
]

#aufg(fig: "a04_vierflaechen", fw: 4.2cm)[Vier gleiche Teilflächen (Serie 11, Aufgabe 4)][
  Welche Fläche schliesst die Kurve $sqrt(|x|) + sqrt(|y|) = 1$ ein?
][
  Die Kurve ist symmetrisch zu beiden Achsen; es genügt der erste Quadrant, dort fallen die Beträge weg: $sqrt(y) = 1 - sqrt(x)$, also $y = (1 - sqrt(x))^2$ für $0 <= x <= 1$.
  $ A/4 = integral_0^1 (1 - 2 sqrt(x) + x) dif x = 1 - 4/3 + 1/2 = 1/6, wide A = 2/3. $
  Kontrolle: Die Kurve liegt im Quadrat $|x| + |y| <= 1$ mit der Fläche $2$, denn $|x| + |y| <= (sqrt(|x|) + sqrt(|y|))^2 = 1$. Und $2\/3 < 2$ #sym.checkmark (Jedes der vier Stücke ist übrigens ein Parabelbogen.)
]

#aufg[Hauptsatz][
  Bestimme die lokalen Extrema von $F(x) = integral_0^x (t^2 - 1) e^(-t^2) dif t$.
][
  Nach dem Hauptsatz ist $F'(x) = (x^2 - 1) e^(-x^2)$. Nullstellen: $x = plus.minus 1$. Da $e^(-x^2) > 0$, bestimmt $x^2 - 1$ das Vorzeichen: $F' > 0$ für $|x| > 1$, $F' < 0$ für $|x| < 1$.
  - Bei $x = -1$ wechselt $F'$ von $+$ nach $-$: lokales Maximum.
  - Bei $x = 1$ von $-$ nach $+$: lokales Minimum.
  Die Werte selbst kann man nicht elementar ausrechnen, das ist für die Frage auch nicht nötig.
]

#aufg[Uneigentliche Integrale][
  Konvergent oder divergent? Berechne gegebenenfalls den Wert. (a) $display(integral_0^oo x e^(-x) dif x)$, (b) $display(integral_0^4 1/sqrt(4 - x) dif x)$, (c) $display(integral_2^oo 1/(x ln x) dif x)$.
][
  (a) Partiell: $integral_0^R x e^(-x) dif x = [-x e^(-x)]_0^R + integral_0^R e^(-x) dif x = -R e^(-R) + 1 - e^(-R) -> 1$. Konvergent, Wert $1$.

  (b) Pol bei $x = 4$. $integral_0^epsilon (4 - x)^(-1\/2) dif x = [-2 sqrt(4 - x)]_0^epsilon = -2 sqrt(4 - epsilon) + 4 -> 4$. Konvergent, Wert $4$.

  (c) Substitution $u = ln x$: $integral dif u \/ u = ln|u|$. Also $integral_2^R = ln(ln R) - ln(ln 2) -> oo$. Divergent, wenn auch extrem langsam.
]

#kurz[
  - $integral_a^b f dif x$ = Grenzwert von Riemann-Summen = Fläche mit Vorzeichen.
  - Hauptsatz: $(integral_a^x f)' = f(x)$ und $integral_a^b f = F(b) - F(a)$. Variable Grenzen: $f(g) g' - f(h) h'$.
  - Partielle Integration: Produktregel rückwärts, nach LIATE ableiten. Bumerang-Integrale nach $I$ auflösen.
  - Substitution: Kettenregel rückwärts; Grenzen mitsubstituieren. $integral f'\/f = ln|f|$.
  - Rationale Funktionen: Polynomdivision, Nenner faktorisieren, Partialbrüche, integrieren ($ln$, $arctan$).
  - Flächen: Parameterform $integral y dot(x) dif t$; Sektor $1/2 integral (x dot(y) - y dot(x)) dif t = 1/2 integral r^2 dif phi$; zwischen Polarkurven $1/2 integral (r_2^2 - r_1^2) dif phi$. Bei geschlossenen Kurven ist der Ursprung beliebig.
  - Anwendungen: Beitrag eines kleinen Stücks aufschreiben, dann integrieren. $dif A = f dif x$, $dif s = sqrt(dot(x)^2 + dot(y)^2) dif t$, $dif V = pi f^2 dif x$, $dif O = 2 pi f dif s$.
  - Uneigentlich: erst endliche Grenze, dann Grenzwert. $integral_1^oo x^(-p)$ konvergiert für $p > 1$, $integral_0^1 x^(-p)$ für $p < 1$. Vergleichskriterium.
]
