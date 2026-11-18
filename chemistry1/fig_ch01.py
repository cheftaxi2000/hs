from plot import *
from matplotlib.patches import Circle, FancyBboxPatch

def box(s, x, y, w, h, t, fc="#eef6fb", ec=B, size=8, bold=False):
    s.ax.add_patch(FancyBboxPatch((x - w / 2, y - h / 2), w, h, boxstyle="round,pad=0.02,rounding_size=0.12", fc=fc, ec=ec, lw=0.8, zorder=3))
    s.ax.text(x, y, t, ha="center", va="center", fontsize=size, zorder=5, fontweight="bold" if bold else "normal")

# ---------- classification of matter ----------
s = Sketch(14, 6.2)
box(s, 7, 5.6, 2.6, 0.7, "Matter", bold=True, fc="#f4f4f4", ec=INK)
box(s, 3.6, 4.1, 3.6, 0.7, "Pure substance", fc=FILL_B, ec=B)
box(s, 10.4, 4.1, 3.0, 0.7, "Mixture", fc=FILL_R, ec=R)
for a, b in [((7, 5.25), (3.6, 4.45)), ((7, 5.25), (10.4, 4.45))]: s.seg(a, b, c=GREY, lw=0.8)
box(s, 1.9, 2.5, 2.6, 0.7, "Element", fc=FILL_B, ec=B); box(s, 5.3, 2.5, 2.6, 0.7, "Compound", fc=FILL_B, ec=B)
box(s, 8.8, 2.5, 2.9, 0.7, "Homogeneous", fc=FILL_R, ec=R); box(s, 12.1, 2.5, 2.9, 0.7, "Heterogeneous", fc=FILL_R, ec=R)
for a, b in [((3.6, 3.75), (1.9, 2.85)), ((3.6, 3.75), (5.3, 2.85)), ((10.4, 3.75), (8.8, 2.85)), ((10.4, 3.75), (12.1, 2.85))]: s.seg(a, b, c=GREY, lw=0.8)
for x, t in [(1.9, "one kind of atom\n$\\mathrm{O_2}$, Fe, He"), (5.3, "fixed ratio of elements\n$\\mathrm{H_2O}$, NaCl"),
             (8.8, "uniform throughout\nair, mineral water"), (12.1, "not uniform\nmilk, granite, sand + water")]:
    s.text(x, 1.95, t, ha="center", va="top", size=7.5, c="#444444")
s.text(7, 4.2, "separate by\nphysical means", ha="center", va="center", size=7, c=GREY)
s.ax.set_ylim(1.15, 6.2)
s.save("c01_matter")

# ---------- periodic table ----------
EL = """H,,,,,,,,,,,,,,,,,He
Li,Be,,,,,,,,,,,B,C,N,O,F,Ne
Na,Mg,,,,,,,,,,,Al,Si,P,S,Cl,Ar
K,Ca,Sc,Ti,V,Cr,Mn,Fe,Co,Ni,Cu,Zn,Ga,Ge,As,Se,Br,Kr
Rb,Sr,Y,Zr,Nb,Mo,Tc,Ru,Rh,Pd,Ag,Cd,In,Sn,Sb,Te,I,Xe
Cs,Ba,*,Hf,Ta,W,Re,Os,Ir,Pt,Au,Hg,Tl,Pb,Bi,Po,At,Rn
Fr,Ra,**,Rf,Db,Sg,Bh,Hs,Mt,Ds,Rg,Cn,Nh,Fl,Mc,Lv,Ts,Og"""
LA = "La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu".split()
AC = "Ac Th Pa U Np Pu Am Cm Bk Cf Es Fm Md No Lr".split()
NONMET = set("H He C N O F Ne P S Cl Ar Se Br Kr I Xe Rn Og Ts".split())
METALLOID = set("B Si Ge As Sb Te At".split())
CM, CN, CMD = "#f1e3c8", "#d3eadf", "#e0d8ef"
s = Sketch(16.4, 9.9); u = 0.86; x0, y0 = 0.75, 8.6
rows = [r.split(",") for r in EL.split("\n")]
def cell(x, y, t, fc, z=None):
    s.ax.add_patch(plt.Rectangle((x, y), u * 0.94, u * 0.94, fc=fc, ec="#9a9a9a", lw=0.4, zorder=2))
    if z: s.ax.text(x + 0.06, y + u * 0.88, str(z), fontsize=4.6, va="top", ha="left", color="#555555", zorder=4)
    s.ax.text(x + u * 0.47, y + u * 0.40, t, fontsize=7.5, ha="center", va="center", zorder=4)
