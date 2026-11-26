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
    f.cap((3.2, -0.15), "$v'_M = v'_N$ (gleiche Anteile längs $M N$)", size=8)
    # Stab
    ground_y, wall_x = 0.9, 9.0; L = 4.3; al = rad(40)
    A = P(wall_x + L * np.cos(al), ground_y); B = P(wall_x, ground_y + L * np.sin(al))
    f.hatch((wall_x - 0.2, ground_y), (14.9, ground_y)); f.hatch((wall_x, 5.1), (wall_x, ground_y))
    f.beam(A, B); f.hinge(A, 0.09); f.hinge(B, 0.09)
    f.arrow(A, A + P(1.5, 0), c=V, lw=1.6); f.text(A + P(1.5, 0), r"$\mathbfit{v}_A$", c=V, dx=0.1, dy=0.38)
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
    f.text(A1, "$A$", dx=-0.3, dy=0.28); f.text(A2, "$A'$", dx=0.32, dy=0.28)
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
    f.cap((13.3, 0.3), "Rotation: $|\\mathbfit{v}|=\\omega r$")
    f.save("k03_transrot")

# ---------- 3.3 Rollen ----------
def rollen():
    f = Fig(15.8, 4.8)
    R, y0 = 1.5, 0.7
    def wheel(cx):
        c = P(cx, y0 + R); f.hatch((cx - 2.2, y0), (cx + 2.2, y0)); f.circle(c, R, fc=LIGHT); f.dot(c, 0.06); return c
    # --- links: wirkliche Geschwindigkeiten = Drehung um Z (linear im Abstand von Z)
    c = wheel(3.1); Z = P(3.1, y0); w = 0.62 / R          # v_O = 0.62 cm im Bild
    for h in (0.5, 1.0, 1.5, 2.0):                        # Punkte auf dem senkrechten Durchmesser
        p = Z + P(0, h * R); f.dot(p, 0.045); f.arrow(p, p + P(w * h * R, 0), c=V, lw=1.4, hl=0.16 if h < 1 else None)
    f.line(Z, Z + P(w * 2 * R, 2 * R), c=V, lw=0.6, dash=(3, 2.5))     # lineare Verteilung
    f.line(Z, Z + P(0, 2 * R), c=GREY, lw=0.6)
    for a in (0, 180):                                    # vorderster und hinterster Punkt
        p = pol(c, R, a); r_ = p - Z; v = w * P(r_[1], -r_[0])
        f.dot(p, 0.045); f.arrow(p, p + v, c=V, lw=1.4); f.line(Z, p, c=GREY, lw=0.5, dash=(3, 3))
        f.rightangle(p, Z - p, v, a=0.16)
    f.dot(Z, 0.08, c=F); f.text(Z, "$Z$", c=F, dx=0.32, dy=0.28)
    f.text(c, r"$O$", dx=-0.3, dy=-0.2, size=9)
    f.text(c + P(w * R, 0) + P(0.25, 0.18), "$v$", c=V, size=9); f.text(Z + P(2 * w * R, 2 * R) + P(0.3, 0.05), "$2v$", c=V, size=9)
    f.cap((3.1, 0.3), "wirkliche Geschwindigkeiten: Drehung um $Z$")
    # --- Zerlegung: Translation + Drehung um O
    for cx in (8.4, 13.0):
        wheel(cx)
    c1, c2 = P(8.4, y0 + R), P(13.0, y0 + R)
    for a in (90, 180, 270, 0):
        p = pol(c1, R, a); f.arrow(p, p + P(0.93, 0), c=V, lw=1.3)
    f.arrow(c1, c1 + P(0.93, 0), c=V, lw=1.3)
    for a in (90, 180, 270, 0):
        p = pol(c2, R, a); v = P(-np.sin(rad(a)), np.cos(rad(a))) * (-0.93)
        f.arrow(p, p + v, c=V, lw=1.3)
    f.moment(c2, 0.45, 160, -140, label=None)
    f.text((10.7, y0 + R - 0.6), "$+$", size=13); f.text((5.75, y0 + R - 0.6), "$=$", size=13)
    f.cap((8.4, 4.35), "Translation mit $v_O$"); f.cap((13.0, 4.35), r"Drehung um $O$ mit $\omega = v_O/R$")
    f.save("k03_rollen")

