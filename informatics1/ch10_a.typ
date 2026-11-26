#import "lib.typ": *

== The idea in plain words

=== A class is a machine with buttons

Think of a ticket machine at the train station. Inside there is money, a printer, a list of prices. You are *not* allowed to open it and take coins out or change the prices. You may only use the *buttons* on the front: choose a ticket, insert money, get change. Because nobody can touch the inside directly, the machine can guarantee its rules: it never gives out more change than it has, a ticket always costs the listed price.

A *class* is such a machine in your program:
- The *private* part is the inside: the data (*data members*). Only the class's own functions may touch it.
- The *public* part is the front: the *member functions* (the buttons) that everybody may call.
- The rules that the machine guarantees are the *invariant* (for a bank account: the balance is never negative).

=== Class and object: blueprint and house

A class is a *blueprint*. From one blueprint you can build many houses, the *objects*. Each house has its own rooms: each object has its *own* copy of all data members.

#cpp("d10_two")

#mem(("a.count_", "3"), ("b.count_", "1"), note: [Two objects, two separate boxes. `a.tick()` means: press the button `tick` *on the machine `a`*. Inside the function, `count_` refers to the box of whichever object the button was pressed on.])

=== The parts of a class, one by one

#snip("class Counter {                       // the name of the new type
public:                              // from here on: usable by everybody
    Counter() : count_(0) {}         // CONSTRUCTOR: same name as the class,
                                     //   no return type, runs at creation
    void tick() { ++count_; }        // MEMBER FUNCTION that changes the object
    int value() const { ... }        // CONST member function: only reads
private:                             // from here on: only for the class itself
    int count_;                      // DATA MEMBER (trailing _ is a convention)
};                                   // do not forget the semicolon!")

- The *constructor* is the function that runs automatically when an object is created. Its job is to give all data members a valid start value, so that the invariant holds from the first moment. `: count_(0)` is the *initialiser list*: "initialise `count_` with `0`".
- A member function marked `const` promises not to change the object. Every function that only *reads* (getters, `length()`, `contains()`) should be `const`; then it can also be called on `const` objects and through `const&` parameters.

=== Iterators are bookmarks

An iterator is like a finger pointing at one element of a container. `*it` reads the element under the finger, `++it` moves the finger to the next one. `c.begin()` puts the finger on the first element. `c.end()` is the position *just after* the last element, like the empty space on a shelf after the last book: there is no book there, but it tells you "you are done".

#mem(("begin()", "↓"), ("", "3"), ("", "1"), ("", "4"), ("end()", "↓  (no element)"), note: [`for (auto it = c.begin(); it != c.end(); ++it)` visits `3`, `1`, `4` and stops when the finger reaches `end()`.])

The point of iterators: the *same* loop works for a `vector`, a `list`, a `set` and a `map`, even though they store their elements in completely different ways. And all functions in `<algorithm>` take a pair of iterators "from here to there".
