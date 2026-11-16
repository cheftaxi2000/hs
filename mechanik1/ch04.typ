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
  Mehrere Kräfte ${A_i | vF_i}$, $i = 1, 2, 3, dots$, bilden eine *Kräftegruppe*. Die Gerade durch $A$ in Richtung $vF$ heißt *Wirkungslinie*.
]

#intu[
  Warum reicht ein Vektor nicht? Probiere es mit einer Tür. Drückst du mit der Kraft $vF$ an der Klinke, geht sie leicht auf. Drückst du mit demselben Vektor direkt neben dem Scharnier, bewegt sich kaum etwas. Derselbe Betrag und dieselbe Richtung, aber eine völlig andere Wirkung: Der Ort, an dem die Kraft angreift, gehört zur Kraft. Deshalb schreiben wir ${A | vF}$ und nicht einfach $vF$.
]

Die Einheit der Kraft ist das *Newton*, $1 "N" = 1 "kg" dot.c "m"\/"s"^2$ (die Kraft, die einem Körper von 1 kg die Beschleunigung $1 "m/s"^2$ gäbe). Zur Anschauung: Eine Tafel Schokolade (100 g) wiegt an der Erdoberfläche etwa 1 N, ein Mensch von 70 kg etwa 700 N, eine Tonne etwa 10 kN. Allgemein haben alle mechanischen Größen Dimensionen, die sich auf Masse $M$, Länge $L$ und Zeit $T$ zurückführen lassen; für die Kraft ist $[F] = M L T^(-2)$.

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

Kräfte, die von außen vorgegeben sind (Gewichte, Nutzlasten, Wind, Schnee), heißen *Lasten*. Kräfte, die sich erst als Antwort auf diese Lasten an Stützen, Lagern und Verbindungen einstellen, heißen *Reaktionen*, später *Bindungskräfte* oder *Lagerkräfte*. Eine wichtige Lektion der Statik ist, dass man die Lasten kennt und die Reaktionen ausrechnet.

== Das Reaktionsprinzip

#satz[Reaktionsprinzip (Newton, actio = reactio)][
  Übt ein materieller Punkt $A_1$ auf einen zweiten, $A_2$, die Kraft ${A_2 | vF}$ aus (_Actio_), so wirkt $A_2$ seinerseits auf $A_1$ mit der Gegenkraft ${A_1 | -vF}$ (_Reactio_). Bei Fernkräften liegen beide Wirkungslinien auf der Verbindungsgeraden durch $A_1$ und $A_2$.
]

Das ist ein *Axiom*: Es wird nicht bewiesen, sondern angenommen und durch Erfahrung und Experiment bestätigt. Keine Kraft existiert ohne ihre Gegenkraft. Newton hat das Prinzip 1684 für Massenpunkte unter Fernkräften formuliert. Wenn du mit der Hand gegen eine Wand drückst, drückt die Wand gleich stark zurück: das spürst du in der Hand. Zwei Eisläufer, die sich voneinander abstoßen, fahren in entgegengesetzte Richtungen.

#fg("k04_reaktion", [Links der Klotz auf dem Tisch. Rechts «auseinandergeschnitten»: Klotz und Tisch üben aufeinander Kräfte aus, die gleich groß und entgegengesetzt sind ($vN$ und $-vN$). Ebenso das Gewicht des Klotzes $vG$ und seine Gegenkraft $-vG$ an der Erde.])

#fehler[
  «Das Gewicht $vG$ und die Normalkraft $vN$ am Klotz sind gleich groß und entgegengesetzt, also sind sie actio und reactio.» Das stimmt nicht. Beide greifen am _selben_ Körper (dem Klotz) an, haben verschiedene Ursachen (Gravitation, Berührung) und sind nur im Gleichgewicht zufällig gleich groß. Lässt man den Tisch beschleunigt nach oben fahren, sind $vN$ und $vG$ verschieden, das Reaktionspaar $vN, -vN$ bleibt aber gleich groß. Merke: Actio und reactio greifen immer an *zwei verschiedenen Körpern* an. Deshalb heben sie sich an einem einzelnen Körper nie auf.
]

== Innere und äußere Kräfte

Bevor man in der Mechanik etwas rechnet, muss man sagen, _welches_ materielle System man gerade betrachtet. Man «grenzt es ab»: Man denkt sich eine geschlossene Fläche um das interessierende System. Alles innerhalb gehört zum System, alles außerhalb ist Umgebung.

#defn[Innere und äußere Kräfte][
  Eine Kraft auf einen Punkt des Systems heißt *innere Kraft*, wenn auch der Angriffspunkt ihrer Reaktion zum System gehört; sie heißt *äußere Kraft*, wenn dieser Angriffspunkt außerhalb des Systems liegt.
]

#fg("k04_system", [Dieselbe Berührungskraft zwischen Last und Träger ist _äußere_ Kraft, wenn das System nur die Last ist (links, gestrichelte Grenze), und _innere_ Kraft, wenn Last und Träger zusammen das System bilden (rechts). Im rechten Fall erscheinen stattdessen die Lagerkräfte als äußere Kräfte.])

