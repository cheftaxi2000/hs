from plot import *
from inf import rb, lab, cell, arr
import numpy as np
F = np.array([[0, 0], [0.5, 0], [0.5, 1.0], [1.1, 1.0], [1.1, 1.4], [0.5, 1.4], [0.5, 1.9], [1.5, 1.9], [1.5, 2.4], [0, 2.4], [0, 0]])
def Rm(t): return np.array([[np.cos(t), -np.sin(t)], [np.sin(t), np.cos(t)]])
def Sm(a): return np.array([[np.cos(2 * a), np.sin(2 * a)], [np.sin(2 * a), -np.cos(2 * a)]])
def panel(name, M, title, axis=None, col=B):
    p = Plot(5.4, 5.4, (-3.0, 3.0), (-3.0, 3.0), xt=(), yt=(), xl="$x_1$", yl=None, grid=False, pad=0.3)
    p.polyfill([tuple(v) for v in F[:-1]], c="#e3e3e3", alpha=1)
    p.curve(F[:, 0], F[:, 1], c=GREY, lw=1.0)
    Q = F @ M.T
    p.polyfill([tuple(v) for v in Q[:-1]], c=FILL_B if col == B else FILL_R, alpha=0.9)
    p.curve(Q[:, 0], Q[:, 1], c=col, lw=1.4)
    if axis is not None:
        u = np.array([np.cos(axis), np.sin(axis)]); p.seg(tuple(-3 * u), tuple(3 * u), c=G, lw=1.2, dash=(5, 3))
        p.text(2.0, 1.55 if axis > 0 else -1.0, "Spiegelachse", c=G, size=8)
    p.text(-2.9, 2.6, title, ha="left", size=8.5)
    p.save(name)
panel("l07_orig", np.eye(2), "Original (grau)")
panel("l07_rot", Rm(np.pi / 3), "Drehung $R(60^\\circ)$", None)
panel("l07_spieg", Sm(np.pi / 6), "Spiegelung $S(30^\\circ)$", np.pi / 6, col=R)

# ---- LR-Zerlegung: Muster ----
s = Sketch(12.8, 4.0)
def blk(ox, kind, name):
    n = 4
    lab(s, ox + n * 0.4, 3.6, name, size=10, bold=True)
    for i in range(n):
        for j in range(n):
            x, y = ox + j * 0.8 + 0.4, 2.9 - i * 0.62
            if kind == "A": t, tx = "blue", "*"
            elif kind == "L": t, tx = ("amber", "*") if i > j else (("red", "1") if i == j else ("white", "0"))
            else: t, tx = ("violet", "*") if j >= i else ("white", "0")
            rb(s, x, y, 0.72, 0.54, t, r=0.12, lw=0.5)
            lab(s, x, y, tx, size=8, c="#aaa" if tx == "0" else INK)
blk(0.2, "A", "$A$"); lab(s, 3.8, 2.0, "=", size=16)
blk(4.3, "L", "$L$ (untere Dreiecksm.)"); lab(s, 7.9, 2.0, "$\\cdot$", size=16)
blk(8.4, "R", "$R$ (obere Dreiecksm.)")
lab(s, 6.4, 0.25, "Unter der Diagonalen von $L$ stehen die Eliminationsfaktoren $l_{ik}$; die Diagonale von $L$ besteht aus Einsen.", size=8.2, c="#444")
s.ax.set_ylim(-0.1, 4.0)
s.save("l07_lr")
