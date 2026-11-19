from inf import *
from matplotlib.patches import Wedge

# ---- 3-bit wheel ----
s = Sketch(9.6, 8.4)
cx, cy, R = 4.8, 4.2, 2.6
th = np.linspace(0, 2 * np.pi, 200)
s.ax.plot(cx + R * np.cos(th), cy + R * np.sin(th), color="#b7bec7", lw=1.0)
for k in range(8):
    a = np.pi / 2 - k * 2 * np.pi / 8
    x, y = cx + R * np.cos(a), cy + R * np.sin(a)
    neg = k >= 4
    s.ax.add_patch(Circle((x, y), 0.17, fc="#f4a6b0" if neg else "#a9cdf0", ec="#555", lw=0.7, zorder=5))
    xb, yb = cx + (R + 0.75) * np.cos(a), cy + (R + 0.75) * np.sin(a)
    lab(s, xb, yb, format(k, "03b"), size=9, mono=True, bold=True)
    xi, yi = cx + (R - 0.6) * np.cos(a), cy + (R - 0.6) * np.sin(a)
    lab(s, xi, yi, str(k if not neg else k - 8), size=10, bold=True, c="#a3222e" if neg else "#2c64a8")
    xo, yo = cx + (R + 1.35) * np.cos(a), cy + (R + 1.35) * np.sin(a)
    lab(s, xo, yo, f"({k})", size=7.5, c="#888")
lab(s, cx, cy + 0.2, "3-bit\ntwo's complement", size=8.6, c="#333")
lab(s, cx, cy - 0.45, "inner: signed value\nouter: bit pattern (unsigned)", size=7, c="#777")
s.save("c08_wheel")

# ---- IEEE 754 layout ----
s = Sketch(15.0, 5.6)
def field(x0, w, t, tone, y, h=1.0):
    rb(s, x0 + w / 2, y, w - 0.06, h, tone, r=0.15); lab(s, x0 + w / 2, y, t, size=8.4, bold=True)
lab(s, 0.1, 4.95, "float (32 bit)", size=9, bold=True, ha="left")
field(0.2, 1.0, "s", "red", 4.2); field(1.2, 4.6, "exponent  (8 bits)", "blue", 4.2); field(5.8, 9.0, "mantissa  (23 bits)", "green", 4.2)
lab(s, 0.1, 3.2, "double (64 bit)", size=9, bold=True, ha="left")
field(0.2, 1.0, "s", "red", 2.45); field(1.2, 6.0, "exponent  (11 bits)", "blue", 2.45); field(7.2, 7.6, "mantissa  (52 bits)", "green", 2.45)
rb(s, 7.5, 0.85, 14.6, 1.2, "white", r=0.2)
lab(s, 7.5, 0.85, r"$x \;=\; (-1)^{s}\;\cdot\;1.m_1m_2m_3\ldots\;\cdot\;2^{\,e - \mathrm{bias}}$        bias = 127 (float), 1023 (double)", size=9.5)
s.save("c08_ieee")

# ---- density of floating-point numbers (toy format: 2 mantissa bits) ----
s = Sketch(15.0, 4.2)
s.ax.plot([0.6, 14.4], [1.9, 1.9], color="#444", lw=1.0)
xs = []
for e in range(0, 4):
    for m in range(4): xs.append((1 + m / 4) * 2 ** e)
xs.append(16.0)
def X(v): return 0.8 + v * 0.85
for v in xs:
    pw = v in (1, 2, 4, 8, 16)
    s.ax.plot([X(v), X(v)], [1.9 - 0.25, 1.9 + 0.25], color="#a3222e" if pw else "#2c64a8", lw=1.5 if pw else 1.1)
for v in (1, 2, 4, 8, 16): lab(s, X(v), 1.3, str(v), size=8.5, c="#a3222e", bold=True)
lab(s, X(1.5), 2.8, "4", size=8, c="#2c64a8"); lab(s, X(3), 2.8, "4", size=8, c="#2c64a8"); lab(s, X(6), 2.8, "4 values", size=7.8, c="#2c64a8"); lab(s, X(12), 2.8, "4 values", size=7.8, c="#2c64a8")
for a, b in [(1, 2), (2, 4), (4, 8), (8, 16)]:
    s.ax.annotate("", xy=(X(b) - 0.05, 2.45), xytext=(X(a) + 0.05, 2.45), arrowprops=dict(arrowstyle="-", color="#9aa5b1", lw=0.8))
lab(s, 7.5, 0.4, "toy format with 2 mantissa bits: each interval between powers of 2\nholds the same number of values, so the gaps double", size=8.2, c="#555")
s.save("c08_density")
