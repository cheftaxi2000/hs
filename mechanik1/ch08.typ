#import "lib.typ": *

= Ruhelage und Gleichgewicht

Jetzt wird es ernst: Unter welchen Bedingungen bleibt ein System in Ruhe? Dieses Kapitel liefert die beiden zentralen Werkzeuge der Statik -- das *Prinzip der virtuellen Leistungen* (PdvL) als Grundaxiom und den *Hauptsatz der Statik* als seine wichtigste Folgerung. Fast jede Statikaufgabe ist eine Anwendung eines dieser beiden Sätze.

== Ruhe und Ruhelage

#defn[Ruhe, Ruhelage][
  Ein System ist *in Ruhe*, wenn $vv_M = bold(0)$ für alle seine Punkte gilt (in einem Zeitintervall); gilt das nur zu einem Zeitpunkt, ist es in *momentaner Ruhe*. Eine *Ruhelage* ist eine Lage mit folgender Eigenschaft: Befindet sich das System einmal in dieser Lage in Ruhe, so bleibt es dort in Ruhe.
]

#intu[
  Ein Pendel am Umkehrpunkt steht für einen Augenblick still: momentane Ruhe. Aber es bleibt nicht dort, also ist das keine Ruhelage. Senkrecht nach unten hängend bleibt es, wenn man es dort loslässt: Das ist eine Ruhelage. Statik fragt nach Ruhelagen, nicht nach Momenten des Stillstands.
]

== Bindungen und Bindungskräfte

Ein System kann sich meist nicht frei bewegen: Es liegt auf, ist gelagert, seine Teile sind durch Gelenke verbunden. Solche Einschränkungen der Bewegungsfreiheit heißen *Bindungen*. Jede Bindung erzwingt ihre Einschränkung durch Kräfte, die *Bindungskräfte* (und Bindungsmomente).

#table(columns: (auto, 1fr), stroke: none, inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 0.6pt),
  [*Innere Bindung*], [schränkt die Bewegung von Teilen des Systems _relativ zueinander_ ein (Gelenk zwischen zwei Stäben, Starrheit). Zugehörige Kräfte: innere Bindungskräfte.],
  [*Äußere Bindung*], [schränkt die Bewegung von Randpunkten gegenüber der Umgebung ein (Lager, Unterlage). Zugehörige Kräfte: äußere Bindungskräfte, auch *Lagerkräfte*.],
  [*Einseitige Bindung*], [kann durch eine wirkliche Bewegung gelöst werden (Körper auf Unterlage kann abheben, Seil kann schlaff werden). Die Bindungskraft hat dann ein vorgeschriebenes Vorzeichen (nur Druck bzw. nur Zug).],
  [*Vollständige Bindung*], [kann nicht gelöst werden (Gelenk, Führung in einer Nut).],
  table.hline(stroke: 0.6pt),
)

#merke[
  *Jede verhinderte Bewegungsmöglichkeit entspricht genau einer Komponente der Bindungskraft* (oder des Bindungsmoments) -- und umgekehrt. Verhindert ein Lager die Verschiebung in $y$-Richtung, so kann es eine Kraft in $y$-Richtung aufbringen. Lässt es die Drehung frei, kann es kein Moment aufbringen. Mit dieser einen Regel lassen sich alle Lagertypen in Kapitel 9 herleiten, statt sie auswendig zu lernen.
]

#defn[Reibungsfreie Bindung][
  In einer (unnachgiebigen) Bindung heißen Bindungskräfte parallel zu den in der Bindung erlaubten Geschwindigkeiten *Reibungskräfte*. Verschwinden sie, heißt die Bindung *reibungsfrei*. Eine reibungsfreie Unterlage kann also nur senkrecht zu sich selbst drücken.
]

== Virtuelle Bewegungszustände

#defn[Virtueller Bewegungszustand][
  Ein *virtueller Bewegungszustand* ist eine Menge _gedachter_ Geschwindigkeiten $tilde(vv)$ der Punkte eines Systems in einer festen Lage. Er hat mit der wirklichen Bewegung nichts zu tun und darf beliebig gewählt werden. Er heißt *zulässig*, wenn er mit den inneren und äußeren Bindungen verträglich ist.
]

