#import "lib.typ": *

= Control Flow I

#lec(3, [Control flow I], [`if` · blocks and scope · `while` · `for` · `do`-`while` · floating-point pitfalls])

#lecture[So far a program was a straight line: statement after statement. Real programs *decide* ("is the input valid?") and *repeat* ("do this for every digit"). These two abilities, selection and iteration, together with variables, are all you need to express every algorithm there is. The chapter ends with a warning about decimals: `double` is not the real numbers.]

== Selection: if and else

#idea[`if` lets the program choose between alternatives depending on a *condition*, which is an expression of type `bool`.]

#snip("if (condition) {
    // executed if the condition is true
} else {
    // executed if it is false (this part is optional)
}")

#fg("c03_if", [Flow chart of `if (n % 2 == 0) ... else ...`. Exactly one of the two branches is executed, then both paths join again.], w: 72%)

Several alternatives are written as a chain of `else if`. The conditions are tested from top to bottom, and the *first* one that is true wins; the rest is skipped.

#cpp("ifelse")

Because the conditions are tested in order, the second condition `points >= 75` is only reached when `points >= 90` was false. So you do not need to write `points >= 75 && points < 90`.

#hood[A condition of type `int` is also accepted: `0` counts as `false`, every other value as `true`. So `if (n)` means `if (n != 0)`. It works, but `if (n != 0)` says what you mean.]

#mistake[
- *`=` instead of `==`.* `if (a = 5)` assigns 5 to `a`, and the condition is then always true. Compilers warn about it (`-Wall`): read the warnings.
- *Semicolon after the condition.* `if (n > 0);` makes the `if` statement empty; the following block is executed always.
- *Missing braces.* Without braces only the *next single statement* belongs to the `if`. The indentation can lie:
```
if (n > 0)
    std::cout << "positive\n";
    std::cout << "done\n";      // belongs NOT to the if!
```
Rule: *always* use braces, even for one statement.
- *Dangling else.* In `if (a) if (b) x(); else y();` the `else` belongs to the *nearest* `if`, whatever the indentation suggests. Braces remove the doubt.
]

=== The conditional operator

For a simple choice between two *values* there is an expression form: `condition ? value_if_true : value_if_false`. For instance `int m = (a > b) ? a : b;` stores the maximum of `a` and `b`.

== Blocks, scope and lifetime

A pair of braces `{ ... }` forms a *block*. A variable declared inside a block lives from its declaration to the closing brace; this region of the program is its *scope*. Outside, it does not exist. Inner declarations may *hide* outer variables of the same name.

#cpp("scope")

#intu[Think of a block as a room. Variables are things you bring into the room. When you leave, they are thrown away. From inside you can see the things in the rooms around yours (outer blocks), but not the other way round. Hiding is legal but confusing: do not reuse names on purpose.]

#why("Why scopes?")[Small scopes keep programs understandable: a variable that lives for three lines can be understood in three lines. A variable that lives for the whole program can be changed from anywhere, and you must understand everything to be sure about it. Declare variables *as late as possible* and in the *smallest scope* possible.]

== Iteration: the three loops

Many tasks need repetition: sum the numbers from 1 to $n$, process every character of a text, repeat until the user enters valid data. C++ provides three loop statements.

=== The while loop

#snip("while (condition) {
    body
}")

The condition is checked *before* each pass. If it is false at the very beginning, the body is never executed.

#fg("c03_while", [Flow chart of the `while` loop. The path back to the condition is the "loop".], w: 62%)

#cpp("digits")

#trace(("pass", "n (at test)", "sum", "count"),
  ("1", "4721", "1", "1"), ("2", "472", "3", "2"), ("3", "47", "10", "3"), ("4", "4", "14", "4"), ("test", "0", "", ""))

Each pass removes the last digit (`n /= 10`), so `n` gets closer to 0. That the condition eventually becomes false is the *termination argument*: always ask yourself why your loop stops.

=== The for loop

The `for` loop collects the three ingredients of a counting loop in one line: initialisation, condition, update.

#fg("c03_for", [Anatomy and execution order of a `for` loop. The update `++i` is executed *after* the body, even though it is written before it.], w: 100%)

#cpp("sumfor")

The `for` loop is exactly the following `while` loop (and the compiler treats it that way):

#snip("{
    int i = 1;               // initialisation
    while (i <= n) {         // condition
        sum += i;            // body
        ++i;                 // update
    }
}")

Note that `i` is declared in the loop header: its scope is the loop only.

#recipe[Design a loop][
  + What is *repeated*? That is the body.
  + What *changes* from pass to pass? That is the counter or the state in the condition/update.
  + What is the *starting state*, and when must we *stop*? Initialisation and condition.
  + What must hold *after* the loop? Check your result with the smallest example ($n = 0$, $n = 1$).]

#trick[Counting loops: half-open ranges][To repeat something $n$ times, the idiom `for (int i = 0; i < n; ++i)` is the standard. The values of `i` are $0, 1, ..., n-1$: exactly $n$ of them. For $1, ..., n$ use `i = 1; i <= n`. A wrong `<` versus `<=` gives the typical *off-by-one error*: one pass too many or too few.]

=== The do-while loop

Sometimes the body must run *at least once* before the condition makes sense, typically for validating input. Then the check comes *after* the body:

#cpp("dowhile")

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Loop*], [*Use it when ...*],
  [`for`], [the number of passes is known when the loop starts (counting, indices)],
  [`while`], [you repeat until some condition changes (digits, search, convergence); possibly zero passes],
  [`do`-`while`], [the body must run at least once (input validation)])

=== Typical loop patterns

*Accumulator:* start with a neutral element (`0` for sums, `1` for products) and update it in every pass (`sum += i`).

