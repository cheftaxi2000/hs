// Kontraktionen, Hutchinson-Operator, Chaosspiel (Lineare Algebra, Woche 14)
import {
  C, TAU, clamp, Stage, Runner, View, line, poly, dot, ring, arrow, mlabel, text, fmt,
  el, seg, chip, readout, transport, layout, stepper, typeset, alpha, slider,
} from '../core.js';

export const meta = {
  id: 'fraktal',
  group: 'Lineare Algebra',
  short: 'Fraktale',
  tag: 'Lineare Algebra · Woche 14',
  title: 'Wie entsteht aus ein paar Matrizen ein Fraktal?',
  card: 'Drei affine Kontraktionen, zufällig angewandt: Die Punkte landen auf dem Attraktor. Jede Farbe ist eine verkleinerte Kopie des Ganzen.',
};

const SQ3 = Math.sqrt(3) / 2;
const P = [[0, 0], [1, 0], [0.5, SQ3]];
/** affine map sending P1,P2,P3 to Q1,Q2,Q3 */
function fromTriangle(Q) {
  const p1 = [P[1][0] - P[0][0], P[1][1] - P[0][1]], p2 = [P[2][0] - P[0][0], P[2][1] - P[0][1]];
  const q1 = [Q[1][0] - Q[0][0], Q[1][1] - Q[0][1]], q2 = [Q[2][0] - Q[0][0], Q[2][1] - Q[0][1]];
  const D = p1[0] * p2[1] - p2[0] * p1[1];
  const inv = [[p2[1] / D, -p2[0] / D], [-p1[1] / D, p1[0] / D]];
  const A = [[q1[0] * inv[0][0] + q2[0] * inv[1][0], q1[0] * inv[0][1] + q2[0] * inv[1][1]], [q1[1] * inv[0][0] + q2[1] * inv[1][0], q1[1] * inv[0][1] + q2[1] * inv[1][1]]];
  const b = [Q[0][0] - (A[0][0] * P[0][0] + A[0][1] * P[0][1]), Q[0][1] - (A[1][0] * P[0][0] + A[1][1] * P[0][1])];
  return { A, b };
}
const ap = (m, x) => [m.A[0][0] * x[0] + m.A[0][1] * x[1] + m.b[0], m.A[1][0] * x[0] + m.A[1][1] * x[1] + m.b[1]];
function norm2(A) {
  const a = A[0][0] ** 2 + A[1][0] ** 2, b = A[0][0] * A[0][1] + A[1][0] * A[1][1], c = A[0][1] ** 2 + A[1][1] ** 2;
  return Math.sqrt((a + c) / 2 + Math.sqrt(((a - c) / 2) ** 2 + b * b));
}
const sierpQ = () => [0, 1, 2].map((i) => P.map((p) => [(p[0] + P[i][0]) / 2, (p[1] + P[i][1]) / 2]));

const FARN = [
  { A: [[0, 0], [0, 0.16]], b: [0, 0], p: 0.01, name: 'Stiel' },
  { A: [[0.85, 0.04], [-0.04, 0.85]], b: [0, 1.6], p: 0.85, name: 'Hauptteil' },
  { A: [[0.2, -0.26], [0.23, 0.22]], b: [0, 1.6], p: 0.07, name: 'linkes Blättchen' },
  { A: [[-0.15, 0.28], [0.26, 0.24]], b: [0, 0.44], p: 0.07, name: 'rechtes Blättchen' },
];
const FARN_BOX = [[-2.2, 0], [2.7, 0], [2.7, 10], [-2.2, 10]];
const START = {
  quadrat: [[0.1, 0.05], [0.9, 0.05], [0.9, 0.85], [0.1, 0.85]],
  F: [[0.25, 0.05], [0.42, 0.05], [0.42, 0.38], [0.68, 0.38], [0.68, 0.52], [0.42, 0.52], [0.42, 0.68], [0.78, 0.68], [0.78, 0.82], [0.25, 0.82]],
  kreis: Array.from({ length: 40 }, (_, i) => [0.5 + 0.38 * Math.cos((i / 40) * TAU), 0.42 + 0.38 * Math.sin((i / 40) * TAU)]),
};

