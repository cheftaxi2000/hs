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
    titles = ["wirkliche Kräfte", "virtuell längs der Ebene (zulässig)", "virtuell senkrecht (Bindung verletzt)"]
    notes = ["", r"$\mathbfit{N}\perp\tilde{\mathbfit{v}}$: leistet nichts", r"jetzt leistet auch $\mathbfit{N}$"]
    for k, x0 in enumerate((1.9, 6.9, 11.9)):
        a = ramp(f, x0, L=3.4)
        c, base, u, n = block_on_ramp(f, x0, a, s=1.3)
        f.dot(c, 0.05)
        lwF = 1.5 if k == 0 else 1.1
        colN = F if k != 1 else MID
        f.arrow(c, c + P(0, -1.15), c=F, lw=lwF); f.text(c + P(0, -1.15), r"$\mathbfit{G}$", c=F, dx=0.35)
        f.arrow(c - P(1.6, 0), c - P(0.1, 0), c=F, lw=lwF); f.text(c - P(1.8, 0), r"$\mathbfit{F}$", c=F, dy=0.32)
        Nb = base; f.arrow(Nb, Nb + n * 1.25, c=colN, lw=lwF); f.text(Nb + n * 1.25, r"$\mathbfit{N}$", c=colN, dx=-0.3, dy=0.22)
        if k == 1:
            f.arrow(c, c + u * 1.5, c=V, lw=1.8, z=7); f.text(c + u * 1.5, r"$\tilde{\mathbfit{v}}$", c=V, dx=0.1, dy=0.38)
        elif k == 2:
            q = c + u * 0.45; f.arrow(q, q + n * 1.4, c=V, lw=1.8, z=7); f.text(q + n * 1.4, r"$\tilde{\mathbfit{v}}'$", c=V, dx=0.35, dy=0.15)
        f.cap((x0 + 1.2, 0.35), titles[k], size=8)
        if notes[k]: f.cap((x0 + 1.2, 4.55), notes[k], size=7.6, c=NEU)
    f.save("k08_virtuell")

# ---------- 8.4 Schere ----------
def schere():
    f = Fig(15.8, 4.2)
    A, B, C = P(1.2, 0.9), P(7.6, 0.9), P(4.4, 1.9)
    f.beam(A, C); f.beam(C, B); f.hinge(C, 0.1)
    f.arrow(A, A + P(1.5, 0), c=F, lw=1.6); f.arrow(B, B - P(1.5, 0), c=F, lw=1.6)
    f.text(A + P(1.5, 0), r"$\mathbfit{F}$", c=F, dx=0.1, dy=-0.38); f.text(B - P(1.5, 0), r"$-\mathbfit{F}$", c=F, dx=-0.1, dy=-0.38)
    f.arrow(C + P(0, 0.2), C + P(0, 1.1), c=V, lw=1.4, dash=(4, 3)); f.text(C + P(0, 1.1), "klappt zusammen", size=8, dy=0.32, c=GREY)
    f.dot(A, 0.07); f.dot(B, 0.07)
    f.text(A, "$A$", dx=-0.3, dy=0.05); f.text(B, "$B$", dx=0.3, dy=0.05); f.text(C, "$C$", dx=-0.3, dy=0.25)
    f.cap((4.4, 0.25), "Gesamtsystem: äussere Kräfte im Gleichgewicht", size=8)
    # Freischnitt des Stabes AC
    A2, C2 = P(10.0, 0.9), P(13.2, 1.9)
    f.beam(A2, C2); f.hinge(C2, 0.1); f.dot(A2, 0.07)
    f.arrow(A2, A2 + P(1.5, 0), c=F, lw=1.6); f.text(A2 + P(1.5, 0), r"$\mathbfit{F}$", c=F, dx=0.1, dy=-0.38)
    f.arrow(C2, C2 - P(1.5, 0), c=F, lw=1.6); f.text(C2 - P(1.5, 0), r"$-\mathbfit{F}$", c=F, dx=-0.1, dy=0.32)
    f.dim(C2 + P(0.7, 0), P(C2[0] + 0.7, A2[1]), "$h$", off=0.0, size=8.5)
    f.line(C2, C2 + P(0.85, 0), c=GREY, lw=0.5); f.line(A2 + P(1.5, 0), P(C2[0] + 0.85, A2[1]), c=GREY, lw=0.5, dash=(2, 2))
    f.arc(P(11.6, 1.4), 0.45, 200, 480, col=M, lw=1.3, arrow=True); f.text((10.6, 2.45), "$M = hF \\neq 0$", c=M, size=8.5)
    f.text(A2, "$A$", dx=-0.3, dy=0.05); f.text(C2, "$C$", dx=0.0, dy=0.32)
    f.cap((11.8, 0.25), "Stab $AC$ allein: Kräftepaar, keine Ruhe", size=8)
    f.save("k08_schere")
