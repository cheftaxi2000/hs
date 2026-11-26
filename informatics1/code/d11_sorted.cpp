#include <iostream>

struct Node { int value; Node* next; };

void print(const Node* p) {
    for (; p != nullptr; p = p->next) std::cout << p->value << " ";
    std::cout << "\n";
}

// PRE: sorted list. POST: v inserted in order; returns the new head
Node* insert_sorted(Node* head, int v) {
    if (head == nullptr || v < head->value)       // new first node
        return new Node{v, head};
    Node* p = head;                               // find the predecessor:
    while (p->next != nullptr && p->next->value < v)
        p = p->next;                              // the last node with value < v
    p->next = new Node{v, p->next};               // link in after p
    return head;
}

int main() {
    Node* head = nullptr;
    for (int v : {5, 2, 8, 6, 1}) {
        head = insert_sorted(head, v);
        print(head);
    }
    while (head) { Node* n = head->next; delete head; head = n; }
}
