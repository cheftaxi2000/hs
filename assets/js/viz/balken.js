// Schnittgrößen am geraden Balken: Q′ = −q, M′ = −Q (Mechanik 1, Kap. 14)
import {
  C, TAU, clamp, Stage, Runner, line, path, poly, circle, dot, ring, arrow, arcArrow, hatch, mlabel, text, fmt,
  el, slider, seg, chip, readout, layout, stepper, typeset, alpha,
} from '../core.js';

export const meta = {
  id: 'schnittgroessen',
  group: 'Mechanik 1',
  short: 'Schnittgrößen',
  tag: 'Mechanik 1 · Kapitel 14.3',
  title: 'Wie entstehen Querkraft- und Momentenverlauf?',
  card: 'Schiebe den Schnitt über den Balken: Die Querkraft sammelt die Last auf, das Moment sammelt die Querkraft auf.',
};

const LEN = 6; // m
const SUPPORTS = {
  zwei: { label: 'Zwei Stützen', xb: LEN },
  ueber: { label: 'Mit Kragende', xb: 4.5 },
  krag: { label: 'Kragarm', xb: null },
};

/* ---------- statics (sign convention of the script: y up, Q_y′ = −q_y, M_z′ = −Q_y) ---------- */
function solve(S) {
  const pts = [], mom = [];
  if (S.F.on) pts.push({ x: S.F.x, Fy: -S.F.val, kind: 'F' });
  if (S.M.on) mom.push({ x: S.M.x, M: S.M.val, kind: 'M' });
  const q = S.q.on ? { a: Math.min(S.q.a, S.q.b), b: Math.max(S.q.a, S.q.b), qy: -S.q.val } : { a: 0, b: 0, qy: 0 };
  const sumF = pts.reduce((s, p) => s + p.Fy, 0) + q.qy * (q.b - q.a);
  const sumM0 = pts.reduce((s, p) => s + p.x * p.Fy, 0) + q.qy * (q.b * q.b - q.a * q.a) / 2 + mom.reduce((s, m) => s + m.M, 0);
  const sup = SUPPORTS[S.support];
  const R = {};
  if (sup.xb) {
    R.By = -sumM0 / sup.xb; R.Ay = -sumF - R.By; R.xb = sup.xb;
    pts.push({ x: 0, Fy: R.Ay, kind: 'A' }, { x: sup.xb, Fy: R.By, kind: 'B' });
  } else {
    R.Ay = -sumF; R.MA = -sumM0;
    pts.push({ x: 0, Fy: R.Ay, kind: 'A' }); mom.push({ x: 0, M: R.MA, kind: 'MA' });
  }
  // evaluation with left limits (x_i < x) — callers use x ± ε around jumps
  const Q = (x) => {
    let s = 0;
    for (const p of pts) if (p.x < x) s += p.Fy;
    if (x > q.a) s += q.qy * (Math.min(x, q.b) - q.a);
    return -s;
  };
  const M = (x) => {
    let s = 0;
    for (const p of pts) if (p.x < x) s += (x - p.x) * p.Fy;
    for (const m of mom) if (m.x < x) s -= m.M;
    if (x > q.a) { const e = Math.min(x, q.b); s += q.qy * ((x - q.a) ** 2 - (x - e) ** 2) / 2; }
    return s;
  };
  const qAt = (x) => (x > q.a && x < q.b ? q.qy : 0);
  const brk = new Set([0, LEN, ...pts.map((p) => p.x), ...mom.map((m) => m.x)]);
  if (S.q.on) { brk.add(q.a); brk.add(q.b); }
  const xs = [...brk].filter((x) => x >= 0 && x <= LEN).sort((a, b) => a - b);
  return { pts, mom, q, R, Q, M, qAt, xs };
}

function curve(sol, f) {
  const out = [[0, 0]], eps = 1e-6;
  for (let i = 0; i < sol.xs.length - 1; i++) {
    const a = sol.xs[i], b = sol.xs[i + 1]; if (b - a < 1e-9) continue;
    const n = 48;
    for (let k = 0; k <= n; k++) { const x = a + eps + ((b - a - 2 * eps) * k) / n; out.push([x, f(x)]); }
  }
  out.push([LEN, 0]);
  return out;
}
const nice = (v) => { if (v <= 1e-9) return 1; const e = 10 ** Math.floor(Math.log10(v)); const m = v / e; return (m <= 1 ? 1 : m <= 2 ? 2 : m <= 2.5 ? 2.5 : m <= 5 ? 5 : 10) * e; };

