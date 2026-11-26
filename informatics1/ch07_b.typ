#import "lib.typ": *

== Recursion step by step

=== What memory looks like during a recursive call

Each call of a function gets its *own frame* with its *own* parameter boxes, even if it is the same function. Here is `factorial(3)` at the deepest moment, just before the base case answers. Four frames are on the stack at the same time, each with a different `n`:

#frames(frame("main"), frame("factorial", ("n", "3")), frame("factorial", ("n", "2")), frame("factorial", ("n", "1")), frame("factorial", ("n", "0", hl)))

Then the answers travel back, from right to left. Each frame finishes its multiplication and disappears:

#trace(("call", "waits for", "computes", "returns"),
  ("factorial(0)", "nothing (base case)", "", "1"),
  ("factorial(1)", "factorial(0) = 1", "1 * 1", "1"),
  ("factorial(2)", "factorial(1) = 1", "2 * 1", "2"),
  ("factorial(3)", "factorial(2) = 2", "3 * 2", "6"))

#remember[*Down* is the phase of the calls (the problem gets smaller, nothing is computed yet). *Up* is the phase of the returns (the results are combined). Code *before* the recursive call runs on the way down; code *after* it runs on the way up.]

=== Three ways to make a problem smaller

#table(columns: (auto, 1fr, auto), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), inset: (y: 5pt),
  [*Kind of input*], [*Make it smaller by …*], [*Base case*],
  [a number `n`], [`n - 1` (or `n / 10`, `n / 2`)], [`n == 0` or `n < 10`],
  [a string / vector], [dropping the first element (`s.substr(1)`)], [empty, or one element],
  [a string / vector with an index `i`], [`i + 1`: "the rest from position `i + 1` on"], [`i == s.size()`])

Here is one example of each kind.

*Number: sum of the digits.* The last digit of `n` is `n % 10`, the rest is `n / 10`. A number with one digit is its own digit sum.
#cpp("d07_digitsum")

*String: reverse.* The reverse of `"abc"` is (the reverse of `"bc"`) followed by `'a'`.
#cpp("d07_reverse")

*String with an index: count a character.* Instead of making a new, shorter string in each call (which costs copying), we pass the same string and the position `i` where "the rest" begins.
#cpp("d07_count")

== How to solve exercises on strings and recursion

#recipe("Write a recursive function")[
+ *Write the signature* and the postcondition: what does the function return for an input $x$? Write it as a sentence.
+ *Base case:* what is the smallest input? Write its answer directly.
+ *Recursive case:* imagine somebody gives you the answer for the smaller input ("leap of faith"). How do you get the answer for $x$ from it? Write exactly that.
+ *Check termination:* does every call make the input strictly smaller, so that the base case is reached? (`n - 1` with base case `n == 0` and a negative `n` never terminates!)
+ *Test* with the base case and the next one or two sizes, by hand.
]

#ex("Exam-style: what does f(4) return?")[
#cpp("d07_ex1", out: false)

#step[Method: work bottom-up.] Do not expand the whole call tree (it grows fast). Instead compute `f` for small arguments first and write them in a table, then use them:
#trace(("n", "rule", "f(n)"),
  ("0", "base case", "1"), ("1", "base case", "1"),
  ("2", "f(1) + 2*f(0) = 1 + 2", "3"), ("3", "f(2) + 2*f(1) = 3 + 2", "5"), ("4", "f(3) + 2*f(2) = 5 + 6", "11"))
#outonly("d07_ex1")
]

#ex("Exam-style: what is printed? (code before and after the call)")[
#cpp("d07_ex2", out: false)

#step[Method: draw the calls as a staircase.] Write the output of each line where it happens.
#trace(("call", "on the way down prints", "on the way up prints"),
  ("g(3)", "3", "3 (last)"), ("g(2)", "2", "2"), ("g(1)", "1", "1 (first on the way up)"), ("g(0)", "nothing: return", ""))
The first `cout` of each call happens before the recursive call (down: `3 2 1`), the second after it (up, in reverse order: `1 2 3`).
#outonly("d07_ex2")
]

#recipe("Write a function on a string")[
+ Decide: do you need the *index* (because you look at neighbours `s[i - 1]` or `s[i + 1]`, or at positions) or just the characters? Index loop or range-based `for`.
+ Use the character tests from the table at the beginning of the chapter, never the raw numbers.
+ Building a result: start with `std::string r;` and append with `r += c;`. Changing the string in place: write `s[i] = …` on a copy or reference.
+ Test with the empty string, a string of length one, and with the special case at the first and last position.
]

#ex("Exam-style: capitalise every word")[
*Task.* Make the first letter of every word upper case. Words are separated by single spaces.

#step[Idea.] A character starts a word if it is the first character (`i == 0`) or if the character *before* it is a space. Because we look at the neighbour `s[i - 1]`, we need the index. The condition `i == 0 ||` comes first, so `s[i - 1]` is never evaluated for `i == 0` (short-circuit evaluation, Chapter 3).
#cpp("d07_ex3")
The parameter is a *copy* (`std::string s`), so the function may change it and return it, while the caller's string stays unchanged.
]

#mistake[
- Forgetting the base case, or a base case that is never reached: the program crashes with a *stack overflow*.
- Making the problem bigger instead of smaller (`f(n + 1)`), or not changing it at all (`f(n)`).
- In string code: `s[i + 1]` in a loop up to `i < s.size()` reads one character past the end in the last round.
]
