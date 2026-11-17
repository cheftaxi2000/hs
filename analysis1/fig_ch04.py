from plot import *
from matplotlib.patches import Ellipse
t = np.linspace(0, 2 * np.pi, 400)

# Vorzeichenbehaftete Fläche
f = lambda x: 0.35 * (x - 0.5) * (x - 2.5) * (x - 4.6) + 0.1
p = Plot(7.0, 4.2, (-0.3, 5.2), (-2.2, 2.4), xt=[], yt=[])
x = np.linspace(0.3, 4.2, 500); y = f(x)
p.fill(x, np.where(y > 0, y, 0), 0, c=FILL_B); p.fill(x, np.where(y < 0, y, 0), 0, c=FILL_R)
p.f(f, -0.1, 5.0, c=INK, lw=1.1)
p.vline(0.3, a=0, b=f(0.3)); p.vline(4.2, a=f(4.2), b=0)
p.text(0.3, 0.08, "$a$", ha="center"); p.text(4.2, 0.08, "$b$", ha="center")
p.text(1.4, 0.45, "$+$", c=B, ha="center", size=11); p.text(3.5, -0.6, r"$-$", c=R, ha="center", size=11)
p.text(4.95, 2.2, r"$f(x)$", ha="right", va="top")
p.save("a04_flaeche")

# Riemann-Summe
f = lambda x: 0.6 + 0.9 * np.sin(0.8 * x) + 0.12 * x
p = Plot(7.0, 4.0, (0, 5.0), (0, 2.4), xt=[], yt=[])
a, b, n = 0.5, 4.5, 8; xs = np.linspace(a, b, n + 1)
for i in range(n):
    xm = 0.5 * (xs[i] + xs[i + 1]); h = f(xm)
    p.polyfill([(xs[i], 0), (xs[i + 1], 0), (xs[i + 1], h), (xs[i], h)], c=FILL_B)
    p.curve([xs[i], xs[i], xs[i + 1], xs[i + 1]], [0, h, h, 0], c=B, lw=0.6); p.dot((xm, h), c=R, r=2)
p.f(f, 0.1, 4.9, c=INK, lw=1.2)
p.text(a, -0.05, "$a$", ha="center", va="top"); p.text(b, -0.05, "$b$", ha="center", va="top")
i = 5; p.text(0.5 * (xs[i] + xs[i + 1]), -0.05, r"$\Delta x$", ha="center", va="top", size=7.5)
p.text(0.5 * (xs[2] + xs[3]), f(0.5 * (xs[2] + xs[3])) + 0.1, r"$f(\xi_k)$", c=R, ha="center", size=7.5)
p.save("a04_riemann")

# Flächenfunktion / Hauptsatz
f = lambda x: 0.8 + 0.5 * np.sin(1.1 * x) + 0.1 * x
p = Plot(7.0, 4.0, (0, 5.0), (0, 2.1), xt=[], yt=[], xl="$t$")
a, X, h = 0.6, 3.0, 0.35
xx = np.linspace(a, X, 200); p.fill(xx, f(xx), 0, c=FILL_B)
xx = np.linspace(X, X + h, 50); p.fill(xx, f(xx), 0, c=FILL_R)
p.f(f, 0.1, 4.9, c=INK)
for v in (a, X, X + h): p.vline(v, a=0, b=f(v), c=GREY, dash=None, lw=0.5)
p.text(a, -0.04, "$a$", ha="center", va="top"); p.text(X, -0.04, "$x$", ha="center", va="top"); p.text(X + h + 0.05, -0.04, "$x+h$", ha="left", va="top")
p.text(1.8, 0.45, "$F(x)$", c=B, ha="center"); p.text(X + h / 2, f(X) + 0.12, r"$\approx f(x)\,h$", c=R, ha="center", size=8)
p.save("a04_hauptsatz")

