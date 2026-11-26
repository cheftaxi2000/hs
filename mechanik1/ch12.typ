#import "lib.typ": *

= Reibung

#woche(12, [Reibung, Statik], [169–175, 180–185, 188–190])

Bisher waren alle Bindungen reibungsfrei: Eine Unterlage konnte nur senkrecht zu sich drücken. In Wirklichkeit kann sie auch _entlang_ der Berührungsfläche Kraft übertragen. Sonst könnte niemand gehen, kein Auto fahren und kein Nagel in der Wand halten. Diese tangentiale Kontaktkraft ist die *Reibungskraft*.

== Physikalische Grundlagen

Die Kontaktkraft zwischen zwei Körpern wird zerlegt in die *Normalkraft* $vN$ (senkrecht zur Berührungsfläche) und die *Reibungskraft* $vF_R$ (tangential). Zwei mikroskopische Ursachen stecken dahinter. Erstens die _Rauigkeit_: Die Oberflächen berühren sich nur an wenigen Spitzen, deren lokale Normalen in alle Richtungen zeigen, und diese Spitzen verhaken sich. Zweitens die _Adhäsion_: An den wirklichen Kontaktstellen kommen sich die Moleküle so nahe, dass sie Bindungen eingehen («Mikroverschweissungen»), die beim Gleiten immer wieder abgeschert werden. Ein vollständiges Modell ist sehr kompliziert; für die Technik genügen erstaunlich einfache Gesetze, die man aus einem Experiment liest.

#fg("k12_experiment", [Das Grundexperiment. Links: Ein Klotz wird mit langsam wachsender Kraft $F$ gezogen; die Unterlage wirkt mit $vN$ und $vF_R$. ($vN$ greift etwas vor dem Schwerpunkt an, weil $vF$ und $vF_R$ ein kleines Kippmoment bilden.) Rechts: die gemessene Reibungskraft. Solange der Klotz haftet, ist $F_R = F$ (die Gerade); bei $mu_0 N$ reisst er los, danach wirkt die kleinere Gleitreibungskraft $mu_1 N$.])

Für das Prinzip der virtuellen Leistungen ist wichtig: Die Normalkräfte leisten bei zulässigen virtuellen Bewegungen nichts (sie stehen senkrecht), die Reibungskräfte (in der Tangentialebene) schon.

Zum Experiment: Man verändert das Gewicht $G$ des Klotzes durch Standardgewichte, erhöht $F$ langsam bis zum Losreissen und hält dann die Geschwindigkeit konstant. Weil in der Ruhelage und bei gleichförmiger Translation die äusseren Kräfte im Gleichgewicht sein müssen, ist $vF_R = -vF$ und $N = G$. Die Vorzeichen von $F_R$ und $F$ sind also immer verschieden. Die Messungen lassen sich damit als Aussagen über $F_R$, $v$ und $|vN|$ lesen und auf beliebige Geometrien verallgemeinern.

Die erste Feststellung: Die Funktion $F_R(v)$ ist in erster Näherung _proportional zum Normalkraftbetrag_. Der Quotient $f(v) = F_R(v)\/|N|$ hat für alle $|N|$ denselben Graphen. Seine qualitative Gestalt (Stahl auf Stahl, Aluminium auf Stahl, Gummi auf Asphalt) zeigt: Der Körper setzt sich in Bewegung, sobald $|f|$ den Grenzwert $mu_0$ erreicht, dann nimmt $|f|$ mit wachsender Schnelligkeit ab bis zum stationären Wert $mu_1$. Beide Zahlen hängen von der Materialpaarung und den Schmierverhältnissen ab. Wir vereinfachen diesen Übergang zu einem Sprung von $mu_0$ auf $mu_1$ (das Bild oben) und bekommen Haft- und Gleitreibungsgesetz.

