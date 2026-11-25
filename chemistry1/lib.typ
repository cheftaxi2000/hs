// ================= Chemistry script: layout and boxes =================
#let sans = "CMU Sans Serif"
#let cbl = rgb("#2f86c0")      // frame of definition / law boxes
#let cblf = rgb("#eef6fb")
#let crd = rgb("#a3222e")      // head of example boxes
#let cpu = rgb("#6b4c9a")      // molecular picture
#let cgr = rgb("#2a7f5a")

// ---------- chemical formulas ----------
// ce("Ca(OH)2"), ce("SO4^2-"), ce("2 H2(g) + O2(g) -> 2 H2O(l)")
// digits right after a letter or a closing bracket become subscripts,
// "^..." (up to the next space) becomes a superscript charge.
#let _sb(t) = box(text(size: 0.72em, baseline: 0.22em, t))
#let _sp(t) = box(text(size: 0.72em, baseline: -0.42em, t))
#let ce(s) = {
  let s = s.replace("<=>", "⇌").replace("->", "→")
  let cs = s.clusters()
  let out = ()
  let i = 0
  let prev = " "
  while i < cs.len() {
    let c = cs.at(i)
    if c == "^" {
      let j = i + 1
      let t = ""
      while j < cs.len() and cs.at(j) != " " and cs.at(j) != "(" { t += cs.at(j); j += 1 }
      out.push(_sp(t.replace("-", "−")))
      i = j; prev = "^"; continue
    }
    if c.match(regex("^[0-9]$")) != none and prev.match(regex("^[A-Za-z\)\]]$")) != none {
      let j = i
      let t = ""
      while j < cs.len() and cs.at(j).match(regex("^[0-9]$")) != none { t += cs.at(j); j += 1 }
      out.push(_sb(t))
      i = j; prev = "0"; continue
    }
    if c == "→" or c == "⇌" { out.push([#h(0.3em)#text(size: 1.1em, c)#h(0.3em)]) }
    else if c == " " { out.push([ ]) }
    else { out.push(c) }
    prev = c
    i += 1
  }
  box(out.join())
}
// displayed reaction, optionally with a note (e.g. Delta H) on the right
#let rxn(s, note: none) = block(width: 100%, spacing: 1.1em, breakable: false,
  if note == none { align(center, ce(s)) }
  else { grid(columns: (1fr, auto, 1fr), align: (left, center, right + horizon), [], ce(s), [#h(1em)#note]) })

// ---------- figures ----------
#let fg(name, cap, w: 100%) = figure(image("figs/" + name + ".svg", width: w), caption: cap)
#let fgs(names, cap, gap: 8pt) = figure(
  grid(columns: (1fr,) * names.len(), column-gutter: gap, align: bottom,
    ..names.map(n => image("figs/" + n + ".svg", width: 100%))),
  caption: cap)

// ---------- boxes ----------
#let _lab(t, col) = text(font: sans, size: 9.5pt, weight: "bold", fill: col, t)
#let _blk(label, body, col: black, bar: none, fill: none, stroke: none, brk: false) = block(
  width: 100%, breakable: brk, fill: fill, spacing: 1.15em, radius: if bar != none { 0pt } else { 4pt },
  stroke: if bar != none { (left: 1.5pt + bar) } else { stroke },
  inset: if bar != none { (left: 11pt, right: 9pt, y: 7pt) } else { (x: 10pt, y: 8pt) },
  { _lab(label, col); v(-4pt); body })

#let defn(title, body) = _blk([Definition: #title], body, fill: cblf, stroke: 0.7pt + cbl)
#let law(title, body) = _blk(title, body, fill: cblf, stroke: 0.7pt + cbl)
#let formula(title, body) = _blk(title, body, fill: cblf, stroke: 0.7pt + cbl)
#let intu(body) = _blk([Intuition], body, bar: luma(150))
#let idea(body) = _blk([What is this about?], body, bar: cbl, col: cbl)
#let micro(body) = _blk([Molecular picture], body, fill: rgb("#f5f1fa"), stroke: 0.6pt + cpu, col: cpu)
#let trick(title, body) = _blk([Trick: #title], body, fill: rgb("#f2f8ee"), stroke: 0.6pt + cgr, col: cgr)
#let remember(body) = _blk([Remember], body, col: crd, bar: crd)
#let mistake(body) = _blk([Common mistakes], body, col: crd, bar: crd)
#let recipe(title, body) = _blk([Recipe: #title], body, fill: luma(248), stroke: 0.6pt + luma(140))
#let why(title, body) = _blk([Why? #title], body, bar: luma(150))
#let everyday(body) = _blk([In everyday life and engineering], body, fill: rgb("#fdf5ea"), stroke: 0.6pt + rgb("#c7741a"), col: rgb("#9a520c"), brk: true)
#let check(q, a) = block(width: 100%, breakable: false, spacing: 1.15em, inset: (x: 10pt, y: 7pt), radius: 4pt,
  stroke: (paint: luma(150), thickness: 0.6pt, dash: "dashed"), {
    _lab([Check yourself], luma(60)); v(-4pt); q
    v(-2pt); text(size: 9.5pt, fill: luma(70))[#text(font: sans, size: 8.5pt, weight: "bold")[Answer.] #a]
  })
#let ex(title, body) = block(width: 100%, breakable: true, spacing: 1.3em, radius: 4pt, clip: true,
  stroke: 0.7pt + crd, fill: luma(249), {
    block(width: 100%, fill: crd, inset: (x: 10pt, y: 4.5pt), sticky: true, below: 0pt,
      text(font: sans, size: 9.5pt, weight: "bold", fill: white)[Worked example: #title])
    block(width: 100%, inset: (x: 10pt, top: 8pt, bottom: 9pt), above: 0pt, body)
  })
#let step(t) = text(font: sans, size: 8.5pt, weight: "bold", fill: crd, t)
#let summary(body) = block(width: 100%, breakable: false, fill: cblf, stroke: 0.7pt + cbl, radius: 4pt, inset: 11pt, spacing: 1.4em,
  [#text(font: sans, size: 10pt, weight: "bold")[The essentials in brief] #v(1pt) #body])
#let lecture(t) = text(size: 9.5pt, style: "italic", t)

// ---------- exercises ----------
#let _pnr = counter("problem")
#let problems() = {
  _pnr.update(0)
  pagebreak(weak: true)
  heading(level: 2)[Problems with solutions]
  text(size: 9.5pt, style: "italic")[Typical exam problems for this chapter. Try them yourself first, then read the solution.]
}
#let prob(title, fig: none, fw: 5.5cm, a, l) = {
  _pnr.step()
  block(width: 100%, breakable: false, spacing: 1.3em, radius: 4pt, clip: true, stroke: 0.7pt + crd, fill: luma(249), {
    block(width: 100%, fill: crd, inset: (x: 10pt, y: 4.5pt), sticky: true, below: 0pt,
      text(font: sans, size: 9.5pt, weight: "bold", fill: white, context [Problem #counter(heading).get().first().#_pnr.get().first(): #title]))
    block(width: 100%, inset: (x: 10pt, top: 8pt, bottom: 9pt), above: 0pt, {
      block(breakable: false, sticky: true, width: 100%, {
        if fig != none {
          grid(columns: (1fr, fw), column-gutter: 12pt, align: (top, center + horizon), a, image("figs/" + fig + ".svg", width: fw))
        } else { a }
        v(2pt); line(length: 100%, stroke: 0.4pt + luma(170)); v(-2pt)
        text(font: sans, size: 9pt, weight: "bold")[Solution]
      })
      v(-3pt)
      l
    })
  })
}

// ---------- lecture markers (like the week bars in the Mechanik script) ----------
#let lec(n, topic, brown) = {
  block(width: 100%, above: 1.8em, below: 1.1em, sticky: true, breakable: false, fill: black, radius: 3pt,
    inset: (x: 12pt, y: 9pt), {
    [#metadata(n) <lecture>]
    grid(columns: (auto, 1fr), column-gutter: 14pt, align: horizon,
      text(font: sans, size: 20pt, weight: "bold", fill: white)[Lecture #n],
      par(justify: false, leading: 0.45em)[#text(font: sans, size: 11.5pt, weight: "bold", fill: white, topic) \ #text(font: sans, size: 9pt, fill: luma(210))[Brown #brown]])
  })
}
#let nolec = [#metadata(none) <lecture>]

// ---------- page layout ----------
#let script(body) = {
  set page(paper: "a4", margin: (x: 2.6cm, top: 2.8cm, bottom: 2.6cm),
    header: context {
      let p = counter(page).get().first()
      let h1 = query(heading.where(level: 1)).filter(h => h.location().page() == here().page())
      if p > 2 and h1.len() == 0 {
        let hs = query(selector(heading.where(level: 1)).before(here()))
        let t = if hs.len() > 0 { hs.last().body } else { [] }
        let n = if hs.len() > 0 and hs.last().numbering != none { [#counter(heading).get().first() #h(0.3em)] } else { [] }
        let ls = query(<lecture>).filter(m => m.location().page() <= here().page())
        let lab = if ls.len() > 0 and ls.last().value != none [Lecture #ls.last().value] else [Chemistry]
        let w = box(fill: black, radius: 2pt, inset: (x: 5pt, y: 2.5pt), baseline: 2.5pt, text(font: sans, size: 9pt, weight: "bold", fill: white, lab))
        text(size: 9pt)[#n#t #h(1fr) #w]
        v(-7pt); line(length: 100%, stroke: 0.5pt)
      }
    },
    footer: context { let p = counter(page).get().first(); if p > 1 { align(center, text(size: 9.5pt, str(p))) } })
  set text(font: "New Computer Modern", size: 10.5pt, lang: "en", region: "gb")
  set par(justify: true, leading: 0.7em, spacing: 1.05em)
  show math.equation.where(block: true): set block(spacing: 1.15em)
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    v(0.3cm)
    if it.numbering != none { text(font: sans, size: 15pt, weight: "bold")[Chapter #counter(heading).display("1")]; v(0.1cm) }
    par(justify: false, text(font: sans, size: 23pt, weight: "bold", hyphenate: false, it.body))
    v(0.1cm); line(length: 100%, stroke: 0.8pt); v(0.7cm)
  }
  show heading.where(level: 2): it => block(sticky: true, above: 1.8em, below: 0.9em, text(font: sans, size: 14.5pt, weight: "bold", [#counter(heading).display() #h(0.7em) #it.body]))
  show heading.where(level: 3): it => block(sticky: true, above: 1.4em, below: 0.7em, text(font: sans, size: 11pt, weight: "bold", it.body))
  show heading.where(level: 4): it => block(sticky: true, above: 1.2em, below: 0.6em, text(font: sans, size: 10pt, weight: "bold", it.body))
  set figure(numbering: n => str(counter(heading).get().first()) + "." + str(n), supplement: [Fig.], gap: 0.9em)
  show figure.caption: it => text(size: 9pt, it)
  show figure: set block(spacing: 1.6em)
  show table: set text(size: 9.5pt)
  set table(stroke: (x, y) => if y == 0 { (bottom: 0.6pt) } else { none }, inset: (x: 6pt, y: 4pt))
  set list(indent: 0.6em, marker: [•])
  set enum(indent: 0.6em)
  body
}

// units helper inside math: $u("J mol^-1 K^-1")$ is not needed; write units as "J"/"mol" text in math.
#let dH = $Delta H$
#let dG = $Delta G$
#let dS = $Delta S$
#let dE = $Delta E$
#let dHf = $Delta H_f^degree$
#let dGf = $Delta G_f^degree$

// ---------- real photographs (Wikimedia Commons, credited in the caption) ----------
#let _ph(name, h) = box(clip: true, radius: 4pt, image("photos/" + name + ".jpg", height: h))
#let photo(names, cap, ht: 4.6cm, gap: 6pt) = figure(
  box(names.map(n => _ph(n, ht)).join(h(gap))), caption: cap)
#let credit(t) = text(size: 7.5pt, fill: luma(110))[Photo: #t]
