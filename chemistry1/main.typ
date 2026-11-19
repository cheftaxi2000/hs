#import "lib.typ": *
#show: script

// ---------- cover ----------
#page(header: none, footer: none, margin: 0pt)[
  #image("figs/cover.svg", width: 100%)
  #pad(x: 2.6cm, top: 0.5cm)[
    #text(font: sans, size: 46pt, weight: "bold")[Chemistry]
    #v(-0.35cm)
    #line(length: 100%, stroke: 0.8pt)
    #v(0.2cm)
    #text(font: sans, size: 14pt)[Maximilian Prym]
    #v(-0.15cm)
    #text(font: sans, size: 12pt, fill: luma(80))[Autumn Semester 2025/26]
  ]
]

// ---------- contents ----------
#page(header: none)[
  #text(font: sans, size: 23pt, weight: "bold")[Contents]
  #v(0.6cm)
  #set text(size: 9.8pt)
  #set par(leading: 0.55em)
  #show outline.entry.where(level: 1): it => { v(0.45em); text(weight: "bold", it) }
  #outline(title: none, depth: 2, indent: 1.4em)
]

#include "ch01.typ"
#include "ch02.typ"
#include "ch03.typ"
#include "ch04.typ"
#include "ch05.typ"
#include "ch06.typ"
#include "ch07.typ"
#include "ch08.typ"
#include "ch09.typ"
#include "ch10.typ"
#include "appendix.typ"
