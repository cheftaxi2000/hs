#include <iostream>
#include <vector>

// pre:  v sorted ascending, 0 <= lo <= hi <= v.size()
// post: index of x in v[lo..hi-1], or -1 if x does not occur there
int search(const std::vector<int>& v, int x, int lo, int hi) {
    if (lo >= hi) return -1;                  // empty range: not found
    int mid = lo + (hi - lo) / 2;
    if (v[mid] == x) return mid;
    if (v[mid] < x) return search(v, x, mid + 1, hi);   // continue in the upper half
    return search(v, x, lo, mid);                       // continue in the lower half
}

int main() {
    std::vector<int> v = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31};
    std::cout << search(v, 17, 0, v.size()) << " " << search(v, 4, 0, v.size()) << "\n";
    return 0;
}
