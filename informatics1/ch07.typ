#import "lib.typ": *

= Strings and Recursion I

#lec(7, [Strings, recursion I], [`char` and ASCII · `std::string` · recursive functions · call tree · Towers of Hanoi])

#lecture[This chapter has two halves. Text first: how computers store characters, and how to work with the `std::string` type. Then one of the central ideas of computer science: *recursion*, a function that solves a problem by calling itself on a smaller version of the same problem.]

== Characters

A computer knows only numbers. To store text, every character is assigned a number: a *code*. The most common table is *ASCII*, defined for 128 characters (letters, digits, punctuation, control characters). A `char` is nothing but a small integer that is *printed* as a character.

#fg("c07_ascii", [Excerpt of the ASCII table. Digits, upper-case letters and lower-case letters each form a consecutive block, in the natural order.], w: 94%)

That the blocks are consecutive makes character arithmetic very useful:

#cpp("chars")

- `'7' - '0'` is the *number* 7: the digit characters are consecutive.
- `x - 'a' + 'A'` converts a lower-case letter to upper case: the offset of `x` from `'a'`, added to `'A'`.
- `c - 'a'` is the *position* of a letter in the alphabet (0 for `a`, 25 for `z`).

#mistake[`'a'` (single quotes) is *one character*; `"a"` (double quotes) is a *string*. And `'5'` is the character with code 53, not the number 5.]

The library `<cctype>` offers ready-made tests such as `std::isdigit(c)`, `std::isalpha(c)`, `std::toupper(c)`.

== Strings

#defn[String][A `std::string` (library `<string>`) is a sequence of characters, of any length that can change. It behaves much like a `std::vector<char>` with extra features for text.]

#cpp("str_basic")

Summary of the operations:
#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Expression*], [*Meaning*],
  [`s.length()` or `s.size()`], [number of characters],
  [`s[i]`], [character at position `i` (from 0); can be changed],
  [`a + b`, `s += b`], [concatenation (at least one side must be a `std::string`)],
  [`a == b`, `a < b`, ...], [comparison in dictionary (lexicographic) order],
  [`s.substr(pos, len)`], [part of the string],
  [`s.find(t)`], [position of the first occurrence of `t`, or `std::string::npos` if none],
  [`s.push_back(c)`], [append one character],
  [`s.empty()`], [`true` for the empty string `""`])

#mistake[`"Hello" + "World"` does not compile: both sides are plain text constants (arrays of characters), not `std::string`s. Write `std::string("Hello") + "World"`. Similarly `"apple" < "banana"` would compare *addresses* rather than letters; with `std::string` it compares letters.]

=== Input of strings

`std::cin >> s` reads a *word* (up to the next whitespace). To read a whole *line* including the spaces, use `std::getline(std::cin, line)`.

#cpp("words")

#intu[A string is a vector of characters, so all vector patterns apply: loop over the indices, compare the first with the last, build a new string with `+=`. The palindrome test is the same two-pointer idea as reversing a vector in Chapter 6.]

#cpp("palindrome")

#ex("Caesar cipher")[Julius Caesar is said to have encrypted messages by replacing each letter by the one $k$ places further in the alphabet. In our program the letter `r[i]` has position `r[i] - 'a'`. We add `k`, wrap around with `% 26`, and convert back with `'a' + ...`.
#cpp("caesar")
To decrypt we shift by $26 - 3 = 23$ more positions, which completes the full circle. The cipher is trivially breakable (there are only 25 keys to try), but it shows the technique.]

== Recursion

#idea[A function may call *itself*. It sounds like circular reasoning, but it works, provided that each call solves a *smaller* problem, and that for the smallest problems there is a direct answer. Many problems have this shape: to sort a list, sort its two halves and merge; to search a folder, search all its subfolders.]

Take the factorial $n! = 1 dot 2 dot dots dot n$. It satisfies

$ n! = n dot (n - 1)!, quad 0! = 1. $

The first line says how to reduce the problem to a smaller one; the second line stops the reduction. That is literally the program:

#cpp("fact_rec")

