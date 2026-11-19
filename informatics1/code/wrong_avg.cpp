#include <iostream>

int main() {
    int a = 10;
    int b = 20;
    std::cout << "average = " << a + b / 2 << "\n";   // oops: not (a + b) / 2
    return 0;
}
