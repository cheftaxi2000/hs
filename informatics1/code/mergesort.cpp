#include <iostream>
#include <vector>

// pre: v[lo..mid-1] and v[mid..hi-1] are both sorted
// post: v[lo..hi-1] is sorted
void merge(std::vector<int>& v, int lo, int mid, int hi) {
    std::vector<int> tmp;
    int i = lo, j = mid;
    while (i < mid && j < hi) {                       // take the smaller of the two front elements
        if (v[i] <= v[j]) tmp.push_back(v[i++]);
        else              tmp.push_back(v[j++]);
    }
    while (i < mid) tmp.push_back(v[i++]);            // one half is used up: copy the rest of the other
    while (j < hi)  tmp.push_back(v[j++]);
    for (int k = 0; k < tmp.size(); ++k) v[lo + k] = tmp[k];
}

// post: v[lo..hi-1] is sorted
void merge_sort(std::vector<int>& v, int lo, int hi) {
    if (hi - lo <= 1) return;                         // 0 or 1 element: already sorted
    int mid = lo + (hi - lo) / 2;
    merge_sort(v, lo, mid);                           // sort the left half
    merge_sort(v, mid, hi);                           // sort the right half
    merge(v, lo, mid, hi);                            // combine
}

int main() {
    std::vector<int> v = {5, 2, 9, 1, 7, 3, 8, 4};
    merge_sort(v, 0, v.size());
    for (int x : v) std::cout << x << " ";
    std::cout << "\n";
    return 0;
}
