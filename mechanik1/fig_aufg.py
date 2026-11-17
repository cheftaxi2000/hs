"""Abbildungen zu den Aufgaben (aus der Vorlesungsmitschrift), neu gezeichnet."""
from figlib import *

BV = r"$\mathbfit{%s}$"
def bv(s, sub=None): return (r"$\mathbfit{%s}_{%s}$" % (s, sub)) if sub else (r"$\mathbfit{%s}$" % s)

def cube(f, o, a, lw=0.8):
    pr = lambda x, y, z: f.proj(o, x, y, z)
    E = [((a,0,0),(a,a,0)), ((a,a,0),(0,a,0)), ((a,0,0),(a,0,a)), ((a,a,0),(a,a,a)), ((0,a,0),(0,a,a)),
         ((a,0,a),(a,a,a)), ((a,a,a),(0,a,a)), ((0,a,a),(0,0,a)), ((0,0,a),(a,0,a))]
    for p, q in E: f.line(pr(*p), pr(*q), lw=lw)
    for q in [(a,0,0),(0,a,0),(0,0,a)]: f.line(pr(0,0,0), pr(*q), lw=0.5, c=GREY, dash=(3, 2))
    return pr

def otimes(f, p, r=0.13, c=F):
    f.circle(p, r, fc="white", ec=c, lw=0.9, z=6); d = r * 0.7
    f.line((p[0]-d, p[1]-d), (p[0]+d, p[1]+d), c=c, lw=0.9, z=7); f.line((p[0]-d, p[1]+d), (p[0]+d, p[1]-d), c=c, lw=0.9, z=7)
def odot(f, p, r=0.13, c=INK):
    f.circle(p, r, fc="white", ec=c, lw=0.9, z=6); f.dot(p, 0.04, c=c, z=7)

def kos(f, o, l=0.8, ydown=False, zin=False, names=("x", "y", "z")):
    """kleines ebenes Koordinatensystem mit z aus der/in die Ebene"""
    o = P(*o); s = -1 if ydown else 1
    f.arrow(o, o + P(l, 0), lw=0.7); f.arrow(o, o + P(0, s * l), lw=0.7)
    f.text(o + P(l + 0.22, 0), f"${names[0]}$", size=8.5); f.text(o + P(0, s * (l + 0.24)), f"${names[1]}$", size=8.5)
    (otimes if zin else odot)(f, o, 0.11, c=INK); f.text(o + P(-0.3, -s * 0.22), f"${names[2]}$", size=8.5)

# ---------- Kap. 2 ----------
def a02():
    f = Fig(6.6, 5.4); o = P(2.9, 1.5); pr = lambda x, y, z: f.proj(o, x, y, z)
    f.axes3(o, l=2.7)
    f.line(o, pr(2.3, 2.3, 0), c=GREY, lw=0.6, dash=(4, 3)); f.text(pr(2.3, 2.3, 0), "$x=y$", dx=0.5, dy=-0.05, size=8.5, c=GREY)
    s = np.linspace(0, 1.95, 60); f.path([pr(t, t, 0.72 * t * t) for t in s], lw=1.3)
    sp = 1.35; Pp = pr(sp, sp, 0.72 * sp * sp); f.dot(Pp); f.text(Pp, "$P$", dx=0.28, dy=-0.05)
    f.line(Pp, pr(sp, sp, 0), c=GREY, lw=0.5, dash=(2, 2))
    f.arrow(o, pr(0.95, 0.95, 0), c=V, lw=1.5); f.text(pr(0.95, 0.95, 0), r"$\mathbfit{\tau}(0)$", c=V, dx=0.1, dy=-0.32)
    f.text(pr(1.9, 1.9, 0.72 * 1.9 ** 2), "Bahn", dx=-0.5, dy=0.1, size=8.5)
    f.save("a02_bahn")

# ---------- Kap. 3 ----------
def a03_rot():
    f = Fig(7.4, 6.8); o = P(2.6, 2.5); a = 2.5; pr = cube(f, o, a)
    f.axes3(o, l=3.3)
    A, B, E, C = pr(0, 0, 0), pr(a, 0, 0), pr(0, a, 0), pr(a, a, a)
    d = unit(C - E); f.line(E - d * 0.9, C + d * 1.0, c=M, lw=1.0, dash=(6, 2, 1, 2)); f.text(C + d * 1.0, r"$\mu$", c=M, dx=0.25, dy=0.05)
    f.arrow(E + d * 0.9, E + d * 1.9, c=M, lw=1.5); f.text(E + d * 1.9, bv(r"\omega"), c=M, dx=0.32, dy=-0.12)
    s = 0.85
    f.arrow(A, pr(s, 0, -s), c=V, lw=1.5); f.text(pr(s, 0, -s), bv("v", "A"), c=V, dx=0.38, dy=0.0)
    f.arrow(B, f.proj(B, s, s, -s), c=V, lw=1.5); f.text(f.proj(B, s, s, -s), bv("v", "B"), c=V, dx=0.35, dy=-0.1)
    for p, n, dx, dy in [(A, "O=A", -0.5, 0.25), (B, "B", -0.3, 0.1), (E, "E", 0.35, 0.25), (C, "C", 0.32, 0.05)]:
        f.dot(p, 0.06); f.text(p, f"${n}$", dx=dx, dy=dy)
    f.text((pr(0, 0, a) + pr(0, 0, 0)) / 2, "$a$", dx=-0.25)
    f.save("a03_wuerfelrot")

