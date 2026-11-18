"""Lewis structures drawn with a small helper."""
from plot import *
from matplotlib.patches import Circle

class Lewis:
    def __init__(s, w, h):
        s.s = Sketch(w, h)
    def atom(s, x, y, t, lp=(), fc=None, size=12, c=INK):
        s.s.text(x, y, t, ha="center", va="center", size=size, c=c)
        for a in lp:   # lone pairs at angle a (deg)
            r = 0.36 if len(t) < 2 else 0.46
            ar = np.radians(a); cx, cy = x + r * np.cos(ar), y + r * np.sin(ar)
            nx, ny = -np.sin(ar), np.cos(ar)
            for d in (-0.075, 0.075):
                s.s.ax.add_patch(Circle((cx + d * nx, cy + d * ny), 0.042, fc=c, ec="none", zorder=6))
        if fc is not None:
            s.s.text(x + 0.3, y + 0.32, fc, size=7.5, c=R, ha="left", va="bottom")
    def bond(s, p, q, order=1, gap=0.3, c=INK):
        p = np.array(p, float); q = np.array(q, float); d = q - p; L = np.linalg.norm(d); d /= L
        n = np.array([-d[1], d[0]])
        a, b = p + d * gap, q - d * gap
        offs = {1: [0], 2: [-0.06, 0.06], 3: [-0.1, 0, 0.1]}[order]
        for o in offs: s.s.seg(a + o * n, b + o * n, lw=0.9, c=c)
    def save(s, n): s.s.save(n)

# HCN step by step
L = Lewis(15.5, 2.0)
steps = [("1. connect", [1, 1], [(), (), ()]), ("2. octets outside", [1, 1], [(), (), (0, 90, -90)]),
         ("3. rest on centre", [1, 1], [(), (90, -90), (0, 90, -90)]), ("4. multiple bonds", [1, 3], [(), (), (0,)])]
for k, (lab, orders, lps) in enumerate(steps):
    x0 = 1.0 + k * 3.9
    pts = [(x0, 1.2), (x0 + 1.1, 1.2), (x0 + 2.2, 1.2)]
    for t, p, lp in zip(["H", "C", "N"], pts, lps): L.atom(*p, t, lp=lp)
    L.bond(pts[0], pts[1], orders[0]); L.bond(pts[1], pts[2], orders[1])
    L.s.text(x0 + 1.1, 0.25, lab, ha="center", size=7.5, c="#444444")
L.save("c07_hcn")

# simple molecules: H2, Cl2, CO2, N2, H2O
L = Lewis(15.5, 2.0)
x = 0.6
def mol(atoms, bonds, lab):
    global x
    for (dx, dy, t, lp) in atoms: L.atom(x + dx, 1.2 + dy, t, lp=lp)
    for (i, j, o) in bonds: L.bond((x + atoms[i][0], 1.2 + atoms[i][1]), (x + atoms[j][0], 1.2 + atoms[j][1]), o)
    xm = (min(a[0] for a in atoms) + max(a[0] for a in atoms)) / 2
    L.s.text(x + xm, 0.2, lab, ha="center", size=7.5, c="#444444")
    x += max(a[0] for a in atoms) + 1.5
mol([(0, 0, "H", ()), (1.0, 0, "H", ())], [(0, 1, 1)], "$\\mathrm{H_2}$")
mol([(0, 0, "Cl", (90, 180, 270)), (1.2, 0, "Cl", (90, 0, 270))], [(0, 1, 1)], "$\\mathrm{Cl_2}$")
mol([(0, 0, "O", (90, 270)), (1.1, 0, "C", ()), (2.2, 0, "O", (90, 270))], [(0, 1, 2), (1, 2, 2)], "$\\mathrm{CO_2}$")
mol([(0, 0, "N", (180,)), (1.1, 0, "N", (0,))], [(0, 1, 3)], "$\\mathrm{N_2}$")
mol([(0, -0.35, "H", ()), (0.8, 0.25, "O", (60, 130)), (1.6, -0.35, "H", ())], [(0, 1, 1), (1, 2, 1)], "$\\mathrm{H_2O}$")
L.save("c07_simple")