# Fläche zwischen Kurven
p = Plot(6.4, 4.4, (-1.6, 2.8), (-1.4, 4.6), xt=[-1, 1, 2], yt=[1, 2, 3, 4])
g1 = lambda x: x + 2; g2 = lambda x: x ** 2
x = np.linspace(-1, 2, 300); p.fill(x, g1(x), g2(x), c=FILL_G)
p.f(g1, c=B, label=r"$g(x)=x+2$", lab_at=2.25, lab_off=(-0.1, 0.1), ha="right"); p.f(g2, c=R, label=r"$f(x)=x^2$", lab_at=-1.45, lab_off=(0.1, 0))
p.dot((-1, 1)); p.dot((2, 4))
p.save("a04_zwischen")

# Parametrische Flächen
def param_area(name, mode):
    p = Plot(5.4, 4.2, (0, 4.4), (0, 3.4), xt=[], yt=[])
    tt = np.linspace(0, 1, 200)
    if mode == "x": X = 0.7 + 3.0 * tt; Y = 0.9 + 1.6 * tt - 0.9 * tt ** 2 + 0.6 * np.sin(4 * tt) * 0.5
    else: Y = 0.6 + 2.3 * tt; X = 1.8 + 0.9 * np.sin(5 * tt) + 0.6 * tt
    if mode == "x": p.fill(X, Y, 0, c=FILL_B)
    else:
        p.ax.fill_betweenx(Y, X, 0, color=FILL_B, lw=0, zorder=1)
    p.curve(X, Y, c=B)
    p.dot((X[0], Y[0])); p.dot((X[-1], Y[-1]))
    if mode == "x":
        p.vline(X[0], a=0, b=Y[0]); p.vline(X[-1], a=0, b=Y[-1])
        p.text(X[0], -0.05, "$x_1$", ha="center", va="top"); p.text(X[-1], -0.05, "$x_2$", ha="center", va="top")
        p.text(2.2, 0.7, "$A$", ha="center", size=10)
    else:
        p.hline(Y[0], a=0, b=X[0]); p.hline(Y[-1], a=0, b=X[-1])
        p.text(-0.05, Y[0], "$y_1$", ha="right", va="center"); p.text(-0.05, Y[-1], "$y_2$", ha="right", va="center")
        p.text(1.2, 1.7, "$A$", ha="center", size=10)
    p.text(X[0] - 0.05, Y[0] + 0.1, "$t_1$", ha="right", c=B, size=8); p.text(X[-1] + 0.05, Y[-1] + 0.1, "$t_2$", c=B, size=8)
    p.save(name)
param_area("a04_param_x", "x"); param_area("a04_param_y", "y")

# Ellipse und y-Achse
p = Plot(5.4, 4.0, (-0.4, 3.4), (-0.4, 2.4), xt=[], yt=[], equal=True)
a, b = 2.8, 1.8; tt = np.linspace(0, np.pi / 3, 100)
p.ax.fill_betweenx(b * np.sin(tt), a * np.cos(tt), 0, color=FILL_B, lw=0, zorder=1)
p.curve(a * np.cos(t), b * np.sin(t), c=GREY, lw=0.6, dash=(3, 2)); p.curve(a * np.cos(tt), b * np.sin(tt), c=B, lw=1.4)
p.dot((a, 0)); p.dot((a * np.cos(np.pi / 3), b * np.sin(np.pi / 3)))
p.text(a + 0.05, 0.08, "$t=0$", size=8); p.text(a * 0.5 + 0.08, b * np.sin(np.pi / 3) + 0.05, r"$t=\frac{\pi}{3}$", size=8)
p.text(0.9, 0.6, "$A$", size=10)
p.save("a04_ellipse_y")

