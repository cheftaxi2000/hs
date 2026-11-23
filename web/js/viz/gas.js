// Kinetische Gastheorie: Stöße erzeugen die Maxwell-Boltzmann-Verteilung (Chemie, Kap. 2)
import { C, clamp, Stage, Runner, line, path, circle, dot, text, fmt, el, seg, chip, readout, transport, layout, stepper, typeset, alpha, slider, mlabel } from '../core.js';

export const meta = {
  id: 'gas',
  group: 'Chemie',
  short: 'Gas',
  tag: 'Chemie · Kapitel 2.6–2.7',
  title: 'Woher kommt die Geschwindigkeitsverteilung eines Gases?',
  card: 'Alle Teilchen starten gleich schnell. Nach wenigen Stößen stellt sich die Maxwell-Boltzmann-Verteilung ein. Druck entsteht aus Wandstößen, Temperatur ist mittlere kinetische Energie.',
};

/* model units: k_B = 1, T = 300 K ↔ kT = 1, light mass m = 1 */
const R = 0.0085;            // particle radius (box height = 1)
const KT = (T) => T / 300;

class Gas {
  constructor() { this.p = []; this.w = 1.4; this.h = 1; this.imp = 0; this.tAcc = 0; this.hist = { a: new Float64Array(48), b: new Float64Array(48) }; this.trail = []; }
  init(N, T, mix, equal) {
    this.p = [];
    const kt = KT(T);
    for (let i = 0; i < N; i++) {
      const heavy = mix && i % 2 === 1, m = heavy ? 4 : 1;
      // speed: either all equal (to the rms value of the species) or Maxwell–Boltzmann in 2D (Rayleigh)
      const s = equal ? Math.sqrt(2 * kt / m) : Math.sqrt(-2 * kt / m * Math.log(1 - Math.random()));
      const a = Math.random() * Math.PI * 2;
      let x, y, ok, g = 0;
      do { x = R + Math.random() * (this.w - 2 * R); y = R + Math.random() * (this.h - 2 * R); ok = this.p.every((q) => (q.x - x) ** 2 + (q.y - y) ** 2 > 4.4 * R * R); } while (!ok && g++ < 50);
      this.p.push({ x, y, vx: s * Math.cos(a), vy: s * Math.sin(a), m, heavy });
    }
    this.hist.a.fill(0); this.hist.b.fill(0); this.imp = 0; this.tAcc = 0; this.P = 0; this.trail = [];
  }
  kT() { let e = 0; for (const q of this.p) e += 0.5 * q.m * (q.vx * q.vx + q.vy * q.vy); return e / this.p.length; } // 2D: <½mv²> = kT
  step(dt, Ttarget, thermo) {
    const sub = Math.max(1, Math.ceil(dt / 0.004));
    const h = dt / sub;
    for (let s = 0; s < sub; s++) this.sub(h);
    // gentle thermostat: uniform rescaling keeps the shape of the distribution
    if (thermo) { const cur = this.kT(), f = Math.sqrt(1 + 0.04 * (KT(Ttarget) / Math.max(cur, 1e-6) - 1)); for (const q of this.p) { q.vx *= f; q.vy *= f; } }
    this.tAcc += dt;
    if (this.tAcc > 0.6) { this.P = this.imp / (this.tAcc * 2 * (this.w + this.h)); this.imp = 0; this.tAcc = 0; }
    // histogram (exponential moving average)
    const vmax = this.vmax;
    for (const k of ['a', 'b']) for (let i = 0; i < 48; i++) this.hist[k][i] *= 0.97;
    for (const q of this.p) { const v = Math.hypot(q.vx, q.vy), i = Math.floor((v / vmax) * 48); if (i < 48) this.hist[q.heavy ? 'b' : 'a'][i] += 1; }
    const t = this.p[0]; this.trail.push([t.x, t.y]); if (this.trail.length > 900) this.trail.shift();
  }
  sub(h) {
    const P = this.p, W = this.w, H = this.h;
    for (const q of P) {
      q.x += q.vx * h; q.y += q.vy * h;
      if (q.x < R) { q.x = 2 * R - q.x; q.vx = -q.vx; this.imp += 2 * q.m * Math.abs(q.vx); }
      if (q.x > W - R) { q.x = 2 * (W - R) - q.x; q.vx = -q.vx; this.imp += 2 * q.m * Math.abs(q.vx); }
      if (q.y < R) { q.y = 2 * R - q.y; q.vy = -q.vy; this.imp += 2 * q.m * Math.abs(q.vy); }
      if (q.y > H - R) { q.y = 2 * (H - R) - q.y; q.vy = -q.vy; this.imp += 2 * q.m * Math.abs(q.vy); }
    }
    // collisions via a uniform grid
    const cs = 2 * R, nx = Math.ceil(W / cs), ny = Math.ceil(H / cs), grid = new Map();
    P.forEach((q, i) => { const k = Math.floor(q.x / cs) + nx * Math.floor(q.y / cs); const a = grid.get(k); if (a) a.push(i); else grid.set(k, [i]); });
    for (let i = 0; i < P.length; i++) {
      const q = P[i], gx = Math.floor(q.x / cs), gy = Math.floor(q.y / cs);
      for (let dx = -1; dx <= 1; dx++) for (let dy = -1; dy <= 1; dy++) {
        const a = grid.get(gx + dx + nx * (gy + dy)); if (!a) continue;
        for (const j of a) {
          if (j <= i) continue;
          const o = P[j], rx = o.x - q.x, ry = o.y - q.y, d2 = rx * rx + ry * ry;
          if (d2 >= 4 * R * R || d2 === 0) continue;
          const d = Math.sqrt(d2), nxn = rx / d, nyn = ry / d;
          const rel = (o.vx - q.vx) * nxn + (o.vy - q.vy) * nyn;
          if (rel >= 0) continue;                           // already separating
          const J = (2 * rel) / (1 / q.m + 1 / o.m);          // elastic impulse along the normal
          q.vx += (J / q.m) * nxn; q.vy += (J / q.m) * nyn; o.vx -= (J / o.m) * nxn; o.vy -= (J / o.m) * nyn;
          const push = (2 * R - d) / 2; q.x -= nxn * push; q.y -= nyn * push; o.x += nxn * push; o.y += nyn * push;
        }
      }
    }
  }
}

