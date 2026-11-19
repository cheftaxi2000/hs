from inf import *

# ---- pipeline: source -> compiler -> executable -> program run ----
s = Sketch(15.6, 5.2); s.ax.set_ylim(1.7, 6.9)
cell(s, 1.5, 3.6, 2.5, 1.3, "main.cpp", "blue", mono=True, bold=True)
lab(s, 1.5, 2.6, "source code", size=8.5, c="#444"); lab(s, 1.5, 2.15, "(what you write)", size=7.5, c="#777")
cell(s, 5.6, 3.6, 2.7, 1.5, "", "violet"); lab(s, 5.6, 4.15, "compiler", size=10, bold=True); lab(s, 5.6, 3.62, "g++", size=8.5, mono=True)
lab(s, 5.6, 2.6, "translates and checks", size=8.5, c="#444")
cell(s, 9.9, 3.6, 2.5, 1.3, "main", "green", mono=True, bold=True)
lab(s, 9.9, 2.6, "executable", size=8.5, c="#444"); lab(s, 9.9, 2.15, "(machine code)", size=7.5, c="#777")
cell(s, 14.0, 3.6, 2.4, 1.5, "", "amber"); lab(s, 14.0, 4.15, "computer", size=10, bold=True); lab(s, 14.0, 3.62, "runs it", size=8.5)
for a, b in [(2.8, 4.2), (6.95, 8.6), (11.2, 12.8)]: arr(s, (a, 3.6), (b, 3.6), lw=1.3)
# error tags (above the stages)
def tag(x, t1, t2, tone, col):
    rb(s, x, 6.25, 3.5, 1.15, tone); lab(s, x, 6.52, t1, size=9, bold=True, c=col); lab(s, x, 6.02, t2, size=7.5, c=col)
    arr(s, (x, 5.65), (x, 4.75), c=col, lw=0.9, ls=(0, (3, 2)))
tag(5.6, "syntax error", "compile-time: no program", "red", "#a3222e")
tag(9.9, "logic error", "runs, but wrong answer", "amber", "#9a520c")
tag(14.0, "runtime error", "crash during execution", "red", "#a3222e")
s.save("c01_pipeline")

# ---- anatomy of Hello World ----
s = Sketch(15.6, 6.3)
rb(s, 7.8, 4.45, 14.8, 3.2, "white", r=0.2, lw=0.8)
code = [("#include <iostream>", 0), ("", 0), ("int main() {", 0), ('    std::cout << "Hello, world!\\n";', 0), ("    return 0;", 0), ("}", 0)]
ys = [5.65, 5.15, 4.65, 4.15, 3.65, 3.15]
for (t, _), y in zip(code, ys):
    if t: lab(s, 0.9, y, t, size=8.6, mono=True, ha="left")
# coloured underlines / call-outs
def under(x0, x1, y, c): s.ax.plot([x0, x1], [y, y], color=c, lw=2, solid_capstyle="round", zorder=4, alpha=0.9)
cw = 0.1415 * 8.6 / 8.6 * 1.0   # char width in cm for 8.6pt DejaVu Mono ~0.0.. computed below
cw = 8.6 * 0.602 / 72 * 2.54   # DejaVu Sans Mono advance = 0.602 em
X0 = 0.9
def px(n): return X0 + n * cw
under(px(0), px(19), 5.45, "#3d7cc9")
under(px(0), px(3), 4.45, "#c4473a"); under(px(4), px(8), 4.45, "#c4473a")
under(px(4), px(13), 3.95, "#2f8a5f"); under(px(14), px(16), 3.95, "#7356a6"); under(px(17), px(32), 3.95, "#b56d12")
under(px(4), px(10), 3.45, "#c4473a")
under(px(32), px(33), 3.95, "#c4473a")
labs = [("1  include the library for input and output", px(19) + 0.25, 5.65, "#3d7cc9"),
        ("2  `main` is where every program starts", 8.4, 4.65, "#c4473a"),
        ("3  the statement  • prints text", 9.8, 4.15, "#2f8a5f"),
        ("4  ‘return 0’: everything went fine", 6.8, 3.65, "#c4473a")]
lab(s, px(19) + 0.3, 5.45, "include the library for input / output", size=8.3, ha="left", c="#2c64a8")
lab(s, px(12) + 0.3, 4.65, "← start of the program: every C++ program has exactly one main", size=8.3, ha="left", c="#a3222e")
lab(s, px(32) + 0.15, 3.78, "", size=8)
# boxes below with explanations
y0 = 1.55
items = [(1.9, "std::cout", "output stream", "green"), (4.65, "<<", "send to", "violet"), (7.4, "\"Hello, world!\\n\"", "string literal", "amber"), (10.9, "\\n", "new line", "grey"), (13.4, ";", "ends statement", "red")]
cell(s, 1.9, 1.5, 2.9, 1.5, "", "green"); lab(s, 1.9, 1.85, "std::cout", size=8.6, mono=True, bold=True); lab(s, 1.9, 1.15, "the console (output stream)", size=7.5)
cell(s, 5.35, 1.5, 2.9, 1.5, "", "violet"); lab(s, 5.35, 1.85, "<<", size=9.5, mono=True, bold=True); lab(s, 5.35, 1.15, "“send into” (output operator)", size=7.5)
cell(s, 8.95, 1.5, 3.3, 1.5, "", "amber"); lab(s, 8.95, 1.85, "\"Hello, world!\\n\"", size=8.2, mono=True, bold=True); lab(s, 8.95, 1.15, "text literal; \\n = new line", size=7.5)
cell(s, 12.75, 1.5, 3.1, 1.5, "", "red"); lab(s, 12.75, 1.85, ";", size=10, mono=True, bold=True); lab(s, 12.75, 1.15, "every statement ends here", size=7.5)
for x0, x1, c in [(px(4), px(13), "#2f8a5f"), (px(14), px(16), "#7356a6"), (px(17), px(32), "#b56d12")]:
    pass




s.save("c01_anatomy")
