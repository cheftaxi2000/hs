// ================= Lineare Algebra I: Layout und Kästen =================
#let sans = "CMU Sans Serif"
#let mono = "JetBrains Mono"
#let cbl = rgb("#5b4aa8")      // Rahmen der Definitions- und Satzkästen (Violett)
#let cblf = rgb("#f2effb")
#let crd = rgb("#a3222e")      // Kopf der Beispielkästen
#let cgr = rgb("#2a7f5a")
#let cor = rgb("#c7741a")

// ---------- Zahlbereiche, Operatoren ----------
#let RR = $bb(R)$
#let NN = $bb(N)$
#let CC = $bb(C)$
#let ZZ = $bb(Z)$
#let QQ = $bb(Q)$
#let KK = $bb(K)$
#let rang = math.op("rang")
#let Kern = math.op("Kern")
#let Bild = math.op("Bild")
#let spur = math.op("spur")
#let adj = math.op("adj")
#let diag = math.op("diag")
#let erz = math.op("span")
#let dimn = math.op("dim")
#let sgn = math.op("sgn")
#let ZSF = [ZSF]
#let tp = $upright(T)$          // transponiert: A^tp

// ---------- Abbildungen ----------
#let fg(name, cap, w: 100%) = figure(image("figs/" + name + ".svg", width: w), caption: cap)
#let fgs(names, cap, gap: 8pt) = figure(
  grid(columns: (1fr,) * names.len(), column-gutter: gap, align: bottom,
    ..names.map(n => image("figs/" + n + ".svg", width: 100%))),
  caption: cap)

// ---------- Kästen ----------
#let _lab(t, col) = text(font: sans, size: 9.5pt, weight: "bold", fill: col, t)
#let _blk(label, body, col: black, bar: none, fill: none, stroke: none, brk: false) = block(
  width: 100%, breakable: brk, fill: fill, spacing: 1.15em, radius: if bar != none { 0pt } else { 4pt },
  stroke: if bar != none { (left: 1.5pt + bar) } else { stroke },
  inset: if bar != none { (left: 11pt, right: 9pt, y: 7pt) } else { (x: 10pt, y: 8pt) },
  { _lab(label, col); v(-4pt); body })

#let defn(title, body) = _blk([Definition: #title], body, fill: cblf, stroke: 0.7pt + cbl, brk: true)
#let satz(title, body) = _blk([Satz: #title], body, fill: cblf, stroke: 0.7pt + cbl, brk: true)
#let formel(title, body) = _blk(title, body, fill: cblf, stroke: 0.7pt + cbl, brk: true)
#let beweis(body) = _blk([Beweis], [#body #h(1fr) $square$], bar: luma(150), brk: true)
#let beweisidee(body) = _blk([Beweisidee], body, bar: luma(150), brk: true)
#let intu(body) = _blk([Anschaulich], body, bar: luma(150), brk: true)
#let idee(body) = _blk([Worum geht es?], body, bar: cbl, col: cbl, brk: true)
#let trick(title, body) = _blk([Trick: #title], body, fill: rgb("#f2f8ee"), stroke: 0.6pt + cgr, col: cgr, brk: true)
#let merke(body) = _blk([Merke], body, col: crd, bar: crd, brk: true)
#let fehler(body) = _blk([Typische Fehler], body, col: crd, bar: crd, brk: true)
#let rezept(title, body) = _blk([Vorgehen: #title], body, fill: luma(248), stroke: 0.6pt + luma(140), brk: true)
#let warum(title, body) = _blk([Warum? #title], body, bar: luma(150), brk: true)
#let alltag(body) = _blk([Anwendung], body, fill: rgb("#fdf5ea"), stroke: 0.6pt + cor, col: rgb("#9a520c"), brk: true)
#let hist(body) = _blk([Historisches], body, fill: rgb("#f4f4f4"), stroke: 0.6pt + luma(150), col: luma(70), brk: true)
#let kontrolle(q, a) = block(width: 100%, breakable: false, spacing: 1.15em, inset: (x: 10pt, y: 7pt), radius: 4pt,
  stroke: (paint: luma(150), thickness: 0.6pt, dash: "dashed"), {
    _lab([Selbsttest], luma(60)); v(-4pt); q
    v(-2pt); text(size: 9.5pt, fill: luma(70))[#text(font: sans, size: 8.5pt, weight: "bold")[Antwort.] #a]
  })
