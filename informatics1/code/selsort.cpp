#include <iostream>
#include <vector>

// post: v is sorted in ascending order
void selection_sort(std::vector<int>& v) {
    for (int i = 0; i + 1 < v.size(); ++i) {
        int m = i;                              // position of the smallest element in v[i..]
        for (int j = i + 1; j < v.size(); ++j)
            if (v[j] < v[m]) m = j;
        int t = v[i]; v[i] = v[m]; v[m] = t;    // put it at position i
    }
}

int main() {
    std::vector<int> v = {5, 2, 9, 1, 7, 3};
    selection_sort(v);
    for (int x : v) std::cout << x << " ";
    std::cout << "\n";
    return 0;
}
