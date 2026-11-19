#include <iostream>

int main() {
    int a = 1, b = 2;
    std::cout << a / b << "\n";                    // int / int
    std::cout << 1.0 * a / b << "\n";              // double / int
    std::cout << static_cast<double>(a) / b << "\n";
    double d = 3.99;
    int i = d;                                     // truncation, no rounding
    std::cout << i << "\n";
    std::cout << static_cast<int>(-3.99) << "\n";
    char c = 'a';
    std::cout << c << " " << c + 1 << " " << static_cast<char>(c + 1) << "\n";
    return 0;
}
