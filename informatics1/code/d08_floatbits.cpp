#include <iostream>
#include <bitset>
#include <cstring>
#include <iomanip>

void show(float f) {
    unsigned int u;
    std::memcpy(&u, &f, 4);                  // the same 32 bits, as an integer
    std::string b = std::bitset<32>(u).to_string();
    std::cout << std::setw(6) << f << " = " << b.substr(0, 1) << " "
              << b.substr(1, 8) << " " << b.substr(9) << "\n";
}

int main() {
    show(-6.25f);
    show(0.75f);
    show(1.0f);
    std::cout << std::setprecision(20) << "0.1f is really " << 0.1f << "\n";
}
