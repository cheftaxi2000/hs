#import "lib.typ": *

= Statik der Systeme

Die meisten Konstruktionen bestehen aus mehreren Körpern, die durch Gelenke, Seile oder Federn verbunden sind. Am Gesamtsystem allein kommt man dann oft nicht weiter: Es gibt mehr Unbekannte als die drei (eben) bzw. sechs (räumlich) Gleichgewichtsbedingungen hergeben. Zwei Wege führen zum Ziel: *Zerlegen* und den Hauptsatz auf jedes Teil anwenden, oder das *PdvL* mit einem geschickt gewählten virtuellen Bewegungszustand.

== Behandlung mit dem Hauptsatz: Zerlegen

Schneidet man ein System an einer Verbindung auf, so werden die inneren Bindungskräfte an der Schnittstelle zu äußeren Kräften der Teile. Nach dem Reaktionsprinzip gilt:

#merke[
  An einer Schnittstelle trägt man die Verbindungskräfte an beiden Teilen *entgegengesetzt gleich* ein: $B_x, B_y$ am einen Teil, $-B_x, -B_y$ am anderen. Man führt also pro Gelenk nur zwei neue Unbekannte ein, nicht vier. Für jeden freigeschnittenen starren Körper stehen dann wieder drei (eben) Gleichgewichtsbedingungen zur Verfügung.
]

Die Gleichungen am Gesamtsystem sind die Summe der Gleichungen an den Teilen und bringen nichts Neues -- aber sie sind oft der bequemste Einstieg, weil in ihnen die Gelenkkräfte nicht vorkommen.

#fig(13.4, 5.0, caption: [Stehleiter auf reibungsfreiem Boden, zusammengehalten durch ein Seil in halber Höhe. Links das System, in der Mitte der Freischnitt des Ganzen, rechts der freigeschnittene linke Holm.],
  // System
  hatch((0.2,0.5),(4.4,0.5)),
  beam((0.8,0.5),(2.3,4.1)), beam((3.8,0.5),(2.3,4.1)), gelenk((2.3,4.1)),
  li((1.55,2.3),(3.05,2.3), s: 0.8pt + black),
  arr((2.3,5.0),(2.3,4.2), c: cf, w: 1.3pt), lbl((2.6,4.85), $vG$, c: cf),
  arc((2.3,4.1), 1.0, 247.4, 270, w: 0.5pt), dl((2.3,4.1),(2.3,2.6)), lbl((2.12,2.9), $beta$, size: 8pt),
  lbl((0.55,0.8), $A$), lbl((4.05,0.8), $B$), lbl((1.95,4.25), $C$), lbl((1.25,3.0), $L$, c: cg, size: 8pt),
  // Gesamt-Freischnitt
  beam((5.4,0.5),(6.9,4.1), c: cg), beam((8.4,0.5),(6.9,4.1), c: cg), li((6.15,2.3),(7.65,2.3), s: 0.6pt + cg),
  arr((6.9,5.0),(6.9,4.2), c: cf, w: 1.3pt), lbl((7.2,4.85), $vG$, c: cf),
  arr((5.4,-0.4),(5.4,0.45), c: cf, w: 1.3pt), arr((8.4,-0.4),(8.4,0.45), c: cf, w: 1.3pt),
  lbl((5.85,-0.15), $N_A$, c: cf), lbl((8.85,-0.15), $N_B$, c: cf),
  // linker Holm
  beam((10.2,0.5),(11.7,4.1)),
  arr((10.2,-0.4),(10.2,0.45), c: cf, w: 1.3pt), lbl((10.65,-0.15), $N_A$, c: cf),
  arr((10.95,2.3),(12.05,2.3), c: cf, w: 1.3pt), lbl((12.25,2.3), $S$, c: cf),
  arr((11.7,4.1),(12.6,4.1), c: cf, w: 1.3pt), arr((11.7,4.1),(11.7,3.3), c: cf, w: 1.3pt),
  lbl((12.85,4.1), $C_x$, c: cf), lbl((12.05,3.4), $C_y$, c: cf), pt((11.7,4.1)),
  pb: 0.5,
)

