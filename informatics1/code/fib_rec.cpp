#include <iostream>

long calls = 0;                         // counts the calls (a global variable, just for the demo)

int fib(int n) {
    ++calls;
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 2);
}

int main() {
    for (int n : {10, 20, 30}) {
        calls = 0;
        int f = fib(n);
        std::cout << "fib(" << n << ") = " << f << " needed " << calls << " calls\n";
    }
    return 0;
}
