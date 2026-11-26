#include <iostream>
#include <vector>

// chosen: the elements already decided to be IN the subset
// k:      the next number to decide about (1 ... n)
void subsets(std::vector<int>& chosen, int k, int n) {
    if (k > n) {                               // all decisions made
        std::cout << "{";
        for (int x : chosen) std::cout << " " << x;
        std::cout << " } ";
        return;
    }
    subsets(chosen, k + 1, n);                 // decision 1: k is NOT in
    chosen.push_back(k);                       // decision 2: k IS in ...
    subsets(chosen, k + 1, n);
    chosen.pop_back();                         // ... undo it (backtrack)
}

int main() {
    std::vector<int> chosen;
    subsets(chosen, 1, 3);
    std::cout << "\n";
}
