#include <iostream>

int main() {
    int x = 1, y = 2;
    int* p = &x;
    int* q = &y;
    *p = *q;          // copy the VALUE: x = 2
    *q = 3;           // y = 3
    q = p;            // copy the ADDRESS: q now points to x as well
    *q = *q + 10;     // x = 12
    std::cout << x << " " << y << " " << *p << " " << *q << "\n";
}
