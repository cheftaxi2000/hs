// Lineare Abbildungen der Ebene: Spalten = Bilder der Basisvektoren, Determinante, Kern und Bild (Lineare Algebra, Woche 7–14)
import {
  C, TAU, clamp, Stage, Runner, View, line, path, poly, circle, dot, ring, arrow, arcArrow, mlabel, text, fmt,
  el, seg, chip, readout, transport, layout, stepper, typeset, alpha, smooth,
} from '../core.js';

export const meta = {
  id: 'abbildung',
  group: 'Lineare Algebra',
  short: 'Abbildung',
  tag: 'Lineare Algebra · Woche 7–9 und 14',
  title: 'Was macht eine Matrix mit der Ebene?',
  card: 'Ziehe die Spalten der Matrix: Das Gitter folgt, die Determinante ist der Flächenfaktor, ihr Vorzeichen die Orientierung. Bei det = 0 fällt die Ebene auf eine Gerade.',
};

const PRESETS = {
  id: { label: 'Identität', A: [[1, 0], [0, 1]] },
  rot: { label: 'Drehung 30°', A: [[Math.cos(Math.PI / 6), -Math.sin(Math.PI / 6)], [Math.sin(Math.PI / 6), Math.cos(Math.PI / 6)]] },
  spg: { label: 'Spiegelung', A: [[Math.cos(Math.PI / 3), Math.sin(Math.PI / 3)], [Math.sin(Math.PI / 3), -Math.cos(Math.PI / 3)]] },
  sch: { label: 'Scherung', A: [[1, 1], [0, 1]] },
  str: { label: 'Streckung', A: [[1.5, 0], [0, 0.6]] },
  dst: { label: 'Drehstreckung', A: [[0.9, -0.9], [0.9, 0.9]] },
  proj: { label: 'Projektion', A: [[0.2, 0.4], [0.4, 0.8]] },
  sing: { label: 'Rang 1', A: [[1, -0.5], [0.5, -0.25]] },
};
const det = (A) => A[0][0] * A[1][1] - A[0][1] * A[1][0];
const mul = (A, p) => [A[0][0] * p[0] + A[0][1] * p[1], A[1][0] * p[0] + A[1][1] * p[1]];
/* the letter F (orientation marker) */
const F = [[0.15, 0.1], [0.32, 0.1], [0.32, 0.45], [0.62, 0.45], [0.62, 0.6], [0.32, 0.6], [0.32, 0.78], [0.72, 0.78], [0.72, 0.93], [0.15, 0.93]];

/** columns interpolated in polar form so that rotations look like rotations */
function morph(A, t) {
  const col = (j) => {
    const e = j === 0 ? [1, 0] : [0, 1], a = [A[0][j], A[1][j]];
    const r0 = 1, r1 = Math.hypot(...a), p0 = Math.atan2(e[1], e[0]);
    let p1 = Math.atan2(a[1], a[0]); let d = p1 - p0; while (d > Math.PI) d -= TAU; while (d < -Math.PI) d += TAU;
    if (r1 < 1e-9) return [e[0] * (1 - t), e[1] * (1 - t)];
    const r = r0 + (r1 - r0) * t, p = p0 + d * t; return [r * Math.cos(p), r * Math.sin(p)];
  };
  const c1 = col(0), c2 = col(1); return [[c1[0], c2[0]], [c1[1], c2[1]]];
}

