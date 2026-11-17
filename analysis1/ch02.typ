#import "lib.typ": *

= Differentialrechnung

#text(size: 9.5pt, style: "italic")[Vorlesung: Kapitel II. Die Ableitung misst, wie schnell sich eine Grösse ändert. Mit ihr findet man Tangenten, Näherungen, Extremwerte, Grenzwerte (l'Hôpital) und die Form von Kurven.]

== Die Ableitung

#idee[Die Steigung einer Geraden ist «Höhenunterschied durch Längenunterschied». Eine Kurve hat aber in jedem Punkt eine andere Steigung. Die Idee: Man nimmt zwei Punkte auf der Kurve, berechnet die Steigung der Verbindungsgeraden (Sekante) und lässt dann den zweiten Punkt auf den ersten zulaufen. Die Sekante wird dabei zur Tangente, und ihre Steigung ist die *Ableitung*.]

#defn[Differenzen- und Differentialquotient][
  *Differenzenquotient* (Steigung der Sekante):
  $ (Delta f)/(Delta x) = (f(x_0 + Delta x) - f(x_0))/(Delta x). $
  *Differentialquotient* (Steigung der Tangente, Ableitung):
  $ f'(x_0) = (dif f)/(dif x)(x_0) = lim_(Delta x -> 0) (f(x_0 + Delta x) - f(x_0))/(Delta x). $
  Existiert dieser Grenzwert, heisst $f$ *differenzierbar* in $x_0$.
]

#fg("a02_sekante", [Lässt man $Delta x$ gegen $0$ gehen, drehen sich die Sekanten (rot) in die Tangente (grün). Die Steigung der Tangente ist $f'(x_0)$.], w: 60%)

#intu[Drei Arten, $f'(x_0)$ zu lesen:
- *Geometrisch:* die Steigung der Tangente im Punkt $(x_0, f(x_0))$.
- *Physikalisch:* die momentane Änderungsrate. Ist $s(t)$ der Ort, dann ist $s'(t)$ die Momentangeschwindigkeit.
- *Als Näherung:* In der Nähe von $x_0$ ist $f(x_0 + h) approx f(x_0) + f'(x_0) h$. Ein kleiner Schritt $h$ im Input ändert den Output um etwa $f'(x_0)$-mal so viel.]

#bsp[Ableitung aus der Definition: $f(x) = x^2$][
  $ (f(x + h) - f(x))/h = ((x + h)^2 - x^2)/h = (2 x h + h^2)/h = 2x + h quad stretch(->)_(h -> 0) quad 2x. $
  Also $(x^2)' = 2x$. Der entscheidende Schritt: Erst kürzen, _dann_ $h -> 0$ setzen. Direktes Einsetzen gäbe $0\/0$.
]

#satz[Differenzierbar und stetig][
  - Jede differenzierbare Funktion ist stetig.
  - Nicht jede stetige Funktion ist differenzierbar.
]

#grid(columns: (1fr, 4.6cm), column-gutter: 12pt, align: horizon,
  [*Gegenbeispiel* $f(x) = |x|$ bei $x_0 = 0$. Der Differenzenquotient ist $|h|\/h$: von rechts $+1$, von links $-1$. Die einseitigen Grenzwerte sind verschieden, die Ableitung existiert nicht. Anschaulich: Am Knick gibt es keine eindeutige Tangente. Stetig ist $|x|$ trotzdem, man kann den Graphen ohne Absetzen zeichnen.],
  image("figs/a02_betrag.svg", width: 100%))

=== Ableitungsregeln

#formel[Die Regeln][
  #table(columns: (auto, 1fr), stroke: none, inset: (x: 5pt, y: 4.5pt),
    [*Potenzregel*], [$(a x^r)' = a r x^(r-1)$ für jedes reelle $r$],
    [*Summenregel*], [$(g + h)' = g' + h'$],
    [*Produktregel*], [$(g h)' = g' h + g h'$],
    [*Quotientenregel*], [$display((g/h)' = (g' h - g h')/h^2)$ #h(1em) Merkspruch: «NAZ minus ZAN durch N-Quadrat»],
    [*Kettenregel*], [$(g(h(x)))' = g'(h(x)) dot h'(x)$ #h(1em) «äussere Ableitung mal innere Ableitung»],
    [*Umkehrfunktion*], [$display((f^(-1))'(x) = 1/(f'(f^(-1)(x))))$],
  )
]

#warum[Produktregel als Rechteck][
  Stell dir $g dot h$ als Fläche eines Rechtecks mit Seiten $g$ und $h$ vor. Wachsen die Seiten um $Delta g$ und $Delta h$, kommen zwei Streifen dazu, $Delta g dot h$ und $g dot Delta h$, und ein winziges Eckstück $Delta g dot Delta h$. Teilt man durch $Delta x$ und lässt $Delta x -> 0$ gehen, verschwindet das Eckstück (es ist «doppelt klein»), und es bleibt $g' h + g h'$.
]

#rezept[Kettenregel sicher anwenden][
  + Erkenne die *äussere* Funktion $g$ (was zuletzt gerechnet wird) und die *innere* $h$ (was in $g$ eingesetzt wird).
  + Leite $g$ ab und setze $h(x)$ unverändert ein.
  + Multipliziere mit $h'(x)$.
  + Bei mehrfacher Verschachtelung von aussen nach innen weitermachen: $(f(g(h(x))))' = f'(dots) dot g'(dots) dot h'(x)$.
]

#bsp[Kettenregel][
  $f(x) = (3x^2 + 5)^3$. Aussen $g(u) = u^3$, $g'(u) = 3u^2$. Innen $h(x) = 3x^2 + 5$, $h'(x) = 6x$.
  $ f'(x) = 3(3x^2 + 5)^2 dot 6x = 18 x (3x^2 + 5)^2. $
  Weitere Beispiele: $(sin(x^2))' = cos(x^2) dot 2x$, $quad (e^(-x^2\/2))' = -x e^(-x^2\/2)$, $quad (sqrt(1 + cos x))' = (-sin x)\/(2 sqrt(1 + cos x))$.
]

