#import "lib.typ": *

= Kräfte

Bisher war alles Geometrie. Jetzt kommt die Ursache ins Spiel: die Kräfte. Eine Kraft sieht man nie direkt. Man erkennt sie an ihrer Wirkung: Etwas verformt sich, oder etwas ändert seinen Bewegungszustand. In diesem Kapitel legen wir fest, was wir unter einer Kraft verstehen wollen, welche Eigenschaften wir ihr zuschreiben, und wie wir verteilte Wirkungen beschreiben.

Wir gehen hier bewusst nicht streng axiomatisch vor, sondern stützen uns auf die Anschauung und die Erfahrung. Die Definition der Kraft ist eine Vereinbarung über Begriffe, nicht ein Beweis. Entscheidend ist, dass sie sich in der Praxis bewährt.

== Der Kraftbegriff

Kräfte treten in der Natur und in der Technik als Ursache von zwei Arten von Wirkungen auf: als Ursache von *Verformungen* (ein Seil dehnt sich, ein Balken biegt sich durch) und von *Bewegungsänderungen* (ein Stein fällt, ein Auto beschleunigt). Um zu quantitativen, nachprüfbaren Aussagen zu kommen, braucht man ein mathematisches Modell. Dieses Modell ist der _punktgebundene Vektor_.

#defn[Kraft][
  Eine *Kraft* ist ein *punktgebundener Vektor* ${A | vF}$: Zu ihr gehören
  - der *Vektoranteil* $vF$ (Betrag und Richtung) und
  - der materielle *Angriffspunkt* $A$.
  Mehrere Kräfte ${A_i | vF_i}$, $i = 1, 2, 3, dots$, bilden eine *Kräftegruppe*. Die Gerade durch $A$ in Richtung $vF$ heisst *Wirkungslinie*.
]

#intu[
  Warum reicht ein Vektor nicht? Probiere es mit einer Tür. Drückst du mit der Kraft $vF$ an der Klinke, geht sie leicht auf. Drückst du mit demselben Vektor direkt neben dem Scharnier, bewegt sich kaum etwas. Derselbe Betrag und dieselbe Richtung, aber eine völlig andere Wirkung: Der Ort, an dem die Kraft angreift, gehört zur Kraft. Deshalb schreiben wir ${A | vF}$ und nicht einfach $vF$.
]

Die Kraft ist also ein _Modellbegriff_: Sie wird als Ursache messbarer Phänomene definiert, als Wechselwirkung, die ein materielles System in Bewegung setzt, verformt oder einen vorhandenen Bewegungs- oder Verformungszustand ändert. Beispiele sind die Fallbewegung eines Gegenstands, die beschleunigte Drehung eines Turbinenrads unter dem Druck des Dampfes, die Gestaltänderung einer Stahlkugel im Kugellager oder die Durchbiegung einer Brücke unter den darauf fahrenden Fahrzeugen.

Das Experiment zeigt, dass die Wirkung einer Kraft gleich bleibt, wenn man Richtung, Betrag und Angriffspunkt beibehält. Deshalb liegt der punktgebundene Vektor nahe. Auf die Vektoranteile wendet man die Regeln der Vektorrechnung an. Greifen mehrere Kräfte im _gleichen_ Punkt an, addiert man sie nach der Parallelogrammregel zu einer *resultierenden Kraft*. Die Vektoren von Kräften mit _verschiedenen_ Angriffspunkten kann man zwar auch addieren, die Summe ist dann aber zunächst keine Kraft mit klar definiertem Angriffspunkt. Wie man damit umgeht, zeigt Kapitel 6.

#merke[
  Ein Vektor ist erst dann eine Kraft, wenn man ihn mit einer physikalischen Wechselwirkung identifiziert. In Zeichnungen darf der Angriffspunkt am Anfang oder an der Spitze des Pfeils stehen. Beschriftet man einen Pfeil mit $R$, kann das zwei Dinge heissen: der _Vektor_ $vR$ (für Rechnungen in Komponenten zerlegen) oder die _Komponente_ $R$ in Richtung des gezeichneten Pfeils (dann kann sie auch negativ sein). Ab Kapitel 9 benutzen wir die zweite Schreibweise für Lagerkräfte.
]