function draw(ctx, W, H, S, opt = {}) {
  const A = morph(S.A, smooth(S.t)), d = det(A);
  const view = new View().fit(-3.2, 3.2, -2.6, 2.6, 0, 0, W, H, opt.thumb ? 6 : 18);
  const X = (p) => view.P(p), s = view.s;
  const [wx0, wy1] = view.inv(0, 0), [wx1, wy0] = view.inv(W, H);
  // original grid
  ctx.save(); ctx.strokeStyle = C.grid; ctx.lineWidth = 1; ctx.beginPath();
  for (let x = Math.ceil(wx0); x <= wx1; x++) { ctx.moveTo(view.X(x), 0); ctx.lineTo(view.X(x), H); }
  for (let y = Math.ceil(wy0); y <= wy1; y++) { ctx.moveTo(0, view.Y(y)); ctx.lineTo(W, view.Y(y)); }
  ctx.stroke(); ctx.restore();
  // transformed grid
  const R = 9;
  ctx.save(); ctx.beginPath(); ctx.lineWidth = 1; ctx.strokeStyle = alpha(C.v, C.dark ? 0.4 : 0.3);
  for (let k = -R; k <= R; k++) {
    const a = X(mul(A, [k, -R])), b = X(mul(A, [k, R])); ctx.moveTo(...a); ctx.lineTo(...b);
    const c = X(mul(A, [-R, k])), e = X(mul(A, [R, k])); ctx.moveTo(...c); ctx.lineTo(...e);
  }
  ctx.stroke(); ctx.restore();
  // transformed axes
  line(ctx, ...X(mul(A, [-R, 0])), ...X(mul(A, [R, 0])), alpha(C.v, 0.7), 1.3);
  line(ctx, ...X(mul(A, [0, -R])), ...X(mul(A, [0, R])), alpha(C.m, 0.7), 1.3);
  // kernel and image when singular
  const sing = Math.abs(d) < 0.02 && S.t > 0.98;
  if (sing && S.layers.kern) {
    const c1 = [A[0][0], A[1][0]], c2 = [A[0][1], A[1][1]];
    const im = Math.hypot(...c1) > 1e-6 ? c1 : c2;
    const kv = Math.abs(A[0][0]) + Math.abs(A[0][1]) > 1e-6 ? [A[0][1], -A[0][0]] : Math.abs(A[1][0]) + Math.abs(A[1][1]) > 1e-6 ? [A[1][1], -A[1][0]] : null;
    if (kv) {
      const k = kv.map((v) => v / Math.hypot(...kv));
      line(ctx, ...X([-k[0] * 9, -k[1] * 9]), ...X([k[0] * 9, k[1] * 9]), C.f, 2, [7, 5]);
      if (!opt.thumb) {
        mlabel(ctx, 'Kern', X([k[0] * 2.2, k[1] * 2.2])[0] + 8, X([k[0] * 2.2, k[1] * 2.2])[1] - 10, C.f, { size: 15, upright: true });
        for (const t of [-2, -1, 1, 2]) { const p = X([k[0] * t * 0.9, k[1] * t * 0.9]); dot(ctx, p[0], p[1], 3, C.f); }
      }
    }
    const m = im.map((v) => v / Math.hypot(...im));
    line(ctx, ...X([-m[0] * 9, -m[1] * 9]), ...X([m[0] * 9, m[1] * 9]), C.k, 3);
    if (!opt.thumb) mlabel(ctx, 'Bild', X([m[0] * 2.6, m[1] * 2.6])[0] + 8, X([m[0] * 2.6, m[1] * 2.6])[1] + 14, C.k, { size: 15, upright: true });
  }
  // unit circle → ellipse
  if (S.layers.kreis) {
    const pts = []; for (let i = 0; i <= 128; i++) { const a = (i / 128) * TAU; pts.push(X(mul(A, [Math.cos(a), Math.sin(a)]))); }
    circle(ctx, view.X(0), view.Y(0), s, alpha(C.muted, 0.6), 1, null, [3, 4]);
    poly(ctx, pts, C.m, 1.6);
  }
  // unit square → parallelogram (signed area = det)
  const sq = [[0, 0], [1, 0], [1, 1], [0, 1]].map((p) => X(mul(A, p)));
  poly(ctx, sq, d >= 0 ? C.k : C.f, 1.6, { close: true, fill: alpha(d >= 0 ? C.k : C.f, C.dark ? 0.22 : 0.16) });
  if (!opt.thumb && Math.abs(d) > 0.05) {
    const c = X(mul(A, [0.5, 0.5]));
    text(ctx, `det = ${fmt(d, 2)}`, c[0], c[1], d >= 0 ? C.k : C.f, { size: 13, font: 'mono', align: 'center', halo: true, weight: 500 });
  }
  // the F
  if (S.layers.f) {
    const fp = F.map((p) => X(mul(A, [p[0] + 1.25, p[1] + 0.35])));
    poly(ctx, fp, C.ink, 1.4, { close: true, fill: alpha(C.ink, C.dark ? 0.55 : 0.75) });
  }
  // basis images (columns)
  const o = X([0, 0]), c1 = X([A[0][0], A[1][0]]), c2 = X([A[0][1], A[1][1]]);
  arrow(ctx, o[0], o[1], c1[0], c1[1], C.v, 3, 14);
  arrow(ctx, o[0], o[1], c2[0], c2[1], C.m, 3, 14);
  if (!opt.thumb) {
    ring(ctx, c1[0], c1[1], 9, C.v, 2); ring(ctx, c2[0], c2[1], 9, C.m, 2);
    const lab = (p, q, txt, col) => { const dx = q[0] - p[0], dy = q[1] - p[1], L = Math.hypot(dx, dy) || 1; mlabel(ctx, txt, q[0] + (dx / L) * 22, q[1] + (dy / L) * 22, col, { size: 16, align: 'center' }); };
    lab(o, c1, '**a**_1', C.v); lab(o, c2, '**a**_2', C.m);
    // orientation arc
    if (Math.abs(d) > 0.05) {
      const a1 = Math.atan2(-(c1[1] - o[1]), c1[0] - o[0]), a2 = Math.atan2(-(c2[1] - o[1]), c2[0] - o[0]);
      let da = a2 - a1; while (da > Math.PI) da -= TAU; while (da < -Math.PI) da += TAU;
      arcArrow(ctx, o[0], o[1], 34, -a1, -(a1 + da), alpha(d >= 0 ? C.k : C.f, 0.9), 1.6, 8);
    }
  }
  dot(ctx, o[0], o[1], 3.2, C.ink);
}

