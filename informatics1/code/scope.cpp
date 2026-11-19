#include <iostream>

int main() {
    int x = 1;
    {
        int y = 2;          // y exists only inside these braces
        int x = 10;         // a NEW x that hides the outer one
        std::cout << "inner: x = " << x << ", y = " << y << "\n";
    }
    std::cout << "outer: x = " << x << "\n";
    // std::cout << y;      // error: y does not exist here
    return 0;
}