function geom(W, H) {
  const wide = W >= 760;
  if (wide) { const bw = W * 0.58; return { wide, box: { x: 18, y: 18, w: bw - 30, h: H - 36 }, hist: { x: bw + 10, y: 30, w: W - bw - 30, h: H * 0.62 - 30 }, gauge: { x: bw + 10, y: H * 0.62 + 24, w: W - bw - 30, h: H * 0.38 - 42 } }; }
  return { wide, box: { x: 10, y: 10, w: W - 20, h: H * 0.5 }, hist: { x: 14, y: H * 0.5 + 34, w: W - 28, h: H * 0.32 }, gauge: { x: 14, y: H * 0.84 + 16, w: W - 28, h: H * 0.16 - 26 } };
}

function draw(ctx, W, H, S) {
  const g = S.gas, G = geom(W, H);
  // box keeps the model aspect (w : h)
  const sc = Math.min(G.box.w / g.wMax, G.box.h / g.h);
  const ox = G.box.x + (G.box.w - g.wMax * sc) / 2, oy = G.box.y + (G.box.h - g.h * sc) / 2;
  const X = (x) => ox + x * sc, Y = (y) => oy + y * sc;
  ctx.save(); ctx.fillStyle = C.surface2; ctx.fillRect(X(0), Y(0), g.w * sc, g.h * sc); ctx.restore();
  ctx.save(); ctx.strokeStyle = C.ink; ctx.lineWidth = 2; ctx.strokeRect(X(0), Y(0), g.w * sc, g.h * sc); ctx.restore();
  // piston on the right
  if (g.w < g.wMax - 1e-3) { ctx.save(); ctx.fillStyle = alpha(C.ink, 0.12); ctx.fillRect(X(g.w), Y(0), (g.wMax - g.w) * sc, g.h * sc); ctx.restore(); line(ctx, X(g.w), Y(0), X(g.w), Y(g.h), C.ink, 4); }
  if (S.layers.trail && g.trail.length > 1) path(ctx, g.trail.map((p) => [X(p[0]), Y(p[1])]), alpha(C.k, 0.85), 1.3);
  const rpx = Math.max(1.6, R * sc);
  for (let i = 0; i < g.p.length; i++) {
    const q = g.p[i];
    ctx.beginPath(); ctx.arc(X(q.x), Y(q.y), i === 0 && S.layers.trail ? rpx + 2 : rpx, 0, 7);
    ctx.fillStyle = i === 0 && S.layers.trail ? C.k : q.heavy ? C.f : C.v; ctx.fill();
  }
  if (S.layers.vec) for (const q of g.p) line(ctx, X(q.x), Y(q.y), X(q.x + q.vx * 0.05), Y(q.y + q.vy * 0.05), alpha(C.ink, 0.5), 1);
  // ---- histogram ----
  const hb = G.hist, vmax = g.vmax, kt = KT(S.T);
  text(ctx, 'GESCHWINDIGKEITSVERTEILUNG', hb.x, hb.y - 12, C.muted, { size: 11, weight: 600 });
  const sumA = g.hist.a.reduce((s, v) => s + v, 0), sumB = g.hist.b.reduce((s, v) => s + v, 0), bw = vmax / 48;
  const fA = (v) => (v / kt) * Math.exp(-(v * v) / (2 * kt)), fB = (v) => ((4 * v) / kt) * Math.exp(-(4 * v * v) / (2 * kt));
  let ymax = 0; for (let i = 0; i < 200; i++) { const v = (vmax * i) / 200; ymax = Math.max(ymax, S.mix ? Math.max(fA(v), fB(v)) : fA(v)); }
  ymax *= 1.15;
  const HX = (v) => hb.x + (v / vmax) * hb.w, HY = (y) => hb.y + hb.h - (y / ymax) * hb.h;
  line(ctx, hb.x, hb.y + hb.h, hb.x + hb.w, hb.y + hb.h, C.muted, 1);
  const bars = (arr, sum, col) => { if (sum <= 0) return; for (let i = 0; i < 48; i++) { const y = Math.min(arr[i] / (sum * bw), ymax * 1.02); ctx.fillStyle = alpha(col, C.dark ? 0.45 : 0.32); ctx.fillRect(HX(i * bw) + 0.5, HY(y), hb.w / 48 - 1, hb.y + hb.h - HY(y)); } };
  bars(g.hist.a, sumA, C.v); if (S.mix) bars(g.hist.b, sumB, C.f);
  if (S.layers.theory) {
    const curve = (f, col) => { const pts = []; for (let i = 0; i <= 200; i++) { const v = (vmax * i) / 200; pts.push([HX(v), HY(f(v))]); } path(ctx, pts, col, 2); };
    curve(fA, C.v); if (S.mix) curve(fB, C.f);
    // characteristic speeds (2D) for the light gas
    const ump = Math.sqrt(kt), uav = Math.sqrt((Math.PI * kt) / 2), urms = Math.sqrt(2 * kt);
    [[ump, 'u_mp'], [uav, 'u_av'], [urms, 'u_rms']].forEach(([u, l], i) => { line(ctx, HX(u), hb.y + 8 + i * 15, HX(u), hb.y + hb.h, alpha(C.ink, 0.35), 1, [3, 3]); mlabel(ctx, l, HX(u) + 4, hb.y + 10 + i * 15, C.ink2, { size: 12 }); });
  }
  text(ctx, 'Geschwindigkeit →', hb.x + hb.w, hb.y + hb.h + 14, C.muted, { size: 10.5, align: 'right', font: 'mono' });
  // ---- pressure gauge ----
  const gb = G.gauge;
  if (gb.h > 30) {
    const A = g.w * g.h, Pid = (g.p.length * g.kT()) / A;
    text(ctx, 'DRUCK AUS WANDSTÖSSEN', gb.x, gb.y, C.muted, { size: 11, weight: 600 });
    const pm = Math.max(Pid, g.P) * 1.4 || 1, bx = gb.x, by = gb.y + 18, bwid = gb.w, bh = 14;
    const bar = (v, y, col, lab) => { ctx.fillStyle = C.surface2; ctx.fillRect(bx, y, bwid, bh); ctx.fillStyle = col; ctx.fillRect(bx, y, (v / pm) * bwid, bh); text(ctx, lab, bx, y + bh + 11, C.ink2, { size: 11.5 }); text(ctx, fmt(v, 0), bx + bwid, y + bh + 11, C.ink, { size: 11.5, font: 'mono', align: 'right' }); };
    bar(g.P, by, C.k, 'gemessen: Impuls an die Wände pro Zeit und Wandlänge');
    if (gb.h > 70) bar(Pid, by + 42, alpha(C.ink, 0.5), 'Modell: P = N k T / A (2D)');
  }
}

