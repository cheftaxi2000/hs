#import "lib.typ": *

= Statik der Systeme

Die meisten Konstruktionen bestehen aus mehreren Körpern, die durch Gelenke, Seile oder Federn verbunden sind. Am Gesamtsystem allein kommt man dann oft nicht weiter: Es gibt mehr Unbekannte, als die drei (eben) bzw. sechs (räumlich) Gleichgewichtsbedingungen hergeben. Zwei Wege führen zum Ziel: *Zerlegen* und den Hauptsatz auf jedes Teil anwenden, oder das *PdvL* mit einem geschickt gewählten virtuellen Bewegungszustand.

== Behandlung mit dem Hauptsatz: Zerlegen

Schneidet man ein System an einer Verbindung auf, so werden die inneren Bindungskräfte an der Schnittstelle zu äußeren Kräften der Teile. Nach dem Reaktionsprinzip gilt:

#merke[
  An einer Schnittstelle trägt man die Verbindungskräfte an beiden Teilen *entgegengesetzt gleich* ein: $B_x, B_y$ am einen Teil, $-B_x, -B_y$ am anderen. Man führt also pro Gelenk nur zwei neue Unbekannte ein, nicht vier. Für jeden freigeschnittenen starren Körper stehen dann wieder drei (eben) Gleichgewichtsbedingungen zur Verfügung.
]

Die Gleichungen am Gesamtsystem sind die Summe der Gleichungen an den Teilen und bringen nichts Neues, aber sie sind oft der bequemste Einstieg, weil in ihnen die Gelenkkräfte nicht vorkommen.

*Warum Zerlegen unverzichtbar ist.* Am Gesamtsystem reichen die drei Gleichgewichtsbedingungen oft nicht aus, auch wenn das System statisch bestimmt ist. Die Information, die in den inneren Bindungen steckt (Gelenke, Federn, Seile, Auflager zwischen den Teilen), kommt erst durch das Zerlegen in die Gleichungen. Dann ist aber nicht jede der vielen Gleichungen nötig: Eine geschickte Kombination von Momentenbedingungen am Gesamtsystem und an einzelnen Teilen führt oft schneller ans Ziel als das Lösen des ganzen Gleichungssystems.

#bsp[Mechanismus mit Feder][
  Ein Stab $A D$ (Länge $2L$, Gewicht $2G$) ist in $A$ gelagert und in seiner Mitte $B$ gelenkig mit dem Stab $B C$ (Länge $L$, Gewicht $G$) verbunden. In $C$ drückt ein reibungsfrei geführter Kolben (Gewicht vernachlässigbar) auf eine lineare Druckfeder (Federkonstante $k$), die bei $phi = 0$ ungespannt wäre und sich in der Ruhelage um $Delta x = 2 L sin phi$ verkürzt. In $D$ greift die Last $P$ an. Gesucht ist die Beziehung zwischen $P$ und dem Winkel $phi$ in der Ruhelage.

  Am Gesamtsystem (Kolben, beide Stäbe) sind die äußeren Kräfte die beiden Gewichte, $P$, die Gelenkkraft in $A$ ($A_x, A_y$), die Federkraft in $C$ und die Normalkraft $N$ der Kolbenführung. Das sind vier Unbekannte ($A_x, A_y, N$ und die gesuchte $P(phi)$) bei nur drei Gleichungen, aber das Problem ist nicht unbestimmt: Zerlegt man in $B$, kommen zwei Gelenkkraftkomponenten $B_x, B_y$ dazu (am zweiten Stab entgegengesetzt), und für zwei Körper hat man sechs Gleichungen für sechs Unbekannte. Man muss sie aber nicht alle lösen. Die Momentenbedingung um $A$ für das _Gesamtsystem_ enthält $A_x, A_y$ nicht, und die Momentenbedingung um $B$ für den _Stab $B C$_ liefert die Federkraft. Aus beiden folgt die gesuchte Beziehung $P(phi)$, in der die Federkraft $F = k Delta x = 2 k L sin phi$ vorkommt (ihre genaue Gestalt hängt von der Richtung und dem Angriffspunkt von $P$ ab; sie steht in Abschnitt 10.1 des Buchs). Eine wichtige Aussage kann man trotzdem ablesen: $P$ kann nur dann in die vorgesehene Richtung wirken, wenn die Federkraft das Gewicht übertrifft, also $2 k L sin phi > G$ gilt. Bei einer zu weichen Feder, $k < G\/(2L)$, lässt sich das in keiner Lage erfüllen (denn $sin phi <= 1$), es sei denn, man kehrt den Richtungssinn von $P$ um.
]

