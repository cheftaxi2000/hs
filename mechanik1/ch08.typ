#import "lib.typ": *

= Ruhelage und Gleichgewicht

Jetzt wird es ernst: Unter welchen Bedingungen bleibt ein System in Ruhe? Dieses Kapitel liefert die zwei zentralen Werkzeuge der Statik: das *Prinzip der virtuellen Leistungen* (PdvL) als Grundaxiom und den *Hauptsatz der Statik* als seine wichtigste Folgerung. Fast jede Statikaufgabe im Rest des Skripts ist eine Anwendung eines dieser beiden Sätze.

Dazu brauchen wir zuerst einige Begriffe: Ruhelage, Bindungen und Bindungskräfte, virtuelle Bewegungszustände.

== Ruhe und Ruhelage

#defn[Ruhe, Ruhelage][
  Ein System ist *in Ruhe*, wenn $vv_M = bold(0)$ für alle seine Punkte gilt. Gilt das nur zu einem Zeitpunkt, heißt es *in momentaner Ruhe*. Eine *Ruhelage* ist eine Lage mit folgender Eigenschaft: Befindet sich das System einmal in dieser Lage in Ruhe, so _bleibt_ es dort in Ruhe.
]

#fg("k08_ruhelage", [Das Pendel in senkrechter Lage ist in einer Ruhelage: Lässt man es dort los, bleibt es hängen. Am Umkehrpunkt steht es nur einen Augenblick lang still und kehrt gleich wieder um. Das ist momentane Ruhe, aber keine Ruhelage.])

Statik fragt nach Ruhelagen, nicht nach Augenblicken des Stillstands. Ob eine Ruhelage _stabil_ ist (das Pendel kehrt nach einer kleinen Störung zurück) oder _labil_ (ein auf der Spitze stehender Stab kippt weg), ist eine weitere Frage, die wir hier nicht behandeln.

== Bindungen und Bindungskräfte

Ein System kann sich meist nicht frei bewegen. Es liegt auf, ist gelagert, und seine Teile sind durch Gelenke verbunden. Solche Einschränkungen der Bewegungsfreiheit heißen *Bindungen*. Jede Bindung erzwingt ihre Einschränkung durch Kräfte oder Momente, die *Bindungskräfte*.

#table(columns: (auto, 1fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [*Innere Bindung*], [schränkt die Bewegung von Teilen des Systems _relativ zueinander_ ein (ein Gelenk zwischen zwei Stäben, die Starrheit eines Körpers). Die zugehörigen Kräfte sind innere Bindungskräfte.],
  [*Äußere Bindung*], [schränkt die Bewegung von Randpunkten gegenüber der Umgebung ein (Lager, Unterlage). Die Kräfte heißen äußere Bindungskräfte oder *Lagerkräfte*.],
  [*Einseitige Bindung*], [kann durch eine wirkliche Bewegung gelöst werden (der Körper hebt von der Unterlage ab, das Seil wird schlaff). Die Bindungskraft hat ein vorgeschriebenes Vorzeichen (nur Druck bzw. nur Zug).],
  [*Vollständige Bindung*], [kann nicht gelöst werden (Gelenk, Führung in einer Nut).],
  table.hline(stroke: 0.7pt),
)

#fg("k08_bindungen", [Links eine einseitige Bindung: Die Unterlage kann nur drücken (nach oben), der Körper kann abheben. Rechts eine vollständige Bindung: Die Nut hält in beide Richtungen quer zur Nut, längs der Nut ist der Klotz frei beweglich.])

#merke[
  *Jede verhinderte Bewegungsmöglichkeit entspricht genau einer Komponente der Bindungskraft* (oder des Bindungsmoments) -- und umgekehrt. Verhindert ein Lager die Verschiebung in $y$-Richtung, kann es eine Kraft in $y$-Richtung aufbringen. Lässt es die Drehung frei, kann es kein Moment aufbringen. Mit dieser einen Regel lassen sich alle Lagertypen aus Kapitel 9 herleiten, statt sie auswendig zu lernen.
]

