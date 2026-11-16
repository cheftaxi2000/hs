from figlib import *

def isect(p, d, q, e):
    A = np.array([d, -np.array(e)]).T; s = np.linalg.solve(A, np.array(q) - np.array(p)); return np.array(p) + s[0] * np.array(d)

# ---------- 3.1 Satz der projizierten Geschwindigkeiten ----------
def sdpg():
    f = Fig(15.8, 5.4)
    f.potato((3.15, 2.4), 5.9, 4.2, ang=8, seed=5)
    Mp, Np = P(1.5, 1.5), P(4.8, 2.7); u = unit(Np - Mp)
    f.line(Mp - u * 0.5, Np + u * 0.8, c=GREY, lw=0.7, dash=(5, 3))
    vM = P(0.7, 1.75); vN = P(1.25, 0.3)
    # Normieren: gleiche Projektion
    pm = vM @ u; vN = u * pm + nrm(u) * (-0.9)
    for p, v, n in [(Mp, vM, "M"), (Np, vN, "N")]:
        q = p + v; pr = p + u * (v @ u)
        f.guide(q, pr)
        f.arrow(p, pr, c=INK, lw=2.4, head=0.9)
        f.arrow(p, q, c=V, lw=1.5)
        f.dot(p)
    f.text(Mp + vM, r"$\mathbfit{v}_M$", c=V, dx=-0.2, dy=0.3); f.text(Np + vN, r"$\mathbfit{v}_N$", c=V, dx=0.4, dy=-0.15)
    f.text(Mp, "$M$", dx=-0.35, dy=-0.15); f.text(Np, "$N$", dx=-0.15, dy=0.4)
    f.text(Mp + u * (vM @ u) * 0.5, r"$v'_M$", dy=-0.35, dx=0.0, size=9); f.text(Np + u * (vN @ u) * 0.5, r"$v'_N$", dy=0.38, size=9)
    f.cap((3.2, 0.3), "$v'_M = v'_N$ (gleiche Anteile längs $M N$)", size=8)
    # Stab
    ground_y, wall_x = 0.9, 9.0; L = 4.3; al = rad(40)
    A = P(wall_x + L * np.cos(al), ground_y); B = P(wall_x, ground_y + L * np.sin(al))
    f.hatch((wall_x - 0.2, ground_y), (14.9, ground_y)); f.hatch((wall_x, 5.1), (wall_x, ground_y))
    f.beam(A, B); f.hinge(A, 0.09); f.hinge(B, 0.09)
    f.arrow(A, A + P(1.5, 0), c=V, lw=1.6); f.text(A + P(1.5, 0), r"$\mathbfit{v}_A$", c=V, dx=0.4, dy=0.1)
    vb = 1.5 / np.tan(al); f.arrow(B, B + P(0, -vb), c=V, lw=1.6); f.text(B + P(0, -vb), r"$\mathbfit{v}_B$", c=V, dx=0.4, dy=-0.1)
    f.angle(A, 1.0, 140, 180, label=r"$\alpha$", lr=1.4, size=9)
    f.text(A, "$A$", dx=0.2, dy=0.4); f.text(B, "$B$", dx=0.3, dy=0.25)
    f.cap((12.0, 0.3), "$v_B = v\\,\\cot\\alpha$", size=8.5)
    f.save("k03_sdpg")

