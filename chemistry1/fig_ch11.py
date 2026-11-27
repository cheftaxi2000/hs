"""Figures for chapter 11: activation energy, Arrhenius, mechanisms, catalysis."""
from plot import *
from matplotlib.patches import Circle, FancyBboxPatch


def prof(pts, n=400):
    """Smooth energy profile through (x, E) points; zero slope at every point
    (levels, transition states and intermediates are all stationary points)."""
    xs, ys = [], []
    for (x0, e0), (x1, e1) in zip(pts[:-1], pts[1:]):
        t = np.linspace(0, 1, n)
        s = t ** 3 * (10 - 15 * t + 6 * t ** 2)
        xs.append(x0 + (x1 - x0) * t); ys.append(e0 + (e1 - e0) * s)
    return np.concatenate(xs), np.concatenate(ys)


def guide(p, y, a, b):
    p.seg((a, y), (b, y), c=GREY, lw=0.6, dash=(3, 2), z=2)


def epot(w, h, xmax=10, ymax=10, xl="reaction progress"):
    return Plot(w, h, (0, xmax), (0, ymax), xt=[], yt=[], xl=xl, yl="$E_\\mathrm{pot}$", grid=False)


def atom(ax, c, xy, r=0.27, z=6, alpha=1.0):
    ax.add_patch(Circle(xy, r, fc=c, ec=INK, lw=0.6, zorder=z, alpha=alpha))


# ======================================================================
# 1. The reaction profile with molecular snapshots underneath
# ======================================================================
s = Sketch(14.6, 8.2)
ax = s.ax
X0, Y0 = 1.3, 2.9            # origin of the energy axes (cm)
XW, YH = 12.9, 7.9
s.seg((X0, Y0), (XW, Y0), lw=0.7); s._head((XW, Y0), (1, 0))
s.seg((X0, Y0), (X0, YH), lw=0.7); s._head((X0, YH), (0, 1))
s.text(XW, Y0 - 0.15, "reaction progress (reaction coordinate)", ha="right", va="top", size=8)
s.text(X0 - 0.12, YH, "$E_\\mathrm{pot}$", ha="right", va="top", size=8.5)
ER, ETS, EP = 4.6, 7.0, 3.55
xR, xTS, xP = 2.6, 7.2, 11.4
x, y = prof([(X0 + 0.15, ER), (xR, ER), (xTS, ETS), (xP, EP), (XW - 0.4, EP)])
s.curve(x, y, c=G, lw=1.5)
# levels and arrows
s.seg((X0 + 0.15, ER), (9.0, ER), c=GREY, lw=0.6, dash=(3, 2), z=2)
s.seg((8.6, EP), (XW - 0.4, EP), c=GREY, lw=0.6, dash=(3, 2), z=2)
s.arrow((xTS, ER), (xTS, ETS - 0.04), c=R, lw=1.1)
s.text(xTS + 0.15, (ER + ETS) / 2, "$E_a$", c=R, va="center", size=9.5)
s.arrow((8.8, ER), (8.8, EP + 0.03), c=B, lw=1.1)
s.text(8.95, (ER + EP) / 2, "$\\Delta E<0$", c=B, va="center", size=9)
s.dot((xTS, ETS), c=INK, r=3.2)
# numbered stages
for k, (xx, yy, lab) in enumerate([(xR - 0.2, ER, "reactants"), (xTS, ETS, "transition state\n(activated complex)"), (xP + 0.2, EP, "products")]):
    ax.add_patch(Circle((xx, yy + 0.55 if k != 1 else yy + 0.5), 0.19, fc="white", ec=INK, lw=0.6, zorder=7))
    s.text(xx, (yy + 0.55 if k != 1 else yy + 0.5), str(k + 1), ha="center", va="center", size=7.5)
