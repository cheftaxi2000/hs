#import "lib.typ": *

= Recursion II and Custom Data Types

#lec(9, [Recursion II, custom data types], [backtracking · divide and conquer · memoization · `struct` · operator overloading · `enum`])

#lecture[The first half deepens recursion: three powerful patterns (trying all possibilities, splitting a problem in halves, remembering results) with the exercises *all permutations*, *binary search*, *merge sort* and the *$n$ queens problem*. The second half is about *types*: with `struct` you create your own data types, bundling values that belong together, and with operator overloading you make them as pleasant to use as `int`.]

== Recursion pattern 1: trying all possibilities

Some problems ask for *all* arrangements of something. Recursion handles them elegantly: *choose* the first element, then solve the same problem for the rest.

#ex("All permutations of a word")[Goal: print all orderings of the letters of `abc`. Idea: the first letter of a permutation is `a`, `b` or `c`. After choosing it, what remains is the problem "all permutations of the other two letters". The function carries two strings: the *prefix* chosen so far, and the *rest* still to be placed.

#cpp("perm")

#fg("c09_perm", [The recursion tree for `abc`: each level fixes one more letter. Base case: nothing left, so the prefix is complete.], w: 92%)

For $n$ letters there are $n! = n dot (n-1) dot dots dot 1$ permutations. For 10 letters that is already 3.6 million, for 20 letters more than the number of seconds since the Big Bang: this kind of solution only works for small $n$.]

=== Backtracking: the n queens problem

Place $n$ queens on an $n times n$ chessboard such that no two attack each other (no common row, column or diagonal). Trying all placements would be hopeless, but we can *abandon a branch as soon as it fails*: place one queen per row, try each column, *check whether it is safe*, go on with the next row if it is, and otherwise *backtrack* to the previous row and try the next column.

#cpp("queens")

#fg("c09_queens", [One of the 92 solutions for $n = 8$, as column per row.], w: 42%)

#recipe[Backtracking][
  + A partial solution is extended one *decision* at a time (a row, a letter, ...).
  + For each decision, try every candidate. If it violates a constraint, skip it (*prune*).
  + If it is allowed, make it, and call yourself for the next decision.
  + When no decision is left, you have a complete solution: count or print it.
  + After the recursive call returns, *undo* the decision if necessary (here it is simply overwritten by the next candidate).]

== Recursion pattern 2: divide and conquer

Instead of reducing the problem by one element ($n arrow.r n-1$), cut it in *half*. Each step halves the problem, so after $log_2 n$ steps only a trivial one is left. That is *much* faster than going one by one.

=== Binary search

To find an element in a *sorted* vector, look at the middle. If it is the one you search, you are done; if it is smaller than the middle element, continue in the lower half, otherwise in the upper half (like looking up a word in a dictionary, or guessing a number between 1 and 100 with "higher / lower" hints).

#cpp("binsearch")

Each call halves the interval `[lo, hi)`, so for $n$ elements at most about $log_2 n$ calls are needed: 20 steps for a million elements, 30 for a billion. The linear search needs up to a million, resp. a billion steps.

#remember[Binary search has two requirements: the data must be *sorted*, and you have to be able to access the middle element directly (vector yes, linked list no, Chapter 11). The midpoint is computed as `lo + (hi - lo) / 2`, which avoids overflow (Problem 5.5).]

=== Fast exponentiation

Computing $x^n$ by $n$ multiplications (Problem 7.4) is wasteful. Observe: $x^n = (x^(n/2))^2$ for even $n$ and $x^n = x dot (x^((n-1)/2))^2$ for odd $n$.

#cpp("fastpow")

For $n = 10^6$ only 27 multiplications are needed instead of a million. Note that `power(x, n / 2)` is called *once* and its result stored in `h`: writing `power(x, n/2) * power(x, n/2)` would compute it twice and destroy the whole gain.

=== Merge sort

Selection sort (Chapter 6) needs about $n^2$ steps. *Merge sort* needs about $n log_2 n$: for a million elements that is 20 million instead of a trillion steps. The idea: split the vector in halves, sort each half recursively, then *merge* the two sorted halves into one sorted vector by repeatedly taking the smaller of the two front elements.