/* ---------- drawing ---------- */
function geom(W, H) {
  const left = Math.max(66, W * 0.08), right = Math.max(34, W * 0.045);
  const x0 = left, x1 = W - right;
  const top = 12, gap = 16, foot = 24;
  const hb = Math.round(H * 0.37), hq = Math.round((H - hb - top - 2 * gap - foot) / 2);
  return {
    X: (x) => x0 + ((x1 - x0) * x) / LEN, inv: (px) => ((px - x0) / (x1 - x0)) * LEN, x0, x1, foot: H - foot / 2,
    beam: { y: top, h: hb }, qp: { y: top + hb + gap, h: hq }, mp: { y: top + hb + 2 * gap + hq, h: hq },
  };
}

function drawAll(ctx, W, H, S, opt = {}) {
  const sol = solve(S), G = geom(W, H);
  const { X } = G;
  const lay = S.layers;
  const by = G.beam.y + G.beam.h * 0.5, bh = Math.max(10, Math.min(16, G.beam.h * 0.075));
  const cut = lay.cut ? S.cut : null;

  // ---- beam panel ----
  // loads scale
  const fpx = Math.min(G.beam.h * 0.34, 90);
  const Fmax = 25, qmax = 10;
  // distributed load
  if (S.q.on) {
    const a = Math.min(S.q.a, S.q.b), b = Math.max(S.q.a, S.q.b);
    const hq = (S.q.val / qmax) * fpx * 0.75 + 8;
    const ya = by - bh / 2 - 3, yt = ya - hq;
    ctx.save(); ctx.fillStyle = alpha(C.f, C.dark ? 0.14 : 0.08); ctx.fillRect(X(a), yt, X(b) - X(a), hq); ctx.restore();
    line(ctx, X(a), yt, X(b), yt, C.f, 1.6);
    const n = Math.max(2, Math.round((X(b) - X(a)) / 22));
    for (let i = 0; i <= n; i++) { const x = X(a) + ((X(b) - X(a)) * i) / n; arrow(ctx, x, yt, x, ya, C.f, 1.3, 7); }
    if (!opt.thumb) {
      mlabel(ctx, 'q', (X(a) + X(b)) / 2 - 30, yt - 13, C.f, { size: 16 });
      text(ctx, `= ${fmt(S.q.val, 1)} kN/m`, (X(a) + X(b)) / 2 - 20, yt - 13, C.f, { size: 12.5, font: 'mono', halo: true });
      ring(ctx, X(a), yt, 5, C.f, 1.6); ring(ctx, X(b), yt, 5, C.f, 1.6);
    }
  }
  // point force
  if (S.F.on) {
    const L = (Math.abs(S.F.val) / Fmax) * fpx + 18, x = X(S.F.x), y1 = by - bh / 2 - 2;
    const dn = S.F.val >= 0;
    if (dn) arrow(ctx, x, y1 - L, x, y1, C.f, 2.6, 12); else arrow(ctx, x, y1, x, y1 - L, C.f, 2.6, 12);
    if (!opt.thumb) {
      mlabel(ctx, 'F', x + 9, y1 - L + 6, C.f, { size: 16 });
      text(ctx, `= ${fmt(Math.abs(S.F.val), 1)} kN`, x + 21, y1 - L + 6, C.f, { size: 12.5, font: 'mono', halo: true });
      ring(ctx, x, dn ? y1 - L : y1 - L, 5.5, C.f, 1.6);
    }
  }
  // point moment
  if (S.M.on) {
    const x = X(S.M.x), r = 20;
    const ccw = S.M.val >= 0;
    arcArrow(ctx, x, by, r, ccw ? 0.6 : Math.PI - 0.6, ccw ? -Math.PI - 0.1 : TAU + 0.1, C.m, 2.2, 10);
    if (!opt.thumb) {
      mlabel(ctx, 'M_0', x + r + 6, by - r - 4, C.m, { size: 16 });
      text(ctx, `= ${fmt(Math.abs(S.M.val), 1)} kNm`, x + r + 30, by - r - 4, C.m, { size: 12.5, font: 'mono', halo: true });
      ring(ctx, x, by - r, 5, C.m, 1.6);
    }
  }
  // beam (left / right of cut)
  const drawBeam = (xa, xb, a = 1) => {
    ctx.save(); ctx.globalAlpha = a;
    ctx.fillStyle = C.surface2; ctx.strokeStyle = C.ink; ctx.lineWidth = 1.6;
    ctx.beginPath(); ctx.rect(X(xa), by - bh / 2, X(xb) - X(xa), bh); ctx.fill(); ctx.stroke(); ctx.restore();
  };
  if (cut != null) { drawBeam(0, cut); drawBeam(cut, LEN, 0.28); } else drawBeam(0, LEN);
  // supports
  const sup = SUPPORTS[S.support];
  const tri = (x, roller) => {
    const px = X(x), y = by + bh / 2, s = 14;
    ctx.save(); ctx.strokeStyle = C.ink; ctx.fillStyle = C.surface; ctx.lineWidth = 1.5;
    ctx.beginPath(); ctx.moveTo(px, y); ctx.lineTo(px - s, y + s * 1.3); ctx.lineTo(px + s, y + s * 1.3); ctx.closePath(); ctx.fill(); ctx.stroke(); ctx.restore();
    const gy = y + s * 1.3 + (roller ? 5 : 0);
    if (roller) line(ctx, px - s - 3, gy, px + s + 3, gy, C.ink, 1.5);
    hatch(ctx, px - s - 5, gy + (roller ? 0 : 0), px + s + 5, gy, C.muted, -1, 7, 6);
    ring(ctx, px, y, 3.2, C.ink, 1.4);
  };
  if (sup.xb) { tri(0, false); tri(sup.xb, true); }
  else { const px = X(0); hatch(ctx, px, by + 34, px, by - 34, C.muted, 1, 10, 7); }
  // reactions
  if (lay.reac) {
    const ya = by + bh / 2 + 28, room = G.beam.y + G.beam.h - ya - 2;
    const rs = (v) => Math.min(room, (Math.abs(v) / Fmax) * fpx * 0.7 + 14);
    const drawR = (px, v, name, right) => {
      const L = rs(v);
      if (v >= 0) arrow(ctx, px, ya + L, px, ya, C.f, 2.2, 10); else arrow(ctx, px, ya, px, ya + L, C.f, 2.2, 10);
      if (!opt.thumb) {
        const lx = right ? px + 10 : px - 10, al = right ? 'left' : 'right';
        mlabel(ctx, name, lx, ya + L / 2 - 8, C.f, { size: 15, align: al });
        text(ctx, `${fmt(v, 2)} kN`, lx, ya + L / 2 + 10, C.f, { size: 11.5, font: 'mono', halo: true, align: al });
      }
    };
    drawR(X(0), sol.R.Ay, 'A_y', true);
    if (sup.xb) drawR(X(sup.xb), sol.R.By, 'B_y', sup.xb < LEN - 0.5);
    else {
      const ccw = sol.R.MA >= 0;
      arcArrow(ctx, X(0) + 2, by, 30, ccw ? -0.9 : 0.9, ccw ? -0.9 - 2.0 : 0.9 + 2.0, C.m, 2, 9);
      if (!opt.thumb) { mlabel(ctx, 'M_A', X(0) + 36, by - 34, C.m, { size: 15 }); text(ctx, `= ${fmt(sol.R.MA, 2)} kNm`, X(0) + 64, by - 34, C.m, { size: 11.5, font: 'mono', halo: true }); }
    }
  }
  // internal forces at the cut (positive face of the left part)
  if (cut != null) {
    const px = X(cut), Qv = sol.Q(cut + 1e-7), Mv = sol.M(cut + 1e-7);
    line(ctx, px, G.beam.y + 6, px, G.mp.y + G.mp.h, alpha(C.ink, 0.45), 1, [4, 4]);
    // Q arrow
    const L = clamp((Math.abs(Qv) / Fmax) * fpx + 14, 14, 110);
    if (Math.abs(Qv) > 1e-6) {
      if (Qv > 0) arrow(ctx, px + 4, by + L / 2, px + 4, by - L / 2, C.f, 2.4, 10);
      else arrow(ctx, px + 4, by - L / 2, px + 4, by + L / 2, C.f, 2.4, 10);
    }
    if (Math.abs(Mv) > 1e-6) {
      const ccw = Mv > 0;
      arcArrow(ctx, px - 6, by, 24, ccw ? 1.05 : -1.05, ccw ? -1.05 : 1.05, C.m, 2.2, 9);
    }
    if (!opt.thumb) {
      const tx = px + 18, ty = by - 48;
      mlabel(ctx, 'Q_y', tx, ty, C.f, { size: 15 }); text(ctx, `= ${fmt(Qv, 2)} kN`, tx + 26, ty, C.f, { size: 12, font: 'mono', halo: true });
      mlabel(ctx, 'M_z', tx, ty - 20, C.m, { size: 15 }); text(ctx, `= ${fmt(Mv, 2)} kNm`, tx + 28, ty - 20, C.m, { size: 12, font: 'mono', halo: true });
      // handle
      ctx.save(); ctx.fillStyle = C.ink; ctx.beginPath(); ctx.roundRect(px - 9, G.beam.y + 2, 18, 18, 9); ctx.fill(); ctx.restore();
      line(ctx, px - 3, G.beam.y + 7, px - 3, G.beam.y + 15, C.surface, 1.4); line(ctx, px + 3, G.beam.y + 7, px + 3, G.beam.y + 15, C.surface, 1.4);
    }
  }
  // x axis ticks under the beam
  if (!opt.thumb) {
    for (let x = 0; x <= LEN; x += 1) text(ctx, `${x}`, X(x), G.foot, C.muted, { size: 11, font: 'mono', align: 'center' });
    mlabel(ctx, 'x', G.x1 + 8, G.foot, C.muted, { size: 14 });
    text(ctx, 'm', G.x1 + 18, G.foot + 1, C.muted, { size: 11, font: 'mono' });
  }

  // ---- diagrams ----
  const qc = curve(sol, sol.Q), mc = curve(sol, sol.M);
  drawDiagram(ctx, G, G.qp, qc, range(qc), C.f, 'Q_y', 'kN', sol, S, 'Q', opt);
  drawDiagram(ctx, G, G.mp, mc, range(mc), C.m, 'M_z', 'kNm', sol, S, 'M', opt);
}

