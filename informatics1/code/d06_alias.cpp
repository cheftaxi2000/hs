#include <iostream>

int main() {
    int a = 5;
    int& r = a;     // r is another name for a
    int c = a;      // c is a new variable with a copy of the value

    r = 8;          // changes a (there is only one box)
    c = 100;        // changes only c
    std::cout << "a = " << a << ", r = " << r << ", c = " << c << "\n";

    a = a + 1;      // r sees it too
    std::cout << "a = " << a << ", r = " << r << ", c = " << c << "\n";
}