ruhelage(); bindungen(); virtuell(); schere()

# ===== Kapitel 9 =====
def lagertypen():
    f = Fig(15.8, 6.6)
    cols = [0.0, 3.95, 7.9, 11.85]; Lb = 2.35; off = 1.25
    names = ["Loslager", "Festlager", "Einspannung", "Pendelstütze"]
    for i, x0 in enumerate(cols):
        yS, yF = 5.2, 2.2; xa = x0 + off
        if i > 0: f.line((x0, 0.15), (x0, 6.3), c=MID, lw=0.5)
        f.beam((xa, yS), (xa + Lb, yS)); f.beam((xa, yF), (xa + Lb, yF), c=GREY)
        if i == 0:
            f.roller((xa, yS), gw=0.9); f.arrow((xa, yF - 1.25), (xa, yF - 0.05), c=F, lw=1.5); f.text((xa, yF - 1.25), r"$A_y$", c=F, dx=0.38)
        if i == 1:
            f.pin((xa, yS), gw=0.9); f.arrow((xa, yF - 1.25), (xa, yF - 0.05), c=F, lw=1.5); f.arrow((xa - 1.05, yF), (xa - 0.05, yF), c=F, lw=1.5)
            f.text((xa, yF - 1.25), r"$A_y$", c=F, dx=0.38); f.text((xa - 1.05, yF), r"$A_x$", c=F, dy=0.32, dx=0.1)
        if i == 2:
            f.wall(xa, yS - 0.85, yS + 0.85, side=-1)
            f.arrow((xa, yF - 1.25), (xa, yF - 0.05), c=F, lw=1.5); f.arrow((xa - 1.05, yF), (xa - 0.05, yF), c=F, lw=1.5)
            f.text((xa, yF - 1.25), r"$A_y$", c=F, dx=0.38); f.text((xa - 1.05, yF), r"$A_x$", c=F, dy=0.32, dx=0.1)
            f.arc((xa, yF), 0.55, 70, 290, col=M, lw=1.3, arrow=True); f.text((xa - 0.75, yF + 0.62), "$M_A$", c=M, size=9)
        if i == 3:
            top = P(xa, yS); bot = P(xa - 0.85, yS - 1.6)
            f.line(top, bot, lw=1.4); f.hinge(top, 0.09); f.hinge(bot, 0.09); f.ground(bot[0] - 0.45, bot[0] + 0.45, bot[1] - 0.12)
            d = unit(top - bot)
            f.arrow(P(xa, yF) - d * 1.35, P(xa, yF) - d * 0.05, c=F, lw=1.5); f.text(P(xa, yF) - d * 1.35, "$S$", c=F, dx=-0.32, dy=0.05)
            f.guide(P(xa, yF) - d * 1.35, P(xa, yF) + d * 0.5, c=MID)
        f.cap((x0 + off + Lb / 2 - 0.2, 0.25), f"{names[i]}: {[1, 2, 3, 1][i]} Unbekannte", size=8)
    f.text((0.15, 5.9), "Symbol", size=7.5, c=GREY, ha="left"); f.text((0.15, 2.9), "Freischnitt", size=7.5, c=GREY, ha="left")
    f.save("k09_lager")

