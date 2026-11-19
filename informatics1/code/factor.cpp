#include <iostream>

// pre:  n >= 2
// post: returns the smallest divisor of n that is greater than 1
int smallest_factor(int n) {
    int d = 2;
    while (d * d <= n && n % d != 0) ++d;
    if (d * d > n) return n;       // no divisor up to sqrt(n): n itself is prime
    return d;
}

// pre:  n >= 1
// post: prints the prime factors of n in ascending order, e.g. "2 * 2 * 3"
void print_factors(int n) {
    bool first = true;
    while (n > 1) {
        int f = smallest_factor(n);
        if (!first) std::cout << " * ";
        std::cout << f;
        first = false;
        n /= f;
    }
    std::cout << "\n";
}

int main() {
    std::cout << "360 = "; print_factors(360);
    std::cout << "97  = "; print_factors(97);
    std::cout << "91  = "; print_factors(91);
    return 0;
}
