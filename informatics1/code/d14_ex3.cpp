#include <iostream>
#include <string>
#include <vector>

class Employee {                                   // abstract base class
public:
    Employee(const std::string& name) : name_(name) {}
    virtual ~Employee() {}
    virtual double salary() const = 0;             // every employee has one,
    std::string name() const { return name_; }     // but each kind computes it
private:                                           // differently
    std::string name_;
};

class Salaried : public Employee {
public:
    Salaried(const std::string& n, double monthly)
        : Employee(n), monthly_(monthly) {}
    double salary() const override { return monthly_; }
private:
    double monthly_;
};

class Hourly : public Employee {
public:
    Hourly(const std::string& n, double rate, double hours)
        : Employee(n), rate_(rate), hours_(hours) {}
    double salary() const override { return rate_ * hours_; }
private:
    double rate_, hours_;
};

int main() {
    std::vector<Employee*> staff = {new Salaried("Anna", 6000),
                                    new Hourly("Ben", 30, 80),
                                    new Hourly("Cleo", 45, 20)};
    double total = 0;
    for (const Employee* e : staff) {              // one loop for all kinds
        std::cout << e->name() << ": " << e->salary() << "\n";
        total += e->salary();
    }
    std::cout << "total: " << total << "\n";
    for (Employee* e : staff) delete e;            // virtual destructor!
}
