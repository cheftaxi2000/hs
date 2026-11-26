from figlib import *
SYS = "#4a4a4a"

def sysbox(f, x0, y0, x1, y1, label=None, lp=None):
    f.path([(x0, y0), (x1, y0), (x1, y1), (x0, y1)], c=SYS, lw=0.9, dash=(5, 3), closed=True, z=1)
    if label: f.text(lp, label, c=SYS, size=8)

# ---------- 4.1 Reaktionsprinzip ----------
def reaktion():
    f = Fig(15.8, 5.6)
    # --- links: System Klotz / Tisch / Erde (ohne Kräfte)
    f.ground(0.4, 5.6, 0.7)
    f.rect((1.0, 2.0), (5.0, 2.3), fc="white")                       # Tischplatte
    for x in (1.3, 4.5): f.rect((x, 0.7), (x + 0.2, 2.0), fc="white")
    f.rect((2.2, 2.3), (3.8, 3.5)); f.text((3.0, 2.9), "Klotz", size=8)
    f.text((3.0, 2.15), "Tisch", size=7.5); f.text((3.0, 0.35), "Erde", size=7.5, c=GREY)
    f.cap((3.0, 4.3), "System: Klotz, Tisch, Erde")
    # --- rechts: auseinandergenommen, Kräftepaare
    xc = 10.0
    f.rect((xc - 0.8, 3.6), (xc + 0.8, 4.8)); f.dot((xc, 4.2), 0.05); f.text((xc + 1.25, 4.6), "Klotz", size=8.5, ha="left")
    f.arrow((xc, 4.2), (xc, 3.25), c=F, lw=1.4); f.text((xc, 3.25), r"$\mathbfit{G}$", c=F, dx=0.32, dy=0.12)
    f.arrow((xc - 0.45, 3.12), (xc - 0.45, 3.58), c=F, lw=1.4); f.text((xc - 0.45, 3.33), r"$\mathbfit{N}$", c=F, dx=-0.38)
    f.rect((xc - 2.3, 2.1), (xc + 2.3, 2.4), fc="white"); f.text((xc + 2.5, 2.25), "Tisch", size=8.5, ha="left")
    f.arrow((xc - 0.45, 2.88), (xc - 0.45, 2.42), c=F, lw=1.4); f.text((xc - 0.45, 2.66), r"$-\mathbfit{N}$", c=F, dx=-0.5)
    f.text((xc + 2.5, 1.9), "(übrige Kräfte am Tisch", size=7, c=GREY, ha="left"); f.text((xc + 2.5, 1.6), "nicht gezeichnet)", size=7, c=GREY, ha="left")
    th = np.linspace(rad(68), rad(112), 80); Rr = 9.0; ce = P(xc, 1.15 - Rr)
    earth = np.array([ce + Rr * P(np.cos(t), np.sin(t)) for t in th])
    f.poly(np.vstack([earth, [earth[-1] + P(0, -0.6)], [earth[0] + P(0, -0.6)]]), fc=LIGHT, ec="none", z=0)
    f.path(earth, lw=1.0); f.text((xc + 2.5, 0.85), "Erde", size=8.5, ha="left")
    f.arrow((xc, 0.25), (xc, 1.1), c=F, lw=1.4); f.text((xc, 0.55), r"$-\mathbfit{G}$", c=F, dx=0.45)
    # Paarmarken
    f.path([(xc - 0.75, 3.45), (xc - 1.15, 3.0), (xc - 0.75, 2.55)], c=GREY, lw=0.6, dash=(2, 2)); f.text((xc - 1.35, 3.0), "Paar", size=7, c=GREY, ha="right")
    f.path([(xc + 0.25, 3.35), (xc + 0.7, 2.0), (xc + 0.25, 0.55)], c=GREY, lw=0.6, dash=(2, 2)); f.text((xc + 0.85, 1.45), "Paar", size=7, c=GREY, ha="left")
    f.cap((xc, 5.2), "auseinandergenommen: jede Kraft hat ihre Gegenkraft am anderen Körper")
    f.save("k04_reaktion")

