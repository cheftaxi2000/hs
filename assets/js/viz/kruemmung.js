// Krümmung, Krümmungskreis, Evolute (Analysis 1, Kap. 2.5)
import {
  C, TAU, clamp, Stage, Runner, View, line, path, circle, dot, ring, arrow, mlabel, text, fmt,
  el, seg, chip, readout, transport, layout, stepper, typeset, alpha,
} from '../core.js';

export const meta = {
  id: 'kruemmung',
  group: 'Analysis 1',
  short: 'Krümmung',
  tag: 'Analysis 1 · Kapitel 2.5',
  title: 'Welcher Kreis passt sich einer Kurve am besten an?',
  card: 'Der Krümmungskreis gleitet die Kurve entlang. Sein Mittelpunkt zeichnet die Evolute, und an Wendepunkten springt er durchs Unendliche auf die andere Seite.',
};

/* clothoid table: r(s) = ∫ (cos θ, sin θ) ds, θ = s²/(2A²) */
const CA = 1.15, CS = 3.05, CN = 6000;
const clo = (() => {
  const xs = new Float64Array(CN + 1), ys = new Float64Array(CN + 1), h = (2 * CS) / CN;
  // integrate from s = 0 outward (Simpson per step)
  const mid = CN / 2;
  const fx = (s) => Math.cos((s * s) / (2 * CA * CA)), fy = (s) => Math.sin((s * s) / (2 * CA * CA));
  xs[mid] = 0; ys[mid] = 0;
  for (let i = mid; i < CN; i++) { const s = -CS + i * h; xs[i + 1] = xs[i] + (h / 6) * (fx(s) + 4 * fx(s + h / 2) + fx(s + h)); ys[i + 1] = ys[i] + (h / 6) * (fy(s) + 4 * fy(s + h / 2) + fy(s + h)); }
  for (let i = mid; i > 0; i--) { const s = -CS + i * h; xs[i - 1] = xs[i] - (h / 6) * (fx(s) + 4 * fx(s - h / 2) + fx(s - h)); ys[i - 1] = ys[i] - (h / 6) * (fy(s) + 4 * fy(s - h / 2) + fy(s - h)); }
  return { xs, ys, h };
})();
function cloPos(s) {
  const u = clamp((s + CS) / clo.h, 0, CN - 1e-9), i = Math.floor(u), f = u - i;
  // cubic Hermite with exact tangents
  const s0 = -CS + i * clo.h, s1 = s0 + clo.h, h = clo.h;
  const d0 = [Math.cos(s0 * s0 / (2 * CA * CA)), Math.sin(s0 * s0 / (2 * CA * CA))], d1 = [Math.cos(s1 * s1 / (2 * CA * CA)), Math.sin(s1 * s1 / (2 * CA * CA))];
  const h00 = 2 * f ** 3 - 3 * f ** 2 + 1, h10 = f ** 3 - 2 * f ** 2 + f, h01 = -2 * f ** 3 + 3 * f ** 2, h11 = f ** 3 - f ** 2;
  return [h00 * clo.xs[i] + h10 * h * d0[0] + h01 * clo.xs[i + 1] + h11 * h * d1[0], h00 * clo.ys[i] + h10 * h * d0[1] + h01 * clo.ys[i + 1] + h11 * h * d1[1]];
}

