from figlib import *

# ---------- 6.1 Verschiebungssatz ----------
def verschieben():
    f = Fig(15.8, 4.2)
    O = P(2.0, 3.5); d = unit(P(1.0, 0.1)); A1 = P(3.6, 1.5); A2 = A1 + d * 3.8
    f.line(A1 - d * 2.4, A2 + d * 4.2, c=GREY, lw=0.7, dash=(5, 3))
    f.arrow(A1, A1 + d * 2.3, c=F, lw=1.6); f.arrow(A2, A2 + d * 2.3, c=F, lw=1.6)
    f.dot(O); f.text(O, "$O$", dx=-0.3, dy=0.25)
    foot = A1 + d * ((O - A1) @ d)
    f.line(O, foot, c=M, lw=1.5); f.text((O + foot) / 2, "$a$", c=M, dx=-0.3, dy=0.0, size=9.5)
    f.dot(A1); f.dot(A2); f.text(A1, "$A$", dx=0.0, dy=-0.45); f.text(A2, "$A'$", dx=0.0, dy=-0.45)
    f.text(A1 + d * 2.3, r"$\mathbfit{F}$", c=F, dx=0.1, dy=0.4); f.text(A2 + d * 2.3, r"$\mathbfit{F}$", c=F, dx=0.1, dy=0.4)
    f.cap((12.0, 3.2), "gleiches Moment $\\mathbf{M}_O$", size=9); f.cap((12.0, 2.6), "(gleicher Hebelarm $a$)", size=8.5)
    f.save("k06_verschieben")

# ---------- 6.2 Hebelgesetz und Kräftepaar ----------
def paare():
    f = Fig(15.8, 5.5)
    y = 2.1
    f.beam((0.8, y), (7.2, y), c=GREY, lw=2.0)
    x1, x2 = 1.4, 6.6; F1, F2 = 1.7, 1.0
    xs = (x1 * F1 + x2 * F2) / (F1 + F2)
    f.arrow((x1, y + 1.7), (x1, y + 0.05), c=F, lw=1.6); f.text((x1, y + 1.7), r"$\mathbfit{F}_1$", c=F, dx=0.35, dy=0.15)
    f.arrow((x2, y + 1.0), (x2, y + 0.05), c=F, lw=1.6); f.text((x2, y + 1.0), r"$\mathbfit{F}_2$", c=F, dx=0.35, dy=0.15)
    f.arrow((xs, y + 2.7), (xs, y - 0.4 + 0.0), c=F, lw=1.0, dash=(5, 3))
    f.arrow((xs, y - 0.1), (xs, y - 1.5), c=F, lw=0) if False else None
    f.arrow((xs, y + 2.7), (xs, y + 0.9), c=F, lw=1.9); f.text((xs, y + 2.7), r"$\mathbfit{R}$", c=F, dx=0.35, dy=0.1)
    f.dim((x1, y), (xs, y), "$a_1$", off=-0.55); f.dim((xs, y), (x2, y), "$a_2$", off=-0.55)
    f.cap((4.0, 0.35), "$a_1 F_1 = a_2 F_2$", size=9.5)
    # Kräftepaar
    f.potato((12.1, 2.5), 5.6, 3.2, ang=3, seed=4)
    f.arrow((10.4, 1.7), (10.4, 3.5), c=F, lw=1.6); f.text((10.4, 3.5), r"$\mathbfit{F}$", c=F, dx=0.35, dy=-0.1)
    f.arrow((13.8, 3.5), (13.8, 1.7), c=F, lw=1.6); f.text((13.8, 1.7), r"$-\mathbfit{F}$", c=F, dx=-0.5, dy=0.1)
    f.dim((10.4, 1.4), (13.8, 1.4), "$b$", off=0.0)
    f.moment(P(12.1, 2.6), 0.55, 160, -140, col=M); f.text((12.1, 2.6), "$M$", c=M, size=10)
    f.cap((12.1, 0.35), "Kräftepaar: $M = b\\,F$", size=9.5)
    f.save("k06_paare")

