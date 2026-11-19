#include <iostream>
#include <string>

class Animal {
public:
    Animal(const std::string& name) : name_(name) { std::cout << "Animal(" << name_ << ") "; }
    ~Animal() { std::cout << "~Animal(" << name_ << ") "; }
    std::string name() const { return name_; }
    void eat() const { std::cout << name_ << " eats\n"; }
protected:
    std::string name_;                     // visible in derived classes, but not to outsiders
};

class Dog : public Animal {                // a Dog IS AN Animal
public:
    Dog(const std::string& name) : Animal(name) { std::cout << "Dog() "; }   // base part first
    ~Dog() { std::cout << "~Dog() "; }
    void bark() const { std::cout << name_ << " says Woof\n"; }              // extra feature
};

int main() {
    {
        Dog d("Rex");
        std::cout << "\n";
        d.eat();            // inherited from Animal
        d.bark();
        std::cout << "leaving the block: ";
    }
    std::cout << "\n";
    return 0;
}
