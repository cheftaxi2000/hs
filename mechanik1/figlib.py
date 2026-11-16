"""Zeichenbibliothek für das Mechanik-Skript. Einheit der Koordinaten: cm (= Maß auf dem Papier)."""
import os
import numpy as np
import matplotlib
matplotlib.use("svg")
import matplotlib.pyplot as plt
from matplotlib import font_manager as fm
from matplotlib.patches import Polygon, Circle, FancyArrowPatch, ArrowStyle, Rectangle

for f in ("Regular", "Medium", "SemiBold"):
    fm.fontManager.addfont(f"/usr/share/fonts/opentype/inter/Inter-{f}.otf")

plt.rcParams.update({
    "svg.fonttype": "path", "font.family": "Inter", "font.size": 8,
    "mathtext.fontset": "cm", "axes.unicode_minus": False,
})

INK = "#1b1b1b"; GREY = "#8d8d8d"; LIGHT = "#efefef"; MID = "#d9d9d9"
V = "#1f5fa8"      # Geschwindigkeiten
F = "#b3382c"      # Kräfte
M = "#2a7f5a"      # Drehung, Momente
PT = 28.3465       # Punkte pro cm
OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "figs")
PNG = "/tmp/claude-0/-home-user-hs/86681ad6-701a-5310-b84c-b1468856c4a6/scratchpad/figpng"
os.makedirs(OUT, exist_ok=True); os.makedirs(PNG, exist_ok=True)

def P(*a): return np.array(a, dtype=float)
def rad(d): return np.deg2rad(d)
def pol(c, r, deg): return np.array(c, float) + r * np.array([np.cos(rad(deg)), np.sin(rad(deg))])
def unit(v): v = np.array(v, float); return v / np.linalg.norm(v)
def nrm(v): v = unit(v); return np.array([-v[1], v[0]])

