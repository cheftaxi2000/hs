#include <iostream>
#include <vector>

int main() {
    std::vector<int> v = {4, 8, 15};      // three elements
    v.push_back(16);                      // append: now 4 elements
    v.push_back(23);
    v[0] = 42;                            // indices start at 0

    std::cout << "size = " << v.size() << "\n";
    std::cout << "first = " << v[0] << ", last = " << v[v.size() - 1] << "\n";

    int sum = 0;
    for (int i = 0; i < v.size(); ++i) sum += v[i];
    std::cout << "sum = " << sum << "\n";

    for (int x : v) std::cout << x << " ";   // range-based for: every element once
    std::cout << "\n";

    std::vector<double> zeros(5, 0.0);       // 5 elements, all 0.0
    std::vector<int> empty;                  // no elements
    std::cout << zeros.size() << " " << empty.size() << " " << empty.empty() << "\n";
    return 0;
}
