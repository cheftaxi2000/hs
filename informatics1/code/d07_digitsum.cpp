#include <iostream>

// POST: returns the sum of the decimal digits of n (n >= 0)
int digit_sum(int n) {
    if (n < 10) return n;               // base case: one digit
    return n % 10 + digit_sum(n / 10);  // last digit + the rest
}

int main() {
    std::cout << digit_sum(4) << " " << digit_sum(472) << " "
              << digit_sum(90031) << "\n";
}
