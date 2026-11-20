#import "lib.typ": *

= Matrixschreibweise und das Gauss-Verfahren

#woche(2, [Schreibweisen für LGS, Gausssches Eliminationsverfahren], [erweiterte Matrix · Matrixschreibweise · Zeilenumformungen · Algorithmus · Pivotwahl])

#vorlesung[Letzte Woche haben wir mit ganzen Gleichungen gerechnet und dabei die Unbekannten $x, y, z$ immer wieder mitgeschrieben, obwohl sie nur Platzhalter sind. Diese Woche streichen wir sie weg: Das LGS wird zu einer Zahlentafel, einer *Matrix*, und das Eliminationsverfahren wird zu einem sauberen, mechanischen Algorithmus mit Zeilen. Wer ihn sicher beherrscht, hat die wichtigste Rechenfertigkeit des ganzen Semesters.]

== Schreibweisen für lineare Gleichungssysteme

Dasselbe LGS lässt sich auf vier Arten aufschreiben. Wir nehmen das Beispiel der letzten Woche:

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: (left, left + horizon),
  [*1. Ausführlich*], [$ x + y + z &= 6 \ 2x - y + z &= 3 \ x + 3y - z &= 4 $],
  [*2. Erweiterte Matrix*], [$ mat(1, 1, 1, 6; 2, -1, 1, 3; 1, 3, -1, 4; augment: #3) $],
  [*3. Matrixgleichung*], [$ underbrace(mat(1, 1, 1; 2, -1, 1; 1, 3, -1), A) underbrace(vec(x, y, z), bold(x)) = underbrace(vec(6, 3, 4), bold(b)) $],
  [*4. Spaltenschreibweise*], [$ x vec(1, 2, 1) + y vec(1, -1, 3) + z vec(1, 1, -1) = vec(6, 3, 4) $])

Alle vier sagen dasselbe. Welche man benutzt, hängt vom Zweck ab: Zum Rechnen nimmt man die erweiterte Matrix, zum Denken die Matrixgleichung $A bold(x) = bold(b)$, und die Spaltenschreibweise liefert eine geometrische Deutung.

=== Matrizen und die erweiterte Matrix

#defn[Matrix][Eine *$m times n$-Matrix* ist ein rechteckiges Schema von Zahlen mit $m$ Zeilen und $n$ Spalten,
$ A = mat(a_(11), a_(12), dots, a_(1n); a_(21), a_(22), dots, a_(2n); dots.v, dots.v, , dots.v; a_(m 1), a_(m 2), dots, a_(m n)). $
$a_(i j)$ ist der Eintrag in der $i$-ten Zeile und $j$-ten Spalte. Die Menge aller reellen $m times n$-Matrizen schreibt man $RR^(m times n)$.]

Merkhilfe: «*Z*eile zuerst, *S*palte später» (der erste Index ist die Zeile). Eine $m times n$-Matrix hat $m$ Zeilen, aber $n$ Spalten, genau wie ein LGS mit $m$ Gleichungen und $n$ Unbekannten.

#defn[Koeffizientenmatrix und erweiterte Matrix][Zum LGS $sum_(j=1)^n a_(i j) x_j = b_i$ ($i = 1, dots, m$) gehören
- die *Koeffizientenmatrix* $A = (a_(i j)) in RR^(m times n)$,
- der *Spaltenvektor der rechten Seite* $bold(b) = (b_1, dots, b_m)^tp$,
- der *Spaltenvektor der Unbekannten* $bold(x) = (x_1, dots, x_n)^tp$,
- die *erweiterte Matrix* $(A | bold(b)) in RR^(m times (n+1))$: die Koeffizientenmatrix mit der rechten Seite als zusätzlicher letzter Spalte (durch einen senkrechten Strich abgesetzt).]

Der senkrechte Strich ist ein reines Gedächtnis-Hilfsmittel («hier steht das Gleichheitszeichen»). Jede *Zeile* der erweiterten Matrix ist eine *Gleichung*, jede *Spalte* links vom Strich gehört zu einer *Unbekannten*.

=== Das Produkt $A bold(x)$

