#include <iostream>
#include <limits>

int main() {
    std::cout << "sizeof(char)   = " << sizeof(char) << "\n";
    std::cout << "sizeof(bool)   = " << sizeof(bool) << "\n";
    std::cout << "sizeof(int)    = " << sizeof(int) << "\n";
    std::cout << "sizeof(long)   = " << sizeof(long) << "\n";
    std::cout << "sizeof(double) = " << sizeof(double) << "\n";
    std::cout << "int min = " << std::numeric_limits<int>::min() << "\n";
    std::cout << "int max = " << std::numeric_limits<int>::max() << "\n";
    std::cout << "unsigned max = " << std::numeric_limits<unsigned int>::max() << "\n";
    return 0;
}
