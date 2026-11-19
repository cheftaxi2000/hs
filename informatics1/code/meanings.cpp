#include <iostream>

int main() {
    int a = 6, b = 3;
    int& r = a;               // & after a type:   reference
    int* p = &b;              // * after a type:   pointer;   & before a variable: address-of
    std::cout << *p << "\n";  // * before a pointer: dereference
    std::cout << a * b << "\n";   // * between two numbers: multiplication
    std::cout << (a & b) << "\n"; // & between two numbers: bit-wise AND
    std::cout << (a && b) << "\n";// && : logical AND
    r = 1;
    std::cout << a << "\n";
    return 0;
}
