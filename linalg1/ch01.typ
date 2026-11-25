#import "lib.typ": *

= Einführung und lineare Gleichungssysteme

#woche(1, [Einführung, lineare Gleichungssysteme], [Geschichte · Grundfragen · Lösungsmenge · Äquivalenzumformungen · Dreiecksform · Gauss])

#vorlesung[Die Lineare Algebra beginnt mit einer sehr alten und sehr praktischen Frage: Wie löst man mehrere Gleichungen mit mehreren Unbekannten gleichzeitig, wenn alle Gleichungen «linear» sind? Diese Woche lernst du, was man von einem solchen System überhaupt wissen will, wie man es systematisch vereinfacht, ohne seine Lösungen zu verändern, und wie das Eliminationsverfahren von Gauss funktioniert. Alles Spätere (Matrizen, Determinanten, Vektorräume) wächst aus dieser einen Frage heraus.]

== Worum geht es in der Linearen Algebra?

#idee[Das Wort *linear* bedeutet: Die Unbekannten kommen nur «einfach» vor, jede für sich, höchstens mit einer Zahl multipliziert, und nur addiert oder subtrahiert. Ausdrücke wie $x^2$, $x y$, $sqrt(x)$ oder $sin(x)$ sind verboten. Das klingt nach einer starken Einschränkung. Es ist aber genau diese Einschränkung, die alles *berechenbar* macht: Für lineare Probleme gibt es vollständige Theorien und schnelle Algorithmen. Und weil sich jede glatte Funktion lokal durch eine lineare «Tangente» annähern lässt (Analysis!), sind lineare Probleme überall im Hintergrund, auch wenn die Originalprobleme nichtlinear sind.]

Die Lineare Algebra untersucht drei eng verwandte Dinge:
- *Lineare Gleichungssysteme* (LGS): Wie findet man alle Lösungen? Gibt es überhaupt welche?
- *Vektoren und Vektorräume*: Eine Struktur, in der man Objekte addieren und mit Zahlen strecken kann. Das können Pfeile im Raum sein, aber auch Polynome, Funktionen oder Messreihen.
- *Lineare Abbildungen und Matrizen*: Rechenvorschriften, die Summen und Vielfache respektieren (Drehungen, Spiegelungen, Projektionen, Skalierungen). Matrizen sind die «Zahlentabellen», mit denen man sie beschreibt und berechnet.

Alle drei sind verschiedene Sichtweisen auf dasselbe. Das ist die grosse Idee des Kurses.

#alltag[*Der Ballbot Rezero.* Rezero ist ein an der ETH Zürich entwickelter Roboter, der auf einer einzigen Kugel balanciert, ähnlich wie ein Mensch, der auf einem Ball steht. Damit er nicht umfällt, misst er hundertfach pro Sekunde seine Neigung und Neigungsgeschwindigkeit und berechnet daraus, wie er die Kugel antreiben soll. Für die Regelung wird der Roboter in der Nähe der aufrechten Lage durch ein *lineares* Modell beschrieben; die Reglerberechnung besteht im Kern aus Matrizenrechnung und linearen Gleichungssystemen. Ähnliches gilt für Computergrafik (jede Drehung und Skalierung eines 3D-Modells ist eine Matrix), für Suchmaschinen (PageRank löst ein riesiges lineares Problem), für Statistik und maschinelles Lernen (Regression) und für die Berechnung von Stromnetzen und Tragwerken.]

== Eine kurze Geschichte der Linearen Algebra

#fg("l01_zeit", [Einige Meilensteine. Die Lineare Algebra ist als zusammenhängende Theorie jünger, als man denkt: Die *Verfahren* sind Jahrtausende alt, die *abstrakte Sprache* der Vektorräume stammt aus dem 19. und 20. Jahrhundert.], w: 100%)

