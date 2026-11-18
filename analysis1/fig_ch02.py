from plot import *

# Sekante -> Tangente
f = lambda x: 0.25 * x ** 2 + 0.6
p = Plot(7.0, 4.8, (0, 4.4), (0, 5.0), xt=[], yt=[])
p.f(f, c=B)
x0 = 1.2
for h_, a in [(2.4, 0.35), (1.5, 0.6), (0.8, 0.85)]:
    m = (f(x0 + h_) - f(x0)) / h_
    p.f(lambda x: f(x0) + m * (x - x0), 0.2, 4.3, c=R, lw=0.8, dash=(4, 2))
p.f(lambda x: f(x0) + 0.5 * x0 * (x - x0), 0.2, 4.3, c=G, lw=1.2)
h_ = 2.4
p.dot((x0, f(x0))); p.dot((x0 + h_, f(x0 + h_)), c=R)
p.seg((x0, f(x0)), (x0 + h_, f(x0)), c=GREY, dash=(2, 2), lw=0.6); p.seg((x0 + h_, f(x0)), (x0 + h_, f(x0 + h_)), c=GREY, dash=(2, 2), lw=0.6)
p.text(x0 + h_ / 2, f(x0) - 0.08, r"$\Delta x$", ha="center", va="top"); p.text(x0 + h_ - 0.06, 1.55, r"$\Delta f$", va="center", ha="right")
p.vline(x0, a=0, b=f(x0)); p.text(x0, -0.08, r"$x_0$", ha="center", va="top"); p.text(x0 + h_, -0.08, r"$x_0+\Delta x$", ha="center", va="top")
p.text(4.3, 4.6, r"Sekanten", c=R, ha="right", va="top", size=8); p.text(4.3, 2.4, r"Tangente", c=G, ha="right", va="top", size=8)
p.save("a02_sekante")

p = Plot(5.0, 3.4, (-2, 2), (-0.4, 2.1), xt=[-1, 1], yt=[1])
p.f(np.abs, c=B); p.dot((0, 0)); p.text(-1.9, 1.95, r"$f(x)=|x|$", c=B, va="top")
p.text(0.15, 0.08, "Knick", c=R, size=8)
p.save("a02_betrag")

f = lambda x: 1 / np.sqrt(1 + x)
p = Plot(6.0, 4.2, (-0.9, 3.0), (-0.2, 2.6), xt=[1, 2], yt=[1, 2])
p.f(f, -0.85, 3.0, c=B); p.text(0.6, 1.5, r"$f(x)=\frac{1}{\sqrt{1+x}}$", c=B)
p.f(lambda x: 1 - x / 2, -0.9, 2.4, c=R, label=r"$t(x)=1-\frac{x}{2}$", lab_at=1.7, lab_off=(0.05, 0.05))
p.dot((0, 1))
p.save("a02_tangente")

# MWS allgemein
f = lambda x: 0.6 + 1.8 * np.sin(0.9 * x - 0.4) + 0.25 * x
p = Plot(6.4, 4.2, (0, 4.6), (0, 3.4), xt=[], yt=[])
a, b = 0.5, 4.1
p.f(f, 0.2, 4.4, c=B)
m = (f(b) - f(a)) / (b - a)
p.seg((a, f(a)), (b, f(b)), c=R, lw=1.0)
xs = np.linspace(a, b, 4000); d = np.gradient(f(xs), xs); x0 = xs[np.argmin(np.abs(d - m) + 10 * (xs < 1.0))]
p.f(lambda x: f(x0) + m * (x - x0), x0 - 1.3, x0 + 1.3, c=G, lw=1.0, dash=(5, 3))
for x in (a, b, x0): p.vline(x, a=0, b=f(x))
p.dot((a, f(a))); p.dot((b, f(b))); p.dot((x0, f(x0)), c=G)
p.text(a, -0.06, "$a$", ha="center", va="top"); p.text(b, -0.06, "$b$", ha="center", va="top"); p.text(x0, -0.06, r"$x_0$", ha="center", va="top")
p.text(2.9, f(2.9) - 0.7, "Sekante", c=R, size=8, va="top"); p.text(x0 + 0.5, f(x0) + 0.5 * m + 0.12, "Tangente", c=G, size=8)
p.save("a02_mws")

