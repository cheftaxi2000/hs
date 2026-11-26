#include <iostream>

class Counter {
public:
    Counter() : count_(0) {}                 // constructor: start at 0
    void tick() { ++count_; }                // changes the object
    int value() const { return count_; }     // only reads: const
private:
    int count_;                              // hidden from the outside
};

int main() {
    Counter a, b;                            // two objects, two count_ boxes
    a.tick(); a.tick(); a.tick();
    b.tick();
    std::cout << "a: " << a.value() << ", b: " << b.value() << "\n";
}
