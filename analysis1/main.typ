#import "lib.typ": *
#show: skript

// ---------- Titel ----------
#page(header: none, footer: none, margin: 0pt)[
  #image("figs/cover.svg", width: 100%)
  #pad(x: 2.6cm, top: 0.5cm)[
    #text(font: sans, size: 46pt, weight: "bold")[Analysis I]
    #v(-0.35cm)
    #line(length: 100%, stroke: 0.8pt)
    #v(0.2cm)
    #text(font: sans, size: 14pt)[Maximilian Prym]
    #v(-0.15cm)
    #text(font: sans, size: 12pt, fill: luma(80))[Herbstsemester 2025/26]
  ]
]

// ---------- Inhalt ----------
#page(header: none)[
  #text(font: sans, size: 23pt, weight: "bold")[Inhaltsverzeichnis]
  #v(0.6cm)
  #show outline.entry.where(level: 1): it => { v(0.55em); text(weight: "bold", it) }
  #outline(title: none, depth: 2, indent: 1.4em)
]

// ---------- Vorwort ----------
#heading(numbering: none, outlined: false)[Wie dieses Skript gedacht ist]

Die Vorlage dieses Skripts ist ein kompaktes PVK-Skript zur Analysis I: Formeln in blauen Kästen, Beispiele in roten Kästen, sehr dicht. Wer den Stoff schon einmal verstanden hat, kann damit gut wiederholen. Wer aber noch nicht weiss, _warum_ eine Formel gilt oder _wann_ man welchen Trick braucht, bleibt mit einer Formelliste allein.

Diese Fassung behält den Aufbau, die Kapitelnummern (in Klammern die Kapitel der Vorlesung) und alle Beispiele der Vorlage. Sie ergänzt, was beim Lernen fehlt:
- *Anschauung* vor jeder Formel: Was bedeutet das, wie sieht es aus?
- *Alltag:* Wo kommt das vor, im täglichen Leben und in der Technik?
- *Herleitungen* in kleinen Schritten, wo sie beim Verstehen helfen.
- *Rezepte* für die typischen Aufgabentypen und *typische Fehler*.
- *Ausführlich gerechnete Beispiele*, bei denen jeder Umformungsschritt kommentiert ist.
- Fehlende Themen, die in Prüfungen vorkommen: Konvergenzkriterien für Reihen, Zwischenwertsatz, Eulerformel, Restglied der Taylorformel, Grenzwerte mit Taylor und anderes.
- *Aufgaben mit Lösungen* am Ende jedes Kapitels und eine Zusammenfassung «Das Wichtigste in Kürze».

Einige kleine Fehler der Vorlage sind korrigiert (zum Beispiel das Vorzeichen der Krümmung und die Definition der Monotonie); wo das passiert, steht ein Hinweis.

=== Die Bausteine

#defn[Begriff][Eine Definition. Sie legt fest, was ein Wort bedeutet. Wörtlich lernen.]
#satz[Name][Eine Aussage, die immer gilt. Die Formeln hier musst du können.]
#formel[Formel][Eine wichtige Formel oder Regel zum Nachschlagen.]
#idee[Steht am Anfang eines Abschnitts und sagt in zwei, drei Sätzen, was das Ziel ist.]
#intu[Ein Bild oder ein Vergleich. Der schnellste Weg, eine Formel zu verstehen und zu behalten.]
#warum[Herleitung][Warum die Formel so aussieht. Beim ersten Lesen darfst du überspringen, beim Lernen nicht.]
#trick[Name][Ein Rechentrick, der in Prüfungen oft gebraucht wird.]
#alltag[Wo die Mathematik ausserhalb des Hörsaals vorkommt: im Alltag, in der Technik, im Ingenieurberuf. Nicht prüfungsrelevant, aber es zeigt, wofür man das alles braucht.]
#merke[Eine Folgerung oder ein Hinweis, der in Aufgaben den Unterschied macht.]
#fehler[Was in Prüfungen immer wieder falsch gemacht wird.]
#rezept[Aufgabentyp][Ein Vorgehen in Schritten.]
#bsp[Titel][Ein durchgerechnetes Beispiel.]

=== Schreibweise

$NN = {1, 2, 3, dots}$ sind die natürlichen Zahlen, $RR$ die reellen, $CC$ die komplexen Zahlen. $RR^+ = (0, oo)$, $RR_0^+ = [0, oo)$. Offene Intervalle haben runde Klammern: $(a, b)$ enthält $a$ und $b$ nicht, $[a, b]$ enthält beide. $forall$ heisst «für alle», $exists$ heisst «es gibt». Ein Punkt über einer Grösse ist die Ableitung nach dem Parameter $t$: $dot(x) = dif x \/ dif t$. «B.H.» steht für die Regel von Bernoulli–de l'Hôpital.

#include "ch01.typ"
#include "ch02.typ"
#include "ch03.typ"
#include "ch04.typ"
#include "ch05.typ"
#include "anhang.typ"
