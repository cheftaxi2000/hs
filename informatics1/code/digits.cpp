#include <iostream>

int main() {
    std::cout << "n = ";
    int n;
    std::cin >> n;

    int count = 0, sum = 0;
    while (n > 0) {
        sum += n % 10;      // add the last digit
        n /= 10;            // cut it off
        ++count;
    }
    std::cout << "digits: " << count << ", digit sum: " << sum << "\n";
    return 0;
}
