// Ebene Bewegung: Momentanzentrum, Geschwindigkeitsfeld und Polbahnen (Mechanik 1, Kap. 3)
import {
  C, TAU, clamp, Stage, Runner, View, line, path, circle, dot, ring, arrow, rightAngle, hatch, mlabel, text, fmt,
  el, slider, seg, chip, readout, transport, layout, stepper, typeset, alpha,
} from '../core.js';

export const meta = {
  id: 'momentanzentrum',
  group: 'Mechanik 1',
  short: 'Momentanzentrum',
  tag: 'Mechanik 1 · Kapitel 3.5',
  title: 'Um welchen Punkt dreht sich der Körper gerade?',
  card: 'Rad, geführter Stab und Schubkurbel: Das Momentanzentrum wandert, und die bewegliche Polbahn rollt auf der festen ab.',
};

/* ---------- kinematics helpers ---------- */
const rot = (th, p) => [Math.cos(th) * p[0] - Math.sin(th) * p[1], Math.sin(th) * p[0] + Math.cos(th) * p[1]];
const toWorld = (b, p) => { const r = rot(b.theta, p); return [b.o[0] + r[0], b.o[1] + r[1]]; };
const toBody = (b, w) => rot(-b.theta, [w[0] - b.o[0], w[1] - b.o[1]]);
/** v = v_O + ω e_z × (p − O) */
const vel = (b, p) => [b.v[0] - b.w * (p[1] - b.o[1]), b.v[1] + b.w * (p[0] - b.o[0])];
/** Z = O + (e_z × v_O)/ω */
const centre = (b) => (Math.abs(b.w) < 1e-6 ? null : [b.o[0] - b.v[1] / b.w, b.o[1] + b.v[0] / b.w]);

/* ---------- scenes ---------- */
const R = 1;          // Radradius
const L = 1;          // Stablänge
const K = 0.97;       // Glättung der Umkehr (Stab)

const SCENES = {
  rad: {
    label: 'Rollendes Rad',
    T: TAU, hold: 0.9,
    box: [-1.15, TAU + 1.15, -1.05, 2.9],
    vs: 0.62,
    probe0: [0, -R],
    sampleRange: [0, TAU],
    pose(t) {
      const tt = clamp(t, 0, TAU);
      const w = -1;                     // Uhrzeigersinn, |ω| = 1 s⁻¹
      const xc = -w * R * tt;           // Rollbedingung v_O = ω R
      return { main: { o: [xc, R], theta: w * tt, v: [-w * R, 0], w } };
    },
    inside: (b, p) => Math.hypot(p[0] - b.o[0], p[1] - b.o[1]) <= R,
  },
  stab: {
    label: 'Stab an Wand und Boden',
    T: 8, hold: 0,
    box: [-0.42, 1.42, -0.3, 1.25],
    vs: 0.85,
    probe0: [0.72, 0],
    sampleRange: [-2, 2],
    pose(t) {
      const a0 = 14 * Math.PI / 180, a1 = 76 * Math.PI / 180;
      const xm = L * (Math.cos(a0) + Math.cos(a1)) / 2, xa = L * (Math.cos(a0) - Math.cos(a1)) / 2;
      const u = TAU * t / this.T, sk = Math.asin(K);
      const xA = xm + xa * Math.asin(K * Math.sin(u)) / sk;
      const dxA = xa * (TAU / this.T) * K * Math.cos(u) / (Math.sqrt(1 - K * K * Math.sin(u) ** 2) * sk);
      const al = Math.acos(clamp(xA / L, -1, 1));
      const w = dxA / (L * Math.sin(al));     // θ = π − α, ω = θ̇ = −α̇
      return { main: { o: [xA, 0], theta: Math.PI - al, v: [dxA, 0], w }, al };
    },
    inside: (b, p) => { const q = toBody(b, p); return q[0] >= -0.02 && q[0] <= L + 0.02 && Math.abs(q[1]) < 0.03; },
  },
  kurbel: {
    label: 'Schubkurbel',
    T: TAU / 1.1, hold: 0,
    box: [-1.45, 4.25, -1.75, 2.05],
    vs: 0.5,
    probe0: null,
    sampleRange: [0, TAU / 1.1],
    lr: 2.6,
    pose(t) {
      const r = 1, l = this.lr * r, om = 1.1;
      const ph = om * t;
      const B = [r * Math.cos(ph), r * Math.sin(ph)];
      const sb = (r / l) * Math.sin(ph), cb = Math.sqrt(1 - sb * sb);
      const xA = r * Math.cos(ph) + l * cb;
      const vA = -om * r * Math.sin(ph + Math.asin(sb)) / cb;      // Skript: v_A = −ωr sin(φ+β)/cos β
      const vB = [-om * r * Math.sin(ph), om * r * Math.cos(ph)];
      const AB = [B[0] - xA, B[1]];
      const w3 = (AB[0] * (vB[1] - 0) - AB[1] * (vB[0] - vA)) / (AB[0] ** 2 + AB[1] ** 2);
      const rod = { o: [xA, 0], theta: Math.atan2(AB[1], AB[0]), v: [vA, 0], w: w3 };
      const crank = { o: [0, 0], theta: ph, v: [0, 0], w: om };
      return { main: rod, crank, ph, B, vA, vB, r, l, om };
    },
    inside: (b, p) => { const q = toBody(b, p); const l = SCENES.kurbel.lr; return q[0] >= -0.03 && q[0] <= l + 0.03 && Math.abs(q[1]) < 0.04; },
  },
};

