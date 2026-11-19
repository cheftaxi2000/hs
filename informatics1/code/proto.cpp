#include <iostream>

bool is_prime(int n);          // declaration (prototype): tells the compiler what exists

int main() {
    for (int n = 10; n <= 30; ++n) {
        if (is_prime(n)) std::cout << n << " ";
    }
    std::cout << "\n";
    return 0;
}

bool is_prime(int n) {         // definition: the actual code
    if (n < 2) return false;
    for (int d = 2; d * d <= n; ++d) {
        if (n % d == 0) return false;     // return leaves the function immediately
    }
    return true;
}
