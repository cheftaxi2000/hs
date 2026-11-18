from plot import *
from matplotlib.patches import Circle, FancyBboxPatch, Rectangle

# ---------- barometer and manometer ----------
s = Sketch(12.5, 6.2)
HG = "#b9c2cc"
# barometer: dish + inverted tube
s.ax.add_patch(Rectangle((0.6, 0.5), 3.6, 0.9, fc=HG, ec=INK, lw=0.8))
s.seg((0.6, 1.6), (0.6, 0.5)); s.seg((4.2, 1.6), (4.2, 0.5))
s.ax.add_patch(Rectangle((2.1, 0.9), 0.6, 3.6, fc=HG, ec="none"))
s.ax.add_patch(Rectangle((2.1, 4.5), 0.6, 1.2, fc="white", ec="none"))
s.seg((2.1, 0.9), (2.1, 5.7)); s.seg((2.7, 0.9), (2.7, 5.7)); s.seg((2.1, 5.7), (2.7, 5.7))
s.text(2.4, 5.1, "vacuum", ha="center", va="center", size=6.5, c="#555555")
s.arrow((3.3, 4.5), (3.3, 1.4), c=R); s.arrow((3.3, 1.4), (3.3, 4.5), c=R); s.text(3.45, 3.0, "$h = 760$ mm", c=R, size=8)
for x in (0.9, 1.4, 3.6, 3.95): s.arrow((x, 2.6), (x, 1.5), c=B, lw=0.8)
s.text(0.6, 2.75, "$P_{atm}$", c=B, size=8.5)
s.text(2.4, 0.1, "barometer", ha="center", va="top", size=8)
# manometer: bulb + U-tube open end
bx = 7.0
s.ax.add_patch(Circle((bx, 4.0), 0.95, fc=FILL_B, ec=INK, lw=0.8)); s.text(bx, 4.0, "gas\n$P_{gas}$", ha="center", va="center", size=8)
s.seg((bx + 0.95, 4.15), (9.0, 4.15)); s.seg((bx + 0.95, 3.85), (8.7, 3.85))
s.seg((9.0, 4.15), (9.0, 0.9)); s.seg((8.7, 3.85), (8.7, 1.2))
s.seg((8.7, 1.2), (10.3, 1.2)); s.seg((9.0, 0.9), (10.6, 0.9))
s.seg((10.3, 1.2), (10.3, 5.6)); s.seg((10.6, 0.9), (10.6, 5.6))
s.ax.add_patch(Rectangle((8.7, 0.9), 1.9, 0.3, fc=HG, ec="none", zorder=0))
s.ax.add_patch(Rectangle((8.7, 0.9), 0.3, 1.6, fc=HG, ec="none", zorder=0))
s.ax.add_patch(Rectangle((10.3, 0.9), 0.3, 3.1, fc=HG, ec="none", zorder=0))
s.hline = None
s.seg((8.4, 2.5), (11.0, 2.5), c=GREY, lw=0.6, dash=(3, 2)); s.seg((10.1, 4.0), (11.0, 4.0), c=GREY, lw=0.6, dash=(3, 2))
s.arrow((11.2, 2.5), (11.2, 4.0), c=R); s.arrow((11.2, 4.0), (11.2, 2.5), c=R); s.text(11.35, 3.2, "$h$", c=R)
for x in (10.45,): s.arrow((x, 6.2), (x, 5.0), c=B, lw=0.8)
s.text(10.6, 5.8, "$P_{atm}$", c=B, size=8.5)
s.text(9.3, 0.1, "open-end manometer: $P_{gas}=P_{atm}+\\rho g h$", ha="center", va="top", size=8)
s.save("c02_baro")

# ---------- Boyle and Charles ----------
p = Plot(6.4, 4.6, (0, 5.3), (0, 5.3), xt=[1, 2, 3, 4], yt=[1, 2, 3, 4], xl="$V$", yl="$P$")
for k, c in [(2, B), (4, R)]:
    p.f(lambda v: k / v, a=0.35, c=c)
p.text(4.3, 0.6, "$T_1$", c=B); p.text(3.4, 1.55, "$T_2>T_1$", c=R)
p.dot((1, 2), c=B); p.dot((2, 1), c=B)
p.text(1.05, 2.15, "$V$ halved", size=7.5); p.text(2.05, 1.12, "$\\rightarrow P$ doubled", size=7.5)
p.save("c02_boyle")
p = Plot(7.6, 4.6, (-300, 120), (0, 5.3), xt=[-273, -200, -100, 0], yt=[], xl="$T$ (°C)", yl="$V$")
for slope, c in [(0.010, B), (0.0135, R)]:
    p.f(lambda T: slope * (T + 273.15), a=-60, b=110, c=c)
    p.f(lambda T: slope * (T + 273.15), a=-273.15, b=-60, c=c, dash=(3, 2), lw=1.0)
p.dot((-273.15, 0), c=INK)
p.text(-262, 0.25, "$-273.15$ °C $=0$ K", size=7.5)
p.text(-250, 3.6, "$n,P$ fixed", size=7.5, c="#444444")
p.save("c02_charles")