def a03_tetra():
    f = Fig(7.6, 5.6); o = P(3.1, 3.6); a = 2.5; pr = lambda x, y, z: f.proj(o, x, y, z)
    D, A, B, C, E = pr(0, 0, 0), pr(a, 0, 0), pr(a, a, 0), pr(0, a, 0), pr(a / 2, a / 2, -a)
    f.ground(E[0] - 2.3, E[0] + 2.3, E[1]); f.text((E[0] - 2.3, E[1]), "ruhende Ebene", dx=0.0, dy=0.28, size=8.5, ha="left")
    f.poly([D, A, B, C], fc=LIGHT, lw=0.9)
    for p in (A, B, C): f.line(p, E, lw=0.9)
    f.line(D, E, lw=0.6, c=GREY, dash=(3, 2))
    f.arrow(D, pr(0, 0, 1.3), lw=0.7); f.text(pr(0, 0, 1.3), "$z$", dy=0.25, size=9)
    f.arrow(C, pr(0, a + 1.1, 0), lw=0.7); f.text(pr(0, a + 1.1, 0), "$y$", dx=0.25, size=9)
    f.arrow(A, pr(a + 1.2, 0, 0), lw=0.7); f.text(pr(a + 1.2, 0, 0), "$x$", dx=-0.2, dy=-0.2, size=9)
    d = unit(B - D); f.arrow(D + d * 0.3, D + d * 1.25, c=M, lw=1.5); f.text(D + d * 0.8, bv(r"\omega"), c=M, dx=0.2, dy=0.28)
    f.arrow(B, f.proj(B, 1.5, 0, 0), c=V, lw=1.5); f.text(f.proj(B, 1.5, 0, 0), bv("v", "B"), c=V, dx=-0.42, dy=-0.12)
    for p, n, dx, dy in [(D, "D", -0.28, 0.2), (A, "A", -0.3, -0.05), (B, "B", 0.32, 0.12), (C, "C", 0.2, 0.28), (E, "E", 0.35, 0.3)]:
        f.dot(p, 0.06); f.text(p, f"${n}$", dx=dx, dy=dy)
    f.text((D + C) / 2, "$a$", dy=0.25)
    f.save("a03_tetraeder")

def a03_allg():
    f = Fig(7.4, 6.4); o = P(2.7, 1.7); L = 2.6; pr = cube(f, o, L)
    f.axes3(o, l=3.5)
    B, P1, P2, P3 = pr(0, 0, 0), pr(L, L, 0), pr(0, L, L), pr(0, 0, L)
    s = 1.3
    f.arrow(P1, f.proj(P1, -s, 0, 0), c=V, lw=1.5); f.text(f.proj(P1, -s, 0, 0), bv("v", "1"), c=V, dx=0.32, dy=0.12)
    f.arrow(P2, f.proj(P2, 0, 0, 0.9), c=V, lw=1.5); f.text(f.proj(P2, 0, 0, 0.9), bv("v", "2"), c=V, dx=0.35)
    f.arrow(P3, f.proj(P3, -s, 0, 0), c=V, lw=1.5); f.text(f.proj(P3, -s, 0, 0), bv("v", "3"), c=V, dx=0.32, dy=0.12)
    for p, n, dx, dy in [(B, "B", 0.25, -0.28), (P1, "P_1", 0.1, -0.35), (P2, "P_2", 0.4, -0.15), (P3, "P_3", -0.4, 0.12)]:
        f.dot(p, 0.06); f.text(p, f"${n}$", dx=dx, dy=dy)
    f.text((pr(L, 0, 0) + pr(L, L, 0)) / 2, "$L$", dy=-0.28)
    f.save("a03_wuerfelallg")

