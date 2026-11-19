#include <iostream>

int main() {
    std::cout << "Points (0-100): ";
    int points;
    std::cin >> points;

    if (points < 0 || points > 100) {
        std::cout << "invalid\n";
    } else if (points >= 90) {
        std::cout << "grade 6\n";
    } else if (points >= 75) {
        std::cout << "grade 5\n";
    } else if (points >= 60) {
        std::cout << "grade 4\n";
    } else {
        std::cout << "failed\n";
    }
    return 0;
}
