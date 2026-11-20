#import "lib.typ": *

= Zeilenstufenform, freie Parameter und Geometrie von LGS

#woche(3, [Zeilenstufenform, Pivots, Parameter, Geometrie], [Zeilenstufenform · Pivots · freie Parameter · Verträglichkeitsbedingungen · Ebenen und Geraden · Hessesche Normalform])

#vorlesung[Das Gauss-Verfahren endet nicht immer in einem schönen Dreieck. Meist bleibt eine «Treppe» übrig, mit Nullzeilen am Ende und Spalten, in denen kein Pivot steht. Diese Woche beschreiben wir dieses Endergebnis ganz genau (Zeilenstufenform), lesen daraus *alle* Lösungen ab (freie Parameter), erklären, wann ein System überhaupt lösbar ist (Verträglichkeit) und sehen, wie die Lösungsmengen geometrisch aussehen: als Punkte, Geraden und Ebenen.]

== Die Zeilenstufenform

#defn[Zeilenstufenform][Eine Matrix ist in *Zeilenstufenform* (ZSF), wenn
+ alle *Nullzeilen* (Zeilen, die nur aus Nullen bestehen) ganz *unten* stehen, und
+ in jeder anderen Zeile der *führende Eintrag* (der erste Eintrag $!= 0$ von links) *weiter rechts* steht als der führende Eintrag der Zeile darüber.
Die führenden Einträge heissen *Pivots*, die Spalten, in denen sie stehen, *Pivotspalten*.]

Die Einträge links von und unterhalb jedes Pivots sind dann alle Null, die Pivots bilden eine «Treppe» von links oben nach rechts unten. Die Stufen können verschieden breit sein.

#fg("l03_zsf", [Eine Matrix in Zeilenstufenform, hier die erweiterte Matrix eines Systems mit 5 Unbekannten und 4 Gleichungen. Die Pivots (rot) stehen in den Spalten 2, 4, 5. Die Treppenlinie trennt den Bereich der Nullen ab.], w: 78%)

#bsp[Zeilenstufenform oder nicht?][
$ A_1 = mat(2, 1, 3; 0, 0, 5; 0, 0, 0), quad A_2 = mat(0, 1, 2; 1, 0, 3; 0, 0, 1), quad A_3 = mat(1, 2, 3; 0, 1, 4; 0, 1, 5). $
$A_1$ ist in ZSF (Pivots $2$ in Spalte 1 und $5$ in Spalte 3; die Nullzeile steht unten). $A_2$ nicht: Der Pivot $1$ der zweiten Zeile steht in Spalte 1, links vom Pivot der ersten Zeile (Spalte 2). $A_3$ nicht: Die Pivots der zweiten und dritten Zeile stehen beide in Spalte 2.
]

#satz[Existenz][Jede Matrix lässt sich durch endlich viele elementare Zeilenumformungen in Zeilenstufenform bringen.]

#beweisidee[Das ist genau der Gauss-Algorithmus der letzten Woche. Er behandelt die erste Pivotspalte, macht darunter alles zu Null und wiederholt das Verfahren auf der kleineren Matrix unterhalb und rechts des Pivots. Da diese Restmatrix in jedem Schritt mindestens eine Zeile verliert, bricht das Verfahren nach höchstens $m$ Schritten ab.]

=== Die reduzierte Zeilenstufenform

Man kann noch einen Schritt weitergehen und auch *oberhalb* der Pivots Nullen erzeugen (das ist das Gauss-Jordan-Verfahren, Woche 6):

#defn[Reduzierte Zeilenstufenform][Eine Matrix in ZSF ist in *reduzierter Zeilenstufenform*, wenn zusätzlich jeder Pivot den Wert $1$ hat und in jeder Pivotspalte ausser dem Pivot nur Nullen stehen.]

Man erreicht sie aus der ZSF, indem man jede Pivotzeile durch ihren Pivot teilt und dann von unten nach oben die Pivotspalten oberhalb der Pivots ausräumt. Die reduzierte ZSF einer Matrix ist *eindeutig* (die ZSF selbst nicht: Man darf z. B. Zeilen mit Faktoren multiplizieren). Die *Anzahl* der Pivots ist aber immer dieselbe, egal, auf welchem Weg man zur ZSF kommt. Diese Zahl ist der *Rang* (Woche 4).

== Lösungen aus der Zeilenstufenform ablesen