# ---------- 3.2 Translation / Rotation ----------
def trans_rot():
    f = Fig(15.8, 4.8)
    # Translation
    f.potato((2.0, 2.3), 3.5, 2.3, ang=-8, seed=11)
    for q in [(1.0, 1.8), (2.0, 1.8), (3.0, 1.8), (1.0, 2.8), (2.0, 2.8), (3.0, 2.8)]:
        f.dot(q, 0.05); f.arrow(q, P(*q) + P(0.8, 0.5), c=V, lw=1.2)
    f.cap((2.0, 0.3), "Translation: alle Pfeile gleich")
    # Viergelenk (kreisförmige Translation)
    O1, O2 = P(5.6, 1.1), P(8.8, 1.1); a = 2.0; ph = 62
    A1, A2 = O1 + a * np.array([np.cos(rad(ph)), np.sin(rad(ph))]), O2 + a * np.array([np.cos(rad(ph)), np.sin(rad(ph))])
    f.pin(O1, size=0.3, gw=0.8); f.pin(O2, size=0.3, gw=0.8)
    f.beam(O1, A1, lw=2.4); f.beam(O2, A2, lw=2.4); f.beam(A1, A2, lw=3.2)
    for p in (O1, O2, A1, A2): f.hinge(p, 0.08)
    f.arc(O1, a, 20, 120, col=GREY, lw=0.6, dash=(3, 3)); f.arc(O2, a, 20, 120, col=GREY, lw=0.6, dash=(3, 3))
    t = np.array([-np.sin(rad(ph)), np.cos(rad(ph))]) * 1.1
    for p in (A1, A2, (A1 + A2) / 2): f.arrow(p, p + t, c=V, lw=1.3)
    f.cap((7.7, 0.3), "Viergelenk: kreisförmige Translation von $A A'$")
    # Rotation
    c = P(13.3, 2.3)
    f.circle(c, 1.5, fc=LIGHT); f.dot(c, 0.06)
    for r_ in (0.5, 1.0, 1.5): f.arrow(c + P(r_, 0), c + P(r_, 0.8 * r_), c=V, lw=1.2, hl=0.14 if r_ < 1 else None)
    f.line(c, c + P(1.5, 0), c=GREY, lw=0.6)
    f.moment(c + P(-0.0, 0), 0.4, 200, 500, label=None)
    f.cap((13.3, 0.3), "Rotation: $|\\mathbf{v}|=\\omega r$")
    f.save("k03_transrot")

# ---------- 3.3 Rollen ----------
def rollen():
    f = Fig(15.8, 4.8)
    R, y0 = 1.5, 0.7
    def wheel(cx, vs=True):
        c = P(cx, y0 + R); f.hatch((cx - 2.2, y0), (cx + 2.2, y0)); f.circle(c, R, fc=LIGHT); f.dot(c, 0.06); return c
    c = wheel(3.1); Z = P(3.1, y0); w = 1.0 / R
    f.guide(Z, c + P(0, R))
    for a in (90, 150, 35, 215, 0, 180):
        p = pol(c, R, a); r_ = p - Z; v = w * P(r_[1], -r_[0])
        f.dot(p, 0.045); f.arrow(p, p + v, c=V, lw=1.4); f.line(Z, p, c=GREY, lw=0.5, dash=(3, 3))
    f.arrow(c, c + P(1.0, 0), c=V, lw=1.5)
    f.dot(Z, 0.08, c=F); f.text(Z, "$Z$", c=F, dx=0.0, dy=-0.4)
    f.text(c, r"$O$", dx=-0.3, dy=-0.2, size=9)
    f.text(c + P(0.75, 0.25), "$v$", c=V, size=9); f.text(c + P(1.35, R - 0.15), "$2v$", c=V, size=9)
    f.cap((3.1, 0.3), "wirkliche Geschwindigkeiten")
    # Zerlegung
    for cx in (8.4, 13.0):
        wheel(cx)
    c1, c2 = P(8.4, y0 + R), P(13.0, y0 + R)
    for a in (90, 180, 270, 0):
        p = pol(c1, R, a); f.arrow(p, p + P(1.0, 0), c=V, lw=1.3)
    f.arrow(c1, c1 + P(1.0, 0), c=V, lw=1.3)
    for a in (90, 180, 270, 0):
        p = pol(c2, R, a); v = P(-np.sin(rad(a)), np.cos(rad(a))) * (-1.0)
        f.arrow(p, p + v, c=V, lw=1.3)
    f.moment(c2, 0.45, 160, -140, label=None)
    f.cap((8.4, 4.35), "Translation mit $v_O$"); f.cap((13.0, 4.35), "Drehung um $O$ mit $\\omega$")
    f.save("k03_rollen")

