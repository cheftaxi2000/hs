#include <iostream>
#include <vector>

// The same class, but the vector does the memory management:
// no destructor, no copy constructor, no assignment needed ("rule of zero")
class IntArray {
public:
    IntArray(int n) : data_(n, 0) {}
    int& operator[](int i) { return data_[i]; }
    int size() const { return data_.size(); }
private:
    std::vector<int> data_;
};

int main() {
    IntArray a(3);
    a[0] = 1;
    IntArray b = a;          // the vector copies itself correctly
    b[0] = 100;
    std::cout << a[0] << " " << b[0] << "\n";
}
