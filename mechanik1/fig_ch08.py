from figlib import *

def ramp(f, x0, y0=0.9, L=4.2, ang=26.565):
    a = rad(ang); top = P(x0 + L, y0 + L * np.tan(a))
    f.poly([(x0, y0), (x0 + L, y0), tuple(top)], fc="#f7f7f7", ec="white", lw=0)
    f.hatch((x0, y0), tuple(top), side=+1) if False else None
    # Schräge mit Schraffur (rechts von der Laufrichtung nach unten)
    f.hatch(tuple(top), (x0, y0), side=-1)
    return a

def block_on_ramp(f, x0, a, s=2.3, w=1.5, h=0.95, y0=0.9, lift=0.0):
    u = P(np.cos(a), np.sin(a)); n = P(-np.sin(a), np.cos(a))
    base = P(x0, y0) + u * s + n * lift
    c = base + n * h / 2
    f.box(c, w, h, ang=np.degrees(a), fc=LIGHT)
    return c, base, u, n

# ---------- 8.1 Pendel ----------
def ruhelage():
    f = Fig(15.8, 5.6)
    for x0, lab in ((3.0, "Ruhelage"), (11.0, "nur momentane Ruhe")):
        f.hatch((x0 - 1.0, 4.4), (x0 + 1.0, 4.4), side=+1)
        f.hinge((x0, 4.4), 0.09)
    f.beam((3.0, 4.4), (3.0, 1.5), lw=1.6); f.circle((3.0, 1.2), 0.3, fc=LIGHT); f.arrow((3.0, 1.2), (3.0, 0.2), c=F, lw=1.4); f.text((3.0, 0.2), r"$\mathbfit{G}$", c=F, dx=0.4)
    f.cap((3.0, 4.95 - 0.0), "")
    ang = -30; p1 = pol((11.0, 4.4), 3.2, -90 + ang)
    f.arc((11.0, 4.4), 3.2, -90 - 40, -90 + 40, col=GREY, lw=0.7, dash=(4, 3))
    f.beam((11.0, 4.4), tuple(p1), lw=1.6); f.circle(p1, 0.3, fc=LIGHT)
    f.arrow(p1, p1 + P(0, -1.0), c=F, lw=1.4); f.text(p1 + P(0, -1.0), r"$\mathbfit{G}$", c=F, dx=0.4)
    f.text(p1 + P(-0.9, 0.4), "$v=0$", size=9)
    f.cap((3.0, 5.2), "Ruhelage: bleibt dort, wenn man loslässt", size=8); f.cap((11.0, 5.2), "Umkehrpunkt: nur momentan in Ruhe", size=8)
    f.save("k08_ruhelage")

# ---------- 8.2 Bindungen ----------
def bindungen():
    f = Fig(15.8, 4.2)
    f.ground(0.6, 6.4, 1.0); f.rect((2.2, 1.0), (4.2, 2.2)); f.dot((3.2, 1.6), 0.05)
    f.arrow((3.2, 0.2), (3.2, 1.0), c=F, lw=1.5); f.text((3.2, 0.2), r"$\mathbfit{N}$", c=F, dx=0.4, dy=0.0)
    f.arrow((3.2, 2.5), (3.2, 3.5), c=GREY, lw=1.2, dash=(4, 3)); f.cap((3.2, 3.8), "kann abheben: einseitige Bindung", size=8)
    # Nut
    f.line((8.4, 1.0), (14.8, 1.0), lw=2.0); f.line((8.4, 2.6), (14.8, 2.6), lw=2.0)
    f.hatch((8.4, 1.0), (14.8, 1.0), side=-1); f.hatch((14.8, 2.6), (8.4, 2.6), side=-1)
    f.rect((10.6, 1.0), (12.6, 2.6), fc=LIGHT, lw=1.0)
    f.arrow((11.6, 1.8), (11.6, 1.05), c=F, lw=1.5); f.arrow((11.6, 1.8), (11.6, 2.55), c=F, lw=1.5)
    f.arrow((12.8, 1.8), (13.9, 1.8), c=GREY, lw=1.2, dash=(4, 3)); f.text((13.6, 2.15), "frei beweglich", size=8, c=GREY)
    f.cap((11.6, 3.8), "kann nicht lösen: vollständige Bindung", size=8)
    f.save("k08_bindungen")

