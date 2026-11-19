#include <iostream>
#include <string>

// post: true iff s reads the same forwards and backwards
bool is_palindrome(const std::string& s) {
    int i = 0, j = s.length() - 1;
    while (i < j) {
        if (s[i] != s[j]) return false;
        ++i; --j;
    }
    return true;
}

int main() {
    std::cout << std::boolalpha;
    std::cout << is_palindrome("racecar") << " " << is_palindrome("level up")
              << " " << is_palindrome("") << "\n";
    return 0;
}