# ---------- 3.3b Bildfolge: rollendes Rad, Zykloide ----------
def zykloide():
    f = Fig(15.8, 4.9)
    R, y0, x0 = 1.62, 0.75, 2.2; vO = 0.75              # vO: Pfeillänge der Nabengeschwindigkeit
    f.hatch((0.4, y0), (15.6, y0))
    th = np.linspace(0, 2 * np.pi, 400)
    cyc = np.column_stack([x0 + R * (th - np.sin(th)), y0 + R * (1 - np.cos(th))])
    f.path(cyc, c=INK, lw=1.3, z=3)
    labs = ["$0$", r"$\frac{1}{4}$", r"$\frac{1}{2}$", r"$\frac{3}{4}$", "$1$"]
    for k, t in enumerate(np.linspace(0, 2 * np.pi, 5)):
        c = P(x0 + R * t, y0 + R); Z = P(c[0], y0)
        p = P(c[0] - R * np.sin(t), y0 + R * (1 - np.cos(t)))
        cur = (k == 2)
        f.circle(c, R, fc="none", ec=INK if cur else GREY, lw=1.0 if cur else 0.6, z=2)
        f.line(c, p, c=INK if cur else GREY, lw=0.9 if cur else 0.6, z=2); f.dot(c, 0.045, c=INK if cur else GREY)
        f.dot(Z, 0.055, c=F)
        v = (vO / R) * P(R * (1 - np.cos(t)), R * np.sin(t))     # dP/dt beim Rollen nach rechts
        if np.linalg.norm(v) > 1e-6:
            f.line(Z, p, c=F, lw=0.5, dash=(2.5, 2)); f.arrow(p, p + v, c=V, lw=1.4, z=6)
        f.dot(p, 0.075, z=7)
        f.text((c[0], y0 - 0.38), labs[k], size=8, c=GREY)
    f.text((x0, y0 + 0.42), r"$\mathbfit{v}_P = \mathbf{0}$", size=8, c=V, dx=-0.55)
    f.text((x0 + 2 * np.pi * R, y0 + 0.42), r"$\mathbfit{v}_P = \mathbf{0}$", size=8, c=V, dx=0.6)
    f.text((x0 + np.pi * R, y0 + 2 * R + 0.4), "$2v_O$", size=8.5, c=V, dx=0.3)
    f.text((x0 - 0.55, y0 - 0.38), "Umdrehung:", size=7.5, c=GREY, ha="right")
    f.save("k03_zykloide")

