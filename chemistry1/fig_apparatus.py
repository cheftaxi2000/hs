"""Apparatus sketches and box diagrams in a clean, rounded style."""
from plot import *
from clean import *
from matplotlib.patches import Circle, FancyBboxPatch

BLUE = "#3d7cc9"; RED = "#c4473a"

# =============== barometer and manometer (Ch. 2) ===============
s = Sketch(12.6, 6.6)
# --- barometer ---
dish = rrect(0.5, 0.55, 3.9, 1.25, 0.32)
s.ax.add_patch(rrect(0.5, 0.55, 3.9, 1.25, 0.32)); s.ax.patches[-1].set(fc=GLASS, ec=GLASS_EDGE, lw=1.0, zorder=2)
grad(s, rrect(0.56, 0.61, 3.78, 0.78, 0.26), HG[0], HG[1], z=3)
tx = 2.45; ttop = 6.05; th = 4.65
tube(s, [(tx, 0.85), (tx, ttop)], 0.62, z=4)
liquid(s, [(tx, 0.85), (tx, th)], 0.62, "#a9b2bc", z=5)
s.ax.plot([tx - 0.2, tx - 0.2], [1.2, th - 0.25], color="white", lw=1.6, alpha=0.7, solid_capstyle="round", zorder=6)   # highlight
s.text(tx, 5.42, "vacuum", ha="center", va="center", size=7, c="#7a8592")
dimension(s, 3.35, 1.39, th + 0.25, "$h = 760$ mm")
for x in (0.9, 1.45, 3.75):
    s.arrow((x, 2.75), (x, 1.95), c=BLUE, lw=1.0)
s.text(0.65, 2.9, "$P_{atm}$", c=BLUE, size=9)
s.text(2.45, 0.2, "barometer", ha="center", va="top", size=8)
# --- open-end manometer ---
bx, by = 6.6, 4.05
s.ax.add_patch(Circle((bx, by), 1.02, fc=GLASS, ec=GLASS_EDGE, lw=1.0, zorder=2))
grad(s, Circle((bx, by), 0.95), GAS[0], GAS[1], z=3)
s.text(bx, by + 0.12, "gas", ha="center", va="center", size=8.5); s.text(bx, by - 0.35, "$P_{gas}$", ha="center", va="center", size=8.5)
xl, xr, yb = 8.7, 10.5, 0.75
path = np.vstack([[bx + 0.95, by], [xl, by], ubend(xl, xr, yb, by, 6.1)[1:]])
tube(s, path, 0.42, z=2)
L = length(path); s_l = arclen_at_y(path, 2.45, "first"); s_r = arclen_at_y(path, 3.95, "last")
liquid(s, cut(path, s_l, s_r), 0.42, "#a9b2bc", z=4)
s.ax.plot([xl + 0.06, xr + 0.6], [2.45, 2.45], color="#c3cbd4", lw=0.7, ls=(0, (3, 2)), zorder=1)
s.ax.plot([xr - 0.3, xr + 0.6], [3.95, 3.95], color="#c3cbd4", lw=0.7, ls=(0, (3, 2)), zorder=1)
dimension(s, xr + 0.55, 2.45, 3.95, "$h$")
s.arrow((xr, 6.9), (xr, 6.3), c=BLUE, lw=1.0); s.text(xr - 0.2, 6.75, "$P_{atm}$", c=BLUE, size=9, ha="right")
s.text(8.9, 0.2, "open-end manometer: $P_{gas}=P_{atm}+\\rho g h$", ha="center", va="top", size=8)
s.ax.set_ylim(-0.25, 7.0)
s.save("c02_baro")

