#include <iostream>

struct P { int x; int y; };

void f(P a, P& b) {
    a.x = 100;
    b.y = a.x + b.x;
}

int main() {
    P p{1, 2};
    P q = p;           // a copy of all members
    q.x = 5;
    f(p, q);
    std::cout << p.x << " " << p.y << " | " << q.x << " " << q.y << "\n";
}
