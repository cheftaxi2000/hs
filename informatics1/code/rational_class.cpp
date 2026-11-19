#include <cassert>
#include <iostream>

class Rational {
public:
    Rational(int n = 0, int d = 1) : n_(n), d_(d) {      // constructor with default arguments
        assert(d != 0);
        if (d_ < 0) { n_ = -n_; d_ = -d_; }              // establish the invariant: d_ > 0
        int g = gcd(n_ < 0 ? -n_ : n_, d_);
        if (g > 1) { n_ /= g; d_ /= g; }                 // ... and the fraction is cancelled
    }
    int numerator() const { return n_; }
    int denominator() const { return d_; }
    Rational operator+(const Rational& o) const { return Rational(n_ * o.d_ + o.n_ * d_, d_ * o.d_); }
    Rational operator*(const Rational& o) const { return Rational(n_ * o.n_, d_ * o.d_); }
    bool operator==(const Rational& o) const { return n_ == o.n_ && d_ == o.d_; }   // both are cancelled

private:
    static int gcd(int a, int b) { return b == 0 ? a : gcd(b, a % b); }
    int n_, d_;                // invariant: d_ > 0, gcd(|n_|, d_) == 1  (maintained by the constructor)
};

std::ostream& operator<<(std::ostream& out, const Rational& r) {
    return out << r.numerator() << "/" << r.denominator();
}

int main() {
    Rational a(6, -8), b(1, 4);
    std::cout << a << " + " << b << " = " << a + b << "\n";
    std::cout << a << " * 2 = " << a * 2 << "\n";          // 2 is converted to Rational(2, 1)
    std::cout << std::boolalpha << (Rational(2, 4) == Rational(3, 6)) << "\n";
    return 0;
}
