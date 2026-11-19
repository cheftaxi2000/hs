from inf import *

# ---- reference vs copy ----
s = Sketch(14.4, 4.6)
lab(s, 0.2, 4.3, "int a = 5;   int& r = a;   int c = a;", size=8.6, mono=True, ha="left")
cell(s, 3.0, 2.2, 1.6, 1.3, "7", "blue", size=11, bold=True, r=0.25)
lab(s, 3.0, 3.15, "one memory cell", size=7.8, c="#777")
lab(s, 1.15, 2.7, "a", size=9.5, mono=True, bold=True, c="#2c64a8"); lab(s, 1.15, 1.7, "r", size=9.5, mono=True, bold=True, c="#2c64a8")
arr(s, (1.45, 2.6), (2.15, 2.4), c="#3d7cc9", lw=0.9); arr(s, (1.45, 1.8), (2.15, 2.0), c="#3d7cc9", lw=0.9)
lab(s, 3.0, 0.9, "two names, one variable", size=8.5, c="#444")
cell(s, 8.4, 2.2, 1.6, 1.3, "100", "amber", size=11, bold=True, r=0.25)
lab(s, 8.4, 3.15, "a different cell", size=7.8, c="#777"); lab(s, 6.8, 2.2, "c", size=9.5, mono=True, bold=True, c="#9a520c")
arr(s, (7.1, 2.2), (7.55, 2.2), c="#c7741a", lw=0.9)
lab(s, 8.4, 0.9, "a copy: independent", size=8.5, c="#444")
s.save("c06_ref")

# ---- vector layout ----
s = Sketch(14.4, 5.2)
lab(s, 0.2, 4.9, "std::vector<int> v = {4, 8, 15};   v.push_back(16);", size=8.4, mono=True, ha="left")
vals = ["4", "8", "15", "16"]
for i, v in enumerate(vals):
    cell(s, 2.0 + i * 1.5, 3.0, 1.4, 1.2, v, "blue", size=10.5, bold=True, r=0.2)
    lab(s, 2.0 + i * 1.5, 2.15, f"v[{i}]", size=8, mono=True, c="#555")
    lab(s, 2.0 + i * 1.5, 3.85, str(i), size=7.5, c="#999")
for i in range(4, 6): cell(s, 2.0 + i * 1.5, 3.0, 1.4, 1.2, "", "white", r=0.2)
lab(s, 0.2, 3.0, "v", size=10, mono=True, bold=True, ha="left")
lab(s, 2.0 + 4.5 * 1.5 + 0.8, 3.0, "unused\nreserve", size=7.5, c="#999", ha="left")
dimension_x = 2.0 - 0.7
s.ax.annotate("", xy=(2.0 - 0.7, 1.55), xytext=(2.0 + 3 * 1.5 + 0.7, 1.55), arrowprops=dict(arrowstyle="<->", color="#c4473a", lw=0.9))
lab(s, 2.0 + 1.5 * 1.5, 1.2, "v.size() == 4", size=8.5, mono=True, c="#c4473a")
lab(s, 7.2, 0.4, "indices run from 0 to size() − 1; v[4] would be outside the vector", size=8.2, c="#a3222e")
s.save("c06_vec")

# ---- sieve of Eratosthenes ----
s = Sketch(14.2, 5.7)
cols = {2: "#cfe3f6", 3: "#d3eadf", 5: "#fcf0dc", 7: "#efe9f7"}
cw, ch = 1.3, 0.85
for k in range(2, 50):
    i, j = (k - 2) % 10, (k - 2) // 10
    x, y = 0.9 + i * cw, 5.2 - j * ch
    prime = all(k % d for d in range(2, int(k ** .5) + 1))
    first = next((d for d in (2, 3, 5, 7) if k % d == 0 and k != d), None)
    if prime:
        rb(s, x, y, cw - 0.12, ch - 0.12, "red", r=0.18); lab(s, x, y, str(k), size=9, bold=True)
    else:
        rb(s, x, y, cw - 0.12, ch - 0.12, "grey", r=0.18, fc=cols[first]); lab(s, x, y, str(k), size=9, c="#888")
y0 = 0.4
for n, (d, c) in enumerate(cols.items()):
    rb(s, 1.0 + n * 3.0, y0, 0.5, 0.4, "grey", r=0.1, fc=c); lab(s, 1.35 + n * 3.0, y0, f"crossed out by {d}", size=8, ha="left")
rb(s, 12.9, y0, 0.5, 0.4, "red", r=0.1); lab(s, 13.25, y0, "prime", size=8, ha="left")
s.save("c06_sieve")