# ---------- Maxwell-Boltzmann distributions ----------
kB = 1.380649e-23; u_ = 1.66054e-27
def mb(v, M, T):
    m = M * u_; a = m / (2 * kB * T)
    return 4 * np.pi * (a / np.pi) ** 1.5 * v ** 2 * np.exp(-a * v * v)
p = Plot(7.4, 4.6, (0, 2300), (0, 2.6), xt=[500, 1000, 1500, 2000], yt=[], xl="$u$ (m/s)", yl="fraction")
for T, c, lab, x in [(273, B, "273 K", 380), (1273, R, "1273 K", 1150)]:
    p.f(lambda v: 1e3 * mb(v, 28, T), a=1, c=c)
    p.text(x, 1e3 * mb(np.array([x]), 28, T)[0] + 0.12, lab, c=c)
p.text(1350, 2.2, "$\\mathrm{N_2}$", size=9)
p.save("c02_mb_T")
p = Plot(7.4, 4.6, (0, 3600), (0, 2.6), xt=[1000, 2000, 3000], yt=[], xl="$u$ (m/s)", yl="fraction")
for M, c, lab, x in [(32, B, "$\\mathrm{O_2}$", 520), (18, G, "$\\mathrm{H_2O}$", 820), (4, R, "He", 1900)]:
    p.f(lambda v: 1e3 * mb(v, M, 298), a=1, c=c)
    p.text(x + 60, 1e3 * mb(np.array([x]), M, 298)[0] + 0.05, lab, c=c)
p.text(2600, 2.2, "$T=298$ K", size=8.5)
p.save("c02_mb_M")
# special velocities
p = Plot(8.8, 4.6, (0, 1300), (0, 2.6), xt=[], yt=[], xl="$u$", yl="fraction")
M, T = 28, 298; m = M * u_
ump = np.sqrt(2 * kB * T / m); uav = np.sqrt(8 * kB * T / (np.pi * m)); urms = np.sqrt(3 * kB * T / m)
p.f(lambda v: 1e3 * mb(v, M, T), a=1, c=B)
for v, lab, c, dx_, yy in [(ump, "$u_{mp}$", G, -40, 2.05), (uav, "$u_{av}$", O, 0, 2.35), (urms, "$u_{rms}$", R, 60, 2.05)]:
    y = 1e3 * mb(np.array([v]), M, T)[0]; p.seg((v, 0), (v, yy - 0.05), c=c, lw=1.0, dash=(3, 2)); p.text(v + dx_, yy, lab, c=c, ha="center", size=8)
p.text(820, 1.6, "$u_{mp}<u_{av}<u_{rms}$", size=8.5)
p.save("c02_speeds")

# ---------- real gases ----------
p = Plot(7.4, 4.8, (0, 1000), (0.3, 2.1), xt=[200, 400, 600, 800], yt=[0.5, 1.0, 1.5], xl="$P$ (atm)", yl="$PV/nRT$")
p.hline(1.0, c=INK, dash=(4, 3))
P = np.linspace(0, 1000, 300)
p.curve(P, 1 + 0.00052 * P + 0.0 * P, c=O)                 # H2-like
p.curve(P, 1 - 0.0006 * P + 1.2e-6 * P ** 2 + 0.0 * P, c=B)   # N2-like
p.curve(P, 1 - 0.0024 * P + 3.3e-6 * P ** 2, c=R)              # CH4-like
p.text(820, 1.47, "$\\mathrm{H_2}$", c=O); p.text(820, 1.55 if False else 1.32, "", c=B)
p.text(900, 1.42 + 0.0, "", c=B)
p.text(700, 0.18 + 1.0 - 0.0006 * 700 + 1.2e-6 * 490000 + 0.04, "$\\mathrm{N_2}$", c=B)
p.text(560, 1 - 0.0024 * 560 + 3.3e-6 * 560 ** 2 - 0.12, "$\\mathrm{CH_4}$", c=R)
p.text(60, 1.03, "ideal gas", size=7.5)
p.save("c02_realgas")

# ---------- random walk / mean free path ----------
s = Sketch(6.0, 4.2); rng = np.random.default_rng(7)
st = [np.zeros(2)]
for k in range(24):
    a = rng.uniform(0, 2 * np.pi); L = rng.exponential(1.0) + 0.2
    st.append(st[-1] + L * np.array([np.cos(a), np.sin(a)]))
st = np.array(st); lo, hi = st.min(0), st.max(0)
sc = min(5.2 / (hi - lo)[0], 3.3 / (hi - lo)[1])
pts = (st - lo) * sc + np.array([0.4, 0.4])
s.curve(pts[:, 0], pts[:, 1], c=B, lw=1.0)
for q in pts[1:-1]: s.dot(q, c=O, r=2.2)
s.dot(pts[0], c=G, r=3.5); s.dot(pts[-1], c=R, r=3.5)
s.arrow(pts[0], pts[-1], c=R, lw=0.9)
s.text(pts[0][0], pts[0][1] - 0.15, "start", ha="center", va="top", size=7.5, c=G)
s.text(pts[-1][0], pts[-1][1] + 0.15, "end", ha="center", va="bottom", size=7.5, c=R)
s.save("c02_randomwalk")
