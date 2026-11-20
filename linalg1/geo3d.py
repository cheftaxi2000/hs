"""Kleine 3D-Hilfen (Schrägbild) fuer das Lineare-Algebra-Skript: Ebenen im Würfel, Pfeile, Parallelepiped."""
import numpy as np
from itertools import product
from matplotlib.patches import Polygon

def proj(p, ax=0.42, ay=0.30):
    """Kabinett-Projektion: x zeigt nach links-unten (zum Betrachter), y nach rechts, z nach oben."""
    p = np.atleast_2d(p).astype(float)
    return np.column_stack([p[:, 1] - ax * p[:, 0], p[:, 2] - ay * p[:, 0]])

def plane_polygon(n, d, box=1.0):
    """Schnitt der Ebene n.x = d mit dem Würfel [-box,box]^3 (geordnete Eckpunkte)."""
    n = np.asarray(n, float); pts = []
    corners = np.array(list(product([-box, box], repeat=3)))
    for i, a in enumerate(corners):
        for j in range(i + 1, len(corners)):
            b = corners[j]
            if np.sum(a != b) != 1: continue
            fa, fb = n @ a - d, n @ b - d
            if fa * fb < 0 or (abs(fa) < 1e-12) :
                t = fa / (fa - fb) if fa != fb else 0
                pts.append(a + t * (b - a))
    pts = np.unique(np.round(np.array(pts), 9), axis=0)
    if len(pts) < 3: return None
    c = pts.mean(0)
    u = np.cross(n, [1, 0.3, 0.2]); u /= np.linalg.norm(u); v = np.cross(n, u)
    ang = np.arctan2((pts - c) @ v, (pts - c) @ u)
    return pts[np.argsort(ang)]

def draw_plane(ax, n, d, color, alpha=0.35, box=1.0, ec=None, z=2):
    P = plane_polygon(n, d, box)
    if P is None: return
    ax.add_patch(Polygon(proj(P), closed=True, fc=color, ec=ec or color, alpha=alpha, lw=0.8, zorder=z))

def draw_box(ax, box=1.0, color="#bbbbbb", lw=0.6):
    cs = np.array(list(product([-box, box], repeat=3)))
    for i, a in enumerate(cs):
        for j in range(i + 1, len(cs)):
            if np.sum(a != cs[j]) == 1:
                q = proj(np.array([a, cs[j]]))
                ax.plot(q[:, 0], q[:, 1], color=color, lw=lw, zorder=1)

def line_in_box(p, u, box=1.0):
    """Gerade p + t u, geschnitten mit dem Würfel (Endpunkte)."""
    p = np.asarray(p, float); u = np.asarray(u, float); lo, hi = -1e9, 1e9
    for k in range(3):
        if abs(u[k]) < 1e-12:
            if abs(p[k]) > box: return None
            continue
        t1, t2 = (-box - p[k]) / u[k], (box - p[k]) / u[k]
        lo, hi = max(lo, min(t1, t2)), min(hi, max(t1, t2))
    if lo > hi: return None
    return p + lo * u, p + hi * u
