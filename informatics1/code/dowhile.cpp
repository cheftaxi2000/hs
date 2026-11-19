#include <iostream>

int main() {
    int n;
    do {
        std::cout << "Enter a positive number: ";
        std::cin >> n;
    } while (n <= 0);
    std::cout << "Thank you, you entered " << n << ".\n";
    return 0;
}