#defn[Haft- und Gleitreibungszahl][
  Der Grenzwert $mu_0$ des Verhältnisses $|F_R| \/ |N|$, bei dem das Gleiten einsetzt, heisst *Haftreibungszahl*. Der Wert $mu_1$ dieses Verhältnisses beim Gleiten heisst *Gleitreibungszahl*. Beide hängen im Wesentlichen nur von der Materialpaarung und dem Zustand der Oberflächen ab, kaum von der Grösse der Berührungsfläche. In der Regel ist $mu_1 < mu_0$.
]

Typische Grössenordnungen für $mu_0$: Stahl auf Stahl trocken $0.15$ bis $0.3$ (geschmiert etwa $0.1$), Holz auf Holz $0.4$ bis $0.6$, Gummi auf trockenem Asphalt etwa $0.8$, Stahl auf Eis etwa $0.03$. Die Werte streuen stark mit Oberflächenzustand, Feuchtigkeit und Temperatur; zwei Stellen Genauigkeit sind meist schon zu viel.

== Haftreibung

#satz[Haftreibungsgesetz][
  Solange zwei Körper aneinander haften (Geschwindigkeit des materiellen Berührungspunkts relativ zur Unterlage null), gilt
  #gl($ |vF_R| <= mu_0 |vN|. $)
]

#merke[
  Das Haftreibungsgesetz ist eine *Ungleichung*. Es sagt _nicht_, wie gross die Haftreibungskraft ist, nur, wie gross sie höchstens werden kann. Die Haftreibungskraft ist eine Bindungskraft wie jede Lagerkraft: Betrag und Richtung folgen aus den *Gleichgewichtsbedingungen*. Die Ungleichung prüft man erst _danach_. Nur an der Haftgrenze (das System beginnt gerade zu rutschen) gilt das Gleichheitszeichen.
]

Genauer: Haftreibungsgesetz heisst, dass an den materiellen Berührungspunkten die Relativgeschwindigkeit $vv = bold(0)$ bleibt, solange die Haftbedingung erfüllt ist. In einer Bindung mit Haftreibung führt man deshalb zuerst eine Haftreibungskraft (oder ein Haftreibungsmoment) von unbekanntem Betrag und unbekannter Richtung ein. Bei einem statisch bestimmten System liefern die Gleichgewichtsbedingungen $F_R$ und $N$; diese Werte setzt man dann bei der Diskussion der Resultate (Schritt 8 des Rezepts aus Kapitel 9) in die Ungleichung ein, um zu entscheiden, ob das System überhaupt in Ruhe sein kann.

#merke[
  In der Umgangssprache sagt man «das Rad rutscht, weil die Reibung zu klein ist». Gemeint ist _nicht_, dass der Betrag $|F_R|$ zu klein wäre. Im Gegenteil: Je grösser $|F_R|$ ist, desto schwerer ist die Haftbedingung zu erfüllen. Gemeint ist, dass $mu_0$ (genauer, das Verhältnis $|F_R|\/N$, das die Situation erzwingt) zu klein für die Aufgabe ist.
]

#rezept[Aufgaben mit Haftreibung][
  + Freischneiden. An jeder rauen Kontaktstelle $N$ *und* $F_R$ als Unbekannte eintragen (Richtung von $F_R$ annehmen).
  + $N$ und $F_R$ aus den Gleichgewichtsbedingungen bestimmen.
  + Haftbedingung $|F_R| <= mu_0 N$ einsetzen. Das Ergebnis ist ein *Bereich* für die gesuchte Grösse (einen Winkel, eine Kraft, eine Reibungszahl).
  + Ausserdem prüfen: $N >= 0$ (kein Abheben) und Standfestigkeit (kein Kippen).
]

#fg("k12_ebene", [Links der Klotz auf der schiefen Ebene. Rechts der Reibungskegel: Die gesamte Kontaktkraft $vR = vN + vF_R$ darf höchstens um den Haftreibungswinkel $rho_0$ gegen die Normale geneigt sein.])

