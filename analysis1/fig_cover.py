"""Titelbild: Taylorpolynome von sin x, die sich um die Sinuskurve legen (Kapitel 5)."""
import numpy as np, matplotlib
from math import factorial
matplotlib.use("svg")
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap
W, H = 21.0, 18.6
fig = plt.figure(figsize=(W / 2.54, H / 2.54)); ax = fig.add_axes([0, 0, 1, 1])
ax.set_xlim(0, W); ax.set_ylim(0, H); ax.axis("off")
BG = "#14335c"; ax.add_patch(plt.Rectangle((0, 0), W, H, fc=BG, ec="none"))
cm = LinearSegmentedColormap.from_list("m", ["#58b58e", "#4fa3d9", "#9b8fe0", "#f0b25a", "#e2604f"])
sx, sy = 0.75, 2.6            # cm pro Einheit
def P(x, n):                 # Taylorpolynom von sin um 0 bis Grad n
    return sum((-1) ** k * x ** (2 * k + 1) / factorial(2 * k + 1) for k in range(n // 2 + 1))
rows = [(2.6, 0.0), (9.3, 0.0), (16.0, 0.0)]
for yc, ph in rows:
    x = np.linspace(-15, 15, 5000)
    for k, n in enumerate(range(1, 34, 2)):
        y = P(x, n)
        y[np.abs(y) > 5.2] = np.nan
        ax.plot(W / 2 + sx * x + ph, yc + sy * y * 0.5, color=cm(k / 16), lw=1.15, alpha=0.95, solid_capstyle="round")
    ax.plot(W / 2 + sx * x + ph, yc + sy * np.sin(x) * 0.5, color="white", lw=1.4)
fig.savefig("figs/cover.svg", format="svg"); fig.savefig("/tmp/claude-0/-home-user-hs/86681ad6-701a-5310-b84c-b1468856c4a6/scratchpad/apng/cover.png", dpi=90)
