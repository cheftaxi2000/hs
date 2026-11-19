#include <iostream>

class Buffer {
public:
    Buffer(int n) : data_(new int[n]) {}
    ~Buffer() { delete[] data_; }
    // no copy constructor: the compiler generates one that copies the POINTER only
private:
    int* data_;
};

int main() {
    Buffer a(10);
    Buffer b = a;                // b.data_ and a.data_ now point to the same array
    std::cout << "both objects exist\n";
    return 0;                    // both destructors run: delete[] twice on the same memory
}
