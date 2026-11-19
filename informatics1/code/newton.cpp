#include <cmath>
#include <iomanip>
#include <iostream>

// pre:  x >= 0
// post: returns an approximation of sqrt(x) (relative error below 1e-12)
double my_sqrt(double x) {
    if (x == 0) return 0;
    double y = x > 1 ? x : 1;                       // starting guess
    while (std::fabs(y * y - x) > 1e-12 * x) {
        y = (y + x / y) / 2;                        // Newton step
    }
    return y;
}

int main() {
    std::cout << std::setprecision(12);
    std::cout << "my_sqrt(2)   = " << my_sqrt(2) << "\n";
    std::cout << "std::sqrt(2) = " << std::sqrt(2.0) << "\n";
    std::cout << "my_sqrt(1e6) = " << my_sqrt(1e6) << "\n";
    return 0;
}
