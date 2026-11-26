#include <iostream>
#include <string>

// POST: returns s backwards
std::string reverse(const std::string& s) {
    if (s.size() <= 1) return s;           // base case
    return reverse(s.substr(1)) + s[0];    // reversed rest + first
}

int main() {
    std::cout << reverse("abc") << " " << reverse("recursion")
              << " [" << reverse("") << "]\n";
}
