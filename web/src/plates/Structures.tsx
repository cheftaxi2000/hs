/** Chapters 9–14: supports, systems, trusses, friction, ropes, internal forces. */
import { useMemo } from 'react';
import { add, ease, intersect, lerp, mul, perp, rot, seg, sub, TAU, deg, type V2 } from '../lib/vec';
import { beamInternal, beamReactions, capstan, catenary, catenaryParam, incline, pratt, solveTruss, threeHinged } from '../phys/statics';
import { Plate } from '../ui/Plate';
import { ArcArrow, Arrow, Dot, Fig, Ground, Hinge, Line, PinSupport, Poly, RollerSupport, lab, toSvg, type Lab } from '../ui/svg';
import { num } from '../ui/Tex';

const W = 960, H = 560;
const t = String.raw;

/* ------------------------------------------------------------------ 9 supports: cut free, reactions */
export function Lager() {
  return (
    <Plate id="lagerkraefte" num="9.1" title="Freischneiden und Lagerkräfte" still={7} period={16}
      formula={t`\textstyle\sum F_x = 0,\qquad \sum F_y = 0,\qquad \sum M_A = 0`}
      note="Lager weg, Kräfte hin: Das Festlager nimmt zwei Komponenten auf, das Loslager eine.">
      {(time) => <LagerFig time={time} />}
    </Plate>
  );
}
function LagerFig({ time }: { time: number }) {
  const L = 6.2, X = toSvg({ ox: 140, oy: 300, s: 110 });
  const cut = ease(seg(time, 1.0, 2.4));
  const u = 0.5 - 0.5 * Math.cos((TAU * Math.max(0, time - 2.4)) / 13.6);
  const a = 0.7 + (L - 1.4) * u;
  const beta = deg(-90) + deg(32) * Math.sin((TAU * Math.max(0, time - 2.4)) / 6.8);
  const F = 1;
  const { Ax, Ay, B } = beamReactions(L, a, F, beta);
  const kf = 1.45;
  const Fv: V2 = [Math.cos(beta), Math.sin(beta)];
  const P = [a, 0.09] as V2;
  const A0: V2 = [0, -0.09], B0: V2 = [L, -0.09];
  const arrowTo = (p: V2, f: V2) => [sub(p, mul(f, kf)), p] as [V2, V2];
  const ax = arrowTo(A0, [Ax, 0]), ay = arrowTo(A0, [0, Ay]), bb = arrowTo(B0, [0, B]);
  const labels: Lab[] = [
    lab(X(sub(P, mul(Fv, kf * F))), t`\v F`, 't', 'f'),
    lab(X(ax[0]), t`A_x`, Ax > 0 ? 'l' : 'r', 'f', cut), lab(X(ay[0]), t`A_y`, 'b', 'f', cut), lab(X(bb[0]), t`B`, 'b', 'f', cut),
    lab(X([0, 0.2]), 'A', 'tl', 'ink'), lab(X([L, 0.2]), 'B', 'tr', 'ink'),
  ];
  return (
    <Fig w={W} h={H} labels={labels}>
      <rect x={X([0, 0])[0]} y={X([0, 0.09])[1]} width={L * 110} height={0.18 * 110} className="ln body-solid" />
      <g opacity={1 - cut * 0.88}>
        <PinSupport p={X(A0)} /><RollerSupport p={X(B0)} />
      </g>
      <Arrow a={X(sub(P, mul(Fv, kf * F)))} b={X(P)} c="f" w={2.6} head={14} />
      <g opacity={cut}>
        <Arrow a={X(ax[0])} b={X(ax[1])} c="f" w={2.2} />
        <Arrow a={X(ay[0])} b={X(ay[1])} c="f" w={2.2} />
        <Arrow a={X(bb[0])} b={X(bb[1])} c="f" w={2.2} />
      </g>
    </Fig>
  );
}