#hist[
- *Babylon (ca. 1800 v. Chr.).* Auf Keilschrifttafeln stehen Aufgaben, die auf Gleichungen mit zwei Unbekannten führen, gelöst durch geschicktes Rechnen.
- *China.* Die «Neun Kapitel der Rechenkunst» (Jiuzhang suanshu), entstanden in den Jahrhunderten um die Zeitenwende, enthalten im achten Kapitel («Fangcheng») Aufgaben mit mehreren Unbekannten. Man löste sie, indem man die Zahlen als Tabelle auf einem Rechenbrett anordnete und systematisch Spalten voneinander abzog: im Kern das spätere Gausssche Verfahren, mehr als 1500 Jahre früher.
- *Leibniz (1693) und Seki Takakazu (1683).* Beide führten, unabhängig voneinander, Determinanten ein, um zu entscheiden, ob ein System eine eindeutige Lösung hat.
- *Gabriel Cramer (1750)* veröffentlichte die Regel, die heute seinen Namen trägt (Woche 10).
- *Carl Friedrich Gauss.* Er benutzte das Eliminationsverfahren systematisch für die Ausgleichsrechnung bei astronomischen und geodätischen Messungen (Methode der kleinsten Quadrate) und beschrieb es 1809 in seiner Himmelsmechanik, der «Theoria motus corporum coelestium». Die Variante, die auch oberhalb der Diagonale eliminiert, geht auf den Geodäten *Wilhelm Jordan* zurück (Handbuch der Vermessungskunde, 1888): das Gauss-Jordan-Verfahren (Woche 6).
- *Hamilton (1843), Grassmann (1844).* Hamilton entdeckte die Quaternionen, Grassmann entwickelte in seiner «Ausdehnungslehre» die Idee von Räumen beliebiger Dimension.
- *Sylvester (1850)* prägte das Wort «Matrix», *Cayley (1858)* begründete die Rechnung mit Matrizen.
- *Giuseppe Peano (1888)* gab als Erster die heutige axiomatische Definition eines Vektorraums an (Woche 10).
- *Computer.* Mit den ersten elektronischen Rechnern wurde die Lineare Algebra zur Rechenmaschine: von Neumann und Goldstine untersuchten 1947 die Rundungsfehler beim Eliminationsverfahren, und Alan Turing beschrieb 1948 die LR-Zerlegung (Woche 7/8), die in jeder Numerik-Software steckt.
- *1998:* Larry Page und Sergey Brin begründen mit PageRank Google auf einer Eigenwertaufgabe für eine riesige Matrix.
]

Die Geschichte erzählt eine Lehre: Aus einem Rechenverfahren für Gleichungssysteme (Gauss, China) wurde über Jahrhunderte eine allgemeine *Sprache* (Vektorräume, Abbildungen), die weit mehr kann als Gleichungen lösen.

== Lineare Gleichungssysteme

=== Ein erstes Beispiel

Ein Kiosk verkauft Brezel und Gipfeli. Gestern wurden 3 Brezel und 2 Gipfeli für zusammen 9 Franken verkauft, heute 1 Brezel und 4 Gipfeli für 8 Franken. Was kostet eine Brezel ($x$), was ein Gipfeli ($y$)?

$ 3x + 2y &= 9 \ x + 4y &= 8 $

Das ist ein *lineares Gleichungssystem* mit zwei Gleichungen und zwei Unbekannten. Probiere selbst: Aus der zweiten Gleichung folgt $x = 8 - 4y$. Eingesetzt in die erste: $3(8 - 4y) + 2y = 9$, also $24 - 10y = 9$, also $y = 1.5$ und $x = 2$. Eine Brezel kostet 2, ein Gipfeli 1.50 Franken. Probe: $3 dot 2 + 2 dot 1.5 = 9$ ✓ und $2 + 4 dot 1.5 = 8$ ✓.

Das Einsetzen funktioniert bei zwei Unbekannten bequem. Bei 20 Gleichungen mit 20 Unbekannten (oder 2 Millionen, wie in der Praxis) braucht man ein *Verfahren*, das ohne Einfälle auskommt und immer funktioniert. Das ist das Ziel dieser und der nächsten Wochen.

=== Definition

#defn[Lineares Gleichungssystem][Ein *lineares Gleichungssystem (LGS)* mit $m$ Gleichungen und $n$ Unbekannten $x_1, dots, x_n$ hat die Form
$ a_(11) x_1 + a_(12) x_2 + dots + a_(1n) x_n &= b_1 \ a_(21) x_1 + a_(22) x_2 + dots + a_(2n) x_n &= b_2 \ dots.v quad quad quad & quad dots.v \ a_(m 1) x_1 + a_(m 2) x_2 + dots + a_(m n) x_n &= b_m $
Die Zahlen $a_(i j)$ heissen *Koeffizienten*, die Zahlen $b_i$ die *rechte Seite*. Der erste Index $i$ eines Koeffizienten $a_(i j)$ nennt die *Gleichung* (Zeile), der zweite $j$ die *Unbekannte* (Spalte). Ein LGS heisst *homogen*, wenn alle $b_i = 0$ sind, sonst *inhomogen*.]