#fg("k10_leiter", [Stehleiter auf reibungsfreiem Boden, zusammengehalten durch ein Seil in halber Höhe. Links das System, in der Mitte der Freischnitt des Ganzen (das Seil ist innen, die Böden liefern $N_A, N_B$), rechts der freigeschnittene linke Holm.])

#bsp[Stehleiter: Lösung durch Zerlegen][
  Zwei gleiche, gewichtslose Holme der Länge $L$, oben gelenkig verbunden, je um $beta$ gegen die Vertikale geneigt. Oben im Gelenk wirkt die Last $G$. Das Seil hängt in halber Höhe. Gesucht: die Seilkraft $S$.

  _Gesamtsystem:_ Die Symmetrie (oder die Momentenbedingung um $A$) liefert $N_A = N_B = G\/2$. Die Seilkraft ist eine innere Kraft und erscheint hier nicht.

  _Linker Holm, Momentenbedingung um $C$_ (dort fallen die unbekannten Gelenkkräfte heraus): $N_A$ hat den Hebelarm $L sin beta$, die Seilkraft greift in halber Höhe an und hat den Hebelarm $(L\/2) cos beta$.
  $ N_A L sin beta - S dot.c (L/2) cos beta = 0 quad => quad S = 2 N_A tan beta = G tan beta. $
  Je weiter die Leiter gespreizt ist, desto größer die Seilkraft; für $beta -> 90°$ wächst sie über alle Grenzen.
]

== Behandlung mit dem PdvL

Sucht man nur _eine_ Größe, ist das PdvL oft schneller.

#rezept[PdvL an Systemen][
  + Die Bindung, deren Kraft gesucht ist, *lösen* und durch die (unbekannte) Bindungskraft ersetzen. Das System wird dadurch zu einem Mechanismus mit einem Freiheitsgrad.
  + Einen *zulässigen virtuellen Bewegungszustand* dieses Mechanismus wählen (alle übrigen Bindungen einhalten). Mit der Kinematik aus Kapitel 3 die virtuellen Geschwindigkeiten der Angriffspunkte aller Kräfte bestimmen, die Leistung haben.
  + $tilde(PP) = sum vF_i dot.c tilde(vv)_i = 0$ aufschreiben. Die virtuelle Schnelligkeit kürzt sich heraus, übrig bleibt die gesuchte Kraft.
]

#bsp[Stehleiter: Lösung mit dem PdvL][
  Seil entfernen und durch die Kräfte $S$ ersetzen, die die Holme nach innen ziehen. Virtuelle Bewegung: Die Leiter spreizt sich, $beta$ wächst mit $dot(tilde(beta))$. Die Böden sind reibungsfrei: $N_A, N_B$ stehen senkrecht auf den Geschwindigkeiten der Fußpunkte und leisten nichts. Das Gelenk in $C$ ist reibungsfrei, seine inneren Kräfte leisten zusammen nichts.

  Die Höhe des Gelenks ist $h = L cos beta$, es sinkt also mit $-dot(h) = L sin beta thin dot(tilde(beta))$. Leistung von $G$: $+G L sin beta thin dot(tilde(beta))$.

  Der Abstand der Seilanschlüsse ist $w = 2 dot.c (L\/2) sin beta = L sin beta$ und wächst mit $dot(w) = L cos beta thin dot(tilde(beta))$. Die Seilkräfte wirken dem entgegen: Leistung $-S L cos beta thin dot(tilde(beta))$.
  $ tilde(PP) = (G L sin beta - S L cos beta) dot(tilde(beta)) = 0 quad => quad S = G tan beta. $
  Eine Gleichung, eine Unbekannte, kein Freischnitt der Einzelteile.
]

Die Verfahren im Überblick: Das PdvL betrachtet das System _ohne Zerlegung_ in der Ruhelage, führt die Lasten (und nur die gesuchten Bindungskräfte) ein, wählt einen zweckmäßigen virtuellen Bewegungszustand und löst $tilde(PP) = 0$. Zwei Faustregeln für die Wahl:

