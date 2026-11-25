#import "lib.typ": *

= Control Flow II and Functions I

#lec(4, [Control flow II, functions I], [nested loops · `break` / `continue` · `switch` · functions · parameters · call stack])

#lecture[First we finish the toolbox of control flow: loops inside loops, leaving loops early, and the `switch` statement. Then comes the most important structuring tool of programming: the *function*. With functions you split a big problem into small, named, reusable pieces.]

== Nested loops

The body of a loop may itself contain a loop. For each pass of the *outer* loop the *inner* loop runs completely from start to end. If the outer loop runs $m$ times and the inner loop $n$ times, the innermost statement is executed $m dot n$ times.

#cpp("nested")

#fg("c04_nested", [The visits of the first program: row `i` (outer loop) prints `i` stars (inner loop). The inner loop runs through completely before the outer loop moves on.], w: 62%)

#trick[Think in a grid][Outer loop = rows, inner loop = columns. To print a picture, a table, or to work through all pairs $(i, j)$, nested loops are the tool. The inner bound may depend on the outer counter (`j <= i`) and gives triangles instead of rectangles.]

#check[How often is the statement `x++;` executed in `for (int i = 0; i < 5; ++i) for (int j = i; j < 5; ++j) x++;`?][$5 + 4 + 3 + 2 + 1 = 15$ times: for `i = 0` the inner loop has 5 passes, for `i = 1` it has 4, and so on.]

== Leaving loops early: break and continue

#defn[break and continue][`break;` leaves the innermost loop (or `switch`) immediately. `continue;` skips the rest of the current pass of the loop and continues with the next one (in a `for` loop, with the update step).]

#cpp("breakcont")

Use them sparingly. They are convenient for "stop as soon as I found it" (search loops), but a loop that can be left from many places is hard to understand. Often a well-chosen loop condition says the same thing more clearly.

#mistake[In nested loops `break` leaves only the *innermost* loop, not all of them.]

== The switch statement

If you compare *one* integer-like value (`int`, `char`, `enum`) with many constants, a chain of `else if` gets long. `switch` is the cleaner form:

#cpp("calc")

The value of `op` is compared with each `case` label, and execution *jumps* to the matching label. It then continues *downwards through all further cases*, unless a `break` stops it. This "fall-through" is the classic source of bugs: if you forget a `break`, the following case is executed too. `default` catches everything else.

#mistake[Missing `break` in a `case`. And `switch` works only for integer-like values, never for `double` or strings.]

== Designing loops: invariants and termination

Two questions help you to get a loop right.

#defn[Loop invariant][A *loop invariant* is a statement about the variables that is true before the loop, and stays true after every pass. Together with the negated loop condition, it tells you what holds after the loop.]

Look at Euclid's algorithm for the greatest common divisor, one of the oldest algorithms known (about 300 BC). The invariant is: "$gcd(a, b)$ is the same as the gcd of the two *original* numbers". Because $gcd(a, b) = gcd(b, a mod b)$, replacing $(a, b)$ by $(b, a mod b)$ preserves it. When `b` is zero, $gcd(a, 0) = a$ is the answer.

#cpp("gcd_loop")

*Termination:* `b` becomes the remainder of a division by `b`, so it is non-negative and strictly smaller than before. A non-negative integer cannot decrease forever, so the loop stops.

#intu[An invariant is a *promise that survives the loop*. If you cannot say what your loop preserves, you probably do not yet understand why it works.]

== Functions

#idea[So far everything was written in `main`. A *function* is a named piece of program that takes *inputs* (parameters), computes something and gives back a *result* (return value). You already know functions from mathematics: $f(x) = x^2$. And you have already used one: `main`.]

Why functions?
- *Reuse*: write once, call anywhere ("is this number prime?").
- *Structure*: a long program becomes a short list of calls with *names* that explain what happens.
- *Testing*: a small function can be tested on its own.
- *Abstraction*: the caller needs to know *what* the function does, not *how*.

#fg("c04_anatomy", [Anatomy of a function definition and a call.], w: 100%)

#cpp("func1")

The *definition* consists of the *return type*, the *name*, the *parameter list* (types and names; these names are the *formal parameters*) and the *body* in braces. A *call* `max(3, x)` supplies *arguments* (actual values) for the parameters. Then:

#rule[What happens at a call][
+ The arguments are evaluated.
+ Space for the function's parameters and local variables is created, and the argument values are *copied* into the parameters.
+ The body is executed up to a `return` statement (or the closing brace).
+ The returned value replaces the call expression, and the caller continues.
]

A function with return type `void` returns nothing; it is called for its *effect* (printing, ...). The `return` statement of a non-`void` function must be reached on every path; the compiler often warns if not.

=== Declaration and definition

C++ reads the file from top to bottom, so a function must be *known* before it is used. Either define it above `main`, or give a *declaration* (prototype), the header without body, followed by `;`, and define the function later:

#cpp("proto")

This function also demonstrates two ideas: `return` ends the function at once (an early exit is perfectly good style), and the loop condition `d * d <= n` is a classic improvement: if $n$ has a divisor at all, it has one that is at most $sqrt(n)$.

=== Scope, local variables and call by value

Variables declared in a function (and its parameters) are *local*: they exist only during the call, and another function cannot see them. In particular, *a parameter is a copy* of the argument. This is called *call by value*.

