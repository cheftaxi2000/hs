from plot import *
from matplotlib.patches import Circle, FancyBboxPatch, Rectangle
from math import comb

# ---------- microstates histogram (N = 10 molecules in two halves) ----------
N = 10
p = Plot(8.0, 4.6, (0, N + 1.8), (0, 275), xt=[k + 1 for k in range(N + 1)], xtl=[f"${k}$" for k in range(N + 1)], yt=[50, 100, 150, 200, 250], xl="", yl="$W$")
for k in range(N + 1):
    W = comb(N, k); x = k + 1
    p.polyfill([(x - 0.35, 0), (x + 0.35, 0), (x + 0.35, W), (x - 0.35, W)], c=FILL_B if k not in (0, N) else FILL_R)
    p.text(x, W + 4, str(W), ha="center", size=6.5)
p.text(1.0, 30, "all left:\nonly 1 way", size=7, c=R)
p.text(6.0, -38, "number of molecules in the left half", ha="center", va="top", size=7.5)
p.save("c05_microstates")

# ---------- entropy vs temperature ----------
p = Plot(7.4, 4.8, (0, 440), (0, 215), xt=[100, 200, 273, 373], yt=[], xl="$T$ (K)", yl="$S$")
T1 = np.linspace(0.1, 273, 200); S1 = 41 * (T1 / 273) ** 1.3
T2 = np.linspace(273, 373, 100); S2 = 63 + 75 * np.log(T2 / 273)
T3 = np.linspace(373, 430, 50); S3 = 195 + 34 * np.log(T3 / 373)
p.curve(T1, S1, c=B); p.curve(T2, S2, c=G); p.curve(T3, S3, c=R)
p.seg((273, 41), (273, 63), c=INK, lw=1.0, dash=(2, 2)); p.seg((373, S2[-1]), (373, 195), c=INK, lw=1.0, dash=(2, 2))
p.text(110, 30, "solid", c=B); p.text(290, 95, "liquid", c=G); p.text(385, 160, "gas", c=R)
p.text(278, 48, "melting", size=7.5); p.text(366, 140, "boiling", size=7.5, ha="right")
p.text(8, 4, "$S=0$ at 0 K", size=7.5)
p.save("c05_entropyT")

# ---------- Delta G vs T: four cases ----------
p = Plot(8.6, 5.4, (0, 10), (-5, 5), xt=[], yt=[], xl="$T$", yl="$\\Delta G$")
p.hline(0, c=INK, dash=None, lw=0.7)
cases = [(-1.0, 0.3, G, "1: $\\Delta H<0,\\ \\Delta S>0$"), (2.0, -0.25, R, "2: $\\Delta H>0,\\ \\Delta S<0$"),
         (-3.5, -0.55, B, "3: $\\Delta H<0,\\ \\Delta S<0$"), (3.0, 0.62, O, "4: $\\Delta H>0,\\ \\Delta S>0$")]
for H, S, c, lab in cases:
    p.f(lambda T: H - S * T, a=0, b=10, c=c)
p.text(9.9, -4.55, "1: always spontaneous", c=G, size=7.5, ha="right")
p.text(9.9, 4.7, "2: never spontaneous", c=R, size=7.5, ha="right", va="top")
p.text(9.9, 1.65, "3: spont. at low $T$", c=B, size=7.5, ha="right")
p.text(9.9, -2.75, "4: spont. at high $T$", c=O, size=7.5, ha="right")
p.text(0.15, -0.6, "1", c=G, size=8); p.text(0.15, 2.3, "2", c=R, size=8); p.text(0.15, -3.2, "3", c=B, size=8); p.text(0.15, 3.3, "4", c=O, size=8)
p.save("c05_dGT")
