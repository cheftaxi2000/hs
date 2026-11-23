import type { HTMLAttributes, ReactNode } from 'react';
import { add, len, mul, perp, sub, unit, type V2 } from '../lib/vec';
import { texHtml } from './Tex';

/** Meaning colours (as in the Lernskript): v velocity, f force, m moment / rotation. */
export type Ink = 'ink' | 'v' | 'f' | 'm' | 'g' | 'k';

export interface Lab { x: number; y: number; tex: string; pos?: Pos; c?: Ink; o?: number; size?: 's' | 'm' | 'l' }
export type Pos = 'c' | 'r' | 'l' | 't' | 'b' | 'tr' | 'tl' | 'br' | 'bl';
export const lab = (p: V2, tex: string, pos: Pos = 'r', c: Ink = 'ink', o = 1): Lab => ({ x: p[0], y: p[1], tex, pos, c, o });

/**
 * A figure: an SVG drawing in viewBox units plus a layer of KaTeX labels placed in the same coordinates.
 * The labels scale with the figure (container query units), so the picture keeps its proportions on any screen.
 */
export function Fig({ w, h, labels = [], children, readout, className = '', ...rest }:
  { w: number; h: number; labels?: Lab[]; children: ReactNode; readout?: string } & HTMLAttributes<HTMLDivElement>) {
  return (
    <div className={'figwrap ' + className} {...rest}>
    <div className="fig" style={{ aspectRatio: `${w} / ${h}` }}>
      <svg viewBox={`0 0 ${w} ${h}`} aria-hidden="true">{children}</svg>
      <div className="labels" aria-hidden="true">
        {labels.map((l, i) => (l.o ?? 1) > 0.02 && (
          <span key={i} className={`lab p-${l.pos ?? 'r'} c-${l.c ?? 'ink'} z-${l.size ?? 'm'}`}
            style={{ left: `${(l.x / w) * 100}%`, top: `${(l.y / h) * 100}%`, opacity: l.o ?? 1 }}
            dangerouslySetInnerHTML={{ __html: texHtml(l.tex) }} />
        ))}
      </div>
    </div>
      {readout && <div className="readout" dangerouslySetInnerHTML={{ __html: texHtml(readout) }} />}
    </div>
  );
}

const pts = (p: readonly V2[]) => p.map((q) => `${q[0].toFixed(2)},${q[1].toFixed(2)}`).join(' ');
export const pathD = (p: readonly V2[], closed = false) =>
  p.length ? 'M' + p.map((q) => `${q[0].toFixed(2)} ${q[1].toFixed(2)}`).join('L') + (closed ? 'Z' : '') : '';

export function Line({ a, b, cls = 'ink', w, o }: { a: V2; b: V2; cls?: string; w?: number; o?: number }) {
  return <line x1={a[0]} y1={a[1]} x2={b[0]} y2={b[1]} className={'ln ' + cls} style={w ? { strokeWidth: w } : undefined} opacity={o} />;
}
export function Poly({ p, cls = 'ink', closed = false, w, o }: { p: readonly V2[]; cls?: string; closed?: boolean; w?: number; o?: number }) {
  const st = w ? { strokeWidth: w } : undefined;
  return closed ? <polygon points={pts(p)} className={'ln ' + cls} style={st} opacity={o} />
    : <polyline points={pts(p)} className={'ln ' + cls} style={st} opacity={o} />;
}

/**
 * A vector arrow from a to b. Slender notched head of constant size; the shaft stops in the notch.
 * `double` draws the double head used for moment and angular-velocity vectors.
 */
export function Arrow({ a, b, c = 'ink', w = 1.7, head = 11, double = false, o = 1, dash = false }:
  { a: V2; b: V2; c?: Ink; w?: number; head?: number; double?: boolean; o?: number; dash?: boolean }) {
  const L = len(sub(b, a));
  if (L < 1.5 || o < 0.02) return null;
  const h = Math.min(head, L * (double ? 0.38 : 0.55));
  const u = unit(sub(b, a)), n = perp(u);
  const tri = (tip: V2) => {
    const back = add(tip, mul(u, -h)), notch = add(tip, mul(u, -h * 0.78));
    return { poly: [tip, add(back, mul(n, h * 0.34)), notch, add(back, mul(n, -h * 0.34))] as V2[], notch };
  };
  const t1 = tri(b);
  const t2 = double ? tri(add(b, mul(u, -h * 0.62))) : null;
  const end = double ? add(b, mul(u, -h * 0.62 - h * 0.6)) : t1.notch;
  return (
    <g className={'arrow c-' + c} opacity={o}>
      <line x1={a[0]} y1={a[1]} x2={end[0]} y2={end[1]} strokeWidth={w} strokeDasharray={dash ? '5 4' : undefined} />
      <polygon points={pts(t1.poly)} />
      {t2 && <polygon points={pts(t2.poly)} />}
    </g>
  );
}

