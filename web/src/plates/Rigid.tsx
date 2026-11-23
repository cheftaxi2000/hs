/** Chapter 3: rigid-body kinematics. */
import { ladder, rolling, sliderCrank } from '../phys/kin';
import { add, add3, cross3, dot, mul, mul3, perp, sub, unit, TAU, type V2, type V3 } from '../lib/vec';
import { Plate, useOrbit } from '../ui/Plate';
import { Arrow3, Path3, useProj } from '../ui/three';
import { Arrow, Dot, Fig, Ground, Hinge, Line, Poly, lab, toSvg, type Lab } from '../ui/svg';

const W = 960, H = 560;
const t = String.raw;

/* ------------------------------------------------------------------ SdpG: slider–crank */
export function SdpG() {
  return (
    <Plate id="sdpg" num="3.1" title="Satz der projizierten Geschwindigkeiten" still={1.1} period={TAU / 0.55}
      formula={t`\v v_A\cdot\v e_{AB} \;=\; \v v_B\cdot\v e_{AB}`}>
      {(time) => <SdpGFig phi={0.55 * time + 0.5} />}
    </Plate>
  );
}
function SdpGFig({ phi }: { phi: number }) {
  const r = 1, l = 2.55, om = 1;
  const S = toSvg({ ox: 300, oy: 300, s: 138 });
  const s = sliderCrank(r, l, phi, om);
  const A = S(s.A), B = S(s.B), O = S([0, 0]);
  const kv = 0.95; // drawn length per unit speed (world units)
  const tipA = S(add(s.A, mul(s.vA, kv))), tipB = S(add(s.B, mul(s.vB, kv)));
  const e = unit(sub(s.B, s.A));
  const pA = dot(s.vA, e) * kv, pB = dot(s.vB, e) * kv;
  const projA = S(add(s.A, mul(e, pA))), projB = S(add(s.B, mul(e, pB)));
  // the line AB, drawn a little past both ends
  const far = (k: number) => S(add(s.A, mul(e, k)));
  const nrm = perp(e);
  const off = (p: V2, k: number) => S(add(p, mul(nrm, k)));
  const labels: Lab[] = [
    lab(O, 'O', 'b'), lab(A, 'A', s.A[1] > 0 ? 'tl' : 'bl'), lab(B, 'B', 't'),
    lab(tipA, t`\v v_A`, 'r', 'v'), lab(tipB, t`\v v_B`, s.vB[0] > 0 ? 'r' : 'l', 'v'),
  ];
  // the two equal projections, shown as bars beside the rod
  const barA0 = off(s.A, 0.13), barA1 = off(add(s.A, mul(e, pA)), 0.13);
  const barB0 = off(s.B, 0.13), barB1 = off(add(s.B, mul(e, pB)), 0.13);
  return (
    <Fig w={W} h={H} labels={labels}>
      {/* slide and crank circle */}
      <Ground a={S([1.1, -0.085])} b={S([4.3, -0.085])} />
      <circle cx={O[0]} cy={O[1]} r={138} className="ln faint" />
      <Line a={far(-0.9)} b={far(l + 0.9)} cls="guide" />
      {/* bodies */}
      <rect x={B[0] - 26} y={B[1] - 11} width={52} height={22} className="ln body-solid" />
      <Line a={O} b={A} w={5} cls="ink" />
      <Line a={A} b={B} w={5} cls="ink" />
      {/* velocities and their projections */}
      <Line a={tipA} b={projA} cls="guide" />
      <Line a={tipB} b={projB} cls="guide" />
      <Arrow a={A} b={tipA} c="v" />
      <Arrow a={B} b={tipB} c="v" />
      <Line a={barA0} b={barA1} cls="v" w={5} />
      <Line a={barB0} b={barB1} cls="v" w={5} />
      <Dot p={projA} r={2.6} c="v" /><Dot p={projB} r={2.6} c="v" />
      <Hinge p={O} /><Hinge p={A} /><Hinge p={B} />
    </Fig>
  );
}

