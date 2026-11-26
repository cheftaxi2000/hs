#include <iostream>
#include <string>

int main() {
    std::string s = "Hello, World 2026";
    int letters = 0, digits = 0, upper = 0;
    std::string only_letters;                // build a new string
    for (int i = 0; i < s.size(); ++i) {
        char c = s[i];
        if (c >= '0' && c <= '9') ++digits;
        if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
            ++letters;
            only_letters += c;               // append one character
        }
        if (c >= 'A' && c <= 'Z') ++upper;
    }
    std::cout << letters << " letters, " << digits << " digits, "
              << upper << " upper case\n";
    std::cout << only_letters << "\n";
}