/* ------------------------------------------------------------------ 10 three-hinged arch: three forces meet in one point */
const ARCH = { A: [0, 0] as V2, B: [6, 0] as V2, G: [3, 2.45] as V2, cL: [1.5, 2.45] as V2, cR: [4.5, 2.45] as V2 };
const bez = (p0: V2, c: V2, p1: V2, s: number): V2 => add(add(mul(p0, (1 - s) ** 2), mul(c, 2 * s * (1 - s))), mul(p1, s * s));
const archAt = (u: number): V2 => (u <= 0.5 ? bez(ARCH.A, ARCH.cL, ARCH.G, u * 2) : bez(ARCH.G, ARCH.cR, ARCH.B, u * 2 - 1));
export function Dreigelenk() {
  return (
    <Plate id="dreigelenkbogen" num="10.1" title="Dreigelenkbogen" still={3} period={14}
      formula={t`\v F + \v A + \v B = \v 0,\quad \text{Wirkungslinien durch einen Punkt } K`}
      note="Der unbelastete Teil ist eine Pendelstütze: Seine Lagerkraft zeigt zum Gelenk G.">
      {(time) => <DreigelenkFig time={time} />}
    </Plate>
  );
}
function DreigelenkFig({ time }: { time: number }) {
  const X = toSvg({ ox: 90, oy: 420, s: 84 });
  const u = 0.1 + 0.8 * (0.5 - 0.5 * Math.cos((TAU * time) / 14));
  const P = archAt(Math.abs(u - 0.5) < 0.015 ? 0.5 + 0.015 * Math.sign(u - 0.5 || 1) : u);
  const F = 1;
  const { RA, RB, leftLoaded } = threeHinged(ARCH.A, ARCH.B, ARCH.G, P, F);
  const S = leftLoaded ? ARCH.B : ARCH.A;
  const K = intersect(P, [0, 1], S, sub(ARCH.G, S)) ?? P;
  const kf = 1.25;
  const left = Array.from({ length: 41 }, (_, i) => X(archAt((i / 40) * 0.5)));
  const right = Array.from({ length: 41 }, (_, i) => X(archAt(0.5 + (i / 40) * 0.5)));
  // force polygon
  const T0: V2 = [8.2, 3.9];
  const kp = 2.1;
  const T1 = add(T0, mul([0, -F], kp)), T2 = add(T1, mul(leftLoaded ? RB : RA, kp)), T3 = add(T2, mul(leftLoaded ? RA : RB, kp));
  const labels: Lab[] = [
    lab(X(add(ARCH.A, [-0.25, 0.1])), 'A', 'l'), lab(X(add(ARCH.B, [0.25, 0.1])), 'B', 'r'), lab(X(ARCH.G), 'G', 't'),
    lab(X(add(P, [0, 0.95])), t`\v F`, 'r', 'f'), lab(X(K), 'K', 'tr', 'k'),
    lab(X(lerp(T0, T1, 0.5)), t`\v F`, 'l', 'f'), lab(X(lerp(T1, T2, 0.5)), leftLoaded ? t`\v B` : t`\v A`, 'r', 'f'), lab(X(lerp(T2, T3, 0.5)), leftLoaded ? t`\v A` : t`\v B`, 't', 'f'),
  ];
  const ext = (p: V2, q: V2, k: number) => [p, add(p, mul(sub(q, p), k))] as [V2, V2];
  const lnS = ext(S, K, 1.15), lnO = ext(leftLoaded ? ARCH.A : ARCH.B, K, 1.15);
  return (
    <Fig w={W} h={H} labels={labels}>
      <Line a={X([P[0], P[1] + 1.0])} b={X([K[0], K[1] + (K[1] > P[1] ? 0.2 : -0.3)])} cls="guide" />
      <Line a={X(lnS[0])} b={X(lnS[1])} cls="guide" />
      <Line a={X(lnO[0])} b={X(lnO[1])} cls="guide" />
      <Poly p={left} cls="ink" w={6} /><Poly p={right} cls="ink" w={6} />
      <PinSupport p={X(ARCH.A)} /><PinSupport p={X(ARCH.B)} />
      <Hinge p={X(ARCH.G)} r={5} />
      <Arrow a={X(add(P, [0, 1.0]))} b={X(P)} c="f" w={2.6} head={14} />
      <Arrow a={X(sub(ARCH.A, mul(RA, kf * 0.7)))} b={X(ARCH.A)} c="f" w={2.2} />
      <Arrow a={X(sub(ARCH.B, mul(RB, kf * 0.7)))} b={X(ARCH.B)} c="f" w={2.2} />
      <Dot p={X(K)} r={4} c="k" />
      <Arrow a={X(T0)} b={X(T1)} c="f" w={2} /><Arrow a={X(T1)} b={X(T2)} c="f" w={2} /><Arrow a={X(T2)} b={X(T3)} c="f" w={2} />
    </Fig>
  );
}