#let bsp(title, body) = block(width: 100%, breakable: true, spacing: 1.3em, radius: 4pt, clip: true,
  stroke: 0.7pt + crd, fill: luma(249), {
    block(width: 100%, fill: crd, inset: (x: 10pt, y: 4.5pt), sticky: true, below: 0pt,
      text(font: sans, size: 9.5pt, weight: "bold", fill: white)[Beispiel: #title])
    block(width: 100%, inset: (x: 10pt, top: 8pt, bottom: 9pt), above: 0pt, body)
  })
#let schritt(t) = text(font: sans, size: 8.5pt, weight: "bold", fill: crd, t)
#let kurz(body) = block(width: 100%, breakable: false, fill: cblf, stroke: 0.7pt + cbl, radius: 4pt, inset: 11pt, spacing: 1.4em,
  [#text(font: sans, size: 10pt, weight: "bold")[Das Wichtigste in Kürze] #v(1pt) #body])
#let vorlesung(t) = text(size: 9.5pt, style: "italic", t)

// Zeilenumformungs-Pfeil: $ #zu[Z2 - 2 Z1] $
#let zu(..t) = $attach(arrow.r.long, t: #text(size: 7.5pt, t.pos().join([,~])))$

// ---------- Aufgaben ----------
#let _aufgnr = counter("aufgabe")
#let aufgaben() = {
  _aufgnr.update(0)
  pagebreak(weak: true)
  heading(level: 2)[Aufgaben mit Lösungen]
  text(size: 9.5pt, style: "italic")[Typische Prüfungsaufgaben zu dieser Woche. Erst selbst versuchen, dann die Lösung lesen.]
}
#let aufg(title, fig: none, fw: 5.5cm, a, l) = {
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

// ---------- Wochenmarker (wie die Wochenbalken im Mechanik-Skript) ----------
#let woche(n, topic, keys) = {
  block(width: 100%, above: 1.8em, below: 1.1em, sticky: true, breakable: false, fill: black, radius: 3pt,
    inset: (x: 12pt, y: 9pt), {
    [#metadata(n) <woche>]
    grid(columns: (auto, 1fr), column-gutter: 14pt, align: horizon,
      text(font: sans, size: 20pt, weight: "bold", fill: white)[Woche #n],
      par(justify: false, leading: 0.45em)[#text(font: sans, size: 11.5pt, weight: "bold", fill: white, topic) \ #text(font: sans, size: 9pt, fill: luma(210), keys)])
  })
}
#let nowoche = [#metadata(none) <woche>]

// ---------- Seitenlayout ----------
#let skript(body) = {
  set page(paper: "a4", margin: (x: 2.6cm, top: 2.8cm, bottom: 2.6cm),
    header: context {
      let p = counter(page).get().first()
      let h1 = query(heading.where(level: 1)).filter(h => h.location().page() == here().page())
      if p > 2 and h1.len() == 0 {
        let hs = query(selector(heading.where(level: 1)).before(here()))
        let t = if hs.len() > 0 { hs.last().body } else { [] }
        let n = if hs.len() > 0 and hs.last().numbering != none { [#counter(heading).get().first() #h(0.3em)] } else { [] }
        let ls = query(<woche>).filter(m => m.location().page() <= here().page())
        let lab = if ls.len() > 0 and ls.last().value != none [Woche #ls.last().value] else [Lineare Algebra I]
        let w = box(fill: black, radius: 2pt, inset: (x: 5pt, y: 2.5pt), baseline: 2.5pt, text(font: sans, size: 9pt, weight: "bold", fill: white, lab))
        text(size: 9pt)[#n#t #h(1fr) #w]
        v(-7pt); line(length: 100%, stroke: 0.5pt)
      }
    },
    footer: context { let p = counter(page).get().first(); if p > 1 { align(center, text(size: 9.5pt, str(p))) } })
  set text(font: "New Computer Modern", size: 10.5pt, lang: "de", region: "de")
  set par(justify: true, leading: 0.7em, spacing: 1.05em)
  show math.equation.where(block: true): set block(spacing: 1.15em)
  set math.mat(gap: 0.55em)
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    v(0.3cm)
    if it.numbering != none { text(font: sans, size: 15pt, weight: "bold")[Kapitel #counter(heading).display("1")]; v(0.1cm) }
    par(justify: false, text(font: sans, size: 23pt, weight: "bold", hyphenate: false, it.body))
    v(0.1cm); line(length: 100%, stroke: 0.8pt); v(0.7cm)
  }
  show heading.where(level: 2): it => block(sticky: true, above: 1.8em, below: 0.9em, text(font: sans, size: 14.5pt, weight: "bold", [#counter(heading).display() #h(0.7em) #it.body]))
  show heading.where(level: 3): it => block(sticky: true, above: 1.4em, below: 0.7em, text(font: sans, size: 11pt, weight: "bold", it.body))
  show heading.where(level: 4): it => block(sticky: true, above: 1.2em, below: 0.6em, text(font: sans, size: 10pt, weight: "bold", it.body))
  set figure(numbering: n => str(counter(heading).get().first()) + "." + str(n), supplement: [Abb.], gap: 0.9em)
  show figure.caption: it => text(size: 9pt, it)
  show figure: set block(spacing: 1.6em)
  show table: set text(size: 9.5pt)
  set table(stroke: (x, y) => if y == 0 { (bottom: 0.6pt) } else { none }, inset: (x: 6pt, y: 4pt))
  set list(indent: 0.6em, marker: [•])
  set enum(indent: 0.6em)
  show raw: set text(font: mono, size: 8.8pt)
  body
}

// ---------- Fotos (Wikimedia Commons, Quelle in der Bildunterschrift) ----------
#let _ph(name, h) = box(clip: true, radius: 4pt, image("photos/" + name + ".jpg", height: h))
#let photo(names, cap, ht: 4.6cm, gap: 6pt) = figure(
  box(names.map(n => _ph(n, ht)).join(h(gap))), caption: cap)
#let credit(t) = text(size: 7.5pt, fill: luma(110))[Foto: #t]