# =============== piston (Ch. 4) ===============
s = Sketch(9.8, 5.2)
cyl = rounded_poly([(0.9, 0.5), (4.7, 0.5), (4.7, 4.7), (0.9, 4.7)], 0.0)
s.ax.add_patch(rrect(0.8, 0.45, 4.0, 4.4, 0.35)); s.ax.patches[-1].set(fc=GLASS, ec=GLASS_EDGE, lw=1.1, zorder=1)
grad(s, rrect(0.9, 0.55, 3.8, 1.85, 0.25), GAS[0], GAS[1], z=2)
grad(s, rrect(0.9, 0.55, 3.8, 3.2, 0.25), "#eef4fc", GAS[0], z=1.5)
s.ax.add_patch(rrect(0.9, 2.25, 3.8, 0.28, 0.1)); s.ax.patches[-1].set(fc="none", ec="#9fb3c8", lw=0.8, ls=(0, (3, 2)), zorder=3)
grad(s, rrect(0.92, 3.6, 3.76, 0.36, 0.14), STEEL[0], STEEL[1], z=4)
s.ax.plot([2.8, 2.8], [3.96, 4.75], color="#a9b3be", lw=5, solid_capstyle="round", zorder=3)
s.text(2.8, 1.35, "gas", ha="center", va="center", size=9)
for x in (1.6, 4.0): s.arrow((x, 4.85), (x, 4.05), c=BLUE, lw=1.0)
s.text(2.8, 5.05, "$P_{ext}$ (constant)", ha="center", size=8, c=BLUE)
s.arrow((5.2, 2.4), (5.2, 3.7), c=RED, lw=1.0); s.text(5.4, 3.05, "$\\Delta x$", c=RED, va="center")
s.text(6.1, 3.9, "$w = -F\\,\\Delta x = -P A\\,\\Delta x$", size=9)
s.text(6.1, 3.05, "$w = -P\\,\\Delta V$", size=10.5)
s.text(6.1, 2.15, "expansion: $\\Delta V>0$, $w<0$", size=8, c="#444444")
s.text(6.1, 1.6, "(the gas does work on", size=8, c="#444444"); s.text(6.1, 1.15, "the surroundings)", size=8, c="#444444")
s.save("c04_piston")

# =============== coffee-cup calorimeter (Ch. 4) ===============
s = Sketch(5.4, 6.0)
outer = rounded_poly([(0.55, 4.0), (4.85, 4.0), (4.35, 0.45), (1.05, 0.45)], 0.35)
inner = rounded_poly([(0.95, 3.85), (4.45, 3.85), (4.02, 0.8), (1.38, 0.8)], 0.3)
s.ax.add_patch(PathPatch(outer, fc="#f6f2ec", ec="#cfc6b8", lw=1.0, zorder=1))
s.ax.add_patch(PathPatch(inner, fc="#fbfaf7", ec="#d9d1c4", lw=0.8, zorder=2))
liq = rounded_poly([(1.1, 3.0), (4.3, 3.0), (4.0, 0.85), (1.4, 0.85)], 0.25)
grad(s, PathPatch(liq), WATER[0], WATER[1], z=3)
s.ax.add_patch(rrect(0.35, 3.95, 4.7, 0.42, 0.18)); s.ax.patches[-1].set(fc="#efe9df", ec="#cfc6b8", lw=1.0, zorder=5)
# thermometer
tube(s, [(3.35, 1.35), (3.35, 5.6)], 0.2, z=6)
liquid(s, [(3.35, 1.35), (3.35, 3.4)], 0.2, "#d0574a", z=7)
s.ax.add_patch(Circle((3.35, 1.25), 0.2, fc="#d0574a", ec="#b84638", lw=0.6, zorder=8))
s.text(3.6, 5.45, "thermometer", size=7.5)
# stirrer
s.ax.plot([2.0, 2.0], [1.55, 5.3], color="#9aa4b0", lw=2.2, solid_capstyle="round", zorder=6)
s.ax.plot([1.6, 2.4], [1.55, 1.55], color="#9aa4b0", lw=2.2, solid_capstyle="round", zorder=6)
s.text(1.8, 5.2, "stirrer", ha="right", size=7.5)
s.text(2.7, 2.2, "solution", ha="center", size=8)
s.text(2.7, 0.15, "nested foam cups, open to air ($P$ constant)", ha="center", va="top", size=7.5, c="#444444")
s.ax.set_ylim(-0.4, 6.0)
s.save("c04_calorimeter")

# =============== free expansion (Ch. 5) ===============
s = Sketch(13.2, 3.9); rng = np.random.default_rng(4)
def flask(cx, cy, r=1.15):
    s.ax.add_patch(Circle((cx, cy), r, fc=GLASS, ec=GLASS_EDGE, lw=1.0, zorder=2))
    tube(s, [(cx, cy + r * 0.8), (cx, cy + r + 0.55)], 0.42, z=1.5)
for X, both, lab in [(0.4, False, "before: gas left, vacuum right"), (7.0, True, "after: gas fills both flasks")]:
    c1, c2 = (X + 1.3, 1.85), (X + 4.3, 1.85)
    tube(s, [c1, c2], 0.26, z=1)
    flask(*c1); flask(*c2)
    s.ax.add_patch(Circle(((c1[0] + c2[0]) / 2, c1[1]), 0.24, fc="white" if both else "#5d6773", ec="#5d6773", lw=1.0, zorder=5))
    s.ax.plot([(c1[0] + c2[0]) / 2 - 0.17, (c1[0] + c2[0]) / 2 + 0.17], [c1[1], c1[1]] if both else [c1[1] - 0.17, c1[1] + 0.17], color="white" if not both else "#5d6773", lw=1.2, zorder=6, solid_capstyle="round")
    for k in range(18):
        c = c2 if (both and k % 2) else c1
        a = rng.uniform(0, 2 * np.pi); rr = 0.9 * np.sqrt(rng.uniform(0, 1))
        s.ax.add_patch(Circle((c[0] + rr * np.cos(a), c[1] + rr * np.sin(a)), 0.075, fc=BLUE, ec="none", zorder=4))
    s.text(X + 2.8, 0.38, lab, ha="center", va="top", size=8)