/* sample Z over a monotone pass → fixed / moving polbahn, plus equal-arc ticks */
function samplePolbahn(sc) {
  const [t0, t1] = sc.sampleRange, N = 900;
  const pts = [];
  for (let i = 0; i <= N; i++) {
    const t = t0 + (t1 - t0) * i / N;
    const b = sc.pose(t).main, Z = centre(b);
    if (!Z || Math.hypot(Z[0], Z[1]) > 40) { pts.push(null); continue; }
    pts.push({ t, Zw: Z, Zb: toBody(b, Z) });
  }
  // ticks at equal arc length on the fixed curve (rolling ⇒ equal on the moving one)
  const ticks = []; const ds = sc === SCENES.rad ? 0.5 : sc === SCENES.stab ? 0.075 : 0.3;
  let acc = 0, prev = null, next = ds * 0.5;
  for (const p of pts) {
    if (!p) { prev = null; continue; }
    if (prev) {
      const d = Math.hypot(p.Zw[0] - prev.Zw[0], p.Zw[1] - prev.Zw[1]);
      if (d > 0.5) { prev = p; continue; }
      acc += d;
      while (acc >= next) { ticks.push(p); next += ds; }
    }
    prev = p;
  }
  return { pts, ticks };
}

/* ---------- drawing ---------- */
function drawScene(ctx, W, H, S, opt = {}) {
  const sc = SCENES[S.scene];
  const P = sc.pose(S.t);
  const b = P.main;
  const view = new View().fit(...sc.box, 0, 0, W, H, opt.pad ?? 26);
  const X = (p) => view.P(p);
  const s = view.s;
  const Z = centre(b);
  const lay = S.layers;
  const vs = sc.vs * s;
  const thin = opt.thumb ? 0.75 : 1;

  // grid
  ctx.save();
  const g = 0.25 * (S.scene === 'stab' ? 1 : 2);
  ctx.strokeStyle = C.grid; ctx.lineWidth = 1; ctx.beginPath();
  const [wx0, wy1] = view.inv(0, 0), [wx1, wy0] = view.inv(W, H);
  for (let x = Math.ceil(wx0 / g) * g; x <= wx1; x += g) { ctx.moveTo(view.X(x), 0); ctx.lineTo(view.X(x), H); }
  for (let y = Math.ceil(wy0 / g) * g; y <= wy1; y += g) { ctx.moveTo(0, view.Y(y)); ctx.lineTo(W, view.Y(y)); }
  ctx.stroke(); ctx.restore();

  // velocity field of the extended body + iso-speed circles
  if (lay.field && Z) {
    const sp = opt.thumb ? 26 : 44;
    // uniform scale so that the longest arrow in view fits the grid spacing
    let vmax = 0;
    for (const [cx, cy] of [[0, 0], [W, 0], [0, H], [W, H]]) vmax = Math.max(vmax, Math.hypot(...vel(b, view.inv(cx, cy))));
    const kf = (sp * 0.78) / Math.max(vmax, 1e-6);
    const Zp = X(Z);
    ctx.save(); ctx.setLineDash([2, 5]);
    for (let r = sp; r < Math.hypot(W, H); r += sp) circle(ctx, Zp[0], Zp[1], r, alpha(C.k, C.dark ? 0.16 : 0.13), 1);
    ctx.restore();
    for (let py = sp / 2; py < H; py += sp) for (let px = sp / 2; px < W; px += sp) {
      const w = view.inv(px, py), v = vel(b, w);
      const inside = sc.inside(b, w);
      arrow(ctx, px, py, px + v[0] * kf, py - v[1] * kf, inside ? C.v : alpha(C.v, C.dark ? 0.38 : 0.30), inside ? 1.6 : 1.1, 6);
    }
  }

  // polbahnen
  const PB = S.pb;
  if (lay.polbahn && PB) {
    // fixed: world curve
    path(ctx, PB.pts.map((p) => (p ? X(p.Zw) : null)), C.k, 2.2 * thin);
    // moving: body curve carried with the body
    path(ctx, PB.pts.map((p) => (p ? X(toWorld(b, p.Zb)) : null)), C.k, 1.6 * thin, [6, 5]);
    if (S.scene === 'stab') {      // ganzer Thaleskreis (Skript) und ganzer Viertelkreis
      const M = toWorld(b, [L / 2, 0]), Mp = X(M);
      circle(ctx, Mp[0], Mp[1], s * L / 2, alpha(C.k, 0.35), 1, null, [2, 4]);
      ctx.save(); ctx.strokeStyle = alpha(C.k, 0.35); ctx.setLineDash([2, 4]); ctx.beginPath();
      ctx.arc(view.X(0), view.Y(0), s * L, -Math.PI / 2, 0); ctx.stroke(); ctx.restore();
    }
    if (!opt.thumb) for (const tk of PB.ticks) {
      // tick on fixed curve (normal to curve, outward) and on moving curve
      const a = X(tk.Zw), m = X(toWorld(b, tk.Zb));
      const ctr = X(b.o);
      ctx.save(); ctx.fillStyle = C.k;
      ctx.beginPath(); ctx.arc(a[0], a[1], 2.6, 0, TAU); ctx.fill();
      ctx.beginPath(); ctx.arc(m[0], m[1], 2.6, 0, TAU); ctx.fillStyle = C.surface; ctx.fill(); ctx.strokeStyle = C.k; ctx.lineWidth = 1.3; ctx.stroke();
      ctx.restore();
      void ctr;
    }
  }

  // probe trajectory
  const probe = S.probe;
  if (lay.bahn && probe) {
    const pts = [];
    let [t0, t1] = S.scene === 'rad' ? [0, clamp(S.t, 0, sc.T)] : [0, sc.T];
    const n = 500;
    for (let i = 0; i <= n; i++) { const t = t0 + (t1 - t0) * i / n; pts.push(X(toWorld(sc.pose(t).main, probe))); }
    path(ctx, pts, alpha(C.ink, 0.55), 1.4 * thin);
  }

  // ----- scene specific geometry -----
  if (S.scene === 'rad') {
    const gy = view.Y(0);
    hatch(ctx, 0, gy, W, gy, C.muted, -1, 10, 8);
    const c = X(b.o), r = s * R;
    ctx.save();
    ctx.beginPath(); ctx.arc(c[0], c[1], r, 0, TAU); ctx.fillStyle = alpha(C.ink, C.dark ? 0.08 : 0.045); ctx.fill();
    ctx.lineWidth = Math.max(3, r * 0.07); ctx.strokeStyle = C.ink; ctx.stroke();
    ctx.lineWidth = 1.2; ctx.strokeStyle = alpha(C.ink, 0.7);
    for (let k = 0; k < 6; k++) {
      const a = toWorld(b, rot(k * TAU / 6, [R * 0.92, 0]));
      const p = X(a); ctx.beginPath(); ctx.moveTo(c[0], c[1]); ctx.lineTo(p[0], p[1]); ctx.stroke();
    }
    ctx.restore();
    circle(ctx, c[0], c[1], r * 0.12, C.ink, 1.5, C.surface);
    dot(ctx, c[0], c[1], 2.2, C.ink);
    if (!opt.thumb) mlabel(ctx, 'O', c[0] + 9, c[1] - 12, C.ink, { size: 15 });

    if (lay.verteilung && Z) {
      // velocities along the vertical diameter through Z: linear in the distance
      const top = [Z[0], 2 * R];
      const tips = [];
      for (let k = 1; k <= 4; k++) {
        const p = [Z[0], (k / 4) * 2 * R], v = vel(b, p), pp = X(p);
        arrow(ctx, pp[0], pp[1], pp[0] + v[0] * vs, pp[1] - v[1] * vs, C.v, 2, 10);
        tips.push([pp[0] + v[0] * vs, pp[1] - v[1] * vs]);
      }
      const zp = X(Z), tp = X(top);
      line(ctx, zp[0], zp[1], tips[3][0], tips[3][1], alpha(C.v, 0.75), 1.2, [4, 4]);
      line(ctx, zp[0], zp[1], tp[0], tp[1], alpha(C.ink, 0.4), 1, [2, 3]);
      if (!opt.thumb) {
        mlabel(ctx, '2v', tips[3][0] + 8, tips[3][1], C.v, { size: 15 });
        mlabel(ctx, 'v', tips[1][0] + 8, tips[1][1], C.v, { size: 15 });
      }
    }
  }

  if (S.scene === 'stab') {
    const O = X([0, 0]);
    const wallTop = view.Y(1.18), floorEnd = view.X(1.36);
    hatch(ctx, O[0], wallTop, O[0], O[1], C.muted, -1, 10, 8);
    hatch(ctx, O[0], O[1], floorEnd, O[1], C.muted, -1, 10, 8);
    const A = b.o, B = toWorld(b, [L, 0]);
    const Ap = X(A), Bp = X(B);
    if (lay.konstruktion && Z) {
      const Zp = X(Z);
      // rectangle O A Z B and the two perpendiculars
      line(ctx, Ap[0], Ap[1], Ap[0], view.Y(1.2), alpha(C.k, 0.9), 1.1, [5, 4]);
      line(ctx, Bp[0], Bp[1], view.X(1.38), Bp[1], alpha(C.k, 0.9), 1.1, [5, 4]);
      rightAngle(ctx, Ap[0], Ap[1], 1, 0, 0, -1, 9, C.k);
      rightAngle(ctx, Bp[0], Bp[1], 0, -1, 1, 0, 9, C.k);
      void Zp;
    }
    // sliders (Führungen)
    ctx.save(); ctx.fillStyle = C.surface; ctx.strokeStyle = C.ink; ctx.lineWidth = 1.4;
    const bw = s * 0.09, bh = s * 0.05;
    ctx.beginPath(); ctx.rect(Ap[0] - bw / 2, Ap[1] - bh, bw, bh); ctx.fill(); ctx.stroke();
    ctx.beginPath(); ctx.rect(Bp[0], Bp[1] - bw / 2, bh, bw); ctx.fill(); ctx.stroke();
    ctx.restore();
    // bar
    ctx.save(); ctx.lineCap = 'round'; ctx.strokeStyle = C.ink; ctx.lineWidth = Math.max(4, s * 0.028);
    ctx.beginPath(); ctx.moveTo(Ap[0], Ap[1]); ctx.lineTo(Bp[0], Bp[1]); ctx.stroke(); ctx.restore();
    ring(ctx, Ap[0], Ap[1], 4, C.ink, 1.6); ring(ctx, Bp[0], Bp[1], 4, C.ink, 1.6);
    if (!opt.thumb) {
      mlabel(ctx, 'A', Ap[0] + 10, Ap[1] + 14, C.ink, { size: 15 });
      mlabel(ctx, 'B', Bp[0] - 22, Bp[1] - 2, C.ink, { size: 15 });
      mlabel(ctx, 'O', O[0] - 18, O[1] + 14, C.ink, { size: 15 });
      // angle α at A
      const al = P.al;
      ctx.save(); ctx.strokeStyle = C.muted; ctx.lineWidth = 1; ctx.beginPath(); ctx.arc(Ap[0], Ap[1], 30, Math.PI, Math.PI + al, false); ctx.stroke(); ctx.restore();
      mlabel(ctx, 'α', Ap[0] - 44 * Math.cos(al / 2), Ap[1] - 44 * Math.sin(al / 2), C.muted, { size: 15, align: 'center' });
    }
    // end velocities
    if (lay.ends) {
      const vA = vel(b, A), vB = vel(b, B);
      arrow(ctx, Ap[0], Ap[1], Ap[0] + vA[0] * vs, Ap[1] - vA[1] * vs, C.v, 2.4, 11);
      arrow(ctx, Bp[0], Bp[1], Bp[0] + vB[0] * vs, Bp[1] - vB[1] * vs, C.v, 2.4, 11);
      if (!opt.thumb) {
        mlabel(ctx, '**v**_A', Ap[0] + vA[0] * vs + (vA[0] > 0 ? 8 : -36), Ap[1] - 14, C.v, { size: 15 });
        mlabel(ctx, '**v**_B', Bp[0] + 10, Bp[1] - vB[1] * vs + (vB[1] < 0 ? 10 : -10), C.v, { size: 15 });
      }
    }
  }

  if (S.scene === 'kurbel') {
    const { B, r, l, ph } = P;
    const O = X([0, 0]), Bp = X(B), A = b.o, Ap = X(A);
    // guide of the piston
    const gy = view.Y(0);
    const ph2 = s * 0.2;
    const g0 = view.X(l - r - 0.3), g1 = view.X(l + r + 0.6);
    hatch(ctx, g0, gy - ph2 / 2 - 2, g1, gy - ph2 / 2 - 2, alpha(C.muted, 0.8), 1, 7, 7);
    hatch(ctx, g1, gy + ph2 / 2 + 2, g0, gy + ph2 / 2 + 2, alpha(C.muted, 0.8), 1, 7, 7);
    // crank circle
    circle(ctx, O[0], O[1], s * r, alpha(C.ink, 0.22), 1, null, [3, 4]);
    // piston
    ctx.save(); ctx.fillStyle = alpha(C.ink, C.dark ? 0.16 : 0.08); ctx.strokeStyle = C.ink; ctx.lineWidth = 1.6;
    const pw = s * 0.42;
    ctx.beginPath(); ctx.roundRect(Ap[0] - pw * 0.25, gy - ph2 / 2, pw, ph2, 3); ctx.fill(); ctx.stroke(); ctx.restore();
    // crank
    ctx.save(); ctx.lineCap = 'round'; ctx.strokeStyle = C.ink;
    ctx.lineWidth = Math.max(5, s * 0.07); ctx.beginPath(); ctx.moveTo(O[0], O[1]); ctx.lineTo(Bp[0], Bp[1]); ctx.stroke();
    // rod
    ctx.lineWidth = Math.max(4, s * 0.05); ctx.globalAlpha = 0.92; ctx.beginPath(); ctx.moveTo(Bp[0], Bp[1]); ctx.lineTo(Ap[0], Ap[1]); ctx.stroke(); ctx.restore();
    ring(ctx, O[0], O[1], 5, C.ink, 1.8); ring(ctx, Bp[0], Bp[1], 4, C.ink, 1.6); ring(ctx, Ap[0], Ap[1], 4, C.ink, 1.6);
    // fixed bearing O
    ctx.save(); ctx.strokeStyle = C.ink; ctx.lineWidth = 1.4; ctx.beginPath();
    ctx.moveTo(O[0], O[1]); ctx.lineTo(O[0] - 11, O[1] + 16); ctx.lineTo(O[0] + 11, O[1] + 16); ctx.closePath(); ctx.stroke(); ctx.restore();
    hatch(ctx, O[0] - 16, O[1] + 16, O[0] + 16, O[1] + 16, C.muted, -1, 7, 6);
    if (!opt.thumb) {
      mlabel(ctx, 'O', O[0] - 22, O[1] - 10, C.ink, { size: 15 });
      mlabel(ctx, 'B', Bp[0] + (B[0] > 0 ? 8 : -20), Bp[1] - 14, C.ink, { size: 15 });
      mlabel(ctx, 'A', Ap[0] - 4, gy + ph2 / 2 + 20, C.ink, { size: 15 });
      mlabel(ctx, '1', (O[0] + Bp[0]) / 2 - 14, (O[1] + Bp[1]) / 2 - 4, C.muted, { size: 13, upright: true });
      mlabel(ctx, '3', (Ap[0] + Bp[0]) / 2, (Ap[1] + Bp[1]) / 2 - 14, C.muted, { size: 13, upright: true });
      mlabel(ctx, '2', Ap[0] + pw * 0.45, gy - ph2 / 2 - 14, C.muted, { size: 13, upright: true });
    }
    if (lay.konstruktion && Z) {
      // Z3 = line OB ∩ perpendicular to the piston path through A
      const far = 60;
      const d = [Math.cos(ph), Math.sin(ph)];
      const p0 = X([-d[0] * far, -d[1] * far]), p1 = X([d[0] * far, d[1] * far]);
      line(ctx, p0[0], p0[1], p1[0], p1[1], alpha(C.k, 0.75), 1.1, [5, 4]);
      line(ctx, Ap[0], 0, Ap[0], H, alpha(C.k, 0.75), 1.1, [5, 4]);
    }
    if (lay.ends) {
      const vB = vel(P.crank, B), vA = [P.vA, 0];
      arrow(ctx, Bp[0], Bp[1], Bp[0] + vB[0] * vs, Bp[1] - vB[1] * vs, C.v, 2.4, 11);
      arrow(ctx, Ap[0], Ap[1], Ap[0] + vA[0] * vs, Ap[1], C.v, 2.4, 11);
      if (!opt.thumb) {
        mlabel(ctx, '**v**_B', Bp[0] + vB[0] * vs + 6, Bp[1] - vB[1] * vs - 12, C.v, { size: 15 });
        mlabel(ctx, '**v**_A', Ap[0] + vA[0] * vs + (vA[0] >= 0 ? 8 : -40), Ap[1] - 16, C.v, { size: 15 });
      }
    }
    if (!opt.thumb) drawVaPlot(ctx, W, H, P);
  }

  // ----- probe point M -----
  if (probe && lay.probe) {
    const M = toWorld(b, probe), Mp = X(M), v = vel(b, M);
    if (Z) {
      const Zp = X(Z);
      line(ctx, Zp[0], Zp[1], Mp[0], Mp[1], alpha(C.k, 0.95), 1.3, [5, 4]);
      const dz = [Mp[0] - Zp[0], Mp[1] - Zp[1]], dl = Math.hypot(...dz);
      const vl = Math.hypot(v[0], v[1]);
      if (dl > 20 && vl * vs > 16) rightAngle(ctx, Mp[0], Mp[1], -dz[0] / dl, -dz[1] / dl, v[0] / vl, -v[1] / vl, 9, C.k);
    }
    if (lay.zerlegung && S.scene === 'rad') {
      // v_M = v_O + ω × OM, drawn head to tail, labels pushed off the arrows along their normals
      const vO = b.v, vr = [v[0] - vO[0], v[1] - vO[1]];
      const a1 = [Mp[0] + vO[0] * vs, Mp[1] - vO[1] * vs], a2 = [a1[0] + vr[0] * vs, a1[1] - vr[1] * vs];
      arrow(ctx, Mp[0], Mp[1], a1[0], a1[1], C.muted, 1.6, 9);
      arrow(ctx, a1[0], a1[1], a2[0], a2[1], C.m, 1.6, 9);
      const off = (p, q, d) => { const dx = q[0] - p[0], dy = q[1] - p[1], L = Math.hypot(dx, dy) || 1; return [(p[0] + q[0]) / 2 + (dy / L) * d, (p[1] + q[1]) / 2 - (dx / L) * d]; };
      const l1 = off(Mp, a1, 16), l2 = off(a1, a2, -18);
      if (Math.hypot(a1[0] - Mp[0], a1[1] - Mp[1]) > 18) mlabel(ctx, '**v**_O', l1[0], l1[1], C.muted, { size: 14, align: 'center' });
      if (Math.hypot(a2[0] - a1[0], a2[1] - a1[1]) > 18) text(ctx, 'ω × OM', l2[0], l2[1], C.m, { size: 14, font: 'serif', align: 'center', halo: true });
    }
    arrow(ctx, Mp[0], Mp[1], Mp[0] + v[0] * vs, Mp[1] - v[1] * vs, C.v, 2.8, 12);
    ring(ctx, Mp[0], Mp[1], opt.thumb ? 3.5 : 6.5, C.ink, 2);
    dot(ctx, Mp[0], Mp[1], 2, C.ink, 'transparent');
    if (!opt.thumb) {
      mlabel(ctx, 'M', Mp[0] - 22, Mp[1] + 14, C.ink, { size: 15 });
      const vl = Math.hypot(v[0], v[1]) || 1;
      if (vl * vs > 14) mlabel(ctx, '**v**_M', Mp[0] + v[0] * vs + (v[0] / vl) * 14, Mp[1] - v[1] * vs - (v[1] / vl) * 14 - 2, C.v, { size: 15, align: 'center' });
    }
  }

  // ----- instantaneous centre Z -----
  if (Z) {
    const Zp = X(Z);
    const inView = Zp[0] > 8 && Zp[0] < W - 8 && Zp[1] > 8 && Zp[1] < H - 8;
    if (inView) {
      ctx.save(); ctx.beginPath(); ctx.arc(Zp[0], Zp[1], opt.thumb ? 5 : 8, 0, TAU); ctx.fillStyle = alpha(C.k, 0.18); ctx.fill(); ctx.restore();
      dot(ctx, Zp[0], Zp[1], opt.thumb ? 3 : 4.6, C.k);
      if (!opt.thumb) mlabel(ctx, S.scene === 'kurbel' ? 'Z_3' : 'Z', Zp[0] + 11, Zp[1] + 15, C.k, { size: 16 });
    } else if (!opt.thumb) edgeMarker(ctx, W, H, X(b.o), Zp, S.scene === 'kurbel' ? 'Z₃' : 'Z');
  } else if (!opt.thumb) {
    text(ctx, 'ω = 0: momentane Translation, Z im Unendlichen', W / 2, 22, C.k, { size: 13, align: 'center', halo: true, weight: 500 });
  }
}

