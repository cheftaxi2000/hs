#include <iostream>

enum class Weekday { Mon, Tue, Wed, Thu, Fri, Sat, Sun };

bool is_weekend(Weekday d) { return d == Weekday::Sat || d == Weekday::Sun; }

Weekday next(Weekday d) {
    return static_cast<Weekday>((static_cast<int>(d) + 1) % 7);   // after Sun comes Mon
}

int main() {
    Weekday d = Weekday::Fri;
    for (int i = 0; i < 4; ++i) {
        std::cout << static_cast<int>(d) << (is_weekend(d) ? " weekend" : " work") << "\n";
        d = next(d);
    }
    return 0;
}
