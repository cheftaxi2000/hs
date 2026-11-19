#include <iostream>
#include <vector>

long calls = 0;

// memo[n] == -1 means "not yet computed"
long fib(int n, std::vector<long>& memo) {
    ++calls;
    if (n <= 1) return n;
    if (memo[n] != -1) return memo[n];                 // already known: no new work
    memo[n] = fib(n - 1, memo) + fib(n - 2, memo);     // compute once, remember
    return memo[n];
}

int main() {
    std::vector<long> memo(91, -1);
    std::cout << "fib(90) = " << fib(90, memo) << " with " << calls << " calls\n";
    return 0;
}
