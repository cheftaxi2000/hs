#include <iostream>

int main() {
    char c = 'A';
    std::cout << c << " has the code " << static_cast<int>(c) << "\n";
    std::cout << "next letter: " << static_cast<char>(c + 1) << "\n";
    std::cout << "digit '7' minus '0' = " << '7' - '0' << "\n";   // digit character -> number

    char x = 'q';
    if (x >= 'a' && x <= 'z') {                // is x a lower-case letter?
        char upper = x - 'a' + 'A';            // convert to upper case
        std::cout << x << " -> " << upper << "\n";
    }
    for (char k = 'a'; k <= 'e'; ++k) std::cout << k;   // characters can be counted
    std::cout << "\n";
    return 0;
}
