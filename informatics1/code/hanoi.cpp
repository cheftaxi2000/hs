#include <iostream>

long moves = 0;

// moves n discs from peg 'from' to peg 'to', using peg 'via' as help
void hanoi(int n, char from, char to, char via, bool print) {
    if (n == 0) return;                                  // nothing to move
    hanoi(n - 1, from, via, to, print);                  // 1. clear the way: n-1 discs to via
    if (print) std::cout << "move disc " << n << " from " << from << " to " << to << "\n";
    ++moves;                                             // 2. move the biggest disc
    hanoi(n - 1, via, to, from, print);                  // 3. put the n-1 discs on top of it
}

int main() {
    hanoi(3, 'A', 'C', 'B', true);
    std::cout << moves << " moves for 3 discs\n";
    moves = 0;
    hanoi(20, 'A', 'C', 'B', false);
    std::cout << moves << " moves for 20 discs\n";
    return 0;
}