Wende Gauss auf die erweiterte Matrix $(A | bold(b))$ an. Dann gilt für ein System mit $n$ Unbekannten:

#rezept[Lösungsmenge aus der ZSF][
  + *Widerspruch?* Steht in der ZSF eine Zeile $(0, dots, 0 | c)$ mit $c != 0$, so ist $L = emptyset$. Ende.
  + Sonst: Die Unbekannten zu den *Pivotspalten* heissen *Pivotvariablen* (oder gebundene Variablen), alle anderen *freie Variablen*.
  + Setze jede freie Variable gleich einem *Parameter* ($s$, $t$, dots), der beliebige reelle Werte annehmen darf.
  + Löse die Gleichungen *von unten nach oben* nach den Pivotvariablen auf. Jede Pivotvariable ergibt sich aus den Parametern und der rechten Seite.
]

#bsp[Ein System mit fünf Unbekannten][
Die erweiterte Matrix des Systems $2x_1 + x_2 + 3x_4 + x_5 = 5$, $x_3 - x_4 + 2x_5 = 4$, $3x_5 = 6$ ist bereits in Zeilenstufenform (die vierte Zeile ist eine Nullzeile):
$ mat(2, 1, 0, 3, 1; 0, 0, 1, -1, 2; 0, 0, 0, 0, 3; 0, 0, 0, 0, 0; augment: #5) quad mat(5; 4; 6; 0) $
Pivots stehen in den Spalten 1, 3, 5. Also sind $x_1, x_3, x_5$ Pivotvariablen, $x_2$ und $x_4$ sind frei: $x_2 = s$, $x_4 = t$. Von unten nach oben:
- Zeile 3: $3x_5 = 6$, also $x_5 = 2$.
- Zeile 2: $x_3 = 4 + x_4 - 2x_5 = 4 + t - 4 = t$.
- Zeile 1: $2x_1 = 5 - x_2 - 3x_4 - x_5 = 5 - s - 3t - 2 = 3 - s - 3t$, also $x_1 = 3\/2 - s\/2 - 3t\/2$.
$ L = {(3\/2 - s\/2 - 3t\/2, quad s, quad t, quad t, quad 2) : s, t in RR}. $
Probe in Zeile 1: $2(3\/2 - s\/2 - 3t\/2) + s + 3t + 2 = 3 - s - 3t + s + 3t + 2 = 5$ ✓.
]

#satz[Anzahl der freien Parameter][Ist ein LGS mit $n$ Unbekannten lösbar und hat die ZSF $r$ Pivots (also $r$ Nicht-Nullzeilen), so hat die Lösungsmenge genau $n - r$ freie Parameter. Insbesondere ist die Lösung *eindeutig* genau dann, wenn $r = n$, d. h. wenn *jede* Spalte der Koeffizientenmatrix einen Pivot hat.]

Die Zahl $n - r$ ist die «Anzahl der Freiheitsgrade» des Systems: Sie sagt, wie viele Unbekannte man frei wählen darf, bevor alles Weitere festgelegt ist.

#fehler[
- *Pivotvariable als Parameter wählen.* Als Parameter dürfen nur die Variablen zu Spalten *ohne* Pivot dienen. Wählt man eine Pivotvariable frei, bekommt man falsche oder widersprüchliche Gleichungen.
- *Vergessen, die rechte Spalte zu prüfen.* Eine Nullzeile links vom Strich ist harmlos ($0 = 0$), aber nur dann, wenn rechts auch eine $0$ steht.
- Die *Reihenfolge* der Zeilen beim Rückwärtseinsetzen: immer unten beginnen.
]

== Verträglichkeitsbedingungen

Bisher war die rechte Seite $bold(b)$ fest. Oft fragt man aber: *Für welche rechten Seiten $bold(b)$ ist das System $A bold(x) = bold(b)$ überhaupt lösbar?* Das beantworten die Nullzeilen der ZSF.

