from figlib import *

# ---------- 11.1 Stab / Knoten ----------
def stab():
    f = Fig(15.8, 4.0)
    for x0, sg, lab in ((1.2, 1, "Zugstab: $S>0$"), (6.8, -1, "Druckstab: $S<0$")):
        a, b = P(x0, 2.2), P(x0 + 3.2, 2.2)
        f.beam(a, b, lw=2.6); f.hinge(a, 0.09); f.hinge(b, 0.09)
        if sg > 0:
            f.arrow(a, a - P(1.0, 0), c=F, lw=1.6); f.arrow(b, b + P(1.0, 0), c=F, lw=1.6)
        else:
            f.arrow(a - P(1.0, 0), a, c=F, lw=1.6); f.arrow(b + P(1.0, 0), b, c=F, lw=1.6)
        f.text(a - P(0.5, -0.35), "$S$", c=F, size=9); f.text(b + P(0.5, 0.35), "$S$", c=F, size=9)
        f.cap((x0 + 1.6, 0.9), lab, size=8.5)
    # Knoten
    n = P(13.4, 2.2)
    f.circle(n, 0.12, fc="white", lw=0.9)
    for ang, lab in ((0, "$S_1$"), (50, "$S_2$"), (160, "$S_3$")):
        d = P(np.cos(rad(ang)), np.sin(rad(ang))); f.line(n + d * 0.1, n + d * 1.5, c=GREY, lw=2.2)
        f.arrow(n + d * 0.12, n + d * 1.4, c=F, lw=1.5); f.text(n + d * 1.7, lab, c=F, size=9)
    f.arrow(n + P(0, 1.5), n + P(0, 0.12), c=F, lw=1.5); f.text(n + P(0.35, 1.45), r"$\mathbfit{F}$", c=F, size=9)
    f.cap((13.4, 0.9), "Knoten mit Stabkräften (als Zug)", size=8.5)
    f.save("k11_stab")

# ---------- 11.2 Fachwerk ----------
NODES = {"A": P(1.2, 1.4), "C": P(4.2, 1.4), "B": P(7.2, 1.4), "D": P(2.7, 2.9), "E": P(5.7, 2.9)}
BARS = {1: ("A", "D"), 2: ("A", "C"), 3: ("D", "C"), 4: ("C", "E"), 5: ("C", "B"), 6: ("D", "E"), 7: ("E", "B")}
def fachwerk():
    f = Fig(15.8, 4.4)
    for k, (p, q) in BARS.items():
        a, b = NODES[p], NODES[q]; f.beam(a, b, lw=2.4)
        m = (a + b) / 2; off = {1: (-0.3, 0.2), 2: (0, -0.3), 3: (-0.3, -0.2), 4: (0.3, -0.2), 5: (0, -0.3), 6: (0, 0.3), 7: (0.3, 0.2)}[k]
        f.text(m + P(*off), f"{k}", size=8.5, c=GREY)
    for n, p in NODES.items(): f.hinge(p, 0.1)
    f.pin(NODES["A"], size=0.32, gw=0.9); f.roller(NODES["B"], size=0.32, gw=0.9)
    f.arrow(NODES["C"] + P(0, -0.0), NODES["C"] - P(0, 1.0), c=F, lw=1.6); f.text(NODES["C"] - P(0, 0.55), r"$\mathbfit{F}$", c=F, dx=0.35, dy=0.0)
    for n, d in (("A", (-0.3, 0.3)), ("B", (0.3, 0.3)), ("C", (0.0, 0.35)), ("D", (-0.3, 0.3)), ("E", (0.3, 0.3))): f.text(NODES[n], f"${n}$", dx=d[0], dy=d[1], size=9)
    f.dim((1.2, 3.8), (2.7, 3.8), "$a$", off=0.0, size=8.5); f.dim((0.5, 1.4), (0.5, 2.9), "$a$", off=0.0, size=8.5)
    # Schnitt
    xs = 3.45
    f.cut((xs, 0.7), (xs, 3.6))
    # linker Teil rechts
    o = P(10.2, 0.0)
    A = NODES["A"] + P(9.0, 0); D = NODES["D"] + P(9.0, 0); C = NODES["C"] + P(9.0, 0)
    f.beam(A, D, lw=2.4)
    xc = xs + 9.0
    f.beam(A, P(xc, A[1]), lw=2.4); f.beam(D, P(xc, D[1]), lw=2.4)
    pD3 = D + (C - D) * ((xc - D[0]) / (C[0] - D[0])); f.beam(D, pD3, lw=2.4)
    f.hinge(A, 0.1); f.hinge(D, 0.1)
    f.arrow(A - P(0, 0.9), A, c=F, lw=1.5); f.text(A - P(0.55, 0.5), r"$F/2$", c=F, size=8.5)
    f.arrow(P(xc, D[1]), P(xc, D[1]) + P(1.0, 0), c=F, lw=1.5); f.text(P(xc + 1.0, D[1]), "$S_6$", c=F, dx=0.4, size=9)
    d3 = unit(C - D); f.arrow(pD3, pD3 + d3 * 0.8, c=F, lw=1.5); f.text(pD3 + d3 * 0.8, "$S_3$", c=F, dx=0.3, dy=0.25, size=9)
    f.arrow(P(xc, A[1]), P(xc, A[1]) + P(0.5, 0), c=F, lw=1.5); f.text(P(xc + 0.3, A[1]), "$S_2$", c=F, dy=-0.32, size=9)
    # Ritter: Wirkungslinien von S2 und S3 schneiden sich in C (Momentenpunkt für S6)
    f.line(P(xc + 0.5, A[1]), C, c=MID, lw=0.6, dash=(3, 2)); f.line(pD3 + d3 * 0.8, C, c=MID, lw=0.6, dash=(3, 2))
    f.circle(C, 0.09, fc="white", ec=NEU, lw=0.8, z=7); f.text(C, "$C$", c=NEU, dx=0.32, dy=0.0, size=9)
    f.text(C + P(0.35, -0.85), "Momentenpunkt für $S_6$", size=7.3, c=NEU)
    f.cap((4.2, 0.15), "Fachwerk und Schnitt", size=8.5); f.cap((12.6, 0.15), "linker Teil (freigeschnitten)", size=8.5)
    f.save("k11_fachwerk")
stab(); fachwerk()
