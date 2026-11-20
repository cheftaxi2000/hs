from plot import *
import numpy as np
# Scherung: gleiche Flaeche
p = Plot(8.6, 4.6, (-0.4, 7.4), (-0.4, 3.3), xt=(), yt=(), xl="$x_1$", yl=None, grid=False, pad=0.3)
a = np.array([3.0, 0.0]); b = np.array([0.6, 2.2])
p.polyfill([(0, 0), tuple(a), tuple(a + b), tuple(b)], c=FILL_B, alpha=0.9)
b2 = b + 1.0 * a
p.polyfill([(0, 0), tuple(a), tuple(a + b2), tuple(b2)], c=FILL_R, alpha=0.45)
p.arrow((0, 0), tuple(a), c=B, lw=1.6); p.arrow((0, 0), tuple(b), c=R, lw=1.6); p.arrow((0, 0), tuple(b2), c=O, lw=1.2)
p.seg(tuple(b), tuple(b2), c=GREY, lw=0.8, dash=(3, 2))
p.text(3.0, 0.15, "$\\mathbf{a}$", c=B, size=10); p.text(0.2, 2.15, "$\\mathbf{b}$", c=R, size=10); p.text(3.8, 2.3, "$\\mathbf{b}+\\mathbf{a}$", c=O, size=10)
p.text(4.4, 0.7, "Grundlinie $|\\mathbf{a}|$ und Höhe bleiben:\nzwei Parallelogramme mit gleicher Fläche", ha="left", size=8.5)
p.save("l09_scher")
