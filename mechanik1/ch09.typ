#import "lib.typ": *

= Lagerbindungen und Lagerkräfte

Lager sind die äußeren Bindungen von Trägern, Wellen und Tragwerken. Dieses Kapitel ist das handwerkliche Herz der Statik: Lager erkennen, Lagerkräfte einzeichnen, Gleichgewicht ansetzen, auflösen. Nach dem letzten Kapitel wissen wir _warum_ das funktioniert; jetzt üben wir _wie_.

== Körper auf ebener Unterlage, Standfestigkeit

Eine reibungsfreie Unterlage drückt mit verteilten Normalkräften auf die Berührungsfläche. Sie sind alle parallel und gleich gerichtet: Die Unterlage kann nur drücken, nicht ziehen. Ihre äquivalente Einzelkraft $vN$ (Kapitel 7: Kräftemittelpunkt) muss deshalb *innerhalb der Standfläche* angreifen, genauer: innerhalb der kleinsten konvexen Fläche, die alle Berührungspunkte umschließt.

#defn[Standfestigkeit][
  Ein Körper auf einer Unterlage heißt *standfest*, wenn er nicht kippt. Das ist genau dann der Fall, wenn die Wirkungslinie der Resultierenden aller übrigen Kräfte (Gewicht, Lasten) die Standfläche durchstößt. Geht sie durch den Rand, steht der Körper an der Kippgrenze.
]

#warum[Warum $vN$ innerhalb der Standfläche angreift][
  Betrachte eine beliebige Tangente an die Randkurve der Standfläche. Die Momente aller infinitesimalen Normalkräfte $dif vN$ bezüglich dieser Tangente haben dasselbe Vorzeichen, denn alle Berührungspunkte liegen auf derselben Seite der Tangente und alle Kräfte zeigen gleich (nach oben). Wegen der statischen Äquivalenz muss auch das Moment der Resultierenden $vN$ dieses Vorzeichen haben. Also liegt ihr Angriffspunkt $P$ auf derselben Seite jeder solchen Tangente wie die Berührungspunkte, das heißt innerhalb der Standfläche. Liefert die Rechnung einen Angriffspunkt außerhalb, ist das ein Widerspruch: Der Kontakt kommt in dieser Form nicht zustande, der Körper kippt.
]

#bsp[Tisch mit seitlicher Kraft][
  Ein dreibeiniger Tisch steht auf einer rauen Ebene. Ohne Last ist seine Standfläche das Dreieck durch die drei Beinenden, und er ist standfest, solange der Schwerpunkt $S$ vertikal darüber liegt (Gewicht und Normalkraft müssen dieselbe Wirkungslinie haben). Nun greife in der Höhe $h$ über dem Boden zusätzlich eine horizontale Kraft $K$ an. Die Unterlage liefert die Normalkraft $N$ und die Reibungskraft $F_R$ (Angriffspunkt $P$). Komponentenbedingungen: $F_R = K$ und $N = G$. Die Momentenbedingung um $S$ verschiebt den Angriffspunkt von $N$ um $x = K h\/G$ gegenüber der Lotrechten durch $S$. Der Tisch kippt nicht, solange $P$ in der Standfläche bleibt, also für $x <= a$ (mit $a$ dem Abstand von $S$ zur Kippkante): $K <= G a\/h$. Außerdem muss die Reibung halten, $F_R <= mu_0 N$, also $K <= mu_0 G$. Die kleinere der beiden Grenzen entscheidet, ob der Tisch zuerst kippt oder gleitet.
]

#fg("k09_standfest", [Die Normalkraft liegt immer genau gegenüber der Resultierenden aus Gewicht und Last. Je stärker man seitlich drückt, desto weiter wandert $vN$ zum Rand. Erreicht sie die Kante, kippt der Körper.])

#intu[
  Eine Kiste, die du seitlich anschiebst, drückt ihre Last immer stärker auf die vordere Kante. Die Unterlage kann nur dort drücken, wo Kontakt ist, also muss die Gegenkraft $vN$ nach vorne wandern, um das Kippmoment aufzufangen. Wenn sie die Kante erreicht, ist kein Platz mehr, und die Kiste kippt.
]

== Lagertypen

Für jedes Lager gilt die Regel aus Kapitel 8: *verhinderte Bewegung $<->$ Kraftkomponente*. Für ebene Probleme (alle Kräfte in der Zeichenebene) genügt diese Übersicht.