/* ------------------------------------------------------------------ 11 truss with a moving load */
export function Fachwerk() {
  return (
    <Plate id="fachwerk" num="11.1" title="Fachwerk unter wandernder Last" still={4.4} period={16}
      formula={t`\text{Knoten } k:\quad \textstyle\sum_j S_j\,\v e_{kj} + \v F_k = \v 0`}
      note="Strichdicke ∝ Stabkraft. Rot: Zug. Schwarz: Druck. Gestrichelt: Nullstab.">
      {(time) => <FachwerkFig time={time} />}
    </Plate>
  );
}
function FachwerkFig({ time }: { time: number }) {
  const panels = 6, w = 1.2, h = 1.2;
  const T = useMemo(() => pratt(panels, w, h), []);
  const X = toSvg({ ox: 120, oy: 380, s: 100 });
  const span = panels * w;
  const x = 0.25 + (span - 0.5) * (0.5 - 0.5 * Math.cos((TAU * time) / 16));
  // the deck carries the load to the two neighbouring bottom nodes (lever rule)
  const loads: V2[] = T.nodes.map(() => [0, 0]);
  const i = Math.min(panels - 1, Math.floor(x / w)), f = x / w - i, F = 1;
  loads[i] = [0, -F * (1 - f)]; loads[i + 1] = [0, -F * f];
  const { S, R } = solveTruss(T, loads);
  const Smax = 1.6;
  const labels: Lab[] = [
    lab(X([x, 1.0 + h]), t`\v F`, 't', 'f'),
    lab(X([0, -0.35]), t`A`, 'bl', 'ink'), lab(X([span, -0.35]), t`B`, 'br', 'ink'),
  ];
  return (
    <Fig w={W} h={H} labels={labels} readout={t`A_y = ${num(R[1], 2)}\,F,\quad B = ${num(R[2], 2)}\,F`}>
      {T.members.map(([a, b], k) => {
        const s = S[k], zero = Math.abs(s) < 1e-6;
        const wd = zero ? 1 : 1.4 + 7.5 * Math.min(1, Math.abs(s) / Smax);
        return <Line key={k} a={X(T.nodes[a])} b={X(T.nodes[b])} cls={zero ? 'guide' : s > 0 ? 'f' : 'ink'} w={wd} />;
      })}
      {T.nodes.map((p, k) => <Hinge key={k} p={X(p)} r={3.6} />)}
      <PinSupport p={X([0, 0])} /><RollerSupport p={X([span, 0])} />
      <Arrow a={X([x, 1.0 + h])} b={X([x, h + 0.06])} c="f" w={2.6} head={14} />
      <Line a={X([x, h + 0.06])} b={X([x, 0])} cls="guide" />
    </Fig>
  );
}