#warum[Ableitung der Umkehrfunktion][
  Es gilt $f(f^(-1)(x)) = x$. Leitet man beide Seiten nach $x$ ab (links mit der Kettenregel), folgt $f'(f^(-1)(x)) dot (f^(-1))'(x) = 1$. Auflösen gibt die Formel. Geometrisch: Spiegelt man an $y = x$, vertauschen sich $Delta x$ und $Delta y$, die Steigung wird zum Kehrwert.
]

#bsp[Umkehrfunktion][
  $f(x) = x^2 + 2$ für $x >= 0$, also $f^(-1)(x) = sqrt(x - 2)$ und $f'(x) = 2x$:
  $ (f^(-1))'(x) = 1/(f'(f^(-1)(x))) = 1/(2 sqrt(x - 2)). $
  Probe durch direktes Ableiten von $sqrt(x - 2)$: dasselbe. Wirklich nützlich ist die Formel, wenn man $f^(-1)$ nicht direkt ableiten kann, wie beim Arkussinus:
]

#bsp[Herleitung von $(arcsin x)'$][
  Mit $f = sin$, $f' = cos$: $(arcsin x)' = 1\/cos(arcsin x)$. Wegen $cos^2 + sin^2 = 1$ und $cos >= 0$ auf $[-pi\/2, pi\/2]$ ist $cos(arcsin x) = sqrt(1 - sin^2(arcsin x)) = sqrt(1 - x^2)$. Also
  $ (arcsin x)' = 1/sqrt(1 - x^2). $
  Genauso erhält man $(arctan x)' = 1\/(1 + x^2)$ und $(ln x)' = 1\/e^(ln x) = 1\/x$.
]

#formel[Ableitungen, die man kennen muss][
  #table(columns: (1fr, 1fr, 1fr), stroke: none, inset: (x: 4pt, y: 4.5pt),
    [$(sin x)' = cos x$], [$(cos x)' = -sin x$], [$(tan x)' = 1/(cos^2 x) = 1 + tan^2 x$],
    [$(cot x)' = -1/(sin^2 x)$], [$(arcsin x)' = 1/sqrt(1 - x^2)$], [$(arccos x)' = -1/sqrt(1 - x^2)$],
    [$(arctan x)' = 1/(1 + x^2)$], [$(sinh x)' = cosh x$], [$(cosh x)' = sinh x$],
    [$(e^x)' = e^x$], [$(a^x)' = a^x ln a$], [$(ln |x|)' = 1/x$],
    [$(log_a x)' = 1/(x ln a)$], [$(sin^2 x)' = sin 2x$], [$(cos^2 x)' = -sin 2x$],
    [$(e^(g(x)))' = e^(g(x)) g'(x)$], [$(ln g(x))' = (g'(x))/(g(x))$], [$(sqrt(x))' = 1/(2 sqrt(x))$],
  )
]

#trick[Logarithmisch ableiten][Bei Funktionen der Form $f(x)^(g(x))$, wo $x$ in Basis _und_ Exponent steht, hilft weder Potenz- noch Exponentialregel. Man schreibt $f^g = e^(g ln f)$ und leitet mit der Kettenregel ab.]

#bsp[$(x^x)'$][
  $x^x = e^(x ln x)$. Kettenregel und Produktregel:
  $ (x^x)' = e^(x ln x) dot (ln x + x dot 1/x) = x^x (ln x + 1). $
  Häufiger Fehler: $(x^x)' = x dot x^(x-1)$ (Potenzregel, falsch, weil der Exponent nicht konstant ist) oder $x^x ln x$ (Exponentialregel, falsch, weil die Basis nicht konstant ist). Die richtige Antwort ist genau die Summe beider falschen.
]

=== Linearisieren und Tangente

#formel[Tangente / Linearisierung in $x_0$][
  $ t(x) = f(x_0) + f'(x_0)(x - x_0) $
  Die Tangente geht durch den Punkt $(x_0, f(x_0))$ und hat die Steigung $f'(x_0)$. In der Nähe von $x_0$ ist $f(x) approx t(x)$.
]

#bsp[Linearisierung von $f(x) = 1\/sqrt(1 + x)$ bei $x_0 = 0$][
  #grid(columns: (1fr, 5.6cm), column-gutter: 12pt, align: horizon,
  [
    $f(0) = 1$. Ableitung mit Kettenregel: $f(x) = (1 + x)^(-1\/2)$, also $f'(x) = -1/2 (1 + x)^(-3\/2)$ und $f'(0) = -1\/2$.
    $ t(x) = 1 - x/2. $
    *Anwendung:* $1\/sqrt(1.1) approx t(0.1) = 0.95$. Der exakte Wert ist $0.9535 dots$, der Fehler ist also kleiner als $0.4 %$.
  ],
  image("figs/a02_tangente.svg", width: 100%))
]

#merke[Die Linearisierung ist das Taylorpolynom 1. Grades (Kapitel 5). Wichtige Näherungen für kleine $x$: $sin x approx x$, $cos x approx 1$, $e^x approx 1 + x$, $ln(1 + x) approx x$, $(1 + x)^r approx 1 + r x$.]

=== Fehlerrechnung

#idee[Misst man eine Grösse $x$ mit einem kleinen Fehler $dif x$, wie gross ist dann der Fehler einer daraus berechneten Grösse $f(x)$? Antwort mit der Linearisierung: Der Fehler wird mit der Steigung $f'(x)$ multipliziert.]

#formel[Fehlerfortpflanzung][
  $ "absoluter Fehler:" quad dif f = f'(x) dif x, wide "relativer Fehler:" quad (dif f)/f = (f'(x))/(f(x)) dif x. $
]

#merke[Für Potenzen $f = c x^n$ ist $(dif f)\/f = n dot (dif x)\/x$: *Der relative Fehler wird mit dem Exponenten multipliziert.* Ein Fehler von 1 % im Radius gibt 2 % Fehler in der Kreisfläche und 3 % im Kugelvolumen.]

