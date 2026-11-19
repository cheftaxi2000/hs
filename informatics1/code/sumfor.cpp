#include <iostream>

int main() {
    std::cout << "n = ";
    int n;
    std::cin >> n;

    int sum = 0;
    for (int i = 1; i <= n; ++i) {
        sum += i;
    }
    std::cout << "1 + 2 + ... + " << n << " = " << sum << "\n";
    return 0;
}