#fg("k09_lager", [Die vier wichtigsten Lager für ebene Probleme. Oben das Lager mit Symbol, unten der Träger «freigeschnitten» mit den Lagerkräften, die das Lager auf ihn ausübt. Die Zahl der Unbekannten entspricht der Zahl der verhinderten Bewegungsmöglichkeiten.])

#table(columns: (auto, 1fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [*Loslager* (Auflager)], [verhindert die Verschiebung senkrecht zur Unterlage. Die Unterlage kann nur drücken (einseitig). *1 Unbekannte*.],
  [*Festlager* (Gelenk)], [verhindert beide Verschiebungen, die Drehung bleibt frei: kein Moment. *2 Unbekannte*.],
  [*Einspannung*], [verhindert alle Bewegungen des Trägerquerschnitts: zwei Verschiebungen und die Drehung. *3 Unbekannte* (2 Kräfte, 1 Moment).],
  [*Pendelstütze*, Seil], [ein Stab mit zwei Gelenken: verhindert die Verschiebung in Stabrichtung. *1 Unbekannte* längs des Stabs (beim Seil nur Zug).],
  table.hline(stroke: 0.7pt),
)

Im Raum zählt man genauso:

#table(columns: (auto, 1fr, auto), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [*Lager (räumlich)*], [*verhindert*], [*Unbekannte*],
  table.hline(stroke: 0.4pt),
  [kurzes Querlager], [Verschiebungen quer zur Wellenachse; Achsverschiebung und alle Drehungen frei], [2 Kräfte],
  [Längslager], [Verschiebung in Achsrichtung (oft einseitig)], [1 Kraft],
  [langes Querlager], [Querverschiebungen und Schiefstellung der Achse], [2 Kräfte, 2 Momente],
  [Kugelgelenk], [alle drei Verschiebungen, alle Drehungen frei], [3 Kräfte],
  [Zylindergelenk (Scharnier)], [alles außer der Drehung um die Zapfenachse], [3 Kräfte, 2 Momente],
  [Einspannung], [alles], [3 Kräfte, 3 Momente],
  table.hline(stroke: 0.7pt),
)

Etwas mehr zu den einzelnen Lagern:

*Auflager.* Es wirkt einseitig und verhindert die Bewegung der Berührungspunkte des Trägers in eine Halbebene; die Auflagerkraft zeigt gegen den anderen Halbraum. Bei reibungsfreier Auflage steht sie senkrecht zur Trägerachse. Beispiel: Ein Träger auf zwei Auflagern $A$, $B$ trage vertikale Lasten $F_1$ (im Abstand $a_1$ von $A$) und $F_2$ (im Abstand $a_2$ von $A$; die Auflager haben den Abstand $L$). Die Momentenbedingungen liefern $B_y = (F_1 a_1 + F_2 a_2)\/L$ und $A_y = (F_1 (L - a_1) + F_2 (L - a_2))\/L$. Wegen der einseitigen Bindung dürfen $A_y, B_y$ nicht negativ werden. Liegt $F_2$ weit hinter $B$ ($a_2 > L$), kann $A_y$ negativ werden: Dann hebt der Träger bei $A$ ab und bleibt in dieser Lage nicht in Ruhe. Aus $A_y >= 0$ folgt $F_2 (a_2 - L) <= F_1 (L - a_1)$.

*Kurzes Querlager* (schmales Ringlager oder Kugellager). Es verhindert die Quertranslation eines Querschnitts senkrecht zur Trägerachse, lässt aber die Längsverschiebung, Kippdrehungen um Querachsen und (bei Rundquerschnitt) die Eigendrehung zu. Reibungsfrei hat die Lagerkraft zwei Komponenten senkrecht zur Achse, deren Richtungssinn sich je nach Belastung einstellt. Zeichnet man eine Komponente in positiver Richtung ein und die Rechnung liefert ein _negatives_ Vorzeichen, so wirkt sie in Wirklichkeit in der Gegenrichtung. Das ist kein Fehler, sondern die Antwort.

*Längslager.* Es verhindert die Verschiebung in Achsrichtung, einseitig ($A >= 0$) oder (zum Beispiel bei einem Kugellager mit beidseitigem Anschlag) in beiden Richtungen.

*Langes Querlager* (breites Gleitlager, Rolllager). Es verhindert auch die Kippdrehungen. Die Lagerdyname besteht dann nicht nur aus einer Kraft, sondern auch aus einem Kräftepaar. Ist es reibungsfrei, hat die Lagerkraft keine Komponente in Achsrichtung.

