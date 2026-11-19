#include <iostream>

int main() {
    std::cout << "Compute a^8. a = ";
    int a;
    std::cin >> a;

    int b = a * a;      // b = a^2
    b = b * b;          // b = a^4
    std::cout << a << "^8 = " << b * b << "\n";   // (a^4)^2 = a^8
    return 0;
}
