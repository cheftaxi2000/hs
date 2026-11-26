#include <iostream>
#include <vector>

// POST: index of x in sorted v, or -1
int search(const std::vector<int>& v, int x) {
    int lo = 0, hi = v.size();                 // search in [lo, hi)
    while (lo < hi) {
        int mid = lo + (hi - lo) / 2;
        std::cout << "lo=" << lo << " hi=" << hi << " mid=" << mid
                  << " v[mid]=" << v[mid] << "\n";
        if (v[mid] == x) return mid;
        if (v[mid] < x) lo = mid + 1;          // x is to the right
        else            hi = mid;              // x is to the left
    }
    return -1;
}

int main() {
    std::vector<int> v = {2, 5, 8, 12, 16, 23, 38, 56, 72, 91};
    int r = search(v, 16);
    std::cout << "result " << r << "\n";
    r = search(v, 40);
    std::cout << "result " << r << "\n";
}
