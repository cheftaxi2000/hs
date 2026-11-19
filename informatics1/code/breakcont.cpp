#include <iostream>

int main() {
    int n = 91;
    int d = 2;
    while (d < n) {
        if (n % d == 0) break;      // found a divisor: leave the loop at once
        ++d;
    }
    std::cout << "smallest divisor of " << n << " greater than 1: " << d << "\n";

    for (int i = 1; i <= 10; ++i) {
        if (i % 3 == 0) continue;   // skip the rest of this pass
        std::cout << i << " ";
    }
    std::cout << "\n";
    return 0;
}