#bsp[Zylindervolumen][
  $V = pi r^2 h$ mit $h = 1$, Radius mit 1 % Fehler gemessen. $V'(r) = 2 pi r$, also
  $ (dif V)/V = (2 pi r dif r)/(pi r^2) = 2 (dif r)/r = 2 dot 1 % = 2 %. $
]

=== Mittelwertsatz

#satz[Mittelwertsatz][Ist $f$ stetig auf $[a, b]$ und differenzierbar auf $(a, b)$, dann gibt es mindestens ein $x_0 in (a, b)$ mit
$ f'(x_0) = (f(b) - f(a))/(b - a). $]

#fg("a02_mws", [Irgendwo zwischen $a$ und $b$ ist die Tangente (grün) parallel zur Sekante (rot).], w: 55%)

#intu[Fährst du in einer Stunde 100 km, dann zeigt der Tacho irgendwann während der Fahrt genau 100 km/h. Die Durchschnittsgeschwindigkeit wird mindestens einmal als Momentangeschwindigkeit erreicht.]

#bsp[Mittelwertsatz für $f(x) = x^2$ auf $[1, 4]$][
  #grid(columns: (1fr, 5.6cm), column-gutter: 12pt, align: horizon,
  [
    Sekantensteigung: $display((f(4) - f(1))/(4 - 1) = (16 - 1)/3 = 5)$.

    Gesucht $x_0$ mit $f'(x_0) = 2 x_0 = 5$, also $x_0 = 2.5 in (1, 4)$.

    Die Tangente in $x_0 = 2.5$ ist parallel zur Sekante durch $(1, 1)$ und $(4, 16)$.
  ],
  image("figs/a02_mws_bsp.svg", width: 100%))
]

#satz[Folgerungen][
  + *Satz von Rolle:* Ist zusätzlich $f(a) = f(b)$, gibt es ein $x_0$ mit $f'(x_0) = 0$.
  + Ist $f' = 0$ auf einem Intervall, so ist $f$ dort konstant.
  + Ist $f' > 0$ auf einem Intervall, so ist $f$ dort streng wachsend ($f' < 0$: streng fallend).
  + *Abschätzung:* $|f(b) - f(a)| <= max|f'| dot |b - a|$.
]

#bsp[Abschätzung mit dem Mittelwertsatz][
  Zeige $|sin a - sin b| <= |a - b|$. Nach dem Mittelwertsatz ist $sin a - sin b = cos(x_0)(a - b)$ für ein $x_0$ zwischen $a$ und $b$, und $|cos x_0| <= 1$.
]

=== Bernoulli–de l'Hôpital

#satz[Regel von Bernoulli–de l'Hôpital][Liefert $f(x)\/g(x)$ für $x -> a$ die Form $0\/0$ oder $plus.minus oo \/ plus.minus oo$, und sind $f, g$ in der Nähe von $a$ differenzierbar mit $g' != 0$, dann gilt
$ lim_(x -> a) f(x)/g(x) = lim_(x -> a) (f'(x))/(g'(x)), $
sofern der rechte Grenzwert existiert. Das gilt auch für $a = plus.minus oo$ und für einseitige Grenzwerte.]

#intu[Bei $0\/0$ sind Zähler und Nenner beide fast null. Wer gewinnt, hängt davon ab, wer schneller gegen null geht, und das messen die Ableitungen. In der Nähe von $a$ ist $f(x) approx f'(a)(x - a)$ und $g(x) approx g'(a)(x - a)$; der Faktor $(x - a)$ kürzt sich.]

#fehler[
  - *Nur bei $0\/0$ oder $oo\/oo$!* Beispiel: $lim_(x -> 0) (x + 1)\/(x + 2) = 1\/2$ durch Einsetzen. Mit (falschem) l'Hôpital käme $1\/1 = 1$.
  - Zähler und Nenner *getrennt* ableiten, nicht mit der Quotientenregel.
  - Vor jeder erneuten Anwendung prüfen, ob immer noch $0\/0$ oder $oo\/oo$ vorliegt.
]

#bsp[B.H. 1][
  $ lim_(x -> 0) (3x)/(sin x) quad (0/0) quad =^"B.H." lim_(x -> 0) 3/(cos x) = 3. $
]

#bsp[B.H. 2: zweimal anwenden][
  $ lim_(x -> 0) (e^x - 1 - x)/x^2 quad (0/0) quad =^"B.H." lim_(x -> 0) (e^x - 1)/(2x) quad (0/0) quad =^"B.H." lim_(x -> 0) e^x/2 = 1/2. $
]

#rezept[Andere unbestimmte Formen auf $0\/0$ oder $oo\/oo$ bringen][
  #table(columns: (auto, 1fr), stroke: none, inset: (x: 5pt, y: 3.5pt),
    [$0 dot oo$], [Als Bruch schreiben: $f dot g = f\/(1\/g)$. Den «einfacheren» Faktor in den Nenner.],
    [$oo - oo$], [Auf einen gemeinsamen Nenner bringen oder ausklammern.],
    [$1^oo, 0^0, oo^0$], [$f^g = e^(g ln f)$. Den Grenzwert des Exponenten $g ln f$ berechnen (das ist $0 dot oo$), am Schluss $e^("Ergebnis")$.],
  )
]

#bsp[$0 dot oo$: $lim_(x -> 0^+) x ln x$][
  $ lim_(x -> 0^+) x ln x = lim_(x -> 0^+) (ln x)/(1\/x) quad (-oo/oo) quad =^"B.H." lim_(x -> 0^+) (1\/x)/(-1\/x^2) = lim_(x -> 0^+) (-x) = 0. $
  Den Logarithmus lässt man im Zähler: Seine Ableitung $1\/x$ ist einfach.
]

#bsp[$oo - oo$: $lim_(x -> 0) (1/(sin x) - 1/x)$][
  Gemeinsamer Nenner: $display(1/(sin x) - 1/x = (x - sin x)/(x sin x))$, Form $0\/0$.
  $ =^"B.H." lim_(x -> 0) (1 - cos x)/(sin x + x cos x) quad (0/0) quad =^"B.H." lim_(x -> 0) (sin x)/(2 cos x - x sin x) = 0/2 = 0. $
]