p = Plot(6.0, 4.8, (0, 4.6), (0, 17.5), xt=[1, 2.5, 4], xtl=["1", "", "4"], yt=[5, 10, 15])
p.f(lambda x: x ** 2, 0, 4.15, c=B)
p.seg((1, 1), (4, 16), c=R, lw=1.0); p.f(lambda x: 6.25 + 5 * (x - 2.5), 1.4, 3.6, c=G, dash=(5, 3), lw=1.0)
p.dot((1, 1)); p.dot((4, 16)); p.dot((2.5, 6.25), c=G); p.vline(2.5, a=0, b=6.25)
p.text(2.5, -0.4, r"$x_0=2{,}5$", ha="center", va="top", c=G, size=8)
p.text(1.12, 0.7, "$(1,1)$", size=8, va="top"); p.text(3.9, 16, "$(4,16)$", ha="right", size=8)
p.save("a02_mws_bsp")

# Extremalaufgabe
p = Plot(6.2, 4.4, (-0.9, 1.4), (-0.6, 0.65), xt=[-0.5, 0.5, 1], yt=[-0.4], ytl=["$-0{,}4$"])
p.f(lambda x: x ** 3 - x, -0.9, 1.15, c=GREY, lw=0.7, dash=(3, 2))
p.f(lambda x: x ** 3 - x, -0.5, 1, c=B, lw=1.6)
p.dot((-0.5, 0.375), c=R); p.dot((1, 0)); p.dot((1 / np.sqrt(3), -2 / (3 * np.sqrt(3))), c=G)
p.text(-0.45, 0.42, r"globales Max. $\frac{3}{8}$", c=R, size=7.5); p.text(0.58, -0.43, "globales Min.", c=G, size=7.5, ha="center", va="top")
p.save("a02_extrem")

p = Plot(5.4, 4.4, (-1.6, 1.6), (-3.0, 3.0), xt=[-1, 1], yt=[-2, 2])
p.f(lambda x: x ** 3, -1.6, 0, c=R); p.f(lambda x: x ** 3, 0, 1.6, c=B); p.dot((0, 0))
p.text(-1.05, -0.4, "konkav", c=R, size=8, ha="center"); p.text(0.95, 0.15, "konvex", c=B, size=8, ha="right")
p.text(-1.5, 2.8, r"$f(x)=x^3$", va="top")
p.save("a02_kd1")
p = Plot(6.0, 4.4, (-1.8, 1.8), (-1.4, 1.6), xt=[-1, 1], yt=[-1, 1])
p.f(lambda x: x ** 4 - 2 * x ** 2, c=B)
for x, c in [(0, R), (-1, G), (1, G)]: p.dot((x, x ** 4 - 2 * x ** 2), c=c)
w = 1 / np.sqrt(3)
for x in (-w, w): p.dot((x, -5 / 9), c=O)
p.text(0.1, 0.1, "Max.", c=R, size=7.5); p.text(-1, -1.1, "Min.", c=G, size=7.5, ha="center", va="top"); p.text(1, -1.1, "Min.", c=G, size=7.5, ha="center", va="top")
p.text(w + 0.07, -0.5, "WP", c=O, size=7.5); p.text(-w - 0.07, -0.5, "WP", c=O, size=7.5, ha="right")
p.save("a02_kd2")

# Wachstum
p = Plot(7.0, 4.6, (0, 6.2), (0, 14), xt=[1, 2, 3, 4, 5, 6], yt=[5, 10])
p.f(lambda x: np.log(x), 0.05, 6.2, c=G, label=r"$\ln x$", lab_at=5.3, lab_off=(0, 0.1))
p.f(lambda x: x, c=O, label=r"$x$", lab_at=5.6, lab_off=(0, 0.1))
p.f(lambda x: x ** 2, c=P, label=r"$x^2$", lab_at=3.5, lab_off=(0.1, 0))
p.f(np.exp, c=R, label=r"$e^x$", lab_at=2.4, lab_off=(-0.1, 0), ha="right")
p.save("a02_wachstum")