Damit die Matrixgleichung $A bold(x) = bold(b)$ einen Sinn hat, muss man sagen, was $A bold(x)$ bedeuten soll. Wir *definieren* es so, dass $A bold(x) = bold(b)$ genau das LGS ist:

#defn[Matrix mal Vektor][Für $A in RR^(m times n)$ und $bold(x) in RR^n$ ist $A bold(x) in RR^m$ der Vektor mit den Einträgen
$ (A bold(x))_i = sum_(j=1)^n a_(i j) x_j = a_(i 1) x_1 + dots + a_(i n) x_n quad (i = 1, dots, m). $
Der $i$-te Eintrag ist also das «Zeile mal Vektor»: die Zeile $i$ von $A$, Eintrag für Eintrag mit $bold(x)$ multipliziert und summiert.]

Es gibt eine zweite, genauso wichtige Sichtweise: Bezeichnet man die Spalten von $A$ mit $bold(a)_1, dots, bold(a)_n in RR^m$, so gilt
$ A bold(x) = x_1 bold(a)_1 + x_2 bold(a)_2 + dots + x_n bold(a)_n . $
Das Produkt $A bold(x)$ ist eine *Linearkombination der Spalten* von $A$, mit den Einträgen von $bold(x)$ als Koeffizienten.

#bsp[Matrix mal Vektor, beide Sichtweisen][
$ A = mat(1, 2, 0; 3, -1, 4), quad bold(x) = vec(2, 1, -1). $
*Zeilenweise:* $(A bold(x))_1 = 1 dot 2 + 2 dot 1 + 0 dot (-1) = 4$ und $(A bold(x))_2 = 3 dot 2 + (-1) dot 1 + 4 dot (-1) = 1$.
*Spaltenweise:* $2 vec(1, 3) + 1 vec(2, -1) + (-1) vec(0, 4) = vec(2 + 2 + 0, 6 - 1 - 4) = vec(4, 1)$. Beide Male $A bold(x) = (4, 1)^tp$.
]

#intu[Die Spaltensicht stellt die Frage hinter einem LGS neu: *Lässt sich die rechte Seite $bold(b)$ als Linearkombination der Spalten von $A$ darstellen, und mit welchen Koeffizienten?* Im Beispiel oben: Mit welchen Zahlen $x, y, z$ kann man aus den Vektoren $(1,2,1)$, $(1,-1,3)$, $(1,1,-1)$ den Vektor $(6,3,4)$ zusammensetzen? Diese Sicht kehrt in Woche 12 als Begriff des *Spaltenraums* wieder.]

== Elementare Zeilenumformungen

Die drei Äquivalenzumformungen von Woche 1 übersetzen sich in Operationen auf den *Zeilen* der erweiterten Matrix:

#defn[Elementare Zeilenumformungen][Auf einer Matrix sind folgende drei Operationen erlaubt:
#table(columns: (auto, auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Typ*], [*Schreibweise*], [*Bedeutung*],
  [Vertauschen], [$Z_i arrow.l.r Z_j$], [Zeile $i$ und Zeile $j$ tauschen die Plätze],
  [Skalieren], [$Z_i arrow.r c Z_i$ ($c != 0$)], [Zeile $i$ mit der Zahl $c eq.not 0$ multiplizieren],
  [Addieren], [$Z_i arrow.r Z_i + c Z_j$ ($j != i$)], [das $c$-fache der Zeile $j$ zur Zeile $i$ addieren (die Zeile $j$ bleibt unverändert)])]

#satz[Zeilenumformungen erhalten die Lösungsmenge][Entsteht $(A' | bold(b)')$ aus $(A | bold(b))$ durch endlich viele elementare Zeilenumformungen, so haben die LGS $A bold(x) = bold(b)$ und $A' bold(x) = bold(b)'$ dieselbe Lösungsmenge.]

Das ist genau der Satz von Woche 1, nur in der neuen Sprache: Jede Zeilenumformung entspricht einer Äquivalenzumformung von Gleichungen.

#merke[*Die Spalten der Koeffizientenmatrix sind heilig.* Man darf nur Zeilen umformen. Spaltenvertauschungen gehören *nicht* zu den erlaubten Umformungen, denn sie vertauschen die Unbekannten (würde man es dennoch tun, müsste man sich das Vertauschen der Variablen merken).]