# ---------- 8.3 Virtuelle Bewegung am Klotz ----------
def virtuell():
    f = Fig(15.8, 5.6)
    titles = ["wirkliche Kräfte", "virtuelle Verschiebung längs der Ebene", "senkrecht: Bindung gelöst"]
    for k, x0 in enumerate((1.9, 6.9, 11.9)):
        a = ramp(f, x0, L=3.4)
        c, base, u, n = block_on_ramp(f, x0, a, s=1.3, lift=0.0 if k < 2 else 0.5)
        f.dot(c, 0.05)
        if k == 0:
            f.arrow(c, c + P(0, -1.25), c=F, lw=1.5); f.text(c + P(0, -1.25), r"$\mathbfit{G}$", c=F, dx=0.4)
            f.arrow(c - P(1.7, 0), c - P(0.1, 0), c=F, lw=1.5); f.text(c - P(1.9, 0), r"$\mathbfit{F}$", c=F, dx=-0.0, dy=0.35)
            Nb = base + 0.0 * u; f.arrow(Nb, Nb + n * 1.4, c=F, lw=1.5); f.text(Nb + n * 1.4, r"$\mathbfit{N}$", c=F, dx=-0.3, dy=0.25)
        elif k == 1:
            f.arrow(c, c + u * 1.5, c=V, lw=1.7); f.text(c + u * 1.5, r"$\tilde{\mathbfit{v}}$", c=V, dx=0.1, dy=0.4)
        else:
            f.arrow(c, c + n * 1.5, c=V, lw=1.7); f.text(c + n * 1.5, r"$\tilde{\mathbfit{v}}'$", c=V, dx=0.35, dy=0.15)
        f.cap((x0 + 1.2, 0.35), titles[k], size=8)
    f.save("k08_virtuell")

# ---------- 8.4 Schere ----------
def schere():
    f = Fig(15.8, 4.2)
    A, B, C = P(2.0, 0.9), P(10.0, 0.9), P(6.0, 1.9)
    f.beam(A, C); f.beam(C, B); f.hinge(C, 0.1)
    f.arrow(A, A + P(1.7, 0), c=F, lw=1.6); f.arrow(B, B - P(1.7, 0), c=F, lw=1.6)
    f.text(A + P(1.7, 0), r"$\mathbfit{F}$", c=F, dx=0.1, dy=-0.4); f.text(B - P(1.7, 0), r"$-\mathbfit{F}$", c=F, dx=-0.1, dy=-0.4)
    f.arrow(C + P(0, 0.2), C + P(0, 1.2), c=V, lw=1.4, dash=(4, 3)); f.text(C + P(0, 1.2), "klappt zusammen", size=8, dy=0.35, c=GREY)
    f.dot(A, 0.07); f.dot(B, 0.07)
    f.cap((12.7, 2.5), "", size=8)
    f.save("k08_schere")
ruhelage(); bindungen(); virtuell(); schere()

# ===== Kapitel 9 =====
def lagertypen():
    f = Fig(15.8, 6.6)
    cols = [0.6, 4.55, 8.5, 12.45]; Lb = 2.9
    for i, x0 in enumerate(cols):
        yS, yF = 5.2, 1.9
        f.beam((x0 + (0.9 if i == 2 else 0.0), yS), (x0 + Lb, yS))
        f.beam((x0 + (0.9 if i == 2 else 0.0), yF), (x0 + Lb, yF), c=GREY)
        if i == 0:
            f.roller((x0, yS), gw=0.9); f.arrow((x0, yF - 1.3), (x0, yF - 0.05), c=F, lw=1.5); f.text((x0, yF - 1.3), r"$A_y$", c=F, dx=0.4, dy=0.0)
        if i == 1:
            f.pin((x0, yS), gw=0.9); f.arrow((x0, yF - 1.3), (x0, yF - 0.05), c=F, lw=1.5); f.arrow((x0 - 1.1, yF), (x0 - 0.05, yF), c=F, lw=1.5)
            f.text((x0, yF - 1.3), r"$A_y$", c=F, dx=0.4); f.text((x0 - 1.1, yF), r"$A_x$", c=F, dy=0.35, dx=-0.0)
        if i == 2:
            xw = x0 + 0.9; f.wall(xw, yS - 0.9, yS + 0.9, side=-1)
            xw2 = xw
            f.arrow((xw, yF - 1.3), (xw, yF - 0.05), c=F, lw=1.5); f.arrow((xw - 1.1, yF), (xw - 0.05, yF), c=F, lw=1.5)
            f.text((xw, yF - 1.3), r"$A_y$", c=F, dx=0.4); f.text((xw - 1.1, yF), r"$A_x$", c=F, dy=0.35)
            f.moment(P(xw + 0.1, yF), 0.5, 150, 30 + 0, col=M, lw=0) if False else f.arc((xw, yF), 0.6, 60, 300, col=M, lw=1.3, arrow=True); f.text((xw + 0.85, yF + 0.5), "$M_A$", c=M, size=9)
        if i == 3:
            top = P(x0, yS); bot = P(x0 + 0.9, yS - 1.7)
            f.beam(top, P(x0 + Lb, yS))
            f.line(top, bot, lw=1.4); f.hinge(top, 0.09); f.hinge(bot, 0.09); f.ground(bot[0] - 0.5, bot[0] + 0.5, bot[1] - 0.15)
            d = unit(top - bot)
            f.arrow(P(x0, yF) - d * 1.4, P(x0, yF) - d * 0.05, c=F, lw=1.5); f.text(P(x0, yF) - d * 1.4, "$S$", c=F, dx=0.35, dy=-0.1)
        f.cap((x0 + 1.5, 0.2), ["Loslager: 1", "Festlager: 2", "Einspannung: 3", "Pendelstütze: 1"][i] + " Unbekannte", size=8)
    f.save("k09_lager")