#bsp[Bedingung an die rechte Seite][
$ A = mat(1, 2, 1; 2, 4, 3; 3, 6, 4). $
Wir eliminieren mit einer *allgemeinen* rechten Seite $bold(b) = (b_1, b_2, b_3)^tp$:
$ mat(1, 2, 1, b_1; 2, 4, 3, b_2; 3, 6, 4, b_3) zu(Z_2 - 2 Z_1, Z_3 - 3 Z_1) mat(1, 2, 1, b_1; 0, 0, 1, b_2 - 2 b_1; 0, 0, 1, b_3 - 3 b_1) zu(Z_3 - Z_2) mat(1, 2, 1, b_1; 0, 0, 1, b_2 - 2 b_1; 0, 0, 0, b_3 - b_2 - b_1). $
Die letzte Zeile lautet $0 = b_3 - b_2 - b_1$. Das System ist also *genau dann lösbar*, wenn
$ b_1 + b_2 - b_3 = 0 $
gilt. Das ist die *Verträglichkeitsbedingung*. Für $bold(b) = (1, 2, 3)^tp$ ist sie erfüllt, für $bold(b) = (1, 1, 1)^tp$ nicht. Im lösbaren Fall ist $x_2 = s$ frei und $x_3 = b_2 - 2b_1$, $x_1 = 3 b_1 - b_2 - 2s$.
]

#warum[Was die Bedingung bedeutet][In der Matrix $A$ ist die dritte Zeile die Summe der ersten beiden ($3 = 1 + 2$, $6 = 2 + 4$, $4 = 1 + 3$). Dann muss auch die dritte rechte Seite die Summe der ersten beiden sein: $b_3 = b_1 + b_2$. Sonst würden die ersten beiden Gleichungen etwas behaupten, was die dritte widerlegt. Verträglichkeit ist also ein Ausdruck dafür, dass *Abhängigkeiten zwischen den Zeilen* der Matrix sich auch auf der rechten Seite wiederfinden müssen.]

#merke[Jede Nullzeile in der ZSF der *Koeffizientenmatrix* liefert eine Verträglichkeitsbedingung an $bold(b)$, nämlich: die rechte Seite dieser Zeile muss Null werden. Hat die Koeffizientenmatrix *keine* Nullzeile in ihrer ZSF (bei $m$ Gleichungen also $m$ Pivots), so ist das System für *jede* rechte Seite lösbar.]

== Geometrische Interpretation

=== Die Lösungsmenge als geometrisches Objekt

Wir haben gesehen: Bei zwei Unbekannten ist jede Gleichung $a x + b y = c$ eine *Gerade* in der Ebene. Bei drei Unbekannten ist $a x + b y + c z = d$ eine *Ebene* im Raum. Allgemein ist eine Gleichung in $n$ Unbekannten eine *Hyperebene* im $RR^n$ (eine «flache» Menge der Dimension $n - 1$). Die Lösungsmenge des Systems ist der *Durchschnitt* all dieser Hyperebenen.

#table(columns: (auto, 1fr, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), align: left,
  [*Unbekannte*], [*Jede Gleichung ist ...*], [*Lösungsmenge kann sein ...*],
  [$n = 2$], [eine Gerade], [leer, ein Punkt, eine Gerade (bei Gleichheit)],
  [$n = 3$], [eine Ebene], [leer, ein Punkt, eine Gerade, eine Ebene],
  [$n$ beliebig], [eine Hyperebene], [leer, oder ein «flaches Gebilde» der Dimension $n - r$ (Punkt, Gerade, Ebene, ...)])

#fgs(("l03_punkt", "l03_gerade", "l03_parallel", "l03_prisma"), [Drei Ebenen im Raum ($3$ Gleichungen, $3$ Unbekannte): die vier typischen Lagen.])

#bsp[Vier Systeme, vier Bilder][
Jedes der vier Bilder gehört zu einem System. Prüfe die Aussagen mit dem Gauss-Verfahren.
+ $x + y + z = 3, quad x - y = 0, quad z = 1$: $L = {(1, 1, 1)}$, die drei Ebenen schneiden sich in *einem Punkt* (Rang 3).
+ $x + y + z = 3, quad x - y = 1, quad 2x + z = 4$: Die dritte Gleichung ist die Summe der ersten beiden. Es bleiben zwei Ebenen, die sich in einer *Geraden* schneiden: $x = t$, $y = t - 1$, $z = 4 - 2t$.
+ $x + y + z = 3, quad x + y + z = 5, quad x - y = 0$: Die ersten beiden Ebenen sind *parallel* und verschieden: Widerspruch $3 = 5$, $L = emptyset$.
+ $x + y = 1, quad y + z = 1, quad x - z = 1$: Je zwei Ebenen schneiden sich in einer Geraden, die drei Geraden sind aber parallel zueinander und treffen sich nie («Prisma»). Rechnung: $Z_1 - Z_2$ ergibt $x - z = 0$, im Widerspruch zu $x - z = 1$. Also $L = emptyset$. Hier hat die Koeffizientenmatrix den Rang $2$, die erweiterte Matrix den Rang $3$.
]

