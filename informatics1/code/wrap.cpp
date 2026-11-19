#include <iostream>

int main() {
    unsigned int u = 0;
    u = u - 1;                         // below zero: wraps around
    std::cout << "0 - 1 as unsigned = " << u << "\n";
    unsigned int v = 4294967295u;      // largest unsigned int
    v = v + 1;
    std::cout << "max + 1 as unsigned = " << v << "\n";
    return 0;
}
