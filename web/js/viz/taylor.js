// Taylorpolynome und Konvergenzradius (Analysis 1, Kap. 5)
import {
  C, TAU, clamp, Stage, Runner, line, path, circle, dot, ring, arrow, mlabel, text, fmt,
  el, slider, seg, chip, readout, transport, layout, stepper, typeset, alpha, smooth,
} from '../core.js';

export const meta = {
  id: 'taylor',
  group: 'Analysis 1',
  short: 'Taylor',
  tag: 'Analysis 1 · Kapitel 5.2–5.3',
  title: 'Wie weit trägt ein Taylorpolynom?',
  card: 'Mehr Glieder, bessere Näherung, aber nur bis zum Konvergenzradius. Die Grenze setzt die nächste Singularität, auch wenn sie komplex ist.',
};

const NMAX = 40;
const fact = [1]; for (let k = 1; k <= NMAX + 2; k++) fact[k] = fact[k - 1] * k;

const FN = {
  exp: {
    label: '<i>e<sup>x</sup></i>', tex: 'e^x', f: Math.exp, x: [-5.6, 5.6], y: [-2.5, 9.5], x0: 0, x0r: [-3.5, 3.5],
    coef: (x0, k) => Math.exp(x0) / fact[k], rho: () => Infinity, sing: [], nearest: () => null,
  },
  cos: {
    label: 'cos <i>x</i>', tex: '\\cos x', f: Math.cos, x: [-11, 11], y: [-2.6, 2.6], x0: 0, x0r: [-6, 6],
    coef: (x0, k) => Math.cos(x0 + (k * Math.PI) / 2) / fact[k], rho: () => Infinity, sing: [], nearest: () => null,
  },
  ln: {
    label: 'ln <i>x</i>', tex: '\\ln x', f: (x) => (x > 0 ? Math.log(x) : NaN), x: [-1.6, 9.2], y: [-3.4, 3.4], x0: 3, x0r: [0.35, 8.2],
    coef: (x0, k) => (k === 0 ? Math.log(x0) : ((k % 2 ? 1 : -1) / k) / x0 ** k), rho: (x0) => x0,
    sing: [{ re: 0, im: 0, lab: '0', cut: true }], nearest: () => [0, 0], singTex: 'z = 0',
  },
  rat: {
    label: '1/(1+<i>x</i><sup>2</sup>)', tex: '\\dfrac{1}{1+x^2}', f: (x) => 1 / (1 + x * x), x: [-4.2, 4.2], y: [-1.1, 2.0], x0: 0, x0r: [-3.2, 3.2],
    coef: (x0, k) => { const r = Math.hypot(x0, 1), ph = Math.atan2(-1, x0); return (k % 2 ? -1 : 1) * -(r ** -(k + 1)) * Math.sin((k + 1) * ph); },
    rho: (x0) => Math.hypot(x0, 1), sing: [{ re: 0, im: 1, lab: 'i' }, { re: 0, im: -1, lab: '−i' }], nearest: () => [0, 1], singTex: 'z = \\pm i',
  },
  lin: {
    label: '1/(2<i>x</i>+5)', tex: '\\dfrac{1}{2x+5}', f: (x) => 1 / (2 * x + 5), x: [-6.2, 3.2], y: [-3, 3], x0: -1, x0r: [-5.8, 2.8],
    coef: (x0, k) => (-2) ** k / (2 * x0 + 5) ** (k + 1), rho: (x0) => Math.abs(x0 + 2.5), sing: [{ re: -2.5, im: 0, lab: '−5/2' }], nearest: () => [-2.5, 0], singTex: 'z = -\\tfrac52',
  },
};

/* ---------- state helpers ---------- */
function coefs(fn, x0) { const a = []; for (let k = 0; k <= NMAX + 1; k++) a.push(fn.coef(x0, k)); return a; }
function evalP(a, n, x0, x, s = 0) {
  const h = x - x0; let p = 0;
  for (let k = n; k >= 0; k--) p = p * h + a[k];
  if (s > 0 && n + 1 <= NMAX + 1) p += s * a[n + 1] * h ** (n + 1);
  return p;
}