#defn[Reibungsfreie Bindung][
  In einer (unnachgiebigen) Bindung heißen Bindungskräfte parallel zu den in der Bindung erlaubten Geschwindigkeiten *Reibungskräfte*, entsprechend Bindungsmomente *Reibungsmomente*. Verschwinden sie alle, heißt die Bindung *reibungsfrei*. Eine reibungsfreie Unterlage kann also nur senkrecht zu sich selbst drücken. Reibung behandeln wir in Kapitel 12.
]

== Virtuelle Bewegungszustände

#defn[Virtueller Bewegungszustand][
  Ein *virtueller Bewegungszustand* ist eine Menge _gedachter_ Geschwindigkeiten $tilde(vv)$ der Punkte eines Systems in einer festen Lage. Er hat mit der wirklichen Bewegung nichts zu tun und darf beliebig gewählt werden. Er heißt *zulässig*, wenn er mit den inneren und äußeren Bindungen verträglich ist.
]

Die *virtuelle Leistung* einer Kraft ist, genau wie in Kapitel 5, $tilde(PP) = vF dot.c tilde(vv)$. Für einen starren Körper mit virtueller Kinemate ${tilde(vv)_B, tilde(vom)}$ ist $tilde(PP) = tilde(vv)_B dot.c vR + tilde(vom) dot.c vM_B$.

#intu[
  Du stehst vor einer ruhenden Konstruktion und fragst dich: «Was wäre, wenn sich das jetzt so bewegen würde?» Du _wackelst in Gedanken_ daran. Es bewegt sich nichts wirklich, und die Kräfte bleiben, wie sie sind. Du rechnest nur aus, welche Leistung die Kräfte bei diesem gedachten Wackeln hätten. Der Trick besteht darin, dass du dir das Wackeln aussuchen darfst, und zwar so, dass nur die Kräfte Leistung haben, die dich interessieren.
]

== Das Prinzip der virtuellen Leistungen

#satz[Grundprinzip der Statik (PdvL)][
  Ein beliebig abgegrenztes materielles System befindet sich genau dann in einer Ruhelage, wenn in dieser Lage die *virtuelle Gesamtleistung aller inneren und äußeren Kräfte* (einschließlich der Bindungskräfte) bei *jedem* virtuellen Bewegungszustand null ist:
  #gl($ tilde(PP) = 0 quad "für alle virtuellen Bewegungszustände." $)
]

Das ist ein Axiom, und zwar der statische Spezialfall eines allgemeinen Grundgesetzes der Mechanik (im Band zur Dynamik erscheint es in verallgemeinerter Form). Es wurde von Jakob Bernoulli bei der Bewegung eines Pendels stillschweigend angewendet und 1788 von Lagrange ausdrücklich formuliert. Seine Stärke liegt in der Freiheit der Wahl:

#merke[
  - Wählst du einen *zulässigen* Bewegungszustand und sind die Bindungen *reibungsfrei*, leisten die Bindungskräfte nichts. Sie fallen aus der Gleichung heraus, und du erhältst direkt eine Beziehung zwischen den Lasten.
  - Willst du eine bestimmte Bindungskraft wissen, wählst du einen Bewegungszustand, der *genau diese eine Bindung verletzt*. Dann erscheint nur diese Bindungskraft in der Gleichung.
]

#fg("k08_virtuell", [Klotz auf reibungsfreier schiefer Ebene, durch eine horizontale Kraft $vF$ gehalten. Links die wirklichen Kräfte. Mitte: zulässige virtuelle Verschiebung längs der Ebene ($vN$ leistet nichts). Rechts: virtuelle Verschiebung senkrecht zur Ebene, die die Bindung verletzt ($vN$ leistet mit).])

