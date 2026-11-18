from plot import *
from matplotlib.patches import Rectangle, Circle

# ---------- solvation enthalpy steps ----------
def lev(s, x0, x1, y, lab, c=INK, below=False):
    s.seg((x0, y), (x1, y), c=c, lw=1.6)
    if below: s.text((x0 + x1) / 2, y - 0.1, lab, ha="center", va="top", size=7.5)
    else: s.text((x0 + x1) / 2, y + 0.08, lab, ha="center", va="bottom", size=7.5)
for name, ymix, title in [("c09_solv_exo", 0.6, "exothermic: $\\Delta H_{soln}<0$"), ("c09_solv_endo", 2.6, "endothermic: $\\Delta H_{soln}>0$")]:
    s = Sketch(7.0, 6.2)
    y0 = 1.8; y1 = 3.6; y2 = 5.3
    lev(s, 0.3, 2.1, y0, "solvent + solute", c=B, below=True)
    lev(s, 1.9, 3.9, y1, "separated solvent + solute", c=GREY)
    lev(s, 3.7, 5.9, y2, "all separated", c=GREY)
    lev(s, 4.9, 6.8, ymix, "solution", c=R, below=True)
    s.arrow((1.6, y0), (2.3, y1), c=G); s.text(1.65, (y0 + y1) / 2 + 0.1, "(i) $\\Delta H_1>0$", ha="right", size=7.5, c=G)
    s.arrow((3.4, y1), (4.1, y2), c=G); s.text(3.45, (y1 + y2) / 2 + 0.15, "(ii) $\\Delta H_2>0$", ha="right", size=7.5, c=G)
    s.arrow((5.5, y2), (5.5, ymix + 0.05), c=O); s.text(5.65, (y2 + ymix) / 2 + 0.3, "(iii)\n$\\Delta H_{mix}<0$", size=7.5, c=O)
    s.seg((0.3, ymix), (4.8, ymix), c=GREY, lw=0.6, dash=(2, 2))
    s.arrow((0.6, y0), (0.6, ymix + 0.04), c=R) if ymix < y0 else s.arrow((0.6, y0), (0.6, ymix - 0.04), c=R)
    s.text(0.75, (y0 + ymix) / 2, "$\\Delta H_{soln}$", size=7.5, c=R, va="center")
    s.text(3.5, 6.05, title, ha="center", size=8.5)
    s.ax.set_ylim(0.0, 6.3)
    s.save(name)

# ---------- solubility vs temperature ----------
T = np.array([0, 20, 40, 60, 80, 100])
p = Plot(7.4, 5.0, (0, 105), (0, 250), xt=[20, 40, 60, 80], yt=[50, 100, 150, 200], xl="$T$ (°C)", yl="g / 100 g water")
for name, v, c, lab in [("KNO3", [13, 32, 64, 110, 169, 246], R, "$\\mathrm{KNO_3}$"), ("NaNO3", [73, 88, 104, 124, 148, 180], O, "$\\mathrm{NaNO_3}$"), ("NaCl", [35.7, 36.0, 36.6, 37.3, 38.4, 39.8], B, "NaCl")]:
    tt = np.linspace(0, 100, 100); vv = np.interp(tt, T, v)
    p.curve(tt, vv, c=c); p.text(101 if name != "KNO3" else 88, (v[-1] if name != "KNO3" else 200) + 6, lab, c=c, size=7.5, ha="right" if name != "KNO3" else "right")
p.save("c09_solT")
p = Plot(6.0, 5.0, (0, 55), (0, 16), xt=[10, 20, 30, 40], yt=[5, 10], xl="$T$ (°C)", yl="mg/L")
tt = np.linspace(0, 50, 100); p.curve(tt, np.interp(tt, [0, 10, 20, 30, 40, 50], [14.6, 11.3, 9.1, 7.6, 6.4, 5.6]), c=B)
p.text(20, 10.5, "$\\mathrm{O_2}$ in water at 1 atm air", c=B, size=7.5)
p.save("c09_O2T")

# ---------- Raoult ----------
p = Plot(6.4, 4.8, (0, 1.12), (0, 1.15), xt=[0.5, 1], yt=[1], ytl=["$P^\\circ$"], xl="$X_{solvent}$", yl="$P_{vap}$")
x = np.linspace(0, 1, 50)
p.curve(x, x, c=B); p.curve(x, x + 0.25 * x * (1 - x), c=R, dash=(4, 2)); p.curve(x, x - 0.25 * x * (1 - x), c=G, dash=(4, 2))
p.text(0.5, 0.36, "ideal (Raoult)", c=B, size=7.5, rotation=0); p.text(0.12, 0.42, "weaker A–B\nattraction", c=R, size=7)
p.text(0.62, 0.32 + 0.0, "", c=G); p.text(0.72, 0.5, "stronger A–B\nattraction", c=G, size=7)
p.save("c09_raoult")

# ---------- phase diagram with solution ----------
p = Plot(8.0, 5.4, (0, 10), (0, 10), xt=[], yt=[5.0], ytl=["1 atm"], xl="$T$", yl="$P$", grid=False)
tx, ty, cx, cy = 3.0, 2.2, 8.6, 8.6
def vapc(t, shift): return ty + (cy - ty) * ((t - tx - shift) / (cx - tx)) ** 1.6
t = np.linspace(0.4, tx, 50); p.curve(t, ty * np.exp(2.2 * (t - tx)), c=INK)
t = np.linspace(tx, cx, 80); p.curve(t, vapc(t, 0), c=INK)
p.seg((tx, ty), (tx - 0.12 * 7.6, 9.8), c=INK, lw=1.3)
ts = tx - 0.35; ps = ty * np.exp(2.2 * (ts - tx)); cx2 = cx + 1.2
liq = lambda t: ps + (cy - ps) * (np.clip(t - ts, 0, None) / (cx2 - ts)) ** 1.6
t = np.linspace(ts, cx + 0.8, 120); p.curve(t, liq(t), c=R, dash=(4, 2))
p.seg((ts, ps), (ts - 0.12 * (9.8 - ps), 9.8), c=R, lw=1.2, dash=(4, 2))
p.hline(5.0, c=GREY, a=0, b=10)
def find(fun, a, b):
    xs = np.linspace(a, b, 4000); ys = fun(xs); i = np.nanargmin(np.abs(ys - 5.0)); return xs[i]
bp0 = find(lambda t: vapc(t, 0), tx, cx); bp1 = find(liq, ts, cx + 2)
fp0 = tx - 0.12 * (5.0 - ty); fp1 = ts - 0.12 * (5.0 - ps)
for xx, c in [(bp0, INK), (bp1, R), (fp0, INK), (fp1, R)]: p.vline(xx, c=c, b=5.0, dash=(2, 2))
p.arrow((bp0, 0.9), (bp1, 0.9), c=R); p.text((bp0 + bp1) / 2, 1.05, "$\\Delta T_b$", c=R, ha="center")
p.arrow((fp0, 0.9), (fp1, 0.9), c=R); p.text(fp1 - 0.1, 1.05, "$\\Delta T_f$", c=R, ha="right")
p.text(1.0, 7.5, "solid"); p.text(4.8, 8.2, "liquid"); p.text(7.5, 2.0, "gas")
p.text(9.9, 7.2, "solvent", ha="right", size=7.5); p.text(9.9, 6.0, "solution", ha="right", size=7.5, c=R)
p.save("c09_colligPD")

