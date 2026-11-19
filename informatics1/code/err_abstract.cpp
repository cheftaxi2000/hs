class Shape {
public:
    virtual double area() const = 0;
};

int main() {
    Shape s;               // an abstract class cannot be instantiated
    return 0;
}
