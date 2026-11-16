#import "lib.typ": *
#show: skript

// ---------- Titel ----------
#page(header: none, footer: none)[
  #v(5.5cm)
  #text(font: "Inter", size: 11pt, fill: cg, tracking: 1.5pt)[LERNSKRIPT]
  #v(4pt)
  #text(font: "Inter", size: 40pt, weight: 600)[Mechanik 1]
  #v(-6pt)
  #text(font: "Inter", size: 17pt, weight: 300)[Kinematik und Statik, anschaulich erklärt]
  #v(10pt)
  #line(length: 4cm, stroke: 1.2pt)
  #v(1fr)
  #text(size: 10pt)[
    Ein Begleitskript zum Lehrbuch \
    _Sayir, Dual, Kaufmann, Mazza: Ingenieurmechanik 1 -- Grundlagen und Statik_ (Springer Vieweg). \
    Gleicher Aufbau, gleiche Begriffe und Formeln, neu erklärt und neu gezeichnet.
  ]
  #v(1cm)
]

// ---------- Inhalt ----------
#page(header: none)[
  #text(font: "Inter", size: 22pt, weight: 600)[Inhalt]
  #v(0.6cm)
  #show outline.entry.where(level: 1): it => { v(0.55em); text(font: "Inter", size: 10pt, weight: 600, it) }
  #outline(title: none, depth: 2, indent: 1.4em)
]

// ---------- Vorwort ----------
#heading(numbering: none, outlined: false)[Wie dieses Skript gedacht ist]

Dieses Skript folgt Kapitel für Kapitel dem Lehrbuch _Ingenieurmechanik 1_. Alle Definitionen, Sätze und Formeln des Buchs sind enthalten; die Kapitelnummern stimmen überein, damit du jederzeit im Buch nachschlagen kannst. Geändert ist die Darstellung: weniger Fließtext, dafür mehr Bilder, mehr Herleitungen in kleinen Schritten, und zu jedem neuen Begriff eine anschauliche Vorstellung, bevor gerechnet wird.

=== Die Bausteine

#defn[Begriff][Eine Definition. Sie legt fest, was ein Wort bedeutet. Wörtlich lernen.]
#satz[Name][Eine Aussage, die gilt (Theorem, Postulat, Gesetz). Die Formeln hier sind die, die du können musst.]
#intu[Ein Bild oder ein Alltagsvergleich. Nicht prüfungsrelevant als Text, aber der schnellste Weg, die Formel darüber zu verstehen und sich an sie zu erinnern.]
#warum[Beweis oder Herleitung][Ein kurzer Beweis oder die Herleitung einer Formel. Hier siehst du, _warum_ sie so aussieht. Beim ersten Lesen darfst du überspringen, beim Lernen nicht.]
#merke[Eine Folgerung oder ein Hinweis, der in Aufgaben den Unterschied macht.]
#rezept[Aufgabentyp][Ein Vorgehen in Schritten für einen häufigen Aufgabentyp.]

Am Ende jedes Kapitels steht «Das Wichtigste in Kürze». Der Anhang sammelt alle Formeln auf wenigen Seiten.

=== Farben in den Abbildungen

Farbe hat in allen Abbildungen dieselbe Bedeutung. Alles andere ist schwarz (Körper, Achsen, Ortsvektoren) oder grau (Hilfslinien, Maße):

#align(center, block(width: 11cm, image("figs/k00_farben.svg")))

=== Schreibweise

Vektoren sind fett: $vv$, $vF$, $vom$. Ihr Betrag ist der gleiche Buchstabe normal gesetzt: $v$, $F$, $omega$. $arrow(A B)$ ist der Vektor von $A$ nach $B$. Ein Punkt über einer Größe ist die Ableitung nach der Zeit: $dot(x) = dif x \/ dif t$. Eine Kraft mit Angriffspunkt schreibt man ${A | vF}$. Eine Tilde kennzeichnet virtuelle (gedachte) Größen: $tilde(vv)$, $tilde(PP)$.

=== Die Idee des ganzen Kurses auf einer halben Seite

+ *Kinematik (Kap. 1--3).* Die Geschwindigkeit aller Punkte eines starren Körpers ist durch zwei Vektoren bestimmt, die Kinemate ${vv_B, vom}$.
+ *Kräfte und Leistung (Kap. 4--5).* Die Leistung $PP = vF dot.c vv$ verbindet Kraft und Bewegung. Am starren Körper wird daraus $PP = vv_B dot.c vR + vom dot.c vM_B$.
+ *Reduktion (Kap. 6--7).* Deshalb zählt von einer Kräftegruppe nur die Dyname ${vR, vM_B}$: Resultierende und Moment.
+ *Gleichgewicht (Kap. 8).* Ein System ruht, wenn die virtuelle Leistung aller Kräfte bei jeder gedachten Bewegung null ist. Für die äußeren Kräfte heißt das $vR = bold(0)$, $vM = bold(0)$.
+ *Anwendungen (Kap. 9--14).* Lager, Systeme, Fachwerke, Reibung, Seile und schließlich der Blick ins Innere des Trägers.

#teil("I", "Grundlagen")[
  Wie beschreibt man Bewegung? Was ist eine Kraft? Und was haben beide miteinander zu tun? Die ersten drei Kapitel behandeln die Geschwindigkeit, erst für einen Punkt, dann für den starren Körper. Die Kapitel 4 und 5 führen die Kraft ein und verknüpfen sie über die Leistung mit der Bewegung.
]
#include "ch01.typ"
#include "ch02.typ"
#include "ch03.typ"
#include "ch04.typ"
#include "ch05.typ"

#teil("II", "Statik")[
  Wann bleibt etwas in Ruhe, und welche Kräfte sind dafür nötig? Zuerst lernen wir, Kräftegruppen zu vereinfachen. Dann kommt das Grundprinzip der Statik, und danach wird es angewendet: auf gelagerte Träger, zusammengesetzte Systeme, Fachwerke, auf Reibung und Seile und schließlich auf die Kräfte im Inneren eines Trägers.
]
#include "ch06.typ"
#include "ch07.typ"
#include "ch08.typ"
#include "ch09.typ"
#include "ch10.typ"
#include "ch11.typ"
#include "ch12.typ"
#include "ch13.typ"
#include "ch14.typ"
#include "anhang.typ"
