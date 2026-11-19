class Account {
    int balance;           // private by default in a class
public:
    Account() : balance(0) {}
};

int main() {
    Account a;
    a.balance = 1000000;   // not allowed from outside
    return 0;
}
