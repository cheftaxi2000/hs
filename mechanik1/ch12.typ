#import "lib.typ": *

= Reibung

Bisher waren alle Bindungen reibungsfrei: Eine Unterlage konnte nur senkrecht zu sich drücken. In Wirklichkeit kann sie auch _entlang_ der Berührungsfläche Kraft übertragen -- sonst könnte niemand gehen, kein Auto fahren und kein Nagel halten. Diese tangentiale Kontaktkraft ist die *Reibungskraft*.

== Physikalische Grundlagen

Die Kontaktkraft zwischen zwei Körpern wird zerlegt in die *Normalkraft* $vN$ (senkrecht zur Berührungsfläche) und die *Reibungskraft* $vF_R$ (tangential). Ursachen der Reibung sind die Rauigkeit der Oberflächen (mikroskopische Verzahnung) und Anziehungskräfte zwischen den Molekülen an den wirklichen Kontaktstellen.

#fig(13.4, 4.2, caption: [Das Grundexperiment. Links: Ein Klotz wird mit langsam wachsender Kraft $F$ gezogen. Rechts: die dabei gemessene Reibungskraft. Solange der Klotz haftet, ist $F_R = F$ (die Gerade); bei $mu_0 N$ reißt er los, danach wirkt die kleinere Gleitreibungskraft $mu_1 N$.],
  hatch((0.3,0.8),(5.6,0.8)), rct((1.6,0.8),(3.6,2.0)), pt((2.6,1.4)),
  arr((2.6,1.4),(2.6,0.3), c: cf, w: 1.3pt), lbl((2.9,0.45), $vG$, c: cf),
  arr((3.6,1.4),(5.0,1.4), c: cf, w: 1.3pt), lbl((5.25,1.4), $vF$, c: cf),
  arr((2.9,-0.2),(2.9,0.8), c: cf, w: 1.3pt), lbl((3.25,-0.05), $vN$, c: cf),
  arr((2.6,0.8),(1.2,0.8), c: cf, w: 1.3pt), lbl((0.95,1.1), $vF_R$, c: cf),
  // Diagramm
  axes((7.6,0.5), 5.2, 3.3, lx: $F$, ly: $|F_R|$, neg: 0.1),
  li((7.6,0.5),(10.1,3.0), s: 1.2pt + cf), li((10.1,3.0),(10.1,2.3), s: 0.5pt + cf, dash: "dashed"), li((10.1,2.3),(12.5,2.3), s: 1.2pt + cf),
  dl((7.6,3.0),(10.1,3.0)), dl((7.6,2.3),(10.1,2.3)),
  lbl((7.05,3.0), $mu_0 N$, size: 8pt), lbl((7.05,2.3), $mu_1 N$, size: 8pt),
  lbl((8.5,2.15), [Haften], size: 8pt, c: cg), lbl((11.4,2.6), [Gleiten], size: 8pt, c: cg),
  pb: 0.3,
)

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
  Das Haftreibungsgesetz ist eine *Ungleichung*. Es sagt _nicht_, wie groß die Haftreibungskraft ist -- nur, wie groß sie höchstens werden kann. Die Haftreibungskraft ist eine Bindungskraft wie jede Lagerkraft: Betrag und Richtung folgen aus den *Gleichgewichtsbedingungen*. Die Ungleichung prüft man _danach_. Nur an der Haftgrenze (das System beginnt gerade zu rutschen) gilt das Gleichheitszeichen.
]

#rezept[Aufgaben mit Haftreibung][
  + Freischneiden. An jeder rauen Kontaktstelle $N$ *und* $F_R$ als Unbekannte eintragen (Richtung von $F_R$ annehmen).
  + $N$ und $F_R$ aus den Gleichgewichtsbedingungen bestimmen.
  + Haftbedingung $|F_R| <= mu_0 N$ einsetzen. Das Ergebnis ist ein *Bereich* für die gesuchte Größe (einen Winkel, eine Kraft, eine Reibungszahl).
  + Außerdem prüfen: $N >= 0$ (kein Abheben) und Standfestigkeit (kein Kippen).
]

