"""Cover: contour lines of hydrogen orbitals (Chapter 6), in the line-art style of the
Mechanik (trochoids) and Analysis (star polygons) covers."""
import numpy as np, matplotlib
matplotlib.use("svg")
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap
from orbitals import psi
W, H = 21.0, 18.6
fig = plt.figure(figsize=(W / 2.54, H / 2.54)); ax = fig.add_axes([0, 0, 1, 1])
ax.set_xlim(0, W); ax.set_ylim(0, H); ax.axis("off"); ax.set_aspect("equal")
BG = "#4a1430"; ax.add_patch(plt.Rectangle((0, 0), W, H, fc=BG, ec="none"))
warm = LinearSegmentedColormap.from_list("w", ["#f08a5d", "#f2c14e", "#fbf0d9"])
cool = LinearSegmentedColormap.from_list("c", ["#e85d8a", "#f4a6c4", "#fbe3ee"])
orbs = [(1, 0, 0, 5), (2, 1, 0, 11), (3, 2, 0, 17), (4, 3, 0, 26), (5, 4, 0, 38),
        (2, 0, 0, 12), (3, 1, 1, 19), (3, 2, 1, 17), (4, 3, 1, 26), (5, 4, 2, 38),
        (3, 0, 0, 22), (4, 1, 0, 30), (4, 2, 1, 27), (4, 3, 2, 26), (5, 3, 1, 40),
        (4, 2, 0, 28), (5, 2, 1, 40), (5, 0, 0, 44), (5, 1, 0, 44), (5, 2, 0, 42)]
nx, ny = 5, 4; dx, dy = W / nx, H / ny; R = 1.68
levels = np.geomspace(0.07, 0.88, 8)
th = np.linspace(0, 2 * np.pi, 300)
for k, (n, l, m, ext) in enumerate(orbs):
    i, j = k % nx, ny - 1 - k // nx
    cx, cy = (i + 0.5) * dx, (j + 0.5) * dy
    ext = ext * 1.25; t = np.linspace(-ext, ext, 320); X, Z = np.meshgrid(t, t)
    p = psi(n, l, m, X, Z); p = p / np.abs(p).max(); p = np.sign(p) * np.abs(p) ** (0.45 if l == 0 else 0.7)
    mask = np.hypot(X, Z) > ext * 0.999
    p = np.ma.array(p, mask=mask)
    xs, ys = cx + X * R / ext, cy + Z * R / ext
    ax.plot(cx + R * np.cos(th), cy + R * np.sin(th), color="white", lw=0.4, alpha=0.25)
    for s_, cmap in [(1, warm), (-1, cool)]:
        cols = [cmap(q) for q in np.linspace(0, 1, len(levels))]
        ax.contour(xs, ys, s_ * p, levels=levels, colors=cols, linewidths=0.75)
    ax.plot([cx], [cy], "o", ms=1.8, color="#fbf0d9", zorder=5)
fig.savefig("figs/cover.svg", format="svg")
fig.savefig("/tmp/claude-0/-home-user-hs/86681ad6-701a-5310-b84c-b1468856c4a6/scratchpad/cover_lines.png", dpi=90)
