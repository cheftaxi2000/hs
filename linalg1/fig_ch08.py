from plot import *
from inf import rb, lab, cell, arr, link
from geo3d import proj
import numpy as np
from matplotlib.patches import Polygon

# ---- det 2x2: Parallelogramm ----
p = Plot(6.6, 5.2, (-0.5, 5.2), (-0.5, 3.9), xt=(), yt=(), xl="$x_1$", yl=None, grid=False, pad=0.3)
a = np.array([3.0, 1.0]); b = np.array([1.0, 2.0])
p.polyfill([(0, 0), tuple(a), tuple(a + b), tuple(b)], c=FILL_B, alpha=0.9)
p.arrow((0, 0), tuple(a), c=B, lw=1.6); p.arrow((0, 0), tuple(b), c=R, lw=1.6)
p.seg(tuple(a), tuple(a + b), c=GREY, lw=0.8, dash=(3, 2)); p.seg(tuple(b), tuple(a + b), c=GREY, lw=0.8, dash=(3, 2))
p.text(3.1, 0.6, "$\\mathbf{a}=(3,1)$", c=B, ha="left", size=9); p.text(0.15, 2.15, "$\\mathbf{b}=(1,2)$", c=R, ha="left", size=9)
p.text(2.0, 1.45, "Fläche $=|\\det|=5$", ha="center", size=9)
p.save("l08_det2")

# ---- det 3x3: Parallelepiped ----
s = Sketch(6.4, 5.6)
s.ax.set_xlim(-2.0, 4.4); s.ax.set_ylim(-1.2, 4.4)
a, b, c = np.array([1.0, 0, 0]), np.array([0, 2.0, 0]), np.array([0, 0, 1.6])
o = np.zeros(3)
V = {}
for i in (0, 1):
    for j in (0, 1):
        for k in (0, 1): V[(i, j, k)] = i * a + j * b + k * c
def P(v): return proj(np.array([v]), 0.9, 0.55)[0]
faces = [[(0,0,0),(1,0,0),(1,1,0),(0,1,0)], [(0,0,1),(1,0,1),(1,1,1),(0,1,1)], [(0,0,0),(0,1,0),(0,1,1),(0,0,1)], [(1,0,0),(1,1,0),(1,1,1),(1,0,1)], [(0,0,0),(1,0,0),(1,0,1),(0,0,1)], [(0,1,0),(1,1,0),(1,1,1),(0,1,1)]]
for f in faces: s.ax.add_patch(Polygon([P(V[v]) for v in f], closed=True, fc="#cfe0f2", ec="#1f5fa8", alpha=0.5, lw=0.8))
for v, col, t in [(a, B, "$\\mathbf{a}$"), (b, R, "$\\mathbf{b}$"), (c, G, "$\\mathbf{c}$")]:
    q = P(v); s.ax.annotate("", xy=q, xytext=(0, 0), arrowprops=dict(arrowstyle="-|>", color=col, lw=1.6, mutation_scale=9))
    s.ax.text(q[0] + 0.1, q[1] + 0.12, t, color=col, fontsize=10)
s.ax.text(1.2, -0.9, "Volumen $=|\\det(\\mathbf{a},\\mathbf{b},\\mathbf{c})|=|1\\cdot 2\\cdot 1.6|$", fontsize=8.5, ha="center")
s.save("l08_det3")

# ---- Sarrus ----
s = Sketch(8.6, 4.6)
vals = [["a", "b", "c", "a", "b"], ["d", "e", "f", "d", "e"], ["g", "h", "i", "g", "h"]]
for i in range(3):
    for j in range(5):
        x, y = 1.0 + j * 1.2, 3.6 - i * 1.05
        tone = "white" if j >= 3 else "blue"
        rb(s, x, y, 1.0, 0.8, tone, r=0.15, lw=0.5, ls=None) if False else rb(s, x, y, 1.0, 0.8, tone, r=0.15, lw=0.5)
        lab(s, x, y, vals[i][j], size=10, c="#999" if j >= 3 else INK, mono=False)
def X(j): return 1.0 + j * 1.2
def Y(i): return 3.6 - i * 1.05
for k, col in enumerate(["#2a7f5a"] * 3):
    s.ax.plot([X(k), X(k + 2)], [Y(0), Y(2)], color="#2a7f5a", lw=2.0, alpha=0.8, solid_capstyle="round")
    s.ax.plot([X(k + 2), X(k)], [Y(0), Y(2)], color="#c4473a", lw=2.0, alpha=0.8, solid_capstyle="round")
lab(s, 7.8, 3.3, "+", size=14, c="#2a7f5a", bold=True); lab(s, 7.8, 1.0, "−", size=14, c="#c4473a", bold=True)
lab(s, 4.0, 0.35, "grün: $aei+bfg+cdh$  −  rot: $ceg+afh+bdi$", size=8.5)
s.ax.set_ylim(0, 4.4)
s.save("l08_sarrus")

# ---- Vorzeichenschachbrett ----
s = Sketch(5.2, 4.4)
for i in range(4):
    for j in range(4):
        sg = (-1) ** (i + j)
        rb(s, 0.9 + j * 1.0, 3.6 - i * 0.9, 0.9, 0.8, "amber" if sg > 0 else "violet", r=0.14, lw=0.5)
        lab(s, 0.9 + j * 1.0, 3.6 - i * 0.9, "+" if sg > 0 else "−", size=11, bold=True)
lab(s, 2.4, 0.0, "$(-1)^{i+j}$: Schachbrettmuster", size=8.5)
s.ax.set_ylim(-0.4, 4.3)
s.save("l08_vorz")
