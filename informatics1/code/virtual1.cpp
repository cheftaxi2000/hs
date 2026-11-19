#include <iostream>
#include <vector>

class Shape {
public:
    virtual ~Shape() {}                           // virtual destructor: see below
    virtual double area() const = 0;              // pure virtual: no implementation here
    virtual const char* name() const = 0;
};

class Circle : public Shape {
public:
    Circle(double r) : r_(r) {}
    double area() const override { return 3.14159265 * r_ * r_; }
    const char* name() const override { return "circle"; }
private:
    double r_;
};

class Rectangle : public Shape {
public:
    Rectangle(double w, double h) : w_(w), h_(h) {}
    double area() const override { return w_ * h_; }
    const char* name() const override { return "rectangle"; }
private:
    double w_, h_;
};

class Square : public Rectangle {
public:
    Square(double a) : Rectangle(a, a) {}
    const char* name() const override { return "square"; }    // area is inherited
};

void describe(const Shape& s) {                   // works for every kind of shape
    std::cout << s.name() << " with area " << s.area() << "\n";
}

int main() {
    Circle c(1);
    Rectangle r(2, 3);
    Square q(2);
    describe(c);
    describe(r);
    describe(q);

    std::vector<Shape*> shapes = {new Circle(2), new Rectangle(1, 5), new Square(3)};
    double total = 0;
    for (const Shape* s : shapes) total += s->area();      // the right area() is called for each
    std::cout << "total area: " << total << "\n";
    for (Shape* s : shapes) delete s;                      // virtual destructor makes this correct
    return 0;
}