s.text(xR - 0.2, ER + 0.85, "reactants", ha="center", size=7.5)
s.text(xTS - 0.35, ETS + 0.25, "transition state\n(activated complex)", ha="right", va="bottom", size=7.5)
s.text(xP + 0.2, EP + 0.85, "products", ha="center", size=7.5)
# snapshots: green atom + blue-red molecule -> green...blue...red -> green-blue + red
ys = 1.05
for xx in (xR - 0.2, xTS, xP + 0.2):
    s.seg((xx, Y0 - 0.55), (xx, ys + 0.55), c=GREY, lw=0.5, dash=(1.5, 1.5), z=1)
# 1: separate, approaching
atom(ax, G, (xR - 1.15, ys)); s.arrow((xR - 0.80, ys + 0.48), (xR - 0.35, ys + 0.48), c=INK, lw=0.7)
atom(ax, B, (xR + 0.15, ys)); atom(ax, R, (xR + 0.62, ys))
# 2: transition state, partial bonds dashed
gx = xTS - 0.85
s.seg((gx, ys), (xTS, ys), c=INK, lw=0.9, dash=(1.6, 1.2), z=5); s.seg((xTS, ys), (xTS + 0.85, ys), c=INK, lw=0.9, dash=(1.6, 1.2), z=5)
atom(ax, G, (gx, ys)); atom(ax, B, (xTS, ys)); atom(ax, R, (xTS + 0.85, ys))
s.text(xTS, ys - 0.45, "old bond half broken, new bond half formed", ha="center", va="top", size=6.8)
s.text(xR - 0.2, ys - 0.45, "A + BC", ha="center", va="top", size=6.8)
s.text(xP + 0.2, ys - 0.45, "AB + C", ha="center", va="top", size=6.8)
# 3: products separating
atom(ax, G, (xP - 0.65, ys)); atom(ax, B, (xP - 0.18, ys)); atom(ax, R, (xP + 0.95, ys))
s.arrow((xP + 1.30, ys + 0.48), (xP + 1.75, ys + 0.48), c=INK, lw=0.7)
s.save("c11_profile")

# ======================================================================
# 2. exothermic vs endothermic
# ======================================================================
for name, ER, ETS, EP, lab in [("c11_exo", 5.0, 8.6, 2.2, "exothermic: $\\Delta E<0$"),
                               ("c11_endo", 2.2, 8.6, 5.0, "endothermic: $\\Delta E>0$")]:
    p = epot(7.2, 4.9)
    x, y = prof([(0.2, ER), (1.6, ER), (4.6, ETS), (7.6, EP), (9.7, EP)])
    p.curve(x, y, c=G, lw=1.4)
    guide(p, ER, 0.2, 7.2); guide(p, EP, 5.8, 9.7)
    p.arrow((4.6, ER), (4.6, ETS - 0.05), c=R); p.text(4.4, (ER + ETS) / 2, "$E_a$", c=R, ha="right", va="center", size=9.5)
    p.arrow((6.6, ER), (6.6, EP), c=B); p.text(6.8, (ER + EP) / 2, "$\\Delta E$", c=B, va="center", size=9.5)
    p.text(0.3, ER + 0.25, "reactants", size=7.5); p.text(9.7, EP + 0.25, "products", ha="right", size=7.5)
    p.text(9.7, 9.9, lab, ha="right", va="top", size=8.5)
    p.save(name)

# ======================================================================
# 3. forward and reverse barrier: the same mountain from both sides
# ======================================================================
p = epot(9.6, 5.4)
ER, ETS, EP = 5.2, 8.8, 2.4
x, y = prof([(0.2, ER), (1.7, ER), (4.9, ETS), (8.1, EP), (9.8, EP)])
p.curve(x, y, c=G, lw=1.4)
guide(p, ER, 0.2, 5.1); guide(p, EP, 0.8, 9.8); guide(p, ETS, 4.9, 7.2)
p.arrow((4.9, ER), (4.9, ETS - 0.05), c=R); p.text(4.7, (ER + ETS) / 2, "$E_a^\\mathrm{fwd}$", c=R, ha="right", va="center", size=9.5)
p.arrow((7.0, EP), (7.0, ETS), c=P); p.text(7.2, 6.9, "$E_a^\\mathrm{rev}$", c=P, va="center", size=9.5)
p.arrow((1.0, ER), (1.0, EP), c=B); p.text(1.2, (ER + EP) / 2, "$\\Delta E$", c=B, va="center", size=9.5)
p.text(0.4, ER + 0.25, "A", size=9); p.text(9.6, EP + 0.25, "B", ha="right", size=9)
p.save("c11_reverse")