export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  // histogram with the 2D Maxwell–Boltzmann curve, and a few particles
  const hx = W * 0.5, hy = 20, hw = W * 0.45, hh = H - 40;
  const f = (v) => v * Math.exp(-v * v / 2), F = (v) => 2 * v * Math.exp(-v * v);
  for (let i = 0; i < 24; i++) { const v = (i + 0.5) / 24 * 4, y = f(v) * (0.9 + 0.2 * Math.sin(i * 7.3)); ctx.fillStyle = alpha(C.v, 0.3); ctx.fillRect(hx + i * hw / 24, hy + hh - y / 0.7 * hh, hw / 24 - 1, y / 0.7 * hh); }
  const pts = []; for (let i = 0; i <= 80; i++) { const v = i / 80 * 4; pts.push([hx + v / 4 * hw, hy + hh - f(v) / 0.7 * hh]); } path(ctx, pts, C.v, 2);
  void F;
  ctx.strokeStyle = C.ink; ctx.lineWidth = 1.5; ctx.strokeRect(10, 14, W * 0.42, H - 28);
  let s = 7; const rnd = () => ((s = (s * 9301 + 49297) % 233280) / 233280);
  for (let i = 0; i < 70; i++) { ctx.beginPath(); ctx.arc(14 + rnd() * (W * 0.42 - 8), 18 + rnd() * (H - 36), 2.2, 0, 7); ctx.fillStyle = i % 3 ? C.v : C.f; ctx.fill(); }
}

