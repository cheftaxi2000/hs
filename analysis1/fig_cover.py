"""Titelbild: Sternpolygone aus den n-ten Einheitswurzeln e^(2 pi i k/n) (Kapitel 3)."""
import numpy as np, matplotlib
matplotlib.use("svg")
import matplotlib.pyplot as plt
W, H = 21.0, 18.6
fig = plt.figure(figsize=(W / 2.54, H / 2.54)); ax = fig.add_axes([0, 0, 1, 1])
ax.set_xlim(0, W); ax.set_ylim(0, H); ax.axis("off"); ax.set_aspect("equal")
BG = "#0f3b36"; ax.add_patch(plt.Rectangle((0, 0), W, H, fc=BG, ec="none"))
cols = ["#f6efe2", "#f2c14e", "#f08a5d", "#e85d75", "#b8de9f", "#7cc6b5"]
nx, ny = 5, 4; dx, dy = W / nx, H / ny; R = 1.62
ns = [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
for j in range(ny):
    for i in range(nx):
        n = ns[(ny - 1 - j) * nx + i]
        cx, cy = (i + 0.5) * dx, (j + 0.5) * dy
        ph = np.pi / 2
        ang = ph + 2 * np.pi * np.arange(n + 1) / n
        ax.plot(cx + R * np.cos(np.linspace(0, 2 * np.pi, 200)), cy + R * np.sin(np.linspace(0, 2 * np.pi, 200)),
                color="#ffffff", lw=0.4, alpha=0.25)
        for k in range(1, n // 2 + 1):
            idx = (np.arange(n + 1) * k) % n
            a = ph + 2 * np.pi * idx / n
            ax.plot(cx + R * np.cos(a), cy + R * np.sin(a), color=cols[(k - 1) % len(cols)], lw=0.8, alpha=0.9, solid_joinstyle="round")
        a = ph + 2 * np.pi * np.arange(n) / n
        ax.plot(cx + R * np.cos(a), cy + R * np.sin(a), "o", ms=2.2, color="#f6efe2", zorder=5)
fig.savefig("figs/cover.svg", format="svg"); fig.savefig("/tmp/claude-0/-home-user-hs/86681ad6-701a-5310-b84c-b1468856c4a6/scratchpad/apng/cover.png", dpi=80)
