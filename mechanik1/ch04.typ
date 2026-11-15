#import "lib.typ": *

= Kräfte

Bis hierher war alles Geometrie. Jetzt kommt die Ursache ins Spiel: Kräfte. Eine Kraft sieht man nie direkt -- man erkennt sie an ihrer Wirkung: Etwas verformt sich, oder etwas ändert seinen Bewegungszustand.

== Der Kraftbegriff

#defn[Kraft, Kräftegruppe][
  Eine *Kraft* ist ein *punktgebundener Vektor* ${A | vF}$: Zu ihr gehören der *Vektoranteil* $vF$ (Betrag und Richtung) und der materielle *Angriffspunkt* $A$. Mehrere Kräfte ${A_i | vF_i}$, $i = 1, 2, dots$, bilden eine *Kräftegruppe*. Die Gerade durch $A$ in Richtung $vF$ heißt *Wirkungslinie*.
]

Einheit ist das Newton: $1 "N" = 1 "kg" dot.c "m/s"^2$. Ein Körper der Masse 1 kg wiegt an der Erdoberfläche etwa 9.81 N; eine Tafel Schokolade (100 g) also rund 1 N.

#merke[
  Der Angriffspunkt gehört zur Kraft. Derselbe Vektor $vF$ an zwei verschiedenen Punkten ist _nicht_ dieselbe Kraft: An der Türklinke geht die Tür leicht auf, direkt neben dem Scharnier kaum. Wann man eine Kraft trotzdem verschieben darf (und welchen Preis man dafür zahlt), klärt Kapitel 6.
]

Vom makroskopischen Standpunkt gibt es zwei Arten von Kräften:

#table(columns: (auto, 1fr, 1fr), stroke: none, inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 0.6pt),
  [], [*Fernkräfte*], [*Kontaktkräfte*],
  table.hline(stroke: 0.3pt),
  [Wirkung], [über Distanz, ohne Berührung], [nur bei Berührung, an der Berührungsstelle],
  [Beispiele], [Gewicht (Gravitation), elektrische und magnetische Kräfte], [Auflagerkraft, Seilkraft, Druck, Reibung],
  [verteilt über], [das Volumen], [die Berührungsfläche],
  table.hline(stroke: 0.6pt),
)

Kräfte, die von außen vorgegeben sind (Gewichte, Nutzlasten, Wind), nennt man *Lasten*. Kräfte, die sich erst als Antwort darauf an den Stützen und Lagern einstellen, sind *Reaktionen* (später: Lager- oder Bindungskräfte).

== Das Reaktionsprinzip

#satz[Reaktionsprinzip (actio = reactio)][
  Übt ein materieller Punkt $A_1$ auf einen zweiten $A_2$ die Kraft ${A_2 | vF}$ aus, so wirkt $A_2$ auf $A_1$ mit der Gegenkraft ${A_1 | -vF}$. Bei Fernkräften liegen beide Wirkungslinien auf der Verbindungsgeraden $A_1 A_2$.
]

Das ist ein Axiom: Es wird nicht bewiesen, sondern durch die Erfahrung bestätigt. Keine Kraft existiert ohne ihre Gegenkraft.

#fig(13, 4.6, caption: [Ein Klotz auf dem Tisch. Kraft und Gegenkraft greifen immer an *verschiedenen* Körpern an: Das Paar $vN$ / $-vN$ (Klotz--Tisch) ist ein Reaktionspaar, ebenso $vG$ / $-vG$ (Klotz--Erde). $vN$ und $vG$ sind _kein_ Reaktionspaar.],
  hatch((0.5,0.6),(5.5,0.6)), rct((1.0,0.6),(5.0,1.0), fill: white), rct((2.2,1.0),(3.8,2.2)),
  lbl((3.0,-0.05), [zusammen], size: 8.5pt),
  // getrennt
  rct((8.4,2.9),(10.0,4.1)), pt((9.2,3.5)),
  arr((9.2,3.5),(9.2,2.3), c: cf, w: 1.3pt), lbl((9.55,2.5), $vG$, c: cf),
  arr((8.8,2.2),(8.8,2.9), c: cf, w: 1.3pt), lbl((8.45,2.5), $vN$, c: cf),
  rct((7.2,1.0),(11.2,1.4), fill: white), arr((8.8,2.1),(8.8,1.4), c: cf, w: 1.3pt), lbl((8.3,1.8), $-vN$, c: cf),
  lbl((11.9,3.5), [Klotz], size: 8.5pt), lbl((11.9,1.2), [Tisch], size: 8.5pt),
  lbl((9.2,0.3), [$-vG$ greift an der Erde an], size: 8pt, c: cg),
)

#fehler[
  «Gewicht und Normalkraft heben sich auf, also sind sie actio und reactio.» Falsch. Beide greifen am _selben_ Körper (dem Klotz) an und sind verschiedener Natur (Fernkraft, Kontaktkraft). Dass sie gleich groß sind, folgt aus dem Gleichgewicht des Klotzes, nicht aus dem Reaktionsprinzip. Actio und reactio greifen immer an zwei verschiedenen Körpern an und können sich deshalb an _einem_ Körper nie aufheben.
]

== Innere und äußere Kräfte

Bevor man irgendetwas rechnet, muss man sagen, _welches_ materielle System man betrachtet. Man «grenzt es ab», zieht in Gedanken eine geschlossene Linie darum.

