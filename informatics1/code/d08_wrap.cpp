#include <iostream>

int main() {
    unsigned char u = 250;                 // 8 bits: 0 ... 255
    for (int k = 0; k < 8; ++k) {
        std::cout << int(u) << " ";
        ++u;                               // after 255 comes 0
    }
    std::cout << "\n";
    signed char s = 125;                   // 8 bits: -128 ... 127
    for (int k = 0; k < 6; ++k) {
        std::cout << int(s) << " ";
        s = s + 1;                         // after 127 comes -128
    }
    std::cout << "\n";
}
