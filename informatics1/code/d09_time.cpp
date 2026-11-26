#include <iostream>

struct Time {
    int h;   // hours 0..23
    int m;   // minutes 0..59
};

// POST: t moved forward by 'minutes' (wraps around midnight)
Time add(Time t, int minutes) {
    int total = t.h * 60 + t.m + minutes;      // everything in minutes
    total = total % (24 * 60);
    return Time{total / 60, total % 60};
}

bool operator<(const Time& a, const Time& b) {
    return a.h < b.h || (a.h == b.h && a.m < b.m);
}

std::ostream& operator<<(std::ostream& out, const Time& t) {
    out << t.h << ":" << (t.m < 10 ? "0" : "") << t.m;
    return out;
}

int main() {
    Time lecture{10, 15};
    Time end = add(lecture, 105);              // 1h 45min later
    std::cout << lecture << " -> " << end << "\n";
    std::cout << add(Time{23, 30}, 45) << "\n";
    std::cout << (lecture < end) << "\n";
}
