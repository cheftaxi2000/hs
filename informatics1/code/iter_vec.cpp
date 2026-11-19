#include <iostream>
#include <vector>

int main() {
    std::vector<int> v = {3, 1, 4, 1, 5};
    // an iterator points at an element; *it is the element, ++it moves to the next
    for (std::vector<int>::iterator it = v.begin(); it != v.end(); ++it) {
        *it = *it * 10;                   // modifies the element
    }
    for (auto it = v.begin(); it != v.end(); ++it)      // 'auto': the compiler deduces the type
        std::cout << *it << " ";
    std::cout << "\n";
    auto p = v.begin() + 2;               // vector iterators can jump
    std::cout << "third element: " << *p << ", distance to end: " << v.end() - p << "\n";
    return 0;
}
