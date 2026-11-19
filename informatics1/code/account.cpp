#include <iostream>

class Account {
public:
    Account(int initial) : balance_(initial) {}             // constructor: runs at creation

    bool withdraw(int amount) {                             // member function
        if (amount <= 0 || amount > balance_) return false; // the invariant protects us
        balance_ -= amount;
        return true;
    }
    void deposit(int amount) { if (amount > 0) balance_ += amount; }
    int balance() const { return balance_; }                // const: does not change the object

private:
    int balance_;                                           // invariant: balance_ >= 0
};

int main() {
    Account a(100);
    a.deposit(50);
    std::cout << "withdraw 200: " << a.withdraw(200) << ", balance " << a.balance() << "\n";
    std::cout << "withdraw 120: " << a.withdraw(120) << ", balance " << a.balance() << "\n";
    return 0;
}
