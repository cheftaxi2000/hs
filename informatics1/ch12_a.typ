#import "lib.typ": *

== The idea in plain words

=== An object's life: moving in and moving out

Every object has a beginning and an end. When it is created, its *constructor* runs, like moving into a flat: you unpack, connect the electricity, put your name on the door. When it is destroyed, its *destructor* runs, like moving out: you return the keys and clean up. You never call the destructor yourself. C++ calls it automatically:
- for a local variable, at the closing brace `}` of its block;
- for a heap object, at `delete p;`.

Local objects are destroyed in *reverse* order of creation, like a stack of plates: the last plate you put on is the first you take off.

=== Owning something on the heap: the key to a locker

Suppose a class keeps its data on the heap (Chapter 11). Then the object itself only holds a *pointer*, a key to a locker in the storage room. The constructor rents the locker (`new`), the destructor gives it back (`delete`). That is RAII: the locker belongs to the object, and it is returned *automatically* when the object dies.

#memtab(("stack", "a.n_", "3"), ("stack", "a.data_", "5000"), ("5000 (heap)", "", "1  2  3"))

=== The copying problem: two people with one key

What happens when we copy such an object, `IntArray b = a;`? If we do not say anything, C++ copies every member, *including the pointer*. So `b.data_` also contains `5000`. Two objects, *one* locker:

#memtab(("stack", "a.data_", "5000"), ("stack", "b.data_", "5000"), ("5000 (heap)", "", "1  2  3"))

This is called a *shallow copy*, and it has two bad consequences:
+ `b[0] = 100` also changes `a[0]`, because it is the same locker. Copying was supposed to give an independent object.
+ At the end, `b` moves out and returns the locker. Then `a` moves out and tries to return the *same* locker again: *double free*. The program crashes (or worse, does not crash and silently corrupts memory).

The cure is a *deep copy*: the copy rents its *own* locker and copies the *contents* into it.

#memtab(("stack", "a.data_", "5000"), ("stack", "b.data_", "6000"), ("5000 (heap)", "", "1  2  3"), ("6000 (heap)", "", "1  2  3"))

Now each object has its own locker, changes do not interfere, and each returns only its own locker. Writing this deep copy is the job of the *copy constructor* and the *copy assignment operator*: together with the destructor, these are the *rule of three*.

=== Which special function runs when?

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), inset: (y: 5pt),
  [*Code*], [*What is called*],
  [`T a;` or `T a(5);`], [a constructor (a *new* object from nothing)],
  [`T b = a;` or `T b(a);`], [*copy constructor* (a *new* object as a copy)],
  [`f(a)` with `void f(T x)`], [*copy constructor* (the parameter is a new object)],
  [`f(a)` with `void f(const T& x)`], [nothing: no new object],
  [`b = a;` where `b` already exists], [*copy assignment* `operator=`],
  [end of the block `}`], [*destructor* of every local object, in reverse order],
  [`delete p;`], [*destructor* of `*p`])

#remember[The `=` sign alone does not tell you which function runs. Ask: *is a new object being created on this line?* If yes (there is a type in front: `T b = a;`), it is the copy constructor. If no (`b = a;` for an existing `b`), it is the assignment.]
