#import "lib.typ": *

= Äquivalenz und Reduktion von Kräftegruppen

An einem Bauteil greifen oft Dutzende Kräfte an. Die Frage dieses Kapitels: Kann man sie durch etwas Einfacheres ersetzen, ohne dass der (starre) Körper einen Unterschied merkt? Die Antwort ist ja, und sie ist erstaunlich handlich: Es kommt nur auf die Summe der Kräfte und die Summe ihrer Momente an.

== Statische Äquivalenz

#defn[Statisch äquivalent][
  Zwei Kräftegruppen ${G}$ und ${G^*}$ am selben Körper heißen *statisch äquivalent*, wenn sie bei *jeder* Starrkörperbewegung dieselbe Gesamtleistung haben.
]

Mit der Leistungsformel $PP = vv_O dot.c vR + vom dot.c vM_O$ aus Kapitel 5 lässt sich das sofort auswerten. Soll $vv_O dot.c vR + vom dot.c vM_O = vv_O dot.c vR^* + vom dot.c vM_O^*$ für _alle_ Kinematen ${vv_O, vom}$ gelten, so müssen die Faktoren einzeln übereinstimmen (wähle erst reine Translationen, dann reine Rotationen):

#satz[Kriterium der statischen Äquivalenz][
  Zwei Kräftegruppen sind genau dann statisch äquivalent, wenn ihre Resultierenden und ihre Momente bezüglich eines (beliebigen) Punktes übereinstimmen:
  #gl($ vR = vR^*, wide vM_O = vM_O^*. $)
]

#merke[
  «Statisch äquivalent» heißt: gleich _für den starren Körper als Ganzes_ (Gleichgewicht, Bewegung). Es heißt *nicht*, dass die Wirkung im Inneren dieselbe ist. Ob du einen Balken in der Mitte oder verteilt belastest, kann für die Lagerkräfte egal sein -- für Durchbiegung und innere Beanspruchung ist es das nicht. Für Verformungen und Schnittgrößen darf man Kräfte nicht einfach ersetzen.
]

== Resultierende und Moment

#defn[Resultierende][
  $vR := sum_(i=1)^n vF_i$, komponentenweise $R_x = sum X_i$, $R_y = sum Y_i$, $R_z = sum Z_i$. Die Resultierende ist zunächst nur ein Vektor ohne Angriffspunkt.
]

#defn[Moment][
  Moment einer Einzelkraft bezüglich $O$: $vM_O := arrow(O A) times vF$. Moment einer Kräftegruppe: $vM_O := sum_i arrow(O A_i) times vF_i$.
]

=== Das Moment anschaulich: Hebelarm

#fig(13, 4.2, caption: [Links: Der Betrag des Moments ist Kraft mal Hebelarm $a$, dem senkrechten Abstand des Bezugspunkts von der Wirkungslinie. Rechts: Verschiebt man die Kraft längs ihrer Wirkungslinie, ändern sich weder Hebelarm noch Moment.],
  dl((0.6,1.2),(6.4,3.52)),
  pt((1.6,3.4)), lbl((1.35,3.6), $O$),
  li((1.6,3.4),(2.39,1.92), s: 0.9pt + cm), lbl((1.75,2.5), $a$, c: cm),
  li((2.39,1.92),(2.25,2.18), s: 0.4pt + cg), 
  arr((1.6,3.4),(4.0,2.56), w: 0.6pt, hs: 0.13), lbl((3.0,3.25), $arrow(O A)$, size: 8pt),
  arr((4.0,2.56),(5.86,3.3), c: cf, w: 1.4pt), pt((4.0,2.56)), lbl((4.05,2.25), $A$), lbl((5.6,2.85), $vF$, c: cf),
  arc((1.6,3.4), 0.45, 200, 420, col: cm, head: true, hs: 0.12), lbl((0.75,3.2), $vM_O$, c: cm, size: 8pt),
  lbl((4.6,0.5), $|vM_O| = F a$),
  // rechts
  dl((7.4,1.2),(13.0,3.44)),
  pt((8.4,3.4)), lbl((8.15,3.6), $O$),
  arr((8.6,1.68),(10.46,2.42), c: cf, w: 0.9pt, dash: "dashed"), arr((10.8,2.56),(12.66,3.3), c: cf, w: 1.4pt),
  pt((8.6,1.68)), pt((10.8,2.56)), lbl((8.7,1.35), $A$), lbl((10.9,2.25), $A'$),
  li((8.4,3.4),(9.19,1.92), s: 0.9pt + cm), lbl((8.55,2.5), $a$, c: cm),
  lbl((11.2,0.5), [gleiches $vR$, gleiches $vM_O$]),
)

