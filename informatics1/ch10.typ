#import "lib.typ": *

= Information Hiding, Iterators and Containers

#lec(10, [Information hiding, iterators and containers], [`class` · `private` / `public` · constructors · invariants · iterators · `set`, `map`, `list` · `<algorithm>`])

#lecture[Two ideas that make large programs manageable. *Information hiding*: a type decides what is visible from outside and keeps its data private, so that nobody can break it. *Containers and iterators*: the standard library already offers ready-made, well-tested data structures and algorithms; you only have to learn how to use them.]

#include "ch10_a.typ"

== Classes and information hiding

#idea[In Chapter 9 a `Rational` was a `struct` whose members `n` and `d` anybody could change. Somebody can write `r.d = 0` and the program contains an invalid fraction that nobody notices until something crashes much later. The cure is *information hiding* (also: *encapsulation*): the data is *private*, and the type offers a few *public* operations, the *interface*, that keep the data consistent.]

#fg("c10_hiding", [Left: all parts of the program may modify the data directly, so every part must be checked when something is wrong. Right: only the member functions have access, so only they have to be checked.], w: 90%)

A `class` is like a `struct`, but with access control and with *member functions*:

#cpp("account")

Let us go through the new elements:
- `public:` and `private:` sections. *What is public is the contract* (the interface), what is private is the implementation, free to change. In a `class` everything is private by default (in a `struct` everything is public by default; that is the only difference).
- *Member functions* (`deposit`, `withdraw`, `balance`) are called with a dot, on an *object*: `a.deposit(50)`. Inside them, the members (`balance_`) are visible directly.
- The *constructor* has the name of the class and no return type. It is called automatically when an object is created (`Account a(100);`) and *initialises* the members, here in the *initialiser list* `: balance_(initial)`.
- `const` after the parameter list (`int balance() const`) promises that the function does not change the object. Such functions can also be called on `const` objects, and for a `const Account&` parameter, only they can.

The compiler enforces the privacy:

#err("err_private")

#defn[Class invariant][A *class invariant* is a condition on the private data that holds for every object *between* calls of its member functions. The constructor *establishes* it, every public member function *preserves* it. Here: `balance_ >= 0`.]

Because the data is private, *the invariant cannot be broken from outside*. To check that it always holds, you only have to read the constructor and the member functions, not the whole program. That is the point of information hiding.

#why("Why not just trust everybody?")[Programs get big, and other programmers (and you in a year) will use your type. A promise written down in the type, and enforced by the compiler, is worth more than a comment saying "please don't touch `balance` directly". Moreover, if the data is private, you can change the *implementation* (for example, store the balance in cents instead of in francs) without changing a single line outside of the class.]

=== The Rational type as a class

Here is the `Rational` of Chapter 9 as a class. The constructor makes sure that the denominator is positive and the fraction is cancelled, so the *invariant* is guaranteed for *every* object.

#cpp("rational_class")

Observe:
- `Rational(int n = 0, int d = 1)` has default arguments. So `Rational(5)` is the fraction $5/1$, and an `int` can be *implicitly converted* to a `Rational`; that is why `a * 2` works.
- The constructor *normalises*: `Rational(6, -8)` becomes $-3/4$.
- The operators are *member functions* here (`a + b` means `a.operator+(b)`), `const` because they do not change `a`. `operator<<` cannot be a member (the stream is on the left); it uses the public getters instead.
- `static int gcd(...)` is a *static* member function: it belongs to the class, not to an object, and is a private helper.

#mistake[
- Making everything public "for convenience". Start private, make public only what is part of the contract.
- Adding a getter *and* a setter for every member: that is a `struct` in disguise. Offer operations that make sense (`withdraw`), not raw data access.
- Forgetting `const` on member functions that do not modify the object.
]

== Containers

#idea[Almost every program needs to store collections of values. Writing such data structures yourself is error-prone, so the C++ standard library provides *containers*. They differ in how they store the data, and therefore in what they can do fast. You have used `std::vector`; now you meet the other important ones.]

