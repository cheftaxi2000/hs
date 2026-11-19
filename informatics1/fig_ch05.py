from inf import *

# ---- stepwise refinement ----
s = Sketch(14.6, 6.4)
def nodeb(x, y, t, tone, w=3.6, h=0.9, mono=False, size=8.6): cell(s, x, y, w, h, t, tone, size=size, mono=mono, r=0.2)
nodeb(7.3, 5.8, "print the prime factors of n", "amber", w=5.2, size=9)
nodeb(2.9, 3.9, "while n > 1", "grey", w=3.0, mono=True, size=8.6)
nodeb(7.3, 3.9, "find the next factor f", "blue", w=4.0)
nodeb(11.8, 3.9, "print f and divide n by f", "green", w=4.4)
for x in (2.9, 7.3, 11.8): link(s, (7.3, 5.35), (x, 4.35), c="#9aa5b1", lw=1.1)
nodeb(5.1, 1.7, "smallest_factor(n)", "violet", w=4.0, mono=True, size=8.4)
nodeb(9.8, 1.7, "try d = 2, 3, 4, ... while d*d <= n", "violet", w=5.0, size=8.4)
link(s, (7.3, 3.45), (5.1, 2.15), c="#9aa5b1", lw=1.1); link(s, (7.3, 3.45), (9.8, 2.15), c="#9aa5b1", lw=1.1)
lab(s, 0.2, 5.8, "level 0\nthe problem", size=7.8, c="#777", ha="left"); lab(s, 0.2, 3.1, "level 1\nbig steps", size=7.8, c="#777", ha="left")
lab(s, 0.2, 1.0, "level 2\ndetails", size=7.8, c="#777", ha="left")
s.save("c05_refine")

# ---- Newton's method for sqrt(2) ----
p = Plot(9.0, 6.0, (0, 2.3), (-2.0, 3.2), xt=(0.5, 1, 1.5, 2), yt=(-1, 1, 2, 3), xl="$y$", yl=None, xtl=["0.5", "1", "", ""])
p.f(lambda x: x * x - 2, 0.1, 2.25, c=B, lw=1.5)
xs = [2.0]
for _ in range(3): xs.append((xs[-1] + 2 / xs[-1]) / 2)
for k, x0 in enumerate(xs[:3]):
    y0 = x0 * x0 - 2; x1 = xs[k + 1]
    p.seg((x0, 0), (x0, y0), c=GREY, lw=0.8, dash=(3, 2)); p.seg((x0, y0), (x1, 0), c=R, lw=1.1)
    p.dot((x0, y0), c=B, r=2.5); p.dot((x1, 0), c=R, r=2.5)
p.text(2.0, -0.3, "$y_0=2$", ha="center", va="top", size=8)
p.text(1.45, -0.75, "$y_1=1.5$", ha="center", va="top", size=8)
p.text(1.0, 0.45, "$y_2\\approx 1.4167$", ha="center", va="bottom", size=8, c=R)
p.text(0.2, 2.75, "plot of $y^2-2$;  tangent at $y_k$ crosses the axis at\n$y_{k+1}=\\frac{1}{2}(y_k+2/y_k)$", ha="left", va="center", size=8.3)
p.save("c05_newton")