# ozone resonance
L = Lewis(9.5, 2.2)
for k, (o1, o2) in enumerate([(2, 1), (1, 2)]):
    x0 = 0.6 + k * 5.0
    A, Bc, C = (x0, 0.9), (x0 + 1.0, 1.55), (x0 + 2.0, 0.9)
    L.atom(*A, "O", lp=(180, 270) if o1 == 2 else (90, 180, 270), fc="" if o1 == 2 else "$-$")
    L.atom(*Bc, "O", lp=(90,), fc="$+$")
    L.atom(*C, "O", lp=(0, 270) if o2 == 2 else (90, 0, 270), fc="" if o2 == 2 else "$-$")
    L.bond(A, Bc, o1); L.bond(Bc, C, o2)
L.s.text(4.7, 1.2, "$\\longleftrightarrow$", ha="center", va="center", size=14)
L.save("c07_ozone")

# benzene resonance (hexagons)
s = Sketch(9.0, 3.0)
def hexa(cx, cy, dbl, circle=False):
    a = np.radians(90 + 60 * np.arange(7)); R = 1.0
    xs, ys = cx + R * np.cos(a), cy + R * np.sin(a)
    s.curve(xs, ys, c=INK, lw=1.0)
    for i in dbl:
        p = np.array([xs[i], ys[i]]); q = np.array([xs[i + 1], ys[i + 1]]); m = np.array([cx, cy])
        p2, q2 = p + (m - p) * 0.2, q + (m - q) * 0.2; d = q2 - p2
        s.seg(p2 + d * 0.12, q2 - d * 0.12, lw=1.0)
    if circle:
        t = np.linspace(0, 2 * np.pi, 100); s.curve(cx + 0.55 * np.cos(t), cy + 0.55 * np.sin(t), c=INK, lw=1.0)
hexa(1.3, 1.5, [0, 2, 4]); hexa(4.1, 1.5, [1, 3, 5]); hexa(7.6, 1.5, [], circle=True)
s.text(2.7, 1.5, "$\\longleftrightarrow$", ha="center", va="center", size=13)
s.text(5.85, 1.5, "$\\equiv$", ha="center", va="center", size=13)
s.text(2.7, 0.0, "two resonance structures", ha="center", size=7.5, c="#444444"); s.text(7.6, 0.0, "delocalised", ha="center", size=7.5, c="#444444")
s.save("c07_benzene")

# octet exceptions: NO, BF3, PCl5
L = Lewis(14.0, 3.9)
# NO
L.atom(1.0, 1.8, "N", lp=(180,)); L.atom(2.2, 1.8, "O", lp=(90, 270)); L.bond((1.0, 1.8), (2.2, 1.8), 2)
from matplotlib.patches import Circle as Ci
L.s.ax.add_patch(Ci((1.0, 2.2), 0.045, fc=INK, ec="none"))
L.s.text(1.6, 0.4, "NO: 11 v.e. (odd)", ha="center", size=7.5, c="#444444")
# BF3
c0 = (5.6, 1.9)
for ang in [90, 210, 330]:
    lp = (ang - 90, ang, ang + 90)
    a = np.radians(ang); p = (c0[0] + 1.1 * np.cos(a), c0[1] + 1.1 * np.sin(a))
    L.atom(*p, "F", lp=lp); L.bond(c0, p, 1)
L.atom(*c0, "B")
L.s.text(5.6, 0.4, "$\\mathrm{BF_3}$: only 6 e$^-$ on B", ha="center", size=7.5, c="#444444")
# PCl5
c0 = (10.6, 1.9)
for ang in [90, 162, 234, 306, 18]:
    a = np.radians(ang); p = (c0[0] + 1.3 * np.cos(a), c0[1] + 1.3 * np.sin(a))
    L.atom(*p, "Cl", lp=(ang - 90, ang, ang + 90), size=10); L.bond(c0, p, 1)
L.atom(*c0, "P")
L.s.text(10.6, 0.05, "$\\mathrm{PCl_5}$: 10 e$^-$ on P", ha="center", size=7.5, c="#444444")
L.save("c07_octetexc")
