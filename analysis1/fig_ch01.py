from plot import *

# ---------- Folgen ----------
def seq(name, fn, N, ylim, yt, label, lab_xy, band=None, Nmark=None, L=None):
    p = Plot(7.4, 4.2, (0, N + 0.8), ylim, xt=range(1, N + 1), yt=yt, xl="$n$", yl="$a_n$")
    if band:
        L, eps = band
        p.polyfill([(0, L - eps), (N + 0.8, L - eps), (N + 0.8, L + eps), (0, L + eps)], c=FILL_G)
        p.hline(L + eps, c=G, dash=(3, 2)); p.hline(L - eps, c=G, dash=(3, 2)); p.hline(L, c=G, dash=None, lw=0.8)
    for n in range(1, N + 1):
        y = fn(n); p.seg((n, 0), (n, y), c=GREY, lw=0.5); p.dot((n, y), c=B)
    p.text(*lab_xy, label, c=B)
    return p

p = seq("", lambda n: (-1) ** n / n, 10, (-1.2, 1.0), [-1, -0.5, 0.5], r"$a_n=\frac{(-1)^n}{n}$", (5.6, 0.55))
p.save("a01_folge_alt")
p = seq("", lambda n: (-1) ** n, 10, (-1.4, 1.5), [-1, 1], r"$a_n=(-1)^n$", (3.2, 1.12))
p.save("a01_folge_pm1")

# Epsilon-Schlauch
p = Plot(12, 4.6, (0, 16.8), (0, 2.25), xt=[], yt=[1], ytl=["$L$"], xl="$n$", yl="$a_n$")
L, eps, N0 = 1.0, 0.25, 5
p.polyfill([(0, L - eps), (16.8, L - eps), (16.8, L + eps), (0, L + eps)], c=FILL_G)
p.hline(L + eps, c=G, dash=(3, 2)); p.hline(L - eps, c=G, dash=(3, 2)); p.hline(L, c=G, dash=None, lw=0.8)
for n in range(1, 17):
    y = 1 + 1.15 * (-1) ** n / n ** 0.95
    p.dot((n, y), c=B if n < N0 else R)
p.vline(N0 - 0.5, c=INK, dash=(2, 2), b=2.05)
p.text(N0 - 0.35, 2.0, r"ab hier: alle $a_n$ im Streifen", c=R, va="top", size=8)
p.text(16.6, L + eps + 0.05, r"$L+\varepsilon$", c=G, ha="right"); p.text(16.6, L - eps - 0.05, r"$L-\varepsilon$", c=G, ha="right", va="top")
p.text(N0 - 0.5, -0.06, r"$N$", ha="center", va="top")
p.save("a01_epsilon")

# Geometrische Reihe als Quadrat
s = Sketch(4.6, 4.6); x0, y0, a = 0.3, 0.3, 4.0
cols = ["#cfe0f2", "#f3d3cf", "#d3eadf", "#efe0c4", "#e0d8ef", "#cfe0f2", "#f3d3cf", "#d3eadf"]
x, y, w, h = x0, y0, a, a; labels = ["1/2", "1/4", "1/8", "1/16", "1/32"]
for k in range(8):
    if k % 2 == 0: r = (x, y, w / 2, h); x += w / 2; w /= 2
    else: r = (x, y + h / 2, w, h / 2); h /= 2
    s.polyfill([(r[0], r[1]), (r[0] + r[2], r[1]), (r[0] + r[2], r[1] + r[3]), (r[0], r[1] + r[3])], c=cols[k])
    s.curve([r[0], r[0] + r[2], r[0] + r[2], r[0], r[0]], [r[1], r[1], r[1] + r[3], r[1] + r[3], r[1]], c=INK, lw=0.6)
    if k < 5: s.text(r[0] + r[2] / 2, r[1] + r[3] / 2, f"${labels[k]}$", ha="center", va="center", size=9 - k * 0.8)
s.save("a01_geomquadrat")

