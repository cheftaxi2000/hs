#include <iostream>

int main() {
    int a[5] = {10, 20, 30, 40, 50};
    int* p = a;            // the array name is the address of a[0]
    std::cout << *p << " ";          // 10
    p = p + 2;             // move two ELEMENTS forward
    std::cout << *p << " ";          // 30
    std::cout << p[1] << " ";        // the element after *p: 40
    std::cout << *(a + 4) << " ";    // same as a[4]: 50
    std::cout << (p - a) << "\n";    // distance in elements: 2
}