/* ------------------------------------------------------------------ 12 friction: block on a tilting plane */
export function Reibung() {
  return (
    <Plate id="reibung" num="12.1" title="Haften, Reibungskegel, Gleiten" still={4.4} period={12}
      formula={t`H \le \mu_0 N\quad\Longleftrightarrow\quad \alpha \le \rho_0,\qquad \tan\rho_0 = \mu_0`}
      note="Solange die Kontaktkraft im Reibungskegel bleibt, haftet der Klotz. Sie ist dann genau senkrecht.">
      {(time) => <ReibungFig time={time} />}
    </Plate>
  );
}
function ReibungFig({ time }: { time: number }) {
  const mu0 = 0.5, mu = 0.38, rho0 = Math.atan(mu0), rate = deg(4.2), a0 = deg(6);
  const tSlip = (rho0 - a0) / rate;
  const al = time < tSlip ? a0 + rate * time : rho0 + 1e-4;
  const st = incline(al, mu0, mu, 1);
  const tau = Math.max(0, time - tSlip);
  const s0 = 3.6;
  const sAcc = 9.81 * (Math.sin(al) - mu * Math.cos(al)) * 0.35; // slowed for viewing
  const s = Math.max(0.65, s0 - 0.5 * sAcc * tau * tau);
  const fade = 1 - ease(seg(time, 11.3, 12));
  const X = toSvg({ ox: 130, oy: 470, s: 112 });
  const e: V2 = [Math.cos(al), Math.sin(al)], n = perp(e);
  const Lp = 6.4, bw = 0.95, bh = 0.62;
  const Q = mul(e, s), C = add(Q, mul(n, bh / 2));
  const block: V2[] = [add(Q, mul(e, -bw / 2)), add(Q, mul(e, bw / 2)), add(add(Q, mul(e, bw / 2)), mul(n, bh)), add(add(Q, mul(e, -bw / 2)), mul(n, bh))];
  // contact resultant K = N n + H e acts where its line through C meets the contact face
  const K = add(mul(n, st.N), mul(e, st.H));
  const at = intersect(Q, e, C, K) ?? Q;
  const kf = 1.2;
  const cone = (r: number) => [at, add(at, mul(rot(n, r), 1.9)), add(at, mul(rot(n, -r), 1.9))] as V2[];
  const labels: Lab[] = [
    lab(X(add(C, [0, -kf])), t`\v G`, 'r', 'f'),
    lab(X(add(at, mul(K, kf))), t`\v K`, 'r', 'f'),
    lab(X(add(at, mul(rot(n, rho0), 1.95))), t`\rho_0`, 'l', 'f'),
    lab(X([1.15, 0.12]), t`\alpha`, 'r', 'k'),
  ];
  return (
    <Fig w={W} h={H} labels={labels} readout={t`\alpha = ${num((al * 180) / Math.PI, 1)}^\circ,\ \ \rho_0 = ${num((rho0 * 180) / Math.PI, 1)}^\circ`}>
      <Ground a={X([-0.4, 0])} b={X([6.6, 0])} />
      <Ground a={X([0, 0])} b={X(mul(e, Lp))} depth={7} />
      <Poly p={[X([0.95, 0]), ...Array.from({ length: 12 }, (_, k) => X(mul([Math.cos((al * (k + 1)) / 12), Math.sin((al * (k + 1)) / 12)], 0.95)))]} cls="k" w={1.3} />
      <g opacity={fade}>
        <Poly p={block.map(X)} closed cls="body" />
        <Poly p={cone(rho0).map(X)} closed cls="wash-f" />
        <Line a={X(cone(rho0)[0])} b={X(cone(rho0)[1])} cls="f" w={1} o={0.7} />
        <Line a={X(cone(rho0)[0])} b={X(cone(rho0)[2])} cls="f" w={1} o={0.7} />
        <Arrow a={X(C)} b={X(add(C, [0, -kf]))} c="f" w={2.4} head={13} />
        <Arrow a={X(at)} b={X(add(at, mul(K, kf)))} c="f" w={2.4} head={13} />
        <Dot p={X(C)} r={3.2} />
      </g>
      <Hinge p={X([0, 0])} r={4} />
    </Fig>
  );
}

/* ------------------------------------------------------------------ 13 catenary */
export function Kettenlinie() {
  return (
    <Plate id="kettenlinie" num="13.1" title="Kettenlinie" still={4} period={16}
      formula={t`y = a\cosh\frac{x}{a},\qquad a = \frac{H}{q},\qquad S(x) = H\cosh\frac{x}{a}`}
      note="Gestrichelt: die Parabel mit gleichem Durchhang. H ist überall gleich, S wächst zu den Aufhängepunkten.">
      {(time) => <KettenFig time={time} />}
    </Plate>
  );
}
function KettenFig({ time }: { time: number }) {
  const b = 3.3, l = 6.75 + 2.6 * (0.5 - 0.5 * Math.cos((TAU * time) / 16));
  const a = catenaryParam(b, l), y = catenary(a, b);
  const X = toSvg({ ox: 480, oy: 175, s: 105 });
  const f = -y(0);
  const curve = Array.from({ length: 121 }, (_, i) => { const x = -b + (2 * b * i) / 120; return X([x, y(x)]); });
  const para = Array.from({ length: 61 }, (_, i) => { const x = -b + (2 * b * i) / 60; return X([x, f * ((x / b) ** 2 - 1)]); });
  const q = 1, Hh = q * a, kS = 0.2;
  const SB: V2 = mul([Math.cos(Math.atan(Math.sinh(b / a))), Math.sin(Math.atan(Math.sinh(b / a)))], Hh * Math.cosh(b / a));
  const SA: V2 = [-SB[0], SB[1]];
  const bottom: V2 = [0, -f];
  const labels: Lab[] = [
    lab(X(add([b, 0], mul(SB, kS))), t`S_B`, 'r', 'f'), lab(X(add([-b, 0], mul(SA, kS))), t`S_A`, 'l', 'f'),
    lab(X(add(bottom, [Hh * kS, 0])), t`H`, 'b', 'f'), lab(X(add(bottom, [-Hh * kS, 0])), t`H`, 'b', 'f'),
    lab(X([b + 0.1, -f / 2]), 'f', 'r', 'k'),
  ];
  return (
    <Fig w={W} h={H} labels={labels} readout={t`f = ${num(f, 2)},\ \ a = ${num(a, 2)},\ \ \ell = ${num(l, 2)}`}>
      <Ground a={X([-b - 0.5, 0.22])} b={X([-b + 0.5, 0.22])} />
      <Ground a={X([b - 0.5, 0.22])} b={X([b + 0.5, 0.22])} />
      <Line a={X([-b, 0.22])} b={X([-b, 0])} cls="ink" /><Line a={X([b, 0.22])} b={X([b, 0])} cls="ink" />
      <Poly p={para} cls="guide" />
      <Poly p={curve} cls="ink" w={2.2} />
      <Line a={X([b + 0.1, 0])} b={X([b + 0.1, -f])} cls="k" w={1.2} />
      <Line a={X([b - 0.05, -f])} b={X([b + 0.25, -f])} cls="k" w={1} />
      <Line a={X([-0.3, -f])} b={X([b + 0.25, -f])} cls="faint" />
      <Arrow a={X([b, 0])} b={X(add([b, 0], mul(SB, kS)))} c="f" w={2.2} />
      <Arrow a={X([-b, 0])} b={X(add([-b, 0], mul(SA, kS)))} c="f" w={2.2} />
      <Arrow a={X(bottom)} b={X(add(bottom, [Hh * kS, 0]))} c="f" w={2} />
      <Arrow a={X(bottom)} b={X(add(bottom, [-Hh * kS, 0]))} c="f" w={2} />
      <Hinge p={X([-b, 0])} r={4} /><Hinge p={X([b, 0])} r={4} />
    </Fig>
  );
}