#bsp[Klotz auf schiefer Ebene][
  Gleichgewicht längs und quer zur Ebene: $F_R = G sin alpha$, $N = G cos alpha$. Haftbedingung: $G sin alpha <= mu_0 G cos alpha$, also
  $ tan alpha <= mu_0. $
  Das Gewicht fällt heraus: Ob ein Körper rutscht, hängt nur vom Winkel und von $mu_0$ ab. Den Grenzwinkel $rho_0$ mit $tan rho_0 = mu_0$ nennt man *Haftreibungswinkel*. So misst man $mu_0$: die Ebene langsam neigen, bis der Körper losrutscht, und den Winkel ablesen.
]

#intu[
  Die gesamte Kontaktkraft $vN + vF_R$ kann gegenüber der Flächennormalen höchstens um $rho_0$ geneigt sein. Alle möglichen Richtungen bilden einen Kegel um die Normale, den *Reibungskegel* (rechts in der Abbildung). Solange die Resultierende der übrigen Kräfte innerhalb dieses Kegels auf die Fläche drückt, haftet der Körper, egal wie gross sie ist. Deshalb hält ein Keil, und deshalb rutscht eine flach genug geneigte Schraube nicht von selbst auf (Selbsthemmung).
]

#bsp[Rollendes Antriebsrad][
  Ein Rad (Radius $R$) rollt gleichförmig, etwa der Radsatz einer Lokomotive, die einen Wagenzug zieht. Dann sind $omega$ und damit $v_O = omega R$ konstant, nach der Bemerkung in Kapitel 8 müssen die Gleichgewichtsbedingungen erfüllt sein. Die Horizontalkomponente $F$ der Lagerkraft in $O$ (der Widerstand des Wagenzugs) ist entgegengesetzt zu $vv_O$ gerichtet und gleich gross wie die Reibungskraft $F_R$. Das Kräftepaar aus $F$ in $O$ und $F_R$ im Berührungspunkt $Z$ muss mit dem Antriebsmoment $M_A$ im Gleichgewicht sein: $M_A = R F_R$. Die Haftreibungskraft zeigt dabei in Fahrtrichtung. Trotzdem ist sie _leistungslos_, weil ihr Angriffspunkt das Momentanzentrum $Z$ ist, dessen Geschwindigkeit null ist. Die Widerstandskraft $F$ leistet mit $vv_O$ negative Leistung, und das Antriebsmoment bringt die gleich grosse positive Leistung auf. Aus der Haftbedingung $F_R <= mu_0 N$ folgt
  $ M_A <= R mu_0 |N| quad "bzw." quad F = F_R <= mu_0 |N|. $
  Erhöht man das Antriebsmoment über diese Grenze hinaus, dreht das Rad durch. Für die Lokomotive zählt die zweite Form: Die grösste _Zugkraft_ ist $mu_0 N$ und hängt nicht vom Raddurchmesser ab (ein grösseres Rad braucht nur ein grösseres Moment für dieselbe Zugkraft). Mehr Zugkraft gibt es nur mit einer grösseren Haftreibungszahl (Sand streuen) oder einer grösseren Achslast. Deshalb sind Lokomotiven schwer.
]

#bsp[Zwei Stäbe mit Reibung][
  Zwei gewichtslose Stäbe sind in den reibungsfreien Gelenken $A$ und $B$ gelagert und berühren sich in $C$ (Haftreibungszahl $mu_0$); der eine trägt eine vertikale Last $G$, der andere eine horizontale Last $F$. In welchem Bereich darf $F$ liegen, damit das System in Ruhe bleibt? Man trennt das System, damit Normalkraft und Reibungskraft in $C$ für jeden Stab als äussere Kräfte erscheinen. Die Richtung der Normalkraft steht wegen der einseitigen Bindung fest, die der Reibungskraft nicht: Erst das Vorzeichen von $F_R$ aus dem Gleichgewicht verrät sie. $F_R > 0$ entspricht einer Gleitgefahr wegen zu grossem $G$, $F_R < 0$ einer Gleitgefahr wegen zu grossem $F$. Die Haftbedingung $|F_R| <= mu_0 N$ deckt beide Fälle ab und liefert zwei Ungleichungen, die zusammen einen _Bereich_ für $F$ ergeben: eine untere und eine obere Grenze, beide aus $mu_0$ und $G$ berechnet. Zu kleines $F$ lässt den Stab wegen $G$ abrutschen, zu grosses in die andere Richtung. Mit Zahlen ist das Beispiel in den Aufgaben am Kapitelende durchgerechnet.
]

