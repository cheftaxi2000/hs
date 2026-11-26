from figlib import *

def sph(f, o, r, th, ps):
    th, ps = rad(th), rad(ps)
    return f.proj(o, r * np.sin(th) * np.cos(ps), r * np.sin(th) * np.sin(ps), r * np.cos(th))

# ---------- 1.1 Lageänderung und Bahnkurve ----------
def lage():
    f = Fig(15.8, 5.2)
    # links: Lage eines Systems zu zwei Zeiten
    f.cap((2.4, 4.75), "Zeit $t_1$", size=8.5); f.cap((8.0, 4.75), "Zeit $t_2$", size=8.5)
    f.potato((2.25, 2.35), 3.5, 3.1, ang=15, seed=3)
    f.potato((8.05, 2.8), 3.7, 3.0, ang=-20, seed=3)
    f.dot((2.0, 2.4)); f.dot((8.0, 2.9))
    f.text((2.0, 2.4), "$M(t_1)$", dx=0.1, dy=-0.5, size=9); f.text((8.0, 2.9), "$M(t_2)$", dx=0.1, dy=-0.5, size=9)
    f.text((2.5, 3.5), "$S(t_1)$", size=9); f.text((8.7, 3.6), "$S(t_2)$", size=9)
    f.arrow((4.3, 2.65), (5.9, 2.8), c=GREY, lw=0.8)
    # rechts: Bahnkurve
    o = P(12.9, 1.5)
    f.axes3(o, l=2.4)
    t = np.linspace(0, 1, 80)
    pts = [f.proj(o, 1.3 + 0.9 * np.sin(2.4 * u), 0.3 + 2.1 * u, 1.0 + 1.5 * np.sin(3.1 * u + 0.5) * 0.7 + 0.8 * u) for u in t]
    f.path(pts, lw=1.3)
    f.dot(pts[8]); f.dot(pts[60])
    f.text(pts[8], "$M(t_1)$", dx=-0.75, dy=0.15, size=9); f.text(pts[60], "$M(t_2)$", dx=0.2, dy=0.5, size=9)
    f.text(pts[70], "Bahnkurve $C$", dx=-0.3, dy=-0.5, size=8, ha="center")
    f.save("k01_lage")

# ---------- 1.2 Die drei Koordinatensätze ----------
def koordinaten():
    f = Fig(15.8, 5.2)
    cols = [(2.6, 1.8), (7.7, 1.8), (12.6, 1.8)]
    L = 2.7
    pts = []
    # --- kartesisch
    o = P(*cols[0]); f.axes3(o, l=L)
    xx, yy, zz = 1.7, 2.1, 1.9
    Mx, My, Mz = f.proj(o, xx, 0, 0), f.proj(o, 0, yy, 0), f.proj(o, 0, 0, zz)
    Mxy, M_ = f.proj(o, xx, yy, 0), f.proj(o, xx, yy, zz)
    for a, b in [(Mx, Mxy), (My, Mxy), (Mxy, M_), (Mz, M_)]: f.guide(a, b)
    f.line(o, Mx, lw=1.7); f.line(Mx, Mxy, lw=1.7); f.line(Mxy, M_, lw=1.7)
    f.dot(M_, 0.08); f.text(M_, "$M$", dx=0.28, dy=0.12)
    for p, t, d in [(Mx, "$M_x$", (-0.5, 0.15)), (My, "$M_y$", (0.0, -0.3)), (Mz, "$M_z$", (-0.35, 0.0)), (Mxy, "$M_{xy}$", (0.45, -0.1))]:
        f.dot(p, 0.045); f.text(p, t, dx=d[0], dy=d[1], size=8.5)
    f.text((o[0] + 0.9, 0.3), r"kartesisch  $(x,\,y,\,z)$", size=9)
    # --- zylindrisch
    o = P(*cols[1]); f.axes3(o, l=L)
    r_, ph, zc = 2.2, 38, 1.9
    Mxy = f.proj(o, r_ * np.cos(rad(ph)), r_ * np.sin(rad(ph)), 0); M_ = f.proj(o, r_ * np.cos(rad(ph)), r_ * np.sin(rad(ph)), zc)
    f.line(o, Mxy, lw=1.7); f.line(Mxy, M_, lw=1.7); f.guide(o, M_)
    arcpts = [f.proj(o, 0.95 * np.cos(rad(a)), 0.95 * np.sin(rad(a)), 0) for a in np.linspace(0, ph, 30)]
    f.path(arcpts, lw=0.8)
    # Koordinatenlinie phi (Kreis um die z-Achse durch M) und Zylinder rho = konst. (hell)
    f.path(f.circle3(o, (0, 0, zc), r_), c=MID, lw=0.7, dash=(3, 2.5), z=1)
    f.dot(M_, 0.08); f.text(M_, "$M$", dx=0.28, dy=0.12); f.dot(Mxy, 0.045); f.text(Mxy, "$M_{xy}$", dx=0.5, dy=-0.12, size=8.5)
    f.text((o + (Mxy - o) * 0.62), r"$\rho$", dx=0.13, dy=0.24); f.text(f.proj(o, 1.35 * np.cos(rad(ph / 2)), 1.35 * np.sin(rad(ph / 2)), 0), r"$\varphi$", dy=-0.05, size=9)
    f.rightangle(Mxy, o - Mxy, M_ - Mxy, a=0.17)
    f.text((Mxy + M_) / 2, "$z$", dx=0.25)
    f.text((o[0] + 0.9, 0.3), r"zylindrisch  $(\rho,\,\varphi,\,z)$", size=9)
    # --- sphärisch
    o = P(*cols[2]); f.axes3(o, l=L)
    r_, th, ps = 2.8, 40, 38
    M_ = sph(f, o, r_, th, ps); Mxy = sph(f, o, r_, 90, ps)
    f.line(o, M_, lw=1.7); f.guide(o, Mxy); f.guide(Mxy, M_)
    f.path([sph(f, o, 1.2, a, ps) for a in np.linspace(0, th, 30)], lw=0.8)
    f.path([sph(f, o, 0.95, 90, a) for a in np.linspace(0, ps, 30)], lw=0.8)
    # Koordinatenlinien durch M: Breitenkreis (psi-Linie) und Meridian (theta-Linie), hell
    f.path([sph(f, o, r_, th, a) for a in np.linspace(0, 360, 200)], c=MID, lw=0.7, dash=(3, 2.5), z=1)
    f.path([sph(f, o, r_, a, ps) for a in np.linspace(0, 90, 80)], c=MID, lw=0.7, z=1)
    f.dot(M_, 0.08); f.text(M_, "$M$", dx=0.28, dy=0.12); f.dot(Mxy, 0.045); f.text(Mxy, "$M_{xy}$", dx=0.5, dy=-0.12, size=8.5)
    f.text((o + M_) / 2, "$r$", dx=0.28, dy=-0.05)
    f.text(sph(f, o, 1.75, th / 2 - 8, ps), r"$\theta$", dx=-0.28, dy=0.0, size=9)
    f.text(sph(f, o, 1.3, 90, ps / 2), r"$\psi$", dy=-0.28, size=9)
    f.text((o[0] + 0.9, 0.3), r"sphärisch  $(r,\,\theta,\,\psi)$", size=9)
    f.save("k01_koordinaten")