const cols = () => [C.v, C.f, C.m, C.k];

function maps(S) { return S.ifs === 'farn' ? FARN : S.Q.map(fromTriangle); }
function box(S) { return S.ifs === 'farn' ? [-3.2, 3.6, -0.3, 10.3] : [-0.12, 1.12, -0.12, 0.98]; }

/* ---------- chaos game buffer ---------- */
class Buffer {
  constructor() { this.cv = document.createElement('canvas'); this.ctx = this.cv.getContext('2d'); this.n = 0; }
  reset(W, H, dpr) {
    this.cv.width = Math.max(1, Math.round(W * dpr)); this.cv.height = Math.max(1, Math.round(H * dpr)); this.dpr = dpr;
    this.img = this.ctx.createImageData(this.cv.width, this.cv.height); this.n = 0; this.dirty = true;
  }
  plot(px, py, rgb, a = 255) {
    const x = Math.round(px * this.dpr), y = Math.round(py * this.dpr);
    if (x < 0 || y < 0 || x >= this.cv.width || y >= this.cv.height) return;
    const i = (y * this.cv.width + x) * 4, d = this.img.data;
    d[i] = rgb[0]; d[i + 1] = rgb[1]; d[i + 2] = rgb[2]; d[i + 3] = Math.min(255, d[i + 3] + a);
    this.n++;
  }
  flush() { if (this.dirty) { this.ctx.putImageData(this.img, 0, 0); this.dirty = false; } }
}
const rgbOf = (hex) => [1, 3, 5].map((i) => parseInt(hex.slice(i, i + 2), 16));

function drawScene(ctx, W, H, S, opt = {}) {
  const view = new View().fit(...box(S), 0, 0, W, H, opt.thumb ? 8 : 26);
  const X = (p) => view.P(p);
  const M = maps(S), K = cols();
  if (S.method === 'chaos') {
    if (S.buf) { S.buf.flush(); ctx.drawImage(S.buf.cv, 0, 0, W, H); }
  } else {
    // Hutchinson iteration of a start set
    const start = S.ifs === 'farn' ? FARN_BOX : START[S.start];
    const lvl = S.level;
    const polys = [];
    const rec = (pts, k, c) => { if (k === 0) { polys.push([pts, c]); return; } M.forEach((m, i) => rec(pts.map((p) => ap(m, p)), k - 1, c < 0 ? i : c)); };
    // apply H^lvl: outermost map decides the colour
    const go = (pts, k) => { if (k === 0) return [[pts, -1]]; const out = []; M.forEach((m, i) => { for (const [q] of go(pts, k - 1)) out.push([q.map((p) => ap(m, p)), i]); }); return out; };
    void rec;
    for (const [pts, c] of go(start, lvl)) poly(ctx, pts.map(X), lvl ? alpha(K[c], 0.9) : C.ink, lvl > 4 ? 0.6 : 1, { close: true, fill: alpha(lvl ? K[c] : C.ink, lvl ? (C.dark ? 0.45 : 0.35) : 0.12) });
  }
  // image triangles / boxes of the maps
  if (S.layers.maps) {
    if (S.ifs === 'farn') {
      poly(ctx, FARN_BOX.map(X), alpha(C.muted, 0.7), 1, { close: true, dash: [4, 4] });
      M.forEach((m, i) => {
        const q = FARN_BOX.map((p) => X(ap(m, p)));
        poly(ctx, q, K[i], 1.4, { close: true, fill: alpha(K[i], 0.05) });
        if (!opt.thumb) { const c = i === 0 ? [q[0][0] + 16, (q[0][1] + q[2][1]) / 2] : [(q[0][0] + q[2][0]) / 2, (q[0][1] + q[2][1]) / 2]; mlabel(ctx, `f_${i + 1}`, c[0], c[1], K[i], { size: 15, align: 'center' }); }
      });
    } else {
      poly(ctx, P.map(X), alpha(C.muted, 0.8), 1, { close: true, dash: [4, 4] });
      S.Q.forEach((Q, i) => {
        poly(ctx, Q.map(X), K[i], 1.6, { close: true, fill: alpha(K[i], 0.05) });
        if (!opt.thumb) Q.forEach((q, j) => { const p = X(q); ring(ctx, p[0], p[1], j === 0 ? 6 : 5, K[i], 1.6); });
        if (!opt.thumb) { const c = X([(Q[0][0] + Q[1][0] + Q[2][0]) / 3, (Q[0][1] + Q[1][1] + Q[2][1]) / 3]); mlabel(ctx, `f_${i + 1}`, c[0], c[1], K[i], { size: 15, align: 'center' }); }
      });
      if (!opt.thumb) P.forEach((p, i) => { const q = X(p); mlabel(ctx, `P_${i + 1}`, q[0] + (i === 0 ? -26 : i === 1 ? 10 : 10), q[1] + (i === 2 ? -6 : 14), C.muted, { size: 14 }); });
    }
  }
  // slow phase of the chaos game: show the jump
  if (S.method === 'chaos' && S.trail && !opt.thumb) {
    const { from, to, i } = S.trail;
    const a = X(from), b = X(to);
    arrow(ctx, a[0], a[1], b[0], b[1], K[i], 2, 10);
    dot(ctx, a[0], a[1], 3.5, C.muted); dot(ctx, b[0], b[1], 4.5, C.ink);
    if (S.ifs !== 'farn') { const c = X(P[i]); line(ctx, b[0], b[1], c[0], c[1], alpha(K[i], 0.5), 1, [3, 4]); }
  }
}