#intu[
  Ob eine Kraft innen oder außen ist, ist keine Eigenschaft der Kraft, sondern eine Folge deiner Wahl der Systemgrenze. Jede Kraft, deren Pfeil die gestrichelte Linie von außen nach innen durchstößt, ist eine äußere. Innere Kräfte treten immer paarweise als $vF$ und $-vF$ auf. Das hat zwei Folgen, die in der ganzen Statik wichtig sind: Erstens heben sich innere Kräfte in der Summe auf, sie fallen aus den Gleichgewichtsbedingungen des Gesamtsystems heraus. Zweitens muss man ein System _aufschneiden_, wenn man eine innere Kraft wissen will, denn dann wird sie durch die Abgrenzung zur äußeren Kraft. Das «Freischneiden» ist die wichtigste Technik der Statik.
]

== Verteilte Kräfte und Kraftdichten

Eine «Einzelkraft» in einem einzigen Punkt ist immer eine Idealisierung. Eine Stütze drückt nicht in einem Punkt auf den Balken, sondern über eine kleine Fläche; eine Kugel auf einer Ebene berührt sie nicht in einem Punkt, sondern über eine kleine Fläche, in der das Material sich verformt. Das Gewicht eines Körpers wirkt in jedem seiner Volumenelemente. Der Wasserdruck wirkt auf jedes Flächenstück der Staumauer. In der Praxis rechnet man trotzdem oft mit Einzelkräften, wenn die Ausdehnung der Kontaktzone klein gegen die Abmessungen des Systems ist. Wo das nicht gilt, beschreibt man die Kraft durch eine *Dichte*: Kraft pro Einheit von Fläche, Volumen oder Länge.

#defn[Kraftdichten][
  - Die *Flächenkraftdichte* $vs$ ist die Kontaktkraft je Flächeneinheit. Auf ein Flächenelement $dif A$ wirkt $dif vF = vs dif A$. Einheit N/m². Beispiel: Wasserdruck, Bodenpressung.
  - Die *Raumkraftdichte* $vf$ ist die Fernkraft je Volumeneinheit. Auf ein Volumenelement $dif V$ wirkt $dif vF = vf dif V$. Einheit N/m³. Beispiel: das Eigengewicht, $vf = gamma ve_g$ mit dem spezifischen Gewicht $gamma = rho g$.
  - Die *Linienkraftdichte* $vq$ ist die Kraft je Längeneinheit für Körper, die man als eindimensional modelliert (Balken, Draht). Auf ein Längenelement $dif x$ wirkt $dif vF = vq dif x$. Einheit N/m. Beispiel: Eigengewicht eines Balkens, Schneelast auf einem Träger.
]

#fg("k04_dichte", [Linienkraftdichte $q(x)$ auf einem Balken. Auf das kurze Stück $dif x$ wirkt die Kraft $q(x) dif x$ (rot hinterlegt). Die Gesamtkraft ist die Summe (das Integral) aller dieser Teilkräfte, also die Fläche unter der Kurve.])

#bsp[Eigengewicht eines Stahlträgers][
  Ein Stahlträger mit Querschnittsfläche $A = 20 "cm"^2 = 2 dot 10^(-3) "m"^2$ und Dichte $rho = 7850 "kg/m"^3$. Das Gewicht je Längeneinheit ist Dichte mal Fläche mal Erdbeschleunigung:
  $ q = rho g A = 7850 dot 9.81 dot 2 dot 10^(-3) "N/m" approx 154 "N/m". $
  Ein Träger der Länge $L = 6$ m wiegt also $G = q L approx 925$ N. Weil $q$ hier konstant ist, ist es eine _Gleichlast_.
]

#bsp[Wasserdruck auf eine Staumauer][
  In der Tiefe $h$ herrscht der Druck $p = rho_W g h$, er steht senkrecht auf der Wand und wächst linear mit der Tiefe. Auf ein Wandstück $dif A$ wirkt die Kraft $dif F = p dif A$. Für eine Mauer der Breite $b$ ist die Linienkraftdichte (Kraft je Höhenmeter) $q(h) = p b = rho_W g b h$: eine *Dreieckslast*, die oben null ist und unten maximal. Wie man sie durch eine einzige Kraft ersetzt, zeigt Kapitel 7.
]

#kurz[
  - Kraft = Vektor $vF$ *plus* Angriffspunkt $A$: ${A | vF}$. Einheit N.
  - Fernkräfte wirken im Volumen, Kontaktkräfte an Berührungsflächen. Lasten sind gegeben, Reaktionen sind gesucht.
  - Reaktionsprinzip: Zu jeder Kraft gehört eine gleich große Gegenkraft am _anderen_ Körper. Das Paar greift an zwei Körpern an.
  - Innen oder außen hängt von der Systemgrenze ab. Erst abgrenzen, dann die äußeren Kräfte eintragen.
  - Verteilte Kräfte: $vs$ (N/m²), $vf$ (N/m³), $vq$ (N/m); Teilkraft = Dichte mal Element.
]
