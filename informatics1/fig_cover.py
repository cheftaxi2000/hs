"""Cover: recursive space-filling curves (Hilbert, Moore, Sierpinski arrowhead, Gosper), drawn by L-systems.
Line-art style like the Mechanik, Analysis and Chemistry covers; amber on charcoal like a code editor."""
import numpy as np, matplotlib
matplotlib.use("svg")
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap
from matplotlib.collections import LineCollection
W, H = 21.0, 18.6
fig = plt.figure(figsize=(W / 2.54, H / 2.54)); ax = fig.add_axes([0, 0, 1, 1])
ax.set_xlim(0, W); ax.set_ylim(0, H); ax.axis("off"); ax.set_aspect("equal")
ax.add_patch(plt.Rectangle((0, 0), W, H, fc="#17181d", ec="none"))
cm = LinearSegmentedColormap.from_list("a", ["#ffe08a", "#ffb347", "#ff7a45", "#ef476f"])

def lsys(axiom, rules, n):
    s = axiom
    for _ in range(n): s = "".join(rules.get(c, c) for c in s)
    return s
def turtle(s, angle, start=0.0):
    x = y = 0.0; a = start; pts = [(0.0, 0.0)]
    for c in s:
        if c == "F" or c in "AB" and angle == 60:
            x += np.cos(np.radians(a)); y += np.sin(np.radians(a)); pts.append((x, y))
        elif c == "+": a += angle
        elif c == "-": a -= angle
    return np.array(pts)
def hilbert(n): return turtle(lsys("A", {"A": "+BF-AFA-FB+", "B": "-AF+BFB+FA-"}, n), 90)
def moore(n): return turtle(lsys("LFL+F+LFL", {"L": "-RF+LFL+FR-", "R": "+LF-RFR-FL+"}, n - 1), 90)
def arrow(n): return turtle(lsys("A", {"A": "B-A-B", "B": "A+B+A"}, n), 60, 0 if n % 2 == 0 else 60)
def gosper(n): return turtle(lsys("A", {"A": "A-B--B+A++AA+B-", "B": "+A-BB--B-A++A+B"}, n), 60)

curves = [hilbert(n) for n in (2, 3, 4, 5)] + [moore(n) for n in (2, 3, 4, 5)] + \
         [arrow(n) for n in (3, 4, 5, 6)] + [gosper(n) for n in (1, 2, 3, 4)]
nx, ny = 4, 4; dx, dy = W / nx, H / ny
for k, P in enumerate(curves):
    i, j = k % nx, k // nx
    cx, cy = (i + 0.5) * dx, H - (j + 0.5) * dy
    x0, x1, y0, y1 = P[:, 0].min(), P[:, 0].max(), P[:, 1].min(), P[:, 1].max()
    sc = min(dx * 0.80 / (x1 - x0), dy * 0.80 / (y1 - y0))
    Q = np.column_stack([cx + (P[:, 0] - (x0 + x1) / 2) * sc, cy + (P[:, 1] - (y0 + y1) / 2) * sc])
    ax.add_patch(plt.Rectangle((cx - dx * 0.46, cy - dy * 0.46), dx * 0.92, dy * 0.92, fc="none", ec="white", lw=0.4, alpha=0.2))
    segs = np.stack([Q[:-1], Q[1:]], axis=1)
    t = np.linspace(0, 1, len(segs))
    lw = 1.2 if len(segs) < 300 else (0.8 if len(segs) < 1500 else 0.5)
    ax.add_collection(LineCollection(segs, colors=[cm(v) for v in t], linewidths=lw, capstyle="round", joinstyle="round"))
fig.savefig("figs/cover.svg", format="svg")
fig.savefig("/tmp/claude-0/-home-user-hs/86681ad6-701a-5310-b84c-b1468856c4a6/scratchpad/cover_inf.png", dpi=80)
