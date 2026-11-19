#include <iostream>
#include <vector>

// col[r] = column of the queen in row r, for the rows 0..r-1 already placed
bool safe(const std::vector<int>& col, int r, int c) {
    for (int i = 0; i < r; ++i) {
        if (col[i] == c) return false;                    // same column
        if (col[i] - c == r - i || c - col[i] == r - i) return false;   // same diagonal
    }
    return true;
}

// counts the ways to complete the placement from row r on
int place(std::vector<int>& col, int r, int n) {
    if (r == n) return 1;                                 // all rows filled: one solution
    int count = 0;
    for (int c = 0; c < n; ++c) {
        if (safe(col, r, c)) {
            col[r] = c;                                   // try it ...
            count += place(col, r + 1, n);                // ... and go on
        }                                                 // (backtrack: next c)
    }
    return count;
}

int main() {
    for (int n = 4; n <= 8; ++n) {
        std::vector<int> col(n);
        std::cout << n << " queens: " << place(col, 0, n) << " solutions\n";
    }
    return 0;
}