Für den Betrag gilt
#gl($ |vM_O| = |vF| dot.c overline(O A) sin alpha = F a. $)
Die Richtung von $vM_O$ steht senkrecht auf der Ebene durch $O$ und die Wirkungslinie; der Drehsinn folgt der Rechte-Hand-Regel. In ebenen Aufgaben zeigt jedes Moment in $plus.minus z$-Richtung, und man rechnet nur mit der Zahl $M_z$: positiv im Gegenuhrzeigersinn.

Kartesisch, mit $arrow(O A) = (x, y, z)$ und $vF = (X, Y, Z)$:
#gl($ M_x = y Z - z Y, quad M_y = z X - x Z, quad M_z = x Y - y X. $)

=== Moment bezüglich einer Achse

Das Moment einer Kraft bezüglich einer Achse $zeta$ (Einheitsvektor $ve_zeta$) ist die Projektion $M_zeta := ve_zeta dot.c vM_B$ für irgendeinen Punkt $B$ auf der Achse; das Ergebnis hängt nicht von der Wahl von $B$ ab. Anschaulich: Es misst, wie stark die Kraft den Körper _um diese Achse_ drehen will.

#satz[Wann das Achsenmoment verschwindet][
  $M_zeta = 0$ genau dann, wenn die Wirkungslinie der Kraft die Achse *schneidet* oder zu ihr *parallel* ist. Sonst gilt $|M_zeta| = a |vF_perp|$ mit dem Kraftanteil $vF_perp$ senkrecht zur Achse und dessen Abstand $a$ von der Achse.
]

#intu[
  Eine Tür dreht um ihre Scharnierachse. Drückst du in Richtung der Scharniere (Wirkungslinie schneidet die Achse) oder ziehst du die Tür nach oben (parallel zur Achse), dreht sie sich nicht. Nur der Anteil, der quer zur Achse an ihr vorbeizielt, dreht. Diese Regel spart in räumlichen Aufgaben viel Arbeit: Wähle Momentenachsen, die möglichst viele unbekannte Kräfte schneiden.
]

=== Wechsel des Bezugspunkts

Das Moment hängt vom Bezugspunkt ab. Für zwei Punkte $O, P$ gilt
#gl($ vM_P = vM_O + arrow(P O) times vR. $)

Lies das so: Moment bezüglich $P$ = Moment bezüglich $O$ + Moment der in $O$ gedachten Resultierenden bezüglich $P$. Vergleiche mit $vv_P = vv_O + vom times arrow(O P)$ aus Kapitel 3 -- dieselbe Struktur, mit den Rollen $vom <-> vR$ und $vv <-> vM$.

#defn[Dyname][
  Das Paar ${vR, vM_O}$ aus Resultierender und Moment bezüglich $O$ heißt *Dyname* der Kräftegruppe in $O$. Zwei Kräftegruppen sind statisch äquivalent, wenn sie dieselbe Dyname haben.
]

== Die wichtigsten Spezialfälle

=== Verschiebungssatz

Zwei Einzelkräfte mit gleichem Vektoranteil sind genau dann statisch äquivalent, wenn sie *dieselbe Wirkungslinie* haben. Am starren Körper darf man eine Kraft also längs ihrer Wirkungslinie verschieben (Abb. 6.1 rechts). Man sagt, die Kraft sei ein _linienflüchtiger_ Vektor.

=== Kräfte mit gemeinsamem Angriffspunkt, nichtparallele Kräfte in einer Ebene

Kräfte am selben Punkt ersetzt man durch ihre Vektorsumme an diesem Punkt (Parallelogrammregel). Zwei nichtparallele Kräfte in einer Ebene verschiebt man längs ihrer Wirkungslinien bis zum Schnittpunkt und addiert sie dort.

=== Parallele Kräfte: das Hebelgesetz

