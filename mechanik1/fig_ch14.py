from figlib import *
def schnitt():
    f = Fig(15.8, 4.6)
    f.axes2(P(0.4, 0.5), 0.9, 0.9, "x", "y", neg=0)
    f.rect((1.8, 2.0), (5.2, 2.7)); f.rect((8.8, 2.0), (12.2, 2.7))
    f.line((7.0, 0.9), (7.0, 3.7), c=V, lw=0.9, dash=(5, 3)); f.text((7.0, 4.0), "Schnitt bei $x$", c=V, size=8.5)
    p = P(5.2, 2.35)
    f.arrow(p, p + P(0.95, 0), c=F, lw=1.5); f.arrow(p, p + P(0, 0.95), c=F, lw=1.5); f.arc(p + P(0, -0.0), 0.5, -50, 50, col=M, lw=1.3, arrow=True)
    f.text(p + P(1.3, -0.0), "$N$", c=F, size=9); f.text(p + P(-0.35, 1.05), "$Q_y$", c=F, size=9); f.text(p + P(0.95, 0.75), "$M_z$", c=M, size=9)
    q = P(8.8, 2.35)
    f.arrow(q, q - P(0.95, 0), c=F, lw=1.5); f.arrow(q, q - P(0, 0.95), c=F, lw=1.5); f.arc(q, 0.5, 130, 230, col=M, lw=1.3, arrow=True)
    f.text(q - P(1.3, 0.0), "$N$", c=F, size=9); f.text(q + P(0.35, -1.05), "$Q_y$", c=F, size=9); f.text(q + P(-0.95, -0.75), "$M_z$", c=M, size=9)
    f.cap((3.5, 0.9), "linker Teil: positives Schnittufer", size=8); f.cap((10.5, 3.6), "rechter Teil: negatives Schnittufer", size=8)
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
    f.poly([(x0, yq), (x0, yq + 0.9), (x0 + L, yq - 0.9), (x0 + L, yq)], fc="#dfe9f4", ec=V, lw=1.1, z=1)
    f.text((x0 - 0.45, yq), "$Q_y$", size=9); f.text((x0 + 0.3, yq + 1.25), r"$q_0L/2$", c=V, size=8); f.text((x0 + L - 0.3, yq - 1.2), r"$-q_0L/2$", c=V, size=8)
    ym = 1.9; f.line((x0, ym), (x0 + L, ym), c=GREY, lw=0.6)
    xs = np.linspace(0, 1, 60); f.poly([(x0, ym)] + [(x0 + L * x, ym + 1.3 * 4 * x * (1 - x)) for x in xs], fc="#dff0e8", ec=M, lw=1.1, z=1)
    f.text((x0 - 0.45, ym), "$M_z$", size=9); f.text((x0 + L / 2, ym + 1.65), r"$q_0L^2/8$", c=M, size=8)
    f.guide((x0 + L / 2, 0.6), (x0 + L / 2, 6.9))
    # rechts: Einzellast
    x1, y = 8.9, 7.0; a, b = 2.2, 4.0; L2 = a + b
    f.beam((x1, y), (x1 + L2, y)); f.pin((x1, y), size=0.28, gw=0.8); f.roller((x1 + L2, y), size=0.28, gw=0.8)
    f.arrow((x1 + a, y + 1.2), (x1 + a, y + 0.07), c=F, lw=1.6); f.text((x1 + a, y + 1.2), r"$F$", c=F, dx=0.35, dy=0.1)
    f.line((x1, yq), (x1 + L2, yq), c=GREY, lw=0.6)
    f.poly([(x1, yq), (x1, yq - 0.8), (x1 + a, yq - 0.8), (x1 + a, yq + 0.55), (x1 + L2, yq + 0.55), (x1 + L2, yq)], fc="#dfe9f4", ec=V, lw=1.1, z=1)
    f.text((x1 + a / 2, yq - 1.1), r"$-Fb/L$", c=V, size=8); f.text((x1 + a + b / 2, yq + 0.85), r"$Fa/L$", c=V, size=8)
    f.line((x1, ym), (x1 + L2, ym), c=GREY, lw=0.6); f.poly([(x1, ym), (x1 + a, ym + 1.3), (x1 + L2, ym)], fc="#dff0e8", ec=M, lw=1.1, z=1)
    f.text((x1 + a, ym + 1.65), r"$Fab/L$", c=M, size=8)
    f.guide((x1 + a, 0.6), (x1 + a, 6.9))
    f.cap((3.7, 0.25), "Gleichlast", size=8.5); f.cap((12.0, 0.25), "Einzellast", size=8.5)
    f.save("k14_diagramme")

def element():
    f = Fig(15.8, 4.2)
    f.beam((1.0, 1.4), (14.8, 1.4), c=GREY, lw=2.0)
    x0, x1 = 6.5, 9.5
    f.rect((x0, 1.1), (x1, 1.7), fc=LIGHT, lw=1.2, z=3)
    f.dload(x0, x1, 1.75, 0.8, n=5)
    f.text((8.0, 3.05), r"$q_y\,\mathrm{d}x$", c=F, size=9)
    f.arrow((x0, 1.4), (x0, 0.4), c=F, lw=1.4); f.text((x0 - 0.7, 0.55), r"$Q_y$", c=F, size=9)
    f.arrow((x1, 1.4), (x1, 2.4), c=F, lw=1.4) if False else None
    f.arrow((x1, 1.4), (x1, 0.4), c=F, lw=0) if False else None
    f.arrow((x1, 0.4), (x1, 1.4), c=F, lw=1.4); f.text((x1 + 1.0, 0.55), r"$Q_y+\mathrm{d}Q_y$", c=F, size=9)
    f.arc((x0, 1.4), 0.5, 60, 300, col=M, lw=1.2, arrow=True); f.text((x0 - 0.9, 2.1), r"$M_z$", c=M, size=9)
    f.arc((x1, 1.4), 0.5, 120, -120, col=M, lw=1.2, arrow=True); f.text((x1 + 1.6, 2.2), r"$M_z+\mathrm{d}M_z$", c=M, size=9)
    f.dim((x0, 3.7), (x1, 3.7), r"$\mathrm{d}x$", off=0.0, size=8.5)
    f.save("k14_element")

def bogen():
    f = Fig(15.8, 4.6)
    c = P(5.2, 1.0); R = 3.0
    f.arc(c, R, 0, 180, lw=2.6); f.hatch((c[0] - R - 1.0, c[1]), (c[0] - R + 1.0, c[1]), side=-1)
    f.arrow(c + P(R, 0), c + P(R, -1.1), c=F, lw=1.6); f.text(c + P(R, -1.1), r"$\mathbfit{F}$", c=F, dx=0.4)
    ph = 45; pp = pol(c, R, ph)
    f.line(c, pp, c=GREY, lw=0.6, dash=(4, 3)); f.dot(pp, 0.08, c=V); f.line(c, c + P(R + 0.6, 0), c=GREY, lw=0.6, dash=(4, 3))
    f.angle(c, 1.0, 0, ph, label=r"$\varphi$", lr=1.4, size=9)
    f.text(c + P(0.5, 0.9), "$R$", c=GREY, size=9)
    f.cap((11.4, 3.4), r"$N=F\cos\varphi$", size=10); f.cap((11.4, 2.7), r"$Q_r=F\sin\varphi$", size=10); f.cap((11.4, 2.0), r"$M_z=RF(1-\cos\varphi)$", size=10)
    f.save("k14_bogen")
schnitt(); diagramme(); element(); bogen()
