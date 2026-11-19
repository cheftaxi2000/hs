#include <bitset>
#include <iostream>

// prints the lowest 8 bits of n, highest bit first (loop version)
void print_bits(unsigned int n) {
    for (int i = 7; i >= 0; --i)
        std::cout << ((n >> i) & 1u);
    std::cout << "\n";
}

int main() {
    print_bits(5);
    print_bits(13);
    print_bits(200);
    std::cout << std::bitset<8>(77) << "\n";                  // the library does the same
    std::cout << std::hex << 255 << " " << 4096 << " " << std::dec << 0xFF << " " << 0x1A << "\n";
    return 0;
}