Zs = {}; z = 0
order = [rows[0]] + rows[1:]
# atomic numbers in reading order including La/Ac series
seq = ["H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne", "Na", "Mg", "Al", "Si", "P", "S", "Cl", "Ar"] + rows[3] + rows[4] + \
      ["Cs", "Ba"] + LA + rows[5][3:] + ["Fr", "Ra"] + AC + rows[6][3:]
for k, e in enumerate(seq): Zs[e] = k + 1
for r, row in enumerate(rows):
    for c, e in enumerate(row):
        if not e: continue
        x, y = x0 + c * u, y0 - (r + 1) * u
        if e in ("*", "**"): cell(x, y, "", "#f4f4f4"); s.ax.text(x + u * 0.47, y + u * 0.42, e, fontsize=7, ha="center", va="center", zorder=4); continue
        fc = CN if e in NONMET else CMD if e in METALLOID else CM
        cell(x, y, e, fc, Zs[e])
for k, (lst, star) in enumerate([(LA, "*"), (AC, "**")]):
    y = y0 - 8.75 * u - k * u
    s.ax.text(x0 + 2.85 * u, y + u * 0.42, star, fontsize=7, ha="right", va="center")
    for c, e in enumerate(lst): cell(x0 + (3 + c) * u, y, e, CM, Zs[e])
for c in range(18): s.ax.text(x0 + c * u + u * 0.47, y0 + 0.08, str(c + 1), fontsize=6.5, ha="center", va="bottom", color="#555555")
for r in range(7): s.ax.text(x0 - 0.12, y0 - (r + 1) * u + u * 0.42, str(r + 1), fontsize=6.5, ha="right", va="center", color="#555555")
s.text(x0 + 9 * u, y0 + 0.42, "group", ha="center", size=7, c="#555555")
s.text(x0 - 0.55, y0 - 4 * u, "period", ha="center", va="center", size=7, c="#555555", rotation=90)
# legend
for k, (fc, t) in enumerate([(CM, "metal"), (CMD, "metalloid"), (CN, "nonmetal")]):
    xx = x0 + 3.2 * u + k * 2.2
    s.ax.add_patch(plt.Rectangle((xx, y0 - 1.25 * u), 0.35, 0.3, fc=fc, ec="#9a9a9a", lw=0.4)); s.text(xx + 0.45, y0 - 1.27 * u, t, size=7.5)
# block labels
for t, c0, c1 in [("s-block", 0, 2), ("d-block (transition metals)", 2, 12), ("p-block", 12, 18)]:
    s.text(x0 + (c0 + c1) / 2 * u, y0 - 7.0 * u - 0.32, t, ha="center", va="top", size=7, c=B)
s.text(x0 + 10.3 * u, y0 - 9.8 * u - 0.1, "f-block: lanthanides (*) and actinides (**)", ha="center", va="top", size=7, c=B)
s.save("c01_ptable")

# ---------- representations of methane ----------
s = Sketch(15.6, 3.7)
s.text(1.3, 1.8, "$\\mathrm{CH_4}$", ha="center", va="center", size=13)
# structural formula
cx, cy = 5.0, 1.85
s.text(cx, cy, "C", ha="center", va="center", size=12)
for dx_, dy_ in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
    s.seg((cx + 0.28 * dx_, cy + 0.3 * dy_), (cx + 0.9 * dx_, cy + 0.9 * dy_), lw=1.0)
    s.text(cx + 1.15 * dx_, cy + 1.12 * dy_ - (0.05 if dy_ else 0), "H", ha="center", va="center", size=11)
