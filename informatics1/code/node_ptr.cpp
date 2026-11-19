#include <iostream>

struct Point { double x, y; };

int main() {
    Point* p = new Point{1.5, 2.5};
    std::cout << (*p).x << " " << p->y << "\n";     // p->y is short for (*p).y
    p->x = 10;
    std::cout << p->x << "\n";
    delete p;
    return 0;
}
