#include <iostream>
#include <string>

int main() {
    std::string line;
    std::getline(std::cin, line);               // reads the whole line, spaces included

    int words = 0;
    bool in_word = false;
    for (char c : line) {
        if (c != ' ' && !in_word) ++words;      // a new word starts here
        in_word = (c != ' ');
    }
    std::cout << "\"" << line << "\" has " << words << " words and "
              << line.length() << " characters\n";

    std::string word;
    std::cin >> word;                           // >> reads one word (up to whitespace)
    std::cout << "next word: " << word << "\n";
    return 0;
}
