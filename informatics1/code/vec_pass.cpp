#include <iostream>
#include <vector>

// const reference: no copy, and the function promises not to modify v
int sum(const std::vector<int>& v) {
    int s = 0;
    for (int x : v) s += x;
    return s;
}

// reference: the function modifies the caller's vector
void double_all(std::vector<int>& v) {
    for (int i = 0; i < v.size(); ++i) v[i] *= 2;
}

// by value: works on a copy, the caller's vector stays the same
void broken_double_all(std::vector<int> v) {
    for (int i = 0; i < v.size(); ++i) v[i] *= 2;
}

int main() {
    std::vector<int> v = {1, 2, 3};
    broken_double_all(v);
    std::cout << "after broken_double_all: sum = " << sum(v) << "\n";
    double_all(v);
    std::cout << "after double_all:        sum = " << sum(v) << "\n";
    return 0;
}