Fall 4 ist lehrreich: Man kann *nicht* aus «keine zwei Ebenen sind parallel» auf einen gemeinsamen Schnittpunkt schliessen. Nur die Rechnung entscheidet.

=== Zeilenbild und Spaltenbild

Dasselbe System lässt sich auf zwei Arten geometrisch lesen:

#table(columns: (1fr, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Zeilenbild*], [*Spaltenbild*],
  [Jede *Gleichung* ist eine Gerade bzw. Ebene. Gesucht: ein Punkt, der auf allen liegt (Schnittpunkt).], [Die *Spalten* $bold(a)_1, dots, bold(a)_n$ sind Vektoren. Gesucht: Koeffizienten $x_j$, so dass $x_1 bold(a)_1 + dots + x_n bold(a)_n = bold(b)$ (Linearkombination).])

Beide Bilder sind richtig. Das Zeilenbild eignet sich zum Zeichnen, das Spaltenbild zum Verstehen: Das System ist genau dann lösbar, wenn $bold(b)$ im «Gerüst» liegt, das die Spalten aufspannen (Woche 12).

=== Parameterdarstellung

Eine Lösungsmenge mit Parametern ist eine *Parameterdarstellung* eines geometrischen Objekts:
- eine Gerade: $bold(x) = bold(p) + t bold(u)$ mit einem *Stützvektor* $bold(p)$ und einem *Richtungsvektor* $bold(u)$,
- eine Ebene: $bold(x) = bold(p) + s bold(u) + t bold(v)$ mit zwei (nicht parallelen) Richtungsvektoren.

#bsp[Parameterdarstellung ablesen][Die Gerade aus Fall 2: $(x, y, z) = (t, t - 1, 4 - 2t) = (0, -1, 4) + t (1, 1, -2)$. Stützvektor $bold(p) = (0, -1, 4)$ (ein Punkt der Lösungsmenge: $t = 0$), Richtungsvektor $bold(u) = (1, 1, -2)$.
Das Beispiel mit 5 Unbekannten: $bold(x) = (3\/2, 0, 0, 0, 2) + s (-1\/2, 1, 0, 0, 0) + t (-3\/2, 0, 1, 1, 0)$.]

Das ist kein Zufall. In Woche 4 zeigen wir: *Die Lösungsmenge eines lösbaren LGS ist immer eine spezielle («partikuläre») Lösung plus die Lösungen des zugehörigen homogenen Systems*, und diese bilden eine Ebene, Gerade, ... durch den Nullpunkt.

== Hessesche Normalform

Wie beschreibt man Gerade und Ebene so, dass man *Abstände* sofort ablesen kann? Dafür brauchen wir das Skalarprodukt (Woche 7 begründet es genauer).

#defn[Skalarprodukt, Länge][Für $bold(x), bold(y) in RR^n$ ist das *Skalarprodukt* $bold(x) dot bold(y) = x_1 y_1 + dots + x_n y_n$ und die *Länge* (Norm) $|bold(x)| = sqrt(bold(x) dot bold(x))$. Ein Vektor der Länge $1$ heisst *Einheitsvektor*. Zwei Vektoren stehen *senkrecht*, wenn $bold(x) dot bold(y) = 0$ gilt.]

Die Gleichung $a x_1 + b x_2 + c x_3 = e$ lässt sich schreiben als $bold(m) dot bold(x) = e$ mit $bold(m) = (a, b, c)$. Der Vektor $bold(m)$ steht senkrecht auf der Ebene: Sind $bold(x)$ und $bold(x)'$ zwei Punkte der Ebene, so gilt $bold(m) dot (bold(x) - bold(x)') = e - e = 0$. Man nennt $bold(m)$ einen *Normalenvektor*.

#defn[Hessesche Normalform][Teilt man die Gleichung $bold(m) dot bold(x) = e$ durch die Länge $|bold(m)|$, so erhält man mit $bold(n) = bold(m) \/ |bold(m)|$ und $d = e \/ |bold(m)|$ die *Hessesche Normalform (HNF)*
$ bold(n) dot bold(x) = d, quad |bold(n)| = 1. $
(Man wählt das Vorzeichen so, dass $d >= 0$.) $bold(n)$ ist der *Einheitsnormalenvektor*, und $d$ ist der *Abstand der Geraden bzw. Ebene vom Nullpunkt*.]

