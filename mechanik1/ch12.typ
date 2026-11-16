#import "lib.typ": *

= Reibung

Bisher waren alle Bindungen reibungsfrei: Eine Unterlage konnte nur senkrecht zu sich drücken. In Wirklichkeit kann sie auch _entlang_ der Berührungsfläche Kraft übertragen. Sonst könnte niemand gehen, kein Auto fahren und kein Nagel in der Wand halten. Diese tangentiale Kontaktkraft ist die *Reibungskraft*.

== Physikalische Grundlagen

Die Kontaktkraft zwischen zwei Körpern wird zerlegt in die *Normalkraft* $vN$ (senkrecht zur Berührungsfläche) und die *Reibungskraft* $vF_R$ (tangential). Ursachen der Reibung sind die Rauigkeit der Oberflächen (mikroskopische Verzahnung) und Anziehungskräfte zwischen den Molekülen an den wirklichen Kontaktstellen. Ein vollständiges Modell ist sehr kompliziert; für die Technik genügen erstaunlich einfache Gesetze, die man aus einem Experiment liest.

#fg("k12_experiment", [Das Grundexperiment. Links: Ein Klotz wird mit langsam wachsender Kraft $F$ gezogen. Rechts: die gemessene Reibungskraft. Solange der Klotz haftet, ist $F_R = F$ (die Gerade); bei $mu_0 N$ reißt er los, danach wirkt die kleinere Gleitreibungskraft $mu_1 N$.])

Zwei mikroskopische Ursachen stehen hinter der Reibung. Erstens die _Rauigkeit_ der Berührungsflächen: Lokal haben die Flächen verschiedene Richtungen der gemeinsamen Normalen, die sich tendenziell gegen die Bewegung verdrehen. Zweitens die Neigung von Molekülen, unter Druck oder Wärme Bindungen einzugehen, sobald sie sich nahe genug kommen. Das führt zu lokalen Verschweißungen, die den Gleitwiderstand erhöhen. Die Normalkräfte leisten bei zulässigen virtuellen Bewegungen nichts (sie stehen senkrecht), die Reibungskräfte (in der Tangentialebene) schon.

Zum Experiment: Man verändert das Gewicht $G$ des Klotzes durch Standardgewichte, erhöht $F$ langsam bis zum Losreißen und hält dann die Geschwindigkeit konstant. Weil in der Ruhelage und bei gleichförmiger Translation die äußeren Kräfte im Gleichgewicht sein müssen, ist $vF_R = -vF$ und $N = G$. Die Vorzeichen von $F_R$ und $F$ sind also immer verschieden. Die Messungen lassen sich damit als Aussagen über $F_R$, $v$ und $|vN|$ lesen und auf beliebige Geometrien verallgemeinern.

Die erste Feststellung: Die Funktion $F_R(v)$ ist in erster Näherung _proportional zum Normalkraftbetrag_. Der Quotient $f(v) = F_R(v)\/|N|$ hat für alle $|N|$ denselben Graphen. Seine qualitative Gestalt (Stahl auf Stahl, Aluminium auf Stahl, Gummi auf Asphalt) zeigt: Der Körper setzt sich in Bewegung, sobald $|f|$ den Grenzwert $mu_0$ erreicht, dann nimmt $|f|$ mit wachsender Schnelligkeit ab bis zum stationären Wert $mu_1$. Beide Zahlen hängen von der Materialpaarung und den Schmierverhältnissen ab. Wir vereinfachen diesen Übergang zu einem Sprung von $mu_0$ auf $mu_1$ (das Bild oben) und bekommen Haft- und Gleitreibungsgesetz.

Beim Ziehen des Klotzes beobachtet man: Solange $F$ klein ist, bewegt sich nichts, und die Reibungskraft hält genau dagegen, $F_R = F$. Bei einem Grenzwert reißt der Klotz los, und danach wirkt eine etwas kleinere, praktisch konstante Reibungskraft.