s.arrow((6.15, 1.85), (6.85, 1.85), c=RED, lw=1.4)
s.ax.set_ylim(-0.2, 3.9)
s.save("c05_expansion")

# =============== osmosis (Ch. 9) ===============
s = Sketch(12.4, 5.4); rng = np.random.default_rng(1)
def osmo(x0, hl, hr, lab):
    xl, xr, yb = x0 + 0.55, x0 + 3.05, 0.75
    path = ubend(xl, xr, yb, 4.9, 4.9)
    w = 0.95
    tube(s, path, w, z=2)
    sm = length(path) / 2
    liquid(s, cut(path, arclen_at_y(path, hl, "first"), sm), w, "#bcd6f2", z=3, cap="butt")
    liquid(s, cut(path, sm, arclen_at_y(path, hr, "last")), w, "#f2c4cd", z=3, cap="butt")
    mx = (xl + xr) / 2
    s.ax.plot([mx, mx], [yb - w / 2 + 0.04, yb + w / 2 - 0.04], color="#5d6773", lw=1.6, ls=(0, (2, 1.4)), zorder=5)
    for k in range(9):
        y = rng.uniform(1.4, hr - 0.25); s.ax.add_patch(Circle((xr + rng.uniform(-0.28, 0.28), y), 0.07, fc=RED, ec="none", zorder=6))
    s.text(mx, 0.0, lab, ha="center", va="top", size=7.5)
    return xl, xr
xl, xr = osmo(0.4, 3.0, 3.0, "start: equal levels")
s.arrow((xl + 0.55, 1.05), (xr - 0.75, 1.05), c=BLUE, lw=1.3)
s.text(xl, 5.15, "pure\nsolvent", ha="center", size=7.5, c=BLUE); s.text(xr, 5.15, "solution", ha="center", size=7.5, c=RED)
xl2, xr2 = osmo(7.4, 2.2, 3.8, "equilibrium")
s.ax.plot([xl2 - 0.5, xr2 + 0.9], [2.2, 2.2], color="#c3cbd4", lw=0.7, ls=(0, (3, 2)), zorder=1)
s.ax.plot([xr2 - 0.5, xr2 + 0.9], [3.8, 3.8], color="#c3cbd4", lw=0.7, ls=(0, (3, 2)), zorder=1)
dimension(s, xr2 + 0.85, 2.2, 3.8, "$\\Pi$")
s.text(5.75, 0.55, "semipermeable\nmembrane", ha="center", va="center", size=7, c="#555555")
s.arrow((4.9, 0.45), (2.35, 0.45), c="#8a939e", lw=0.7)
s.ax.set_ylim(-0.45, 5.6)
s.save("c09_osmosis")

# =============== box diagrams ===============
# classification of matter
s = Sketch(14, 5.2)
pill(s, 7, 4.65, 2.4, 0.66, "Matter", tone="grey", bold=True)
pill(s, 3.6, 3.25, 3.4, 0.66, "Pure substance", tone="blue"); pill(s, 10.4, 3.25, 2.8, 0.66, "Mixture", tone="red")
for a, b in [((7, 4.32), (3.6, 3.58)), ((7, 4.32), (10.4, 3.58)), ((3.6, 2.92), (1.9, 2.18)), ((3.6, 2.92), (5.3, 2.18)), ((10.4, 2.92), (8.8, 2.18)), ((10.4, 2.92), (12.1, 2.18))]:
    link(s, a, b)
for x, t, tone in [(1.9, "Element", "blue"), (5.3, "Compound", "blue"), (8.8, "Homogeneous", "red"), (12.1, "Heterogeneous", "red")]:
    pill(s, x, 1.85, 2.8, 0.66, t, tone=tone)
for x, t in [(1.9, "one kind of atom\n$\\mathrm{O_2}$, Fe, He"), (5.3, "fixed ratio of elements\n$\\mathrm{H_2O}$, NaCl"),
             (8.8, "uniform throughout\nair, mineral water"), (12.1, "not uniform\nmilk, granite, sand + water")]:
    s.text(x, 1.3, t, ha="center", va="top", size=7.5, c="#555555")