# ---------- 3.4 Kinemate ----------
def kinemate():
    f = Fig(15.8, 5.2)
    f.potato((4.2, 2.4), 7.4, 4.2, ang=6, seed=7)
    B, M_ = P(2.2, 1.7), P(5.8, 2.7); BM = M_ - B
    w = 0.30                                            # omega (Bildmassstab), Gegenuhrzeigersinn
    vB = P(1.5, 0.35); rot = w * P(-BM[1], BM[0])       # omega x BM, exakt senkrecht zu BM
    f.line(B, M_, c=GREY, lw=0.8)
    f.arrow(B, B + vB, c=V, lw=1.6); f.text(B + vB, r"$\mathbfit{v}_B$", c=V, dx=0.35, dy=0.0)
    f.arrow(M_, M_ + vB, c=VL, lw=1.1, dash=(4, 3)); f.text(M_ + vB, r"$\mathbfit{v}_B$", c=VL, dx=0.32, dy=-0.22, size=8.5)
    f.arrow(M_ + vB, M_ + vB + rot, c=VL, lw=1.1, dash=(4, 3))
    f.arrow(M_, M_ + vB + rot, c=V, lw=1.8); f.text(M_ + vB + rot, r"$\mathbfit{v}_M$", c=V, dx=-0.15, dy=0.35)
    f.text(M_ + vB + rot * 0.5, r"$\boldsymbol{\omega}\times\overrightarrow{BM}$", c=V, size=8.5, dx=1.0, ha="center")
    f.arrow(M_, M_ + rot, c=VL, lw=0.8, dash=(2, 2)); f.rightangle(M_, BM, rot, a=0.2, c=GREY)
    f.dot(B); f.dot(M_); f.text(B, "$B$", dx=-0.62, dy=-0.25); f.text(M_, "$M$", dx=-0.2, dy=-0.45)
    f.moment(B, 0.45, 40, 330, label=None); f.text(B + P(-0.55, 0.8), r"$\boldsymbol{\omega}$", c=M, size=10)
    f.cap((12.1, 3.7), r"$\boldsymbol{\omega}=\mathbf{0}$: Translation", size=8.5); f.cap((12.1, 2.9), r"$\mathbfit{v}_B=\mathbf{0}$: Kreiselung um $B$", size=8.5); f.cap((12.1, 2.1), "sonst: beides überlagert", size=8.5)
    f.save("k03_kinemate")

# ---------- 3.5 Zentralachse / Schraube ----------
def schraube():
    f = Fig(15.8, 6.2)
    Z = P(5.4, 2.4); d = 2.0; w = 0.75                  # Abstand d_Z, omega im Bildmassstab
    vw = 1.25                                            # v_omega (Achsrichtung y)
    f.axes3(P(1.0, 0.7), l=1.3)
    Y = lambda y: f.proj(Z, 0, y, 0)
    f.line(Y(-3.8), Y(3.9), c=GREY, lw=0.8, dash=(7, 3, 1.5, 3))
    f.text(Y(-3.8), r"Zentralachse $\zeta$", dx=0.55, dy=-0.4, size=8.5, c=GREY)
    f.arrow(Y(-3.4), Y(-1.8), c=M, lw=1.8); f.text(Y(-2.6), r"$\boldsymbol{\omega}$", c=M, dy=0.6, size=10)
    ring = np.array([f.proj(Z, 0.45 * np.sin(a), -2.6, 0.45 * np.cos(a)) for a in np.linspace(rad(-120), rad(150), 80)])
    f.path(ring[:-5], c=M, lw=1.0, z=6); f.head(ring[-1], ring[-1] - ring[-6], c=M, hl=0.18, z=6)
    for h in (-0.5, 0.0, 0.5, 1.0):
        p = f.proj(Z, 0, 0, h * d); vp = f.proj(p, w * h * d, vw, 0) - p
        f.dot(p, 0.06 if h != 0 else 0.075)
        f.arrow(p, p + vp, c=V, lw=1.9 if h in (0.0, 1.0) else 1.2)
    f.line(f.proj(Z, 0, 0, -0.75 * d), f.proj(Z, 0, 0, 1.2 * d), c=GREY, lw=0.6, dash=(4, 3))
    Bp = f.proj(Z, 0, 0, d)
    vo = f.proj(Bp, 0, vw, 0) - Bp; vp = f.proj(Bp, w * d, 0, 0) - Bp
    f.arrow(Bp, Bp + vo, c=VL, lw=1.1, dash=(4, 3)); f.arrow(Bp, Bp + vp, c=VL, lw=1.1, dash=(4, 3))
    f.text(Bp + vo, r"$\mathbfit{v}_\omega$", c=V, dx=0.32, dy=0.18, size=8.5)
    f.text(Bp + vp, r"$(\mathbfit{v}_B)_\perp$", c=V, dx=-0.62, dy=-0.05, size=8.5)
    f.text(Bp + vo + vp, r"$\mathbfit{v}_B$", c=V, dx=0.32, dy=-0.12, size=9.5)
    f.text(Bp, "$B$", dx=-0.3, dy=0.28); f.text(Z, "$Z$", dx=-0.32, dy=-0.3)
    f.text(Z + f.proj(Z, 0, vw, 0) - Z, r"$\mathbfit{v}_Z=\mathbfit{v}_\omega$", c=V, dx=0.95, dy=-0.25, size=9)
    f.text(f.proj(Z, 0, 0, 0.25 * d), r"$d_Z$", dx=-0.38, dy=0.0, size=9)
    xt = 10.6
    for i, t in enumerate([r"Geschwindigkeiten auf der Senkrechten",
                           r"zu $\zeta$ durch $Z$: Längs $\zeta$ haben alle",
                           r"denselben Anteil $\mathbfit{v}_\omega$, der Queranteil",
                           r"wächst linear mit dem Abstand von $\zeta$.",
                           r"Abstand: $d_Z = |(\mathbfit{v}_B)_\perp|\,/\,\omega$"]):
        f.text((xt, 1.9 - 0.44 * i), t, size=8.2, ha="left")
    f.save("k03_schraube")

