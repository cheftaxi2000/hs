from figlib import *
def schnitt():
    f = Fig(15.8, 4.6)
    f.axes2(P(0.4, 0.5), 0.9, 0.9, "x", "y", neg=0); f.text((1.85, 0.5), r"($z$ aus der Ebene)", size=7.5, c=GREY, ha="left")
    f.rect((1.8, 2.0), (5.2, 2.7)); f.rect((8.8, 2.0), (12.2, 2.7))
    f.cut((7.0, 0.9), (7.0, 3.7)); f.text((7.0, 4.0), "Schnitt bei $x$", c=NEU, size=8.5)
    p = P(5.2, 2.35)
    f.arrow(p, p + P(0.95, 0), c=F, lw=1.5); f.arrow(p, p + P(0, 0.95), c=F, lw=1.5)
    f.arc(p, 0.5, -55, 55, col=M, lw=1.3, arrow=True)                     # +M_z: Gegenuhrzeigersinn
    f.text(p + P(1.3, -0.0), "$N$", c=F, size=9); f.text(p + P(-0.35, 1.05), "$Q_y$", c=F, size=9); f.text(p + P(0.95, 0.75), "$M_z$", c=M, size=9)
    q = P(8.8, 2.35)
    f.arrow(q, q - P(0.95, 0), c=F, lw=1.5); f.arrow(q, q - P(0, 0.95), c=F, lw=1.5)
    f.arc(q, 0.5, 235, 125, col=M, lw=1.3, arrow=True)                    # -M_z: Uhrzeigersinn
    f.text(q - P(1.3, 0.0), "$N$", c=F, size=9); f.text(q + P(0.35, -1.05), "$Q_y$", c=F, size=9); f.text(q + P(-0.95, 0.75), "$M_z$", c=M, size=9)
    f.cap((3.5, 0.9), "linker Teil: positives Schnittufer", size=8); f.cap((10.5, 0.9), "rechter Teil: negatives Schnittufer", size=8)
    f.cap((10.5, 3.6), "(gleiche Grössen, entgegengesetzt)", size=7.5, c=GREY)
    f.save("k14_schnitt")

def diagramme():
    f = Fig(15.8, 8.4)
    def beam_top(x0, y, L, load):
        f.beam((x0, y), (x0 + L, y)); f.pin((x0, y), size=0.28, gw=0.8); f.roller((x0 + L, y), size=0.28, gw=0.8)
    # links: Gleichlast
    x0, L = 0.7, 6.0; y = 7.0
    beam_top(x0, y, L, None); f.dload(x0, x0 + L, y + 0.05, 0.8, n=10)
    f.text((x0 + L / 2, y + 1.15), "$q_0$", c=F, size=9)
    yq = 4.6; f.line((x0, yq), (x0 + L, yq), c=GREY, lw=0.6)
    f.poly([(x0, yq), (x0, yq - 0.9), (x0 + L, yq + 0.9), (x0 + L, yq)], fc="#f6dfdb", ec=F, lw=1.1, z=1)
    f.text((x0 - 0.45, yq), "$Q_y$", size=9); f.text((x0 + 0.45, yq - 1.2), r"$-q_0L/2$", c=F, size=8); f.text((x0 + L + 0.1, yq + 0.9), r"$q_0L/2$", c=F, size=8, ha="left")
    ym = 1.9; f.line((x0, ym), (x0 + L, ym), c=GREY, lw=0.6)
    xs = np.linspace(0, 1, 60); f.poly([(x0, ym)] + [(x0 + L * x, ym + 1.3 * 4 * x * (1 - x)) for x in xs], fc="#dff0e8", ec=M, lw=1.1, z=1)
    f.text((x0 - 0.45, ym), "$M_z$", size=9); f.text((x0 + L / 2, ym + 1.65), r"$q_0L^2/8$", c=M, size=8)
    f.guide((x0 + L / 2, 0.6), (x0 + L / 2, 6.9))
    # rechts: Einzellast
    x1, y = 8.9, 7.0; a, b = 2.2, 4.0; L2 = a + b
    f.beam((x1, y), (x1 + L2, y)); f.pin((x1, y), size=0.28, gw=0.8); f.roller((x1 + L2, y), size=0.28, gw=0.8)
    f.arrow((x1 + a, y + 1.2), (x1 + a, y + 0.07), c=F, lw=1.6); f.text((x1 + a, y + 1.2), r"$F$", c=F, dx=0.35, dy=0.1)
    f.line((x1, yq), (x1 + L2, yq), c=GREY, lw=0.6)
    f.poly([(x1, yq), (x1, yq - 0.8), (x1 + a, yq - 0.8), (x1 + a, yq + 0.55), (x1 + L2, yq + 0.55), (x1 + L2, yq)], fc="#f6dfdb", ec=F, lw=1.1, z=1)
    f.text((x1 + a / 2, yq - 1.1), r"$-Fb/L$", c=F, size=8); f.text((x1 + a + b / 2, yq + 0.85), r"$Fa/L$", c=F, size=8)
    f.line((x1, ym), (x1 + L2, ym), c=GREY, lw=0.6); f.poly([(x1, ym), (x1 + a, ym + 1.3), (x1 + L2, ym)], fc="#dff0e8", ec=M, lw=1.1, z=1)
    f.text((x1 + a, ym + 1.65), r"$Fab/L$", c=M, size=8)
    f.guide((x1 + a, 0.6), (x1 + a, 6.9))
    f.cap((3.7, 0.25), "Gleichlast", size=8.5); f.cap((12.0, 0.25), "Einzellast", size=8.5)
    f.text((7.8, 0.25), r"($y$ nach oben: positive Werte oben aufgetragen)", size=7.3, c=GREY)
    f.save("k14_diagramme")