# Sektor allgemein
p = Plot(5.0, 4.2, (-0.4, 3.6), (-0.4, 3.2), xt=[], yt=[], equal=True, grid=False)
ph = np.linspace(0.3, 1.25, 200); r = 1.4 + 0.9 * ph
X, Y = r * np.cos(ph), r * np.sin(ph)
p.polyfill(list(zip(np.r_[0, X], np.r_[0, Y])), c=FILL_B)
p.curve(X, Y, c=B); p.seg((0, 0), (X[0], Y[0]), c=INK, lw=0.6); p.seg((0, 0), (X[-1], Y[-1]), c=INK, lw=0.6)
p.text(1.2, 0.95, "$A$", size=10)
p.text(X[0] + 0.05, Y[0] - 0.05, r"$t_1$", c=B, size=8, va="top"); p.text(X[-1], Y[-1] + 0.08, r"$t_2$", c=B, size=8)
p.save("a04_sektor")

# Archimedische Spirale
p = Plot(6.4, 4.4, (-4.2, 3.0), (-1.0, 4.0), xt=[-3, -2, -1, 1, 2], yt=[1, 2, 3], equal=True)
ph = np.linspace(0, 2 * np.pi, 500); r = 1 + ph; p.curve(r * np.cos(ph), r * np.sin(ph), c=GREY, lw=0.6, dash=(3, 2))
ph = np.linspace(np.pi / 6, 5 * np.pi / 6, 300); r = 1 + ph
p.polyfill(list(zip(np.r_[0, r * np.cos(ph)], np.r_[0, r * np.sin(ph)])), c=FILL_B)
p.curve(r * np.cos(ph), r * np.sin(ph), c=B, lw=1.4)
for a_ in (np.pi / 6, 5 * np.pi / 6): p.seg((0, 0), ((1 + a_) * np.cos(a_), (1 + a_) * np.sin(a_)), c=INK, lw=0.6)
p.text(1.6, 0.85, r"$\varphi_1=\frac{\pi}{6}$", size=8); p.text(-3.1, 2.0, r"$\varphi_2=\frac{5\pi}{6}$", size=8, ha="right")
p.text(1.4, 2.8, r"$r=1+\varphi$", c=B, size=8)
p.save("a04_spirale")

# Logarithmische Spirale
p = Plot(6.4, 4.4, (-2.4, 2.4), (-0.6, 2.4), xt=[-2, -1, 1, 2], yt=[1, 2], equal=True)
ph = np.linspace(-2, 3.6, 500); r = np.exp(0.5 * ph); p.curve(r * np.cos(ph), r * np.sin(ph), c=GREY, lw=0.6, dash=(3, 2))
ph = np.linspace(0, 1, 100); r = np.exp(0.5 * ph); p.curve(r * np.cos(ph), r * np.sin(ph), c=B, lw=1.6)
p.dot((1, 0)); p.dot((np.exp(0.5) * np.cos(1), np.exp(0.5) * np.sin(1)))
p.text(1.1, 0.08, r"$\varphi=0$", size=8); p.text(np.exp(0.5) * np.cos(1) + 0.08, np.exp(0.5) * np.sin(1), r"$\varphi=1$", size=8)
p.save("a04_logspirale")

# Bogenlänge: kleines Dreieck
p = Plot(5.0, 3.6, (0, 4.0), (0, 2.8), xt=[], yt=[], grid=False)
f = lambda x: 0.4 + 0.12 * x ** 2 + 0.15 * x
p.f(f, 0.2, 3.9, c=B)
x0, dx = 1.7, 1.1; p.seg((x0, f(x0)), (x0 + dx, f(x0)), c=GREY, lw=0.7); p.seg((x0 + dx, f(x0)), (x0 + dx, f(x0 + dx)), c=GREY, lw=0.7)
p.seg((x0, f(x0)), (x0 + dx, f(x0 + dx)), c=R, lw=1.2)
p.text(x0 + dx / 2, f(x0) - 0.06, r"$\mathrm{d}x$", ha="center", va="top"); p.text(x0 + dx + 0.06, (f(x0) + f(x0 + dx)) / 2, r"$\mathrm{d}y$", va="center")
p.text(x0 + dx / 2 - 0.08, (f(x0) + f(x0 + dx)) / 2 + 0.1, r"$\mathrm{d}s$", c=R, ha="right")
p.save("a04_bogen")

