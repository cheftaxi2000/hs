#include <iostream>

// pre: n >= 0
int factorial(int n) {
    if (n == 0) return 1;                  // base case
    return n * factorial(n - 1);           // recursive case: smaller problem
}

int main() {
    for (int n = 0; n <= 6; ++n)
        std::cout << n << "! = " << factorial(n) << "\n";
    return 0;
}