const CURVES = {
  parabel: {
    label: 'Parabel', tex: 'y = x^2/2', t: [-2.5, 2.5], t0: 0.9, loop: false,
    r: (t) => [t, t * t / 2], d1: (t) => [1, t], d2: () => [0, 1], box: [-3.3, 3.3, -0.7, 3.9],
  },
  ellipse: {
    label: 'Ellipse', tex: '(2\\cos t,\\ \\sin t)', t: [0, TAU], t0: 0.5, loop: true,
    r: (t) => [2 * Math.cos(t), Math.sin(t)], d1: (t) => [-2 * Math.sin(t), Math.cos(t)], d2: (t) => [-2 * Math.cos(t), -Math.sin(t)], box: [-3.2, 3.2, -3.2, 3.2],
  },
  sinus: {
    label: 'Sinus', tex: 'y = \\sin x', t: [-1.5 * Math.PI, 1.5 * Math.PI], t0: -0.6, loop: false,
    r: (t) => [t, Math.sin(t)], d1: (t) => [1, Math.cos(t)], d2: (t) => [0, -Math.sin(t)], box: [-5.2, 5.2, -2.9, 2.9],
  },
  zykloide: {
    label: 'Zykloide', tex: '(t-\\sin t,\\ 1-\\cos t)', t: [0.02, 4 * Math.PI - 0.02], t0: 2.2, loop: false,
    r: (t) => [t - Math.sin(t), 1 - Math.cos(t)], d1: (t) => [1 - Math.cos(t), Math.sin(t)], d2: (t) => [Math.sin(t), Math.cos(t)], box: [-0.4, 13, -2.35, 2.35],
  },
  klothoide: {
    label: 'Klothoide', tex: 'k(s) = s/A^2,\\quad A = 1.15', t: [-CS, CS], t0: 0.8, loop: false,
    r: (s) => cloPos(s), d1: (s) => { const th = s * s / (2 * CA * CA); return [Math.cos(th), Math.sin(th)]; },
    d2: (s) => { const th = s * s / (2 * CA * CA), w = s / (CA * CA); return [-w * Math.sin(th), w * Math.cos(th)]; }, box: null,
  },
};

function frame(cv, t) {
  const r = cv.r(t), d = cv.d1(t), dd = cv.d2(t);
  const v = Math.hypot(d[0], d[1]);
  const k = (d[0] * dd[1] - dd[0] * d[1]) / v ** 3;
  const n = [-d[1] / v, d[0] / v], T = [d[0] / v, d[1] / v];
  const M = Math.abs(k) > 1e-9 ? [r[0] + n[0] / k, r[1] + n[1] / k] : null;
  return { r, T, n, k, v, M };
}
function samples(cv) {
  if (!cv.box) {   // fit the view to the curve itself
    let x0 = 1e9, x1 = -1e9, y0 = 1e9, y1 = -1e9;
    for (let i = 0; i <= 400; i++) { const p = cv.r(cv.t[0] + ((cv.t[1] - cv.t[0]) * i) / 400); x0 = Math.min(x0, p[0]); x1 = Math.max(x1, p[0]); y0 = Math.min(y0, p[1]); y1 = Math.max(y1, p[1]); }
    const mx = 0.18 * (x1 - x0), my = 0.12 * (y1 - y0);
    cv.box = [x0 - mx, x1 + mx, y0 - my, y1 + my];
  }
  const N = 1400, out = [];
  let s = 0, prev = null;
  for (let i = 0; i <= N; i++) {
    const t = cv.t[0] + ((cv.t[1] - cv.t[0]) * i) / N, f = frame(cv, t);
    if (prev) s += Math.hypot(f.r[0] - prev[0], f.r[1] - prev[1]);
    prev = f.r; out.push({ t, s, ...f });
  }
  return out;
}

/* ---------- drawing ---------- */
function geom(W, H, cv) {
  const kh = Math.max(86, Math.round(H * 0.19));
  const view = new View().fit(...cv.box, 0, 0, W, H - kh - 8, 22);
  return { view, kp: { x: 56, y: H - kh - 4, w: W - 56 - 22, h: kh - 8 } };
}