# ---------- 3.6 Momentanzentrum ----------
def momentanzentrum():
    f = Fig(15.8, 5.4)
    f.potato((2.95, 2.2), 5.4, 3.7, ang=-6, seed=2)
    Z = P(2.3, 3.6); w = 0.62                                  # Gegenuhrzeigersinn
    Pp, Qp = P(1.5, 1.55), P(4.55, 2.55)
    vel = lambda p: w * P(-(p - Z)[1], (p - Z)[0])
    for p in (Pp, Qp):
        n = unit(p - Z); f.line(p + n * 0.6, Z - n * 0.45, c=F, lw=0.8, dash=(5, 3))
        f.arrow(p, p + vel(p), c=V, lw=1.6); f.rightangle(p, Z - p, vel(p), a=0.17)
    f.dot(Pp); f.dot(Qp); f.dot(Z, 0.08, c=F)
    f.text(Pp, "$P$", dx=-0.3, dy=-0.2); f.text(Qp, "$Q$", dx=-0.32, dy=-0.22)
    f.text(Pp + vel(Pp), r"$\mathbfit{v}_P$", c=V, dx=0.35, dy=-0.1); f.text(Qp + vel(Qp), r"$\mathbfit{v}_Q$", c=V, dx=0.4, dy=0.1)
    f.text(Z, "$Z$", c=F, dx=-0.75, dy=0.45)
    f.arc(Z, 0.55, 200, 480, col=M, lw=1.2, arrow=True)
    f.cap((3.0, 0.3), r"Senkrechten zu $\mathbfit{v}_P$, $\mathbfit{v}_Q$ schneiden sich in $Z$", size=8)
    gy, wx = 0.9, 9.0; L = 4.2; al = rad(50)
    A = P(wx + L * np.cos(al), gy); B = P(wx, gy + L * np.sin(al)); Zs = P(A[0], B[1])
    f.hatch((wx - 0.2, gy), (15.0, gy)); f.hatch((wx, 5.1), (wx, gy))
    f.line(A, Zs, c=F, lw=0.8, dash=(5, 3)); f.line(B, Zs, c=F, lw=0.8, dash=(5, 3))
    f.beam(A, B); f.hinge(A, 0.09); f.hinge(B, 0.09); f.dot(Zs, 0.08, c=F)
    f.arrow(A, A + P(1.4, 0), c=V, lw=1.6); f.arrow(B, B + P(0, -1.4 / np.tan(al)), c=V, lw=1.6)
    f.text(A, "$A$", dx=0.3, dy=0.32); f.text(B, "$B$", dx=0.35, dy=0.2); f.text(Zs, "$Z$", c=F, dx=0.75, dy=0.45)
    f.arc(Zs, 0.5, 200, 500, col=M, lw=1.2, arrow=True)
    f.cap((12.0, 0.3), "Stab: $Z$ ist die vierte Ecke des Rechtecks", size=8)
    f.save("k03_momentanzentrum")

