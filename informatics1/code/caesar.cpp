#include <iostream>
#include <string>

// shifts every lower-case letter by k positions (cyclically), leaves other characters alone
std::string caesar(const std::string& text, int k) {
    std::string r = text;
    for (int i = 0; i < r.length(); ++i) {
        if (r[i] >= 'a' && r[i] <= 'z')
            r[i] = 'a' + (r[i] - 'a' + k) % 26;
    }
    return r;
}

int main() {
    std::string secret = caesar("attack at dawn", 3);
    std::cout << secret << "\n";
    std::cout << caesar(secret, 23) << "\n";     // shift by 26 - 3 decrypts
    return 0;
}
