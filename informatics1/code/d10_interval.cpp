#include <iostream>

// An interval [lo, hi] of real numbers. Invariant: lo_ <= hi_
class Interval {
public:
    Interval(double a, double b) {           // establishes the invariant
        if (a <= b) { lo_ = a; hi_ = b; }
        else        { lo_ = b; hi_ = a; }
    }
    double length() const { return hi_ - lo_; }
    bool contains(double x) const { return lo_ <= x && x <= hi_; }
    void extend(double x) {                  // keeps the invariant
        if (x < lo_) lo_ = x;
        if (x > hi_) hi_ = x;
    }
    double lo() const { return lo_; }
    double hi() const { return hi_; }
private:
    double lo_, hi_;
};

int main() {
    Interval i(5, 2);                        // given in the wrong order
    std::cout << "[" << i.lo() << ", " << i.hi() << "] length "
              << i.length() << "\n";
    i.extend(7);
    std::cout << "[" << i.lo() << ", " << i.hi() << "] contains 6: "
              << i.contains(6) << "\n";
}