# ---------- 4.2 System und Systemgrenze ----------
def systemgrenze():
    f = Fig(15.8, 4.8)
    def scene(x0, cur):
        bc = GREY if cur == "last" else INK
        f.beam((x0, 1.4), (x0 + 5.8, 1.4), c=bc)
        f.rect((x0 + 1.9, 1.62), (x0 + 3.5, 2.6), ec=INK)                       # Last auf zwei Kufen
        for xk in (x0 + 2.0, x0 + 3.2): f.rect((xk, 1.45), (xk + 0.3, 1.62), fc=INK, ec=INK)
        f.line((x0 + 3.5, 2.1), (x0 + 4.4, 2.1), c=INK, lw=0.8)                 # Seil
        return P(x0 + 2.7, 2.1)
    # --- links: System = Last
    S = scene(0.8, "last"); f.pin((0.8, 1.4), gw=0.9); f.roller((6.6, 1.4), gw=0.9)
    sysbox(f, 2.45, 1.44, 4.55, 3.0, "System: Last", (3.5, 3.35))
    f.arrow(S + P(0, 0.2), S + P(0, -0.3), c=F, lw=1.3); f.text(S + P(0, -0.1), r"$\mathbfit{G}$", c=F, dx=0.3)
    f.arrow((5.2, 2.1), (6.1, 2.1), c=F, lw=1.3); f.text((6.1, 2.1), r"$\mathbfit{Z}$", c=F, dx=0.3)
    for k, xk in enumerate((2.95, 4.15)):
        f.arrow((xk, 0.75), (xk, 1.43), c=F, lw=1.1); f.text((xk, 0.62), f"$N_{k+1}$", c=F, size=8.5)
        f.arrow((xk + 0.4, 1.5), (xk - 0.3, 1.5), c=F, lw=1.0, hl=0.15); f.text((xk - 0.45, 1.12), f"$R_{k+1}$", c=F, size=8.5)
    # --- rechts: System = Last und Träger
    S = scene(8.6, "alles"); f.pin((8.6, 1.4), gw=0.9); f.roller((14.4, 1.4), gw=0.9)
    sysbox(f, 8.2, 0.15, 15.0, 3.0, None); f.text((11.6, 3.35), "System: Last und Träger", c=SYS, size=8)
    f.arrow(S + P(0, 0.2), S + P(0, -0.3), c=F, lw=1.3); f.text(S + P(0, -0.1), r"$\mathbfit{G}$", c=F, dx=0.3)
    f.arrow((13.0, 2.1), (13.9, 2.1), c=F, lw=1.3); f.text((13.9, 2.1), r"$\mathbfit{Z}$", c=F, dx=0.3)
    f.arrow((9.55, 0.25), (8.65, 0.92), c=F, lw=1.3); f.text((9.55, 0.25), r"$\mathbfit{F}_A$", c=F, dx=0.4, dy=0.05)
    f.arrow((14.4, 0.2), (14.4, 0.92), c=F, lw=1.3); f.text((14.4, 0.2), r"$\mathbfit{F}_B$", c=F, dx=-0.42, dy=0.12)
    f.text((11.6, 0.55), "$N_i,\\ R_i$ jetzt innere Kräfte", size=7.5, c=GREY)
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
            f.guide(o + Fv, o + P(Fv[0], -0.22))
            f.arrow(o + P(0, -0.22), o + P(Fv[0], -0.22), c=FL, lw=2.0)
            f.text(o + P(Fv[0] / 2, -0.5), r"$F\cos\alpha$", c=F, size=8)
        f.angle(o, 0.7, 0, ang, label=r"$\alpha$", lr=0.98, size=8.5)
        f.text(o + P(1.3, -0.95), lab, size=10)
    f.save("k05_leistung")

# ---------- 5.2 Moment als Hebel ----------
def hebel():
    f = Fig(15.8, 4.6)
    O = P(2.0, 2.0); A = P(6.2, 3.7)
    d = unit(P(1.0, -0.38)); Fv = 3.2 * d
    f.line(A - d * 4.2, A + d * 4.6, c=GREY, lw=0.7, dash=(5, 3))
    n = nrm(d); foot = A + d * ((O - A) @ d)
    f.line(O, foot, c=NEU, lw=1.3); f.text((O + foot) / 2, "$a$", c=NEU, dx=-0.25, dy=0.1, size=9.5)
    f.rightangle(foot, O - foot, d, a=0.2)
    f.arrow(O, A, c=INK, lw=1.2); f.text((O + A) / 2, r"$\overrightarrow{OA}$", dx=-0.3, dy=0.45, size=8.5)
    f.arrow(A, A + Fv, c=F, lw=1.7); f.text(A + Fv, r"$\mathbfit{F}$", c=F, dx=0.3, dy=0.3)
    f.dot(O); f.dot(A); f.text(O, "$O$", dx=-0.3, dy=-0.2); f.text(A, "$A$", dx=0.0, dy=0.4)
    f.moment(O, 0.6, 210, -70 + 0, col=M)
    f.text(O + P(-0.2, -0.95), r"$\mathbfit{M}_O$ dreht rechtsherum", c=M, size=8.5, ha="left")
    f.cap((12.0, 3.2), "$|\\mathbfit{M}_O| = F\\,a$", size=10); f.cap((12.0, 2.5), "Hebelarm $a$ = senkrechter", size=8.5); f.cap((12.0, 2.1), "Abstand von $O$ zur", size=8.5); f.cap((12.0, 1.7), "Wirkungslinie", size=8.5)
    f.save("k05_hebel")
leistung(); hebel()
