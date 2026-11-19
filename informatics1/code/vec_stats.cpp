#include <iostream>
#include <vector>

int main() {
    int n;
    std::cin >> n;
    std::vector<double> a(n);
    for (int i = 0; i < n; ++i) std::cin >> a[i];

    double max = a[0], sum = 0;
    for (double x : a) {
        if (x > max) max = x;
        sum += x;
    }
    std::cout << "max = " << max << ", average = " << sum / n << "\n";
    std::cout << "reversed:";
    for (int i = n - 1; i >= 0; --i) std::cout << " " << a[i];
    std::cout << "\n";
    return 0;
}