function edgeMarker(ctx, W, H, from, to, lab) {
  const dx = to[0] - from[0], dy = to[1] - from[1];
  const m = 22;
  let t = Infinity;
  if (dx > 0) t = Math.min(t, (W - m - from[0]) / dx); if (dx < 0) t = Math.min(t, (m - from[0]) / dx);
  if (dy > 0) t = Math.min(t, (H - m - from[1]) / dy); if (dy < 0) t = Math.min(t, (m - from[1]) / dy);
  if (!isFinite(t) || t < 0) return;
  const x = from[0] + dx * t, y = from[1] + dy * t, L = Math.hypot(dx, dy);
  arrow(ctx, x - dx / L * 18, y - dy / L * 18, x, y, C.k, 2, 9);
  text(ctx, `${lab} außerhalb`, x - dx / L * 26, y - dy / L * 26 + (dy > 0 ? -12 : 12), C.k, { size: 12, align: 'center', halo: true, weight: 500 });
}

function drawVaPlot(ctx, W, H, P) {
  const w = Math.min(250, W * 0.34), h = 104, x0 = W - w - 16, y0 = H - h - 16;
  ctx.save();
  ctx.fillStyle = alpha(C.surface, 0.94); ctx.strokeStyle = C.hair; ctx.lineWidth = 1;
  ctx.beginPath(); ctx.roundRect(x0, y0, w, h, 8); ctx.fill(); ctx.stroke();
  const px = x0 + 30, pw = w - 42, py = y0 + 20, ph = h - 38, my = py + ph / 2;
  const vmax = P.om * P.r * 1.45;
  line(ctx, px, my, px + pw, my, C.hair, 1);
  const pts = [], ref = [];
  const sc = SCENES.kurbel;
  for (let i = 0; i <= 160; i++) {
    const t = (sc.T * i) / 160, Q = sc.pose(t);
    const xx = px + (pw * i) / 160;
    pts.push([xx, my - (Q.vA / vmax) * ph / 2]);
    ref.push([xx, my + (P.om * P.r * Math.sin(Q.ph) / vmax) * ph / 2]);
  }
  path(ctx, ref, alpha(C.muted, 0.8), 1, [3, 3]);
  path(ctx, pts, C.v, 1.8);
  const ph0 = ((P.ph % TAU) + TAU) % TAU;
  const mx = px + pw * ph0 / TAU, myy = my - (P.vA / vmax) * ph / 2;
  line(ctx, mx, py - 4, mx, py + ph + 4, alpha(C.ink, 0.3), 1);
  dot(ctx, mx, myy, 3.2, C.v);
  mlabel(ctx, 'v_A', x0 + 8, py + 2, C.v, { size: 13, halo: false });
  text(ctx, '0', px - 4, py + ph + 12, C.muted, { size: 10.5, align: 'center', font: 'mono' });
  text(ctx, '2π', px + pw, py + ph + 12, C.muted, { size: 10.5, align: 'center', font: 'mono' });
  mlabel(ctx, 'φ', px + pw / 2, py + ph + 12, C.muted, { size: 12, align: 'center', halo: false });
  text(ctx, '−ωr sin φ', px + pw - 2, py + 4, C.muted, { size: 10, align: 'right', font: 'mono' });
  ctx.restore();
}

