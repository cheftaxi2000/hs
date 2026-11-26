#import "lib.typ": *

= Lagerbindungen und Lagerkräfte

Lager sind die äusseren Bindungen von Trägern, Wellen und Tragwerken. Dieses Kapitel ist das handwerkliche Herz der Statik: Lager erkennen, Lagerkräfte einzeichnen, Gleichgewicht ansetzen, auflösen. Nach dem letzten Kapitel wissen wir _warum_ das funktioniert; jetzt üben wir _wie_.

== Körper auf ebener Unterlage, Standfestigkeit

Eine reibungsfreie Unterlage drückt mit verteilten Normalkräften auf die Berührungsfläche. Sie sind alle parallel und gleich gerichtet: Die Unterlage kann nur drücken, nicht ziehen. Ihre äquivalente Einzelkraft $vN$ (Kapitel 7: Kräftemittelpunkt) muss deshalb *innerhalb der Standfläche* angreifen, genauer: innerhalb der kleinsten konvexen Fläche, die alle Berührungspunkte umschliesst.

#defn[Standfestigkeit][
  Ein Körper auf einer Unterlage heisst *standfest*, wenn er nicht kippt. Das ist genau dann der Fall, wenn die Wirkungslinie der Resultierenden aller übrigen Kräfte (Gewicht, Lasten) die Standfläche durchstösst. Geht sie durch den Rand, steht der Körper an der Kippgrenze.
]

#warum[Warum $vN$ innerhalb der Standfläche angreift][
  Betrachte eine beliebige Tangente an die Randkurve der Standfläche. Die Momente aller infinitesimalen Normalkräfte $dif vN$ bezüglich dieser Tangente haben dasselbe Vorzeichen, denn alle Berührungspunkte liegen auf derselben Seite der Tangente und alle Kräfte zeigen gleich (nach oben). Wegen der statischen Äquivalenz muss auch das Moment der Resultierenden $vN$ dieses Vorzeichen haben. Also liegt ihr Angriffspunkt $P$ auf derselben Seite jeder solchen Tangente wie die Berührungspunkte, das heisst innerhalb der Standfläche. Liefert die Rechnung einen Angriffspunkt ausserhalb, ist das ein Widerspruch: Der Kontakt kommt in dieser Form nicht zustande, der Körper kippt.
]

#bsp[Tisch mit seitlicher Kraft][
  Ein dreibeiniger Tisch steht auf einer rauen Ebene. Ohne Last ist seine Standfläche das Dreieck durch die drei Beinenden, und er ist standfest, solange der Schwerpunkt $S$ vertikal darüber liegt (Gewicht und Normalkraft müssen dieselbe Wirkungslinie haben). Nun greife in der Höhe $h$ über dem Boden zusätzlich eine horizontale Kraft $K$ an. Die Unterlage liefert die Normalkraft $N$ und die Reibungskraft $F_R$ (Angriffspunkt $P$). Komponentenbedingungen: $F_R = K$ und $N = G$. Die Momentenbedingung um $S$ verschiebt den Angriffspunkt von $N$ um $x = K h\/G$ gegenüber der Lotrechten durch $S$. Der Tisch kippt nicht, solange $P$ in der Standfläche bleibt, also für $x <= a$ (mit $a$ dem Abstand von $S$ zur Kippkante): $K <= G a\/h$. Ausserdem muss die Reibung halten, $F_R <= mu_0 N$, also $K <= mu_0 G$. Die kleinere der beiden Grenzen entscheidet, ob der Tisch zuerst kippt oder gleitet.
]

#fg("k09_standfest", [Kräfte massstäblich. Ohne seitliche Last greift $vN$ unter dem Schwerpunkt an. Mit $vF$ kommt die Reibungskraft $vF_R = -vF$ dazu, und $vN$ wandert um $e = F h\/G$ zur vorderen Kante ($h$: Höhe von $vF$). Die gestrichelte Wirkungslinie der Resultierenden aus $vG$ und $vF$ trifft den Boden genau dort (Dreikräftesatz). Erreicht sie die Kante, steht der Körper an der Kippgrenze.])

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
  [Zylindergelenk (Scharnier)], [alles ausser der Drehung um die Zapfenachse], [3 Kräfte, 2 Momente],
  [Einspannung], [alles], [3 Kräfte, 3 Momente],
  table.hline(stroke: 0.7pt),
)

Etwas mehr zu den einzelnen Lagern:

*Auflager.* Es wirkt einseitig und verhindert die Bewegung der Berührungspunkte des Trägers in eine Halbebene; die Auflagerkraft zeigt gegen den anderen Halbraum. Bei reibungsfreier Auflage steht sie senkrecht zur Berührungsfläche (bei einem waagrechten Träger auf waagrechter Unterlage also senkrecht zur Trägerachse). Beispiel: Ein Träger auf zwei Auflagern $A$, $B$ trage vertikale Lasten $F_1$ (im Abstand $a_1$ von $A$) und $F_2$ (im Abstand $a_2$ von $A$; die Auflager haben den Abstand $L$). Die Momentenbedingungen liefern $B_y = (F_1 a_1 + F_2 a_2)\/L$ und $A_y = (F_1 (L - a_1) + F_2 (L - a_2))\/L$. Wegen der einseitigen Bindung dürfen $A_y, B_y$ nicht negativ werden. Liegt $F_2$ weit hinter $B$ ($a_2 > L$), kann $A_y$ negativ werden: Dann hebt der Träger bei $A$ ab und bleibt in dieser Lage nicht in Ruhe. Aus $A_y >= 0$ folgt $F_2 (a_2 - L) <= F_1 (L - a_1)$.

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
  + *Äussere Kräfte einführen:* Lasten (Gewicht im Schwerpunkt, verteilte Lasten durch ihre Ersatzkraft) und Lagerkräfte. Das Bild dazu heisst *Freischnitt*: das System allein, ohne Lager, nur mit Kräften.
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
  _Kontrolle:_ $A_y + B_y = F$ ✓. _Deutung:_ Das Lager, das näher an der Last liegt, trägt den grösseren Teil. Steht die Last direkt über $A$ ($a = 0$), trägt $A$ alles. Ausserdem muss $B_y >= 0$ sein, weil das Loslager nur drücken kann; das ist hier für $F > 0$ erfüllt.
]

#bsp[Kragarm mit Gleichlast][
  Ein Balken der Länge $L$ ist links eingespannt und trägt die Gleichlast $q_0$. Ersatzkraft $q_0 L$ in der Mitte. Unbekannte: $A_x, A_y, M_A$.
  $ A_x = 0, wide A_y = q_0 L, wide M_A - (L\/2) dot.c q_0 L = 0 quad => quad M_A = (q_0 L^2) / 2. $
  Die Einspannung muss ein Moment aufbringen, weil sonst nichts die Drehung um $A$ verhindert.
]

=== Mehrere Momentenbedingungen

Bei ebenen Problemen ist es oft nützlich, eine Komponentenbedingung durch eine zweite Momentenbedingung zu ersetzen. Man stellt zuerst die Momentenbedingung um einen günstigen Punkt $O_1$ auf, danach eine zweite um einen Punkt $O_2$, und schliesslich eine Komponentenbedingung längs einer Achse, die _nicht_ senkrecht zur Verbindung $O_1 O_2$ steht. Diese drei Gleichungen sind notwendig und auch hinreichend: Verschwinden die Momente um $O_1$ und $O_2$, lässt sich die Kräftegruppe höchstens noch auf eine Einzelkraft mit Wirkungslinie längs $O_1 O_2$ reduzieren (Formel $vM_P = vM_O + arrow(P O) times vR$); die Komponentenbedingung sorgt dafür, dass auch diese verschwindet. Ebenso genügen drei Momentenbedingungen um drei _nicht auf einer Geraden liegende_ Punkte. Im Raum kann man die sechs Gleichungen durch sechs Momentenbedingungen um sechs geeignet liegende Achsen ersetzen.

#merke[
  Es gibt aber nie mehr als *drei* unabhängige Gleichgewichtsbedingungen pro ebenem Körper (sechs im Raum). Denn sie garantieren schon, dass die Dyname der äusseren Kräfte verschwindet, und damit ist jede weitere Bedingung automatisch erfüllt. Zusätzliche Gleichungen bringen nichts Neues und helfen nicht gegen eine statische Unbestimmtheit.
]

== Statische Bestimmtheit

#defn[Statisch bestimmt, unbestimmt][
  Sei $n$ die Anzahl der unbekannten Lagerkraftkomponenten und $m$ die Anzahl unabhängiger Gleichgewichtsbedingungen. Für $m = n$ (und eindeutig lösbares Gleichungssystem) heisst das Problem *statisch bestimmt*. Für $m < n$ ist es *statisch unbestimmt*: Die Statik allein reicht nicht, man braucht zusätzlich die Verformungen. Für $m > n$ ist das System beweglich und nur für spezielle Lasten in Ruhe.
]