*Einspannung.* Sie verhindert alle Bewegungen des Querschnitts. Die Lagerdyname besteht aus der Einspannkraft und dem Einspannmoment. In einem ebenen Problem sind das drei Unbekannte (zwei Kraftkomponenten und ein Moment), im räumlichen sechs.

*Kugelgelenk.* Es verhindert die drei Verschiebungen und lässt alle Drehungen (Kreiselung) zu. *Zylindergelenk:* Es lässt die Drehung um die Zapfenachse und eventuell eine Verschiebung längs der Achse zu und verhindert alles andere. Bei einem ebenen System mit der Kräfteebene senkrecht zur Zapfenachse übt es nur eine Kraft und kein Moment aus.

#warum[Die Zapfenkraft geht durch die Gelenkmitte][
  Zeichnet man das Spiel zwischen Zapfen und Bohrung übertrieben, sieht man, dass die Berührungsstelle $B$ zunächst unbekannt ist. Bei reibungsfreiem Gelenk muss die Zapfenkraft aber längs der gemeinsamen Normalen im Berührungspunkt wirken. Diese Normale geht durch den Mittelpunkt des Zapfens. Also geht die Wirkungslinie der Zapfenkraft durch die Gelenkmitte, ihr Betrag und ihre Richtung ergeben sich erst aus dem Gleichgewicht.
]

#intu[
  Frag bei jedem Lager: «Wenn ich hier anfasse und schiebe oder drehe: In welche Richtungen gibt es nach, in welche hält es dagegen?» Wo es dagegenhält, zeichnest du eine unbekannte Kraft (oder ein Moment) ein. Die Pfeilrichtung darfst du raten. Kommt am Ende eine negative Zahl heraus, zeigt die Kraft in Wirklichkeit in die Gegenrichtung.
]

== Vorgehen zur Ermittlung der Lagerkräfte

#rezept[Lagerkräfte in acht Schritten][
  + *System abgrenzen.* Was genau ist «mein» System?
  + *Äußere Kräfte einführen:* Lasten (Gewicht im Schwerpunkt, verteilte Lasten durch ihre Ersatzkraft) und Lagerkräfte. Das Bild dazu heißt *Freischnitt*: das System allein, ohne Lager, nur mit Kräften.
  + *Basis* $ve_x, ve_y, ve_z$ und Koordinaten wählen.
  + *Abzählen:* Unbekannte $n$ gegen Gleichungen $m$ (eben: 3 pro Körper). Statisch bestimmt?
  + *Gleichgewichtsbedingungen* komponentenweise aufschreiben.
  + Wenn nötig: System *zerlegen* und die Schritte 1 bis 5 für die Teile wiederholen.
  + *Auflösen.*
  + *Diskutieren:* Vorzeichen, Grenzfälle, Einheiten. Sind einseitige Bindungen eingehalten?
]

#fg("k09_freischnitt", [Vom System zum Freischnitt: Lager entfernen, Lagerkräfte dafür eintragen. Bei $A$ ein Festlager (2 Kräfte), bei $B$ ein Loslager (1 Kraft).])

#merke[
  Die Kunst liegt in Schritt 5. Wähle den *Bezugspunkt der Momentenbedingung dort, wo sich möglichst viele unbekannte Kräfte schneiden*: Sie haben dort keinen Hebelarm und fallen heraus. Oft erhält man so pro Gleichung nur eine Unbekannte. In der Ebene darf man statt der zwei Komponentenbedingungen auch weitere Momentenbedingungen um andere Punkte verwenden; es bleiben aber immer nur *drei* unabhängige Gleichungen pro Körper.
]

#bsp[Balken auf zwei Stützen][
  Ein Balken der Länge $L = a + b$, in $A$ gelenkig und in $B$ auf einem Loslager, trägt im Abstand $a$ von $A$ die Last $F$. Unbekannte: $A_x, A_y, B_y$ (3), Gleichungen: 3. Statisch bestimmt.
  $ sum X: quad A_x = 0, wide sum M_A: quad -a F + (a + b) B_y = 0, wide sum M_B: quad b F - (a + b) A_y = 0. $
  $ => quad B_y = a / (a + b) F, wide A_y = b / (a + b) F. $
  _Kontrolle:_ $A_y + B_y = F$ ✓. _Deutung:_ Das Lager, das näher an der Last liegt, trägt den größeren Teil. Steht die Last direkt über $A$ ($a = 0$), trägt $A$ alles. Außerdem muss $B_y >= 0$ sein, weil das Loslager nur drücken kann; das ist hier für $F > 0$ erfüllt.
]

