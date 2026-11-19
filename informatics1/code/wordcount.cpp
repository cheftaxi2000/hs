#include <iostream>
#include <map>
#include <string>

int main() {
    std::map<std::string, int> count;
    std::string w;
    while (std::cin >> w) {            // reads word by word until the input ends
        ++count[w];                    // a missing key is created with value 0
    }
    for (const auto& entry : count)
        std::cout << entry.first << " " << entry.second << "\n";
    return 0;
}