#defn[Haft- und Gleitreibungszahl][
  Der Grenzwert $mu_0$ des Verhältnisses $|F_R| \/ |N|$, bei dem das Gleiten einsetzt, heißt *Haftreibungszahl*. Der Wert $mu_1$ dieses Verhältnisses beim Gleiten heißt *Gleitreibungszahl*. Beide hängen im Wesentlichen nur von der Materialpaarung und dem Zustand der Oberflächen ab, kaum von der Größe der Berührungsfläche. In der Regel ist $mu_1 < mu_0$.
]

Typische Größenordnungen: Stahl auf Stahl trocken etwa 0.15, Gummi auf trockenem Asphalt etwa 0.8, Stahl auf Eis etwa 0.03.

== Haftreibung

#satz[Haftreibungsgesetz][
  Solange zwei Körper aneinander haften (Geschwindigkeit des materiellen Berührungspunkts relativ zur Unterlage null), gilt
  #gl($ |vF_R| <= mu_0 |vN|. $)
]

#merke[
  Das Haftreibungsgesetz ist eine *Ungleichung*. Es sagt _nicht_, wie groß die Haftreibungskraft ist, nur, wie groß sie höchstens werden kann. Die Haftreibungskraft ist eine Bindungskraft wie jede Lagerkraft: Betrag und Richtung folgen aus den *Gleichgewichtsbedingungen*. Die Ungleichung prüft man erst _danach_. Nur an der Haftgrenze (das System beginnt gerade zu rutschen) gilt das Gleichheitszeichen.
]

Genauer: Haftreibungsgesetz heißt, dass an den materiellen Berührungspunkten die Relativgeschwindigkeit $vv = bold(0)$ bleibt, solange die Haftbedingung erfüllt ist. In einer Bindung mit Haftreibung führt man deshalb zuerst eine Haftreibungskraft (oder ein Haftreibungsmoment) von unbekanntem Betrag und unbekannter Richtung ein. Bei einem statisch bestimmten System liefern die Gleichgewichtsbedingungen $F_R$ und $N$; diese Werte setzt man dann bei der Diskussion der Resultate (Schritt 8 des Rezepts aus Kapitel 9) in die Ungleichung ein, um zu entscheiden, ob das System überhaupt in Ruhe sein kann.

#merke[
  In der Umgangssprache sagt man «das Rad rutscht, weil die Reibung zu klein ist». Gemeint ist _nicht_, dass der Betrag $|F_R|$ zu klein wäre. Im Gegenteil: Je größer $|F_R|$ ist, desto schwerer ist die Haftbedingung zu erfüllen. Gemeint ist, dass $mu_0$ (genauer, das Verhältnis $|F_R|\/N$, das die Situation erzwingt) zu klein für die Aufgabe ist.
]

#rezept[Aufgaben mit Haftreibung][
  + Freischneiden. An jeder rauen Kontaktstelle $N$ *und* $F_R$ als Unbekannte eintragen (Richtung von $F_R$ annehmen).
  + $N$ und $F_R$ aus den Gleichgewichtsbedingungen bestimmen.
  + Haftbedingung $|F_R| <= mu_0 N$ einsetzen. Das Ergebnis ist ein *Bereich* für die gesuchte Größe (einen Winkel, eine Kraft, eine Reibungszahl).
  + Außerdem prüfen: $N >= 0$ (kein Abheben) und Standfestigkeit (kein Kippen).
]

#fg("k12_ebene", [Links der Klotz auf der schiefen Ebene. Rechts der Reibungskegel: Die gesamte Kontaktkraft $vR = vN + vF_R$ darf höchstens um den Haftreibungswinkel $rho_0$ gegen die Normale geneigt sein.])

#bsp[Klotz auf schiefer Ebene][
  Gleichgewicht längs und quer zur Ebene: $F_R = G sin alpha$, $N = G cos alpha$. Haftbedingung: $G sin alpha <= mu_0 G cos alpha$, also
  $ tan alpha <= mu_0. $
  Das Gewicht fällt heraus: Ob ein Körper rutscht, hängt nur vom Winkel und von $mu_0$ ab. Den Grenzwinkel $rho_0$ mit $tan rho_0 = mu_0$ nennt man *Haftreibungswinkel*. So misst man $mu_0$: die Ebene langsam neigen, bis der Körper losrutscht, und den Winkel ablesen.
]