function draw(ctx, W, H, S, opt = {}) {
  const cv = CURVES[S.curve], G = geom(W, H, cv), { view } = G, X = (p) => view.P(p);
  const smp = S.smp, f = frame(cv, S.t), lay = S.layers;
  const s = view.s;
  // grid
  const g = (cv.box[1] - cv.box[0]) > 8 ? 1 : 0.5;
  ctx.save(); ctx.strokeStyle = C.grid; ctx.lineWidth = 1; ctx.beginPath();
  const [wx0, wy1] = view.inv(0, 0), [wx1, wy0] = view.inv(W, G.kp.y - 4);
  for (let x = Math.ceil(wx0 / g) * g; x <= wx1; x += g) { ctx.moveTo(view.X(x), 0); ctx.lineTo(view.X(x), G.kp.y - 4); }
  for (let y = Math.ceil(wy0 / g) * g; y <= wy1; y += g) { ctx.moveTo(0, view.Y(y)); ctx.lineTo(W, view.Y(y)); }
  ctx.stroke(); ctx.restore();
  ctx.save(); ctx.beginPath(); ctx.rect(0, 0, W, G.kp.y - 4); ctx.clip();
  line(ctx, 0, view.Y(0), W, view.Y(0), alpha(C.muted, 0.6), 1);
  line(ctx, view.X(0), 0, view.X(0), G.kp.y, alpha(C.muted, 0.6), 1);

  // family of osculating circles
  if (lay.schar) {
    const total = smp[smp.length - 1].s, n = 18;
    for (let i = 0; i < n; i++) {
      const target = ((i + 0.5) / n) * total; const p = smp.find((q) => q.s >= target) || smp[smp.length - 1];
      if (!p.M || Math.abs(1 / p.k) * s > 3 * W) continue;
      const c = X(p.M); circle(ctx, c[0], c[1], Math.abs(1 / p.k) * s, alpha(C.m, C.dark ? 0.22 : 0.16), 1);
    }
  }
  // curvature comb
  if (lay.kamm) {
    const total = smp[smp.length - 1].s, kmax = Math.max(...smp.map((p) => Math.abs(p.k))), sc = Math.min(1.2, 0.18 * (cv.box[1] - cv.box[0]) / kmax);
    const tips = [];
    const step = Math.max(1, Math.round(smp.length / 150));
    for (let i = 0; i < smp.length; i += step) {
      const p = smp[i], q = [p.r[0] - p.n[0] * p.k * sc, p.r[1] - p.n[1] * p.k * sc];
      const a = X(p.r), b = X(q); line(ctx, a[0], a[1], b[0], b[1], alpha(C.m, 0.35), 1); tips.push(b);
    }
    path(ctx, tips, alpha(C.m, 0.7), 1.2);
    void total;
  }
  // evolute
  if (lay.evolute) {
    const pts = smp.map((p) => (p.M && Math.abs(1 / p.k) < 40 ? X(p.M) : null));
    // break where the centre jumps (inflection points)
    for (let i = 1; i < pts.length; i++) if (pts[i] && pts[i - 1] && Math.hypot(pts[i][0] - pts[i - 1][0], pts[i][1] - pts[i - 1][1]) > W * 0.4) pts[i] = null;
    path(ctx, pts, alpha(C.f, 0.85), 1.6);
    // traced part up to now
    if (!opt.thumb) {
      const done = []; for (let i = 0; i < smp.length && smp[i].t <= S.t; i++) done.push(pts[i]);
      if (cv.loop || true) path(ctx, done, C.f, 2.4);
    }
  }
  // the curve
  path(ctx, smp.map((p) => X(p.r)), C.ink, opt.thumb ? 2 : 2.6);

  // osculating circle
  const P = X(f.r);
  const rho = Math.abs(1 / f.k);
  if (lay.kreis) {
    if (f.M && rho * s < 40 * Math.max(W, H)) {
      const c = X(f.M);
      ctx.save(); ctx.beginPath(); ctx.arc(c[0], c[1], rho * s, 0, TAU);
      ctx.fillStyle = alpha(C.m, C.dark ? 0.09 : 0.06); ctx.fill(); ctx.strokeStyle = C.m; ctx.lineWidth = 2; ctx.stroke(); ctx.restore();
      line(ctx, P[0], P[1], c[0], c[1], alpha(C.m, 0.9), 1.3, [5, 4]);
      dot(ctx, c[0], c[1], 3.6, C.m);
      if (!opt.thumb) {
        mlabel(ctx, 'M', c[0] + 9, c[1] - 11, C.m, { size: 15 });
        const mx = (P[0] + c[0]) / 2, my = (P[1] + c[1]) / 2;
        if (rho * s > 40) mlabel(ctx, 'ρ', mx + 7, my - 8, C.m, { size: 15 });
      }
    } else {
      const d = 4000; line(ctx, P[0] - f.T[0] * d, P[1] + f.T[1] * d, P[0] + f.T[0] * d, P[1] - f.T[1] * d, alpha(C.m, 0.8), 1.6);
      if (!opt.thumb) text(ctx, 'k = 0 : Krümmungskreis wird zur Geraden (ρ → ∞)', W / 2, 20, C.m, { size: 12.5, align: 'center', halo: true, weight: 500 });
    }
  }
  if (lay.tn) {
    const L = 0.16 * (cv.box[1] - cv.box[0]) * s / 2.2;
    const ls = Math.min(L, 80);
    arrow(ctx, P[0], P[1], P[0] + f.T[0] * ls, P[1] - f.T[1] * ls, C.v, 2.4, 11);
    arrow(ctx, P[0], P[1], P[0] + f.n[0] * ls * 0.75, P[1] - f.n[1] * ls * 0.75, C.muted, 1.8, 9);
    if (!opt.thumb) {
      mlabel(ctx, '**τ**', P[0] + f.T[0] * ls + 6, P[1] - f.T[1] * ls - 8, C.v, { size: 15 });
      mlabel(ctx, '**n**', P[0] + f.n[0] * ls * 0.75 + 6, P[1] - f.n[1] * ls * 0.75 - 8, C.muted, { size: 15 });
    }
  }
  ring(ctx, P[0], P[1], opt.thumb ? 3.5 : 6.5, C.ink, 2.2);
  ctx.restore();

  if (!opt.thumb) drawK(ctx, G.kp, S, smp, f);
}

