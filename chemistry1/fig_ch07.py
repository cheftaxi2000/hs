from plot import *
from matplotlib.patches import Circle, Rectangle, Ellipse
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
        s.ax.add_patch(Rectangle((x, y - u), u * 0.95, u * 0.95, fc=cmap((v - 0.7) / 3.3), ec="#999999", lw=0.4))
        s.text(x + u * 0.47, y - u * 0.35, e, ha="center", va="center", size=9)
        s.text(x + u * 0.47, y - u * 0.75, f"{v:.1f}", ha="center", va="center", size=7.5)
s.arrow((7.75, 0.5), (7.75, 6.0), c=R, lw=1.1); s.text(7.9, 3.2, "increases\nupwards", size=7.5, c=R, va="center")
s.arrow((1.5, 6.55), (7.4, 6.55), c=R, lw=1.1); s.text(4.4, 6.65, "increases to the right", ha="center", size=7.5, c=R)
s.save("c07_EN")

# ---------- 3D molecule drawing helper ----------
def proj(v, az=0.35, el=0.25):
    ca, sa, ce_, se = np.cos(az), np.sin(az), np.cos(el), np.sin(el)
    x, y, z = v
    x1 = ca * x - sa * y; y1 = sa * x + ca * y
    return np.array([x1, ce_ * z - se * y1]), ce_ * y1 + se * z   # (2d, depth)
def molecule(ax, cx, cy, ligs, lps=(), sc=0.9, cc="#555555", lc="#e06a5a"):
    items = []
    for v in ligs:
        p2, d = proj(np.array(v) * sc); items.append((d, "L", p2))
    for v in lps:
        p2, d = proj(np.array(v) * sc * 0.75); items.append((d, "P", p2, v))
    items.sort(key=lambda t: t[0])
    def draw(it):
        if it[1] == "L":
            ax.plot([cx, cx + it[2][0]], [cy, cy + it[2][1]], color="#8a8a8a", lw=2.6, zorder=2 + (0 if it[0] > 0 else 6), solid_capstyle="round")
            ax.add_patch(Circle((cx + it[2][0], cy + it[2][1]), 0.22, fc=lc, ec="#555555", lw=0.6, zorder=3 + (0 if it[0] > 0 else 6)))
        else:
            v = np.array(it[3]); p2 = it[2]; ang = np.degrees(np.arctan2(p2[1], p2[0]))
            L = np.hypot(*p2)
            ax.add_patch(Ellipse((cx + p2[0] * 0.62, cy + p2[1] * 0.62), max(L * 1.1, 0.35), 0.42, angle=ang, fc="#cfe0f2", ec=B, lw=0.6, alpha=0.85, zorder=2 + (0 if it[0] > 0 else 6)))
    for it in items: draw(it)
    ax.add_patch(Circle((cx, cy), 0.28, fc=cc, ec=INK, lw=0.6, zorder=5))
t = np.radians
TET = [(0, 0, 1), (0.943, 0, -0.333), (-0.471, 0.816, -0.333), (-0.471, -0.816, -0.333)]
TBP = [(0, 0, 1), (0, 0, -1), (1, 0, 0), (-0.5, 0.866, 0), (-0.5, -0.866, 0)]
OCT = [(0, 0, 1), (0, 0, -1), (1, 0, 0), (-1, 0, 0), (0, 1, 0), (0, -1, 0)]
TRI = [(0, 0, 1), (0.866, 0, -0.5), (-0.866, 0, -0.5)]
LIN = [(1, 0, 0), (-1, 0, 0)]