# ---------- 3.7 Polbahnen ----------
def polbahnen():
    f = Fig(7.6, 5.9)
    O = P(1.3, 0.8); L = 4.4
    f.hatch((O[0] - 0.2, O[1]), (O[0] + 5.6, O[1])); f.hatch((O[0], O[1] + 5.0), (O[0], O[1]))
    f.arc(O, L, 0, 90, col=GREY, lw=1.6)
    t = 1 / 3                                                     # Stabpunkt C: Abstand t*L von B
    ell = np.array([O + P(t * L * np.cos(a), (1 - t) * L * np.sin(a)) for a in np.linspace(0, np.pi / 2, 120)])
    f.path(ell, c=NEU, lw=0.8, dash=(4, 2.5), z=2)
    for al_, cur in ((22, False), (45, True), (68, False)):
        al = rad(al_); A = O + P(L * np.cos(al), 0); B = O + P(0, L * np.sin(al))
        Zp = P(A[0], B[1]); cc = (A + B) / 2; C = B + t * (A - B)
        if cur: f.circle(cc, L / 2, fc="none", ec=V, lw=1.3, z=2)
        else:
            a0 = np.rad2deg(np.arctan2(*(A - cc)[::-1])); f.arc(cc, L / 2, a0, a0 + 180, col=VL, lw=0.8, z=2)
        f.beam(A, B, lw=2.8 if cur else 1.6, c=INK if cur else GREY)
        f.hinge(A, 0.08 if cur else 0.06); f.hinge(B, 0.08 if cur else 0.06)
        f.dot(Zp, 0.08 if cur else 0.06, c=F); f.dot(C, 0.055, c=NEU, z=8)
        if cur:
            f.line(A, Zp, c=F, lw=0.6, dash=(3, 2.5)); f.line(B, Zp, c=F, lw=0.6, dash=(3, 2.5))
            f.text(Zp, "$Z$", c=F, dx=0.32, dy=0.3); f.text(A, "$A$", dx=0.28, dy=-0.32); f.text(B, "$B$", dx=-0.32, dy=0.0)
            f.text(C, "$C$", dx=0.25, dy=0.2, size=8.5, c=NEU)
    f.text(O, "$O$", dx=-0.3, dy=-0.3)
    f.text(pol(O, L, 80), "feste Polbahn", c=GREY, size=8.2, dx=0.35, dy=0.3, ha="left")
    f.save("k03_polbahnen")

