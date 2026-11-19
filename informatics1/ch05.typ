#import "lib.typ": *

= Functions II

#lec(5, [Functions II], [specifications · `assert` · testing · stepwise refinement · overloading · numerical functions])

#lecture[Chapter 4 showed *how* to write a function. This chapter is about writing *good* functions: how to say precisely what a function promises (specifications), how to let the machine check these promises (`assert`), how to build a program top-down from small functions (stepwise refinement), and a few more language features (overloading, default arguments).]

== Specifying a function: pre- and postconditions

A function is a contract between its caller and its author. The contract has two halves:

#defn[Precondition and postcondition][The *precondition* states what must be true *when the function is called* (a duty of the caller). The *postcondition* states what is true *when the function returns* (a duty of the function), provided that the precondition held.]

Example: `int divide(int a, int b)` with the precondition $b != 0$ and the postcondition "returns $a/b$ rounded towards zero". If somebody calls `divide(1, 0)`, then the *caller* broke the contract; the function owes nothing. If the precondition holds but the result is wrong, the *function* is at fault. This clear distribution of blame is the point of the whole idea.

We write these in a comment above the function:

#snip("// pre:  n >= 0
// post: returns n! = 1 * 2 * ... * n  (and 0! = 1)
int factorial(int n);")

#intu[Think of a function as a vending machine. Precondition: you insert the right coin. Postcondition: you get your drink. If you put in a button instead of a coin, the machine owes you nothing.]

#remember[Write the specification (what goes in, what comes out) *before* the body. If you cannot formulate the postcondition, you do not yet know what the function should do.]

== Assertions

Comments can lie, and nobody reads them while the program runs. An *assertion* turns a precondition into code. `assert(condition);` from the library `<cassert>` does nothing if the condition is true, and *stops the program with a message* if it is false.

#cpp("rt_assert")

The output shows the first call working and the second one stopping the program, with the file, line, function and the failed condition: exactly the information you need to find the bug.

#hood[Assertions are for *programmer errors* (violated preconditions, impossible states), not for errors you expect to happen at runtime, like a user entering a wrong number. For those you check and react (e.g. ask again). A production build can disable all assertions with the compiler option `-DNDEBUG`; then they cost nothing.]

== Testing

How do you know that a function is correct? You *test* it: call it with inputs for which you know the answer, and check the result automatically. `assert` is a good tool for this.

#cpp("tests")

Good tests cover:
- *typical* cases (`gcd(12, 18)`),
- *edge cases* (zero, one, equal arguments, the smallest and the largest allowed value),
- the *symmetry* or other properties you expect (`gcd(a, b) == gcd(b, a)`).

#mistake[Testing proves the presence of bugs, never their absence. "It worked for my example" is not a proof. But a function with a suite of tests that are re-run after each change lets you modify code without fear.]

== Stepwise refinement

How to attack a larger problem? *Top-down*: write the solution as a few big steps in plain words; then refine each step into smaller ones, until each step is a few lines of C++ or a call of a function you already have. Each refined step often becomes a function.

*Problem:* print the prime factorisation of $n$, e.g. $360 = 2 dot 2 dot 2 dot 3 dot 3 dot 5$.

#fg("c05_refine", [Top-down design. Level 0 is the problem, level 1 describes the solution in big steps, level 2 refines the one step that is not obvious.], w: 92%)

#cpp("factor")

The code mirrors the design: `print_factors` reads almost like the plan, and `smallest_factor` encapsulates the only tricky part. If `smallest_factor` returns something composite there would be a bug, but it cannot: the smallest divisor greater than 1 is always prime. (Why? A composite divisor would have a smaller divisor, which also divides $n$.)

#trick[Look at `smallest_factor`][The loop stops either when a divisor is found or when `d * d > n`. After the loop we have to find out which one happened. Such "which exit did I take" questions are best answered right after the loop, as the code does.]

== Overloading and default arguments

C++ allows several functions with the *same name* if their parameter types differ: *overloading*. The compiler chooses the version that fits the arguments.

#cpp("overload")

The call `square(3)` matches the `int` version exactly, `square(1.5)` the `double` version. The return type alone is *not* enough to distinguish two overloads. A call that fits several versions equally well is rejected as *ambiguous*.

A *default argument* (here `exponent = 2`) is used if the caller omits that argument. Default arguments must be the *last* parameters.

#everyday[You have been using overloading all the time: `std::cout << 5` and `std::cout << "text"` call different versions of `operator<<`. Overloading is a convenience: the same *idea* (print, square, compare) has the same name for different types.]

== Global variables and constants

A variable declared *outside* of every function is *global*. It lives as long as the program and is visible in all functions below its declaration.

#snip("const double pi = 3.14159265358979;   // a global CONSTANT: fine
int counter = 0;                           // a global VARIABLE: dangerous

