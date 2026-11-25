#import "lib.typ": *

= Memory Management with Classes

#lec(12, [Memory management with classes], [constructors · destructors · RAII · copying objects · rule of three · dynamic arrays])

#lecture[Chapter 11 left us with a nagging worry: who calls `delete`, and when? In this chapter classes take the job over. A class that *owns* memory allocates it in its constructor and releases it in its *destructor*, and the language calls both for us at exactly the right moments. The price: we must say what *copying* such an object means. That is the famous "rule of three".]

== Lifetime of objects: constructors and destructors

Every object of class type goes through two special moments:
- its *constructor* runs when it is created,
- its *destructor* runs when it is destroyed: at the end of its scope for local variables, at `delete` for heap objects. The destructor is written `~ClassName()`, without parameters.

We can *watch* this with a class that merely reports what happens:

#cpp("dtor_demo")

Observe:
- Local objects are destroyed when their *block* ends, in the *reverse order* of creation (`b` at the closing brace of the inner block, `a` at the end of `main`).
- Calling `by_value(a)` creates a *copy* of `a` (by the *copy constructor*), which is destroyed when the function returns. Passing by `const` reference makes no copy at all.
- A heap object lives until `delete`.

#defn[RAII: resource acquisition is initialisation][A class that *owns* a resource (memory, a file, a lock) *acquires* it in the constructor and *releases* it in the destructor. Then the resource's lifetime is tied to the object's lifetime, and cleanup happens automatically, also when the function is left early by `return` or by an error.]

#intu[RAII is a hotel room with an automatic door lock: when you walk in (construct) the room is yours, and when you leave (destruct) it is released, no matter how you leave. You cannot forget to return the key.]

This is why you will rarely write `new` and `delete` in application code: `std::vector`, `std::string`, `std::map`, ... are classes of exactly this kind. In this chapter we build a simple one ourselves, to see how it works.

== The copying problem

Take a class that owns an array on the heap:

#snip("class Buffer {
public:
    Buffer(int n) : data_(new int[n]) {}     // acquire
    ~Buffer() { delete[] data_; }            // release
private:
    int* data_;
};")

If we do not write anything else, the compiler provides a *default copy constructor*, which copies the members one by one. For the pointer `data_` that means: *the address is copied, not the array*. That is a *shallow copy*:

#fg("c12_copy", [Left: after `Buffer b = a;` with the compiler's default copy, both objects point to the same array. Right: the *deep copy* allocates a new array and copies the contents.], w: 100%)

When both objects are destroyed, both destructors do `delete[] data_` on the same array:

#cpp("rt_doublefree")

(The exact message depends on the system. Typical symptoms: a crash, an error message from the memory manager, or no symptom at all and a corrupted memory somewhere else.) Even before the crash, a shallow copy is wrong: changing `b`'s data would silently change `a`'s.

== The rule of three

#rule[Rule of three][If a class needs a *destructor* of its own (because it owns a resource), then it almost certainly also needs
+ a *copy constructor* `T(const T& other)`, which creates a new object as a *deep copy* of `other`, and
+ a *copy assignment operator* `T& operator=(const T& other)`, which makes an *existing* object a deep copy of `other`, releasing what it owned before.
If you write one of the three, write all three.]

The copy constructor is called for initialisations (`IntVec w = v;`), for passing by value, and for returning by value. The assignment operator is called for `u = w;` where `u` already exists. Here is a complete example, a simple version of `std::vector<int>` that also shows how a vector grows:

#cpp("intvec")

Let us study the parts.

*The constructor* allocates room for one element. `size_` is the number of used elements, `cap_` (the *capacity*) the size of the allocated array.

*The destructor* returns the array. Done automatically at the end of the life of every `IntVec`.

*The copy constructor* allocates a *new* array of the same capacity and copies the elements (a *deep copy*).

*The assignment operator* is more subtle, because the target already owns an array:
+ Check for *self-assignment* (`this != &o`): with `u = u` we would otherwise delete the very array we want to copy from. `this` is a pointer to the object on which the member function is called.
+ Allocate and fill the new array *first*, then delete the old one, then take over the new one. (This order also leaves the object intact if the allocation fails.)
+ `return *this;` returns the object itself by reference, so that chains `a = b = c` work.

*The growth.* `push_back` needs space for one more element. If `size_ == cap_`, `grow()` allocates an array of *twice* the capacity, copies, deletes the old one. The program output shows capacities 1, 2, 4, 8, 16.

#fg("c12_growth", [Growing by doubling. The old array is released after the elements have been copied.], w: 92%)

#why("Why double rather than add one?")[If we grew by one element every time, each `push_back` would copy all elements: $n$ elements would cost about $n^2 slash 2$ copies in total. With doubling, the copies are $1 + 2 + 4 + dots + n/2 < n$ in total: on average, less than one copy per `push_back`. This is called *amortised constant time*, and is what `std::vector` does as well (hence `capacity()` there too).]

