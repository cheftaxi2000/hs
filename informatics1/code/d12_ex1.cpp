#include <iostream>

struct T {
    T()                    { std::cout << "ctor ";   }
    T(const T&)            { std::cout << "copy ";   }
    T& operator=(const T&) { std::cout << "assign "; return *this; }
    ~T()                   { std::cout << "dtor ";   }
};

void by_value(T x) {}
void by_ref(const T& x) {}

int main() {
    T a;                 // 1
    T b = a;             // 2
    b = a;               // 3
    by_value(a);         // 4
    by_ref(a);           // 5
    std::cout << "| ";
}                        // 6: b and a are destroyed
