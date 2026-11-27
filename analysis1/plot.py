"""Zeichenhilfe für das Analysis-Skript: Funktionsgraphen im Stil des Mechanik-Skripts.
Grössen in cm, Text als Pfade, Schrift CMU Serif."""
import os, logging
logging.getLogger("matplotlib.font_manager").setLevel(logging.ERROR)
import numpy as np
import matplotlib
matplotlib.use("svg")
import matplotlib.pyplot as plt
from matplotlib import font_manager as fm
from matplotlib import patheffects as pe
from matplotlib.patches import Polygon

for f in ("cmunrm", "cmunti", "cmunbx", "cmunbi"):
    fm.fontManager.addfont(f"/usr/share/fonts/truetype/cmu/{f}.ttf")
plt.rcParams.update({"svg.fonttype": "path", "font.family": "CMU Serif", "font.size": 8,
                     "mathtext.fontset": "cm", "axes.unicode_minus": False,
                     "svg.hashsalt": "analysis1"})   # deterministische SVG-IDs

INK = "#1b1b1b"; GREY = "#8d8d8d"; GRID = "#e6e6e6"
B = "#1f5fa8"; R = "#b3382c"; G = "#2a7f5a"; O = "#c7741a"; P = "#6b4c9a"
FILL_B = "#cfe0f2"; FILL_R = "#f3d3cf"; FILL_G = "#d3eadf"
OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "figs")
PNG = os.environ.get("FIGPNG", os.path.join(os.path.dirname(os.path.abspath(__file__)), ".figpng"))  # Vorschau-PNGs (nicht im Repo)
os.makedirs(OUT, exist_ok=True); os.makedirs(PNG, exist_ok=True)
HALO = [pe.withStroke(linewidth=2.6, foreground="white")]


