#import "lib.typ": *

= Subtyping, Polymorphism and Inheritance

#lec(14, [Subtyping, polymorphism and inheritance], [`class B : public A` · `protected` · `virtual` · `override` · abstract classes · slicing · virtual destructor])

#lecture[The final chapter completes the picture of object-oriented programming. *Inheritance* lets a new class reuse and extend an existing one. *Subtyping* says that an object of the derived class can be used wherever the base class is expected. And *polymorphism* ("many forms") makes the program do the right thing for the *actual* kind of object at run time. Together they allow code like "compute the total area of all shapes" that works for shapes that did not even exist when the code was written.]

#include "ch14_a.typ"

== Inheritance

#idea[Dogs, cats and fish are all animals: they have a name, they eat, they have an age. Writing these features three times would be wasteful and error-prone. With *inheritance* you write them once in a *base class* (`Animal`) and let *derived classes* (`Dog`, ...) take them over and add their own.]

#cpp("inherit1")

#defn[Inheritance][In `class Dog : public Animal`, the class `Dog` is *derived from* the *base class* `Animal`. A `Dog` object *contains* an `Animal` part, so it has all members of `Animal` and the new members of `Dog`. We say: a `Dog` *is an* `Animal`.]

The example shows the rules:
- *Construction order:* the base part is constructed first (`Animal(Rex)`), then the derived part (`Dog()`). The derived constructor passes arguments to the base constructor in the initialiser list: `: Animal(name)`.
- *Destruction order:* the reverse (`~Dog()`, then `~Animal`).
- *Access:* `public` members are visible to everybody, `private` ones only inside the class itself, even *not* in derived classes. A new third level, `protected`, makes members visible inside the class and its derived classes, but not to outsiders.
- `public` inheritance (the one we always use) keeps the interface: the public members of `Animal` are public in `Dog`, too.

#why("Is-a versus has-a")[Inheritance models *is a*: a dog *is an* animal. For *has a* use a *member*: a car *has an* engine, so `class Car { Engine engine_; ... }`, not `class Car : public Engine`. Wrong inheritance is a classical design error: ask "can I use a derived object everywhere a base object is expected, and everything still makes sense?" If not, do not inherit.]

== Subtyping

Because a `Dog` *is an* `Animal`, a `Dog` can be used wherever an `Animal` is expected: a function `void feed(const Animal& a)` accepts a `Dog`; a pointer `Animal*` may point to a `Dog`. This is *subtyping*: `Dog` is a *subtype* of `Animal`.

#snip("Dog d(\"Rex\");
Animal& a = d;        // fine: reference to the Animal part of d
Animal* p = &d;       // fine: pointer to a Dog as pointer to Animal
a.eat();              // fine
// a.bark();          // error: the declared type of a is Animal, and Animal has no bark()")

Two types now play a role:
- the *static type* of an expression is the type in the declaration (`Animal&`): known to the compiler, decides what you are *allowed* to write;
- the *dynamic type* is the type of the object that is actually there (`Dog`): known only at run time.

#remember[The conversion goes in one direction only. *Up* (derived to base) is automatic and safe. *Down* (base to derived) is not allowed implicitly: not every `Animal` is a `Dog`.]

== Polymorphism and virtual functions

Suppose `Shape` has an `area()` and `Circle` has its own version. Which one is called through a `Shape&`?

#cpp("novirtual")

The answer for an ordinary member function: the one of the *static* type (`Shape`), which is useless here. We want "the area of the *actual* shape". For this you declare the function `virtual` in the base class:

#cpp("virtual1")

What to see:
- `describe(const Shape&)` is written *once* and works for circles, rectangles and squares, and for any shape that somebody defines in the future. At *run time*, the call `s.area()` is dispatched to the version belonging to the *dynamic* type. This is *polymorphism* (*dynamic binding*).
- `virtual double area() const = 0;` is a *pure virtual* function: it has no implementation. A class with at least one pure virtual function is *abstract*: it cannot be instantiated, and serves as an *interface* ("every shape can say its area"). Derived classes must override all pure virtual functions to be instantiable.
- `override` after the declaration tells the compiler "I intend to override a virtual function". If you misspell the name or get the parameters wrong, you get an *error* instead of silently creating a new function. Always use it.
- `Square` derives from `Rectangle`, overrides only `name` and inherits `area`.
- A `std::vector<Shape*>` can hold different kinds of shapes, and the loop `total += s->area()` calls the right function for each.

