import { describe, expect, it } from 'vitest';
import {
  altHarmonic, bisection, cabs, carg, cmul, cpow, darboux, diff, ellipse, evolute, roots, seqA, seqN, simpson, taylorRational, taylorSin,
} from './ana';

describe('sequence and ε', () => {
  it('N(ε) is the first index from which every term lies in the ε-band', () => {
    for (const eps of [0.5, 0.21, 0.07]) {
      const N = seqN(eps);
      expect(Math.abs(seqA(N) - 1)).toBeLessThan(eps);
      expect(Math.abs(seqA(N - 1) - 1)).toBeGreaterThanOrEqual(eps);
      for (let n = N; n < N + 200; n++) expect(Math.abs(seqA(n) - 1)).toBeLessThan(eps);
    }
  });
});

describe('bisection', () => {
  it('halves the bracket and keeps the sign change', () => {
    const f = (x: number) => x ** 3 - x - 1;
    const s = bisection(f, 0, 2, 30);
    s.forEach(([a, b], k) => { expect(b - a).toBeCloseTo(2 / 2 ** k, 12); expect(f(a)).toBeLessThan(0); expect(f(b)).toBeGreaterThanOrEqual(0); });
    expect(s[30][0]).toBeCloseTo(1.324717957, 8);
  });
});

describe('curvature of the ellipse', () => {
  it('ρ = a²/b at the end of the major axis; centre of curvature lies on the evolute', () => {
    const a = 3, b = 1.8;
    expect(ellipse(a, b, 0).rho).toBeCloseTo((b * b) / a);
    expect(ellipse(a, b, Math.PI / 2).rho).toBeCloseTo((a * a) / b);
    for (const t of [0.3, 1.1, 2.4, 4]) {
      const { C } = ellipse(a, b, t), E = evolute(a, b, t);
      expect(C[0]).toBeCloseTo(E[0]); expect(C[1]).toBeCloseTo(E[1]);
    }
  });
});

describe('complex numbers', () => {
  it('multiplying multiplies the lengths and adds the angles', () => {
    const z: [number, number] = [1.1, 0.7], w: [number, number] = [-0.4, 1.3];
    const p = cmul(z, w);
    expect(cabs(p)).toBeCloseTo(cabs(z) * cabs(w));
    expect(Math.cos(carg(p))).toBeCloseTo(Math.cos(carg(z) + carg(w)));
  });
  it('the n roots solve w^n = z', () => {
    const z: [number, number] = [-1.2, 0.9];
    for (const w of roots(z, 5)) { const q = cpow(w, 5); expect(q[0]).toBeCloseTo(z[0]); expect(q[1]).toBeCloseTo(z[1]); }
  });
});

describe('integrals', () => {
  const f = (x: number) => 1 + 0.6 * Math.sin(1.3 * x) + 0.05 * x * x;
  it('lower sum ≤ integral ≤ upper sum, and both close in', () => {
    const I = simpson(f, 0, 6);
    for (const n of [4, 16, 128]) { const d = darboux(f, 0, 6, n); expect(d.lo).toBeLessThanOrEqual(I + 1e-9); expect(d.up).toBeGreaterThanOrEqual(I - 1e-9); }
    const d = darboux(f, 0, 6, 512);
    expect(d.up - d.lo).toBeLessThan(0.05);
  });
  it('Simpson is exact for x³ and gives ∫₀^π sin = 2', () => {
    expect(simpson((x) => x ** 3, 0, 2)).toBeCloseTo(4, 10);
    expect(simpson(Math.sin, 0, Math.PI)).toBeCloseTo(2, 10);
  });
  it('fundamental theorem: d/dx ∫ₐˣ f = f(x)', () => {
    const F = (x: number) => simpson(f, 0, x, 4000);
    for (const x of [1, 2.5, 4.2]) expect(diff(F, x, 1e-3)).toBeCloseTo(f(x), 5);
  });
});

describe('series', () => {
  it('Taylor polynomials of sin converge (degree 19 at x = 5)', () => {
    expect(taylorSin(0.7, 1)).toBeCloseTo(0.7);
    expect(taylorSin(5, 19)).toBeCloseTo(Math.sin(5), 4);
  });
  it('1/(1+x²): converges inside |x| < 1, diverges outside', () => {
    expect(taylorRational(0.6, 60)).toBeCloseTo(1 / 1.36, 8);
    expect(Math.abs(taylorRational(1.1, 60))).toBeGreaterThan(50);
  });
  it('alternating harmonic series → ln 2, and ln 2 lies between neighbouring partial sums', () => {
    expect(altHarmonic(100000)).toBeCloseTo(Math.LN2, 4);
    for (let n = 1; n < 30; n++) {
      const a = altHarmonic(n), b = altHarmonic(n + 1);
      expect(Math.min(a, b)).toBeLessThan(Math.LN2); expect(Math.max(a, b)).toBeGreaterThan(Math.LN2);
    }
  });
});