Die Einheit der Kraft ist das *Newton*, $1 "N" = 1 "kg" dot.c "m"\/"s"^2$ (die Kraft, die einem Körper von 1 kg die Beschleunigung $1 "m/s"^2$ gäbe). Zur Anschauung: Eine Tafel Schokolade (100 g) wiegt an der Erdoberfläche etwa 1 N, ein Mensch von 70 kg etwa 700 N, eine Tonne etwa 10 kN. Allgemein haben alle mechanischen Grössen Dimensionen, die sich auf Masse $M$, Länge $L$ und Zeit $T$ zurückführen lassen; für die Kraft ist $[F] = M L T^(-2)$.

=== Fernkräfte und Kontaktkräfte

Auf makroskopischer Ebene (ohne Moleküle zu betrachten) unterscheidet man zwei Arten.

#table(columns: (auto, 1fr, 1fr), stroke: none, inset: (x: 6pt, y: 6pt),
  table.hline(stroke: 0.7pt),
  [], [*Fernkräfte*], [*Kontaktkräfte*],
  table.hline(stroke: 0.4pt),
  [Wirkung], [über Distanz, ohne Berührung], [nur bei Berührung, an der Berührungsstelle],
  [Beispiele], [Gewicht (Gravitation), elektrische und magnetische Kräfte], [Auflagerkraft, Seilkraft, Druck, Reibung],
  [verteilt über], [das Volumen des Körpers], [die Berührungsfläche],
  table.hline(stroke: 0.7pt),
)

Beispiele für Fernkräfte: die Gravitation zwischen Sonne und Planeten, die elektromagnetischen Kräfte zwischen geladenen Teilchen, die induktiven Kräfte zwischen Stator und Rotor eines Elektromotors. Beispiele für Kontaktkräfte: die Kräfte zwischen Kugel und Ring im Kugellager, zwischen Dampf und Turbinenschaufel, zwischen Last und Träger und zwischen Träger und Stützen. Das Gewicht der Last ist dagegen eine Fernkraft (Gravitation). Berühren sich zwei Körper nicht mehr, verschwinden auch die Kontaktkräfte; Fernkräfte bleiben.

Zu den Einheiten: Das SI-Einheitensystem (auch MKS-System) geht von der Masse als dritter Grunddimension aus, neben Länge und Zeit. Die Einheit der Masse ist das Kilogramm (ursprünglich die Masse eines Liters Wasser, seit 2019 über die Planck-Konstante festgelegt), daneben Tonne und Gramm. Das ältere CGS-System verwendet Gramm und Zentimeter und kommt in manchen Publikationen noch vor; es unterscheidet sich nur durch die kleineren Einheiten.

Kräfte, die von aussen vorgegeben sind (Gewichte, Nutzlasten, Wind, Schnee), heissen *Lasten*. Kräfte, die sich erst als Antwort auf diese Lasten an Stützen, Lagern und Verbindungen einstellen, heissen *Reaktionen*, später *Bindungskräfte* oder *Lagerkräfte*. Eine wichtige Lektion der Statik ist, dass man die Lasten kennt und die Reaktionen ausrechnet.

#woche(6, [Reaktionsprinzip, Leistung], [68–82])
== Das Reaktionsprinzip

#satz[Reaktionsprinzip (Newton, actio = reactio)][
  Übt ein materieller Punkt $A_1$ auf einen zweiten, $A_2$, die Kraft ${A_2 | vF}$ aus (_Actio_), so wirkt $A_2$ seinerseits auf $A_1$ mit der Gegenkraft ${A_1 | -vF}$ (_Reactio_). Bei Fernkräften liegen beide Wirkungslinien auf der Verbindungsgeraden durch $A_1$ und $A_2$.
]

Das ist ein *Axiom*: Es wird nicht bewiesen, sondern angenommen und durch Erfahrung und Experiment bestätigt. Keine Kraft existiert ohne ihre Gegenkraft. Newton hat das Prinzip 1687 in den _Principia_ als drittes Bewegungsgesetz formuliert, ursprünglich für Massenpunkte unter Fernkräften. Wenn du mit der Hand gegen eine Wand drückst, drückt die Wand gleich stark zurück: das spürst du in der Hand. Zwei Eisläufer, die sich voneinander abstossen, fahren in entgegengesetzte Richtungen.

Zwei Präzisierungen gehören zum Prinzip.

*Wer ist wer?* Bei Kontaktkräften haben Kraft und Gegenkraft im Moment der Berührung denselben _geometrischen_ Angriffspunkt, den Berührungspunkt. Trotzdem sind es zwei verschiedene _materielle_ Punkte $A_1, A_2$, die zu verschiedenen Systemen gehören. Bezeichne sie deshalb verschieden, das verhindert Denkfehler beim Freischneiden.

