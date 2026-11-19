#include <iostream>

struct Rational {       // the fraction n / d
    int n;
    int d;              // invariant: d > 0
};

int gcd(int a, int b) { return b == 0 ? a : gcd(b, a % b); }

// operators for our own type: the same notation as for int and double
Rational operator+(Rational a, Rational b) {
    Rational r = {a.n * b.d + b.n * a.d, a.d * b.d};
    int g = gcd(r.n < 0 ? -r.n : r.n, r.d);        // cancel the fraction
    r.n /= g; r.d /= g;
    return r;
}

Rational operator*(Rational a, Rational b) {
    Rational r = {a.n * b.n, a.d * b.d};
    int g = gcd(r.n < 0 ? -r.n : r.n, r.d);
    if (g > 1) { r.n /= g; r.d /= g; }
    return r;
}

bool operator==(Rational a, Rational b) { return a.n * b.d == b.n * a.d; }

std::ostream& operator<<(std::ostream& out, Rational r) {
    return out << r.n << "/" << r.d;
}

int main() {
    Rational a = {1, 2}, b = {1, 3};
    std::cout << a << " + " << b << " = " << a + b << "\n";
    std::cout << a << " * " << b << " = " << a * b << "\n";
    Rational s = {0, 1};
    for (int k = 1; k <= 10; ++k) s = s + Rational{1, k * (k + 1)};   // telescoping sum
    std::cout << "sum 1/(k(k+1)), k = 1..10 = " << s << "\n";
    std::cout << std::boolalpha << (Rational{2, 4} == Rational{1, 2}) << "\n";
    return 0;
}
