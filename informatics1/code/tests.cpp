#include <cassert>
#include <iostream>

int gcd(int a, int b) {
    while (b != 0) { int r = a % b; a = b; b = r; }
    return a;
}

int main() {
    assert(gcd(12, 18) == 6);     // typical case
    assert(gcd(7, 13) == 1);      // coprime
    assert(gcd(5, 0) == 5);       // edge case: zero
    assert(gcd(9, 9) == 9);       // edge case: equal arguments
    assert(gcd(18, 12) == 6);     // order must not matter
    std::cout << "all tests passed\n";
    return 0;
}