#intu[
  Die gesamte Kontaktkraft $vN + vF_R$ kann gegenüber der Flächennormalen höchstens um $rho_0$ geneigt sein. Alle möglichen Richtungen bilden einen Kegel um die Normale, den *Reibungskegel* (rechts in der Abbildung). Solange die Resultierende der übrigen Kräfte innerhalb dieses Kegels auf die Fläche drückt, haftet der Körper, egal wie groß sie ist. Deshalb hält ein Keil, und deshalb rutscht eine flach genug geneigte Schraube nicht von selbst auf (Selbsthemmung).
]

#bsp[Rollendes Antriebsrad][
  Ein Rad (Radius $R$) rollt gleichförmig, etwa der Radsatz einer Lokomotive, die einen Wagenzug zieht. Dann sind $omega$ und damit $v_O = omega R$ konstant, nach der Bemerkung in Kapitel 8 müssen die Gleichgewichtsbedingungen erfüllt sein. Die Horizontalkomponente $F$ der Lagerkraft in $O$ (der Widerstand des Wagenzugs) ist entgegengesetzt zu $vv_O$ gerichtet und gleich groß wie die Reibungskraft $F_R$. Das Kräftepaar aus $F$ in $O$ und $F_R$ im Berührungspunkt $Z$ muss mit dem Antriebsmoment $M_A$ im Gleichgewicht sein: $M_A = R F_R$. Die Haftreibungskraft zeigt dabei in Fahrtrichtung. Trotzdem ist sie _leistungslos_, weil ihr Angriffspunkt das Momentanzentrum $Z$ ist, dessen Geschwindigkeit null ist. Die Widerstandskraft $F$ leistet mit $vv_O$ negative Leistung, und das Antriebsmoment bringt die gleich große positive Leistung auf. Aus der Haftbedingung $F_R <= mu_0 N$ folgt
  $ M_A < R mu_0 |N|. $
  Erhöht man das Antriebsmoment über diese Grenze hinaus, dreht das Rad durch. Man vergrößert die Grenze durch einen größeren Raddurchmesser, eine größere Haftreibungszahl oder eine größere vertikale Last auf dem Rad (deshalb sind Triebachsen von Lokomotiven schwer).
]

#bsp[Zwei Stäbe mit Reibung][
  Zwei gewichtslose Stäbe sind in den reibungsfreien Gelenken $A$ und $B$ gelagert und berühren sich in $C$ (Haftreibungszahl $mu_0$); der eine trägt eine vertikale Last $G$, der andere eine horizontale Last $F$. In welchem Bereich darf $F$ liegen, damit das System in Ruhe bleibt? Man trennt das System, damit Normalkraft und Reibungskraft in $C$ für jeden Stab als äußere Kräfte erscheinen. Die Richtung der Normalkraft steht wegen der einseitigen Bindung fest, die der Reibungskraft nicht: Erst das Vorzeichen von $F_R$ aus dem Gleichgewicht verrät sie. $F_R > 0$ entspricht einer Gleitgefahr wegen zu großem $G$, $F_R < 0$ einer Gleitgefahr wegen zu großem $F$. Die Haftbedingung $|F_R| <= mu_0 N$ deckt beide Fälle ab und liefert zwei Ungleichungen, die zusammen einen _Bereich_ für $F$ ergeben: eine untere und eine obere Grenze, beide aus $mu_0$ und $G$ berechnet. Zu kleines $F$ lässt den Stab wegen $G$ abrutschen, zu großes in die andere Richtung.
]

#fg("k12_leiter", [Leiter an einer glatten Wand auf rauem Boden.])