def a03_fw():
    f = Fig(9.6, 6.6); L = 2.15; A = P(1.5, 5.6)
    N = {k: A + L * P(*v) for k, v in dict(A=(0, 0), C=(1, 0), D=(1, -1), E=(2, -1), F=(2, -2), B=(3, -2)).items()}
    bars = [("A", "C", 1), ("A", "D", 2), ("C", "D", 3), ("C", "E", 4), ("D", "E", 5), ("D", "F", 6), ("F", "B", 7), ("E", "B", 8)]
    off = {1: (0, 0.22), 2: (-0.22, -0.18), 3: (-0.2, 0.2), 4: (0.22, 0.18), 5: (0, 0.22), 6: (-0.22, -0.18), 7: (0, -0.25), 8: (0.22, 0.18)}
    for a, b, n in bars:
        f.line(N[a], N[b], lw=1.5); m = (N[a] + N[b]) / 2; f.text(m + P(*off[n]), str(n), size=8, c=GREY)
    f.wall(N["A"][0] - 0.42, N["A"][1] - 0.6, N["A"][1] + 0.6, side=-1)
    f.poly([N["A"], N["A"] + P(-0.42, 0.26), N["A"] + P(-0.42, -0.26)], fc="white", lw=1.0, z=3)
    f.roller(N["B"])
    for k, p in N.items(): f.hinge(p, 0.085)
    f.arrow(N["B"] + P(0, 0.0), N["B"] + P(-1.25, 0), c=V, lw=1.6, z=8); f.text(N["B"] + P(-0.75, 0.3), bv("v", "B"), c=V)
    for k, dx, dy in [("A", 0.1, 0.35), ("C", 0.05, 0.33), ("D", -0.32, -0.12), ("E", 0.12, 0.33), ("F", -0.3, -0.22), ("B", 0.35, 0.1)]:
        f.text(N[k], f"${k}$", dx=dx, dy=dy)
    f.dim(N["A"] + P(0, 0.55), N["C"] + P(0, 0.55), "$L$", off=0.25)
    kos(f, (7.6, 5.0), l=0.75)
    f.save("a03_fachwerk")

# ---------- Kap. 5 ----------
def a05():
    f = Fig(7.6, 5.4); A = P(1.6, 1.2); L = 4.4; u = P(np.cos(rad(45)), np.sin(rad(45))); n = P(-u[1], u[0])
    B = A + L * u; C = A + L / 2 * u
    f.guide(A, A + P(2.0, 0)); f.angle(A, 1.0, 0, 45, label=r"$45^\circ$", lr=1.45, size=8.5)
    f.beam(A, B, lw=3.0); f.hinge(A, 0.09)
    f.arrow(A + P(0, -0.35), A + P(1.5, -0.35), c=V, lw=1.6); f.text(A + P(1.5, -0.35), bv("v", "A"), c=V, dx=0.35)
    f.arc(A, 0.6, 110, 250, col=M, lw=1.2, arrow=True); f.text(A + P(-0.85, 0.2), r"$\omega$", c=M)
    f.arrow(B, B + P(0, -1.5), c=F, lw=1.6); f.text(B + P(0, -1.5), bv("G"), c=F, dx=0.3, dy=0.1)
    f.arrow(C, C + n * 1.4, c=F, lw=1.6); f.text(C + n * 1.4, bv("W"), c=F, dx=-0.3, dy=0.2)
    f.dot(C, 0.06)
    for p, t, dx, dy in [(A, "A", -0.3, -0.25), (B, "B", 0.3, 0.2), (C, "C", 0.3, -0.2)]: f.text(p, f"${t}$", dx=dx, dy=dy)
    f.text(A + L / 4 * u, "$L/2$", dx=-0.4, dy=0.28, size=8.5); f.text(A + 3 * L / 4 * u, "$L/2$", dx=-0.4, dy=0.28, size=8.5)
    kos(f, (5.9, 0.9), l=0.75)
    f.save("a05_stab")

# ---------- Kap. 6 ----------
def a06():
    f = Fig(7.6, 6.4); o = P(2.9, 1.9); a = 2.5; pr = cube(f, o, a)
    f.axes3(o, l=3.6)
    A, C, B, D = pr(0, 0, 0), pr(a, 0, 0), pr(a, a, 0), pr(0, a, a)
    s = 1.15
    f.arrow(A, f.proj(A, -s, 0, 0), c=F, lw=1.6); f.text(f.proj(A, -s, 0, 0), bv("F", "A"), c=F, dx=0.3, dy=0.22)
    f.arrow(B, f.proj(B, 0, s, 0), c=F, lw=1.6); f.text(f.proj(B, 0, s, 0), bv("F", "B"), c=F, dx=0.05, dy=-0.3)
    f.arrow(C, f.proj(C, 0, 0, s), c=F, lw=1.6); f.text(f.proj(C, 0, 0, s), bv("F", "C"), c=F, dx=-0.35, dy=0.0)
    f.arrow(D, f.proj(D, s, -s, -s), c=F, lw=1.6); f.text(f.proj(D, s, -s, -s), bv("F", "D"), c=F, dx=-0.38, dy=0.05)
    for p, n, dx, dy in [(A, "A", -0.3, 0.05), (C, "C", -0.3, -0.12), (B, "B", 0.05, 0.3), (D, "D", 0.3, 0.22)]:
        f.dot(p, 0.06); f.text(p, f"${n}$", dx=dx, dy=dy)
    f.text((pr(a, 0, 0) + pr(a, a, 0)) / 2, "$a$", dy=-0.28)
    f.save("a06_wuerfel")