/* ---------- thumbnail ---------- */
export function thumb(ctx, W, H) {
  ctx.fillStyle = C.surface; ctx.fillRect(0, 0, W, H);
  const S = { scene: 'stab', t: 0.9, layers: { field: false, polbahn: true, bahn: false, probe: true, konstruktion: true, ends: true }, probe: [0.72, 0] };
  S.pb = samplePolbahn(SCENES.stab);
  drawScene(ctx, W, H, S, { thumb: true, pad: 10 });
}

/* ---------- mount ---------- */
const STEPS = [
  { title: 'Ein Punkt steht still', scene: 'rad', layers: { field: false, polbahn: false, bahn: true, probe: true, verteilung: false, zerlegung: true, konstruktion: true, ends: true },
    html: '<p>Das Rad rollt ohne zu gleiten. Der Radpunkt, der gerade den Boden berührt, hat in diesem Augenblick die Geschwindigkeit null. Die Zerlegung am Punkt $M$ zeigt, warum: Die Translation der Nabe $\\boldsymbol v_O$ und der Drehanteil $\\boldsymbol\\omega\\times\\overrightarrow{OM}$ heben sich unten genau auf.</p><p>Verfolge $M$: Er durchläuft eine Zykloide und kommt am Boden für einen Augenblick zum Stehen.</p>' },
  { title: 'Die Geschwindigkeit wächst linear mit dem Abstand', scene: 'rad', layers: { field: false, polbahn: false, bahn: true, probe: true, verteilung: true, zerlegung: false, konstruktion: true, ends: true },
    html: '<p>Momentan dreht sich das ganze Rad um den Berührpunkt $Z$. Deshalb gilt für jeden Punkt</p>$$\\boldsymbol v_M\\perp\\overrightarrow{ZM},\\qquad |\\boldsymbol v_M| = \\omega\\,\\overline{ZM}.$$<p>Auf dem senkrechten Durchmesser liegen die Pfeilspitzen auf einer Geraden durch $Z$: oben $2v$, in der Nabe $v$, unten $0$. Ziehe $M$ an eine andere Stelle; der rechte Winkel bleibt.</p>' },
  { title: 'Das ganze Feld dreht sich um Z', scene: 'rad', layers: { field: true, polbahn: false, bahn: false, probe: true, verteilung: false, zerlegung: false, konstruktion: true, ends: true },
    html: '<p>Denkt man sich den Körper auf die ganze Ebene ausgedehnt, sieht das Geschwindigkeitsfeld aus wie das einer reinen Drehung um $Z$. Auf jedem Kreis um $Z$ ist der Betrag gleich.</p><p>Das Feld gilt aber nur für diesen einen Augenblick. Lass die Animation laufen: Das Zentrum des Wirbels wandert mit dem Rad mit.</p>' },
  { title: 'Z aus zwei Richtungen konstruieren', scene: 'stab', layers: { field: false, polbahn: false, bahn: false, probe: true, verteilung: false, zerlegung: false, konstruktion: true, ends: true },
    html: '<p>Die Stabenden laufen an Boden und Wand. Die Richtungen von $\\boldsymbol v_A$ und $\\boldsymbol v_B$ sind also bekannt. $Z$ liegt auf beiden Senkrechten, also in der vierten Ecke des Rechtecks über $A$ und $B$.</p>$$\\omega = \\frac{v_A}{L\\sin\\alpha},\\qquad v_B = v_A\\cot\\alpha .$$<p>Bei flachem Stab wird $v_B$ sehr groß: Achte auf den Pfeil an $B$, wenn $\\alpha$ klein wird.</p>' },
  { title: 'Polbahnen: ein Kreis rollt in einem Kreis', scene: 'stab', layers: { field: false, polbahn: true, bahn: true, probe: true, verteilung: false, zerlegung: false, konstruktion: true, ends: false },
    html: '<p>$Z$ wandert. Im ruhenden Bezugssystem liegt es immer im Abstand $L$ von der Ecke $O$: Das ist die <b>feste Polbahn</b>, ein Viertelkreis. Vom Stab aus gesehen liegt $Z$ auf dem Thaleskreis über $AB$: die <b>bewegliche Polbahn</b> mit Radius $L/2$ (gestrichelt, sie bewegt sich mit dem Stab).</p><p>Die Marken auf beiden Kurven haben gleiche Bogenabstände. Sie treffen sich genau im Berührpunkt: Der Thaleskreis rollt im Viertelkreis ab, ohne zu gleiten.</p>' },
  { title: 'Mehrere Körper, mehrere Zentren', scene: 'kurbel', layers: { field: false, polbahn: false, bahn: true, probe: true, verteilung: false, zerlegung: false, konstruktion: true, ends: true },
    html: '<p>Jeder starre Körper hat sein eigenes Momentanzentrum. Die Kurbel 1 dreht um das Lager $O$, der Kolben 2 verschiebt sich (sein Zentrum liegt im Unendlichen). Für die Pleuelstange 3 liegt $Z_3$ auf der Verlängerung von $OB$ und auf der Senkrechten zur Kolbenbahn durch $A$.</p><p>Bei $\\varphi = 90^\\circ$ sind beide Linien parallel: Die Stange verschiebt sich dann momentan nur, und $Z_3$ läuft ins Unendliche. Unten rechts siehst du $v_A(\\varphi)$ und gestrichelt die Näherung $-\\omega r\\sin\\varphi$ für $l \\gg r$.</p>' },
];

