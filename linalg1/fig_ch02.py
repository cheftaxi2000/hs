from inf import *
# Eliminationsschema fuer eine 4x5 erweiterte Matrix: nach Schritt 0, 1, 2, 3
s = Sketch(15.4, 4.6)
def mat(ox, stage, title):
    lab(s, ox + 1.75, 4.2, title, size=8.5, bold=True)
    rows, cols = 4, 5
    for i in range(rows):
        for j in range(cols):
            x, y = ox + j * 0.7 + 0.35, 3.4 - i * 0.7
            zero = (stage >= 1 and j == 0 and i >= 1) or (stage >= 2 and j == 1 and i >= 2) or (stage >= 3 and j == 2 and i >= 3)
            piv = (stage >= 1 and i == 0 and j == 0) or (stage >= 2 and i == 1 and j == 1) or (stage >= 3 and i == 2 and j == 2)
            tone = "red" if piv else ("white" if zero else "blue")
            rb(s, x, y, 0.62, 0.58, tone, r=0.12, lw=0.5)
            lab(s, x, y, "0" if zero else ("●" if piv else "*"), size=8, c="#aaa" if zero else INK)
    vline_(s, ox + 3.5 + 0.02, 0.9, 3.8, c="#444", lw=1.0)
mat(0.1, 0, "Start")
mat(3.9, 1, "nach Schritt 1")
mat(7.7, 2, "nach Schritt 2")
mat(11.5, 3, "nach Schritt 3")
for x in (3.75, 7.55, 11.35): arr(s, (x - 0.15, 2.3), (x + 0.25, 2.3), c="#555", lw=1.0)
rb(s, 1.0, 0.35, 0.4, 0.3, "red", r=0.08); lab(s, 1.3, 0.35, "Pivot (≠ 0)", size=7.5, ha="left")
rb(s, 3.8, 0.35, 0.4, 0.3, "white", r=0.08); lab(s, 4.1, 0.35, "durch Elimination erzeugte Null", size=7.5, ha="left")
rb(s, 8.4, 0.35, 0.4, 0.3, "blue", r=0.08); lab(s, 8.7, 0.35, "beliebige Zahl", size=7.5, ha="left")
s.ax.set_ylim(0, 4.6)
s.save("l02_elim")
