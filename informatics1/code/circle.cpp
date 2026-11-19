#include <iostream>

int main() {
    std::cout << "radius r = ";
    double r;
    std::cin >> r;

    const double pi = 3.14159265;
    std::cout << "circumference = " << 2 * pi * r << "\n";
    std::cout << "area          = " << pi * r * r << "\n";
    return 0;
}
