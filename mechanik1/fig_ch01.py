from figlib import *

def sph(f, o, r, th, ps):
    th, ps = rad(th), rad(ps)
    return f.proj(o, r * np.sin(th) * np.cos(ps), r * np.sin(th) * np.sin(ps), r * np.cos(th))

# ---------- 1.1 Lageänderung und Bahnkurve ----------
def lage():
    f = Fig(15.8, 5.2)
    # links: Lage eines Systems zu zwei Zeiten
    f.cap((2.4, 4.75), "Zeit $t_1$", size=8.5); f.cap((8.0, 4.75), "Zeit $t_2$", size=8.5)
    blob1 = [(0.6, 1.2), (1.5, 0.7), (3.0, 0.9), (3.9, 2.0), (3.3, 3.5), (1.8, 4.0), (0.7, 3.0)]
    f.poly(blob1)
    blob2 = [(6.3, 2.0), (7.5, 1.3), (9.0, 1.4), (9.8, 2.6), (9.3, 4.0), (7.6, 4.3), (6.5, 3.3)]
    f.poly(blob2)
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
    f = Fig(15.8, 5.0)
    cols = [(2.6, 1.6), (7.7, 1.6), (12.6, 1.6)]
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
    for p, t, d in [(Mx, "$M_x$", (-0.3, -0.12)), (My, "$M_y$", (0.0, -0.3)), (Mz, "$M_z$", (-0.35, 0.0)), (Mxy, "$M_{xy}$", (0.45, -0.1))]:
        f.dot(p, 0.045); f.text(p, t, dx=d[0], dy=d[1], size=8.5)
    f.text((o[0] + 0.9, 0.3), r"kartesisch  $(x,\,y,\,z)$", size=9)
    # --- zylindrisch
    o = P(*cols[1]); f.axes3(o, l=L)
    r_, ph, zc = 2.2, 38, 1.9
    Mxy = f.proj(o, r_ * np.cos(rad(ph)), r_ * np.sin(rad(ph)), 0); M_ = f.proj(o, r_ * np.cos(rad(ph)), r_ * np.sin(rad(ph)), zc)
    f.line(o, Mxy, lw=1.7); f.line(Mxy, M_, lw=1.7); f.guide(o, M_)
    arcpts = [f.proj(o, 0.95 * np.cos(rad(a)), 0.95 * np.sin(rad(a)), 0) for a in np.linspace(0, ph, 30)]
    f.path(arcpts, lw=0.8)
    f.dot(M_, 0.08); f.text(M_, "$M$", dx=0.28, dy=0.12); f.dot(Mxy, 0.045); f.text(Mxy, "$M_{xy}$", dx=0.5, dy=-0.12, size=8.5)
    f.text((o + (Mxy - o) * 0.5), r"$\rho$", dx=0.1, dy=0.3); f.text(f.proj(o, 1.35 * np.cos(rad(ph / 2)), 1.35 * np.sin(rad(ph / 2)), 0), r"$\varphi$", dy=-0.05, size=9)
    f.text((Mxy + M_) / 2, "$z$", dx=0.25)
    f.text((o[0] + 0.9, 0.3), r"zylindrisch  $(\rho,\,\varphi,\,z)$", size=9)
    # --- sphärisch
    o = P(*cols[2]); f.axes3(o, l=L)
    r_, th, ps = 2.8, 40, 38
    M_ = sph(f, o, r_, th, ps); Mxy = sph(f, o, r_, 90, ps)
    f.line(o, M_, lw=1.7); f.guide(o, Mxy); f.guide(Mxy, M_)
    f.path([sph(f, o, 1.2, a, ps) for a in np.linspace(0, th, 30)], lw=0.8)
    f.path([sph(f, o, 0.95, 90, a) for a in np.linspace(0, ps, 30)], lw=0.8)
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

# ---------- 1.5 Beispiele: Ellipse und Schraubenlinie ----------
def beispiele():
    f = Fig(15.8, 5.0)
    # Ellipse in schiefer Ebene
    o = P(3.2, 1.6); f.axes3(o, l=2.5)
    ts = np.linspace(0, 1, 90)
    pts = [f.proj(o, 1.0 * np.cos(3 * np.pi * t) * 3 / 5 * 1.4, 1.0 * np.cos(3 * np.pi * t) * 4 / 5 * 1.4 + 0.0, 1.3 + 0.9 * np.sin(3 * np.pi * t)) for t in ts]
    f.path(pts, lw=1.4); f.dot(pts[0]); f.dot(pts[-1], c=GREY)
    f.text(pts[0], "$M(0)$", dx=0.7, dy=0.15, size=8.5); f.text(pts[-1], "$M(1)$", dx=-0.65, dy=0.0, size=8.5)
    f.cap((3.6, 0.3), "Ellipse (kartesisches Beispiel)")
    # Schraubenlinie
    o = P(11.6, 1.6); f.axes3(o, l=2.5)
    pts = [f.proj(o, (0.8 + 0.5 * t) * np.cos(5.2 * t), (0.8 + 0.5 * t) * np.sin(5.2 * t), 0.1 + 3.0 * t) for t in np.linspace(0, 1, 160)]
    f.path(pts, lw=1.4); f.dot(pts[0]); f.dot(pts[-1])
    f.text(pts[0], "Kathode", dx=-0.9, dy=-0.15, size=8); f.text(pts[-1], "Anode", dx=0.8, dy=0.15, size=8)
    f.cap((12.2, 0.3), "Schraubenlinie (zylindrisches Beispiel)")
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
    f.line(o + P(0.0, -0.18), pr + P(0, -0.18), c=F, lw=2.2)
    f.dim(o + P(0, 0), pr, "", off=0)  # unsichtbare Maßlinie vermeiden
    f.angle(o, 0.9, 0, 38, label=r"$\theta$", lr=1.25)
    f.text(o + P(b[0] / 2, -0.62), r"$|\mathbf{b}|\cos\theta$", c=F, size=9)
    f.cap((3.6, 5.0), "Skalarprodukt", size=8.5)
    f.text((3.6, 4.45), r"$\mathbf{a}\cdot\mathbf{b}=|\mathbf{a}|\,|\mathbf{b}|\cos\theta$", size=9.5)
    f.text((3.6, 0.35), "Anteil von $\\mathbf{b}$ in Richtung $\\mathbf{a}$, mal $|\\mathbf{a}|$", size=7.8, c=GREY)
    # rechts: Kreuzprodukt
    o = P(10.4, 1.6)
    a = f.proj(o, 2.4, 0, 0) - o; b = f.proj(o, 0, 3.0, 0) - o
    f.poly([o, o + a, o + a + b, o + b], fc="#e4ecf5", ec=GREY, lw=0.7)
    f.arrow(o, o + a, c=INK, lw=1.3); f.tip(o, o + a, r"$\mathbfit{a}$", dist=0.3)
    f.arrow(o, o + b, c=INK, lw=1.3); f.tip(o, o + b, r"$\mathbfit{b}$", dist=0.3)
    f.arrow(o, o + P(0, 2.8), c=V, lw=1.3); f.tip(o, o + P(0, 2.8), r"$\mathbfit{a}\times\mathbfit{b}$", c=V, dist=0.42)
    f.text(o + (a + b) * 0.55, "Fläche $= |\\mathbf{a}\\times\\mathbf{b}|$", size=7.8, c=GREY, dy=-0.15)
    f.cap((12.0, 5.0), "Kreuzprodukt", size=8.5)
    f.save("k01_produkte")
produkte()