*Zusatzpostulat für Fernkräfte.* Bei Fernkräften liegen die Wirkungslinien von Kraft und Gegenkraft auf der Verbindungsgeraden von $A_1$ und $A_2$. Das schliesst aus, dass Kraft und Gegenkraft zwar entgegengesetzte Vektoren haben, aber auf zwei parallelen, seitlich versetzten Wirkungslinien liegen. Solche zwei Kräfte würden ein Kräftepaar bilden (Kapitel 6) und zwei Körper ohne äussere Ursache in Drehung versetzen.

Beachte schliesslich: Die in der Dynamik später auftretenden _Trägheitskräfte_ haben keine Reaktionen. Sie entsprechen keiner physikalischen Wechselwirkung und sind nur mathematische Hilfsvorstellungen («scheinbare Kräfte»).

#fg("k04_reaktion", [Links das System aus Klotz, Tisch und Erde. Rechts auseinandergenommen: Klotz und Tisch üben aufeinander die Kontaktkräfte $vN$ und $-vN$ aus. Das Gewicht $vG$ des Klotzes ist die Anziehung durch die Erde; seine Gegenkraft $-vG$ greift an der Erde an, nicht am Tisch. Am Klotz allein heben sich $vG$ und $vN$ auf, sie sind aber _kein_ Reaktionspaar.])

#fehler[
  «Das Gewicht $vG$ und die Normalkraft $vN$ am Klotz sind gleich gross und entgegengesetzt, also sind sie actio und reactio.» Das stimmt nicht. Beide greifen am _selben_ Körper (dem Klotz) an, haben verschiedene Ursachen (Gravitation, Berührung) und sind nur im Gleichgewicht zufällig gleich gross. Lässt man den Tisch beschleunigt nach oben fahren, sind $vN$ und $vG$ verschieden, das Reaktionspaar $vN, -vN$ bleibt aber gleich gross. Merke: Actio und reactio greifen immer an *zwei verschiedenen Körpern* an. Deshalb heben sie sich an einem einzelnen Körper nie auf.
]

== Innere und äussere Kräfte

Bevor man in der Mechanik etwas rechnet, muss man sagen, _welches_ materielle System man gerade betrachtet. Man «grenzt es ab»: Man denkt sich eine geschlossene Fläche um das interessierende System. Alles innerhalb gehört zum System, alles ausserhalb ist Umgebung.

#defn[Innere und äussere Kräfte][
  Eine Kraft auf einen Punkt des Systems heisst *innere Kraft*, wenn auch der Angriffspunkt ihrer Reaktion zum System gehört; sie heisst *äussere Kraft*, wenn dieser Angriffspunkt ausserhalb des Systems liegt.
]

*Beispiel aus dem Buch.* An der Last in der Abbildung wirken die Zugkraft $Z$, das Gewicht $G$, zwei Normalkräfte $N_1, N_2$ (senkrecht zur Berührungsebene) und zwei Reibungskräfte $R_1, R_2$ (in der Berührungsebene). Wählt man nur die Last als System, sind alle diese Kräfte äussere Kräfte. Wählt man Last und Träger zusammen, bleiben $Z$ und $G$ äussere Kräfte, aber Normal- und Reibungskräfte werden innere, weil die Angriffspunkte ihrer Reaktionen auf den Träger jetzt im System liegen. Zusätzlich erscheinen die Lagerkräfte $F_A, F_B$ der Stützen als äussere Kräfte. Wo greift die Reaktion auf das Gewicht $G$ an? An der Erde: Die Last zieht die Erde mit einer gleich grossen Gegenkraft an, deren Wirkungslinie durch den Erdmittelpunkt geht. Die Lagerkräfte $F_A, F_B$ werden oft fälschlich als «Reaktionen» des Gewichts bezeichnet. Sie sind es nicht: Sie sind Wirkungen der Stützen auf den Träger, ihre Reaktionen greifen an den Stützen an.

Beim Freischneiden werden also Actio-Reactio-Paare getrennt, und man muss beide Partner mit ihren richtigen materiellen Angriffspunkten berücksichtigen.

