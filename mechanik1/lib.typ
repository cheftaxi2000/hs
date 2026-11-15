// ---------- Farben mit fester Bedeutung ----------
#let cv = rgb("#1b5fa6")   // Geschwindigkeiten
#let cf = rgb("#b83227")   // Kräfte
#let cm = rgb("#1d7a4c")   // Rotation, Momente
#let cg = luma(110)        // Hilfslinien
#let cl = luma(235)        // Flächen

// ---------- Vektor-Kürzel ----------
#let vr = $bold(r)$
#let vv = $bold(v)$
#let vF = $bold(F)$
#let vR = $bold(R)$
#let vM = $bold(M)$
#let vN = $bold(N)$
#let vG = $bold(G)$
#let vS = $bold(S)$
#let ve = $bold(e)$
#let va = $bold(a)$
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

// ---------- Zeichenwerkzeug (Koordinaten in cm, y nach oben) ----------
#let _p(p, h) = (p.at(0) * 1cm, (h - p.at(1)) * 1cm)
#let rad(d) = d * calc.pi / 180
#let pol(c, r, deg) = (c.at(0) + r * calc.cos(rad(deg)), c.at(1) + r * calc.sin(rad(deg)))
#let add(a, b) = (a.at(0) + b.at(0), a.at(1) + b.at(1))
#let sb(a, b) = (a.at(0) - b.at(0), a.at(1) - b.at(1))
#let mul(a, k) = (a.at(0) * k, a.at(1) * k)
#let mitte(a, b) = mul(add(a, b), 0.5)
#let len(a) = calc.sqrt(a.at(0) * a.at(0) + a.at(1) * a.at(1))
#let unit(a) = mul(a, 1 / len(a))
#let nrm(a) = (-a.at(1), a.at(0))
// schiefe Parallelprojektion für 3D-Skizzen: x nach vorn-links, y nach rechts, z nach oben
#let p3(o, x, y, z) = (o.at(0) + y - 0.5 * x, o.at(1) + z - 0.35 * x)

#let li(a, b, s: 0.6pt + black, dash: none) = h => place(top + left,
  line(start: _p(a, h), end: _p(b, h), stroke: if dash == none { s } else { (paint: s.paint, thickness: s.thickness, dash: dash) }))
