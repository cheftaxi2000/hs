#import "lib.typ": *

= Reference Types and Vectors

#lec(6, [Reference types, vectors], [references · call by reference · `const` · `std::vector` · 2D data · out-of-range])

#lecture[Two big steps. First, *references*: a second name for an existing variable, which lets a function change the caller's data and avoids needless copying. Second, the `std::vector`: a growing row of values of the same type. With vectors, a program can handle *as many* values as the input contains, not just as many as we have declared variables for.]

#include "ch06_a.typ"

== References

#defn[Reference][A *reference* is an *alias*, a second name, for an existing variable. It is declared with `&` after the type: `int& r = a;`. From then on `r` and `a` denote *the same* memory cell. A reference must be initialised and always stays bound to the same variable.]

#fg("c06_ref", [`r` is a second name for `a`; `c` is an independent copy.], w: 86%)

#cpp("ref_basic")

The expression `&a` (the *address* of `a`, Chapter 11) is used here only to show that `a` and `r` are at the same place in memory, but `c` is not.

=== Call by reference

References solve the problem from Chapter 4: with a reference parameter, the function works on the caller's variable instead of on a copy.

#cpp("swap_ref")

The parameters `a` and `b` are *aliases* of `x` and `y`. Changing them changes `x` and `y`. Compare with Problem 4.5: the only difference is the `&`.

#table(columns: (auto, 1fr, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Parameter*], [*Meaning*], [*Use for*],
  [`int x`], [*call by value*: a copy], [small types you only read (`int`, `double`, `bool`, `char`)],
  [`int& x`], [*call by reference*: an alias; the function may change the argument], [results through parameters, `swap`, big objects you modify],
  [`const T& x`], [alias, but the function must not change it], [big objects (vectors, strings) you only read: no copy])

#hood[Why const references? Copying a vector with a million elements takes a million steps. A reference copies nothing: it is just a second name. With `const` you additionally promise not to change the argument, and the compiler verifies this. For small types a copy is as cheap as a reference, so pass them by value.]

#mistake[
- A non-`const` reference parameter cannot be bound to a *literal* or a temporary result: `swap(x, 3)` and `increment(a + 1)` are errors, since `3` and `a + 1` are not variables. A `const` reference may.
- Never return a reference to a *local* variable: the variable dies at the end of the function (Chapter 4), the reference *dangles*.
- Do not forget the `&`: `void swap(int a, int b)` compiles, runs and silently does nothing.
]

== Vectors

#idea[A variable holds one value. For 100 values you do not want 100 variables. A `std::vector<T>` is a sequence of elements of type `T`, stored one after another in memory, that can be accessed by *index* and can *grow*. It lives in the library `<vector>`. The `T` in angle brackets is the *element type*: `std::vector<int>`, `std::vector<double>`, `std::vector<bool>`, ...]

#fg("c06_vec", [A vector of four `int`s. Elements are numbered starting from 0. The `size()` is the number of elements.], w: 90%)

#cpp("vec_basic")

The most important operations:

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Expression*], [*Meaning*],
  [`std::vector<int> v;`], [empty vector],
  [`std::vector<int> v(n);`], [$n$ elements, all `0` (for `int`)],
  [`std::vector<int> v(n, x);`], [$n$ elements, all equal to `x`],
  [`std::vector<int> v = {1, 2, 3};`], [elements listed explicitly],
  [`v.size()`], [number of elements],
  [`v.empty()`], [`true` if there are none],
  [`v[i]`], [element number `i` (valid: $0 <= i < $ `v.size()`); can be read and written],
  [`v.push_back(x)`], [append `x` at the end; the vector grows by one],
  [`v.pop_back()`], [remove the last element],
  [`v.back()`, `v.front()`], [last / first element],
  [`v.clear()`], [remove all elements])

#trick[Reading $n$ values][First read $n$, create `std::vector<double> a(n);`, then read each `a[i]` in a loop. If the number is unknown, use `push_back` in a loop (reading until the input ends).]

