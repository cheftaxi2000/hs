#import "lib.typ": *

= Ruhelage und Gleichgewicht

Jetzt wird es ernst: Unter welchen Bedingungen bleibt ein System in Ruhe? Dieses Kapitel liefert die zwei zentralen Werkzeuge der Statik: das *Prinzip der virtuellen Leistungen* (PdvL) als Grundaxiom und den *Hauptsatz der Statik* als seine wichtigste Folgerung. Fast jede Statikaufgabe im Rest des Skripts ist eine Anwendung eines dieser beiden Sätze.

Dazu brauchen wir zuerst einige Begriffe: Ruhelage, Bindungen und Bindungskräfte, virtuelle Bewegungszustände.

== Ruhe und Ruhelage

#defn[Ruhe, Ruhelage][
  Ein System ist *in Ruhe*, wenn $vv_M = bold(0)$ für alle seine Punkte gilt. Gilt das nur zu einem Zeitpunkt, heißt es *in momentaner Ruhe*. Eine *Ruhelage* ist eine Lage mit folgender Eigenschaft: Befindet sich das System einmal in dieser Lage in Ruhe, so _bleibt_ es dort in Ruhe.
]

#fg("k08_ruhelage", [Das Pendel in senkrechter Lage ist in einer Ruhelage: Lässt man es dort los, bleibt es hängen. Am Umkehrpunkt steht es nur einen Augenblick lang still und kehrt gleich wieder um. Das ist momentane Ruhe, aber keine Ruhelage.])

Statik fragt nach Ruhelagen, nicht nach Augenblicken des Stillstands. Das Pendel ist beim größten Ausschlag $phi_0$ nur momentan in Ruhe; seine Ruhelage ist die senkrechte Lage. Statt «Ruhelage» sagt man oft auch *Gleichgewichtslage*. Der Zusatz in der Definition ist wichtig: Die Lage bleibt nur dann eine Ruhelage, wenn sich die angreifenden Kräfte und die Lagerung nicht ändern. Ob eine Ruhelage _stabil_ ist (das Pendel kehrt nach einer kleinen Störung zurück) oder _labil_ (ein auf der Spitze stehender Stab kippt weg), ist eine weitere Frage, die wir hier nicht behandeln.

#woche(9, [Bindungen], [118–141])
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

Jeder Komponente der Bindungskräfte und -momente («Bindungskomponente») entspricht eine (linear unabhängige) Gleichung zwischen den Bewegungszuständen der verbundenen Körper. Zwei Beispiele, die man sich merken sollte:

- *Innere Bindung.* Zwei Stäbe $A B$ und $B C$ sind in $B$ durch ein reibungsfreies Gelenk verbunden. Der Stab $A B$ übt auf $B C$ die Gelenkkraft ${B | vF}$ aus, umgekehrt übt $B C$ auf $A B$ die Reaktion ${B | -vF}$ aus. Beide Angriffspunkte liegen im betrachteten System der zwei Stäbe: ${B | vF}$ und ${B | -vF}$ sind innere Bindungskräfte.
- *Äußere Bindung.* Ein Gegenstand auf einer Unterlage: An den Berührungspunkten übt die Unterlage die *Auflagerkräfte* auf ihn aus. Quer-, Längs- und Kugellager einer rotierenden Welle sind äußere Bindungen des Systems Welle; ihre Kräfte heißen *Lagerkräfte*.

#fg("k08_bindungen", [Links eine einseitige Bindung: Die Unterlage kann nur drücken (nach oben), der Körper kann abheben. Rechts eine vollständige Bindung: Die Nut hält in beide Richtungen quer zur Nut, längs der Nut ist der Klotz frei beweglich.])

#merke[
  *Jede verhinderte Bewegungsmöglichkeit entspricht genau einer Komponente der Bindungskraft* (oder des Bindungsmoments) -- und umgekehrt. Verhindert ein Lager die Verschiebung in $y$-Richtung, kann es eine Kraft in $y$-Richtung aufbringen. Lässt es die Drehung frei, kann es kein Moment aufbringen. Mit dieser einen Regel lassen sich alle Lagertypen aus Kapitel 9 herleiten, statt sie auswendig zu lernen.
]

