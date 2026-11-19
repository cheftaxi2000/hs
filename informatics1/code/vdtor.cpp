#include <iostream>

class Base {
public:
    virtual ~Base() { std::cout << "~Base\n"; }
};

class Derived : public Base {
public:
    Derived() : data_(new int[100]) {}
    ~Derived() { std::cout << "~Derived (releases the array)\n"; delete[] data_; }
private:
    int* data_;
};

int main() {
    Base* p = new Derived;
    delete p;               // virtual destructor: ~Derived runs first, then ~Base
    return 0;
}
