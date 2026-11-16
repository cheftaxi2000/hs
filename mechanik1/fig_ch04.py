from figlib import *
SYS = "#4a4a4a"

def sysbox(f, x0, y0, x1, y1, label=None, lp=None):
    f.path([(x0, y0), (x1, y0), (x1, y1), (x0, y1)], c=SYS, lw=0.9, dash=(5, 3), closed=True, z=1)
    if label: f.text(lp, label, c=SYS, size=8)

# ---------- 4.1 Reaktionsprinzip ----------
def reaktion():
    f = Fig(15.8, 5.2)
    f.ground(0.4, 6.2, 0.6); f.rect((1.4, 0.6), (5.2, 1.0), fc="white"); f.rect((2.4, 1.0), (4.2, 2.6)); f.dot((3.3, 1.8))
    f.arrow((3.3, 1.8), (3.3, 0.95), c=F, lw=1.3); f.text((3.3, 0.95), r"$\mathbfit{G}$", c=F, dx=-0.4, dy=0.0)
    f.arrow((3.9, 0.35), (3.9, 1.0), c=F, lw=1.3); f.text((4.35, 0.6), r"$\mathbfit{N}$", c=F, size=9.5)
    f.cap((3.3, 3.2), "Klotz auf dem Tisch")
    # getrennt
    f.rect((9.0, 3.2), (10.8, 4.8)); f.dot((9.9, 4.0)); f.text((9.9, 4.0), "Klotz", dx=1.4, size=8.5)
    f.arrow((9.9, 4.0), (9.9, 2.9), c=F, lw=1.3); f.text((9.9, 2.9), r"$\mathbfit{G}$", c=F, dx=0.4, dy=0.0)
    f.arrow((9.3, 2.55), (9.3, 3.15), c=F, lw=1.3); f.text((8.85, 2.85), r"$\mathbfit{N}$", c=F, size=9.5)
    f.rect((8.0, 1.5), (12.4, 1.9), fc="white"); f.text((12.9, 1.7), "Tisch", size=8.5, ha="left")
    f.arrow((9.3, 2.5), (9.3, 1.95), c=F, lw=1.3); f.text((8.75, 2.2), r"$-\mathbfit{N}$", c=F, size=9.5)
    f.arrow((9.9, 0.8), (9.9, 1.45), c=F, lw=1.3)
    f.text((9.9, 0.45), r"$-\mathbfit{G}$ greift an der Erde an", c=F, size=8)
    f.save("k04_reaktion")

# ---------- 4.2 System und Systemgrenze ----------
def systemgrenze():
    f = Fig(15.8, 4.4)
    for x0 in (0.8, 8.6):
        f.beam((x0, 1.4), (x0 + 5.8, 1.4)); f.rect((x0 + 1.8, 1.5), (x0 + 3.4, 2.5))
    f.pin((0.8, 1.4), gw=0.9); f.roller((6.6, 1.4), gw=0.9); f.pin((8.6, 1.4), gw=0.9); f.roller((14.4, 1.4), gw=0.9)
    sysbox(f, 2.4, 1.45, 4.4, 3.0, "System: Last", (3.4, 3.35))
    f.arrow((3.1, 2.0), (3.1, 0.95), c=F, lw=1.3); f.text((3.1, 0.95), r"$\mathbfit{G}$", c=F, dx=-0.35, dy=0.0)
    f.arrow((3.7, 0.35), (3.7, 1.35), c=F, lw=1.3)
    sysbox(f, 8.2, 0.2, 15.0, 3.2, None); f.text((11.6, 3.5), "System: Last und Träger", c=SYS, size=8)
    f.arrow((11.4, 2.0), (11.4, 1.0), c=F, lw=1.3); f.text((11.4, 1.0), r"$\mathbfit{G}$", c=F, dx=-0.35)
    f.arrow((8.6, 0.15), (8.6, 0.95), c=F, lw=1.3); f.arrow((14.4, 0.15), (14.4, 0.95), c=F, lw=1.3)
    f.save("k04_system")