#fg("k12_leiter", [Leiter an einer glatten Wand auf rauem Boden.])

#bsp[Leiter an der Wand][
  Homogene Leiter (Gewicht $G$, Länge $L$, Winkel $alpha$ zum Boden), Wand glatt, Boden rau. Unbekannt: $N_A, F_R$ (Boden), $N_B$ (Wand).
  $ sum Y: quad N_A = G, wide sum X: quad F_R = N_B, wide sum M_A: quad N_B L sin alpha - G (L/2) cos alpha = 0. $
  Also $N_B = G\/(2 tan alpha)$ und damit $F_R = G\/(2 tan alpha)$. Haftbedingung $F_R <= mu_0 N_A$:
  $ tan alpha >= 1 / (2 mu_0). $
  Die Leiter muss steil genug stehen. Für $mu_0 = 0.5$ mindestens $45°$. Steigt eine Person (Gewicht $Q$) hinauf, wächst $N_B$ mit ihrer Höhe, $N_A$ aber nur um $Q$: Die Haftbedingung wird mit jeder Sprosse knapper. Eine Leiter, die leer sicher steht, kann deshalb rutschen, wenn man oben steht.
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

Das Gleitreibungsgesetz geht auf Ansätze von Coulomb (1736 bis 1806) und Morin (1795 bis 1880) zurück. Verlangen die Gleichgewichtsbedingungen (oder in der Dynamik die Bewegungsgleichungen) Lagerkraftkomponenten, die der Haftbedingung nicht genügen, tritt Gleiten ein. Probleme mit Gleitreibung gehören naturgemäss schon in die Dynamik; in der Statik braucht man das Gesetz, wenn man zum Beispiel eine Bremse im Gleichgewicht mit gleichförmig bewegten Teilen betrachtet.

In der Statik tritt Gleitreibung dann auf, wenn ein Körper gleichförmig gleitet oder gleichförmig um eine feste Symmetrieachse dreht: Dann sind die äusseren Kräfte im Gleichgewicht (Kapitel 8), obwohl sich etwas bewegt. Das Gleitreibungsgesetz liefert, im Gegensatz zum Haftreibungsgesetz, eine zusätzliche _Gleichung_. Bei gut geschmierten Flächen mit einem Schmierfilm braucht man für eine genaue Behandlung die Strömungsmechanik; unser Gesetz gilt für trockene Reibung (ungefettete oder nur mässig gefettete Flächen).

#bsp[Schleifscheibe][
  Ein Messer wird an einer Schleifscheibe (Radius $R$) geschliffen, die mit konstanter Rotationsgeschwindigkeit um ihr Lager dreht. Ist die Normalkraft $N$ auf das Messer bekannt, folgt die Reibungskraft am Umfang aus $F_R = mu_1 N$ (gegen die Bewegung gerichtet), und die Momentenbedingung um das Lager liefert das nötige Antriebsmoment $M = R F_R = mu_1 N R$. Das ist der Preis des Schleifens.
]

#ohnewoche[Dieser Abschnitt steht nicht im Wochenplan der Vorlesung (Buch S. 175–180).]
== Gelenk- und Lagerreibung

In einem wirklichen Gelenk reibt der Zapfen (Radius $r_L$) in der Bohrung. Die Reibungskräfte am Zapfenumfang ergeben ein *Reibungsmoment* um die Gelenkachse. Mit der Gelenkkraft $vZ$ (die Kraft, mit der der Zapfen in die Bohrung gedrückt wird) gilt
#gl($ "Haften:" quad |M_R| <= mu_0 r_L |vZ|, wide "Gleiten:" quad |M_R| = mu_1 r_L |vZ|, $)
beim Gleiten der relativen Drehung entgegengesetzt. Ein raues Gelenk in Ruhe kann also, anders als das ideale, ein begrenztes Moment übertragen. Dieselben Formeln gelten für kurze und lange Querlager von Wellen. Für ein Längslager gilt etwas anderes, siehe unten.

