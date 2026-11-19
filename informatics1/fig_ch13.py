from inf import *

POS = {50: (0, 0), 30: (-1, -1), 70: (1, -1), 20: (-1.5, -2), 40: (-0.5, -2), 60: (0.5, -2), 80: (1.5, -2), 35: (-0.75, -3)}
EDGES = [(50, 30), (50, 70), (30, 20), (30, 40), (70, 60), (70, 80), (40, 35)]
def tree(s, ox, oy, sx=1.7, sy=1.15, hi=(), tone="blue", labels=None, pos=POS, edges=EDGES, hed=(), rad=0.38, size=9):
    for a, b in edges:
        (x1, y1), (x2, y2) = pos[a], pos[b]
        on = (a, b) in hed
        s.ax.plot([ox + x1 * sx, ox + x2 * sx], [oy + y1 * sy, oy + y2 * sy], color="#d1495b" if on else "#9aa5b1", lw=1.8 if on else 1.1, zorder=1)
    for k, (x, y) in pos.items():
        t = "amber" if k in hi else tone
        rb(s, ox + x * sx, oy + y * sy, rad * 2, rad * 2, t, r=rad, z=3, lw=0.9)
        lab(s, ox + x * sx, oy + y * sy, str(k), size=size, bold=True, mono=True)
        if labels and k in labels: lab(s, ox + x * sx + 0.45, oy + y * sy + 0.42, str(labels[k]), size=7.8, c="#c26a10", bold=True)

# ---- stack / queue ----
s = Sketch(14.6, 4.6)
lab(s, 3.2, 4.3, "stack: last in, first out", size=9, bold=True)
for i, v in enumerate([1, 2, 3]): cell(s, 3.2, 0.7 + i * 0.85, 2.2, 0.75, str(v), "blue", size=10, bold=True, r=0.15)
arr(s, (1.0, 3.7), (2.0, 2.95), c="#2a7f5a", lw=1.2); lab(s, 0.9, 3.95, "push(4)", size=8.5, mono=True, c="#2a7f5a", ha="center")
arr(s, (4.4, 2.95), (5.4, 3.7), c="#a3222e", lw=1.2); lab(s, 5.4, 3.95, "pop()", size=8.5, mono=True, c="#a3222e")
lab(s, 3.2, 0.1, "everything happens at the top", size=7.8, c="#777")
lab(s, 10.6, 4.3, "queue: first in, first out", size=9, bold=True)
for i, v in enumerate([1, 2, 3]): cell(s, 8.4 + i * 1.5, 2.0, 1.35, 0.9, str(v), "teal", size=10, bold=True, r=0.15)
arr(s, (13.6, 2.0), (12.5, 2.0), c="#2a7f5a", lw=1.2) if False else None
arr(s, (13.8, 2.0), (13.0, 2.0), c="#2a7f5a", lw=1.2); lab(s, 13.9, 1.45, "push_back(4)", size=8, mono=True, c="#2a7f5a", ha="right")
arr(s, (7.6, 2.0), (6.8, 2.0), c="#a3222e", lw=1.2); lab(s, 7.6, 1.45, "pop_front()", size=8, mono=True, c="#a3222e", ha="right")
lab(s, 8.4, 2.75, "front", size=7.8, c="#777"); lab(s, 11.4, 2.75, "back", size=7.8, c="#777")
s.save("c13_stackqueue")

# ---- BST with search path ----
s = Sketch(11.6, 8.0)
tree(s, 5.8, 7.0, hi=(50, 30, 40, 35), hed=[(50, 30), (30, 40), (40, 35)], sx=2.6, sy=1.7, rad=0.5, size=10.5)
lab(s, 0.2, 7.6, "binary search tree", size=9, bold=True, ha="left")
lab(s, 0.2, 7.05, "every key in the left subtree is\nsmaller, in the right one larger", size=8, c="#555", ha="left")
lab(s, 0.2, 2.2, "contains(35):\n35 < 50 → left\n35 > 30 → right\n35 < 40 → left\nfound after 4 steps", size=8.2, c="#a3222e", ha="left")
s.ax.set_ylim(0.2, 8.2)
s.save("c13_bst")