function geom(W, H, fn) {
  const l = 56, r = 22;
  const top = 12, g = 10, avail = H - top - 2 * g - 10;
  const [xa, xb] = fn.x, sx = (W - l - r) / (xb - xa);
  // the complex panel uses the same scale as the real axis (circles stay circles) and must show every singularity
  const imax = Math.max(0, ...fn.sing.map((s) => Math.abs(s.im)));
  const hc = Math.round(clamp(Math.max(avail * 0.3, 2 * (imax + 0.38) * sx), avail * 0.26, avail * 0.46));
  const rest = avail - hc, hg = Math.round(rest * 0.78), he = rest - hg;
  const X = (x) => l + (x - xa) * sx, inv = (px) => xa + (px - l) / sx;
  return { l, r, W, H, X, inv, sx, gp: { y: top, h: hg }, ep: { y: top + hg + g, h: he }, cp: { y: top + hg + 2 * g + he, h: hc } };
}

function draw(ctx, W, H, S, opt = {}) {
  const fn = FN[S.fn], G = geom(W, H, fn), { X } = G;
  const rho = fn.rho(S.x0), a = S.a;
  const [ya, yb] = fn.y, gp = G.gp;
  const Y = (y) => gp.y + gp.h - ((y - ya) / (yb - ya)) * gp.h;
  const lo = S.x0 - rho, hi = S.x0 + rho;
  const clipRect = (P, f) => { ctx.save(); ctx.beginPath(); ctx.rect(G.l, P.y, W - G.l - G.r, P.h); ctx.clip(); f(); ctx.restore(); };

  /* --- graph panel --- */
  clipRect(gp, () => {
    // band of convergence
    if (isFinite(rho)) {
      ctx.fillStyle = alpha(C.m, C.dark ? 0.1 : 0.065); ctx.fillRect(X(lo), gp.y, X(hi) - X(lo), gp.h);
    } else { ctx.fillStyle = alpha(C.m, C.dark ? 0.06 : 0.04); ctx.fillRect(G.l, gp.y, W, gp.h); }
    // grid
    const stp = (fn.x[1] - fn.x[0]) > 14 ? 2 : 1;
    for (let x = Math.ceil(fn.x[0] / stp) * stp; x <= fn.x[1]; x += stp) line(ctx, X(x), gp.y, X(x), gp.y + gp.h, C.grid, 1);
    const ys = (yb - ya) > 8 ? 2 : (yb - ya) > 4 ? 1 : 0.5;
    for (let y = Math.ceil(ya / ys) * ys; y <= yb; y += ys) line(ctx, G.l, Y(y), W - G.r, Y(y), C.grid, 1);
    line(ctx, G.l, Y(0), W - G.r, Y(0), C.muted, 1);
    if (fn.x[0] < 0 && fn.x[1] > 0) line(ctx, X(0), gp.y, X(0), gp.y + gp.h, C.muted, 1);
    // function
    const N = Math.round(W - G.l - G.r);
    const fpts = [];
    for (let i = 0; i <= N; i++) { const x = G.inv(G.l + i), y = fn.f(x); fpts.push(isFinite(y) && Math.abs(y) < 1e3 ? [X(x), Y(y)] : null); }
    if (S.fn === 'lin') { const px = X(-2.5); line(ctx, px, gp.y, px, gp.y + gp.h, alpha(C.f, 0.5), 1, [3, 4]); }
    path(ctx, fpts, C.ink, opt.thumb ? 2 : 2.6);
    // ghosts of lower degrees
    if (!opt.thumb) for (let d = 3; d >= 1; d--) {
      const n = S.n - d; if (n < 0) continue;
      path(ctx, polyPts(G, Y, a, n, S.x0, 0, N), alpha(C.v, 0.1 + 0.07 * (3 - d)), 1.2);
    }
    path(ctx, polyPts(G, Y, a, S.n, S.x0, S.s, N), C.v, opt.thumb ? 2 : 2.4);
    // expansion point
    const fy = fn.f(S.x0);
    line(ctx, X(S.x0), gp.y, X(S.x0), gp.y + gp.h, alpha(C.ink, 0.35), 1, [2, 3]);
    if (isFinite(fy)) ring(ctx, X(S.x0), Y(fy), opt.thumb ? 3 : 5.5, C.ink, 2);
  });
  if (!opt.thumb) {
    // y ticks
    const ys = (yb - ya) > 8 ? 2 : (yb - ya) > 4 ? 1 : 0.5;
    for (let y = Math.ceil(ya / ys) * ys; y <= yb; y += ys) text(ctx, fmt(y, ys < 1 ? 1 : 0), G.l - 8, Y(y), C.muted, { size: 10.5, font: 'mono', align: 'right' });
    // legend
    const lx = G.l + 14, ly = gp.y + 16;
    line(ctx, lx, ly, lx + 22, ly, C.ink, 2.6); text(ctx, 'f(x)', lx + 30, ly, C.ink, { size: 12.5, font: 'serif', halo: true });
    line(ctx, lx + 84, ly, lx + 106, ly, C.v, 2.4); text(ctx, `P${sub(S.n)}(x)`, lx + 114, ly, C.v, { size: 12.5, font: 'serif', halo: true });
    if (isFinite(rho)) text(ctx, `|x − x₀| < ρ`, X(S.x0), gp.y + gp.h - 12, C.m, { size: 12, align: 'center', halo: true, weight: 500 });
  }

  /* --- error panel: log10 |f − P_n| --- */
  const ep = G.ep, e0 = -10, e1 = 2;
  const EY = (v) => ep.y + ep.h - ((clamp(v, e0, e1) - e0) / (e1 - e0)) * ep.h;
  if (!opt.thumb) {
    ctx.save(); ctx.fillStyle = C.surface2; ctx.fillRect(G.l, ep.y, W - G.l - G.r, ep.h); ctx.restore();
    if (isFinite(rho)) { ctx.fillStyle = alpha(C.m, C.dark ? 0.1 : 0.065); ctx.fillRect(Math.max(G.l, X(lo)), ep.y, Math.min(W - G.r, X(hi)) - Math.max(G.l, X(lo)), ep.h); }
    for (const v of [-9, -6, -3, 0]) { line(ctx, G.l, EY(v), W - G.r, EY(v), C.grid, 1); text(ctx, `10${sup(v)}`, G.l - 8, EY(v), C.muted, { size: 10, font: 'mono', align: 'right' }); }
    const N = Math.round((W - G.l - G.r) / 1.5), pts = [];
    for (let i = 0; i <= N; i++) {
      const x = G.inv(G.l + i * 1.5), fv = fn.f(x);
      if (!isFinite(fv) || Math.abs(fv) > 1e6) { pts.push(null); continue; }
      const e = Math.abs(fv - evalP(a, S.n, S.x0, x, S.s));
      pts.push([X(x), EY(Math.log10(Math.max(e, 1e-16)))]);
    }
    clipRect(ep, () => {
      ctx.save(); ctx.beginPath(); let pen = false;
      for (const p of pts) { if (!p) { pen = false; continue; } if (!pen) { ctx.moveTo(p[0], ep.y + ep.h); ctx.lineTo(p[0], p[1]); pen = true; } else ctx.lineTo(p[0], p[1]); }
      ctx.restore();
      path(ctx, pts, C.ink2, 1.4);
    });
    text(ctx, 'Fehler |f − Pₙ|, logarithmisch', W - G.r - 8, ep.y + ep.h - 10, C.ink2, { size: 11, halo: true, weight: 500, align: 'right' });
  }

  /* --- complex plane panel --- */
  const cp = G.cp, cy = cp.y + cp.h / 2, sIm = G.sx;
  const CY = (im) => cy - im * sIm;
  clipRect(cp, () => {
    ctx.fillStyle = C.surface2; ctx.fillRect(G.l, cp.y, W, cp.h);
    // grid
    const stp = (fn.x[1] - fn.x[0]) > 14 ? 2 : 1;
    for (let x = Math.ceil(fn.x[0] / stp) * stp; x <= fn.x[1]; x += stp) line(ctx, X(x), cp.y, X(x), cp.y + cp.h, C.grid, 1);
    for (let k = -6; k <= 6; k++) line(ctx, G.l, CY(k * stp), W, CY(k * stp), C.grid, 1);
    line(ctx, G.l, cy, W, cy, C.muted, 1);
    if (fn.x[0] < 0 && fn.x[1] > 0) line(ctx, X(0), cp.y, X(0), cp.y + cp.h, C.muted, 1);
    // disk
    const cx = X(S.x0);
    if (isFinite(rho)) {
      circle(ctx, cx, cy, rho * sIm, C.m, 1.8, alpha(C.m, C.dark ? 0.16 : 0.11));
      line(ctx, X(lo), cy, X(hi), cy, C.m, 3.4);
      // nearest singularity and radius
      const nz = fn.nearest(S.x0);
      if (nz && !opt.thumb) {
        const sp = [X(nz[0]), CY(nz[1])];
        line(ctx, cx, cy, sp[0], sp[1], C.m, 1.3, [4, 3]);
        const mx = (cx + sp[0]) / 2, my = (cy + sp[1]) / 2;
        text(ctx, `ρ = ${fmt(rho, 3)}`, mx + 8, my - 9, C.m, { size: 12, font: 'mono', halo: true, weight: 500 });
      }
    } else {
      ctx.fillStyle = alpha(C.m, C.dark ? 0.1 : 0.07); ctx.fillRect(G.l, cp.y, W, cp.h);
      if (!opt.thumb) text(ctx, 'ρ = ∞ : keine Singularität in ℂ, die Reihe konvergiert überall', G.l + (W - G.l) / 2, cp.y + 16, C.m, { size: 12, align: 'center', halo: true, weight: 500 });
    }
    // singularities
    for (const sg of fn.sing) {
      const px = X(sg.re), py = CY(sg.im);
      if (sg.cut) {
        ctx.save(); ctx.strokeStyle = C.f; ctx.lineWidth = 1.6; ctx.beginPath(); ctx.moveTo(px, py);
        for (let x = px, i = 0; x > G.l - 10; x -= 6, i++) ctx.lineTo(x - 6, py + (i % 2 ? -3 : 3));
        ctx.stroke(); ctx.restore();
      }
      const r = opt.thumb ? 4 : 6;
      line(ctx, px - r, py - r, px + r, py + r, C.f, 2.4); line(ctx, px - r, py + r, px + r, py - r, C.f, 2.4);
      if (!opt.thumb) text(ctx, sg.lab, px + 10, py - 10, C.f, { size: 13, font: 'serif', halo: true, weight: 600 });
    }
    dot(ctx, cx, cy, opt.thumb ? 3 : 4.4, C.ink);
  });
  if (!opt.thumb) {
    text(ctx, 'ℂ', G.l - 30, cp.y + 14, C.muted, { size: 15, font: 'serif' });
    text(ctx, 'Im', G.l - 30, cp.y + 32, C.muted, { size: 10.5, font: 'mono' });
    mlabel(ctx, 'x_0', X(S.x0) + 8, cy + 14, C.ink, { size: 14 });
    // connectors between panels at x0 ± ρ
    if (isFinite(rho)) for (const xx of [lo, hi]) {
      const px = X(xx); if (px < G.l || px > W - G.r) continue;
      line(ctx, px, gp.y, px, cp.y + cp.h / 2, alpha(C.m, 0.55), 1, [5, 4]);
    }
    // x tick labels under graph
    const stp = (fn.x[1] - fn.x[0]) > 14 ? 2 : 1;
    for (let x = Math.ceil(fn.x[0] / stp) * stp; x <= fn.x[1]; x += stp) text(ctx, fmt(x, 0), X(x), cp.y + cp.h - 9, C.muted, { size: 10.5, font: 'mono', align: 'center', halo: true });
  }
}
function polyPts(G, Y, a, n, x0, s, N) {
  const pts = [];
  for (let i = 0; i <= N; i++) { const x = G.inv(G.l + i), y = evalP(a, n, x0, x, s); pts.push(isFinite(y) ? [G.X(x), Y(clamp(y, -1e4, 1e4))] : null); }
  return pts;
}
const SUBS = '₀₁₂₃₄₅₆₇₈₉', SUPS = '⁰¹²³⁴⁵⁶⁷⁸⁹';
const sub = (n) => String(n).split('').map((d) => SUBS[+d]).join('');
const sup = (n) => (n < 0 ? '⁻' : '') + String(Math.abs(n)).split('').map((d) => SUPS[+d]).join('');