def element():
    f = Fig(15.8, 4.4)
    f.beam((1.0, 1.4), (14.8, 1.4), c=GREY, lw=2.0)
    x0, x1 = 6.5, 9.5
    f.rect((x0, 1.1), (x1, 1.7), fc=LIGHT, lw=1.2, z=3)
    for xx in np.linspace(x0 + 0.3, x1 - 0.3, 5):                       # q_y in positiver y-Richtung gezeichnet
        f.arrow((xx, 1.75), (xx, 2.55), c=F, lw=0.8, hl=0.14)
    f.line((x0 + 0.3, 2.55), (x1 - 0.3, 2.55), c=F, lw=0.8)
    f.text((8.0, 2.9), r"$q_y\,\mathrm{d}x$", c=F, size=9)
    f.arrow((x0, 1.4), (x0, 0.4), c=F, lw=1.4); f.text((x0 - 0.7, 0.55), r"$Q_y$", c=F, size=9)
    f.arrow((x1, 0.4), (x1, 1.4), c=F, lw=1.4); f.text((x1 + 1.0, 0.55), r"$Q_y+\mathrm{d}Q_y$", c=F, size=9)
    f.arc((x0, 1.4), 0.5, 300, 60, col=M, lw=1.2, arrow=True); f.text((x0 - 0.9, 2.1), r"$M_z$", c=M, size=9)          # negatives Ufer: Uhrzeigersinn
    f.arc((x1, 1.4), 0.5, -120, 120, col=M, lw=1.2, arrow=True); f.text((x1 + 1.6, 2.2), r"$M_z+\mathrm{d}M_z$", c=M, size=9)  # positives Ufer
    f.dim((x0, 3.6), (x1, 3.6), r"$\mathrm{d}x$", off=0.0, size=8.5)
    f.text((12.6, 3.6), "alle Grössen positiv eingezeichnet", size=7.5, c=GREY)
    f.axes2(P(1.3, 2.6), 0.8, 0.8, "x", "y", neg=0)
    f.save("k14_element")

def bogen():
    f = Fig(15.8, 4.9)
    c = P(5.2, 1.0); R = 3.0; ph = 45
    f.arc(c, R, ph, 180, lw=2.6, col=MID); f.arc(c, R, 0, ph, lw=2.6)
    f.hatch((c[0] - R - 1.0, c[1]), (c[0] - R + 1.0, c[1]), side=-1)
    f.arrow(c + P(R, 0), c + P(R, -1.1), c=F, lw=1.6); f.text(c + P(R, -1.1), r"$\mathbfit{F}$", c=F, dx=0.4)
    pp = pol(c, R, ph); er = unit(pp - c); ep = P(-er[1], er[0])
    f.line(c, pp, c=GREY, lw=0.6, dash=(4, 3)); f.line(c, c + P(R + 0.6, 0), c=GREY, lw=0.6, dash=(4, 3))
    f.cut(pp - er * 0.35, pp + er * 0.35)
    f.arrow(pp, pp + ep * 0.95, c=F, lw=1.4); f.text(pp + ep * 0.95, "$N$", c=F, dx=-0.15, dy=0.25, size=9)
    f.arrow(pp, pp + er * 0.95, c=F, lw=1.4); f.text(pp + er * 0.95, "$Q_r$", c=F, dx=0.3, dy=0.05, size=9)
    f.arc(pp, 0.45, -90 + ph - 60, -90 + ph + 60, col=M, lw=1.2, arrow=True); f.text(pp + P(0.85, -0.3), "$M_z$", c=M, size=9)
    f.angle(c, 1.0, 0, ph, label=r"$\varphi$", lr=1.4, size=9)
    f.text(c + P(0.6, 1.0), "$R$", c=GREY, size=9)
    f.text(c + P(-R + 0.4, R * 0.55), "abgetrennt", size=7.5, c=GREY)
    f.cap((11.6, 3.7), r"freies Stück $0 \leq \varphi' \leq \varphi$:", size=8.5)
    f.cap((11.6, 3.0), r"$N=F\cos\varphi$", size=10); f.cap((11.6, 2.35), r"$Q_r=F\sin\varphi$", size=10); f.cap((11.6, 1.7), r"$M_z=RF(1-\cos\varphi)$", size=10)
    f.save("k14_bogen")
schnitt(); diagramme(); element(); bogen()
