from plot import *
from geo3d import *
import numpy as np
def vec(s, v, col, label, off=(0.08, 0.1)):
    q = proj(np.array([v]))[0]
    s.ax.annotate("", xy=q, xytext=(0, 0), arrowprops=dict(arrowstyle="-|>", color=col, lw=1.7, mutation_scale=9), zorder=8)
    s.ax.text(q[0] + off[0], q[1] + off[1], label, color=col, fontsize=9.5, zorder=9)
def panel(name, kind):
    s = Sketch(5.4, 5.0)
    s.ax.set_xlim(-1.9, 2.4); s.ax.set_ylim(-1.5, 1.9)
    draw_box(s.ax)
    if kind == 1:
        seg = line_in_box((0, 0, 0), (0.5, 0.9, 0.6)); q = proj(np.array(seg)); s.ax.plot(q[:, 0], q[:, 1], color="#2a7f5a", lw=2.0, alpha=0.7)
        vec(s, (0.4, 0.7, 0.5), "#1f5fa8", "$\\mathbf{v}$")
        s.ax.text(0.2, -1.45, "$\\mathrm{span}\\{\\mathbf{v}\\}$: Gerade", ha="center", fontsize=8.5)
    elif kind == 2:
        draw_plane(s.ax, (0.3, 0.2, 1.0), 0.0, "#5b4aa8", alpha=0.3)
        vec(s, (0.0, 0.8, 0.1), "#1f5fa8", "$\\mathbf{v}$"); vec(s, (0.8, -0.2, 0.2), "#b3382c", "$\\mathbf{w}$")
        s.ax.text(0.2, -1.45, "$\\mathrm{span}\\{\\mathbf{v},\\mathbf{w}\\}$: Ebene", ha="center", fontsize=8.5)
    else:
        for n in [(1, 0, 0), (0, 1, 0), (0, 0, 1)]: draw_plane(s.ax, n, 0.0, "#5b4aa8", alpha=0.12)
        vec(s, (0.0, 0.9, 0.0), "#1f5fa8", "$\\mathbf{u}$"); vec(s, (0.0, 0.0, 0.9), "#b3382c", "$\\mathbf{v}$"); vec(s, (0.9, 0.0, 0.0), "#2a7f5a", "$\\mathbf{w}$")
        s.ax.text(0.2, -1.45, "$\\mathrm{span}\\{\\mathbf{u},\\mathbf{v},\\mathbf{w}\\}=\\mathbb{R}^3$", ha="center", fontsize=8.5)
    q = proj(np.array([[0, 0, 0.0]])); s.ax.plot(q[:, 0], q[:, 1], "o", ms=4, color="black", zorder=10)
    s.save(name)
panel("l12_s1", 1); panel("l12_s2", 2); panel("l12_s3", 3)

# ---- lineare Abhaengigkeit in der Ebene ----
def dep(name, kind):
    p = Plot(5.0, 4.0, (-3.4, 3.4), (-2.2, 2.6), xt=(), yt=(), xl="", yl=None, grid=False, pad=0.25)
    if kind == "abh":
        p.arrow((0, 0), (1.5, 0.9), c=B, lw=1.6); p.arrow((0, 0), (3.0, 1.8), c=R, lw=1.2)
        p.text(1.0, 1.35, "$\\mathbf{a}$", c=B, size=10); p.text(1.6, 2.1, "$\\mathbf{b}=2\\mathbf{a}$", c=R, size=9)
        p.text(0.0, -1.6, "parallel: linear abhängig", ha="center", size=8.5)
    else:
        p.arrow((0, 0), (1.5, 0.9), c=B, lw=1.6); p.arrow((0, 0), (-0.5, 1.7), c=R, lw=1.6)
        p.text(1.55, 0.55, "$\\mathbf{a}$", c=B, size=10); p.text(-1.0, 1.7, "$\\mathbf{b}$", c=R, size=10)
        p.text(0.0, -1.6, "nicht parallel: linear unabhängig", ha="center", size=8.5)
    p.save(name)
dep("l12_abh", "abh"); dep("l12_unabh", "unabh")