#defn[Innere und äußere Kräfte][
  Eine Kraft auf einen Punkt des Systems heißt *innere Kraft*, wenn auch der Angriffspunkt ihrer Reaktion zum System gehört, sonst *äußere Kraft*.
]

#fig(13, 3.6, caption: [Dieselbe Kontaktkraft zwischen Last und Träger ist äußere Kraft, wenn das System nur die Last ist (links), und innere Kraft, wenn Last und Träger zusammen das System bilden (rechts). Dann treten stattdessen die Stützkräfte als äußere Kräfte auf.],
  // links
  beam((0.8,1.2),(5.4,1.2), c: cg), rct((2.4,1.25),(3.8,2.2)),
  pl(((2.1,1.0),(4.1,1.0),(4.1,2.5),(2.1,2.5)), s: 0.7pt + cv, close: true, dash: "dashed"),
  arr((3.1,1.75),(3.1,0.55), c: cf, w: 1.2pt), arr((3.5,0.35),(3.5,1.2), c: cf, w: 1.2pt),
  lbl((2.75,0.6), $vG$, c: cf), lbl((3.85,0.6), $vN$, c: cf), lbl((3.1,2.8), [System: Last], c: cv, size: 8pt),
  // rechts
  beam((7.6,1.2),(12.2,1.2)), rct((9.2,1.25),(10.6,2.2)),
  pl(((7.3,0.95),(12.5,0.95),(12.5,2.5),(7.3,2.5)), s: 0.7pt + cv, close: true, dash: "dashed"),
  arr((9.9,1.75),(9.9,0.45), c: cf, w: 1.2pt), arr((7.8,0.2),(7.8,1.15), c: cf, w: 1.2pt), arr((12.0,0.2),(12.0,1.15), c: cf, w: 1.2pt),
  lbl((10.25,0.55), $vG$, c: cf), lbl((8.15,0.4), $vA$, c: cf), lbl((11.65,0.4), $vB$, c: cf), lbl((9.9,2.8), [System: Last + Träger], c: cv, size: 8pt),
)

#intu[
  Ob eine Kraft innen oder außen ist, ist keine Eigenschaft der Kraft, sondern deiner Wahl der Systemgrenze. Jede Kraft, deren Pfeil die gestrichelte Grenze «durchstößt» (Ursache draußen, Wirkung drinnen), ist eine äußere. Innere Kräfte treten immer paarweise als $vF$ und $-vF$ auf. Genau deshalb fallen sie später aus den Gleichgewichtsbedingungen heraus -- und genau deshalb muss man ein System _aufschneiden_, wenn man eine innere Kraft wissen will.
]

== Verteilte Kräfte und Kraftdichten

Eine «Einzelkraft» an einem Punkt ist immer eine Idealisierung. In Wirklichkeit ist jede Kraft über eine Fläche, ein Volumen oder (im Modell) eine Linie verschmiert. Man beschreibt sie durch eine *Dichte*: Kraft pro Einheit.

#table(columns: (auto, auto, auto, 1fr), stroke: none, inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 0.6pt),
  [*Dichte*], [*Symbol*], [*Einheit*], [*Kraft auf ein Element / Beispiel*],
  table.hline(stroke: 0.3pt),
  [Flächenkraftdichte], [$vs$], [N/m²], [$dif vF = vs dif A$ -- Wasserdruck auf eine Staumauer, Bodenpressung],
  [Raumkraftdichte], [$vf$], [N/m³], [$dif vF = vf dif V$ -- spezifisches Gewicht $gamma = rho g$],
  [Linienkraftdichte], [$vq$], [N/m], [$dif vF = vq dif x$ -- Eigengewicht eines Balkens, Schneelast auf einem Träger],
  table.hline(stroke: 0.6pt),
)

#fig(12, 3.2, caption: [Linienkraftdichte $q(x)$ auf einem Balken. Auf das kurze Stück $dif x$ wirkt die Kraft $q dif x$; die Fläche unter der Kurve ist die Gesamtkraft.],
  beam((1,0.7),(9,0.7)), festlager((1,0.7), s: 0.25), loslager((9,0.7), s: 0.25),
  graph(t => 0.9 + 0.5 * calc.sin(t * 0.5), 0, 8, o: (1, 0.8), c: cf, w: 0.7pt),
  ..range(9).map(i => arr((1 + i, 1.7 + 0.5 * calc.sin(i * 0.5)), (1 + i, 0.82), c: cf, w: 0.6pt, hs: 0.13)),
  rct((4.0,0.8),(4.4,2.2), fill: rgb("#b8322733"), s: none),
  lbl((4.2,2.75), $q(x) dif x$, c: cf, size: 8pt), lbl((7.3,2.75), $q(x)$, c: cf),
  lbl((10.7,1.6), $R = integral q dif x$),
)

Wie man eine verteilte Kraft durch eine einzige Kraft am richtigen Ort ersetzt, ist Thema von Kapitel 7.

#kurz[
  - Kraft = Vektor $vF$ *plus* Angriffspunkt $A$: ${A | vF}$.
  - Fernkräfte wirken im Volumen, Kontaktkräfte an Berührungsflächen.
  - Reaktionsprinzip: zu jeder Kraft gehört eine gleich große Gegenkraft am _anderen_ Körper.
  - Innen oder außen hängt von der Systemgrenze ab. Erst abgrenzen, dann Kräfte eintragen.
  - Verteilte Kräfte: $vs$ (N/m²), $vf$ (N/m³), $vq$ (N/m).
]
