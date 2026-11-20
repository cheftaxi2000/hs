from plot import *
from inf import rb, lab, cell, arr, hline_
import numpy as np

# ---- drei Faelle bei 2 Gleichungen in 2 Unbekannten ----
def panel(name, lines, pt=None, cap=None, dashed=False):
    p = Plot(4.6, 4.4, (-0.3, 4.2), (-0.3, 4.2), xt=(1, 2, 3, 4), yt=(1, 2, 3, 4), xl="$x$", yl=None, pad=0.4)
    for (a, b, c, col, lbl, pos) in lines:
        xs = np.array([-0.3, 4.2])
        if b != 0:
            ys = (c - a * xs) / b; p.curve(xs, ys, c=col, lw=1.6, dash=((4, 3) if (dashed and col == R) else None))
        else:
            p.curve([c / a, c / a], [-0.3, 4.2], c=col, lw=1.6)
        p.text(pos[0], pos[1], lbl, c=col, size=8.5, ha="left", va="bottom")
    if pt: p.dot(pt, c=INK, r=3.2)
    p.save(name)
panel("l01_eind", [(1, 1, 3, B, "$x+y=3$", (0.1, 3.0)), (1, -1, 1, R, "$x-y=1$", (3.0, 2.1))], pt=(2, 1))
panel("l01_keine", [(1, 1, 1, B, "$x+y=1$", (0.05, 1.1)), (1, 1, 2, R, "$x+y=2$", (0.05, 2.1))])
panel("l01_viele", [(1, 1, 1, B, "$x+y=1$", (1.2, 1.2)), (2, 2, 2, R, "$2x+2y=2$", (2.0, 0.55))], dashed=True)

# ---- Zeitstrahl ----
s = Sketch(15.4, 5.6)
s.ax.plot([0.5, 14.9], [2.8, 2.8], color="#444", lw=1.2)
events = [(1.0, "um 1800 v. Chr.", "Babylon:\nSysteme mit\n2 Unbekannten", 1), (3.2, "um die Zeitenwende", "China: «Neun Kapitel»,\nEliminationsverfahren", -1),
          (5.4, "1683 / 1693", "Seki, Leibniz:\nDeterminanten", 1), (7.0, "1750", "Cramer:\nCramersche Regel", -1),
          (8.6, "1809", "Gauss:\nEliminationsverfahren", 1), (10.0, "1844 / 1858", "Grassmann, Cayley:\nVektoren, Matrizen", -1),
          (11.5, "1888", "Jordan; Peano:\nVektorraum-Axiome", 1), (13.0, "1948", "Turing:\nLR-Zerlegung", -1), (14.4, "1998", "PageRank", 1)]
for x, d, t, up in events:
    s.ax.plot([x, x], [2.8, 2.8 + 0.5 * up], color="#5b4aa8", lw=1.0); s.ax.plot([x], [2.8], "o", ms=4, color="#5b4aa8", zorder=5)
    s.ax.text(x, 2.8 + 0.62 * up, d, ha="center", va="bottom" if up > 0 else "top", fontsize=7.8, color="#5b4aa8", fontweight="bold")
    s.ax.text(x, 2.8 + 0.62 * up + (0.38 * up), t, ha="center", va="bottom" if up > 0 else "top", fontsize=7.2, color="#333", linespacing=1.15)
s.ax.set_xlim(0, 15.4); s.ax.set_ylim(-0.2, 5.8)
s.save("l01_zeit")
