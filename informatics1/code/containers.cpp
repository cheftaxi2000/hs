#include <iostream>
#include <list>
#include <map>
#include <set>
#include <string>
#include <vector>

int main() {
    std::set<int> s = {5, 1, 4, 1, 5, 9};          // no duplicates, always sorted
    s.insert(3);
    for (int x : s) std::cout << x << " ";
    std::cout << "| 4 in set? " << (s.count(4) > 0) << ", size " << s.size() << "\n";

    std::map<std::string, int> age;                // key -> value, sorted by key
    age["Alice"] = 20;
    age["Bob"] = 19;
    age["Alice"] = 21;                             // overwrites
    for (auto it = age.begin(); it != age.end(); ++it)
        std::cout << it->first << ": " << it->second << "\n";

    std::list<int> l;                              // doubly linked list: cheap at both ends
    l.push_back(2); l.push_back(3); l.push_front(1);
    for (int x : l) std::cout << x << " ";
    std::cout << "\n";
    return 0;
}
