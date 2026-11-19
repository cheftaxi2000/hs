#include <bitset>
#include <iostream>

int main() {
    unsigned char a = 0b11001010;      // binary literal
    unsigned char b = 0b10100110;
    std::cout << "a        = " << std::bitset<8>(a) << "\n";
    std::cout << "b        = " << std::bitset<8>(b) << "\n";
    std::cout << "a & b    = " << std::bitset<8>(a & b) << "   (and)\n";
    std::cout << "a | b    = " << std::bitset<8>(a | b) << "   (or)\n";
    std::cout << "a ^ b    = " << std::bitset<8>(a ^ b) << "   (xor)\n";
    std::cout << "~a       = " << std::bitset<8>(static_cast<unsigned char>(~a)) << "   (not)\n";
    std::cout << "a << 2   = " << std::bitset<8>(static_cast<unsigned char>(a << 2)) << "   (shift left)\n";
    std::cout << "a >> 2   = " << std::bitset<8>(a >> 2) << "   (shift right)\n";

    int x = 13;
    std::cout << x << " * 8 = " << (x << 3) << ",  " << x << " / 4 = " << (x >> 2) << "\n";
    int k = 2;
    std::cout << "bit " << k << " of " << x << " is " << ((x >> k) & 1) << "\n";
    return 0;
}