# ---------- Abbildung D -> W ----------
s = Sketch(8.0, 4.0)
s.ellipse((1.7, 1.75), 1.15, 1.5); s.ellipse((6.3, 1.75), 1.15, 1.5)
A = [(1.7, 2.75), (1.7, 2.05), (1.7, 1.35), (1.7, 0.65)]; Bp = [(6.3, 2.75), (6.3, 1.95), (6.3, 1.15), (6.3, 0.5)]
for i, (q, t) in enumerate(zip(A, "abcd")): s.dot(q, r=3); s.text(q[0] - 0.18, q[1], f"${t}$", ha="right", va="center")
for i, (q, t) in enumerate(zip(Bp, "1234")): s.dot(q, r=3); s.text(q[0] + 0.18, q[1], f"${t}$", ha="left", va="center")
for i, j in [(0, 0), (1, 1), (2, 1), (3, 3)]:
    s.arrow((A[i][0] + 0.15, A[i][1]), (Bp[j][0] - 0.17, Bp[j][1] + (0.04 if i != 2 else -0.04)), c=B, lw=0.8)
s.text(1.7, 3.35, r"$D$", ha="center", va="bottom", size=10); s.text(6.3, 3.35, r"$W$ (Zielmenge)", ha="center", va="bottom", size=9)
s.text(4.0, 3.15, r"$f$", ha="center", c=B, size=10)
s.save("a01_abbildung")

# ---------- Definitions-/Wertebereich ----------
p = Plot(7.2, 4.6, (-2.2, 8.2), (-5.5, 5.5), xt=[-2, 2, 4, 6, 8], yt=[-4, -2, 2, 4])
p.vline(3, c=R); p.f(lambda x: 1 / (x - 3), -2.2, 2.999, c=B); p.f(lambda x: 1 / (x - 3), 3.001, 8.2, c=B)
p.text(3.15, 4.6, r"$x=3$", c=R); p.text(4.4, 1.2, r"$f(x)=\frac{1}{x-3}$", c=B)
p.save("a01_dw1")

p = Plot(7.6, 5.0, (-1, 44), (-14, 30), xt=[10, 16, 20, 30, 40], yt=[-10, 6, 10, 20])
p.polyfill([(-1, 6), (44, 6), (44, 10), (-1, 10)], c=FILL_R, alpha=0.8)
g = lambda x: (x - 15) / (np.sqrt(x) - 4)
p.f(g, 0, 15.99, c=B, n=3000); p.f(g, 16.01, 44, c=B, n=3000); p.vline(16, c=R)
p.dot((0, 3.75), c=B); p.dot((1, 14 / 3 * 0 + (1 - 15) / (1 - 4)), c=B, r=0)
p.text(16.6, 26, r"$x=16$", c=R); p.text(26, 15.5, r"$g(x)=\frac{x-15}{\sqrt{x}-4}$", c=B)
p.text(30, 8, r"Lücke $(6,10)$", c=R, va="center", size=8)
p.save("a01_dw2")

# ---------- Funktionsfamilien ----------
p = Plot(7.2, 5.4, (-2.4, 2.6), (-2.6, 4.6), xt=[-2, -1, 1, 2], yt=[-2, -1, 1, 2, 3, 4])
p.f(lambda x: x ** 3, c=B, label=r"$x^3$", lab_at=1.45, lab_off=(0.12, 0))
p.f(lambda x: x ** 2, c=R, label=r"$x^2$", lab_at=-2.05, lab_off=(-0.1, 0), ha="right")
p.f(np.sqrt, 0, 2.6, c=G, label=r"$\sqrt{x}=x^{1/2}$", lab_at=2.0, lab_off=(-0.1, 0.12), ha="left")
p.f(lambda x: 1 / x, -2.4, -0.01, c=O); p.f(lambda x: 1 / x, 0.01, 2.6, c=O, label=r"$x^{-1}$", lab_at=0.3, lab_off=(0.1, 0))
p.save("a01_potenz")