Physikalisch: Ein System ist statisch bestimmt gelagert, wenn es gerade so viele Bindungen hat, dass es sich nicht mehr bewegen kann. Jede weitere Bindung ist «überzählig». Löst man in Gedanken $u$ Bindungskomponenten, bis das System gerade noch unbeweglich ist, so ist es *$u$-fach statisch unbestimmt*.

Die physikalische Überlegung dahinter: Bei einem statisch unbestimmten System kann man Bindungen lösen, und es bleibt trotzdem unbeweglich. Bei einem statisch bestimmten System wird es durch das Lösen einer einzigen Bindungskomponente zu einem beweglichen Mechanismus. Beispiele für Balken in der Ebene: Beidseitig gelenkig gelagert gibt vier Unbekannte (zwei Gelenkkräfte mit je zwei Komponenten), aber nur drei Gleichungen, die horizontalen Komponenten $A_x, B_x$ sind einzeln nicht bestimmbar: einfach unbestimmt. Einseitig eingespannt und am anderen Ende aufgelegt: einfach unbestimmt. Einseitig eingespannt und am anderen Ende gelenkig gelagert: fünf Unbekannte, zweifach unbestimmt. Beidseitig eingespannt: sechs Unbekannte, dreifach unbestimmt. Bei mehreren Trägern ist Vorsicht mit dem Urteil «unbestimmt» geboten: Das System kann statisch bestimmt sein, was man erst nach dem Zerlegen sieht (Dreigelenkbogen: 4 Unbekannte am Gesamtsystem, aber nach der Trennung im Zwischengelenk $2 dot.c 3 = 6$ Gleichungen für $4 + 2 = 6$ Unbekannte, siehe Kapitel 10 und 11).

#fg("k09_bestimmt", [Links statisch bestimmt (3 Unbekannte). Mitte: zwei Gelenke, 4 Unbekannte, einfach unbestimmt (die horizontale Kraft kann beliebig auf die zwei Gelenke verteilt werden). Rechts: Einspannung plus Auflager, 4 Unbekannte, einfach unbestimmt.])

== Ergänzungen

=== Lagerkraft oder Lagerreaktion?

Die *Lagerkraft* ist die Kraft, die das Lager _auf den Träger_ ausübt; sie tragen wir im Freischnitt des Trägers ein. Die *Lagerreaktion* ist ihre Gegenkraft, die der Träger auf das Lager (das Fundament) ausübt. Für die Dimensionierung des Fundaments braucht man die zweite; sie ist gleich gross und entgegengesetzt.

=== Federn und nachgiebige Lager

Eine lineare Feder mit *Federkonstante* $k$ (N/m) übt bei der Längenänderung $Delta x$ gegenüber ihrer ungespannten Länge die Kraft
#gl($ F = k Delta x $)
aus, so gerichtet, dass sie in die ungespannte Länge zurückwill. Eine Drehfeder liefert entsprechend ein Moment $M = k_phi Delta phi$. Ein elastisch nachgiebiges Lager ist ein Lager mit Feder: Die Lagerkraft ist dann keine freie Unbekannte mehr, sondern durch die Einsenkung bestimmt. Damit bekommt man zusätzliche Gleichungen, die auch statisch unbestimmte Probleme lösbar machen (Beispiel: Feder zwischen zwei Stäben, Kapitel 10).

Beispiele: Ein Auflager $A$ mit Federkonstante $k$ übt die Auflagerkraft $A_y = k Delta y_A$ aus, wobei $Delta y_A$ die Einsenkung in der Ruhelage ist. Ein in zwei Richtungen elastisch verschiebbares Gelenk hat $B_x = k_x Delta x_B$ und $B_y = k_y Delta y_B$. Eine nachgiebige Einspannung ersetzt man durch eine Drehfeder mit $M = k_phi Delta phi$ ($k_phi$ hat die Dimension Kraft mal Länge), wenn nötig ergänzt durch Längsfedern. Bei grossen Verformungen werden die Federgesetze nichtlinear. Die Lager der vorigen Abschnitte heissen im Gegensatz dazu *feste Lager*: eine Idealisierung, in der die Nachgiebigkeit vernachlässigt wird.