#fig(13, 3.7, caption: [Zwei gleich gerichtete parallele Kräfte sind einer Einzelkraft $R = F_1 + F_2$ äquivalent, deren Wirkungslinie den Abstand im umgekehrten Verhältnis der Kräfte teilt. Rechts das Kräftepaar: Resultierende null, aber Moment $M = b F$.],
  beam((0.8,1.5),(6.0,1.5), c: cg),
  arr((1.2,3.1),(1.2,1.55), c: cf, w: 1.3pt), arr((5.6,2.3),(5.6,1.55), c: cf, w: 1.3pt),
  arr((2.67,1.45),(2.67,-0.0), c: cf, w: 1.3pt, dash: "dashed"),
  lbl((0.8,2.5), $vF_1$, c: cf), lbl((6.0,2.1), $vF_2$, c: cf), lbl((3.0,0.4), $vR$, c: cf),
  bem((1.2,1.5),(2.67,1.5), $a_1$, off: 0.3), bem((2.67,1.5),(5.6,1.5), $a_2$, off: 0.3),
  lbl((4.6,0.4), $a_1 F_1 = a_2 F_2$, size: 8.5pt),
  // Kräftepaar
  rct((8.2,0.9),(12.4,3.1)),
  arr((9.0,1.4),(9.0,2.8), c: cf, w: 1.3pt), arr((11.6,2.6),(11.6,1.2), c: cf, w: 1.3pt),
  lbl((8.65,2.6), $vF$, c: cf), lbl((12.05,1.4), $-vF$, c: cf),
  bem((9.0,1.2),(11.6,1.2), $b$, off: -0.6),
  arc((10.3,2.0), 0.5, 150, -150, col: cm, head: true), lbl((10.3,2.0), $M$, c: cm, size: 8pt),
)

Für zwei parallele Kräfte mit $vR != bold(0)$ liegt die äquivalente Einzelkraft auf einer parallelen Wirkungslinie mit
#gl($ a_1 |vF_1| = a_2 |vF_2|, $)
wobei $a_1, a_2$ die Abstände der Wirkungslinie von $vR$ zu jenen von $vF_1, vF_2$ sind. Bei gleich gerichteten Kräften liegt sie dazwischen (näher bei der größeren), bei entgegengesetzten außerhalb, auf der Seite der größeren.

=== Kräftepaar

#defn[Kräftepaar][
  Zwei parallele Kräfte mit $vF_1 + vF_2 = bold(0)$ (gleich groß, entgegengesetzt, verschiedene Wirkungslinien) bilden ein *Kräftepaar*. Sein Moment
  #gl($ vM = arrow(A' A) times vF, wide |vM| = b |vF| $)
  ($b$: Abstand der Wirkungslinien, «Breite») ist für _jeden_ Bezugspunkt dasselbe.
]

Weil $vR = bold(0)$ ist, fällt in $vM_P = vM_O + arrow(P O) times vR$ der Zusatzterm weg: Das Moment eines Kräftepaars ist ein *freier Vektor*. Man darf ein Kräftepaar am starren Körper beliebig verschieben und in seiner Ebene drehen, und man darf $F$ und $b$ verändern, solange $b F$ gleich bleibt. Deshalb zeichnet man es oft nur als gebogenen Pfeil mit dem Wert $M$.

#intu[
  Ein Kräftepaar ist «reine Drehwirkung». Zwei Hände am Lenkrad, eine zieht, eine drückt: Das Lenkrad wird nirgendwohin geschoben, es wird nur gedreht. Ein Kräftepaar lässt sich nie durch eine einzelne Kraft ersetzen, und umgekehrt. Kraft und Kräftepaar sind die beiden Grundbausteine jeder Belastung.
]

=== Eine Kraft parallel verschieben

