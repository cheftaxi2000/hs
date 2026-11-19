#include <iostream>
#include <string>

// prints all words that start with 'prefix' followed by a permutation of 'rest'
void permute(const std::string& prefix, const std::string& rest) {
    if (rest.empty()) {                          // base case: nothing left to place
        std::cout << prefix << " ";
        return;
    }
    for (int i = 0; i < rest.length(); ++i) {
        // choose rest[i] as the next letter, permute what remains
        permute(prefix + rest[i], rest.substr(0, i) + rest.substr(i + 1));
    }
}

int main() {
    permute("", "abc");
    std::cout << "\n";
    return 0;
}
