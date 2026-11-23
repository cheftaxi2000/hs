/** Small, dependency-free vector algebra (2D and 3D). Tuples keep scenes cheap to build every frame. */
export type V2 = readonly [number, number];
export type V3 = readonly [number, number, number];

export const add = (a: V2, b: V2): V2 => [a[0] + b[0], a[1] + b[1]];
export const sub = (a: V2, b: V2): V2 => [a[0] - b[0], a[1] - b[1]];
export const mul = (a: V2, k: number): V2 => [a[0] * k, a[1] * k];
export const dot = (a: V2, b: V2) => a[0] * b[0] + a[1] * b[1];
export const cross2 = (a: V2, b: V2) => a[0] * b[1] - a[1] * b[0];
export const len = (a: V2) => Math.hypot(a[0], a[1]);
export const unit = (a: V2): V2 => { const l = len(a) || 1; return [a[0] / l, a[1] / l]; };
/** a turned by +90° (counter-clockwise). */
export const perp = (a: V2): V2 => [-a[1], a[0]];
export const lerp = (a: V2, b: V2, t: number): V2 => [a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t];
export const polar = (r: number, phi: number): V2 => [r * Math.cos(phi), r * Math.sin(phi)];
export const rot = (a: V2, phi: number): V2 => {
  const c = Math.cos(phi), s = Math.sin(phi);
  return [c * a[0] - s * a[1], s * a[0] + c * a[1]];
};
/** ω e_z × r in the plane. */
export const omegaCross = (w: number, r: V2): V2 => [-w * r[1], w * r[0]];

/** Intersection of the lines p + s·u and q + t·v (null when parallel). */
export function intersect(p: V2, u: V2, q: V2, v: V2): V2 | null {
  const d = cross2(u, v);
  if (Math.abs(d) < 1e-12) return null;
  const s = cross2(sub(q, p), v) / d;
  return add(p, mul(u, s));
}

export const add3 = (a: V3, b: V3): V3 => [a[0] + b[0], a[1] + b[1], a[2] + b[2]];
export const sub3 = (a: V3, b: V3): V3 => [a[0] - b[0], a[1] - b[1], a[2] - b[2]];
export const mul3 = (a: V3, k: number): V3 => [a[0] * k, a[1] * k, a[2] * k];
export const dot3 = (a: V3, b: V3) => a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
export const cross3 = (a: V3, b: V3): V3 => [
  a[1] * b[2] - a[2] * b[1],
  a[2] * b[0] - a[0] * b[2],
  a[0] * b[1] - a[1] * b[0],
];
export const len3 = (a: V3) => Math.hypot(a[0], a[1], a[2]);
export const unit3 = (a: V3): V3 => { const l = len3(a) || 1; return [a[0] / l, a[1] / l, a[2] / l]; };

export const clamp = (x: number, a: number, b: number) => Math.min(b, Math.max(a, x));
/** 0 → 1 between a and b. */
export const seg = (t: number, a: number, b: number) => clamp((t - a) / (b - a), 0, 1);
/** Smooth (cubic) ease in and out. */
export const ease = (x: number) => x * x * (3 - 2 * x);
export const TAU = Math.PI * 2;
export const deg = (d: number) => (d * Math.PI) / 180;
