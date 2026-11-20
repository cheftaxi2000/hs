"""Titelbild: ein Quadratgitter, abgebildet durch Matrizen, die von der Identität zu einer singulären Matrix laufen.
Linienstil wie bei den Covern von Mechanik, Analysis, Chemie und Informatik."""
import numpy as np, matplotlib
matplotlib.use("svg")
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap
from matplotlib.collections import LineCollection
W, H = 21.0, 18.6
fig = plt.figure(figsize=(W / 2.54, H / 2.54)); ax = fig.add_axes([0, 0, 1, 1])
ax.set_xlim(0, W); ax.set_ylim(0, H); ax.axis("off"); ax.set_aspect("equal")
ax.add_patch(plt.Rectangle((0, 0), W, H, fc="#2a1a5c", ec="none"))
cm = LinearSegmentedColormap.from_list("v", ["#5ce1e6", "#a8e8f0", "#f3ecff", "#c9a8ff", "#8f6bf0"])
def R(a): return np.array([[np.cos(a), -np.sin(a)], [np.sin(a), np.cos(a)]])
# vier Familien: Scherung, Drehstreckung, Kollaps auf eine Gerade, Drehung+Spiegelung
def fam(k):
    r, c = k // 4, k % 4
    t = c / 3
    if r == 0: return np.array([[1, 1.6 * t + 0.0], [0, 1]]) @ R(0.35 * t)
    if r == 1: return R(1.4 * t) @ np.diag([1 + 0.45 * t, 1 - 0.1 * t])
    if r == 2: return R(0.5) @ np.diag([1.0, 1.0 - 0.97 * t]) @ R(-0.5)
    return np.diag([1, -1]) @ R(1.9 * t) if t > 0 else np.eye(2)
nx, ny = 4, 4; dx, dy = W / nx, H / ny
n = 11; g = np.linspace(-1, 1, n); s = np.linspace(-1, 1, 60)
for k in range(16):
    i, j = k % nx, k // nx
    cx, cy = (i + 0.5) * dx, H - (j + 0.5) * dy
    M = fam(k)
    sc = 0.27 * min(dx, dy)
    segs, cols = [], []
    for fixed in g:
        for horiz in (True, False):
            pts = np.stack([s, np.full_like(s, fixed)]) if horiz else np.stack([np.full_like(s, fixed), s])
            q = M @ pts
            P = np.column_stack([cx + sc * q[0] / 1.0, cy + sc * q[1]])
            segs.append(P)
            cols.append(cm((fixed + 1) / 2))
    ax.add_patch(plt.Rectangle((cx - dx * 0.46, cy - dy * 0.46), dx * 0.92, dy * 0.92, fc="none", ec="white", lw=0.4, alpha=0.2))
    # Einheitsquadrat als Referenz (gestrichelt)
    ax.plot(cx + sc * np.array([-1, 1, 1, -1, -1]), cy + sc * np.array([-1, -1, 1, 1, -1]), color="white", lw=0.5, alpha=0.35, ls=(0, (2, 2)))
    for P, c in zip(segs, cols): ax.plot(P[:, 0], P[:, 1], color=c, lw=0.85, solid_capstyle="round")
fig.savefig("figs/cover.svg", format="svg")
fig.savefig("/tmp/claude-0/-home-user-hs/86681ad6-701a-5310-b84c-b1468856c4a6/scratchpad/cover_la.png", dpi=80)
