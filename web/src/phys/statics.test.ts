import { describe, expect, it } from 'vitest';
import { add, cross2, sub, type V2 } from '../lib/vec';
import {
  beamInternal, beamReactions, capstan, catenary, catenaryParam, centroid, incline, pratt, scissorForce, solveTruss,
  threeHinged, trapezoid,
} from './statics';

describe('line load', () => {
  it('resultant = area, at the centroid of the load area (numerical integral)', () => {
    const { R, xS, q } = trapezoid(1.2, 3.1, 5);
    let I = 0, Ix = 0; const n = 20000;
    for (let i = 0; i < n; i++) { const x = (5 * (i + 0.5)) / n; I += q(x) * 5 / n; Ix += x * q(x) * 5 / n; }
    expect(R).toBeCloseTo(I, 6); expect(xS).toBeCloseTo(Ix / I, 6);
  });
  it('triangle: x_S = 2L/3', () => expect(trapezoid(0, 2, 6).xS).toBeCloseTo(4));
});

describe('beam reactions', () => {
  it('sum of forces and of moments about A vanish', () => {
    const L = 6, a = 2.2, F = 3, beta = -1.1;
    const { Ax, Ay, B } = beamReactions(L, a, F, beta);
    expect(Ax + F * Math.cos(beta)).toBeCloseTo(0);
    expect(Ay + B + F * Math.sin(beta)).toBeCloseTo(0);
    expect(B * L + F * Math.sin(beta) * a).toBeCloseTo(0);
  });
});

describe('beam internal forces', () => {
  const L = 6, q = 1.5, F = 4, a = 4;
  const b = beamInternal(L, q, F, a);
  it('M vanishes at both supports, Q jumps by F under the load', () => {
    expect(b.M(0)).toBeCloseTo(0); expect(b.M(L)).toBeCloseTo(0);
    expect(b.Q(a - 1e-9) - b.Q(a + 1e-9)).toBeCloseTo(F);
    expect(b.Q(L)).toBeCloseTo(-b.B);
  });
  it("dM/dx = Q and dQ/dx = −q away from the load", () => {
    for (const x of [0.7, 2.5, 5.1]) {
      const h = 1e-5;
      expect((b.M(x + h) - b.M(x - h)) / (2 * h)).toBeCloseTo(b.Q(x), 5);
      expect((b.Q(x + h) - b.Q(x - h)) / (2 * h)).toBeCloseTo(-q, 5);
    }
  });
});

describe('three-hinged arch', () => {
  const A: V2 = [0, 0], B: V2 = [6, 0], G: V2 = [3, 2.6];
  for (const P of [[1.2, 1.9], [4.5, 1.8]] as V2[]) {
    it(`whole arch and both parts are in equilibrium (load at x = ${P[0]})`, () => {
      const F = 2, { RA, RB } = threeHinged(A, B, G, P, F);
      const Fv: V2 = [0, -F];
      const sum = add(add(RA, RB), Fv);
      expect(sum[0]).toBeCloseTo(0); expect(sum[1]).toBeCloseTo(0);
      // moment of everything acting on the left part about G vanishes
      const left = cross2(sub(A, G), RA) + (P[0] <= G[0] ? cross2(sub(P, G), Fv) : 0);
      expect(left).toBeCloseTo(0);
      const right = cross2(sub(B, G), RB) + (P[0] > G[0] ? cross2(sub(P, G), Fv) : 0);
      expect(right).toBeCloseTo(0);
    });
  }
});

