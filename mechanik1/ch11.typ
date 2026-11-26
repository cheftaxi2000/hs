#import "lib.typ": *

= Statisch bestimmte Fachwerke

#woche(11, [Fachwerke], [158–169])

Fachwerke sind Tragwerke aus Stäben, die in *Knoten* verbunden sind: Brücken, Kräne, Dachbinder, Strommasten. Sie sind leicht und trotzdem steif, weil ihre Stäbe fast nur auf Zug oder Druck beansprucht werden, die Belastungsart, die das Material am besten ausnutzt. Für die Statik haben Fachwerke einen riesigen Vorteil: Man kann sie mit sehr einfachen Mitteln vollständig berechnen.

== Ideale Fachwerke und Pendelstützen

#defn[Ideales Fachwerk][
  Ein *ideales Fachwerk* erfüllt:
  - die Stäbe sind gerade und gewichtslos,
  - sie sind an ihren Enden durch *reibungsfreie Gelenke* (die Knoten) verbunden,
  - alle Lasten greifen *nur in den Knoten* an (Knotenlasten).
]

Diese Voraussetzungen idealisieren die Wirklichkeit: Echte Knoten sind geschweisst, verschraubt oder mit Knotenblechen genietet und übertragen auch etwas Biegemoment, und Stäbe haben Eigengewicht. Solange die Stäbe schlank sind und die Lasten über die Knoten eingeleitet werden, sind diese Biegemomente aber klein. Für die Frage «Welche Kräfte tragen die Stäbe?» liefert das Modell deshalb eine gute erste Abschätzung.

Schneidet man einen einzelnen Stab frei, greifen an ihm nur zwei Kräfte an, je eine an jedem Ende. Nach Kapitel 6 können zwei Kräfte nur im Gleichgewicht sein, wenn sie auf derselben Wirkungslinie liegen, also auf der Stabachse:

#satz[Pendelstütze][
  Ein gewichtsloser, an beiden Enden reibungsfrei gelenkig gelagerter und nur dort belasteter Stab (*Pendelstütze*) überträgt nur eine Kraft *in Stabrichtung*, die *Stabkraft* $S$. Vereinbarung:
  $ S > 0: quad "Zugstab", wide S < 0: quad "Druckstab". $
  Ein ideales Fachwerk besteht ausschliesslich aus Pendelstützen.
]

Ob eine Stabkraft Zug oder Druck ist, legt man an der _äusseren Normalen des Stabquerschnitts_ fest: Zeigt die Kraft am Stabende in Richtung der äusseren Normalen (vom Stab weg), liegt Zug vor, sonst Druck. Zwei Kräfte $\{A | vS\}$ und $\{A' | -vS\}$ genügen, daher charakterisiert man beide durch die einzige skalare Grösse $S$ mit $vS = S ve_N$. Ein Fachwerk, bei dem ein Stab zwischen seinen Enden quer belastet wird oder mit einer Platte fest verschweisst ist, ist _nicht ideal_.

#fg("k11_stab", [Links: Zug- und Druckstab. Rechts: Am freigeschnittenen Knoten trägt man jede Stabkraft als Zug ein, also vom Knoten weg. Ergibt die Rechnung $S < 0$, ist der Stab ein Druckstab.])

#intu[
  Ein Stab mit zwei Gelenken kann weder etwas quer zu sich abstützen noch verdrehen: Er würde einfach um sein Gelenk schwenken. Er kann nur ziehen oder schieben, wie ein Seil, das zusätzlich auch drücken darf. Das macht Fachwerke so einfach: Pro Stab gibt es genau _eine_ Unbekannte.
]

Zur Beurteilung der Tragfähigkeit eines ruhenden Fachwerks braucht man einzelne oder alle Stabkräfte. Wir lernen drei Verfahren: Knotengleichgewicht, Dreikräfteschnitt und PdvL. Bei allen setzen wir ein _statisch bestimmtes_ ideales Fachwerk voraus, denn nur solche Systeme lassen sich ohne Verformungen allein mit der Statik berechnen. Fachwerke, die innerlich oder äusserlich statisch unbestimmt sind, brauchen die Festigkeitslehre (Mechanik 2).

== Abzählen: statische Bestimmtheit

Mit $s$ Stäben, $r$ Lagerkraftkomponenten und $k$ Knoten hat man $s + r$ Unbekannte. Pro Knoten stehen zwei (eben) bzw. drei (räumlich) Gleichgewichtsbedingungen zur Verfügung, denn alle Kräfte am Knoten gehen durch ihn (die Momentenbedingung ist automatisch erfüllt). Also:
#gl($ u = s + r - 2k quad ("eben"), wide u = s + r - 3k quad ("räumlich"). $)
$u = 0$ ist notwendig für statische Bestimmtheit, aber wie in Kapitel 10 nicht hinreichend: Eine ungünstige Lagerung (Wirkungslinien durch einen Punkt) oder eine bewegliche Stabanordnung macht das Fachwerk trotz $u = 0$ zum Mechanismus. Für das Beispiel unten: $s = 7$, $r = 3$ (zwei Kräfte im Gelenk, eine im Loslager), $k = 5$, also $u = 7 + 3 - 10 = 0$.

