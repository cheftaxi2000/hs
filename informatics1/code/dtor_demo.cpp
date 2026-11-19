#include <iostream>
#include <string>

class Tracer {
public:
    Tracer(const std::string& name) : name_(name) { std::cout << "  construct " << name_ << "\n"; }
    Tracer(const Tracer& o) : name_(o.name_ + " (copy)") { std::cout << "  copy      " << name_ << "\n"; }
    ~Tracer() { std::cout << "  destroy   " << name_ << "\n"; }
private:
    std::string name_;
};

void by_value(Tracer t) { std::cout << "  inside by_value\n"; }
void by_reference(const Tracer& t) { std::cout << "  inside by_reference\n"; }

int main() {
    std::cout << "start of main\n";
    Tracer a("a");
    {
        Tracer b("b");
        std::cout << "end of inner block\n";
    }                                       // b is destroyed here
    std::cout << "call by value:\n";
    by_value(a);                            // a copy is made and destroyed
    std::cout << "call by reference:\n";
    by_reference(a);                        // no copy
    Tracer* h = new Tracer("heap");
    delete h;                               // destroyed when WE say so
    std::cout << "end of main\n";
    return 0;
}                                           // a is destroyed here
