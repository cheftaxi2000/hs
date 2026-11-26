#include <iostream>

// A fixed-size array of ints on the heap, with the rule of three
class IntArray {
public:
    IntArray(int n) : n_(n), data_(new int[n]) {      // acquire
        for (int i = 0; i < n_; ++i) data_[i] = 0;
    }
    ~IntArray() { delete[] data_; }                   // release

    IntArray(const IntArray& o) : n_(o.n_), data_(new int[o.n_]) {
        for (int i = 0; i < n_; ++i) data_[i] = o.data_[i];   // deep copy
    }

    IntArray& operator=(const IntArray& o) {
        if (this == &o) return *this;                 // a = a: nothing to do
        int* fresh = new int[o.n_];                   // 1. new memory
        for (int i = 0; i < o.n_; ++i) fresh[i] = o.data_[i]; // 2. copy
        delete[] data_;                               // 3. free the old
        data_ = fresh;                                // 4. take the new
        n_ = o.n_;
        return *this;
    }

    int& operator[](int i) { return data_[i]; }
    int size() const { return n_; }
private:
    int n_;
    int* data_;
};

int main() {
    IntArray a(3);
    a[0] = 1; a[1] = 2; a[2] = 3;
    IntArray b = a;          // copy constructor: b has its own array
    b[0] = 100;
    IntArray c(1);
    c = a;                   // assignment: c gives back its old array
    c[2] = 300;
    std::cout << a[0] << " " << a[2] << " | " << b[0] << " | "
              << c[2] << " " << c.size() << "\n";
}