describe('Pratt truss', () => {
  const T = pratt(6, 1, 1);
  it('m + 3 = 2k', () => expect(T.members.length + 3).toBe(2 * T.nodes.length));
  it('symmetric load: reactions F/2, mid bottom chord tension = M/h', () => {
    const loads: V2[] = T.nodes.map(() => [0, 0]);
    loads[3] = [0, -2];
    const { S, R } = solveTruss(T, loads);
    expect(R[1]).toBeCloseTo(1); expect(R[2]).toBeCloseTo(1); expect(R[0]).toBeCloseTo(0);
    // Ritter cut through bay 2–3: bottom chord 2–3 carries M(at top node above 2)/h = 1·2/1 = 2 (tension)
    const k = T.members.findIndex(([i, j]) => i === 2 && j === 3);
    expect(S[k]).toBeCloseTo(2);
    // every node in equilibrium (re-check from the forces)
    const res = T.nodes.map(() => [0, 0] as [number, number]);
    T.members.forEach(([i, j], m) => {
      const d = sub(T.nodes[j], T.nodes[i]), l = Math.hypot(d[0], d[1]);
      res[i][0] += S[m] * d[0] / l; res[i][1] += S[m] * d[1] / l; res[j][0] -= S[m] * d[0] / l; res[j][1] -= S[m] * d[1] / l;
    });
    T.supports.forEach(({ node, dir }, k2) => { res[node][0] += R[k2] * dir[0]; res[node][1] += R[k2] * dir[1]; });
    res.forEach((f, i) => { expect(f[0] + loads[i][0]).toBeCloseTo(0); expect(f[1] + loads[i][1]).toBeCloseTo(0); });
  });
});

describe('friction on an incline', () => {
  it('sticks up to tan α = μ0; while sticking the contact force is vertical', () => {
    const s = incline(0.4, 0.5, 0.4, 1);
    expect(s.sticks).toBe(true);
    // N along the normal, H up the slope: the sum is (0, G)
    const fx = -s.N * Math.sin(0.4) + s.H * Math.cos(0.4), fy = s.N * Math.cos(0.4) + s.H * Math.sin(0.4);
    expect(fx).toBeCloseTo(0); expect(fy).toBeCloseTo(1);
    expect(incline(Math.atan(0.5) + 0.01, 0.5, 0.4, 1).sticks).toBe(false);
  });
});

describe('catenary', () => {
  it('has the prescribed length and passes through the supports', () => {
    const b = 3, l = 7.4, a = catenaryParam(b, l), y = catenary(a, b);
    expect(2 * a * Math.sinh(b / a)).toBeCloseTo(l, 8);
    expect(y(b)).toBeCloseTo(0); expect(y(-b)).toBeCloseTo(0);
    let L = 0; const n = 4000;
    for (let i = 0; i < n; i++) { const x0 = -b + (2 * b * i) / n, x1 = -b + (2 * b * (i + 1)) / n; L += Math.hypot(x1 - x0, y(x1) - y(x0)); }
    expect(L).toBeCloseTo(l, 4);
  });
});

describe('rope friction', () => {
  it('Euler–Eytelwein: one full turn with μ = 0.3 multiplies by e^{0.6π} ≈ 6.59', () => {
    expect(capstan(1, 0.3, 2 * Math.PI)).toBeCloseTo(6.586, 3);
  });
});

describe('centroid', () => {
  it('L-shape from two rectangles', () => {
    const { S, A } = centroid([{ x0: 0, y0: 0, x1: 4, y1: 1 }, { x0: 0, y0: 1, x1: 1, y1: 3 }]);
    expect(A).toBe(6);
    expect(S[0]).toBeCloseTo((4 * 2 + 2 * 0.5) / 6); expect(S[1]).toBeCloseTo((4 * 0.5 + 2 * 2) / 6);
  });
});

describe('scissor lift by virtual power', () => {
  it('F = n G cot α makes the total virtual power vanish', () => {
    const a = 0.8, G = 3, n = 2, al = 0.6, ad = 0.37;
    const F = scissorForce(G, al, n);
    const xdot = -2 * a * Math.sin(al) * ad, hdot = 2 * n * a * Math.cos(al) * ad;
    expect(F * -xdot + -G * hdot).toBeCloseTo(0);
  });
});