# perspective drawing (wedge / dash)
cx, cy = 8.6, 1.7
s.text(cx, cy, "C", ha="center", va="center", size=12)
s.seg((cx, cy + 0.3), (cx, cy + 1.0), lw=1.0); s.text(cx, cy + 1.28, "H", ha="center", va="center", size=11)
s.seg((cx - 0.25, cy - 0.18), (cx - 0.95, cy - 0.65), lw=1.0); s.text(cx - 1.18, cy - 0.82, "H", ha="center", va="center", size=11)
s.polyfill([(cx + 0.25, cy - 0.15), (cx + 0.95, cy - 0.4), (cx + 0.85, cy - 0.7)], c=INK, z=5)
s.text(cx + 1.17, cy - 0.7, "H", ha="center", va="center", size=11)
for k in range(5):
    f_ = 0.25 + k * 0.15
    s.seg((cx + 0.15 * 0 + f_ * 0.0 + 0.0 + 0.0 + 0.0, cy - 0.25 - f_ * 0.65), (cx + 0.0 + 0.0, cy - 0.25 - f_ * 0.65), lw=0)
for k in range(6):
    t_ = 0.15 + k * 0.14; L_ = 0.06 + 0.05 * k
    yy = cy - 0.25 - t_ * 0.7; xx = cx + 0.03
    s.seg((xx - L_ * 0.5, yy - 0.0), (xx + L_ * 0.5, yy), lw=0.8)
s.text(cx + 0.02, cy - 1.32, "H", ha="center", va="center", size=11)
# ball and stick
cx, cy = 12.0, 1.75
Hs = [(0, 1.15), (-1.05, -0.45), (0.85, -0.65), (0.25, -0.15)]
for hx, hy in Hs[:3]: s.seg((cx, cy), (cx + hx, cy + hy), lw=2.2, c="#9a9a9a")
s.seg((cx, cy), (cx + 0.55, cy + 0.15), lw=2.2, c="#b9b9b9")
s.ax.add_patch(Circle((cx + 0.6, cy + 0.17), 0.24, fc="#e6e6e6", ec="#7a7a7a", lw=0.6, zorder=3))
s.ax.add_patch(Circle((cx, cy), 0.42, fc="#3a3a3a", ec=INK, lw=0.6, zorder=4))
for hx, hy in Hs[:3]: s.ax.add_patch(Circle((cx + hx, cy + hy), 0.28, fc="#f4f4f4", ec="#7a7a7a", lw=0.6, zorder=5))
# space filling
cx, cy = 14.6, 1.75
s.ax.add_patch(Circle((cx + 0.35, cy + 0.12), 0.52, fc="#e6e6e6", ec="#7a7a7a", lw=0.6, zorder=2))
s.ax.add_patch(Circle((cx, cy), 0.75, fc="#3a3a3a", ec=INK, lw=0.6, zorder=3))
for hx, hy in [(0, 0.78), (-0.72, -0.35), (0.6, -0.5)]: s.ax.add_patch(Circle((cx + hx, cy + hy), 0.5, fc="#f4f4f4", ec="#7a7a7a", lw=0.6, zorder=4))
for x, t in [(1.3, "molecular\nformula"), (5.0, "structural\nformula"), (8.6, "perspective\ndrawing"), (12.0, "ball-and-stick"), (14.6, "space-filling")]:
    s.text(x, -0.05, t, ha="center", va="top", size=7.5, c="#444444")
s.ax.set_ylim(-0.75, 3.4)
s.save("c01_methane")