# ---------- 3.4 Kinemate ----------
def kinemate():
    f = Fig(15.8, 5.2)
    f.potato((4.2, 2.4), 7.4, 4.2, ang=6, seed=7)
    B, M_ = P(2.2, 1.7), P(5.8, 2.7)
    f.line(B, M_, c=GREY, lw=0.8)
    f.arrow(B, B + P(1.5, 0.35), c=V, lw=1.6); f.text(B + P(1.5, 0.35), r"$\mathbfit{v}_B$", c=V, dx=0.35, dy=0.0)
    f.arrow(M_, M_ + P(1.5, 0.35), c=V, lw=1.0, dash=(4, 3)); f.text(M_ + P(1.5, 0.35), r"$\mathbfit{v}_B$", c=V, dx=0.35, dy=-0.2, size=8.5)
    rot = P(-0.5, 2.0)
    f.arrow(M_ + P(1.5, 0.35), M_ + P(1.5, 0.35) + rot * 0.0 + P(0, 1.0), c=V, lw=1.0, dash=(4, 3))
    f.arrow(M_, M_ + P(1.5, 0.35) + P(0, 1.0), c=V, lw=1.8); f.text(M_ + P(1.5, 1.35), r"$\mathbfit{v}_M$", c=V, dx=0.1, dy=0.4)
    f.text(M_ + P(2.0, 0.7), r"$\boldsymbol{\omega}\times BM$", c=V, size=8.5, dx=0.5)
    f.dot(B); f.dot(M_); f.text(B, "$B$", dx=-0.3, dy=-0.3); f.text(M_, "$M$", dx=-0.2, dy=-0.45)
    f.moment(B, 0.45, 40, 330, label=None); f.text(B + P(-0.55, 0.8), r"$\boldsymbol{\omega}$", c=M, size=10)
    f.cap((12.1, 3.7), r"$\boldsymbol{\omega}=\mathbf{0}$: Translation", size=8.5); f.cap((12.1, 2.9), r"$\mathbf{v}_B=\mathbf{0}$: Kreiselung um $B$", size=8.5); f.cap((12.1, 2.1), "sonst: beides überlagert", size=8.5)
    f.save("k03_kinemate")

# ---------- 3.5 Zentralachse / Schraube ----------
def schraube():
    f = Fig(15.8, 6.0)
    Z = P(6.4, 3.2)
    f.axes3(Z + P(-4.2, -1.8), l=1.5)
    f.line(f.proj(Z, 0, -3.6, 0), f.proj(Z, 0, 3.8, 0), c=GREY, lw=0.8, dash=(7, 3, 1.5, 3))
    f.text(f.proj(Z, 0, 3.8, 0), r"Zentralachse $\zeta$", dx=0.1, dy=0.45, size=8.5, c=GREY)
    f.arrow(f.proj(Z, 0, -3.2, 0), f.proj(Z, 0, -1.6, 0), c=M, lw=1.8); f.text(f.proj(Z, 0, -2.4, 0), r"$\boldsymbol{\omega}$", c=M, dy=0.4, size=10)
    f.arrow(Z, f.proj(Z, 0, 1.7, 0), c=V, lw=1.8); f.dot(Z, 0.07); f.text(Z, "$Z$", dx=-0.3, dy=0.3)
    f.text(f.proj(Z, 0, 1.7, 0), r"$\mathbfit{v}_Z=\mathbfit{v}_\omega$", c=V, dx=0.1, dy=-0.5, size=9)
    Bp = f.proj(Z, 0, 0, -2.0)
    f.line(Z, Bp, c=GREY, lw=0.8, dash=(4, 3)); f.dot(Bp); f.text(Bp, "$B$", dx=-0.35, dy=-0.1)
    f.text((Z + Bp) / 2, r"$d_Z$", dx=-0.35, dy=0.0, size=9)
    vo = f.proj(Bp, 0, 1.7, 0) - Bp; vp = f.proj(Bp, 3.0, 0, 0) - Bp
    f.arrow(Bp, Bp + vo, c=V, lw=1.2, dash=(5, 3)); f.arrow(Bp, Bp + vp, c=V, lw=1.2, dash=(5, 3))
    f.arrow(Bp, Bp + vo + vp, c=V, lw=1.9)
    f.text(Bp + vo / 2, r"$\mathbfit{v}_\omega$", c=V, dx=0.1, dy=0.35, size=8.5); f.text(Bp + vp / 2, r"$(\mathbfit{v}_B)_\perp$", c=V, dx=-0.3, dy=-0.55, size=8.5)
    f.text(Bp + vo + vp, r"$\mathbfit{v}_B$", c=V, dx=0.2, dy=-0.4, size=9.5)
    f.cap((12.3, 1.1), "Schraube: Drehung um $\\zeta$ und", size=8.5); f.cap((12.3, 0.7), "Verschiebung längs $\\zeta$", size=8.5)
    f.save("k03_schraube")

