#include <iostream>
#include <vector>

void f(std::vector<int> a, std::vector<int>& b) {
    a[0] = 10;
    b[0] = 20;
    b.push_back(a[1]);
}

int main() {
    std::vector<int> x = {1, 2};
    std::vector<int> y = {3, 4};
    f(x, y);
    f(y, x);
    for (int e : x) std::cout << e << " ";
    std::cout << "| ";
    for (int e : y) std::cout << e << " ";
    std::cout << "\n";
}
