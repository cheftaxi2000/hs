#import "lib.typ": *

== How to solve exercises on memory management with classes

Typical tasks: *"which special functions are called, in which order?"*, *"implement the rule of three for this class"*, and *"find the memory bug"*.

#recipe("Which special functions are called?")[
+ Number the lines of `main`. For each line, use the table above: new object from nothing, new object as a copy, assignment to an existing object, or nothing.
+ Parameters *by value* are new objects (copy constructor), and they are destroyed when the function returns (destructor).
+ At every closing brace, list the local objects of that block and destroy them in *reverse* order of creation.
]

#ex("Exam-style: what is printed?")[
#cpp("d12_ex1", out: false)

#step[Line 1.] `T a;`: new object from nothing: `ctor`.

#step[Line 2.] `T b = a;`: new object as a copy: `copy`. (The `=` here is *not* an assignment.)

#step[Line 3.] `b = a;`: `b` already exists: `assign`.

#step[Line 4.] `by_value(a)`: the parameter `x` is a new copy: `copy`. At the end of `by_value`, `x` is destroyed: `dtor`.

#step[Line 5.] `by_ref(a)`: a reference, no new object: nothing.

#step[Line 6.] `|` is printed, then at the end of `main` the locals are destroyed in reverse order, first `b`, then `a`: `dtor dtor`.
#outonly("d12_ex1")
]

#recipe("Write the rule of three for a class with a pointer member")[
For a class with members `int n_; int* data_;` (an array of `n_` ints on the heap):
- *Destructor:* `~T() { delete[] data_; }`
- *Copy constructor:* initialise `n_` from the other object, get *new* memory, copy the elements one by one.
- *Copy assignment:* the four steps, in this order:
  + if `this == &o` (self-assignment `a = a`), return immediately;
  + get new memory and copy the elements of `o` into it;
  + `delete[]` the *old* memory;
  + store the new pointer and the new size; `return *this;`.
- Allocating *before* deleting means that if `new` fails (out of memory), the object is still in its old, valid state.
]

#ex("Exam-style: an array class with the rule of three")[
#cpp("d12_array")
#step[Check the result.] `b` is a deep copy, so `b[0] = 100` does not change `a[0]`, which is still `1`. `c` started with size `1`; the assignment gave back its old one-element array and gave it a copy of `a`'s three elements; `c[2] = 300` again does not change `a[2]`. All three objects are destroyed at the end of `main`, each returning *its own* array: no double free.
]

#recipe("Find the memory bug in a class")[
Check these points:
+ Is there a `new` in the constructor, but no `delete` in the destructor? *Leak.*
+ `new[]` with `delete` (without `[]`), or the other way round? *Undefined behaviour.*
+ Is there a destructor that deletes, but no copy constructor and no assignment? *Shallow copies, double free.*
+ Does the assignment operator forget to `delete[]` the old memory? *Leak.* Does it delete *before* copying, without a self-assignment check? *`a = a` destroys the data.*
+ Does a function return a pointer or reference to a *local* object? *Dangling.*
]

#trick[The best rule is the rule of zero][If the data member is a `std::vector` (or `std::string`, or any other standard container) instead of a raw pointer, the container already does the deep copy and the cleanup correctly. Then you need *none* of the three special functions:
#cpp("d12_rule0")
In real code, prefer this. In exams, you have to be able to write the rule of three by hand, because it shows that you understand what the containers do for you.]