#defn[Base case and recursive case][Every recursive function consists of
- one or more *base cases*, which are answered directly (here `n == 0`), and
- *recursive cases*, which call the function with a *smaller* argument (here `n - 1`) and combine the result.
If the arguments never reach a base case, the recursion never ends.]

=== What happens during the call?

Remember the call stack (Chapter 4): each call has its own frame with its own `n`. The call `factorial(3)` has to wait for `factorial(2)`, which waits for `factorial(1)`, which waits for `factorial(0)`. Only then, results come back.

#fg("c07_factorial", [The calls of `factorial(3)` and how the result returns.], w: 94%)

The following version prints each call and return, indented by depth, so that you can *see* it:

#cpp("fact_trace")

#hood[At the deepest point there are four frames on the stack at the same time. If you call `factorial(1000000)`, there are a million frames, the stack memory is exhausted, and the program crashes with a *stack overflow* ("segmentation fault"). Recursion uses memory proportional to its *depth*. A loop would not.]

#recipe[Think recursively][
  + *Smallest case:* for which input can you answer directly? (the base case)
  + *Reduction:* how can you reduce any other input to a smaller one? Assume that the function works correctly for smaller inputs (*leap of faith*!).
  + *Combination:* how do you get the answer from the answer to the smaller problem?
  + *Check* that every chain of calls reaches a base case.]

#trick[Don't trace every call in your head][To check a recursive function, do not follow all calls down to the base case. Check just three things: (1) the base case is right, (2) the recursive case is right *if* the recursive calls are right, (3) the arguments get smaller. Then by induction, the function works.]

Some more short recursive functions to practise the pattern:

#cpp("rec_sum")

- `digit_sum`: the problem for `n` is the last digit plus the problem for `n / 10`. Base: a single digit.
- `pal`: a string is a palindrome if the outer characters agree *and* the inside is a palindrome. Base: nothing or one character left (`i >= j`).
- `gcd`: Euclid again; base: `b == 0`.

=== Recursion can be wasteful: Fibonacci

The Fibonacci numbers are defined by $F_0 = 0$, $F_1 = 1$, and $F_n = F_(n-1) + F_(n-2)$. The recursive program is a direct transcription of the definition:

#cpp("fib_rec")

Look at the number of calls: it grows enormously, by a factor of about 1.6 for each increase of $n$ by one. The call tree shows why:

#fg("c07_fibtree", [Calls of `fib(5)`. The same sub-problem (`fib(3)`, `fib(2)`, ...) is solved again and again.], w: 80%)

`fib(30)` needs 2.7 million calls, `fib(50)` would need about 40 *billion*. The loop from Chapter 3 computes the same number with 50 additions. A recursive formulation that is natural is not necessarily efficient. Remedy: remember results already computed (*memoization*, Chapter 9) or use a loop.

#table(columns: (1fr, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }),
  [*Recursion is good when ...*], [*A loop is better when ...*],
  [the problem has a recursive structure (trees, folders, divide and conquer)], [the task is a simple repetition (sums, counting, scanning)],
  [the recursive solution is much shorter and clearer], [sub-problems overlap (Fibonacci), or the depth would be huge])

== Towers of Hanoi

A famous puzzle: three pegs and $n$ discs of different sizes, stacked on peg A with the smallest on top. Move all discs to peg C, one at a time, never placing a larger disc on a smaller one. Try it with 3 discs and you will notice that *thinking* does not help much, but *recursion* does:

#rule[Solution of Hanoi][To move $n$ discs from A to C (using B as helper):
+ move the top $n - 1$ discs from A to B (a smaller problem!),
+ move the largest disc from A to C,
+ move the $n - 1$ discs from B to C (again the smaller problem).
For $n = 0$ there is nothing to do.]

#cpp("hanoi")

#fg("c07_hanoi", [The seven moves for three discs, as produced by the program. Disc 1 (blue) moves in every second step.], w: 100%)

The number of moves $M(n)$ satisfies $M(0) = 0$ and $M(n) = 2 M(n-1) + 1$, which gives $M(n) = 2^n - 1$: 1048575 for 20 discs, as the program counted. For 64 discs, as in the legend of the monks of Hanoi, it would be $2^64 - 1 approx 1.8 dot 10^19$ moves: at one move per second the world would end first. No program can improve this: the *problem* itself needs that many moves.

