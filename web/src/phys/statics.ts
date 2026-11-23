/** Statics used by the plates of chapters 4–14. Every drawn force comes from here. */
import { add, cross2, len, mul, sub, unit, type V2 } from '../lib/vec';

/* ---------- 4 line load: trapezoid q0 → q1 over length L ---------- */
export function trapezoid(q0: number, q1: number, L: number) {
  const R = ((q0 + q1) * L) / 2;
  const xS = (L * (q0 + 2 * q1)) / (3 * (q0 + q1));
  const q = (x: number) => q0 + ((q1 - q0) * x) / L;
  return { R, xS, q };
}

/* ---------- 9 beam on a pin (x = 0) and a roller (x = L), force F at x = a, direction angle β (from +x) ---------- */
export function beamReactions(L: number, a: number, F: number, beta: number) {
  const Fx = F * Math.cos(beta), Fy = F * Math.sin(beta);
  const B = (-Fy * a) / L; // vertical (positive up)
  const Ay = -Fy - B;
  const Ax = -Fx;
  return { Ax, Ay, B };
}

/* ---------- 14 simply supported beam: uniform q over [0, L] and point load F (down) at a ---------- */
export function beamInternal(L: number, q: number, F: number, a: number) {
  const A = (q * L) / 2 + (F * (L - a)) / L;
  const B = q * L + F - A;
  const Q = (x: number) => A - q * x - (x > a ? F : 0);
  const M = (x: number) => A * x - (q * x * x) / 2 - (x > a ? F * (x - a) : 0);
  return { A, B, Q, M };
}

/* ---------- 10 three-hinged arch: pins A, B on the ground, hinge G, vertical load F (down) at P ---------- */
export function threeHinged(A: V2, B: V2, G: V2, P: V2, F: number) {
  const Fv: V2 = [0, -F];
  // the unloaded part is a two-force member: its support force points along the line support → G
  const leftLoaded = P[0] <= G[0];
  const S = leftLoaded ? B : A, other = leftLoaded ? A : B;
  const e = unit(sub(G, S));
  // moment about the other support: (S − other) × s·e + (P − other) × Fv = 0
  const s = -cross2(sub(P, other), Fv) / cross2(sub(S, other), e);
  const RS = mul(e, s);
  const RO = mul(add(Fv, RS), -1);
  const RA = leftLoaded ? RO : RS, RB = leftLoaded ? RS : RO;
  return { RA, RB, leftLoaded };
}

/* ---------- 11 plane truss, method of joints: unknowns = member forces (tension +) and support reactions ---------- */
export interface Truss { nodes: V2[]; members: [number, number][]; supports: { node: number; dir: V2 }[] }
export function solveTruss(T: Truss, loads: V2[]): { S: number[]; R: number[] } {
  const n = T.nodes.length, m = T.members.length, r = T.supports.length;
  const N = 2 * n;
  if (m + r !== N) throw new Error('truss is not statically determinate by counting');
  const A: number[][] = Array.from({ length: N }, () => new Array(N).fill(0));
  const b = new Array(N).fill(0);
  T.members.forEach(([i, j], k) => {
    const e = unit(sub(T.nodes[j], T.nodes[i])); // tension pulls node i towards j
    A[2 * i][k] += e[0]; A[2 * i + 1][k] += e[1];
    A[2 * j][k] -= e[0]; A[2 * j + 1][k] -= e[1];
  });
  T.supports.forEach(({ node, dir }, k) => { A[2 * node][m + k] += dir[0]; A[2 * node + 1][m + k] += dir[1]; });
  loads.forEach((f, i) => { b[2 * i] -= f[0]; b[2 * i + 1] -= f[1]; });
  const x = gauss(A, b);
  return { S: x.slice(0, m), R: x.slice(m) };
}
export function gauss(A0: number[][], b0: number[]): number[] {
  const n = b0.length, A = A0.map((r, i) => [...r, b0[i]]);
  for (let c = 0; c < n; c++) {
    let p = c;
    for (let r = c + 1; r < n; r++) if (Math.abs(A[r][c]) > Math.abs(A[p][c])) p = r;
    if (Math.abs(A[p][c]) < 1e-12) throw new Error('singular system');
    [A[c], A[p]] = [A[p], A[c]];
    for (let r = 0; r < n; r++) {
      if (r === c) continue;
      const f = A[r][c] / A[c][c];
      if (f !== 0) for (let k = c; k <= n; k++) A[r][k] -= f * A[c][k];
    }
  }
  return A.map((r, i) => r[n] / r[i]);
}
/** Pratt truss with `panels` bays of width w and height h. Pin at the left end, roller at the right. */
export function pratt(panels: number, w: number, h: number): Truss {
  const nodes: V2[] = [];
  for (let i = 0; i <= panels; i++) nodes.push([i * w, 0]);
  const top = (i: number) => panels + i; // top node above bottom node i, i = 1 … panels − 1
  for (let i = 1; i < panels; i++) nodes.push([i * w, h]);
  const members: [number, number][] = [];
  for (let i = 0; i < panels; i++) members.push([i, i + 1]);
  for (let i = 1; i < panels - 1; i++) members.push([top(i), top(i + 1)]);
  for (let i = 1; i < panels; i++) members.push([i, top(i)]);
  members.push([0, top(1)], [panels, top(panels - 1)]);
  const half = panels / 2;
  for (let i = 1; i < panels - 1; i++) members.push(i < half ? [top(i), i + 1] : [top(i + 1), i]);
  return { nodes, members, supports: [{ node: 0, dir: [1, 0] }, { node: 0, dir: [0, 1] }, { node: panels, dir: [0, 1] }] };
}