#bsp[Stehleiter -- Lösung durch Zerlegen][
  Zwei gleiche, gewichtslose Holme der Länge $L$, oben gelenkig verbunden, je um $beta$ gegen die Vertikale geneigt. Oben im Gelenk wirkt die Last $G$. Gesucht ist die Seilkraft $S$.

  _Gesamtsystem:_ Symmetrie (oder Momentenbedingung um $A$) liefert $N_A = N_B = G \/ 2$. Die Seilkraft ist eine innere Kraft und erscheint hier nicht.

  _Linker Holm, Momentenbedingung um $C$_ (dort fallen die unbekannten Gelenkkräfte heraus): $N_A$ hat den Hebelarm $L sin beta$, die Seilkraft greift in halber Höhe an und hat den Hebelarm $(L\/2) cos beta$.
  $ N_A L sin beta - S L/2 cos beta = 0 quad => quad S = 2 N_A tan beta = G tan beta. $
  Je weiter die Leiter gespreizt ist, desto größer die Seilkraft; bei $beta -> 90°$ wächst sie über alle Grenzen.
]

== Behandlung mit dem PdvL

Sucht man nur _eine_ Größe, ist das PdvL oft schneller. Das Rezept:

#rezept[PdvL an Systemen][
  + Die Bindung, deren Kraft gesucht ist, *lösen* und durch die (unbekannte) Bindungskraft ersetzen. Das System wird dadurch zu einem Mechanismus mit einem Freiheitsgrad.
  + Einen *zulässigen virtuellen Bewegungszustand* dieses Mechanismus wählen (alle übrigen Bindungen einhalten) und mit der Kinematik aus Kapitel 3 die virtuellen Geschwindigkeiten der Angriffspunkte aller Kräfte bestimmen, die Leistung haben.
  + $tilde(PP) = sum vF_i dot.c tilde(vv)_i = 0$ aufschreiben. Die virtuelle Schnelligkeit kürzt sich heraus, übrig bleibt die gesuchte Kraft.
]

#bsp[Stehleiter -- Lösung mit dem PdvL][
  Seil entfernen, durch die Kräfte $S$ ersetzen, die die Holme nach innen ziehen. Virtuelle Bewegung: Die Leiter spreizt sich, $beta$ wächst mit $tilde(dot(beta))$. Die Böden sind reibungsfrei, $N_A, N_B$ stehen senkrecht auf den Geschwindigkeiten der Fußpunkte und leisten nichts; die Gelenkkräfte in $C$ sind innere Kräfte eines reibungsfreien Gelenks und leisten zusammen nichts.

  Höhe des Gelenks: $h = L cos beta$, also sinkt $C$ mit $-tilde(dot(h)) = L sin beta thin tilde(dot(beta))$. Leistung von $G$: $+G L sin beta thin tilde(dot(beta))$.

  Abstand der Seilanschlüsse: $w = 2 dot.c (L\/2) sin beta = L sin beta$, wächst mit $tilde(dot(w)) = L cos beta thin tilde(dot(beta))$. Die Seilkräfte wirken dem entgegen: Leistung $-S L cos beta thin tilde(dot(beta))$.
  $ tilde(PP) = (G L sin beta - S L cos beta) tilde(dot(beta)) = 0 quad => quad S = G tan beta. $
  Eine Gleichung, eine Unbekannte, kein Freischnitt der Einzelteile.
]

#intu[
  Das PdvL ist das Hebelgesetz in allgemeiner Form: «Was man an Kraft spart, muss man an Weg zulegen.» Beim Flaschenzug zieht man mit kleiner Kraft, aber viel Seil; die Last hebt sich nur wenig. Leistung hinein = Leistung heraus. Wenn du bei einer Maschine das Übersetzungsverhältnis der _Geschwindigkeiten_ kennst, kennst du sofort das umgekehrte Verhältnis der _Kräfte_.
]

== Statisch unbestimmte Systeme