# ---------- 4.3 Linienkraftdichte ----------
def dichte():
    f = Fig(15.8, 4.4)
    f.beam((1.0, 1.0), (14.0, 1.0)); f.pin((1.0, 1.0), size=0.3, gw=0.8); f.roller((14.0, 1.0), size=0.3, gw=0.8)
    xs = np.linspace(1.0, 14.0, 60); qf = lambda x: 1.0 + 0.55 * np.sin((x - 1) * 0.36)
    f.path([(x, 1.1 + qf(x)) for x in xs], c=F, lw=0.9)
    for x in np.linspace(1.0, 14.0, 14): f.arrow((x, 1.1 + qf(x)), (x, 1.1), c=F, lw=0.7, hl=0.14)
    xa, xb = 6.9, 7.7
    f.poly([(xa, 1.1), (xb, 1.1), (xb, 1.1 + qf(xb)), (xa, 1.1 + qf(xa))], fc="#f0cdc8", ec=F, lw=0.7, z=0)
    f.text((7.3, 3.4), r"$q(x)\,\mathrm{d}x$", c=F, size=9); f.text((12.4, 3.0), r"$q(x)$", c=F, size=9.5)
    f.dim((xa, 0.65), (xb, 0.65), r"$\mathrm{d}x$", off=-0.4, size=8.5)
    f.arrow((7.3, 3.15), (7.3, 2.55), c=F, lw=0.6, hl=0.12)
    f.save("k04_dichte")
reaktion(); systemgrenze(); dichte()

# ===== Kapitel 5 =====
# ---------- 5.1 Leistung: Vorzeichen ----------
def leistung():
    f = Fig(15.8, 3.9)
    for i, (x0, ang, lab) in enumerate([(1.2, 40, r"$\mathcal{P}>0$"), (6.4, 90, r"$\mathcal{P}=0$"), (11.6, 140, r"$\mathcal{P}<0$")]):
        o = P(x0, 1.3)
        f.arrow(o, o + P(2.6, 0), c=V, lw=1.6); f.text(o + P(2.6, 0), r"$\mathbfit{v}$", c=V, dx=0.35, dy=0.0)
        Fv = 1.8 * P(np.cos(rad(ang)), np.sin(rad(ang)))
        f.arrow(o, o + Fv, c=F, lw=1.6); f.text(o + Fv, r"$\mathbfit{F}$", c=F, dx=0.1 if ang < 100 else -0.25, dy=0.35)
        f.dot(o, 0.07)
        if ang != 90:
            f.guide(o + Fv, o + P(Fv[0], 0))
            f.line(o + P(0, -0.2), o + P(Fv[0], -0.2), c=M, lw=2.4)
        f.angle(o, 0.7, 0, ang, label=r"$\alpha$", lr=0.98, size=8.5)
        f.text(o + P(1.3, -0.75), lab, size=10)
    f.save("k05_leistung")

# ---------- 5.2 Moment als Hebel ----------
def hebel():
    f = Fig(15.8, 4.6)
    O = P(2.0, 2.0); A = P(6.2, 3.7)
    d = unit(P(1.0, -0.38)); Fv = 3.2 * d
    f.line(A - d * 4.2, A + d * 4.6, c=GREY, lw=0.7, dash=(5, 3))
    n = nrm(d); foot = A + d * ((O - A) @ d)
    f.line(O, foot, c=M, lw=1.6); f.text((O + foot) / 2, "$a$", c=M, dx=-0.2, dy=0.3, size=9.5)
    f.arrow(O, A, c=INK, lw=1.2); f.text((O + A) / 2, r"$\overrightarrow{OA}$", dx=-0.3, dy=0.45, size=8.5)
    f.arrow(A, A + Fv, c=F, lw=1.7); f.text(A + Fv, r"$\mathbfit{F}$", c=F, dx=0.3, dy=0.3)
    f.dot(O); f.dot(A); f.text(O, "$O$", dx=-0.3, dy=-0.2); f.text(A, "$A$", dx=0.0, dy=0.4)
    f.moment(O, 0.6, 210, -70 + 0, col=M)
    f.text(O + P(-0.2, -0.95), r"$\mathbfit{M}_O$ dreht rechtsherum", c=M, size=8.5, ha="left")
    f.cap((12.0, 3.2), "$|\\mathbf{M}_O| = F\\,a$", size=10); f.cap((12.0, 2.5), "Hebelarm $a$ = senkrechter", size=8.5); f.cap((12.0, 2.1), "Abstand von $O$ zur", size=8.5); f.cap((12.0, 1.7), "Wirkungslinie", size=8.5)
    f.save("k05_hebel")
leistung(); hebel()