#bsp[$0^0$: $lim_(x -> 0^+) x^x$][
  $x^x = e^(x ln x)$, und eben haben wir $x ln x -> 0$ gezeigt. Also $x^x -> e^0 = 1$.
]

== Kurvendiskussion

=== Extremalaufgaben

#idee[Gesucht ist der grösste oder kleinste Wert einer Funktion auf einem Intervall. Kandidaten gibt es nur an drei Sorten von Stellen. Man berechnet die Funktionswerte an allen Kandidaten und vergleicht.]

#rezept[Globale Extrema auf $[a, b]$][
  + *Randpunkte:* $f(a)$ und $f(b)$ berechnen.
  + *Kritische Punkte:* alle $x in (a, b)$ mit $f'(x) = 0$.
  + *Singuläre Punkte:* Stellen, an denen $f'$ nicht existiert (Knicke, z. B. bei Beträgen).
  + *Vergleichen:* Der grösste Wert ist das globale Maximum, der kleinste das globale Minimum.
  Ist das Intervall offen oder unbeschränkt, ersetzt man die Randwerte durch Grenzwerte. Dann kann es sein, dass kein Maximum existiert.
]

#bsp[Extremalaufgabe $f(x) = x^3 - x$ auf $[-1/2, 1]$][
  #grid(columns: (1fr, 5.8cm), column-gutter: 12pt, align: horizon,
  [
    *Randwerte:* $f(-1/2) = -1/8 + 1/2 = 3/8$, $quad f(1) = 0$.

    *Kritische Punkte:* $f'(x) = 3x^2 - 1 = 0 <=> x = plus.minus 1\/sqrt(3)$. Nur $x = 1\/sqrt(3) approx 0.577$ liegt im Intervall ($-0.577 < -0.5$ nicht).
    $ f(1/sqrt(3)) = 1/(3 sqrt(3)) - 1/sqrt(3) = -2/(3 sqrt(3)) = -(2 sqrt(3))/9 approx -0.385. $
    *Vergleich:* Max. $3\/8$ bei $x = -1\/2$ (am Rand!), Min. $-2 sqrt(3)\/9$ bei $x = 1\/sqrt(3)$.
  ],
  image("figs/a02_extrem.svg", width: 100%))
  Das Maximum liegt am Rand, wo $f' != 0$ ist. Wer nur $f' = 0$ löst, findet es nicht.
]

#bsp[Optimierung: Die sparsamste Dose][
  Eine zylindrische Dose soll $V = 1$ Liter fassen. Welche Masse hat sie, wenn möglichst wenig Blech gebraucht wird?

  *Zielfunktion:* Oberfläche $A = 2 pi r^2 + 2 pi r h$ (Deckel, Boden, Mantel).

  *Nebenbedingung:* $V = pi r^2 h = 1$, also $h = 1\/(pi r^2)$. Einsetzen eliminiert $h$:
  $ A(r) = 2 pi r^2 + 2/r, quad r > 0. $
  *Ableiten:* $A'(r) = 4 pi r - 2\/r^2 = 0 <=> r^3 = 1\/(2 pi) <=> r = (2 pi)^(-1\/3) approx 0.54 "dm"$.

  *Ist es ein Minimum?* $A''(r) = 4 pi + 4\/r^3 > 0$. Ausserdem $A -> oo$ für $r -> 0$ und $r -> oo$, also ist es das globale Minimum.

  *Ergebnis:* $h = 1\/(pi r^2) = 2 r$. Die optimale Dose ist so hoch wie breit.
]

#rezept[Textaufgabe zur Optimierung][
  + Skizze, Variablen benennen.
  + Zielfunktion aufschreiben (was soll minimal/maximal sein?).
  + Nebenbedingung(en) nutzen, um alle Variablen bis auf eine zu eliminieren.
  + Definitionsbereich der verbleibenden Variablen bestimmen.
  + Globale Extrema mit dem Rezept oben bestimmen. Ränder nicht vergessen!
]

=== Kurvendiskussion