#bsp[Leiter an der Wand][
  Homogene Leiter (Gewicht $G$, Länge $L$, Winkel $alpha$ zum Boden), Wand glatt, Boden rau. Unbekannt: $N_A, F_R$ (Boden), $N_B$ (Wand).
  $ sum Y: quad N_A = G, wide sum X: quad F_R = N_B, wide sum M_A: quad N_B L sin alpha - G (L/2) cos alpha = 0. $
  Also $N_B = G\/(2 tan alpha)$ und damit $F_R = G\/(2 tan alpha)$. Haftbedingung $F_R <= mu_0 N_A$:
  $ tan alpha >= 1 / (2 mu_0). $
  Die Leiter muss steil genug stehen. Für $mu_0 = 0.5$ mindestens $45°$. Stellt sich eine Person auf die Leiter, ändert sich das Ergebnis (je höher, desto größer $N_B$): Die Leiter rutscht, wenn man oben steht.
]

== Gleitreibung

#satz[Gleitreibungsgesetz (Coulomb)][
  Gleitet der Berührungspunkt mit der Geschwindigkeit $vv != bold(0)$ relativ zur Unterlage, so ist
  #gl($ vF_R = -mu_1 |vN| vv / (|vv|). $)
  Die Gleitreibungskraft hat den festen Betrag $mu_1 |vN|$ und ist der Relativgeschwindigkeit *entgegengerichtet*.
]

Beim Gleiten ist die Reibungskraft also _bekannt_ (keine zusätzliche Unbekannte), und ihre Leistung ist immer negativ: Sie entzieht dem System mechanische Energie und wandelt sie in Wärme um.

#table(columns: (auto, 1fr, 1fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [], [*Haften*], [*Gleiten*],
  table.hline(stroke: 0.4pt),
  [Relativgeschwindigkeit], [null], [nicht null],
  [Betrag von $F_R$], [aus dem Gleichgewicht; nur $<= mu_0 N$], [$= mu_1 N$],
  [Richtung von $F_R$], [aus dem Gleichgewicht], [gegen die Relativgeschwindigkeit],
  [Art der Aussage], [Ungleichung], [Gleichung],
  table.hline(stroke: 0.7pt),
)

Das Gleitreibungsgesetz geht auf Ansätze von Coulomb (1736 bis 1806) und Morin (1795 bis 1880) zurück. Verlangen die Gleichgewichtsbedingungen (oder in der Dynamik die Bewegungsgleichungen) Lagerkraftkomponenten, die der Haftbedingung nicht genügen, tritt Gleiten ein. Probleme mit Gleitreibung gehören naturgemäß schon in die Dynamik; in der Statik braucht man das Gesetz, wenn man zum Beispiel eine Bremse im Gleichgewicht mit gleichförmig bewegten Teilen betrachtet.

In der Statik tritt Gleitreibung dann auf, wenn ein bewegter starrer Körper im Gleichgewicht ist (seine Kinemate bezüglich des Massenmittelpunkts bleibt konstant, Kapitel 8). Dann liefert das Gleitreibungsgesetz, im Gegensatz zum Haftreibungsgesetz, eine zusätzliche _Gleichung_. Bei gut geschmierten Flächen mit einem Schmierfilm braucht man für eine genaue Behandlung die Strömungsmechanik; unser Gesetz gilt für trockene Reibung (ungefettete oder nur mäßig gefettete Flächen).

#bsp[Schleifscheibe][
  Ein Messer wird an einer Schleifscheibe (Radius $R$) geschliffen, die mit konstanter Rotationsgeschwindigkeit um ihr Lager dreht. Ist die Normalkraft $N$ auf das Messer bekannt, folgt die Reibungskraft am Umfang aus $F_R = mu_1 N$ (gegen die Bewegung gerichtet), und die Momentenbedingung um das Lager liefert das nötige Antriebsmoment $M = R F_R = mu_1 N R$. Das ist der Preis des Schleifens.
]

== Gelenk- und Lagerreibung