#defn[Reibungsfreie Bindung][
  In einer (unnachgiebigen) Bindung heißen Bindungskräfte parallel zu den in der Bindung erlaubten Geschwindigkeiten *Reibungskräfte*, entsprechend Bindungsmomente *Reibungsmomente*. Verschwinden sie alle, heißt die Bindung *reibungsfrei*. Eine reibungsfreie Unterlage kann also nur senkrecht zu sich selbst drücken. Reibung behandeln wir in Kapitel 12.
]

Zur Definition der Reibung: In einer Bindung (zwischen starren Körpern, unnachgiebig, ohne Antrieb) sind Bindungskräfte, die parallel zu einer zulässigen virtuellen Geschwindigkeit der Bindung stehen, Reibungskräfte. Bei einem Körper auf einer Unterlage ist die Berührung genau dann reibungsfrei, wenn die Wirkungslinie der Bindungskraft in Richtung der Flächennormalen liegt. Bei einem Gelenk in einem ebenen System, das eine Kraft mit zwei Komponenten und eventuell ein Moment $M_R$ auf den Stab ausübt, ist die virtuelle Rotation um das Gelenk zulässig; ein Moment $M_R$ wäre also ein Reibungsmoment. Virtuelle Translationen in Richtung der Kraftkomponenten sind unzulässig, diese Komponenten sind keine Reibungskräfte.

== Virtuelle Bewegungszustände

#defn[Virtueller Bewegungszustand][
  Ein *virtueller Bewegungszustand* ist eine Menge _gedachter_ Geschwindigkeiten $tilde(vv)$ der Punkte eines Systems in einer festen Lage. Er hat mit der wirklichen Bewegung nichts zu tun und darf beliebig gewählt werden. Er heißt *zulässig*, wenn er mit den inneren und äußeren Bindungen verträglich ist.
]

Die *virtuelle Leistung* einer Kraft ist, genau wie in Kapitel 5, $tilde(PP) = vF dot.c tilde(vv)$. Für einen starren Körper mit virtueller Kinemate ${tilde(vv)_B, tilde(vom)}$ ist $tilde(PP) = tilde(vv)_B dot.c vR + tilde(vom) dot.c vM_B$.

*Was zulässig heißt, hängt von den Bindungen ab.* Liegt ein Rad auf einer starren Unterlage, ist die virtuelle Geschwindigkeit des Berührungspunkts nur zulässig, wenn sie in der Tangentialebene liegt; jede andere würde die Unterlage durchdringen oder zum Abheben führen (die Bindung lösen). Bei einem starren Körper müssen die virtuellen Geschwindigkeiten außerdem dem Satz der projizierten Geschwindigkeiten genügen. Bei Mechanismen aus mehreren Körpern bestimmt man einen zulässigen virtuellen Bewegungszustand mit der Kinematik von Kapitel 3: Geben wir zum Beispiel an einem ebenen System aus zwei gelenkig verbundenen starren Stäben $A B$ und $B C$ die virtuelle Geschwindigkeit des Punkts $C$ vor (horizontal, Betrag $v$), so ist der ganze virtuelle Bewegungszustand eindeutig bestimmt: Stab $A B$ dreht um das Lager $A$, und Stab $B C$ dreht momentan um sein Momentanzentrum.

*Einseitige Bindungen.* Die Bindungskraft einer einseitigen Bindung zeigt immer gegen die «freie» Raumhälfte: Die Unterlage kann nur drücken. Ein zulässiger virtueller Bewegungszustand darf eine einseitige Bindung _nicht lösen_. Ein starrer Zylinder ist für den Kolben darin eine _vollständige_ Bindung, denn die einzig mögliche Bewegung des Kolbens (axial) löst sie nicht.

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