function drawK(ctx, kp, S, smp, f) {
  const total = smp[smp.length - 1].s;
  let kmax = 0; for (const p of smp) kmax = Math.max(kmax, Math.abs(p.k));
  kmax = Math.min(kmax, 6) * 1.1;
  const X = (sv) => kp.x + (sv / total) * kp.w, Y = (k) => kp.y + kp.h / 2 - (clamp(k, -kmax, kmax) / kmax) * (kp.h / 2 - 4);
  ctx.save(); ctx.fillStyle = C.surface2; ctx.beginPath(); ctx.roundRect(kp.x - 6, kp.y - 2, kp.w + 12, kp.h + 4, 6); ctx.fill(); ctx.restore();
  line(ctx, kp.x, Y(0), kp.x + kp.w, Y(0), C.muted, 1);
  const pts = smp.map((p) => [X(p.s), Y(p.k)]);
  ctx.save(); ctx.beginPath(); ctx.moveTo(pts[0][0], Y(0)); pts.forEach((p) => ctx.lineTo(p[0], p[1])); ctx.lineTo(pts[pts.length - 1][0], Y(0)); ctx.closePath();
  ctx.fillStyle = alpha(C.m, C.dark ? 0.18 : 0.12); ctx.fill(); ctx.restore();
  path(ctx, pts, C.m, 1.8);
  // current
  const cur = smp.reduce((b, p) => (Math.abs(p.t - S.t) < Math.abs(b.t - S.t) ? p : b), smp[0]);
  const cx = X(cur.s);
  line(ctx, cx, kp.y, cx, kp.y + kp.h, alpha(C.ink, 0.35), 1);
  dot(ctx, cx, Y(f.k), 3.6, C.m);
  mlabel(ctx, 'k', 14, kp.y + 12, C.m, { size: 16 });
  text(ctx, '> 0 links', 14, kp.y + 30, C.muted, { size: 10, font: 'mono' });
  text(ctx, '< 0 rechts', 14, kp.y + 43, C.muted, { size: 10, font: 'mono' });
  text(ctx, 'Bogenlänge s →', kp.x + kp.w - 4, kp.y + kp.h - 8, C.muted, { size: 10.5, align: 'right', font: 'mono' });
}

