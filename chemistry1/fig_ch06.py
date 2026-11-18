from plot import *
from matplotlib.patches import Circle, Rectangle, FancyBboxPatch
import matplotlib.colors as mc
import sys; sys.path.insert(0, ".")

# ---------- wave ----------
p = Plot(8.5, 3.0, (0, 10.5), (-1.5, 1.6), xt=[], yt=[], xl="", yl="", axes=False)
p.hline(0, c=GREY, dash=(3, 2), a=0, b=10.5)
p.f(lambda x: np.sin(2 * np.pi * x / 3.2), a=0, b=10.3, c=B)
p.arrow((0.8, 1.25), (4.0, 1.25), c=R); p.arrow((4.0, 1.25), (0.8, 1.25), c=R); p.text(2.4, 1.32, "$\\lambda$", c=R, ha="center")
p.arrow((7.2, 0), (7.2, 1.0), c=G); p.text(7.35, 0.45, "amplitude", c=G, size=7.5)
p.arrow((8.9, -1.15), (10.3, -1.15), c=INK); p.text(9.6, -1.25, "$c$", ha="center", va="top")
p.save("c06_wave")

# ---------- hydrogen spectrum (Balmer) ----------
def wl2rgb(w):
    if w < 440: r, g, b = -(w - 440) / 60, 0, 1
    elif w < 490: r, g, b = 0, (w - 440) / 50, 1
    elif w < 510: r, g, b = 0, 1, -(w - 510) / 20
    elif w < 580: r, g, b = (w - 510) / 70, 1, 0
    elif w < 645: r, g, b = 1, -(w - 645) / 65, 0
    else: r, g, b = 1, 0, 0
    return (r, g, b)
s = Sketch(13.0, 3.6)
x0, x1, w0, w1 = 0.8, 12.6, 380, 720
X = lambda w: x0 + (w - w0) / (w1 - w0) * (x1 - x0)
for w in np.linspace(380, 720, 340):
    s.ax.add_patch(Rectangle((X(w), 2.3), (x1 - x0) / 340 + 0.01, 0.9, fc=wl2rgb(w), ec="none"))
s.text((x0 + x1) / 2, 3.3, "white light: continuous spectrum", ha="center", size=8)
s.ax.add_patch(Rectangle((x0, 0.8), x1 - x0, 0.9, fc="#111111", ec="none"))
for w, lab in [(410.2, "410"), (434.0, "434"), (486.1, "486"), (656.3, "656")]:
    s.ax.add_patch(Rectangle((X(w) - 0.04, 0.8), 0.08, 0.9, fc=wl2rgb(w), ec="none"))
    s.text(X(w), 0.7, lab, ha="center", va="top", size=7.5)
s.text((x0 + x1) / 2, 0.1, "hydrogen: line spectrum (visible Balmer lines, nm)", ha="center", va="top", size=8)
s.save("c06_spectrum")

# ---------- Bohr energy levels ----------
s = Sketch(8.0, 6.4)
sc = 5.0 / 13.6
def y(n): return 5.9 - 13.6 / n ** 2 * sc
for n in [1, 2, 3, 4, 5, 6]:
    s.seg((1.2, y(n)), (5.0, y(n)), lw=1.2, c=INK if n < 6 else GREY)
    if n < 5: s.text(0.95, y(n), f"$n={n}$", ha="right", va="center", size=8); s.text(5.15, y(n), f"${-13.6/n**2:.2f}$ eV", va="center", size=7.5)
s.seg((1.2, 5.9), (5.0, 5.9), lw=1.0, c=GREY, dash=(3, 2)); s.text(0.95, 5.9, "$n=\\infty$", ha="right", va="center", size=8); s.text(5.15, 5.95, "0 (ionised)", va="center", size=7.5)
# Lyman / Balmer arrows
for k, (a, b, c) in enumerate([(2, 1, "#6b4c9a"), (3, 1, "#6b4c9a"), (4, 1, "#6b4c9a")]):
    s.arrow((1.5 + 0.25 * k, y(a)), (1.5 + 0.25 * k, y(b)), c=c, lw=1.0)