Bernoulli hat das PdvL stillschweigend bei der Bewegung eines physikalischen Pendels benutzt, Lagrange hat es 1788 ausdrücklich und in aller Schärfe formuliert. Wie jedes Postulat wird es ohne Beweis angenommen und durch seine experimentell überprüfbaren Folgerungen bestätigt.

#merke[
  Das PdvL sagt, welche Kräfte in einer Ruhelage herrschen müssen. Es kann aber nicht sicherstellen, dass diese Kräfte im gegebenen System überhaupt möglich sind. Das muss man zusätzlich prüfen: über die Festigkeit (Mechanik 2), über die richtige Richtung der Normalkraft in einer einseitigen Bindung (Kapitel 9), über die Standfestigkeit (Kapitel 9) oder über das Haftreibungsgesetz (Kapitel 12). Deshalb steht im Postulat der Zusatz «und wenn die Eigenschaften des Systems und seiner Lagerung diese Kräfte zulassen».
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

#warum[Beweis des Hauptsatzes][
  Wir erteilen dem System in seiner Ruhelage eine beliebige momentane Starrkörperbewegung als virtuellen Bewegungszustand. Er darf die äußeren Bindungen durchaus verletzen. Nach dem PdvL muss die Gesamtleistung aller inneren und äußeren Kräfte null sein. Nach dem Reaktionsprinzip enthalten die inneren Kräfte mit jeder Kraft auch ihre Reaktion, sie bilden also eine Nullgruppe: $vR^((i)) = bold(0)$ und $vM_O^((i)) = bold(0)$. Nach der Leistungsformel für starre Körper liefern sie bei einer Starrkörperbewegung keinen Beitrag. Übrig bleibt $tilde(PP) = tilde(vv)_O dot.c vR^((a)) + tilde(vom) dot.c vM_O^((a)) = 0$ für alle Kinematen $\{tilde(vv)_O, tilde(vom)\}$. Das geht nur, wenn $vR^((a)) = bold(0)$ und $vM_O^((a)) = bold(0)$.
]

#bsp[Klotz auf der schiefen Ebene mit dem Hauptsatz][
  Dieselbe Aufgabe wie oben, jetzt mit den Gleichgewichtsbedingungen. Wir zerlegen parallel ($ve_x$) und senkrecht ($ve_y$) zur Ebene, dann tritt die Unbekannte $N$ nur in einer Komponentenbedingung auf: $vF = -F cos alpha thin ve_x - F sin alpha thin ve_y$, $vG = G sin alpha thin ve_x - G cos alpha thin ve_y$, $vN = N ve_y$. Aus $vR = bold(0)$ folgt
  $ -F cos alpha + G sin alpha = 0, quad -F sin alpha - G cos alpha + N = 0, $
  also wieder $F = G tan alpha$ und $N = G\/cos alpha$. Die Momentenbedingung bezüglich des Schwerpunkts liefert dann die Lage der Wirkungslinie von $vN$. Die Gleichungen sind dieselben, die das PdvL mit drei gewählten virtuellen Bewegungen geliefert hat.
]

#merke[
  Der Hauptsatz ist *notwendig, aber im Allgemeinen nicht hinreichend*. Er gilt für jedes System, auch für verformbare und für Mechanismen. Aber aus dem Gleichgewicht der äußeren Kräfte am Gesamtsystem folgt noch nicht, dass auch jedes Teil in Ruhe bleibt. Für *einen einzelnen starren Körper* dagegen ist er auch hinreichend.
]

Die genaue Aussage ist: Für einen *einzelnen starren Körper* bilden der Hauptsatz und die etwaigen Bedingungen in den äußeren Bindungen (Richtung der Normalkraft bei einseitiger Bindung, Standfestigkeit, Haftreibungsgesetz) einen vollständigen Satz notwendiger _und hinreichender_ Bedingungen für eine Ruhelage. Besteht das System aus mehreren starren Bestandteilen, schreibt man den Hauptsatz für _jeden_ Bestandteil einzeln an. Beim System der zwei Stäbe wären das 6 Gleichungen (eben) bzw. 12 (räumlich). Dann erkennt man den Fehler sofort: An jedem getrennten Stab wirkt ein Kräftepaar mit Moment $!= 0$, die Momentenbedingung kann nicht erfüllt werden. Bei deformierbaren Systemen führt der Grenzübergang auf Differentialgleichungen des Gleichgewichts (Mechanik 2).