# ---------- Kap. 7 ----------
def a07():
    f = Fig(9.0, 6.9); o = P(1.5, 0.9); c = 1.15
    for i in range(5):
        f.line(o + P(i * c, 0), o + P(i * c, 4 * c), c=MID, lw=0.6, z=0); f.line(o + P(0, i * c), o + P(4 * c, i * c), c=MID, lw=0.6, z=0)
    f.arrow(o + P(-0.3, 0), o + P(6.6, 0), lw=0.7); f.text(o + P(6.85, 0), "$x$", size=9)
    f.arrow(o + P(0, -0.3), o + P(0, 4 * c + 0.7), lw=0.7); f.text(o + P(0, 4 * c + 0.95), "$y$", size=9)
    pts = dict(A1=(4, 4, -3), A2=(0, 3, 1), A3=(3, 2, -3), A4=(1, 1, 3), A5=(2, 0, -2))
    for k, (x, y, Fk) in pts.items():
        p = o + P(x * c, y * c); q = p + P(0.5 * Fk, 0)
        f.arrow(p, q, c=F, lw=1.6); f.hinge(p, 0.075)
        f.text(p, f"$A_{k[1]}$", dx=0.3 if k == "A2" else 0.05, dy=0.3, size=9)
        lab = {1: "F", 3: "3F", -3: "3F", -2: "2F"}[Fk]
        f.text((p + q) / 2, f"${lab}$", c=F, dy=-0.27, size=8.5)
    f.dim(o + P(4 * c, 0), o + P(4 * c, c), "1 m", off=-0.45, size=8)
    f.text(o + P(1.9 * c, 4 * c + 0.45), "Raster 1 m", size=8, c=GREY)
    f.save("a07_rahmen")

# ---------- Kap. 8 ----------
def a08_quader():
    f = Fig(8.6, 6.9); al = 28; u = P(np.cos(rad(-al)), np.sin(rad(-al))); n = P(-u[1], u[0])
    p0 = P(0.7, 4.9); p1 = p0 + u * 7.6
    f.hatch(p0, p1, side=-1)
    a = 1.5; m = p0 + u * 3.3; c = m + n * a
    pts = f.box(c, a, 2 * a, ang=-al, fc=LIGHT)
    top = m + n * 2 * a + u * a / 2
    f.arrow(top + P(1.5, 0), top, c=F, lw=1.6); f.text(top + P(1.5, 0), bv("F"), c=F, dx=0.25)
    f.dot(c, 0.06); f.text(c, "$S$", dx=-0.25, dy=0.12)
    f.arrow(c, c + P(0, -1.5), c=F, lw=1.6); f.text(c + P(0, -1.5), bv("G"), c=F, dx=0.3, dy=0.05)
    x = 0.42; q = m - u * x
    f.arrow(q - n * 1.3, q, c=F, lw=1.6, z=7); f.text(q - n * 1.3, bv("N"), c=F, dx=-0.3, dy=0.0)
    f.dim(q, m, "$x$", off=0.5, size=8.5)
    f.text(pts[0] + (pts[1] - pts[0]) / 2, "$a$", dx=0.05, dy=0.0 - 0.0, size=9, bg=False) if False else None
    f.text(m + n * 2 * a + n * 0.25, "$a$", size=9); f.text(m - u * (a / 2 + 0.3) + n * a, "$2a$", size=9)
    f.guide(p1, p1 - P(1.9, 0)); f.angle(p1, 1.3, 180 - al, 180, label=r"$\alpha$", lr=1.65)
    f.text(top, "$A$", dx=0.1, dy=0.32)
    f.save("a08_quader")

def a08_waage():
    f = Fig(7.6, 3.5); A = P(3.0, 1.4)
    f.beam(A + P(-2.4, 0), A + P(3.6, 0), lw=3.0); f.pin(A)
    f.arrow(A + P(-1.8, 1.5), A + P(-1.8, 0.06), c=F, lw=1.6); f.text(A + P(-1.8, 1.5), "$2F$", c=F, dy=0.25)
    f.arrow(A + P(3.6, 1.1), A + P(3.6, 0.06), c=F, lw=1.6); f.text(A + P(3.6, 1.1), "$F$", c=F, dy=0.25)
    f.dim(A + P(-1.8, 0), A, "$x$", off=0.55); f.dim(A, A + P(3.6, 0), "$L$", off=0.55)
    f.text(A, "$A$", dx=0.0, dy=0.33)
    f.save("a08_waage")

# ---------- Kap. 9 ----------
def a09_balken():
    f = Fig(8.4, 3.6); A = P(1.3, 1.5); L = 5.7; B = A + P(L, 0); C = A + P(L / 3, 0)
    f.beam(A, B, lw=3.0); f.roller(A); f.pin(B)
    d = P(np.cos(rad(-45)), np.sin(rad(-45)))
    f.arrow(C - d * 1.6, C, c=F, lw=1.6); f.text(C - d * 1.6, bv("P"), c=F, dx=-0.25, dy=0.2)
    f.arc(C, 0.75, 135, 180, col=INK, lw=0.7); f.text(C + P(-1.05, 0.38), r"$\pi/4$", size=8.5)
    f.dim(A, C, "$L/3$", off=-1.0); f.dim(C, B, "$2L/3$", off=-1.0)
    f.text(A, "$A$", dx=-0.35, dy=0.25); f.text(B, "$B$", dx=0.35, dy=0.25)
    f.save("a09_balken")

