#include <iostream>

int main() {
    int a = 0, b = 1;                    // two consecutive Fibonacci numbers
    for (int i = 0; i < 10; ++i) {
        std::cout << a << " ";
        int next = a + b;
        a = b;
        b = next;
    }
    std::cout << "\n";
    return 0;
}
