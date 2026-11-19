#include <iostream>

int main() {
    int n = 10;
    double wrong = 0, right = 0;
    for (int k = 1; k <= n; ++k) {
        wrong += 1 / k;        // integer division: 1/1 = 1, 1/2 = 0, 1/3 = 0, ...
        right += 1.0 / k;
    }
    std::cout << "wrong: " << wrong << "\n";
    std::cout << "right: " << right << "\n";
    return 0;
}