p = Plot(7.2, 5.4, (-3.2, 3.2), (-5, 6), xt=[-3, -2, -1, 1, 2, 3], yt=[-4, -2, 2, 4, 6])
p.f(lambda x: x ** 2 - 4, c=B, label=r"$x^2-4$", lab_at=2.75, lab_off=(0.12, -0.1))
p.f(lambda x: 0.5 * x ** 3 - 2 * x, c=R, label=r"$\frac{1}{2}x^3-2x$", lab_at=-2.35, lab_off=(-0.1, -0.15), ha="right", va="top")
p.f(lambda x: 0.1 * (x ** 4 - 6 * x ** 2 + 5), c=G); p.text(0.15, 1.3, r"$0{,}1(x^4-6x^2+5)$", c=G)
for r_ in (-2, 2): p.dot((r_, 0), c=B, r=2.2)
p.save("a01_poly")

p = Plot(7.2, 5.4, (-4.2, 4.2), (-4, 4), xt=[-4, -2, 2, 4], yt=[-4, -2, 2, 4])
p.vline(-1, c=R, lw=0.6); p.hline(1, c=R, lw=0.6)
f = lambda x: (x - 2) / (x + 1)
p.f(f, -4.2, -1.001, c=B, n=3000); p.f(f, -0.999, 4.2, c=B, n=3000); p.text(2.6, -0.8, r"$\frac{x-2}{x+1}$", c=B, va="top")
p.f(lambda x: 4 / (x ** 2 + 1), c=G, label=r"$\frac{4}{x^2+1}$", lab_at=0.8, lab_off=(0.1, 0.12))
p.text(-1.15, 3.6, r"$x=-1$", c=R, ha="right"); p.text(-4.0, 1.12, r"$y=1$", c=R)
p.save("a01_rational")

# Einheitskreis
p = Plot(5.0, 5.0, (-1.45, 1.45), (-1.45, 1.45), xt=[-1, 1], yt=[-1, 1], equal=True, grid=False)
t = np.linspace(0, 2 * np.pi, 400); p.curve(np.cos(t), np.sin(t), c=INK, lw=0.8)
a = 0.9; c_, s_ = np.cos(a), np.sin(a)
p.seg((0, 0), (c_, s_), c=INK, lw=1.0); p.seg((c_, 0), (c_, s_), c=R, lw=1.6); p.seg((0, 0), (c_, 0), c=B, lw=1.6)
tt = np.linspace(0, a, 50); p.curve(0.28 * np.cos(tt), 0.28 * np.sin(tt), c=G, lw=0.9)
p.dot((c_, s_)); p.text(c_ + 0.06, s_ + 0.04, r"$(\cos\varphi,\ \sin\varphi)$", size=8)
p.text(c_ + 0.05, s_ / 2, r"$\sin\varphi$", c=R, size=8); p.text(c_ / 2, -0.06, r"$\cos\varphi$", c=B, ha="center", va="top", size=8)
p.text(0.3, 0.12, r"$\varphi$", c=G, size=8)
p.save("a01_einheitskreis")

p = Plot(9.0, 4.2, (-3.6, 7.0), (-1.5, 1.6), xt=[-np.pi, -np.pi / 2, np.pi / 2, np.pi, 3 * np.pi / 2, 2 * np.pi],
         xtl=[r"$-\pi$", r"$-\frac{\pi}{2}$", r"$\frac{\pi}{2}$", r"$\pi$", r"$\frac{3\pi}{2}$", r"$2\pi$"], yt=[-1, 1])
p.f(np.sin, c=R, label=r"$\sin x$", lab_at=1.2, lab_off=(0, 0.1), ha="center")
p.f(np.cos, c=B); p.text(-3.5, 0.6, r"$\cos x$", c=B)
p.save("a01_sincos")

p = Plot(7.2, 5.4, (-2.6, 2.6), (-3.6, 3.8), xt=[-2, -1, 1, 2], yt=[-3, -2, -1, 1, 2, 3])
p.hline(1, c=GREY, lw=0.5); p.hline(-1, c=GREY, lw=0.5)
p.f(np.cosh, c=B, label=r"$\cosh x$", lab_at=1.65, lab_off=(0.12, 0))
p.f(np.sinh, c=R, label=r"$\sinh x$", lab_at=-1.75, lab_off=(0.12, -0.1), va="top")
p.f(np.tanh, c=G, label=r"$\tanh x$", lab_at=1.6, lab_off=(0.1, -0.12), va="top")
p.save("a01_hyp")