/* ---------- thumbnail ---------- */
export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  const fn = FN.rat; const S = { fn: 'rat', x0: 0.5, n: 10, s: 0, a: coefs(fn, 0.5) };
  draw(ctx, W, H, S, { thumb: true });
}

const STEPS = [
  { title: 'Grad 1: die Tangente', set: { fn: 'exp', x0: 0, n: 1 },
    html: '<p>Welches Polynom passt am besten zu $f$ in der Nähe von $x_0$? Mit Grad 1 stimmen Funktionswert und Steigung überein: Das ist die Tangente $P_1(x) = f(x_0) + f\'(x_0)(x-x_0)$.</p><p>Das untere Band zeigt den Fehler $|f - P_n|$ logarithmisch. Er ist nur in $x_0$ selbst null.</p>' },
  { title: 'Grad 2: die Schmiegparabel', set: { fn: 'exp', x0: 0, n: 2 },
    html: '<p>Jeder weitere Koeffizient legt eine weitere Ableitung im Entwicklungspunkt fest:</p>$$a_k = \\frac{f^{(k)}(x_0)}{k!}.$$<p>$P_2$ hat auch dieselbe Krümmung wie $f$. Der Bereich, in dem der Fehler klein ist, wird breiter.</p>' },
  { title: 'Mehr Glieder, bessere Vorhersage', set: { fn: 'exp', x0: 0, n: 2, play: true },
    html: '<p>Drücke auf Abspielen: Der Grad steigt Schritt für Schritt. Bei $e^x$ und bei $\\cos x$ wird die Näherung irgendwann überall gut, weil es keine Stelle gibt, an der die Funktion «kaputt» ist. Der Konvergenzradius ist $\\rho = \\infty$.</p><p>Je weiter man von $x_0$ weg will, desto mehr Glieder braucht man.</p>' },
  { title: 'Eine harte Grenze', set: { fn: 'ln', x0: 3, n: 3, play: true },
    html: '<p>Bei $\\ln x$ um $x_0 = 3$ schmiegen sich die Polynome nur im Intervall $(0, 6)$ an. Rechts von $6$ laufen sie weg, egal wie hoch der Grad ist. Im Fehlerband sieht man das als Wand: innen fällt der Fehler mit jedem Grad, außen wächst er.</p>$$\\rho = \\lim_{k\\to\\infty}\\left|\\frac{a_k}{a_{k+1}}\\right| = 3.$$<p>Die Grenze ist symmetrisch um $x_0$: Die Reihe «sieht» das Hindernis bei $0$ und kommt deshalb auch nach rechts nicht weiter als $3$.</p>' },
  { title: 'Das unsichtbare Hindernis', set: { fn: 'rat', x0: 0, n: 4, play: true },
    html: '<p>$\\dfrac{1}{1+x^2}$ ist auf ganz $\\mathbb R$ glatt und harmlos. Trotzdem divergiert die Taylorreihe um $0$ für $|x| > 1$.</p><p>Die Erklärung steht in der komplexen Ebene darunter: Der Nenner wird bei $x = \\pm i$ null. Der Konvergenzkreis wächst um $x_0$, bis er diese Pole berührt. Sein Schnitt mit der reellen Achse ist genau das Intervall, in dem die Reihe konvergiert.</p>' },
  { title: 'Konvergenzradius ohne Rechnung', set: { fn: 'rat', x0: 1.5, n: 12 },
    html: '<p>Verschiebe $x_0$ (tippen oder ziehen). Der Radius ist immer der Abstand zur nächsten Singularität:</p>$$\\rho = |x_0 - i| = \\sqrt{x_0^2 + 1}.$$<p>Probiere auch $\\frac{1}{2x+5}$ (Pol bei $-\\tfrac52$) und $\\ln x$ (Problemstelle $0$). Das ist der Trick aus dem Skript: Konvergenzradius gleich Abstand zum nächsten «kaputten» Punkt, auch wenn dieser komplex ist.</p>' },
];