*Two variables walking together:* the Fibonacci sequence $0, 1, 1, 2, 3, 5, ...$ where each number is the sum of the previous two.

#cpp("fib")

Trace the first passes: `(a, b) = (0, 1)`, print 0, `next = 1`, then `(a, b) = (1, 1)`; print 1, next = 2, `(a, b) = (1, 2)` and so on. Each pass moves the pair one step along the sequence.

#mistake[
- *Infinite loops*: forgetting the update (`while (i < n) { sum += i; }`) or a condition that never becomes false. Stop a running program with `Ctrl-C`.
- *Off by one*: `i < n` vs. `i <= n`.
- *Semicolon after the header*: `for (...);` or `while (...);` makes an empty loop; the block after it runs once.
- *Changing the counter inside the body* of a `for` loop makes it hard to follow.
- Forgetting that integer division in the body behaves like in Chapter 2: `sum += 1 / k` adds 0.
]

#cpp("harmonic")

== Floating-point numbers: guidelines

A `double` has 64 bits: not enough to store every decimal number exactly. Computers use *binary* fractions (Chapter 8), and $0.1$ in binary is periodic, like $1/3 = 0.333...$ in decimal. It must be cut off, so the stored value is only close to $0.1$. This leads to rules that every programmer must know.

#cpp("fpcompare")

#remember[
+ *Never compare floating-point numbers with `==` or `!=`* if they result from calculations. Compare their difference: `std::fabs(a - b) < eps` with a small tolerance `eps`.
+ *Do not use `double` as a loop counter.* `for (double x = 0; x != 1; x += 0.1)` never reaches exactly 1 and loops forever. Count with an `int` and compute `x = i * 0.1` from it.
+ *Expect small errors* (about 16 significant digits), and *larger errors* when subtracting nearly equal numbers or adding numbers of very different size.
+ Use `double` for real numbers, not `float`; use `int` for things you count.
]

#hood[`std::fabs` (absolute value of a `double`) and other mathematical functions (`std::sqrt`, `std::pow`, `std::sin`, ...) live in the library `<cmath>`. Printing with `std::setprecision(17)` (from `<iomanip>`) shows more digits than the default of 6, which hides the errors.]

#check[Your sum of ten 0.1's is `0.99999999999999989`. Is the computer "wrong"?][No: it computes exactly what the standard prescribes, with numbers that cannot store 0.1 exactly. The program's *specification* has to say "approximately", and the comparison has to use a tolerance.]

#summary[
- `if`/`else if`/`else` select one alternative; conditions are `bool` expressions; always use braces.
- A *block* is a scope: its variables die at the closing brace. Declare in the smallest scope.
- `while`: test first. `for`: init, test, update in one line. `do`-`while`: body first, then test.
- Every loop needs an argument that it terminates; beware of off-by-one errors and infinite loops.
- Floating-point numbers are approximations: no `==`, no `double` counters.
]

#problems()

#prob("Trace the loop", [What does the program print?
```
int i = 0, s = 0;
while (i < 5) {
    if (i % 2 == 0) s += i; else s -= 1;
    ++i;
}
std::cout << s;
```],
[#trace(("pass", "i (start)", "action", "s"), ("1", "0", "even: s += 0", "0"), ("2", "1", "odd: s -= 1", "-1"), ("3", "2", "even: s += 2", "1"), ("4", "3", "odd: s -= 1", "0"), ("5", "4", "even: s += 4", "4"))
Output: `4`.])

#prob("Rewrite as while", [Rewrite `for (int i = 10; i > 0; i -= 3) std::cout << i << " ";` as a `while` loop. What is printed?],
[```
int i = 10;
while (i > 0) {
    std::cout << i << " ";
    i -= 3;
}
```
Prints `10 7 4 1`. After the last pass `i` is $-2$ and the condition fails.])

#prob("Number of divisors", [Write a program that reads a positive integer `n` and prints how many divisors it has (including 1 and `n`). Then use it to decide whether `n` is prime.],
[```
int count = 0;
for (int d = 1; d <= n; ++d) {
    if (n % d == 0) ++count;
}
std::cout << count << " divisors\n";
if (count == 2) std::cout << "prime\n";
```
A prime has exactly two divisors (1 and itself); for $n = 1$ the count is 1, correctly not prime. A faster test would only try $d$ up to $sqrt(n)$.])

#prob("Finding the bug", [The program should print $1 + 1/2 + 1/4 + 1/8 + ... + 1/1024$. Find the two mistakes.
```
double sum = 0;
for (int k = 0; k <= 10; ++k) {
    sum += 1 / (2 ^ k);
}
```],
[(1) `^` is not "to the power of" in C++ (it is the bit-wise XOR operator). There is no power operator; use `std::pow(2, k)` or keep a variable `double term = 1;` and halve it in every pass (`term /= 2`). (2) `1 / ...` with integers is an integer division and gives 0 for $k >= 1$. Correct:
```
double sum = 0, term = 1;
for (int k = 0; k <= 10; ++k) { sum += term; term /= 2; }
```
The result is $2 - 2^(-10) = 1.99902...$.])

#prob("Collatz", [Starting from a positive integer $n$ repeat: if $n$ is even, replace it by $n/2$, otherwise by $3n+1$, until $n$ equals 1. Print how many steps are needed. For $n = 6$ the sequence is $6, 3, 10, 5, 16, 8, 4, 2, 1$.],
[```
int steps = 0;
while (n != 1) {
    if (n % 2 == 0) n /= 2; else n = 3 * n + 1;
    ++steps;
}
std::cout << steps;
```
For $n = 6$: 8 steps. (That this loop terminates for every $n$ is an unsolved problem in mathematics. Nobody has found a counter-example, but nobody has a proof either.)])
