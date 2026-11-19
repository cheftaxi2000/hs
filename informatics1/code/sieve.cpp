#include <iostream>
#include <vector>

int main() {
    int n = 50;
    std::vector<bool> prime(n + 1, true);          // prime[k] == true: k is still a candidate
    prime[0] = prime[1] = false;
    for (int p = 2; p * p <= n; ++p) {
        if (prime[p]) {
            for (int m = p * p; m <= n; m += p)    // cross out the multiples of p
                prime[m] = false;
        }
    }
    for (int k = 2; k <= n; ++k)
        if (prime[k]) std::cout << k << " ";
    std::cout << "\n";
    return 0;
}