/* ---------- thumbnail ---------- */
export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  const S = { curve: 'ellipse', t: 0.55, layers: { kreis: true, evolute: true, schar: true, kamm: false, tn: false } };
  S.smp = samples(CURVES.ellipse);
  const cv = CURVES.ellipse, view = new View().fit(...cv.box, 0, 0, W, H, 8);
  const X = (p) => view.P(p);
  const smp = S.smp, total = smp[smp.length - 1].s;
  for (let i = 0; i < 16; i++) { const p = smp.find((q) => q.s >= ((i + 0.5) / 16) * total); const c = X(p.M); circle(ctx, c[0], c[1], Math.abs(1 / p.k) * view.s, alpha(C.m, 0.18), 1); }
  path(ctx, smp.map((p) => X(p.M)), C.f, 1.6);
  path(ctx, smp.map((p) => X(p.r)), C.ink, 2.2);
  const f = frame(cv, S.t), c = X(f.M), P = X(f.r);
  circle(ctx, c[0], c[1], Math.abs(1 / f.k) * view.s, C.m, 1.8);
  line(ctx, P[0], P[1], c[0], c[1], C.m, 1, [4, 3]);
  ring(ctx, P[0], P[1], 3.5, C.ink, 2); dot(ctx, c[0], c[1], 2.8, C.m);
}

const STEPS = [
  { title: 'Krümmung heißt: Die Richtung dreht sich', set: { curve: 'parabel', t: -1.6, layers: { kreis: false, evolute: false, schar: false, kamm: true, tn: true }, play: true },
    html: '<p>Fahr die Parabel entlang und beobachte den Tangentenvektor $\\boldsymbol\\tau$. Wo er sich schnell dreht, ist die Kurve stark gekrümmt. Der grüne Kamm trägt die Krümmung als Länge senkrecht zur Kurve ab.</p>$$k = \\frac{\\dot x\\,\\ddot y - \\ddot x\\,\\dot y}{(\\dot x^2 + \\dot y^2)^{3/2}}$$<p>Am Scheitel ist $k$ am größten, weiter außen wird die Parabel flacher.</p>' },
  { title: 'Der Krümmungskreis', set: { curve: 'parabel', t: 0, layers: { kreis: true, evolute: false, schar: false, kamm: false, tn: true } },
    html: '<p>Der Kreis, der die Kurve im Punkt am besten annähert, hat denselben Punkt, dieselbe Tangente und dieselbe Krümmung:</p>$$\\rho = \\frac{1}{|k|},\\qquad \\boldsymbol M = \\boldsymbol r + \\frac{1}{k}\\,\\hat{\\boldsymbol n}.$$<p>Am Scheitel von $y = x^2/2$ ist $k = 1$, der Kreis hat Radius $1$. Ziehe den Punkt nach außen: Der Kreis wird schnell größer.</p>' },
  { title: 'Wendepunkte: der Kreis springt', set: { curve: 'sinus', t: -1.2, layers: { kreis: true, evolute: false, schar: false, kamm: true, tn: true }, play: true },
    html: '<p>Beim Sinus wechselt die Kurve zwischen Links- ($k > 0$) und Rechtskurve ($k < 0$). Vor dem Wendepunkt wächst der Kreis ins Unendliche, wird kurz zur Tangente und taucht auf der anderen Seite wieder auf.</p><p>Im Streifen unten sieht man den Vorzeichenwechsel von $k$ direkt.</p>' },
  { title: 'Die Evolute', set: { curve: 'ellipse', t: 0.2, layers: { kreis: true, evolute: true, schar: true, kamm: false, tn: false }, play: true },
    html: '<p>Der Mittelpunkt $\\boldsymbol M$ des Krümmungskreises beschreibt selbst eine Kurve, die <b>Evolute</b>. Bei der Ellipse ist es eine gestreckte Astroide.</p><p>Wo die Ellipse am stärksten gekrümmt ist (an den Enden der langen Achse), ist der Kreis am kleinsten, und die Evolute hat dort ihre Spitzen.</p>' },
  { title: 'Die Zykloide und ihre Evolute', set: { curve: 'zykloide', t: 1.2, layers: { kreis: true, evolute: true, schar: false, kamm: false, tn: false }, play: true },
    html: '<p>Die Bahn eines Radpunkts (siehe Mechanik, rollendes Rad) hat eine erstaunliche Evolute: wieder eine Zykloide, gleich groß, nur um $\\pi$ verschoben und nach unten geklappt.</p><p>In den Spitzen ist die Kurve unendlich stark gekrümmt ($\\rho \\to 0$), oben am flachsten mit $\\rho = 4$.</p>' },
  { title: 'Klothoide: Krümmung wächst gleichmäßig', set: { curve: 'klothoide', t: -2.6, layers: { kreis: true, evolute: false, schar: false, kamm: true, tn: true }, play: true },
    html: '<p>Straßen und Gleise gehen nie direkt von der Geraden ($k = 0$) in einen Kreis über. Dazwischen liegt eine Klothoide, deren Krümmung linear mit der Bogenlänge wächst:</p>$$k(s) = \\frac{s}{A^2}.$$<p>Im Streifen unten ist $k(s)$ eine Gerade. Am Steuer heißt das: Man dreht das Lenkrad gleichmäßig ein, und die Querbeschleunigung $v^2 k$ steigt ohne Ruck.</p>' },
];