# ---- three traversals ----
s = Sketch(15.0, 5.2)
def order(kind):
    out = []
    def rec(k):
        kids = {50: (30, 70), 30: (20, 40), 70: (60, 80), 40: (35, None)}
        if k is None: return
        l, r = kids.get(k, (None, None))
        if kind == "pre": out.append(k)
        rec(l)
        if kind == "in": out.append(k)
        rec(r)
        if kind == "post": out.append(k)
    rec(50); return {k: i + 1 for i, k in enumerate(out)}
for n, (kind, title) in enumerate([("pre", "preorder: node, left, right"), ("in", "inorder: left, node, right"), ("post", "postorder: left, right, node")]):
    ox = 2.5 + n * 5.0
    lab(s, ox, 5.0, title, size=8.3, bold=True)
    tree(s, ox, 4.2, sx=1.0, sy=0.95, labels=order(kind), rad=0.32, size=8, tone="blue" if kind != "in" else "green")
s.ax.set_ylim(0.6, 5.3)
s.save("c13_traversal")

# ---- erase: three cases ----
s = Sketch(16.4, 5.4)
cases = [("leaf: just remove it", {5: (0, 0), 3: (-0.8, -1), 8: (0.8, -1)}, [(5, 3), (5, 8)], 3),
         ("one child: it moves up", {5: (0, 0), 3: (-0.8, -1), 8: (0.8, -1), 7: (0.2, -2)}, [(5, 3), (5, 8), (8, 7)], 8),
         ("two children: successor takes over", {5: (0, 0), 3: (-1.0, -1), 8: (1.0, -1), 6: (0.3, -2), 9: (1.7, -2)}, [(5, 3), (5, 8), (8, 6), (8, 9)], 5)]
for n, (title, pos, ed, rem) in enumerate(cases):
    ox = 2.4 + n * 5.4
    lab(s, ox + 0.3, 5.1, title, size=8.2, bold=True)
    for a, b in ed: s.ax.plot([ox + pos[a][0] * 1.4, ox + pos[b][0] * 1.4], [4.1 + pos[a][1] * 1.1, 4.1 + pos[b][1] * 1.1], color="#9aa5b1", lw=1.1, zorder=1)
    for k, (x, y) in pos.items():
        rb(s, ox + x * 1.4, 4.1 + y * 1.1, 0.7, 0.7, "red" if k == rem else "blue", r=0.35, z=3)
        lab(s, ox + x * 1.4, 4.1 + y * 1.1, str(k), size=8.5, bold=True, mono=True)
    lab(s, ox, 0.8, "remove " + str(rem), size=8, c="#a3222e", mono=True)
s.ax.set_ylim(0.4, 5.4)
s.save("c13_erase")

# ---- balanced vs degenerate ----
s = Sketch(14.6, 5.0)
bal = {4: (0, 0), 2: (-1, -1), 6: (1, -1), 1: (-1.5, -2), 3: (-0.5, -2), 5: (0.5, -2), 7: (1.5, -2)}
be = [(4, 2), (4, 6), (2, 1), (2, 3), (6, 5), (6, 7)]
lab(s, 3.2, 4.8, "inserted 4, 2, 6, 1, 3, 5, 7:  height 3", size=8.5, bold=True)
tree(s, 3.2, 4.0, sx=1.4, sy=1.1, pos=bal, edges=be, rad=0.32, size=8.5)
lab(s, 11.0, 4.8, "inserted 1, 2, 3, ..., 7:  height 7", size=8.5, bold=True)
chain = {k: (0.0 + (k - 1) * 0.5, -(k - 1) * 0.55) for k in range(1, 8)}
tree(s, 9.0, 4.2, sx=0.9, sy=0.9, pos=chain, edges=[(k, k + 1) for k in range(1, 7)], rad=0.28, size=8)
lab(s, 7.3, 0.2, "same keys, same rules: the shape depends on the insertion order", size=8, c="#666")
s.ax.set_ylim(0.0, 5.0)
s.save("c13_degenerate")