# ---------- 3.6 Momentanzentrum ----------
def momentanzentrum():
    f = Fig(15.8, 5.4)
    f.potato((2.95, 2.2), 5.4, 3.7, ang=-6, seed=2)
    Pp, Qp = P(1.5, 1.6), P(4.5, 2.5); d1 = P(1.0, -0.45); d2 = P(0.45, 1.0)
    n1, n2 = nrm(d1), nrm(d2)
    Z = isect(Pp, n1, Qp, n2)
    f.line(Pp - n1 * 0.6, Z + n1 * 0.4, c=F, lw=0.8, dash=(5, 3)); f.line(Qp - n2 * 0.6, Z + n2 * 0.4, c=F, lw=0.8, dash=(5, 3))
    f.arrow(Pp, Pp + unit(d1) * 1.3, c=V, lw=1.6); f.arrow(Qp, Qp + unit(d2) * 1.3, c=V, lw=1.6)
    f.dot(Pp); f.dot(Qp); f.dot(Z, 0.08, c=F)
    f.text(Pp, "$P$", dx=-0.3, dy=-0.2); f.text(Qp, "$Q$", dx=-0.3, dy=-0.2)
    f.text(Pp + unit(d1) * 1.3, r"$\mathbfit{v}_P$", c=V, dx=0.35, dy=-0.1); f.text(Qp + unit(d2) * 1.3, r"$\mathbfit{v}_Q$", c=V, dx=0.4, dy=0.1)
    f.text(Z, "$Z$", c=F, dx=-0.3, dy=0.3)
    cr = (Pp - Z)[0] * d1[1] - (Pp - Z)[1] * d1[0]
    f.arc(Z, 0.55, 200, 480 if cr > 0 else -120, col=M, lw=1.2, arrow=True)
    f.cap((3.0, 0.3), "Senkrechten zu $\\mathbf{v}_P$, $\\mathbf{v}_Q$ schneiden sich in $Z$", size=8)
    # Stab
    gy, wx = 0.9, 9.0; L = 4.2; al = rad(50)
    A = P(wx + L * np.cos(al), gy); B = P(wx, gy + L * np.sin(al)); Zs = P(A[0], B[1])
    f.hatch((wx - 0.2, gy), (15.0, gy)); f.hatch((wx, 5.1), (wx, gy))
    f.line(A, Zs, c=F, lw=0.8, dash=(5, 3)); f.line(B, Zs, c=F, lw=0.8, dash=(5, 3))
    f.beam(A, B); f.hinge(A, 0.09); f.hinge(B, 0.09); f.dot(Zs, 0.08, c=F)
    f.arrow(A, A + P(1.4, 0), c=V, lw=1.6); f.arrow(B, B + P(0, -1.4 / np.tan(al)), c=V, lw=1.6)
    f.text(A, "$A$", dx=-0.3, dy=0.35); f.text(B, "$B$", dx=0.35, dy=0.2); f.text(Zs, "$Z$", c=F, dx=0.3, dy=0.3)
    f.arc(Zs, 0.5, 200, 500, col=M, lw=1.2, arrow=True)
    f.cap((12.0, 0.3), "Stab: $Z$ ist die vierte Ecke des Rechtecks", size=8)
    f.save("k03_momentanzentrum")

