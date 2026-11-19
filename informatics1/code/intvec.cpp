#include <iostream>

class IntVec {
public:
    IntVec() : size_(0), cap_(1), data_(new int[1]) {}

    // rule of three: destructor, copy constructor, copy assignment
    ~IntVec() { delete[] data_; }

    IntVec(const IntVec& o) : size_(o.size_), cap_(o.cap_), data_(new int[o.cap_]) {
        for (int i = 0; i < size_; ++i) data_[i] = o.data_[i];       // deep copy
    }

    IntVec& operator=(const IntVec& o) {
        if (this != &o) {                                            // guard against v = v
            int* fresh = new int[o.cap_];
            for (int i = 0; i < o.size_; ++i) fresh[i] = o.data_[i];
            delete[] data_;                                          // release the old memory
            data_ = fresh;
            size_ = o.size_;
            cap_ = o.cap_;
        }
        return *this;
    }

    void push_back(int x) {
        if (size_ == cap_) grow();
        data_[size_++] = x;
    }
    int size() const { return size_; }
    int capacity() const { return cap_; }
    int& operator[](int i) { return data_[i]; }
    const int& operator[](int i) const { return data_[i]; }

private:
    void grow() {                                                    // double the capacity
        int* bigger = new int[2 * cap_];
        for (int i = 0; i < size_; ++i) bigger[i] = data_[i];
        delete[] data_;
        data_ = bigger;
        cap_ *= 2;
    }
    int size_, cap_;
    int* data_;
};

int main() {
    IntVec v;
    for (int i = 1; i <= 9; ++i) {
        v.push_back(i * i);
        std::cout << "size " << v.size() << ", capacity " << v.capacity() << "\n";
    }
    IntVec w = v;               // copy constructor
    w[0] = 100;                 // changes only the copy
    std::cout << v[0] << " " << w[0] << "\n";
    IntVec u;
    u = w;                      // copy assignment
    u = u;                      // self-assignment: harmless
    std::cout << u[0] << " " << u.size() << "\n";
    return 0;
}