== Das Gausssche Eliminationsverfahren

#rezept[Gauss-Algorithmus (Vorwärtselimination)][
  Gegeben ist die erweiterte Matrix $(A | bold(b))$. Beginne mit der ersten Zeile und der ersten Spalte.
  + *Pivotspalte suchen:* Gehe in der aktuellen Teilmatrix (Zeilen ab der aktuellen Zeile $r$) zur ersten Spalte $s$, die nicht nur Nullen enthält. Gibt es keine, so bist du fertig.
  + *Pivot wählen:* Steht in der aktuellen Zeile an der Stelle $s$ eine $0$, so tausche diese Zeile mit einer darunterliegenden, die dort einen Eintrag $!= 0$ hat. Der Eintrag auf Position $(r, s)$ ist der *Pivot*.
  + *Eliminieren:* Mache alle Einträge *unter* dem Pivot in Spalte $s$ zu Null: Ersetze für jede Zeile $i > r$ die Zeile $Z_i$ durch $Z_i - (a_(i s) \/ a_(r s)) Z_r$.
  + *Weiter:* Setze $r arrow.l r + 1$ und wiederhole ab Schritt 1 mit der Restmatrix unter und rechts vom Pivot.
  Das Ergebnis ist eine Matrix in *Zeilenstufenform* («Treppenform»). Danach folgt das *Rückwärtseinsetzen* (Woche 3 behandelt den allgemeinen Fall).
]

#fg("l02_elim", [Das Verfahren erzeugt Schritt für Schritt eine Treppe aus Nullen unterhalb der Pivots (Pivots sind rot, $*$ steht für beliebige Einträge).], w: 100%)

=== Beispiel 1: eindeutige Lösung

