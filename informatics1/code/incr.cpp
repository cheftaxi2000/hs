#include <iostream>

int main() {
    int a = 5;
    int b = a++;     // b gets the OLD value, then a is incremented
    std::cout << "a = " << a << ", b = " << b << "\n";
    int c = ++a;     // a is incremented first, c gets the NEW value
    std::cout << "a = " << a << ", c = " << c << "\n";
    a += 10;         // same as a = a + 10
    a *= 2;          // same as a = a * 2
    std::cout << "a = " << a << "\n";
    return 0;
}
