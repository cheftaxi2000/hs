/** Chapter 1 and 2: the material point — coordinates, velocity, circular motion. */
import { useState, type ReactNode } from 'react';
import { add, add3, cross3, ease, lerp, mul, mul3, seg, sub, type V3 } from '../lib/vec';
import { path, pathVel } from '../phys/kin';
import { Plate, Seg, useOrbit } from '../ui/Plate';
import { Arrow, Dot, Fig, Line, Poly, lab, toSvg, type Lab } from '../ui/svg';
import { Arrow3, Path3, axes as mkAxes, arc3, circle3, useProj } from '../ui/three';
import { num } from '../ui/Tex';

const W = 960, H = 560;
const t = String.raw;

/* ------------------------------------------------------------------ 1.1 three sets of coordinates */
type Sys = 'k' | 'z' | 's';
const FORMULA: Record<Sys, string> = {
  k: t`\v r = x\,\e{x} + y\,\e{y} + z\,\e{z}`,
  z: t`x = \rho\cos\varphi,\quad y = \rho\sin\varphi,\quad z = z`,
  s: t`x = r\sin\theta\cos\psi,\quad y = r\sin\theta\sin\psi,\quad z = r\cos\theta`,
};
export function Koordinaten() {
  const [sys, setSys] = useState<Sys>('z');
  const orbit = useOrbit(0.62, 0.36);
  return (
    <Plate id="koordinaten" num="1.1" title="Drei Koordinatensätze, ein Punkt" still={2} formula={FORMULA[sys]}
      controls={<Seg label="Koordinatensatz" value={sys} onChange={setSys} options={[{ v: 'k', l: 'kartesisch' }, { v: 'z', l: 'zylindrisch' }, { v: 's', l: 'sphärisch' }]} />}>
      {(time) => <KoordFig time={time} sys={sys} cam={orbit.cam} bind={orbit.bind} />}
    </Plate>
  );
}
function KoordFig({ time, sys, cam, bind }: { time: number; sys: Sys; cam: { az: number; el: number }; bind: object }) {
  const { P } = useProj(cam, 470, 380, 92);
  const phi = 0.72 + 0.32 * Math.sin(0.35 * time);
  const rho = 2.3 + 0.25 * Math.sin(0.27 * time + 1);
  const z = 1.75 + 0.35 * Math.sin(0.41 * time + 2);
  const M: V3 = [rho * Math.cos(phi), rho * Math.sin(phi), z];
  const Mxy: V3 = [M[0], M[1], 0], Mx: V3 = [M[0], 0, 0], My: V3 = [0, M[1], 0], Mz: V3 = [0, 0, M[2]], O: V3 = [0, 0, 0];
  const r = Math.hypot(rho, z), theta = Math.atan2(rho, z);
  const labels: Lab[] = [];
  const axes = mkAxes(P, labels, [3.6, 3.6, 3.1]);
  labels.push(lab(P(M), 'M', 'tr'), lab(P(O), 'O', 'bl', 'g'));
  const er: V3 = mul3(M, 1 / r);
  const ephi: V3 = [-Math.sin(phi), Math.cos(phi), 0];
  const erho: V3 = [Math.cos(phi), Math.sin(phi), 0];
  const etheta: V3 = [Math.cos(theta) * Math.cos(phi), Math.cos(theta) * Math.sin(phi), -Math.sin(theta)];
  const ez: V3 = [0, 0, 1];
  const basis: [V3, string][] = sys === 'k' ? [[[1, 0, 0], t`\e{x}`], [[0, 1, 0], t`\e{y}`], [ez, t`\e{z}`]]
    : sys === 'z' ? [[erho, t`\e{\rho}`], [ephi, t`\e{\varphi}`], [ez, t`\e{z}`]]
    : [[er, t`\e{r}`], [etheta, t`\e{\theta}`], [ephi, t`\e{\psi}`]];
  const kb = 0.78;
  basis.forEach(([e, n]) => labels.push(lab(P(add3(M, mul3(e, kb * 1.2))), n, 'c', 'ink')));
  const val = (x: number) => num(x, 2);
  let draw: ReactNode;
  if (sys === 'k') {
    labels.push(lab(P(mul3(Mx, 0.5)), 'x', 'bl', 'k'), lab(P(mul3(My, 0.5)), 'y', 'b', 'k'), lab(P(mul3(Mz, 0.5)), 'z', 'l', 'k'));
    labels.push(lab(P(Mx), t`M_x`, 'b', 'g'), lab(P(My), t`M_y`, 'br', 'g'), lab(P(Mz), t`M_z`, 'l', 'g'));
    draw = (
      <g>
        <Path3 P={P} p={[Mx, Mxy, My]} cls="guide" />
        <Path3 P={P} p={[M, Mxy]} cls="guide" />
        <Path3 P={P} p={[M, Mz]} cls="guide" />
        <Path3 P={P} p={[O, Mx]} cls="k" w={3} />
        <Path3 P={P} p={[O, My]} cls="k" w={3} />
        <Path3 P={P} p={[O, Mz]} cls="k" w={3} />
      </g>
    );
  } else if (sys === 'z') {
    const ring = (h: number) => circle3([0, 0, h], ez, rho);
    labels.push(lab(P(mul3(Mxy, 0.55)), t`\rho`, 'b', 'k'), lab(P(add3(Mxy, [0, 0, z / 2])), 'z', 'r', 'k'),
      lab(P(arc3(O, [1, 0, 0], erho, 0.95, 8)[4]), t`\varphi`, 'b', 'k'), lab(P(Mxy), t`M_{xy}`, 'br', 'g'));
    draw = (
      <g>
        <Path3 P={P} p={ring(0)} cls="faint" />
        <Path3 P={P} p={ring(z)} cls="faint" />
        <Path3 P={P} p={[O, Mz]} cls="faint" />
        <Path3 P={P} p={[Mz, M]} cls="guide" />
        <Path3 P={P} p={[O, Mxy]} cls="k" w={3} />
        <Path3 P={P} p={[Mxy, M]} cls="k" w={3} />
        <Path3 P={P} p={arc3(O, [1, 0, 0], erho, 0.82)} cls="k" w={1.6} />
      </g>
    );
  } else {
    const meridian = arc3(O, ez, erho, r, 48);
    labels.push(lab(P(mul3(M, 0.55)), 'r', 'tl', 'k'), lab(P(arc3(O, ez, M, 0.95, 8)[4]), t`\theta`, 't', 'k'),
      lab(P(arc3(O, [1, 0, 0], erho, 0.95, 8)[4]), t`\psi`, 'b', 'k'), lab(P(Mxy), t`M_{xy}`, 'br', 'g'));
    draw = (
      <g>
        <Path3 P={P} p={circle3(O, ez, r)} cls="faint" />
        <Path3 P={P} p={meridian} cls="faint" />
        <Path3 P={P} p={[M, Mxy]} cls="guide" />
        <Path3 P={P} p={[O, Mxy]} cls="guide" />
        <Path3 P={P} p={[O, M]} cls="k" w={3} />
        <Path3 P={P} p={arc3(O, ez, M, 0.82)} cls="k" w={1.6} />
        <Path3 P={P} p={arc3(O, [1, 0, 0], erho, 0.82)} cls="k" w={1.6} />
      </g>
    );
  }
  const readout = sys === 'k' ? t`(x;\,y;\,z) = (${val(M[0])};\ ${val(M[1])};\ ${val(M[2])})`
    : sys === 'z' ? t`(\rho;\,\varphi;\,z) = (${val(rho)};\ ${val(phi)};\ ${val(z)})`
    : t`(r;\,\theta;\,\psi) = (${val(r)};\ ${val(theta)};\ ${val(phi)})`;
  return (
    <Fig w={W} h={H} labels={labels} readout={readout} {...bind}>
      {axes}
      {draw}
      {basis.map(([e], i) => <Arrow3 key={i} P={P} a={M} b={add3(M, mul3(e, kb))} c="ink" w={1.5} head={10} />)}
      <Dot p={P(M)} r={4.2} />
      <Dot p={P(O)} r={2.6} c="g" />
    </Fig>
  );
}