# Kegelschnitte, Zykloide
t = np.linspace(0, 2 * np.pi, 400)
p = Plot(5.0, 4.0, (-0.4, 4.4), (-0.4, 3.6), xt=[], yt=[], equal=True, grid=False)
x0, y0, R_ = 2.0, 1.6, 1.3
p.curve(x0 + R_ * np.cos(t), y0 + R_ * np.sin(t)); p.dot((x0, y0)); p.seg((x0, y0), (x0 + R_ * np.cos(0.6), y0 + R_ * np.sin(0.6)), c=R)
p.text(x0 + 0.55, y0 + 0.15, "$R$", c=R); p.vline(x0, a=0, b=y0); p.hline(y0, a=0, b=x0)
p.text(x0, -0.08, "$x_0$", ha="center", va="top"); p.text(-0.08, y0, "$y_0$", ha="right", va="center")
p.save("a02_kreis")
p = Plot(5.4, 4.0, (-0.4, 4.8), (-0.4, 3.6), xt=[], yt=[], equal=True, grid=False)
x0, y0, a, b = 2.3, 1.6, 1.9, 1.1
p.curve(x0 + a * np.cos(t), y0 + b * np.sin(t)); p.dot((x0, y0))
p.seg((x0, y0), (x0 + a, y0), c=R); p.seg((x0, y0), (x0, y0 + b), c=G)
p.text(x0 + a / 2, y0 + 0.05, "$a$", c=R, ha="center"); p.text(x0 + 0.07, y0 + b / 2, "$b$", c=G, va="center")
p.vline(x0, a=0, b=y0 - 0.0); p.text(x0, -0.08, "$x_0$", ha="center", va="top"); p.text(-0.08, y0, "$y_0$", ha="right", va="center"); p.hline(y0, a=0, b=x0 - a)
p.save("a02_ellipse")
p = Plot(5.6, 4.4, (-4.2, 4.2), (-3.2, 3.2), xt=[], yt=[], equal=True, grid=False)
a, b = 1.4, 1.0; s = np.linspace(-1.75, 1.75, 300)
for sg in (1, -1): p.curve(sg * a * np.cosh(s), b * np.sinh(s))
p.f(lambda x: b / a * x, c=GREY, dash=(4, 3), lw=0.7); p.f(lambda x: -b / a * x, c=GREY, dash=(4, 3), lw=0.7)
p.dot((a, 0)); p.dot((0, b), c=GREY); p.text(a + 0.1, -0.12, "$(a,0)$", va="top", size=8); p.text(0.12, b + 0.05, "$(0,b)$", size=8, c=GREY)
p.text(3.9, 3.0, r"$y=\frac{b}{a}x$", c=GREY, ha="right", va="top", size=8)
p.save("a02_hyperbel")
p = Plot(14.5, 4.9, (-1.3, 4 * np.pi + 1.4), (-0.85, 3.9), xt=[np.pi, 2 * np.pi, 3 * np.pi, 4 * np.pi], xtl=[r"$\pi a$", r"$2\pi a$", r"$3\pi a$", r"$4\pi a$"], yt=[1, 2], ytl=["$a$", "$2a$"], equal=True)
tt = np.linspace(0, 4 * np.pi, 800)
for bb, c, lab in [(1.0, B, "gewöhnlich $b=a$"), (0.5, G, "verkürzt $b<a$"), (1.6, R, "verlängert $b>a$")]:
    p.curve(tt - bb * np.sin(tt), 1 - bb * np.cos(tt), c=c, lw=1.2 if bb == 1 else 0.9)
tc = 2.4; cx = tc
p.curve(cx + np.cos(t), 1 + np.sin(t), c=INK, lw=0.7); p.dot((cx, 1), r=2)
p.seg((cx, 1), (cx - np.sin(tc), 1 - np.cos(tc)), c=INK, lw=0.7); p.dot((cx - np.sin(tc), 1 - np.cos(tc)), c=B)
p.text(2 * np.pi, 3.85, "gewöhnlich ($b=a$)", c=B, ha="center", va="top", size=8)
p.text(2 * np.pi, 3.45, "verkürzt ($b<a$)", c=G, ha="center", va="top", size=8)
p.text(2 * np.pi, 3.05, "verlängert ($b>a$)", c=R, ha="center", va="top", size=8)
p.save("a02_zykloide")

