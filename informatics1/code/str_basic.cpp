#include <iostream>
#include <string>

int main() {
    std::string a = "Hello";
    std::string b = "World";
    std::string s = a + ", " + b + "!";          // + joins strings
    std::cout << s << "\n";
    std::cout << "length: " << s.length() << "\n";
    std::cout << "s[0] = " << s[0] << ", last = " << s[s.length() - 1] << "\n";

    s[0] = 'J';                                  // strings can be changed
    std::cout << s << "\n";
    std::cout << s.substr(7, 5) << "\n";         // 5 characters from position 7
    std::cout << "find \"World\": " << s.find("World") << "\n";
    std::cout << "find \"xyz\":   " << (s.find("xyz") == std::string::npos ? "not found" : "found") << "\n";
    std::cout << std::boolalpha << (std::string("apple") < std::string("banana")) << " " << (a == "Hello") << "\n";
    return 0;
}
