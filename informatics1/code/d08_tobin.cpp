#include <iostream>
#include <string>

// POST: returns the binary digits of n (n >= 0)
std::string to_binary(unsigned int n) {
    if (n == 0) return "0";
    std::string bits;
    while (n > 0) {
        bits = char('0' + n % 2) + bits;   // remainder = next bit, put it in front
        n = n / 2;
    }
    return bits;
}

int main() {
    for (unsigned int n : {5u, 13u, 45u, 100u, 255u})
        std::cout << n << " = " << to_binary(n) << "\n";
}
