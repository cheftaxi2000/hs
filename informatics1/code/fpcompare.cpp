#include <cmath>
#include <iomanip>
#include <iostream>

int main() {
    double a = 0.1 + 0.2;
    std::cout << std::boolalpha << std::setprecision(17);
    std::cout << "0.1 + 0.2     = " << a << "\n";
    std::cout << "a == 0.3      : " << (a == 0.3) << "\n";
    std::cout << "|a - 0.3|     = " << std::fabs(a - 0.3) << "\n";
    const double eps = 1e-9;
    std::cout << "|a - 0.3| < eps: " << (std::fabs(a - 0.3) < eps) << "\n";

    double s = 0;
    for (int i = 0; i < 10; ++i) s += 0.1;        // ten times 0.1
    std::cout << "sum of ten 0.1 = " << s << ", == 1.0 ? " << (s == 1.0) << "\n";
    return 0;
}