Für ein System aus mehreren Körpern zählt man über alle Teile: $m$ = Anzahl aller Gleichgewichtsbedingungen (eben: 3 pro starrem Körper), $n$ = Anzahl aller unbekannten Lager- und Verbindungskraftkomponenten.

#defn[Grad der statischen Unbestimmtheit][
  Ist $m = n$ am Gesamtsystem und allen Teilsystemen, so ist das System *statisch bestimmt*. Muss man $u$ Bindungskomponenten lösen, um es gerade noch unbeweglich zu machen, heißt es *$u$-fach statisch unbestimmt*, und es gilt
  #gl($ n - m = u. $)
]

#bsp[Dreigelenkbogen][
  Zwei Träger, gelenkig in $A$ und $B$ gelagert und im Scheitel $C$ gelenkig verbunden. Am Gesamtsystem: 4 Unbekannte ($A_x, A_y, B_x, B_y$), 3 Gleichungen -- scheinbar unbestimmt. Zerlegt in $C$: 2 Körper $times$ 3 Gleichungen $= 6$, Unbekannte $4 + 2 = 6$. Statisch bestimmt. Vorgehen: Am Gesamtsystem liefern die Momentenbedingungen um $A$ und $B$ die vertikalen Komponenten; die horizontalen folgen erst aus der Momentenbedingung um $C$ an einem der beiden Teile.
]

#fig(13, 3.4, caption: [Abzählen allein kann täuschen. Links: Dreigelenkbogen, $n = m = 6$, statisch bestimmt. Rechts: Drei Auflager, $n = m = 3$ -- aber alle drei Wirkungslinien sind parallel. Nichts hält den Träger horizontal; er ist _nicht_ brauchbar gelagert.],
  beam((0.8,0.8),(2.9,2.9)), beam((2.9,2.9),(5.0,0.8)), festlager((0.8,0.8)), festlager((5.0,0.8)), gelenk((2.9,2.9)),
  lbl((0.5,1.1), $A$), lbl((5.3,1.1), $B$), lbl((2.9,3.2), $C$),
  // drei Auflager
  beam((7.6,1.4),(12.6,1.4)),
  loslager((8.2,1.4), s: 0.28), loslager((10.1,1.4), s: 0.28), loslager((12.0,1.4), s: 0.28),
  dl((8.2,1.4),(8.2,3.0), c: cf), dl((10.1,1.4),(10.1,3.0), c: cf), dl((12.0,1.4),(12.0,3.0), c: cf),
  lbl((10.1,3.25), [parallele Wirkungslinien], size: 8pt, c: cf),
  arr((6.5,1.75),(7.5,1.75), c: cv, w: 0.9pt, dash: "dashed"), lbl((6.6,2.05), $tilde(vv)$, c: cv, size: 8pt),
)

#merke[
  Die Bedingung $n = m$ ist notwendig, aber nicht hinreichend. Zusätzlich muss das Gleichungssystem eindeutig lösbar sein. Anschaulich: Schneiden sich in der Ebene die Wirkungslinien aller Lagerkräfte in *einem Punkt* (oder sind sie alle parallel), so kann keine von ihnen ein Moment um diesen Punkt aufbringen (bzw. keine Kraft quer dazu) -- das System ist beweglich, obwohl die Zahlen stimmen. Solche Lagerungen heißen auch _statisch unbrauchbar_.
]

Statisch unbestimmte Systeme lassen sich erst lösen, wenn man die Verformungen einbezieht (Festigkeitslehre, Mechanik 2).

#kurz[
  - Zerlegen: Verbindungskräfte an beiden Teilen entgegengesetzt gleich eintragen; pro Körper 3 Gleichungen (eben).
  - Gesamtsystem zuerst: dort fehlen die inneren Kräfte.
  - PdvL: gesuchte Bindung lösen, zulässige virtuelle Bewegung, $tilde(PP) = 0$.
  - $n - m = u$; aber $n = m$ garantiert noch keine brauchbare Lagerung.
]
