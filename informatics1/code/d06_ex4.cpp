#include <iostream>
#include <vector>

// POST: returns a vector with the sum of each row of m
std::vector<int> row_sums(const std::vector<std::vector<int>>& m) {
    std::vector<int> s(m.size(), 0);           // one sum per row, all 0
    for (int i = 0; i < m.size(); ++i)         // i: row
        for (int j = 0; j < m[i].size(); ++j)  // j: column
            s[i] += m[i][j];
    return s;
}

int main() {
    std::vector<std::vector<int>> m = {{1, 2, 3},
                                       {4, 5, 6}};
    for (int x : row_sums(m)) std::cout << x << " ";
    std::cout << "\n";
}
