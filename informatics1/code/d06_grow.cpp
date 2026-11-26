#include <iostream>
#include <vector>

void print(const std::vector<int>& v) {
    std::cout << "size " << v.size() << ": ";
    for (int x : v) std::cout << x << " ";
    std::cout << "\n";
}

int main() {
    std::vector<int> v;      // empty
    print(v);
    v.push_back(7);          // [7]
    print(v);
    v.push_back(3);          // [7, 3]
    v.push_back(9);          // [7, 3, 9]
    print(v);
    v[1] = 4;                // overwrite element number 1 (the second one!)
    print(v);
    v.pop_back();            // remove the last one
    print(v);
}
