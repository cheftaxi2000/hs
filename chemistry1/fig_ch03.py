from plot import *
from matplotlib.patches import Circle, FancyBboxPatch

OC, HC = "#e06a5a", "#f4f4f4"
def water(s, x, y, ang, sc=1.0):
    """water molecule, oxygen at (x,y), H atoms pointing in direction ang (rad)."""
    s.ax.add_patch(Circle((x, y), 0.26 * sc, fc=OC, ec="#555555", lw=0.5, zorder=4))
    for d in (-0.92, 0.92):
        a = ang + d
        s.ax.add_patch(Circle((x + 0.3 * sc * np.cos(a), y + 0.3 * sc * np.sin(a)), 0.15 * sc, fc=HC, ec="#555555", lw=0.5, zorder=5))

s = Sketch(13.0, 5.4)
for cx, ion, col, lab, out in [(3.2, "Na", "#9ec5e8", "$\\mathrm{Na^+}$", False), (9.6, "Cl", "#b8de9f", "$\\mathrm{Cl^-}$", True)]:
    r0 = 0.55 if ion == "Na" else 0.8
    s.ax.add_patch(Circle((cx, 2.7), r0, fc=col, ec=INK, lw=0.7, zorder=3))
    s.text(cx, 2.7, lab, ha="center", va="center", size=10)
    RR = r0 + 0.65
    for k in range(6 if ion == "Na" else 7):
        a = 2 * np.pi * k / (6 if ion == "Na" else 7) + 0.3
        x, y = cx + RR * np.cos(a), 2.7 + RR * np.sin(a)
        if out: x, y = cx + (RR + 0.25) * np.cos(a), 2.7 + (RR + 0.25) * np.sin(a)
        # Na+: oxygen points in (H outward); Cl-: one H points in
        water(s, x, y, a if not out else a + np.pi + 0.92)
    s.text(cx, 0.15, "O ($\\delta^-$) points to the cation" if not out else "H ($\\delta^+$) points to the anion", ha="center", va="bottom", size=8, c="#444444")
s.save("c03_hydration")

# water dipole
s = Sketch(4.4, 3.4)
water(s, 2.2, 1.9, -np.pi / 2, sc=2.6)
s.text(2.2, 2.75, "$\\delta^-$", ha="center", size=10, c=R)
s.text(1.1, 0.55, "$\\delta^+$", ha="center", size=10, c=B); s.text(3.3, 0.55, "$\\delta^+$", ha="center", size=10, c=B)
s.text(2.2, 1.9, "O", ha="center", va="center", size=10, z=9)
s.save("c03_water")

# activity series
s = Sketch(9.0, 8.2)
mets = ["Li", "K", "Ba", "Ca", "Na", "Mg", "Al", "Mn", "Zn", "Cr", "Fe", "Co", "Ni", "Sn", "Pb", "$\\mathbf{H_2}$", "Cu", "Ag", "Hg", "Pt", "Au"]
ions = ["Li$^+$", "K$^+$", "Ba$^{2+}$", "Ca$^{2+}$", "Na$^+$", "Mg$^{2+}$", "Al$^{3+}$", "Mn$^{2+}$", "Zn$^{2+}$", "Cr$^{3+}$", "Fe$^{2+}$", "Co$^{2+}$", "Ni$^{2+}$", "Sn$^{2+}$", "Pb$^{2+}$", "H$^+$", "Cu$^{2+}$", "Ag$^+$", "Hg$^{2+}$", "Pt$^{2+}$", "Au$^{3+}$"]
y0 = 7.6; dy = 0.35
for k, (m, i) in enumerate(zip(mets, ions)):
    y = y0 - k * dy
    c = R if k < 15 else (G if k == 15 else B)
    s.text(2.6, y, m, ha="right", va="center", size=8.5, c=INK if k != 15 else G)
    s.text(3.0, y, "$\\rightarrow$", ha="center", va="center", size=8)
    s.text(3.4, y, i + " + $n\\,e^-$", ha="left", va="center", size=8.5, c=INK if k != 15 else G)
s.seg((0.6, y0 - 14.5 * dy), (6.2, y0 - 14.5 * dy), c=G, lw=0.8, dash=(3, 2)); s.seg((0.6, y0 - 15.5 * dy), (6.2, y0 - 15.5 * dy), c=G, lw=0.8, dash=(3, 2))
s.arrow((7.0, y0 - 20 * dy), (7.0, y0), c=R, lw=1.4)
s.text(7.2, y0 - 0.1, "easily oxidised\n(reactive metals)", va="top", size=8, c=R)
s.text(7.2, y0 - 20 * dy + 0.1, "hardly oxidised\n(noble metals)", va="bottom", size=8, c=B)
s.text(7.2, y0 - 12.2 * dy, "react with acid\nto give $\\mathrm{H_2}$", va="center", size=7.5, c="#444444")
s.save("c03_activity")

# oxidation number ladder
p = Plot(13.5, 2.6, (-3.6, 7.8), (-1.1, 1), axes=False, grid=False)
p.seg((-3.6, 0), (7.6, 0), lw=0.7); p._head((7.8, 0), (1, 0))
for k in range(-3, 8):
    p.seg((k, -0.06), (k, 0.06), lw=0.6); p.text(k, -0.12, f"${k:+d}$" if k else "$0$", ha="center", va="top", size=7)
p.text(7.7, -0.12, "oxidation\nnumber", ha="right", va="top", size=7.5)
p.arrow((0.2, 0.62), (4.8, 0.62), c=R, lw=1.2); p.text(2.5, 0.7, "oxidation: lose $e^-$", c=R, ha="center")
p.arrow((4.8, -0.62), (0.2, -0.62), c=B, lw=1.2); p.text(2.5, -0.7, "reduction: gain $e^-$", c=B, ha="center", va="top")
for x, t in [(-3, "$\\mathrm{NH_3}$"), (0, "$\\mathrm{N_2}$"), (2, "NO"), (4, "$\\mathrm{NO_2}$"), (5, "$\\mathrm{HNO_3}$")]:
    p.text(x, 0.12, t, ha="center", size=8, c=P)
p.save("c03_oxladder")