#let dl(a, b, c: cg) = li(a, b, s: 0.5pt + c, dash: "dashed")
#let pl(pts, s: 0.6pt + black, fill: none, close: false, dash: none) = h => {
  let segs = (curve.move(_p(pts.at(0), h)),)
  for q in pts.slice(1) { segs.push(curve.line(_p(q, h))) }
  if close { segs.push(curve.close()) }
  let st = if s == none { none } else if dash == none { s } else { (paint: s.paint, thickness: s.thickness, dash: dash) }
  place(top + left, curve(stroke: st, fill: fill, ..segs))
}
#let poly(pts, fill: cl, s: 0.6pt + black) = pl(pts, s: s, fill: fill, close: true)
#let _head(tip, dir, c, size) = h => {
  let u = unit(dir); let n = nrm(u)
  let b = sb(tip, mul(u, size))
  place(top + left, curve(fill: c, stroke: none,
    curve.move(_p(tip, h)), curve.line(_p(add(b, mul(n, size * 0.36)), h)),
    curve.line(_p(sb(b, mul(n, size * 0.36)), h)), curve.close()))
}
#let arr(a, b, c: black, w: 1pt, hs: 0.2, dash: none) = h => {
  let u = unit(sb(b, a))
  li(a, sb(b, mul(u, hs * 0.8)), s: w + c, dash: dash)(h)
  _head(b, u, c, hs)(h)
}
#let arc(c, r, a0, a1, col: black, w: 0.6pt, head: false, hs: 0.17, dash: none, n: 40) = h => {
  let pts = range(n + 1).map(i => pol(c, r, a0 + (a1 - a0) * i / n))
  pl(pts, s: w + col, dash: dash)(h)
  if head {
    let t = nrm(sb(pts.last(), c)); if a1 < a0 { t = mul(t, -1) }
    // Spitze leicht in Bogenrichtung korrigiert
    _head(add(pts.last(), mul(unit(t), hs * 0.35)), add(unit(t), mul(unit(sb(c, pts.last())), hs / r * 0.5)), col, hs)(h)
  }
}
#let lbl(p, body, c: black, size: 9pt) = h => {
  let q = _p(p, h)
  place(top + left, dx: q.at(0) - 3cm, dy: q.at(1) - 1cm,
    box(width: 6cm, height: 2cm, align(center + horizon, text(size: size, fill: c, body))))
}
#let pt(p, r: 0.05, c: black) = h => {
  let q = _p(p, h)
  place(top + left, dx: q.at(0) - r * 1cm, dy: q.at(1) - r * 1cm, circle(radius: r * 1cm, fill: c, stroke: none))
}
#let circ(p, r, fill: none, s: 0.6pt + black, dash: none) = h => {
  let q = _p(p, h)
  let st = if s == none { none } else if dash == none { s } else { (paint: s.paint, thickness: s.thickness, dash: dash) }
  place(top + left, dx: q.at(0) - r * 1cm, dy: q.at(1) - r * 1cm, circle(radius: r * 1cm, fill: fill, stroke: st))
}
#let rct(a, b, fill: cl, s: 0.6pt + black) = poly((a, (b.at(0), a.at(1)), b, (a.at(0), b.at(1))), fill: fill, s: s)
// Schraffur auf der rechten Seite der Richtung a->b (Boden: a links, b rechts => Schraffur unten)
#let hatch(a, b, d: 0.16, step: 0.16) = h => {
  let u = unit(sb(b, a)); let n = mul(nrm(u), -1); let L = len(sb(b, a))
  li(a, b, s: 0.8pt + black)(h)
  let k = int(L / step)
  for i in range(1, k + 1) {
    let q = add(a, mul(u, i * step))
    li(q, add(add(q, mul(n, d)), mul(u, -d)), s: 0.4pt + cg)(h)
  }
}
#let beam(a, b, w: 2.4pt, c: black) = li(a, b, s: (thickness: w, paint: c, cap: "round"))
// Lager: p = Lagerpunkt, Dreieck nach unten
#let festlager(p, s: 0.32) = h => {
  let a = add(p, (-s * 0.6, -s)); let b = add(p, (s * 0.6, -s))
  poly((p, a, b), fill: white)(h)
  hatch(add(a, (-0.12, 0)), add(b, (0.12, 0)))(h)
  circ(p, 0.05, fill: white)(h)
}
#let loslager(p, s: 0.32) = h => {
  let a = add(p, (-s * 0.6, -s)); let b = add(p, (s * 0.6, -s))
  poly((p, a, b), fill: white)(h)
  li(add(a, (-0.12, 0)), add(b, (0.12, 0)))(h)
  hatch(add(a, (-0.12, -0.09)), add(b, (0.12, -0.09)))(h)
  circ(p, 0.05, fill: white)(h)
}
// Einspannung: Wand vertikal bei p, Höhe hh, Schraffur nach links (side=-1) oder rechts (+1)
#let wand(p, hh: 0.9, side: -1) = h => {
  let a = add(p, (0, -hh / 2)); let b = add(p, (0, hh / 2))
  if side < 0 { hatch(a, b)(h) } else { hatch(b, a)(h) }
}
#let gelenk(p) = circ(p, 0.06, fill: white)
#let zigzag(a, b, n: 8, amp: 0.12) = h => {
  let u = unit(sb(b, a)); let nn = nrm(u); let L = len(sb(b, a))
  let pts = (a, add(a, mul(u, L * 0.12)))
  for i in range(n) {
    let t = 0.12 + 0.76 * (i + 0.5) / n
    pts.push(add(add(a, mul(u, L * t)), mul(nn, if calc.even(i) { amp } else { -amp })))
  }
  pts.push(add(a, mul(u, L * 0.88))); pts.push(b)
  pl(pts)(h)
}
// Streckenlast: Pfeile von oben (Höhe hh) auf die Linie a-b; hh2 für Dreieckslast
#let dload(a, b, hh: 0.6, hh2: none, n: 7, c: cf) = h => {
  let e = if hh2 == none { hh } else { hh2 }
  pl((add(a, (0, hh)), add(b, (0, e))), s: 0.6pt + c)(h)
  for i in range(n + 1) {
    let q = add(a, mul(sb(b, a), i / n)); let k = hh + (e - hh) * i / n
    if k > 0.15 { arr(add(q, (0, k)), q, c: c, w: 0.6pt, hs: 0.13)(h) }
  }
}
#let bem(a, b, body, off: -0.35, t: 0.5) = h => {
  let u = unit(sb(b, a)); let n = nrm(u)
  let a2 = add(a, mul(n, off)); let b2 = add(b, mul(n, off))
  li(a2, b2, s: 0.4pt + cg)(h)
  li(add(a2, mul(n, 0.08)), sb(a2, mul(n, 0.08)), s: 0.4pt + cg)(h)
  li(add(b2, mul(n, 0.08)), sb(b2, mul(n, 0.08)), s: 0.4pt + cg)(h)
  lbl(add(add(a2, mul(sb(b2, a2), t)), mul(n, if off < 0 { -0.2 } else { 0.2 })), body, c: cg, size: 8pt)(h)
}
#let graph(f, x0, x1, o: (0, 0), sx: 1, sy: 1, n: 60, c: black, w: 1pt, dash: none) = h => {
  let pts = range(n + 1).map(i => { let t = x0 + (x1 - x0) * i / n; (o.at(0) + sx * t, o.at(1) + sy * f(t)) })
  pl(pts, s: w + c, dash: dash)(h)
}
#let axes(o, xl, yl, lx: $x$, ly: $y$, neg: 0.2) = h => {
  arr(add(o, (-neg, 0)), add(o, (xl, 0)), w: 0.5pt, hs: 0.14)(h)
  arr(add(o, (0, -neg)), add(o, (0, yl)), w: 0.5pt, hs: 0.14)(h)
  lbl(add(o, (xl + 0.18, 0)), lx)(h); lbl(add(o, (0, yl + 0.2)), ly)(h)
}
#let axes3(o, l: 2, lx: $x$, ly: $y$, lz: $z$) = h => {
  arr(o, p3(o, l, 0, 0), w: 0.5pt, hs: 0.14)(h); arr(o, p3(o, 0, l, 0), w: 0.5pt, hs: 0.14)(h); arr(o, p3(o, 0, 0, l), w: 0.5pt, hs: 0.14)(h)
  lbl(add(p3(o, l, 0, 0), (-0.15, -0.12)), lx)(h); lbl(add(p3(o, 0, l, 0), (0.2, 0)), ly)(h); lbl(add(p3(o, 0, 0, l), (0, 0.2)), lz)(h)
}

