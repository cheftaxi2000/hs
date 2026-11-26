#include <iostream>
#include <string>

// POST: every word of s starts with an upper-case letter
std::string capitalize(std::string s) {           // a copy: we may change it
    for (int i = 0; i < s.size(); ++i) {
        bool word_start = (i == 0 || s[i - 1] == ' ');
        if (word_start && s[i] >= 'a' && s[i] <= 'z')
            s[i] = s[i] - 'a' + 'A';
    }
    return s;
}

int main() {
    std::cout << capitalize("eth zurich is in zurich") << "\n";
}
