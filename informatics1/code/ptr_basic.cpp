#include <iostream>

int main() {
    int a = 5;
    int* p = &a;                 // p stores the ADDRESS of a: "p points to a"
    std::cout << "*p = " << *p << "\n";       // dereference: the value at that address
    *p = 42;                     // writes through the pointer: changes a!
    std::cout << "a  = " << a << "\n";
    std::cout << "p == &a: " << (p == &a) << "\n";

    int b = 7;
    p = &b;                      // a pointer can be re-targeted (a reference cannot)
    *p += 1;
    std::cout << "a = " << a << ", b = " << b << "\n";

    int* q = nullptr;            // points to nothing
    std::cout << "q is null: " << (q == nullptr) << "\n";
    return 0;
}