for k, (a, c) in enumerate([(3, "#d0302a"), (4, "#16a0a0"), (5, "#3060d0")]):
    s.arrow((3.2 + 0.3 * k, y(a)), (3.2 + 0.3 * k, y(2)), c=c, lw=1.0)
s.text(1.75, y(1) - 0.15, "Lyman (UV)", ha="center", va="top", size=7.5, c=P)
s.text(3.5, y(2) - 0.15, "Balmer (visible)", ha="center", va="top", size=7.5, c=R)
s.ax.set_ylim(0.3, 6.3)
s.save("c06_bohr")

# ---------- orbital shapes: density cuts ----------
import importlib.util, types
src = open('fig_cover.py').read().split('orbs = [')[0]
mod = types.ModuleType('fc'); exec(src, mod.__dict__); psi = mod.psi
def orb_img(n, l, m, ext, N=300, rot=False):
    t = np.linspace(-ext, ext, N); X_, Z_ = np.meshgrid(t, t)
    if rot: X_, Z_ = (X_ + Z_) / np.sqrt(2), (Z_ - X_) / np.sqrt(2)
    ps = psi(n, l, m, X_, Z_); d = ps * ps; d = (d / d.max()) ** 0.5
    pos = np.array(mc.to_rgb(B)); neg = np.array(mc.to_rgb(R))
    col = np.where(ps[..., None] > 0, pos, neg)
    return 1 - d[..., None] * (1 - col)
fig = plt.figure(figsize=(15.5 / 2.54, 4.4 / 2.54))
items = [((1, 0, 0), 5, "1s", False), ((2, 0, 0), 12, "2s", False), ((3, 0, 0), 21, "3s", False),
         ((2, 1, 0), 11, "$2p_z$", False), ((2, 1, 1), 11, "$2p_x$", False), ((3, 2, 0), 18, "$3d_{z^2}$", False), ((3, 2, 1), 18, "$3d_{xz}$", True)]
for k, (q, ext, lab, rot) in enumerate(items):
    ax = fig.add_axes([k / 7 + 0.005, 0.18, 1 / 7 - 0.01, 0.8]); ax.axis("off")
    ax.imshow(orb_img(*q, ext, rot=rot), origin="lower", extent=(-1, 1, -1, 1), interpolation="bicubic")
    ax.text(0, -1.12, lab, ha="center", va="top", fontsize=9)
fig.savefig(os.path.join(OUT, "c06_orbitals.svg"), format="svg", bbox_inches="tight", pad_inches=0.03)
fig.savefig(os.path.join(PNG, "c06_orbitals.png"), dpi=130, bbox_inches="tight", pad_inches=0.03); plt.close(fig)

# ---------- orbital energy diagrams ----------
s = Sketch(15.6, 6.6)
def boxes(x, yy, k, lab, c=INK):
    for i in range(k): s.ax.add_patch(Rectangle((x + i * 0.42, yy), 0.4, 0.32, fc="white", ec=c, lw=0.8, zorder=3))
    s.text(x - 0.1, yy + 0.16, lab, ha="right", va="center", size=7.5)
# hydrogen
H = {1: 0.6, 2: 3.4, 3: 4.7, 4: 5.5}
for n, yy in H.items():
    boxes(1.0, yy, 1, f"{n}s")
    if n >= 2: boxes(1.9, yy, 3, f"{n}p" if False else "")
    if n >= 3: boxes(3.3, yy, 5, "")
    if n >= 4: boxes(5.5, yy, 7, "")
for n, yy in H.items():
    for x, lab, cond in [(1.9, "p", n >= 2), (3.3, "d", n >= 3), (5.5, "f", n >= 4)]:
        if cond: s.text(x + 0.0, yy + 0.42, f"{n}{lab}", size=6.5, c="#555555")
s.text(3.4, 6.35, "hydrogen: energy depends only on $n$", ha="center", size=8)
# multielectron
M = [("1s", 1, 0.6), ("2s", 1, 2.6), ("2p", 3, 3.2), ("3s", 1, 4.0), ("3p", 3, 4.5), ("4s", 1, 5.0), ("3d", 5, 5.3), ("4p", 3, 5.85)]
xs = {"s": 10.4, "p": 11.5, "d": 13.1}
for lab, k, yy in M:
    boxes(xs[lab[1]], yy, k, lab)
