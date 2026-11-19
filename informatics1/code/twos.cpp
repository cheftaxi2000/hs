#include <bitset>
#include <iostream>

int main() {
    // the same 8 bits, read as signed and as unsigned
    for (int v : {0, 1, 127, -1, -2, -128}) {
        signed char s = v;
        unsigned char u = s;
        std::cout << std::bitset<8>(u) << "  signed: " << static_cast<int>(s)
                  << "  unsigned: " << static_cast<int>(u) << "\n";
    }
    signed char big = 127;
    big = big + 1;                                   // 128 does not fit into 8 signed bits
    std::cout << "127 + 1 in 8 bits: " << static_cast<int>(big) << "\n";
    std::cout << "40000 in 16 bits: " << static_cast<short>(40000) << "\n";
    return 0;
}