#fg("c10_containers", [Four containers and what they are good for.], w: 96%)

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Container*], [*Typical use*],
  [`std::vector<T>`], [the default. Indexing `v[i]`, fast appending at the end.],
  [`std::list<T>`], [insertion and removal in the middle without moving all other elements. No indexing.],
  [`std::set<T>`], [a collection *without duplicates*, kept *sorted*. Fast membership test (`count`, `find`).],
  [`std::map<K, V>`], [*dictionary*: a value for each key, e.g. name → age, word → count. Sorted by key.])

#cpp("containers")

The `map` is the container that gets a lot of use. `age["Alice"]` finds the entry with this key, or *creates* one with a default value (0 for `int`). Each entry of the map is a pair, with members `first` (the key) and `second` (the value): `it->first`, `it->second`.

#ex("Counting words")[Task: read a text and count how often each word occurs. With a `map<string, int>` it is five lines:
#cpp("wordcount")
`while (std::cin >> w)` is true as long as reading a word succeeded; it stops at the end of the input. `++count[w]` creates the entry if necessary (with 0) and increments it. The map prints in alphabetical order for free.]

#hood[A `vector` keeps its elements in one block of memory; a `list` consists of nodes linked by pointers (Chapter 11), a `set` and `map` are organised as balanced *search trees* (Chapter 13). That explains the table: tree-based containers find an element in about $log_2 n$ steps, a `vector` has to look at all $n$ (unless it is sorted and we use binary search), a `list` has no random access at all.]

== Iterators

How do you visit all elements of a `set` or a `list`? There is no index `s[3]`. The common solution of all containers is the *iterator*, a kind of generalised pointer ("arrow") that points to one element of a container.

#fg("c10_iter", [An iterator `it` points to an element. `begin()` points to the first, `end()` to the position *behind* the last element (not an element itself).], w: 88%)

The basic operations of an iterator `it`:
- `*it`: the element it points to (can be read and written),
- `++it`: move to the next element,
- `it == jt`, `it != jt`: compare positions.

#cpp("iter_vec")

The loop `for (auto it = c.begin(); it != c.end(); ++it)` works *for every container* and is exactly what the range-based `for (x : c)` of Chapter 6 does behind the scenes. Note: *the end is excluded*, `it != c.end()`, the same half-open convention as for indices. And note the keyword `auto`: the compiler works out the (long) type itself.

#trick[Use `it->member` for iterators to structs][For an iterator over a container of structs or pairs, `it->first` is short for `(*it).first`.]

#mistake[
- Dereferencing `end()`: `*v.end()` is as wrong as `v[v.size()]`.
- Using an iterator after the container was changed: `push_back` may move the elements to new memory, and then the old iterators *dangle*.
- Comparing iterators of *different* containers.
]

== Algorithms

The header `<algorithm>` contains functions that work on *ranges* given by two iterators `[begin, end)`. They work with any container, and they are carefully optimised and tested: use them instead of your own loops.

#cpp("algos")

The most useful ones:

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Function*], [*Effect*],
  [`std::sort(b, e)`], [sort ascending (about $n log n$ steps); a third argument gives another order],
  [`std::find(b, e, x)`], [iterator to the first `x`, or `e` if not found],
  [`std::count(b, e, x)`], [how many elements equal `x`],
  [`std::min_element(b, e)`, `std::max_element(b, e)`], [iterator to the smallest / largest],
  [`std::reverse(b, e)`], [reverse the order],
  [`std::accumulate(b, e, init)`], [sum of the elements, starting from `init` (in `<numeric>`)],
  [`std::binary_search(b, e, x)`], [is `x` in the *sorted* range? ($log n$)])

The bracket expression `[](int x) { return x % 2 == 1; }` in `count_if` is a *lambda*, a small nameless function written on the spot ("count the elements for which this function returns true"). You will mostly just copy this pattern.

#everyday[Professional C++ code is full of these algorithms and containers. A programmer who knows the standard library writes a third of the code and has a third of the bugs. Whenever you are about to write a loop that searches, counts, sorts or accumulates, ask: *is there a standard algorithm for it?*]