export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  const S = { ifs: 'sierpinski', method: 'chaos', Q: sierpQ(), layers: { maps: false } };
  const view = new View().fit(...box(S), 0, 0, W, H, 8), M = maps(S), K = cols();
  let x = [0.3, 0.3];
  for (let n = 0; n < 9000; n++) { const i = (Math.random() * 3) | 0; x = ap(M[i], x); if (n > 20) { const p = view.P(x); ctx.fillStyle = K[i]; ctx.fillRect(p[0], p[1], 1, 1); } }
}

const STEPS = [
  { title: 'Halber Weg zu einer zufälligen Ecke', set: { ifs: 'sierpinski', method: 'chaos', reset: true, layers: { maps: true } },
    html: '<p>Drei Abbildungen $f_i(\\boldsymbol x) = \\tfrac12(\\boldsymbol x + P_i)$: Jede zieht einen Punkt auf halbem Weg zur Ecke $P_i$. Jede ist eine affin-lineare <b>Kontraktion</b> mit $A = \\tfrac12 I$.</p><p>Das Chaosspiel: Wähle zufällig ein $f_i$, wende es an, wiederhole. Die ersten Sprünge laufen langsam.</p>' },
  { title: 'Die Punkte finden den Attraktor', set: { method: 'chaos', layers: { maps: false } },
    html: '<p>Nach wenigen Sprüngen liegen alle Punkte (beliebig nah) auf derselben Menge, egal wo man startet. Mit der Zeit füllen sie das <b>Sierpinski-Dreieck</b>.</p><p>Der Grund ist der Banachsche Fixpunktsatz, angewandt auf Mengen statt auf Punkte.</p>' },
  { title: 'Drei Kopien seiner selbst', set: { method: 'chaos', layers: { maps: true } },
    html: '<p>Die Farbe zeigt, welche Abbildung zuletzt angewandt wurde. Jede Farbe ist ein halb so großes Sierpinski-Dreieck:</p>$$A = f_1(A)\\cup f_2(A)\\cup f_3(A).$$<p>Daraus folgt die Dimension $s$ mit $3\\cdot(\\tfrac12)^s = 1$, also $s = \\ln 3/\\ln 2 \\approx 1.585$.</p>' },
  { title: 'Egal, womit man anfängt', set: { method: 'hutch', start: 'F', level: 0, play: true, layers: { maps: false } },
    html: '<p>Der Hutchinson-Operator ersetzt eine Menge durch die Vereinigung ihrer Bilder:</p>$$H(K) = f_1(K)\\cup f_2(K)\\cup f_3(K).$$<p>Starte mit einem F, einem Quadrat oder einem Kreis: Die Folge $K, H(K), H^2(K), \\dots$ läuft immer gegen dasselbe Dreieck.</p>' },
  { title: 'Selbst bauen', set: { method: 'chaos', layers: { maps: true } },
    html: '<p>Ziehe die Ecken der farbigen Dreiecke. Jedes Dreieck legt eine affine Abbildung fest: wohin $P_1, P_2, P_3$ gehen. Der Attraktor wird sofort neu gezeichnet.</p><p>Solange alle Abbildungen Kontraktionen sind ($\\|A_i\\| < 1$), gibt es genau einen Attraktor.</p>' },
  { title: 'Barnsleys Farn', set: { ifs: 'farn', method: 'chaos', reset: true, layers: { maps: true } },
    html: '<p>Vier affine Abbildungen mit 24 Zahlen erzeugen einen Farn. $f_1$ hat Rang 1 und quetscht alles auf den Stiel. $f_2$ bildet den ganzen Farn auf den Farn ohne die untersten Blätter ab. $f_3$, $f_4$ erzeugen die beiden unteren Blättchen.</p><p>Die gestrichelte Box und ihre vier farbigen Bilder zeigen das direkt.</p>' },
];

