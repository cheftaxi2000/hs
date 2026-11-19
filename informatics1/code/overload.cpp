#include <iostream>

int    square(int x)    { std::cout << "[int version] ";    return x * x; }
double square(double x) { std::cout << "[double version] "; return x * x; }

// default argument: if the caller gives only one argument, exponent is 2
double power(double base, int exponent = 2) {
    double result = 1;
    for (int i = 0; i < exponent; ++i) result *= base;
    return result;
}

int main() {
    std::cout << square(3) << "\n";
    std::cout << square(1.5) << "\n";
    std::cout << power(3) << "\n";
    std::cout << power(2, 10) << "\n";
    return 0;
}
