#include <iostream>

long mults = 0;

// pre: n >= 0.  x^n with about log2(n) multiplications
double power(double x, int n) {
    if (n == 0) return 1;
    double h = power(x, n / 2);          // x^(n/2), computed ONCE
    mults++;
    if (n % 2 == 0) return h * h;        // x^n = (x^(n/2))^2
    mults++;
    return h * h * x;                    // odd n: one more factor x
}

int main() {
    std::cout << power(2, 10) << " (multiplications: ";
    mults = 0; power(2, 10); std::cout << mults << ")\n";
    mults = 0;
    std::cout << power(1.0001, 1000000) << " (multiplications: ";
    mults = 0; power(1.0001, 1000000); std::cout << mults << ")\n";
    return 0;
}