# Rotationskörper um x-Achse (Scheibe)
def rot_x(name):
    s = Sketch(6.6, 4.4); ox, oy = 0.5, 2.2
    f = lambda x: 0.9 + 0.35 * np.sin(1.2 * x) + 0.12 * x
    x = np.linspace(0.6, 5.2, 300)
    s.curve(ox + x, oy + f(x), c=B, lw=1.3); s.curve(ox + x, oy - f(x), c=B, lw=0.8)
    for xe, lw in [(0.6, 0.8), (5.2, 0.8)]: s.ax.add_patch(Ellipse((ox + xe, oy), 0.5 * f(xe), 2 * f(xe), fill=False, ec=B, lw=lw, zorder=3))
    xm, dx = 3.0, 0.3
    s.ax.add_patch(Ellipse((ox + xm, oy), 0.5 * f(xm), 2 * f(xm), fc=FILL_R, ec=R, lw=0.9, zorder=2))
    s.arrow((ox - 0.2, oy), (ox + 6.0, oy), c=INK, lw=0.7); s.text(ox + 6.0, oy - 0.12, "$x$", va="top")
    s.seg((ox + xm, oy), (ox + xm, oy + f(xm)), c=R, lw=0.8); s.text(ox + xm + 0.08, oy + f(xm) / 2 + 0.1, "$f(x)$", c=R, size=8)
    s.text(ox + 5.3, oy + f(5.2) + 0.05, "$y=f(x)$", c=B, size=8)
    s.save(name)
rot_x("a04_rotx")

# Beispiel Rotationsvolumen: Parabelbögen
p = Plot(5.0, 4.6, (-0.4, 1.6), (-1.4, 1.5), xt=[1], yt=[-1, 1], equal=True)
yy = np.linspace(-1, 1, 300); xx = (np.abs(yy) - 1) ** 2
p.ax.fill_betweenx(yy, xx, 0, color=FILL_B, lw=0, zorder=1)
p.curve((yy[yy >= 0] - 1) ** 2, yy[yy >= 0], c=B, lw=1.4); p.curve((-yy[yy <= 0] - 1) ** 2, yy[yy <= 0], c=G, lw=1.2)
p.seg((0, -1), (0, 1), c=INK, lw=1.2)
p.dot((0, 1)); p.dot((0, -1)); p.dot((1, 0))
p.text(0.55, 0.6, r"$y=1-\sqrt{x}$", c=B, size=8); p.text(0.1, 1.08, "$(0,1)$", size=8)
p.save("a04_rotbsp")

# Kegel mit Querschnitt
s = Sketch(5.0, 4.6); ox, oy = 2.5, 0.6
s.ax.add_patch(Ellipse((ox, oy), 3.0, 0.7, fill=False, ec=B, lw=0.9))
s.seg((ox - 1.5, oy), (ox, oy + 3.6), c=B); s.seg((ox + 1.5, oy), (ox, oy + 3.6), c=B)
zz = 1.5; rr = 1.5 * (1 - zz / 3.6)
s.ax.add_patch(Ellipse((ox, oy + zz), 2 * rr, 0.7 * rr / 1.5 * 1.0, fc=FILL_R, ec=R, lw=0.9, zorder=3))
s.arrow((ox, oy - 0.3), (ox, oy + 4.2), c=INK, lw=0.7); s.text(ox + 0.1, oy + 4.15, "$z$", va="top")
s.seg((ox, oy + zz), (ox + rr, oy + zz), c=R, lw=0.8); s.text(ox + rr / 2, oy + zz + 0.05, "$r(z)$", c=R, ha="center", size=8)
s.text(ox - 0.1, oy + 3.65, "$4$", size=8, ha="right"); s.text(ox + 1.55, oy - 0.05, "$1$", size=8, va="top")
s.text(ox - 1.9, oy + zz, r"$F(z)=\pi r(z)^2$", c=R, size=8, ha="center")
s.save("a04_kegel")

