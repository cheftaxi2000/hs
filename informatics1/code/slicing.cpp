#include <iostream>

class Shape {
public:
    virtual double area() const { return 0; }
    virtual ~Shape() {}
};

class Rectangle : public Shape {
public:
    Rectangle(double w, double h) : w_(w), h_(h) {}
    double area() const override { return w_ * h_; }
private:
    double w_, h_;
};

void by_value(Shape s)      { std::cout << "by value:     " << s.area() << "\n"; }   // slicing!
void by_reference(Shape& s) { std::cout << "by reference: " << s.area() << "\n"; }

int main() {
    Rectangle r(2, 3);
    by_reference(r);
    by_value(r);            // only the Shape part of r is copied: w_ and h_ are lost
    return 0;
}
