#include <iostream>

int main() {
    for (int i = 1; i <= 4; ++i) {          // row
        for (int j = 1; j <= i; ++j) {      // column: as many stars as the row number
            std::cout << "* ";
        }
        std::cout << "\n";
    }
    std::cout << "\n";
    for (int i = 1; i <= 3; ++i) {
        for (int j = 1; j <= 5; ++j) {
            std::cout << i * j << "\t";
        }
        std::cout << "\n";
    }
    return 0;
}