/* ---------- 12 block on an inclined plane ---------- */
export function incline(alpha: number, mu0: number, mu: number, G: number) {
  const sticks = Math.tan(alpha) <= mu0;
  const N = G * Math.cos(alpha);
  const H = sticks ? G * Math.sin(alpha) : mu * N; // friction, up the slope
  const a = sticks ? 0 : 9.81 * (Math.sin(alpha) - mu * Math.cos(alpha)) / 1; // per unit G/m = g
  return { sticks, N, H, a };
}

/* ---------- 13 catenary between (±b, 0) with rope length l: y = a cosh(x/a) − a cosh(b/a) ---------- */
export function catenaryParam(b: number, l: number): number {
  if (l <= 2 * b) throw new Error('rope too short');
  // l = 2a sinh(b/a) decreases in a; bisection on a
  let lo = 1e-3, hi = 1e3;
  for (let k = 0; k < 200; k++) {
    const mid = Math.sqrt(lo * hi);
    if (2 * mid * Math.sinh(b / mid) > l) lo = mid; else hi = mid;
  }
  return Math.sqrt(lo * hi);
}
export const catenary = (a: number, b: number) => (x: number) => a * Math.cosh(x / a) - a * Math.cosh(b / a);

/* ---------- 13 rope friction (Euler–Eytelwein) ---------- */
export const capstan = (S1: number, mu: number, alpha: number) => S1 * Math.exp(mu * alpha);

/* ---------- 7 centroid of a plate made of rectangles (holes: negative area) ---------- */
export function centroid(rects: { x0: number; y0: number; x1: number; y1: number; hole?: boolean }[]) {
  let A = 0, Sx = 0, Sy = 0;
  for (const r of rects) {
    const a = (r.x1 - r.x0) * (r.y1 - r.y0) * (r.hole ? -1 : 1);
    A += a; Sx += a * (r.x0 + r.x1) / 2; Sy += a * (r.y0 + r.y1) / 2;
  }
  return { A, S: [Sx / A, Sy / A] as V2 };
}
/** Polar moment of the plate about its centroid, per unit areal mass. */
export function polarMoment(rects: { x0: number; y0: number; x1: number; y1: number; hole?: boolean }[], about: V2) {
  let J = 0;
  for (const r of rects) {
    const w = r.x1 - r.x0, h = r.y1 - r.y0, a = w * h * (r.hole ? -1 : 1);
    const c: V2 = [(r.x0 + r.x1) / 2, (r.y0 + r.y1) / 2];
    J += a * ((w * w + h * h) / 12 + len(sub(c, about)) ** 2);
  }
  return J;
}

/* ---------- 8 scissor lift with n crosses of bar length 2a: PdvL gives the force F at the roller ---------- */
export const scissorForce = (G: number, alpha: number, n: number) => n * G / Math.tan(alpha);