def a09_dreieck():
    f = Fig(8.8, 4.8); L = 2.7; A = P(1.4, 3.4); C = A + P(2 * L, 0); B = A + P(L, -L * np.tan(rad(30)))
    f.poly([A, C, B], fc=LIGHT, lw=1.2)
    f.wall(A[0] - 0.42, A[1] - 0.6, A[1] + 0.6, side=-1)
    f.poly([A, A + P(-0.42, 0.26), A + P(-0.42, -0.26)], fc="white", lw=1.0, z=3); f.hinge(A, 0.08)
    f.roller(B)
    Gp = A + P(1.5 * L, 0); f.arrow(Gp, Gp + P(0, -1.1), c=F, lw=1.6, z=7); f.text(Gp + P(0, -1.1), bv("G"), c=F, dx=0.3, dy=0.35)
    d = P(-0.5, np.sqrt(3) / 2); f.arrow(C - d * 1.5, C, c=F, lw=1.6); f.text(C - d * 1.5, bv("F"), c=F, dx=0.3)
    f.angle(A, 1.0, -30, 0, label=r"$30^\circ$", lr=1.5, size=8); f.angle(C, 0.8, 180, 210, label=r"$30^\circ$", lr=1.2, size=7.5)
    f.dim(A, Gp, "$3L/2$", off=0.4); f.dim(A + P(0, 0.0), C, "$2L$", off=0.95)
    for p, t, dx, dy in [(A, "A", -0.2, 0.85), (C, "C", 0.3, 0.2), (B, "B", 0.42, 0.05)]: f.text(p, f"${t}$", dx=dx, dy=dy)
    kos(f, (7.6, 0.7), l=0.7)
    f.save("a09_dreieck")

def a09_L():
    f = Fig(6.8, 5.0); A = P(1.3, 1.3); L = 3.0; B = A + P(L, 0); C = B + P(0, L)
    f.clamp(A, h=1.3, side=-1)
    f.beam(A, B, lw=3.0); f.beam(B + P(0, -0.04), C, lw=3.0)
    for p, lab in [(A + P(L / 2, 0), (0, -0.38)), (B + P(0, L / 2), (0.4, 0))]:
        otimes(f, p, 0.15); f.text(p + P(*lab), bv("G"), c=F)
    f.dim(A, B, "$L$", off=-0.95); f.dim(B, C, "$L$", off=-1.05)
    for p, t, dx, dy in [(A, "A", 0.15, 0.35), (B, "B", 0.3, -0.25), (C, "C", 0.3, 0.1)]: f.text(p, f"${t}$", dx=dx, dy=dy)
    kos(f, (1.7, 3.3), l=0.7)
    f.save("a09_lkrag")

def a09_schraeg():
    f = Fig(8.4, 4.4); al = 20; u = P(np.cos(rad(al)), np.sin(rad(al))); n = P(-u[1], u[0])
    A = P(1.3, 1.2); L = 5.8; B = A + L * u; S = A + 0.45 * L * u
    f.beam(A, B + u * 0.8, lw=3.0); f.pin(A)
    c = B - n * 0.17; f.circle(c, 0.11, fc="white", lw=0.9, z=4); f.hatch(c - n * 0.11 - u * 0.5, c - n * 0.11 + u * 0.5, side=-1)
    f.guide(A, A + P(2.3, 0)); f.angle(A, 1.5, 0, al, label=r"$\alpha$", lr=1.8)
    f.dot(S, 0.06); f.arrow(S, S + P(0, -1.4), c=F, lw=1.6); f.text(S + P(0, -1.4), bv("G"), c=F, dx=0.3, dy=0.05)
    f.dim(A, S, "$s$", off=0.5); f.dim(A, B, "$L$", off=1.05)
    for p, t, dx, dy in [(A, "A", -0.35, 0.15), (B, "B", 0.25, -0.5), (S, "S", 0.1, 0.0)]: f.text(p, f"${t}$", dx=dx, dy=dy - (0.28 if t == "S" else 0))
    o = P(6.6, 0.8); f.arrow(o, o + u * 0.8, lw=0.7); f.arrow(o, o + n * 0.8, lw=0.7); f.text(o + u * 1.05, "$x$", size=8.5); f.text(o + n * 1.05, "$y$", size=8.5)
    f.save("a09_schraeg")

