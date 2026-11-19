"""Shaded 3D ball-and-stick drawings for matplotlib (spheres with light and highlight,
bonds as shaded cylinders, lone pairs as translucent lobes). Units: cm on a Sketch."""
import numpy as np
import matplotlib.colors as mc

LIGHT = np.array([-0.45, 0.55, 0.70]); LIGHT /= np.linalg.norm(LIGHT)
_cache = {}


def sphere_img(color, n=160):
    key = (color, n)
    if key in _cache: return _cache[key]
    c = np.array(mc.to_rgb(color))
    y, x = np.mgrid[1:-1:n * 1j, -1:1:n * 1j]
    r2 = x * x + y * y; inside = r2 <= 1
    z = np.sqrt(np.clip(1 - r2, 0, 1))
    N = np.dstack([x, y, z])
    diff = np.clip(N @ LIGHT, 0, 1)
    H = LIGHT + np.array([0, 0, 1.0]); H /= np.linalg.norm(H)
    spec = np.clip(N @ H, 0, 1) ** 45
    rim = (1 - z) ** 3
    col = c[None, None] * (0.30 + 0.75 * diff[..., None]) + 0.55 * spec[..., None] - 0.18 * rim[..., None] * c
    col = np.clip(col, 0, 1)
    edge = np.clip((1 - np.sqrt(r2)) * n / 2.0, 0, 1)          # anti-aliased edge
    img = np.dstack([col, edge * inside])
    _cache[key] = img
    return img


def ball(ax, x, y, r, color, z=5):
    ax.imshow(sphere_img(color), extent=(x - r, x + r, y - r, y + r), zorder=z, interpolation="bilinear")


def stick(ax, p, q, w=0.13, color="#9aa3ad", z=4, layers=7):
    """bond as a shaded cylinder from p to q (2D points), width w in cm."""
    p, q = np.asarray(p, float), np.asarray(q, float)
    c = np.array(mc.to_rgb(color)); PT = 72 / 2.54
    for k in range(layers):
        f = 1 - k / layers                       # from wide/dark to narrow/light
        shade = np.clip(c * (0.55 + 0.6 * (1 - f)), 0, 1)
        off = np.array([-(q - p)[1], (q - p)[0]]); off = off / (np.linalg.norm(off) + 1e-9) * w * 0.12 * (1 - f)
        ax.plot([p[0] + off[0], q[0] + off[0]], [p[1] + off[1], q[1] + off[1]], color=shade, lw=w * PT * f,
                solid_capstyle="butt", zorder=z)


def lobe(ax, base, tip, width, z=3, color="#7fb0e8"):
    """lone-pair lobe: soft translucent teardrop from base towards tip."""
    from matplotlib.patches import Polygon
    base, tip = np.asarray(base, float), np.asarray(tip, float)
    d = tip - base; L = np.linalg.norm(d); u = d / L; n = np.array([-u[1], u[0]])
    t = np.linspace(0, np.pi, 60)
    for k, (sc, al) in enumerate([(1.0, 0.34), (0.8, 0.28), (0.58, 0.28), (0.36, 0.32)]):
        xs = L * sc * (1 - np.cos(t)) / 2; ws = width * sc * np.sin(t) * (0.55 + 0.45 * (1 - np.cos(t)) / 2)
        pts = np.r_[[base + u * x + n * w for x, w in zip(xs, ws)], [base + u * x - n * w for x, w in zip(xs[::-1], ws[::-1])]]
        ax.add_patch(Polygon(pts, closed=True, fc=color, ec="none", alpha=al, zorder=z + 0.01 * k))


def rot(ax_, a):
    c, s = np.cos(a), np.sin(a)
    if ax_ == "x": return np.array([[1, 0, 0], [0, c, -s], [0, s, c]])
    if ax_ == "y": return np.array([[c, 0, s], [0, 1, 0], [-s, 0, c]])
    return np.array([[c, -s, 0], [s, c, 0], [0, 0, 1]])


def molecule(ax, cx, cy, ligands, lone=(), R=1.0, Rm=None, rc=0.34, rl=0.24,
             ccol="#4a4f57", lcol="#e8705f", lp_col="#7fb0e8", zbase=10):
    """ligands, lone: unit 3D vectors. Projected with rotation Rm (view along -z)."""
    Rm = np.eye(3) if Rm is None else Rm
    items = []
    for v in ligands:
        w = Rm @ np.asarray(v, float); items.append(("L", w))
    for v in lone:
        w = Rm @ np.asarray(v, float); items.append(("P", w))
    # draw back to front; central atom at depth 0
    items.sort(key=lambda it: it[1][2])
    drawn_center = False
    for kind, w in items:
        if not drawn_center and w[2] > 0:
            ball(ax, cx, cy, rc, ccol, z=zbase); drawn_center = True
        z = zbase + (2 if w[2] > 0 else -2) + w[2]
        end = np.array([cx + R * w[0], cy + R * w[1]])
        if kind == "L":
            stick(ax, (cx, cy), end, z=z - 0.5)
            ball(ax, end[0], end[1], rl * (1 + 0.12 * w[2]), lcol, z=z)
        else:
            lobe(ax, (cx, cy), (cx + 1.0 * R * w[0], cy + 1.0 * R * w[1]), 0.40, z=z - 0.4, color=lp_col)
    if not drawn_center: ball(ax, cx, cy, rc, ccol, z=zbase)