Die Koeffizienten sind (in diesem Kurs zunächst) reelle Zahlen, später auch komplexe. Ein LGS mit $m = n$ nennt man *quadratisch*; ist $m < n$, hat es «weniger Gleichungen als Unbekannte» (*unterbestimmt*); ist $m > n$, hat es «mehr Gleichungen als Unbekannte» (*überbestimmt*).

#defn[Lösung, Lösungsmenge][Eine *Lösung* des LGS ist ein $n$-Tupel $(x_1, dots, x_n)$ reeller Zahlen, das *alle* $m$ Gleichungen gleichzeitig erfüllt. Die Menge aller Lösungen heisst *Lösungsmenge* $L$ des LGS.]

Eine Lösung ist also nicht eine Zahl, sondern ein ganzes Tupel; die Lösungsmenge $L$ ist eine Menge von Tupeln. Für das Kiosk-Beispiel ist $L = {(2, 1.5)}$.

#merke[«Alle Gleichungen gleichzeitig» ist wörtlich gemeint: Ein Tupel, das zwar die erste, aber nicht die zweite Gleichung erfüllt, ist *keine* Lösung des Systems.]

=== Die drei Grundfragen

Man kann an ein LGS drei Fragen stellen, und diese drei Fragen begleiten uns durch den ganzen Kurs:

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Frage*], [*Inhalt*],
  [Existenz], [Gibt es überhaupt eine Lösung? ($L != emptyset$?)],
  [Eindeutigkeit], [Wenn ja: Gibt es genau eine, oder mehr?],
  [Berechnung], [Wie findet man *alle* Lösungen, also die ganze Menge $L$, effizient und sicher?])

=== Wie viele Lösungen kann ein LGS haben?

Bei zwei Gleichungen mit zwei Unbekannten bedeutet jede Gleichung eine *Gerade* in der Ebene (alle Punkte $(x, y)$, die sie erfüllen). Eine Lösung des Systems ist ein Punkt, der auf beiden Geraden liegt: ein *Schnittpunkt*. Zwei Geraden in der Ebene können sich auf drei Arten verhalten:

#fgs(("l01_eind", "l01_keine", "l01_viele"), [Drei mögliche Fälle: genau eine Lösung (die Geraden schneiden sich), keine Lösung (parallel), unendlich viele Lösungen (die Geraden fallen zusammen).])

#table(columns: (auto, auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*System*], [*Lösungsmenge*], [*Warum*],
  [$x + y = 3, quad x - y = 1$], [$L = {(2, 1)}$], [Addieren: $2x = 4$, also $x = 2$ und $y = 1$],
  [$x + y = 1, quad x + y = 2$], [$L = emptyset$], [Die linken Seiten sind gleich, die rechten verschieden: Widerspruch $1 = 2$],
  [$x + y = 1, quad 2x + 2y = 2$], [$L = {(t, 1 - t) : t in RR}$], [Die zweite Gleichung ist das Doppelte der ersten: Es bleibt *eine* Gleichung für zwei Unbekannte])

Im dritten Fall kann man $x = t$ *frei* wählen und $y = 1 - t$ ergibt sich. Man nennt $t$ einen *Parameter*.

#satz[Anzahl der Lösungen][Ein lineares Gleichungssystem hat *entweder keine, oder genau eine, oder unendlich viele* Lösungen. Es gibt nie «genau zwei» oder «genau fünf» Lösungen.]