#err("err_abstract")

=== How does it work?

#hood[If a class has virtual functions, each object carries a hidden pointer, the `vptr`, to a table of function addresses, the *vtable* of its class. A virtual call looks into the table of the object's *own* class, and jumps to the function found there. The cost is one extra pointer per object and one extra indirection per call: small, but not zero. That is why functions are not virtual by default in C++.]

#fg("c14_vtable", [A virtual call. The compiler does not know which function runs: the object itself carries the information.], w: 96%)

#fg("c14_hierarchy", [The class hierarchy of our shapes ("is a" arrows).], w: 80%)

== Virtual destructors

There is a trap with polymorphism and `delete`. Consider `Base* p = new Derived; delete p;`. If the destructor is *not* virtual, the static type `Base*` decides: only `~Base` runs, the derived part is never destroyed (its destructor does not run, so what it owns leaks), and formally the behaviour is undefined. With a *virtual destructor*:

#cpp("vdtor")

#rule[Virtual destructor][A class that is meant to be a base class for polymorphic use (it has virtual functions) must have a *virtual destructor*. Otherwise deleting a derived object through a base pointer is undefined behaviour.]

== Slicing

Pass a derived object by *value* to a function expecting the base class, and the copy is made *as a base object*: the derived part is cut off.

#cpp("slicing")

#fg("c14_slicing", [Slicing: only the `Shape` part is copied. The copy is a plain `Shape` and its `area()` is the base version.], w: 78%)

Polymorphism only works through *pointers or references*. That is why `describe` takes a `const Shape&`. So: pass objects of polymorphic classes by (const) reference or pointer, never by value.

== When is inheritance a good idea? Subtype principle

The question that decides whether the derived class is a legitimate subtype: *can every use of the base class be replaced by the derived class without anything breaking?* (This is the *Liskov substitution principle*.)

A classical trap is "a `Square` is a `Rectangle`, mathematically". Suppose `Rectangle` has `set_width(w)` and `set_height(h)` that change one side only. A `Square` must keep its sides equal, so `set_width` would have to change the height too. Code that works on a `Rectangle&` and relies on "setting the width does not change the height" now breaks for squares. In our example the shapes are *immutable* (no setters), so the subtype relation is harmless. With mutable objects the "is a" of mathematics is not the "is a" of programs. Prefer *small interfaces* (like `Shape`: `area`, `name`), and use inheritance mostly to implement such interfaces.

#everyday[Graphical user interfaces are the classical use: `Button`, `Slider`, `TextBox` all derive from `Widget` with a virtual `draw()` and `on_click()`; the window loops over its list of `Widget*` and calls `draw()`. Games: `Enemy` with many kinds. Standard library: streams (`std::ostream` is the base of `std::cout` and of file streams, so that `operator<<` for `Rational` of Chapter 9 works with all of them).]

#include "ch14_b.typ"

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*Game entities.* In a typical game there is a base class `Entity` with a virtual function `update()` and `draw()`. Player, Enemy, Bullet and Tree each derive from it and override these. The game loop holds a list of `Entity*` and calls `update()` for each, without knowing whether it deals with a player or a tree: the virtual call selects the correct code at runtime. New kinds of objects can be added without changing the loop, which is the point of polymorphism.]

#everyday[*«Everything is a file».* On Linux and macOS, a file on the disk, a USB stick, a network connection and the keyboard all offer the same operations (`open`, `read`, `write`, `close`). Programs use these without caring what is behind them. Internally the operating system calls different code for each device, which is a polymorphic interface in the plain C of the kernel. The same idea lets you save a document to a local disk or to the cloud with the same code, only the object behind the interface differs.]