export function mount(root) {
  const L0 = layout(root, meta);
  const S = { scene: 'rad', t: 0, layers: { ...STEPS[0].layers }, probe: null, pb: null };
  const setProbe = () => {
    const sc = SCENES[S.scene];
    if (sc.probe0) S.probe = sc.probe0.slice();
    else S.probe = [sc.lr / 2, 0];
  };
  setProbe(); S.pb = samplePolbahn(SCENES[S.scene]);

  let drag = null;
  const stage = new Stage(L0.stage, {
    draw: (ctx, W, H) => drawScene(ctx, W, H, S),
    pointer: {
      down(x, y) {
        const sc = SCENES[S.scene], b = sc.pose(S.t).main;
        const view = new View().fit(...sc.box, 0, 0, stage.w, stage.h, 26);
        if (S.probe) {
          const Mp = view.P(toWorld(b, S.probe));
          if (Math.hypot(Mp[0] - x, Mp[1] - y) < 26) return { kind: 'probe', view };
        }
        return { kind: 'pose', view, x0: x, t0: S.t };
      },
      drag(h, x, y) {
        const sc = SCENES[S.scene];
        if (h.kind === 'probe') {
          const w = h.view.inv(x, y);
          S.probe = toBody(sc.pose(S.t).main, w);
        } else {
          runner.pause();
          if (S.scene === 'rad') S.t = clamp(h.t0 + (x - h.x0) / (h.view.s * R), 0, sc.T);
          else if (S.scene === 'stab') {
            // drag A along the floor → find the α-phase with that x_A (monotone half-cycle)
            const xA = clamp(h.view.inv(x, y)[0], Math.cos(76 * Math.PI / 180) + 1e-3, Math.cos(14 * Math.PI / 180) - 1e-3);
            let lo = -sc.T / 4, hi = sc.T / 4;
            for (let i = 0; i < 40; i++) { const m = (lo + hi) / 2; if (sc.pose(m).main.o[0] < xA) lo = m; else hi = m; }
            S.t = (lo + hi) / 2;
          } else {
            const w = h.view.inv(x, y); let ph = Math.atan2(w[1], w[0]); if (ph < 0) ph += TAU;
            S.t = ph / 1.1;
          }
          syncScrub();
        }
      },
      hover(x, y) {
        const sc = SCENES[S.scene], b = sc.pose(S.t).main;
        const view = new View().fit(...sc.box, 0, 0, stage.w, stage.h, 26);
        const Mp = view.P(toWorld(b, S.probe));
        return Math.hypot(Mp[0] - x, Mp[1] - y) < 26 ? 'grab' : 'ew-resize';
      },
    },
  });
  const hint = el('div', { class: 'hint', html: 'Punkt <i>M</i> ziehen · Körper ziehen, um die Lage zu ändern' });
  L0.stage.append(hint);

  const periodOf = () => { const sc = SCENES[S.scene]; return sc.T + (sc.hold || 0); };
  let tLoop = 0;
  const runner = new Runner({
    stages: [stage],
    update(dt) {
      const sc = SCENES[S.scene];
      tLoop += dt;
      if (S.scene === 'rad') {
        if (tLoop > periodOf()) tLoop = 0;
        S.t = Math.min(tLoop, sc.T);
      } else { S.t = (S.t + dt) % sc.T; }
      syncScrub(); updateReadout();
    },
    onTick: () => updateReadout(),
  });

  const scrub = el('input', { type: 'range', min: 0, max: 1000, step: 1, value: 0, 'aria-label': 'Zeitpunkt' });
  const tlabel = el('span', { class: 'tlabel' });
  const syncScrub = () => {
    const sc = SCENES[S.scene];
    const t = ((S.t % sc.T) + sc.T) % sc.T;
    const f = S.scene === 'rad' ? S.t / sc.T : t / sc.T;
    scrub.value = Math.round(f * 1000);
    scrub.style.setProperty('--p', f * 100 + '%');
    tlabel.textContent = S.scene === 'kurbel' ? `φ = ${Math.round(((SCENES.kurbel.pose(S.t).ph * 180 / Math.PI) % 360 + 360) % 360)}°`
      : S.scene === 'stab' ? `α = ${(sc.pose(S.t).al * 180 / Math.PI).toFixed(1)}°` : `t = ${S.t.toFixed(2)} s`;
  };
  scrub.addEventListener('input', () => {
    runner.pause();
    const sc = SCENES[S.scene]; S.t = (scrub.value / 1000) * sc.T; tLoop = S.t; syncScrub(); stage.invalidate();
  });
  L0.tslot.append(transport(runner, {
    onRestart: () => { S.t = S.scene === 'stab' ? -SCENES.stab.T / 4 + SCENES.stab.T : 0; tLoop = 0; if (S.scene === 'stab') S.t = 0; syncScrub(); stage.invalidate(); runner.play(); },
    scrub, label: tlabel,
  }));

  // scene switcher
  const sceneSeg = seg(Object.entries(SCENES).map(([k, v]) => [k, v.label]), S.scene, (k) => setScene(k), 'scenes');
  L0.scenes.append(sceneSeg);

  // panel
  const q = el('p', { class: 'question', html: 'Ein Körper bewegt sich in der Ebene. In jedem Augenblick gibt es genau einen Punkt $Z$, der ruht. <b>Wo liegt er, und wie hilft er, die Geschwindigkeit jedes anderen Punktes zu finden?</b>' });
  const steps = stepper(STEPS, (st) => {
    if (st.scene !== S.scene) setScene(st.scene, false);
    Object.assign(S.layers, st.layers); syncChips(); stage.invalidate();
  });

  const chips = {
    field: chip('Geschwindigkeitsfeld', S.layers.field, C.v, (v) => { S.layers.field = v; stage.invalidate(); }),
    polbahn: chip('Polbahnen', S.layers.polbahn, C.k, (v) => { S.layers.polbahn = v; stage.invalidate(); }),
    bahn: chip('Bahn von <i>M</i>', S.layers.bahn, C.ink, (v) => { S.layers.bahn = v; stage.invalidate(); }),
    konstruktion: chip('Konstruktion', S.layers.konstruktion, C.k, (v) => { S.layers.konstruktion = v; stage.invalidate(); }),
    verteilung: chip('Verteilung', S.layers.verteilung, C.v, (v) => { S.layers.verteilung = v; stage.invalidate(); }),
    zerlegung: chip('Zerlegung', S.layers.zerlegung, C.m, (v) => { S.layers.zerlegung = v; stage.invalidate(); }),
  };
  const syncChips = () => {
    for (const [k, c] of Object.entries(chips)) c.set(!!S.layers[k]);
    chips.verteilung.hidden = S.scene !== 'rad'; chips.zerlegung.hidden = S.scene !== 'rad';
    chips.konstruktion.hidden = S.scene === 'rad';
    lrCtrl.hidden = S.scene !== 'kurbel';
  };
  const lrCtrl = slider({ id: 'pb-lr', label: 'Pleuellänge <span class="var">l</span>/<span class="var">r</span>', min: 1.6, max: 4.5, step: 0.05, value: SCENES.kurbel.lr,
    format: (v) => v.toFixed(2), onInput: (v) => { SCENES.kurbel.lr = v; S.pb = samplePolbahn(SCENES.kurbel); S.probe = [v / 2, 0]; stage.invalidate(); } });

  const ro = readout([['w', 'Rotationsschnelligkeit <span class="var">ω</span>'], ['zm', 'Abstand <span class="var">ZM</span>'], ['vm', '<span class="var">|v<sub>M</sub>|</span>'], ['wz', '<span class="var">ω</span> · <span class="var">ZM</span>'], ['x', '']]);
  function updateReadout() {
    const sc = SCENES[S.scene], P = sc.pose(S.t), b = P.main, Z = centre(b);
    const M = toWorld(b, S.probe), v = vel(b, M);
    ro.set('w', `${fmt(b.w, 3)} s⁻¹`);
    if (Z) { const zm = Math.hypot(M[0] - Z[0], M[1] - Z[1]); ro.set('zm', fmt(zm, 3)); ro.set('wz', fmt(Math.abs(b.w) * zm, 3)); }
    else { ro.set('zm', '∞'); ro.set('wz', '—'); }
    ro.set('vm', fmt(Math.hypot(...v), 3));
    const dts = ro.querySelectorAll('dt'), last = dts[dts.length - 1];
    if (S.scene === 'rad') {
      const d = Math.hypot(...S.probe); const kind = Math.abs(d - R) < 0.04 ? 'gewöhnlich' : d < R ? 'verkürzt' : 'verlängert';
      last.innerHTML = 'Bahn von <span class="var">M</span>'; ro.set('x', `${kind}e Zykloide`);
    } else if (S.scene === 'stab') {
      last.innerHTML = '<span class="var">v<sub>B</sub></span> / <span class="var">v<sub>A</sub></span> = cot <span class="var">α</span>';
      ro.set('x', Math.abs(b.v[0]) > 1e-4 ? fmt(Math.abs(vel(b, toWorld(b, [L, 0]))[1] / b.v[0]), 3) + ' = ' + fmt(1 / Math.tan(P.al), 3) : '—');
    } else {
      last.innerHTML = 'Kolben <span class="var">v<sub>A</sub></span>'; ro.set('x', fmt(P.vA, 3));
    }
  }
  const box = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Erkunden' }), el('div', { class: 'toggles' }, ...Object.values(chips)), lrCtrl, ro);
  const formulas = el('div', { class: 'box' }, el('h3', { class: 'box-h', html: 'Formeln aus dem Skript' }), el('div', { class: 'formulas', html:
    '<p>Grundgleichung des Bewegungszustandes</p>$$\\boldsymbol v_M = \\boldsymbol v_B + \\boldsymbol\\omega\\times\\overrightarrow{BM}$$<p>Lage des Momentanzentrums</p>$$\\overrightarrow{BZ} = \\frac{\\boldsymbol\\omega\\times\\boldsymbol v_B}{\\omega^2},\\qquad \\overline{BZ} = \\frac{|\\boldsymbol v_B|}{\\omega}$$' }));
  const insight = el('div', { class: 'insight', html: '<b>Erkenntnis</b>Eine ebene Bewegung ist in jedem Augenblick eine Drehung um $Z$. Über die Zeit betrachtet ist sie das Abrollen der beweglichen Polbahn auf der festen.' });
  L0.panel.append(q, steps, box, formulas, insight, el('p', { class: 'src', html: 'Skript Mechanik 1, Abschnitte 3.2 (Rollen), 3.5 (Momentanzentrum, Polbahnen), Beispiel Schubkurbelgetriebe.' }));
  typeset(L0.panel);

  function setScene(k, resetStep = true) {
    S.scene = k; sceneSeg.set(k);
    setProbe(); S.pb = samplePolbahn(SCENES[k]);
    S.t = 0; tLoop = 0;
    if (k === 'stab') S.t = 1.2;
    if (k === 'kurbel') S.t = (35 * Math.PI / 180) / 1.1;
    if (resetStep) {
      const idx = STEPS.findIndex((s) => s.scene === k);
      if (idx >= 0 && STEPS[steps.index()].scene !== k) { steps.go(idx); return; }
    }
    syncChips(); syncScrub(); updateReadout(); stage.invalidate();
  }

  steps.go(0);
  setScene('rad', false);
  S.t = 1.25; tLoop = S.t; syncScrub();
  runner.play();
  return { destroy() { runner.destroy(); stage.destroy(); } };
}
