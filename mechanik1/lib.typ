// ---------- Farben mit fester Bedeutung (wie in den Abbildungen) ----------
#let cv = rgb("#1f5fa8")   // Geschwindigkeiten
#let cf = rgb("#b3382c")   // Kräfte
#let cm = rgb("#2a7f5a")   // Drehung, Momente
#let cg = luma(120)

// ---------- Vektor-Kürzel ----------
#let vr = $bold(r)$
#let vv = $bold(v)$
#let vF = $bold(F)$
#let vR = $bold(R)$
#let vM = $bold(M)$
#let vN = $bold(N)$
#let vn = $bold(n)$
#let vG = $bold(G)$
#let vS = $bold(S)$
#let ve = $bold(e)$
#let va = $bold(a)$
#let vb = $bold(b)$
#let vc = $bold(c)$
#let vP = $bold(P)$
#let vq = $bold(q)$
#let vs = $bold(s)$
#let vf = $bold(f)$
#let vA = $bold(A)$
#let vB = $bold(B)$
#let vZ = $bold(Z)$
#let vom = $bold(omega)$
#let vrho = $bold(rho)$
#let vtau = $bold(tau)$
#let PP = $cal(P)$

// ---------- Abbildungen ----------
#let fg(name, cap, w: 100%) = figure(image("figs/" + name + ".svg", width: w), caption: cap)

// ---------- Kästen ----------
#let _lab(t, col) = text(font: "Inter", size: 7.5pt, weight: 600, fill: col, tracking: 0.6pt, upper(t))
#let _blk(label, body, col: black, bar: none, fill: none, stroke: none, brk: false) = block(
  width: 100%, breakable: brk, fill: fill, spacing: 1.15em,
  stroke: if bar != none { (left: 1.5pt + bar) } else { stroke },
  inset: if bar != none { (left: 11pt, right: 9pt, y: 8pt) } else { (x: 10pt, y: 8pt) },
  { _lab(label, col); v(-3pt); body })

#let defn(title, body) = _blk([Definition #sym.dot.c #title], body, bar: black)
#let satz(title, body) = _blk([Satz #sym.dot.c #title], body, bar: black, fill: luma(243))
#let intu(body) = _blk([Anschaulich], body, col: luma(90), fill: rgb("#f6f2e9"))
#let merke(body) = _blk([Merke], body, col: cf, bar: cf)
#let fehler(body) = _blk([Typische Fehler], body, col: cf, bar: cf)
#let rezept(title, body) = _blk([Vorgehen #sym.dot.c #title], body, stroke: 0.6pt + luma(150))
#let warum(title, body) = _blk([Warum gilt das? #sym.dot.c #title], body, col: luma(90), bar: luma(175))
#let bsp(title, body) = {
  block(width: 100%, sticky: true, above: 1.3em, below: 0.5em, inset: (top: 7pt), stroke: (top: 0.5pt + luma(170)),
    text(font: "Inter", size: 8.5pt, weight: 600)[Beispiel #sym.dot.c #title])
  body
  v(0.4em)
}
#let kurz(body) = block(width: 100%, breakable: false, stroke: 0.6pt + black, inset: 11pt, spacing: 1.4em,
  [#text(font: "Inter", size: 8.5pt, weight: 600, tracking: 0.6pt)[DAS WICHTIGSTE IN KÜRZE] #v(1pt) #body])
#let gl(body) = math.equation(block: true, numbering: n => "(" + str(counter(heading).get().first()) + "." + str(n) + ")", body)

#let teil(num, title, body) = {
  pagebreak(weak: true)
  v(6cm)
  text(font: "Inter", size: 11pt, fill: cg, tracking: 1.5pt)[TEIL #num]
  v(2pt)
  text(font: "Inter", size: 30pt, weight: 600, title)
  v(8pt); line(length: 4cm, stroke: 1.2pt); v(10pt)
  block(width: 75%, text(size: 11pt, body))
}

#let skript(body) = {
  set page(paper: "a4", margin: (x: 2.6cm, top: 2.6cm, bottom: 2.6cm),
    header: context {
      let p = counter(page).get().first()
      if p > 2 {
        let hs = query(selector(heading.where(level: 1)).before(here()))
        let t = if hs.len() > 0 { hs.last().body } else { [] }
        text(font: "Inter", size: 7.5pt, fill: cg)[Mechanik 1 #h(1fr) #t]
        v(-6pt); line(length: 100%, stroke: 0.3pt + luma(170))
      }
    },
    footer: context { let p = counter(page).get().first(); if p > 1 { align(center, text(font: "Inter", size: 8pt, fill: cg, str(p))) } })
  set text(font: "New Computer Modern", size: 10.5pt, lang: "de", region: "de")
  set par(justify: true, leading: 0.7em, spacing: 1.05em)
  show math.equation.where(block: true): set block(spacing: 1.15em)
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    v(1.2cm)
    if it.numbering != none { text(font: "Inter", size: 44pt, weight: 300, fill: cg, counter(heading).display("1")); v(-1.0cm) }
    par(justify: false, text(font: "Inter", size: 22pt, weight: 600, hyphenate: false, it.body))
    v(0.5cm)
  }
  show heading.where(level: 2): it => block(sticky: true, above: 1.7em, below: 0.9em, text(font: "Inter", size: 13pt, weight: 600, [#counter(heading).display() #h(0.5em) #it.body]))
  show heading.where(level: 3): it => block(sticky: true, above: 1.3em, below: 0.7em, text(font: "Inter", size: 10pt, weight: 600, it.body))
  set figure(numbering: n => str(counter(heading).get().first()) + "." + str(n), supplement: [Abb.], gap: 0.9em)
  show figure.caption: it => text(size: 8.8pt, fill: luma(60), it)
  show figure: set block(spacing: 1.6em)
  set list(indent: 0.6em, marker: [–])
  set enum(indent: 0.6em)
  body
}
