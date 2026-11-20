from plot import *
from geo3d import *
import numpy as np
from matplotlib.patches import Polygon

# ---- Koordinaten bzgl. einer schiefen Basis ----
p = Plot(8.8, 6.2, (-1.2, 5.2), (-2.0, 3.6), xt=(), yt=(), xl="$e_1$", yl=None, grid=False, pad=0.3)
b1 = np.array([1.0, 1.0]); b2 = np.array([1.0, -1.0])
for k in range(-1, 4):
    p.seg(tuple(k * b1 - 3 * b2), tuple(k * b1 + 4 * b2), c="#cfc6ee", lw=0.7)
    p.seg(tuple(k * b2 - 3 * b1), tuple(k * b2 + 4 * b1), c="#cfc6ee", lw=0.7)
v = 2 * b1 + 1 * b2
p.arrow((0, 0), tuple(b1), c=B, lw=1.8); p.arrow((0, 0), tuple(b2), c=R, lw=1.8)
p.seg((0, 0), tuple(2 * b1), c=B, lw=1.0, dash=(4, 2)); p.seg(tuple(2 * b1), tuple(v), c=R, lw=1.0, dash=(4, 2))
p.arrow((0, 0), tuple(v), c=G, lw=1.8); p.dot(tuple(v), c=G, r=3.4)
p.text(0.3, 1.2, "$\\mathbf{b}_1=(1,1)$", c=B, size=9, ha="left"); p.text(0.9, -1.6, "$\\mathbf{b}_2=(1,-1)$", c=R, size=9, ha="left")
p.text(3.15, 1.15, "$\\mathbf{v}=(3,1)$", c=G, size=9, ha="left")
p.text(-1.1, 3.1, "$\\mathbf{v}=2\\,\\mathbf{b}_1+1\\,\\mathbf{b}_2$,  Koordinaten $[\\mathbf{v}]_{\\mathcal{B}}=(2,1)$", size=9, ha="left")
p.save("l13_koord")

# ---- drei Vektoren: komplanar oder nicht ----
def panel(name, kind):
    s = Sketch(5.4, 5.0)
    s.ax.set_xlim(-1.9, 2.4); s.ax.set_ylim(-1.5, 1.9)
    draw_box(s.ax)
    def vec(v, col, lab):
        q = proj(np.array([v]))[0]
        s.ax.annotate("", xy=q, xytext=(0, 0), arrowprops=dict(arrowstyle="-|>", color=col, lw=1.7, mutation_scale=9), zorder=8)
        s.ax.text(q[0] + 0.08, q[1] + 0.1, lab, color=col, fontsize=9.5)
    if kind == "kompl":
        draw_plane(s.ax, (0.3, 0.2, 1.0), 0.0, "#5b4aa8", alpha=0.25)
        vec((0.0, 0.9, 0.0 - 0.18), "#1f5fa8", "$\\mathbf{a}$"); vec((0.8, -0.1, -0.28), "#b3382c", "$\\mathbf{b}$"); vec((0.5, 0.6, -0.33), "#2a7f5a", "$\\mathbf{a}+\\mathbf{b}$")
        s.ax.text(0.2, -1.45, "in einer Ebene: linear abhängig", ha="center", fontsize=8.3)
    else:
        draw_plane(s.ax, (0.3, 0.2, 1.0), 0.0, "#5b4aa8", alpha=0.18)
        vec((0.0, 0.9, 0.0 - 0.18), "#1f5fa8", "$\\mathbf{a}$"); vec((0.8, -0.1, -0.28), "#b3382c", "$\\mathbf{b}$"); vec((0.0, 0.1, 0.9), "#2a7f5a", "$\\mathbf{c}$")
        s.ax.text(0.2, -1.45, "$\\mathbf{c}$ verlässt die Ebene: unabhängig", ha="center", fontsize=8.3)
    q = proj(np.array([[0, 0, 0.0]])); s.ax.plot(q[:, 0], q[:, 1], "o", ms=4, color="black", zorder=10)
    s.save(name)
panel("l13_kompl", "kompl"); panel("l13_nicht", "nicht")
