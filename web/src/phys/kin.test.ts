import { describe, expect, it } from 'vitest';
import { dot, len, sub, unit, type V2 } from '../lib/vec';
import { ladder, path, pathVel, rolling, sliderCrank } from './kin';

const num = (f: (t: number) => V2, t: number, h = 1e-6): V2 => {
  const a = f(t + h), b = f(t - h);
  return [(a[0] - b[0]) / (2 * h), (a[1] - b[1]) / (2 * h)];
};

describe('rolling without sliding', () => {
  const R = 1, v = 1.3;
  it('contact point at rest, hub v, top 2v', () => {
    const w = rolling(R, v, 2.1);
    expect(len(w.vel(w.Z))).toBe(0);
    const vO = w.vel(w.O), top = w.vel([w.O[0], 2 * R]);
    expect(vO[0]).toBeCloseTo(v); expect(vO[1]).toBeCloseTo(0);
    expect(top[0]).toBeCloseTo(2 * v); expect(top[1]).toBeCloseTo(0);
  });
  it('a material point moves with v = ω × ZP (numerical derivative of its place)', () => {
    for (const beta of [0.3, 1.7, 4.0]) {
      const place = (t: number) => rolling(R, v, v * t).point(beta);
      const t = 1.234, w = rolling(R, v, v * t);
      const vn = num(place, t), va = w.vel(w.point(beta));
      expect(va[0]).toBeCloseTo(vn[0], 5); expect(va[1]).toBeCloseTo(vn[1], 5);
    }
  });
  it('the marked point lies on the rim and traces the cycloid', () => {
    const w = rolling(R, v, 3.3);
    expect(len(sub(w.marked, w.O))).toBeCloseTo(R);
    const m = w.point(-Math.PI / 2); // the point that started at the bottom
    expect(m[0]).toBeCloseTo(w.marked[0]); expect(m[1]).toBeCloseTo(w.marked[1]);
  });
});

describe('ladder between wall and floor', () => {
  it('v = ω × ZP reproduces the motion of A, B and the midpoint', () => {
    const L = 3, a0 = 0.9, ad = -0.7;
    const at = (s: number) => (t: number) => ladder(L, a0 + ad * t, ad).at(s);
    const l = ladder(L, a0, ad);
    for (const s of [0, 0.5, 1, 0.3]) {
      const vn = num(at(s), 0), va = l.vel(l.at(s));
      expect(va[0]).toBeCloseTo(vn[0], 5); expect(va[1]).toBeCloseTo(vn[1], 5);
    }
  });
  it('Z lies on the circle of radius L about the corner (fixed polode) and on the circle over AB (moving polode)', () => {
    const l = ladder(2.5, 0.6, 1);
    expect(len(l.Z)).toBeCloseTo(2.5);
    expect(len(sub(l.Z, l.mid))).toBeCloseTo(1.25);
  });
});

describe('slider–crank: theorem of projected velocities', () => {
  it('v_A and v_B have equal projections on AB, and v_B is the derivative of x_B', () => {
    const r = 1, l = 2.6, w = 1.7;
    for (const phi of [0.2, 1.1, 2.5, 4.4]) {
      const s = sliderCrank(r, l, phi, w);
      const e = unit(sub(s.B, s.A));
      expect(dot(s.vA, e)).toBeCloseTo(dot(s.vB, e), 10);
      const xb = (t: number): V2 => sliderCrank(r, l, phi + w * t, w).B;
      expect(s.vB[0]).toBeCloseTo(num(xb, 0)[0], 5);
      expect(len(sub(s.B, s.A))).toBeCloseTo(l);
    }
  });
});

describe('plane path', () => {
  it('pathVel is the derivative of path', () => {
    for (const t of [0.1, 1, 2.7]) {
      const n = num(path, t), a = pathVel(t);
      expect(a[0]).toBeCloseTo(n[0], 5); expect(a[1]).toBeCloseTo(n[1], 5);
    }
  });
});