#everyday[*What polymorphism costs.* A virtual function call goes through a table of function addresses (the vtable) and costs a few nanoseconds more than a normal call. For almost all programs this is irrelevant, but in the inner loop of a physics simulation with billions of calls professionals avoid virtual functions. Good engineering is knowing where the cost matters.]
// ALLTAG-END

#summary[
- A *derived class* contains its base part: all base members plus its own. Constructors run base first; destructors the reverse. `protected` is visible in derived classes.
- *Subtyping*: a derived object can be used where the base type is expected (references, pointers). The *static type* is what the code declares; the *dynamic type* is what the object really is.
- `virtual` functions are dispatched by the *dynamic type* (*polymorphism*). Mark overrides with `override`. `= 0` makes a function *pure virtual* and the class *abstract* (an interface).
- Polymorphic base classes need a *virtual destructor*. Never pass polymorphic objects by value (*slicing*).
- Use inheritance for real *is-a* relations that respect substitutability; use members for *has-a*.
]

#problems()

#prob("Construction order", [Given `class A { A() {print "A"} ~A() {print "~A"} }`, `class B : public A` (prints `B`, `~B`) and `class C : public B` (prints `C`, `~C`), what is printed by `{ C c; }`?],
[Construction runs from the base to the derived class: `A B C`. Destruction in reverse: `~C ~B ~A`.])

#prob("Static or dynamic?", [Given `class A { public: virtual void f() { cout << "A"; } void g() { cout << "A"; } };`, `class B : public A { public: void f() override { cout << "B"; } void g() { cout << "B"; } };` and `B b; A& r = b;`, what do `r.f()`, `r.g()`, `b.f()` and `b.g()` print?],
[`r.f()`: `f` is virtual, the dynamic type is `B`: *B*. `r.g()`: `g` is not virtual, the static type `A` decides: *A*. `b.f()`: *B*. `b.g()`: *B*. Output sequence: `B A B B`.])

#prob("Design", [Design a hierarchy for bank accounts: `Account` with `balance()` and a virtual `monthly_fee()`, and the derived `SavingsAccount` (fee 0) and `CheckingAccount` (fee 5). Write a function that sums the fees of a `std::vector<Account*>`.],
[```
class Account {
public:
    Account(double b) : balance_(b) {}
    virtual ~Account() {}
    double balance() const { return balance_; }
    virtual double monthly_fee() const = 0;
protected:
    double balance_;
};
class SavingsAccount : public Account {
public:
    SavingsAccount(double b) : Account(b) {}
    double monthly_fee() const override { return 0; }
};
class CheckingAccount : public Account {
public:
    CheckingAccount(double b) : Account(b) {}
    double monthly_fee() const override { return 5; }
};
double total_fees(const std::vector<Account*>& v) {
    double s = 0;
    for (const Account* a : v) s += a->monthly_fee();   // dynamic dispatch
    return s;
}
```])

#prob("What is wrong?", [Find the problem: `class Base { public: ~Base() {} virtual void f() {} };` and `class Derived : public Base { int* p_ = new int[10]; public: ~Derived() { delete[] p_; } };` with `Base* b = new Derived; delete b;`.],
[The destructor of `Base` is not virtual, although the class has a virtual function. `delete b` calls only `~Base`; `~Derived` does not run, so the array `p_` leaks (and the behaviour is undefined by the standard). Fix: `virtual ~Base() {}`.])

#prob("Is-a?", [A colleague writes `class Stack : public std::vector<int>` so that `Stack` gets `push_back` and `[]` for free. Why is this questionable?],
[A stack is *not* a vector in the sense of substitutability: users of `Stack` could insert in the middle or access arbitrary elements, which violates the stack discipline (LIFO). The relation is *has-a* (implemented by a vector): keep a `std::vector<int>` as a private member (as in Problem 12.3) and offer only `push`, `pop`, `top`. In addition, `std::vector` has no virtual destructor and is not designed as a base class.])