#bsp[Das System der Woche 1 in Matrixform][
$ mat(1, 1, 1, 6; 2, -1, 1, 3; 1, 3, -1, 4; augment: #3) zu(Z_2 - 2 Z_1) mat(1, 1, 1, 6; 0, -3, -1, -9; 1, 3, -1, 4; augment: #3) zu(Z_3 - Z_1) mat(1, 1, 1, 6; 0, -3, -1, -9; 0, 2, -2, -2; augment: #3) $
Der Pivot der zweiten Zeile ist $-3$. Um die $2$ darunter zu beseitigen, braucht man $Z_3 + (2\/3) Z_2$. Um Brüche zu vermeiden, multipliziert man zuerst $Z_3$ mit 3 und addiert dann $2 Z_2$:
$ mat(1, 1, 1, 6; 0, -3, -1, -9; 0, 2, -2, -2; augment: #3) zu(Z_3 arrow.r 3 Z_3) mat(1, 1, 1, 6; 0, -3, -1, -9; 0, 6, -6, -6; augment: #3) zu(Z_3 + 2 Z_2) mat(1, 1, 1, 6; 0, -3, -1, -9; 0, 0, -8, -24; augment: #3) $
Das ist eine Dreiecksform (hier zugleich Zeilenstufenform). *Rückwärtseinsetzen:* Aus der letzten Zeile $-8 z = -24$ folgt $z = 3$. Zweite Zeile: $-3y - z = -9$, also $-3y = -6$, $y = 2$. Erste Zeile: $x + y + z = 6$, also $x = 1$. Lösung: $L = {(1, 2, 3)}$.
]

=== Beispiel 2: unendlich viele Lösungen

Hier hat das System *mehr Unbekannte als Gleichungen*: drei Gleichungen, vier Unbekannte.

#bsp[Ein unterbestimmtes System][
$ x_1 + 2x_2 + x_3 + x_4 &= 4 \ 2x_1 + 4x_2 + 3x_3 + x_4 &= 9 \ x_1 + 2x_2 + 2x_3 &= 5 $
$ mat(1, 2, 1, 1, 4; 2, 4, 3, 1, 9; 1, 2, 2, 0, 5; augment: #4) zu(Z_2 - 2 Z_1, Z_3 - Z_1) mat(1, 2, 1, 1, 4; 0, 0, 1, -1, 1; 0, 0, 1, -1, 1; augment: #4) zu(Z_3 - Z_2) mat(1, 2, 1, 1, 4; 0, 0, 1, -1, 1; 0, 0, 0, 0, 0; augment: #4) $
Die dritte Zeile ist eine *Nullzeile* ($0 = 0$): Die dritte Gleichung war eine Folge der ersten beiden (sie lieferte keine neue Information). Es bleiben *zwei* Gleichungen für *vier* Unbekannte. In der zweiten Zeile steht in Spalte 2 eine $0$, der Pivot liegt also in der *dritten* Spalte (Pivot $1$ bei $x_3$). Die Spalten 1 und 3 haben Pivots, die Spalten 2 und 4 nicht. Die zu den Spalten ohne Pivot gehörenden Unbekannten $x_2$ und $x_4$ kann man *frei wählen*: $x_2 = s$ und $x_4 = t$ mit $s, t in RR$.
Zweite Zeile: $x_3 - x_4 = 1$, also $x_3 = 1 + t$. Erste Zeile: $x_1 + 2x_2 + x_3 + x_4 = 4$, also $x_1 = 4 - 2s - (1 + t) - t = 3 - 2s - 2t$.
$ L = {(3 - 2s - 2t, quad s, quad 1 + t, quad t) : s, t in RR}. $
Probe an der ursprünglichen ersten Gleichung: $(3 - 2s - 2t) + 2s + (1 + t) + t = 4$ ✓. Dritte: $(3 - 2s - 2t) + 2s + 2(1 + t) = 5$ ✓.
]

Zwei freie Parameter heisst: Die Lösungsmenge ist eine *Ebene* im $RR^4$ (zweidimensional). Wann man wie viele Parameter bekommt, regelt der Begriff des *Rangs* (Woche 4).

=== Beispiel 3: keine Lösung

Ändern wir die rechte Seite der dritten Gleichung von $5$ auf $6$:

#bsp[Ein widersprüchliches System][
$ mat(1, 2, 1, 1, 4; 2, 4, 3, 1, 9; 1, 2, 2, 0, 6; augment: #4) zu(Z_2 - 2 Z_1, Z_3 - Z_1) mat(1, 2, 1, 1, 4; 0, 0, 1, -1, 1; 0, 0, 1, -1, 2; augment: #4) zu(Z_3 - Z_2) mat(1, 2, 1, 1, 4; 0, 0, 1, -1, 1; 0, 0, 0, 0, 1; augment: #4) $
Die letzte Zeile bedeutet $0 x_1 + 0 x_2 + 0 x_3 + 0 x_4 = 1$, also $0 = 1$: *Widerspruch*. Das System hat keine Lösung, $L = emptyset$.
]

Ein einziger Eintrag in der rechten Spalte entscheidet über lösbar oder unlösbar. Das ist die *Verträglichkeitsbedingung*, die wir nächste Woche systematisch untersuchen.

#merke[*Das Ergebnis des Verfahrens lesen:*
- Eine Zeile $(0, dots, 0 | c)$ mit $c != 0$ $arrow.r$ *keine Lösung*.
- Sonst gibt es Lösungen. *Jede Spalte ohne Pivot* gibt einen *freien Parameter*. Gibt es keine solche Spalte, ist die Lösung *eindeutig*.]

== Rechnen ohne Fehler: Tipps

#rezept[Sauberes Rechnen von Hand][
  + Schreibe bei *jeder* Umformung dazu, was du getan hast ($Z_2 - 2 Z_1$), und zwar *vor* dem Ausrechnen. So findet man Fehler wieder.
  + Immer *nur eine Art von Umformung pro Schritt*, aber mehrere Zeilen gleichzeitig sind erlaubt, solange sie sich nur auf die unveränderte Pivotzeile beziehen.
  + Wähle (wenn möglich) *Pivots, die $1$ oder $-1$ sind*, oder vertausche Zeilen, um Brüche zu vermeiden.
  + *Probe* am Schluss immer in den *ursprünglichen* Gleichungen.
]

== Pivotwahl in der Numerik: warum man tauscht

Rechnet man von Hand mit exakten Zahlen, ist jeder Pivot $!= 0$ gleich gut. Ein Computer rechnet aber mit gerundeten Zahlen (Gleitkommazahlen mit rund 16 Stellen, vgl. Informatik), und dann kann ein *kleiner* Pivot katastrophal sein.