# ======================================================================
# 4. energy distribution at two temperatures
# ======================================================================
def mb(E, T):
    return 2 / np.sqrt(np.pi) * np.sqrt(E) / T ** 1.5 * np.exp(-E / T)
p = Plot(9.6, 5.2, (0, 8.2), (0, 0.5), xt=[], yt=[], xl="kinetic energy $E$", yl="fraction of molecules", grid=False)
Ea = 4.2
T1, T2 = 1.0, 1.7
xx = np.linspace(Ea, 8.0, 300)
p.fill(xx, mb(xx, T2), c=FILL_R); p.fill(xx, mb(xx, T1), c=FILL_B, z=2)
p.f(lambda E: mb(E, T1), a=0, b=8.0, c=B); p.f(lambda E: mb(E, T2), a=0, b=8.0, c=R)
p.vline(Ea, c=INK, lw=0.7, a=0, b=0.4)
p.text(Ea, 0.41, "$E_a$", ha="center", size=9)
p.text(0.95, 0.44, "$T_1$", c=B, size=9); p.text(2.35, 0.27, "$T_2>T_1$", c=R, size=9)
p.text(5.0, 0.13, "molecules with $E\\geq E_a$:\nfew at $T_1$ (blue),\nmany more at $T_2$ (red)", size=7.5)
p.save("c11_boltz")

# ======================================================================
# 5. Arrhenius plot
# ======================================================================
p = Plot(9.6, 5.6, (0, 10), (0, 10), xt=[], yt=[], xl="$1/T$", yl="$\\ln k$", grid=False)
lnA, m = 8.8, -0.95
f = lambda u: lnA + m * u
p.f(f, a=0, b=5.6, c=GREY, lw=1.0, dash=(3, 2))
p.f(f, a=5.6, b=8.9, c=B, lw=1.4)
for u in (5.9, 6.6, 7.4, 8.1, 8.7):
    p.dot((u, f(u) + 0.12 * np.sin(5 * u)), c=B, r=3.0)
p.dot((0, lnA), c=B, r=3.2)
p.text(0.25, lnA + 0.15, "intercept $\\ln A$ (extrapolated, $T\\to\\infty$)", size=7.5)
u1, u2 = 6.4, 8.0
p.seg((u1, f(u1)), (u2, f(u1)), c=INK, lw=0.7); p.seg((u2, f(u1)), (u2, f(u2)), c=INK, lw=0.7)
p.text((u1 + u2) / 2, f(u1) + 0.15, "$\\Delta(1/T)$", ha="center", size=7.5)
p.text(u2 + 0.12, (f(u1) + f(u2)) / 2, "$\\Delta \\ln k$", va="center", size=7.5)
p.text(6.0, 5.4, "slope $m=\\dfrac{\\Delta\\ln k}{\\Delta(1/T)}=-\\dfrac{E_a}{R}$", c=B, size=8.5)
p.text(7.2, 0.35, "measured range", c=B, ha="center", size=7)
p.text(0.3, -0.25, "high $T$", va="top", size=7); p.text(8.9, -0.25, "low $T$", va="top", ha="right", size=7)
p.save("c11_arrh")