def standfest():
    f = Fig(15.8, 5.2)
    G = 1.3; b, H, hF = 1.8, 2.7, 2.3                      # Breite, Höhe, Angriffshöhe von F
    for i, (x0, r) in enumerate(((0.5, 0.0), (5.4, 0.25), (10.3, b / (2 * hF)))):
        y0 = 1.4; f.ground(x0, x0 + 4.0, y0)
        xl = x0 + 1.0; f.rect((xl, y0), (xl + b, y0 + H)); S = P(xl + b / 2, y0 + 1.2); f.dot(S, 0.05)
        f.arrow(S, S + P(0, -G), c=F, lw=1.4); f.text(S + P(0, -G / 2), r"$\mathbfit{G}$", c=F, dx=-0.3)
        e = r * hF; Pn = P(S[0] + e, y0)
        f.arrow(Pn + P(0, -G), Pn, c=F, lw=1.4); f.text(Pn + P(0, -G * 0.6), r"$\mathbfit{N}$", c=F, dx=0.3)
        if r > 0:
            yF = y0 + hF; Fl = r * G
            f.arrow((xl - Fl, yF), (xl, yF), c=F, lw=1.4); f.text((xl - Fl / 2, yF), r"$\mathbfit{F}$", c=F, dy=0.3)
            f.arrow(Pn, Pn + P(-Fl, 0), c=F, lw=1.2, hl=0.15); f.text(Pn + P(-Fl / 2, 0.0), r"$\mathbfit{F}_R$", c=F, dy=-0.32, dx=-0.15, size=8.5)
            I = P(S[0], yF); f.line(I + P(-0.3 * r, 0.3) * 0, Pn, c=NEU, lw=0.8, dash=(4, 2.5), z=6); f.dot(I, 0.04, c=NEU)
            f.line((S[0], S[1]), I, c=MID, lw=0.5, dash=(2, 2)); f.line((xl, yF), I, c=MID, lw=0.5, dash=(2, 2))
            f.dim(P(S[0], y0 + 0.3), P(Pn[0], y0 + 0.3), "", off=0.0, size=8); f.text(P((S[0] + Pn[0]) / 2, y0 + 0.55), "$e$", size=8)
        f.cap((x0 + 1.9, y0 + H + 0.45), ["ohne Last", "mit Last: $N$ wandert", "Kippgrenze: $N$ an der Kante"][i], size=8)
    f.text((8.0, -0.4), r"gestrichelt: Wirkungslinie der Resultierenden aus $\mathbfit{G}$ und $\mathbfit{F}$; sie trifft den Boden im Angriffspunkt von $\mathbfit{N}$", size=7.6, c=NEU)
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
    A, B, C = ladder(0.6); f.ground(0.2, 4.4, 1.6); f.line(((A + C) / 2), ((B + C) / 2), lw=1.2)
    f.arrow(C + P(0, 1.0), C + P(0, 0.1), c=F, lw=1.6); f.text(C + P(0, 1.0), r"$\mathbfit{G}$", c=F, dx=0.4)
    f.text(A, "$A$", dx=-0.3, dy=0.3, size=9); f.text(B, "$B$", dx=0.3, dy=0.3, size=9); f.text(C, "$C$", dx=0.35, dy=-0.15, size=9)
    f.cap((2.3, 0.2), "System", size=8.5)
    A, B, C = ladder(5.6, col=GREY); f.line(((A + C) / 2), ((B + C) / 2), c=GREY, lw=0.9)
    f.arrow(C + P(0, 1.0), C + P(0, 0.1), c=F, lw=1.6); f.text(C + P(0, 1.0), r"$\mathbfit{G}$", c=F, dx=0.4)
    f.arrow(A - P(0, 0.9), A, c=F, lw=1.6); f.arrow(B - P(0, 0.9), B, c=F, lw=1.6)
    f.text(A - P(0.5, 0.5), r"$N_A$", c=F, size=9); f.text(B - P(-0.5, 0.5), r"$N_B$", c=F, size=9)
    f.cap((7.3, 0.2), "Gesamtsystem (Freischnitt)", size=8.5)
    # linker Holm
    A, B, C = P(11.4, 1.6), P(0, 0), P(13.1, 4.9)
    f.beam(A, C, lw=2.6)
    f.arrow(A - P(0, 0.9), A, c=F, lw=1.6); f.text(A - P(0.5, 0.5), r"$N_A$", c=F, size=9)
    S1 = A + (C - A) * 0.50
    f.arrow(S1, S1 + P(1.2, 0), c=F, lw=1.6); f.text(S1 + P(1.2, 0), "$S$", c=F, dx=0.3, size=9)
    f.arrow(C, C + P(1.0, 0), c=F, lw=1.6); f.arrow(C, C - P(0, 0.9), c=F, lw=1.6)
    f.text(C + P(1.0, 0), "$C_x$", c=F, dx=0.4, size=9); f.text(C - P(0, 0.9), "$C_y$", c=F, dx=0.4, dy=0.0, size=9); f.hinge(C, 0.09)
    f.cap((12.0, 0.2), "linker Holm", size=8.5)
    f.save("k10_leiter")

