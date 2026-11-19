#include <cmath>
#include <iostream>
#include <vector>

struct Point {          // a new type that bundles two values
    double x;
    double y;
};

double distance(const Point& p, const Point& q) {
    return std::sqrt((p.x - q.x) * (p.x - q.x) + (p.y - q.y) * (p.y - q.y));
}

Point midpoint(const Point& p, const Point& q) {
    Point m;
    m.x = (p.x + q.x) / 2;
    m.y = (p.y + q.y) / 2;
    return m;                                  // structs can be returned like numbers
}

int main() {
    Point a = {0, 0};                          // initialise the members in order
    Point b = {3, 4};
    Point m = midpoint(a, b);
    std::cout << "distance = " << distance(a, b) << "\n";
    std::cout << "midpoint = (" << m.x << ", " << m.y << ")\n";

    std::vector<Point> path = {{0, 0}, {1, 0}, {1, 1}, {0, 1}};   // a vector of structs
    double length = 0;
    for (int i = 0; i + 1 < path.size(); ++i) length += distance(path[i], path[i + 1]);
    std::cout << "path length = " << length << "\n";
    return 0;
}