function range(pts) {
  let mx = 0, mn = 0; for (const p of pts) { mx = Math.max(mx, p[1]); mn = Math.min(mn, p[1]); }
  let hi = mx > 1e-9 ? nice(mx) : 0, lo = mn < -1e-9 ? -nice(-mn) : 0;
  if (hi === 0 && lo === 0) hi = 1;
  const pad = 0.12 * (hi - lo);
  return { hi, lo, top: hi === 0 ? pad : hi, bot: lo === 0 ? -pad : lo };
}
function drawDiagram(ctx, G, P, pts, rg, col, name, unit, sol, S, which, opt) {
  const { X } = G, vmax = Math.max(rg.hi, -rg.lo);
  const Y = (v) => P.y + 6 + ((rg.top - v) / (rg.top - rg.bot)) * (P.h - 12);
  const y0 = Y(0);
  // frame
  line(ctx, G.x0, y0, G.x1, y0, C.muted, 1);
  line(ctx, G.x0, P.y + 2, G.x0, P.y + P.h - 2, C.hair, 1);
  if (!opt.thumb) {
    mlabel(ctx, name, 10, P.y + 14, col, { size: 16 });
    text(ctx, unit, 10, P.y + 32, C.muted, { size: 11, font: 'mono' });
    for (const v of [rg.hi, rg.lo]) { if (!v) continue; line(ctx, G.x0 - 4, Y(v), G.x0, Y(v), C.muted, 1); text(ctx, fmt(v, vmax < 10 ? 1 : 0), G.x0 - 7, Y(v), C.muted, { size: 10.5, font: 'mono', align: 'right' }); line(ctx, G.x0, Y(v), G.x1, Y(v), C.grid, 1); }
    text(ctx, '0', G.x0 - 7, y0, C.muted, { size: 10.5, font: 'mono', align: 'right' });
  }
  const px = pts.map(([x, v]) => [X(x), Y(v)]);
  // area fill
  ctx.save(); ctx.beginPath(); ctx.moveTo(px[0][0], y0); px.forEach((p) => ctx.lineTo(p[0], p[1])); ctx.lineTo(px[px.length - 1][0], y0); ctx.closePath();
  ctx.fillStyle = alpha(col, C.dark ? 0.16 : 0.1); ctx.fill(); ctx.restore();
  // area under Q up to the cut (= −ΔM)
  const cut = S.layers.cut ? S.cut : null;
  if (which === 'Q' && S.layers.area && cut != null) {
    ctx.save(); ctx.beginPath(); ctx.moveTo(X(0), y0);
    pts.filter((p) => p[0] <= cut).forEach(([x, v]) => ctx.lineTo(X(x), Y(v)));
    ctx.lineTo(X(cut), Y(sol.Q(cut))); ctx.lineTo(X(cut), y0); ctx.closePath();
    ctx.fillStyle = alpha(C.m, C.dark ? 0.32 : 0.22); ctx.fill(); ctx.restore();
  }
  poly(ctx, px, col, 2.2);
  // extremum of M
  if (which === 'M' && !opt.thumb) {
    let best = null;
    for (const p of pts) if (!best || Math.abs(p[1]) > Math.abs(best[1])) best = p;
    if (best && Math.abs(best[1]) > 1e-6) {
      const bx = X(best[0]), byy = Y(best[1]);
      dot(ctx, bx, byy, 3.4, col);
      text(ctx, `${fmt(best[1], 2)} kNm`, bx + 8, byy + (best[1] > 0 ? -12 : 14), col, { size: 11.5, font: 'mono', halo: true, weight: 500 });
      // Q = 0 there → guide to the Q diagram
      if (S.layers.slope) {
        const Qb = sol.Q(best[0]);
        if (Math.abs(Qb) < 1e-3 * Math.max(1, vmax)) line(ctx, bx, G.qp.y + G.qp.h / 2, bx, byy, alpha(col, 0.6), 1, [2, 3]);
      }
    }
  }
  // cut marker + tangent (slope)
  if (cut != null) {
    const v = which === 'Q' ? sol.Q(cut + 1e-7) : sol.M(cut + 1e-7);
    const cx = X(cut), cy = Y(v);
    if (S.layers.slope) {
      const k = which === 'Q' ? -sol.qAt(cut + 1e-7) : -sol.Q(cut + 1e-7); // dQ/dx, dM/dx
      const dx = 0.75;
      const a = [X(cut - dx), Y(v - k * dx)], b = [X(cut + dx), Y(v + k * dx)];
      line(ctx, a[0], a[1], b[0], b[1], C.ink, 1.4);
      if (!opt.thumb) {
        const lab = which === 'Q' ? `Q′ = −q_y = ${fmt(k, 2)} kN/m` : `M′ = −Q_y = ${fmt(k, 2)} kN`;
        text(ctx, lab, cx + 12, P.y + 12, C.ink, { size: 11.5, font: 'mono', halo: true });
      }
    }
    ring(ctx, cx, cy, 5, col, 2);
    if (which === 'Q' && S.layers.area && !opt.thumb) {
      const dM = sol.M(cut + 1e-7) - sol.M(1e-7);
      text(ctx, `−∫Q dx = ${fmt(dM, 2)} kNm = ΔM`, X(Math.min(cut, LEN) / 2), y0 + (sol.Q(cut / 2) > 0 ? 14 : -14), C.m, { size: 11, font: 'mono', align: 'center', halo: true });
    }
  }
}

