#include <iostream>

class Shape {
public:
    double area() const { return 0; }             // NOT virtual
};

class Circle : public Shape {
public:
    Circle(double r) : r_(r) {}
    double area() const { return 3.14159 * r_ * r_; }   // hides the base version
private:
    double r_;
};

int main() {
    Circle c(2);
    Shape& s = c;                                  // allowed: a Circle is a Shape
    std::cout << "via Circle: " << c.area() << "\n";
    std::cout << "via Shape&: " << s.area() << "\n";    // the function is chosen by the DECLARED type
    return 0;
}