#warum[Für die Anzahl der Lösungen][Angenommen, das System hat zwei verschiedene Lösungen $bold(u)$ und $bold(v)$. Dann liegt auch jeder Punkt $bold(u) + t(bold(v) - bold(u))$ auf der Verbindungsgeraden *beider* Lösungen. Denn setzt man ihn in eine Gleichung ein, so erhält man $a_1 (u_1 + t(v_1 - u_1)) + dots = (1 - t) (a_1 u_1 + dots) + t (a_1 v_1 + dots) = (1 - t) b + t b = b$. Mit zwei Lösungen hat man also automatisch unendlich viele (für jedes reelle $t$ eine). Das ist eine erste Andeutung der Struktur, die wir in Woche 4 (Lösungsmengen homogener Systeme) und Woche 11 (Unterräume) vollständig verstehen werden.]

#bsp[Ein altes chinesisches Rätsel][Aus den «Neun Kapiteln» (Kapitel 8, Aufgabe 1), sinngemäss: Drei Bündel guter Ernte, zwei Bündel mittlerer Ernte und ein Bündel schlechter Ernte ergeben 39 Mass Getreide. Zwei gute, drei mittlere und ein schlechtes ergeben 34 Mass; ein gutes, zwei mittlere und drei schlechte ergeben 26 Mass. Wie viel liefert jedes Bündel? Mit $x, y, z$ für gut, mittel, schlecht:
$ 3x + 2y + z &= 39 \ 2x + 3y + z &= 34 \ x + 2y + 3z &= 26 $
Die Lösung ist $x = 37\/4 = 9.25$, $y = 17\/4 = 4.25$, $z = 11\/4 = 2.75$ Mass. (Probe: $3 dot 9.25 + 2 dot 4.25 + 2.75 = 27.75 + 8.5 + 2.75 = 39$ ✓.) Mit dem Verfahren dieser Woche kannst du das selbst herausfinden.]

== Äquivalente Gleichungssysteme und Äquivalenzumformungen

Die Idee des Lösens ist immer dieselbe: Man ersetzt das System durch ein *einfacheres*, das *dieselben Lösungen* hat, bis man die Lösung ablesen kann.

#defn[Äquivalente Systeme][Zwei LGS in denselben Unbekannten heissen *äquivalent*, wenn sie *dieselbe Lösungsmenge* haben. Eine Umformung, die ein LGS in ein äquivalentes überführt, heisst *Äquivalenzumformung*.]

#satz[Die drei Äquivalenzumformungen][Die folgenden Umformungen eines LGS verändern die Lösungsmenge *nicht*:
+ *Vertauschen* zweier Gleichungen.
+ *Multiplizieren* einer Gleichung mit einer Zahl $c != 0$.
+ *Addieren* eines Vielfachen einer Gleichung zu einer anderen Gleichung.]

#beweis[Die Reihenfolge der Gleichungen spielt für «alle gleichzeitig erfüllt» keine Rolle: (1) ist klar. Bei (2) gilt für $c != 0$: $a = b$ genau dann, wenn $c a = c b$ (man kann durch $c$ teilen). Bei (3) sei das System durch $G_1, G_2, dots$ gegeben und wir ersetzen $G_2$ durch $G_2 + c G_1$. Erfüllt ein $bold(x)$ die Gleichungen $G_1$ und $G_2$, so auch $G_2 + c G_1$, denn gleiche Dinge zu gleichen addiert bleiben gleich. Umgekehrt: Erfüllt $bold(x)$ die Gleichungen $G_1$ und $G_2 + c G_1$, so erfüllt es auch $(G_2 + c G_1) - c G_1 = G_2$. Jede Lösung des alten Systems ist also eine des neuen und umgekehrt. Die Lösungsmengen sind gleich.]

Der Beweis zeigt den Kern der Sache: Jede der drei Umformungen lässt sich durch eine Umformung *rückgängig* machen (Vertauschen durch nochmaliges Vertauschen, Multiplizieren mit $c$ durch Multiplizieren mit $1\/c$, Addieren von $c G_1$ durch Subtrahieren von $c G_1$). Eine umkehrbare Umformung kann keine Lösung vernichten und keine neue erzeugen.