export function mount(root) {
  const L0 = layout(root, meta);
  const S = { fn: 'exp', x0: 0, n: 1, s: 0, a: null, phase: 0 };
  const refresh = () => { S.a = coefs(FN[S.fn], S.x0); };
  refresh();
  const stage = new Stage(L0.stage, {
    draw: (ctx, W, H) => draw(ctx, W, H, S),
    pointer: {
      down(x, y) { const G = geom(stage.w, stage.h, FN[S.fn]); if (x < G.l - 4) return null; setX0(G.inv(x)); return { k: 'x0' }; },
      drag(h, x) { const G = geom(stage.w, stage.h, FN[S.fn]); setX0(G.inv(x)); },
      hover: () => 'ew-resize',
    },
  });
  L0.stage.append(el('div', { class: 'hint', html: 'Tippen oder ziehen, um den Entwicklungspunkt <i>x</i><sub>0</sub> zu setzen' }));
  function setX0(v) {
    const fn = FN[S.fn];
    v = clamp(v, ...fn.x0r);
    if (S.fn === 'lin' && Math.abs(v + 2.5) < 0.25) v = v < -2.5 ? -2.75 : -2.25;
    S.x0 = Math.round(v * 100) / 100; refresh(); updateReadout(); stage.invalidate();
  }

  const DT = 0.8, MORPH = 0.45;
  const runner = new Runner({
    stages: [stage],
    update(dt) {
      S.phase += dt;
      if (S.phase > DT - MORPH) S.s = smooth(clamp((S.phase - (DT - MORPH)) / MORPH, 0, 1));
      if (S.phase >= DT) {
        S.phase = 0; S.s = 0;
        if (S.n < maxN()) { S.n++; nSl.set(S.n); updateReadout(); }
        if (S.n >= maxN()) runner.pause();
      }
    },
  });
  const maxN = () => (S.fn === 'exp' ? 22 : S.fn === 'cos' ? 30 : 30);
  runner.on((p) => { if (!p) { S.s = 0; S.phase = 0; stage.invalidate(); } });

  const nSl = slider({ id: 'ty-n', label: 'Grad', min: 0, max: NMAX, step: 1, value: S.n, format: (v) => `n = ${v}`, onInput: (v) => { runner.pause(); S.n = v; updateReadout(); stage.invalidate(); } });
  const nIn = nSl.input; nIn.setAttribute('aria-label', 'Grad n');
  const tlabel = el('span', { class: 'tlabel' });
  L0.tslot.append(transport(runner, { onRestart: () => { S.n = 0; nSl.set(0); S.phase = 0; updateReadout(); runner.play(); }, scrub: nIn, label: tlabel }));
  nSl.querySelector('.ctrl-top').remove();

  const fnSeg = seg(Object.entries(FN).map(([k, v]) => [k, v.label]), S.fn, (k) => { setFn(k); }, 'scenes');
  L0.scenes.append(fnSeg);
  function setFn(k, x0) {
    S.fn = k; fnSeg.set(k); S.x0 = x0 ?? FN[k].x0; refresh(); updateReadout(); stage.invalidate();
  }

  const q = el('p', { class: 'question', html: 'Ein Taylorpolynom nutzt nur, was man an einer einzigen Stelle $x_0$ über $f$ weiß. <b>Wie weit reicht diese Information, und was entscheidet, wo die Reihe aufhört zu konvergieren?</b>' });
  const steps = stepper(STEPS, (st) => {
    const s = st.set; runner.pause();
    setFn(s.fn, s.x0); S.n = s.n; nSl.set(s.n); updateReadout(); stage.invalidate();
    if (s.play) setTimeout(() => runner.play(), 350);
  });
  const ro = readout([['f', 'Funktion'], ['x0', 'Entwicklungspunkt <span class="var">x</span><sub>0</sub>'], ['rho', 'Konvergenzradius <span class="var">ρ</span>'], ['s', 'nächste Singularität']]);
  const poly = el('div', { class: 'formulas' });
  let tsT = 0;
  function updateReadout() {
    const fn = FN[S.fn], rho = fn.rho(S.x0);
    ro.set('f', fn.label); ro.set('x0', fmt(S.x0, 2)); ro.set('rho', isFinite(rho) ? fmt(rho, 3) : '∞');
    ro.set('s', fn.sing.length ? fn.sing.map((s) => s.lab).join(', ') : 'keine');
    tlabel.textContent = `n = ${S.n}`;
    clearTimeout(tsT);
    tsT = setTimeout(() => {
      const a = S.a, terms = [];
      const h = S.x0 === 0 ? 'x' : `(x ${S.x0 > 0 ? '-' : '+'} ${fmt(Math.abs(S.x0), 2)})`;
      for (let k = 0; k <= S.n && terms.length < 3; k++) {
        if (Math.abs(a[k]) < 1e-12) continue;
        const c = Math.abs(a[k]), sg = a[k] < 0 ? '-' : '+';
        const cs = Math.abs(c - 1) < 1e-12 && k > 0 ? '' : (c < 1e-3 ? c.toExponential(2).replace(/e(.*)/, '\\cdot 10^{$1}') : fmt(c, 3).replace(/0+$/, '').replace(/\.$/, ''));
        terms.push({ sg, t: k === 0 ? cs : `${cs}${k === 1 ? h : h + '^{' + k + '}'}` });
      }
      let tex = terms.map((t, i) => (i === 0 ? (t.sg === '-' ? '-' : '') : ` ${t.sg} `) + t.t).join('') || '0';
      if (S.n > 0 && terms.length >= 3) tex += ' + \\dots';
      poly.innerHTML = `$$P_{${S.n}}(x) = ${tex}$$`;
      typeset(poly);
    }, 160);
  }
  const box = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Erkunden' }), ro, poly);
  const formulas = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Formeln aus dem Skript' }), el('div', { class: 'formulas', html:
    '$$P_n(x) = \\sum_{k=0}^{n}\\frac{f^{(k)}(x_0)}{k!}(x-x_0)^k$$<p>Restglied nach Lagrange</p>$$R_n(x) = \\frac{f^{(n+1)}(\\xi)}{(n+1)!}(x-x_0)^{n+1}$$<p>Konvergenzradius</p>$$\\rho = \\lim_{k\\to\\infty}\\left|\\frac{a_k}{a_{k+1}}\\right|$$' }));
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Innerhalb von $|x - x_0| < \\rho$ wird die Näherung mit jedem Glied besser, außerhalb wird sie schlechter. Der Radius ist der Abstand zur nächsten Singularität in der komplexen Ebene.' });
  L0.panel.append(q, steps, box, formulas, insight, el('p', { class: 'src', html: 'Skript Analysis 1, Abschnitte 5.2 (Potenzreihen, Konvergenzradius, Trick «Konvergenzradius ohne Rechnung») und 5.3 (Taylorpolynome).' }));
  steps.go(0);
  updateReadout(); typeset(L0.panel);
  return { destroy() { runner.destroy(); stage.destroy(); } };
}
