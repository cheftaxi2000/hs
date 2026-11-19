#include <iostream>
#include <vector>

int main() {
    int rows = 6;
    std::vector<std::vector<int>> t(rows);           // a vector of vectors
    for (int i = 0; i < rows; ++i) {
        t[i] = std::vector<int>(i + 1, 1);           // row i has i+1 entries, all 1
        for (int j = 1; j < i; ++j)
            t[i][j] = t[i - 1][j - 1] + t[i - 1][j]; // sum of the two entries above
    }
    for (int i = 0; i < rows; ++i) {
        for (int x : t[i]) std::cout << x << " ";
        std::cout << "\n";
    }
    return 0;
}
