#include <iostream>
#include <bitset>
#include <iomanip>

void show(const char* what, unsigned int x) {
    std::cout << what << " = " << std::setw(2) << x << "   " << std::bitset<6>(x) << "\n";
}

int main() {
    unsigned int a = 12, b = 10;       // 1100 and 1010
    show("a & b ", a & b);
    show("a | b ", a | b);
    show("a ^ b ", a ^ b);
    show("a << 2", a << 2);
    show("a >> 1", a >> 1);
}