# Tangente und Normale an Parameterkurve
p = Plot(6.0, 4.4, (-0.3, 4.4), (-0.3, 3.4), xt=[], yt=[], equal=True, grid=False)
tt = np.linspace(-0.2, 3.3, 300); X = tt; Y = 0.25 * tt ** 2 + 0.3 * np.sin(2 * tt) + 0.4
p.curve(X, Y)
t0 = 1.6; x0, y0 = t0, 0.25 * t0 ** 2 + 0.3 * np.sin(2 * t0) + 0.4; dx, dy = 1, 0.5 * t0 + 0.6 * np.cos(2 * t0)
L = np.hypot(dx, dy); ux, uy = dx / L, dy / L
p.seg((x0 - 1.5 * ux, y0 - 1.5 * uy), (x0 + 1.9 * ux, y0 + 1.9 * uy), c=GREY, dash=(4, 3), lw=0.7)
p.arrow((x0, y0), (x0 + 1.1 * ux, y0 + 1.1 * uy), c=B, lw=1.2); p.arrow((x0, y0), (x0 - 0.9 * uy, y0 + 0.9 * ux), c=R, lw=1.2)
p.dot((x0, y0)); p.text(x0 + 0.1, y0 - 0.12, r"$\vec r(t)$", va="top")
p.text(x0 + 1.15 * ux, y0 + 1.1 * uy - 0.05, r"$\dot{\vec r}=(\dot x,\dot y)$", c=B, va="top", size=8)
p.text(x0 - 0.9 * uy - 0.05, y0 + 0.9 * ux, r"$\vec h=(-\dot y,\dot x)$", c=R, ha="right", size=8)
p.save("a02_tangnorm")

# Krümmungskreise
p = Plot(7.2, 4.4, (-2.4, 2.6), (-0.4, 3.2), xt=[], yt=[], equal=True, grid=False)
g = lambda x: 0.5 * x ** 2
p.f(g, -2.4, 2.4, c=B, clip=False)
for x0, c in [(0.0, R), (1.0, G)]:
    d1, d2 = x0, 1.0; k = d2 / (1 + d1 ** 2) ** 1.5; r = 1 / k
    n = np.array([-d1, 1]) / np.hypot(d1, 1); M = np.array([x0, g(x0)]) + r * n
    ph = np.arctan2(-n[1], -n[0]); w = min(np.pi, 1.6 / r); tt2 = np.linspace(ph - w, ph + w, 200)
    p.curve(M[0] + r * np.cos(tt2), M[1] + r * np.sin(tt2), c=c, lw=0.8, dash=(4, 2)); p.dot(M, c=c, r=2.2); p.dot((x0, g(x0)), c=c)
    p.seg((x0, g(x0)), M, c=c, lw=0.6)
p.text(0.12, 0.45, r"$r=\frac{1}{k}$ klein", c=R, size=7.5); p.text(1.15, 0.35, r"$r$ gross", c=G, size=7.5, va="top")
p.save("a02_kruemmung")

# Evolute der Ellipse
p = Plot(6.4, 6.3, (-3.0, 3.0), (-3.1, 3.1), xt=[], yt=[], equal=True, grid=False)
a, b = 2.5, 1.5
p.curve(a * np.cos(t), b * np.sin(t), c=B)
e = (a ** 2 - b ** 2)
p.curve(e / a * np.cos(t) ** 3, -e / b * np.sin(t) ** 3, c=R)
t0 = 0.5; P0 = np.array([a * np.cos(t0), b * np.sin(t0)]); E0 = np.array([e / a * np.cos(t0) ** 3, -e / b * np.sin(t0) ** 3])
r = np.linalg.norm(P0 - E0); p.curve(E0[0] + r * np.cos(t), E0[1] + r * np.sin(t), c=G, lw=0.7, dash=(4, 2))
p.seg(P0, E0, c=G, lw=0.7); p.dot(P0); p.dot(E0, c=R)
p.text(2.6, 1.3, "Kurve", c=B, size=8); p.text(0.35, 1.95, "Evolute", c=R, size=8); p.text(-2.0, -1.9, "Krümmungskreis", c=G, size=8, va="top")
p.save("a02_evolute")