# ---------- 1.3 Koordinatenlinien: Zylinderkoordinaten ----------
def linien():
    f = Fig(15.8, 5.0)
    # links: Draufsicht auf die xy-Ebene mit Polarkoordinatenlinien
    o = P(2.6, 2.5)
    for r in (0.8, 1.6, 2.4): f.circle(o, r, fc="none", ec=MID, lw=0.7)
    for a in range(0, 360, 30): f.line(o, pol(o, 2.4, a), c=MID, lw=0.7)
    f.axes2(o, 3.0, 2.8, "x", "y", neg=0)
    M_ = pol(o, 1.6, 40); f.circle(o, 1.6, fc="none", ec=INK, lw=1.4, z=3)
    f.line(o, pol(o, 2.4, 40), lw=1.4, z=3)
    f.dot(M_, 0.08)
    f.arrow(M_, M_ + 0.95 * unit(M_ - o), c=INK, lw=1.2, label=r"$\mathbfit{e}_\rho$", off=(0.3, -0.05))
    f.arrow(M_, M_ + 0.95 * nrm(M_ - o), c=INK, lw=1.2, label=r"$\mathbfit{e}_\varphi$", off=(-0.35, 0.1))
    f.text(o + P(0.3, -0.55), "Blick von oben", size=7.8, c=GREY, ha="left")
    f.cap((2.6, -0.15), "Koordinatenlinien (zylindrisch)", va="top")
    # rechts: kartesische Basis in drei Punkten vs. zylindrische Basis
    o2 = P(9.0, 1.2)
    f.cap((12.6, 4.55), "kartesische Basis: überall gleich", size=8)
    f.cap((12.6, 4.15), "zylindrische Basis: dreht mit dem Punkt", size=8)
    f.save("k01_linien")

