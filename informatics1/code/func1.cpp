#include <iostream>

// returns x squared
int square(int x) {
    return x * x;
}

// returns the larger of two numbers
int max(int a, int b) {
    if (a > b) return a;
    return b;
}

// prints a line, returns nothing
void greet(int times) {
    for (int i = 0; i < times; ++i) {
        std::cout << "Hello! ";
    }
    std::cout << "\n";
}

int main() {
    std::cout << square(7) << "\n";
    std::cout << max(square(3), 2 * 4) << "\n";    // calls can be nested
    greet(3);
    return 0;
}
