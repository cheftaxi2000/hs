#include <iostream>

void g(int n) {
    if (n == 0) return;
    std::cout << n << " ";
    g(n - 1);
    std::cout << n << " ";
}

int main() {
    g(3);
    std::cout << "\n";
}