#fg("k08_schere", [Gleichgewicht der äußeren Kräfte, aber keine Ruhelage: Zwei gelenkig verbundene Stäbe auf reibungsfreier Ebene (Draufsicht), belastet mit $vF$ und $-vF$ auf derselben Wirkungslinie. Die äußeren Kräfte bilden eine Nullgruppe, trotzdem klappt die Anordnung zusammen. Erst das Gleichgewicht an jedem einzelnen Stab würde das aufdecken.])

#intu[
  Newtons erstes Gesetz in der Sprache der Statik: Sind die äußeren Kräfte an einem starren Körper im Gleichgewicht, ändert sich seine Bewegung nicht. Das ist Ruhe, aber auch gleichförmige Translation oder gleichförmige Drehung um eine Achse durch den Massenmittelpunkt. «Gleichgewicht» heißt also streng genommen: keine Änderung des Bewegungszustands. Die Statik behandelt den Fall, in dem dieser Zustand die Ruhe ist.
]

#rezept[Welches Werkzeug wofür?][
  - *Hauptsatz* (Gleichgewichtsbedingungen): der Normalfall. Systematisch, liefert alle Lagerkräfte. Bei mehreren Körpern muss man zerlegen und bekommt viele Gleichungen mit vielen Unbekannten.
  - *PdvL*: elegant, wenn man an einem beweglichen System (Mechanismus) _eine_ Beziehung zwischen Lasten oder _eine_ bestimmte Kraft sucht, ohne alle anderen auszurechnen. Braucht dafür etwas Kinematik aus Kapitel 3.
]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Wippe, Waage, Kran.* Das Hebelgesetz $F_1 l_1 = F_2 l_2$ ist die Momentenbedingung in ihrer einfachsten Form. Auf ihr beruhen die Balkenwaage, die Wippe auf dem Spielplatz, der Flaschenöffner und die Schubkarre. Ein Turmdrehkran trägt hinten Betongewichte, damit das Moment der Last (vorn) vom Moment des Gegengewichts (hinten) aufgehoben wird, und er darf nur so viel heben, wie dieses Gleichgewicht erlaubt: Je weiter draussen die Last hängt, desto weniger darf sie wiegen. Darum steht auf dem Kran eine Lastmomenttabelle.]

#alltag[*Standsicherheit.* Ob eine Leiter, ein Gerüst, ein Schild oder ein Kran umkippt, entscheiden die Gleichgewichtsbedingungen: $sum vF = bold(0)$ und $sum vM = bold(0)$ um jeden Punkt. Beim Aufstellen einer Leiter wählt man den Winkel so, dass die Haftreibung am Boden die waagrechte Kraft aufnehmen kann, in der Praxis etwa $75 degree$. Dieselben Bedingungen entscheiden, ob ein Regal an der Wand befestigt werden muss, wenn man oben Gewicht ablegt.]
// ALLTAG-END

#aufgaben()

