/** Kinematics used by the plates of chapters 2 and 3. Every figure takes its numbers from here. */
import { add, omegaCross, sub, type V2 } from '../lib/vec';

/* ---------- rolling wheel (radius R, hub speed v, rolling to the right) ---------- */
export function rolling(R: number, v: number, xO: number) {
  const omega = -v / R; // clockwise: ω = −(v/R) e_z
  const theta = xO / R; // angle turned since the marked point touched the ground at x = 0
  const O: V2 = [xO, R];
  const Z: V2 = [xO, 0];
  /** Material point at polar angle β (from the hub, measured at θ = 0) → its place now. */
  const point = (beta: number): V2 => add(O, [R * Math.cos(beta - theta), R * Math.sin(beta - theta)]);
  const vel = (P: V2): V2 => omegaCross(omega, sub(P, Z));
  /** Cycloid: the marked point that touched the ground at x = 0. */
  const marked: V2 = [R * (theta - Math.sin(theta)), R * (1 - Math.cos(theta))];
  return { omega, theta, O, Z, point, vel, marked };
}

/* ---------- ladder AB between wall (x = 0) and floor (y = 0), angle α against the floor ---------- */
export function ladder(L: number, alpha: number, alphaDot: number) {
  const A: V2 = [L * Math.cos(alpha), 0];
  const B: V2 = [0, L * Math.sin(alpha)];
  const Z: V2 = [A[0], B[1]]; // normals to both guides meet here
  const omega = -alphaDot; // body angle is π − α
  const vel = (P: V2): V2 => omegaCross(omega, sub(P, Z));
  const at = (s: number): V2 => [A[0] + (B[0] - A[0]) * s, A[1] + (B[1] - A[1]) * s];
  return { A, B, Z, omega, vel, at, mid: at(0.5) };
}

/* ---------- slider–crank: crank OA (radius r) turns with ω, rod AB (length l), B slides on the x-axis ---------- */
export function sliderCrank(r: number, l: number, phi: number, omega: number) {
  const A: V2 = [r * Math.cos(phi), r * Math.sin(phi)];
  const root = Math.sqrt(l * l - r * r * Math.sin(phi) ** 2);
  const B: V2 = [r * Math.cos(phi) + root, 0];
  const vA: V2 = omegaCross(omega, A);
  const vB: V2 = [(-r * Math.sin(phi) - (r * r * Math.sin(phi) * Math.cos(phi)) / root) * omega, 0];
  return { A, B, vA, vB };
}

/* ---------- a plane path for the secant → tangent picture ---------- */
/** An ellipse (semi-axes 3.3 and 1.85) with O in one focus, as for a planet. */
const EA = 3.3, EB = 1.85, EC = Math.sqrt(EA * EA - EB * EB);
export const path = (t: number): V2 => [EA * Math.cos(t) + EC, EB * Math.sin(t)];
export const pathVel = (t: number): V2 => [-EA * Math.sin(t), EB * Math.cos(t)];
