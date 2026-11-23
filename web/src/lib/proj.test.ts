import { describe, expect, it } from 'vitest';
import { basis } from './proj';
import { cross3, dot3, len3 } from './vec';

describe('camera basis', () => {
  it('is orthonormal and right-handed for any view', () => {
    for (const [az, el] of [[0.4, 0.3], [2.2, -0.1], [-1, 1.2]]) {
      const { right, up, toward } = basis({ az, el });
      expect(len3(right)).toBeCloseTo(1);
      expect(len3(up)).toBeCloseTo(1);
      expect(dot3(right, up)).toBeCloseTo(0);
      expect(dot3(right, toward)).toBeCloseTo(0);
      const c = cross3(right, up);
      c.forEach((x, i) => expect(x).toBeCloseTo(toward[i]));
    }
  });
});
