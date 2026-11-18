from plot import *
from matplotlib.patches import Circle, Ellipse, Rectangle

# ---------- boiling points of hydrides ----------
O_ = 200
p = Plot(8.2, 5.4, (1.5, 5.9), (0, 320), xt=[2, 3, 4, 5], yt=[50, 100, 150, 200, 250, 300], ytl=["$-150$", "$-100$", "$-50$", "$0$", "$50$", "$100$"], xl="period", yl="$T_{bp}$")
data = {"g14": ([-161, -112, -88, -52], ["CH$_4$", "SiH$_4$", "GeH$_4$", "SnH$_4$"], GREY, -52),
        "g15": ([-33, -88, -62, -17], ["NH$_3$", "PH$_3$", "AsH$_3$", "SbH$_3$"], G, -22),
        "g16": ([100, -60, -41, -2], ["H$_2$O", "H$_2$S", "H$_2$Se", "H$_2$Te"], B, 6),
        "g17": ([20, -85, -67, -35], ["HF", "HCl", "HBr", "HI"], R, -38)}
for k, (g, (v, labs, c, yr)) in enumerate(data.items()):
    x = np.array([2, 3, 4, 5]); vv = np.array(v) + O_; p.curve(x, vv, c=c, lw=1.1)
    for xi, vi in zip(x, vv): p.dot((xi, vi), c=c, r=2.4)
    p.text(5.1, yr + O_, labs[-1], c=c, size=7.5, va="center")
    p.text(1.92, vv[0] + (8 if g != "g15" else -4), labs[0], c=c, size=7.5, ha="right", va="center")
p.text(3.1, 270, "H-bonding: $\\mathrm{H_2O}$, HF, $\\mathrm{NH_3}$\nfar above the trend", size=7.5)
p.save("c08_hydrides")

# ---------- dispersion cartoon ----------
s = Sketch(13.0, 3.0)
def blob(cx, shift, lab):
    s.ax.add_patch(Ellipse((cx + shift, 1.6), 2.4, 1.6, fc=FILL_B, ec=B, lw=0.8, alpha=0.9))
    s.ax.add_patch(Circle((cx, 1.6), 0.12, fc=INK, ec="none", zorder=5))
    if shift:
        s.text(cx + shift + 0.8, 2.55, "$\\delta^-$", ha="center", size=10, c=R); s.text(cx - 0.9, 2.55, "$\\delta^+$", ha="center", size=10, c=B)
    s.text(cx, 0.45, lab, ha="center", size=7.5, c="#444444")
blob(1.8, 0.0, "symmetric on average"); s.arrow((3.5, 1.6), (4.3, 1.6), c=INK)
blob(6.2, 0.45, "momentary fluctuation"); blob(10.2, 0.45, "induced dipole in neighbour")
s.text(8.2, 1.6, "$\\cdots$", ha="center", va="center", size=12)
s.save("c08_dispersion")

# ---------- water H-bonds ----------
s = Sketch(7.6, 4.6); OC, HC = "#e06a5a", "#f4f4f4"
def w(x, y, a):
    s.ax.add_patch(Circle((x, y), 0.32, fc=OC, ec="#555555", lw=0.5, zorder=4))
    pts = []
    for d in (-0.91, 0.91):
        hx, hy = x + 0.42 * np.cos(a + d), y + 0.42 * np.sin(a + d)
        s.ax.add_patch(Circle((hx, hy), 0.19, fc=HC, ec="#555555", lw=0.5, zorder=5)); pts.append((hx, hy))
    return pts
c0 = (3.8, 2.3); hs = w(*c0, np.radians(-90))
others = []
for ang in [210, 330]:
    a = np.radians(ang); h = (c0[0] + 0.42 * np.cos(a), c0[1] + 0.42 * np.sin(a))
    o = (c0[0] + 1.75 * np.cos(a), c0[1] + 1.75 * np.sin(a)); w(*o, a + np.pi + 1.6)
    s.seg(h, (o[0] - 0.33 * np.cos(a), o[1] - 0.33 * np.sin(a)), c=B, lw=1.0, dash=(2, 2))
for ang in [60, 120]:
    a = np.radians(ang); o = (c0[0] + 1.75 * np.cos(a), c0[1] + 1.75 * np.sin(a))
    hh = w(*o, a + np.pi)
    h = min(hh, key=lambda q: np.hypot(q[0] - c0[0], q[1] - c0[1]))
    s.seg(h, (c0[0] + 0.33 * np.cos(a), c0[1] + 0.33 * np.sin(a)), c=B, lw=1.0, dash=(2, 2))
s.text(7.4, 0.25, "dashed: hydrogen bonds", ha="right", size=7.5, c=B)
s.save("c08_hbond")

# ---------- kinetic energy distribution and evaporation ----------
p = Plot(7.8, 4.6, (0, 10), (0, 0.52), xt=[], yt=[], xl="$E_k$", yl="fraction")
E = np.linspace(0, 10, 400)
def dist(T): return 2 / np.sqrt(np.pi) * np.sqrt(E) / T ** 1.5 * np.exp(-E / T)
for T, c, lab in [(1.0, B, "low $T$"), (1.8, R, "high $T$")]:
    p.curve(E, dist(T), c=c)
Emin = 5.0
m = E >= Emin
p.fill(E[m], dist(1.8)[m], 0, c=FILL_R); p.fill(E[m], dist(1.0)[m], 0, c=FILL_B)
p.vline(Emin, c=INK, b=0.45); p.text(5.1, 0.42, "energy needed to escape the liquid", size=7.5)
p.text(1.2, 0.46, "low $T$", c=B); p.text(2.6, 0.27, "high $T$", c=R)
p.save("c08_escape")

