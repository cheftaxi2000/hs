#include <iostream>

struct Engine {
    Engine()  { std::cout << "Engine "; }
    ~Engine() { std::cout << "~Engine "; }
};
struct Vehicle {
    Vehicle()          { std::cout << "Vehicle "; }
    virtual ~Vehicle() { std::cout << "~Vehicle "; }
};
struct Car : public Vehicle {
    Engine e;                                   // a member
    Car()  { std::cout << "Car "; }
    ~Car() { std::cout << "~Car "; }
};

int main() {
    Vehicle* v = new Car;
    std::cout << "| ";
    delete v;
    std::cout << "\n";
}
