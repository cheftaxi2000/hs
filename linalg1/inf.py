"""Drawing helpers for the informatics script (rounded boxes, memory cells, arrows, flow-chart parts)."""
from plot import *
from clean import SOFT, link
import matplotlib.colors as mc
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch, Circle, Polygon, Rectangle
MONO = "DejaVu Sans Mono"
TONES = dict(SOFT)
TONES["teal"] = ("#fdebd2", "#c26a10"); TONES["white"] = ("#ffffff", "#6b7480"); TONES["dark"] = ("#2b3a3d", "#2b3a3d")

def _edge(fg): return mc.to_hex(np.array(mc.to_rgb(fg)) * 0.45 + 0.55)

def rb(s, x, y, w, h, tone="grey", z=2, lw=0.7, r=None, ec=None, fc=None, dash=None):
    """rounded box centred at (x, y)."""
    bg, fg = TONES[tone]
    r = min(h / 2, 0.22) if r is None else r
    s.ax.add_patch(FancyBboxPatch((x - w / 2 + r, y - h / 2 + r), w - 2 * r, h - 2 * r, boxstyle=f"round,pad={r}",
                   fc=fc or bg, ec=ec or _edge(fg), lw=lw, zorder=z, ls=(0, dash) if dash else "-"))

def lab(s, x, y, t, size=8, c=INK, mono=False, ha="center", va="center", bold=False, z=9, **kw):
    return s.ax.text(x, y, t, ha=ha, va=va, fontsize=size, color=c, zorder=z, fontfamily=MONO if mono else "CMU Serif",
                     fontweight="bold" if bold else "normal", **kw)

def cell(s, x, y, w, h, t, tone="grey", size=8.5, mono=True, bold=False, r=None, z=2, c=INK):
    rb(s, x, y, w, h, tone, z=z, r=r)
    lab(s, x, y, t, size=size, mono=mono, bold=bold, z=z + 3, c=c)

def arr(s, p, q, c="#4a5560", lw=1.0, rad=0.0, z=6, head=7, ls="-"):
    a = FancyArrowPatch(p, q, arrowstyle=f"-|>,head_length={head/10},head_width={head/20}", mutation_scale=10,
                        connectionstyle=f"arc3,rad={rad}", color=c, lw=lw, zorder=z, shrinkA=0, shrinkB=0, ls=ls)
    s.ax.add_patch(a)

def dot(s, p, c=INK, r=0.07, z=7):
    s.ax.add_patch(Circle(p, r, fc=c, ec="none", zorder=z))

def diamond(s, x, y, w, h, tone="amber", z=2):
    bg, fg = TONES[tone]
    s.ax.add_patch(Polygon([(x - w / 2, y), (x, y + h / 2), (x + w / 2, y), (x, y - h / 2)], closed=True, fc=bg, ec=_edge(fg), lw=0.7, zorder=z, joinstyle="round"))

def hline_(s, x0, x1, y, c="#b7bec7", lw=0.8, dash=None, z=1):
    s.ax.plot([x0, x1], [y, y], color=c, lw=lw, zorder=z, ls=(0, dash) if dash else "-", solid_capstyle="round")

def vline_(s, x, y0, y1, c="#b7bec7", lw=0.8, dash=None, z=1):
    s.ax.plot([x, x], [y0, y1], color=c, lw=lw, zorder=z, ls=(0, dash) if dash else "-", solid_capstyle="round")

def poly(s, pts, c=INK, lw=0.9, z=4, dash=None):
    p = np.array(pts); s.ax.plot(p[:, 0], p[:, 1], color=c, lw=lw, zorder=z, ls=(0, dash) if dash else "-", solid_capstyle="round", solid_joinstyle="round")
