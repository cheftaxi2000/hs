#include <cmath>
#include <iomanip>
#include <iostream>
#include <limits>

int main() {
    std::cout << std::setprecision(17);
    std::cout << "double epsilon : " << std::numeric_limits<double>::epsilon() << "\n";
    std::cout << "double max     : " << std::numeric_limits<double>::max() << "\n";
    std::cout << "double min     : " << std::numeric_limits<double>::min() << "\n";
    std::cout << "float  epsilon : " << std::numeric_limits<float>::epsilon() << "\n";

    double big = 1e308;
    std::cout << "1e308 * 10     : " << big * 10 << "\n";           // overflow -> infinity
    std::cout << "-1.0 / 0       : " << -1.0 / 0 << "\n";
    std::cout << "0.0 / 0        : " << 0.0 / 0 << "\n";            // not a number
    std::cout << "sqrt(-1)       : " << std::sqrt(-1.0) << "\n";

    std::cout << "1 + 1e-16 == 1 : " << (1 + 1e-16 == 1) << "\n";   // too small to be noticed
    std::cout << "1e16 + 1 == 1e16 : " << (1e16 + 1 == 1e16) << "\n";
    float f = 16777216.0f;                                          // 2^24
    std::cout << "float 2^24 + 1 == 2^24 : " << (f + 1 == f) << "\n";
    std::cout << "(0.1 + 0.2) + 0.3 = " << (0.1 + 0.2) + 0.3 << "\n";
    std::cout << "0.1 + (0.2 + 0.3) = " << 0.1 + (0.2 + 0.3) << "\n";
    return 0;
}
