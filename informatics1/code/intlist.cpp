#include <iostream>

class IntList {
public:
    IntList() : head_(nullptr), tail_(nullptr), size_(0) {}
    ~IntList() { clear(); }

    IntList(const IntList& o) : head_(nullptr), tail_(nullptr), size_(0) {   // deep copy
        for (const Node* p = o.head_; p != nullptr; p = p->next) push_back(p->value);
    }
    IntList& operator=(const IntList& o) {
        if (this != &o) {
            clear();
            for (const Node* p = o.head_; p != nullptr; p = p->next) push_back(p->value);
        }
        return *this;
    }

    void push_front(int v) {
        head_ = new Node{v, head_};
        if (tail_ == nullptr) tail_ = head_;       // the list was empty
        ++size_;
    }
    void push_back(int v) {                        // constant time thanks to tail_
        Node* n = new Node{v, nullptr};
        if (tail_ == nullptr) head_ = n; else tail_->next = n;
        tail_ = n;
        ++size_;
    }
    int pop_front() {                              // pre: not empty
        Node* old = head_;
        int v = old->value;
        head_ = old->next;
        if (head_ == nullptr) tail_ = nullptr;
        delete old;
        --size_;
        return v;
    }
    bool empty() const { return size_ == 0; }
    int size() const { return size_; }
    void print() const {
        for (const Node* p = head_; p != nullptr; p = p->next) std::cout << p->value << " ";
        std::cout << "(size " << size_ << ")\n";
    }
    void clear() { while (!empty()) pop_front(); }

private:
    struct Node { int value; Node* next; };        // an implementation detail: private
    Node* head_;
    Node* tail_;
    int size_;
};

int main() {
    IntList a;
    a.push_back(2); a.push_back(3); a.push_front(1);
    a.print();
    IntList b = a;               // deep copy
    b.pop_front();
    a.print();
    b.print();
    return 0;
}