#bsp[Ein winziger Pivot][
$ 10^(-20) x + y = 1, quad x + y = 2. $
Die exakte Lösung ist $x = 1 \/ (1 - 10^(-20)) approx 1$ und $y = 1 - 10^(-20) approx 1$ (beide auf 16 Stellen gleich 1).
*Ohne Zeilentausch* (Pivot $10^(-20)$): Der Faktor ist $10^(20)$. Die zweite Zeile wird $(1 - 10^(20)) y = 2 - 10^(20)$. Auf einem Rechner mit 16 Stellen ist $1 - 10^(20) = -10^(20)$ und $2 - 10^(20) = -10^(20)$ (die kleinen Zahlen gehen «unter»), also $y = 1$. Dann folgt aus der ersten Zeile $10^(-20) x = 1 - y = 0$, also $x = 0$. *Falsch!* (Die wahre Lösung hat $x approx 1$.)
*Mit Zeilentausch* (Pivot $1$): Man tauscht die Zeilen und eliminiert mit dem Faktor $10^(-20)$. Es entsteht $(1 - 10^(-20)) y = 1 - 2 dot 10^(-20)$, gerundet $y = 1$, und aus der ersten Zeile $x + y = 2$ folgt $x = 1$. Richtig.
]

Rechnet man das Beispiel in doppelter Genauigkeit (`double`) nach, so liefert der Rechner ohne Tausch $x = 0$, mit Tausch $x = 1$. Die Regel, die jedes seriöse Programm anwendet, heisst *Spaltenpivotisierung* (Teilpivotisierung): Man wählt als Pivot jeweils den *betragsgrössten* Eintrag der Pivotspalte unterhalb (und einschliesslich) der aktuellen Zeile und vertauscht ihn nach oben. Dann sind alle Faktoren betragsmässig $<= 1$, und Rundungsfehler können nicht verstärkt werden.

#hist[Dass der Rundungsfehler beim Eliminationsverfahren harmlos bleibt, wenn man Pivots geschickt wählt, hat 1947 die Analyse von John von Neumann und Herman Goldstine gezeigt, später ausgebaut von James Wilkinson. Davor befürchtete man, dass bei grossen Systemen die Fehler unkontrolliert anwachsen.]

== Aufwand

Wie viel Arbeit macht das Verfahren für $n$ Gleichungen und $n$ Unbekannte? Im Schritt $k$ muss man in $n - k$ Zeilen je einen Faktor bestimmen und die $n - k + 1$ Einträge (inklusive rechter Seite) der Restzeile aktualisieren. Mit $j = n - k$ sind das $j(j + 1)$ Multiplikationen (die Faktorbildung mitgezählt), insgesamt
$ sum_(j=1)^(n-1) j(j + 1) = frac((n - 1) n (n + 1), 3) approx n^3/3. $
Verdoppelt man $n$, so wird die Rechnung *achtmal* aufwändiger. Das anschliessende Rückwärtseinsetzen kostet nur etwa $n^2\/2$ Multiplikationen und fällt für grosse $n$ nicht ins Gewicht.

#kurz[
- Ein LGS hat vier Schreibweisen; die *erweiterte Matrix* $(A | bold(b))$ und die *Matrixgleichung* $A bold(x) = bold(b)$ sind die wichtigsten. $A bold(x)$ ist «Zeilen mal Vektor» und gleichzeitig eine *Linearkombination der Spalten*.
- *Elementare Zeilenumformungen*: Zeilen vertauschen, Zeile mit $c != 0$ multiplizieren, Vielfaches einer Zeile zu einer anderen addieren. Sie ändern $L$ nicht.
- *Gauss*: Pivot wählen, darunter Nullen erzeugen, mit der Restmatrix weitermachen $arrow.r$ Zeilenstufenform; dann rückwärts einsetzen.
- Ergebnis: Zeile $(0 dots 0 | c)$, $c != 0$ $arrow.r$ keine Lösung; Spalten ohne Pivot $arrow.r$ freie Parameter.
- Numerisch: den betragsgrössten Pivot wählen. Aufwand $approx n^3\/3$.
]

