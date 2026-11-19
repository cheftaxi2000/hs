from inf import *

def oval(s, x, y, t, w=1.7):
    cell(s, x, y, w, 0.7, t, "grey", size=8, mono=False, r=0.35)
def stmt(s, x, y, t, w=2.6, tone="blue"):
    cell(s, x, y, w, 0.85, t, tone, size=8, mono=True, r=0.18)
def cond(s, x, y, t, w=3.0, h=1.5):
    diamond(s, x, y, w, h, "amber"); lab(s, x, y, t, size=8, mono=True)
def yes(s, x, y): lab(s, x, y, "yes", size=7.5, c="#2a7f5a", bold=True)
def no(s, x, y): lab(s, x, y, "no", size=7.5, c="#a3222e", bold=True)

# ---- if / else ----
s = Sketch(12.6, 6.6)
oval(s, 6.3, 6.2, "start")
arr(s, (6.3, 5.85), (6.3, 5.45)); cond(s, 6.3, 4.7, "n % 2 == 0")
arr(s, (4.8, 4.7), (3.7, 4.7)); yes(s, 4.25, 4.95); stmt(s, 2.2, 4.7, 'cout << "even"', w=3.0, tone="green")
arr(s, (7.8, 4.7), (8.9, 4.7)); no(s, 8.35, 4.95); stmt(s, 10.4, 4.7, 'cout << "odd"', w=3.0, tone="red")
link(s, (2.2, 4.27), (2.2, 3.0), c="#4a5560", lw=1.0); link(s, (10.4, 4.27), (10.4, 3.0), c="#4a5560", lw=1.0)
link(s, (2.2, 3.0), (10.4, 3.0), c="#4a5560", lw=1.0); arr(s, (6.3, 3.0), (6.3, 2.35))
stmt(s, 6.3, 1.9, "next statement", w=3.4, tone="grey")
s.save("c03_if")

# ---- while ----
s = Sketch(11.6, 6.8)
oval(s, 3.4, 6.4, "start"); arr(s, (3.4, 6.05), (3.4, 5.65))
cond(s, 3.4, 4.85, "condition", w=3.2)
arr(s, (3.4, 4.1), (3.4, 3.45)); yes(s, 3.75, 3.85)
stmt(s, 3.4, 3.0, "body", w=2.6)
poly(s, [(3.4, 2.57), (3.4, 1.9), (0.5, 1.9), (0.5, 4.85)], c="#4a5560", lw=1.0); arr(s, (0.5, 4.85), (1.8, 4.85))
poly(s, [(5.0, 4.85), (6.9, 4.85)], c="#4a5560", lw=1.0); arr(s, (6.9, 4.85), (8.4, 4.85)); no(s, 5.9, 5.07)
stmt(s, 9.9, 4.85, "after the loop", w=3.0, tone="grey")
lab(s, 6.1, 2.2, "the condition is checked\nBEFORE every pass", size=8.3, c="#555", ha="left")
s.save("c03_while")

# ---- for: anatomy with execution order ----
s = Sketch(15.4, 5.6)
rb(s, 7.7, 4.7, 14.4, 1.3, "white", r=0.2)
x0 = 0.9; cw = 9.2 * 0.602 / 72 * 2.54
lab(s, x0, 4.7, "for (int i = 1; i <= n; ++i) {  sum += i;  }", size=9.2, mono=True, ha="left")
def span(a, b, y, col): s.ax.plot([x0 + a * cw, x0 + b * cw], [y, y], color=col, lw=2.2, solid_capstyle="round", zorder=4)
span(5, 14, 4.2, "#3d7cc9"); span(16, 22, 4.2, "#c7741a"); span(24, 29, 4.2, "#7356a6"); span(33, 42, 4.2, "#2f8a5f")
def box_(x, y, n, t1, t2, tone, w=3.6):
    rb(s, x, y, w, 1.55, tone); lab(s, x - w / 2 + 0.35, y + 0.4, n, size=10, bold=True, c="#222"); lab(s, x + 0.2, y + 0.38, t1, size=8.6, mono=True, bold=True)
    lab(s, x, y - 0.25, t2, size=7.8, c="#333", linespacing=1.15)
box_(2.0, 2.2, "1", "int i = 1", "initialisation:\nonce, before the first pass", "blue")
box_(5.9, 2.2, "2", "i <= n", "condition: checked before\nevery pass; false = leave loop", "amber", w=3.8)
box_(9.9, 2.2, "4", "++i", "update: after every pass,\nthen back to 2", "violet", w=3.6)
box_(13.7, 2.2, "3", "sum += i", "body", "green", w=2.4)
for x, c in [(x0 + 9.5 * cw, "#3d7cc9"), (x0 + 19 * cw, "#c7741a"), (x0 + 26.5 * cw, "#7356a6"), (x0 + 37.5 * cw, "#2f8a5f")]: pass
arr(s, (x0 + 9.5 * cw, 4.1), (2.0, 3.0), c="#3d7cc9", lw=0.8)
arr(s, (x0 + 19 * cw, 4.1), (5.9, 3.0), c="#c7741a", lw=0.8)
arr(s, (x0 + 26.5 * cw, 4.1), (9.9, 3.0), c="#7356a6", lw=0.8)
arr(s, (x0 + 37.5 * cw, 4.1), (13.7, 3.0), c="#2f8a5f", lw=0.8)
lab(s, 7.7, 0.35, "order: 1 once, then repeat  2 → 3 → 4  while the condition is true", size=8.5, c="#555")
s.save("c03_for")