# Oberflächen-Beispiel
p = Plot(5.6, 3.6, (-0.2, 2.4), (-0.2, 1.4), xt=[0.5, 1, 1.5, 2], yt=[0.5, 1], equal=True)
tt = np.linspace(0, 1, 200); p.curve(2 * tt, 2 * (np.cosh(tt) - 1), c=B, lw=1.4)
p.text(1.1, 0.75, r"$\gamma(t)=(2t,\ 2(\cosh t-1))$", c=B, size=8, ha="right")
p.save("a04_flbsp")

# Schwerpunkt: Streifen
p = Plot(5.6, 4.2, (-0.2, 4.2), (-0.2, 3.2), xt=[], yt=[], grid=False)
f = lambda x: 2.4 - 0.15 * (x - 1.2) ** 2
xx = np.linspace(0.3, 3.8, 200); p.fill(xx, f(xx), 0.4, c=FILL_B)
p.curve(xx, f(xx), c=B); p.seg((0.3, 0.4), (3.8, 0.4), c=B); p.seg((0.3, 0.4), (0.3, f(0.3)), c=B); p.seg((3.8, 0.4), (3.8, f(3.8)), c=B)
x1, dx = 2.6, 0.18; p.polyfill([(x1, 0.4), (x1 + dx, 0.4), (x1 + dx, f(x1)), (x1, f(x1))], c=FILL_R, z=2)
p.text(x1 + dx + 0.06, 1.3, "$H(x)$", c=R, size=8); p.text(x1 + dx / 2, 0.35, "$x$", ha="center", va="top", size=8)
p.dot((2.05, 1.38), c=INK); p.text(2.0, 1.38, "$S$", ha="right", va="bottom", size=8)
p.save("a04_schwerpunkt")

# Uneigentliche Integrale
p = Plot(5.2, 4.0, (-0.1, 1.6), (-4.2, 0.8), xt=[1], yt=[-3, -2, -1])
xx = np.linspace(0.001, 1, 400); p.fill(xx, np.log(xx), 0, c=FILL_R)
p.f(np.log, 0.012, 1.6, c=B); p.text(1.15, 0.12, r"$\ln x$", c=B, size=8)
p.text(0.62, -0.3, r"$A=-1$", c=R, size=8)
p.save("a04_ln")
p = Plot(6.6, 4.0, (-0.2, 6.4), (-0.2, 2.4), xt=[1, 2, 3, 4, 5, 6], yt=[1, 2])
xx = np.linspace(1, 6.4, 300); p.fill(xx, 1 / xx, 1 / xx ** 2, c=FILL_R); p.fill(xx, 1 / xx ** 2, 0, c=FILL_G)
p.f(lambda x: 1 / x, 0.4, 6.4, c=R); p.text(4.2, 0.42, r"$\frac{1}{x}$: Fläche $\infty$", c=R, size=8)
p.f(lambda x: 1 / x ** 2, 0.62, 6.4, c=G); p.text(2.6, 1.15, r"$\frac{1}{x^2}$: Fläche $1$", c=G, size=8); p.arrow((2.55, 1.1), (1.6, 0.25), c=G, lw=0.7)
p.vline(1, a=0, b=1)
p.save("a04_px")
p = Plot(7.0, 3.0, (-5.2, 5.2), (-0.2, 1.4), xt=[-4, -2, 2, 4], yt=[1])
xx = np.linspace(-5.2, 5.2, 300); p.fill(xx, 1 / (1 + xx ** 2), 0, c=FILL_B)
p.f(lambda x: 1 / (1 + x ** 2), c=B, label=r"$\frac{1}{1+x^2}$", lab_at=1.3, lab_off=(0.12, 0.05))
p.text(-3.0, 0.45, r"Fläche $=\pi$", c=B, size=8, ha="center")
p.save("a04_lorentz")