#fig(13, 4.2, caption: [Links: Klotz auf der schiefen Ebene. Er haftet, solange $tan alpha <= mu_0$. Rechts: Leiter an glatter Wand auf rauem Boden.],
  poly(((0.5,0.5),(5.6,0.5),(5.6,3.05)), fill: luma(245)),
  arc((0.5,0.5), 1.1, 0, 26.6, w: 0.5pt), lbl((1.9,0.8), $alpha$, size: 8pt),
  poly(((2.63,1.565),(3.97,2.235),(3.61,2.95),(2.27,2.28))), pt((3.12,2.26)),
  arr((3.12,2.26),(3.12,0.96), c: cf, w: 1.3pt), lbl((3.4,1.1), $vG$, c: cf),
  arr((3.3,1.9),(2.76,2.97), c: cf, w: 1.3pt), lbl((2.45,3.2), $vN$, c: cf),
  arr((3.3,1.9),(4.3,2.4), c: cf, w: 1.3pt), lbl((4.75,2.75), $vF_R$, c: cf),
  // Leiter
  hatch((7.6,0.5),(12.4,0.5)), hatch((12.0,0.5),(12.0,4.2)),
  beam((9.2,0.5),(12.0,3.7)), pt((10.6,2.1)),
  arr((10.6,2.1),(10.6,1.0), c: cf, w: 1.3pt), lbl((10.9,1.2), $vG$, c: cf),
  arr((9.2,-0.4),(9.2,0.45), c: cf, w: 1.3pt), lbl((9.6,-0.2), $N_A$, c: cf),
  arr((8.2,0.5),(9.15,0.5), c: cf, w: 1.3pt), lbl((8.3,0.85), $F_R$, c: cf),
  arr((12.9,3.7),(12.05,3.7), c: cf, w: 1.3pt), lbl((12.8,4.0), $N_B$, c: cf),
  arc((9.2,0.5), 0.8, 0, 48.8, w: 0.5pt), lbl((10.25,0.8), $alpha$, size: 8pt),
  lbl((9.0,0.9), $A$), lbl((11.7,3.9), $B$),
  pb: 0.4,
)

#bsp[Klotz auf schiefer Ebene][
  Gleichgewicht längs und quer zur Ebene: $F_R = G sin alpha$, $N = G cos alpha$. Haftbedingung: $G sin alpha <= mu_0 G cos alpha$, also
  $ tan alpha <= mu_0. $
  Das Gewicht fällt heraus: Ob ein Körper rutscht, hängt nur vom Winkel und von $mu_0$ ab. Den Grenzwinkel $rho_0$ mit $tan rho_0 = mu_0$ nennt man *Haftreibungswinkel*. So misst man $mu_0$: Ebene langsam neigen, bis der Körper losrutscht.
]

#intu[
  Die gesamte Kontaktkraft $vN + vF_R$ kann gegenüber der Flächennormalen höchstens um den Winkel $rho_0$ geneigt sein. Alle möglichen Richtungen bilden einen Kegel um die Normale, den *Reibungskegel*. Solange die Resultierende der übrigen Kräfte innerhalb dieses Kegels auf die Fläche drückt, haftet der Körper -- egal wie groß sie ist. Deshalb hält ein Keil, deshalb rutscht eine flach genug geneigte Schraube nicht von selbst auf (Selbsthemmung).
]

#bsp[Leiter an der Wand][
  Homogene Leiter (Gewicht $G$, Länge $L$, Winkel $alpha$ zum Boden), Wand glatt, Boden rau.
  $ sum Y: quad N_A = G, wide sum X: quad F_R = N_B, wide sum M_A: quad N_B L sin alpha - G L/2 cos alpha = 0. $
  Also $F_R = N_B = G \/ (2 tan alpha)$. Haftbedingung $F_R <= mu_0 N_A$:
  $ tan alpha >= 1 / (2 mu_0). $
  Die Leiter muss steil genug stehen. Für $mu_0 = 0.5$ mindestens $45°$.
]

== Gleitreibung

#satz[Gleitreibungsgesetz (Coulomb)][
  Gleitet der Berührungspunkt mit der Geschwindigkeit $vv != bold(0)$ relativ zur Unterlage, so ist
  #gl($ vF_R = -mu_1 |vN| vv / (|vv|). $)
  Die Gleitreibungskraft hat den festen Betrag $mu_1 |vN|$ und ist der Relativgeschwindigkeit *entgegengerichtet*.
]

Beim Gleiten ist die Reibungskraft also _bekannt_ (keine zusätzliche Unbekannte), ihre Leistung ist immer negativ: Sie entzieht dem System mechanische Energie und wandelt sie in Wärme um.

#table(columns: (auto, 1fr, 1fr), stroke: none, inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 0.6pt),
  [], [*Haften*], [*Gleiten*],
  table.hline(stroke: 0.3pt),
  [Relativgeschwindigkeit], [null], [nicht null],
  [Betrag von $F_R$], [aus dem Gleichgewicht; nur $<= mu_0 N$], [$= mu_1 N$],
  [Richtung von $F_R$], [aus dem Gleichgewicht], [gegen die Relativgeschwindigkeit],
  [Art der Aussage], [Ungleichung], [Gleichung],
  table.hline(stroke: 0.6pt),
)

