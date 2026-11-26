#import "lib.typ": *

== How to solve exercises on inheritance and polymorphism

Three exam classics: *"which function is called?"*, *"in which order are constructors and destructors called?"* and *"design a class hierarchy"*.

#recipe("Which function is called?")[
For a call `x.f()` or `p->f()`, ask in this order:
+ *Is the call made through a pointer or a reference?* If `x` is a plain object (also a parameter *by value*), the function of its own type runs, and that is the end of it. (By value, a derived object is *sliced* to the base type.)
+ *Is `f` virtual in the static type?* (Look at the class of the *declaration* `A*`, `A&`. Once virtual in a base class, the function stays virtual in all derived classes.) If *not* virtual: the version of the *static* type runs.
+ *If virtual:* the version of the *dynamic* type runs (the most derived class that overrides it).
]

#ex("Exam-style: static or dynamic?")[
#cpp("d14_ex1", out: false)

`f` is virtual, `g` is not. `b` is a `B` in all four cases.

#step[1: `A* p = &b`.] Pointer. `f` is virtual, so the object decides: `B::f`. `g` is not virtual, so the label `A` decides: `A::g`.

#step[2: `const A& x`.] Reference: the same reasoning, `B::f A::g`.

#step[3: `A x` by value.] A *copy* of type `A` is made: the `B` part is sliced off. `x` really is an `A`, so both calls give `A::f A::g`.

#step[4: `b` itself.] Static and dynamic type are both `B`: `B::f B::g`.
#outonly("d14_ex1")
]

#recipe("Order of constructors and destructors")[
- *Construction:* first the *base class* part, then the *members* (in the order they are declared), then the body of the derived class's constructor. (From the foundation up.)
- *Destruction:* exactly the reverse: the derived destructor body, then the members, then the base class.
- `delete p` with `p` of type `Base*`: the derived destructor runs only if the destructor of `Base` is *virtual*. Otherwise only `~Base()` runs, and the derived part is never cleaned up.
]

#ex("Exam-style: what is printed?")[
#cpp("d14_ex2", out: false)

#step[Construction of `new Car`.] Base first: `Vehicle`. Then the member `e`: `Engine`. Then the body of `Car()`: `Car`.

#step[`delete v`.] `v` has the static type `Vehicle*`, but `~Vehicle` is virtual, so the destruction starts at the dynamic type `Car`: `~Car`, then the member: `~Engine`, then the base: `~Vehicle`.
#outonly("d14_ex2")
Without `virtual` before `~Vehicle()`, only `~Vehicle` would be printed (strictly speaking, the behaviour would even be undefined).
]

#recipe("Design a class hierarchy")[
+ Find what the different kinds have *in common* (data and operations). That goes into the base class.
+ Operations that exist for all kinds but *work differently* become `virtual` functions in the base class, *pure virtual* (`= 0`) if there is no sensible default.
+ Each derived class calls the base constructor in its initialiser list and overrides the virtual functions (mark them `override`).
+ Give the base class a `virtual` destructor.
+ Code that uses the hierarchy works with `Base&` or `Base*` (for example a `std::vector<Base*>`) and calls only the virtual functions. It never asks "which kind are you?".
+ Check *is-a*: is every derived object really a valid base object? If not ("has a"), use a member instead of inheritance.
]

#ex("Exam-style: employees with different pay")[
*Task.* A company has salaried employees (fixed monthly salary) and hourly workers (rate times hours). Write classes so that the payroll can be computed with a single loop over all employees.

#step[Common part.] Every employee has a name and a salary, but the salary is computed differently. So: abstract base `Employee` with `name()` and a pure virtual `salary()`.

#step[Derived classes.] `Salaried` stores the monthly amount, `Hourly` the rate and the hours. Each overrides `salary()`.

#step[Using it.] A `std::vector<Employee*>` holds all of them. The loop calls `e->salary()`, and thanks to `virtual` the right formula runs for each person.
#cpp("d14_ex3")
Ben earns $30 dot 80 = 2400$, Cleo $45 dot 20 = 900$, and the total is $6000 + 2400 + 900 = 9300$. Adding a new kind of employee (say, `Intern`) needs a new class, but *no change* to the loop.
]

#mistake[
- Forgetting `virtual` in the base class: the derived version is never called through base pointers.
- Passing polymorphic objects *by value*: slicing.
- No virtual destructor in a base class used with `delete` through base pointers.
- A typo in the overriding function (`aera()`, or a missing `const`): without `override`, this silently creates a *new* function. With `override`, the compiler reports it.
- Calling a derived-only function through a base reference (`animal.bark()`): compile error, because the static type decides what is allowed.
]
