import { dot3, type V2, type V3 } from './vec';

/** Orthographic camera: azimuth az about +z (from +x), elevation el above the xy-plane. z is up on screen. */
export interface Cam { az: number; el: number; ox: number; oy: number; s: number }

export function basis(c: Pick<Cam, 'az' | 'el'>) {
  const ca = Math.cos(c.az), sa = Math.sin(c.az), ce = Math.cos(c.el), se = Math.sin(c.el);
  const right: V3 = [-sa, ca, 0];
  const up: V3 = [-se * ca, -se * sa, ce];
  const toward: V3 = [ce * ca, ce * sa, se]; // from the scene towards the viewer
  return { right, up, toward };
}

export function projector(c: Cam) {
  const { right, up, toward } = basis(c);
  const P = (p: V3): V2 => [c.ox + c.s * dot3(p, right), c.oy - c.s * dot3(p, up)];
  /** Depth: larger = nearer the viewer. */
  const depth = (p: V3) => dot3(p, toward);
  return { P, depth, toward };
}