Zwei weitere Beispiele: Ein Fachwerk mit $s = 9$, $k = 5$ und $r = 3$ hat $u = 2$; es ist statisch bestimmt gelagert, aber innerlich zweifach unbestimmt (zwei Stäbe «zu viel»). Eines mit $s = 7$, $k = 5$ und $r = 4$ hat $u = 1$; es ist innerlich bestimmt, aber äusserlich einfach unbestimmt gelagert.

Das Grundbauelement ist das *Dreieck*: die einfachste in sich unverschiebliche Stabfigur (ein Viereck aus Stäben ist ein Mechanismus). Jeder weitere Knoten, der mit zwei neuen Stäben an bestehende Knoten angeschlossen wird, erhält die Bestimmtheit.

== Knotengleichgewicht

Jeder Knoten wird freigeschnitten. An ihm greifen die Stabkräfte der anschliessenden Stäbe an (alle als Zug, vom Knoten weg), eventuell eine Knotenlast und Lagerkräfte. Alle Wirkungslinien gehen durch den Knoten; es bleiben $sum X = 0$ und $sum Y = 0$.

#rezept[Knotengleichgewicht][
  + Lagerkräfte am Gesamtfachwerk bestimmen (drei Gleichungen).
  + Mit einem Knoten beginnen, an dem höchstens *zwei* unbekannte Stabkräfte angreifen.
  + $sum X = 0$ und $sum Y = 0$ liefern diese beiden. Zum nächsten Knoten mit höchstens zwei Unbekannten weitergehen.
  + Die letzten Knoten liefern Kontrollgleichungen.
]

#fg("k11_fachwerk", [Beispielfachwerk: 7 Stäbe, 5 Knoten, 3 Lagerkomponenten, $u = 0$. Die Last $vF$ greift in $C$ an. Rechts der freigeschnittene linke Teil für den Ritter-Schnitt durch die Stäbe 2, 3 und 6, alle Stabkräfte als Zug angesetzt. Die Wirkungslinien von $S_2$ und $S_3$ schneiden sich in $C$: Die Momentenbedingung um $C$ enthält nur noch $S_6$.])

*Zur Reihenfolge.* Ist das Fachwerk aus zwei Teilfachwerken zusammengesetzt, die in einem Gelenk $C$ verbunden und in $A$ und $B$ fest gelagert sind (ein Dreigelenkbogen aus Stäben), so hat man vier Lagerkraftkomponenten. Dann verfährt man wie in Kapitel 10: Die Momentenbedingungen um $A$ und $B$ am Ganzen liefern die vertikalen, die Momentenbedingung um $C$ an einem Teilfachwerk die horizontalen Komponenten.

Am freigeschnittenen Knoten trägt man jede Stabkraft als Zugkraft ein, also vom Knoten weg zeigend (am Stab ist ihre Reaktion dann ebenfalls Zug). Ergibt die Rechnung $S_i > 0$, ist der Stab tatsächlich gezogen, sonst gedrückt. Von den $2k$ Knotengleichungen braucht man nur $s + r$; die übrigen enthalten am Schluss nur noch bekannte Werte und dienen als *Kontrolle*.

#bsp[Knotengleichgewicht][
  Koordinaten (mit $a$ als Masseinheit): $A(0, 0)$, $C(2a, 0)$, $B(4a, 0)$, $D(a, a)$, $E(3a, a)$. Last $F$ nach unten in $C$.

  _Lagerkräfte:_ Momentenbedingung um $A$: $4a B_y - 2a F = 0$, also $B_y = F\/2$; $A_y = F\/2$; $A_x = 0$.

  _Knoten $A$_ (Stab 1 nach $D$ unter 45°, Stab 2 nach $C$):
  $ sum Y: quad F/2 + S_1/sqrt(2) = 0 quad => quad S_1 = -F/sqrt(2). wide sum X: quad S_2 + S_1/sqrt(2) = 0 quad => quad S_2 = F/2. $
  _Knoten $D$_ (Stäbe 1, 3 nach $C$, 6 nach $E$):
  $ sum Y: quad -S_1/sqrt(2) - S_3/sqrt(2) = 0 quad => quad S_3 = F/sqrt(2). wide sum X: quad -S_1/sqrt(2) + S_3/sqrt(2) + S_6 = 0 quad => quad S_6 = -F. $
  Aus der Symmetrie: $S_4 = S_3$, $S_5 = S_2$, $S_7 = S_1$. _Kontrolle am Knoten $C$:_ $sum Y = S_3\/sqrt(2) + S_4\/sqrt(2) - F = F\/2 + F\/2 - F = 0$ ✓.

  _Deutung:_ Der Obergurt (6) und die äusseren Diagonalen (1, 7) sind gedrückt, der Untergurt (2, 5) und die inneren Diagonalen (3, 4) gezogen. Das ist genau wie bei einem durchgebogenen Balken: oben Druck, unten Zug.
]

