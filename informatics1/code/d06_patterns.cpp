#include <iostream>
#include <vector>

int main() {
    std::vector<int> v = {4, -2, 7, 0, 7, -5};

    // 1. accumulate (sum)
    int sum = 0;
    for (int x : v) sum += x;

    // 2. count (how many satisfy a condition?)
    int neg = 0;
    for (int x : v) if (x < 0) ++neg;

    // 3. extreme value (maximum) -- start with the first element!
    int mx = v[0];
    for (int x : v) if (x > mx) mx = x;

    // 4. search (first index of 7, or -1)
    int pos = -1;
    for (int i = 0; i < v.size(); ++i)
        if (v[i] == 7) { pos = i; break; }

    // 5. filter into a new vector
    std::vector<int> pos_only;
    for (int x : v) if (x > 0) pos_only.push_back(x);

    // 6. modify in place (needs a reference or an index)
    for (int& x : v) x = 2 * x;

    std::cout << "sum " << sum << ", negatives " << neg << ", max " << mx
              << ", first 7 at " << pos << "\n";
    std::cout << "positives:";
    for (int x : pos_only) std::cout << " " << x;
    std::cout << "\ndoubled:";
    for (int x : v) std::cout << " " << x;
    std::cout << "\n";
}