#bsp[Klotz auf schiefer Ebene][
  Die Ebene habe den Neigungswinkel $alpha$. Gesucht sind die Haltekraft $F$ (horizontal) und die Normalkraft $N$.

  _Zulässige Translation längs der Ebene_ mit virtueller Schnelligkeit $tilde(v)$ aufwärts: $vN$ steht senkrecht auf $tilde(vv)$ und leistet nichts. Das Gewicht hat den Anteil $G sin alpha$ gegen die Bewegung (also $-G sin alpha$), die horizontale Kraft $F$ hat den Anteil $F cos alpha$ in Bewegungsrichtung:
  $ tilde(PP) = tilde(v) (F cos alpha - G sin alpha) = 0 quad => quad F = G tan alpha. $

  _Translation senkrecht von der Ebene weg_ (verletzt die Auflagebindung, daher nicht zulässig, aber als _virtueller_ Zustand erlaubt!) mit Schnelligkeit $tilde(v)'$: Jetzt leistet $vN$ mit. Gewicht und $F$ haben die Anteile $-G cos alpha$ und $-F sin alpha$:
  $ tilde(PP) = tilde(v)' (N - G cos alpha - F sin alpha) = 0 quad => quad N = G cos alpha + G tan alpha sin alpha = G / (cos alpha). $
  Beachte, wie gezielt jede gewählte Bewegung genau eine Unbekannte liefert. Eine dritte Bewegung, die virtuelle Drehung um den Schwerpunkt, würde die Lage der Wirkungslinie von $vN$ liefern.
]

== Der Hauptsatz der Statik

Wählt man als virtuellen Bewegungszustand eine *Starrkörperbewegung des ganzen Systems* (als wäre es eingefroren), so leisten die inneren Kräfte insgesamt nichts: Sie treten paarweise als $vF, -vF$ auf, und bei einer Starrkörperbewegung heben sich ihre Leistungen auf. Übrig bleibt die Leistung der äußeren Kräfte, $tilde(PP) = tilde(vv)_O dot.c vR^((a)) + tilde(vom) dot.c vM_O^((a))$. Soll sie für _jede_ Kinemate $\{tilde(vv)_O, tilde(vom)\}$ verschwinden, so folgt:

#satz[Hauptsatz der Statik][
  Alle *äußeren* Kräfte (einschließlich der äußeren Bindungskräfte), die auf ein materielles System in einer Ruhelage wirken, müssen notwendigerweise im Gleichgewicht sein:
  #gl($ vR^((a)) = bold(0), wide vM_O^((a)) = bold(0). $)
]

Das sind die *Gleichgewichtsbedingungen*: im Raum 6 skalare Gleichungen, in der Ebene 3.

#merke[
  Der Hauptsatz ist *notwendig, aber im Allgemeinen nicht hinreichend*. Er gilt für jedes System, auch für verformbare und für Mechanismen. Aber aus dem Gleichgewicht der äußeren Kräfte am Gesamtsystem folgt noch nicht, dass auch jedes Teil in Ruhe bleibt. Für *einen einzelnen starren Körper* dagegen ist er auch hinreichend.
]

#fg("k08_schere", [Gleichgewicht der äußeren Kräfte, aber keine Ruhelage: Zwei gelenkig verbundene Stäbe auf reibungsfreier Ebene (Draufsicht), belastet mit $vF$ und $-vF$ auf derselben Wirkungslinie. Die äußeren Kräfte bilden eine Nullgruppe, trotzdem klappt die Anordnung zusammen. Erst das Gleichgewicht an jedem einzelnen Stab würde das aufdecken.])

#rezept[Welches Werkzeug wofür?][
  - *Hauptsatz* (Gleichgewichtsbedingungen): der Normalfall. Systematisch, liefert alle Lagerkräfte. Bei mehreren Körpern muss man zerlegen und bekommt viele Gleichungen mit vielen Unbekannten.
  - *PdvL*: elegant, wenn man an einem beweglichen System (Mechanismus) _eine_ Beziehung zwischen Lasten oder _eine_ bestimmte Kraft sucht, ohne alle anderen auszurechnen. Braucht dafür etwas Kinematik aus Kapitel 3.
]

#kurz[
  - Ruhelage: einmal dort in Ruhe, immer dort in Ruhe (nicht dasselbe wie momentane Ruhe).
  - Jede verhinderte Bewegungsmöglichkeit gehört zu genau einer Bindungskomponente.
  - PdvL: Ruhelage $<=>$ $tilde(PP) = 0$ für alle virtuellen Bewegungszustände.
  - Zulässig plus reibungsfrei: Bindungskräfte leisten nichts. Bindung lösen: genau diese Kraft kommt ins Spiel.
  - Hauptsatz: $vR^((a)) = bold(0)$, $vM_O^((a)) = bold(0)$ für die äußeren Kräfte. Notwendig; für den einzelnen starren Körper auch hinreichend.
]