#check[What is the smallest number of moves for 5 discs? And what does `hanoi(0, ...)` do?][$2^5 - 1 = 31$. It returns immediately, because the base case `n == 0` is reached; there is nothing to do.]

// ALLTAG-BEGIN
== Where this shows up in the real world

#everyday[*Text is bytes: Unicode and UTF-8.* A `char` is one byte, but not every letter fits in one byte: the letter `é` takes two bytes in UTF-8, a Chinese character three, an emoji four. That is why `s.size()` for the string `"héllo"` returns $6$, not $5$. Almost all web pages and files use UTF-8 today. Real programs that count characters, cut strings or reverse them therefore need a library that understands Unicode; the simple `std::string` operations from this chapter work on bytes.]

#everyday[*Recursion in the file system.* Folders contain files and other folders, which contain files and other folders. Listing everything below a folder is a recursion: for each entry, if it is a file print it, if it is a folder do the same inside. Commands like `find`, `du` (disk usage) and your operating system's search all work this way. The same pattern appears for every nested structure: the structure of a web page, a menu with submenus, an organisation chart, a family tree.]
// ALLTAG-END

#summary[
- A `char` is a small integer (ASCII code). Digit and letter blocks are consecutive: `c - '0'`, `c - 'a'`.
- `std::string`: length, indexing, `+`, comparison, `substr`, `find`; `getline` reads a line. Vector techniques work on strings.
- Recursion: *base case* + *recursive case* with a *smaller* argument. Each call has its own stack frame.
- Check recursive functions by: base case right, step right, argument shrinks.
- Naive recursion may repeat work exponentially (Fibonacci); Towers of Hanoi needs $2^n - 1$ moves.
]

#problems()

#prob("ASCII arithmetic", [What are the values (as `int`) of (a) `'c' - 'a'`, (b) `'9' - '0' + 1`, (c) `'A' + 2`, and what is printed by `std::cout << static_cast<char>('A' + 2)`?],
[(a) 2. (b) 10. (c) 67 (the code of `'C'`). The cast prints `C`. (Without the cast, `std::cout << ('A' + 2)` prints the *number* 67, because the sum of a `char` and an `int` is an `int`.)])

#prob("Count a letter", [Write `int count(const std::string& s, char c)` that counts how often `c` occurs in `s`. Then write `std::string reversed(const std::string& s)` that returns the string reversed.],
[```
int count(const std::string& s, char c) {
    int n = 0;
    for (char x : s) if (x == c) ++n;
    return n;
}
std::string reversed(const std::string& s) {
    std::string r;
    for (int i = s.length() - 1; i >= 0; --i) r += s[i];
    return r;
}
```
`int i` (not `unsigned`) makes the condition `i >= 0` work.])

#prob("Trace the recursion", [What does `f(4)` return?
```
int f(int n) {
    if (n <= 1) return 1;
    return f(n - 1) + 2 * f(n - 2);
}
```],
[$f(0) = f(1) = 1$. $f(2) = f(1) + 2 f(0) = 3$. $f(3) = f(2) + 2 f(1) = 3 + 2 = 5$. $f(4) = f(3) + 2 f(2) = 5 + 6 = 11$.])

#prob("Recursive power", [Write `double power(double x, int n)` for $n >= 0$ recursively, using $x^n = x dot x^(n-1)$. How many multiplications does it need? (A faster variant comes in Chapter 9.)],
[```
double power(double x, int n) {
    if (n == 0) return 1;
    return x * power(x, n - 1);
}
```
$n$ multiplications and $n + 1$ calls, the same cost as a loop but with $n$ stack frames.])

#prob("Binary representation", [Write a recursive function `void print_binary(int n)` ($n >= 0$) that prints $n$ in binary, e.g. 13 as `1101`.],
[```
void print_binary(int n) {
    if (n >= 2) print_binary(n / 2);     // the higher digits first
    std::cout << n % 2;                  // then the last digit
}
```
The recursion prints the number without its last bit first, then the last bit `n % 2`. For `n = 0` or `1` there is just one digit. Trace for 13: `print_binary(6)` prints 110, then 1.])