def dreigelenk():
    f = Fig(15.8, 5.6)
    A, B, C = P(0.9, 1.4), P(6.1, 1.4), P(3.5, 4.0)
    f.beam(A, C); f.beam(C, B); f.pin(A, gw=0.9); f.pin(B, gw=0.9); f.hinge(C, 0.1)
    m = (A + C) / 2; Fd = P(0.9, -0.4)
    f.arrow(m - Fd, m - unit(Fd) * 0.03, c=F, lw=1.6); f.text(m - Fd, r"$\mathbfit{F}$", c=F, dx=-0.25, dy=0.2)
    f.text(A, "$A$", dx=-0.3, dy=0.35, size=9); f.text(B, "$B$", dx=0.3, dy=0.35, size=9); f.text(C, "$C$", dx=0.0, dy=0.4, size=9)
    f.cap((3.5, 0.15), "Gesamtsystem: 4 Unbekannte, 3 Gleichungen", size=8.5)
    # zerlegt: gleiche Geometrie, rechter Teil um gap verschoben
    sh, gap = 6.9, 1.8
    A2, C2 = A + P(sh, 0), C + P(sh, 0); C3, B2 = C + P(sh + gap, 0), B + P(sh + gap, 0)
    f.beam(A2, C2); f.beam(C3, B2); f.pin(A2, gw=0.9); f.pin(B2, gw=0.9); f.hinge(C2, 0.09); f.hinge(C3, 0.09)
    m2 = (A2 + C2) / 2; f.arrow(m2 - Fd, m2 - unit(Fd) * 0.03, c=F, lw=1.6); f.text(m2 - Fd, r"$\mathbfit{F}$", c=F, dx=-0.25, dy=0.2)
    k = 0.75
    f.arrow(A2 + P(-k, 0), A2, c=F, lw=1.4); f.text(A2 + P(-k, 0), r"$A_x$", c=F, dx=0.05, dy=0.3, size=9)
    f.arrow(A2 + P(0, -k), A2, c=F, lw=1.4); f.text(A2 + P(0, -k), r"$A_y$", c=F, dx=0.38, dy=0.1, size=9)
    f.arrow(C2, C2 + P(k, 0), c=F, lw=1.4); f.text(C2 + P(k, 0), r"$C_x$", c=F, dx=-0.1, dy=0.3, size=9)
    f.arrow(C2, C2 + P(0, k), c=F, lw=1.4); f.text(C2 + P(0, k), r"$C_y$", c=F, dx=-0.38, size=9)
    f.arrow(C3, C3 + P(-k, 0), c=F, lw=1.4); f.text(C3 + P(-k, 0), r"$-C_x$", c=F, dx=0.05, dy=-0.3, size=9)
    f.arrow(C3, C3 + P(0, -k), c=F, lw=1.4); f.text(C3 + P(0, -k), r"$-C_y$", c=F, dx=-0.45, dy=0.05, size=9)
    f.arrow(B2 + P(k, 0), B2, c=F, lw=1.4); f.text(B2 + P(k, 0), r"$B_x$", c=F, dx=-0.05, dy=0.3, size=9)
    f.arrow(B2 + P(0, -k), B2, c=F, lw=1.4); f.text(B2 + P(0, -k), r"$B_y$", c=F, dx=-0.38, dy=0.1, size=9)
    f.cap((11.3, 0.15), "zerlegt in $C$: 6 Unbekannte, 6 Gleichungen", size=8.5)
    f.save("k10_dreigelenk")

def unbrauchbar():
    f = Fig(15.8, 4.6)
    f.beam((0.8, 1.6), (6.4, 1.6))
    for x in (1.5, 3.6, 5.7): f.roller((x, 1.6), gw=0.8, size=0.3); f.guide((x, 1.6), (x, 3.7), c=F)
    f.arrow((3.6, 2.25), (4.6, 2.25), c=V, lw=1.3, dash=(4, 3))
    f.cap((3.6, 4.1), "drei parallele Wirkungslinien", size=8, c=F); f.cap((3.6, 0.3), "horizontal verschiebbar", size=8)
    yb = 1.9; f.beam((8.8, yb), (15.0, yb)); P0 = P(11.9, 4.1)
    for x in (9.4, 11.9, 14.4):
        top = P(x, yb); d = unit(top - P0); bot = top + d * 1.15
        f.guide(top, P0, c=F); f.line(top, bot, lw=1.3); f.hinge(top, 0.08); f.hinge(bot, 0.08)
        g = nrm(d); f.hatch(bot + d * 0.1 - g * 0.4, bot + d * 0.1 + g * 0.4) if False else f.ground(bot[0] - 0.35, bot[0] + 0.35, bot[1] - 0.1)
    f.dot(P0, 0.08, c=F); f.text(P0, "$P$", c=F, dx=0.3, dy=0.25)
    f.arc(P0, 0.45, 200, 480, col=V, lw=1.0, arrow=True, dash=(3, 2))
    f.cap((11.9, 0.3), r"drei Pendelstützen, Wirkungslinien durch $P$: Drehung um $P$ möglich", size=8)
    f.save("k10_unbrauchbar")
leiter(); dreigelenk(); unbrauchbar()
