#include <iostream>

int main() {
    std::cout << std::boolalpha;           // print true/false instead of 1/0
    int x = 0;
    std::cout << (x != 0 && 10 / x > 1) << "\n";   // right side is NOT evaluated
    std::cout << (x == 0 || 10 / x > 1) << "\n";   // right side is NOT evaluated
    int year = 2100;
    bool leap = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
    std::cout << year << " is a leap year: " << leap << "\n";
    std::cout << (1 < 2 < 3) << " " << (3 > 2 > 1) << "\n";   // surprise!
    return 0;
}
