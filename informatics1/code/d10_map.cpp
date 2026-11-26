#include <iostream>
#include <map>
#include <string>

int main() {
    std::string text = "the cat and the hat and the bat";
    std::map<char, int> freq;                // letter -> how often
    for (char c : text)
        if (c != ' ') ++freq[c];             // creates the entry with 0 first

    for (auto it = freq.begin(); it != freq.end(); ++it)
        std::cout << it->first << ":" << it->second << " ";
    std::cout << "\n";

    // look up without creating: find
    if (freq.find('z') == freq.end()) std::cout << "no z\n";
    std::cout << "entries: " << freq.size() << "\n";
}