#satz[Was die Ableitungen über den Graphen sagen][
  #table(columns: (auto, 1fr), stroke: none, inset: (x: 5pt, y: 3.5pt),
    [$f'(x) > 0$ / $< 0$], [$f$ steigt / fällt],
    [$f'(xi) = 0$], [waagrechte Tangente: Kandidat für ein Extremum],
    [$f'(xi) = 0, f''(xi) < 0$], [lokales *Maximum* in $xi$],
    [$f'(xi) = 0, f''(xi) > 0$], [lokales *Minimum* in $xi$],
    [$f''(x) > 0$], [*linksgekrümmt (konvex)*: Graph liegt über seinen Tangenten, «Schale»],
    [$f''(x) < 0$], [*rechtsgekrümmt (konkav)*: Graph liegt unter seinen Tangenten, «Kuppel»],
    [$f''(xi) = 0, f'''(xi) != 0$], [*Wendepunkt*: die Krümmung wechselt],
    [$f'(xi) = f''(xi) = 0, f'''(xi) != 0$], [*Sattelpunkt* (Terrassenpunkt): Wendepunkt mit waagrechter Tangente],
  )
]

#intu[Stell dir vor, du fährst mit dem Velo von links nach rechts über den Graphen. $f'' > 0$: Du lenkst nach links (Linkskurve, konvex). $f'' < 0$: Du lenkst nach rechts (konkav). Am Wendepunkt wechselst du die Lenkrichtung. Und $f'' > 0$ an einer Stelle mit $f' = 0$ heisst: Du bist unten in einer Schale, also beim Minimum.]

#merke[Ist $f'(xi) = f''(xi) = 0$, entscheidet $f''(xi) = 0$ nichts. Dann hilft der *Vorzeichenwechsel von $f'$*: Wechselt $f'$ in $xi$ von $+$ nach $-$, ist es ein Maximum, von $-$ nach $+$ ein Minimum, ohne Wechsel kein Extremum. Beispiel: $x^4$ hat bei $0$ ein Minimum, obwohl $f''(0) = 0$. Der Vorzeichentest funktioniert immer und ist oft schneller als die zweite Ableitung.]

#rezept[Vollständige Kurvendiskussion][
  + Definitionsbereich, Symmetrie (gerade/ungerade), Periodizität.
  + Nullstellen ($f = 0$) und $y$-Achsenabschnitt $f(0)$.
  + Verhalten am Rand von $D$ und für $x -> plus.minus oo$: Asymptoten, Polstellen.
  + $f'$: kritische Punkte, Monotoniebereiche, Extrema.
  + $f''$: Krümmungsbereiche, Wendepunkte.
  + Wertetabelle für einige Punkte, dann skizzieren.
]

#bsp[Kurvendiskussion 1: $f(x) = x^3$][
  #grid(columns: (1fr, 5.0cm), column-gutter: 12pt, align: horizon,
  [
    $f'(x) = 3x^2$, $f''(x) = 6x$, $f'''(x) = 6$.
    - $f''(x) < 0$ für $x < 0$: rechtsgekrümmt (konkav).
    - $f''(x) > 0$ für $x > 0$: linksgekrümmt (konvex).
    - $f''(0) = 0$ und $f'''(0) = 6 != 0$: Wendepunkt bei $0$. Da auch $f'(0) = 0$, ist es ein Sattelpunkt. Kein Extremum, denn $f' >= 0$ wechselt das Vorzeichen nicht.
  ],
  image("figs/a02_kd1.svg", width: 100%))
]

#bsp[Kurvendiskussion 2: $f(x) = x^4 - 2x^2$][
  #grid(columns: (1fr, 5.6cm), column-gutter: 12pt, align: horizon,
  [
    *Symmetrie:* gerade, $f(-x) = f(x)$.\
    *Nullstellen:* $x^2(x^2 - 2) = 0 <=> x = 0, plus.minus sqrt(2)$.\
    *Ableitungen:* $f'(x) = 4x^3 - 4x = 4x(x^2 - 1)$, $f''(x) = 12x^2 - 4$.\
    *Extrema:* $f' = 0 <=> x = 0, plus.minus 1$.
    - $f''(0) = -4 < 0$: Maximum $(0, 0)$.
    - $f''(plus.minus 1) = 8 > 0$: Minima $(plus.minus 1, -1)$.
    *Wendepunkte:* $f'' = 0 <=> x = plus.minus 1\/sqrt(3)$, $f(plus.minus 1\/sqrt(3)) = 1\/9 - 2\/3 = -5\/9$. Da $f''' = 24x != 0$ dort, sind es Wendepunkte $(plus.minus 1\/sqrt(3), -5\/9)$.
  ],
  image("figs/a02_kd2.svg", width: 100%))
]

== Grössenordnungen von Funktionen

#idee[Für grosse $x$ interessiert oft nur, _wie schnell_ etwas wächst, nicht der genaue Wert. Die Landau-Symbole $o$ und $O$ sind eine Kurzschrift dafür: $o$ heisst «verschwindend klein im Vergleich», $O$ heisst «höchstens so gross, bis auf einen Faktor».]

#defn[Klein-o][$f$ ist von *kleinerer Grössenordnung* als $g$ für $x -> oo$, wenn
$ lim_(x -> oo) f(x)/g(x) = 0. $
Man schreibt $f(x) = o(g(x))$ und sagt: $f$ wächst langsamer als $g$.]

#defn[Gross-O][$f(x) = O(g(x))$ für $x -> oo$, wenn $|f(x)\/g(x)|$ beschränkt bleibt, also wenn es ein $C > 0$ gibt mit $|f(x)| <= C |g(x)|$ für grosse $x$. In Worten: $f$ wächst *höchstens so schnell* wie $g$, bis auf einen konstanten Faktor. (Hinreichend: $lim |f\/g| = A$ mit $A < oo$.)]

#fg("a02_wachstum", [Die Rangliste des Wachstums: $ln x << x << x^2 << e^x$. Jede Funktion ist ab einer Stelle für immer kleiner als die nächste.], w: 60%)

#formel[Regeln für $x -> oo$][
  $ ln x = o(x^a) quad (a > 0), wide x^a = o(e^x), wide x^a = o(x^b) quad (a < b), wide e^(a x) = o(e^(b x)) quad (a < b) $
]

#bsp[Grössenordnungen ordnen][
  Ordne nach Wachstum für $x -> oo$:
  $ f_1 = x^3, quad f_2 = e^(5x + 1), quad f_3 = ln(x^3), quad f_4 = ln(e^(x^4) - 2), quad f_5 = ln(x^2). $
  *Vereinfachen hilft:* $f_3 = 3 ln x$, $f_5 = 2 ln x$, und $f_4 approx ln(e^(x^4)) = x^4$, weil die $-2$ neben $e^(x^4)$ keine Rolle spielt.
  - $f_3\/f_5 = (3 ln x)\/(2 ln x) = 3\/2$: gleiche Grössenordnung, $f_3 = O(f_5)$ und umgekehrt.
  - $(ln x)\/x^3 -> 0$: $f_3, f_5 = o(f_1)$.
  - $x^3\/x^4 -> 0$: $f_1 = o(f_4)$.
  - $x^4\/e^(5x+1) -> 0$: $f_4 = o(f_2)$.
  $ e^(5x + 1) >> ln(e^(x^4) - 2) >> x^3 >> ln(x^3) approx ln(x^2) $
  («$approx$» heisst hier: gleiche Grössenordnung.)
]

#bsp[$O$ und $o$ im Vergleich][
  - $3x^2 + 5x = O(x^2)$, denn $(3x^2 + 5x)\/x^2 -> 3 < oo$. Aber nicht $o(x^2)$, da der Grenzwert nicht $0$ ist.
  - $x = o(x^2)$, denn $x \/ x^2 -> 0$. Damit auch $x = O(x^2)$: Aus $o$ folgt immer $O$.
]

