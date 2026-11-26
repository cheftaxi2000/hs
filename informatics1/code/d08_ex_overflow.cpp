#include <iostream>

int main() {
    unsigned char a = 200, b = 100;
    unsigned char c = a + b;          // 300 does not fit into 8 bits
    int d = a + b;                    // computed as int: fits
    unsigned int e = 3 - 5;           // negative result, unsigned type
    std::cout << int(c) << " " << d << " " << e << "\n";
}
