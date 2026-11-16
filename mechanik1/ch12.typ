#import "lib.typ": *

= Reibung

Bisher waren alle Bindungen reibungsfrei: Eine Unterlage konnte nur senkrecht zu sich drücken. In Wirklichkeit kann sie auch _entlang_ der Berührungsfläche Kraft übertragen. Sonst könnte niemand gehen, kein Auto fahren und kein Nagel in der Wand halten. Diese tangentiale Kontaktkraft ist die *Reibungskraft*.

== Physikalische Grundlagen

Die Kontaktkraft zwischen zwei Körpern wird zerlegt in die *Normalkraft* $vN$ (senkrecht zur Berührungsfläche) und die *Reibungskraft* $vF_R$ (tangential). Ursachen der Reibung sind die Rauigkeit der Oberflächen (mikroskopische Verzahnung) und Anziehungskräfte zwischen den Molekülen an den wirklichen Kontaktstellen. Ein vollständiges Modell ist sehr kompliziert; für die Technik genügen erstaunlich einfache Gesetze, die man aus einem Experiment liest.

#fg("k12_experiment", [Das Grundexperiment. Links: Ein Klotz wird mit langsam wachsender Kraft $F$ gezogen. Rechts: die gemessene Reibungskraft. Solange der Klotz haftet, ist $F_R = F$ (die Gerade); bei $mu_0 N$ reißt er los, danach wirkt die kleinere Gleitreibungskraft $mu_1 N$.])

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

== Gelenk- und Lagerreibung

In einem wirklichen Gelenk reibt der Zapfen (Radius $r_L$) in der Bohrung. Die Reibungskräfte am Zapfenumfang ergeben ein *Reibungsmoment* um die Gelenkachse. Mit der Gelenkkraft $vZ$ (die Kraft, mit der der Zapfen in die Bohrung gedrückt wird) gilt
#gl($ "Haften:" quad |M_R| <= mu_0 r_L |vZ|, wide "Gleiten:" quad |M_R| = mu_1 r_L |vZ|, $)
beim Gleiten der relativen Drehung entgegengesetzt. Ein raues Gelenk in Ruhe kann also, anders als das ideale, ein begrenztes Moment übertragen. Dieselben Formeln gelten für Querlager von Wellen; für ein Längslager mit Normalkraft $N$ entsprechend $M_R = mu_1 r_L N$.

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
