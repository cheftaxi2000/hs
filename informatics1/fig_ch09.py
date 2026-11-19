from inf import *

# ---- permutation decision tree for abc ----
s = Sketch(14.6, 7.0); s.ax.set_ylim(0.0, 7.0)
def nd(x, y, pre, rest, leaf=False):
    cell(s, x, y, 1.9 if not leaf else 1.2, 0.85, (pre or "∅") + " | " + rest if not leaf else pre, "green" if leaf else "blue", size=8.2, mono=True, r=0.2)
nd(7.3, 6.4, "", "abc")
firsts = [("a", "bc"), ("b", "ac"), ("c", "ab")]
for k, (p, r) in enumerate(firsts):
    x = 2.6 + k * 4.8
    link(s, (7.3, 5.97), (x, 4.98), c="#9aa5b1"); nd(x, 4.55, p, r)
    for m in range(2):
        x2 = x + (-1.2 if m == 0 else 1.2); y2 = 2.9
        link(s, (x, 4.12), (x2, 3.33), c="#9aa5b1")
        pre2 = p + r[m]; rest2 = r[1 - m]
        nd(x2, y2, pre2, rest2)
        link(s, (x2, 2.47), (x2, 1.78), c="#9aa5b1"); nd(x2, 1.35, pre2 + rest2, "", leaf=True)
lab(s, 0.1, 6.4, "prefix | rest", size=7.8, c="#777", ha="left", mono=True)
lab(s, 7.3, 0.4, "the leaves are the 6 permutations of abc", size=8.5, c="#2a7f5a", bold=True)
s.save("c09_perm")

# ---- merge sort ----
s = Sketch(15.0, 7.6)
def row(y, groups, tone):
    xs = []
    n = sum(len(g) for g in groups); gap = 0.35; w = 0.8
    total = n * w + (len(groups) - 1) * gap
    x = 7.5 - total / 2
    for g in groups:
        for v in g:
            cell(s, x + w / 2, y, w - 0.08, 0.75, str(v), tone, size=9, bold=True, r=0.15); x += w
        x += gap
    return
levels = [[[5, 2, 9, 1, 7, 3, 8, 4]], [[5, 2, 9, 1], [7, 3, 8, 4]], [[5, 2], [9, 1], [7, 3], [8, 4]], [[5], [2], [9], [1], [7], [3], [8], [4]]]
ys = [7.0, 5.7, 4.4, 3.1]
for y, g in zip(ys, levels): row(y, g, "blue")
lab(s, 0.1, 7.0, "split", size=8, c="#3d7cc9", ha="left", bold=True)
merged = [[[2, 5], [1, 9], [3, 7], [4, 8]], [[1, 2, 5, 9], [3, 4, 7, 8]], [[1, 2, 3, 4, 5, 7, 8, 9]]]
for y, g in zip([1.8, 0.5, -0.8], merged): row(y, g, "green")
lab(s, 0.1, 1.8, "merge", size=8, c="#2a7f5a", ha="left", bold=True)
for y0, y1 in [(6.55, 6.1), (5.25, 4.8), (3.95, 3.5)]: arr(s, (7.5, y0), (7.5, y1), c="#3d7cc9", lw=0.9)
for y0, y1 in [(2.7, 2.25), (1.4, 0.95), (0.1, -0.35)]: pass
arr(s, (7.5, 2.75), (7.5, 2.25), c="#2a7f5a", lw=0.9); arr(s, (7.5, 1.45), (7.5, 0.95), c="#2a7f5a", lw=0.9); arr(s, (7.5, 0.15), (7.5, -0.35), c="#2a7f5a", lw=0.9)
s.ax.set_ylim(-1.4, 7.6)
s.save("c09_merge")

# ---- 8 queens solution ----
sol = [0, 4, 7, 5, 2, 6, 1, 3]
s = Sketch(6.6, 6.9)
for r in range(8):
    for c in range(8):
        s.ax.add_patch(Rectangle((c * 0.8, (7 - r) * 0.8), 0.8, 0.8, fc="#f1d9b5" if (r + c) % 2 == 0 else "#b88b5f", ec="none", zorder=1))
for r, c in enumerate(sol):
    x, y = c * 0.8 + 0.4, (7 - r) * 0.8 + 0.4
    s.ax.add_patch(Circle((x, y), 0.27, fc="#a3222e", ec="white", lw=1.2, zorder=4)); lab(s, x, y - 0.01, "Q", size=9, c="white", bold=True)
for k in range(8): lab(s, k * 0.8 + 0.4, 6.7, str(k), size=7.5, c="#777"); lab(s, -0.3, (7 - k) * 0.8 + 0.4, str(k), size=7.5, c="#777")
lab(s, 3.2, -0.3, "col = {0, 4, 7, 5, 2, 6, 1, 3}", size=8, mono=True, c="#333")
s.ax.set_xlim(-0.6, 6.6); s.ax.set_ylim(-0.6, 6.9)
s.save("c09_queens")

# ---- struct memory ----
s = Sketch(13.0, 4.2)
lab(s, 0.1, 3.9, "Point p = {3.0, 4.0};", size=8.6, mono=True, ha="left")
cell(s, 2.0, 2.2, 3.4, 1.3, "3.0", "blue", size=11, bold=True, r=0.2); cell(s, 5.4, 2.2, 3.4, 1.3, "4.0", "green", size=11, bold=True, r=0.2)
lab(s, 2.0, 1.3, "p.x  (8 bytes)", size=8.5, mono=True); lab(s, 5.4, 1.3, "p.y  (8 bytes)", size=8.5, mono=True)
s.ax.annotate("", xy=(0.25, 0.75), xytext=(7.1, 0.75), arrowprops=dict(arrowstyle="<->", color="#c4473a", lw=0.9)); lab(s, 3.7, 0.4, "p: one variable, 16 bytes, members one after another", size=8.3, c="#c4473a")
lab(s, 9.5, 2.2, "members are selected\nwith a dot:  p.x,  p.y", size=8.5, ha="left", c="#444")
s.save("c09_struct")
