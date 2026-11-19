#include <iostream>

// post: the values of a and b are exchanged
void swap(int& a, int& b) {
    int t = a;
    a = b;
    b = t;
}

int main() {
    int x = 3, y = 8;
    swap(x, y);
    std::cout << "x = " << x << ", y = " << y << "\n";
    return 0;
}