class Plot:
    """Koordinatensystem mit Achsen durch den Ursprung (oder am Rand), Pfeilspitzen, leichtem Gitter."""
    def __init__(s, w, h, xlim, ylim, xt=(), yt=(), xl="$x$", yl="$y$", grid=True, equal=False,
                 xtl=None, ytl=None, axes=True, pad=0.35):
        s.w, s.h = w, h
        s.fig = plt.figure(figsize=(w / 2.54, h / 2.54))
        px, py = pad / w, pad / h
        s.ax = s.fig.add_axes([px, py, 1 - 2 * px, 1 - 2 * py])
        s.ax.set_xlim(*xlim); s.ax.set_ylim(*ylim); s.ax.axis("off")
        if equal: s.ax.set_aspect("equal", adjustable="box")
        s.xlim, s.ylim = xlim, ylim
        if grid:
            for x in xt: s.ax.axvline(x, color=GRID, lw=0.5, zorder=0)
            for y in yt: s.ax.axhline(y, color=GRID, lw=0.5, zorder=0)
        if axes:
            x0 = 0 if xlim[0] <= 0 <= xlim[1] else xlim[0]
            y0 = 0 if ylim[0] <= 0 <= ylim[1] else ylim[0]
            s.ax.plot(xlim, [y0, y0], color=INK, lw=0.7, zorder=3, solid_capstyle="butt")
            s.ax.plot([x0, x0], ylim, color=INK, lw=0.7, zorder=3, solid_capstyle="butt")
            s._head((xlim[1], y0), (1, 0)); s._head((x0, ylim[1]), (0, 1))
            dx, dy = s.cm2d(1, 1)
            if xl: s.ax.text(xlim[1] - 0.05 * dx, y0 - 0.22 * dy, xl, ha="right", va="top", fontsize=8.5, zorder=6, path_effects=HALO)
            if yl: s.ax.text(x0 - 0.15 * dx, ylim[1] - 0.02 * dy, yl, ha="right", va="top", fontsize=8.5, zorder=6, path_effects=HALO)
            labs = xtl if xtl is not None else [_fmt(v) for v in xt]
            for v, t in zip(xt, labs):
                if abs(v - x0) < 1e-12 and y0 == 0: continue
                s.ax.plot([v, v], [y0 - 0.06 * dy, y0 + 0.06 * dy], color=INK, lw=0.6, zorder=3)
                s.ax.text(v, y0 - 0.12 * dy, t, ha="center", va="top", fontsize=7, zorder=6, path_effects=HALO)
            labs = ytl if ytl is not None else [_fmt(v) for v in yt]
            for v, t in zip(yt, labs):
                if abs(v - y0) < 1e-12 and x0 == 0: continue
                s.ax.plot([x0 - 0.06 * dx, x0 + 0.06 * dx], [v, v], color=INK, lw=0.6, zorder=3)
                s.ax.text(x0 - 0.12 * dx, v, t, ha="right", va="center", fontsize=7, zorder=6, path_effects=HALO)
            if x0 == 0 and y0 == 0 and 0 in xt and 0 in yt:
                s.ax.text(-0.12 * dx, -0.12 * dy, "0", ha="right", va="top", fontsize=7, zorder=6, path_effects=HALO)

    def cm2d(s, cx, cy):
        """Umrechnung cm auf dem Papier -> Dateneinheiten."""
        bw = s.w - 0.7; bh = s.h - 0.7
        return cx * (s.xlim[1] - s.xlim[0]) / bw, cy * (s.ylim[1] - s.ylim[0]) / bh

    def _head(s, tip, d, c=INK, L=0.22, W=0.075):
        d = np.array(d, float); d /= np.linalg.norm(d)
        # in Papier-cm rechnen, damit die Spitze nie verzerrt ist
        sx, sy = s.cm2d(1, 1)
        dc = np.array([d[0] / sx, d[1] / sy]); dc /= np.linalg.norm(dc)
        nc = np.array([-dc[1], dc[0]])
        tipc = np.array([tip[0] / sx, tip[1] / sy])
        pts = [tipc, tipc - L * dc + W * nc, tipc - 0.78 * L * dc, tipc - L * dc - W * nc]
        pts = [(p[0] * sx, p[1] * sy) for p in pts]
        s.ax.add_patch(Polygon(pts, closed=True, fc=c, ec=c, lw=0.3, zorder=4))

    def f(s, fn, a=None, b=None, c=B, lw=1.3, n=1200, dash=None, z=4, clip=True, label=None, lab_at=None, lab_off=(0.15, 0.15), ha="left", va="bottom"):
        a = s.xlim[0] if a is None else a; b = s.xlim[1] if b is None else b
        x = np.linspace(a, b, n)
        with np.errstate(all="ignore"): y = fn(x)
        y = np.array(y, float)
        if clip:
            span = s.ylim[1] - s.ylim[0]
            y[(y > s.ylim[1]) | (y < s.ylim[0])] = np.nan
        ln, = s.ax.plot(x, y, color=c, lw=lw, zorder=z, solid_capstyle="round")
        s._chk(x, y)
        if dash: ln.set_dashes(dash)
        if label is not None and lab_at is not None:
            dx, dy = s.cm2d(*lab_off)
            s.text(lab_at + dx, float(fn(np.array([lab_at]))[0]) + dy, label, c=c, ha=ha, va=va)
        return ln

    def curve(s, x, y, c=B, lw=1.3, dash=None, z=4):
        ln, = s.ax.plot(x, y, color=c, lw=lw, zorder=z, solid_capstyle="round", solid_joinstyle="round")
        if hasattr(s, "_chk"): s._chk(x, y)
        if dash: ln.set_dashes(dash)
        return ln

    def fill(s, x, y1, y2=0, c=FILL_B, alpha=1, z=1):
        s.ax.fill_between(x, y1, y2, color=c, alpha=alpha, zorder=z, lw=0)

    def polyfill(s, pts, c=FILL_B, z=1, alpha=1):
        s.ax.add_patch(Polygon(pts, closed=True, fc=c, ec="none", zorder=z, alpha=alpha))

    def vline(s, x, c=GREY, lw=0.7, dash=(4, 3), a=None, b=None):
        a = s.ylim[0] if a is None else a; b = s.ylim[1] if b is None else b
        ln, = s.ax.plot([x, x], [a, b], color=c, lw=lw, zorder=2)
        if dash: ln.set_dashes(dash)
    def hline(s, y, c=GREY, lw=0.7, dash=(4, 3), a=None, b=None):
        a = s.xlim[0] if a is None else a; b = s.xlim[1] if b is None else b
        ln, = s.ax.plot([a, b], [y, y], color=c, lw=lw, zorder=2)
        if dash: ln.set_dashes(dash)
    def seg(s, p, q, c=INK, lw=0.9, dash=None, z=4):
        ln, = s.ax.plot([p[0], q[0]], [p[1], q[1]], color=c, lw=lw, zorder=z, solid_capstyle="round")
        if dash: ln.set_dashes(dash)

    def arrow(s, p, q, c=INK, lw=1.0, z=5):
        p = np.array(p, float); q = np.array(q, float)
        sx, sy = s.cm2d(1, 1)
        d = np.array([(q - p)[0] / sx, (q - p)[1] / sy]); L = np.linalg.norm(d)
        hl = min(0.22, 0.45 * L)
        qq = q - np.array([d[0] / L * 0.78 * hl * sx, d[1] / L * 0.78 * hl * sy])
        s.ax.plot([p[0], qq[0]], [p[1], qq[1]], color=c, lw=lw, zorder=z, solid_capstyle="butt")
        s._head(q, q - p, c=c, L=hl, W=hl * 0.34)

    def dot(s, p, c=INK, r=2.6, open_=False, z=7):
        s.ax.plot([p[0]], [p[1]], "o", ms=r * 1.0, mfc="white" if open_ else c, mec=c, mew=0.9, zorder=z)

    def text(s, x, y, t, c=INK, ha="left", va="bottom", size=8.5, z=8, **kw):
        s.ax.text(x, y, t, color=c, ha=ha, va=va, fontsize=size, zorder=z, path_effects=HALO, **kw)

    def _chk(s, x, y):
        x = np.asarray(x, float); y = np.asarray(y, float); m = np.isfinite(x) & np.isfinite(y)
        if not m.any(): return
        xl, yl = s.ax.get_xlim(), s.ax.get_ylim()
        out = (x[m] < xl[0] - 1e-9) | (x[m] > xl[1] + 1e-9) | (y[m] < yl[0] - 1e-9) | (y[m] > yl[1] + 1e-9)
        if out.any(): s._clipped = getattr(s, "_clipped", 0) + 1

    def save(s, name):
        if getattr(s, "_clipped", 0): print("CLIP", name, s._clipped)
        s.fig.savefig(os.path.join(OUT, name + ".svg"), format="svg", bbox_inches="tight", pad_inches=0.03, metadata={"Date": None})
        s.fig.savefig(os.path.join(PNG, name + ".png"), dpi=130, bbox_inches="tight", pad_inches=0.03)
        plt.close(s.fig)


def _fmt(v):
    if abs(v - round(v)) < 1e-9: return f"${int(round(v))}$".replace("-", "-")
    return f"${v:g}$".replace(".", "{,}")


class Sketch:
    """Freies Zeichenblatt in cm (für Mengendiagramme, Skizzen ohne Achsen)."""
    def __init__(s, w, h):
        s.w, s.h = w, h
        s.fig = plt.figure(figsize=(w / 2.54, h / 2.54))
        s.ax = s.fig.add_axes([0, 0, 1, 1]); s.ax.set_xlim(0, w); s.ax.set_ylim(0, h)
        s.ax.set_aspect("equal"); s.ax.axis("off")
        s.xlim, s.ylim = (0, w), (0, h)
    cm2d = lambda s, a, b: (a, b)
    _head = Plot._head; arrow = Plot.arrow; dot = Plot.dot; text = Plot.text; seg = Plot.seg; save = Plot.save
    curve = Plot.curve; polyfill = Plot.polyfill
    def ellipse(s, c, a, b, fc="#f4f4f4", ec=INK, lw=0.9):
        from matplotlib.patches import Ellipse
        s.ax.add_patch(Ellipse(c, 2 * a, 2 * b, fc=fc, ec=ec, lw=lw, zorder=1))