# ---------- 3.8 Planetengetriebe ----------
def planet():
    f = Fig(15.8, 6.4)
    O = P(4.2, 3.2); R1, R2 = 1.3, 3.0; R3 = (R2 - R1) / 2; Lc = (R1 + R2) / 2
    f.circle(O, R2 + 0.5, fc=MID); f.circle(O, R2, fc="white"); f.circle(O, R1, fc=LIGHT)
    O3 = O + P(Lc, 0); f.circle(O3, R3, fc=LIGHT, z=3)
    f.beam(O, O3, lw=2.2); f.dot(O, 0.07); f.dot(O3, 0.07, z=7)
    Pp = O + P(R1, 0); Qp = O3 + P(R3, 0)
    f.text(O, "$O$", dx=-0.25, dy=-0.35); f.text(O3, "$O'$", dx=0.05, dy=-0.38, size=8.5)
    f.dot(Pp, 0.07, c=F); f.dot(Qp, 0.07, c=F)
    f.text(Pp, "$P$", dx=-0.25, dy=-0.38, size=9); f.text(Qp, "$Q$", dx=0.3, dy=-0.32, size=9)
    vP, vQ = 1.0, 1.75; vM = (vP + vQ) / 2
    f.arrow(Pp, Pp + P(0, vP), c=V, lw=1.5, z=8); f.arrow(Qp, Qp + P(0, vQ), c=V, lw=1.5, z=8)
    f.arrow(O3, O3 + P(0, vM), c=V, lw=1.5, z=8)
    f.line(Pp + P(0, vP), Qp + P(0, vQ), c=V, lw=0.7, dash=(3, 2.5), z=8)
    f.text(Pp + P(0, vP), r"$R_1\omega_1$", c=V, dx=-0.55, dy=0.25, size=8.5); f.text(Qp + P(0, vQ), r"$R_2\omega_2$", c=V, dx=0.7, dy=0.15, size=8.5)
    f.text(O3 + P(0, vM), r"$v_{O'}$", c=V, dx=0.05, dy=0.32, size=8.5)
    f.arc(O, 0.5, -120, -30, col=M, lw=1.1, arrow=True); f.text(O + P(0.12, -0.78), r"$\omega$", c=M, size=9)
    f.text(O + P(-0.5, 0.55), "1", size=9); f.text(O + P(-2.9, 1.7), "2", size=9); f.text(O3 + P(-0.35, 0.45), "3", size=9); f.text(O + P(0.62, 0.24), "Arm", size=7.5, c=GREY)
    f.cap((9.6, 5.3), "Rad 1: Radius $R_1$, Drehung $\\omega_1$", size=8.5, ha="left"); f.cap((9.6, 4.85), "Hohlrad 2: Radius $R_2$, Drehung $\\omega_2$", size=8.5, ha="left")
    f.cap((9.6, 4.4), "Planetenrad 3: Radius $(R_2-R_1)/2$", size=8.5, ha="left"); f.cap((9.6, 3.95), "Arm: Länge $L=(R_1+R_2)/2$, Drehung $\\omega$", size=8.5, ha="left")
    f.cap((9.6, 3.2), "Rad 3 ist eben bewegt: Die Geschwindigkeiten", size=8.2, ha="left", c=NEU)
    f.cap((9.6, 2.8), "längs $PQ$ wachsen linear (gestrichelt). Die", size=8.2, ha="left", c=NEU)
    f.cap((9.6, 2.4), "Mitte $O'$ hat den Mittelwert, $v_{O'} = \\omega L$.", size=8.2, ha="left", c=NEU)
    f.save("k03_planet")

sdpg(); trans_rot(); rollen(); zykloide(); kinemate(); schraube(); momentanzentrum(); polbahnen(); planet()

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
    f.text(O, "$O$", dx=0.35, dy=-0.25); f.text(B, "$B$", dx=-0.05, dy=-0.42); f.text(A, "$A$", dx=0.75, dy=0.15); f.text(Z, "$Z_3$", c=F, dx=0.5, dy=0.1)
    vBlen = 1.5; w3 = vBlen / np.linalg.norm(Z - B); vAlen = w3 * np.linalg.norm(Z - A)   # beide aus der Drehung um Z_3
    vb = unit(P(-np.sin(ph), np.cos(ph))) * vBlen; f.arrow(B, B + vb, c=V, lw=1.6); f.text(B + vb, r"$\mathbfit{v}_B$", c=V, dx=-0.3, dy=0.3)
    top = A + P(0.25, 0.62)
    f.arrow(top, top + P(-vAlen, 0), c=V, lw=1.6); f.text(top + P(-vAlen / 2, 0), r"$\mathbfit{v}_A$", c=V, dy=0.3)
    f.rightangle(B, O - B, vb, a=0.17)
    f.angle(O, 0.75, 0, 38, label=r"$\varphi$", lr=1.02, size=9)
    f.arc(O, 0.42, 70, 290, col=M, lw=1.2, arrow=True)
    f.text(O + P(-0.6, 0.5), r"$\omega$", c=M, size=9)
    f.text((7.9, 0.3), r"Kurbel 1 (um $O$), Pleuel 3, Kolben 2 (geradlinig);  $v_A : v_B = \overline{Z_3A} : \overline{Z_3B}$", size=8, c=GREY)
    f.save("k03_kurbel")
kurbel()