export function mount(root) {
  const SLOW = 14, MAXPTS = 260000;
  const L0 = layout(root, meta);
  const S = { ifs: 'sierpinski', method: 'chaos', Q: sierpQ(), layers: { maps: true }, start: 'F', level: 0, buf: new Buffer(), x: [0.31, 0.62], steps: 0, trail: null, slowT: 0 };
  const stage = new Stage(L0.stage, {
    draw: (ctx, W, H) => drawScene(ctx, W, H, S),
    pointer: {
      down(x, y) {
        if (S.ifs === 'farn' || !S.layers.maps) return null;
        const v = new View().fit(...box(S), 0, 0, stage.w, stage.h, 26);
        let best = null, bd = 26;
        S.Q.forEach((Q, i) => Q.forEach((q, j) => { const p = v.P(q), d = Math.hypot(p[0] - x, p[1] - y); if (d < bd) { bd = d; best = { i, j, v }; } }));
        return best;
      },
      drag(h, x, y) { const w = h.v.inv(x, y); S.Q[h.i][h.j] = [clamp(w[0], -0.1, 1.1), clamp(w[1], -0.1, 0.97)]; restart(); },
      hover(x, y) {
        if (S.ifs === 'farn' || !S.layers.maps) return null;
        const v = new View().fit(...box(S), 0, 0, stage.w, stage.h, 26);
        for (const Q of S.Q) for (const q of Q) { const p = v.P(q); if (Math.hypot(p[0] - x, p[1] - y) < 26) return 'grab'; }
        return null;
      },
    },
  });
  stage.onResize = () => { S.buf.reset(stage.w, stage.h, stage.dpr); if (S.steps >= SLOW) S.steps = SLOW; stage.invalidate(); };
  const hint = el('div', { class: 'hint', html: 'Ecken der farbigen Dreiecke ziehen' });
  L0.stage.append(hint);

  function restart(keepSlow) {
    S.buf.reset(stage.w, stage.h, stage.dpr); S.x = S.ifs === 'farn' ? [0, 0] : [0.31, 0.62]; S.steps = 0; S.trail = null;
    if (!keepSlow) S.slowT = 0;
    if (keepSlow) S.steps = 30;
    stage.invalidate(); upd();
  }
  function pick(M) {
    if (S.ifs !== 'farn') return (Math.random() * M.length) | 0;
    let r = Math.random(); for (let i = 0; i < M.length; i++) { r -= M[i].p; if (r <= 0) return i; } return M.length - 1;
  }
  const runner = new Runner({
    stages: [stage],
    update(dt) {
      if (S.method === 'hutch') {
        S.slowT += dt;
        if (S.slowT > 1.1) { S.slowT = 0; if (S.level < maxLevel()) { S.level++; lvlSl.set(S.level); upd(); } else runner.pause(); }
        return;
      }
      const M = maps(S), K = cols().map(rgbOf);
      const view = new View().fit(...box(S), 0, 0, stage.w, stage.h, 26);
      if (S.steps < SLOW) {
        S.slowT += dt;
        if (S.slowT > (S.steps < 4 ? 0.85 : 0.45)) {
          S.slowT = 0; const i = pick(M), nx = ap(M[i], S.x);
          S.trail = { from: S.x, to: nx, i }; S.x = nx; S.steps++;
          const p = view.P(nx); for (let k = 0; k < 6; k++) S.buf.plot(p[0] + (k % 3) - 1, p[1] + ((k / 3) | 0), K[i]); S.buf.dirty = true;
        }
      } else {
        S.trail = null;
        const n = Math.min(MAXPTS - S.buf.n, Math.round(60 + S.steps * 0.15));
        const a = S.ifs === 'farn' ? 140 : 200;
        for (let k = 0; k < n; k++) { const i = pick(M); S.x = ap(M[i], S.x); const p = view.P(S.x); S.buf.plot(p[0], p[1], K[i], a); }
        S.steps += n; S.buf.dirty = true;
        if (S.buf.n >= MAXPTS) runner.pause();
      }
      upd();
    },
  });
  const maxLevel = () => (S.ifs === 'farn' ? 6 : 7);
  L0.tslot.append(transport(runner, { onRestart: () => { if (S.method === 'hutch') { S.level = 0; lvlSl.set(0); S.slowT = 0; } else restart(); runner.play(); upd(); }, label: el('span', { class: 'tlabel' }) }));
  const tlabel = L0.tslot.querySelector('.tlabel');

  const ifsSeg = seg([['sierpinski', 'Sierpinski'], ['farn', 'Barnsley-Farn']], S.ifs, (k) => setIfs(k), 'scenes');
  L0.scenes.append(ifsSeg);
  function setIfs(k) { S.ifs = k; ifsSeg.set(k); if (k === 'sierpinski') S.Q = sierpQ(); S.level = Math.min(S.level, maxLevel()); lvlSl.input.max = maxLevel(); restart(); runner.play(); }

  const methodSeg = seg([['chaos', 'Chaosspiel'], ['hutch', 'Mengen iterieren']], S.method, (m) => { S.method = m; syncUI(); restart(true); runner.play(); });
  const startSeg = seg([['F', 'F'], ['quadrat', 'Quadrat'], ['kreis', 'Kreis']], S.start, (k) => { S.start = k; stage.invalidate(); });
  const lvlSl = slider({ id: 'fr-l', label: 'Anzahl Anwendungen von <span class="var">H</span>', min: 0, max: 7, step: 1, value: 0, format: (v) => `${v}`, onInput: (v) => { runner.pause(); S.level = v; upd(); } });
  const chips = { maps: chip('Abbildungen zeigen', true, C.ink, (v) => { S.layers.maps = v; hint.hidden = !v || S.ifs === 'farn'; stage.invalidate(); }) };
  const bReset = el('button', { type: 'button', class: 'btn', html: 'Sierpinski wiederherstellen' });
  bReset.addEventListener('click', () => { S.Q = sierpQ(); restart(); runner.play(); });
  const ro = readout([['n', 'Punkte'], ['q', 'Kontraktionsfaktoren ‖<span class="var">A<sub>i</sub></span>‖'], ['s', 'Dimension (Selbstähnlichkeit)']]);
  function upd() {
    const M = maps(S);
    tlabel.textContent = S.method === 'chaos' ? `${S.buf.n.toLocaleString('de-CH')} Punkte` : `H${'⁰¹²³⁴⁵⁶⁷'[S.level]}(K)`;
    ro.set('n', S.method === 'chaos' ? S.buf.n.toLocaleString('de-CH') : `${(M.length ** S.level).toLocaleString('de-CH')} Teilmengen`);
    const qs = M.map((m) => norm2(m.A)); const ok = qs.every((q) => q < 1);
    ro.set('q', qs.map((q) => fmt(q, 2)).join(' · ') + (ok ? '' : ' (keine Kontraktion!)'));
    // similarity dimension if all maps are similarities with the same ratio
    const sim = M.every((m) => Math.abs(m.A[0][0] - m.A[1][1]) < 1e-3 && Math.abs(m.A[0][1] + m.A[1][0]) < 1e-3 || Math.abs(m.A[0][0] + m.A[1][1]) < 1e-3 && Math.abs(m.A[0][1] - m.A[1][0]) < 1e-3);
    const r = qs[0];
    ro.set('s', sim && qs.every((q) => Math.abs(q - r) < 1e-3) && r < 1 && r > 0 ? `ln ${M.length} / ln ${fmt(1 / r, 2)} = ${fmt(Math.log(M.length) / Math.log(1 / r), 3)}` : '—');
    stage.invalidate();
  }
  function syncUI() {
    methodSeg.set(S.method); chips.maps.set(S.layers.maps);
    startSeg.hidden = S.method !== 'hutch' || S.ifs === 'farn'; lvlSl.hidden = S.method !== 'hutch';
    bReset.hidden = S.ifs === 'farn'; hint.hidden = !S.layers.maps || S.ifs === 'farn';
  }
  const q = el('p', { class: 'question', html: 'Ein Farn, ein Dreieck voller Löcher: <b>Wie können ein paar Matrizen und Vektoren so komplizierte Formen festlegen?</b>' });
  const steps = stepper(STEPS, (st) => {
    const s = st.set; runner.pause();
    if (s.ifs && s.ifs !== S.ifs) { S.ifs = s.ifs; ifsSeg.set(s.ifs); if (s.ifs === 'sierpinski') S.Q = sierpQ(); }
    if (s.ifs === 'sierpinski' && s.reset) S.Q = sierpQ();
    S.method = s.method; Object.assign(S.layers, s.layers);
    if (s.start) { S.start = s.start; startSeg.set(s.start); }
    if (s.level !== undefined) { S.level = s.level; lvlSl.set(s.level); }
    lvlSl.input.max = maxLevel();
    syncUI();
    if (S.method === 'chaos') restart(!s.reset && st !== STEPS[0]); else { S.slowT = 0; upd(); }
    setTimeout(() => runner.play(), 200);
  });
  const box1 = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Erkunden' }), methodSeg, startSeg, lvlSl, el('div', { class: 'toggles' }, chips.maps, bReset), ro);
  const formulas = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Formeln aus dem Skript' }), el('div', { class: 'formulas', html:
    '<p>Kontraktion</p>$$|f(\\boldsymbol x) - f(\\boldsymbol y)| \\le q\\,|\\boldsymbol x - \\boldsymbol y|,\\quad q<1$$<p>Hutchinson-Operator und Attraktor</p>$$H(K) = \\bigcup_{i=1}^m f_i(K),\\qquad H(A) = A$$' }));
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Kontraktionen ziehen alles auf einen Fixpunkt. Mehrere Kontraktionen zusammen ziehen alles auf eine Fixmenge, den Attraktor. Er besteht aus verkleinerten Kopien seiner selbst, eine pro Abbildung.' });
  L0.panel.append(q, steps, box1, formulas, insight, el('p', { class: 'src', html: 'Skript Lineare Algebra, Woche 14: Kontraktionen, Banachscher Fixpunktsatz, Hutchinson-Operator, Chaosspiel, Barnsleys Farn.' }));
  steps.go(0); syncUI(); typeset(L0.panel);
  return { destroy() { runner.destroy(); stage.destroy(); } };
}
