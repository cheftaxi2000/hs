#include <iostream>

int main() {
    char c = 'd';
    std::cout << "code of 'd':        " << int(c) << "\n";
    std::cout << "position in abc:    " << c - 'a' << "\n";
    std::cout << "upper case:         " << char(c - 'a' + 'A') << "\n";
    char d = '7';
    std::cout << "digit '7' as int:   " << d - '0' << "\n";        // 7
    std::cout << "'7' + 1 as int:     " << d + 1 << "\n";          // 56, not 8!
}