=== Gesucht ist die Ruhelage

Manchmal sind nicht die Kräfte unbekannt, sondern die Lage selbst (ein Winkel, eine Auslenkung). Das Vorgehen bleibt gleich: Man schreibt die Gleichgewichtsbedingungen in einer _allgemeinen_ Lage mit dem unbekannten Winkel $phi$ auf. Die Gleichungen bestimmen dann $phi$ zusammen mit den Lagerkräften, oft als trigonometrische Gleichung.

#fehler[
  - Lagerkräfte vergessen oder zu viele eintragen. Ein Loslager hat _eine_ Unbekannte, nicht zwei.
  - Im Freischnitt die Lager stehen lassen. Lager _oder_ Lagerkräfte, nie beides.
  - Das Einspannmoment vergessen.
  - Bei verteilten Lasten die Ersatzkraft am falschen Ort ansetzen (Dreieck: $2\/3$ von der Spitze).
  - Mehr als drei Gleichungen pro ebenem Körper aufstellen und sich wundern, dass sie nichts Neues bringen.
]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Lager an der Brücke.* Eine Brücke dehnt sich im Sommer aus und zieht sich im Winter zusammen: Eine $100$ m lange Stahlbrücke wird bei $40$ K Temperaturunterschied um etwa $5$ cm länger. Darum liegt sie auf einem Festlager (nimmt Kräfte in beiden Richtungen auf) und einem Loslager (rollt und nimmt nur die senkrechte Kraft auf). Hätte sie zwei Festlager, entstünden gewaltige Zwangskräfte. Dasselbe Prinzip steckt in Dehnfugen von Autobahnen und im «Klacken» von Brückenübergängen.]

#alltag[*Scharnier und Türrahmen.* Eine Tür hängt an zwei Scharnieren. Das obere zieht an der Tür, das untere drückt, und beide zusammen halten das Moment des Türgewichts. Schwere Türen bekommen drei Bänder. Damit ist die Lagerung statisch unbestimmt: Wie sich die Kräfte auf die drei Bänder verteilen, hängt davon ab, wie genau sie montiert sind. Die Berechnung der Lagerkräfte in diesem Kapitel ist genau der Schritt, den Statiker bei jedem Bauteil als erstes tun: erst die Kräfte an den Auflagern, dann die Schnitte im Bauteil.]
// ALLTAG-END

#aufgaben()

#aufg(fig: "a09_balken", fw: 6.8cm)[Balken mit schräger Kraft][
  Ein Balken der Länge $L$ liegt in $A$ auf einem reibungsfreien Auflager und ist in $B$ gelenkig gelagert. Im Abstand $L\/3$ von $A$ greift unter dem Winkel $pi\/4$ die Kraft $vP$ an (nach rechts unten). Gesucht sind die Lagerkräfte.
][
  _Freischneiden._ Auflager $A$: eine Kraft $A_y$. Gelenk $B$: $B_x, B_y$. Drei Unbekannte, drei Gleichungen: statisch bestimmt.

  _Gleichgewicht._
  $ sum X: quad & sqrt(2)/2 P + B_x = 0 quad && => quad B_x = -sqrt(2)/2 P, \
    sum M_B: quad & -A_y L + sqrt(2)/2 P dot 2/3 L = 0 quad && => quad A_y = sqrt(2)/3 P, \
    sum Y: quad & A_y + B_y - sqrt(2)/2 P = 0 quad && => quad B_y = sqrt(2)/6 P. $

  _Diskussion._ $A_y > 0$: Das einseitige Auflager drückt, wie es muss. Die vertikalen Lagerkräfte verhalten sich wie $2 : 1$, umgekehrt zu den Abständen der Last von den Lagern. $B_x$ ist negativ, wirkt also nach links: Nur das Gelenk kann den Horizontalanteil von $vP$ aufnehmen.
]