Die *virtuelle Leistung* einer Kraft ist $tilde(PP) = vF dot.c tilde(vv)$, berechnet genau wie in Kapitel 5. Für einen starren Körper mit virtueller Kinemate ${tilde(vv)_B, tilde(vom)}$ also $tilde(PP) = tilde(vv)_B dot.c vR + tilde(vom) dot.c vM_B$.

#intu[
  Du stehst vor einer ruhenden Konstruktion und fragst dich: «Was wäre, wenn sich das jetzt so bewegen würde?» Du _wackelst in Gedanken_ daran. Es bewegt sich nichts wirklich, die Kräfte bleiben, wie sie sind. Du rechnest nur aus, welche Leistung die Kräfte bei diesem gedachten Wackeln hätten. Der Trick: Du darfst dir das Wackeln aussuchen -- und suchst es so aus, dass nur die Kräfte Leistung haben, die dich interessieren.
]

== Das Prinzip der virtuellen Leistungen

#satz[Grundprinzip der Statik (PdvL)][
  Ein beliebig abgegrenztes materielles System befindet sich genau dann in einer Ruhelage, wenn in dieser Lage die *virtuelle Gesamtleistung aller inneren und äußeren Kräfte* (einschließlich der Bindungskräfte) bei *jedem* virtuellen Bewegungszustand null ist:
  #gl($ tilde(PP) = 0 wide "für alle virtuellen Bewegungszustände." $)
]

Das ist ein Axiom (der statische Spezialfall eines allgemeinen Grundgesetzes der Mechanik). Seine Stärke liegt in der Freiheit der Wahl:

#merke[
  - Wählst du einen *zulässigen* Bewegungszustand und sind die Bindungen *reibungsfrei*, so leisten die Bindungskräfte nichts. Sie fallen aus der Gleichung heraus, und du erhältst direkt eine Beziehung zwischen den Lasten.
  - Willst du eine bestimmte Bindungskraft wissen, wählst du einen Bewegungszustand, der *genau diese eine Bindung verletzt*. Dann erscheint nur diese Bindungskraft in der Gleichung.
]

#fig(13.2, 4.6, caption: [Klotz auf reibungsfreier schiefer Ebene, gehalten durch eine horizontale Kraft $vF$. Drei virtuelle Bewegungen liefern je eine Unbekannte.],
  // schiefe Ebene
  poly(((0.5,0.5),(6.2,0.5),(6.2,3.35)), fill: luma(245)),
  arc((0.5,0.5), 1.1, 0, 26.6, w: 0.5pt), lbl((1.9,0.8), $alpha$, size: 8pt),
  // Klotz: Mittelpunkt auf der Ebene bei (3.3,1.9), gedreht um 26.6°
  poly(((2.63,1.565),(3.97,2.235),(3.61,2.95),(2.27,2.28))),
  pt((3.12,2.26)),
  arr((3.12,2.26),(3.12,0.96), c: cf, w: 1.3pt), lbl((3.4,1.1), $vG$, c: cf),
  arr((1.72,2.26),(3.02,2.26), c: cf, w: 1.3pt), lbl((1.5,2.5), $vF$, c: cf),
  arr((3.3,1.9),(2.76,2.97), c: cf, w: 1.3pt), lbl((2.5,3.2), $vN$, c: cf),
  arr((4.3,2.6),(3.4,2.15), c: cv, w: 1.0pt, dash: "dashed"), lbl((4.55,2.85), $tilde(vv)$, c: cv),
  // Tabelle rechts
  lbl((10.0,4.1), [virtuelle Bewegung #h(1.5em) Ergebnis], size: 8.5pt),
  li((7.4,3.85),(12.8,3.85), s: 0.3pt + black),
  lbl((10.0,3.35), [Translation längs der Ebene: $F = G tan alpha$], size: 8.5pt),
  lbl((10.0,2.6), [Translation senkrecht dazu: $N = G \/ cos alpha$], size: 8.5pt),
  lbl((10.0,1.85), [Rotation um den Schwerpunkt:], size: 8.5pt), lbl((10.0,1.4), [Lage der Wirkungslinie von $vN$], size: 8.5pt),
)

#bsp[Klotz auf schiefer Ebene][
  _Zulässige Translation_ mit Schnelligkeit $tilde(v)$ die Ebene hinunter: $vN$ steht senkrecht auf $tilde(vv)$ und leistet nichts. Das Gewicht hat den Anteil $G sin alpha$ in Bewegungsrichtung, die horizontale Kraft $F$ den Anteil $F cos alpha$ dagegen:
  $ tilde(PP) = tilde(v) (G sin alpha - F cos alpha) = 0 quad => quad F = G tan alpha. $
  _Unzulässige Translation_ senkrecht von der Ebene weg (verletzt die Auflagebindung): Jetzt leistet $vN$ mit.
  $ tilde(PP) = tilde(v)' (N - G cos alpha - F sin alpha) = 0 quad => quad N = G cos alpha + G tan alpha sin alpha = G / (cos alpha). $
  Bemerke, wie gezielt jede Bewegung genau eine Unbekannte liefert.
]