s.text(7, 3.25, "separate by\nphysical means", ha="center", va="center", size=7, c="#8a939e")
s.ax.set_ylim(0.35, 5.1)
s.save("c01_matter")

# mole map
s = Sketch(14.5, 3.2)
pill(s, 2.0, 1.75, 2.9, 1.0, "mass $m$\n(g)", tone="green"); pill(s, 7.25, 1.75, 2.9, 1.0, "amount $n$\n(mol)", tone="blue"); pill(s, 12.5, 1.75, 2.9, 1.0, "number $N$\n(particles)", tone="red")
for a, b in [((3.6, 2.0), (5.65, 2.0)), ((8.85, 2.0), (10.9, 2.0))]: s.arrow(a, b, c="#5d6773", lw=1.0)
for a, b in [((5.65, 1.5), (3.6, 1.5)), ((10.9, 1.5), (8.85, 1.5))]: s.arrow(a, b, c="#5d6773", lw=1.0)
s.text(4.62, 2.1, "$\\div\\, M$", ha="center", size=9); s.text(4.62, 1.4, "$\\times\\, M$", ha="center", va="top", size=9)
s.text(9.87, 2.1, "$\\times\\, N_A$", ha="center", size=9); s.text(9.87, 1.4, "$\\div\\, N_A$", ha="center", va="top", size=9)
s.text(4.62, 0.35, "$M$ = molar mass (g/mol)", ha="center", size=7.5, c="#555555")
s.text(9.87, 0.35, "$N_A = 6.022\\times10^{23}\\,\\mathrm{mol^{-1}}$", ha="center", size=7.5, c="#555555")
s.save("c01_molemap")

# stoichiometry road map
s = Sketch(15.6, 3.0)
for x, t, tone in [(1.6, "grams of A", "green"), (5.3, "moles of A", "blue"), (10.3, "moles of B", "blue"), (14.0, "grams of B", "green")]:
    pill(s, x, 2.2, 2.6, 0.72, t, tone=tone)
s.arrow((2.95, 2.2), (3.95, 2.2), c="#5d6773"); s.arrow((6.65, 2.2), (8.95, 2.2), c=RED, lw=1.4); s.arrow((11.65, 2.2), (12.65, 2.2), c="#5d6773")
s.text(3.45, 1.6, "$\\div\\, M_A$", ha="center", va="top", size=8.5); s.text(13.15, 1.6, "$\\times\\, M_B$", ha="center", va="top", size=8.5)
s.text(7.8, 1.6, "$\\times\\,\\dfrac{\\nu_B}{\\nu_A}$  (coefficients)", ha="center", va="top", size=8.5, c=RED)
s.text(7.8, 0.3, "the balanced equation is the only bridge between A and B", ha="center", size=7.5, c="#555555")
s.save("c01_stoichmap")

# sign convention (Ch. 4)
s = Sketch(12.6, 5.0)
grad(s, rrect(3.7, 1.35, 4.6, 2.5, 0.45), "#eaf2fc", "#cfe0f4", z=2)
s.ax.add_patch(rrect(3.7, 1.35, 4.6, 2.5, 0.45)); s.ax.patches[-1].set(fc="none", ec="#a9c3e2", lw=0.8, zorder=3)
s.text(6.0, 2.85, "system", ha="center", va="center", size=10); s.text(6.0, 2.25, "$\\Delta E = q + w$", ha="center", va="center", size=10)
s.text(0.2, 4.6, "surroundings", size=8.5, c="#8a939e")
s.arrow((1.0, 3.2), (3.55, 3.2), c=RED, lw=1.3); s.text(2.27, 3.32, "$q>0$  heat in", ha="center", c=RED, size=8)
s.arrow((3.55, 2.0), (1.0, 2.0), c=RED, lw=1.3); s.text(2.27, 1.88, "$q<0$  heat out", ha="center", va="top", c=RED, size=8)
s.arrow((12.0, 3.2), (8.45, 3.2), c=G, lw=1.3); s.text(10.2, 3.32, "$w>0$  work done on system", ha="center", c=G, size=8)
s.arrow((8.45, 2.0), (12.0, 2.0), c=G, lw=1.3); s.text(10.2, 1.88, "$w<0$  work done by system", ha="center", va="top", c=G, size=8)
s.text(6.3, 0.6, "sign convention: everything is seen from the system ($+$ = system gains energy)", ha="center", size=8, c="#555555")
s.save("c04_signs")