#aufg[Abzählen im Raum][
  Ein Balken $A B$ (Länge $L$, längs $x$) ist an beiden Enden in Kugelgelenken gelagert. In der Mitte greift die Kraft $(F_x, F_y, F_z)$ an. Bestimme die Lagerkräfte. Ist die Lagerung statisch bestimmt? Was ändert sich, wenn $B$ ein kurzes Querlager ist oder wenn der Balken in $B$ eingespannt wird?
][
  Zwei Kugelgelenke: $n = 6$ Unbekannte $A_x, A_y, A_z, B_x, B_y, B_z$.
  $ sum X: quad A_x + B_x + F_x = 0, wide sum Y: quad A_y + B_y + F_y = 0, wide sum Z: quad A_z + B_z + F_z = 0, $
  $ M_x^((A)): quad 0 = 0, wide M_y^((A)): quad -F_z L/2 - B_z L = 0, wide M_z^((A)): quad F_y L/2 + B_y L = 0. $
  Daraus $B_y = A_y = -F_y\/2$ und $B_z = A_z = -F_z\/2$. Für die Längsrichtung bleibt nur $A_x + B_x = -F_x$: Wie sich $F_x$ auf die beiden Gelenke verteilt, lässt sich mit der Statik allein nicht sagen. Es gibt nur $m = 5$ brauchbare Gleichungen für $n = 6$ Unbekannte, die Lagerung ist *einfach statisch unbestimmt*. (Die Gleichung $0 = 0$ zeigt zugleich, dass nichts die Drehung um die Balkenachse verhindert.)

  - _Kurzes Querlager in $B$:_ $B_x$ entfällt, $n = 5 = m$, alle Lagerkräfte sind eindeutig bestimmt, $A_x = -F_x$. Die Gleichung $M_x: 0 = 0$ bleibt aber stehen: Die Drehung um die Balkenachse ist nach wie vor frei. Die Lagerung trägt nur deshalb, weil die Last kein Moment um diese Achse hat; streng genommen ist sie beweglich, nicht statisch bestimmt. Beim Stabmodell (Querschnitt null) ist das bedeutungslos, bei einer Welle mit Rad nicht.
  - _Einspannung in $B$, Kugelgelenk in $A$:_ $n = 6 + 3 = 9$, $m = 6$, dreifach statisch unbestimmt.
]

#aufg(fig: "a09_dreieck", fw: 7cm)[Dreieckscheibe][
  Eine Scheibe $A B C$ ist in $A$ gelenkig gelagert und liegt in $B$ auf. Die Kante $A C$ (Länge $2L$) ist horizontal, die Winkel bei $A$ und $C$ sind 30°. Das Gewicht $G$ greift im Abstand $3L\/2$ von $A$ an. In $C$ wirkt die Kraft $vF$ senkrecht zur Kante $B C$ nach links oben.

  Gesucht sind die Lagerkräfte und die Bedingung, unter der die Scheibe liegen bleibt.
][
  $vF$ schliesst mit der Vertikalen 30° ein: $vF = F (-1\/2, sqrt(3)\/2)$.
  $ sum X: quad & A_x - F/2 = 0 quad && => quad A_x = F/2, \
    sum M_A: quad & B_y L - G dot 3/2 L + sqrt(3)/2 F dot 2 L = 0 quad && => quad B_y = 3/2 G - sqrt(3) F, \
    sum Y: quad & A_y + B_y - G + sqrt(3)/2 F = 0 quad && => quad A_y = -1/2 G + sqrt(3)/2 F. $

  _Diskussion._ Das Auflager in $B$ ist einseitig, es kann nur drücken: $B_y >= 0$, also
  $ F <= sqrt(3)/2 G. $
  Für grösseres $F$ hebt die Scheibe in $B$ ab und dreht um $A$. Das Gelenk $A$ darf dagegen in beide Richtungen belastet werden; $A_y$ wechselt bei $F = G\/sqrt(3)$ das Vorzeichen.
]

#aufg(fig: "a09_schraeg", fw: 6.8cm)[Schräger Balken][
  Ein Balken (Neigung $alpha$) ist unten in $A$ gelenkig gelagert und liegt im Abstand $L$ davon in $B$ auf einem Auflager, dessen Unterlage parallel zum Balken ist. Das Gewicht $G$ greift im Abstand $s$ von $A$ an. Gesucht sind die Lagerkräfte.
][
  Die Achsen legt man längs und quer zum Balken, weil die Auflagerkraft in $B$ dann nur eine Komponente $B_y$ hat. Das Gewicht wird zerlegt: $vG = (-G sin alpha, -G cos alpha)$.
  $ sum X: quad & A_x - G sin alpha = 0 quad && => quad A_x = G sin alpha, \
    sum M_A: quad & B_y L - G cos alpha dot s = 0 quad && => quad B_y = G cos alpha dot s/L, \
    sum M_B: quad & -A_y L + G cos alpha (L - s) = 0 quad && => quad A_y = G cos alpha (1 - s/L). $
  Kontrolle: $A_y + B_y = G cos alpha$ ✓. $B_y > 0$, das Auflager drückt. Der Längsanteil $G sin alpha$ des Gewichts geht ganz ins Gelenk, den Queranteil teilen sich die Lager nach dem Hebelgesetz.
]