/* ------------------------------------------------------------------ rolling */
export function Rollen() {
  const R = 1, v = 1.0, x0 = 0, x1 = TAU * R + 0.3;
  const period = (x1 - x0) / v + 1.2;
  return (
    <Plate id="rollen" num="3.2" title="Rollen" still={3.4} period={period}
      formula={t`\v v_P = \v\omega\times\overrightarrow{ZP},\qquad |\v v_P| = \omega\,\overline{ZP}`}
      note="Der Berührpunkt Z ruht für einen Augenblick. Ein Randpunkt zeichnet eine Zykloide.">
      {(time) => <RollFig xO={x0 + Math.min(time * v, x1 - x0)} R={R} v={v} x0={x0} />}
    </Plate>
  );
}
function RollFig({ xO, R, v, x0 }: { xO: number; R: number; v: number; x0: number }) {
  const S = toSvg({ ox: 150, oy: 420, s: 108 });
  const w = rolling(R, v, xO);
  const O = S(w.O), Z = S(w.Z);
  const kv = 0.4;
  // cycloid traced by the marked point since the start
  const cyc: V2[] = [];
  for (let x = x0; x <= xO + 1e-9; x += 0.03) cyc.push(S(rolling(R, v, x).marked));
  cyc.push(S(w.marked));
  const rimPts = Array.from({ length: 8 }, (_, i) => w.point((i * TAU) / 8 + Math.PI / 2));
  const spokes = Array.from({ length: 6 }, (_, i) => w.point((i * TAU) / 6 + 0.26));
  const M = w.marked, Ms = S(M);
  const labels: Lab[] = [
    lab(Z, 'Z', 'b'), lab(O, 'O', 'tl', 'ink'),
    lab(S(add(M, mul(w.vel(M), kv))), t`\v v_P`, 'r', 'v'),
    lab(Ms, 'P', 'l'),
  ];
  const top: V2 = [w.O[0], 2 * R];
  return (
    <Fig w={W} h={H} labels={labels}>
      <Ground a={S([-1.0, 0])} b={S([7.4, 0])} />
      <Poly p={cyc} cls="k" w={1.5} />
      {/* velocity distribution on the vertical diameter: linear in the height above Z */}
      <Line a={Z} b={S(add(top, mul(w.vel(top), kv)))} cls="guide" />
      <Line a={Z} b={S(top)} cls="faint" />
      <circle cx={O[0]} cy={O[1]} r={R * 108} className="ln body-solid" />
      {spokes.map((p, i) => <Line key={i} a={O} b={S(p)} cls="faint" />)}
      <Line a={Z} b={Ms} cls="guide" />
      {rimPts.map((p, i) => <Arrow key={i} a={S(p)} b={S(add(p, mul(w.vel(p), kv)))} c="v" w={1.3} head={9} o={0.8} />)}
      {[0.5, 1].map((h) => { const p: V2 = [w.O[0], h * R]; return <Arrow key={h} a={S(p)} b={S(add(p, mul(w.vel(p), kv)))} c="v" w={1.3} head={9} o={0.8} />; })}
      <Arrow a={Ms} b={S(add(M, mul(w.vel(M), kv)))} c="v" w={2} />
      <RightAngle at={Ms} u={unit(sub(Z, Ms))} v={unit(sub(S(add(M, w.vel(M))), Ms))} />
      <Dot p={O} r={3} /><Dot p={Z} r={3.6} /><Dot p={Ms} r={3.6} c="k" />
    </Fig>
  );
}

/** Right-angle mark at a point between the screen directions u and v. */
export function RightAngle({ at, u, v, s = 10 }: { at: V2; u: V2; v: V2; s?: number }) {
  const a = add(at, mul(u, s)), b = add(at, add(mul(u, s), mul(v, s))), c = add(at, mul(v, s));
  return <Poly p={[a, b, c]} cls="thin" />;
}