s.text(12.2, 6.35, "many-electron atom: $s<p<d$ within a shell", ha="center", size=8)
s.arrow((9.1, 0.5), (9.1, 6.0), c=INK, lw=0.8); s.text(8.95, 6.0, "$E$", ha="right", va="top", size=9)
s.save("c06_levels")

# ---------- filling order diagram ----------
s = Sketch(6.4, 6.6)
rows = [["1s"], ["2s", "2p"], ["3s", "3p", "3d"], ["4s", "4p", "4d", "4f"], ["5s", "5p", "5d", "5f"], ["6s", "6p", "6d"], ["7s", "7p"]]
for i, r in enumerate(rows):
    for j, t in enumerate(r):
        s.text(0.8 + j * 1.3, 6.1 - i * 0.85, t, ha="center", va="center", size=9)
for k in range(8):
    # diagonal through cells with i + j = k (approx)
    pts = [(i, k - i) for i in range(7) if 0 <= k - i < len(rows[i]) and k - i <= i]
    pts = [(i, j) for i in range(7) for j in range(len(rows[i])) if i + j == k + (0)]
order = []
for t in range(1, 9):
    cells = [(i, j) for i in range(7) for j in range(len(rows[i])) if (i + 1) + j == t]
    cells.sort(key=lambda c: -c[0])
    if not cells: continue
    a, b = cells[0], cells[-1]
    pa = (0.8 + a[1] * 1.3 - 0.35, 6.1 - a[0] * 0.85 - 0.3); pb = (0.8 + b[1] * 1.3 + 0.35, 6.1 - b[0] * 0.85 + 0.3)
    s.arrow(pb, pa, c=R, lw=0.8)
s.save("c06_aufbau")

# ---------- periodic trends ----------
IE = [1312, 2372, 520, 899, 801, 1086, 1402, 1314, 1681, 2081, 496, 738, 578, 787, 1012, 1000, 1251, 1521, 419, 590, 633, 659, 651, 653, 717, 762, 760, 737, 745, 906, 579, 762, 947, 941, 1140, 1351, 403]
RA = [31, 28, 128, 96, 84, 76, 71, 66, 57, 58, 166, 141, 121, 111, 107, 105, 102, 106, 203, 176, 170, 160, 153, 139, 139, 132, 126, 124, 132, 122, 122, 120, 119, 120, 120, 116, 220]
SYM = "H He Li Be B C N O F Ne Na Mg Al Si P S Cl Ar K Ca Sc Ti V Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr Rb".split()
Z = np.arange(1, 38)
for name, data, ylim, yt, yl, lab_idx in [("c06_IE", IE, (0, 2650), [500, 1000, 1500, 2000, 2500], "$I_1$", [1, 9, 17, 35, 2, 10, 18, 36]),
                                          ("c06_radius", RA, (0, 245), [50, 100, 150, 200], "$r$", [2, 10, 18, 36, 8, 16, 34])]:
    p = Plot(13.0, 4.8, (0, 39), ylim, xt=[2, 10, 18, 36], yt=yt, xl="$Z$", yl=yl)
    for z0, z1 in [(2, 10), (10, 18), (18, 36)]: p.polyfill([(z0 + 0.5, 0), (z1 + 0.5, 0), (z1 + 0.5, ylim[1]), (z0 + 0.5, ylim[1])], c="#f6f3ee" if z0 != 10 else "#eef3f6")
    p.curve(Z, data, c=B, lw=1.0)
    for z, v in zip(Z, data): p.dot((z, v), c=B, r=2.0)
    for i in lab_idx:
        z = i + 1 if False else i
        zz = [k for k, sname in enumerate(SYM) if k == i][0]
        dy = 0.04 * ylim[1]
        p.text(zz + 1, data[zz] + dy, SYM[zz], ha="center", size=7.5, c=R)
    p.save(name)
