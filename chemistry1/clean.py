"""Clean, rounded drawing primitives for apparatus sketches (glassware, liquids, pills).
Works on plot.Sketch, where 1 data unit = 1 cm on paper."""
import numpy as np
from matplotlib.patches import FancyBboxPatch, Circle, Polygon, PathPatch
from matplotlib.path import Path
import matplotlib.colors as mc
from plot import INK

PT = 72 / 2.54                # points per cm
GLASS = "#f3f6fa"; GLASS_EDGE = "#b7c2ce"
WATER = ("#cfe3f6", "#9cc3ea"); HG = ("#d9dee4", "#9aa4b0"); GAS = ("#e3eefb", "#c4daf3")
ROSE = ("#f8dfe4", "#eeb0bd"); STEEL = ("#e9edf1", "#a9b3be"); WARM = ("#fbefd9", "#f2cf91")
SOFT = {"blue": ("#e6f0fb", "#3d7cc9"), "red": ("#fbe7e4", "#c4473a"), "green": ("#e3f3ea", "#2f8a5f"),
        "grey": ("#f0f2f5", "#6b7480"), "violet": ("#efe9f7", "#7356a6"), "amber": ("#fcf0dc", "#b56d12")}


def _stroke(ax, pts, w_cm, color, z, cap="round"):
    pts = np.asarray(pts, float)
    ln, = ax.plot(pts[:, 0], pts[:, 1], color=color, lw=w_cm * PT, solid_capstyle=cap, solid_joinstyle="round", zorder=z)
    return ln


def tube(s, pts, w, z=2, fill=GLASS):
    """glass tube of inner width w (cm) along a polyline, rounded ends and bends."""
    _stroke(s.ax, pts, w + 0.07, GLASS_EDGE, z)
    _stroke(s.ax, pts, w, fill, z + 0.1)


def liquid(s, pts, w, color, z=3, cap="round"):
    """liquid inside a tube: same polyline (sub-path), slightly narrower."""
    _stroke(s.ax, pts, w - 0.06, color, z, cap=cap)
    # light highlight along the left side for a glassy look
    p = np.asarray(pts, float)


def arc(cx, cy, r, a0, a1, n=40):
    a = np.linspace(np.radians(a0), np.radians(a1), n)
    return np.c_[cx + r * np.cos(a), cy + r * np.sin(a)]


def ubend(xl, xr, ybot, ytop_l, ytop_r):
    """U-tube centre line: down the left arm, round bottom, up the right arm."""
    r = (xr - xl) / 2
    return np.vstack([[xl, ytop_l], [xl, ybot + r], arc((xl + xr) / 2, ybot + r, r, 180, 360)[1:-1], [xr, ybot + r], [xr, ytop_r]])


def cut(pts, s0, s1):
    """sub-polyline between arc lengths s0 and s1."""
    pts = np.asarray(pts, float); d = np.r_[0, np.cumsum(np.hypot(*np.diff(pts, axis=0).T))]
    t = np.linspace(s0, s1, 200)
    return np.c_[np.interp(t, d, pts[:, 0]), np.interp(t, d, pts[:, 1])]


def length(pts):
    pts = np.asarray(pts, float); return np.hypot(*np.diff(pts, axis=0).T).sum()


def arclen_at_y(pts, y, which="first"):
    pts = np.asarray(pts, float); d = np.r_[0, np.cumsum(np.hypot(*np.diff(pts, axis=0).T))]
    sols = []
    for i in range(len(pts) - 1):
        y0, y1 = pts[i, 1], pts[i + 1, 1]
        if (y0 - y) * (y1 - y) <= 0 and y0 != y1:
            t = (y - y0) / (y1 - y0); sols.append(d[i] + t * (d[i + 1] - d[i]))
    return sols[0] if which == "first" else sols[-1]


def grad(s, patch, c1, c2, vertical=True, z=2):
    """fill a patch with a soft linear gradient c1 (top/left) -> c2 (bottom/right)."""
    s.ax.add_patch(patch); patch.set_facecolor("none"); patch.set_edgecolor("none"); patch.set_zorder(z)
    ext = patch.get_extents(); inv = s.ax.transData.inverted()
    (x0, y0), (x1, y1) = inv.transform([[ext.x0, ext.y0], [ext.x1, ext.y1]])
    a, b = np.array(mc.to_rgb(c1)), np.array(mc.to_rgb(c2))
    t = np.linspace(0, 1, 256)
    g = (a[None] * (1 - t[:, None]) + b[None] * t[:, None])
    img = g[:, None, :] if vertical else g[None, :, :]
    im = s.ax.imshow(img, extent=(x0, x1, y0, y1), origin="upper", aspect="auto", zorder=z, interpolation="bicubic")
    im.set_clip_path(patch)
    s.ax.set_xlim(*s.xlim); s.ax.set_ylim(*s.ylim)
    return im


def rrect(x, y, w, h, r):
    return FancyBboxPatch((x + r, y + r), w - 2 * r, h - 2 * r, boxstyle=f"round,pad={r}")


def rounded_poly(pts, r):
    """closed polygon with rounded corners (radius r)."""
    pts = np.asarray(pts, float); n = len(pts); verts = []; codes = []
    for i in range(n):
        p0, p1, p2 = pts[i - 1], pts[i], pts[(i + 1) % n]
        a = p0 - p1; b = p2 - p1
        la, lb = np.linalg.norm(a), np.linalg.norm(b)
        rr = min(r, la / 2.2, lb / 2.2)
        q0 = p1 + a / la * rr; q2 = p1 + b / lb * rr
        if i == 0: verts.append(q0); codes.append(Path.MOVETO)
        else: verts.append(q0); codes.append(Path.LINETO)
        verts += [p1, q2]; codes += [Path.CURVE3, Path.CURVE3]
    verts.append(verts[0]); codes.append(Path.CLOSEPOLY)
    return Path(verts, codes)


def pill(s, x, y, w, h, text, tone="blue", size=8.5, bold=False, z=3):
    """rounded label box: soft tinted fill, no hard outline, coloured text."""
    bg, fg = SOFT[tone]
    r = min(h / 2, 0.32)
    s.ax.add_patch(FancyBboxPatch((x - w / 2 + r, y - h / 2 + r), w - 2 * r, h - 2 * r, boxstyle=f"round,pad={r}",
                                  fc=bg, ec=mc.to_hex(np.array(mc.to_rgb(fg)) * 0.35 + 0.65), lw=0.6, zorder=z))
    s.ax.text(x, y, text, ha="center", va="center", fontsize=size, color=INK, zorder=z + 2, fontweight="bold" if bold else "normal")


def link(s, p, q, c="#b7bec7", lw=1.1, z=1):
    s.ax.plot([p[0], q[0]], [p[1], q[1]], color=c, lw=lw, solid_capstyle="round", zorder=z)


def dimension(s, x, y0, y1, label, c="#c4473a", side="right", size=8.5):
    """vertical dimension line with small end bars."""
    s.ax.plot([x, x], [y0, y1], color=c, lw=0.9, solid_capstyle="round", zorder=6)
    for y in (y0, y1): s.ax.plot([x - 0.12, x + 0.12], [y, y], color=c, lw=0.9, solid_capstyle="round", zorder=6)
    s.text(x + (0.18 if side == "right" else -0.18), (y0 + y1) / 2, label, c=c, size=size, va="center", ha="left" if side == "right" else "right")


def soft_arrow(s, p, q, c="#3d7cc9", lw=1.1):
    s.arrow(p, q, c=c, lw=lw)