== Gelenk- und Lagerreibung

In einem wirklichen Gelenk reibt der Zapfen (Radius $r_L$) in der Bohrung. Die Reibungskräfte am Zapfenumfang ergeben ein *Reibungsmoment* um die Gelenkachse. Mit der Gelenkkraft $vZ$ (der Kraft, mit der der Zapfen in die Bohrung gedrückt wird):
#gl($ "Haften:" quad |M_R| <= mu_0 r_L |vZ|, wide "Gleiten:" quad |M_R| = mu_1 r_L |vZ|, $)
beim Gleiten der relativen Drehung entgegengesetzt. Ein raues Gelenk in Ruhe kann also -- anders als das ideale -- ein begrenztes Moment übertragen. Dieselben Formeln gelten für Querlager von Wellen; für ein Längslager mit Normalkraft $N$ entsprechend $M_R = mu_1 r_L N$.

== Rollreibung

Ein starres Rad auf starrer, schiefer Ebene: Die Momentenbedingung um den Berührungspunkt $Z$ enthält nur das Gewicht (Hebelarm $R sin alpha$) und kann für $alpha != 0$ nie erfüllt sein. Nach diesem Modell würde ein Rad auf der kleinsten Neigung losrollen. Die Erfahrung zeigt etwas anderes.

Die Auflösung: Rad und Unterlage verformen sich an der Berührungsstelle ein wenig. Die Normalkräfte sind über eine kleine Fläche verteilt, und ihre Resultierende greift nicht genau in $Z$ an, sondern um eine kleine Strecke $e$ in Rollrichtung versetzt. Das ergibt ein *Rollreibungsmoment* $M_R = e |vN|$.

#fig(12, 3.6, caption: [Rollreibung. Die Normalkraft greift um $e$ versetzt an; das ist gleichwertig mit einer Normalkraft in $Z$ plus einem Moment $M_R = e N$, das dem Rollen entgegenwirkt.],
  hatch((0.3,0.6),(4.6,0.6)), circ((2.4,2.0), 1.4), pt((2.4,2.0)),
  arr((2.4,2.0),(2.4,0.9), c: cf, w: 1.3pt), lbl((2.1,1.2), $vG$, c: cf),
  arr((2.75,-0.3),(2.75,0.6), c: cf, w: 1.3pt), lbl((3.1,-0.1), $vN$, c: cf),
  bem((2.4,0.6),(2.75,0.6), $e$, off: 0.25),
  arr((2.4,2.0),(3.5,2.0), c: cf, w: 1.3pt), lbl((3.75,2.0), $vF$, c: cf),
  arr((2.4,0.6),(1.4,0.6), c: cf, w: 1.3pt), lbl((1.2,0.9), $vF_R$, c: cf),
  lbl((5.6,1.6), $=$, size: 12pt),
  hatch((6.6,0.6),(10.9,0.6)), circ((8.7,2.0), 1.4), pt((8.7,2.0)),
  arr((8.7,2.0),(8.7,0.9), c: cf, w: 1.3pt),
  arr((8.7,-0.3),(8.7,0.6), c: cf, w: 1.3pt), lbl((9.05,-0.1), $vN$, c: cf),
  arr((8.7,2.0),(9.8,2.0), c: cf, w: 1.3pt), arr((8.7,0.6),(7.7,0.6), c: cf, w: 1.3pt),
  arc((8.7,0.6), 0.55, 20, 160, col: cm, head: true, hs: 0.13), lbl((8.7,1.4), $M_R$, c: cm, size: 8pt),
  pb: 0.35,
)

#satz[Rollreibungsgesetz][
  #gl($ "Ruhe:" quad |M_R| <= mu_2 |vN|, wide "Rollen:" quad |M_R| = mu_2 |vN|. $)
  $mu_2$ heißt *Rollreibungslänge*. Sie ist -- anders als $mu_0, mu_1$ -- keine reine Zahl, sondern eine *Länge* (typisch Bruchteile eines Millimeters für Stahl auf Stahl).
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
  - Schiefe Ebene: Haften für $tan alpha <= mu_0$.
  - Gelenk: $|M_R| <= mu_0 r_L |Z|$ bzw. $= mu_1 r_L |Z|$.
  - Rollen: $|M_R| <= mu_2 N$ mit der Rollreibungslänge $mu_2$.
]
