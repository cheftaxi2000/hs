#include <iostream>

int main() {
    int a = 252, b = 105;
    while (b != 0) {
        int r = a % b;       // Euclid: gcd(a, b) = gcd(b, a mod b)
        a = b;
        b = r;
        std::cout << "a = " << a << ", b = " << b << "\n";
    }
    std::cout << "gcd = " << a << "\n";
    return 0;
}
