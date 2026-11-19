from plot import *
from matplotlib.patches import Circle, FancyBboxPatch

def box(s, x, y, w, h, t, fc="#eef6fb", ec=B, size=8, bold=False):
    s.ax.add_patch(FancyBboxPatch((x - w / 2, y - h / 2), w, h, boxstyle="round,pad=0.02,rounding_size=0.12", fc=fc, ec=ec, lw=0.8, zorder=3))
    s.ax.text(x, y, t, ha="center", va="center", fontsize=size, zorder=5, fontweight="bold" if bold else "normal")

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
    s.ax.add_patch(FancyBboxPatch((x + 0.08, y + 0.08), u * 0.94 - 0.16, u * 0.94 - 0.16, boxstyle="round,pad=0.08", fc=fc, ec="none", lw=0, zorder=2))
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
    s.ax.add_patch(FancyBboxPatch((xx + 0.05, y0 - 1.25 * u + 0.05), 0.25, 0.2, boxstyle="round,pad=0.05", fc=fc, ec="none")); s.text(xx + 0.45, y0 - 1.27 * u, t, size=7.5)
# block labels
for t, c0, c1 in [("s-block", 0, 2), ("d-block (transition metals)", 2, 12), ("p-block", 12, 18)]:
    s.text(x0 + (c0 + c1) / 2 * u, y0 - 7.0 * u - 0.32, t, ha="center", va="top", size=7, c=B)
s.text(x0 + 10.3 * u, y0 - 9.8 * u - 0.1, "f-block: lanthanides (*) and actinides (**)", ha="center", va="top", size=7, c=B)
s.save("c01_ptable")

# ---------- representations of methane ----------
s = Sketch(16.5, 3.9)
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
# ball and stick / space filling (shaded 3D spheres)
from mol3d import molecule, ball, rot
TET = [(0, 0, 1), (0.943, 0, -0.333), (-0.471, 0.816, -0.333), (-0.471, -0.816, -0.333)]
Rv = rot("x", -1.35) @ rot("z", 0.35)
molecule(s.ax, 12.1, 1.75, TET, R=1.3, Rm=Rv, rc=0.38, rl=0.27, ccol="#3d4148", lcol="#e9ecef")
# space filling: overlapping spheres sorted by depth
cx, cy = 15.0, 1.75
atoms = [(np.zeros(3), 0.78, "#3d4148")] + [(Rv @ np.array(v) * 0.72, 0.55, "#e9ecef") for v in TET]
for p3, r, c in sorted(atoms, key=lambda a: a[0][2]):
    ball(s.ax, cx + p3[0], cy + p3[1], r * (1 + 0.08 * p3[2]), c, z=10 + p3[2])
for x, t in [(1.3, "molecular\nformula"), (5.0, "structural\nformula"), (8.6, "perspective\ndrawing"), (12.1, "ball-and-stick"), (15.0, "space-filling")]:
    s.text(x, -0.05, t, ha="center", va="top", size=7.5, c="#444444")
s.ax.set_xlim(0, 16.5); s.ax.set_ylim(-0.75, 3.6)
s.save("c01_methane")

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