#let fig(w, h, caption: none, pb: 0.25, ..els) = figure(
  pad(bottom: pb * 1cm, box(width: w * 1cm, height: h * 1cm, for e in els.pos() { e(h) })),
  caption: caption,
)
#let sketch(w, h, ..els) = box(width: w * 1cm, height: h * 1cm, for e in els.pos() { e(h) })

// ---------- Kästen ----------
#let _box(label, body, col: black, fill: none) = block(width: 100%, breakable: false, fill: fill,
  stroke: (left: 1.6pt + col), inset: (left: 11pt, right: 9pt, y: 8pt), spacing: 1.1em,
  [#text(font: "Inter", size: 7.5pt, weight: 600, fill: col, tracking: 0.6pt, upper(label))\ #v(-2pt) #body])
#let defn(title, body) = _box([Definition #sym.dot.c #title], body)
#let satz(title, body) = _box([Satz #sym.dot.c #title], body, fill: luma(245))
#let intu(body) = _box([So kannst du es dir vorstellen], body, col: cv)
#let merke(body) = _box([Merke], body, col: cf)
#let fehler(body) = _box([Typische Fehler], body, col: cf)
#let bsp(title, body) = block(width: 100%, breakable: true, spacing: 1.1em, inset: (y: 2pt),
  [#text(font: "Inter", size: 8.5pt, weight: 600)[Beispiel #sym.dot.c #title] \ #body])
#let rezept(title, body) = _box([Vorgehen #sym.dot.c #title], body, col: cm)
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
        v(-6pt); line(length: 100%, stroke: 0.3pt + cg)
      }
    },
    footer: context { let p = counter(page).get().first(); if p > 1 { align(center, text(font: "Inter", size: 8pt, fill: cg, str(p))) } })
  set text(font: "New Computer Modern", size: 10.5pt, lang: "de", region: "de")
  set par(justify: true, leading: 0.68em, spacing: 1.05em)
  show math.equation.where(block: true): set block(spacing: 1.1em)
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
  show heading.where(level: 2): it => block(sticky: true, above: 1.6em, below: 0.9em, text(font: "Inter", size: 13pt, weight: 600, [#counter(heading).display() #h(0.5em) #it.body]))
  show heading.where(level: 3): it => block(sticky: true, above: 1.3em, below: 0.7em, text(font: "Inter", size: 10pt, weight: 600, it.body))
  set figure(numbering: n => str(counter(heading).get().first()) + "." + str(n), supplement: [Abb.], gap: 0.9em)
  show figure.caption: it => text(size: 8.8pt, fill: luma(60), it)
  show figure: set block(spacing: 1.5em)
  set list(indent: 0.6em, marker: [–])
  set enum(indent: 0.6em)
  body
}