/* ------------------------------------------------------------------ ladder: instantaneous centre and polodes */
export function Leiter() {
  return (
    <Plate id="momentanzentrum" num="3.3" title="Momentanzentrum und Polbahnen" still={2.2} period={TAU / 0.42}
      formula={t`\v v_Z = \v 0,\qquad \overline{OZ} = L`}
      note="Z wandert auf einem festen Viertelkreis (Rastpolbahn). Mit der Leiter läuft der Thaleskreis über AB (Gangpolbahn).">
      {(time) => <LeiterFig time={time} />}
    </Plate>
  );
}
function LeiterFig({ time }: { time: number }) {
  const L = 3.1, w = 0.42;
  const a = 0.78 + 0.62 * Math.sin(w * time), ad = 0.62 * w * Math.cos(w * time);
  const l = ladder(L, a, ad);
  const S = toSvg({ ox: 300, oy: 470, s: 118 });
  const A = S(l.A), B = S(l.B), Z = S(l.Z), O = S([0, 0]);
  const kv = 1.0;
  const pts = [0, 0.25, 0.5, 0.75, 1].map((s) => l.at(s));
  const fixed: V2[] = []; for (let k = 0; k <= 60; k++) fixed.push(S([L * Math.cos((k / 60) * Math.PI / 2), L * Math.sin((k / 60) * Math.PI / 2)]));
  const moving: V2[] = []; for (let k = 0; k <= 96; k++) moving.push(S(add(l.mid, [(L / 2) * Math.cos((k / 96) * TAU), (L / 2) * Math.sin((k / 96) * TAU)])));
  const labels: Lab[] = [
    lab(A, 'A', 'b'), lab(B, 'B', 'l'), lab(Z, 'Z', 'tr', 'ink'), lab(O, 'O', 'bl'),
    lab(S(add(l.A, mul(l.vel(l.A), kv))), t`\v v_A`, l.vel(l.A)[0] > 0 ? 'r' : 'l', 'v'),
    lab(S(add(l.B, mul(l.vel(l.B), kv))), t`\v v_B`, l.vel(l.B)[1] > 0 ? 't' : 'b', 'v'),
    lab(S([L * Math.cos(1.25), L * Math.sin(1.25)]), t`\text{Rastpolbahn}`, 'tr', 'g'),
  ];
  return (
    <Fig w={W} h={H} labels={labels}>
      <Ground a={S([0, 3.55])} b={S([0, 0])} />
      <Ground a={S([0, 0])} b={S([5.2, 0])} />
      <Poly p={fixed} cls="guide" />
      <Poly p={moving} cls="k" w={1.2} o={0.9} />
      <Line a={Z} b={A} cls="guide" /><Line a={Z} b={B} cls="guide" />
      {pts.map((p, i) => i % 4 ? <Line key={i} a={Z} b={S(p)} cls="faint" /> : null)}
      <Line a={A} b={B} w={6} cls="ink" />
      {pts.map((p, i) => <Arrow key={i} a={S(p)} b={S(add(p, mul(l.vel(p), kv)))} c="v" w={i % 4 ? 1.3 : 1.9} head={i % 4 ? 9 : 11} />)}
      <Hinge p={A} /><Hinge p={B} />
      <Dot p={Z} r={4} c="k" />
    </Fig>
  );
}


