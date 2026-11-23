/** Function plots: a view window mapped into a box of the figure, axes with ticks, curves split at gaps. */
import type { V2 } from '../lib/vec';
import { Arrow, Line, lab, type Lab } from './svg';
import { num } from './Tex';

export interface View { x0: number; x1: number; y0: number; y1: number }
export interface Box { l: number; t: number; r: number; b: number }

export function plotter(v: View, box: Box) {
  const sx = (box.r - box.l) / (v.x1 - v.x0), sy = (box.b - box.t) / (v.y1 - v.y0);
  const X = (p: V2): V2 => [box.l + (p[0] - v.x0) * sx, box.b - (p[1] - v.y0) * sy];
  return { X, sx, sy, v, box };
}
export type Plotter = ReturnType<typeof plotter>;

/** «Nice» tick values between a and b (1, 2, 5 × 10^k). */
export function niceTicks(a: number, b: number, target = 6): number[] {
  const raw = (b - a) / target, p = 10 ** Math.floor(Math.log10(raw));
  const step = [1, 2, 5, 10].map((k) => k * p).find((s) => s >= raw) ?? 10 * p;
  const out: number[] = [];
  for (let x = Math.ceil(a / step) * step; x <= b + 1e-9 * step; x += step) out.push(Math.abs(x) < 1e-12 * step ? 0 : x);
  return out;
}
const digitsFor = (ticks: number[]) => {
  if (ticks.length < 2) return 0;
  const step = Math.abs(ticks[1] - ticks[0]);
  return Math.max(0, Math.min(6, Math.ceil(-Math.log10(step) + 1e-9)));
};

/** Axes through the origin (or along the box edge when 0 is outside the window). */
export function axes2(P: Plotter, labels: Lab[], o: {
  xt?: number[] | false; yt?: number[] | false; xl?: string; yl?: string; skipZero?: boolean; xFmt?: (x: number) => string; yFmt?: (y: number) => string;
} = {}) {
  const { v, X } = P;
  const y0 = Math.min(Math.max(0, v.y0), v.y1), x0 = Math.min(Math.max(0, v.x0), v.x1);
  const ax = X([v.x0, y0]), bx = X([v.x1, y0]), ay = X([x0, v.y0]), by = X([x0, v.y1]);
  const xt = o.xt === false ? [] : o.xt ?? niceTicks(v.x0, v.x1, 7);
  const yt = o.yt === false ? [] : o.yt ?? niceTicks(v.y0, v.y1, 5);
  const dx = digitsFor(xt), dy = digitsFor(yt);
  const els = [
    <Arrow key="ax" a={[ax[0] - 6, ax[1]]} b={[bx[0] + 14, bx[1]]} c="g" w={1} head={8} />,
    <Arrow key="ay" a={[ay[0], ay[1] + 6]} b={[by[0], by[1] - 14]} c="g" w={1} head={8} />,
  ];
  for (const x of xt) {
    if (o.skipZero !== false && x === 0 && x0 === 0) continue;
    const p = X([x, y0]);
    els.push(<Line key={'tx' + x} a={[p[0], p[1] - 3.5]} b={[p[0], p[1] + 3.5]} cls="ln-g" />);
    labels.push({ x: p[0], y: p[1] + 5, tex: o.xFmt ? o.xFmt(x) : num(x, dx), pos: 'b', c: 'g', size: 's' });
  }
  for (const y of yt) {
    if (o.skipZero !== false && y === 0 && y0 === 0) continue;
    const p = X([x0, y]);
    els.push(<Line key={'ty' + y} a={[p[0] - 3.5, p[1]]} b={[p[0] + 3.5, p[1]]} cls="ln-g" />);
    labels.push({ x: p[0] - 5, y: p[1], tex: o.yFmt ? o.yFmt(y) : num(y, dy), pos: 'l', c: 'g', size: 's' });
  }
  if (o.xl) labels.push(lab([bx[0] + 16, bx[1]], o.xl, 'r', 'g'));
  if (o.yl) labels.push(lab([by[0] + 6, by[1] - 8], o.yl, 'r', 'g'));
  return <g>{els}</g>;
}

/** Sample y = f(x) on [a, b]; split the polyline where the value leaves a generous margin or is not finite. */
export function sample(P: Plotter, f: (x: number) => number, a: number, b: number, n = 400): V2[][] {
  const { v } = P, h = v.y1 - v.y0, lo = v.y0 - 2 * h, hi = v.y1 + 2 * h;
  const out: V2[][] = [];
  let cur: V2[] = [];
  for (let i = 0; i <= n; i++) {
    const x = a + ((b - a) * i) / n, y = f(x);
    if (!Number.isFinite(y) || y < lo || y > hi) { if (cur.length > 1) out.push(cur); cur = []; continue; }
    cur.push(P.X([x, y]));
  }
  if (cur.length > 1) out.push(cur);
  return out;
}

/** Clip-path id for a plot box (curves stay inside the window). */
export function ClipBox({ id, box, pad = 0 }: { id: string; box: Box; pad?: number }) {
  return <defs><clipPath id={id}><rect x={box.l - pad} y={box.t - pad} width={box.r - box.l + 2 * pad} height={box.b - box.t + 2 * pad} /></clipPath></defs>;
}