Wie entsteht das Reibungsmoment im Gelenk? Bei reibungsfreier Berührung geht die Wirkungslinie der Zapfenkraft durch die Gelenkmitte $O$. Mit Reibung besteht die Zapfenkraft $vZ$ aus zwei Komponenten $vN$ und $vF_R$, von denen nur $vN$ durch die Gelenkmitte geht. Für die Reduktion auf $O$ (ebenes Problem) entsteht neben der Kraft ${O | vZ}$ ein Kräftepaar mit dem Moment $M_R = r_L F_R$ ($r_L$ Lagerradius): das *Reibungsmoment*. Ohne Bewegung zwischen Zapfen und Buchse ist es eine zusätzliche Unbekannte, die man aus dem Gleichgewicht bestimmt. Beispiel: Ein homogener Balken ist in $A$ in einem rauen Gelenk festgehalten und in $B$ reibungsfrei aufgelegt. Unbekannt sind $A_x, A_y, B_y, M_R$; die Komponentenbedingung in horizontaler Richtung zeigt $A_x = 0$, die zwei restlichen Gleichungen reichen für drei Unbekannte ($A_y, B_y, M_R$) nicht aus. Man bekommt nur den _Bereich_ von $M_R$, den die Haftbedingung erlaubt.

Die Haftbedingung $|F_R| <= mu_0 N$ wird mit $r_L$ multipliziert und gibt links das Reibungsmoment. Rechts steht aber die unbekannte Normalkraft $N$, denn man kann $vZ$ nicht eindeutig in $N$ und $F_R$ zerlegen, solange der Berührungspunkt unbekannt ist. Exakt gilt an der Haftgrenze $F_R = mu_0 N$, also $|vZ| = N sqrt(1 + mu_0^2)$ und
$ |M_R| <= r_L |vZ| sin rho_0 = r_L |vZ| mu_0 / sqrt(1 + mu_0^2) quad (tan rho_0 = mu_0). $
Geometrisch: Die Wirkungslinie der Zapfenkraft berührt höchstens den *Reibungskreis* mit dem Radius $r_L sin rho_0$ um die Gelenkmitte. Für kleine $mu_0$ ist $sin rho_0 approx mu_0$, und man benutzt die einfachere Form $|M_R| <= mu_0 r_L |vZ|$ von oben. Sie überschätzt das zulässige Moment um höchstens den Faktor $sqrt(1 + mu_0^2)$, für $mu_0 = 0.5$ um etwa 12 %; das liegt innerhalb der Streuung der Messwerte von $mu_0$.

#bsp[Zwei Stäbe in einem rauen Gelenk][
  Zwei Stäbe der Länge $L$, jeder mit Gewicht $G$, sind in $C$ durch ein raues Gelenk (Lagerradius $r_L$) verbunden; $A$ ist reibungsfrei gelagert, $B$ ein horizontal verschiebbares Auflager, in $B$ wirkt die horizontale Stützkraft $F$. Am Gesamtsystem fallen die Kräfte und Momente in $C$ heraus (sie sind innere Kräfte): $A_y = G$, $A_x = F$, $B_y = G$. Um das zulässige Intervall für $F$ zu finden, trennt man in $C$. Aus der Momentenbedingung um $C$ für einen Stab folgt das Reibungsmoment $M_R$; die Zapfenkraft in $C$ hat den Betrag $F$. Die Haftbedingung $|M_R| <= mu_0 r_L F$ liefert je nach Vorzeichen von $M_R$ zwei Ungleichungen, die zusammen das zulässige Intervall für $F$ geben.
]

Für ein Längslager lässt sich eine genauere Formel herleiten. Eine Welle vom Radius $R$ liege gleichmässig auf. Das Flächenelement $dif A = r dif r dif phi$ trägt die Normalkraft $dif N = N dif A\/(pi R^2)$ und die tangentiale Reibungskraft $|dif F_R| = mu_1 dif N$ im Abstand $r$ von der Achse. Aufsummiert (integriert) ergibt sich das Reibungsmoment $M_R = integral r dif F_R = (mu_1 N \/ (pi R^2)) integral_0^R r^2 dif r integral_0^(2 pi) dif phi = (2\/3) mu_1 R N$. Das ist weniger als $mu_1 R N$, weil die Reibungskräfte im Mittel näher an der Achse angreifen als am Rand.

