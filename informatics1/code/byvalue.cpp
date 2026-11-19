#include <iostream>

void increment(int x) {
    x = x + 1;                                  // changes only the local copy
    std::cout << "in increment: x = " << x << "\n";
}

int main() {
    int a = 5;
    increment(a);
    std::cout << "in main:      a = " << a << "\n";
    return 0;
}