#fg("l03_hnf", [Gerade $bold(n) dot bold(x) = d$ in der Ebene. Der Einheitsvektor $bold(n)$ zeigt vom Nullpunkt zur Geraden, und $d$ ist ihr Abstand vom Ursprung. Der Abstand eines Punktes $P$ ist $|bold(n) dot bold(p) - d|$.], w: 62%)

#satz[Abstand von einem Punkt][Ist $bold(n) dot bold(x) = d$ die HNF einer Geraden (in $RR^2$) oder Ebene (in $RR^3$) und $P$ ein Punkt mit Ortsvektor $bold(p)$, so ist sein Abstand von der Geraden bzw. Ebene
$ "Abstand"(P) = |bold(n) dot bold(p) - d|. $
Das Vorzeichen von $bold(n) dot bold(p) - d$ verrät die Seite: positiv auf der Seite, in die $bold(n)$ zeigt.]

#beweis[Setze $delta = bold(n) dot bold(p) - d$ und $bold(f) = bold(p) - delta bold(n)$. Dann ist $bold(n) dot bold(f) = bold(n) dot bold(p) - delta (bold(n) dot bold(n)) = bold(n) dot bold(p) - delta = d$, also liegt $bold(f)$ in der Ebene. Die Verbindung $bold(p) - bold(f) = delta bold(n)$ steht senkrecht auf der Ebene und hat die Länge $|delta|$. Der Fusspunkt des Lotes ist also $bold(f)$, und kein anderer Punkt der Ebene kann näher liegen (Pythagoras: jede andere Verbindung hat zusätzlich eine Komponente parallel zur Ebene).]

#bsp[Abstand eines Punktes von einer Ebene][
Die Ebene $E: x + 2y + 2z = 9$ hat den Normalenvektor $bold(m) = (1, 2, 2)$ mit $|bold(m)| = sqrt(1 + 4 + 4) = 3$. Die HNF lautet
$ 1/3 (x + 2y + 2z) = 3, quad bold(n) = (1\/3, 2\/3, 2\/3), quad d = 3. $
Der Ursprung hat also den Abstand $3$ von $E$. Für $P = (1, 1, 1)$ ist $bold(n) dot bold(p) - d = 5\/3 - 3 = -4\/3$. Abstand $4\/3$; negatives Vorzeichen: $P$ liegt auf der Seite des Ursprungs.
Gerade in der Ebene: $3x + 4y = 10$ hat $|bold(m)| = 5$, HNF $(3x + 4y)\/5 = 2$. Der Punkt $(4, 3)$ hat den Abstand $|12 + 12 - 10|\/5 = 14\/5 = 2.8$.
]

#alltag[Abstandsformeln dieser Art stecken in jedem CAD- und Grafikprogramm: Kollisionserkennung (liegt ein Punkt vor oder hinter einer Wand?), Clipping (wird ein Dreieck von einer Ebene abgeschnitten?) und die Trennebenen von Support-Vector-Maschinen im maschinellen Lernen sind Hessesche Normalformen. Das Vorzeichen von $bold(n) dot bold(p) - d$ entscheidet, auf welcher Seite man sich befindet.]

#kurz[
- *Zeilenstufenform:* Nullzeilen unten, Pivots bilden eine Treppe. Jede Matrix lässt sich so umformen (Gauss). Die *reduzierte* ZSF hat Pivots $1$ und Nullen auch über den Pivots.
- Lösungen ablesen: Widerspruchszeile $(0 dots 0 | c)$? Sonst: Pivotvariablen vs. *freie Variablen = Parameter*; von unten nach oben auflösen. Zahl der Parameter $= n - r$.
- *Verträglichkeitsbedingungen:* Nullzeilen der Koeffizientenmatrix zwingen die rechte Seite zu Null.
- Geometrie: Gleichung $arrow.r$ Hyperebene; Lösungsmenge $arrow.r$ Durchschnitt; Lösungen sind Punkt, Gerade, Ebene, dots, oder leer. Parameterdarstellung $bold(p) + s bold(u) + t bold(v)$.
- *HNF* $bold(n) dot bold(x) = d$ mit $|bold(n)| = 1$; Abstand eines Punktes: $|bold(n) dot bold(p) - d|$.
]

#aufgaben()

