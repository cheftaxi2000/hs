from plot import *
from math import factorial

# Harmonische Reihe vs. sum 1/k^2
p = Plot(7.4, 4.2, (0, 41), (0, 5.1), xt=[10, 20, 30, 40], yt=[1, 2, 3, 4], xl="$n$", yl="$s_n$")
n = np.arange(1, 41); h = np.cumsum(1 / n); q = np.cumsum(1 / n ** 2)
for k in range(40): p.dot((n[k], h[k]), c=R, r=1.8); p.dot((n[k], q[k]), c=G, r=1.8)
p.hline(np.pi ** 2 / 6, c=G, lw=0.6)
p.text(40, h[-1] + 0.15, r"$\sum\frac{1}{k}$: wächst ohne Grenze", c=R, ha="right", size=8)
p.text(40, np.pi ** 2 / 6 - 0.15, r"$\sum\frac{1}{k^2}\to\frac{\pi^2}{6}$", c=G, ha="right", va="top", size=8)
p.save("a05_harmonisch")

# Leibniz: alternierende Partialsummen
p = Plot(7.4, 3.8, (0, 16.8), (0, 1.15), xt=[5, 10, 15], yt=[np.log(2), 1], ytl=[r"$\ln 2$", "1"], xl="$n$", yl="$s_n$")
s = np.cumsum([(-1) ** (k + 1) / k for k in range(1, 17)])
p.hline(np.log(2), c=G, lw=0.6)
p.curve(np.arange(1, 17), s, c=GREY, lw=0.6)
for k in range(16): p.dot((k + 1, s[k]), c=B, r=2.2)
p.save("a05_leibniz")

# Geometrische Reihe 1/(1-x) und Partialsummen
p = Plot(7.2, 4.6, (-1.6, 1.4), (-1.0, 6.0), xt=[-1, 1], yt=[1, 2, 4], )
p.polyfill([(-1, -1), (1, -1), (1, 6), (-1, 6)], c=FILL_G, alpha=0.5)
for N, c in [(2, P), (5, O), (12, R)]:
    p.f(lambda x, N=N: sum(x ** k for k in range(N + 1)), c=c, lw=0.9, dash=(4, 2))
p.f(lambda x: 1 / (1 - x), -1.6, 0.995, c=B, lw=1.5)
p.text(0.55, 4.6, r"$\frac{1}{1-x}$", c=B, size=9, ha="right"); p.text(-1.5, 5.6, r"$|x|<1$: Reihe konvergiert", c=G, size=7.5, va="top")
p.text(-1.55, 2.3, r"$s_{12}$", c=R, size=8); p.text(-1.55, 1.25, r"$s_5$", c=O, size=8, va="top"); p.text(-1.25, 0.25, r"$s_2$", c=P, size=8)
p.save("a05_geom")

# cos mit Taylorpolynomen
def taylor_cos(x, n): return sum((-1) ** k * x ** (2 * k) / factorial(2 * k) for k in range(n // 2 + 1))
p = Plot(8.6, 4.6, (-7.2, 7.2), (-1.8, 1.8), xt=[-6, -4, -2, 2, 4, 6], yt=[-1, 1])
for n, c in [(2, R), (4, O), (6, P), (10, G)]:
    p.f(lambda x, n=n: taylor_cos(x, n), c=c, lw=0.9)
p.f(np.cos, c=B, lw=1.6)
for n, c, x in [(2, R, 1.9), (4, O, 3.1), (6, P, 4.1), (10, G, 6.1)]:
    y = taylor_cos(x, n); y = max(min(y, 1.6), -1.6)
    p.text(x + 0.12, y, f"$P_{{{n}}}$", c=c, size=8, va="center")
p.text(-6.9, -1.55, r"$\cos x$", c=B, size=8)
p.save("a05_cos")

# exp mit Taylorpolynomen
p = Plot(6.4, 4.6, (-3.2, 2.4), (-1.2, 6.5), xt=[-3, -2, -1, 1, 2], yt=[2, 4, 6])
for n, c in [(1, R), (2, O), (3, P), (4, G)]:
    p.f(lambda x, n=n: sum(x ** k / factorial(k) for k in range(n + 1)), c=c, lw=0.9)
p.f(np.exp, c=B, lw=1.6); p.dot((0, 1))
p.text(1.7, 5.9, r"$e^x$", c=B, size=9, ha="right")
for n, c, xy in [(1, R, (2.0, 3.2)), (2, O, (-2.9, 2.6)), (3, P, (-2.7, -0.9)), (4, G, (-3.1, 4.5))]:
    p.text(*xy, f"$P_{n}$", c=c, size=8)
p.save("a05_exp")

# ln um 3
def taylor_ln(x, n): return np.log(3) + sum((-1) ** (k + 1) / k * ((x - 3) / 3) ** k for k in range(1, n + 1))
p = Plot(8.0, 4.6, (-0.5, 8.0), (-2.6, 3.0), xt=[1, 2, 3, 4, 5, 6, 7], yt=[-2, -1, 1, 2])
p.polyfill([(0, -2.6), (6, -2.6), (6, 3.0), (0, 3.0)], c=FILL_G, alpha=0.45)
for n, c in [(1, R), (3, O), (5, P), (15, G)]:
    p.f(lambda x, n=n: taylor_ln(x, n), c=c, lw=0.9)
p.f(np.log, 0.03, 8.0, c=B, lw=1.6); p.dot((3, np.log(3)))
p.text(7.9, np.log(7.9) - 0.15, r"$\ln x$", c=B, ha="right", va="top", size=9)
p.text(3, 2.85, r"Konvergenzbereich $0<x<6$", c=G, ha="center", va="top", size=8)
p.text(6.6, 2.6, "$P_1$", c=R, size=8, ha="right"); p.text(6.5, -2.3, "$P_{15}$", c=G, size=8); p.text(0.15, -2.3, "$P_3$", c=O, size=8)
p.save("a05_ln")

# Konvergenzintervall auf der Zahlengerade
s = Sketch(9.0, 1.6); y0 = 0.7
s.seg((0.2, y0), (8.8, y0), c=INK, lw=0.8)
s.ax.plot([2.2, 6.8], [y0, y0], color=G, lw=4, solid_capstyle="butt", zorder=2, alpha=0.6)
for x, t in [(2.2, r"$x_0-\rho$"), (4.5, r"$x_0$"), (6.8, r"$x_0+\rho$")]:
    s.seg((x, y0 - 0.12), (x, y0 + 0.12), lw=0.8); s.text(x, y0 - 0.2, t, ha="center", va="top", size=8)
s.text(4.5, y0 + 0.2, "Konvergenz", c=G, ha="center", size=8)
s.text(1.0, y0 + 0.2, "Divergenz", c=R, ha="center", size=8); s.text(8.0, y0 + 0.2, "Divergenz", c=R, ha="center", size=8)
s.text(2.2, y0 + 0.2, "?", c=O, ha="center", size=10); s.text(6.8, y0 + 0.2, "?", c=O, ha="center", size=10)
s.save("a05_intervall")