#fg("c09_merge", [Merge sort on eight numbers: split down to single elements (which are trivially sorted), then merge back up.], w: 86%)

#cpp("mergesort")

#hood[Why is it $n log_2 n$? There are $log_2 n$ levels of splitting, and on each level the merge steps touch each of the $n$ elements once. Compare with $n^2$: for $n = 10^6$ the difference is the one between an instant and a coffee break. The standard library function `std::sort` (Chapter 10) is a similar algorithm.]

== Recursion pattern 3: remembering results (memoization)

Chapter 7 showed that the naive recursive Fibonacci recomputes the same values over and over. The remedy is simple: store each result in a table after computing it, and look it up before computing.

#cpp("memo")

With memoization each `fib(k)` is computed only once, so only about $2n$ calls are needed instead of exponentially many (`fib(90)` would never finish with the naive version). This idea, solving each sub-problem once and storing the result, is the key idea of *dynamic programming*.

=== Mutual recursion and recursion vs. loops

Two functions can call each other (*mutual recursion*): `is_even(n)` returns `is_odd(n - 1)` and `is_odd(n)` returns `is_even(n - 1)`. The C++ rule applies: the function must be *declared* before the first use (Chapter 4). Every recursion can be written as a loop (possibly with an explicit stack), and every loop as a recursion. Use whatever is clearer; recursion shines for trees, backtracking and divide and conquer.

== Custom data types: struct

#idea[Real-world things consist of several values that belong together: a point has an $x$ and a $y$, a student a name, a number and grades. With `struct` you define a *new type* that bundles such values, the *members*. It is then a type like `int`: you can have variables of it, pass it to functions, return it from functions, put it in vectors.]

#cpp("point")

#fg("c09_struct", [A `Point` variable occupies the memory of its members, one after another.], w: 80%)

Notes:
- The definition `struct Point { double x; double y; };` (do not forget the semicolon at the end!) creates a *type*, no variable yet.
- Access members with a dot: `p.x`. Initialise with braces, in the order of the members: `Point a = {0, 0};`.
- Assigning a struct copies *all* members. Passing it by value copies it too, so use `const Point&` for big structs, as before.

#why("Why bundle?")[A function `distance(Point, Point)` has two parameters instead of four, and it is impossible to mix up the $x$ of one point with the $y$ of another. A program that speaks of points, rationals and weekdays is closer to the problem domain than one that only knows `double`.]

=== Operator overloading

The notation `a + b` is more readable than `add(a, b)`. C++ lets you define the operators for your own types: a function called `operator+`, `operator==`, `operator<<`, ... Here we define fractions:

#cpp("rational")

- `operator+` is an ordinary function whose name is `operator+`. The expression `a + b` is translated into the call `operator+(a, b)`.
- The invariant "the denominator is positive and the fraction is cancelled" is maintained by the operators: after every operation the result is shortened by the gcd.
- `operator<<` makes `std::cout << r` work for `Rational`. It receives the output stream by reference and returns it, so that chains `std::cout << a << " + " << b` work.
- `Rational{1, k * (k + 1)}` creates a temporary `Rational`.

The sum is the telescoping series $sum_(k=1)^(10) 1/(k(k+1)) = 1 - 1/11 = 10/11$. With `double` we would have got $0.909090909...$ with a rounding error, here we get the *exact* result.

#mistake[
- Forgetting the semicolon after the closing brace of a `struct`.
- Overloading operators with a *surprising* meaning (`+` that subtracts). Overload an operator only if its meaning is obvious.
- Rational overflow: `a.n * b.d` can exceed the range of `int` for big values. A real implementation checks this or uses larger types.
]

== Enumerations

If a variable can take one of a small number of *named* values (weekdays, directions, states of a machine), do not encode them as `0, 1, 2` (nobody remembers what `3` meant). An *enumeration type* gives them names:

#cpp("enum")

`enum class` values are written `Weekday::Fri`; they are *not* implicitly numbers, so `static_cast<int>` is needed to get the index, and you cannot accidentally compare a `Weekday` with a `Colour`. The `% 7` in `next` makes the days cycle (remainder, Chapter 2). Enumerations pair naturally with `switch` (Chapter 4).

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*Backtracking: Sudoku, scheduling, route planning.* A Sudoku solver, a timetable generator, a robot looking for a way through a maze: all use the same recursive idea. Try a choice, recurse, and if it fails, undo the choice and try the next one. This is the structure of the Eight Queens problem in this chapter. Real planning programs add clever tricks to cut off bad branches early, but the skeleton is the recursion you have written.]