#cpp("vec_stats")

=== Indices and the range-based for loop

Two ways to visit each element:

#snip("for (int i = 0; i < v.size(); ++i) { ... v[i] ... }   // you need the index
for (int x : v)                    { ... x ...    }   // only the values (a copy of each)
for (int& x : v)                   { x *= 2; }          // alias: modifies the elements
for (const int& x : v)             { ... }             // no copies, no changes")

#mistake[
*Out-of-range access.* `v[5]` for a vector with 3 elements compiles, and the program reads some memory that is not part of the vector: garbage, a crash, or, worst of all, silently wrong results. The size is `v.size()`, and the *last valid index is `v.size() - 1`*. An off-by-one error here is among the most frequent bugs in all of programming (and a classical source of security problems).

The checked version `v.at(i)` stops the program with an error message when the index is invalid, which is wonderful for finding bugs:

#cpp("rt_oob")
]

#mistake[Mixing signed and unsigned: `v.size()` is an *unsigned* number. In `for (int i = v.size() - 1; i >= 0; --i)` it works because `i` is an `int`, but `v.size() - 1` is a huge number when the vector is empty (`0u - 1`, see Chapter 2). Check `v.empty()` first.]

=== Vectors as parameters

#cpp("vec_pass")

The by-value version works on a copy and does not change the caller's vector, the reference version does. `sum` takes a `const` reference: no copy, no modification. This is the standard idiom for vector parameters: *`const std::vector<T>&` to read, `std::vector<T>&` to modify*.

== Algorithms on vectors

*Searching:* a loop over all indices; stop when you have found the element (`return i;`), or after the loop report "not found".

*Sorting:* put the elements in order. The idea of *selection sort*: find the smallest element and swap it to the front; then find the smallest of the rest, and so on.

#cpp("selsort")

#ex("Trace selection sort for {5, 2, 9, 1}")[
#trace(("i", "vector before", "m (min position)", "vector after swap"),
  ("0", "5 2 9 1", "3", "1 2 9 5"), ("1", "1 2 9 5", "1", "1 2 9 5"), ("2", "1 2 9 5", "3", "1 2 5 9"))
The first $i$ elements are always final and sorted: this is the *loop invariant* (Chapter 4). The inner loop looks at $n - 1$, $n - 2$, ... elements, in total about $n^2 slash 2$ comparisons. For large vectors there are much faster methods (Chapter 9).]

#why("Why swap with a temporary variable?")[`v[i] = v[m]; v[m] = v[i];` would overwrite the first value before it could be copied into the second place. The temporary `t` keeps it safe.]

=== The sieve of Eratosthenes

How to find *all* primes up to $n$ quickly? Write down the numbers $2, ..., n$. Take the first number not crossed out (it is prime), and cross out all its multiples. Repeat. Numbers that survive are prime. It suffices to go on up to $sqrt(n)$, because every composite number has a prime factor of at most $sqrt(n)$.

#fg("c06_sieve", [The sieve for $n = 49$. Each composite number is shown in the colour of its smallest prime factor, the one that crossed it out first.], w: 96%)

#cpp("sieve")

The vector `prime` stores one `bool` per number: "index = the number" is a very common trick. Crossing out starts at $p^2$ because smaller multiples have already been crossed out by smaller primes.

== Vectors of vectors

An element of a vector may itself be a vector: `std::vector<std::vector<int>>` is a table (a *matrix*) with rows of equal or different length. `t[i][j]` is element `j` of row `i`.

#cpp("pascal")

#everyday[Almost all data in engineering is a vector or a table: measurements over time, pixels in an image (a matrix of colour values), coordinates of the nodes in a simulation, a matrix in a system of equations. The loops of this and the last chapters are what process them.]

#include "ch06_b.typ"

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*Why you pass big things by reference.* A 4K image has $3840 times 2160$ pixels with $3$ bytes each, about $25$ MB. If a function takes it by value, it copies $25$ MB each call; with `const Image&` it passes an address of $8$ bytes, about three million times less. Every professional C++ API passes large objects by reference for this reason, and `const` makes sure the function does not change them. In video processing, with $60$ frames per second, this decides whether the program keeps up or not.]