export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  draw(ctx, W, H, { A: [[1.1, 0.7], [0.25, 0.95]], t: 1, layers: { f: true, kreis: true, kern: true } }, { thumb: true });
}

const STEPS = [
  { title: 'Die Spalten sind die Bilder der Basisvektoren', set: { p: 'sch', t: 0, play: true, layers: { f: true, kreis: false, kern: true } },
    html: '<p>Eine lineare Abbildung ist festgelegt, sobald man weiß, wohin $\\boldsymbol e_1$ und $\\boldsymbol e_2$ gehen. Genau das steht in den Spalten:</p>$$A = \\bigl(f(\\boldsymbol e_1)\\ \\big|\\ f(\\boldsymbol e_2)\\bigr).$$<p>Ziehe die Pfeilspitzen von $\\boldsymbol a_1$ und $\\boldsymbol a_2$. Das ganze Gitter folgt.</p>' },
  { title: 'Gitter bleibt Gitter', set: { p: 'dst', t: 0, play: true, layers: { f: true, kreis: false, kern: true } },
    html: '<p>Geraden bleiben Geraden, Parallelen bleiben parallel, gleiche Abstände bleiben gleich, und der Nullpunkt bleibt fest. Das ist Linearität in Bildern:</p>$$f(c\\,\\boldsymbol u + d\\,\\boldsymbol v) = c\\,f(\\boldsymbol u) + d\\,f(\\boldsymbol v).$$' },
  { title: 'Die Determinante ist ein Flächenfaktor', set: { p: 'str', t: 0, play: true, layers: { f: true, kreis: false, kern: true } },
    html: '<p>Das Einheitsquadrat wird zum Parallelogramm aus $\\boldsymbol a_1$ und $\\boldsymbol a_2$. Seine orientierte Fläche ist</p>$$\\det A = a_{11}a_{22} - a_{12}a_{21}.$$<p>Jede Fläche in der Ebene wird mit demselben Faktor multipliziert, auch das F. Deshalb gilt $\\det(AB) = \\det A\\cdot\\det B$: Hintereinander ausgeführt multiplizieren sich die Faktoren.</p>' },
  { title: 'Das Vorzeichen ist die Orientierung', set: { p: 'spg', t: 0, play: true, layers: { f: true, kreis: false, kern: true } },
    html: '<p>Bei einer Spiegelung liegt $\\boldsymbol a_2$ rechts von $\\boldsymbol a_1$: Der Drehsinn kehrt sich um, das F erscheint seitenverkehrt, und $\\det A < 0$. Ziehe $\\boldsymbol a_2$ langsam über $\\boldsymbol a_1$ hinweg und beobachte, wie die Fläche durch null geht.</p>' },
  { title: 'det = 0: Die Ebene fällt auf eine Gerade', set: { p: 'proj', t: 0, play: true, layers: { f: true, kreis: false, kern: true } },
    html: '<p>Sind die Spalten parallel, so ist das Parallelogramm flach. Alles landet auf einer Geraden, dem <b>Bild</b>. Eine ganze Gerade, der <b>Kern</b>, wird auf $\\boldsymbol 0$ abgebildet. Die Abbildung ist nicht umkehrbar.</p>$$\\dim\\operatorname{Kern} + \\dim\\operatorname{Bild} = 1 + 1 = 2.$$<p>Was der Kern an Dimension schluckt, fehlt im Bild.</p>' },
  { title: 'Orthogonal: Kreis bleibt Kreis', set: { p: 'rot', t: 0, play: true, layers: { f: true, kreis: true, kern: true } },
    html: '<p>Der Einheitskreis wird im Allgemeinen zur Ellipse. Bei Drehungen und Spiegelungen bleibt er ein Kreis: Längen und Winkel bleiben erhalten, $Q^\\top Q = I$ und $\\det Q = \\pm 1$. Vergleiche mit der Drehstreckung: Kreis, aber größer.</p>' },
];

