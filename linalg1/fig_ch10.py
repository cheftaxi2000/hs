from plot import *
import numpy as np
# Vektoraddition und Streckung im R^2
def arrowfig(name, mode):
    p = Plot(5.6, 4.4, (-1.6, 5.2), (-0.8, 3.9), xt=(), yt=(), xl="", yl=None, grid=False, pad=0.25)
    u = np.array([3.0, 0.8]); v = np.array([0.9, 2.2])
    if mode == "add":
        p.arrow((0, 0), tuple(u), c=B, lw=1.6); p.arrow((0, 0), tuple(v), c=R, lw=1.6)
        p.seg(tuple(u), tuple(u + v), c=R, lw=0.9, dash=(3, 2)); p.seg(tuple(v), tuple(u + v), c=B, lw=0.9, dash=(3, 2))
        p.arrow((0, 0), tuple(u + v), c=G, lw=1.8)
        p.text(2.7, 0.2, "$\\mathbf{u}$", c=B, size=10); p.text(0.1, 1.8, "$\\mathbf{v}$", c=R, size=10); p.text(2.3, 2.5, "$\\mathbf{u}+\\mathbf{v}$", c=G, size=10)
        p.text(2.5, -0.2, "Addition: Parallelogramm", ha="center", size=8, c="#555")
    else:
        p.arrow((0, 0), tuple(u), c=B, lw=1.6); p.arrow((0, 0), tuple(1.5 * u * 0.9), c=O, lw=1.0)
        p.arrow((0, 0), tuple(-0.5 * u * 0.9), c=R, lw=1.4)
        p.text(2.8, 0.25, "$\\mathbf{u}$", c=B, size=10); p.text(3.4, 1.3, "$1{,}5\\,\\mathbf{u}$", c=O, size=9); p.text(-1.0, -0.2, "$-0{,}5\\,\\mathbf{u}$", c=R, size=9)
        p.text(2.5, -0.2, "Skalarmultiplikation: Strecken", ha="center", size=8, c="#555")
    p.save(name)
arrowfig("l10_add", "add"); arrowfig("l10_skal", "skal")
