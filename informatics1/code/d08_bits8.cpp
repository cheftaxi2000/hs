#include <iostream>
#include <bitset>
#include <iomanip>

int main() {
    for (int v : {5, -5, 45, -45, 127, -128, -1}) {
        signed char c = v;
        std::cout << std::setw(5) << v << "   " << std::bitset<8>(c) << "\n";
    }
}
