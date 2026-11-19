#include <iostream>

struct Node {
    int value;
    Node* next;                          // pointer to the next node, nullptr at the end
};

// new node in front of the list; returns the new head
Node* push_front(Node* head, int v) {
    return new Node{v, head};
}

void print(const Node* head) {
    for (const Node* p = head; p != nullptr; p = p->next)
        std::cout << p->value << " -> ";
    std::cout << "end\n";
}

int length(const Node* head) {
    int n = 0;
    for (const Node* p = head; p != nullptr; p = p->next) ++n;
    return n;
}

bool contains(const Node* head, int v) {
    for (const Node* p = head; p != nullptr; p = p->next)
        if (p->value == v) return true;
    return false;
}

void free_list(Node* head) {
    while (head != nullptr) {
        Node* next = head->next;         // remember before deleting!
        delete head;
        head = next;
    }
}

int main() {
    Node* head = nullptr;                // the empty list
    for (int v : {3, 2, 1}) head = push_front(head, v);
    print(head);
    std::cout << "length " << length(head) << ", contains 2: " << contains(head, 2)
              << ", contains 9: " << contains(head, 9) << "\n";
    free_list(head);
    return 0;
}