/** A circular arrow (sense of rotation) about c, radius r, from angle a0 to a1 (SVG angles, y down). */
export function ArcArrow({ c, r, a0, a1, ink = 'm', w = 1.6, o = 1 }: { c: V2; r: number; a0: number; a1: number; ink?: Ink; w?: number; o?: number }) {
  const n = 40, p: V2[] = [];
  const head = 10, dir = Math.sign(a1 - a0) || 1;
  const a1s = a1 - dir * (head * 0.75) / r;
  for (let i = 0; i <= n; i++) { const a = a0 + ((a1s - a0) * i) / n; p.push([c[0] + r * Math.cos(a), c[1] + r * Math.sin(a)]); }
  const tip: V2 = [c[0] + r * Math.cos(a1), c[1] + r * Math.sin(a1)];
  const from: V2 = [c[0] + r * Math.cos(a1 - dir * head / r), c[1] + r * Math.sin(a1 - dir * head / r)];
  return (
    <g opacity={o}>
      <polyline points={pts(p)} className={'ln c-' + ink + '-s'} style={{ strokeWidth: w }} />
      <Arrow a={from} b={tip} c={ink} w={0.01} head={head} />
    </g>
  );
}

export function Dot({ p, r = 3.4, c = 'ink', o }: { p: V2; r?: number; c?: Ink; o?: number }) {
  return <circle cx={p[0]} cy={p[1]} r={r} className={'dot c-' + c} opacity={o} />;
}
/** Hinge: small open circle. */
export function Hinge({ p, r = 4.6 }: { p: V2; r?: number }) {
  return <circle cx={p[0]} cy={p[1]} r={r} className="hinge" />;
}

/** A fixed surface from a to b, hatched on its left side (seen from a towards b). */
export function Ground({ a, b, gap = 9, depth = 9, o }: { a: V2; b: V2; gap?: number; depth?: number; o?: number }) {
  const L = len(sub(b, a)), u = unit(sub(b, a)), n = perp(u);
  const hatch: string[] = [];
  const kk = mul(unit(add(mul(u, -1), n)), depth * 1.25);
  for (let s = gap * 0.6; s < L; s += gap) {
    const p = add(a, mul(u, s));
    const q = add(p, kk);
    hatch.push(`M${p[0].toFixed(1)} ${p[1].toFixed(1)}L${q[0].toFixed(1)} ${q[1].toFixed(1)}`);
  }
  return (
    <g opacity={o}>
      <path d={hatch.join('')} className="ln hatch" />
      <line x1={a[0]} y1={a[1]} x2={b[0]} y2={b[1]} className="ln ink" style={{ strokeWidth: 1.4 }} />
    </g>
  );
}

/** Festlager (pin support): hinge at p, triangle below, hatched ground. Rotated by `angle` (rad, 0 = upright). */
export function PinSupport({ p, s = 1, angle = 0 }: { p: V2; s?: number; angle?: number }) {
  const R = (q: V2): V2 => { const c = Math.cos(angle), si = Math.sin(angle); return [p[0] + s * (c * q[0] - si * q[1]), p[1] + s * (si * q[0] + c * q[1])]; };
  const h = 19, b = 12.5;
  return (
    <g>
      <polygon points={pts([R([0, 0]), R([-b, h]), R([b, h])])} className="ln ink support" />
      <Ground a={R([-b - 7, h])} b={R([b + 7, h])} />
      <Hinge p={p} r={4.4 * s} />
    </g>
  );
}
/** Loslager (roller support): like the pin support, with a gap line (it may slide along the ground). */
export function RollerSupport({ p, s = 1, angle = 0 }: { p: V2; s?: number; angle?: number }) {
  const R = (q: V2): V2 => { const c = Math.cos(angle), si = Math.sin(angle); return [p[0] + s * (c * q[0] - si * q[1]), p[1] + s * (si * q[0] + c * q[1])]; };
  const h = 19, b = 12.5;
  return (
    <g>
      <polygon points={pts([R([0, 0]), R([-b, h]), R([b, h])])} className="ln ink support" />
      <Line a={R([-b - 3, h + 5])} b={R([b + 3, h + 5])} w={1.4} />
      <Ground a={R([-b - 7, h + 9])} b={R([b + 7, h + 9])} />
      <Hinge p={p} r={4.4 * s} />
    </g>
  );
}

/** Angle arc at c from direction a0 to a1 (SVG angles). */
export function AngleArc({ c, r, a0, a1, cls = 'k', w = 1.2 }: { c: V2; r: number; a0: number; a1: number; cls?: string; w?: number }) {
  const n = Math.max(6, Math.ceil(Math.abs(a1 - a0) * 12));
  const p: V2[] = [];
  for (let i = 0; i <= n; i++) { const a = a0 + ((a1 - a0) * i) / n; p.push([c[0] + r * Math.cos(a), c[1] + r * Math.sin(a)]); }
  return <polyline points={pts(p)} className={'ln ' + cls} style={{ strokeWidth: w }} />;
}

/** World (y up, metres) → SVG (y down, px). */
export interface Frame { ox: number; oy: number; s: number }
export const toSvg = (f: Frame) => (p: V2): V2 => [f.ox + f.s * p[0], f.oy - f.s * p[1]];
