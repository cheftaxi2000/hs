from plot import *
import numpy as np
from inf import arr as _arr

# ---- Givens-Rotation: (3,4) -> (5,0) ----
p = Plot(8.2, 6.4, (-0.6, 6.2), (-1.5, 5.2), xt=(), yt=(), xl="$x_1$", yl=None, grid=False, pad=0.35)
x = np.array([3.0, 4.0])
th = np.linspace(0, np.arctan2(4, 3), 60)
p.curve(5 * np.cos(th), 5 * np.sin(th), c=GREY, lw=1.0, dash=(4, 3))
p.arrow((0, 0), (3, 4), c=B, lw=1.6); p.arrow((0, 0), (5, 0), c=R, lw=1.6)
p.dot((3, 4), c=B, r=3); p.dot((5, 0), c=R, r=3)
p.text(3.15, 4.15, "$\\mathbf{x}=(3,4)$", c=B, ha="left", size=9)
p.text(5.0, 0.2, "$G\\mathbf{x}=(5,0)$", c=R, ha="right", size=9)
p.text(1.2, 0.45, "$\\varphi$", c=INK, size=10)
a = np.linspace(0, np.arctan2(4, 3), 30); p.curve(1.2 * np.cos(a), 1.2 * np.sin(a), c=INK, lw=0.8)
p.text(3.0, -1.2, "Drehung um den Winkel $-\\varphi$ mit $\\cos\\varphi=3/5$, $\\sin\\varphi=4/5$", ha="center", size=8)
p.save("l06_givens")

# ---- Householder-Spiegelung ----
p = Plot(8.4, 6.4, (-3.4, 5.6), (-2.2, 4.6), xt=(), yt=(), xl="$x_1$", yl=None, grid=False, pad=0.35)
v = np.array([-2.0, 4.0]) / np.linalg.norm([-2, 4]); x = np.array([3.0, 4.0]); Hx = np.array([5.0, 0.0])
t = np.array([v[1], -v[0]])
p.seg(tuple(-3.4 * t), tuple(5.2 * t), c=G, lw=1.7)
p.arrow((0, 0), tuple(x), c=B, lw=1.5); p.arrow((0, 0), tuple(Hx), c=R, lw=1.5)
p.seg(tuple(x), tuple(Hx), c=GREY, lw=0.9, dash=(3, 2))
p.arrow((0, 0), tuple(1.6 * v), c=O, lw=1.4)
m = (x + Hx) / 2; p.dot(tuple(m), c=INK, r=2.4)
p.text(3.1, 4.1, "$\\mathbf{x}$", c=B, ha="left", size=10); p.text(5.0, 0.25, "$H\\mathbf{x}$", c=R, ha="right", size=10)
p.text(-1.0, 1.9, "$\\mathbf{v}$", c=O, size=10)
p.text(1.7, -1.8, "Spiegelebene $\\perp\\ \\mathbf{v}$", c=G, ha="left", size=8.5)
p.text(-3.3, 4.2, "$\\mathbf{v}=\\mathbf{x}-\\|\\mathbf{x}\\|\\mathbf{e}_1=(-2,4)$", c=O, ha="left", size=8.5)
p.save("l06_householder")