#woche(12, [Reibung, Statik (Fortsetzung)], [180–185])
== Rollreibung

Ein starres Rad auf starrer, schiefer Ebene: Die Momentenbedingung um den Berührungspunkt $Z$ enthält nur das Gewicht (Hebelarm $R sin alpha$) und kann für $alpha != 0$ nie erfüllt sein. Nach diesem Modell würde jedes Rad schon bei der kleinsten Neigung losrollen. Die Erfahrung zeigt etwas anderes.

Die Auflösung: Rad und Unterlage verformen sich an der Berührungsstelle ein wenig. Die Normalkräfte sind über eine kleine Fläche verteilt, und ihre Resultierende greift nicht genau in $Z$ an, sondern um eine kleine Strecke $e$ in Rollrichtung versetzt. Das ergibt ein *Rollreibungsmoment* $M_R = e |vN|$.

#fg("k12_roll", [Rollreibung. Rad und Unterlage verformen sich; die Normalkraft greift um $e$ vor $Z$ (in Rollrichtung) an. Das ist statisch äquivalent mit einer Normalkraft in $Z$ plus einem Moment $M_R = e N$, das dem Rollen entgegenwirkt.])

#satz[Rollreibungsgesetz][
  #gl($ "Ruhe:" quad |M_R| <= mu_2 |vN|, wide "Rollen:" quad |M_R| = mu_2 |vN|. $)
  $mu_2$ heisst *Rollreibungslänge*. Sie ist, anders als $mu_0, mu_1$, keine reine Zahl, sondern eine *Länge* (typisch Bruchteile eines Millimeters für Stahl auf Stahl).
]

#bsp[Rad auf schiefer Ebene][
  Gleichgewicht: $F_R = G sin alpha$, $N = G cos alpha$, $M_R = R G sin alpha$. Damit das Rad ruht, müssen *beide* Bedingungen gelten:
  $ "nicht gleiten:" quad tan alpha <= mu_0, wide "nicht rollen:" quad tan alpha <= mu_2 / R. $
  Weil $mu_2 \/ R$ fast immer viel kleiner ist als $mu_0$, beginnt das Rad zu rollen, lange bevor es rutschen würde. Darum hat man das Rad erfunden.

  Zur Grössenordnung: Bei einem Autoreifen ($R approx 0.3$ m) ist der Rollwiderstandsbeiwert $mu_2\/R approx 0.01$, also $mu_2 approx 3$ mm, nur ein kleiner Bruchteil der Aufstandslänge von gut $10$ cm. Ein Auto mit gelöster Bremse rollt deshalb schon ab einer Neigung von etwa $arctan 0.01 approx 0.6°$ los; rutschen würde es erst bei $tan alpha = mu_0 approx 0.8$, also bei fast $40°$. Beim Eisenbahnrad (Stahl auf Stahl, $R approx 0.5$ m, $mu_2 approx 0.5$ mm) ist $mu_2\/R approx 0.001$: Darum braucht ein Güterzug so wenig Zugkraft.
]

#fehler[
  - $F_R = mu_0 N$ als Gleichung hinschreiben, obwohl nur Haften vorliegt. Gleichheit gilt nur an der Haftgrenze.
  - Die Richtung der Reibungskraft falsch annehmen und dann mit Beträgen weiterrechnen. Beim Haften Richtung annehmen und das Vorzeichen ernst nehmen; beim Gleiten gegen die Relativgeschwindigkeit.
  - Bei mehreren Kontaktstellen annehmen, alle seien gleichzeitig an der Haftgrenze. Das muss nicht so sein.
  - Vergessen, auch das Kippen zu prüfen: Ein hoher Klotz kippt, bevor er rutscht.
]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Haftreibung und ABS.* Ein Reifen haftet auf trockener Strasse mit $mu_0 approx 0.8$ bis $1$, auf nasser Fahrbahn mit etwa $0.5$ und auf Eis nur mit etwa $0.1$. Beim Notbremsen ist die grösste Verzögerung $a = mu_0 g$, bei Eis also gerade mal $1$ m/s². Rutscht der Reifen, wird aus Haft- Gleitreibung, die kleiner ist, und das Auto lässt sich nicht mehr lenken. Genau das verhindert das ABS: Es bremst so, dass der Reifen gerade noch haftet, und regelt dazu bis zu etwa zwanzigmal pro Sekunde nach.]

