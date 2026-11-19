from inf import *

# ---- expression tree  2 * x + 1 > y  with x = 4, y = 7 ----
s = Sketch(11.0, 6.0)
def node(x, y, t, tone="teal", w=1.0):
    cell(s, x, y, w, 0.8, t, tone, size=10, bold=True, r=0.4)
def edge(p, q): link(s, p, q, c="#9aa5b1", lw=1.2)
def val(x, y, t, c="#2a7f5a"): lab(s, x, y, t, size=8.5, c=c, mono=True, bold=True)
edge((5.5, 5.0), (3.0, 3.75)); edge((5.5, 5.0), (8.6, 3.75))
edge((3.0, 3.35), (1.6, 2.35)); edge((3.0, 3.35), (4.5, 2.35))
edge((1.6, 1.95), (0.9, 0.95)); edge((1.6, 1.95), (2.3, 0.95))
node(5.5, 5.4, ">", "amber"); node(3.0, 3.55, "+"); node(8.6, 3.55, "y", "blue"); node(1.6, 2.15, "*"); node(4.5, 2.15, "1", "grey")
node(0.9, 0.55, "2", "grey"); node(2.3, 0.55, "x", "blue")
val(6.5, 5.4, "true", "#a3222e"); val(3.75, 3.55, "9"); val(9.45, 3.55, "7"); val(2.45, 2.15, "8"); val(3.15, 0.55, "4");
lab(s, 10.9, 5.4, "3  compare", size=8, ha="right", c="#444"); lab(s, 10.9, 4.9, "2  add", size=8, ha="right", c="#444"); lab(s, 10.9, 4.4, "1  multiply", size=8, ha="right", c="#444")
s.save("c02_tree")

# ---- types in memory: byte cells ----
s = Sketch(15.0, 6.2)
rows = [("bool", 1, "true / false", "amber"), ("char", 1, "'a', '+', '7'", "violet"), ("int", 4, "whole numbers, about $\\pm 2\\cdot 10^{9}$", "blue"), ("long", 8, "whole numbers, about $\\pm 9\\cdot 10^{18}$", "teal"), ("double", 8, "decimals, ~15 digits", "green")]
cw = 0.62
for k, (n, b, d, tone) in enumerate(rows):
    y = 5.4 - k * 1.1
    lab(s, 1.5, y, n, size=9.5, mono=True, bold=True, ha="right")
    for i in range(b): rb(s, 1.9 + i * cw + cw / 2, y, cw - 0.06, 0.7, tone, r=0.12)
    lab(s, 1.9 + b * cw + 0.2, y, f"{b} byte{'s' if b > 1 else ''}: {d}", size=8.5, ha="left", c="#333")
lab(s, 1.9, 0.2, "one cell = 1 byte = 8 bits", size=8, ha="left", c="#777")
s.save("c02_types")