/* ------------------------------------------------------------------ 2.1 the velocity as a limit */
export function Sekante() {
  return (
    <Plate id="geschwindigkeit" num="2.1" title="Geschwindigkeit als Grenzwert" still={7.2} period={10}
      formula={t`\v v = \lim_{\Delta t\to 0}\frac{\Delta\v r}{\Delta t} = \dot{\v r}`}
      note="Die Sehne wird zur Tangente. Der Quotient strebt gegen einen endlichen Pfeil.">
      {(time) => <SekFig time={time} />}
    </Plate>
  );
}
function SekFig({ time }: { time: number }) {
  const S = toSvg({ ox: 480, oy: 285, s: 118 });
  const t0 = 0.55;
  // Δt shrinks geometrically from 1.6 to ≈ 0, then holds
  const k = ease(seg(time, 0.6, 7.0));
  const dt = 1.6 * Math.pow(0.004, k);
  const r0 = path(t0), r1 = path(t0 + dt), v = pathVel(t0);
  const kv = 0.42;
  const curve = Array.from({ length: 181 }, (_, i) => S(path((i / 180) * Math.PI * 2)));
  const q = mul(sub(r1, r0), kv / dt);
  const O = S([0, 0]), M0 = S(r0), M1 = S(r1);
  const labels: Lab[] = [
    lab(O, 'O', 'bl', 'g'), lab(M0, t`M(t)`, 'br'), lab(M1, t`M(t+\Delta t)`, 'l', 'g', dt > 0.15 ? 1 : 0),
    lab(S(add(r0, q)), t`\dfrac{\Delta\v r}{\Delta t}`, 't', 'v'),
    lab(S(lerp(r0, r1, 0.5)), t`\Delta\v r`, 'tl', 'ink', dt > 0.25 ? 1 : 0),
  ];
  return (
    <Fig w={W} h={H} labels={labels} readout={t`\Delta t = ${num(dt, 3)}`}>
      <Poly p={curve} cls="faint" w={1.6} />
      <Line a={S(add(r0, mul(v, -1.1)))} b={S(add(r0, mul(v, 1.1)))} cls="guide" />
      <Arrow a={O} b={M0} c="ink" w={1.2} />
      <Arrow a={O} b={M1} c="g" w={1.2} o={dt > 0.05 ? 1 : 0.35} />
      <Arrow a={M0} b={M1} c="ink" w={1.5} o={dt > 0.05 ? 1 : 0} />
      <Arrow a={M0} b={S(add(r0, q))} c="v" w={2.4} head={13} />
      <Dot p={M0} r={4} /><Dot p={M1} r={3} c="g" /><Dot p={O} r={2.6} c="g" />
    </Fig>
  );
}

