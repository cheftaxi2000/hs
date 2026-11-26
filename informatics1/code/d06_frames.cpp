#include <iostream>

void by_value(int n) { n = n * 10; }     // n is a photocopy
void by_ref(int& n)  { n = n * 10; }     // n is the original

int main() {
    int x = 3;
    by_value(x);
    std::cout << "after by_value: x = " << x << "\n";
    by_ref(x);
    std::cout << "after by_ref:   x = " << x << "\n";
}