#everyday[*`std::vector`: the default container.* Sensor measurements over time, the pixels of a row, the particles of a simulation: whenever the data is a sequence, professionals first reach for `std::vector`. It stores its elements in one block of memory, which is what processors like best: in many measurements a vector beats fancier structures simply because the hardware loads neighbouring elements together. Rule of thumb in industry: use `vector` unless you can prove you need something else.]
// ALLTAG-END

#summary[
- A *reference* `T&` is a second name for a variable. *Call by reference* lets a function modify its arguments; `const T&` avoids copies for read-only access.
- `std::vector<T>`: a growable sequence with `size()`, `push_back`, `[i]`. Indices run from 0 to `size() - 1`; going outside is a bug that the compiler does not catch (use `at()` to find it).
- Pass vectors by (const) reference. Range-based `for` visits all elements.
- Standard algorithms by hand: sum, maximum, search, selection sort, sieve; tables as vectors of vectors.
]

#problems()

#prob("Reference or copy?", [What is printed?
```
void f(int a, int& b) { a += 1; b += 1; }
int main() {
    int x = 10, y = 10;
    f(x, y);
    f(y, x);
    std::cout << x << " " << y;
}
```],
[First call: `a` is a copy of `x`, `b` is an alias of `y`: `y` becomes 11, `x` stays 10. Second call `f(y, x)`: `a` is a copy of `y` (11), `b` is an alias of `x`: `x` becomes 11. Output: `11 11`.])

#prob("Reverse in place", [Write `void reverse(std::vector<int>& v)` that reverses the order of the elements *without* using a second vector.],
[```
void reverse(std::vector<int>& v) {
    for (int i = 0; i < v.size() / 2; ++i) {
        int t = v[i];
        v[i] = v[v.size() - 1 - i];
        v[v.size() - 1 - i] = t;
    }
}
```
Swap the first with the last, the second with the second to last, and so on. Only half of the elements are visited as starting point: going further would swap everything back. Check the cases of 0, 1, 2 and 3 elements: for an odd size the middle one stays.])

#prob("Remove duplicates", [Given a sorted vector, write a function that returns a new vector with every value only once.],
[```
std::vector<int> unique_values(const std::vector<int>& v) {
    std::vector<int> r;
    for (int x : v) {
        if (r.empty() || r.back() != x) r.push_back(x);
    }
    return r;
}
```
Because the input is sorted, equal values are neighbours: it suffices to compare with the last element already stored. Input `{1, 1, 2, 3, 3, 3}` gives `{1, 2, 3}`.])

#prob("Find the bug", [This function should return the index of the largest element. What goes wrong for a vector with one element and what for an empty vector?
```
int argmax(const std::vector<int>& v) {
    int m = 0;
    for (int i = 1; i <= v.size(); ++i)
        if (v[i] > v[m]) m = i;
    return m;
}
```],
[The loop condition must be `i < v.size()`: with `<=`, `v[v.size()]` is read, i.e. one element *behind* the end (out-of-range access), for any vector, including a one-element vector. For an empty vector, `v[0]` does not exist either: the precondition `!v.empty()` is missing and should be checked with `assert`.])

#prob("Matrix transpose", [Write a function that takes a matrix `const std::vector<std::vector<double>>& a` with $m$ rows and $n$ columns and returns its transpose with $n$ rows and $m$ columns.],
[```
std::vector<std::vector<double>> transpose(const std::vector<std::vector<double>>& a) {
    int m = a.size(), n = a[0].size();               // pre: m >= 1
    std::vector<std::vector<double>> t(n, std::vector<double>(m));
    for (int i = 0; i < m; ++i)
        for (int j = 0; j < n; ++j)
            t[j][i] = a[i][j];
    return t;
}
```
The element in row `i`, column `j` goes to row `j`, column `i`.])
