/** Helpers for the 3D plates: everything is projected orthographically and drawn as SVG lines. */
import { add3, cross3, dot3, mul3, sub3, unit3, len3, type V2, type V3 } from '../lib/vec';
import { projector, type Cam } from '../lib/proj';
import { Arrow, Line, Poly, lab, type Ink, type Lab } from './svg';

export type Proj = ReturnType<typeof projector>;

/** Points of the circular arc about c from direction u to direction w (both ⟂ to the arc's axis), radius r. */
export function arc3(c: V3, u: V3, w: V3, r: number, n = 32): V3[] {
  const uu = unit3(u);
  const ax = unit3(cross3(u, w));
  const vv = cross3(ax, uu);
  const ang = Math.atan2(dot3(w, vv), dot3(w, uu));
  const out: V3[] = [];
  for (let i = 0; i <= n; i++) {
    const a = (ang * i) / n;
    out.push(add3(c, add3(mul3(uu, r * Math.cos(a)), mul3(vv, r * Math.sin(a)))));
  }
  return out;
}
/** Full circle about c in the plane ⟂ n. */
export function circle3(c: V3, n: V3, r: number, k = 72): V3[] {
  const nn = unit3(n);
  const a = Math.abs(nn[2]) < 0.9 ? unit3(cross3(nn, [0, 0, 1])) : unit3(cross3(nn, [1, 0, 0]));
  const b = cross3(nn, a);
  return Array.from({ length: k + 1 }, (_, i) => {
    const t = (i / k) * Math.PI * 2;
    return add3(c, add3(mul3(a, r * Math.cos(t)), mul3(b, r * Math.sin(t))));
  });
}

export function useProj(cam: { az: number; el: number }, ox: number, oy: number, s: number): Proj {
  return projector({ ...cam, ox, oy, s } as Cam);
}

/** Coordinate axes from O; pushes the labels x, y, z (call it as a function, before the figure renders). */
export function axes(P: Proj['P'], labels: Lab[], L: number | [number, number, number] = 3, neg = 0.6, names = ['x', 'y', 'z']) {
  const [lx, ly, lz] = typeof L === 'number' ? [L, L, L] : L;
  const O = P([0, 0, 0]);
  const ends: [V3, string][] = [[[lx, 0, 0], 'x'], [[0, ly, 0], 'y'], [[0, 0, lz], 'z']];
  ends.forEach(([e], i) => { if (names[i]) labels.push(lab(P(mul3(e, 1.07)), names[i], 'c', 'g')); });
  return (
    <g>
      {ends.map(([e], i) => <Line key={'n' + i} a={O} b={P(mul3(e, -neg / len3(e)))} cls="faint" />)}
      {ends.map(([e], i) => <Arrow key={i} a={O} b={P(e)} c="g" w={1.1} head={9} />)}
    </g>
  );
}

export function Arrow3({ P, a, b, c = 'ink', w, head, double, o }: { P: Proj['P']; a: V3; b: V3; c?: Ink; w?: number; head?: number; double?: boolean; o?: number }) {
  return <Arrow a={P(a)} b={P(b)} c={c} w={w} head={head} double={double} o={o} />;
}
export function Path3({ P, p, cls = 'ink', w, closed, o }: { P: Proj['P']; p: V3[]; cls?: string; w?: number; closed?: boolean; o?: number }) {
  return <Poly p={p.map(P) as V2[]} cls={cls} w={w} closed={closed} o={o} />;
}
export const along = (a: V3, b: V3, k: number): V3 => add3(a, mul3(sub3(b, a), k));