#aufg("Zeilenstufenform und Lösung", [Bringe $(A | bold(b))$ mit $A = mat(1, 2, -1, 3; 2, 4, 1, 0; 3, 6, 0, 3)$ und $bold(b) = (1, 5, 6)^tp$ auf Zeilenstufenform und bestimme alle Lösungen.],
[$ mat(1, 2, -1, 3, 1; 2, 4, 1, 0, 5; 3, 6, 0, 3, 6) zu(Z_2 - 2 Z_1, Z_3 - 3 Z_1) mat(1, 2, -1, 3, 1; 0, 0, 3, -6, 3; 0, 0, 3, -6, 3) zu(Z_3 - Z_2) mat(1, 2, -1, 3, 1; 0, 0, 3, -6, 3; 0, 0, 0, 0, 0) $
Pivots in Spalte 1 und 3, frei: $x_2 = s$, $x_4 = t$. Zeile 2: $x_3 = 1 + 2t$. Zeile 1: $x_1 = 1 - 2s + x_3 - 3t = 2 - 2s - t$. $L = {(2 - 2s - t, s, 1 + 2t, t)}$. Probe Zeile 2 des Originals: $2(2 - 2s - t) + 4s + (1 + 2t) = 5$ ✓.])

#aufg("Verträglichkeit", [Für welche $(b_1, b_2, b_3)$ ist $x + 2y + z = b_1$, $2x + y + 3z = b_2$, $3x + 3y + 4z = b_3$ lösbar?],
[$ mat(1, 2, 1, b_1; 2, 1, 3, b_2; 3, 3, 4, b_3) zu(Z_2 - 2 Z_1, Z_3 - 3 Z_1) mat(1, 2, 1, b_1; 0, -3, 1, b_2 - 2 b_1; 0, -3, 1, b_3 - 3 b_1) zu(Z_3 - Z_2) mat(1, 2, 1, b_1; 0, -3, 1, b_2 - 2 b_1; 0, 0, 0, b_3 - b_2 - b_1) $
Bedingung: $b_3 = b_1 + b_2$ (die dritte Zeile ist die Summe der beiden ersten).])

#aufg("Drei Ebenen", [Bestimme die Lage der Ebenen $E_1: x + y + z = 1$, $E_2: x - y + z = 3$, $E_3: 2x + 2z = 4$ (leer, Punkt, Gerade?).],
[$E_1 + E_2$ ergibt $2x + 2z = 4$: Die dritte Ebene ist die Summe der ersten beiden, enthält also nichts Neues. Aus $E_1 - E_2$: $2y = -2$, $y = -1$. Dann $x + z = 2$. Lösung: $y = -1$, $x = t$, $z = 2 - t$: eine *Gerade* durch $(0, -1, 2)$ mit Richtung $(1, 0, -1)$.])

#aufg("Hessesche Normalform", [Gegeben ist die Ebene $2x - y + 2z = 6$. Bestimme die HNF und den Abstand des Punktes $P = (3, 2, 4)$ von der Ebene. Auf welcher Seite liegt $P$?],
[$|(2, -1, 2)| = sqrt(4 + 1 + 4) = 3$. HNF: $(2x - y + 2z)\/3 = 2$. Für $P$: $(6 - 2 + 8)\/3 - 2 = 4 - 2 = 2$. Abstand $2$, positives Vorzeichen: $P$ liegt auf der Seite, in die $bold(n) = (2\/3, -1\/3, 2\/3)$ zeigt. (Der Ursprung hat $bold(n) dot bold(0) - 2 = -2 < 0$: Er liegt auf der anderen Seite.)])

#aufg("Freie Parameter zählen", [Ein LGS hat $4$ Gleichungen und $6$ Unbekannte, die ZSF der Koeffizientenmatrix hat $3$ Pivots. Wie viele freie Parameter hat die Lösungsmenge, wenn sie nicht leer ist? Was ist die kleinste mögliche Parameteranzahl für *irgendein* solches System mit $4$ Gleichungen und $6$ Unbekannten?],
[$n - r = 6 - 3 = 3$ freie Parameter. Mehr als $4$ Pivots kann es nicht geben ($4$ Zeilen), also ist $r <= 4$ und die Anzahl der Parameter $n - r >= 6 - 4 = 2$. Ein System mit mehr Unbekannten als Gleichungen kann also nie eindeutig lösbar sein: Es hat entweder keine oder unendlich viele Lösungen.])
