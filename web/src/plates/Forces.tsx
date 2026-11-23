/** Chapters 4–8: forces, power, reduction, centre of gravity, virtual power. */
import { useMemo } from 'react';
import { add, add3, cross3, dot, dot3, ease, len, len3, mul, mul3, omegaCross, rot, seg, sub, sub3, unit, unit3, TAU, type V2, type V3 } from '../lib/vec';
import { centroid, polarMoment, scissorForce, trapezoid } from '../phys/statics';
import { Plate, useOrbit } from '../ui/Plate';
import { ArcArrow, Arrow, Dot, Fig, Ground, Hinge, Line, PinSupport, Poly, RollerSupport, lab, toSvg, type Lab } from '../ui/svg';
import { num } from '../ui/Tex';
import { Arrow3, Path3, axes as mkAxes, useProj } from '../ui/three';

const W = 960, H = 560;
const t = String.raw;

/* ------------------------------------------------------------------ 4 line load → resultant */
export function Linienlast() {
  return (
    <Plate id="linienlast" num="4.1" title="Linienlast und Resultierende" still={9.5} period={13}
      formula={t`R = \int_0^L q(x)\,\mathrm dx,\qquad x_S = \frac{1}{R}\int_0^L x\,q(x)\,\mathrm dx`}
      note="Immer feiner zerlegt, dann ersetzt: Die Resultierende greift im Schwerpunkt der Lastfläche an.">
      {(time) => <LinienlastFig time={time} />}
    </Plate>
  );
}
function LinienlastFig({ time }: { time: number }) {
  const L = 6.4, q0 = 0.55, q1 = 2.2;
  const S = toSvg({ ox: 160, oy: 400, s: 100 });
  const { R, xS, q } = trapezoid(q0, q1, L);
  const kq = 0.85; // drawn height per unit q
  // phases: n = 4, 8, 16, 32 bars, then the area, then the resultant
  const steps = [4, 8, 16, 32];
  const k = Math.min(3, Math.floor(seg(time, 0.4, 7.2) * 4));
  const n = steps[k];
  const area = ease(seg(time, 7.4, 8.4)), res = ease(seg(time, 8.6, 9.6));
  const bars = Array.from({ length: n }, (_, i) => (i + 0.5) * (L / n));
  const top = (x: number): V2 => [x, kq * q(x)];
  const loadPoly: V2[] = [S([0, 0]), ...Array.from({ length: 21 }, (_, i) => S(top((L * i) / 20))), S([L, 0])];
  const barOp = 1 - res;
  const labels: Lab[] = [
    lab(S(top(L)), t`q(x)`, 'r', 'f', 1),
    lab(S([xS, kq * R / L + 1.05]), t`R`, 't', 'f', res),
    lab(S([xS, -0.62]), t`x_S`, 'b', 'g', res),
    lab(S([0, -0.05]), '0', 'b', 'g'), lab(S([L, -0.05]), 'L', 'b', 'g'),
  ];
  return (
    <Fig w={W} h={H} labels={labels} readout={res < 0.5 ? t`n = ${n}` : t`x_S/L = ${num(xS / L, 3)}`}>
      <Poly p={loadPoly} closed cls="wash-f" o={0.35 + 0.65 * area} />
      <Poly p={loadPoly.slice(1, -1)} cls="f" w={1.4} />
      {bars.map((x, i) => {
        const w = (L / n) * 100 * 0.7, h = kq * q(x) * 100;
        const p = S([x, 0]);
        return <g key={n + '-' + i} opacity={barOp * (1 - area * 0.85)}>
          <Arrow a={[p[0], p[1] - h]} b={[p[0], p[1] - 2]} c="f" w={Math.max(1, Math.min(2.2, w / 14))} head={Math.min(11, w * 0.6 + 4)} />
        </g>;
      })}
      <rect x={S([0, 0])[0]} y={S([0, 0])[1]} width={L * 100} height={18} className="ln body-solid" />
      <PinSupport p={S([0, -0.18])} />
      <RollerSupport p={S([L, -0.18])} />
      <Line a={S([xS, -0.2])} b={S([xS, -0.6])} cls="guide" o={res} />
      <Arrow a={S([xS, kq * R / L + 1.0])} b={S([xS, 0.02])} c="f" w={3} head={15} o={res} />
    </Fig>
  );
}