#bsp[Kragarm mit Gleichlast][
  Ein Balken der Länge $L$ ist links eingespannt und trägt die Gleichlast $q_0$. Ersatzkraft $q_0 L$ in der Mitte. Unbekannte: $A_x, A_y, M_A$.
  $ A_x = 0, wide A_y = q_0 L, wide M_A - (L\/2) dot.c q_0 L = 0 quad => quad M_A = (q_0 L^2) / 2. $
  Die Einspannung muss ein Moment aufbringen, weil sonst nichts die Drehung um $A$ verhindert.
]

=== Mehrere Momentenbedingungen

Bei ebenen Problemen ist es oft nützlich, eine Komponentenbedingung durch eine zweite Momentenbedingung zu ersetzen. Man stellt zuerst die Momentenbedingung um einen günstigen Punkt $O_1$ auf, danach eine zweite um einen Punkt $O_2$, und schließlich eine Komponentenbedingung längs einer Achse, die _nicht_ senkrecht zur Verbindung $O_1 O_2$ steht. Diese drei Gleichungen sind notwendig und auch hinreichend: Verschwinden die Momente um $O_1$ und $O_2$, lässt sich die Kräftegruppe höchstens noch auf eine Einzelkraft mit Wirkungslinie längs $O_1 O_2$ reduzieren (Formel $vM_P = vM_O + arrow(P O) times vR$); die Komponentenbedingung sorgt dafür, dass auch diese verschwindet. Ebenso genügen drei Momentenbedingungen um drei _nicht auf einer Geraden liegende_ Punkte. Im Raum kann man die sechs Gleichungen durch sechs Momentenbedingungen um sechs geeignet liegende Achsen ersetzen.

#merke[
  Es gibt aber nie mehr als *drei* unabhängige Gleichgewichtsbedingungen pro ebenem Körper (sechs im Raum). Denn sie garantieren schon, dass die Dyname der äußeren Kräfte verschwindet, und damit ist jede weitere Bedingung automatisch erfüllt. Zusätzliche Gleichungen bringen nichts Neues und helfen nicht gegen eine statische Unbestimmtheit.
]

== Statische Bestimmtheit

#defn[Statisch bestimmt, unbestimmt][
  Sei $n$ die Anzahl der unbekannten Lagerkraftkomponenten und $m$ die Anzahl unabhängiger Gleichgewichtsbedingungen. Für $m = n$ (und eindeutig lösbares Gleichungssystem) heißt das Problem *statisch bestimmt*. Für $m < n$ ist es *statisch unbestimmt*: Die Statik allein reicht nicht, man braucht zusätzlich die Verformungen. Für $m > n$ ist das System beweglich und nur für spezielle Lasten in Ruhe.
]

Physikalisch: Ein System ist statisch bestimmt gelagert, wenn es gerade so viele Bindungen hat, dass es sich nicht mehr bewegen kann. Jede weitere Bindung ist «überzählig». Löst man in Gedanken $u$ Bindungskomponenten, bis das System gerade noch unbeweglich ist, so ist es *$u$-fach statisch unbestimmt*.

Die physikalische Überlegung dahinter: Bei einem statisch unbestimmten System kann man Bindungen lösen, und es bleibt trotzdem unbeweglich. Bei einem statisch bestimmten System wird es durch das Lösen einer einzigen Bindungskomponente zu einem beweglichen Mechanismus. Beispiele für Balken in der Ebene: Beidseitig gelenkig gelagert gibt vier Unbekannte (zwei Gelenkkräfte mit je zwei Komponenten), aber nur drei Gleichungen, die horizontalen Komponenten $A_x, B_x$ sind einzeln nicht bestimmbar: einfach unbestimmt. Einseitig eingespannt und am anderen Ende aufgelegt: einfach unbestimmt. Einseitig eingespannt und am anderen Ende gelenkig gelagert: fünf Unbekannte, zweifach unbestimmt. Beidseitig eingespannt: sechs Unbekannte, dreifach unbestimmt. Bei mehreren Trägern ist Vorsicht mit dem Urteil «unbestimmt» geboten: Das System kann statisch bestimmt sein, was man erst nach dem Zerlegen sieht (Dreigelenkbogen: 4 Unbekannte am Gesamtsystem, aber nach der Trennung im Zwischengelenk $2 dot.c 3 = 6$ Gleichungen für $4 + 2 = 6$ Unbekannte, siehe Kapitel 10 und 11).

