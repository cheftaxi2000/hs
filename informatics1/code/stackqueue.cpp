#include <iostream>
#include <queue>
#include <stack>
#include <string>

// are the brackets in s correctly nested?  "([]{})" yes, "([)]" no
bool balanced(const std::string& s) {
    std::stack<char> open;
    for (char c : s) {
        if (c == '(' || c == '[' || c == '{') {
            open.push(c);
        } else if (c == ')' || c == ']' || c == '}') {
            if (open.empty()) return false;
            char o = open.top(); open.pop();
            if ((c == ')' && o != '(') || (c == ']' && o != '[') || (c == '}' && o != '{')) return false;
        }
    }
    return open.empty();
}

int main() {
    std::stack<int> st;
    std::queue<int> q;
    for (int i = 1; i <= 4; ++i) { st.push(i); q.push(i); }
    std::cout << "stack (last in, first out): ";
    while (!st.empty()) { std::cout << st.top() << " "; st.pop(); }
    std::cout << "\nqueue (first in, first out): ";
    while (!q.empty()) { std::cout << q.front() << " "; q.pop(); }
    std::cout << "\n" << std::boolalpha << balanced("([]{})") << " " << balanced("([)]") << " " << balanced("((") << "\n";
    return 0;
}