+ Will man eine Beziehung zwischen Lasten und Lage (wie im Mechanismus mit Feder), wählt man einen _zulässigen_ Zustand, der mit allen Bindungen verträglich ist. Die reibungsfreien Bindungskräfte, die nicht interessieren, tragen dann nichts bei.
+ Will man eine _Bindungskraft_ ermitteln, wählt man einen Zustand, der genau diese Bindung verletzt und mit allen anderen verträglich ist. Dann trägt nur die gesuchte Kraft zur Leistung bei.

Beim Mechanismus mit Feder dreht man zum Beispiel $A D$ virtuell mit $dot(tilde(phi))$ um $A$; aus den Richtungen der Geschwindigkeiten in $B$ und $C$ folgt das Momentanzentrum von $B C$, der Stab dreht mit demselben Betrag $dot(tilde(phi))$ in umgekehrter Richtung, und mit den Geschwindigkeiten der Schwerpunkte und von $C$ bekommt man die Leistungen der Gewichte, der Last $P$ und der Federkraft. Will man dagegen die Führungskraft $N$ wissen, dreht man das ganze System starr um $A$, wobei der Kolben von der Führungsrichtung abweicht: In $C$ entsteht eine Geschwindigkeit in Richtung von $N$, und nur $N$ taucht zusätzlich in der Gleichung auf.

#bsp[Differentialflaschenzug][
  Ein Differentialflaschenzug hat eine obere Spule mit zwei festen Radien $a > b$ und eine bewegliche untere Rolle. Die (gewichtslosen, undehnbaren) Seile haften auf den Rollen und hängen, soweit sie frei sind, senkrecht. Last $Q$ (inklusive Gewicht der unteren Rolle) hängt an der unteren Rolle; am freien Seilende wirkt die Zugkraft $P$. Als virtuellen Zustand nehmen wir den wirklichen, bei dem das freie Ende mit Schnelligkeit $v$ nach unten läuft. Das Momentanzentrum der oberen Spule liegt auf ihrer Achse; die beiden freien Seilstücke links laufen mit $v$ und $b v\/a$. Diese Geschwindigkeiten übertragen sich auf die untere Rolle, deren Momentanzentrum auf dem horizontalen Durchmesser liegt, im Abstand $c = (a - b)\/2$ vom Mittelpunkt. Ihr Mittelpunkt (und damit der Angriffspunkt von $Q$) steigt mit der Schnelligkeit $v (a - b)\/(2a)$. Das Gewicht der oberen Spule leistet nichts. Das PdvL ergibt $P v - Q v (a - b)\/(2a) = 0$, also
  $ P = Q (a - b) / (2a). $
  Wählt man $a$ und $b$ fast gleich, kann $P$ beliebig klein gegen $Q$ werden. Der Preis: Das Seilende muss sehr weit gezogen werden, die Last hebt sich nur ein wenig. Genau das drückt der Name «Differentialflaschenzug» aus.
]

#intu[
  Das PdvL ist das Hebelgesetz in allgemeiner Form: Was man an Kraft spart, muss man an Weg zulegen. Beim Flaschenzug zieht man mit kleiner Kraft, aber viel Seil, die Last hebt sich nur wenig. Leistung hinein = Leistung heraus. Kennt man bei einer Maschine das Übersetzungsverhältnis der _Geschwindigkeiten_, kennt man sofort das umgekehrte Verhältnis der _Kräfte_.
]

== Statisch unbestimmte Systeme

Für ein System aus mehreren Körpern zählt man über alle Teile: $m$ = Anzahl aller Gleichgewichtsbedingungen (eben: 3 pro starrem Körper), $n$ = Anzahl aller unbekannten Lager- und Verbindungskraftkomponenten.

#defn[Grad der statischen Unbestimmtheit][
  Ist $m = n$ am Gesamtsystem und an allen Teilsystemen, so heißt das System *statisch bestimmt*. Muss man $u$ Bindungskomponenten lösen, um es gerade noch unbeweglich zu machen, ist es *$u$-fach statisch unbestimmt*, und es gilt
  #gl($ n - m = u. $)
]

#fg("k10_dreigelenk", [Der Dreigelenkbogen: Das Gesamtsystem hat 4 Unbekannte und nur 3 Gleichungen, aber nach dem Zerlegen im Gelenk $C$ sind es 6 Unbekannte und 6 Gleichungen. Er ist statisch bestimmt.])