# ======================================================================
# 6. orientation of the collision
# ======================================================================
s = Sketch(14.0, 3.6)
ax = s.ax
for row, (yy, good) in enumerate([(2.65, True), (0.95, False)]):
    atom(ax, G, (0.6, yy)); s.arrow((0.95, yy), (1.6, yy), c=INK, lw=0.8)
    if good:
        atom(ax, B, (2.2, yy)); atom(ax, R, (2.67, yy))
    else:
        atom(ax, R, (2.2, yy)); atom(ax, B, (2.67, yy))
    s.text(1.25, yy + 0.33, "collision", ha="center", size=6.8)
    s.arrow((3.35, yy), (4.25, yy), c=GREY, lw=0.8)
    if good:
        atom(ax, G, (5.0, yy)); atom(ax, B, (5.47, yy)); atom(ax, R, (6.6, yy))
        s.arrow((6.95, yy), (7.6, yy), c=INK, lw=0.8)
        s.text(8.3, yy, "effective: the green atom hits the end it bonds to,\nA + BC → AB + C", va="center", size=7.5, c=G)
    else:
        atom(ax, G, (5.45, yy)); s.arrow((5.1, yy), (4.55, yy), c=INK, lw=0.8)
        atom(ax, R, (6.3, yy)); atom(ax, B, (6.77, yy))
        s.text(8.3, yy, "ineffective: wrong end, the atom bounces off,\nno reaction (even if the energy suffices)", va="center", size=7.5, c=R)
s.save("c11_orient")

# ======================================================================
# 7. catalyst: lower barrier through a different path
# ======================================================================
p = epot(10.0, 5.6)
ER, ETS, EP = 4.4, 9.1, 2.3
x, y = prof([(0.2, ER), (1.6, ER), (5.0, ETS), (8.3, EP), (9.8, EP)])
p.curve(x, y, c=GREY, lw=1.2, dash=(4, 2.5))
x, y = prof([(0.2, ER), (1.6, ER), (3.7, 6.8), (5.0, 5.6), (6.3, 6.5), (8.3, EP), (9.8, EP)])
p.curve(x, y, c=G, lw=1.5)
guide(p, ER, 0.2, 5.6); guide(p, EP, 0.8, 9.8)
p.arrow((5.0, ER), (5.0, ETS - 0.05), c=R); p.text(5.2, 8.0, "$E_a^\\mathrm{uncat}$", c=R, size=9)
p.arrow((3.7, ER), (3.7, 6.75), c=G); p.text(3.55, 4.95, "$E_a^\\mathrm{cat}$", c=G, ha="right", va="center", size=9)
p.arrow((1.0, ER), (1.0, EP), c=B); p.text(1.2, 3.35, "$\\Delta E$ (unchanged)", c=B, va="center", size=8)
p.text(5.6, 5.35, "intermediate", ha="center", va="top", size=7)
p.text(0.3, ER + 0.25, "reactants", size=7.5); p.text(9.8, EP + 0.25, "products", ha="right", size=7.5)
p.save("c11_cat")

# ======================================================================
# 8. two-step mechanisms: slow first step / fast pre-equilibrium
# ======================================================================
p = epot(7.4, 5.0)
x, y = prof([(0.2, 3.0), (1.0, 3.0), (3.0, 8.8), (4.9, 5.9), (6.6, 7.2), (8.6, 1.6), (9.8, 1.6)])
p.curve(x, y, c=G, lw=1.4)
guide(p, 3.0, 0.2, 3.4)
p.arrow((3.0, 3.0), (3.0, 8.75), c=R); p.text(2.8, 6.2, "$E_a$", c=R, ha="right", va="center", size=9)
p.text(3.0, 9.05, "step 1 (slow)", c=R, ha="center", va="bottom", size=7.5)
p.text(6.6, 7.45, "step 2\n(fast)", ha="center", va="bottom", size=7.5)
p.text(4.9, 5.65, "$\\mathrm{NO_3}$ + NO\n+ CO", ha="center", va="top", size=7)
p.text(0.25, 2.75, "$2\\,\\mathrm{NO_2}$ + CO", va="top", size=7)
p.text(9.8, 1.35, "$\\mathrm{NO_2}$ + NO + $\\mathrm{CO_2}$", ha="right", va="top", size=7)
p.save("c11_mech_a")