# ---------- 3.7 Polbahnen ----------
def polbahnen():
    f = Fig(15.8, 5.4)
    O = P(1.6, 0.8); L = 4.2
    f.hatch((O[0] - 0.2, O[1]), (O[0] + 5.8, O[1])); f.hatch((O[0], O[1] + 5.0), (O[0], O[1]))
    f.arc(O, L, 0, 90, col=GREY, lw=1.4)
    for al_ in (25, 45, 65):
        al = rad(al_); A = O + P(L * np.cos(al), 0); B = O + P(0, L * np.sin(al))
        Zp = P(A[0], B[1]); cc = (A + B) / 2
        if al_ == 45:
            f.beam(A, B, lw=2.8); f.hinge(A, 0.08); f.hinge(B, 0.08); f.dot(Zp, 0.08, c=F)
            f.circle(cc, L / 2, fc="none", ec=V, lw=1.2, z=2)
            f.text(Zp, "$Z$", c=F, dx=0.3, dy=0.3)
        else:
            f.dot(Zp, 0.06, c=F)
    f.text(O + P(L * 0.72 + 0.6, L * 0.72 + 0.6), "feste Polbahn", c=GREY, size=8.5, dx=0.5)
    f.text(O + P(0.6, 2.3), "bewegliche\nPolbahn", c=V, size=8.5, dx=0.4, ha="left")
    f.text(O, "$O$", dx=-0.3, dy=-0.3)
    f.cap((10.6, 3.6), "Der geführte Stab $A B$ rollt mit dem", size=8.5); f.cap((10.6, 3.2), "Thaleskreis (Durchmesser $A B$)", size=8.5); f.cap((10.6, 2.8), "innen am Kreis mit Radius $L$ ab.", size=8.5)
    f.save("k03_polbahnen")

# ---------- 3.8 Planetengetriebe ----------
def planet():
    f = Fig(15.8, 6.4)
    O = P(4.2, 3.2); R1, R2 = 1.3, 3.0; R3 = (R2 - R1) / 2; Lc = (R1 + R2) / 2
    f.circle(O, R2 + 0.5, fc=MID); f.circle(O, R2, fc="white"); f.circle(O, R1, fc=LIGHT)
    O3 = O + P(Lc, 0); f.circle(O3, R3, fc=LIGHT, z=3)
    f.beam(O, O3, lw=2.2); f.dot(O, 0.07); f.dot(O3, 0.07, z=7)
    Pp = O + P(R1, 0); Qp = O + P(R2 - 0.5, 0)
    f.text(O, "$O$", dx=-0.25, dy=-0.35)
    f.text(O3, "$O'$", dx=0.0, dy=0.35, size=8.5)
    f.dot(Pp, 0.07, c=F); f.dot(O + P(R2 - 0.5, 0), 0.0)
    Qp = O3 + P(R3, 0); f.dot(Qp, 0.07, c=F)
    f.text(Pp, "$P$", dx=0.0, dy=-0.9 + 0.35, size=9); f.text(Qp, "$Q$", dx=0.35, dy=-0.4, size=9)
    f.arrow(Pp, Pp + P(0, 1.0), c=V, lw=1.5); f.arrow(Qp, Qp + P(0, 1.6), c=V, lw=1.5)
    f.text(Pp + P(0, 1.0), r"$R_1\omega_1$", c=V, dx=-0.85, dy=0.3, size=8.5); f.text(Qp + P(0, 1.6), r"$R_2\omega_2$", c=V, dx=0.7, dy=0.2, size=8.5)
    f.text(O + P(-0.5, 0.55), "1", size=9); f.text(O + P(-2.9, 1.7), "2", size=9); f.text(O3 + P(0.0, -0.55), "3", size=9); f.text(O + P(0.7, -0.3), "Arm", size=8, c=GREY)
    f.cap((9.6, 5.0), "Rad 1: Radius $R_1$, Drehung $\\omega_1$", size=8.5, ha="left"); f.cap((9.6, 4.5), "Hohlrad 2: Radius $R_2$, Drehung $\\omega_2$", size=8.5, ha="left")
    f.cap((9.6, 4.0), "Planetenrad 3: Radius $(R_2-R_1)/2$", size=8.5, ha="left"); f.cap((9.6, 3.5), "Arm: Länge $(R_1+R_2)/2$", size=8.5, ha="left")
    f.save("k03_planet")