/* ------------------------------------------------------------------ 5 power of a force on a rotating body */
export function Leistung() {
  const w = 0.6;
  return (
    <Plate id="leistung" num="5.1" title="Leistung und Moment" still={1.2} period={TAU / w}
      formula={t`\mathcal P = \v F\cdot\v v_A = \v F\cdot(\v\omega\times\v r) = \v\omega\cdot(\v r\times\v F) = \v\omega\cdot\v M_O`}
      note="Die Leistung hängt nur vom Hebelarm h ab. Geht die Wirkungslinie durch O, ist sie null.">
      {(time) => <LeistungFig phi={w * time + 0.3} w={w} />}
    </Plate>
  );
}
function LeistungFig({ phi, w }: { phi: number; w: number }) {
  const S = toSvg({ ox: 380, oy: 285, s: 150 });
  const Rd = 1.25;
  const rA = rot([1.05, 0], phi);
  const F: V2 = [0.95, -0.55]; // fixed force (e.g. a rope pulling)
  const vA = omegaCross(w, rA);
  const Pw = dot(F, vA); // = ω·(r × F) = ω M_O
  const kv = 1.35, kf = 1.0;
  const eF = unit(F);
  const foot = add(rA, mul(eF, -dot(rA, eF))); // foot of the perpendicular from O on the line of action
  const O = S([0, 0]), A = S(rA);
  const marks = Array.from({ length: 12 }, (_, i) => rot([Rd, 0], phi + (i * TAU) / 12));
  const labels: Lab[] = [
    lab(O, 'O', 'bl', 'g'), lab(A, 'A', 'tl'),
    lab(S(add(rA, mul(F, kf))), t`\v F`, 'r', 'f'),
    lab(S(add(rA, mul(vA, kv))), t`\v v_A`, 't', 'v'),
    lab(S(mul(foot, 0.5)), 'h', 'tr', 'k', len(foot) > 0.12 ? 1 : 0),
    lab(S([0.24, 0.3]), t`\v\omega`, 'tr', 'm'),
  ];
  const sign = Pw > 0.002 ? '>' : Pw < -0.002 ? '<' : '=';
  return (
    <Fig w={W} h={H} labels={labels} readout={t`\mathcal P = M_O\,\omega = ${num(Pw, 2)}\ ${sign}\ 0`}>
      <circle cx={O[0]} cy={O[1]} r={Rd * 150} className="ln body-solid" />
      {marks.map((p, i) => <Line key={i} a={S(mul(p, 0.93))} b={S(p)} cls="thin" />)}
      <Line a={S(add(rA, mul(eF, -2.4)))} b={S(add(rA, mul(eF, 2.4)))} cls="guide" />
      <Line a={O} b={S(foot)} cls="k" w={2.2} />
      <Line a={O} b={A} cls="thin" />
      <ArcArrow c={O} r={34} a0={0.4} a1={-1.9} ink="m" w={1.6} />
      <Arrow a={A} b={S(add(rA, mul(F, kf)))} c="f" w={2.6} head={14} />
      <Arrow a={A} b={S(add(rA, mul(vA, kv)))} c="v" w={2.2} />
      <Dot p={S(foot)} r={2.6} c="k" />
      <Hinge p={O} /><Dot p={A} r={3.8} />
    </Fig>
  );
}

