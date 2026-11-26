#include <iostream>

int f(int n) {
    if (n <= 1) return 1;
    return f(n - 1) + 2 * f(n - 2);
}

int main() {
    std::cout << f(4) << "\n";
}
