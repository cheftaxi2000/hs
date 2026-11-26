#include <iostream>

int main() {
    int a = 5;
    int b = 9;
    int* p = &a;        // p holds the address of a: "p points to a"
    *p = 7;             // go to where p points, write 7 there -> a is 7
    p = &b;             // now p holds the address of b
    *p = *p + 1;        // b = b + 1
    std::cout << "a = " << a << ", b = " << b << ", *p = " << *p << "\n";
}