/* ------------------------------------------------------------------ 6 reduction of a group of forces: the dyname and the central axis */
const FORCES: { at: V3; F: V3 }[] = [
  { at: [1.6, -0.6, 0.0], F: [0, 0.9, 0.7] },
  { at: [-0.8, 1.2, 0.6], F: [0.6, 0, 0.9] },
  { at: [0.3, 0.4, 1.4], F: [-0.2, 0.5, 0.4] },
];
export function Reduktion() {
  const orbit = useOrbit(0.7, 0.33);
  return (
    <Plate id="dyname" num="6.1" title="Reduktion einer Kräftegruppe" still={11} period={14}
      formula={t`\v M_{B'} = \v M_B + \overrightarrow{B'B}\times\v R`}
      note="Wandert der Bezugspunkt, ändert sich nur das Moment. Auf der Zentralachse ist es parallel zu R und am kleinsten.">
      {(time) => <ReduktionFig time={time} cam={orbit.cam} bind={orbit.bind} />}
    </Plate>
  );
}
export function reduction(B: V3) {
  const R = FORCES.reduce<V3>((s, f) => add3(s, f.F), [0, 0, 0]);
  const MO = FORCES.reduce<V3>((s, f) => add3(s, cross3(f.at, f.F)), [0, 0, 0]);
  const MB = add3(MO, cross3(sub3([0, 0, 0], B), R)); // M_B = M_O + BO × R
  const P0 = mul3(cross3(R, MO), 1 / dot3(R, R)); // point of the central axis nearest O
  return { R, MO, MB, P0 };
}
function ReduktionFig({ time, cam, bind }: { time: number; cam: { az: number; el: number }; bind: object }) {
  const { P } = useProj(cam, 470, 300, 124);
  const { R, P0 } = reduction([0, 0, 0]);
  const eR = unit3(R);
  const start: V3 = [1.9, 1.7, -0.6];
  const k = ease(seg(time, 3.5, 9.5)), k2 = ease(seg(time, 10, 13)) - ease(seg(time, 13.4, 14));
  const B = add3(lerp3(start, P0, k), mul3(eR, -0.9 * k2));
  const MB = reduction(B).MB;
  const kf = 0.95, km = 0.75;
  const showF = 1 - ease(seg(time, 1.2, 3.0)) * 0.55;
  const red = ease(seg(time, 1.2, 3.0));
  const axis = [add3(P0, mul3(eR, -2.6)), add3(P0, mul3(eR, 2.6))];
  const Mpar = mul3(eR, dot3(MB, eR));
  const labels: Lab[] = [
    ...FORCES.map((f, i) => lab(P(add3(f.at, mul3(f.F, kf))), t`\v F_${i + 1}`, 'r', 'f', showF)),
    lab(P(add3(B, mul3(R, kf))), t`\v R`, 'r', 'f', red),
    lab(P(add3(B, mul3(MB, km))), t`\v M_B`, 'r', 'm', red),
    lab(P(B), 'B', 'bl', 'ink', red),
    lab(P(axis[0]), t`\text{Zentralachse}`, 'r', 'g', ease(seg(time, 8, 9.5))),
  ];
  const ax = mkAxes(P, labels, 1.5, 0.3);
  return (
    <Fig w={W} h={H} labels={labels} readout={t`|\v M_B| = ${num(len3(MB), 2)}`} {...bind}>
      {ax}
      <Dot p={P([0, 0, 0])} r={2.6} c="g" />
      <Path3 P={P} p={axis} cls="guide" o={ease(seg(time, 8, 9.5))} />
      {FORCES.map((f, i) => <g key={i} opacity={showF}>
        <Arrow3 P={P} a={f.at} b={add3(f.at, mul3(f.F, kf))} c="f" w={2} />
        <Dot p={P(f.at)} r={3} />
      </g>)}
      <g opacity={red}>
        <Arrow3 P={P} a={B} b={add3(B, mul3(R, kf))} c="f" w={2.8} head={14} />
        <Path3 P={P} p={[add3(B, mul3(MB, km)), add3(B, mul3(Mpar, km))]} cls="guide" />
        <Arrow3 P={P} a={B} b={add3(B, mul3(MB, km))} c="m" w={2.4} double head={13} />
        <Dot p={P(B)} r={4} />
      </g>
    </Fig>
  );
}
const lerp3 = (a: V3, b: V3, k: number): V3 => add3(a, mul3(sub3(b, a), k));