== Der Hauptsatz der Statik

Wählt man als virtuellen Bewegungszustand eine *Starrkörperbewegung des ganzen Systems* (als wäre es eingefroren), so leisten die inneren Kräfte insgesamt nichts: Sie treten paarweise als $vF, -vF$ auf, und bei einer Starrkörperbewegung heben sich ihre Leistungen auf. Übrig bleibt die Leistung der äußeren Kräfte, $tilde(PP) = tilde(vv)_O dot.c vR^((a)) + tilde(vom) dot.c vM_O^((a))$. Soll sie für _jede_ Kinemate verschwinden, folgt:

#satz[Hauptsatz der Statik][
  Alle *äußeren* Kräfte (einschließlich der äußeren Bindungskräfte), die auf ein materielles System in einer Ruhelage wirken, müssen notwendigerweise im Gleichgewicht sein:
  #gl($ vR^((a)) = bold(0), wide vM_O^((a)) = bold(0). $)
]

Das sind die *Gleichgewichtsbedingungen*: im Raum 6 skalare Gleichungen, in der Ebene 3.

#merke[
  Der Hauptsatz ist *notwendig, aber im Allgemeinen nicht hinreichend*. Er gilt für jedes System, auch für verformbare und für Mechanismen. Aber aus dem Gleichgewicht der äußeren Kräfte am Gesamtsystem folgt noch nicht, dass auch jedes Teil in Ruhe bleibt. Für *einen einzelnen starren Körper* dagegen ist er auch hinreichend.
]

#fig(11, 2.6, caption: [Gleichgewicht der äußeren Kräfte, aber keine Ruhelage: Zwei gelenkig verbundene Stäbe auf reibungsfreier Ebene (Draufsicht). Die beiden Kräfte bilden eine Nullgruppe -- trotzdem klappt die Schere zusammen. Erst das Gleichgewicht an jedem einzelnen Stab deckt das auf.],
  beam((1.0,0.5),(5.5,1.6)), beam((5.5,1.6),(10.0,0.5)), gelenk((5.5,1.6)),
  arr((1.0,0.5),(2.6,0.5), c: cf, w: 1.3pt), arr((10.0,0.5),(8.4,0.5), c: cf, w: 1.3pt),
  lbl((1.8,0.15), $vF$, c: cf), lbl((9.2,0.15), $-vF$, c: cf), lbl((5.5,1.95), [Gelenk], size: 8pt),
  arr((5.5,1.45),(5.5,0.75), c: cv, w: 0.9pt, dash: "dashed"),
)

#rezept[Welches Werkzeug wofür?][
  - *Hauptsatz* (Gleichgewichtsbedingungen): der Normalfall. Systematisch, liefert alle Lagerkräfte. Bei mehreren Körpern muss man zerlegen und bekommt viele Gleichungen mit vielen Unbekannten.
  - *PdvL*: elegant, wenn man an einem beweglichen System (Mechanismus) *eine* Beziehung zwischen Lasten sucht oder *eine* bestimmte Kraft, ohne alle anderen ausrechnen zu wollen. Braucht dafür etwas Kinematik (Kapitel 3).
]

#kurz[
  - Ruhelage: einmal dort in Ruhe, immer dort in Ruhe.
  - Jede Bindungskomponente gehört zu genau einer verhinderten Bewegungsmöglichkeit.
  - PdvL: Ruhelage $<=>$ $tilde(PP) = 0$ für alle virtuellen Bewegungszustände.
  - Zulässig + reibungsfrei: Bindungskräfte leisten nichts.
  - Hauptsatz: $vR^((a)) = bold(0)$, $vM_O^((a)) = bold(0)$ für die äußeren Kräfte. Notwendig; für den einzelnen starren Körper auch hinreichend.
]