# ---------- 6.3 Kraft parallel verschieben ----------
def parallel():
    f = Fig(15.8, 3.9)
    for x0 in (0.5, 5.3, 10.3):
        f.potato((x0 + 1.8, 1.8), 3.9, 2.0, ang=0, seed=8)
    # links
    f.dot((1.3, 1.8)); f.text((1.3, 1.8), "$B$", dx=-0.25, dy=0.35, size=9); f.dot((3.3, 1.8)); f.text((3.3, 1.8), "$A$", dx=0.2, dy=0.4, size=9)
    f.arrow((3.3, 0.3), (3.3, 1.75), c=F, lw=1.6); f.text((3.3, 0.3), r"$\mathbfit{F}$", c=F, dx=0.4, dy=0.0)
    f.text((4.6, 1.8), "$=$", size=14)
    # Mitte
    f.dot((6.1, 1.8)); f.dot((8.1, 1.8))
    f.arrow((8.1, 0.3), (8.1, 1.75), c=F, lw=1.6); f.arrow((6.1, 0.3), (6.1, 1.75), c=F, lw=1.6); f.arrow((6.1, 3.3), (6.1, 1.85), c=F, lw=1.6, dash=(4, 2))
    f.text((8.1, 0.3), r"$\mathbfit{F}$", c=F, dx=0.4); f.text((6.1, 0.3), r"$\mathbfit{F}$", c=F, dx=0.4); f.text((6.1, 3.3), r"$-\mathbfit{F}$", c=F, dx=0.55, dy=0.0)
    f.text((9.6, 1.8), "$=$", size=14)
    # rechts
    f.dot((11.1, 1.8)); f.arrow((11.1, 0.3), (11.1, 1.75), c=F, lw=1.6); f.text((11.1, 0.3), r"$\mathbfit{F}$", c=F, dx=0.4)
    f.moment(P(13.0, 1.8), 0.5, 160, -140, col=M); f.text((13.0, 1.8), "$M$", c=M, size=9)
    f.dim((1.3, 3.0), (3.3, 3.0), "$d$", off=0.0 + 0.0)
    f.text((12.8, 3.2), r"$M = d\,F$", size=9)
    f.save("k06_parallel")

# ---------- 6.4 Reduktion: Schraube einer Kräftegruppe ----------
def dyname():
    f = Fig(15.8, 4.6)
    for k, (x0, lab) in enumerate([(0.0, "Kräftegruppe"), (5.4, "Dyname in $B$"), (10.4, "Schraube auf Zentralachse")]):
        pass
    f.potato((2.6, 2.2), 4.2, 3.2, ang=10, seed=6)
    for p, v in [((1.4, 1.7), (0.0, 1.2)), ((2.8, 1.2), (0.4, 1.0)), ((3.4, 3.1), (0.0, -1.0)), ((2.0, 3.0), (0.9, 0.5))]:
        f.dot(p, 0.05); f.arrow(p, P(*p) + P(*v), c=F, lw=1.2)
    f.cap((2.6, 0.2), "beliebige Kräftegruppe", size=8.5)
    f.text((5.5, 2.2), r"$\Rightarrow$", size=15)
    f.potato((8.6, 2.2), 4.2, 3.2, ang=10, seed=6)
    B = P(8.2, 2.1); f.dot(B, 0.06); f.text(B, "$B$", dx=-0.3, dy=-0.3)
    f.arrow(B, B + P(0.9, 1.3), c=F, lw=1.8); f.text(B + P(0.9, 1.3), r"$\mathbfit{R}$", c=F, dx=-0.3, dy=0.05)
    f.moment(B, 0.55, 20, 300, col=M); f.text(B + P(-0.6, 0.9), r"$\mathbfit{M}_B$", c=M, size=9)
    f.cap((8.6, 0.2), "Dyname ${\\mathbf{R},\\mathbf{M}_B}$", size=8.5)
    f.text((11.2, 2.2), r"$\Rightarrow$", size=15)
    Z = P(13.4, 2.0); u = unit(P(0.7, 1.0))
    f.line(Z - u * 1.7, Z + u * 2.0, c=GREY, lw=0.8, dash=(7, 3, 1.5, 3))
    f.arrow(Z - u * 0.0, Z + u * 1.5, c=F, lw=1.8); f.text(Z + u * 1.5, r"$\mathbfit{R}$", c=F, dx=0.3, dy=0.1)
    f.arc(Z + u * 0.5, 0.5, 20, 330, col=M, lw=1.3, arrow=True)
    f.cap((13.4, 0.2), "Schraube", size=8.5)
    f.save("k06_dyname")
verschieben(); paare(); parallel(); dyname()