const STEPS = [
  { title: 'Alle starten gleich schnell', set: { equal: true, mix: false, T: 300, N: 260, layers: { theory: false, trail: false, vec: false } },
    html: '<p>Jedes Teilchen hat am Anfang denselben Betrag der Geschwindigkeit, nur die Richtungen sind zufällig. Das Histogramm ist eine einzige Spitze.</p><p>Die Teilchen stoßen elastisch: Energie und Impuls bleiben bei jedem Stoß erhalten, werden aber neu verteilt.</p>' },
  { title: 'Stöße erzeugen die Verteilung', set: { layers: { theory: true } },
    html: '<p>Nach wenigen Stößen pro Teilchen sieht das Histogramm immer gleich aus: die <b>Maxwell-Boltzmann-Verteilung</b>. Sie hat eine Spitze ($u_\\text{mp}$) und einen langen Schwanz zu hohen Geschwindigkeiten, deshalb liegen $u_\\text{av}$ und $u_\\text{rms}$ rechts davon.</p><p>Die Simulation ist zweidimensional. Dort gilt $f(u) \\propto u\\,e^{-mu^2/2k_BT}$; im Raum steht $u^2$ statt $u$, und $u_\\text{rms} = \\sqrt{3RT/M}$.</p>' },
  { title: 'Temperatur ist mittlere kinetische Energie', set: { equal: false, mix: false, T: 900, layers: { theory: true } },
    html: '<p>Erhöhe die Temperatur: Die Teilchen werden schneller, die Verteilung wird breiter und flacher. Der Druck steigt im gleichen Verhältnis wie $T$:</p>$$\\overline{E}_k \\propto T,\\qquad P \\propto \\frac{N k_B T}{V}.$$' },
  { title: 'Leicht ist schnell', set: { equal: false, mix: true, T: 300, layers: { theory: true } },
    html: '<p>Zwei Gase bei derselben Temperatur, die roten Teilchen viermal so schwer. Beide haben dieselbe mittlere kinetische Energie, also sind die leichten im Mittel $\\sqrt{4} = 2$ mal so schnell. Daher das Gesetz von Graham:</p>$$\\frac{r_1}{r_2} = \\sqrt{\\frac{M_2}{M_1}}.$$' },
  { title: 'Druck kommt von Wandstößen', set: { equal: false, mix: false, T: 300, layers: { theory: true, vec: true } },
    html: '<p>Jeder Stoß an die Wand überträgt den Impuls $2mu_\\perp$. Die Summe pro Zeit und Wandlänge ist der Druck. Schiebe den Kolben hinein: Bei kleinerem Volumen treffen die Teilchen öfter auf, der gemessene Druck steigt wie $1/V$ (Boyle).</p>' },
  { title: 'Schnell, aber kaum vom Fleck', set: { equal: false, mix: false, T: 300, N: 420, layers: { theory: true, trail: true, vec: false } },
    html: '<p>Ein Teilchen ist markiert. Zwischen zwei Stößen fliegt es gerade, nach jedem Stoß in eine neue Richtung: ein <b>Random Walk</b>. Nach $N$ Schritten der Länge $\\lambda$ ist der zurückgelegte Weg $N\\lambda$, der Abstand vom Start aber nur etwa $\\sqrt N\\,\\lambda$.</p><p>Deshalb dauert es, bis man ein Parfum am anderen Ende des Raums riecht.</p>' },
];