#fg("k09_bestimmt", [Links statisch bestimmt (3 Unbekannte). Mitte: zwei Gelenke, 4 Unbekannte, einfach unbestimmt (die horizontale Kraft kann beliebig auf die zwei Gelenke verteilt werden). Rechts: Einspannung plus Auflager, 4 Unbekannte, einfach unbestimmt.])

== Ergänzungen

=== Lagerkraft oder Lagerreaktion?

Die *Lagerkraft* ist die Kraft, die das Lager _auf den Träger_ ausübt; sie tragen wir im Freischnitt des Trägers ein. Die *Lagerreaktion* ist ihre Gegenkraft, die der Träger auf das Lager (das Fundament) ausübt. Für die Dimensionierung des Fundaments braucht man die zweite; sie ist gleich groß und entgegengesetzt.

=== Federn und nachgiebige Lager

Eine lineare Feder mit *Federkonstante* $k$ (N/m) übt bei der Längenänderung $Delta x$ gegenüber ihrer ungespannten Länge die Kraft
#gl($ F = k Delta x $)
aus, so gerichtet, dass sie in die ungespannte Länge zurückwill. Eine Drehfeder liefert entsprechend ein Moment $M = k_phi Delta phi$. Ein elastisch nachgiebiges Lager ist ein Lager mit Feder: Die Lagerkraft ist dann keine freie Unbekannte mehr, sondern durch die Einsenkung bestimmt. Damit bekommt man zusätzliche Gleichungen, die auch statisch unbestimmte Probleme lösbar machen (Beispiel: Feder zwischen zwei Stäben, Kapitel 10).

Für ein elastisch nachgiebiges Lager gilt: Das Auflager $A$ mit Federkonstante $k$ übt die Auflagerkraft $A_y = k Delta y_A$ aus, wobei $Delta y_A$ die sich in der Ruhelage einstellende Verschiebung ist. Ein Zylindergelenk, das in zwei Richtungen elastisch verschiebbar ist, hat Komponenten $B_x = k_x Delta x_B$ und $B_y = k_y Delta y_B$. Zusätzlich können in jeder Richtung Reibungskräfte auftreten (Kapitel 12). Auch Einspannungen sind nicht unendlich steif: Man ersetzt sie durch eine lineare Drehfeder (Torsionsfeder), die bei einer Verdrehung $Delta phi$ ein Kräftepaar mit dem Moment $M = C Delta phi$ entwickelt ($C$ hat die Dimension Kraft mal Länge). Ist die Einspannung auch translatorisch nachgiebig, kommen entsprechende Zug- und Druckfedern dazu (elastische Einspannung). Bei großen Verformungen muss man nichtlineare Effekte berücksichtigen. Die Lager, die wir bisher betrachtet haben, heißen im Gegensatz dazu *feste Lager*: Sie sind eine Idealisierung, in der die Nachgiebigkeit des Lagers vernachlässigt wird.

=== Gesucht ist die Ruhelage

Manchmal sind nicht die Kräfte unbekannt, sondern die Lage selbst (ein Winkel, eine Auslenkung). Das Vorgehen bleibt gleich: Man schreibt die Gleichgewichtsbedingungen in einer _allgemeinen_ Lage mit dem unbekannten Winkel $phi$ auf. Die Gleichungen bestimmen dann $phi$ zusammen mit den Lagerkräften, oft als trigonometrische Gleichung.

#fehler[
  - Lagerkräfte vergessen oder zu viele eintragen. Ein Loslager hat _eine_ Unbekannte, nicht zwei.
  - Im Freischnitt die Lager stehen lassen. Lager _oder_ Lagerkräfte, nie beides.
  - Das Einspannmoment vergessen.
  - Bei verteilten Lasten die Ersatzkraft am falschen Ort ansetzen (Dreieck: $2\/3$ von der Spitze).
  - Mehr als drei Gleichungen pro ebenem Körper aufstellen und sich wundern, dass sie nichts Neues bringen.
]

#kurz[
  - Loslager 1, Gelenk 2, Einspannung 3 Unbekannte (eben).
  - Freischnitt, Gleichgewicht: $sum X = 0$, $sum Y = 0$, $sum M = 0$.
  - Momentenbezugspunkt dort wählen, wo viele Unbekannte durchgehen.
  - Statisch bestimmt: $n = m$. Sonst unbestimmt ($n > m$) oder beweglich ($n < m$).
  - Standfest, solange die Resultierende die Standfläche trifft.
]