#bsp[Dreigelenkbogen][
  Zwei Träger, in $A$ und $B$ gelenkig gelagert und im Scheitel $C$ gelenkig verbunden. Am Gesamtsystem: 4 Unbekannte ($A_x, A_y, B_x, B_y$) und 3 Gleichungen. Zerlegt in $C$: 2 Körper mal 3 Gleichungen $= 6$; Unbekannte $4 + 2 = 6$ (nämlich $C_x, C_y$ kommen dazu). Statisch bestimmt. Vorgehen: Am Gesamtsystem liefern die Momentenbedingungen um $A$ und um $B$ die vertikalen Komponenten $B_y$ und $A_y$. Die horizontalen Komponenten folgen erst aus der Momentenbedingung um $C$ an einem der beiden Teile, denn nur dort kommt $A_x$ (bzw. $B_x$) mit einem Hebelarm vor.
]

#fg("k10_unbrauchbar", [Abzählen allein kann täuschen. Links: Drei Auflager, $n = m = 3$, aber alle Wirkungslinien sind parallel. Nichts hält den Träger horizontal, die Lagerung ist unbrauchbar. Rechts: Alle Wirkungslinien gehen durch einen Punkt $P$. Der Träger kann sich momentan um $P$ drehen.])

#merke[
  Die Bedingung $n = m$ ist notwendig, aber nicht hinreichend. Zusätzlich muss das Gleichungssystem eindeutig lösbar sein. Anschaulich: Schneiden sich in der Ebene die Wirkungslinien aller Lagerkräfte in *einem Punkt* (oder sind sie alle parallel), kann keine von ihnen ein Moment um diesen Punkt aufbringen (bzw. eine Kraft quer dazu). Das System ist beweglich, obwohl die Zahlen stimmen. Solche Lagerungen heißen auch _statisch unbrauchbar_.
]

Man kann ein System also auf zwei Arten als statisch unbestimmt erkennen. *Statisch:* Man vergleicht die Anzahl $n$ der Unbekannten mit der Anzahl $m$ der zur Verfügung stehenden unabhängigen Gleichgewichtsbedingungen, bei Bedarf nach dem Zerlegen. Ist $m = n$ für das Gesamtsystem und alle Teilsysteme, heißt es statisch bestimmt; für $m < n$ statisch unbestimmt; für $m > n$ _überbestimmt_: Ein Mechanismus, der im Allgemeinen nicht in Ruhe bleibt, weil die nötigen Gleichgewichtsbedingungen nicht erfüllt werden können. (Man nennt solche Systeme auch «verschieblich» oder «kinematisch unbestimmt»; man richtet dann den Blick auf zu wenige Bindungen statt auf zu viele Gleichungen.) *Kinematisch:* Ein statisch unbestimmtes System hat mehr Bindungskomponenten, als für die Ruhe nötig sind. Hebt man $u$ Bindungskomponenten auf, und es bleibt gerade noch unbeweglich, aber bei einer weiteren wird es zum beweglichen Mechanismus, ist es $u$-fach statisch unbestimmt. Die Existenz eines zulässigen virtuellen Bewegungszustands mit nichtverschwindenden Geschwindigkeiten zeigt, dass das System ein Mechanismus ist. Bei der Beurteilung der Unbeweglichkeit zählt zunächst nur, ob irgendeine Bewegung möglich ist, nicht, welche Kräfte dabei auftreten.

Statisch unbestimmte Systeme lassen sich erst lösen, wenn man die Verformungen einbezieht (Festigkeitslehre, Mechanik 2). Typisch ist dann der Ansatz: Zusätzliche Gleichungen aus «die Verschiebung am Lager ist null» bzw. «das Lager federt ein».

#kurz[
  - Zerlegen: Verbindungskräfte an beiden Teilen entgegengesetzt gleich eintragen; pro Körper 3 Gleichungen (eben).
  - Gesamtsystem zuerst: dort fehlen die inneren Kräfte.
  - PdvL: gesuchte Bindung lösen, zulässige virtuelle Bewegung wählen, $tilde(PP) = 0$.
  - $n - m = u$; aber $n = m$ garantiert noch keine brauchbare Lagerung.
]
