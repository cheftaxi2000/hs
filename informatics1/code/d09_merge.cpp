#include <iostream>
#include <vector>

// PRE: a and b sorted. POST: sorted vector with all elements of a and b
std::vector<int> merge(const std::vector<int>& a, const std::vector<int>& b) {
    std::vector<int> r;
    int i = 0, j = 0;                          // front of a, front of b
    while (i < a.size() && j < b.size()) {
        if (a[i] <= b[j]) r.push_back(a[i++]); // take the smaller front
        else              r.push_back(b[j++]);
    }
    while (i < a.size()) r.push_back(a[i++]); // one of them is used up:
    while (j < b.size()) r.push_back(b[j++]); // copy the rest of the other
    return r;
}

int main() {
    for (int x : merge({1, 4, 9}, {2, 3, 10, 12})) std::cout << x << " ";
    std::cout << "\n";
}
