#include <iostream>

int main() {
    double a, b;
    char op;
    std::cin >> a >> op >> b;
    switch (op) {
        case '+': std::cout << a + b << "\n"; break;
        case '-': std::cout << a - b << "\n"; break;
        case '*': std::cout << a * b << "\n"; break;
        case '/':
            if (b != 0) std::cout << a / b << "\n";
            else std::cout << "division by zero\n";
            break;
        default:
            std::cout << "unknown operator\n";
    }
    return 0;
}