# ---------- 1.4 Basisvektoren in Polarkoordinaten (Draufsicht) ----------
def basis():
    f = Fig(15.8, 5.2)
    o = P(1.6, 0.9)
    f.arrow(o - P(0.2, 0), o + P(4.8, 0), lw=0.7, head=0.6); f.arrow(o - P(0, 0.2), o + P(0, 4.0), lw=0.7, head=0.6)
    f.text(o + P(5.05, 0), "$x$"); f.text(o + P(0, 4.25), "$y$")
    f.arc(o, 3.3, 0, 90, col=GREY, lw=0.6, dash=(4, 3))
    for a in (22, 64):
        M_ = pol(o, 3.3, a); f.line(o, M_, c=GREY, lw=0.6, dash=(4, 3)); f.dot(M_, 0.07)
        f.arrow(M_, M_ + 0.95 * unit(M_ - o), c=INK, lw=1.2); f.tip(M_, M_ + 0.95 * unit(M_ - o), r"$\mathbfit{e}_\rho$", dist=0.32)
        f.arrow(M_, M_ + 0.95 * nrm(M_ - o), c=INK, lw=1.2); f.tip(M_, M_ + 0.95 * nrm(M_ - o), r"$\mathbfit{e}_\varphi$", dist=0.34)
    f.angle(o, 1.1, 0, 22, label=r"$\varphi$", lr=1.45)
    f.cap((4.0, 0.2), "zylindrische Basis")
    o2 = P(9.8, 0.9)
    f.arrow(o2 - P(0.2, 0), o2 + P(4.8, 0), lw=0.7, head=0.6); f.arrow(o2 - P(0, 0.2), o2 + P(0, 4.0), lw=0.7, head=0.6)
    f.text(o2 + P(5.05, 0), "$x$"); f.text(o2 + P(0, 4.25), "$y$")
    for i, q in enumerate([(1.0, 1.0), (3.2, 0.9), (1.9, 2.7), (3.9, 3.0)]):
        M_ = o2 + P(*q); f.dot(M_, 0.07)
        f.arrow(M_, M_ + P(0.95, 0), c=INK, lw=1.2); f.arrow(M_, M_ + P(0, 0.95), c=INK, lw=1.2)
        if i == 0:
            f.tip(M_, M_ + P(0.95, 0), r"$\mathbfit{e}_x$", dist=0.34); f.tip(M_, M_ + P(0, 0.95), r"$\mathbfit{e}_y$", dist=0.3)
    f.cap((12.2, 0.2), "kartesische Basis")
    f.save("k01_basis")

# ---------- 1.5 Beispiele: Ellipse und Schraubenlinie (massstäblich) ----------
def beispiele():
    f = Fig(15.8, 5.6)
    # --- links: Stabspitze x = 3cos(3πt), y = 4cos(3πt), z = sin(3πt) [cm], Massstab k
    o = P(3.6, 2.6); k = 0.5
    u = np.array([3, 4, 0]) / 5.0                     # horizontale Richtung der Bahnebene
    def Q(uu, zz): return f.proj(o, *(k * (uu * u + np.array([0, 0, zz]))))
    # Bahnebene y = 4x/3 (senkrecht, enthält die z-Achse) als helle Fläche
    f.poly([Q(-6.2, -1.9), Q(6.2, -1.9), Q(6.2, 2.6), Q(-6.2, 2.6)], fc="#f4f4f4", ec=MID, lw=0.6, z=0)
    f.axes3(o, l=2.6)
    f.line(Q(-6.2, 0), Q(6.2, 0), c=GREY, lw=0.6, dash=(4, 3), z=1)
    ts = np.linspace(0, 1, 300)
    pts = np.array([Q(5 * np.cos(3 * np.pi * t), np.sin(3 * np.pi * t)) for t in ts])
    f.path(pts, lw=1.5, z=4)
    M0, M1 = Q(5, 0), Q(-5, 0)
    f.dot(M0, 0.075); f.dot(M1, 0.075, c=GREY)
    f.text(M0, "$M(0)$", dx=0.45, dy=-0.32, size=8.5); f.text(M1, "$M(1)$", dx=-0.55, dy=0.3, size=8.5)
    f.arrow(M0, M0 + P(0, 0.62), c=V, lw=1.2); f.text(M0 + P(0, 0.62), r"$\mathbfit{v}(0)$", c=V, dx=0.1, dy=0.28, size=8.5)
    # Halbachsen
    top = Q(0, 1); f.line(top + P(-0.12, 0), top + P(0.12, 0), c=NEU, lw=0.8, z=6)
    f.text(o + P(0.36, k * 0.5), "1 cm", size=7.3, c=NEU)
    f.text(o + (M0 - o) * 0.6, "5 cm", dy=0.2, size=7.3, c=NEU)
    f.text(Q(-6.0, 2.35), r"Bahnebene $y = \frac{4}{3}x$", size=7.6, c=GREY, ha="left", dy=-0.05)
    f.cap((3.6, -0.05), "Stabspitze: Ellipse in einer senkrechten Ebene")
    # --- rechts: Elektron rho = R1 + a t, phi = b t, z = a t (zwischen Kathode und Anode)
    o = P(11.9, 1.45); R1, R2 = 0.65, 2.05; H = R2 - R1
    for R, lab in ((R1, "Kathode"), (R2, "Anode")):
        for zz, ls in ((0, (3, 2.5)), (H + 0.55, None)):
            c3 = f.circle3(o, (0, 0, zz), R)
            f.path(c3, c=GREY if R == R2 else NEU, lw=0.6, dash=ls, z=1)
        xs = f.circle3(o, (0, 0, 0), R, n=721)
        i0, i1 = np.argmin(xs[:, 0]), np.argmax(xs[:, 0])
        for i in (i0, i1): f.line(xs[i], xs[i] + P(0, H + 0.55), c=GREY if R == R2 else NEU, lw=0.6, z=1)
    f.axes3(o, l=2.9)
    turns = 1.15; tt = np.linspace(0, 1, 400)
    sp = np.array([f.proj(o, (R1 + H * t) * np.cos(2 * np.pi * turns * t), (R1 + H * t) * np.sin(2 * np.pi * turns * t), H * t) for t in tt])
    f.path(sp, lw=1.6, z=5)
    f.dot(sp[0], 0.075); f.dot(sp[-1], 0.075)
    f.text(sp[0], "Start ($t=0$)", dx=-1.2, dy=0.1, size=7.8); f.text(sp[-1], "Ziel ($t_2$)", dx=0.15, dy=0.32, size=7.8)
    f.text(f.proj(o, 0, 0, H + 0.55) + P(-0.95, 0.75), "Kathode $R_1$", size=7.6, c=NEU)
    f.text(f.proj(o, 0, R2, H + 0.55), "Anode $R_2$", size=7.6, c=GREY, dx=0.45, dy=0.3)
    f.cap((12.2, -0.05), r"Elektron: Schraubenlinie auf dem Kegel $\rho = R_1 + z$")
    f.save("k01_beispiele")