/* ---------- thumbnail ---------- */
export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  const S = defaults(); S.layers = { reac: false, cut: true, slope: false, area: false }; S.cut = 2.8;
  ctx.save(); ctx.translate(0, 4);
  drawAll(ctx, W, H - 8, S, { thumb: true });
  ctx.restore();
}
function defaults() {
  return {
    support: 'zwei', cut: 2.6,
    F: { on: true, x: 2, val: 12 }, q: { on: true, a: 3.5, b: 6, val: 4 }, M: { on: false, x: 4.5, val: 10 },
    layers: { reac: true, cut: true, slope: false, area: false },
  };
}

const STEPS = [
  { title: 'Zuerst die Lagerkräfte', set: { support: 'zwei', layers: { reac: true, cut: false, slope: false, area: false }, M: false },
    html: '<p>Ein Balken auf zwei Stützen trägt eine Einzelkraft $F$ und eine Gleichlast $q$. Bevor man innen schneidet, bestimmt man die Lagerkräfte aus dem Gleichgewicht am ganzen Balken:</p>$$\\sum F_y = 0,\\qquad \\sum M_A = 0 .$$<p>Ziehe die Lasten an den Kreisen zur Seite. Die Lagerkräfte passen sich sofort an.</p>' },
  { title: 'Schneiden: Gleichgewicht am linken Teil', set: { layers: { reac: true, cut: true, slope: false, area: false }, cut: 1.2 },
    html: '<p>Der Schnitt bei $x$ legt die inneren Kräfte frei. Am positiven Schnittufer des linken Teils zeigen positive $Q_y$ und $M_z$ in die positiven Koordinatenrichtungen. Ihre Werte folgen aus dem Gleichgewicht des linken Teils allein.</p><p>Ziehe den Schnitt (den dunklen Griff oben oder irgendwo in den Diagrammen) langsam von links nach rechts.</p>' },
  { title: 'Die Querkraft sammelt die Last auf', set: { layers: { reac: true, cut: true, slope: true, area: false }, cut: 4.6 },
    html: '<p>Am Balkenelement $\\mathrm dx$ gilt $\\mathrm dQ_y = -q_y\\,\\mathrm dx$, also</p>$$Q_y\' = -q_y .$$<p>Ohne Last ist $Q$ konstant, unter der Gleichlast steigt sie linear (die Tangente zeigt die Steigung $q$). An der Einzelkraft springt sie um genau $F$.</p>' },
  { title: 'Das Moment sammelt die Querkraft auf', set: { layers: { reac: true, cut: true, slope: true, area: true }, cut: 3.2 },
    html: '<p>Ebenso gilt</p>$$M_z\' = -Q_y,\\qquad M_z(x) - M_z(0) = -\\int_0^x Q_y\\,\\mathrm d\\xi .$$<p>Die grüne Fläche im $Q$-Diagramm ist genau die Änderung von $M$ bis zum Schnitt. Wo $Q = 0$ ist oder das Vorzeichen wechselt, hat $M$ seine Tangente waagrecht: Dort liegt das größte Biegemoment.</p>' },
  { title: 'Sprünge und Knicke', set: { layers: { reac: true, cut: true, slope: true, area: false }, M: true, cut: 4.2 },
    html: '<p>Ein Einzelmoment $M_0$ ändert die Querkraft nicht, aber $M$ springt um $-M_0$. Eine Einzelkraft lässt $Q$ springen und erzeugt in $M$ einen Knick.</p>$$Q_y(a^+) - Q_y(a^-) = -F_y,\\qquad M_z(b^+) - M_z(b^-) = -M_0 .$$<p>Schiebe $M_0$ und den Schnitt an der Sprungstelle vorbei.</p>' },
  { title: 'Kragarm und Kragende', set: { support: 'krag', layers: { reac: true, cut: true, slope: true, area: true }, M: false, cut: 0.6 },
    html: '<p>Beim Kragarm liegt das größte Moment an der Einspannung. Am freien Ende sind $Q$ und $M$ null, wenn dort keine Einzellast angreift.</p><p>Wechsle auch zu «Mit Kragende»: Über dem rechten Lager wird $M$ negativ, der Balken ist dort oben gezogen.</p>' },
];

