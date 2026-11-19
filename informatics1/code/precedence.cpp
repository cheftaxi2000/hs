#include <iostream>

int main() {
    std::cout << "1 + 2 * 3     = " << 1 + 2 * 3 << "\n";
    std::cout << "(1 + 2) * 3   = " << (1 + 2) * 3 << "\n";
    std::cout << "10 - 4 - 3    = " << 10 - 4 - 3 << "\n";     // left to right
    std::cout << "7 / 2         = " << 7 / 2 << "\n";          // integer division
    std::cout << "7 % 2         = " << 7 % 2 << "\n";
    std::cout << "-7 / 2        = " << -7 / 2 << "\n";         // rounds towards zero
    std::cout << "-7 % 2        = " << -7 % 2 << "\n";
    std::cout << "7 / 2.0       = " << 7 / 2.0 << "\n";        // floating-point division
    return 0;
}