#alltag[*Seilreibung: ein Segler hält ein Schiff.* Wickelt man ein Seil mit dem Winkel $alpha$ um einen Poller, gilt $S_1 = S_2 e^(mu alpha)$ (Euler-Eytelwein). Bei $mu = 0.3$ und drei vollen Windungen ($alpha = 6 pi$) ergibt das $e^(0.3 dot 6 pi) approx 286$: Mit $100$ N Handkraft hält man $28.6$ kN, das sind $2.9$ Tonnen! So legen Segler ihre Boote an, so sichern Kletterer mit einem Seil, das über einen Karabiner umgelenkt wird, und so hält die Saite am Wirbel einer Gitarre.]

#photo(("m_bremse",), [Scheibenbremse am Fahrrad: Der Belag wird gegen die Scheibe gepresst, die Reibkraft $F_R = mu N$ bremst das Rad. #credit[Alextredz, CC BY-SA 4.0, Wikimedia Commons]], ht: 5cm)
// ALLTAG-END

#aufgaben()

#aufg(fig: "a12_schrank", fw: 5.4cm)[Schrank schieben: Kippen oder Gleiten?][
  Ein Schrank (Breite $b$, Gewicht $G$, Schwerpunkt in der Mitte) steht auf einem Parkettboden (Haftreibungszahl $mu_0$). In der Höhe $y$ drückt man horizontal mit der Kraft $F$.

  Was passiert zuerst, wenn man $F$ steigert: Kippt der Schrank oder gleitet er?
][
  _Gleichgewicht in der Ruhe._ $N = G$, $F_R = F$. Die Normalkraft greift um $e$ neben der Mitte an; Momente um die Mitte der Standfläche: $N e = F y$, also $e = F y \/ G$.

  _Zwei Bedingungen für die Ruhe._
  - Nicht kippen: $vN$ muss in der Standfläche bleiben, $e < b\/2$, also $F\/G < b\/(2y)$.
  - Nicht gleiten: $F_R < mu_0 N$, also $F\/G < mu_0$.

  _Welche Grenze kommt zuerst?_ Die kleinere:
  $ y > b/(2 mu_0): quad "Kippen vor Gleiten", wide y < b/(2 mu_0): quad "Gleiten vor Kippen". $
  Mit $mu_0 = 1\/2$ (Metall auf Holz) gleitet der Schrank, solange man tiefer als $y = b$ angreift. Wer einen Schrank verschieben will, drückt deshalb unten.
]