p = epot(7.4, 5.0)
x, y = prof([(0.2, 3.0), (1.0, 3.0), (2.6, 5.9), (4.0, 5.0), (6.2, 8.8), (8.4, 1.4), (9.8, 1.4)])
p.curve(x, y, c=G, lw=1.4)
guide(p, 3.0, 0.2, 6.6)
p.arrow((6.2, 3.0), (6.2, 8.75), c=R); p.text(6.4, 6.3, "$E_a$", c=R, va="center", size=9)
p.text(6.2, 9.05, "step 2 (slow)", c=R, ha="center", va="bottom", size=7.5)
p.text(2.6, 6.15, "step 1 (fast,\nequilibrium)", ha="center", va="bottom", size=7.5)
p.text(4.0, 4.75, "O + $\\mathrm{O_2}$\n+ $\\mathrm{O_3}$", ha="center", va="top", size=7)
p.text(0.25, 3.25, "$2\\,\\mathrm{O_3}$", size=7)
p.text(9.8, 1.65, "$3\\,\\mathrm{O_2}$", ha="right", size=7)
p.save("c11_mech_b")

# ======================================================================
# 9. figures for the problems
# ======================================================================
def box(p, xy, t):
    p.ax.add_patch(FancyBboxPatch((xy[0] - 0.42, xy[1] - 0.36), 0.84, 0.72, boxstyle="square,pad=0", fc="white", ec=INK, lw=0.6, zorder=7))
    p.text(xy[0], xy[1], t, ha="center", va="center", size=7.5, z=9)

p = Plot(5.8, 4.6, (0, 10), (0, 10), xt=[], yt=[], xl="reaction progress", yl="energy", grid=False)
ER, ETS, EP = 4.4, 9.0, 1.6
x, y = prof([(0.2, ER), (1.6, ER), (4.4, ETS), (7.4, EP), (9.8, EP)])
p.curve(x, y, c=R, lw=1.3)
guide(p, ER, 0.2, 5.4); guide(p, EP, 3.6, 9.8)
p.arrow((4.4, ER), (4.4, ETS - 0.05), c=INK, lw=0.8); p.arrow((3.9, ER), (3.9, EP), c=INK, lw=0.8)
box(p, (1.2, 5.4), "1"); box(p, (4.4, 6.8), "2"); box(p, (3.0, 3.0), "3"); box(p, (8.8, 2.6), "4")
p.ax.add_patch(Circle((4.4, ETS), 0.2, fc="white", ec=INK, lw=0.8, zorder=8)); p.text(4.85, ETS - 0.1, "5", size=7.5)
p.save("c11_ex0")

p = Plot(5.8, 4.6, (0, 10), (0, 10), xt=[], yt=[], xl="reaction progress", yl="$E_\\mathrm{pot}$", grid=False)
x, y = prof([(0.2, 5.0), (1.4, 5.0), (4.4, 9.2), (7.4, 1.8), (9.8, 1.8)]); p.curve(x, y, c=R, lw=1.3)
x, y = prof([(0.2, 5.0), (1.4, 5.0), (4.4, 7.4), (7.4, 1.8), (9.8, 1.8)]); p.curve(x, y, c=B, lw=1.3)
p.text(4.4, 9.45, "red", c=R, ha="center", size=7.5); p.text(4.4, 6.95, "blue", c=B, ha="center", va="top", size=7.5)
p.save("c11_ex2")

p = Plot(5.8, 4.6, (0, 10), (0, 10), xt=[], yt=[], xl="$1/T$", yl="$\\ln k$", grid=False)
p.f(lambda u: 8.6 - 0.35 * u, a=0, b=8, c=R); p.f(lambda u: 7.2 - 0.82 * u, a=0, b=8, c=B)
p.dot((0, 8.6), c=R); p.dot((0, 7.2), c=B)
p.text(4.2, 7.4, "red", c=R, size=7.5); p.text(4.2, 3.0, "blue", c=B, size=7.5)
p.save("c11_ex4")
