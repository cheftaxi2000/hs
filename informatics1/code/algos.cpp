#include <algorithm>
#include <iostream>
#include <numeric>
#include <vector>

int main() {
    std::vector<int> v = {5, 2, 9, 1, 7, 3};
    std::sort(v.begin(), v.end());                              // ascending
    for (int x : v) std::cout << x << " ";
    std::cout << "\n";
    std::sort(v.begin(), v.end(), std::greater<int>());         // descending
    for (int x : v) std::cout << x << " ";
    std::cout << "\n";

    auto it = std::find(v.begin(), v.end(), 7);                 // iterator to the element, or end()
    if (it != v.end()) std::cout << "7 found at index " << it - v.begin() << "\n";
    std::cout << "min = " << *std::min_element(v.begin(), v.end())
              << ", max = " << *std::max_element(v.begin(), v.end()) << "\n";
    std::cout << "sum = " << std::accumulate(v.begin(), v.end(), 0) << "\n";
    std::cout << "odd numbers: " << std::count_if(v.begin(), v.end(), [](int x) { return x % 2 == 1; }) << "\n";
    std::reverse(v.begin(), v.end());
    for (int x : v) std::cout << x << " ";
    std::cout << "\n";
    return 0;
}
