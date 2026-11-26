#include <iostream>

class A {
public:
    virtual void f() const { std::cout << "A::f "; }
    void g() const         { std::cout << "A::g "; }
    virtual ~A() {}
};

class B : public A {
public:
    void f() const override { std::cout << "B::f "; }
    void g() const          { std::cout << "B::g "; }
};

void by_ref(const A& x)  { x.f(); x.g(); }
void by_val(A x)         { x.f(); x.g(); }

int main() {
    B b;
    A* p = &b;
    p->f(); p->g();          // 1: pointer of type A* to a B
    std::cout << "| ";
    by_ref(b);               // 2: reference of type A& to a B
    std::cout << "| ";
    by_val(b);               // 3: a copy of type A (sliced)
    std::cout << "| ";
    b.f(); b.g();            // 4: the object itself, type B
    std::cout << "\n";
}