def a09_T():
    f = Fig(8.2, 6.6); a = 1.0; B = P(1.6, 5.2); C = B + P(4 * a, 0); D = B + P(a, 0); A = D + P(0, -4 * a)
    f.beam(B, C, lw=3.0); f.beam(D, A, lw=3.0)
    for p in (B, C):
        for s in (-1, 1): f.rect((p[0] - 0.09 + s * 0.0, p[1] + s * 0.14), (p[0] + 0.09, p[1] + s * 0.5), fc=MID, lw=0.7)
    S2 = B + P(2 * a, 0); S1 = D + P(0, -2 * a)
    for p in (S1, S2): f.dot(p, 0.06, c="white", z=7); f.circle(p, 0.06, fc="white", lw=0.7, z=7)
    f.arrow(S2, S2 + P(0, -1.2), c=F, lw=1.6); f.text(S2 + P(0, -1.2), bv("G"), c=F, dx=0.3, dy=0.1)
    f.arrow(S1 + P(0.22, 0), S1 + P(0.22, -1.2), c=F, lw=1.6, z=6); f.text(S1 + P(0.22, -1.2), bv("G"), c=F, dx=0.3, dy=0.1)
    q = A + P(0.7, 0.9); f.arrow(q, q + P(0, -1.1), c=M, lw=1.5); f.head(q + P(0, -0.88), P(0, -1), c=M, hl=0.24)
    f.text(q + P(0.38, -0.55), bv("M"), c=M)
    f.line(A + P(-0.45, 0), A + P(0.45, 0), lw=2.2)
    f.dim(B, D, "$a$", off=0.75); f.dim(D, S2, "$a$", off=0.75); f.dim(S2, C, "$2a$", off=0.75)
    f.dim(D, S1, "$2a$", off=-0.6); f.dim(S1, A, "$2a$", off=-0.6)
    for p, t, dx, dy in [(B, "B", -0.35, 0.0), (C, "C", 0.35, 0.0), (D, "D", 0.25, 0.3), (A, "A", -0.3, -0.3), (S2, "S_2", 0.3, -0.28), (S1, "S_1", 0.35, 0.2)]:
        f.text(p, f"${t}$", dx=dx, dy=dy)
    kos(f, (6.2, 2.0), l=0.75)
    f.save("a09_ttraeger")

# ---------- Kap. 10 ----------
def a10():
    f = Fig(8.6, 6.8); A = P(2.0, 5.7); ph = 28; L = 2.5; u = P(np.cos(rad(-ph)), np.sin(rad(-ph)))
    D = A + 2 * L * u; B = A + L * u; C = P(A[0], D[1]); Sm = (B + C) / 2; gy = 0.9
    f.wall(A[0] - 0.42, A[1] - 0.55, A[1] + 0.55, side=-1)
    f.poly([A, A + P(-0.42, 0.26), A + P(-0.42, -0.26)], fc="white", lw=1.0, z=3)
    for dx in (-0.2, 0.2): f.line((A[0] + dx, A[1] - 0.75), (A[0] + dx, gy + 0.9), lw=0.7, c=GREY)
    f.ground(A[0] - 0.7, A[0] + 0.7, gy); f.spring((A[0], gy), C + P(0, -0.2), n=9, amp=0.15, lead=0.2)
    f.text((A[0] + 0.5, (gy + C[1]) / 2 - 0.2), "$k$", size=9)
    f.beam(A, D, lw=3.0); f.beam(B, C, lw=3.0)
    f.rect((C[0] - 0.2, C[1] - 0.2), (C[0] + 0.2, C[1] + 0.2), fc="white", lw=1.0, z=4)
    for p in (A, B, C): f.hinge(p, 0.085)
    f.guide(A, A + P(2.6, 0)); f.angle(A, 1.6, -ph, 0, label=r"$\varphi$", lr=1.95)
    f.arrow(B, B + P(0, -1.3), c=F, lw=1.6); f.text(B + P(0, -1.3), "$2G$", c=F, dx=0.38, dy=0.1)
    f.dot(Sm, 0.05); f.arrow(Sm, Sm + P(0, -1.0), c=F, lw=1.6); f.text(Sm + P(0, -1.0), "$G$", c=F, dx=0.28, dy=0.05)
    n = P(-u[1], u[0]); f.arrow(D + n * 1.4, D, c=F, lw=1.6); f.text(D + n * 1.4, bv("P"), c=F, dx=0.3, dy=0.05)
    for p, t, dx, dy in [(A, "A", 0.1, 0.35), (B, "B", 0.15, 0.33), (C, "C", -0.45, 0.0), (D, "D", 0.25, -0.3)]: f.text(p, f"${t}$", dx=dx, dy=dy)
    f.text(A + L / 2 * u, "$L$", dx=0.12, dy=0.3, size=8.5); f.text(A + 1.5 * L * u, "$L$", dx=0.12, dy=0.3, size=8.5); f.text(Sm, "$L$", dx=-0.25, dy=-0.3, size=8.5)
    f.dim(A + P(-0.9, 0), C + P(-0.9, 0), r"$2L\,\sin\varphi$", off=-0.35, size=8)
    kos(f, (6.6, 0.9), l=0.75)
    f.save("a10_feder")

