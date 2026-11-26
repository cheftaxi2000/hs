#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

int main() {
    std::vector<int> v = {7, 2, 9, 2, 5};
    std::sort(v.begin(), v.end());                          // 2 2 5 7 9
    int twos = std::count(v.begin(), v.end(), 2);           // 2
    int sum = std::accumulate(v.begin(), v.end(), 0);       // 25
    auto big = std::max_element(v.begin(), v.end());        // iterator!
    auto f = std::find(v.begin(), v.end(), 5);
    std::cout << twos << " " << sum << " " << *big << " "
              << "5 is at index " << (f - v.begin()) << "\n";
}
