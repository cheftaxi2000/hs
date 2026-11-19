from plot import *
from matplotlib.patches import Circle, Rectangle, Ellipse, FancyBboxPatch
import matplotlib.colors as mc

# ---------- Lewis symbols period 2 ----------
s = Sketch(15.0, 2.2)
els = [("Li", 1), ("Be", 2), ("B", 3), ("C", 4), ("N", 5), ("O", 6), ("F", 7), ("Ne", 8)]
pos = [(0, 1), (0, -1), (-1, 0), (1, 0)]   # top, bottom, left, right
for k, (e, n) in enumerate(els):
    cx, cy = 1.0 + k * 1.85, 1.15
    s.text(cx, cy, e, ha="center", va="center", size=12)
    counts = [0, 0, 0, 0]
    for i in range(n): counts[[3, 0, 1, 2][i % 4]] += 1   # right, top, bottom, left
    for side, c in zip(pos, counts):
        for j in range(c):
            off = (j - (c - 1) / 2) * 0.17
            dx, dy = side
            x = cx + dx * 0.42 + (off if dy else 0); y = cy + dy * 0.42 + (off if dx else 0)
            s.ax.add_patch(Circle((x, y), 0.045, fc=INK, ec="none", zorder=6))
    s.text(cx, 0.25, f"{n}", ha="center", size=7.5, c=GREY)
s.text(0.1, 0.25, "v.e.:", ha="left", size=7.5, c=GREY)
s.save("c07_lewis")

# ---------- H2 potential energy curve ----------
p = Plot(7.6, 4.8, (0, 3.2), (-4.9, 3.0), xt=[0.74], xtl=["$74$ pm"], yt=[], xl="$r$", yl="$E$")
r = np.linspace(0.38, 3.2, 300)
De, a, re = 4.5, 1.9, 0.74
p.curve(r, De * (1 - np.exp(-a * (r - re))) ** 2 - De, c=B)
p.vline(0.74, c=GREY, a=-4.6, b=0)
p.text(0.95, -4.55, "bond length: energy minimum", size=7.5)
p.arrow((2.3, -4.5), (2.3, -0.05), c=R, lw=0.9); p.arrow((2.3, -0.05), (2.3, -4.5), c=R, lw=0.9)
p.text(2.2, -3.0, "bond enthalpy\n(436 kJ/mol)", size=7.5, c=R, ha="right")
p.text(0.42, 2.4, "nuclei repel", size=7.5); p.text(2.6, 0.25, "far apart:\nno interaction", size=7.5, ha="center")
p.save("c07_h2curve")

# ---------- electronegativity table ----------
EN = [[("H", 2.1)], [("Li", 1.0), ("Be", 1.5), ("B", 2.0), ("C", 2.5), ("N", 3.0), ("O", 3.5), ("F", 4.0)],
      [("Na", 0.9), ("Mg", 1.2), ("Al", 1.5), ("Si", 1.8), ("P", 2.1), ("S", 2.5), ("Cl", 3.0)],
      [("K", 0.8), ("Ca", 1.0), ("Ga", 1.6), ("Ge", 1.8), ("As", 2.0), ("Se", 2.4), ("Br", 2.8)],
      [("Rb", 0.8), ("Sr", 1.0), ("In", 1.7), ("Sn", 1.8), ("Sb", 1.9), ("Te", 2.1), ("I", 2.5)],
      [("Cs", 0.7), ("Ba", 0.9), ("Tl", 1.8), ("Pb", 1.8), ("Bi", 1.9), ("Po", 2.0), ("At", 2.2)]]
cmap = mc.LinearSegmentedColormap.from_list("en", ["#f7f2e8", "#f2c14e", "#d4553a"])
s = Sketch(9.6, 6.9); u = 1.0
for r_, row in enumerate(EN):
    for c_, (e, v) in enumerate(row):
        x = 0.4 + c_ * u if r_ else 0.4; y = 6.3 - r_ * u
        s.ax.add_patch(FancyBboxPatch((x + 0.09, y - u + 0.09), u * 0.93 - 0.18, u * 0.93 - 0.18, boxstyle="round,pad=0.09", fc=cmap((v - 0.7) / 3.3), ec="none"))
        s.text(x + u * 0.47, y - u * 0.35, e, ha="center", va="center", size=9)
        s.text(x + u * 0.47, y - u * 0.75, f"{v:.1f}", ha="center", va="center", size=7.5)
s.arrow((7.75, 0.5), (7.75, 6.0), c=R, lw=1.1); s.text(7.9, 3.2, "increases\nupwards", size=7.5, c=R, va="center")
s.arrow((1.5, 6.55), (7.4, 6.55), c=R, lw=1.1); s.text(4.4, 6.65, "increases to the right", ha="center", size=7.5, c=R)
s.save("c07_EN")

