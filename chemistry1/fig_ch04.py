from plot import *
from matplotlib.patches import Circle, FancyBboxPatch, Rectangle

def level(s, x0, x1, y, lab, c=INK, side="right", size=8.5):
    s.seg((x0, y), (x1, y), c=c, lw=1.6)
    if side == "right": s.text(x1 + 0.15, y, lab, va="center", size=size)
    elif side == "left": s.text(x0 - 0.15, y, lab, va="center", ha="right", size=size)
    else: s.text((x0 + x1) / 2, y + 0.08, lab, ha="center", va="bottom", size=size)

# ---------- sign convention ----------
s = Sketch(12.6, 5.2)
s.ax.add_patch(FancyBboxPatch((3.6, 1.3), 4.3, 2.6, boxstyle="round,pad=0.02,rounding_size=0.2", fc=FILL_B, ec=B, lw=1.0))
s.text(5.75, 2.6, "system\n$\\Delta E = q + w$", ha="center", va="center", size=9.5)
s.text(0.2, 4.7, "surroundings", size=8.5, c="#555555")
s.arrow((1.0, 3.2), (3.5, 3.2), c=R, lw=1.4); s.text(2.25, 3.3, "$q>0$  heat in", ha="center", c=R, size=8)
s.arrow((3.5, 2.0), (1.0, 2.0), c=R, lw=1.4); s.text(2.25, 1.9, "$q<0$  heat out", ha="center", va="top", c=R, size=8)
s.arrow((11.9, 3.2), (8.1, 3.2), c=G, lw=1.4); s.text(10.0, 3.3, "$w>0$  work done on system", ha="center", c=G, size=8)
s.arrow((8.1, 2.0), (11.9, 2.0), c=G, lw=1.4); s.text(10.0, 1.9, "$w<0$  work done by system", ha="center", va="top", c=G, size=8)
s.text(6.3, 0.6, "sign convention: everything is seen from the system ($+$ = system gains energy)", ha="center", size=8, c="#444444")
s.save("c04_signs")

# ---------- energy diagram H2 combustion ----------
s = Sketch(7.6, 5.0)
level(s, 0.8, 3.6, 4.0, "$2\\,\\mathrm{H_2(g)} + \\mathrm{O_2(g)}$", c=B, side="center")
level(s, 0.8, 3.6, 1.0, "$2\\,\\mathrm{H_2O(l)}$", c=R, side="center")
s.arrow((4.3, 4.0), (4.3, 1.0), c=INK, lw=1.2)
s.text(4.5, 2.5, "$\\Delta E<0$\nenergy released\nto surroundings", va="center", size=8)
s.arrow((0.4, 0.4), (0.4, 4.7), c=INK, lw=0.8); s.text(0.25, 4.7, "$E$", ha="right", va="top", size=9)
s.text(2.2, 4.45, "reactants", ha="center", size=7.5, c=GREY); s.text(2.2, 0.55, "products", ha="center", va="top", size=7.5, c=GREY)
s.ax.set_ylim(0.0, 5.0)
s.save("c04_energydiag")

# ---------- piston work ----------
s = Sketch(9.5, 5.0)
s.seg((1.0, 0.6), (1.0, 4.6), lw=1.2); s.seg((4.6, 0.6), (4.6, 4.6), lw=1.2); s.seg((1.0, 0.6), (4.6, 0.6), lw=1.2)
s.ax.add_patch(Rectangle((1.02, 0.62), 3.56, 1.6, fc=FILL_B, ec="none"))
s.ax.add_patch(Rectangle((1.02, 2.22), 3.56, 1.3, fc=FILL_B, ec="none", alpha=0.45))
s.ax.add_patch(Rectangle((1.02, 3.52), 3.56, 0.3, fc="#9a9a9a", ec=INK, lw=0.7))
s.ax.add_patch(Rectangle((1.02, 2.22), 3.56, 0.3, fc="none", ec=INK, lw=0.6, ls=(0, (3, 2))))
s.text(2.8, 1.4, "gas", ha="center", va="center", size=9)
s.arrow((5.2, 2.37), (5.2, 3.67), c=R); s.text(5.4, 3.0, "$\\Delta x$", c=R, va="center")
for x in (1.8, 2.8, 3.8): s.arrow((x, 4.6), (x, 3.9), c=B, lw=0.9)
s.text(2.8, 4.65, "$P_{ext}$ (constant)", ha="center", size=8, c=B)
s.text(6.2, 3.6, "$w = -F\\,\\Delta x = -P A\\,\\Delta x$", size=9)
s.text(6.2, 2.8, "$w = -P\\,\\Delta V$", size=10.5)
s.text(6.2, 1.9, "expansion: $\\Delta V>0$, $w<0$", size=8, c="#444444")
s.text(6.2, 1.4, "(the gas does work on the", size=8, c="#444444"); s.text(6.2, 1.0, "surroundings)", size=8, c="#444444")
s.save("c04_piston")