/* ------------------------------------------------------------------ 13 rope friction */
export function Seilreibung() {
  return (
    <Plate id="seilreibung" num="13.2" title="Seilreibung" still={8.5} period={11}
      formula={t`S_2 = S_1\,e^{\mu\alpha}`}
      note="Strichdicke ∝ Seilkraft. Jede weitere Windung vervielfacht die haltbare Last.">
      {(time) => <SeilFig time={time} />}
    </Plate>
  );
}
function SeilFig({ time }: { time: number }) {
  const mu = 0.25, S1 = 1, amax = 3 * Math.PI;
  const al = 0.15 + (amax - 0.15) * ease(seg(time, 0.5, 8.5));
  const S2 = capstan(S1, mu, al), Smax = capstan(S1, mu, amax);
  const X = toSvg({ ox: 340, oy: 290, s: 100 });
  const R = 1.0, gap = 0.11;
  // contact path: from the top (load side), clockwise; φ = wrapped angle so far
  const rad = (ph: number) => R + 0.05 + (gap * ph) / TAU;
  const pt = (ph: number): V2 => { const th = Math.PI / 2 - ph; return [rad(ph) * Math.cos(th), rad(ph) * Math.sin(th)]; };
  const Sat = (ph: number) => S1 * Math.exp(mu * (al - ph)); // load side (φ = 0) carries S2
  const wOf = (S: number) => 1.3 + 9 * (S / Smax);
  const segs: { a: V2; b: V2; w: number }[] = [];
  const N = Math.max(8, Math.ceil(al * 24));
  for (let k = 0; k < N; k++) { const p0 = (al * k) / N, p1 = (al * (k + 1)) / N; segs.push({ a: X(pt(p0)), b: X(pt(p1)), w: wOf(Sat((p0 + p1) / 2)) }); }
  const load0 = pt(0), loadEnd: V2 = [-2.0, load0[1]];
  const ex = pt(al), th = Math.PI / 2 - al, dir: V2 = [Math.sin(th), -Math.cos(th)];
  const exEnd = add(ex, mul(dir, 1.25));
  // plot of S(α)/S1
  const px = (a: number) => 600 + (a / amax) * 290, py = (r: number) => 470 - ((r - 1) / (Smax - 1)) * 330;
  const plot = Array.from({ length: 81 }, (_, i) => [px((amax * i) / 80), py(capstan(1, mu, (amax * i) / 80))] as V2);
  const cur: V2 = [px(al), py(S2 / S1)];
  const ticks = [1, 2, 3].map((k) => px(k * Math.PI));
  const labels: Lab[] = [
    lab(X(add(loadEnd, [-0.6, 0])), t`S_2`, 'l', 'f'), lab(X(add(exEnd, mul(dir, 0.6))), t`S_1`, dir[0] >= 0 ? 'r' : 'l', 'f'),
    lab([px(amax) + 6, 470], t`\alpha`, 'r', 'g'), lab([600, 132], t`S_2/S_1`, 't', 'g'),
    ...ticks.map((x, k) => lab([x, 474], k === 0 ? t`\pi` : t`${k + 1}\pi`, 'b', 'g')),
  ];
  return (
    <Fig w={W} h={H} labels={labels} readout={t`\mu = ${num(mu, 2)},\ \ S_2/S_1 = e^{\mu\alpha} = ${num(S2 / S1, 2)}`}>
      <circle cx={X([0, 0])[0]} cy={X([0, 0])[1]} r={R * 100} className="ln body" />
      <circle cx={X([0, 0])[0]} cy={X([0, 0])[1]} r={3} className="dot c-g" />
      <Line a={X(loadEnd)} b={X(load0)} cls="ink" w={wOf(S2)} />
      {segs.map((s, k) => <Line key={k} a={s.a} b={s.b} cls="ink" w={s.w} />)}
      <Line a={X(ex)} b={X(exEnd)} cls="ink" w={wOf(S1)} />
      <Arrow a={X(loadEnd)} b={X(add(loadEnd, [-0.55, 0]))} c="f" w={2.4} />
      <Arrow a={X(exEnd)} b={X(add(exEnd, mul(dir, 0.55)))} c="f" w={2.4} />
      <Line a={[600, 470]} b={[px(amax) + 4, 470]} cls="thin" />
      <Line a={[600, 470]} b={[600, 132]} cls="thin" />
      {ticks.map((x, k) => <Line key={k} a={[x, 466]} b={[x, 474]} cls="thin" />)}
      <Poly p={plot} cls="faint" w={1.6} />
      <Poly p={plot.filter(([x]) => x <= cur[0] + 0.01)} cls="f" w={2} />
      <Line a={[cur[0], 470]} b={cur} cls="guide" /><Line a={[600, cur[1]]} b={cur} cls="guide" />
      <Dot p={cur} r={4} c="f" />
    </Fig>
  );
}