=== Nullstäbe erkennen

Stäbe mit $S = 0$ heissen *Nullstäbe*. Man findet sie oft ohne Rechnung:
- *Unbelasteter Knoten mit zwei Stäben*, die nicht in einer Linie liegen: Beide sind Nullstäbe.
- *Unbelasteter Knoten mit drei Stäben*, von denen zwei in einer Linie liegen: Der dritte ist ein Nullstab.
- *Belasteter Knoten mit zwei Stäben*, Last in Richtung des einen Stabs: Der andere ist ein Nullstab.
Nullstäbe sind nicht überflüssig. Sie halten die Knoten fest, verhindern Beweglichkeit bei anderen Lasten und verkürzen die Knicklänge gedrückter Stäbe.

== Dreikräfteschnitt (Ritter-Schnitt)

Will man nur einzelne Stabkräfte, ist es mühsam, sich Knoten für Knoten vorzuarbeiten. Schneller ist ein Schnitt durch das ganze Fachwerk.

#rezept[Dreikräfteschnitt][
  + Lagerkräfte bestimmen.
  + Das Fachwerk durch einen Schnitt in zwei Teile trennen, der *drei Stäbe* durchtrennt, die *nicht alle vom selben Knoten* ausgehen.
  + Einen der beiden Teile freischneiden; die drei Stabkräfte als Zug eintragen. Das Teil ist ein starrer Körper im Gleichgewicht, mit drei Gleichgewichtsbedingungen für drei Unbekannte.
  + Für jede gesuchte Stabkraft die *Momentenbedingung um den Schnittpunkt der beiden anderen* Stäbe ansetzen. Sind die beiden anderen parallel, nimmt man stattdessen die Komponentenbedingung senkrecht zu ihnen.
]

#bsp[Stabkraft 6 direkt][
  Schnitt durch die Stäbe 2, 3, 6; linker Teil (Abbildung oben rechts). Die Stäbe 2 und 3 schneiden sich in $C$. Momentenbedingung um $C$ (positiv gegen den Uhrzeigersinn): Die Lagerkraft $F\/2$ in $A$ hat den Hebelarm $2a$ und dreht im Uhrzeigersinn, also $-2a dot.c F\/2 = -a F$. $S_6$ wirkt im Abstand $a$ über $C$ nach rechts, auch im Uhrzeigersinn: $-a S_6$.
  $ -a F - a S_6 = 0 quad => quad S_6 = -F. $
  Dasselbe wie oben, in einer Zeile und ohne die Stäbe 1, 2, 3 zu berechnen.
]

== PdvL am Fachwerk

Entfernt man den Stab mit der gesuchten Kraft und ersetzt ihn durch die beiden Kräfte $S$ an seinen Endknoten, wird das statisch bestimmte Fachwerk zu einem Mechanismus mit einem Freiheitsgrad. Man bestimmt für eine zulässige virtuelle Bewegung die Geschwindigkeiten der belasteten Knoten und der beiden Endknoten des entfernten Stabs (Momentanzentren der starr bleibenden Teilfachwerke!) und setzt $tilde(PP) = 0$.

#bsp[Stab 6 mit dem PdvL][
  Stab 6 entfernen. Das linke Dreieck $A D C$ dreht sich um das Lager $A$ mit $tilde(omega)$ (gegen den Uhrzeigersinn). Dann ist $vv_C = (0, 2a tilde(omega))$ vertikal und $vv_D = tilde(omega) a (-1, 1)$. Das rechte Dreieck $C E B$ hat $vv_C$ vertikal und $vv_B$ horizontal (Loslager); die Senkrechten schneiden sich in $B$, also ist $B$ sein Momentanzentrum mit Rotation $-tilde(omega)$, und $vv_E = tilde(omega) a (1, 1)$.

  Leistungen: $S_6$ zieht $D$ nach rechts und $E$ nach links, $F$ nach unten in $C$:
  $ tilde(PP) = S_6 (-tilde(omega) a) + (-S_6)(tilde(omega) a) + (-F)(2 a tilde(omega)) = 0 quad => quad S_6 = -F. $
]

