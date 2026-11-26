#include <iostream>

struct Node { int value; Node* next; };

// POST: number of nodes with a value greater than t
int count_greater(const Node* head, int t) {
    int count = 0;
    for (const Node* p = head; p != nullptr; p = p->next)  // visit every node
        if (p->value > t) ++count;
    return count;
}

int main() {
    Node* head = new Node{4, new Node{9, new Node{1, new Node{7, nullptr}}}};
    std::cout << count_greater(head, 3) << " " << count_greater(nullptr, 3)
              << "\n";
    while (head != nullptr) {                 // free the list
        Node* next = head->next;
        delete head;
        head = next;
    }
}