# ===== Kapitel 7 =====
def baleken():
    f = Fig(15.8, 4.0)
    for x0, kind in ((0.6, "gleich"), (8.2, "dreieck")):
        f.beam((x0, 1.1), (x0 + 5.8, 1.1))
        if kind == "gleich":
            f.dload(x0, x0 + 5.8, 1.15, 1.1, n=9); R = 3.3
            f.arrow((x0 + 2.9, 3.7), (x0 + 2.9, 2.45), c=F, lw=1.9); f.text((x0 + 2.9, 3.7), r"$R=q_0L$", c=F, dx=1.0, dy=0.1, size=9)
            f.dim((x0, 0.7), (x0 + 2.9, 0.7), "$L/2$", off=-0.0, size=8.5); f.dim((x0 + 2.9, 0.7), (x0 + 5.8, 0.7), "$L/2$", off=-0.0, size=8.5)
            f.text((x0 - 0.35, 1.95), "$q_0$", c=F, size=9)
        else:
            f.dload(x0, x0 + 5.8, 1.15, 0.0, 1.6, n=9)
            xr = x0 + 5.8 * 2 / 3
            f.arrow((xr, 3.7), (xr, 1.9), c=F, lw=1.9); f.text((xr, 3.7), r"$R=q_0L/2$", c=F, dx=-1.2, dy=0.1, size=9)
            f.dim((x0, 0.7), (xr, 0.7), "$2L/3$", off=0.0, size=8.5); f.dim((xr, 0.7), (x0 + 5.8, 0.7), "$L/3$", off=0.0, size=8.5)
            f.text((x0 + 6.25, 2.5), "$q_0$", c=F, size=9)
    f.save("k07_last")

def schwerpunkte():
    f = Fig(15.8, 3.9)
    # Dreieck
    pts = [(0.5, 0.9), (3.5, 0.9), (1.9, 3.4)]; f.poly(pts); c = np.mean(pts, axis=0); f.dot(c, 0.07, c=F)
    f.guide((0.2, c[1]), (3.8, c[1])); f.text((3.95, c[1]), "$h/3$", size=8.5); f.cap((2.0, 0.35), "Dreieck")
    # Halbkreisfläche
    c0 = P(6.6, 0.9); t = np.linspace(0, 180, 60); f.poly([pol(c0, 1.5, a) for a in t]); sc = c0 + P(0, 4 * 1.5 / (3 * np.pi))
    f.dot(sc, 0.07, c=F); f.text(sc, r"$4R/3\pi$", dx=0.0, dy=-0.32, size=8); f.cap((6.6, 0.35), "Halbkreisfläche")
    # Halbkreisbogen
    c0 = P(10.0, 0.9); f.arc(c0, 1.5, 0, 180, lw=1.6); f.line((8.4, 0.9), (11.6, 0.9), c=GREY, lw=0.6); sc = c0 + P(0, 2 * 1.5 / np.pi)
    f.dot(sc, 0.07, c=F); f.text(sc, r"$2R/\pi$", dx=0.0, dy=-0.35, size=8); f.cap((10.0, 0.35), "Halbkreisbogen")
    # Viertelkreis
    c0 = P(12.8, 0.9); f.poly([c0] + [pol(c0, 2.0, a) for a in np.linspace(0, 90, 40)]); sc = c0 + P(1, 1) * 4 * 2.0 / (3 * np.pi)
    f.dot(sc, 0.07, c=F); f.text(sc, r"$4R/3\pi$", dx=0.1, dy=-0.35, size=8); f.cap((13.8, 0.35), "Viertelkreis")
    f.save("k07_schwerpunkte")

def lprofil():
    f = Fig(15.8, 4.6)
    f.poly([(1.0, 0.8), (4.2, 0.8), (4.2, 1.6), (1.8, 1.6), (1.8, 4.0), (1.0, 4.0)])
    f.dim((1.0, 0.8), (4.2, 0.8), "$4a$", off=-0.4); f.dim((1.0, 1.6), (1.0, 4.0), "$3a$", off=0.4 * -1)
    f.guide((1.8, 1.6), (1.0, 1.6)); f.text((1.55, 1.2), "$a$", size=8.5, c=GREY)
    S = P(1.0 + 19 / 14 * 0.8, 0.8 + 19 / 14 * 0.8); f.dot(S, 0.08, c=F); f.text(S, "$S$", c=F, dx=0.3, dy=0.25)
    c0 = P(11.0, 2.4); f.circle(c0, 1.8, fc=LIGHT); f.circle(c0 + P(0.9, 0), 0.9, fc="white", ec=INK)
    S2 = c0 + P(-0.3, 0); f.dot(S2, 0.08, c=F); f.text(S2, "$S$", c=F, dx=-0.3, dy=0.3)
    f.dot(c0, 0.05, c=GREY); f.text(c0, "$O$", dx=0.0, dy=-0.4, size=8, c=GREY)
    f.cap((11.0, 0.25), "Scheibe mit Loch", size=8.5); f.cap((3.0, 0.1), "", size=8.5)
    f.save("k07_beispiele")
baleken(); schwerpunkte(); lprofil()