#fg("k04_system", [Die Last wird an einem Seil mit $vZ$ über den Träger gezogen. Links ist das System nur die Last (gestrichelte Grenze, der Träger grau ausserhalb): Normalkräfte $N_1, N_2$ und Reibungskräfte $R_1, R_2$ an den Kufen sind äussere Kräfte. Rechts gehören Last und Träger zum System: $N_i, R_i$ werden innere Kräfte, stattdessen erscheinen die Lagerkräfte $vF_A, vF_B$. Weil $vZ$ waagrecht zieht, ist $vF_A$ geneigt.])

#intu[
  Ob eine Kraft innen oder aussen ist, ist keine Eigenschaft der Kraft, sondern eine Folge deiner Wahl der Systemgrenze. Jede Kraft, deren Pfeil die gestrichelte Linie von aussen nach innen durchstösst, ist eine äussere. Innere Kräfte treten immer paarweise als $vF$ und $-vF$ auf. Das hat zwei Folgen, die in der ganzen Statik wichtig sind: Erstens heben sich innere Kräfte in der Summe auf, sie fallen aus den Gleichgewichtsbedingungen des Gesamtsystems heraus. Zweitens muss man ein System _aufschneiden_, wenn man eine innere Kraft wissen will, denn dann wird sie durch die Abgrenzung zur äusseren Kraft. Das «Freischneiden» ist die wichtigste Technik der Statik.
]

== Verteilte Kräfte und Kraftdichten

Eine «Einzelkraft» in einem einzigen Punkt ist immer eine Idealisierung. Eine Stütze drückt nicht in einem Punkt auf den Balken, sondern über eine kleine Fläche; eine Kugel auf einer Ebene berührt sie nicht in einem Punkt, sondern über eine kleine Fläche, in der das Material sich verformt. Das Gewicht eines Körpers wirkt in jedem seiner Volumenelemente. Der Wasserdruck wirkt auf jedes Flächenstück der Staumauer. In der Praxis rechnet man trotzdem oft mit Einzelkräften, wenn die Ausdehnung der Kontaktzone klein gegen die Abmessungen des Systems ist. Wo das nicht gilt, beschreibt man die Kraft durch eine *Dichte*: Kraft pro Einheit von Fläche, Volumen oder Länge.

#defn[Kraftdichten][
  - Die *Flächenkraftdichte* $vs$ ist die Kontaktkraft je Flächeneinheit. Auf ein Flächenelement $dif A$ wirkt $dif vF = vs dif A$. Einheit N/m². Beispiel: Wasserdruck, Bodenpressung.
  - Die *Raumkraftdichte* $vf$ ist die Fernkraft je Volumeneinheit. Auf ein Volumenelement $dif V$ wirkt $dif vF = vf dif V$. Einheit N/m³. Beispiel: das Eigengewicht, $vf = gamma ve_g$ mit dem spezifischen Gewicht $gamma = rho g$.
  - Die *Linienkraftdichte* $vq$ ist die Kraft je Längeneinheit für Körper, die man als eindimensional modelliert (Balken, Draht). Auf ein Längenelement $dif x$ wirkt $dif vF = vq dif x$. Einheit N/m. Beispiel: Eigengewicht eines Balkens, Schneelast auf einem Träger.
]

Etwas genauer: Die Kontaktkräfte sind auf einer endlichen Fläche verteilt (_Flächenkräfte_), die Fernkräfte auf einem endlichen Raumteil (_Raumkräfte_). Betrachtet man den Körper als Kontinuum, gibt es unendlich viele Angriffspunkte. Wird das Flächenstück $Delta A$ kleiner, muss auch die zugehörige Kraft $Delta vF$ gegen null gehen, sonst wäre die Gesamtwirkung unendlich. Der Quotient bleibt endlich, und das ist die Dichte:
$ vs = lim_(Delta A -> 0) (Delta vF) / (Delta A), wide vf = lim_(Delta V -> 0) (Delta vF) / (Delta V), wide vq = lim_(Delta s -> 0) (Delta vF) / (Delta s). $
Die Flächenkraftdichte heisst in der Festigkeitslehre auch *Spannungsvektor*. Der Wasserdruck $p$ an der Staumauer ergibt $vs = -p vn$ (mit der äusseren Flächennormalen $vn$): Der Druck wirkt gegen die Wand. Das spezifische Gewicht $gamma$ ist der Betrag der Raumkraftdichte der Gravitation; die Raumkraftdichte selbst ist ein Vektor, der zum Erdmittelpunkt zeigt. Ist sie in allen Punkten gleich (uniforme Raumkraftverteilung), so ist die Gesamtkraft auf einen homogenen Körper vom Volumen $V$ einfach $G = V gamma$. Das darf man annehmen, solange die Abmessungen des Körpers klein gegen den Erdradius sind: Dann haben die Gewichte aller Volumenelemente praktisch gleiche Richtung und gleichen Betrag.

