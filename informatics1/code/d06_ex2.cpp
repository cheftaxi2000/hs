#include <iostream>
#include <vector>

// POST: returns how many elements of v are strictly greater than t
int count_greater(const std::vector<int>& v, int t) {
    int count = 0;
    for (int x : v)
        if (x > t) ++count;
    return count;
}

int main() {
    std::cout << count_greater({5, 1, 8, 3}, 3) << "\n";  // 5 and 8
    std::cout << count_greater({}, 3) << "\n";            // empty: 0
    std::cout << count_greater({3, 3}, 3) << "\n";        // strictly: 0
}
