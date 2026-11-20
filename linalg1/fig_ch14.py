from plot import *
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon
F = np.array([[0, 0], [0.5, 0], [0.5, 1.0], [1.1, 1.0], [1.1, 1.4], [0.5, 1.4], [0.5, 1.9], [1.5, 1.9], [1.5, 2.4], [0, 2.4], [0, 0]])
def Rm(t): return np.array([[np.cos(t), -np.sin(t)], [np.sin(t), np.cos(t)]])
maps = [("Drehung $R(45^\\circ)$", Rm(np.pi / 4)), ("Spiegelung an $x_1$-Achse", np.diag([1, -1])), ("Streckung $\\mathrm{diag}(1{,}5;\\,0{,}6)$", np.diag([1.5, 0.6])),
        ("Scherung $x_1\\mapsto x_1+0{,}8\\,x_2$", np.array([[1, 0.8], [0, 1.0]])), ("Projektion auf $x_2=2x_1$", np.array([[1, 2], [2, 4]]) / 5.0),
        ("Drehstreckung $0{,}7\\,R(60^\\circ)$", 0.7 * Rm(np.pi / 3))]
for k, (title, M) in enumerate(maps):
    p = Plot(5.0, 4.8, (-3.2, 3.6), (-3.0, 3.6), xt=(), yt=(), xl="", yl=None, grid=False, pad=0.25)
    # Gitter
    for g in range(-3, 4):
        for a, b in [((g, -3), (g, 3)), ((-3, g), (3, g))]:
            A_, B_ = M @ np.array(a, float), M @ np.array(b, float)
            p.seg(tuple(A_), tuple(B_), c="#dbd5f2", lw=0.5)
    Q = F @ M.T
    p.polyfill([tuple(v) for v in F[:-1]], c="#e3e3e3", alpha=1); p.curve(F[:, 0], F[:, 1], c=GREY, lw=0.8)
    p.polyfill([tuple(v) for v in Q[:-1]], c=FILL_B, alpha=0.85); p.curve(Q[:, 0], Q[:, 1], c=B, lw=1.3)
    p.text(-3.1, 3.1, title, ha="left", size=8)
    p.save(f"l14_abb{k+1}")

# ---- Projektion auf eine Gerade ----
p = Plot(7.0, 5.4, (-0.6, 4.6), (-0.6, 4.4), xt=(), yt=(), xl="$x_1$", yl=None, grid=False, pad=0.3)
a = np.array([1.0, 2.0]); v = np.array([3.0, 1.0]); pv = (a @ v) / (a @ a) * a
p.seg(tuple(-0.5 * a), tuple(2.2 * a), c=G, lw=1.6)
p.arrow((0, 0), tuple(v), c=B, lw=1.6); p.arrow((0, 0), tuple(pv), c=R, lw=1.6); p.seg(tuple(v), tuple(pv), c=GREY, lw=1.0, dash=(3, 2))
p.dot(tuple(pv), c=R, r=3)
p.text(3.1, 0.85, "$\\mathbf{v}=(3,1)$", c=B, ha="left", size=9); p.text(1.1, 2.1, "$P\\mathbf{v}=(1,2)$", c=R, ha="left", size=9)
p.text(1.15, 3.9, "Gerade $\\mathrm{span}\\{\\mathbf{a}\\}$,  $\\mathbf{a}=(1,2)$", c=G, ha="left", size=8.5)
p.text(2.3, 1.6, "$\\mathbf{v}-P\\mathbf{v}\\perp\\mathbf{a}$", c=GREY, ha="left", size=8)
p.save("l14_proj")

# ---- Interpolation ----
p = Plot(8.0, 5.0, (-0.6, 2.8), (-1.0, 3.6), xt=(1, 2), yt=(1, 2, 3), xl="$x$", yl=None, pad=0.3)
p.f(lambda x: 2 * x ** 2 - 3 * x + 1, -0.3, 2.3, c=B, lw=1.6)
for (x0, y0) in [(0, 1), (1, 0), (2, 3)]: p.dot((x0, y0), c=R, r=3.6)
p.text(0.15, 1.15, "$(0,1)$", c=R, size=8.5, ha="left"); p.text(1.1, -0.2, "$(1,0)$", c=R, size=8.5, ha="left", va="top"); p.text(1.5, 3.2, "$(2,3)$", c=R, size=8.5, ha="left")
p.text(0.2, 3.0, "$p(x)=2x^2-3x+1$", c=B, size=9, ha="left")
p.save("l14_interp")

# ---- Hutchinson-Operator fuer das Sierpinski-Dreieck ----
P0 = np.array([[0, 0], [1, 0], [0.5, np.sqrt(3) / 2]])
def H(polys):
    out = []
    for poly in polys:
        for p0 in P0: out.append((poly + p0) / 2)
    return out
polys = [P0.copy()]
for k in range(5):
    s = plt.figure(figsize=(2.6 / 2.54, 2.4 / 2.54)); ax = s.add_axes([0, 0, 1, 1]); ax.axis("off"); ax.set_xlim(-0.05, 1.05); ax.set_ylim(-0.05, 0.95); ax.set_aspect("equal")
    for poly in polys: ax.add_patch(Polygon(poly, closed=True, fc="#5b4aa8", ec="none", alpha=0.9, lw=0))
    s.savefig(f"figs/l14_h{k}.svg", format="svg"); s.savefig(PNG + f"/l14_h{k}.png", dpi=130); plt.close(s)
    polys = H(polys)

# ---- Barnsleys Farn ----
rng = np.random.default_rng(1)
Ms = [np.array([[0, 0], [0, .16]]), np.array([[.85, .04], [-.04, .85]]), np.array([[.2, -.26], [.23, .22]]), np.array([[-.15, .28], [.26, .24]])]
bs = [np.array([0, 0]), np.array([0, 1.6]), np.array([0, 1.6]), np.array([0, .44])]
pr = np.array([.01, .85, .07, .07])
N = 120000; x = np.zeros(2); pts = np.zeros((N, 2)); ks = rng.choice(4, size=N, p=pr)
for i in range(N):
    x = Ms[ks[i]] @ x + bs[ks[i]]; pts[i] = x
s = plt.figure(figsize=(6.6 / 2.54, 8.8 / 2.54)); ax = s.add_axes([0, 0, 1, 1]); ax.axis("off"); ax.set_aspect("equal")
ax.scatter(pts[500:, 0], pts[500:, 1], s=0.12, c=pts[500:, 1], cmap="Greens", vmin=-9, vmax=11, linewidths=0, rasterized=True)
ax.set_xlim(-3.0, 3.0); ax.set_ylim(-0.3, 10.3)
s.savefig("figs/l14_farn.svg", format="svg", dpi=200); s.savefig(PNG + "/l14_farn.png", dpi=110); plt.close(s)