/* ------------------------------------------------------------------ 7 centre of gravity by suspension */
const PLATE = [
  { x0: 0, y0: 0, x1: 3.2, y1: 0.9 },
  { x0: 0, y0: 0.9, x1: 0.9, y1: 2.6 },
  { x0: 1.9, y0: 0.25, x1: 2.5, y1: 0.65, hole: true },
];
const OUTLINE: V2[] = [[0, 0], [3.2, 0], [3.2, 0.9], [0.9, 0.9], [0.9, 2.6], [0, 2.6]];
const HOLE: V2[] = [[1.9, 0.25], [2.5, 0.25], [2.5, 0.65], [1.9, 0.65]];
const HANG: V2[] = [[0.45, 2.2], [2.85, 0.45]];
/** Damped swing of the plate hanging at Ai, starting from angle θ0 (rad, relative to equilibrium). Returns θ(t) samples every dt. */
function swing(Ai: V2, S: V2, theta0: number, T: number, dt = 1 / 120) {
  const d = len(sub(S, Ai)), J = polarMoment(PLATE, Ai), A = centroid(PLATE).A;
  const k = (9.81 * A * d) / J * 0.55, c = 0.95; // slowed for viewing
  let th = theta0, om = 0;
  const out: number[] = [];
  for (let s = 0; s <= T; s += dt) { out.push(th); const a = -k * Math.sin(th) - c * om; om += a * dt; th += om * dt; }
  return out;
}
export function Schwerpunkt() {
  return (
    <Plate id="schwerpunkt" num="7.1" title="Schwerpunkt durch Aufhängen" still={15.5} period={17}
      formula={t`x_S = \frac{\sum A_i\,x_i}{\sum A_i},\qquad y_S = \frac{\sum A_i\,y_i}{\sum A_i}`}
      note="Wo die Platte auch hängt: Der Schwerpunkt pendelt unter den Aufhängepunkt. Zwei Lotlinien schneiden sich in S.">
      {(time) => <SchwerpunktFig time={time} />}
    </Plate>
  );
}
function SchwerpunktFig({ time }: { time: number }) {
  const { S } = centroid(PLATE);
  const tables = useMemo(() => HANG.map((A) => swing(A, S, 0.5, 8)), [S]);
  const phase = time < 8 ? 0 : 1;
  const tl = time < 8 ? time : time - 8;
  const A = HANG[phase];
  const th = tables[phase][Math.min(tables[phase].length - 1, Math.floor(tl * 120))];
  // body angle so that S hangs straight below A, plus the swing θ
  const d = sub(S, A);
  const base = -Math.PI / 2 - Math.atan2(d[1], d[0]);
  const ang = base + th;
  const pin: V2 = [0, 0];
  const X = toSvg({ ox: 480, oy: 112, s: 98 });
  const place = (p: V2): V2 => add(pin, rot(sub(p, A), ang));
  const settled = tl > 6.6 ? ease(seg(tl, 6.6, 7.6)) : 0;
  // plumb lines in body coordinates (they stay with the body once drawn)
  const plumb = (Ai: V2) => { const u = unit(sub(S, Ai)); return [add(Ai, mul(u, -0.4)), add(Ai, mul(u, 3.3))] as V2[]; };
  const l0 = plumb(HANG[0]), l1 = plumb(HANG[1]);
  const show0 = phase === 1 ? 1 : settled, show1 = phase === 1 ? settled : 0;
  const end = time > 15 ? ease(seg(time, 15, 16)) : 0;
  const labels: Lab[] = [
    lab(X(place(HANG[0])), t`A_1`, 'tl', 'ink'), lab(X(place(HANG[1])), t`A_2`, 'r', 'ink'),
    lab(X(place(S)), 'S', 'br', 'f', Math.max(end, show1 * 0.0)),
  ];
  return (
    <Fig w={W} h={H} labels={labels}>
      <Poly p={OUTLINE.map((p) => X(place(p)))} closed cls="body" />
      <Poly p={HOLE.map((p) => X(place(p)))} closed cls="body-solid" />
      <Line a={X(place(l0[0]))} b={X(place(l0[1]))} cls="f" w={1.3} o={show0} />
      <Line a={X(place(l1[0]))} b={X(place(l1[1]))} cls="f" w={1.3} o={show1} />
      <Arrow a={X(place(S))} b={add(X(place(S)), [0, 70])} c="f" w={2.2} o={end} />
      <Ground a={X([0.75, 0.75])} b={X([-0.75, 0.75])} />
      <Line a={X([0, 0.75])} b={X(pin)} cls="ink" w={2} />
      {HANG.map((p, i) => <Hinge key={i} p={X(place(p))} r={4} />)}
      <Dot p={X(place(S))} r={4.2} c="f" o={end} />
    </Fig>
  );
}

