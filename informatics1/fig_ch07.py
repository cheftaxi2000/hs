from inf import *

# ---- ASCII excerpt ----
s = Sketch(15.0, 5.4)
def strip(y, start, n, tone, title):
    lab(s, 0.2, y + 0.75, title, size=8.3, ha="left", c="#555")
    for i in range(n):
        c = start + i
        cell(s, 1.0 + i * 1.12, y, 1.02, 1.0, "", tone, r=0.14)
        lab(s, 1.0 + i * 1.12, y + 0.17, chr(c), size=9.5, mono=True, bold=True); lab(s, 1.0 + i * 1.12, y - 0.27, str(c), size=7.2, c="#555")
strip(4.4, 48, 10, "violet", "digits: '0' = 48, ..., '9' = 57")
strip(2.6, 65, 12, "blue", "upper case: 'A' = 65, ..., 'Z' = 90")
strip(0.8, 97, 12, "green", "lower case: 'a' = 97, ..., 'z' = 122")
lab(s, 14.8, 4.4, "consecutive,\nin alphabetical\norder", size=7.8, c="#777", ha="right")
s.ax.set_ylim(0.0, 5.6)
s.save("c07_ascii")

# ---- factorial: calls down, returns up ----
s = Sketch(13.0, 5.6)
names = ["factorial(3)", "factorial(2)", "factorial(1)", "factorial(0)"]
res = ["3 * 2 = 6", "2 * 1 = 2", "1 * 1 = 1", "1"]
for i, n in enumerate(names):
    x = 1.5 + i * 2.9
    cell(s, x + 0.8, 3.7, 2.6, 1.1, n, ["blue", "blue", "blue", "green"][i], size=8.2, bold=True, r=0.2)
    if i < 3: arr(s, (x + 2.1, 4.05), (x + 2.9 - 0.5 + 0.0, 4.05), c="#3d7cc9", lw=1.0)
    lab(s, x + 0.8, 4.55 + 0.35, "", size=8)
    arr(s, (x + 2.9 - 0.5 - 0.0 + 0.0, 3.35) if i < 3 else (x + 0.8, 3.15), (x + 2.1, 3.35) if i < 3 else (x + 0.8, 3.15), c="#c4473a", lw=1.0) if i < 3 else None
for i, r in enumerate(res):
    x = 1.5 + i * 2.9
    lab(s, x + 0.8, 2.6, "returns", size=7.5, c="#a3222e"); lab(s, x + 0.8, 2.1, r, size=9, mono=True, bold=True, c="#a3222e")
lab(s, 6.5, 5.3, "the calls go down (each waits for the smaller problem) ...", size=8.5, c="#3d7cc9")
lab(s, 6.5, 0.9, "... and the results come back up: 1 → 1 → 2 → 6", size=8.5, c="#a3222e")
rb(s, 1.5 + 3 * 2.9 + 0.8, 3.7, 2.8, 1.5, "green", r=0.25, fc="none", ec="#2f8a5f", dash=(3, 2))
s.save("c07_factorial")

# ---- Fibonacci call tree ----
s = Sketch(14.0, 6.4)
leaf = [0]
def layout(n, d):
    if n <= 1:
        x = leaf[0] * 1.45; leaf[0] += 1; return (n, x, d, [])
    l = layout(n - 1, d + 1); r = layout(n - 2, d + 1)
    return (n, (l[1] + r[1]) / 2, d, [l, r])
tree = layout(5, 0)
def draw(t):
    n, x, d, ch = t; X, Y = 0.8 + x, 5.8 - d * 1.2
    for c in ch:
        link(s, (X, Y - 0.35), (0.8 + c[1], 5.8 - c[2] * 1.2 + 0.35), c="#9aa5b1", lw=0.9); draw(c)
    cell(s, X, Y, 1.25, 0.7, f"fib({n})", "green" if n <= 1 else "blue", size=7.6, r=0.18)
draw(tree)
lab(s, 13.9, 5.8, "fib(3) is computed twice,\nfib(2) three times, ...", size=8.2, ha="right", c="#a3222e")
s.save("c07_fibtree")

# ---- Towers of Hanoi n = 3 ----
def moves(n, f, t, v, out):
    if n == 0: return
    moves(n - 1, f, v, t, out); out.append((f, t)); moves(n - 1, v, t, f, out)
ms = []; moves(3, 0, 2, 1, ms)
pegs = [[3, 2, 1], [], []]
states = [[list(p) for p in pegs]]
for a, c in ms:
    pegs[c].append(pegs[a].pop()); states.append([list(p) for p in pegs])
s = Sketch(15.0, 6.0)
cols = {1: "#7fb2e5", 2: "#f0b25a", 3: "#8fcaa9"}
for k, st in enumerate(states):
    i, j = k % 5, k // 5
    ox, oy = 0.2 + i * 3.0, 3.3 - j * 3.0
    s.ax.plot([ox, ox + 2.3], [oy, oy], color="#555", lw=1.0, solid_capstyle="round")
    for p in range(3):
        px = ox + 0.5 + p * 0.95
        s.ax.plot([px, px], [oy, oy + 1.6], color="#999", lw=1.1, solid_capstyle="round")
        for h, d in enumerate(st[p]):
            w = 0.25 + 0.2 * d
            rb(s, px, oy + 0.17 + h * 0.3, 0.28 + 0.14 * d, 0.26, "grey", r=0.09, fc=cols[d], ec="#666" , lw=0.4)
    lab(s, ox + 1.15, oy - 0.4, "start" if k == 0 else (f"{k}: {'ABC'[ms[k-1][0]]} → {'ABC'[ms[k-1][1]]}" ), size=8, c="#333")
s.ax.set_ylim(-0.4, 5.2); s.ax.set_xlim(0, 15.0)
s.save("c07_hanoi")
