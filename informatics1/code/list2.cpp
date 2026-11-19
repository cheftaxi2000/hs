#include <iostream>

struct Node { int value; Node* next; };

void print(const Node* head) {
    for (const Node* p = head; p != nullptr; p = p->next) std::cout << p->value << " ";
    std::cout << "\n";
}

// inserts v right after the node p
void insert_after(Node* p, int v) {
    p->next = new Node{v, p->next};
}

// removes the first node with the value v; returns the (possibly new) head
Node* remove(Node* head, int v) {
    if (head == nullptr) return nullptr;
    if (head->value == v) {              // special case: the first node
        Node* rest = head->next;
        delete head;
        return rest;
    }
    Node* p = head;
    while (p->next != nullptr && p->next->value != v) p = p->next;
    if (p->next != nullptr) {            // found: unlink and delete
        Node* victim = p->next;
        p->next = victim->next;
        delete victim;
    }
    return head;
}

// reverses the list by redirecting all the next pointers
Node* reverse(Node* head) {
    Node* prev = nullptr;
    while (head != nullptr) {
        Node* next = head->next;
        head->next = prev;
        prev = head;
        head = next;
    }
    return prev;
}

int main() {
    Node* head = new Node{1, new Node{2, new Node{4, nullptr}}};
    print(head);
    insert_after(head->next, 3);         // after the node containing 2
    print(head);
    head = remove(head, 1);
    print(head);
    head = reverse(head);
    print(head);
    while (head) head = remove(head, head->value);   // free everything
    return 0;
}