def standfest():
    f = Fig(15.8, 3.9)
    for i, x0 in enumerate((0.5, 5.4, 10.3)):
        f.ground(x0, x0 + 4.0, 0.7); f.rect((x0 + 1.0, 0.7), (x0 + 2.8, 3.0)); f.dot((x0 + 1.9, 1.85), 0.05)
        f.arrow((x0 + 1.9, 1.85), (x0 + 1.9, 0.95), c=F, lw=1.4)
        xn = [x0 + 1.9, x0 + 2.35, x0 + 2.8][i]
        f.arrow((xn, 0.0), (xn, 0.7), c=F, lw=1.5); f.text((xn, 0.0), r"$\mathbfit{N}$", c=F, dx=0.35, dy=0.1) if False else None
        if i > 0: f.arrow((x0, 2.6), (x0 + 1.0, 2.6), c=F, lw=1.5); f.text((x0 + 0.1, 2.95), r"$\mathbfit{F}$", c=F, size=9)
        f.cap((x0 + 1.9, 3.55), ["ohne Last", "mit Last: $N$ wandert", "Kippgrenze"][i], size=8)
    f.save("k09_standfest")

def freischnitt():
    f = Fig(15.8, 4.5)
    f.beam((1.0, 2.4), (6.6, 2.4)); f.pin((1.0, 2.4), gw=1.0); f.roller((6.6, 2.4), gw=1.0)
    f.arrow((3.2, 3.8), (3.2, 2.5), c=F, lw=1.6); f.text((3.2, 3.8), r"$\mathbfit{F}$", c=F, dx=0.35, dy=0.1)
    f.dim((1.0, 1.0), (3.2, 1.0), "$a$", off=0.0, size=9); f.dim((3.2, 1.0), (6.6, 1.0), "$b$", off=0.0, size=9)
    f.text((0.6, 3.0), "$A$", size=9); f.text((7.0, 3.0), "$B$", size=9)
    f.beam((9.2, 2.4), (14.8, 2.4))
    f.arrow((11.4, 3.8), (11.4, 2.5), c=F, lw=1.6); f.text((11.4, 3.8), r"$\mathbfit{F}$", c=F, dx=0.35, dy=0.1)
    f.arrow((9.2, 1.3), (9.2, 2.33), c=F, lw=1.6); f.arrow((8.1, 2.4), (9.13, 2.4), c=F, lw=1.6); f.arrow((14.8, 1.3), (14.8, 2.33), c=F, lw=1.6)
    f.text((9.6, 1.5), "$A_y$", c=F, size=9); f.text((8.3, 2.8), "$A_x$", c=F, size=9); f.text((14.4, 1.5), "$B_y$", c=F, size=9)
    f.cap((3.8, 0.1), "System", size=8.5); f.cap((12.0, 0.1), "Freischnitt", size=8.5)
    f.save("k09_freischnitt")