export function mount(root) {
  const L0 = layout(root, meta);
  const S = defaults();
  let drag = null;
  const stage = new Stage(L0.stage, {
    draw: (ctx, W, H) => drawAll(ctx, W, H, S),
    pointer: {
      down(x, y) {
        const G = geom(stage.w, stage.h), by = G.beam.y + G.beam.h * 0.5;
        const near = (px, py, r = 22) => Math.hypot(x - px, y - py) < r;
        const fpx = Math.min(G.beam.h * 0.34, 90);
        if (S.layers.cut && near(G.X(S.cut), G.beam.y + 11, 24)) return { k: 'cut' };
        if (S.F.on) { const L = (Math.abs(S.F.val) / 25) * fpx + 18; if (Math.abs(x - G.X(S.F.x)) < 20 && y > by - L - 14 && y < by) return { k: 'F' }; }
        if (S.M.on && near(G.X(S.M.x), by, 32)) return { k: 'M' };
        if (S.q.on) {
          const hq = (S.q.val / 10) * fpx * 0.75 + 8, yt = by - 8 - hq;
          if (near(G.X(S.q.a), yt)) return { k: 'qa' };
          if (near(G.X(S.q.b), yt)) return { k: 'qb' };
          const a = Math.min(S.q.a, S.q.b), b = Math.max(S.q.a, S.q.b);
          if (x > G.X(a) && x < G.X(b) && y > yt - 8 && y < by) return { k: 'q', off: G.inv(x) - a, w: b - a };
        }
        if (S.layers.cut && (y > G.qp.y - 6 || Math.abs(x - G.X(S.cut)) < 18)) { S.cut = clamp(G.inv(x), 0.02, LEN - 0.02); return { k: 'cut' }; }
        return null;
      },
      drag(h, x) {
        const G = geom(stage.w, stage.h), u = clamp(G.inv(x), 0, LEN), sn = (v) => Math.round(v * 10) / 10;
        if (h.k === 'cut') S.cut = clamp(u, 0.02, LEN - 0.02);
        if (h.k === 'F') S.F.x = sn(u);
        if (h.k === 'M') S.M.x = clamp(sn(u), 0.1, LEN - 0.1);
        if (h.k === 'qa') S.q.a = sn(u);
        if (h.k === 'qb') S.q.b = sn(u);
        if (h.k === 'q') { const a = clamp(sn(u - h.off), 0, LEN - h.w); S.q.a = a; S.q.b = sn(a + h.w); }
        if (Math.abs(S.q.a - S.q.b) < 0.2) { if (h.k === 'qa') S.q.a = S.q.b - 0.2 * Math.sign(S.q.b - S.q.a || 1); else if (h.k === 'qb') S.q.b = S.q.a + 0.2; }
        S.q.a = clamp(S.q.a, 0, LEN); S.q.b = clamp(S.q.b, 0, LEN);
        updateReadout();
      },
      hover(x, y) {
        const G = geom(stage.w, stage.h);
        if (y > G.qp.y - 6) return 'ew-resize';
        return 'grab';
      },
    },
  });
  L0.stage.append(el('div', { class: 'hint', html: 'Lasten an den Kreisen ziehen · Schnitt in den Diagrammen verschieben' }));
  const runner = new Runner({ stages: [stage], onTick: () => updateReadout() });

  const supSeg = seg(Object.entries(SUPPORTS).map(([k, v]) => [k, v.label]), S.support, (k) => { S.support = k; stage.invalidate(); updateReadout(); }, 'scenes');
  L0.scenes.append(supSeg);

  const q = el('p', { class: 'question', html: 'In der Prüfung musst du Querkraft- und Momentenverläufe skizzieren. <b>Woher weiß man, wo die Kurve gerade, schräg oder gekrümmt ist, wo sie springt und wo das größte Moment liegt?</b>' });
  const steps = stepper(STEPS, (st) => {
    const s = st.set;
    if (s.support) { S.support = s.support; supSeg.set(s.support); }
    Object.assign(S.layers, s.layers);
    if (s.M !== undefined) { S.M.on = s.M; }
    if (s.cut !== undefined) S.cut = s.cut;
    syncUI(); stage.invalidate(); updateReadout();
  });

  const chips = {
    reac: chip('Lagerkräfte', S.layers.reac, C.f, (v) => { S.layers.reac = v; stage.invalidate(); }),
    cut: chip('Schnitt', S.layers.cut, C.ink, (v) => { S.layers.cut = v; stage.invalidate(); }),
    slope: chip('Steigungen', S.layers.slope, C.ink, (v) => { S.layers.slope = v; stage.invalidate(); }),
    area: chip('Fläche unter <i>Q</i>', S.layers.area, C.m, (v) => { S.layers.area = v; stage.invalidate(); }),
  };
  const loadChips = {
    F: chip('Einzelkraft <i>F</i>', S.F.on, C.f, (v) => { S.F.on = v; syncUI(); stage.invalidate(); updateReadout(); }),
    q: chip('Gleichlast <i>q</i>', S.q.on, C.f, (v) => { S.q.on = v; syncUI(); stage.invalidate(); updateReadout(); }),
    M: chip('Einzelmoment <i>M</i><sub>0</sub>', S.M.on, C.m, (v) => { S.M.on = v; syncUI(); stage.invalidate(); updateReadout(); }),
  };
  const sF = slider({ id: 'bk-F', label: 'Einzelkraft <span class="var">F</span> (nach unten positiv)', min: -20, max: 20, step: 0.5, value: S.F.val, format: (v) => fmt(v, 1) + ' kN', onInput: (v) => { S.F.val = v; stage.invalidate(); updateReadout(); } });
  const sq = slider({ id: 'bk-q', label: 'Gleichlast <span class="var">q</span>', min: 0, max: 10, step: 0.25, value: S.q.val, format: (v) => fmt(v, 2) + ' kN/m', onInput: (v) => { S.q.val = v; stage.invalidate(); updateReadout(); } });
  const sM = slider({ id: 'bk-M', label: 'Einzelmoment <span class="var">M</span><sub>0</sub> (Gegenuhrzeigersinn positiv)', min: -30, max: 30, step: 0.5, value: S.M.val, format: (v) => fmt(v, 1) + ' kNm', onInput: (v) => { S.M.val = v; stage.invalidate(); updateReadout(); } });
  const ro = readout([['A', 'Lager <span class="var">A<sub>y</sub></span>'], ['B', 'Lager <span class="var">B<sub>y</sub></span>'], ['x', 'Schnitt bei <span class="var">x</span>'], ['Q', '<span class="var">Q<sub>y</sub></span>(<span class="var">x</span>)'], ['M', '<span class="var">M<sub>z</sub></span>(<span class="var">x</span>)'], ['max', 'größtes |<span class="var">M<sub>z</sub></span>|']]);
  function updateReadout() {
    const sol = solve(S);
    ro.set('A', fmt(sol.R.Ay, 2) + ' kN');
    const dtB = ro.querySelectorAll('dt')[1];
    if (SUPPORTS[S.support].xb) { dtB.innerHTML = 'Lager <span class="var">B<sub>y</sub></span>'; ro.set('B', fmt(sol.R.By, 2) + ' kN'); }
    else { dtB.innerHTML = 'Einspannmoment <span class="var">M<sub>A</sub></span>'; ro.set('B', fmt(sol.R.MA, 2) + ' kNm'); }
    ro.set('x', fmt(S.cut, 2) + ' m');
    ro.set('Q', fmt(sol.Q(S.cut + 1e-7), 2) + ' kN'); ro.set('M', fmt(sol.M(S.cut + 1e-7), 2) + ' kNm');
    const mc = curve(sol, sol.M); let best = mc[0]; for (const p of mc) if (Math.abs(p[1]) > Math.abs(best[1])) best = p;
    ro.set('max', `${fmt(Math.abs(best[1]), 2)} kNm bei ${fmt(best[0], 2)} m`);
  }
  function syncUI() {
    for (const [k, c] of Object.entries(chips)) c.set(!!S.layers[k]);
    loadChips.F.set(S.F.on); loadChips.q.set(S.q.on); loadChips.M.set(S.M.on);
    sF.hidden = !S.F.on; sq.hidden = !S.q.on; sM.hidden = !S.M.on;
  }
  const box = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Erkunden' }), el('div', { class: 'toggles' }, ...Object.values(chips)),
    el('div', { class: 'toggles' }, ...Object.values(loadChips)), sF, sq, sM, ro);
  const formulas = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Formeln aus dem Skript' }), el('div', { class: 'formulas', html:
    '$$Q_y\' = -q_y,\\qquad M_z\' = -Q_y,\\qquad M_z\'\' = q_y$$<p>Kontrollwerte</p>$$M_\\text{max} = \\frac{q_0L^2}{8}\\ \\text{(Gleichlast)},\\qquad M_\\text{max} = \\frac{Fab}{L}\\ \\text{(Einzellast)}$$' }));
  const tbl = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Belastung → Verlauf' }), el('dl', { class: 'readout', html:
    '<dt>keine Last</dt><dd><i>Q</i> konstant · <i>M</i> linear</dd><dt>Gleichlast</dt><dd><i>Q</i> linear · <i>M</i> Parabel</dd><dt>Einzelkraft</dt><dd><i>Q</i> Sprung · <i>M</i> Knick</dd><dt>Einzelmoment</dt><dd><i>Q</i> stetig · <i>M</i> Sprung</dd>' }));
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Last, Querkraft und Moment hängen zusammen wie Beschleunigung, Geschwindigkeit und Weg. Jeder Verlauf ist um einen Grad glatter als der vorige, und das Moment ist dort extremal, wo die Querkraft null wird.' });
  L0.panel.append(q, steps, box, tbl, formulas, insight, el('p', { class: 'src', html: 'Skript Mechanik 1, Abschnitt 14.3 (Differentialbeziehungen am geraden Balken). Vorzeichen wie im Skript: positives Schnittufer, <i>y</i> nach oben.' }));
  steps.go(0);
  syncUI(); updateReadout(); typeset(L0.panel);
  return { destroy() { runner.destroy(); stage.destroy(); } };
}