# ---------- vapour pressure curves ----------
p = Plot(8.0, 5.0, (0, 105), (0, 125), xt=[20, 40, 60, 80, 100], yt=[25, 50, 75, 101.3, 125], ytl=["$25$", "$50$", "$75$", "$101$", ""], xl="$T$ (°C)", yl="$P_{vap}$ (kPa)")
R_ = 8.314
for name, Hv, Tb, c, lx in [("diethyl ether", 26.0e3, 307.8, O, 23), ("ethanol", 38.6e3, 351.4, G, 66), ("water", 40.7e3, 373.15, B, 92)]:
    f = lambda T: 101.325 * np.exp(-Hv / R_ * (1 / (T + 273.15) - 1 / Tb))
    p.f(f, a=0, b=105, c=c)
    p.text(lx + 1, min(f(lx), 117), name, c=c, size=7.5, ha="left" if name != "water" else "right")
p.hline(101.325, c=GREY); p.text(2, 104, "1 atm: normal boiling point", size=7)
p.save("c08_vapP")

# ---------- Clausius-Clapeyron straight line ----------
p = Plot(5.8, 4.6, (2.6, 3.7), (0, 5.4), xt=[2.8, 3.0, 3.2, 3.4], yt=[], xl="$1/T$", yl="$\\ln P_{vap}$")
x = np.linspace(2.65, 3.5, 50); Hv = 40.7e3
p.curve(x, -Hv / R_ * (x * 1e-3) + Hv / R_ / 373.15 + np.log(101.325), c=B)
p.text(3.0, 4.8, "slope $=-\\Delta H_{vap}/R$", size=8)
p.save("c08_cc")

# ---------- heating curve ----------
q = [0, 0.953, 0.953 + 6.01, 0.953 + 6.01 + 7.53, 0.953 + 6.01 + 7.53 + 40.6, 0.953 + 6.01 + 7.53 + 40.6 + 0.938]
T = [-25, 0, 0, 100, 100, 125]; T = [t + 40 for t in T]
p = Plot(12.5, 5.0, (0, 60), (0, 180), xt=[10, 20, 30, 40], yt=[15, 40, 140, 165], ytl=["$-25$", "$0$", "$100$", "$125$"], xl="heat added (kJ)", yl="$T$")
cols = [B, P, G, R, O]
for i in range(5): p.curve(q[i:i + 2], T[i:i + 2], c=cols[i], lw=1.6)
labs = ["A", "B", "C", "D", "E", "F"]
offs = [(0.5, -12), (0.4, 5), (0.4, -14), (-1.4, 5), (-1.6, -14), (0.6, 2)]
for i in range(6): p.dot((q[i], T[i]), c=INK, r=2.4); p.text(q[i] + offs[i][0], T[i] + offs[i][1], labs[i], size=8)
p.text(1.4, 18, "ice warms", c=B, size=7.5); p.text(3.0, 48, "melting", c=P, size=7.5)
p.text(11.5, 85, "water warms", c=G, size=7.5); p.text(30, 145, "boiling: 40.6 kJ, the largest step", c=R, size=7.5)
p.text(58.5, 170, "steam", c=O, size=7.5, ha="right")
p.save("c08_heating")

# ---------- phase diagrams ----------
def phase(name, tp, cp, solid_slope, title, xt, yt, xtl, ytl, xl, lab):
    p = Plot(7.0, 5.6, (0, 10), (0, 10), xt=xt, yt=yt, xtl=xtl, ytl=ytl, xl="$T$", yl="$P$", grid=False)
    tx, ty = tp; cx, cy = cp
    t = np.linspace(0.4, tx, 50); p.curve(t, ty * np.exp(2.2 * (t - tx)), c=INK)                     # sublimation
    t = np.linspace(tx, cx, 50); p.curve(t, ty + (cy - ty) * ((t - tx) / (cx - tx)) ** 1.6, c=INK)     # vaporisation
    p.seg((tx, ty), (tx + solid_slope * (9.8 - ty), 9.8), c=INK, lw=1.3)                              # melting
    p.dot(tp, c=R); p.dot(cp, c=R)
    p.text(tx + 0.15, ty - 0.25, "triple point", size=7, c=R, va="top"); p.text(cx + 0.1, cy + 0.15, "critical point", size=7, c=R)
    for (x, y, t_) in lab: p.text(x, y, t_, size=8.5, ha="center")
    p.text(5, 10.2, title, ha="center", size=8.5)
    return p
p = phase("h2o", (3.0, 2.2), (8.3, 7.3), -0.12, "$\\mathrm{H_2O}$", [3.0, 4.6], [5.0], ["", ""], ["1 atm"], "", [(1.4, 6.5, "solid"), (5.0, 7.5, "liquid"), (6.5, 1.5, "gas")])
p.hline(5.0, c=GREY, a=0, b=10); p.vline(2.72, c=GREY, b=5.0); p.vline(6.6, c=GREY, b=5.0)
p.text(2.72, -0.3, "0 °C", ha="center", va="top", size=7); p.text(6.6, -0.3, "100 °C", ha="center", va="top", size=7)
p.save("c08_pd_h2o")
p = phase("co2", (4.2, 4.0), (7.6, 8.2), 0.12, "$\\mathrm{CO_2}$", [], [2.0], [], ["1 atm"], "", [(2.2, 7.2, "solid"), (6.0, 8.6, "liquid"), (7.2, 2.2, "gas")])
p.hline(2.0, c=GREY, a=0, b=10); p.vline(3.38, c=GREY, b=2.0); p.text(3.38, -0.3, "$-78$ °C", ha="center", va="top", size=7)
p.text(3.6, 2.15, "sublimes", size=7, c=B)
p.save("c08_pd_co2")