/* ------------------------------------------------------------------ screw motion (kinemate) */
export function Schraube() {
  const orbit = useOrbit(0.55, 0.3);
  const w = 0.75;
  return (
    <Plate id="kinemate" num="3.4" title="Die allgemeinste Bewegung: Schraubung" still={2.6} period={TAU / w}
      formula={t`\v v_P = \v v_B + \v\omega\times\overrightarrow{BP}`}
      note="Auf der Zentralachse ist v parallel zu ω. Jeder Punkt läuft auf einer Schraubenlinie.">
      {(time) => <SchraubeFig time={time} w={w} cam={orbit.cam} bind={orbit.bind} />}
    </Plate>
  );
}
function SchraubeFig({ time, w, cam, bind }: { time: number; w: number; cam: { az: number; el: number }; bind: object }) {
  const { P, depth } = useProj(cam, 470, 300, 84);
  const pitch = 0.34; // v∥ = pitch · ω
  const phi = w * time, rise = pitch * phi - Math.PI * pitch; // centred around z = 0
  const om: V3 = [0, 0, w], vpar: V3 = [0, 0, pitch * w];
  const place = (q: V3, ph: number, zz: number): V3 => {
    const c = Math.cos(ph), s = Math.sin(ph);
    return [c * q[0] - s * q[1], s * q[0] + c * q[1], q[2] + zz];
  };
  const vel = (p: V3): V3 => add3(vpar, cross3(om, p));
  // a box beside the axis (body coordinates)
  const [x0, x1, y0, y1, z0, z1] = [0.7, 2.5, -0.55, 0.55, -0.45, 0.45];
  const corners: V3[] = [];
  for (const z of [z0, z1]) for (const y of [y0, y1]) for (const x of [x0, x1]) corners.push([x, y, z]);
  const Cw = corners.map((q) => place(q, phi, rise));
  const faces: [number[], V3][] = [
    [[0, 1, 3, 2], [0, 0, -1]], [[4, 5, 7, 6], [0, 0, 1]], [[0, 1, 5, 4], [0, -1, 0]],
    [[2, 3, 7, 6], [0, 1, 0]], [[0, 2, 6, 4], [-1, 0, 0]], [[1, 3, 7, 5], [1, 0, 0]],
  ];
  const nd = (n: V3) => depth(place(n, phi, 0)) - depth([0, 0, 0]);
  const vis = faces.filter(([, n]) => nd(n) > 0);
  const Bi = 7, Pi = 4;
  const B = Cw[Bi], Pp = Cw[Pi];
  const helix = (q: V3) => Array.from({ length: 121 }, (_, i) => { const ph = (i / 120) * TAU; return place(q, ph, pitch * ph - Math.PI * pitch); });
  const kv = 0.95, kw = 1.9;
  const A0: V3 = [0, 0, rise];
  const labels: Lab[] = [
    lab(P(add3(B, mul3(vel(B), kv))), t`\v v_B`, 'r', 'v'), lab(P(B), 'B', 'tl'),
    lab(P(add3(Pp, mul3(vel(Pp), kv))), t`\v v_P`, 'r', 'v'), lab(P(Pp), 'P', 'bl'),
    lab(P([0, 0, 2.55]), t`\text{Zentralachse}`, 'r', 'g'),
    lab(P(add3(A0, [0, 0, w * kw + 0.05])), t`\v\omega`, 'l', 'm'),
  ];
  return (
    <Fig w={W} h={H} labels={labels} {...bind}>
      <Path3 P={P} p={[[0, 0, -2.4], [0, 0, 2.6]]} cls="guide" />
      <Path3 P={P} p={helix(corners[Bi])} cls="k" w={1.1} o={0.55} />
      <Path3 P={P} p={helix(corners[Pi])} cls="k" w={1.1} o={0.55} />
      {vis.map(([idx], i) => <Poly key={i} p={idx.map((j) => P(Cw[j]))} closed cls="body" />)}
      <Arrow3 P={P} a={A0} b={add3(A0, [0, 0, w * kw])} c="m" w={2.2} double head={12} />
      <Arrow3 P={P} a={A0} b={add3(A0, mul3(vpar, kv))} c="v" w={2.2} />
      <Arrow3 P={P} a={B} b={add3(B, mul3(vel(B), kv))} c="v" w={2.2} />
      <Arrow3 P={P} a={Pp} b={add3(Pp, mul3(vel(Pp), kv))} c="v" w={2.2} />
      <Dot p={P(B)} r={3.8} /><Dot p={P(Pp)} r={3.8} />
    </Fig>
  );
}