/* ------------------------------------------------------------------ 14 internal forces: the cut walks along the beam */
export function Schnitt() {
  return (
    <Plate id="schnittgroessen" num="14.1" title="Querkraft und Biegemoment" still={6.4} period={12}
      formula={t`\frac{\mathrm dQ}{\mathrm dx} = -q,\qquad \frac{\mathrm dM}{\mathrm dx} = Q`}
      note="Der Schnitt wandert. Was links bleibt, ist im Gleichgewicht, wenn am Schnittufer Q und M wirken.">
      {(time) => <SchnittFig time={time} />}
    </Plate>
  );
}
function SchnittFig({ time }: { time: number }) {
  const L = 6, q = 0.8, F = 2, a = 4;
  const b = beamInternal(L, q, F, a);
  const ox = 150, s = 110, X = toSvg({ ox, oy: 150, s });
  const xc = Math.max(0.001, L * ease(seg(time, 0.6, 10)));
  const yQ = 305, kQ = 19, yM = 405, kM = 18;
  const gx = (x: number) => ox + x * s;
  const xs = Array.from({ length: 241 }, (_, i) => (L * i) / 240);
  const Qp = (x: number): V2 => [gx(x), yQ - kQ * b.Q(x)];
  const Mp = (x: number): V2 => [gx(x), yM + kM * b.M(x)];
  const qline = (xx: number[]) => xx.flatMap((x) => (Math.abs(x - a) < 1e-9 ? [] : [Qp(x)]));
  const Qfull = [...qline(xs.filter((x) => x <= a)), [gx(a), yQ - kQ * b.Q(a - 1e-9)] as V2, [gx(a), yQ - kQ * b.Q(a + 1e-9)] as V2, ...qline(xs.filter((x) => x > a))];
  const Mfull = xs.map(Mp);
  const upto = (pts: V2[]) => pts.filter(([x]) => x <= gx(xc) + 1e-6);
  const Qc = b.Q(xc), Mc = b.M(xc);
  const Qcut = [[gx(0), yQ] as V2, ...upto(Qfull), [gx(xc), yQ - kQ * Qc] as V2, [gx(xc), yQ] as V2];
  const Mcut = [[gx(0), yM] as V2, ...upto(Mfull), [gx(xc), yM + kM * Mc] as V2, [gx(xc), yM] as V2];
  const top = 0.09, kf = 0.2;
  const cutP = X([xc, 0]);
  const labels: Lab[] = [
    lab(X([a, 0.95]), t`F`, 't', 'f'), lab(X([1.0, 0.62]), t`q`, 't', 'f'),
    lab(X([xc + 0.08, (kf * Qc) / 2]), t`Q`, Qc < 0 ? 'br' : 'tr', 'f', xc > 0.05 && xc < L - 0.05 && Math.abs(Qc) > 0.05 ? 1 : 0),
    lab([gx(xc) + 24, cutP[1] - 30], t`M`, 'tr', 'm', xc > 0.05 && xc < L - 0.05 ? 1 : 0),
    lab([ox - 16, yQ], 'Q', 'l', 'g'), lab([ox - 16, yM + 40], 'M', 'l', 'g'),
    lab(X([0, -0.3]), 'A', 'b', 'ink'), lab(X([L, -0.3]), 'B', 'b', 'ink'),
  ];
  const qArrows = Array.from({ length: 13 }, (_, i) => (L * i) / 12);
  return (
    <Fig w={W} h={H} labels={labels} readout={t`x = ${num(xc, 2)}:\ \ Q = ${num(Qc, 2)},\ \ M = ${num(Mc, 2)}`}>
      {/* beam: the left part stays, the right part is cut away */}
      <rect x={gx(0)} y={X([0, top])[1]} width={xc * s} height={2 * top * s} className="ln body" />
      <rect x={gx(xc)} y={X([0, top])[1]} width={(L - xc) * s} height={2 * top * s} className="ln body-solid" opacity={0.3} />
      <g opacity={0.3 + 0.7 * 1}>
        {qArrows.map((x, i) => <Arrow key={i} a={X([x, 0.52])} b={X([x, top + 0.02])} c="f" w={1.1} head={8} o={x <= xc + 1e-6 ? 1 : 0.3} />)}
        <Line a={X([0, 0.52])} b={X([L, 0.52])} cls="f" w={1.1} />
      </g>
      <Arrow a={X([a, 0.95])} b={X([a, top + 0.02])} c="f" w={2.4} head={13} o={a <= xc ? 1 : 0.3} />
      <g opacity={1}>
        <PinSupport p={X([0, -top])} /><g opacity={0.3}><RollerSupport p={X([L, -top])} /></g>
      </g>
      {/* internal forces at the cut (positive face: Q downward, M counter-clockwise for M > 0) */}
      <Arrow a={X([xc + 0.05, (kf * Qc) / 2])} b={X([xc + 0.05, (-kf * Qc) / 2])} c="f" w={2.2} o={xc > 0.05 && xc < L - 0.05 && Math.abs(Qc) > 0.05 ? 1 : 0} />
      {xc > 0.05 && xc < L - 0.05 && Math.abs(Mc) > 0.05 && <ArcArrow c={cutP} r={24} a0={Mc > 0 ? 1.2 : -1.2} a1={Mc > 0 ? -1.2 : 1.2} ink="m" w={1.8} />}
      {/* diagrams */}
      <Line a={[gx(0), yQ]} b={[gx(L), yQ]} cls="thin" />
      <Line a={[gx(0), yM]} b={[gx(L), yM]} cls="thin" />
      <Poly p={Qfull} cls="faint" w={1.4} />
      <Poly p={Mfull} cls="faint" w={1.4} />
      <Poly p={Qcut} closed cls="wash-f" />
      <Poly p={upto(Qfull).concat([[gx(xc), yQ - kQ * Qc]])} cls="f" w={1.8} />
      <Poly p={Mcut} closed cls="wash-m" />
      <Poly p={upto(Mfull).concat([[gx(xc), yM + kM * Mc]])} cls="m" w={1.8} />
      <Line a={[gx(xc), X([0, top])[1] - 4]} b={[gx(xc), yM + kM * 6.2]} cls="guide" />
      <Dot p={[gx(xc), yQ - kQ * Qc]} r={3.6} c="f" />
      <Dot p={[gx(xc), yM + kM * Mc]} r={3.6} c="m" />
    </Fig>
  );
}