sdpg(); trans_rot(); rollen(); kinemate(); schraube(); momentanzentrum(); polbahnen(); planet()

# ---------- 3.9 Schubkurbelgetriebe ----------
def kurbel():
    f = Fig(15.8, 6.8)
    O = P(3.6, 1.6); r, l = 1.8, 5.0; ph = rad(38)
    B = O + r * P(np.cos(ph), np.sin(ph)); A = P(B[0] + np.sqrt(l ** 2 - (B[1] - O[1]) ** 2), O[1])
    Z = P(A[0], O[1] + np.tan(ph) * (A[0] - O[0]))
    f.hatch((2.6, O[1] - 0.5), (13.1, O[1] - 0.5), side=-1)
    
    f.line(O, Z, c=F, lw=0.8, dash=(5, 3)); f.line(A, Z, c=F, lw=0.8, dash=(5, 3))
    f.rect((A[0] - 0.55, O[1] - 0.4), (A[0] + 0.55, O[1] + 0.4), fc=LIGHT)
    f.beam(O, B, lw=3.0); f.beam(B, A, lw=2.4)
    f.hinge(O, 0.1); f.hinge(B, 0.1); f.hinge(A, 0.1); f.dot(Z, 0.09, c=F)
    f.pin(O, size=0.3, gw=0.9) if False else None
    f.text(O, "$O$", dx=0.35, dy=-0.05); f.text(B, "$B$", dx=0.3, dy=0.32); f.text(A, "$A$", dx=0.3, dy=0.62); f.text(Z, "$Z_3$", c=F, dx=0.5, dy=0.1)
    vb = unit(P(-np.sin(ph), np.cos(ph))) * 1.5; f.arrow(B, B + vb, c=V, lw=1.6); f.text(B + vb, r"$\mathbfit{v}_B$", c=V, dx=-0.3, dy=0.3)
    f.arrow(A + P(0, 0.75), A + P(-1.6, 0.75), c=V, lw=1.6); f.text(A + P(-1.6, 0.75), r"$\mathbfit{v}_A$", c=V, dx=-0.35)
    f.angle(O, 1.1, 0, 38, label=r"$\varphi$", lr=1.45, size=9)
    f.moment(O + P(0, 0), 0.0, 0, 0) if False else f.arc(O, 0.7, 60, 300, col=M, lw=1.2, arrow=True)
    f.text(O + P(-0.75, 0.75), r"$\omega$", c=M, size=9)
    f.text((7.9, 0.3), "Kurbel 1 (um $O$), Pleuel 3, Kolben 2 (geradlinig)", size=8, c=GREY)
    f.save("k03_kurbel")
kurbel()