In einem wirklichen Gelenk reibt der Zapfen (Radius $r_L$) in der Bohrung. Die Reibungskräfte am Zapfenumfang ergeben ein *Reibungsmoment* um die Gelenkachse. Mit der Gelenkkraft $vZ$ (die Kraft, mit der der Zapfen in die Bohrung gedrückt wird) gilt
#gl($ "Haften:" quad |M_R| <= mu_0 r_L |vZ|, wide "Gleiten:" quad |M_R| = mu_1 r_L |vZ|, $)
beim Gleiten der relativen Drehung entgegengesetzt. Ein raues Gelenk in Ruhe kann also, anders als das ideale, ein begrenztes Moment übertragen. Dieselben Formeln gelten für kurze und lange Querlager von Wellen. Für ein Längslager gilt etwas anderes, siehe unten.

Wie entsteht das Reibungsmoment im Gelenk? Bei reibungsfreier Berührung geht die Wirkungslinie der Zapfenkraft durch die Gelenkmitte $O$. Mit Reibung besteht die Zapfenkraft $vZ$ aus zwei Komponenten $vN$ und $vF_R$, von denen nur $vN$ durch die Gelenkmitte geht. Für die Reduktion auf $O$ (ebenes Problem) entsteht neben der Kraft ${O | vZ}$ ein Kräftepaar mit dem Moment $M_R = r_L F_R$ ($r_L$ Lagerradius): das *Reibungsmoment*. Ohne Bewegung zwischen Zapfen und Buchse ist es eine zusätzliche Unbekannte, die man aus dem Gleichgewicht bestimmt. Beispiel: Ein homogener Balken ist in $A$ in einem rauen Gelenk festgehalten und in $B$ reibungsfrei aufgelegt. Unbekannt sind $A_x, A_y, B_y, M_R$; die Komponentenbedingung in horizontaler Richtung zeigt $A_x = 0$, die zwei restlichen Gleichungen reichen für drei Unbekannte ($A_y, B_y, M_R$) nicht aus. Man bekommt nur den _Bereich_ von $M_R$, den die Haftbedingung erlaubt.

Die Haftbedingung $|F_R| <= mu_0 N$ wird mit $r_L$ multipliziert und gibt links das Reibungsmoment. Rechts steht aber die unbekannte Normalkraft $N$, denn man kann $vZ$ nicht eindeutig in $N$ und $F_R$ zerlegen, solange der Berührungspunkt unbekannt ist. Man ersetzt deshalb $N$ durch den etwas größeren Betrag $|Z|$. Der Unterschied ist höchstens der Faktor $sqrt(1 + mu_0^2)$, für $mu_0 = 0.5$ etwa 12 %, was bei der großen Unsicherheit der Messwerte von $mu_0$ bedeutungslos ist. So entsteht die Form, die wir oben benutzt haben, $|M_R| <= mu_0 r_L |vZ|$.

#bsp[Zwei Stäbe in einem rauen Gelenk][
  Zwei Stäbe der Länge $L$, jeder mit Gewicht $G$, sind in $C$ durch ein raues Gelenk (Lagerradius $r_L$) verbunden; $A$ ist reibungsfrei gelagert, $B$ ein horizontal verschiebbares Auflager, in $B$ wirkt die horizontale Stützkraft $F$. Am Gesamtsystem fallen die Kräfte und Momente in $C$ heraus (sie sind innere Kräfte): $A_y = G$, $A_x = F$, $B_y = G$. Um das zulässige Intervall für $F$ zu finden, trennt man in $C$. Aus der Momentenbedingung um $C$ für einen Stab folgt das Reibungsmoment $M_R$; die Zapfenkraft in $C$ hat den Betrag $F$. Die Haftbedingung $|M_R| <= mu_0 r_L F$ liefert je nach Vorzeichen von $M_R$ zwei Ungleichungen, die zusammen das zulässige Intervall für $F$ geben.
]

