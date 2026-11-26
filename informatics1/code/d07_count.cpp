#include <iostream>
#include <string>

// POST: how often c occurs in s from position i on
int count_from(const std::string& s, char c, int i) {
    if (i == s.size()) return 0;             // nothing left
    int here = (s[i] == c) ? 1 : 0;          // one character
    return here + count_from(s, c, i + 1);   // and the rest
}

int main() {
    std::cout << count_from("banana", 'a', 0) << "\n";
}