void tick() { ++counter; }                 // changes state invisibly to the caller")

Global *constants* are good: they give magic numbers a name. Global *variables* are bad: every function can change them, so you can no longer understand a function by reading its text alone; the result of a call depends on invisible state. Rule: pass what a function needs as *parameters* and return what it computes.

== Numerical functions: a worked example

Mathematical functions live in `<cmath>` (`std::sqrt`, `std::pow`, `std::sin`, `std::fabs`, ...). To see how such a function can be built, we compute $sqrt(x)$ with *Newton's method*, the idea of repeatedly "improving a guess". If $y$ is too big, then $x / y$ is too small, and their average is closer to $sqrt(x)$.

#fg("c05_newton", [Newton's method for $y^2 - 2 = 0$. The tangent at the current guess crosses the axis at the next, better guess. The error roughly *squares* in each step.], w: 66%)

#cpp("newton")

Observe the details learned in Chapter 3: the loop *does not compare* with `==` but checks whether $y^2$ is close enough to $x$ (a tolerance, scaled with $x$ so that it works for big and small numbers). The specification is also honest: it promises an *approximation*, not the exact value.

#ex("Trace Newton for x = 2")[
#trace(("step", "y", "y*y"), ("start", "2", "4"), ("1", "1.5", "2.25"), ("2", "1.41666...", "2.00694"), ("3", "1.41421568...", "2.0000060"), ("4", "1.41421356237...", "2.0000000000"))
The number of correct digits roughly doubles with every step: 0, 1, 3, 6, 12 digits. That is why a handful of passes suffices.]

== Evaluation order and side effects

C++ does *not* specify in which order the arguments of a function call, or the operands of most operators, are evaluated. So `f(i++, i++)` or `a[i] = i++` are traps: different compilers may give different results (or the program may have undefined behaviour). Rule: do not use a variable in the same expression where you also change it with `++` or `=`. One change per expression, and it is the last thing.

#summary[
- A function is a contract: *precondition* (caller's duty), *postcondition* (function's duty). Write them as comments, check preconditions with `assert`.
- Test with typical and edge cases; re-run tests after each change.
- Stepwise refinement: plan in big steps, refine until each step is simple; each step may become a function.
- *Overloading*: same name, different parameter types. *Default arguments* go last.
- Global constants are fine, global variables are not.
- Numerical code: tolerances instead of `==`; the specification says "approximately".
]

#problems()

#prob("Write a specification", [Give pre- and postconditions for `int max3(int a, int b, int c)` and for `bool is_leap(int year)`.],
[`max3`: pre: none (any integers). Post: the result is one of `a`, `b`, `c` and is greater than or equal to each of them. `is_leap`: pre: `year >= 1` (Gregorian calendar, say). Post: returns `true` iff `year` is divisible by 4 and not by 100, or divisible by 400.])

#prob("Tests", [Write assertion-based tests for `int digit_sum(int n)` (sum of decimal digits of $n >= 0$), including edge cases, and implement the function so that they pass.],
[```
assert(digit_sum(0) == 0);          // edge: zero
assert(digit_sum(7) == 7);          // single digit
assert(digit_sum(472) == 13);       // typical
assert(digit_sum(1000) == 1);       // zeros inside
assert(digit_sum(2147483647) == 46);// largest int

int digit_sum(int n) {              // pre: n >= 0
    int s = 0;
    while (n > 0) { s += n % 10; n /= 10; }
    return s;
}
```])

#prob("Overload resolution", [Given `void f(int x)` and `void f(double x)`, what do `f(2)`, `f(2.0)`, `f(2 + 0.5)` and `f('a')` call?],
[`f(2)`: `int` version. `f(2.0)`: `double` version. `f(2 + 0.5)`: the expression has type `double`, so the `double` version. `f('a')`: a `char` is promoted to `int` (a cheap conversion), so the `int` version is chosen.])

#prob("Refine", [Plan, top-down, a program that reads a positive integer $n$ and prints the first $n$ prime numbers. Write down the functions you would use, then implement them.],
[Level 1: read `n`; count = 0; candidate = 2; while count < n: if `is_prime(candidate)` print it and ++count; ++candidate. Level 2: `is_prime(k)` from Chapter 4.
```
int count = 0;
for (int k = 2; count < n; ++k) {
    if (is_prime(k)) { std::cout << k << " "; ++count; }
}
```
Note that the loop condition counts primes, not candidates: the number of passes is not known in advance.])

#prob("The unsafe function", [A colleague's function `int mid(int a, int b) { return (a + b) / 2; }` is used on values near `INT_MAX`. What goes wrong and how can you fix it?],
[`a + b` can exceed `INT_MAX` and overflow (undefined behaviour; typically a negative number). Fix: `a + (b - a) / 2`, which never exceeds the range for $a <= b$. (This overflow bug was present for years in binary-search implementations of standard libraries.)])