class Fig:
    def __init__(s, w, h):
        s.w, s.h = w, h
        s.fig = plt.figure(figsize=(w / 2.54, h / 2.54))
        s.ax = s.fig.add_axes([0, 0, 1, 1]); s.ax.set_xlim(0, w); s.ax.set_ylim(0, h)
        s.ax.set_aspect("equal"); s.ax.axis("off")

    # ---------- Grundformen ----------
    def line(s, p, q, c=INK, lw=0.9, dash=None, z=2, cap="butt"):
        (x0, y0), (x1, y1) = p, q
        ln, = s.ax.plot([x0, x1], [y0, y1], color=c, lw=lw, solid_capstyle=cap, zorder=z)
        if dash: ln.set_dashes(dash)
        return ln
    def path(s, pts, c=INK, lw=0.9, dash=None, z=2, closed=False):
        pts = np.array(pts, float)
        if closed: pts = np.vstack([pts, pts[0]])
        ln, = s.ax.plot(pts[:, 0], pts[:, 1], color=c, lw=lw, zorder=z, solid_joinstyle="round")
        if dash: ln.set_dashes(dash)
    def guide(s, p, q, c=GREY, lw=0.6): s.line(p, q, c=c, lw=lw, dash=(4, 3), z=1)
    def poly(s, pts, fc=LIGHT, ec=INK, lw=0.9, z=1, alpha=1):
        s.ax.add_patch(Polygon(np.array(pts, float), closed=True, fc=fc, ec=ec, lw=lw, zorder=z, joinstyle="round", alpha=alpha))
    def circle(s, c, r, fc=LIGHT, ec=INK, lw=0.9, z=1, dash=None):
        p = Circle(c, r, fc=fc, ec=ec, lw=lw, zorder=z)
        if dash: p.set_linestyle((0, dash))
        s.ax.add_patch(p)
    def rect(s, p, q, **k):
        (x0, y0), (x1, y1) = p, q
        s.poly([(x0, y0), (x1, y0), (x1, y1), (x0, y1)], **k)
    def box(s, c, w, h, ang=0, **k):
        c = np.array(c, float); R = np.array([[np.cos(rad(ang)), -np.sin(rad(ang))], [np.sin(rad(ang)), np.cos(rad(ang))]])
        pts = [c + R @ np.array(d) for d in [(-w/2, -h/2), (w/2, -h/2), (w/2, h/2), (-w/2, h/2)]]
        s.poly(pts, **k); return pts
    def dot(s, p, r=0.07, c=INK, z=6): s.ax.add_patch(Circle(p, r, fc=c, ec="none", zorder=z))
    def hinge(s, p, r=0.1): s.ax.add_patch(Circle(p, r, fc="white", ec=INK, lw=0.9, zorder=7))

    # ---------- Text ----------
    def text(s, p, t, c=INK, size=9, ha="center", va="center", dx=0, dy=0, z=8, bg=False, weight="normal"):
        kw = dict(bbox=dict(fc="white", ec="none", pad=0.6)) if bg else {}
        s.ax.text(p[0] + dx, p[1] + dy, t, color=c, fontsize=size, ha=ha, va=va, zorder=z, fontweight=weight, **kw)
    def cap(s, p, t, c=INK, size=7.8, **k): s.text(p, t, c=c, size=size, **k)

    # ---------- Pfeile ----------
    def arrow(s, p, q, c=INK, lw=1.3, label=None, off=(0.0, 0.0), ha="center", va="center", size=9.5,
              dash=None, head=1.0, z=5, both=False, hl=None):
        p, q = np.array(p, float), np.array(q, float)
        L = np.linalg.norm(q - p)
        hl = (min(0.25, max(0.11, 0.3 * L)) * head) if hl is None else hl
        ms = 1.0
        style = ArrowStyle("<|-|>" if both else "-|>", head_length=hl * PT / 11, head_width=hl * 0.18 * PT / 11)
        a = FancyArrowPatch(p, q, arrowstyle=style, mutation_scale=11, color=c, lw=lw, shrinkA=0, shrinkB=0,
                            zorder=z, joinstyle="miter", capstyle="butt")
        if dash: a.set_linestyle((0, dash))
        s.ax.add_patch(a)
        if label is not None:
            m = (p + q) / 2
            s.text(m + np.array(off), label, c=c, size=size, ha=ha, va=va)
    def vec(s, p, q, c=F, label=None, off=(0.15, 0.15), **k):
        """Pfeil mit Beschriftung nahe der Spitze (off in cm relativ zur Spitze)."""
        s.arrow(p, q, c=c, **k)
        if label is not None: s.text(np.array(q) + np.array(off), label, c=c, size=k.get("size", 9.5))
    def tip(s, p, q, label, c=INK, dist=0.3, side=0.0, size=9.5):
        """Beschriftung hinter der Pfeilspitze q (Pfeil p→q), seitlich um 'side' versetzt."""
        u = unit(np.array(q) - np.array(p)); s.text(np.array(q) + u * dist + nrm(u) * side, label, c=c, size=size)
    def arc(s, c, r, a0, a1, col=INK, lw=0.9, arrow=False, n=60, z=4, label=None, lr=None, size=9, dash=None):
        c = np.array(c, float)
        t = np.linspace(a0, a1, n)
        pts = np.array([pol(c, r, a) for a in t])
        if arrow:
            k = 4
            s.path(pts[:-k + 1], c=col, lw=lw, z=z)
            s.arrow(pts[-k], pts[-1], c=col, lw=lw, hl=0.21, z=z)
        else:
            s.path(pts, c=col, lw=lw, z=z, dash=dash)
        if label is not None:
            am = (a0 + a1) / 2; rr = lr if lr else r + 0.28
            s.text(pol(c, rr, am), label, c=col, size=size)
    def angle(s, c, r, a0, a1, label=None, col=INK, **k): s.arc(c, r, a0, a1, col=col, lw=0.7, label=label, **k)
    def moment(s, c, r, a0=210, a1=-30, col=M, label=None, lr=None):
        s.arc(c, r, a0, a1, col=col, lw=1.3, arrow=True, label=label, lr=lr)

    # ---------- Konstruktionselemente ----------
    def hatch(s, p, q, side=-1, step=0.2, ln=0.22, c=GREY, lw=0.6, edge=True):
        """Schraffur entlang p→q; side=-1: rechts von der Laufrichtung."""
        p, q = np.array(p, float), np.array(q, float)
        u = unit(q - p); n = -nrm(u) * (1 if side < 0 else -1)
        L = np.linalg.norm(q - p)
        if edge: s.line(p, q, lw=1.1, c=INK)
        for t in np.arange(step / 2, L, step):
            a = p + u * t
            s.line(a, a + n * ln * 0.9 - u * ln * 0.9, c=c, lw=lw)
    def ground(s, x0, x1, y, **k): s.hatch((x0, y), (x1, y), **k)
    def wall(s, x, y0, y1, side=-1, **k):
        s.hatch((x, y1), (x, y0), side=side, **k) if side < 0 else s.hatch((x, y0), (x, y1), side=-1, **k)
    def pin(s, p, size=0.38, base=True, gw=1.0):
        p = np.array(p, float)
        a, b = p + P(-size * 0.62, -size), p + P(size * 0.62, -size)
        s.poly([p, a, b], fc="white", lw=1.0, z=3)
        if base: s.ground(p[0] - gw / 2, p[0] + gw / 2, p[1] - size)
        s.hinge(p, 0.07)
    def roller(s, p, size=0.38, base=True, gw=1.0):
        p = np.array(p, float)
        a, b = p + P(-size * 0.62, -size * 0.8), p + P(size * 0.62, -size * 0.8)
        s.poly([p, a, b], fc="white", lw=1.0, z=3)
        r = size * 0.14
        for dx in (-size * 0.32, size * 0.32): s.circle(p + P(dx, -size * 0.8 - r), r, fc="white", lw=0.8, z=3)
        if base: s.ground(p[0] - gw / 2, p[0] + gw / 2, p[1] - size * 0.8 - 2 * r)
        s.hinge(p, 0.07)
    def clamp(s, p, h=1.1, side=-1):
        p = np.array(p, float)
        s.wall(p[0], p[1] - h / 2, p[1] + h / 2, side=side)
    def beam(s, p, q, lw=3.4, c=INK): s.line(p, q, c=c, lw=lw, cap="butt", z=3)
    def spring(s, p, q, n=7, amp=0.16, lead=0.25):
        p, q = np.array(p, float), np.array(q, float); u = unit(q - p); nn = nrm(u); L = np.linalg.norm(q - p)
        pts = [p, p + u * lead]
        for i in range(n):
            t = lead + (L - 2 * lead) * (i + 0.5) / n
            pts.append(p + u * t + nn * amp * (1 if i % 2 == 0 else -1))
        pts += [q - u * lead, q]
        s.path(pts, lw=1.0)
    def dim(s, p, q, label, off=-0.5, size=8.5, ext=0.12):
        p, q = np.array(p, float), np.array(q, float); u = unit(q - p); n = nrm(u)
        a, b = p + n * off, q + n * off
        s.line(p + n * (0.08 * np.sign(off)), a + n * ext * np.sign(off), c=GREY, lw=0.5)
        s.line(q + n * (0.08 * np.sign(off)), b + n * ext * np.sign(off), c=GREY, lw=0.5)
        s.arrow(a, b, c=GREY, lw=0.6, both=True, head=0.5)
        s.text((a + b) / 2 + n * 0.0, label, c=INK, size=size, bg=True)
    def dload(s, x0, x1, y, h0, h1=None, n=8, c=F, lw=0.8):
        h1 = h0 if h1 is None else h1
        xs = np.linspace(x0, x1, n + 1); hs = np.linspace(h0, h1, n + 1)
        s.path([(x, y + h) for x, h in zip(xs, hs)], c=c, lw=lw)
        for x, h in zip(xs, hs):
            if h > 0.22: s.arrow((x, y + h), (x, y), c=c, lw=lw, head=0.55)
    def axes2(s, o, lx, ly, nx="x", ny="y", c=INK, neg=0.2):
        o = np.array(o, float)
        s.arrow(o - P(neg, 0), o + P(lx, 0), c=c, lw=0.7, head=0.6); s.arrow(o - P(0, neg), o + P(0, ly), c=c, lw=0.7, head=0.6)
        s.text(o + P(lx + 0.22, 0), f"${nx}$", size=9); s.text(o + P(0, ly + 0.25), f"${ny}$", size=9)
    def proj(s, o, x, y, z):
        """schiefe Parallelprojektion: x nach vorn-links, y nach rechts, z nach oben."""
        return P(o[0] + y - 0.42 * x, o[1] + z - 0.30 * x)
    def axes3(s, o, l=2.4, names=("x", "y", "z"), c=INK):
        for i, (v, nm) in enumerate(zip([(l, 0, 0), (0, l, 0), (0, 0, l)], names)):
            q = s.proj(o, *v); s.arrow(o, q, c=c, lw=0.7, head=0.6)
            d = unit(q - np.array(o)); s.text(q + d * 0.28, f"${nm}$", size=9)

    def save(s, name):
        s.fig.savefig(os.path.join(OUT, name + ".svg"), format="svg", transparent=True)
        s.fig.savefig(os.path.join(PNG, name + ".png"), dpi=220, facecolor="white")
        plt.close(s.fig)