#cpp("byvalue")

Changing `x` inside `increment` changes the copy only. If you want the *caller's* variable to change, you need *references* (Chapter 6). If you only want a result, `return` it: `a = increment(a);`.

=== The call stack

Where do the local variables of all active calls live? On the *call stack*: a region of memory that works like a stack of plates. Every call puts a new *frame* (parameters, local variables, where to return to) on top. When the function returns, its frame is removed.

#fg("c04_stack", [The stack while executing `main` → `f(5)` → `g(5)`. Each call has its own variables: the `y` in `g` and the `x` in `f` are different places even if they hold the same value.], w: 100%)

#hood[Frames are why functions can call themselves (Chapter 7): every call gets its own frame with its own variables. And it is why a function's local variables are *gone* after the return: the frame has been discarded. Returning a pointer or reference to a local variable (Chapters 6, 11) is therefore a serious bug.]

#recipe[Writing a function][
  + Write down the *signature* first: name, parameter types, return type. "What goes in, what comes out?"
  + Add a comment that states the *purpose*, one sentence.
  + Write the body. Keep it short: a function should do *one* thing.
  + Test it on its own with a few calls in `main`.]

#everyday[Even the biggest systems consist of functions, each of which fits on a screen. Typical rules of thumb are: a function has a clear name (`is_prime`, not `check`), has at most a few parameters, and fits on one screen. A name that describes the result (`square`, `is_prime`) is easier to read than a name that describes the how (`do_loop`).]

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*Assertions at NASA.* Gerard Holzmann of NASA's Jet Propulsion Laboratory proposed «ten rules» for code in space missions. They include: keep functions short enough to fit on one printed page, give every loop a fixed upper bound, and write on average at least two `assert`s per function. A function states what it expects (precondition) and what it promises (postcondition), and the program checks this while running. In ordinary desktop programs assertions are switched off in release builds; in your exercises they are the quickest way to find out which function broke the contract.]

#everyday[*The standard library as a toolbox.* `<cmath>`, `<algorithm>` and `<string>` contain functions that thousands of experts have tested for decades. Writing your own `sqrt` or `sort` is a good exercise, but in production code you almost always call the library one. Part of the profession is knowing what already exists and what to call it.]
// ALLTAG-END

#summary[
- Nested loops: the inner loop runs fully for each pass of the outer loop. `break` leaves the innermost loop; `continue` skips to the next pass. `switch` selects by value; do not forget `break`.
- A loop *invariant* is true before and after each pass; with a termination argument it proves the loop correct (Euclid's algorithm).
- A *function* has return type, name, parameters and body; it is *declared* before use and may be *defined* later.
- Parameters are *copies* of the arguments (call by value). Local variables live in a *stack frame* that disappears at return.
]

#problems()

#prob("Triangle", [Write a function `void triangle(int n)` that prints a right triangle of `n` rows where row `i` consists of `i` copies of the digit `i`. For `n = 4` the output is
```
1
22
333
4444
```],
[```
void triangle(int n) {
    for (int i = 1; i <= n; ++i) {
        for (int j = 0; j < i; ++j) std::cout << i;
        std::cout << "\n";
    }
}
```
Outer loop over the rows, inner loop prints `i` times the digit `i`, then a line break.])

#prob("Function trace", [What is printed?
```
int f(int x) { return 2 * x + 1; }
int g(int x) { x = f(x) + 1; return x * x; }
int main() {
    int x = 2;
    std::cout << g(x) << " " << x;
}
```],
[`g(2)`: the parameter `x` is a copy, `f(2) = 5`, so inside `g` the copy becomes $5 + 1 = 6$ and the result is $36$. The variable `x` in `main` is untouched: it is still 2. Output: `36 2`.])

#prob("Count by loop and by switch", [Write a program that reads characters (`char`) until a full stop `.` is read and counts how many vowels (a, e, i, o, u, lower case) were read.],
[```
char c;
int vowels = 0;
std::cin >> c;
while (c != '.') {
    switch (c) {
        case 'a': case 'e': case 'i': case 'o': case 'u':
            ++vowels;
    }
    std::cin >> c;
}
std::cout << vowels;
```
The labels stacked on top of each other share the same statement: the intended use of fall-through. Note that `std::cin >> c` skips whitespace.])

#prob("Greatest common divisor as a function", [Write `int gcd(int a, int b)` using Euclid's algorithm, and use it to write `bool coprime(int a, int b)`. Trace `gcd(48, 18)`.],
[```
int gcd(int a, int b) {
    while (b != 0) {
        int r = a % b; a = b; b = r;
    }
    return a;
}
bool coprime(int a, int b) { return gcd(a, b) == 1; }
```
Trace: $(48, 18) -> (18, 12) -> (12, 6) -> (6, 0)$, so `gcd(48, 18) = 6`.])

#prob("Why does this not work?", [`void swap(int a, int b) { int t = a; a = b; b = t; }` is called as `swap(x, y);` but `x` and `y` keep their values. Why?],
[Because of call by value: `a` and `b` are copies of `x` and `y`. The function swaps the copies, which disappear at the return. To swap the caller's variables the parameters need to be references: `void swap(int& a, int& b)` (Chapter 6).])