p = Plot(6.4, 5.4, (-2.6, 5.4), (-2.6, 5.4), xt=[-2, 1, 2, 4], yt=[-2, 1, 2, 4], equal=True)
p.f(lambda x: x, c=GREY, dash=(4, 3), lw=0.8)
p.f(np.exp, c=B, label=r"$e^x$", lab_at=1.3, lab_off=(-0.12, 0), ha="right")
p.f(np.log, 0.02, 5.4, c=R, label=r"$\ln x$", lab_at=4.0, lab_off=(0, 0.12), ha="center")
p.dot((0, 1), c=B); p.dot((1, 0), c=R); p.text(4.4, 4.9, r"$y=x$", c=GREY, ha="right")
p.save("a01_explog")

# gerade / ungerade
for name, fn, lab in [("a01_gerade", lambda x: x ** 2, r"$f(x)=x^2$"), ("a01_ungerade", lambda x: x ** 3, r"$f(x)=x^3$")]:
    p = Plot(5.2, 4.4, (-1.9, 1.9), (-2.4, 3.0), xt=[-1, 1], yt=[-1, 1, 2])
    p.f(fn, c=B)
    x1 = 1.3; p.dot((x1, fn(x1)), c=R); p.dot((-x1, fn(-x1)), c=R)
    p.seg((x1, 0), (x1, fn(x1)), c=R, dash=(2, 2), lw=0.7); p.seg((-x1, 0), (-x1, fn(-x1)), c=R, dash=(2, 2), lw=0.7)
    p.text(-1.8, 2.8, lab, c=B, va="top")
    p.save(name)

# Stetigkeit / Sprung
p = Plot(6.4, 4.0, (-2.2, 2.2), (-1.6, 1.7), xt=[-2, -1, 1, 2], yt=[-1, 1])
p.seg((-2.2, -1), (0, -1), c=B, lw=1.3); p.seg((0, 1), (2.2, 1), c=B, lw=1.3)
p.dot((0, -1), c=B, open_=True); p.dot((0, 1), c=B)
p.text(1.0, 1.12, r"$g(x)=1,\ x\geq 0$", c=B, ha="center"); p.text(-1.1, -1.12, r"$g(x)=-1,\ x<0$", c=B, ha="center", va="top")
p.save("a01_sprung")

# Zwischenwertsatz
p = Plot(6.8, 4.4, (0, 4.4), (-1.6, 2.4), xt=[], yt=[], xl="$x$", yl="$y$")
fz = lambda x: 0.45 * x + 0.9 * np.sin(2.3 * x - 1.6) - 0.3
a_, b_ = 0.4, 4.0
p.f(fz, a_, b_, c=B)
c0 = 0.75; p.hline(c0, c=G, dash=(4, 3), a=0, b=4.4)
p.vline(a_, a=0, b=fz(a_), c=GREY); p.vline(b_, a=0, b=fz(b_), c=GREY)
p.dot((a_, fz(a_)), c=B); p.dot((b_, fz(b_)), c=B)
p.text(a_, -0.08, "$a$", ha="center", va="top"); p.text(b_, -0.08, "$b$", ha="center", va="top")
p.text(4.35, c0 + 0.08, r"$c$", c=G, ha="right")
def brentq(g, lo, hi):
    if g(lo) * g(hi) > 0: raise ValueError
    for _ in range(80):
        m = 0.5 * (lo + hi)
        if g(lo) * g(m) <= 0: hi = m
        else: lo = m
    return 0.5 * (lo + hi)
for lo, hi in [(0.4, 1.3), (1.3, 2.6), (2.6, 4.0)]:
    try:
        r_ = brentq(lambda x: fz(x) - c0, lo, hi); p.dot((r_, c0), c=R); p.seg((r_, 0), (r_, c0), c=R, dash=(2, 2), lw=0.6)
    except Exception: pass