# ---------- mole map ----------
s = Sketch(14.5, 3.4)
box(s, 2.0, 1.7, 2.8, 1.0, "mass $m$\n(g)", fc=FILL_G, ec=G)
box(s, 7.25, 1.7, 2.8, 1.0, "amount $n$\n(mol)", fc=FILL_B, ec=B, bold=False)
box(s, 12.5, 1.7, 2.8, 1.0, "number $N$\n(particles)", fc=FILL_R, ec=R)
s.arrow((3.5, 1.95), (5.75, 1.95), c=INK); s.arrow((5.75, 1.45), (3.5, 1.45), c=INK)
s.arrow((8.75, 1.95), (11.0, 1.95), c=INK); s.arrow((11.0, 1.45), (8.75, 1.45), c=INK)
s.text(4.62, 2.05, "$\\div\\, M$", ha="center", size=9); s.text(4.62, 1.35, "$\\times\\, M$", ha="center", va="top", size=9)
s.text(9.87, 2.05, "$\\times\\, N_A$", ha="center", size=9); s.text(9.87, 1.35, "$\\div\\, N_A$", ha="center", va="top", size=9)
s.text(4.62, 0.45, "$M$ = molar mass (g/mol)", ha="center", size=7.5, c="#444444")
s.text(9.87, 0.45, "$N_A = 6.022\\times10^{23}\\,\\mathrm{mol^{-1}}$", ha="center", size=7.5, c="#444444")
s.save("c01_molemap")

# ---------- stoichiometry road map ----------
s = Sketch(15.6, 3.2)
xs_ = [1.6, 5.3, 10.3, 14.0]
box(s, xs_[0], 2.2, 2.5, 0.8, "grams of A", fc=FILL_G, ec=G); box(s, xs_[1], 2.2, 2.5, 0.8, "moles of A", fc=FILL_B, ec=B)
box(s, xs_[2], 2.2, 2.5, 0.8, "moles of B", fc=FILL_B, ec=B); box(s, xs_[3], 2.2, 2.5, 0.8, "grams of B", fc=FILL_G, ec=G)
s.arrow((2.9, 2.2), (4.0, 2.2)); s.arrow((6.6, 2.2), (9.0, 2.2), c=R, lw=1.4); s.arrow((11.6, 2.2), (12.7, 2.2))
s.text(3.45, 1.55, "$\\div\\, M_A$", ha="center", va="top", size=8.5); s.text(13.15, 1.55, "$\\times\\, M_B$", ha="center", va="top", size=8.5)
s.text(7.8, 1.55, "$\\times\\,\\dfrac{\\nu_B}{\\nu_A}$  (coefficients)", ha="center", va="top", size=8.5, c=R)
s.text(7.8, 0.35, "the balanced equation is the only bridge between A and B", ha="center", size=7.5, c="#444444")
s.save("c01_stoichmap")

# ---------- H2 + O2 particle picture ----------
s = Sketch(13.5, 3.0)
def mol(atoms, c):
    for (x, y, r, fc) in atoms: s.ax.add_patch(Circle((x, y), r, fc=fc, ec="#555555", lw=0.6, zorder=3))
H_, O_ = "#f4f4f4", "#e06a5a"
def h2(x, y): mol([(x - 0.17, y, 0.22, H_), (x + 0.17, y, 0.22, H_)], 0)
def o2(x, y): mol([(x - 0.22, y, 0.3, O_), (x + 0.22, y, 0.3, O_)], 0)
def h2o(x, y): mol([(x, y, 0.32, O_), (x - 0.3, y - 0.24, 0.2, H_), (x + 0.3, y - 0.24, 0.2, H_)], 0)
h2(1.0, 2.0); h2(1.0, 1.0); s.text(2.0, 1.5, "+", ha="center", va="center", size=12); o2(3.0, 1.5)
s.arrow((4.3, 1.5), (6.0, 1.5)); h2o(7.0, 2.0); h2o(7.0, 0.95)
s.text(1.0, 0.25, "2 $\\mathrm{H_2}$", ha="center", size=8.5); s.text(3.0, 0.25, "$\\mathrm{O_2}$", ha="center", size=8.5); s.text(7.0, 0.1, "2 $\\mathrm{H_2O}$", ha="center", size=8.5)
s.text(9.0, 1.9, "left: 4 H, 2 O", size=8.5); s.text(9.0, 1.25, "right: 4 H, 2 O", size=8.5); s.text(9.0, 0.55, "atoms are only regrouped", size=8, c=G)
s.save("c01_h2o2")
