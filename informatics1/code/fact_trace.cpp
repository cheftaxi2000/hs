#include <iostream>
#include <string>

int factorial(int n, int depth) {
    std::string pad(2 * depth, ' ');
    std::cout << pad << "factorial(" << n << ") called\n";
    int result = (n == 0) ? 1 : n * factorial(n - 1, depth + 1);
    std::cout << pad << "factorial(" << n << ") returns " << result << "\n";
    return result;
}

int main() {
    factorial(3, 0);
    return 0;
}