# ---------- Kap. 12 ----------
def a12_schrank():
    f = Fig(7.0, 5.8); x0, y0, b, h = 2.9, 0.9, 2.2, 4.2
    f.ground(1.0, 6.4, y0); f.rect((x0, y0), (x0 + b, y0 + h), fc=LIGHT)
    c = P(x0 + b / 2, y0 + h / 2); f.dot(c, 0.06)
    f.arrow(c, c + P(0, -1.4), c=F, lw=1.6); f.text(c + P(0, -1.4), bv("G"), c=F, dx=-0.3, dy=0.1)
    yF = 2.6; f.arrow((x0 - 1.5, y0 + yF), (x0, y0 + yF), c=F, lw=1.6); f.text((x0 - 1.5, y0 + yF), bv("F"), c=F, dy=0.3, dx=0.2)
    e = 0.7; q = P(c[0] + e, y0); f.arrow(q, q + P(0, 1.5), c=F, lw=1.6, z=7); f.text(q + P(0, 1.5), bv("N"), c=F, dx=0.3)
    f.arrow((x0 + b - 0.2, y0 - 0.3), (x0 + b - 1.5, y0 - 0.3), c=F, lw=1.6); f.text((x0 + b - 1.5, y0 - 0.3), bv("F", "R"), c=F, dx=-0.38)
    f.dim((x0, y0 + h), (x0 + b, y0 + h), "$b$", off=0.4); f.dim((x0 - 1.9, y0), (x0 - 1.9, y0 + yF), "$y$", off=0.0)
    f.line((c[0], y0), (c[0], y0 + 0.9), c=GREY, lw=0.5, dash=(3, 2)); f.dim((c[0], y0 + 0.55), (q[0], y0 + 0.55), "$e$", off=0.0, size=8)
    f.save("a12_schrank")

def a12_scheibe():
    f = Fig(7.6, 6.5); ph = 25; u = P(np.cos(rad(-ph)), np.sin(rad(-ph))); n = P(-u[1], u[0])
    p0 = P(0.6, 3.9); p1 = p0 + u * 7.0; f.hatch(p0, p1, side=-1)
    r = 1.35; Z = p0 + u * 3.0; O = Z + n * r
    f.circle(O, r, fc=LIGHT); f.dot(O, 0.06); f.text(O, "$O$", dx=0.28, dy=0.12)
    f.arrow(O, O + P(0, -1.3), c=F, lw=1.6); f.text(O + P(0, -1.3), bv("G"), c=F, dx=0.3, dy=0.25)
    T = O + n * r; f.arrow(T, T - u * 1.4, c=F, lw=1.6); f.text(T - u * 1.4, bv("F", "B"), c=F, dx=-0.15, dy=0.33)
    f.arrow(Z - n * 1.3, Z, c=F, lw=1.6, z=7); f.text(Z - n * 1.3, bv("N"), c=F, dx=-0.3)
    f.arrow(Z - u * 0.0, Z - u * 1.3, c=F, lw=1.6, z=7); f.text(Z - u * 1.3, bv("F", "R"), c=F, dx=-0.1, dy=0.32)
    f.line(O, O + r * P(np.cos(rad(20)), np.sin(rad(20))), lw=0.6, c=GREY); f.text(O + 0.6 * r * P(np.cos(rad(20)), np.sin(rad(20))), "$r$", dy=0.2, size=8.5)
    f.guide(p1, p1 - P(1.9, 0)); f.angle(p1, 1.3, 180 - ph, 180, label=r"$\varphi$", lr=1.65)
    f.save("a12_scheibe")

def a12_staebe():
    f = Fig(7.4, 6.4); L = 2.5; A = P(1.6, 1.0); B = A + P(L, 0); u = P(0.5, np.sqrt(3) / 2); D = A + 2 * L * u; C = A + L * u
    f.beam(A, D, lw=3.0); f.beam(C, B, lw=3.0); f.pin(A); f.pin(B)
    f.arrow(D, D + P(0, -1.4), c=F, lw=1.6); f.text(D + P(0, -1.4), bv("G"), c=F, dx=0.3, dy=0.1)
    m = (C + B) / 2; f.arrow(m + P(1.5, 0), m, c=F, lw=1.6); f.text(m + P(1.5, 0), bv("F"), c=F, dx=0.25)
    f.angle(A, 0.9, 0, 60, label=r"$60^\circ$", lr=1.35, size=8)
    f.dot(C, 0.07)
    for p, t, dx, dy in [(A, "A", -0.4, 0.1), (B, "B", 0.4, 0.1), (C, "C", -0.3, 0.15), (D, "D", -0.3, 0.1)]: f.text(p, f"${t}$", dx=dx, dy=dy)
    f.text(A + L / 2 * u, "$L$", dx=-0.3, dy=0.12, size=8.5); f.text(A + 1.5 * L * u, "$L$", dx=-0.3, dy=0.12, size=8.5)
    f.text((C + m) / 2, "$L/2$", dx=0.4, dy=0.15, size=8.5); f.text((m + B) / 2, "$L/2$", dx=-0.42, dy=-0.1, size=8.5)
    f.save("a12_staebe")