#fig(12.5, 2.9, caption: [Parallelverschiebung einer Kraft: Man fügt in $B$ die Nullgruppe $vF, -vF$ hinzu. Übrig bleiben die Kraft in $B$ und ein Kräftepaar mit dem Moment $M = d F$ (Versetzungsmoment).],
  ..(0.6, 4.9, 9.2).map(x0 => rct((x0, 0.7), (x0 + 3.0, 2.0))),
  arr((3.0,0.2),(3.0,1.35), c: cf, w: 1.3pt), pt((3.0,1.35)), pt((1.2,1.35)), lbl((1.2,1.65), $B$, size: 8pt), lbl((3.0,1.65), $A$, size: 8pt), lbl((3.35,0.4), $vF$, c: cf),
  lbl((4.25,1.35), $=$, size: 12pt),
  arr((7.3,0.2),(7.3,1.35), c: cf, w: 1.3pt), arr((5.5,0.2),(5.5,1.35), c: cf, w: 1.3pt), arr((5.5,2.5),(5.5,1.35), c: cf, w: 1.3pt, dash: "dashed"), pt((7.3,1.35)), pt((5.5,1.35)),
  lbl((8.55,1.35), $=$, size: 12pt),
  arr((9.8,0.2),(9.8,1.35), c: cf, w: 1.3pt), pt((9.8,1.35)), lbl((10.15,0.4), $vF$, c: cf),
  arc((11.2,1.35), 0.4, -140, 140, col: cm, head: true), lbl((11.2,1.35), $M$, c: cm, size: 8pt),
  bem((1.2,2.0),(3.0,2.0), $d$, off: 0.25),
)

Das ist der anschauliche Inhalt von $vM_P = vM_O + arrow(P O) times vR$: Eine Kraft darf man an jeden Punkt verschieben, wenn man das dabei «verlorene» Moment als Kräftepaar dazugibt.

== Gleichgewicht einer Kräftegruppe

#defn[Gleichgewicht, Nullgruppe][
  Eine Kräftegruppe ist *im Gleichgewicht* (sie ist eine *Nullgruppe*), wenn
  #gl($ vR = bold(0), wide vM_O = bold(0). $)
  Die erste Gleichung heißt *Komponentenbedingung*, die zweite *Momentenbedingung*. Ist $vR = bold(0)$, so ist $vM_O = bold(0)$ für alle Bezugspunkte zugleich erfüllt oder für keinen.
]

Eine Nullgruppe hat bei jeder Starrkörperbewegung die Leistung null; man darf sie zu jeder Kräftegruppe hinzufügen oder weglassen, ohne die statische Äquivalenz zu ändern. Im Raum sind das 6 skalare Gleichungen, in der Ebene 3 ($R_x = 0$, $R_y = 0$, $M_z = 0$).

#satz[Zwei und drei Kräfte im Gleichgewicht][
  - *Zwei* Kräfte sind nur dann im Gleichgewicht, wenn sie gleich groß und entgegengesetzt sind und auf *derselben Wirkungslinie* liegen.
  - *Drei* nichtparallele Kräfte in einer Ebene sind nur dann im Gleichgewicht, wenn sich ihre Wirkungslinien in *einem Punkt* schneiden (und ihre Vektoren ein geschlossenes Dreieck bilden).
]

Beides folgt direkt aus der Momentenbedingung (wähle den Bezugspunkt auf einer bzw. im Schnittpunkt zweier Wirkungslinien) und ist in Aufgaben ein mächtiges Werkzeug: Kennt man zwei Wirkungslinien, kennt man die Richtung der dritten Kraft.

== Reduktion einer Kräftegruppe

*Reduktion* heißt: die einfachste statisch äquivalente Kräftegruppe finden. Der erste Schritt ist immer die Dyname ${vR, vM_B}$ in einem bequemen Punkt $B$: eine Einzelkraft $vR$ in $B$ plus ein Kräftepaar mit Moment $vM_B$.

Wie bei der Kinemate gibt es zwei *Invarianten*, die nicht vom Bezugspunkt abhängen:
#gl($ "1. Invariante:" quad vR, wide "2. Invariante:" quad vR dot.c vM_P = vR dot.c vM_O. $)
Die zweite bedeutet: Der Anteil $vM^((R))$ des Moments _in Richtung von_ $vR$ ist überall gleich. Nur der Anteil senkrecht zu $vR$ hängt vom Bezugspunkt ab, und er lässt sich durch geschickte Wahl zum Verschwinden bringen. Die Punkte $Z$, in denen das gelingt, bilden die *Zentralachse* (parallel zu $vR$):
#gl($ arrow(B Z) = (vR times vM_B) / (|vR|^2), wide vM_Z = vM^((R)) = lambda vR. $)
Die Dyname ${vR, vM_Z}$ auf der Zentralachse heißt (Kraft-)*Schraube*: eine Kraft und ein Kräftepaar, das um die Richtung dieser Kraft dreht -- wie beim Eindrehen einer Schraube mit dem Schraubenzieher.

