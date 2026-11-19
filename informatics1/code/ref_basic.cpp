#include <iostream>

int main() {
    int a = 5;
    int& r = a;          // r is another name (an alias) for a
    int c = a;           // c is a COPY of a

    r = 7;               // changes a!
    c = 100;             // changes only the copy
    std::cout << "a = " << a << ", r = " << r << ", c = " << c << "\n";
    std::cout << "same place? " << (&a == &r) << ", " << (&a == &c) << "\n";
    return 0;
}