# electron-domain geometries
fig = plt.figure(figsize=(15.5 / 2.54, 3.6 / 2.54)); ax = fig.add_axes([0, 0, 1, 1]); ax.set_xlim(0, 15.5); ax.set_ylim(0, 3.6); ax.set_aspect("equal"); ax.axis("off")
data = [(LIN, "2: linear", "180°"), (TRI, "3: trigonal planar", "120°"), (TET, "4: tetrahedral", "109.5°"), (TBP, "5: trigonal bipyramidal", "90°, 120°"), (OCT, "6: octahedral", "90°")]
for k, (L, lab, ang) in enumerate(data):
    cx = 1.55 + k * 3.1
    molecule(ax, cx, 2.05, L, sc=1.0)
    ax.text(cx, 0.55, lab, ha="center", va="center", fontsize=7.5); ax.text(cx, 0.15, ang, ha="center", va="center", fontsize=7.5, color=R)
fig.savefig(os.path.join(OUT, "c07_domains.svg"), format="svg", bbox_inches="tight", pad_inches=0.03); fig.savefig(os.path.join(PNG, "c07_domains.png"), dpi=130, bbox_inches="tight"); plt.close(fig)

# molecular geometries with lone pairs
rows = [
    [(TRI[:2] if False else [TRI[1], TRI[2]], [TRI[0]], "bent ($\\mathrm{SO_2}$)\n3 domains, 1 LP"),
     (TET[1:], [TET[0]], "trigonal pyramidal ($\\mathrm{NH_3}$)\n4 domains, 1 LP"),
     (TET[2:], TET[:2], "bent ($\\mathrm{H_2O}$)\n4 domains, 2 LP")],
    [([TBP[0], TBP[1], TBP[3], TBP[4]], [TBP[2]], "seesaw ($\\mathrm{SF_4}$)\n5 domains, 1 LP"),
     ([TBP[0], TBP[1], TBP[2]], [TBP[3], TBP[4]], "T-shaped ($\\mathrm{ClF_3}$)\n5 domains, 2 LP"),
     (OCT[1:], [OCT[0]], "square pyramidal ($\\mathrm{BrF_5}$)\n6 domains, 1 LP"),
     (OCT[2:], OCT[:2], "square planar ($\\mathrm{XeF_4}$)\n6 domains, 2 LP")]]
fig = plt.figure(figsize=(15.5 / 2.54, 7.4 / 2.54)); ax = fig.add_axes([0, 0, 1, 1]); ax.set_xlim(0, 15.5); ax.set_ylim(0, 7.4); ax.set_aspect("equal"); ax.axis("off")
for r_, row in enumerate(rows):
    for k, (L, LP, lab) in enumerate(row):
        cx = 1.95 + k * 3.85 if r_ else 2.6 + k * 5.15; cy = 5.6 - r_ * 3.7
        molecule(ax, cx, cy, L, LP, sc=1.0)
        ax.text(cx, cy - 1.55, lab, ha="center", va="center", fontsize=7.2)
fig.savefig(os.path.join(OUT, "c07_shapes.svg"), format="svg", bbox_inches="tight", pad_inches=0.03); fig.savefig(os.path.join(PNG, "c07_shapes.png"), dpi=130, bbox_inches="tight"); plt.close(fig)

# ---------- bond type continuum ----------
s = Sketch(14.0, 2.4)
for i in range(200):
    x = 0.6 + i * 12.8 / 200
    s.ax.add_patch(Rectangle((x, 1.0), 12.8 / 200 + 0.01, 0.45, fc=plt.cm.RdBu_r(0.15 + 0.7 * i / 200), ec="none"))
for x, t1, t2 in [(0.6, "nonpolar covalent", "$\\Delta\\chi\\approx 0$:  $\\mathrm{Cl_2}$, $\\mathrm{N_2}$"), (7.0, "polar covalent", "$0.4<\\Delta\\chi<2$:  HF, $\\mathrm{H_2O}$"), (13.4, "ionic", "$\\Delta\\chi\\gtrsim 2$:  NaCl, LiF")]:
    s.text(x, 1.6, t1, ha="center" if 1 < x < 13 else ("left" if x < 1 else "right"), size=8.5)
    s.text(x, 0.85, t2, ha="center" if 1 < x < 13 else ("left" if x < 1 else "right"), va="top", size=7.5, c="#444444")
s.save("c07_continuum")
