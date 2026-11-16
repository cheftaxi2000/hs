from figlib import *

def experiment():
    f = Fig(15.8, 4.2)
    f.ground(0.3, 6.3, 0.8); f.rect((1.4, 0.8), (3.6, 2.2)); f.dot((2.5, 1.5), 0.05)
    f.arrow((2.5, 1.5), (2.5, 0.35), c=F, lw=1.4); f.text((2.5, 0.35), r"$\mathbfit{G}$", c=F, dx=0.4)
    f.arrow((3.6, 1.5), (5.4, 1.5), c=F, lw=1.6); f.text((5.4, 1.5), r"$\mathbfit{F}$", c=F, dx=0.35, dy=0.25)
    f.arrow((2.5, 0.8), (1.1, 0.8), c=F, lw=1.6); f.text((1.1, 0.8), r"$\mathbfit{F}_R$", c=F, dx=-0.45, dy=0.35)
    f.arrow((3.0, 0.1), (3.0, 0.8), c=F, lw=0) if False else None
    # Diagramm
    o = P(8.3, 0.9)
    f.arrow(o - P(0.1, 0), o + P(6.5, 0), lw=0.7, head=0.6); f.arrow(o - P(0, 0.1), o + P(0, 3.2), lw=0.7, head=0.6)
    f.text(o + P(6.75, 0), "$F$"); f.text(o + P(0, 3.45), "$|F_R|$")
    f.line(o, o + P(2.6, 2.6), c=F, lw=1.6); f.line(o + P(2.6, 1.7), o + P(6.1, 1.7), c=F, lw=1.6); f.line(o + P(2.6, 2.6), o + P(2.6, 1.7), c=F, lw=0.7, dash=(3, 2))
    f.guide(o + P(0, 2.6), o + P(2.6, 2.6)); f.guide(o + P(0, 1.7), o + P(2.6, 1.7))
    f.text(o + P(-0.55, 2.6), r"$\mu_0 N$", size=8.5); f.text(o + P(-0.55, 1.7), r"$\mu_1 N$", size=8.5)
    f.text(o + P(1.1, 0.35), "Haften", c=GREY, size=8.5); f.text(o + P(4.5, 1.35), "Gleiten", c=GREY, size=8.5)
    f.text(o + P(1.1, 0.95), r"$F_R=F$", c=F, size=8.5, dx=0.3, dy=0.2)
    f.save("k12_experiment")

def schief():
    f = Fig(15.8, 4.8)
    a = rad(26.565); x0, y0, L = 0.8, 0.9, 5.0
    top = P(x0 + L, y0 + L * np.tan(a))
    f.poly([(x0, y0), (x0 + L, y0), tuple(top)], fc="#f7f7f7", ec="white", lw=0); f.hatch(tuple(top), (x0, y0), side=-1)
    u = P(np.cos(a), np.sin(a)); n = P(-np.sin(a), np.cos(a)); base = P(x0, y0) + u * 2.3; c = base + n * 0.55
    f.box(c, 1.6, 1.1, ang=np.degrees(a), fc=LIGHT); f.dot(c, 0.05)
    f.arrow(c, c + P(0, -1.3), c=F, lw=1.5); f.text(c + P(0, -1.3), r"$\mathbfit{G}$", c=F, dx=0.4)
    f.arrow(base, base + n * 1.3, c=F, lw=1.5); f.text(base + n * 1.3, r"$\mathbfit{N}$", c=F, dx=-0.3, dy=0.2)
    f.arrow(base, base + u * 1.3, c=F, lw=1.5); f.text(base + u * 1.3, r"$\mathbfit{F}_R$", c=F, dx=0.5, dy=-0.1)
    f.angle((x0, y0), 1.2, 0, 26.565, label=r"$\alpha$", lr=1.6, size=9)
    # Reibungskegel
    o = P(11.2, 0.9)
    r0 = rad(25); 
    f.arrow(o, o + P(0, 3.4), c=GREY, lw=0.8, head=0.6); f.text(o + P(0.0, 3.65), "Normale", size=8, c=GREY, dx=0.0)
    for s in (-1, 1): f.line(o, o + P(s * 3.4 * np.sin(r0), 3.4 * np.cos(r0)), c=INK, lw=0.9, dash=(5, 3))
    f.line(o + P(-3.0, 0), o + P(3.0, 0), c=INK, lw=1.2); f.hatch(o + P(3.0, 0), o + P(-3.0, 0), side=-1)
    f.arc(o + P(0, 0.0), 2.0, 90 - 25, 90 + 25, col=INK, lw=0.7); f.text(o + P(0, 2.45), r"$\rho_0$", size=9)
    R = P(0.8, 2.5); f.arrow(o + R * 0, o + R, c=F, lw=1.7); f.text(o + R, r"$\mathbfit{R}$", c=F, dx=0.3, dy=0.2)
    f.cap((11.2, 0.25), "Reibungskegel: $\\tan\\rho_0=\\mu_0$", size=8.5)
    f.save("k12_ebene")