def bestimmt():
    f = Fig(15.8, 3.0)
    for i, (x0, nm, lab) in enumerate(((0.6, "pf", "$n=3$: statisch bestimmt"), (5.6, "ff", "$n=4$: einfach unbestimmt"), (10.6, "cl", "$n=4$: einfach unbestimmt"))):
        f.beam((x0, 1.7), (x0 + 4.0, 1.7))
        if nm == "pf": f.pin((x0, 1.7), gw=0.8, size=0.32); f.roller((x0 + 4.0, 1.7), gw=0.8, size=0.32)
        if nm == "ff": f.pin((x0, 1.7), gw=0.8, size=0.32); f.pin((x0 + 4.0, 1.7), gw=0.8, size=0.32)
        if nm == "cl": f.wall(x0, 1.1, 2.3, side=-1); f.roller((x0 + 4.0, 1.7), gw=0.8, size=0.32)
        f.cap((x0 + 2.0, 0.25), lab, size=8)
    f.save("k09_bestimmt")
lagertypen(); standfest(); freischnitt(); bestimmt()

# ===== Kapitel 10 =====
def leiter():
    f = Fig(15.8, 6.2)
    def ladder(x0, col=INK, ground=True):
        A, B, C = P(x0, 1.6), P(x0 + 3.4, 1.6), P(x0 + 1.7, 4.9)
        f.beam(A, C, c=col, lw=2.6); f.beam(B, C, c=col, lw=2.6); f.hinge(C, 0.09)
        return A, B, C
    A, B, C = ladder(0.6); f.ground(0.2, 4.4, 1.6); f.line((1.15, 2.8), (3.05, 2.8), lw=1.2)
    f.arrow(C + P(0, 1.0), C + P(0, 0.1), c=F, lw=1.6); f.text(C + P(0, 1.0), r"$\mathbfit{G}$", c=F, dx=0.4)
    f.text(A, "$A$", dx=-0.3, dy=0.3, size=9); f.text(B, "$B$", dx=0.3, dy=0.3, size=9); f.text(C, "$C$", dx=0.35, dy=-0.15, size=9)
    f.cap((2.3, 0.2), "System", size=8.5)
    A, B, C = ladder(5.6, col=GREY); f.line((6.15, 2.8), (8.05, 2.8), c=GREY, lw=0.9)
    f.arrow(C + P(0, 1.0), C + P(0, 0.1), c=F, lw=1.6); f.text(C + P(0, 1.0), r"$\mathbfit{G}$", c=F, dx=0.4)
    f.arrow(A - P(0, 0.9), A, c=F, lw=1.6); f.arrow(B - P(0, 0.9), B, c=F, lw=1.6)
    f.text(A - P(0.5, 0.5), r"$N_A$", c=F, size=9); f.text(B - P(-0.5, 0.5), r"$N_B$", c=F, size=9)
    f.cap((7.3, 0.2), "Gesamtsystem (Freischnitt)", size=8.5)
    # linker Holm
    A, B, C = P(11.4, 1.6), P(0, 0), P(13.1, 4.9)
    f.beam(A, C, lw=2.6)
    f.arrow(A - P(0, 0.9), A, c=F, lw=1.6); f.text(A - P(0.5, 0.5), r"$N_A$", c=F, size=9)
    S1 = A + (C - A) * 0.30
    f.arrow(S1, S1 + P(1.2, 0), c=F, lw=1.6); f.text(S1 + P(1.2, 0), "$S$", c=F, dx=0.3, size=9)
    f.arrow(C, C + P(1.0, 0), c=F, lw=1.6); f.arrow(C, C - P(0, 0.9), c=F, lw=1.6)
    f.text(C + P(1.0, 0), "$C_x$", c=F, dx=0.4, size=9); f.text(C - P(0, 0.9), "$C_y$", c=F, dx=0.4, dy=0.0, size=9); f.hinge(C, 0.09)
    f.cap((12.0, 0.2), "linker Holm", size=8.5)
    f.save("k10_leiter")

