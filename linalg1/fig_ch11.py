from plot import *
from inf import lab
from geo3d import *
import numpy as np

# ---- Unterraeume im R^3 ----
def panel(name, kind):
    s = Sketch(5.4, 5.0)
    s.ax.set_xlim(-1.9, 2.4); s.ax.set_ylim(-1.5, 1.9)
    draw_box(s.ax)
    if kind == "plane":
        draw_plane(s.ax, (0.3, 0.2, 1.0), 0.0, "#5b4aa8", alpha=0.35)
        q = proj(np.array([[0, 0, 0.0]])); s.ax.plot(q[:, 0], q[:, 1], "o", ms=5, color="black", zorder=7); s.ax.text(q[0, 0] + 0.12, q[0, 1] - 0.22, "$\\mathbf{0}$", fontsize=9)
        s.ax.text(0.2, -1.45, "Ebene durch $\\mathbf{0}$: Unterraum", ha="center", fontsize=8.2)
    elif kind == "line":
        seg = line_in_box((0, 0, 0), (0.6, 1.0, 0.5)); q = proj(np.array(seg)); s.ax.plot(q[:, 0], q[:, 1], color="#2a7f5a", lw=2.2, zorder=6)
        q = proj(np.array([[0, 0, 0.0]])); s.ax.plot(q[:, 0], q[:, 1], "o", ms=5, color="black", zorder=7); s.ax.text(q[0, 0] + 0.12, q[0, 1] - 0.22, "$\\mathbf{0}$", fontsize=9)
        s.ax.text(0.2, -1.45, "Gerade durch $\\mathbf{0}$: Unterraum", ha="center", fontsize=8.2)
    else:
        draw_plane(s.ax, (0.3, 0.2, 1.0), 0.6, "#b3382c", alpha=0.35)
        q = proj(np.array([[0, 0, 0.0]])); s.ax.plot(q[:, 0], q[:, 1], "o", ms=5, color="black", zorder=7); s.ax.text(q[0, 0] + 0.12, q[0, 1] - 0.22, "$\\mathbf{0}$", fontsize=9)
        s.ax.text(0.2, -1.45, "Ebene neben $\\mathbf{0}$: kein UR", ha="center", fontsize=8.2)
    s.save(name)
panel("l11_ebene", "plane"); panel("l11_gerade", "line"); panel("l11_affin", "aff")

# ---- Funktionen addieren ----
p = Plot(9.0, 4.8, (-0.3, 6.6), (-1.7, 1.9), xt=(np.pi, 2 * np.pi), yt=(-1, 1), xl="$x$", yl=None, xtl=["$\\pi$", "$2\\pi$"], pad=0.3)
p.f(np.sin, 0, 2 * np.pi, c=B, lw=1.4); p.f(np.cos, 0, 2 * np.pi, c=R, lw=1.4)
p.f(lambda x: np.sin(x) + np.cos(x), 0, 2 * np.pi, c=G, lw=1.8)
x0 = 1.0
for fn, col in [(np.sin, B), (np.cos, R), (lambda x: np.sin(x) + np.cos(x), G)]: p.dot((x0, fn(x0)), c=col, r=2.8)
p.vline(x0, c=GREY, a=-1.7, b=1.9)
p.text(5.4, -0.55, "$\\sin$", c=B, size=9); p.text(4.4, 0.7, "$\\cos$", c=R, size=9); p.text(1.15, 1.45, "$\\sin+\\cos$", c=G, size=9)
p.text(1.05, -1.6, "$(f+g)(x_0)=f(x_0)+g(x_0)$", ha="left", size=8)
p.save("l11_funk")