#merke[Die Symbole werden auch für $x -> 0$ verwendet, mit umgekehrter Rangliste: Dort ist $x^3 = o(x^2)$, weil kleine Potenzen schneller verschwinden. Das braucht man bei Taylor (Kapitel 5): $sin x = x - x^3\/6 + o(x^4)$.]

== Ebene Kurven

=== Darstellungsformen

#idee[Nicht jede Kurve ist der Graph einer Funktion. Ein Kreis zum Beispiel hat zu einem $x$ zwei $y$-Werte. Deshalb gibt es drei Arten, eine Kurve zu beschreiben.]

#defn[Drei Darstellungen einer Kurve][
  - *Explizit:* $y = f(x)$. Einfach, aber zu jedem $x$ nur ein $y$.
  - *Implizit:* $F(x, y) = 0$. Die Kurve ist die Menge aller Punkte, die die Gleichung erfüllen. Kreis: $x^2 + y^2 - 1 = 0$.
  - *Parameterdarstellung:* $vr(t) = (x(t), y(t))$, $t in [t_1, t_2]$. Ein Punkt «fährt» die Kurve ab; $t$ ist wie eine Zeit. Kann alles darstellen, auch Schleifen.
]

#bsp[Dieselbe Parabel dreimal][
  $ "explizit:" quad y = x^2 - 1, wide "implizit:" quad F(x, y) = y - x^2 + 1 = 0, wide "parametrisch:" quad vr(t) = vec(t, t^2 - 1). $
]

=== Umwandeln

#rezept[Umwandlungen][
  #table(columns: (auto, 1fr), stroke: none, inset: (x: 5pt, y: 3.5pt),
    [explizit $->$ implizit], [alles auf eine Seite: $F(x, y) = y - f(x) = 0$],
    [implizit $->$ explizit], [nach $y$ auflösen (geht nicht immer, oder nur stückweise)],
    [explizit $->$ Parameter], [$x(t) = t$, $y(t) = f(t)$],
    [Parameter $->$ explizit/implizit], [$t$ eliminieren: $x(t)$ nach $t$ auflösen und einsetzen, oder eine Identität wie $cos^2 + sin^2 = 1$ benutzen],
  )
]

#bsp[Umwandlungen][
  - $y = x^3 + 2 quad <=> quad F(x, y) = y - x^3 - 2 = 0 quad <=> quad vr(t) = (t, t^3 + 2)$.
  - $F(x, y) = 5x + 4y - 2 = 0 quad <=> quad y = (2 - 5x)\/4$.
  - $vr(t) = (t - 3, t^3 - t)$: Aus $x = t - 3$ folgt $t = x + 3$, also $y = (x + 3)^3 - (x + 3)$.
  - $vr(t) = (cos t, sin t)$: $x^2 + y^2 = cos^2 t + sin^2 t = 1$, also $x^2 + y^2 - 1 = 0$, der Einheitskreis. Hier kann man $t$ nicht direkt auflösen, aber die Identität eliminiert es.
]

=== Wichtige Kurven

#grid(columns: (1fr, 4.4cm), column-gutter: 12pt, align: horizon,
  formel[Kreis, Mittelpunkt $(x_0, y_0)$, Radius $R$][
    $ vr(t) = vec(x_0 + R cos t, y_0 + R sin t), quad t in [0, 2 pi) $
    $ (x - x_0)^2 + (y - y_0)^2 = R^2 $
  ],
  image("figs/a02_kreis.svg", width: 100%))

#grid(columns: (1fr, 4.6cm), column-gutter: 12pt, align: horizon,
  formel[Ellipse, Mittelpunkt $(x_0, y_0)$, Halbachsen $a, b$][
    $ vr(t) = vec(x_0 + a cos t, y_0 + b sin t) $
    $ (x - x_0)^2/a^2 + (y - y_0)^2/b^2 = 1 $
    Ein in $x$-Richtung um $a$ und in $y$-Richtung um $b$ gestreckter Einheitskreis.
  ],
  image("figs/a02_ellipse.svg", width: 100%))

#grid(columns: (1fr, 4.8cm), column-gutter: 12pt, align: horizon,
  formel[Hyperbel mit Parametern $a, b$][
    $ vr(t) = vec(plus.minus a cosh t, b sinh t) $
    $ x^2/a^2 - y^2/b^2 = 1 $
    Asymptoten $y = plus.minus (b\/a) x$. Das Pluszeichen gibt den rechten Ast, das Minus den linken.
  ],
  image("figs/a02_hyperbel.svg", width: 100%))

#formel[Zykloide][
  Bahn eines Punktes im Abstand $b$ vom Mittelpunkt eines Rades mit Radius $a$, das ohne zu rutschen auf der $x$-Achse abrollt:
  $ vr(t) = vec(a t - b sin t, a - b cos t). $
  Gewöhnlich: $b = a$ (Punkt auf dem Umfang, mit Spitzen). Verkürzt: $b < a$ (Punkt innen, wellig). Verlängert: $b > a$ (Punkt ausserhalb, mit Schleifen).
]

#fg("a02_zykloide", [Die drei Zykloiden. Der Mittelpunkt des Rades bewegt sich mit $a t$ nach rechts, der Punkt dreht sich um den Mittelpunkt: daher $a t - b sin t$.], w: 100%)

#formel[Kurven in Polarkoordinaten][
  Oft ist eine Kurve als Abstand $r$ in Abhängigkeit vom Winkel $phi$ gegeben, $r = r(phi)$. Das ist eine spezielle Parameterdarstellung mit Parameter $phi$:
  $ vr(phi) = vec(r(phi) cos phi, r(phi) sin phi). $
  Beispiele: Kreis $r = R$, archimedische Spirale $r = a phi$ (konstanter Windungsabstand), logarithmische Spirale $r = e^(c phi)$.
]

=== Tangente, Normale und Krümmung