/* ------------------------------------------------------------------ 2.2 circular motion */
export function Kreis() {
  const orbit = useOrbit(0.5, 0.32);
  return (
    <Plate id="kreisbewegung" num="2.2" title="Kreisbewegung" still={1.4} period={(Math.PI * 2) / 0.7}
      formula={t`\v\omega = \dot\varphi\,\e{z},\qquad \v v = \v\omega\times\v r,\qquad |\v v| = \omega R`}
      note="Ziehen dreht die Ansicht. Der Fusspunkt von r darf irgendwo auf der Achse liegen.">
      {(time) => <KreisFig time={time} cam={orbit.cam} bind={orbit.bind} />}
    </Plate>
  );
}
function KreisFig({ time, cam, bind }: { time: number; cam: { az: number; el: number }; bind: object }) {
  const { P } = useProj(cam, 480, 400, 96);
  const R = 2.1, h = 2.0, w = 0.7, phi = w * time + 0.4;
  const C: V3 = [0, 0, h], O: V3 = [0, 0, 0];
  const M: V3 = [R * Math.cos(phi), R * Math.sin(phi), h];
  const om: V3 = [0, 0, w];
  const v = cross3(om, M);
  const kv = 1.25, kw = 1.9;
  const labels: Lab[] = [];
  const axes = mkAxes(P, labels, [3.2, 3.2, 0.01], 0.6, ['x', 'y', '']);
  labels.push(lab(P(M), 'M', 't'), lab(P(O), 'O', 'bl', 'g'), lab(P(mul3(add3(O, M), 0.5)), t`\v r`, 'l'),
    lab(P(add3(M, mul3(v, kv))), t`\v v`, 'r', 'v'), lab(P(add3(C, [0, 0, w * kw])), t`\v\omega`, 'r', 'm'),
    lab(P(mul3(add3(C, M), 0.5)), 'R', 't', 'g'), lab(P(C), 'C', 'r', 'g'));
  const sense = arc3([0, 0, h + 0.95], [1, 0, 0], [0, 1, 0], 0.34, 20).concat(arc3([0, 0, h + 0.95], [0, 1, 0], [-1, 0, 0], 0.34, 20));
  return (
    <Fig w={W} h={H} labels={labels} {...bind}>
      {axes}
      <Path3 P={P} p={[[0, 0, -0.4], [0, 0, h + 2.2]]} cls="thin" />
      <Path3 P={P} p={circle3(C, [0, 0, 1], R, 96)} cls="ink" w={1.5} />
      <Path3 P={P} p={[C, M]} cls="guide" />
      <Arrow3 P={P} a={O} b={M} c="ink" w={1.5} />
      <Arrow3 P={P} a={C} b={add3(C, [0, 0, w * kw])} c="m" w={2.2} double head={12} />
      <Path3 P={P} p={sense} cls="m" w={1.4} />
      <Arrow3 P={P} a={M} b={add3(M, mul3(v, kv))} c="v" w={2.4} head={13} />
      <Dot p={P(M)} r={4.2} /><Dot p={P(C)} r={2.6} c="g" /><Dot p={P(O)} r={2.6} c="g" />
    </Fig>
  );
}