#everyday[*Divide and conquer.* Merge sort splits the list in half, sorts each half recursively and merges: $n log n$ steps instead of $n^2$. For one million elements that is about $2 dot 10^7$ steps instead of $10^(12)$. Python's built-in `sort` (Timsort) is a refined merge sort, and the same split-and-combine idea is behind the fast Fourier transform (audio, mobile phone signals) and parallel computing: each processor gets one half.]

#everyday[*Structs are records.* One row in a database table, one line of a CSV file, one measurement from a GPS receiver (time, latitude, longitude, height): everything with several fields that belong together is a `struct`. Defining your own type, instead of using five loose variables, is the first step to readable code, and it is how data is passed between all parts of a program.]
// ALLTAG-END

#summary[
- Recursion patterns: *try all possibilities* (permutations, backtracking with pruning), *divide and conquer* (binary search $log n$, fast power, merge sort $n log n$), *memoization* (store sub-results).
- `struct` bundles values into a new type; members via `.`; copying copies all members.
- *Operator overloading*: `operator+`, `operator==`, `operator<<` give your types natural notation.
- `enum class` names a small set of values.
]

#problems()

#prob("Count the calls", [How many times is `merge` called by `merge_sort` for a vector with 8 elements? For 16?],
[Each call with at least 2 elements makes exactly one `merge` call. With 8 elements there are $4 + 2 + 1 = 7$ merges (4 merges of 1+1, 2 of 2+2, 1 of 4+4), generally $n - 1$ merges. For 16 elements: 15.])

#prob("Subsets", [Write a recursive function that prints all subsets of the set $\{1, ..., n\}$. For $n = 3$ there are 8 subsets.],
[Decision for each element: in or out.
```
void subsets(std::vector<int>& chosen, int k, int n) {
    if (k > n) {                                   // all elements decided
        for (int x : chosen) std::cout << x << " ";
        std::cout << "\n";
        return;
    }
    subsets(chosen, k + 1, n);                     // k is not in the subset
    chosen.push_back(k);
    subsets(chosen, k + 1, n);                     // k is in the subset
    chosen.pop_back();                             // undo (backtracking)
}
```
Called as `subsets(c, 1, 3)` with an empty vector `c`. There are $2^n$ leaves in the recursion tree.])

#prob("Complex numbers", [Define `struct Complex { double re, im; };` and the operators `+`, `*` and `<<`. ($(a + b i)(c + d i) = (a c - b d) + (a d + b c) i$.)],
[```
struct Complex { double re; double im; };
Complex operator+(Complex a, Complex b) { return {a.re + b.re, a.im + b.im}; }
Complex operator*(Complex a, Complex b) {
    return {a.re * b.re - a.im * b.im, a.re * b.im + a.im * b.re};
}
std::ostream& operator<<(std::ostream& o, Complex z) {
    return o << z.re << " + " << z.im << "i";
}
```
Test: $i dot i$ = `Complex{0,1} * Complex{0,1}` gives $-1 + 0 i$.])

#prob("Search steps", [How many comparisons does binary search need at most to find an element in a sorted vector of 1000 elements? Of 1 000 000?],
[Each step halves the interval: $2^10 = 1024 > 1000$ so at most 10 (+1 for the last check) steps; $2^20 > 10^6$, so about 20. The number of steps is $ceil(log_2 (n+1))$.])

#prob("Memoize", [The sequence $a_0 = 1$, $a_n = a_(n-1) + a_(n-2) + a_(n-3)$ (for $n >= 3$; $a_1 = a_2 = 1$) is computed recursively. How would you avoid the exponential number of calls?],
[Store computed values in a `std::vector<long> memo(n + 1, -1)`. At the start of `a(n, memo)`: return the base value for $n <= 2$; if `memo[n] != -1` return it; otherwise compute `memo[n] = a(n-1) + a(n-2) + a(n-3)` and return it. Each index is computed once: $O(n)$ calls. (Or: a loop that keeps the last three values.)])