# ---------- VSEPR shapes: shaded 3D renderings ----------
from mol3d import molecule as mol3, rot as R3
TET = [(0, 0, 1), (0.943, 0, -0.333), (-0.471, 0.816, -0.333), (-0.471, -0.816, -0.333)]
TBP = [(0, 0, 1), (0, 0, -1), (1, 0, 0), (-0.5, 0.866, 0), (-0.5, -0.866, 0)]
OCT = [(0, 0, 1), (0, 0, -1), (1, 0, 0), (-1, 0, 0), (0, 1, 0), (0, -1, 0)]
TRI = [(0, 0, 1), (0.866, 0, -0.5), (-0.866, 0, -0.5)]
LIN = [(1, 0, 0), (-1, 0, 0)]
V_up = R3("x", -1.30) @ R3("z", 0.42)      # z axis up, seen slightly from above
V_tri = R3("x", -1.42) @ R3("z", 0.12)   # planar molecules (xz-plane) almost face-on
V_tet = R3("x", -1.30) @ R3("z", 0.30)
LC, CC, LPC = "#e8705f", "#4a4f57", "#5f97d8"

def canvas(w, h):
    fig = plt.figure(figsize=(w / 2.54, h / 2.54)); ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(0, w); ax.set_ylim(0, h); ax.set_aspect("equal"); ax.axis("off"); return fig, ax
def finish(fig, ax, w, h, name):
    ax.set_xlim(0, w); ax.set_ylim(0, h)
    fig.savefig(os.path.join(OUT, name + ".svg"), format="svg", bbox_inches="tight", pad_inches=0.03)
    fig.savefig(os.path.join(PNG, name + ".png"), dpi=130, bbox_inches="tight", pad_inches=0.03); plt.close(fig)

# electron-domain geometries
W_, H_ = 15.5, 4.4
fig, ax = canvas(W_, H_)
data = [(LIN, V_tri, "2: linear", "180°"), (TRI, V_tri, "3: trigonal planar", "120°"), (TET, V_tet, "4: tetrahedral", "109.5°"),
        (TBP, V_up, "5: trigonal bipyramidal", "90°, 120°"), (OCT, V_up, "6: octahedral", "90°")]
for k, (L, V, lab, ang) in enumerate(data):
    cx = 1.55 + k * 3.1
    mol3(ax, cx, 2.55, L, R=1.15, Rm=V, rc=0.33, rl=0.25, ccol=CC, lcol=LC)
    ax.text(cx, 0.75, lab, ha="center", va="center", fontsize=7.5); ax.text(cx, 0.32, ang, ha="center", va="center", fontsize=7.5, color=R)
finish(fig, ax, W_, H_, "c07_domains")

# molecular geometries with lone pairs
W_, H_ = 15.5, 8.4
fig, ax = canvas(W_, H_)
rows = [[([TRI[1], TRI[2]], [TRI[0]], V_tri, "bent ($\\mathrm{SO_2}$)\n3 domains, 1 LP"),
         (TET[1:], [TET[0]], V_tet, "trigonal pyramidal ($\\mathrm{NH_3}$)\n4 domains, 1 LP"),
         ([(0.79, -0.62, 0), (-0.79, -0.62, 0)], [(0, 0.58, 0.81), (0, 0.58, -0.81)], R3("x", 0.12) @ R3("y", 0.62), "bent ($\\mathrm{H_2O}$)\n4 domains, 2 LP")],
        [([TBP[0], TBP[1], TBP[3], TBP[4]], [TBP[2]], V_up, "seesaw ($\\mathrm{SF_4}$)\n5 domains, 1 LP"),
         ([TBP[0], TBP[1], TBP[2]], [TBP[3], TBP[4]], V_up, "T-shaped ($\\mathrm{ClF_3}$)\n5 domains, 2 LP"),
         (OCT[1:], [OCT[0]], V_up, "square pyramidal ($\\mathrm{BrF_5}$)\n6 domains, 1 LP"),
         (OCT[2:], OCT[:2], V_up, "square planar ($\\mathrm{XeF_4}$)\n6 domains, 2 LP")]]
for r_, row in enumerate(rows):
    for k, (L, LP, V, lab) in enumerate(row):
        cx = 1.95 + k * 3.85 if r_ else 2.6 + k * 5.15; cy = 6.45 - r_ * 4.15
        mol3(ax, cx, cy, L, LP, R=1.15, Rm=V, rc=0.33, rl=0.25, ccol=CC, lcol=LC, lp_col=LPC)
        ax.text(cx, cy - 1.75, lab, ha="center", va="center", fontsize=7.2)
finish(fig, ax, W_, H_, "c07_shapes")

# ---------- bond type continuum ----------
s = Sketch(14.0, 2.4)
for i in range(200):
    x = 0.6 + i * 12.8 / 200
    s.ax.add_patch(Rectangle((x, 1.0), 12.8 / 200 + 0.01, 0.45, fc=plt.cm.RdBu_r(0.15 + 0.7 * i / 200), ec="none"))
for x, t1, t2 in [(0.6, "nonpolar covalent", "$\\Delta\\chi\\approx 0$:  $\\mathrm{Cl_2}$, $\\mathrm{N_2}$"), (7.0, "polar covalent", "$0.4<\\Delta\\chi<2$:  HF, $\\mathrm{H_2O}$"), (13.4, "ionic", "$\\Delta\\chi\\gtrsim 2$:  NaCl, LiF")]:
    s.text(x, 1.6, t1, ha="center" if 1 < x < 13 else ("left" if x < 1 else "right"), size=8.5)
    s.text(x, 0.85, t2, ha="center" if 1 < x < 13 else ("left" if x < 1 else "right"), va="top", size=7.5, c="#444444")
s.save("c07_continuum")
