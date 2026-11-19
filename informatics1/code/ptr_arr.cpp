#include <iostream>

int main() {
    int a[5] = {10, 20, 30, 40, 50};     // an array: 5 ints next to each other
    int* p = a;                          // an array name converts to a pointer to its first element
    std::cout << *p << " " << *(p + 2) << " " << a[2] << "\n";   // p + 2: two ELEMENTS further

    int sum = 0;
    for (int* q = a; q != a + 5; ++q)    // iterate with a pointer; a + 5 is one past the end
        sum += *q;
    std::cout << "sum = " << sum << "\n";
    std::cout << "sizeof(a) = " << sizeof(a) << ", elements: " << sizeof(a) / sizeof(a[0]) << "\n";
    return 0;
}
