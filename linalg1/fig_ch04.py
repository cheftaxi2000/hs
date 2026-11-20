from inf import *
from plot import Plot, B, R, G, O, P, INK, GREY
import numpy as np

# ---- Matrix-Anatomie ----
s = Sketch(11.6, 5.4)
vals = [["a11", "a12", "a13", "a14"], ["a21", "a22", "a23", "a24"], ["a31", "a32", "a33", "a34"]]
for i in range(3):
    for j in range(4):
        x, y = 2.4 + j * 1.4, 3.9 - i * 1.15
        tone = "violet" if (i == 1) else ("amber" if j == 2 else "white")
        if i == 1 and j == 2: tone = "red"
        rb(s, x, y, 1.2, 0.95, tone, r=0.18, lw=0.7)
        lab(s, x, y, "$a_{%d%d}$" % (i + 1, j + 1), size=9)
lab(s, 1.2, 3.9 - 1.15, "Zeile 2", size=8.5, c="#5b4aa8", bold=True, ha="center")
lab(s, 2.4 + 2 * 1.4, 4.75, "Spalte 3", size=8.5, c="#9a520c", bold=True)
for j in range(4): lab(s, 2.4 + j * 1.4, 0.5, f"j = {j+1}", size=7.5, c="#888")
for i in range(3): lab(s, 7.7, 3.9 - i * 1.15, f"i = {i+1}", size=7.5, c="#888", ha="left")
lab(s, 9.9, 2.75, "3 \u00d7 4-Matrix\n(m = 3 Zeilen,\nn = 4 Spalten)", size=8.3, ha="center")
s.ax.annotate("", xy=(8.45, 1.2), xytext=(8.45, 3.9), arrowprops=dict(arrowstyle="-", color="#aaa", lw=0.7))
s.save("l04_matrix")

# ---- Loesungsmenge = partikulaer + homogen ----
p = Plot(8.4, 6.2, (-3.2, 3.8), (-2.6, 3.4), xt=(), yt=(), xl="$x_1$", yl=None, grid=False, pad=0.35)
u = np.array([1.0, 0.7]); xp = np.array([-0.4, 1.4])
tt = np.array([-4.0, 4.0])
p.seg(tuple(-3.5 * u), tuple(3.5 * u), c=G, lw=1.7)
p.seg(tuple(xp - 3.5 * u), tuple(xp + 3.5 * u), c=B, lw=1.7)
p.arrow((0, 0), tuple(xp), c=R, lw=1.4)
p.dot(tuple(xp), c=R, r=3.2); p.dot((0, 0), c=INK, r=3)
w = xp + 1.3 * u; p.dot(tuple(w), c=INK, r=2.6)
p.arrow(tuple(xp), tuple(w), c=G, lw=1.1)
p.text(-3.0, -1.9, "$L_{\\mathrm{hom}}$: Lösungen von $A\\mathbf{x}=\\mathbf{0}$\n(Gerade durch $\\mathbf{0}$)", c=G, ha="left", size=8.5)
p.text(-3.0, 3.0, "$L$: Lösungen von $A\\mathbf{x}=\\mathbf{b}$", c=B, ha="left", size=8.5)
p.text(-1.15, 0.55, "$\\mathbf{x}_p$", c=R, size=9)
p.text(w[0] + 0.15, w[1] + 0.1, "$\\mathbf{x}_p+\\mathbf{x}_h$", c=INK, ha="left", size=8.5)
p.save("l04_affin")

# ---- Transposition ----
s = Sketch(11.4, 4.6)
A = [[1, 2, 3], [4, 5, 6]]
def block(ox, vals, title, hi=None):
    rows, cols = len(vals), len(vals[0])
    lab(s, ox + cols * 0.5, 4.2, title, size=9, bold=True)
    for i in range(rows):
        for j in range(cols):
            tone = "red" if (hi and (i, j) == hi) else ("violet" if i == j else "blue")
            cell(s, ox + j * 1.0 + 0.5, 3.1 - i * 1.0, 0.88, 0.88, str(vals[i][j]), tone, size=10, mono=False, r=0.15)
block(0.4, A, "$A$ (2 \u00d7 3)", None)
block(6.2, [[1, 4], [2, 5], [3, 6]], "$A^{\\mathsf{T}}$ (3 \u00d7 2)", None)
arr(s, (3.8, 2.6), (5.8, 2.6), c="#555", lw=1.3); lab(s, 4.8, 3.0, "Zeilen werden Spalten", size=8.5, c="#555")
lab(s, 5.5, -0.2, "Spiegeln an der Hauptdiagonalen: $(A^{\\mathsf{T}})_{ij}=a_{ji}$", size=8.5)
s.ax.set_ylim(-0.6, 4.6)
s.save("l04_transp")
