from inf import *

def obj(x, y, name, ptrtxt="data_"):
    rb(s, x, y, 2.6, 1.3, "blue", r=0.2); lab(s, x, y + 0.7, name, size=8.5, mono=True, bold=True, c="#2c64a8")
    lab(s, x - 0.55, y, "size_  3", size=7.6, mono=True); dot(s, (x + 0.7, y - 0.35), c="#555", r=0.08)
    lab(s, x + 0.3, y - 0.35, "data_", size=7.6, mono=True, ha="right")
def arrayat(x, y, vals, tone="amber"):
    for i, v in enumerate(vals): cell(s, x + i * 0.95, y, 0.85, 0.8, str(v), tone, size=9, r=0.15)

s = Sketch(15.0, 6.2)
lab(s, 3.5, 5.9, "shallow copy (compiler default)", size=9, bold=True, c="#a3222e")
obj(1.7, 4.5, "a"); obj(1.7, 2.0, "b")
arrayat(5.0, 3.4, [1, 4, 9])
arr(s, (2.4, 4.15), (5.0, 3.6), c="#a3222e", lw=1.2); arr(s, (2.4, 1.65), (5.0, 3.15), c="#a3222e", lw=1.2)
lab(s, 5.5, 2.35, "one array, two owners:\nboth destructors call delete[]", size=8, c="#a3222e")
lab(s, 11.0, 5.9, "deep copy (our copy constructor)", size=9, bold=True, c="#2a7f5a")
obj(9.2, 4.5, "a"); obj(9.2, 2.0, "b")
arrayat(12.0, 4.5, [1, 4, 9]); arrayat(12.0, 2.0, [1, 4, 9], "green")
arr(s, (9.9, 4.15), (12.0, 4.3), c="#2a7f5a", lw=1.2); arr(s, (9.9, 1.65), (12.0, 1.85), c="#2a7f5a", lw=1.2)
lab(s, 12.9, 0.9, "each object owns its own array", size=8, c="#2a7f5a")
vline_(s, 7.8, 0.5, 5.9, c="#ccc", lw=0.8, dash=(3, 3))
s.save("c12_copy")

# ---- growth by doubling ----
s = Sketch(15.0, 5.2)
def row(y, cap, n, lbl, tone="blue"):
    lab(s, 0.1, y, lbl, size=7.8, mono=True, ha="left")
    for i in range(cap):
        cell(s, 4.2 + i * 0.85, y, 0.78, 0.7, str(i * i + 1) if i < n else "", tone if i < n else "white", size=8, r=0.12)
row(4.5, 4, 4, "cap 4, size 4")
lab(s, 0.1, 3.6, "push_back(17):  allocate 8, copy 4 values, delete[] the old array, store the new value", size=8.3, c="#a3222e", ha="left")
row(2.6, 8, 5, "cap 8, size 5")
for i in range(4): arr(s, (4.2 + i * 0.85, 4.12), (4.2 + i * 0.85, 2.98), c="#bbb", lw=0.7, head=4)
lab(s, 0.1, 1.2, "Each growth step copies all elements, but because the capacity doubles,\nthe copying work per push_back is small on average (\"amortised constant\").", size=8.3, ha="left", c="#444")
s.save("c12_growth")
