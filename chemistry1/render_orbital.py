"""Shaded isosurface rendering of hydrogen orbitals (numpy ray marching)."""
import numpy as np
from fig_cover import psi3

def rot(ax_, a):
    c, s = np.cos(a), np.sin(a)
    if ax_ == "x": return np.array([[1, 0, 0], [0, c, -s], [0, s, c]])
    if ax_ == "y": return np.array([[c, 0, s], [0, 1, 0], [-s, 0, c]])
    return np.array([[c, -s, 0], [s, c, 0], [0, 0, 1]])

def render(q, ext, W, H, size_px, iso=0.12, Rm=np.eye(3), D=400,
           pos=((0.70, 0.40, 0.08), (1.0, 0.85, 0.52)), neg=((0.42, 0.06, 0.30), (0.96, 0.44, 0.70))):
    n, l, m = q
    f = lambda x, y, z: psi3(n, l, m, x, y, z)
    g = np.linspace(-ext, ext, 80); GX, GY, GZ = np.meshgrid(g, g, g)
    pmax = np.abs(f(GX, GY, GZ)).max(); thr = iso * pmax
    sc = 2 * ext / size_px
    xs = (np.arange(W) - W / 2) * sc; ys = (H / 2 - np.arange(H)) * sc
    X, Y = np.meshgrid(xs, ys); Xf, Yf = X.ravel(), Y.ravel()
    hitz = np.full(Xf.size, np.nan); alive = np.ones(Xf.size, bool)
    zs = np.linspace(1.8 * ext, -1.8 * ext, D); prev = None
    RT = Rm.T
    def ev(x, y, z):
        P = np.stack([x, y, z], -1) @ RT
        return f(P[:, 0], P[:, 1], P[:, 2])
    for k, z in enumerate(zs):
        idx = np.nonzero(alive)[0]
        if idx.size == 0: break
        v = np.abs(ev(Xf[idx], Yf[idx], np.full(idx.size, z)))
        hit = v > thr
        if prev is None: hit[:] = False
        if hit.any():
            hi = idx[hit]; v0 = prev[hit]; v1 = v[hit]
            t = np.clip((thr - v0) / (v1 - v0 + 1e-30), 0, 1)
            hitz[hi] = zs[k - 1] + t * (z - zs[k - 1])
            alive[hi] = False
        prev = v[~hit]
    hm = ~np.isnan(hitz)
    img = np.zeros((Xf.size, 3)); alpha = np.zeros(Xf.size)
    x, y, z = Xf[hm], Yf[hm], hitz[hm]
    e = sc * 0.8
    fa = lambda a, b, c: np.abs(ev(a, b, c))
    nx = fa(x + e, y, z) - fa(x - e, y, z); ny = fa(x, y + e, z) - fa(x, y - e, z); nz = fa(x, y, z + e) - fa(x, y, z - e)
    N = -np.stack([nx, ny, nz], -1); N /= np.linalg.norm(N, axis=1, keepdims=True) + 1e-30
    sign = ev(x, y, z) > 0
    L = np.array([-0.45, 0.65, 0.62]); L /= np.linalg.norm(L)
    V = np.array([0, 0, 1.0]); Hh = (L + V) / np.linalg.norm(L + V)
    diff = np.clip(N @ L, 0, 1); spec = np.clip(N @ Hh, 0, 1) ** 40
    rim = (1 - np.clip(N @ V, 0, 1)) ** 2.5
    L2 = np.array([0.7, -0.3, 0.4]); L2 /= np.linalg.norm(L2); fill = np.clip(N @ L2, 0, 1)
    pos_d, pos_l = np.array(pos[0]), np.array(pos[1]); neg_d, neg_l = np.array(neg[0]), np.array(neg[1])
    base_d = np.where(sign[:, None], pos_d, neg_d); base_l = np.where(sign[:, None], pos_l, neg_l)
    t = (diff ** 0.85)[:, None]
    col = base_d * (1 - t) + base_l * t
    col = col * (0.55 + 0.45 * diff[:, None]) + 0.14 * fill[:, None] * base_l
    col = col + 0.65 * spec[:, None] + 0.30 * rim[:, None] * base_l
    img[hm] = np.clip(col, 0, 1); alpha[hm] = 1
    return img.reshape(H, W, 3), alpha.reshape(H, W), hitz.reshape(H, W)