#aufg(fig: "a12_scheibe", fw: 6cm)[Kreisscheibe mit Bremskraft][
  Eine Kreisscheibe (Radius $r$, Gewicht $G$) bewegt sich gleichförmig eine schiefe Ebene (Neigung $phi$) hinunter. Am höchsten Punkt, dem Kontaktpunkt gegenüber, wirkt tangential die Bremskraft $F_B$ (parallel zur Ebene, bergwärts).

  + Die Scheibe rollt gleichförmig, ohne zu gleiten. Wie gross sind $F_B$ und $F_R$, und für welche $phi$ ist das möglich?
  + Die Scheibe gleitet gleichförmig, ohne sich zu drehen. Für welches $phi$?
][
  Bei gleichförmiger Bewegung sind die Gleichgewichtsbedingungen erfüllt. In beiden Fällen gilt
  $ N = G cos phi, wide F_R + F_B = G sin phi, wide M_O: thick F_B r - F_R r = 0, $
  also $F_B = F_R = 1/2 G sin phi$.

  _1. Rollen._ Der Kontaktpunkt haftet, es gilt das Haftreibungsgesetz als Ungleichung:
  $ F_R < mu_0 N quad => quad 1/2 G sin phi < mu_0 G cos phi quad => quad tan phi < 2 mu_0. $

  _2. Gleiten._ Am Kontakt gilt das Gleitreibungsgesetz als Gleichung, $F_R = mu_1 N = mu_1 G cos phi$. Mit $F_R = 1/2 G sin phi$:
  $ tan phi = 2 mu_1. $

  _Bemerkung._ Wegen $mu_0 > mu_1$ ist der Grenzwinkel für das Haften grösser als der Winkel für gleichförmiges Gleiten. Überschreitet man die Haftgrenze, sinkt die Reibungskraft sprunghaft, und die Scheibe wird beschleunigt.
]

#aufg(fig: "a12_staebe", fw: 5.4cm)[Zwei Stäbe mit rauem Kontakt][
  Der Stab $A D$ (Länge $2L$, unter 60°) ist in $A$ gelenkig gelagert und trägt in $D$ die Last $G$. Der Stab $C B$ (Länge $L$) ist in $B$ gelenkig gelagert ($overline(A B) = L$) und stützt den ersten Stab in dessen Mitte $C$ ab; der Kontakt ist rau (Haftreibungszahl $mu_0$). In der Mitte von $C B$ wirkt die horizontale Kraft $F$ nach links. Die Stäbe sind gewichtslos.

  In welchem Bereich muss $F$ liegen, damit das System in Ruhe bleibt?
][
  _Trennen in $C$._ Erst dann erscheinen die Kontaktkräfte: die Normalkraft $N$ senkrecht zu $A D$ und die Reibungskraft $F_R$ längs $A D$ (positiv gezählt, wenn sie am Stab $C B$ nach unten wirkt).

  _Stab $A D$, Momente um $A$._ $G$ hat den Hebelarm $2 L cos 60° = L$, $N$ den Hebelarm $L$, $F_R$ geht durch $A$:
  $ N L - G L = 0 quad => quad N = G. $

  _Stab $C B$, Momente um $B$._ Das Dreieck $A B C$ ist gleichseitig. $F$ hat den Hebelarm $sqrt(3)/2 dot L/2$, $F_R$ den Hebelarm $sqrt(3)/2 L$ (Abstand von $B$ zur Geraden $A D$), $N$ den Hebelarm $L\/2$:
  $ sqrt(3)/2 dot L/2 dot F + sqrt(3)/2 L F_R - N L/2 = 0 quad => quad F_R = sqrt(3)/3 G - 1/2 F. $

  _Haftbedingung._ $|F_R| < mu_0 N = mu_0 G$ deckt beide Rutschrichtungen ab:
  $ (2 sqrt(3))/3 G - 2 mu_0 G < F < (2 sqrt(3))/3 G + 2 mu_0 G. $
  Bei $F = (2 sqrt(3))\/3 dot G$ ist keine Reibung nötig. Ist $F$ kleiner, rutscht $C$ wegen $G$ ab ($F_R > 0$); ist $F$ grösser, schiebt $F$ den Stab in die andere Richtung ($F_R < 0$). Die Reibung macht aus dem einen Gleichgewichtswert einen ganzen Bereich.
]

#kurz[
  - Haften: $|F_R| <= mu_0 N$, Ungleichung; $F_R$ aus dem Gleichgewicht.
  - Gleiten: $F_R = mu_1 N$, gegen die Bewegung.
  - Schiefe Ebene: Haften für $tan alpha <= mu_0$. Reibungskegel mit Öffnungswinkel $rho_0$, $tan rho_0 = mu_0$.
  - Gelenk: $|M_R| <= mu_0 r_L |Z|$ bzw. $= mu_1 r_L |Z|$.
  - Rollen: $|M_R| <= mu_2 N$ mit der Rollreibungslänge $mu_2$.
]