p.text(a_ + 0.1, fz(a_) - 0.05, r"$f(a)$", va="top", size=8); p.text(b_ - 0.1, fz(b_), r"$f(b)$", ha="right", size=8)
p.save("a01_zws")

# ---------- Transformationen ----------
f1 = lambda x: 2 * x ** 3 - 3 * x ** 2 - 6 * x + 6
trafos = [("a01_t_spx", lambda x: -f1(x), r"$-f(x)$"), ("a01_t_spy", lambda x: f1(-x), r"$f(-x)$"),
          ("a01_t_vx", lambda x: f1(x + 2), r"$f(x+2)$"), ("a01_t_vy", lambda x: f1(x) + 10, r"$f(x)+10$"),
          ("a01_t_sx", lambda x: f1(2 * x), r"$f(2x)$"), ("a01_t_dx", lambda x: f1(x / 2), r"$f(\frac{x}{2})$"),
          ("a01_t_dy", lambda x: 2 * f1(x), r"$2f(x)$"), ("a01_t_kw", lambda x: 1 / f1(x), r"$\frac{1}{f(x)}$")]
for name, fn, lab in trafos:
    big = name in ("a01_t_dx",)
    xl = (-4.6, 5.2) if big else (-3.6, 3.6)
    kw = name == "a01_t_kw"
    p = Plot(5.0, 3.9, xl, (-6, 6.5) if kw else (-25, 27), xt=[-2, 2] if not big else [-4, -2, 2, 4], yt=[-5, 5] if kw else [-20, 20], yl="")
    p.f(f1, c=GREY, lw=1.0, n=2000)
    if kw:
        x = np.linspace(*xl, 6000); y = fn(x); y[np.abs(y) > 7] = np.nan
        y[1:][np.abs(np.diff(y)) > 2] = np.nan
        p.curve(x, y, c=B)
    else:
        p.f(fn, c=B, n=2000)
    p.text(xl[1] - 0.1, 24 if not kw else 6, lab, c=B, ha="right", va="top", size=9)
    p.text(xl[0] + 0.1, 24 if not kw else 6, r"$f(x)$", c=GREY, ha="left", va="top", size=8)
    p.save(name)

# ---------- Injektiv, surjektiv, bijektiv ----------
def mapping(name, pairs, nA, nB):
    s = Sketch(4.6, 3.2)
    s.ellipse((1.0, 1.55), 0.72, 1.35); s.ellipse((3.6, 1.55), 0.72, 1.35)
    ya = np.linspace(2.45, 0.65, nA); yb = np.linspace(2.45, 0.65, nB)
    for i, y in enumerate(ya): s.dot((1.0, y), r=2.6); s.text(0.8, y, f"${i + 1}$", ha="right", va="center", size=8)
    for i, y in enumerate(yb): s.dot((3.6, y), r=2.6); s.text(3.8, y, "$" + "ABCD"[i] + "$", ha="left", va="center", size=8)
    for i, j in pairs: s.arrow((1.12, ya[i]), (3.47, yb[j]), c=B, lw=0.75)
    s.text(1.0, 3.18, "$D$", ha="center", va="top"); s.text(3.6, 3.18, "$W$", ha="center", va="top")
    s.save(name)
mapping("a01_m_surj", [(0, 0), (1, 1), (2, 2), (3, 2)], 4, 3)
mapping("a01_m_inj", [(0, 0), (1, 2), (2, 3)], 3, 4)
mapping("a01_m_bij", [(0, 1), (1, 0), (2, 2), (3, 3)], 4, 4)