#aufg(fig: "a08_quader", fw: 6.2cm)[Quader auf schiefer Ebene: Wo greift $vN$ an?][
  Ein Quader (Breite $a$ längs der Ebene, Höhe $2a$, Gewicht $G$ im Schwerpunkt $S$) liegt auf einer reibungsfreien schiefen Ebene (Neigung $alpha$). In der oberen talseitigen Ecke $A$ hält ihn eine horizontale Kraft $vF$.

  Gesucht sind mit dem PdvL die Haltekraft $F$, die Normalkraft $N$ und der Abstand $x$ ihres Angriffspunkts von der Mitte der Standfläche. Steht der Quader?
][
  Achsen: $ve_x$ längs der Ebene talwärts, $ve_y$ senkrecht von der Ebene weg. Dann ist $vG = (G sin alpha, -G cos alpha)$, $vF = (-F cos alpha, -F sin alpha)$, $vN = (0, N)$.

  _Zulässige Translation $tilde(v)$ längs der Ebene_ ($vN$ leistet nichts):
  $ tilde(PP) = (G sin alpha - F cos alpha) tilde(v) = 0 quad => quad F = G tan alpha. $

  _Unzulässige Translation $tilde(v)'$ senkrecht zur Ebene_ (die Bindung wird gelöst, $vN$ leistet mit):
  $ (N - G cos alpha - F sin alpha) tilde(v)' = 0 quad => quad N = G/(cos alpha). $

  _Unzulässige Rotation $tilde(omega)$ um $S$._ $vG$ hat kein Moment. $vF$ greift in $(a\/2, a)$ an, $vN$ in $(-x, -a)$:
  $ [a F (cos alpha - 1/2 sin alpha) - x N] tilde(omega) = 0 quad => quad x = a sin alpha (cos alpha - 1/2 sin alpha). $

  _Diskussion._ Der Quader steht, solange $vN$ innerhalb der Standfläche angreift, $|x| < a\/2$. Das ist gleichbedeutend mit $sin 2 alpha < 1 + sin^2 alpha$ und für jede Neigung erfüllt: Mit dieser Haltekraft kippt der Quader nie. Dieselben drei Gleichungen liefert der Hauptsatz ($vR = bold(0)$, $M_S = 0$); jede virtuelle Bewegung entspricht einer Gleichgewichtsbedingung.
]

#aufg(fig: "a08_waage", fw: 6cm)[Waage mit dem PdvL][
  Ein Balken ist in $A$ gelenkig gelagert. Rechts hängt im Abstand $L$ die Last $F$, links im Abstand $x$ die Last $2F$. Das Eigengewicht wird vernachlässigt.

  Für welches $x$ ist der Balken in Ruhe, und wie groß ist die Lagerkraft?
][
  _Ruhelage._ Der einzige zulässige Bewegungszustand ist die Rotation $tilde(omega)$ um $A$. Das rechte Ende hat die Schnelligkeit $L tilde(omega)$ nach oben (gegen $F$), der linke Angriffspunkt $x tilde(omega)$ nach unten (mit $2F$):
  $ tilde(PP) = (2 F x - F L) tilde(omega) = 0 quad => quad x = L/2. $
  Die Lagerkraft kommt in dieser Gleichung nicht vor. Das ist die Stärke des PdvL.

  _Lagerkraft._ Um sie zu finden, löst man die Bindung in Gedanken: Bei einer virtuellen vertikalen Translation $tilde(v)'$ leistet $A_y$ mit, $(A_y - 3F) tilde(v)' = 0$, also $A_y = 3F$. Eine horizontale Translation gibt $A_x = 0$.

  Der Hauptsatz liefert dasselbe: $sum X = 0$, $sum Y = 0$ geben $A_x = 0$, $A_y = 3F$, und $sum M_A = 0$ gibt $x = L\/2$.
]

#kurz[
  - Ruhelage: einmal dort in Ruhe, immer dort in Ruhe (nicht dasselbe wie momentane Ruhe).
  - Jede verhinderte Bewegungsmöglichkeit gehört zu genau einer Bindungskomponente.
  - PdvL: Ruhelage $<=>$ $tilde(PP) = 0$ für alle virtuellen Bewegungszustände.
  - Zulässig plus reibungsfrei: Bindungskräfte leisten nichts. Bindung lösen: genau diese Kraft kommt ins Spiel.
  - Hauptsatz: $vR^((a)) = bold(0)$, $vM_O^((a)) = bold(0)$ für die äußeren Kräfte. Notwendig; für den einzelnen starren Körper auch hinreichend.
]