Beim Wählen des virtuellen Zustands achtet man darauf, dass er den Satz der projizierten Geschwindigkeiten _am entfernten Stab verletzt_ und sonst mit allen übrigen Bindungen (inneren und äusseren) verträglich ist. Dann erscheinen bei reibungsfreien Bindungen keine überflüssigen Unbekannten: Auch die Lagerkräfte tragen nichts bei und müssen für die gesuchte Stabkraft gar nicht berechnet werden. Der Zustand ist ein wirklicher Bewegungszustand des Mechanismus, deshalb kann man die Tildes zur Vereinfachung weglassen.

== Räumliche Fachwerke

Alles überträgt sich: Knotengleichgewicht mit drei Gleichungen pro Knoten ($sum X = sum Y = sum Z = 0$), Beginn an einem Knoten mit höchstens drei Unbekannten. Die Komponenten einer Stabkraft erhält man, indem man $S$ mit dem Einheitsvektor in Stabrichtung multipliziert:
$ vS = S (arrow(P Q)) / (|arrow(P Q)|) wide ("Stab von Knoten" P "nach" Q, "Kraft auf Knoten" P). $
Ein typisches Beispiel: ein räumliches Fachwerk aus $s = 12$ Stäben und $k = 6$ Knoten, gelagert mit einem Kugelgelenk (3 Komponenten), zwei Auflagern und einem Seil (je 1 Komponente), also $r = 6$ und $u = 12 + 6 - 18 = 0$. Die Lagerkräfte findet man am schnellsten mit Momentenbedingungen um Achsen, die möglichst viele unbekannte Lagerkräfte schneiden (Kapitel 6). Für das Knotengleichgewicht braucht man von jeder Stabkraft die Komponenten: Einheitsvektor aus den Koordinaten der Endknoten, mal $S$. Oft trägt ein Stab bei einem bestimmten Lastfall gar keine Kraft. Weglassen darf man ihn trotzdem nicht: Ohne ihn wäre das Fachwerk beweglich, und bei einem anderen Lastfall trägt er. Handrechnungen räumlicher Fachwerke sind aufwendig und fehleranfällig; in der Praxis rechnet man mit dem Computer und kontrolliert einzelne Stäbe von Hand.

Die räumliche Grundfigur ist das Tetraeder (vier Knoten, sechs Stäbe).

#fehler[
  - Stabkräfte am Knoten mal als Zug, mal als Druck eintragen und die Vorzeichen durcheinanderbringen. Immer als Zug ansetzen.
  - Lasten mitten auf einem Stab: Dann ist es kein ideales Fachwerk mehr, der Stab wird gebogen.
  - Ritter-Schnitt durch drei Stäbe, die sich in einem Knoten treffen: liefert nichts.
]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Fachwerke sind überall.* Brücken, Kräne, Hochspannungsmasten, Dachstühle, der Eiffelturm und die Streben im Flugzeugflügel sind Fachwerke: Dreiecke aus geraden Stäben, die nur Zug oder Druck aufnehmen. Dreiecke sind steif, Vierecke nicht, deshalb setzt man auf jeder Baustelle schräge Streben ein. Der Stab ist dabei nur so schwer wie nötig, weil man ihm nur eine einzige Aufgabe gibt: längs zu halten. Das ist der Grund, warum eine Fachwerkbrücke bei gleicher Spannweite deutlich weniger Stahl braucht als ein Vollwandträger.]

#alltag[*Nullstäbe und Knotenverfahren in der Praxis.* Beim Knotenverfahren zeichnet man um jeden Knoten ein Kräftegleichgewicht. Dabei findet man Stäbe, die gar keine Kraft führen (Nullstäbe). Sie sind nicht überflüssig: Sie verhindern, dass sich ein anderer Stab seitlich verformt (knickt), und halten das System bei geänderter Last stabil. Wer ein Fachwerk entwirft, rechnet mit mehreren Lastfällen (Schnee, Wind, Verkehr), und ein Stab, der für den einen Fall ein Nullstab ist, trägt im nächsten.]

#photo(("m_fachwerk",), [Eine Eisenbahnbrücke als Fachwerk: Dreiecke aus Stäben, die nur auf Zug und Druck beansprucht werden. #credit[Asurnipal, CC BY-SA 4.0, Wikimedia Commons]], ht: 5cm)
// ALLTAG-END

#kurz[
  - Ideales Fachwerk: gelenkige Knoten, Lasten nur in Knoten, Stäbe sind Pendelstützen.
  - Eine Unbekannte pro Stab; $S > 0$ Zug, $S < 0$ Druck.
  - $u = s + r - 2k$ (eben), $u = s + r - 3k$ (räumlich).
  - Knotengleichgewicht für alle Stabkräfte, Ritter-Schnitt für einzelne, PdvL für einzelne bei einfacher Kinematik.
]