# ---------- Kap. 14 ----------
def a14_krag():
    f = Fig(8.4, 3.4); A = P(1.6, 1.5); L = 4.6; B = A + P(L, 0)
    f.beam(A, B, lw=3.0); f.clamp(B, h=1.3, side=1)
    f.arrow(A, A + P(0, 1.3), c=F, lw=1.6); f.text(A + P(0, 1.3), bv("F"), c=F, dx=0.3)
    f.arrow(A, A + P(-1.2, 0), c=F, lw=1.6); f.text(A + P(-1.2, 0), bv("S"), c=F, dy=0.3, dx=0.15)
    f.dim(A, B, "$L$", off=-0.6); x = 1.8
    f.line(A + P(x, -0.35), A + P(x, 0.35), c=GREY, lw=0.7, dash=(3, 2)); f.dim(A + P(0, 0.0), A + P(x, 0), "$x$", off=0.7 - 0.25)
    kos(f, (7.2, 3.0), l=0.55, ydown=True, zin=True)
    f.save("a14_kragarm")

def a14_einfeld():
    f = Fig(8.0, 4.0); A = P(1.2, 1.6); a, b = 3.4, 2.2; B = A + P(a + b, 0); C = A + P(a, 0)
    f.beam(A, B, lw=3.0); f.pin(A); f.roller(B)
    f.arrow(C + P(0, 1.4), C + P(0, 0.06), c=F, lw=1.6); f.text(C + P(0, 1.4), bv("F"), c=F, dx=0.3)
    f.dim(A, C, "$a$", off=0.55); f.dim(C, B, "$b$", off=0.55)
    f.text(A, "$A$", dx=-0.35, dy=0.2); f.text(B, "$B$", dx=0.35, dy=0.2)
    kos(f, (2.0, 3.65), l=0.55, ydown=True, zin=True)
    f.save("a14_einfeld")

def a14_3d():
    f = Fig(8.4, 6.4); B = P(1.9, 4.2); L = 4.4; a = 2.3; C = B + P(L, 0); A = B + P(0, -a)
    f.beam(B, C, lw=3.0); f.beam(B + P(0, 0.04), A, lw=3.0); f.clamp(C, h=1.5, side=1)
    n = 7
    xs = np.linspace(0, L, n + 1); f.line(B, C + P(0, 1.1), c=F, lw=0.8)
    for x in xs[1:]: f.arrow(B + P(x, 1.1 * x / L), B + P(x, 0.06), c=F, lw=0.8, head=0.55)
    f.text(C + P(-0.3, 1.4), r"$q$", c=F); f.text(B + P(L / 2, 1.2), r"$q\,x/L$", c=F, size=8.5, dx=-0.5, dy=-0.1)
    f.arrow(A, A + P(-1.2, 0), c=F, lw=1.6); f.text(A + P(-1.2, 0), bv("F", "1"), c=F, dx=-0.05, dy=0.3)
    f.arrow(A, A + P(0, -1.2), c=F, lw=1.6); f.text(A + P(0, -1.2), bv("F", "2"), c=F, dx=0.35, dy=0.1)
    otimes(f, A + P(0.0, 0.0), 0.15); f.text(A + P(0.45, 0.25), bv("F", "3"), c=F)
    f.dim(B, C, "$L$", off=1.75); f.dim(B, A, "$a$", off=-0.6)
    for p, t, dx, dy in [(B, "B", -0.3, 0.25), (C, "C", -0.3, -0.35), (A, "A", -0.3, -0.3)]: f.text(p, f"${t}$", dx=dx, dy=dy)
    kos(f, (6.3, 1.9), l=0.7, ydown=True, zin=True)
    f.save("a14_winkel")

def a14_L():
    f = Fig(8.8, 5.4); A = P(1.4, 1.6); L = 2.6; Bp = A + P(L, 0); C = A + P(2 * L, 0); D = C + P(0, L)
    f.clamp(A, h=1.3, side=-1); f.beam(A, C, lw=3.0); f.beam(C + P(0, -0.04), D, lw=3.0); f.hinge(Bp, 0.1); f.roller(C)
    n = 6
    for y in np.linspace(0, L, n + 1)[1:]: f.arrow(C + P(0.06, y), C + P(0.95, y), c=F, lw=0.8, head=0.55)
    f.line(C + P(0.95, 0), D + P(0.95, 0), c=F, lw=0.8); f.text(D + P(1.0, 0.0), r"$q=P/L$", c=F, dx=0.0, dy=0.3, size=8.5)
    f.dim(A, Bp, "$L$", off=0.5); f.dim(Bp, C, "$L$", off=0.5); f.dim(C, D, "$L$", off=-1.45)
    for p, t, dx, dy in [(A, "A", 0.25, -0.35), (Bp, "B", 0.0, -0.35), (C, "C", -0.3, 0.3), (D, "D", -0.3, 0.05)]: f.text(p, f"${t}$", dx=dx, dy=dy)
    kos(f, (2.2, 3.6), l=0.7)
    f.save("a14_ltraeger")

for fn in (a02, a03_rot, a03_tetra, a03_allg, a03_fw, a05, a06, a07, a08_quader, a08_waage, a09_balken, a09_dreieck, a09_L,
           a09_schraeg, a09_T, a10, a12_schrank, a12_scheibe, a12_staebe, a14_krag, a14_einfeld, a14_3d, a14_L):
    fn()
