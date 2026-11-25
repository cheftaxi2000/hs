// ================= Informatics script: layout and boxes =================
#let sans = "CMU Sans Serif"
#let mono = "JetBrains Mono"
#let cbl = rgb("#c26a10")      // frame of definition / rule boxes (amber)
#let cblf = rgb("#fdf4e7")
#let crd = rgb("#a3222e")      // head of example boxes
#let cpu = rgb("#5b4a9a")      // "under the hood"
#let cgr = rgb("#2a7f5a")
#let cor = rgb("#c7741a")

// ---------- code ----------
#show raw: set text(font: mono, size: 8.6pt)
#let _out(txt, inp) = block(width: 100%, fill: rgb("#1f2a2d"), radius: (bottom: 4pt), inset: (x: 10pt, y: 7pt), above: 0pt, spacing: 1.2em, {
  if inp != "" {
    text(font: sans, size: 7.5pt, weight: "bold", fill: rgb("#8fd3c6"))[INPUT]; v(-6pt)
    text(font: mono, size: 8.4pt, fill: rgb("#ffd479"), raw(inp.trim("\n", at: end), block: true)); v(1pt)
  }
  text(font: sans, size: 7.5pt, weight: "bold", fill: rgb("#8fd3c6"))[OUTPUT]; v(-6pt)
  text(font: mono, size: 8.4pt, fill: rgb("#e8f1ee"), raw(txt.trim("\n", at: end), block: true))
})
#let cpp(name, out: true) = {
  let src = read("code/" + name + ".cpp").trim("\n", at: end)
  let long = src.split("\n").len() > 30
  block(width: 100%, spacing: 1.2em, breakable: long, {
    block(width: 100%, breakable: long, fill: rgb("#f5f8f7"), stroke: 0.6pt + luma(195), radius: if out { (top: 4pt) } else { 4pt },
      inset: (x: 9pt, y: 7pt), above: 0pt, below: 0pt, raw(src, lang: "cpp", block: true))
    if out { _out(read("out/" + name + ".txt"), read("out/" + name + ".in")) }
  })
}
#let err(name) = block(width: 100%, spacing: 1.2em, breakable: false, {
  let src = read("code/" + name + ".cpp").trim("\n", at: end)
  block(width: 100%, fill: rgb("#f5f8f7"), stroke: 0.6pt + luma(195), radius: (top: 4pt), inset: (x: 9pt, y: 7pt), above: 0pt, below: 0pt, raw(src, lang: "cpp", block: true))
  block(width: 100%, fill: rgb("#3a1f22"), radius: (bottom: 4pt), inset: (x: 10pt, y: 7pt), above: 0pt, spacing: 1.2em, {
    text(font: sans, size: 7.5pt, weight: "bold", fill: rgb("#ff9d96"))[COMPILER MESSAGE]; v(-6pt)
    text(font: mono, size: 8pt, fill: rgb("#ffe3e0"), raw(read("out/" + name + ".txt").trim("\n", at: end), block: true))
  })
})
// short code snippet (no file)
#let snip(src) = block(width: 100%, spacing: 1.2em, breakable: false, fill: rgb("#f5f8f7"), stroke: 0.6pt + luma(195), radius: 4pt,
  inset: (x: 9pt, y: 7pt), raw(src.trim("\n"), lang: "cpp", block: true))

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
#let rule(title, body) = _blk(title, body, fill: cblf, stroke: 0.7pt + cbl)
#let intu(body) = _blk([Intuition], body, bar: luma(150))
#let idea(body) = _blk([What is this about?], body, bar: cbl, col: cbl)
#let hood(body) = _blk([Under the hood], body, fill: rgb("#f3f1fa"), stroke: 0.6pt + cpu, col: cpu)
#let trick(title, body) = _blk([Trick: #title], body, fill: rgb("#f2f8ee"), stroke: 0.6pt + cgr, col: cgr)
#let remember(body) = _blk([Remember], body, col: crd, bar: crd)
#let mistake(body) = _blk([Common mistakes], body, col: crd, bar: crd)
#let recipe(title, body) = _blk([Recipe: #title], body, fill: luma(248), stroke: 0.6pt + luma(140))
#let why(title, body) = _blk([Why? #title], body, bar: luma(150))
#let everyday(body) = _blk([In practice], body, fill: rgb("#eef4fb"), stroke: 0.6pt + rgb("#2f6fb0"), col: rgb("#235a92"), brk: true)
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
// trace table: header row of variable names, then rows
#let trace(head, ..rows) = {
  let n = head.len()
  align(center, block(breakable: false, spacing: 1.1em, table(columns: (auto,) * n, align: center, inset: (x: 8pt, y: 3.5pt),
    stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
    ..head.map(h => text(font: mono, size: 8.6pt, weight: "bold", h)),
    ..rows.pos().flatten().map(c => text(font: mono, size: 8.6pt, c)))))
}

// ---------- exercises ----------
#let _pnr = counter("problem")
#let problems() = {
  _pnr.update(0)
  pagebreak(weak: true)
  heading(level: 2)[Problems with solutions]
  text(size: 9.5pt, style: "italic")[Typical exam-style problems. Try them yourself first (ideally on paper, then in the compiler), and only then read the solution.]
}
#let prob(title, fig: none, fw: 5.5cm, a, l) = {
  _pnr.step()
  block(width: 100%, breakable: true, spacing: 1.3em, radius: 4pt, clip: true, stroke: 0.7pt + crd, fill: luma(249), {
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
#let lec(n, topic, keys) = {
  block(width: 100%, above: 1.8em, below: 1.1em, sticky: true, breakable: false, fill: black, radius: 3pt,
    inset: (x: 12pt, y: 9pt), {
    [#metadata(n) <lecture>]
    show raw.where(block: false): it => text(font: mono, size: 8.2pt, it.text)
    grid(columns: (auto, 1fr), column-gutter: 14pt, align: horizon,
      text(font: sans, size: 20pt, weight: "bold", fill: white)[Lecture #n],
      par(justify: false, leading: 0.45em)[#text(font: sans, size: 11.5pt, weight: "bold", fill: white, topic) \ #text(font: sans, size: 9pt, fill: luma(210), keys)])
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
        let lab = if ls.len() > 0 and ls.last().value != none [Lecture #ls.last().value] else [Informatics]
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
  show raw.where(block: false): it => box(fill: luma(240), inset: (x: 2.2pt), outset: (y: 2.4pt), radius: 2pt, it)
  body
}

// ---------- real photographs (Wikimedia Commons, credited in the caption) ----------
#let _ph(name, h) = box(clip: true, radius: 4pt, image("photos/" + name + ".jpg", height: h))
#let photo(names, cap, ht: 4.6cm, gap: 6pt) = figure(
  box(names.map(n => _ph(n, ht)).join(h(gap))), caption: cap)
#let credit(t) = text(size: 7.5pt, fill: luma(110))[Photo: #t]