#fehler[
- *Multiplikation mit $0$* ist keine Äquivalenzumformung: Die Gleichung $x = 5$ mal 0 ergibt $0 = 0$, und diese Aussage hat *alle* Zahlen als Lösung. Daher die Bedingung $c != 0$.
- *Nicht umkehrbare Umformungen* wie Quadrieren: Aus $x = 2$ folgt $x^2 = 4$ mit den zwei Lösungen $2$ und $-2$. Es kommt eine Lösung hinzu.
- Beim Addieren eines Vielfachen einer Gleichung zu einer anderen muss die Gleichung, *zu der* man addiert, erhalten bleiben: Man ersetzt $G_2$ durch $G_2 + c G_1$, nicht beide durch etwas Neues. (Wer $G_1$ durch $G_1 + G_2$ *und* gleichzeitig $G_2$ durch $G_2 - G_1$ ersetzt, hat womöglich eine Information verloren.)
]

== Dreiecksform und Rückwärtseinsetzen

Welche Systeme kann man *sofort* lösen? Solche in *Dreiecksform*: Jede Gleichung enthält weniger Unbekannte als die darüberliegende.

$ 2x + y - z &= 4 \ 3y + z &= 8 \ 2z &= 4 $

Die letzte Gleichung enthält nur $z$: Aus $2z = 4$ folgt $z = 2$. Das setzt man in die zweite ein: $3y + 2 = 8$, also $y = 2$. Und mit beidem in die erste: $2x + 2 - 2 = 4$, also $x = 2$. Die Lösung ist $(2, 2, 2)$.

#defn[Rückwärtseinsetzen][Bei einem System in Dreiecksform löst man die *letzte* Gleichung zuerst und setzt das Ergebnis in die darüberliegende ein, dann beide in die nächste, und so fort bis zur ersten Gleichung. Dieses Vorgehen heisst *Rückwärtseinsetzen*.]

#intu[Ein Dreieckssystem ist wie eine Leiter: Von unten nach oben ist jeder Schritt einfach, weil man auf der Sprosse darunter bereits sicher steht. Das Gausssche Verfahren konstruiert diese Leiter.]

#kontrolle[Löse $x + 2y + 3z = 14$, $quad 2y + z = 5$, $quad 3z = 9$ durch Rückwärtseinsetzen.][$z = 3$; $2y + 3 = 5$ also $y = 1$; $x + 2 + 9 = 14$ also $x = 3$. Lösung $(3, 1, 3)$.]

== Das Gausssche Eliminationsverfahren: die Grundidee

#idee[Man erzeugt die Dreiecksform *systematisch*: Zuerst eliminiert man die Unbekannte $x_1$ aus allen Gleichungen ausser der ersten, indem man passende Vielfache der ersten Gleichung abzieht. Dann eliminiert man $x_2$ aus allen Gleichungen ausser den ersten beiden, und so weiter. Am Ende hat man ein Dreieckssystem, das man rückwärts löst. Jeder Schritt ist eine Äquivalenzumformung: Die Lösungen bleiben erhalten.]

#bsp[Ein vollständiges Beispiel][
Gegeben sei
$ x + y + z &= 6 quad (G_1) \ 2x - y + z &= 3 quad (G_2) \ x + 3y - z &= 4 quad (G_3) $

#schritt[1. Elimination von $x$.] Das $x$ in $G_2$ und $G_3$ muss weg. Ersetze $G_2$ durch $G_2 - 2 G_1$ und $G_3$ durch $G_3 - G_1$:
$ x + y + z &= 6 \ -3y - z &= -9 \ 2y - 2z &= -2 $
#schritt[2. Elimination von $y$.] Dividiere $G_3$ durch 2: $y - z = -1$. Der Übersicht halber vertausche die beiden unteren Gleichungen. Dann ist $y - z = -1$ die zweite Gleichung. Addiere nun das $3$-fache dieser Gleichung zur dritten Gleichung $-3y - z = -9$: $(-3y - z) + 3(y - z) = -9 + 3(-1)$, also $-4z = -12$.
$ x + y + z &= 6 \ y - z &= -1 \ -4z &= -12 $
#schritt[3. Rückwärtseinsetzen.] $z = 3$; dann $y = z - 1 = 2$; dann $x = 6 - y - z = 1$.

Die Lösung ist $(x, y, z) = (1, 2, 3)$. Probe in den *ursprünglichen* Gleichungen: $1 + 2 + 3 = 6$ ✓, $2 - 2 + 3 = 3$ ✓, $1 + 6 - 3 = 4$ ✓.
]

