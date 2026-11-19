#include <cassert>
#include <iostream>

// pre:  b != 0
// post: returns a / b rounded towards zero
int divide(int a, int b) {
    assert(b != 0);          // the precondition is checked while running
    return a / b;
}

int main() {
    std::cout << divide(7, 2) << "\n";
    std::cout << divide(1, 0) << "\n";    // violates the precondition
    return 0;
}