p = Plot(6.0, 4.6, (-2.4, 2.4), (-2.4, 4.4), xt=[-2, -1, 1, 2], yt=[-2, 2, 4])
p.f(lambda x: x, c=B, label=r"$x$", lab_at=1.9, lab_off=(0.05, -0.12), va="top")
p.f(lambda x: x ** 2, c=R, label=r"$x^2$", lab_at=1.6, lab_off=(-0.12, 0), ha="right")
p.hline(-1.3, c=G, dash=(3, 2)); p.text(0.1, -1.45, r"$y=-1{,}3$ wird von $x^2$ nie erreicht", c=G, va="top", size=7.5)
p.save("a01_g_surj")
p = Plot(6.0, 4.6, (-2.2, 2.2), (-4.4, 5.4), xt=[-2, -1, 1, 2], yt=[-4, 2, 4])
p.f(lambda x: x ** 3, c=B, label=r"$x^3$", lab_at=1.3, lab_off=(0.12, 0))
p.f(lambda x: x ** 2, c=R, label=r"$x^2$", lab_at=-1.85, lab_off=(-0.08, 0), ha="right")
p.hline(2.0, c=G, dash=(3, 2)); p.dot((np.sqrt(2), 2), c=R); p.dot((-np.sqrt(2), 2), c=R); p.dot((2 ** (1 / 3), 2), c=B)
p.save("a01_g_inj")

# Umkehrfunktionen
p = Plot(6.0, 6.0, (-3.0, 3.0), (-3.0, 3.0), xt=[-2, -1, 1, 2], yt=[-2, -1, 1, 2], equal=True)
p.f(lambda x: x, c=GREY, dash=(4, 3), lw=0.8)
p.f(lambda x: x ** 3 - 1, c=B); p.text(1.45, -1.5, r"$f(x)=x^3-1$", c=B)
p.f(lambda x: np.cbrt(x + 1), c=R); p.text(0.2, 2.2, r"$f^{-1}(x)=\sqrt[3]{x+1}$", c=R)
p.dot((-1, -2), c=B); p.dot((-2, -1), c=R)
p.seg((-1, -2), (-2, -1), c=GREY, dash=(2, 2), lw=0.6)
p.text(-0.9, -2.1, r"$(-1,-2)$", c=B, va="top", size=7.5); p.text(-2.1, -0.9, r"$(-2,-1)$", c=R, ha="center", va="bottom", size=7.5)
p.text(-2.9, 2.9, r"$y=x$", c=GREY, va="top")
p.save("a01_umkehr1")
p = Plot(6.0, 6.0, (-2.2, 2.2), (-2.2, 2.2), xt=[-np.pi / 2, -1, 1, np.pi / 2], xtl=[r"$-\frac{\pi}{2}$", "$-1$", "$1$", r"$\frac{\pi}{2}$"],
         yt=[-np.pi / 2, -1, 1, np.pi / 2], ytl=[r"$-\frac{\pi}{2}$", "$-1$", "$1$", r"$\frac{\pi}{2}$"], equal=True)
p.f(lambda x: x, c=GREY, dash=(4, 3), lw=0.8)
p.f(np.sin, -2.2, -np.pi / 2, c=B, lw=0.6, dash=(2, 2)); p.f(np.sin, np.pi / 2, 2.2, c=B, lw=0.6, dash=(2, 2))
p.f(np.sin, -np.pi / 2, np.pi / 2, c=B, label=r"$\sin x$", lab_at=1.25, lab_off=(0.08, -0.12), va="top")
p.f(np.arcsin, -1, 1, c=R, label=r"$\arcsin x$", lab_at=0.75, lab_off=(-0.12, 0.05), ha="right")
p.save("a01_umkehr2")

# Asymptoten
p = Plot(7.4, 5.4, (-4.4, 4.4), (-11, 8), xt=[-4, -2, -1, 2, 4], yt=[-10, -5, 5])
f = lambda x: x ** 2 / (x + 1)
p.vline(-1, c=R); p.f(lambda x: x - 1, c=G, dash=(5, 3), lw=1.0)
p.f(f, -4.4, -1.001, c=B, n=3000); p.f(f, -0.999, 4.4, c=B, n=3000)
p.text(2.9, 4.3, r"$f(x)=\frac{x^2}{x+1}$", c=B, ha="right"); p.text(3.4, 1.6, r"$g(x)=x-1$", c=G, va="top")
p.text(-1.15, 7.5, r"$x=-1$", c=R, va="top", ha="right")
p.save("a01_asymptote")