Für einen horizontalen Balken mit veränderlichem spezifischem Gewicht $gamma(x)$ und veränderlicher Querschnittsfläche $A(x)$ ist die Linienkraftdichte des Gewichts $q(x) = -gamma(x) A(x) ve_z$. Bei einem homogenen Balken mit konstantem Querschnitt ist sie konstant: $q = -A gamma ve_z$.

#fg("k04_dichte", [Linienkraftdichte $q(x)$ auf einem Balken. Auf das kurze Stück $dif x$ wirkt die Kraft $q(x) dif x$ (rot hinterlegt). Die Gesamtkraft ist die Summe (das Integral) aller dieser Teilkräfte, also die Fläche unter der Kurve.])

#bsp[Eigengewicht eines Stahlträgers][
  Ein Stahlträger mit Querschnittsfläche $A = 20 "cm"^2 = 2 dot 10^(-3) "m"^2$ und Dichte $rho = 7850 "kg/m"^3$. Das Gewicht je Längeneinheit ist Dichte mal Fläche mal Erdbeschleunigung:
  $ q = rho g A = 7850 dot 9.81 dot 2 dot 10^(-3) "N/m" approx 154 "N/m". $
  Ein Träger der Länge $L = 6$ m wiegt also $G = q L approx 925$ N. Weil $q$ hier konstant ist, ist es eine _Gleichlast_.
]

#bsp[Wasserdruck auf eine Staumauer][
  In der Tiefe $h$ herrscht der Druck $p = rho_W g h$, er steht senkrecht auf der Wand und wächst linear mit der Tiefe. Auf ein Wandstück $dif A$ wirkt die Kraft $dif F = p dif A$. Für eine Mauer der Breite $b$ ist die Linienkraftdichte (Kraft je Höhenmeter) $q(h) = p b = rho_W g b h$: eine *Dreieckslast*, die oben null ist und unten maximal. Wie man sie durch eine einzige Kraft ersetzt, zeigt Kapitel 7.
]

// ALLTAG-BEGIN
== Wo man das im Alltag und im Beruf braucht

#alltag[*Kräfte sind Vektoren: das Seil am Berg.* Ein Seil, das an einem Hang durchhängt, zieht an den Befestigungen viel stärker, als das Gewicht der Last vermuten lässt: Je flacher das Seil gespannt ist, desto grösser wird die Seilkraft. Mit zwei gleich langen Seilen unter dem Winkel $alpha$ zur Horizontalen gilt $S = G\/(2 sin alpha)$. Bei $alpha = 5 degree$ ist $S approx 5.7 G$. Darum lassen sich Slacklines kaum so spannen, dass sie nicht mehr durchhängen: Die Kraft würde ins Unendliche wachsen.]

#alltag[*Actio gleich Reactio: die Rakete.* Eine Rakete bewegt sich, weil sie Gas nach hinten stösst und das Gas sie nach vorne. Sie braucht keine Luft, an der sie sich «abstossen» könnte; das Prinzip funktioniert deshalb auch im Vakuum. Dieselbe Idee steckt in jedem Wasserschlauch: Wer den Schlauch hält, spürt die Rückstosskraft des austretenden Wassers. Feuerwehrleute brauchen deshalb zwei bis drei Personen für grosse Strahlrohre.]
// ALLTAG-END

#kurz[
  - Kraft = Vektor $vF$ *plus* Angriffspunkt $A$: ${A | vF}$. Einheit N.
  - Fernkräfte wirken im Volumen, Kontaktkräfte an Berührungsflächen. Lasten sind gegeben, Reaktionen sind gesucht.
  - Reaktionsprinzip: Zu jeder Kraft gehört eine gleich grosse Gegenkraft am _anderen_ Körper. Das Paar greift an zwei Körpern an.
  - Innen oder aussen hängt von der Systemgrenze ab. Erst abgrenzen, dann die äusseren Kräfte eintragen.
  - Verteilte Kräfte: $vs$ (N/m²), $vf$ (N/m³), $vq$ (N/m); Teilkraft = Dichte mal Element.
]
