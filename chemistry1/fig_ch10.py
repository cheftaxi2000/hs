from plot import *

k = 0.18
# ---------- concentrations vs time, average vs instantaneous ----------
p = Plot(7.6, 5.0, (0, 21), (0, 1.12), xt=[5, 10, 15], yt=[0.5, 1.0], xl="$t$ (s)", yl="[ ] (M)")
p.f(lambda t: np.exp(-k * t), a=0, b=20.5, c=B); p.f(lambda t: 1 - np.exp(-k * t), a=0, b=20.5, c=R)
p.text(15, 0.12, "[A]", c=B); p.text(15, 0.98, "[B]", c=R, va="top")
y10 = 1 - np.exp(-k * 10)
p.seg((0, 0), (10, y10), c=O, lw=1.0, dash=(3, 2)); p.dot((10, y10), c=O)
p.text(5.2, 0.25, "average rate\n0–10 s", c=O, size=7.5)
t0 = 3; y0 = 1 - np.exp(-k * t0); sl = k * np.exp(-k * t0)
p.seg((t0 - 2.5, y0 - 2.5 * sl), (t0 + 2.8, y0 + 2.8 * sl), c=G, lw=1.0); p.dot((t0, y0), c=G)
p.text(0.6, 0.72, "instantaneous rate\n= tangent slope", c=G, size=7.5)
p.save("c10_rates")

# ---------- zero order product formation ----------
p = Plot(5.6, 5.0, (0, 12), (0, 1.12), xt=[5], yt=[0.5, 1.0], xl="$t$ (s)", yl="[D] (M)")
p.f(lambda t: 0.1 * t, a=0, b=10, c=R); p.hline(1.0, c=GREY, a=10, b=12)
p.text(1.0, 0.85, "straight line:\nrate independent\nof [C]", size=7.5)
p.save("c10_zero")

# ---------- linear plots for the three orders ----------
A0 = 1.0
data = [("zeroth order", lambda t: A0 - 0.08 * t, "[A]", (0, 1.15), 12),
        ("first order", lambda t: 3.4 + np.log(A0 * np.exp(-0.25 * t)), "$\\ln$[A]", (0, 3.75), 12),
        ("second order", lambda t: 1 / A0 + 0.6 * t, "1/[A]", (0, 8.3), 12)]
for i, (title, f, yl, ylim, T) in enumerate(data):
    p = Plot(4.8, 4.2, (0, T), ylim, xt=[], yt=[], xl="$t$", yl=yl, grid=False)
    p.f(f, a=0, b=T - 0.5, c=[R, B, G][i])
    slope = ["slope $=-k$", "slope $=-k$", "slope $=+k$"][i]
    p.text(T * 0.45, (ylim[0] + ylim[1]) * 0.5 + 0.3 * (ylim[1] - ylim[0]) * (1 if i != 2 else -0.8), slope, size=8, c=[R, B, G][i])
    p.text(T * 0.5, ylim[1], title, ha="center", va="top", size=8.5)
    p.save(f"c10_lin{i}")

# ---------- first-order half-lives ----------
p = Plot(8.4, 4.8, (0, 4.6), (0, 1.12), xt=[1, 2, 3, 4], xtl=["$t_{1/2}$", "$2t_{1/2}$", "$3t_{1/2}$", "$4t_{1/2}$"], yt=[0.125, 0.25, 0.5, 1.0], ytl=["$[A]_0/8$", "$[A]_0/4$", "$[A]_0/2$", "$[A]_0$"], xl="$t$", yl="")
p.f(lambda t: 0.5 ** t, a=0, b=4.5, c=B)
for n in range(1, 4):
    p.seg((n, 0), (n, 0.5 ** n), c=GREY, lw=0.6, dash=(2, 2)); p.seg((0, 0.5 ** n), (n, 0.5 ** n), c=GREY, lw=0.6, dash=(2, 2))
p.text(2.3, 0.6, "first order: each half-life\nhalves what is left", size=7.5)
p.save("c10_halflife")

# ---------- concentration vs time for three orders, same k*[A]0 initial rate ----------
p = Plot(7.6, 4.8, (0, 10.5), (0, 1.12), xt=[2, 4, 6, 8, 10], yt=[0.5, 1.0], xl="$t$", yl="[A]")
r0 = 0.2
p.f(lambda t: np.where(t < 5, 1 - r0 * t, np.nan), a=0, b=5, c=R)
p.seg((5, 0), (10.3, 0), c=R, lw=1.3)
p.f(lambda t: np.exp(-r0 * t), a=0, b=10.3, c=B)
p.f(lambda t: 1 / (1 + r0 * t), a=0, b=10.3, c=G)
p.text(3.6, 0.22, "zeroth", c=R, size=7.5); p.text(6.0, 0.36, "first", c=B, size=7.5); p.text(8.0, 0.43, "second", c=G, size=7.5)
p.text(5.4, 1.0, "same initial rate", size=7.5)
p.save("c10_orders")
