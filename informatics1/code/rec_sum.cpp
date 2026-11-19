#include <iostream>
#include <string>

// sum of the digits of n >= 0, recursively
int digit_sum(int n) {
    if (n < 10) return n;
    return n % 10 + digit_sum(n / 10);
}

// is s a palindrome? look at the outer characters, then at the inside
bool pal(const std::string& s, int i, int j) {
    if (i >= j) return true;
    if (s[i] != s[j]) return false;
    return pal(s, i + 1, j - 1);
}

// greatest common divisor, Euclid, recursively
int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

int main() {
    std::cout << digit_sum(4721) << " " << pal("racecar", 0, 6) << " " << gcd(252, 105) << "\n";
    return 0;
}
