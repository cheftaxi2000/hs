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
#let sans = "CMU Sans Serif"
#let cbl = rgb("#2f86c0")      // Rahmen der Definitions- und Satzkästen
#let cblf = rgb("#eef6fb")
#let crd = rgb("#a3222e")      // Kopf der Beispielkästen
#let _lab(t, col) = text(font: sans, size: 9.5pt, weight: "bold", fill: col, t)
#let _blk(label, body, col: black, bar: none, fill: none, stroke: none, brk: false) = block(
  width: 100%, breakable: brk, fill: fill, spacing: 1.15em, radius: if bar != none { 0pt } else { 4pt },
  stroke: if bar != none { (left: 1.5pt + bar) } else { stroke },
  inset: if bar != none { (left: 11pt, right: 9pt, y: 7pt) } else { (x: 10pt, y: 8pt) },
  { _lab(label, col); v(-4pt); body })

#let defn(title, body) = _blk([Definition: #title], body, fill: cblf, stroke: 0.7pt + cbl)
#let satz(title, body) = _blk([Satz: #title], body, fill: cblf, stroke: 0.7pt + cbl)
#let intu(body) = _blk([Anschaulich], body, bar: luma(150))
#let merke(body) = _blk([Merke], body, col: crd, bar: crd)
#let fehler(body) = _blk([Typische Fehler], body, col: crd, bar: crd)
#let rezept(title, body) = _blk([Vorgehen: #title], body, fill: luma(248), stroke: 0.6pt + luma(140))
#let warum(title, body) = _blk([Warum gilt das? #title], body, bar: luma(150))
#let bsp(title, body) = block(width: 100%, breakable: true, spacing: 1.3em, radius: 4pt, clip: true,
  stroke: 0.7pt + crd, fill: luma(249), {
    block(width: 100%, fill: crd, inset: (x: 10pt, y: 4.5pt), sticky: true, below: 0pt,
      text(font: sans, size: 9.5pt, weight: "bold", fill: white)[Beispiel: #title])
    block(width: 100%, inset: (x: 10pt, top: 8pt, bottom: 9pt), above: 0pt, body)
  })
#let kurz(body) = block(width: 100%, breakable: false, fill: cblf, stroke: 0.7pt + cbl, radius: 4pt, inset: 11pt, spacing: 1.4em,
  [#text(font: sans, size: 10pt, weight: "bold")[Das Wichtigste in Kürze] #v(1pt) #body])
#let gl(body) = math.equation(block: true, numbering: n => "(" + str(counter(heading).get().first()) + "." + str(n) + ")", body)

// ---------- Aufgaben (aus der Vorlesungsmitschrift) ----------
#let _aufgnr = counter("aufgabe")
#let aufgaben() = {
  _aufgnr.update(0)
  heading(level: 2)[Aufgaben mit Lösungen]
  text(size: 9.5pt, style: "italic")[Durchgerechnete Aufgaben aus der Vorlesung zu diesem Kapitel. Erst selbst versuchen, dann die Lösung lesen.]
}
#let aufg(title, fig: none, fw: 6cm, a, l) = {
  _aufgnr.step()
  block(width: 100%, breakable: true, spacing: 1.3em, radius: 4pt, clip: true, stroke: 0.7pt + crd, fill: luma(249), {
    block(width: 100%, fill: crd, inset: (x: 10pt, y: 4.5pt), sticky: true, below: 0pt,
      text(font: sans, size: 9.5pt, weight: "bold", fill: white, context [Aufgabe #counter(heading).get().first().#_aufgnr.get().first(): #title]))
    block(width: 100%, inset: (x: 10pt, top: 8pt, bottom: 9pt), above: 0pt, {
      block(breakable: false, sticky: true, width: 100%, {
        if fig != none {
          grid(columns: (1fr, fw), column-gutter: 12pt, align: (top, center + horizon), a, image("figs/" + fig + ".svg", width: fw))
        } else { a }
        v(2pt); line(length: 100%, stroke: 0.4pt + luma(170)); v(-2pt)
        text(font: sans, size: 9pt, weight: "bold")[Lösung]
      })
      v(-3pt)
      l
    })
  })
}

// ---------- Wochenmarken ----------
#let woche(n, thema, seiten) = {
  block(width: 100%, above: 1.8em, below: 1.1em, sticky: true, breakable: false, fill: black, radius: 3pt,
    inset: (x: 12pt, y: 9pt), {
    [#metadata(n) <woche>]
    grid(columns: (auto, 1fr, auto), column-gutter: 14pt, align: horizon,
      text(font: sans, size: 20pt, weight: "bold", fill: white)[Woche #n],
      text(font: sans, size: 11.5pt, weight: "bold", fill: white, thema),
      text(font: sans, size: 10pt, fill: white)[Buch S. #seiten])
  })
}
#let ohnewoche(body) = block(width: 100%, above: 1.6em, below: 0.9em, sticky: true, {
  [#metadata(none) <woche>]
  line(length: 100%, stroke: 0.5pt); v(-7pt)
  text(size: 9pt, style: "italic", body)
})

#let teil(num, title, body) = {
  pagebreak(weak: true)
  v(6cm)
  text(font: sans, size: 14pt, weight: "bold")[Teil #num]
  v(4pt)
  text(font: sans, size: 26pt, weight: "bold", title)
  v(6pt); line(length: 100%, stroke: 0.8pt); v(10pt)
  block(width: 80%, text(size: 11pt, body))
}

#let skript(body) = {
  set page(paper: "a4", margin: (x: 2.6cm, top: 2.8cm, bottom: 2.6cm),
    header: context {
      let p = counter(page).get().first()
      let h1 = query(heading.where(level: 1)).filter(h => h.location().page() == here().page())
      if p > 2 and h1.len() == 0 {
        let hs = query(selector(heading.where(level: 1)).before(here()))
        let h2 = query(selector(heading.where(level: 2)).before(here()))
        let t = if hs.len() > 0 { hs.last().body } else { [] }
        let n = if hs.len() > 0 and hs.last().numbering != none { [#counter(heading).get().first() #h(0.3em)] } else { [] }
        let ws = query(<woche>).filter(m => m.location().page() <= here().page())
        let w = if ws.len() > 0 and ws.last().value != none { box(fill: black, radius: 2pt, inset: (x: 5pt, y: 2.5pt), baseline: 2.5pt, text(font: sans, size: 9.5pt, weight: "bold", fill: white)[Woche #ws.last().value]) } else { [Mechanik 1] }
        text(size: 9pt)[#n#t #h(1fr) #w]
        v(-7pt); line(length: 100%, stroke: 0.5pt)
      }
    },
    footer: context { let p = counter(page).get().first(); if p > 1 { align(center, text(size: 9.5pt, str(p))) } })
  set text(font: "New Computer Modern", size: 10.5pt, lang: "de", region: "de")
  set par(justify: true, leading: 0.7em, spacing: 1.05em)
  show math.equation.where(block: true): set block(spacing: 1.15em)
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    v(2.2cm)
    if it.numbering != none { text(font: sans, size: 15pt, weight: "bold")[Kapitel #counter(heading).display("1")]; v(0.1cm) }
    par(justify: false, text(font: sans, size: 23pt, weight: "bold", hyphenate: false, it.body))
    v(0.1cm); line(length: 100%, stroke: 0.8pt); v(0.7cm)
  }
  show heading.where(level: 2): it => block(sticky: true, above: 1.8em, below: 0.9em, text(font: sans, size: 14.5pt, weight: "bold", [#counter(heading).display() #h(0.7em) #it.body]))
  show heading.where(level: 3): it => block(sticky: true, above: 1.4em, below: 0.7em, text(font: sans, size: 11pt, weight: "bold", it.body))
  set figure(numbering: n => str(counter(heading).get().first()) + "." + str(n), supplement: [Abb.], gap: 0.9em)
  show figure.caption: it => text(size: 9pt, it)
  show figure: set block(spacing: 1.6em)
  set list(indent: 0.6em, marker: [•])
  set enum(indent: 0.6em)
  body
}
