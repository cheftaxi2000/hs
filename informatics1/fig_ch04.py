from inf import *

# ---- nested loops: order of visits ----
s = Sketch(8.6, 5.6)
lab(s, 4.5, 5.35, "j (inner loop)", size=8.5, c="#555"); lab(s, 0.1, 2.9, "i\n(outer)", size=8.5, c="#555", ha="left")
k = 0
for i in range(1, 5):
    for j in range(1, 5):
        x, y = 1.8 + (j - 1) * 1.7, 4.4 - (i - 1) * 1.1
        on = j <= i
        cell(s, x, y, 1.5, 0.85, f"({i},{j})" if on else "", "teal" if on else "white", size=8, r=0.2, c=INK if on else "#bbb")
        if on: k += 1; lab(s, x + 0.55, y + 0.3, str(k), size=7, c="#c26a10", bold=True)
for j in range(1, 5): lab(s, 1.8 + (j - 1) * 1.7, 5.05, str(j), size=8, c="#777")
for i in range(1, 5): lab(s, 0.85, 4.4 - (i - 1) * 1.1, str(i), size=8, c="#777")
lab(s, 4.3, 0.15, "orange numbers: order of the visits; the inner loop runs fastest", size=8, c="#c26a10")
s.save("c04_nested")

# ---- call stack snapshots ----
s = Sketch(15.0, 5.6)
src = ["int g(int y) { return 2 * y; }", "int f(int x) { return g(x) + 1; }", "int main() { int r = f(5); }"]
for k_, t in enumerate(src): lab(s, 0.3, 5.35 - k_ * 0.45, t, size=7.8, mono=True, ha="left")
snaps = [("1  in main", [("main", "r = ?")]), ("2  f called", [("main", "r = ?"), ("f", "x = 5")]),
         ("3  g called", [("main", "r = ?"), ("f", "x = 5"), ("g", "y = 5")]), ("4  g returned 10", [("main", "r = ?"), ("f", "x = 5")]), ("5  f returned 11", [("main", "r = 11")])]
for n, (title, frames) in enumerate(snaps):
    x = 1.55 + n * 2.95
    lab(s, x, 3.85, title, size=8.2, bold=True, c="#333")
    for lvl, (fn, vars_) in enumerate(frames):
        y = 0.9 + lvl * 1.0
        tone = ["blue", "teal", "violet"][lvl]
        rb(s, x, y, 2.5, 0.88, tone, r=0.15)
        lab(s, x, y + 0.18, fn, size=8.4, mono=True, bold=True); lab(s, x, y - 0.2, vars_, size=7.8, mono=True)
    hline_(s, x - 1.4, x + 1.4, 0.33, c="#999", lw=1.0)
lab(s, 7.5, 0.05, "the stack grows upwards with every call and shrinks with every return", size=8.2, c="#666")
s.ax.set_ylim(-0.1, 5.7)
s.save("c04_stack")

# ---- function anatomy ----
s = Sketch(15.2, 5.4)
rb(s, 7.6, 2.0, 14.4, 2.5, "white", r=0.2)
cw = 9.0 * 0.602 / 72 * 2.54; x0 = 0.9
lab(s, x0, 2.85, "int max(int a, int b) {", size=9, mono=True, ha="left")
lab(s, x0, 2.25, "    if (a > b) return a;", size=9, mono=True, ha="left")
lab(s, x0, 1.65, "    return b;", size=9, mono=True, ha="left")
lab(s, x0, 1.05, "}", size=9, mono=True, ha="left")
lab(s, 10.2, 2.25, "int m = max(3, x);", size=9, mono=True, ha="left")
lab(s, 10.2, 2.85, "// a call:", size=8.5, mono=True, ha="left", c="#777")
def und(a, b, y, c, xs=x0): s.ax.plot([xs + a * cw, xs + b * cw], [y, y], color=c, lw=2.2, solid_capstyle="round", zorder=4)
und(0, 3, 3.07, "#3d7cc9"); und(4, 7, 3.07, "#2f8a5f"); und(8, 20, 3.07, "#c7741a"); und(13, 17, 2.47, "#7356a6", xs=10.2)
for (x, t1, t2, tone, ax_) in [(1.9, "return type", "the type of the result", "blue", x0 + 1.5 * cw), (5.2, "name", "how to call it", "green", x0 + 5.5 * cw), (8.6, "parameters", "inputs, with types", "amber", x0 + 14 * cw), (12.3, "arguments", "actual values at the call", "violet", 10.2 + 15 * cw)]:
    rb(s, x, 4.75, 3.1, 1.1, tone, r=0.2); lab(s, x, 4.98, t1, size=9, bold=True); lab(s, x, 4.52, t2, size=7.6, c="#444")
    arr(s, (x, 4.2), (ax_, 3.15 if x < 11 else 2.55), c=TONES[tone][1], lw=0.8)
s.save("c04_anatomy")