Wir haben nur die drei Äquivalenzumformungen benutzt. Deshalb ist die Lösung des Dreieckssystems auch die des Ausgangssystems. Die *Probe* am Originalsystem ist trotzdem Pflicht: Sie fängt Rechenfehler ab.

#merke[*Gauss in einem Satz:* Mit den drei Äquivalenzumformungen bringe das System in Dreiecksform (Vorwärtselimination) und löse dann von unten nach oben (Rückwärtseinsetzen).]

=== Was kann schiefgehen? Das Verfahren zeigt es an

Wenn man das Verfahren bei einem System durchführt, das keine eindeutige Lösung hat, sieht man das *im Verlauf*:

#table(columns: (1fr, 1fr, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Beispiel*], [*Im Verlauf der Elimination*], [*Ergebnis*],
  [$x + y = 1, quad x + y = 2$ \ $arrow.r$ $G_2 - G_1$:], [$0 = 1$ (Widerspruch)], [keine Lösung],
  [$x + y + z = 3, quad y - z = 1$ \ (nur zwei Gleichungen)], [$z$ kommt in keiner führenden Position vor], [unendlich viele Lösungen: $z = t$ frei, $y = 1 + t$, $x = 2 - 2t$],
  [$G_2 - G_1$ führt auf $0 = 0$], [die Gleichung war überflüssig], [Zeile entfällt; ggf. mehr Freiheit])

Der Fall «Widerspruch» (eine Gleichung der Form $0 = c$ mit $c != 0$) bedeutet keine Lösung. Der Fall «$0 = 0$» heisst: Diese Gleichung enthielt keine neue Information. Wie man solche Fälle ganz sauber behandelt, ist Thema der nächsten beiden Wochen (Zeilenstufenform, Pivots, freie Parameter).

#alltag[*Aufwand.* Bei einem System mit $n$ Gleichungen und $n$ Unbekannten braucht das Gausssche Verfahren etwa $n^3\/3$ Multiplikationen (und etwa ebenso viele Additionen). Für $n = 1000$ sind das rund $3 dot 10^8$ Operationen: ein Rechner schafft das in Bruchteilen einer Sekunde. Das Einsetzverfahren «von Hand» für beliebige Systeme oder die Cramersche Regel mit Determinanten (Woche 10) wären bei grossem $n$ hoffnungslos langsam. Gauss ist nicht nur das älteste, sondern bis heute das praktischste Verfahren.]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*GPS: ein Gleichungssystem im Taschenformat.* Dein Handy kennt seinen Ort $(x, y, z)$ und den Fehler seiner Uhr $t$. Das sind vier Unbekannte. Jeder empfangene Satellit liefert eine Gleichung (Abstand = Lichtgeschwindigkeit mal Laufzeit); deshalb braucht man mindestens vier Satelliten. Die Gleichungen sind eigentlich nicht linear, werden aber in jedem Rechenschritt durch ein lineares System ersetzt und mit dem Gauss-Verfahren gelöst, mehrmals pro Sekunde.]

#alltag[*Reaktionsgleichungen ausgleichen.* Wie viele Sauerstoffmoleküle verbrennen ein Propanmolekül? Ansatz: $a thin "C"_3 "H"_8 + b thin "O"_2 -> c thin "CO"_2 + d thin "H"_2 "O"$. Aus «gleich viele Atome vorher und nachher» folgen drei lineare Gleichungen: $3a = c$, $8a = 2d$, $2b = 2c + d$. Mit $a = 1$ ergibt sich $c = 3$, $d = 4$, $b = 5$. Chemiker lösen auf diese Weise auch grosse Reaktionsnetze, mit Hunderten von Stoffen und einem LGS, das ein Computer rechnet.]

#alltag[*Verkehr und Netzwerke.* An jedem Knoten eines Strassennetzes oder Stromnetzes gilt: Was hineinfliesst, fliesst auch wieder hinaus (Kirchhoff'sche Knotenregel). Jeder Knoten liefert eine lineare Gleichung für die unbekannten Flüsse. So rechnen Verkehrsplaner Zählstellendaten auf nicht gemessene Strassen hoch, und Elektroingenieure bestimmen Ströme in einem Netz mit hunderten Knoten. Dass das lösbar ist (oder nicht eindeutig), entscheidet sich genau mit den Methoden dieses Kapitels.]
// ALLTAG-END

