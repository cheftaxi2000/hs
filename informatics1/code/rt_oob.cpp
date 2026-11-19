#include <iostream>
#include <vector>

int main() {
    std::vector<int> v = {10, 20, 30};
    std::cout << v.at(2) << "\n";     // fine
    std::cout << v.at(5) << "\n";     // out of range: at() checks and stops the program
    return 0;
}
