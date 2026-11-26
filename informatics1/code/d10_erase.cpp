#include <iostream>
#include <vector>

int main() {
    std::vector<int> v = {3, 0, 0, 5, 0, 7};
    for (auto it = v.begin(); it != v.end(); ) {     // no ++it here!
        if (*it == 0) it = v.erase(it);   // erase returns the next position
        else ++it;                         // only advance if nothing erased
    }
    for (int x : v) std::cout << x << " ";
    std::cout << "\n";
}