*The two `operator[]`.* The non-`const` version returns an `int&`, so that `w[0] = 100` can *write*; the `const` version is for `const IntVec`. Returning a *reference* to an element is what allows the assignment.

#hood[Since 2011 there is also the *rule of five* (move constructor and move assignment, which "steal" the memory from temporaries instead of copying it) and the *rule of zero*: a class whose members are all RAII types (`std::vector`, `std::string`) needs *none* of these special functions, since the compiler-generated ones are correct. That is the preferred style: let the library manage the memory. We only write the rule of three to understand *why* it works.]

== Disabling copying, and `this`

Sometimes copying makes no sense (a file handle, a unique resource). In that case you *forbid* it, so that the mistake cannot even be compiled:

#snip("class File {
public:
    File(const File&) = delete;              // no copy constructor
    File& operator=(const File&) = delete;   // no copy assignment
    ...
};")

Inside any member function the keyword `this` is a *pointer to the current object*. `this->size_` is the same as `size_`. We needed it above to compare addresses and to return `*this`.

#mistake[
- A destructor without copy constructor and assignment (the double delete from above).
- Forgetting `delete[]` (leak) or using `delete` instead of `delete[]` in the destructor.
- Copy assignment without the self-assignment check, or one that deletes before the copy is made.
- Pass big objects by value when `const T&` is meant: not wrong, but each call makes a complete deep copy.
]

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*Resources are not only memory.* Every open file, network connection, database transaction or lock is a resource that must be returned. The idea of this chapter, that the destructor cleans up when the object dies, is called RAII (resource acquisition is initialisation) and is the central idiom of modern C++. `std::ifstream` closes its file, `std::lock_guard` releases its lock and `std::unique_ptr` frees its memory, even when an exception is thrown in between. Leaks in long-running servers cost real money: a web server that loses a few bytes per request will be restarted every night.]

#everyday[*Why copying must be thought through.* If a class owns a resource, copying it by default copies only the pointer, so two objects point to the same memory, and when both are destroyed the memory is freed twice. The «rule of three» (destructor, copy constructor, copy assignment) in this chapter is the cure. Modern code avoids the problem by making the owning member a `std::vector` or `std::unique_ptr`; then the compiler does the right thing without any extra code.]
// ALLTAG-END

#summary[
- *Constructor* at creation, *destructor* at destruction (end of scope or `delete`). Locals are destroyed in reverse order.
- *RAII*: the object owns its resources, the destructor releases them. No manual `delete` in user code.
- The default copy of a pointer member is *shallow*: two owners, double delete. Fix: *rule of three*: destructor, copy constructor (deep copy), copy assignment (self-assignment check, free the old memory).
- Growing arrays by *doubling* the capacity gives amortised constant time for `push_back`.
- Best of all: use `std::vector` and `std::string` as members and write none of the three.
]

#problems()

#prob("When are the special functions called?", [For `class T` with all special functions printing a message: which of constructor (C), copy constructor (CC), assignment (A) and destructor (D) are called, in this order, by
```
T a;
T b = a;
T c;
c = b;
```
at the closing brace of the block, in addition?],
[`T a;` → C. `T b = a;` → CC (an initialisation, not an assignment, despite the `=`). `T c;` → C. `c = b;` → A. At the end of the block three objects are destroyed: D D D (in the order `c`, `b`, `a`).])

#prob("Find the leak", [What is wrong with this class?
```
class Name {
public:
    Name(const char* s) { text_ = new char[100]; /* copy s */ }
    void set(const char* s) { text_ = new char[100]; /* copy s */ }
private:
    char* text_;
};
```],
[(1) No destructor: the array is never released, a leak for every object. (2) `set` overwrites the pointer without deleting the old array: a leak at each call (it should `delete[] text_` first). (3) Once a destructor is added, the rule of three applies: copy constructor and assignment are needed. Better: use `std::string` as the member and nothing of this is necessary.])

#prob("Implement a Stack", [Using `std::vector<int>` as a member, write a class `Stack` with `push`, `pop` (precondition: not empty), `top` and `empty`. Do you need a destructor?],
[```
class Stack {
public:
    void push(int x) { v_.push_back(x); }
    void pop() { assert(!v_.empty()); v_.pop_back(); }
    int top() const { assert(!v_.empty()); return v_.back(); }
    bool empty() const { return v_.empty(); }
private:
    std::vector<int> v_;
};
```
No destructor, copy constructor or assignment needed (rule of zero): `std::vector` already implements the rule of three correctly, and the compiler-generated functions of `Stack` call those.])

#prob("Why the order?", [In the assignment operator, why is the new array allocated and filled *before* the old one is deleted?],
[(1) With self-assignment (if the check were forgotten), deleting first would destroy the data to be copied. (2) If `new` throws an exception because memory is exhausted, the object still holds its old, valid array instead of a dangling pointer. The principle: *do everything that can fail first, then change the object.*])
