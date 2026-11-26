"""Titelbild: Rollkurven (Trochoiden) eines abrollenden Rades, die Bahnkurven aus Kapitel 3."""
import numpy as np, matplotlib
matplotlib.use("svg")
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap, to_rgb
W, H = 21.0, 18.6
fig = plt.figure(figsize=(W / 2.54, H / 2.54)); ax = fig.add_axes([0, 0, 1, 1])
ax.set_xlim(0, W); ax.set_ylim(0, H); ax.axis("off"); ax.set_aspect("equal")
BG = "#14335c"; ax.add_patch(plt.Rectangle((0, 0), W, H, fc=BG, ec="none"))
cm = LinearSegmentedColormap.from_list("m", ["#7fb0e8", "#eaf1fb", "#f0b25a", "#e2604f", "#58b58e"])
R = 1.55; t = np.linspace(-3 * np.pi, 9 * np.pi, 2600)
rows = [(-0.6, 0.0), (5.6, 0.5 * np.pi), (11.8, 1.0 * np.pi), (18.0, 1.5 * np.pi)]
ds = np.linspace(0.12, 2.25, 17)
for y0, ph in rows:
    ax.plot([0, W], [y0, y0], color="#ffffff", lw=0.5, alpha=0.35)
    for k, d in enumerate(ds):
        x = R * (t + ph) - d * R * np.sin(t) - 6.0; y = y0 + R - d * R * np.cos(t)
        ax.plot(x, y, color=cm(k / (len(ds) - 1)), lw=0.75 if abs(d - 1) > 0.07 else 1.5, alpha=0.9, solid_capstyle="round")
# ein Rad mit Speiche, damit man die Konstruktion erkennt
y0, ph = rows[1]; tc = 1.15 * np.pi; cx = R * (tc + ph) - 6.0; cy = y0 + R
th = np.linspace(0, 2 * np.pi, 200); ax.plot(cx + R * np.cos(th), cy + R * np.sin(th), color="white", lw=1.1)
px, py = cx - R * np.sin(tc), cy - R * np.cos(tc)
ax.plot([cx, px], [cy, py], color="white", lw=1.1); ax.plot([cx], [cy], "o", ms=3.2, color="white"); ax.plot([px], [py], "o", ms=4.2, color="#f0b25a")
import os
plt.rcParams["svg.hashsalt"] = "mechanik1"
fig.savefig("figs/cover.svg", format="svg", metadata={"Date": None})
if os.environ.get("FIGPNG"): fig.savefig(os.path.join(os.environ["FIGPNG"], "cover.png"), dpi=110)