def leiter():
    f = Fig(15.8, 4.8)
    gy, wx = 0.9, 5.4; al = rad(55); Lh = 4.0
    A = P(wx - Lh * np.cos(al), gy); B = P(wx, gy + Lh * np.sin(al))
    f.hatch((0.4, gy), (wx + 0.3, gy)); f.hatch((wx, 4.8), (wx, gy), side=-1)
    f.beam(A, B, lw=2.8); f.hinge(A, 0.08)
    S = (A + B) / 2; f.dot(S, 0.06); f.arrow(S, S - P(0, 1.2), c=F, lw=1.5); f.text(S - P(0, 1.2), r"$\mathbfit{G}$", c=F, dx=0.4)
    f.arrow(A - P(0, 0.8), A, c=F, lw=1.5); f.text(A - P(0.45, 0.45), r"$N_A$", c=F, size=9)
    f.arrow(A - P(1.1, 0), A - P(0.08, 0), c=F, lw=1.5); f.text(A - P(1.1, -0.35), r"$F_R$", c=F, size=9)
    f.arrow(B + P(1.1, 0) * 0 + P(1.1, 0), B + P(0.08, 0), c=F, lw=0) if False else None
    f.arrow(B + P(-1.1, 0) * 0, B, c=F, lw=0) if False else None
    f.arrow(B - P(1.0, 0), B, c=F, lw=1.5) if False else None
    f.arrow(B + P(0.0, 0), B + P(-1.1, 0), c=F, lw=1.5); f.text(B + P(-1.1, 0.35), r"$N_B$", c=F, size=9)
    f.angle(A, 1.0, 0, 55, label=r"$\alpha$", lr=1.35, size=9)
    f.cap((9.8, 3.2), "Wand glatt, Boden rau:", size=8.5); f.cap((9.8, 2.7), "$N_A=G,\\ F_R=N_B$", size=9); f.cap((9.8, 2.1), "$F_R\\leq\\mu_0 N_A$", size=9); f.cap((9.8, 1.5), "$\\tan\\alpha\\geq 1/(2\\mu_0)$", size=9)
    f.save("k12_leiter")

def rollen():
    f = Fig(15.8, 4.2)
    for x0, k in ((3.2, 0), (11.2, 1)):
        f.ground(x0 - 2.0, x0 + 2.0, 0.8); c = P(x0, 0.8 + 1.4); f.circle(c, 1.4, fc=LIGHT); f.dot(c, 0.05)
        f.arrow(c, c - P(0, 1.0), c=F, lw=1.4); f.text(c - P(0, 1.0), r"$\mathbfit{G}$", c=F, dx=-0.4, dy=0.0)
        if k == 0:
            f.arrow((x0 + 0.5, 0.0), (x0 + 0.5, 0.8), c=F, lw=1.6); f.text((x0 + 0.5, 0.0), r"$\mathbfit{N}$", c=F, dx=0.4, dy=0.1); f.text((x0 + 0.95, 0.4), "$e$", size=8.5)
            f.text((x0 + 0.25, -0.25), "", size=8)
        else:
            f.arrow((x0, 0.0), (x0, 0.8), c=F, lw=1.6); f.text((x0, 0.0), r"$\mathbfit{N}$", c=F, dx=0.4, dy=0.1)
            f.arc(P(x0, 0.8), 0.6, 20, 160, col=M, lw=1.3, arrow=True); f.text((x0 + 1.5, 1.2), r"$M_R=eN$", c=M, size=8.5)
    f.text((7.2, 2.2), r"$=$", size=14)
    f.save("k12_roll")
experiment(); schief(); leiter(); rollen()
