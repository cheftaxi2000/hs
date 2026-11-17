from plot import *
t = np.linspace(0, 2 * np.pi, 400)
def cplx(w, h, xl, yl, xt, yt, **k):
    return Plot(w, h, xl, yl, xt=xt, yt=yt, xl=r"$\mathrm{Re}$", yl=r"$\mathrm{Im}$", equal=True, **k)
def ang(p, r, a0, a1, c=G, lab=None, lr=None):
    tt = np.linspace(a0, a1, 60); p.curve(r * np.cos(tt), r * np.sin(tt), c=c, lw=0.8)
    if lab:
        am = (a0 + a1) / 2; lr = lr or r + 0.25; p.text(lr * np.cos(am), lr * np.sin(am), lab, c=c, ha="center", va="center", size=8)

p = cplx(5.6, 5.0, (-0.6, 4.6), (-0.6, 4.8), [1, 2, 3], [1, 2, 3, 4])
p.arrow((0, 0), (3, 4), c=B, lw=1.2); p.vline(3, a=0, b=4); p.hline(4, a=0, b=3)
p.dot((3, 4), c=B); p.text(3.1, 4.05, r"$z=3+4i$", c=B)
p.text(1.75, 1.6, r"$r=|z|=5$", c=B, ha="left", va="top", size=8); ang(p, 0.9, 0, np.arctan2(4, 3), lab=r"$\varphi$", lr=1.2)
p.save("a03_ebene")

p = cplx(5.0, 5.0, (-0.6, 4.0), (-3.0, 3.0), [1, 2, 3], [-2, -1, 1, 2])
p.arrow((0, 0), (3, 2), c=B); p.arrow((0, 0), (3, -2), c=R); p.seg((3, 2), (3, -2), c=GREY, dash=(3, 2), lw=0.6)
p.text(3.1, 2.05, r"$z=x+iy$", c=B); p.text(3.1, -2.05, r"$\bar z=x-iy$", c=R, va="top")
ang(p, 0.8, 0, np.arctan2(2, 3), lab=r"$\varphi$", lr=1.1); ang(p, 0.8, -np.arctan2(2, 3), 0, c=R, lab=r"$-\varphi$", lr=1.4)
p.save("a03_konj")

p = cplx(6.0, 4.8, (-0.6, 4.8), (-1.6, 3.6), [1, 2, 3, 4], [-1, 1, 2, 3])
z1, z2 = (3, 1), (1, 2)
p.arrow((0, 0), z1, c=B); p.arrow((0, 0), z2, c=G); p.arrow((0, 0), (4, 3), c=R, lw=1.2)
p.seg(z1, (4, 3), c=GREY, dash=(3, 2), lw=0.6); p.seg(z2, (4, 3), c=GREY, dash=(3, 2), lw=0.6)
p.arrow((0, 0), (2, -1), c=O); p.seg(z2, z1, c=O, dash=(3, 2), lw=0.6)
p.text(3.1, 0.9, r"$z_1$", c=B, va="top"); p.text(0.9, 2.1, r"$z_2$", c=G, ha="right"); p.text(4.05, 3.0, r"$z_1+z_2$", c=R)
p.text(2.1, -1.0, r"$z_1-z_2$", c=O, va="center")
p.save("a03_add")

p = cplx(5.6, 6.2, (-1.0, 4.2), (-0.6, 6.8), [1, 2, 3], [1, 2, 3, 4, 5, 6])
a1, a2 = np.pi / 3, np.pi / 6
p.arrow((0, 0), (3 * np.cos(a1), 3 * np.sin(a1)), c=B); p.arrow((0, 0), (2 * np.cos(a2), 2 * np.sin(a2)), c=G); p.arrow((0, 0), (0, 6), c=R, lw=1.3)
p.text(3 * np.cos(a1) + 0.1, 3 * np.sin(a1), r"$z_1=3e^{i\pi/3}$", c=B, size=8)
p.text(2 * np.cos(a2) + 0.1, 2 * np.sin(a2) - 0.1, r"$z_2=2e^{i\pi/6}$", c=G, size=8, va="top")
p.text(0.15, 6.1, r"$z_1z_2=6e^{i\pi/2}=6i$", c=R, size=8, va="bottom")
ang(p, 0.7, 0, a2, c=G, lab=r"$30^\circ$", lr=1.05); ang(p, 1.25, 0, a1, c=B, lab=r"$60^\circ$", lr=1.55); ang(p, 2.3, a1, np.pi / 2, c=R)
p.text(2.45 * np.cos(1.3) + 0.05, 2.45 * np.sin(1.3) + 0.05, r"$+30^\circ$", c=R, size=7.5)
p.save("a03_mult")

