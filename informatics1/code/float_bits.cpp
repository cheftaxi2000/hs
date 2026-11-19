#include <bitset>
#include <cstdint>
#include <cstring>
#include <iostream>

void show(float f) {
    std::uint32_t u;
    std::memcpy(&u, &f, 4);                       // look at the raw bits of the float
    std::bitset<32> b(u);
    std::string s = b.to_string();
    std::cout << f << "\n   " << s.substr(0, 1) << " " << s.substr(1, 8) << " " << s.substr(9)
              << "   exponent field = " << ((u >> 23) & 0xFF) << "\n";
}

int main() {
    show(1.0f);
    show(-6.25f);
    show(0.1f);
    show(0.5f);
    return 0;
}
