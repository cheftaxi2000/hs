from inf import *
from geo3d import *

# ---- Zeilenstufenform: Treppe ----
s = Sketch(11.6, 5.0)
rows = [(0, 3), (1, 5), (3, 6)]
for i in range(4):
    for j in range(7):
        x, y = 1.0 + j * 1.2, 4.0 - i * 0.95
        piv = any(i == r and j == c for r, c in [(0, 1), (1, 3), (2, 4)])
        zero = (i == 0 and j < 1) or (i == 1 and j < 3) or (i == 2 and j < 4) or i == 3
        tone = "red" if piv else ("white" if zero else "blue")
        rb(s, x, y, 1.05, 0.8, tone, r=0.15, lw=0.5)
        lab(s, x, y, "0" if zero else ("\u25cf" if piv else "*"), size=9, c="#aaa" if zero else INK, mono=piv)
# Treppenlinie
pts = [(0.35, 4.4), (1.6, 4.4), (1.6, 3.45), (4.0, 3.45), (4.0, 2.5), (5.2, 2.5), (5.2, 1.55), (7.6, 1.55)]
poly(s, [(0.35, 4.45), (1.45, 4.45), (1.45, 3.5), (3.85, 3.5), (3.85, 2.55), (5.05, 2.55), (5.05, 1.6), (8.25, 1.6)], c="#5b4aa8", lw=1.4)
vline_(s, 1.0 + 5 * 1.2 + 0.6, 0.9, 4.5, c="#444", lw=1.0)
for j, t in enumerate(["$x_1$", "$x_2$", "$x_3$", "$x_4$", "$x_5$", "$x_6$"]): lab(s, 1.0 + j * 1.2, 4.7, t, size=8, c="#555")
lab(s, 1.0 + 6 * 1.2, 4.7, "$b$", size=8, c="#555")
lab(s, 9.5, 1.5, "Nullzeilen\nunten", size=8, c="#777", ha="left")
s.save("l03_zsf")

# ---- vier Lagen dreier Ebenen ----
def panel(name, planes, pt=None, line=None, title=""):
    s = Sketch(4.4, 4.6)
    s.ax.set_xlim(-1.9, 2.3); s.ax.set_ylim(-1.7, 1.8)
    draw_box(s.ax)
    cols = ["#1f5fa8", "#b3382c", "#2a7f5a"]
    for (n, d), c in zip(planes, cols): draw_plane(s.ax, n, d, c, alpha=0.32)
    if line is not None:
        seg = line_in_box(*line)
        if seg:
            q = proj(np.array(seg)); s.ax.plot(q[:, 0], q[:, 1], color="black", lw=2.0, zorder=6, solid_capstyle="round")
    if pt is not None:
        q = proj(np.array([pt])); s.ax.plot(q[:, 0], q[:, 1], "o", ms=5, color="black", zorder=7)
    s.ax.text(0.2, -1.62, title, ha="center", va="bottom", fontsize=8.2)
    s.save(name)
panel("l03_punkt", [((1, 0, 0), 0.3), ((0, 1, 0), -0.2), ((0, 0, 1), 0.4)], pt=(0.3, -0.2, 0.4), title="genau ein Punkt")
panel("l03_gerade", [((1, 1, 0), 0.0), ((0, 1, 1), 0.2), ((1, 0, -1), -0.2)], line=((0, 0, 0.2), (1, -1, 1)), title="eine Gerade")
panel("l03_parallel", [((0, 0, 1), -0.5), ((0, 0, 1), 0.5), ((1, 1, 0), 0.0)], title="keine: zwei Ebenen parallel")
panel("l03_prisma", [((1, 1, 0), 0.3), ((0, 1, 1), 0.3), ((1, 0, -1), 0.6)], title="keine: «Prisma»")

# ---- Hessesche Normalform in der Ebene ----
p = Plot(8.6, 6.6, (-0.8, 6.2), (-0.8, 5.0), xt=(), yt=(), xl="$x_1$", yl=None, grid=False, pad=0.35)
n = np.array([3, 4]) / 5.0; d = 2.0
t = np.array([-n[1], n[0]])
P0 = n * d
for tt in (-4.0, 5.2): pass
a, b = P0 + t * (-3.4), P0 + t * 3.6
p.seg(tuple(a), tuple(b), c=B, lw=1.8)
p.arrow((0, 0), tuple(P0), c=R, lw=1.5)
p.arrow(tuple(P0), tuple(P0 + 1.1 * n), c=G, lw=1.3)
p.dot((0, 0), c=INK, r=3)
Q = np.array([4.0, 3.0]); Qf = Q - (n @ Q - d) * n
p.seg(tuple(Q), tuple(Qf), c=O, lw=1.3, dash=(3, 2)); p.dot(tuple(Q), c=O, r=3.2); p.dot(tuple(Qf), c=O, r=2.4)
p.text(0.0, 4.5, r"$g:\ n_1x_1+n_2x_2=d$", c=B, ha="left", size=8.5)
p.text(0.75, 0.55, "$d$", c=R, ha="left", size=9)
p.text(P0[0] + 0.45, P0[1] + 0.85, "$\\mathbf{n}$", c=G, size=9.5)
p.text(4.15, 3.1, "$P$", c=O, ha="left", size=9)
p.text(2.75, 2.35, "Abstand\n$|\\mathbf{n}\\cdot\\mathbf{p}-d|$", c=O, ha="left", size=8)
p.save("l03_hnf")