# Potenzen von sqrt3 + i
p = cplx(7.6, 5.2, (-70, 12), (-10, 40), [-60, -40, -20], [10, 20, 30])
z = np.sqrt(3) + 1j; prev = None
pts = [z ** k for k in range(1, 7)]
for k, w in enumerate(pts, 1):
    p.arrow((0, 0), (w.real, w.imag), c=B if k < 6 else R, lw=0.9 if k < 6 else 1.2)
    p.text(w.real + (1.5 if w.real >= 0 else -1.5), w.imag + 1.2, f"$z^{k}$" if k > 1 else "$z$", c=B if k < 6 else R, ha="left" if (w.real >= 0 and k != 3) else "right", size=8)
rr = np.abs(pts); ph = np.angle(pts)
ts = np.linspace(np.angle(z), np.pi, 300); rs = 2 ** (ts / (np.pi / 6))
p.curve(rs * np.cos(ts), rs * np.sin(ts), c=GREY, lw=0.6, dash=(3, 2))
p.save("a03_potenz")

# Fünfte Wurzeln
p = cplx(5.4, 5.4, (-1.6, 1.6), (-1.6, 1.6), [-1, 1], [-1, 1], grid=False)
R_ = 2 ** 0.2; p.curve(R_ * np.cos(t), R_ * np.sin(t), c=GREY, lw=0.6, dash=(3, 2))
angs = [np.pi / 30 + 2 * np.pi * k / 5 for k in range(5)]
P = [(R_ * np.cos(a), R_ * np.sin(a)) for a in angs]
p.curve([q[0] for q in P + [P[0]]], [q[1] for q in P + [P[0]]], c=G, lw=0.7)
for k, (q, a) in enumerate(zip(P, angs)):
    p.dot(q, c=R); p.text(q[0] + 0.2 * np.cos(a), q[1] + 0.2 * np.sin(a), f"$z_{k}$", c=R, ha="center", va="center")
ang(p, 0.45, 2 * np.pi * 1 / 5 + np.pi / 30, 2 * np.pi * 2 / 5 + np.pi / 30, c=O, lab=r"$\frac{2\pi}{5}$", lr=0.72)
p.save("a03_wurzel")

# Euler: e^{i phi} auf dem Einheitskreis
p = cplx(5.0, 5.0, (-1.45, 1.6), (-1.45, 1.6), [-1, 1], [-1, 1], grid=False)
p.curve(np.cos(t), np.sin(t), c=INK, lw=0.7)
a = 0.85; p.arrow((0, 0), (np.cos(a), np.sin(a)), c=B, lw=1.2)
p.seg((np.cos(a), 0), (np.cos(a), np.sin(a)), c=R, dash=(3, 2), lw=0.8)
p.text(np.cos(a) + 0.07, np.sin(a) + 0.05, r"$e^{i\varphi}$", c=B)
p.text(np.cos(a) + 0.05, np.sin(a) / 2, r"$\sin\varphi$", c=R, size=7.5); p.text(np.cos(a) / 2, -0.07, r"$\cos\varphi$", ha="center", va="top", size=7.5)
ang(p, 0.3, 0, a, lab=r"$\varphi$", lr=0.42)
for q, s in [((-1, 0), r"$e^{i\pi}=-1$"), ((0, 1), r"$e^{i\pi/2}=i$")]: p.dot(q, c=O)
p.text(-1.05, -0.08, r"$e^{i\pi}=-1$", c=O, ha="right", va="top", size=7.5); p.text(0.08, 1.08, r"$e^{i\pi/2}=i$", c=O, size=7.5)
p.save("a03_euler")

# Quadranten-Falle
p = cplx(5.2, 4.6, (-4.0, 4.0), (-3.0, 3.4), [-3, 3], [-2, 2], grid=False)
p.arrow((0, 0), (2, 2), c=B); p.arrow((0, 0), (-2, -2), c=R)
p.text(2.05, 2.05, r"$1+i$", c=B, size=8); p.text(-2.05, -2.1, r"$-1-i$", c=R, size=8, ha="right", va="top")
ang(p, 0.6, 0, np.pi / 4, c=B, lab=r"$\frac{\pi}{4}$", lr=0.9); ang(p, 1.0, 0, -3 * np.pi / 4, c=R, lab=r"$-\frac{3\pi}{4}$", lr=1.5)
p.save("a03_quadrant")

# Polynom mit komplexen Nullstellen (reeller Graph)
p = Plot(6.0, 4.0, (0, 2.6), (-14, 14), xt=[0.5, 1, 1.5, 2, 2.5], yt=[-10, 10])
p.f(lambda x: x ** 5 - 4 * x ** 4 + 10 * x ** 3 - 14 * x ** 2 + 9 * x - 10, c=B); p.dot((2, 0), c=R)
p.text(2.05, -1.2, "$x=2$", c=R, va="top", size=8)
p.save("a03_poly")