/* ------------------------------------------------------------------ 8 virtual power: scissor lift */
export function Schere() {
  return (
    <Plate id="pdvl" num="8.1" title="Prinzip der virtuellen Leistungen" still={2} period={TAU / 0.5}
      formula={t`\mathcal P = -F\,\dot x - G\,\dot h = 0\quad\Rightarrow\quad F = n\,G\cot\alpha`}
      note="Eine gedachte Bewegung genügt: Die Leistungen von F und G heben sich auf.">
      {(time) => <ScherenFig time={time} />}
    </Plate>
  );
}
function ScherenFig({ time }: { time: number }) {
  const a = 0.95, n = 2, G = 1;
  const al = 0.62 + 0.2 * Math.sin(0.5 * time), ad = 0.2 * 0.5 * Math.cos(0.5 * time);
  const X = toSvg({ ox: 300, oy: 480, s: 118 });
  const w = 2 * a * Math.cos(al), hh = 2 * a * Math.sin(al);
  const F = scissorForce(G, al, n);
  const xdot = -2 * a * Math.sin(al) * ad, Hdot = 2 * n * a * Math.cos(al) * ad;
  const bars: [V2, V2][] = [];
  for (let i = 0; i < n; i++) { bars.push([[0, i * hh], [w, (i + 1) * hh]], [[w, i * hh], [0, (i + 1) * hh]]); }
  const top = n * hh;
  const kv = 2.4, kf = 0.5;
  const PF = -F * xdot, PG = -G * Hdot;
  const pf = X([w, 0]), ptop = X([w / 2, top + 0.14]);
  const labels: Lab[] = [
    lab(X([w + F * kf + 0.15, 0.13]), t`F`, 'r', 'f'),
    lab(X([w / 2 + 0.04, top + 0.14 + 0.62]), t`G`, 'r', 'f'),
    lab(X(add([w, -0.05], [xdot * kv / 2, 0])), t`\dot x`, 'b', 'v', Math.abs(xdot) > 0.01 ? 1 : 0),
    lab(X([w / 2 - 0.5, top + 0.14 + Hdot * kv]), t`\dot h`, 'l', 'v', Math.abs(Hdot) > 0.01 ? 1 : 0),
    lab([745, 470], t`-F\dot x`, 'b', 'f'), lab([807, 470], t`-G\dot h`, 'b', 'f'),
  ];
  // power bars (right): F·ẋ and −G·ḣ, always equal and opposite
  const kP = 520, base = 300;
  const bar = (x: number, p: number) => <rect x={x} y={p > 0 ? base - p * kP : base} width={30} height={Math.abs(p) * kP} className={'ln ' + (p > 0 ? 'wash-f' : 'wash-f')} style={{ stroke: 'var(--f)', strokeWidth: 1.2 }} />;
  return (
    <Fig w={W} h={H} labels={labels} readout={t`\alpha = ${num((al * 180) / Math.PI, 1)}^\circ,\quad F/G = ${num(F, 2)}`}>
      <Ground a={X([-0.4, 0])} b={X([2.6, 0])} />
      {bars.map(([p, q], i) => <Line key={i} a={X(p)} b={X(q)} w={4.5} cls="ink" />)}
      <rect x={X([-0.15, 0])[0]} y={X([0, top + 0.14])[1]} width={(w + 0.3) * 118} height={0.14 * 118} className="ln body-solid" />
      {Array.from({ length: n + 1 }, (_, i) => [<Hinge key={'l' + i} p={X([0, i * hh])} r={4} />, <Hinge key={'r' + i} p={X([w, i * hh])} r={4} />])}
      {Array.from({ length: n }, (_, i) => <Hinge key={'m' + i} p={X([w / 2, (i + 0.5) * hh])} r={3.6} />)}
      <circle cx={pf[0]} cy={pf[1] + 6} r={6} className="ln body-solid" />
      <Arrow a={X([w + F * kf + 0.1, 0.13])} b={X([w + 0.1, 0.13])} c="f" w={2.4} head={13} />
      <Arrow a={X([w / 2, top + 0.14 + 0.62])} b={ptop} c="f" w={2.4} head={13} />
      <Arrow a={X([w, -0.05])} b={X(add([w, -0.05], [xdot * kv, 0]))} c="v" w={1.8} o={0.9} />
      <Arrow a={X([w / 2 - 0.35, top + 0.14])} b={X([w / 2 - 0.35, top + 0.14 + Hdot * kv])} c="v" w={1.8} o={0.9} />
      <Line a={[700, base]} b={[880, base]} cls="thin" />
      {bar(730, PF)}{bar(792, PG)}
    </Fig>
  );
}

