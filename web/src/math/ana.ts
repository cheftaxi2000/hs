/** Analysis I: every curve, sum and root drawn on the Analysis plates comes from here. */
import type { V2 } from '../lib/vec';

/* ---------- 1 sequences ---------- */
/** a_n = 1 + (−1)^n · c/n converges to 1; |a_n − 1| < ε exactly for n > c/ε. */
export const seqA = (n: number, c = 1.2) => 1 + ((-1) ** n * c) / n;
export const seqN = (eps: number, c = 1.2) => Math.floor(c / eps) + 1;

/** Bisection steps for a continuous f with f(a) < 0 < f(b). */
export function bisection(f: (x: number) => number, a: number, b: number, steps: number): [number, number][] {
  const out: [number, number][] = [[a, b]];
  for (let k = 0; k < steps; k++) {
    const m = (a + b) / 2;
    if (f(m) < 0) a = m; else b = m;
    out.push([a, b]);
  }
  return out;
}

/* ---------- 2 differential calculus ---------- */
export const diff = (f: (x: number) => number, x: number, h = 1e-5) => (f(x + h) - f(x - h)) / (2 * h);

/** Ellipse x = a cos t, y = b sin t: curvature, centre of curvature, evolute. */
export function ellipse(a: number, b: number, t: number) {
  const P: V2 = [a * Math.cos(t), b * Math.sin(t)];
  const d: V2 = [-a * Math.sin(t), b * Math.cos(t)];
  const dd: V2 = [-a * Math.cos(t), -b * Math.sin(t)];
  const sp = Math.hypot(d[0], d[1]);
  const kappa = (d[0] * dd[1] - d[1] * dd[0]) / sp ** 3;
  const n: V2 = [-d[1] / sp, d[0] / sp]; // left normal (towards the centre for this orientation)
  const rho = 1 / kappa;
  const C: V2 = [P[0] + rho * n[0], P[1] + rho * n[1]];
  return { P, kappa, rho, C, n };
}
export const evolute = (a: number, b: number, t: number): V2 => [((a * a - b * b) / a) * Math.cos(t) ** 3, ((b * b - a * a) / b) * Math.sin(t) ** 3];

/* ---------- 3 complex numbers (as [re, im]) ---------- */
export type C = V2;
export const cmul = (z: C, w: C): C => [z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0]];
export const cabs = (z: C) => Math.hypot(z[0], z[1]);
export const carg = (z: C) => Math.atan2(z[1], z[0]);
export const cexp = (r: number, phi: number): C => [r * Math.cos(phi), r * Math.sin(phi)];
export const cpow = (z: C, n: number): C => { let w: C = [1, 0]; for (let k = 0; k < n; k++) w = cmul(w, z); return w; };
/** All n solutions of w^n = z. */
export function roots(z: C, n: number): C[] {
  const r = Math.pow(cabs(z), 1 / n), p = carg(z);
  return Array.from({ length: n }, (_, k) => cexp(r, (p + 2 * Math.PI * k) / n));
}

/* ---------- 4 integral calculus ---------- */
/** Lower and upper sum on n equal parts (extremes on each part found by sampling plus the end points). */
export function darboux(f: (x: number) => number, a: number, b: number, n: number) {
  const h = (b - a) / n;
  let lo = 0, up = 0;
  const parts: { x0: number; x1: number; m: number; M: number }[] = [];
  for (let i = 0; i < n; i++) {
    const x0 = a + i * h, x1 = x0 + h;
    let m = Infinity, M = -Infinity;
    for (let k = 0; k <= 24; k++) { const y = f(x0 + (h * k) / 24); m = Math.min(m, y); M = Math.max(M, y); }
    lo += m * h; up += M * h;
    parts.push({ x0, x1, m, M });
  }
  return { lo, up, parts };
}
/** Composite Simpson rule (for the exact values printed next to the sums). */
export function simpson(f: (x: number) => number, a: number, b: number, n = 2000) {
  const h = (b - a) / n;
  let s = f(a) + f(b);
  for (let i = 1; i < n; i++) s += f(a + i * h) * (i % 2 ? 4 : 2);
  return (s * h) / 3;
}

/* ---------- 5 series ---------- */
/** Taylor polynomial of sin about 0 up to degree n. */
export function taylorSin(x: number, n: number) {
  let s = 0, term = x;
  for (let k = 1; k <= n; k += 2) { s += term; term *= (-x * x) / ((k + 1) * (k + 2)); }
  return s;
}
/** Taylor polynomial of 1/(1 + x²) about 0 up to degree 2m: Σ (−1)^k x^{2k}. */
export const taylorRational = (x: number, m: number) => { let s = 0, t = 1; for (let k = 0; k <= m; k++) { s += t; t *= -x * x; } return s; };
/** Partial sums of the alternating harmonic series. */
export const altHarmonic = (n: number) => { let s = 0; for (let k = 1; k <= n; k++) s += (k % 2 ? 1 : -1) / k; return s; };