#aufg(fig: "a09_lkrag", fw: 5.2cm)[Eingespannter Winkelträger][
  Ein rechtwinkliger Träger ist in $A$ eingespannt. Der Arm $A B$ (Länge $L$) liegt längs $x$, der Arm $B C$ (Länge $L$) längs $y$. Beide Arme haben das Gewicht $G$, das in ihrer Mitte senkrecht zur Zeichenebene wirkt (in sie hinein, Richtung $-z$).

  Gesucht sind die Kräfte und Momente an der Einspannung.
][
  Eine Einspannung im Raum hat sechs Unbekannte: $A_x, A_y, A_z$ und $M_x, M_y, M_z$.

  _Kräfte._ $A_x = A_y = 0$, $A_z = 2G$.

  _Momente um $A$._ Die Gewichte $(0, 0, -G)$ greifen in $(L\/2, 0, 0)$ und $(L, L\/2, 0)$ an:
  $ (L\/2, 0, 0) times (0, 0, -G) = (0, 1/2 G L, 0), wide (L, L\/2, 0) times (0, 0, -G) = (-1/2 G L, G L, 0). $
  Das Einspannmoment hebt die Summe auf:
  $ M_x = 1/2 G L, quad M_y = -3/2 G L, quad M_z = 0. $

  _Deutung._ $M_y$ kommt vom Abstand beider Gewichte in $x$-Richtung ($L\/2$ und $L$). $M_x$ kommt allein vom zweiten Arm, dessen Gewicht um $L\/2$ neben der Achse $A B$ liegt; es verdreht den Arm $A B$ um seine Längsachse.
]

#aufg(fig: "a09_ttraeger", fw: 6.4cm)[T-Träger in zwei Querlagern][
  Ein T-förmiger Träger besteht aus dem Balken $B C$ (Länge $4a$, längs $x$) und dem Steg $D A$ (Länge $4a$, nach unten), der im Abstand $a$ von $B$ ansetzt. Beide Teile haben das Gewicht $G$ (in $S_2$ und $S_1$). In $A$ wirkt ein Moment vom Betrag $M$, dessen Vektor nach unten zeigt. $B$ und $C$ sind kurze Querlager (Kräfte nur quer zu $B C$).

  Gesucht sind die Lagerkräfte.
][
  Unbekannte: $B_y, B_z, C_y, C_z$.
  $ sum Y: quad B_y + C_y - 2 G = 0, wide sum Z: quad B_z + C_z = 0. $
  Momente um $B$ (der Momentvektor in $A$ ist $(0, -M, 0)$, die Kraft $C_z$ in $(4a, 0, 0)$ hat das Moment $(0, -4 a C_z, 0)$):
  $ M_y^((B)): quad & -M - 4 a C_z = 0 quad && => quad C_z = -M/(4a), quad B_z = M/(4a), \
    M_z^((B)): quad & -a G - 2 a G + 4 a C_y = 0 quad && => quad C_y = 3/4 G, quad B_y = 5/4 G. $
  Das Moment $M$ wird von einem Kräftepaar $B_z, C_z$ mit dem Hebelarm $4a$ aufgenommen. $B$ trägt mehr Gewicht als $C$, weil beide Schwerpunkte näher bei $B$ liegen.

  Die übrigen Bedingungen ($sum X$ und $M_x^((B))$) lauten $0 = 0$: Vier Gleichungen für vier Unbekannte. Sie zeigen aber auch, dass diese Lager weder eine Verschiebung längs $x$ noch eine Drehung um die Achse $B C$ verhindern.
]

#kurz[
  - Loslager 1, Gelenk 2, Einspannung 3 Unbekannte (eben).
  - Freischnitt, Gleichgewicht: $sum X = 0$, $sum Y = 0$, $sum M = 0$.
  - Momentenbezugspunkt dort wählen, wo viele Unbekannte durchgehen.
  - Statisch bestimmt: $n = m$. Sonst unbestimmt ($n > m$) oder beweglich ($n < m$).
  - Standfest, solange die Resultierende die Standfläche trifft.
]