#aufgaben()

#aufg("Eliminationsverfahren mit erweiterter Matrix", [Löse
$ x_1 + 2x_2 + x_3 &= 4 \ 2x_1 + 5x_2 + 3x_3 &= 11 \ x_1 + x_2 + 2x_3 &= 3 $
mit dem Gauss-Verfahren auf der erweiterten Matrix.],
[$ mat(1, 2, 1, 4; 2, 5, 3, 11; 1, 1, 2, 3; augment: #3) zu(Z_2 - 2 Z_1, Z_3 - Z_1) mat(1, 2, 1, 4; 0, 1, 1, 3; 0, -1, 1, -1; augment: #3) zu(Z_3 + Z_2) mat(1, 2, 1, 4; 0, 1, 1, 3; 0, 0, 2, 2; augment: #3) $
Rückwärts: $x_3 = 1$; $x_2 = 3 - 1 = 2$; $x_1 = 4 - 4 - 1 = -1$. Lösung $(-1, 2, 1)$. Probe in der zweiten Gleichung: $-2 + 10 + 3 = 11$ ✓.])

#aufg("Zwei Sichtweisen auf $A bold(x)$", [Berechne $A bold(x)$ für $A = mat(2, -1; 0, 3; 1, 1)$ und $bold(x) = (3, 2)^tp$ zeilenweise und spaltenweise. Welche Dimension hat das Ergebnis?],
[Zeilenweise: $(2 dot 3 - 2, quad 0 + 6, quad 3 + 2) = (4, 6, 5)$. Spaltenweise: $3 vec(2, 0, 1) + 2 vec(-1, 3, 1) = vec(6 - 2, 6, 3 + 2) = vec(4, 6, 5)$. Eine $3 times 2$-Matrix mal ein Vektor im $RR^2$ ergibt einen Vektor im $RR^3$ (Zeilenanzahl).])

#aufg("Freie Parameter", [Bestimme die Lösungsmenge von $x_1 - x_2 + x_3 + 2x_4 = 1$, $quad 2x_1 - 2x_2 + 3x_3 + x_4 = 4$.],
[$ mat(1, -1, 1, 2, 1; 2, -2, 3, 1, 4; augment: #4) zu(Z_2 - 2 Z_1) mat(1, -1, 1, 2, 1; 0, 0, 1, -3, 2; augment: #4) $
Pivots in den Spalten 1 und 3; frei sind $x_2 = s$, $x_4 = t$. Zweite Zeile: $x_3 = 2 + 3t$. Erste: $x_1 = 1 + s - x_3 - 2t = 1 + s - 2 - 3t - 2t = -1 + s - 5t$. $L = {(-1 + s - 5t, s, 2 + 3t, t) : s, t in RR}$. Probe der zweiten Gleichung: $2(-1 + s - 5t) - 2s + 3(2 + 3t) + t = -2 + 2s - 10t - 2s + 6 + 9t + t = 4$ ✓.])

#aufg("Für welche $a$ lösbar?", [Für welche $a in RR$ ist das LGS $x + 2y = 1$, $quad 3x + 6y = a$ lösbar? Wie sieht die Lösungsmenge dann aus?],
[$Z_2 - 3 Z_1$: $0 = a - 3$. Lösbar genau für $a = 3$. Dann bleibt $x + 2y = 1$: $y = t$ frei, $x = 1 - 2t$, $L = {(1 - 2t, t) : t in RR}$ (eine Gerade).])

#aufg("Warum tauscht man Zeilen?", [Warum ist es für den Algorithmus wichtig, dass der Pivot $!= 0$ ist? Was passiert in Schritt 3, wenn man einen Pivot $0$ benutzt?],
[In Schritt 3 steht $Z_i - (a_(i s) \/ a_(r s)) Z_r$: man muss durch den Pivot $a_(r s)$ teilen. Bei $a_(r s) = 0$ ist der Faktor nicht definiert. Findet man in der Spalte darunter einen Eintrag $!= 0$, tauscht man die Zeilen. Findet man keinen, ist die Spalte (ab dieser Zeile) eine Nullspalte, und man geht zur nächsten Spalte weiter (Spalte ohne Pivot).])