#idee[Bei einer Parameterkurve $vr(t)$ ist $dot(vr)(t) = (dot(x), dot(y))$ der *Geschwindigkeitsvektor*: Er zeigt in Bewegungsrichtung, also tangential an die Kurve. Dreht man ihn um $90 degree$ nach links, erhält man die Normale. Die Krümmung misst, wie schnell sich die Richtung ändert.]

#fg("a02_tangnorm", [Tangentenvektor $dot(vr)$ (blau) und Normalenvektor $vec(h)$ (rot), um $90 degree$ nach links gedreht.], w: 55%)

#formel[Tangente und Normale im Punkt $vr(t_0)$][
  #table(columns: (1fr, 1fr), stroke: none, inset: (x: 4pt, y: 5pt),
    [Tangentenrichtung: $dot(vr)(t_0) = vec(dot(x)(t_0), dot(y)(t_0))$], [Normalenrichtung: $vec(h)(t_0) = vec(-dot(y)(t_0), dot(x)(t_0))$],
    [Tangente: $vec(t)(s) = vr(t_0) + s dot(vr)(t_0)$], [Normale: $vec(n)(s) = vr(t_0) + s vec(h)(t_0)$],
    [Steigung: $m = display((dot(y)(t_0))/(dot(x)(t_0)))$], [Einheitsnormale: $hat(vn) = display(1/sqrt(dot(x)^2 + dot(y)^2) vec(-dot(y), dot(x)))$],
  )
]

#warum[Steigung $m = dot(y)\/dot(x)$][
  Kettenregel: $(dif y)/(dif x) = (dif y \/ dif t)/(dif x \/ dif t)$. Für eine explizite Kurve ($x = t$) wird daraus einfach $f'(x)$. Ist $dot(x) = 0$ und $dot(y) != 0$, ist die Tangente senkrecht.
]

#defn[Krümmung][
  $ k(t) = (dot(x)(t) dot.op dot.double(y)(t) - dot.double(x)(t) dot.op dot(y)(t))/(dot(x)^2(t) + dot(y)^2(t))^(3\/2) $
  $k > 0$: *Linkskurve* (die Kurve biegt in Fahrtrichtung nach links). $k < 0$: *Rechtskurve*. $k = 0$: gerade oder Wendepunkt.
]

#text(size: 9pt, style: "italic")[Korrektur gegenüber der Vorlage: Dort sind «links-» und «rechtsgekrümmt» vertauscht. Probe: Der Einheitskreis $vr = (cos t, sin t)$ wird gegen den Uhrzeigersinn durchlaufen, also links herum, und die Formel ergibt $k = (sin^2 t + cos^2 t)\/1 = 1 > 0$.]

#merke[Für eine explizite Kurve $y = f(x)$ (also $x = t$, $dot(x) = 1$, $dot.double(x) = 0$) vereinfacht sich die Formel zu
$ k(x) = (f''(x))/(1 + f'(x)^2)^(3\/2). $
Das Vorzeichen von $k$ ist das von $f''$, passend zu «$f'' > 0$ heisst linksgekrümmt» aus der Kurvendiskussion.]

#defn[Krümmungskreis][Der Kreis, der die Kurve im Punkt $vr(t)$ am besten annähert: gleicher Punkt, gleiche Tangente, gleiche Krümmung.
$ "Radius:" quad rho = 1/(|k(t)|), wide "Mittelpunkt:" quad vec(M)(t) = vr(t) + 1/(k(t)) hat(vn)(t). $]

#fg("a02_kruemmung", [Krümmungskreise an einer Parabel. Am Scheitel ist die Krümmung gross und der Kreis klein; weiter aussen wird die Kurve flacher, und der Krümmungskreis wird grösser.], w: 60%)

#bsp[Krümmung des Kreises und der Parabel][
  *Kreis* $vr(t) = (R cos t, R sin t)$: $dot(x) = -R sin t$, $dot(y) = R cos t$, $dot.double(x) = -R cos t$, $dot.double(y) = -R sin t$.
  $ k = ((-R sin t)(-R sin t) - (-R cos t)(R cos t))/(R^2)^(3\/2) = R^2/R^3 = 1/R. $
  Ein Kreis hat überall dieselbe Krümmung $1\/R$, und sein Krümmungskreis ist er selbst.

  *Parabel* $y = x^2\/2$: $f' = x$, $f'' = 1$, also $k(x) = 1\/(1 + x^2)^(3\/2)$. Am Scheitel $k(0) = 1$ (Krümmungsradius $1$), bei $x = 1$ nur noch $k = 2^(-3\/2) approx 0.35$.
]

#defn[Evolute][Die Kurve, auf der die Mittelpunkte aller Krümmungskreise liegen:
$ vec(E)(t) = vr(t) + 1/(k(t)) hat(vn)(t) = vec(x - dot(y) (dot(x)^2 + dot(y)^2)/(dot(x) dot.double(y) - dot.double(x) dot(y)), y + dot(x) (dot(x)^2 + dot(y)^2)/(dot(x) dot.double(y) - dot.double(x) dot(y))). $]

#fg("a02_evolute", [Die Evolute einer Ellipse (rot) ist eine gestreckte Astroide. Für jeden Punkt der Ellipse liegt der Mittelpunkt des Krümmungskreises (grün) auf ihr. Wo die Ellipse am stärksten gekrümmt ist (an den Enden der langen Achse), ist der Kreis am kleinsten, und die Evolute hat dort ihre Spitzen nahe an der Kurve.], w: 58%)

#aufgaben()

#aufg[Ableiten][
  Leite ab: (a) $f(x) = x^2 e^(-3x)$, (b) $g(x) = ln(sqrt(1 + x^2))$, (c) $h(x) = arctan(1\/x)$, (d) $k(x) = (sin x)^x$ für $0 < x < pi$.
][
  (a) Produkt- und Kettenregel: $f'(x) = 2x e^(-3x) + x^2 dot (-3) e^(-3x) = x(2 - 3x) e^(-3x)$.

  (b) Erst vereinfachen: $g(x) = 1/2 ln(1 + x^2)$, also $g'(x) = 1/2 dot (2x)/(1 + x^2) = x/(1 + x^2)$.

  (c) $h'(x) = 1/(1 + 1\/x^2) dot (-1/x^2) = -1/(x^2 + 1)$. Interessant: Das ist $-(arctan x)'$. Tatsächlich ist $arctan(1\/x) = pi\/2 - arctan x$ für $x > 0$.

  (d) $k = e^(x ln sin x)$, also $k'(x) = (sin x)^x (ln sin x + x (cos x)/(sin x)) = (sin x)^x (ln sin x + x cot x)$.
]