#table(columns: (auto, auto, 1fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.6pt),
  [$vR$], [$vM_B$], [*Einfachste äquivalente Kräftegruppe*],
  table.hline(stroke: 0.3pt),
  [$= bold(0)$], [$= bold(0)$], [nichts: Gleichgewicht (Nullgruppe)],
  [$= bold(0)$], [$!= bold(0)$], [ein *Kräftepaar* mit Moment $vM_B$],
  [$!= bold(0)$], [$vR dot.c vM_B = 0$], [eine *Einzelkraft* $vR$ auf der Zentralachse],
  [$!= bold(0)$], [$vR dot.c vM_B != 0$], [eine *Schraube*: $vR$ auf der Zentralachse plus Kräftepaar $vM^((R)) parallel vR$],
  table.hline(stroke: 0.6pt),
)

#merke[
  Bei *ebenen* Kräftegruppen und bei *parallelen* Kräften steht das Moment immer senkrecht auf $vR$, also $vR dot.c vM_B = 0$. Solche Kräftegruppen lassen sich daher immer auf eine Einzelkraft reduzieren (oder auf ein Kräftepaar, wenn $vR = bold(0)$ ist). Die echte Schraube gibt es nur im Raum.
]

#rezept[Ebene Kräftegruppe reduzieren][
  + Koordinaten wählen, alle Kräfte in Komponenten $X_i, Y_i$ zerlegen.
  + $R_x = sum X_i$, $R_y = sum Y_i$.
  + Bezugspunkt $O$ wählen (am besten dort, wo viele Wirkungslinien durchgehen) und $M_O = sum (x_i Y_i - y_i X_i)$ bilden, oder direkt «Kraft mal Hebelarm» mit Vorzeichen nach Drehsinn.
  + Ist $vR != bold(0)$: Die Wirkungslinie der äquivalenten Einzelkraft erfüllt $x R_y - y R_x = M_O$. Ihr Abstand von $O$ ist $a = |M_O| \/ |vR|$.
]

#bsp[Drei Kräfte an einer Platte][
  An einer quadratischen Platte (Seite $a$, Ecken $O(0,0)$, $P(a,0)$, $Q(a,a)$, $S(0,a)$) greifen an: in $P$ die Kraft $(0, F)$, in $Q$ die Kraft $(-F, 0)$, in $S$ die Kraft $(0, -2F)$.
  $ R_x = -F, quad R_y = F - 2F = -F, wide M_O = underbrace(a F, "in" P) + underbrace(a F, "in" Q) + underbrace(0, "in" S) = 2 a F. $
  (Kraft in $Q$: $x Y - y X = a dot.c 0 - a dot.c (-F) = a F$.) Die Gruppe ist einer Einzelkraft $vR = (-F, -F)$ äquivalent, deren Wirkungslinie $x(-F) - y(-F) = 2 a F$, also $y = x + 2a$ erfüllt. Abstand von $O$: $2 a F \/ (sqrt(2) F) = sqrt(2) a$.
]

#fehler[
  - Das Moment einer Kräftegruppe als «Moment der Resultierenden» berechnen, ohne zu wissen, wo die Resultierende angreift. $vR$ allein hat keinen Angriffspunkt.
  - Bei $vR = bold(0)$ auf Gleichgewicht schließen. Es kann ein Kräftepaar übrig bleiben.
  - Hebelarm bis zum Angriffspunkt statt senkrecht bis zur Wirkungslinie messen.
  - Vorzeichen: In der Ebene eine Drehrichtung als positiv festlegen (üblich: Gegenuhrzeigersinn) und konsequent beibehalten.
]

#kurz[
  - Statisch äquivalent $<=>$ gleiche Dyname: $vR = vR^*$, $vM_O = vM_O^*$.
  - $vM_O = arrow(O A) times vF$, Betrag = Kraft $times$ Hebelarm; $vM_P = vM_O + arrow(P O) times vR$.
  - Kraft längs der Wirkungslinie verschiebbar; Parallelverschiebung kostet ein Versetzungsmoment.
  - Kräftepaar: $vR = bold(0)$, Moment $b F$, freier Vektor.
  - Gleichgewicht: $vR = bold(0)$ und $vM_O = bold(0)$.
  - Reduktion: Nullgruppe, Kräftepaar, Einzelkraft oder Schraube; Zentralachse $arrow(B Z) = (vR times vM_B) \/ R^2$.
]
