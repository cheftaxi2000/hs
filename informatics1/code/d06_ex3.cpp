#include <iostream>
#include <vector>

// POST: all negative numbers are removed from v, order of the rest kept
void remove_negatives(std::vector<int>& v) {
    int k = 0;                          // next free place for a kept element
    for (int i = 0; i < v.size(); ++i)
        if (v[i] >= 0) {
            v[k] = v[i];                // move the kept element forward
            ++k;
        }
    v.resize(k);                        // cut off the rest
}

int main() {
    std::vector<int> v = {3, -1, -4, 5, -9, 2};
    remove_negatives(v);
    for (int x : v) std::cout << x << " ";
    std::cout << "\n";
}
