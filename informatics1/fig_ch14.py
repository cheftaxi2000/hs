from inf import *

# ---- class hierarchy ----
s = Sketch(14.6, 7.6)
def klass(x, ytop, name, members, tone, w):
    h = 0.75 + 0.42 * len(members)
    rb(s, x, ytop - h / 2, w, h, tone, r=0.18)
    lab(s, x, ytop - 0.38, name, size=9, bold=True, mono=True, c="#222")
    for i, m in enumerate(members): lab(s, x, ytop - 0.82 - i * 0.42, m, size=7.4, mono=True, c="#444")
    return ytop - h
def tri(x, y):   # hollow inheritance triangle with its tip at (x, y)
    s.ax.add_patch(Polygon([(x - 0.25, y - 0.42), (x + 0.25, y - 0.42), (x, y)], closed=True, fc="white", ec="#555", lw=1.1, zorder=5))
yb = klass(7.3, 7.0, "Shape", ["virtual double area() = 0", "virtual const char* name() = 0"], "amber", 5.6)
tri(7.3, yb); link(s, (7.3, yb - 0.42), (7.3, 4.2), c="#555", lw=1.1)
link(s, (3.0, 4.2), (10.8, 4.2), c="#555", lw=1.1)
for x in (3.0, 10.8): link(s, (x, 4.2), (x, 3.55), c="#555", lw=1.1)
klass(3.0, 3.55, "Circle", ["double r_", "area() override"], "blue", 4.2)
yr = klass(10.8, 3.55, "Rectangle", ["double w_, h_", "area() override"], "blue", 4.6)
tri(10.8, yr); link(s, (10.8, yr - 0.42), (10.8, 0.9), c="#555", lw=1.1)
klass(10.8, 0.9, "Square", ["(inherits area)"], "green", 3.4)
lab(s, 0.2, 7.4, "arrow = \"is a\":  Circle is a Shape;  Square is a Rectangle is a Shape", size=8.2, ha="left", c="#555")
s.ax.set_ylim(-0.5, 7.7)
s.save("c14_hierarchy")

# ---- vtable ----
s = Sketch(14.6, 5.8)
lab(s, 0.2, 5.5, "Shape* p = new Circle(2);   p->area();", size=8.8, mono=True, ha="left")
cell(s, 1.9, 3.4, 3.0, 1.0, "p", "amber", size=10, bold=True, r=0.2); 
rb(s, 6.3, 3.0, 3.0, 2.4, "blue", r=0.2); lab(s, 6.3, 4.0, "Circle object", size=8.3, bold=True)
cell(s, 6.3, 3.35, 2.4, 0.6, "vptr", "violet", size=8.5, r=0.15); cell(s, 6.3, 2.5, 2.4, 0.6, "r_ = 2", "white", size=8.5, r=0.15)
arr(s, (3.4, 3.4), (4.8, 3.4), c="#555", lw=1.2)
rb(s, 11.3, 3.4, 4.8, 2.4, "violet", r=0.2); lab(s, 11.3, 4.35, "vtable of Circle", size=8.3, bold=True)
cell(s, 11.3, 3.6, 4.2, 0.55, "area  →  Circle::area", "white", size=8, r=0.12); cell(s, 11.3, 2.85, 4.2, 0.55, "name  →  Circle::name", "white", size=8, r=0.12)
arr(s, (7.5, 3.35), (8.9, 3.45), c="#7356a6", lw=1.2)
lab(s, 7.3, 0.9, "At run time: follow p to the object, its vptr to the table of its OWN class,\nand call the entry for area. The same code works for every derived class.", size=8.5, c="#444")
s.save("c14_vtable")

# ---- slicing ----
s = Sketch(14.0, 4.2)
lab(s, 0.2, 3.9, "Rectangle r(2, 3);    void by_value(Shape s);    by_value(r);", size=8.4, mono=True, ha="left")
rb(s, 3.0, 1.9, 4.6, 1.5, "blue", r=0.2); lab(s, 3.0, 2.95, "Rectangle r", size=8.5, bold=True)
cell(s, 1.9, 1.8, 1.9, 0.8, "Shape part", "amber", size=7.8, mono=False, r=0.15); cell(s, 4.2, 1.8, 1.9, 0.8, "w_=2, h_=3", "blue", size=7.8, r=0.15)
arr(s, (5.5, 1.9), (8.0, 1.9), c="#a3222e", lw=1.4); lab(s, 6.75, 2.3, "copy", size=8, c="#a3222e")
rb(s, 10.0, 1.9, 3.0, 1.5, "amber", r=0.2); lab(s, 10.0, 2.95, "Shape s (copy)", size=8.5, bold=True)
cell(s, 10.0, 1.8, 1.9, 0.8, "Shape part", "amber", size=7.8, mono=False, r=0.15)
lab(s, 11.9, 0.65, "the Rectangle part is cut off: \"sliced\"", size=8.3, c="#a3222e", ha="right")
s.save("c14_slicing")
