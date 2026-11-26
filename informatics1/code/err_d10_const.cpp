class Counter {
public:
    Counter() : count_(0) {}
    int value() const { ++count_; return count_; }   // const, but changes!
private:
    int count_;
};

int main() {
    Counter c;
    c.count_ = 5;                                    // private!
}
