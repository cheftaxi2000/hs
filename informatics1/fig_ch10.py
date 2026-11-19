from inf import *

# ---- information hiding ----
s = Sketch(14.6, 5.6)
# left: no hiding
lab(s, 3.3, 5.3, "without hiding", size=9, bold=True, c="#a3222e")
cell(s, 3.3, 2.6, 4.4, 1.5, "", "red"); lab(s, 3.3, 2.9, "balance", size=9, mono=True, bold=True); lab(s, 3.3, 2.3, "anybody may change it", size=8, c="#a3222e")
for k, y in enumerate((4.2, 1.0, 2.6)):
    pass
lab(s, 0.5, 4.2, "program\npart A", size=7.8, c="#555"); lab(s, 0.5, 1.0, "program\npart B", size=7.8, c="#555"); lab(s, 6.7, 4.2, "program\npart C", size=7.8, c="#555")
arr(s, (1.2, 4.0), (2.2, 3.2), c="#a3222e", lw=1.0); arr(s, (1.2, 1.2), (2.2, 2.0), c="#a3222e", lw=1.0); arr(s, (6.1, 3.9), (5.1, 3.2), c="#a3222e", lw=1.0)
# right: capsule
lab(s, 10.6, 5.3, "with a class", size=9, bold=True, c="#2a7f5a")
rb(s, 10.6, 2.6, 5.4, 3.6, "green", r=0.5, lw=1.2)
lab(s, 10.6, 4.0, "public interface", size=8.3, c="#2a7f5a", bold=True)
cell(s, 10.6, 2.0, 2.6, 1.5, "", "grey"); lab(s, 10.6, 2.25, "balance_", size=9, mono=True, bold=True); lab(s, 10.6, 1.7, "private", size=7.8, c="#777")
for x, t, y in [(8.7, "deposit()", 3.15), (12.5, "withdraw()", 3.15), (10.6, "balance()", 3.5)]:
    pass
cell(s, 8.65, 3.0, 1.7, 0.6, "deposit()", "green", size=7.8, r=0.2); cell(s, 12.55, 3.0, 1.9, 0.6, "withdraw()", "green", size=7.8, r=0.2); cell(s, 10.6, 3.35, 1.7, 0.55, "balance()", "green", size=7.8, r=0.2)
lab(s, 13.8, 0.35, "only the member functions touch the data, and they keep the invariant", size=8, c="#444", ha="right")
s.save("c10_hiding")

# ---- iterator ----
s = Sketch(14.4, 5.4)
vals = [3, 1, 4, 1, 5]
for i, v in enumerate(vals):
    cell(s, 2.0 + i * 1.7, 2.6, 1.55, 1.2, str(v), "blue", size=11, bold=True, r=0.2)
cell(s, 2.0 + 5 * 1.7, 2.6, 1.55, 1.2, "", "white", r=0.2); lab(s, 2.0 + 5 * 1.7, 2.6, "end", size=8, c="#999", mono=True)
lab(s, 0.1, 2.6, "v", size=10, mono=True, bold=True, ha="left")
arr(s, (2.0, 4.6), (2.0, 3.3), c="#2f8a5f", lw=1.3); lab(s, 2.0, 4.85, "v.begin()", size=8.5, mono=True, c="#2f8a5f", bold=True)
arr(s, (2.0 + 5 * 1.7, 4.6), (2.0 + 5 * 1.7, 3.3), c="#a3222e", lw=1.3); lab(s, 2.0 + 5 * 1.7, 4.85, "v.end()", size=8.5, mono=True, c="#a3222e", bold=True)
arr(s, (2.0 + 2 * 1.7, 0.7), (2.0 + 2 * 1.7, 1.9), c="#7356a6", lw=1.3); lab(s, 2.0 + 2 * 1.7, 0.4, "it", size=9, mono=True, c="#7356a6", bold=True)
lab(s, 2.0 + 2 * 1.7 + 0.2, 1.35, "*it is 4;  ++it moves right", size=8, c="#7356a6", ha="left")
lab(s, 2.0 + 5 * 1.7, 1.55, "one past the last", size=7.6, c="#a3222e")
s.save("c10_iter")

# ---- containers ----
s = Sketch(15.0, 7.4)
def title(x, y, t): lab(s, x, y, t, size=9, bold=True, mono=True)
# vector
title(1.9, 7.0, "vector")
for i, v in enumerate(["5", "2", "9"]): cell(s, 0.9 + i * 1.1, 6.0, 1.0, 0.8, v, "blue", size=9.5, r=0.15)
lab(s, 1.9, 5.25, "indexed, in order of\ninsertion; fast at the end", size=7.6, c="#555")
# list
title(5.9, 7.0, "list")
for i, v in enumerate(["5", "2", "9"]):
    cell(s, 4.9 + i * 1.5, 6.0, 0.95, 0.8, v, "teal", size=9.5, r=0.15)
    if i < 2: arr(s, (5.4 + i * 1.5, 6.0), (5.9 + i * 1.5 - 0.0 + 0.0, 6.0), c="#555", lw=0.9, head=5)
lab(s, 5.9, 5.25, "chain of nodes; cheap to\ninsert and remove anywhere", size=7.6, c="#555")
# set
title(11.3, 7.0, "set")
for (x, y, v) in [(11.3, 6.2, "4"), (10.4, 5.35, "2"), (12.2, 5.35, "9")]: cell(s, x, y, 0.9, 0.7, v, "green", size=9.5, r=0.3)
link(s, (11.15, 5.9), (10.55, 5.65)); link(s, (11.45, 5.9), (12.05, 5.65))
lab(s, 13.9, 5.7, "sorted, no duplicates;\nfast search", size=7.6, c="#555", ha="left")
# map
title(3.5, 4.2, "map<string,int>")
for i, (k, v) in enumerate([("Alice", "21"), ("Bob", "19"), ("Carol", "20")]):
    cell(s, 2.4, 3.4 - i * 0.85, 1.9, 0.7, k, "amber", size=8.5, r=0.15); cell(s, 4.4, 3.4 - i * 0.85, 1.0, 0.7, v, "violet", size=8.5, r=0.15)
    arr(s, (3.4, 3.4 - i * 0.85), (3.9, 3.4 - i * 0.85), c="#555", lw=0.8, head=5)
lab(s, 7.0, 2.55, "key → value, sorted by key;\nlook up by name instead of index", size=7.6, c="#555", ha="left")
s.ax.set_ylim(0.2, 7.4)
s.save("c10_containers")