export function mount(root) {
  const L0 = layout(root, meta);
  const S = { T: 300, N: 260, mix: false, equal: true, layers: { theory: false, trail: false, vec: false }, gas: new Gas() };
  S.gas.wMax = 1.4; S.gas.w = 1.4; S.gas.vmax = 3.2;
  S.gas.init(S.N, S.T, S.mix, S.equal);
  const stage = new Stage(L0.stage, { draw: (ctx, W, H) => draw(ctx, W, H, S) });
  const runner = new Runner({ stages: [stage], update(dt) { S.gas.step(Math.min(dt, 0.033) * 0.55, S.T, true); upd(); } });
  L0.tslot.append(transport(runner, { onRestart: () => { S.gas.init(S.N, S.T, S.mix, S.equal); runner.play(); } }));
  const q = el('p', { class: 'question', html: 'Ein Gas besteht aus Teilchen, die herumfliegen und zusammenstoßen. <b>Wie entstehen daraus Temperatur, Druck und die typische Verteilung der Geschwindigkeiten?</b>' });
  const tSl = slider({ id: 'gs-T', label: 'Temperatur <span class="var">T</span>', min: 100, max: 1000, step: 10, value: S.T, format: (v) => `${v} K`, onInput: (v) => { S.T = v; S.gas.vmax = 3.2 * Math.sqrt(Math.max(1, v / 300) * (v > 300 ? 1 : 1)); } });
  const vSl = slider({ id: 'gs-V', label: 'Volumen (Kolben)', min: 0.5, max: 1, step: 0.01, value: 1, format: (v) => `${Math.round(v * 100)} %`, onInput: (v) => { const nw = S.gas.wMax * v; for (const p of S.gas.p) if (p.x > nw - R) { p.x = nw - R - Math.random() * 0.02; p.vx = -Math.abs(p.vx); } S.gas.w = nw; } });
  const nSeg = seg([[120, '120'], [260, '260'], [420, '420']], S.N, (n) => { S.N = n; S.gas.init(n, S.T, S.mix, false); });
  const chips = {
    theory: chip('Theoriekurve', false, C.v, (v) => { S.layers.theory = v; stage.invalidate(); }),
    trail: chip('Ein Teilchen verfolgen', false, C.k, (v) => { S.layers.trail = v; S.gas.trail = []; }),
    vec: chip('Geschwindigkeiten', false, C.ink, (v) => { S.layers.vec = v; }),
    mix: chip('Zwei Gase (1 : 4)', false, C.f, (v) => { S.mix = v; S.gas.init(S.N, S.T, v, false); }),
  };
  const bEq = el('button', { type: 'button', class: 'btn', html: 'Alle gleich schnell starten' });
  bEq.addEventListener('click', () => { S.gas.init(S.N, S.T, S.mix, true); runner.play(); });
  const ro = readout([['T', 'kinetische Temperatur'], ['u', '<span class="var">u</span><sub>rms</sub> leicht (2D)'], ['P', 'Druck gemessen / Modell']]);
  let last = 0;
  function upd() {
    const now = performance.now(); if (now - last < 200) return; last = now;
    const g = S.gas, kt = g.kT();
    ro.set('T', `${Math.round(kt * 300)} K`);
    let s = 0, n = 0; for (const p of g.p) if (!p.heavy) { s += p.vx * p.vx + p.vy * p.vy; n++; }
    ro.set('u', `${fmt(Math.sqrt(s / n), 3)} (Theorie ${fmt(Math.sqrt(2 * KT(S.T)), 3)})`);
    const Pid = (g.p.length * kt) / (g.w * g.h);
    ro.set('P', `${fmt(g.P, 0)} / ${fmt(Pid, 0)}`);
  }
  const steps = stepper(STEPS, (st) => {
    const s = st.set;
    if (s.T) { S.T = s.T; tSl.set(s.T); S.gas.vmax = 3.2 * Math.sqrt(Math.max(1, s.T / 300)); }
    if (s.N) { S.N = s.N; nSeg.set(s.N); }
    if (s.mix !== undefined) { S.mix = s.mix; chips.mix.set(s.mix); }
    Object.assign(S.layers, s.layers); for (const k of ['theory', 'trail', 'vec']) chips[k].set(!!S.layers[k]);
    if (s.equal !== undefined || s.N || s.mix !== undefined) { S.gas.w = S.gas.wMax; vSl.set(1); S.gas.init(S.N, S.T, S.mix, !!s.equal); }
    S.gas.trail = [];
    runner.play();
  });
  const box = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Erkunden' }), tSl, vSl, el('div', { class: 'ctrl' }, el('div', { class: 'ctrl-top', html: 'Anzahl Teilchen' }), nSeg), el('div', { class: 'toggles' }, ...Object.values(chips)), bEq, ro);
  const formulas = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Formeln aus dem Skript (3D)' }), el('div', { class: 'formulas', html:
    '$$\\overline{E}_k = \\tfrac32 k_B T,\\qquad u_\\text{rms} = \\sqrt{\\frac{3RT}{M}}$$<p>Graham</p>$$\\frac{r_1}{r_2} = \\sqrt{\\frac{M_2}{M_1}}$$<p>Im zweidimensionalen Modell: $\\overline{E}_k = k_BT$, $u_\\text{rms} = \\sqrt{2k_BT/m}$.</p>' }));
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Niemand gibt die Maxwell-Boltzmann-Verteilung vor: Sie stellt sich durch Stöße von selbst ein. Temperatur ist ein Maß für die mittlere kinetische Energie, Druck die Summe der Wandstöße.' });
  L0.panel.append(q, steps, box, formulas, insight, el('p', { class: 'src', html: 'Skript Chemie, Abschnitte 2.6 (kinetische Gastheorie, Geschwindigkeitsverteilungen) und 2.7 (Effusion, Diffusion, mittlere freie Weglänge). Simulation: elastische harte Scheiben in 2D, Modelleinheiten.' }));
  steps.go(0); typeset(L0.panel);
  runner.play();
  return { destroy() { runner.destroy(); stage.destroy(); } };
}
