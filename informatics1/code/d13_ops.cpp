#include <iostream>
#include <stack>
#include <queue>

int main() {
    std::stack<int> s;
    std::queue<int> q;
    for (int x : {1, 2, 3}) { s.push(x); q.push(x); }
    s.pop(); q.pop();                 // removes 3 from s, 1 from q
    s.push(4); q.push(4);
    std::cout << "stack top: " << s.top() << ", queue front: " << q.front()
              << "\n";
    std::cout << "stack:";
    while (!s.empty()) { std::cout << " " << s.top(); s.pop(); }
    std::cout << "\nqueue:";
    while (!q.empty()) { std::cout << " " << q.front(); q.pop(); }
    std::cout << "\n";
}