lage(); koordinaten(); basis(); beispiele()

# ---------- 1.6 Skalarprodukt und Kreuzprodukt ----------
def produkte():
    f = Fig(15.8, 5.4)
    # links: Skalarprodukt
    o = P(1.2, 1.2)
    a = P(4.2, 0.0); b = 3.2 * np.array([np.cos(rad(38)), np.sin(rad(38))])
    f.arrow(o, o + a, c=INK, lw=1.3); f.tip(o, o + a, r"$\mathbfit{a}$", dist=0.3)
    f.arrow(o, o + b, c=INK, lw=1.3); f.tip(o, o + b, r"$\mathbfit{b}$", dist=0.3)
    pr = o + P(b[0], 0); f.guide(o + b, pr)
    f.line(o + P(0.0, -0.18), pr + P(0, -0.18), c=NEU, lw=2.2)
    f.dim(o + P(0, 0), pr, "", off=0)  # unsichtbare Masslinie vermeiden
    f.angle(o, 0.9, 0, 38, label=r"$\theta$", lr=1.25)
    f.text(o + P(b[0] / 2, -0.5), r"$|\mathbfit{b}|\cos\theta$", c=NEU, size=9)
    f.cap((3.6, 5.0), "Skalarprodukt", size=8.5)
    f.text((3.6, 4.45), r"$\mathbfit{a}\cdot\mathbfit{b}=|\mathbfit{a}|\,|\mathbfit{b}|\cos\theta$", size=9.5)
    f.text((3.6, -0.02), "Anteil von $\\mathbfit{b}$ in Richtung $\\mathbfit{a}$, mal $|\\mathbfit{a}|$", size=7.8, c=GREY)
    # rechts: Kreuzprodukt
    o = P(10.4, 1.6)
    a = f.proj(o, 2.4, 0, 0) - o; b = f.proj(o, 0, 3.0, 0) - o
    f.poly([o, o + a, o + a + b, o + b], fc="#ececec", ec=GREY, lw=0.7)
    f.arrow(o, o + a, c=INK, lw=1.3); f.tip(o, o + a, r"$\mathbfit{a}$", dist=0.3)
    f.arrow(o, o + b, c=INK, lw=1.3); f.tip(o, o + b, r"$\mathbfit{b}$", dist=0.3)
    f.arrow(o, o + P(0, 2.8), c=INK, lw=1.6); f.tip(o, o + P(0, 2.8), r"$\mathbfit{a}\times\mathbfit{b}$", c=INK, dist=0.42)
    f.rightangle(o, a, P(0, 1), a=0.2); f.rightangle(o, b, P(0, 1), a=0.2)
    f.text(o + (a + b) * 0.5 + P(0.55, -0.05), "Fläche $= |\\mathbfit{a}\\times\\mathbfit{b}|$", size=7.8, c=NEU)
    f.cap((12.0, 5.0), "Kreuzprodukt", size=8.5)
    f.save("k01_produkte")
produkte()