# ---------- Hess diagram ----------
s = Sketch(9.6, 5.6)
level(s, 3.2, 5.6, 5.0, "$2\\,\\mathrm{H_2(g)}+\\mathrm{O_2(g)}$", c=B, side="left")
level(s, 3.2, 5.6, 1.9, "$2\\,\\mathrm{H_2O(g)}$", c=O, side="left")
level(s, 3.2, 5.6, 0.6, "$2\\,\\mathrm{H_2O(l)}$", c=R, side="left")
s.arrow((3.9, 4.95), (3.9, 1.95), c=O, lw=1.2); s.text(4.05, 3.4, "$-483.6$ kJ", va="center", size=8, c=O)
s.arrow((3.9, 1.85), (3.9, 0.65), c=R, lw=1.2); s.text(4.05, 1.25, "$-88$ kJ", va="center", size=8, c=R)
s.arrow((6.2, 4.95), (6.2, 0.65), c=INK, lw=1.4); s.text(6.4, 2.95, "$\\Delta H_{rxn}=-572$ kJ", va="center", size=8.5)
s.text(6.4, 2.45, "(sum of the steps)", va="center", size=7.5, c="#555555")
s.save("c04_hess")

# ---------- propane via formation enthalpies ----------
s = Sketch(12.5, 7.4)
y_el, y_r, y_p = 6.5, 5.85, 1.2
level(s, 4.6, 9.2, y_el, "$3\\,\\mathrm{C(gr)}+4\\,\\mathrm{H_2(g)}+5\\,\\mathrm{O_2(g)}$  (elements, $H\\equiv0$)", c=G, side="center", size=8)
level(s, 0.4, 3.4, y_r, "$\\mathrm{C_3H_8(g)}+5\\,\\mathrm{O_2(g)}$", c=B, side="center", size=8)
level(s, 0.4, 9.2, y_p, "$3\\,\\mathrm{CO_2(g)}+4\\,\\mathrm{H_2O(l)}$", c=R, side="center", size=8)
s.arrow((3.4, y_r), (4.6, y_el), c=G, lw=1.2)
s.text(2.2, y_r - 0.2, "1: \"unform\" the reactant\n$-\\Delta H_f^\\circ(\\mathrm{C_3H_8})=+104$ kJ", va="top", size=7.5, c=G)
s.arrow((7.6, y_el - 0.05), (7.6, y_p + 0.05), c=R, lw=1.2)
s.text(7.8, (y_el + y_p) / 2, "2: form the products\n$3(-394)+4(-286)$\n$=-2326$ kJ", va="center", size=7.5, c=R)
s.arrow((1.9, y_r - 0.05), (1.9, y_p + 0.05), c=INK, lw=1.4)
s.text(2.1, (y_r + y_p) / 2 - 0.5, "$\\Delta H^\\circ_{rxn}$\n$=+104-2326$\n$=-2222$ kJ", va="center", size=8)
s.text(12.3, y_p - 0.1, "(not to scale)", ha="right", va="top", size=7, c=GREY)
s.ax.set_ylim(y_p - 0.5, 7.4)
s.save("c04_propane")

# ---------- coffee cup calorimeter ----------
s = Sketch(5.0, 5.6)
s.polyfill([(1.0, 0.5), (4.0, 0.5), (4.3, 4.0), (0.7, 4.0)], c="#f0ece4")
s.curve([0.7, 1.0, 4.0, 4.3], [4.0, 0.5, 0.5, 4.0], c=INK, lw=1.0)
s.curve([0.95, 1.18, 3.82, 4.05], [3.7, 0.75, 0.75, 3.7], c=INK, lw=0.6)
s.polyfill([(1.18, 0.75), (3.82, 0.75), (3.98, 2.9), (1.02, 2.9)], c=FILL_B)
s.ax.add_patch(Rectangle((0.5, 4.0), 4.0, 0.35, fc="#e3dccf", ec=INK, lw=0.8))
s.seg((3.1, 5.3), (3.1, 1.2), lw=1.6, c="#777777"); s.dot((3.1, 1.2), c=R, r=4)
s.text(3.25, 5.2, "thermometer", size=7.5)
s.seg((1.9, 5.0), (1.9, 1.5), lw=1.0, c="#777777"); s.seg((1.6, 1.5), (2.2, 1.5), lw=1.0, c="#777777"); s.text(1.75, 5.0, "stirrer", ha="right", size=7.5)
s.text(2.5, 2.2, "solution", ha="center", size=8)
s.text(2.5, 0.1, "styrofoam cups ($P$ constant)", ha="center", va="top", size=7.5, c="#444444")
s.save("c04_calorimeter")