def dreigelenk():
    f = Fig(15.8, 5.6)
    A, B, C = P(0.9, 1.4), P(6.7, 1.4), P(3.8, 4.2)
    f.beam(A, C); f.beam(C, B); f.pin(A, gw=0.9); f.pin(B, gw=0.9); f.hinge(C, 0.1)
    f.arrow(P(1.2, 3.3) , P(1.2 + 0.0, 3.3) - P(0, 0.0), c=F, lw=0) if False else None
    m = (A + C) / 2; f.arrow(m + P(-0.9, 0.4), m + P(-0.03, 0.01), c=F, lw=1.6); f.text(m + P(-1.1, 0.4), r"$\mathbfit{F}$", c=F, dx=-0.15, dy=0.25)
    f.text(A, "$A$", dx=-0.3, dy=0.35, size=9); f.text(B, "$B$", dx=0.3, dy=0.35, size=9); f.text(C, "$C$", dx=0.0, dy=0.4, size=9)
    f.cap((3.8, 0.15), "Gesamtsystem: 4 Unbekannte", size=8.5)
    # getrennt
    A2, C2 = P(8.9, 1.4), P(11.2, 4.2); B2, C3 = P(14.4, 1.4), P(13.3, 4.2)
    f.beam(A2, C2); f.beam(C3, B2); f.pin(A2, gw=0.9); f.pin(B2, gw=0.9)
    f.arrow(A2 + P(-0.9, 0.4) * 0, A2, c=F, lw=0) if False else None
    for p, d, lab, off in [(A2, P(0, 1.0), "$A_y$", P(0.4, -0.5)), (A2, P(1.0, 0), "$A_x$", P(-0.3, 0.35)), (C2, P(1.0, 0), "$C_x$", P(0.4, 0.3)), (C2, P(0, -1.0), "$C_y$", P(0.0, -1.2))]:
        pass
    f.arrow(A2 - P(0, 1.0) * 0 + P(-0.0, -0.9) * 0, A2, lw=0) if False else None
    f.arrow(A2 + P(-1.0, 0), A2, c=F, lw=1.5); f.text(A2 + P(-1.0, 0.0), r"$A_x$", c=F, dy=0.35, size=9)
    f.arrow(A2 + P(0, -0.0), A2 + P(0, 1.0), c=F, lw=0) if False else None
    f.arrow(C2, C2 + P(0.7, 0), c=F, lw=1.5); f.text(C2 + P(0.7, 0), r"$C_x$", c=F, dx=-0.2, dy=0.38, size=9)
    f.arrow(C2, C2 - P(0, 1.0), c=F, lw=1.5); f.text(C2 - P(0, 1.0), r"$C_y$", c=F, dx=0.35, size=9)
    f.arrow(C3, C3 - P(0.7, 0), c=F, lw=1.5); f.text(C3 - P(0.7, 0), r"$-C_x$", c=F, dx=-0.15, dy=-0.38, size=9)
    f.arrow(C3, C3 + P(0, 1.0), c=F, lw=1.5); f.text(C3 + P(0, 1.0), r"$-C_y$", c=F, dx=0.55, size=9)
    f.arrow(B2 + P(1.0, 0), B2, c=F, lw=1.5); f.text(B2 + P(1.0, 0), r"$B_x$", c=F, dy=0.35, size=9)
    f.cap((11.1, 0.15), "zerlegt: 6 Unbekannte, 6 Gleichungen", size=8.5)
    f.save("k10_dreigelenk")

def unbrauchbar():
    f = Fig(15.8, 3.9)
    f.beam((0.8, 1.2), (6.4, 1.2))
    for x in (1.5, 3.6, 5.7): f.roller((x, 1.2), gw=0.8, size=0.3); f.guide((x, 1.2), (x, 3.2), c=F)
    f.cap((3.6, 3.55), "drei parallele Wirkungslinien", size=8, c=F); f.cap((3.6, 0.15), "horizontal verschiebbar", size=8)
    f.beam((9.0, 1.2), (14.8, 1.2)); P0 = P(11.6, 3.3)
    for x in (9.6, 11.6, 13.8): f.line((x, 1.2), tuple(P0 + (P(x, 1.2) - P0) * 0.2 * 0 + (P(x, 1.2) - P0) * -0.0), c=F, lw=0) if False else None
    for x in (9.6, 11.6, 14.2):
        f.circle((x, 1.2), 0.1, fc="white"); f.guide((x, 1.2), tuple(P0), c=F)
    f.dot(P0, 0.08, c=F); f.text(P0, "$P$", c=F, dx=0.3, dy=0.25); f.cap((11.8, 0.15), "drei Wirkungslinien durch $P$: Drehung um $P$ möglich", size=8)
    f.save("k10_unbrauchbar")
leiter(); dreigelenk(); unbrauchbar()