export function mount(root) {
  const L0 = layout(root, meta);
  const S = { A: PRESETS.sch.A.map((r) => r.slice()), t: 1, layers: { f: true, kreis: false, kern: true }, preset: 'sch' };
  const viewOf = () => new View().fit(-3.2, 3.2, -2.6, 2.6, 0, 0, stage.w, stage.h, 18);
  const stage = new Stage(L0.stage, {
    draw: (ctx, W, H) => draw(ctx, W, H, S),
    pointer: {
      down(x, y) {
        if (S.t < 1) { S.t = 1; runner.pause(); }
        const v = viewOf();
        for (const j of [0, 1]) { const p = v.P([S.A[0][j], S.A[1][j]]); if (Math.hypot(p[0] - x, p[1] - y) < 28) return { j }; }
        return null;
      },
      drag(h, x, y) {
        const w = viewOf().inv(x, y); let a = [clamp(w[0], -3, 3), clamp(w[1], -2.5, 2.5)];
        if (S.snap) a = a.map((v) => Math.round(v * 4) / 4);
        // gentle magnetism to det = 0 so the singular case can be reached by hand
        const o = h.j === 0 ? [S.A[0][1], S.A[1][1]] : [S.A[0][0], S.A[1][0]];
        const lo = Math.hypot(...o);
        if (lo > 1e-6) { const crossv = (a[0] * o[1] - a[1] * o[0]) / lo; if (Math.abs(crossv) < 0.06) { const pr = (a[0] * o[0] + a[1] * o[1]) / (lo * lo); a = [o[0] * pr, o[1] * pr]; } }
        S.A[0][h.j] = a[0]; S.A[1][h.j] = a[1]; S.preset = null; presetSeg.set(null); upd();
      },
      hover(x, y) { const v = viewOf(); for (const j of [0, 1]) { const p = v.P([S.A[0][j], S.A[1][j]]); if (Math.hypot(p[0] - x, p[1] - y) < 28) return 'grab'; } return null; },
    },
  });
  L0.stage.append(el('div', { class: 'hint', html: 'Pfeilspitzen von <b>a</b><sub>1</sub> und <b>a</b><sub>2</sub> ziehen' }));
  const runner = new Runner({ stages: [stage], update(dt) { S.t = Math.min(1, S.t + dt / 1.6); if (S.t >= 1) runner.pause(); upd(); } });
  L0.tslot.append(transport(runner, { onRestart: () => { S.t = 0; runner.play(); }, label: el('span', { class: 'tlabel', html: 'Abbildung anwenden' }) }));

  const presetSeg = seg(Object.entries(PRESETS).map(([k, v]) => [k, v.label]), S.preset, (k) => setPreset(k, true));
  function setPreset(k, anim) { S.preset = k; S.A = PRESETS[k].A.map((r) => r.slice()); presetSeg.set(k); if (anim) { S.t = 0; runner.play(); } upd(); }
  const q = el('p', { class: 'question', html: 'Eine $2\\times 2$-Matrix ist eine Tabelle aus vier Zahlen. <b>Was bedeutet sie geometrisch, und was sagt ihre Determinante?</b>' });
  const steps = stepper(STEPS, (st) => { Object.assign(S.layers, st.set.layers); syncChips(); setPreset(st.set.p, false); S.t = 0; setTimeout(() => runner.play(), 200); });
  const chips = {
    f: chip('Figur F', true, C.ink, (v) => { S.layers.f = v; stage.invalidate(); }),
    kreis: chip('Einheitskreis', false, C.m, (v) => { S.layers.kreis = v; stage.invalidate(); }),
    kern: chip('Kern und Bild', true, C.f, (v) => { S.layers.kern = v; stage.invalidate(); }),
    snap: chip('Am Raster einrasten', false, C.muted, (v) => { S.snap = v; }),
  };
  const syncChips = () => { for (const k of ['f', 'kreis', 'kern']) chips[k].set(!!S.layers[k]); };
  const matEl = el('div', { class: 'formulas' });
  const ro = readout([['d', '<span class="var">det A</span>'], ['r', 'Rang'], ['o', 'Orientierung'], ['q', 'orthogonal']]);
  let tsT = 0;
  function upd() {
    const A = S.A, d = det(A);
    const rk = Math.hypot(...A[0], ...A[1]) < 1e-9 ? 0 : Math.abs(d) < 0.02 ? 1 : 2;
    ro.set('d', fmt(d, 3)); ro.set('r', `${rk}`);
    ro.set('o', Math.abs(d) < 0.02 ? 'entartet' : d > 0 ? 'erhalten' : 'umgekehrt');
    const QtQ = [A[0][0] ** 2 + A[1][0] ** 2, A[0][0] * A[0][1] + A[1][0] * A[1][1], A[0][1] ** 2 + A[1][1] ** 2];
    ro.set('q', Math.abs(QtQ[0] - 1) < 0.03 && Math.abs(QtQ[2] - 1) < 0.03 && Math.abs(QtQ[1]) < 0.03 ? 'ja' : 'nein');
    clearTimeout(tsT);
    tsT = setTimeout(() => { const f = (v) => fmt(v, 2); matEl.innerHTML = `$$A = \\begin{pmatrix} \\color{${C.v}}{${f(A[0][0])}} & \\color{${C.m}}{${f(A[0][1])}} \\\\ \\color{${C.v}}{${f(A[1][0])}} & \\color{${C.m}}{${f(A[1][1])}} \\end{pmatrix}$$`; typeset(matEl); }, 120);
    stage.invalidate();
  }
  const box = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Erkunden' }), presetSeg, matEl, el('div', { class: 'toggles' }, ...Object.values(chips)), ro);
  const formulas = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Formeln aus dem Skript' }), el('div', { class: 'formulas', html:
    '$$\\det\\begin{pmatrix} a & b \\\\ c & d\\end{pmatrix} = ad - bc,\\qquad \\det(AB) = \\det A\\,\\det B$$<p>Rangsatz</p>$$\\dim V = \\dim\\operatorname{Kern}(f) + \\dim\\operatorname{Bild}(f)$$' }));
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Eine Matrix ist eine Verformung der Ebene, die Gitter auf Gitter abbildet. Ihre Spalten sagen wohin, ihre Determinante sagt, um welchen Faktor sich Flächen ändern und ob die Orientierung kippt.' });
  L0.panel.append(q, steps, box, formulas, insight, el('p', { class: 'src', html: 'Skript Lineare Algebra, Woche 7 (Drehungen, Spiegelungen), 8–9 (Determinanten, Produktsatz) und 14 (lineare Abbildungen, Kern, Bild, Rangsatz).' }));
  steps.go(0); typeset(L0.panel);
  return { destroy() { runner.destroy(); stage.destroy(); } };
}