#aufg[Tangente][
  Bestimme die Tangente an $f(x) = x ln x$ im Punkt $x_0 = e$.
][
  $f(e) = e$. $f'(x) = ln x + 1$, also $f'(e) = 2$.
  $ t(x) = e + 2(x - e) = 2x - e. $
]

#aufg[Grenzwerte mit l'Hôpital][
  Berechne (a) $display(lim_(x -> 0) (x - sin x)/x^3)$, (b) $display(lim_(x -> oo) x (e^(1\/x) - 1))$, (c) $display(lim_(x -> 0^+) (1 + x)^(1\/x))$.
][
  (a) Dreimal $0\/0$:
  $ lim (1 - cos x)/(3x^2) = lim (sin x)/(6x) = lim (cos x)/6 = 1/6. $
  (b) Form $oo dot 0$. Mit $u = 1\/x -> 0^+$: $display(lim_(u -> 0^+) (e^u - 1)/u =^"B.H." lim e^u/1 = 1)$.

  (c) Form $1^oo$. Exponent: $display((ln(1 + x))/x =^"B.H." 1/(1 + x) -> 1)$. Also Grenzwert $e^1 = e$.
]

#aufg[Extremwertaufgabe][
  Aus einem rechteckigen Blech $16 times 10$ cm werden an den Ecken Quadrate der Seitenlänge $x$ ausgeschnitten und die Ränder hochgebogen. Für welches $x$ wird das Volumen der offenen Schachtel maximal?
][
  $V(x) = x (16 - 2x)(10 - 2x) = 4x^3 - 52x^2 + 160x$, sinnvoll für $0 <= x <= 5$.

  $V'(x) = 12x^2 - 104x + 160 = 4(3x^2 - 26x + 40) = 0 <=> x = (26 plus.minus sqrt(676 - 480))/6 = (26 plus.minus 14)/6$, also $x = 2$ oder $x = 20\/3$. Nur $x = 2$ liegt im Intervall.

  Vergleich: $V(0) = V(5) = 0$, $V(2) = 2 dot 12 dot 6 = 144$. Maximum bei $x = 2$ cm mit $144 "cm"^3$.
]

#aufg[Kurvendiskussion][
  Untersuche $f(x) = x e^(-x)$ auf Extrema, Wendepunkte und Verhalten für $x -> plus.minus oo$.
][
  $f'(x) = (1 - x) e^(-x)$, $f''(x) = (x - 2) e^(-x)$.
  - *Extremum:* $f' = 0 <=> x = 1$, $f''(1) = -e^(-1) < 0$: Maximum $(1, 1\/e)$.
  - *Wendepunkt:* $f'' = 0 <=> x = 2$, Vorzeichenwechsel von $-$ nach $+$: Wendepunkt $(2, 2\/e^2)$.
  - *Ränder:* $x -> oo$: $x\/e^x -> 0$ ($e^x$ gewinnt), waagrechte Asymptote $y = 0$. $x -> -oo$: $x e^(-x) -> -oo$.
]

#aufg[Krümmung einer Parameterkurve][
  Berechne die Krümmung der Zykloide $vr(t) = (t - sin t, 1 - cos t)$ bei $t = pi$ (höchster Punkt).
][
  $dot(x) = 1 - cos t$, $dot(y) = sin t$, $dot.double(x) = sin t$, $dot.double(y) = cos t$. Bei $t = pi$: $dot(x) = 2$, $dot(y) = 0$, $dot.double(x) = 0$, $dot.double(y) = -1$.
  $ k(pi) = (2 dot (-1) - 0 dot 0)/(4 + 0)^(3\/2) = -2/8 = -1/4. $
  Negativ: Rechtskurve, wie erwartet oben auf dem Bogen (man fährt nach rechts und biegt nach unten ab). Krümmungsradius $4$, also doppelt so gross wie die Bogenhöhe.
]

#kurz[
  - $f'(x_0) = lim_(h -> 0) (f(x_0 + h) - f(x_0))\/h$: Steigung der Tangente, momentane Änderungsrate.
  - Produkt-, Quotienten-, Kettenregel; $(f^(-1))' = 1\/f'(f^(-1))$; bei $f^g$ immer $e^(g ln f)$.
  - Tangente $t(x) = f(x_0) + f'(x_0)(x - x_0)$. Relativer Fehler einer Potenz $x^n$: $n$-mal der relative Fehler von $x$.
  - Mittelwertsatz: Irgendwo ist die Tangente parallel zur Sekante.
  - l'Hôpital nur bei $0\/0$, $oo\/oo$; andere Formen erst umformen ($0 dot oo$ als Bruch, $1^oo$ mit $e^(g ln f)$).
  - Globale Extrema: Ränder, $f' = 0$, Stellen ohne Ableitung, vergleichen.
  - $f'' > 0$ konvex (Minimum), $f'' < 0$ konkav (Maximum), $f'' = 0$ mit Vorzeichenwechsel: Wendepunkt.
  - $ln x << x^a << e^x$. $f = o(g)$: $f\/g -> 0$. $f = O(g)$: $f\/g$ beschränkt.
  - Kurven: explizit, implizit, parametrisch. Tangente $dot(vr)$, Normale $(-dot(y), dot(x))$.
  - Krümmung $k = (dot(x) dot.double(y) - dot.double(x) dot(y))\/(dot(x)^2 + dot(y)^2)^(3\/2)$, $k > 0$ Linkskurve; Krümmungsradius $1\/|k|$.
]
