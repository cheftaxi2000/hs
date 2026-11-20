from inf import *
# ---- Falk-Schema ----
s = Sketch(13.4, 7.0)
w, h = 1.3, 0.95
def blk(x0, y0, rows, cols, name, tone, hi_row=None, hi_col=None):
    for i in range(rows):
        for j in range(cols):
            t = tone
            if hi_row is not None and i == hi_row: t = "violet"
            if hi_col is not None and j == hi_col: t = "amber"
            if hi_row is not None and hi_col is not None and i == hi_row and j == hi_col: t = "red"
            rb(s, x0 + j * w + w / 2, y0 - i * h - h / 2, w - 0.1, h - 0.1, t, r=0.16, lw=0.6)
            lab(s, x0 + j * w + w / 2, y0 - i * h - h / 2, "$%s_{%d%d}$" % (name, i + 1, j + 1), size=8.3)
Cy = 3.2; By = Cy + 0.2 + 3 * h
blk(1.0, Cy, 3, 3, "a", "blue", hi_row=1)
blk(1.0 + 3 * w + 0.2, By, 3, 2, "b", "blue", hi_col=1)
blk(1.0 + 3 * w + 0.2, Cy, 3, 2, "c", "white", hi_row=1, hi_col=1)
lab(s, 1.0 + 1.5 * w, Cy + 0.25, "$A$  ($3\\times 3$)", size=9, bold=True)
lab(s, 1.0 + 3 * w + 0.2 + w, By + 0.3, "$B$  ($3\\times 2$)", size=9, bold=True)
lab(s, 1.0 + 3 * w + 0.2 + w, 0.0 + 0.1, "$C=AB$  ($3\\times 2$)", size=9, bold=True)
lab(s, 10.2, 5.6, "Zeile 2 von $A$ · Spalte 2 von $B$", size=8.5, c="#5b4aa8", ha="left")
lab(s, 10.2, 5.05, "$c_{22}=a_{21}b_{12}+a_{22}b_{22}+a_{23}b_{32}$", size=8.5, c="#a3222e", ha="left")
lab(s, 10.2, 3.5, "Man liest ab: der Eintrag $(i,j)$\nsteht im Kreuzungspunkt von\nZeile $i$ (links) und Spalte $j$ (oben).", size=8.3, c="#444", ha="left", linespacing=1.3)
s.ax.set_ylim(-0.4, 7.0)
s.save("l05_falk")