#kurz[
- Ein LGS hat $m$ Gleichungen, $n$ Unbekannte; eine Lösung ist ein $n$-Tupel, das *alle* Gleichungen erfüllt; $L$ ist die Menge aller Lösungen.
- Drei Fragen: Existenz, Eindeutigkeit, Berechnung. Mögliche Anzahl der Lösungen: $0$, $1$ oder $infinity$, nie etwas dazwischen.
- Zwei LGS sind *äquivalent*, wenn $L$ gleich ist. Äquivalenzumformungen: Vertauschen, Multiplikation mit $c != 0$, Addition eines Vielfachen einer Gleichung zu einer anderen. Alle drei sind umkehrbar.
- *Dreiecksform* löst man durch *Rückwärtseinsetzen*. Das *Gausssche Verfahren* erzeugt die Dreiecksform systematisch.
]

#aufgaben()

#aufg("Drei Systeme", [Löse mit dem Eliminationsverfahren und mache die Probe: \ (a) $2x + y = 5, quad 4x - y = 1$. \ (b) $x - 2y + z = 0, quad 2x + y - z = 5, quad -x + y + 2z = 7$.],
[(a) Addiere beide Gleichungen: $6x = 6$, also $x = 1$ und $y = 5 - 2 = 3$. Probe: $4 - 3 = 1$ ✓. \ (b) $G_2 - 2G_1$: $5y - 3z = 5$. $G_3 + G_1$: $-y + 3z = 7$. Addiere beide neuen Gleichungen: $4y = 12$, also $y = 3$. Aus $-y + 3z = 7$ folgt $3z = 7 + y = 10$, also $z = 10\/3$. Prüfe mit der ersten neuen Gleichung: $5 dot 3 - 3 dot 10\/3 = 15 - 10 = 5$ ✓. Aus $G_1$: $x = 2y - z = 6 - 10\/3 = 8\/3$. Lösung $(8\/3, 3, 10\/3)$. Probe in $G_2$: $16\/3 + 3 - 10\/3 = 2 + 3 = 5$ ✓.])

#aufg("Keine, eine oder unendlich viele?", [Für welche Werte des Parameters $a in RR$ hat das System $x + y = 2$, $quad 2x + 2y = a$ (i) keine, (ii) genau eine, (iii) unendlich viele Lösungen?],
[Subtrahiere das Doppelte der ersten von der zweiten Gleichung: $0 = a - 4$. Ist $a != 4$, so ist das ein Widerspruch: keine Lösung. Ist $a = 4$, so bleibt nur $x + y = 2$: unendlich viele Lösungen $(t, 2 - t)$. Genau eine Lösung gibt es für *keinen* Wert von $a$: Zwei Geraden mit gleicher Steigung können sich nicht in genau einem Punkt schneiden.])

#aufg("Warum ist das keine Äquivalenzumformung?", [Das LGS $x + y = 1$, $quad x - y = 1$ hat die Lösung $(1, 0)$. Zeige: Ersetzt man beide Gleichungen gleichzeitig durch ihre Summe und ihre Summe nochmals (also $G_1' = G_1 + G_2$ und $G_2' = G_1 + G_2$), so entsteht ein System mit unendlich vielen Lösungen. Warum geht Information verloren?],
[Beide neuen Gleichungen lauten $2x = 2$, also $x = 1$ mit beliebigem $y$: unendlich viele Lösungen. Die Umformung ist nicht umkehrbar: Aus den neuen Gleichungen kann man die alten nicht zurückgewinnen, weil beide neuen identisch sind. Eine erlaubte Umformung ersetzt immer nur *eine* Gleichung durch eine Kombination, in der die zu ersetzende Gleichung mit einem Faktor $!= 0$ vorkommt.])

#aufg("Rückwärtseinsetzen", [Löse $2x_1 - x_2 + 3x_3 = 7$, $quad x_2 - 2x_3 = -3$, $quad 4x_3 = 8$.],
[$x_3 = 2$; $x_2 = -3 + 2 dot 2 = 1$; $2x_1 = 7 + x_2 - 3x_3 = 7 + 1 - 6 = 2$, also $x_1 = 1$. Lösung $(1, 1, 2)$.])