Für ein Längslager lässt sich eine genauere Formel herleiten. Eine Welle vom Radius $R$ liege gleichmäßig auf. Das Flächenelement $dif A = r dif r dif phi$ trägt die Normalkraft $dif N = N dif A\/(pi R^2)$ und die tangentiale Reibungskraft $|dif F_R| = mu_1 dif N$ im Abstand $r$ von der Achse. Aufsummiert (integriert) ergibt sich das Reibungsmoment $M_R = integral r dif F_R = (mu_1 N \/ (pi R^2)) integral_0^R r^2 dif r integral_0^(2 pi) dif phi = (2\/3) mu_1 R N$. Das ist weniger als $mu_1 R N$, weil die Reibungskräfte im Mittel näher an der Achse angreifen als am Rand.

== Rollreibung

Ein starres Rad auf starrer, schiefer Ebene: Die Momentenbedingung um den Berührungspunkt $Z$ enthält nur das Gewicht (Hebelarm $R sin alpha$) und kann für $alpha != 0$ nie erfüllt sein. Nach diesem Modell würde jedes Rad schon bei der kleinsten Neigung losrollen. Die Erfahrung zeigt etwas anderes.

Die Auflösung: Rad und Unterlage verformen sich an der Berührungsstelle ein wenig. Die Normalkräfte sind über eine kleine Fläche verteilt, und ihre Resultierende greift nicht genau in $Z$ an, sondern um eine kleine Strecke $e$ in Rollrichtung versetzt. Das ergibt ein *Rollreibungsmoment* $M_R = e |vN|$.

#fg("k12_roll", [Rollreibung. Die Normalkraft greift um $e$ versetzt an. Das ist gleichwertig mit einer Normalkraft in $Z$ plus einem Moment $M_R = e N$, das dem Rollen entgegenwirkt.])

#satz[Rollreibungsgesetz][
  #gl($ "Ruhe:" quad |M_R| <= mu_2 |vN|, wide "Rollen:" quad |M_R| = mu_2 |vN|. $)
  $mu_2$ heißt *Rollreibungslänge*. Sie ist, anders als $mu_0, mu_1$, keine reine Zahl, sondern eine *Länge* (typisch Bruchteile eines Millimeters für Stahl auf Stahl).
]

#bsp[Rad auf schiefer Ebene][
  Gleichgewicht: $F_R = G sin alpha$, $N = G cos alpha$, $M_R = R G sin alpha$. Damit das Rad ruht, müssen *beide* Bedingungen gelten:
  $ "nicht gleiten:" quad tan alpha <= mu_0, wide "nicht rollen:" quad tan alpha <= mu_2 / R. $
  Weil $mu_2 \/ R$ fast immer viel kleiner ist als $mu_0$, beginnt das Rad zu rollen, lange bevor es rutschen würde. Darum hat man das Rad erfunden.
]

#fehler[
  - $F_R = mu_0 N$ als Gleichung hinschreiben, obwohl nur Haften vorliegt. Gleichheit gilt nur an der Haftgrenze.
  - Die Richtung der Reibungskraft falsch annehmen und dann mit Beträgen weiterrechnen. Beim Haften Richtung annehmen und das Vorzeichen ernst nehmen; beim Gleiten gegen die Relativgeschwindigkeit.
  - Bei mehreren Kontaktstellen annehmen, alle seien gleichzeitig an der Haftgrenze. Das muss nicht so sein.
  - Vergessen, auch das Kippen zu prüfen: Ein hoher Klotz kippt, bevor er rutscht.
]

#kurz[
  - Haften: $|F_R| <= mu_0 N$, Ungleichung; $F_R$ aus dem Gleichgewicht.
  - Gleiten: $F_R = mu_1 N$, gegen die Bewegung.
  - Schiefe Ebene: Haften für $tan alpha <= mu_0$. Reibungskegel mit Öffnungswinkel $rho_0$, $tan rho_0 = mu_0$.
  - Gelenk: $|M_R| <= mu_0 r_L |Z|$ bzw. $= mu_1 r_L |Z|$.
  - Rollen: $|M_R| <= mu_2 N$ mit der Rollreibungslänge $mu_2$.
]