#include "ch10_b.typ"

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*Hiding the details: the bank account.* A class `Account` with a private balance and public `deposit` and `withdraw` functions can enforce rules that no outside code can bypass: the balance never becomes negative, every change is logged. The data is protected because only the class code touches it. Later, the bank can change how the balance is stored (a new database, a faster structure) without a single line of the calling code changing. This is the whole point of information hiding, and it is why large systems with millions of lines remain changeable.]

#everyday[*Choose the container for the question you ask.* `std::vector` if you mostly walk through all elements, `std::map` or `std::unordered_map` if you mostly look things up by key (a phone book, a dictionary of words, the stock price by ticker), `std::set` if you only care whether something is present. The same iterator interface works for all of them, so `std::sort`, `std::find` and `std::count` work with any container. Picking the right one often makes a program a thousand times faster.]
// ALLTAG-END

#summary[
- A `class` has `private` data and `public` member functions. *Information hiding* means: outsiders can only use the interface, so a *class invariant* can be guaranteed by constructor and member functions alone.
- *Constructors* initialise objects (initialiser list); `const` member functions promise not to modify the object.
- Containers: `vector` (default), `list`, `set` (sorted, unique), `map` (key → value).
- *Iterators* point into containers: `*it`, `++it`, `begin()`, `end()` (one past the last). The same loop works for all containers.
- `<algorithm>`: `sort`, `find`, `count`, `reverse`, `min_element`, ... take ranges `[begin, end)`.
]

#problems()

#prob("Design a class", [Design a class `Counter` that counts events. It should have a constructor setting the counter to 0, a member function `increment()`, a `const` member function `value()`, and `reset()`. What would be the invariant?],
[```
class Counter {
public:
    Counter() : n_(0) {}
    void increment() { ++n_; }
    void reset() { n_ = 0; }
    int value() const { return n_; }
private:
    int n_;                // invariant: n_ >= 0 (up to overflow)
};
```
Nobody can set the counter to a negative number or decrement it from outside.])

#prob("Where is the invariant?", [A class `Interval` stores `lo_` and `hi_` with the invariant `lo_ <= hi_`. Why is it a bad idea to add `set_lo(int x)` as a public member function that just assigns `lo_ = x`? How can you fix it?],
[`set_lo(10)` on `[1, 5]` would produce `[10, 5]` and break the invariant. Fixes: the function checks `x <= hi_` (precondition with `assert` or return `false`), or `lo_` is simply not settable and a new `Interval` is constructed instead (the constructor checks `lo <= hi`).])

#prob("Choose the container", [Which container would you use for (a) the sorted list of distinct words in a text, (b) the number of occurrences of each letter, (c) a queue of customers where people leave from the middle, (d) measurement values read in order, later accessed by index?],
[(a) `std::set<std::string>`. (b) `std::map<char, int>` (or a `vector<int>(26)` indexed by `c - 'a'`, the array trick of Chapter 6, which is faster). (c) `std::list`. (d) `std::vector`.])

#prob("Use algorithms", [Given `std::vector<int> v`, write one line each for: the number of elements equal to 0; whether 42 occurs; sorting in descending order; the sum of the elements.],
[```
int zeros = std::count(v.begin(), v.end(), 0);
bool has42 = std::find(v.begin(), v.end(), 42) != v.end();
std::sort(v.begin(), v.end(), std::greater<int>());
int sum = std::accumulate(v.begin(), v.end(), 0);
```])

#prob("Iterator bug", [What is wrong with this loop that should remove all zeros from a `std::vector<int> v`?
```
for (auto it = v.begin(); it != v.end(); ++it)
    if (*it == 0) v.erase(it);
```],
[`erase` changes the vector (elements move up), so `it` is *invalidated*: using it afterwards (`++it`) is undefined behaviour. Besides, even if it worked, the element that moves into the freed place would be skipped. The correct idiom: `v.erase(std::remove(v.begin(), v.end(), 0), v.end());` (the remove-erase idiom), or collect the non-zero elements in a new vector.])
