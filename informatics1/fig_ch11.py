from inf import *

# ---- memory regions ----
s = Sketch(13.6, 7.2)
regs = [("stack", "local variables, parameters, return addresses;\ngrows with every call, automatically", "blue", 6.1),
        ("", "free", "white", 4.7), ("heap", "memory obtained with new;\nlives until you delete it", "amber", 3.4),
        ("static", "global variables, constants", "violet", 2.2), ("code", "the machine instructions of the program", "grey", 1.1)]
for name, desc, tone, y in regs:
    h = 1.0 if name != "" else 0.9
    rb(s, 3.0, y, 5.0, h, tone, r=0.2, dash=(3, 2) if tone == "white" else None)
    if name: lab(s, 3.0, y, name, size=10.5, bold=True, mono=True)
    else: lab(s, 3.0, y, "unused", size=8.5, c="#aaa")
    if name: lab(s, 6.0, y, desc, size=8.3, ha="left", c="#444")
arr(s, (1.0, 5.6), (1.0, 5.05), c="#3d7cc9", lw=1.2); arr(s, (1.0, 3.9), (1.0, 4.35), c="#c7741a", lw=1.2)
lab(s, 0.3, 6.8, "high addresses", size=7.8, c="#777", ha="left"); lab(s, 0.3, 0.45, "low addresses", size=7.8, c="#777", ha="left")
s.save("c11_memory")

# ---- pointer picture ----
s = Sketch(14.0, 4.6)
lab(s, 0.1, 4.3, "int a = 42;   int* p = &a;", size=8.8, mono=True, ha="left")
cell(s, 9.5, 2.1, 2.2, 1.3, "42", "blue", size=12, bold=True, r=0.2); lab(s, 9.5, 3.0, "a", size=9.5, mono=True, bold=True, c="#2c64a8")
lab(s, 9.5, 1.2, "address 0x7ffc10", size=7.8, mono=True, c="#777")
cell(s, 3.2, 2.1, 3.0, 1.3, "0x7ffc10", "amber", size=10, bold=True, r=0.2); lab(s, 3.2, 3.0, "p", size=9.5, mono=True, bold=True, c="#9a520c")
lab(s, 3.2, 1.2, "holds an address", size=7.8, c="#777")
arr(s, (4.8, 2.1), (8.35, 2.1), c="#a3222e", lw=1.5); lab(s, 6.6, 2.45, "points to", size=8.5, c="#a3222e")
lab(s, 13.9, 2.1, "*p means\n\"the cell that\np points to\"", size=8, c="#444", ha="right")
s.save("c11_pointer")

# ---- linked list ----
s = Sketch(14.6, 4.4)
cell(s, 1.0, 2.2, 1.5, 1.0, "head", "amber", size=8.5, r=0.2)
xs = [3.6, 6.7, 9.8]
vals = [1, 2, 3]
for i, (x, v) in enumerate(zip(xs, vals)):
    rb(s, x, 2.2, 2.4, 1.2, "blue", r=0.2); vline_(s, x + 0.3, 1.6, 2.8, c="#9cc3ea", lw=0.9)
    lab(s, x - 0.45, 2.2, str(v), size=11, bold=True, mono=True); 
    dot(s, (x + 0.9, 2.2), c="#555", r=0.08)
    lab(s, x - 0.45, 1.25, "value", size=6.8, c="#777"); lab(s, x + 0.9, 1.25, "next", size=6.8, c="#777")
arr(s, (1.75, 2.2), (xs[0] - 1.2, 2.2), c="#555", lw=1.2)
for i in range(2): arr(s, (xs[i] + 0.9, 2.2), (xs[i + 1] - 1.2, 2.2), c="#555", lw=1.2)
cell(s, 12.9, 2.2, 1.5, 1.0, "nullptr", "grey", size=8, r=0.2, c="#a3222e"); arr(s, (xs[2] + 0.9, 2.2), (12.15, 2.2), c="#555", lw=1.2)
lab(s, 7.3, 3.9, "nodes live anywhere on the heap; the pointers link them into a chain", size=8.3, c="#555")
s.save("c11_list")

# ---- insert / remove ----
s = Sketch(14.6, 7.6)
def chain(y, vals, tone="blue", skip=None, new=None, title=None, extra=None):
    lab(s, 0.1, y + 0.9, title, size=8.5, bold=True, ha="left")
    xs = [1.5 + i * 2.4 for i in range(len(vals))]
    for i, (x, v) in enumerate(zip(xs, vals)):
        cell(s, x, y, 1.4, 0.9, str(v), "green" if v == new else tone, size=10, bold=True, mono=True, r=0.2)
    return xs
y = 6.2
xs = chain(y, [1, 2, 4], title="before: insert 3 after the node with value 2")
for i in range(2): arr(s, (xs[i] + 0.7, y), (xs[i + 1] - 0.7, y), c="#555", lw=1.1)
y = 4.3
xs = chain(y, [1, 2, 4], title="step 1: new node, its next := p->next")
cell(s, xs[1] + 1.5, y - 1.15, 1.4, 0.9, "3", "green", size=10, bold=True, mono=True, r=0.2)
arr(s, (xs[0] + 0.7, y), (xs[1] - 0.7, y), c="#555", lw=1.1); arr(s, (xs[1] + 0.7, y), (xs[2] - 0.7, y), c="#bbb", lw=1.1)
arr(s, (xs[1] + 2.0, y - 0.7), (xs[2] - 0.2, y - 0.5), c="#2a7f5a", lw=1.3, rad=0.2)
y = 2.1
xs = chain(y, [1, 2, 4], title="step 2: p->next := new node")
cell(s, xs[1] + 1.5, y - 1.15, 1.4, 0.9, "3", "green", size=10, bold=True, mono=True, r=0.2)
arr(s, (xs[0] + 0.7, y), (xs[1] - 0.7, y), c="#555", lw=1.1)
arr(s, (xs[1] + 0.5, y - 0.45), (xs[1] + 0.9, y - 0.7), c="#2a7f5a", lw=1.5)
arr(s, (xs[1] + 2.0, y - 0.7), (xs[2] - 0.2, y - 0.5), c="#2a7f5a", lw=1.3, rad=0.2)
s.ax.set_ylim(0.4, 7.2)
s.save("c11_insert")