export function mount(root) {
  const L0 = layout(root, meta);
  const S = { curve: 'parabel', t: 0, dir: 1, layers: { ...STEPS[0].set.layers }, smp: samples(CURVES.parabel) };
  const setCurve = (k) => { S.curve = k; S.smp = samples(CURVES[k]); S.t = CURVES[k].t0; S.dir = 1; curveSeg.set(k); updateReadout(); stage.invalidate(); };

  const stage = new Stage(L0.stage, {
    draw: (ctx, W, H) => draw(ctx, W, H, S),
    pointer: {
      down(x, y) {
        const cv = CURVES[S.curve], G = geom(stage.w, stage.h, cv);
        if (y > G.kp.y - 6) { scrubK(x, G); return { k: 'k' }; }
        let best = null, bd = 1e9;
        for (const p of S.smp) { const q = G.view.P(p.r), d = Math.hypot(q[0] - x, q[1] - y); if (d < bd) { bd = d; best = p; } }
        if (bd < 34) { runner.pause(); S.t = best.t; updateReadout(); return { k: 'pt' }; }
        return null;
      },
      drag(h, x, y) {
        const cv = CURVES[S.curve], G = geom(stage.w, stage.h, cv);
        if (h.k === 'k') { scrubK(x, G); return; }
        // follow the finger: search near the current parameter first (keeps continuity on self-overlapping curves)
        let best = null, bd = 1e9;
        for (const p of S.smp) { const q = G.view.P(p.r), d = Math.hypot(q[0] - x, q[1] - y) + Math.abs(p.t - S.t) * 2; if (d < bd) { bd = d; best = p; } }
        S.t = best.t; updateReadout();
      },
      hover(x, y) { const G = geom(stage.w, stage.h, CURVES[S.curve]); return y > G.kp.y - 6 ? 'ew-resize' : 'grab'; },
    },
  });
  function scrubK(x, G) {
    runner.pause();
    const total = S.smp[S.smp.length - 1].s, sv = clamp(((x - G.kp.x) / G.kp.w) * total, 0, total);
    const p = S.smp.find((q) => q.s >= sv) || S.smp[S.smp.length - 1]; S.t = p.t; updateReadout();
  }
  L0.stage.append(el('div', { class: 'hint', html: 'Punkt auf der Kurve ziehen · im <i>k</i>-Streifen scrubben' }));

  const runner = new Runner({
    stages: [stage],
    update(dt) {
      const cv = CURVES[S.curve], f = frame(cv, S.t);
      const span = cv.box[1] - cv.box[0];
      const speed = span * 0.075;                // Bogenlänge pro Sekunde
      const dtt = clamp((speed * dt) / Math.max(f.v, 0.05), 0, 0.06);
      S.t += S.dir * dtt;
      if (cv.loop) { if (S.t > cv.t[1]) S.t -= cv.t[1] - cv.t[0]; }
      else if (S.t > cv.t[1]) { S.t = cv.t[1]; S.dir = -1; } else if (S.t < cv.t[0]) { S.t = cv.t[0]; S.dir = 1; }
      updateReadout();
    },
  });
  L0.tslot.append(transport(runner, { onRestart: () => { S.t = CURVES[S.curve].t[0]; S.dir = 1; runner.play(); } }));

  const curveSeg = seg(Object.entries(CURVES).map(([k, v]) => [k, v.label]), S.curve, (k) => setCurve(k), 'scenes');
  L0.scenes.append(curveSeg);

  const q = el('p', { class: 'question', html: 'Eine Kurve biegt mal stärker, mal schwächer, mal nach links, mal nach rechts. <b>Wie misst man das mit einer Zahl, und welcher Kreis passt an jeder Stelle am besten?</b>' });
  const steps = stepper(STEPS, (st) => {
    const s = st.set; runner.pause();
    if (s.curve !== S.curve) setCurve(s.curve);
    S.t = s.t; S.dir = 1; Object.assign(S.layers, s.layers); syncChips(); updateReadout(); stage.invalidate();
    if (s.play) setTimeout(() => runner.play(), 300);
  });
  const chips = {
    kreis: chip('Krümmungskreis', true, C.m, (v) => { S.layers.kreis = v; stage.invalidate(); }),
    tn: chip('Tangente, Normale', true, C.v, (v) => { S.layers.tn = v; stage.invalidate(); }),
    evolute: chip('Evolute', false, C.f, (v) => { S.layers.evolute = v; stage.invalidate(); }),
    schar: chip('Kreisschar', false, C.m, (v) => { S.layers.schar = v; stage.invalidate(); }),
    kamm: chip('Krümmungskamm', false, C.m, (v) => { S.layers.kamm = v; stage.invalidate(); }),
  };
  const syncChips = () => { for (const [k, c] of Object.entries(chips)) c.set(!!S.layers[k]); };
  const ro = readout([['c', 'Kurve'], ['k', 'Krümmung <span class="var">k</span>'], ['rho', 'Radius <span class="var">ρ</span> = 1/|<span class="var">k</span>|'], ['dir', 'Richtung'], ['M', 'Mittelpunkt <span class="var">M</span>']]);
  const cTex = el('div', { class: 'formulas' });
  function updateReadout() {
    const cv = CURVES[S.curve], f = frame(cv, S.t);
    ro.set('c', cv.label);
    ro.set('k', fmt(f.k, 3)); ro.set('rho', Math.abs(f.k) < 1e-3 ? '∞' : fmt(1 / Math.abs(f.k), 3));
    ro.set('dir', Math.abs(f.k) < 2e-3 ? 'Wendepunkt' : f.k > 0 ? 'Linkskurve' : 'Rechtskurve');
    ro.set('M', f.M && Math.abs(1 / f.k) < 1e3 ? `(${fmt(f.M[0], 2)}, ${fmt(f.M[1], 2)})` : '—');
    if (cTex._c !== S.curve) { cTex._c = S.curve; cTex.innerHTML = `$$${S.curve === 'ellipse' || S.curve === 'zykloide' ? '\\boldsymbol r(t) = ' : ''}${cv.tex}$$`; typeset(cTex); }
  }
  const box = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Erkunden' }), el('div', { class: 'toggles' }, ...Object.values(chips)), cTex, ro);
  const formulas = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Formeln aus dem Skript' }), el('div', { class: 'formulas', html:
    '<p>Explizite Kurve $y = f(x)$</p>$$k(x) = \\frac{f\'\'(x)}{\\bigl(1 + f\'(x)^2\\bigr)^{3/2}}$$<p>Krümmungskreis und Evolute</p>$$\\rho = \\frac{1}{|k|},\\qquad \\boldsymbol E(t) = \\boldsymbol r(t) + \\frac{1}{k(t)}\\,\\hat{\\boldsymbol n}(t)$$' }));
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Die Krümmung ist ein Drehtempo: wie schnell sich die Tangente pro Bogenlänge dreht. Ihr Kehrwert ist der Radius des Kreises, der sich an dieser Stelle anschmiegt. Das Vorzeichen sagt, auf welcher Seite er liegt.' });
  L0.panel.append(q, steps, box, formulas, insight, el('p', { class: 'src', html: 'Skript Analysis 1, Abschnitt 2.5 (Wichtige Kurven; Tangente, Normale und Krümmung; Evolute).' }));
  S.smp = samples(CURVES[S.curve]);
  steps.go(0);
  syncChips(); updateReadout(); typeset(L0.panel);
  return { destroy() { runner.destroy(); stage.destroy(); } };
}
