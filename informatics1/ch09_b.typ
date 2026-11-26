#import "lib.typ": *

== Step by step: the three recursion patterns at work

=== "All possibilities": choose, recurse, undo

To list all subsets of $\{1, 2, 3\}$, decide for each number in turn: *in* or *out*? Every subset is one sequence of three decisions. The function decides about one number `k` and leaves the rest to the recursive call:

#cpp("d09_subsets")

The three lines in the middle are the heart of every backtracking program:
- `subsets(chosen, k + 1, n)`: try the first option (`k` out) and let recursion handle the rest;
- `chosen.push_back(k); subsets(…)`: try the second option (`k` in);
- `chosen.pop_back()`: *undo* the decision, so that the caller finds `chosen` exactly as it was before. Without this line, the elements would pile up.

The tree of decisions has $2^3 = 8$ leaves, one per subset. With $n$ numbers there are $2^n$ subsets: fine for $n = 20$ (one million), hopeless for $n = 60$.

=== Binary search, traced

The vector is sorted. The search keeps an interval `[lo, hi)` in which `x` must be, if it is there at all, and halves it in each step:

#cpp("d09_bstrace")

Read the first search: $v[5] = 23 > 16$, so `16` can only be *left* of position 5: `hi = 5`. Then $v[2] = 8 < 16$: `16` is right of 2: `lo = 3`. Then $v[4] = 16$: found. In the second search the interval becomes empty (`lo == hi`) without a match: `40` is not there.

=== Merging, traced

Merge sort is only as good as its merge step. Two sorted lists are combined like two queues at a counter: always the person who is in front and has the *smaller* number goes first.

#cpp("d09_merge")

#trace(("a front", "b front", "take", "result so far"),
  ("1", "2", "1 (from a)", "1"), ("4", "2", "2 (from b)", "1 2"), ("4", "3", "3 (from b)", "1 2 3"),
  ("4", "10", "4 (from a)", "1 2 3 4"), ("9", "10", "9 (from a)", "1 2 3 4 9"), ("—", "10", "rest of b", "1 2 3 4 9 10 12"))

Each element is taken exactly once, so merging $n$ elements costs about $n$ steps. Merge sort merges on $log_2 n$ levels, which gives $n log_2 n$ in total.

== How to solve exercises on recursion II and structs

#recipe("Generate all possibilities (backtracking)")[
+ What is *one decision*? (A letter, a column for a queen, "in or out" for an element.)
+ What does the function need to know? Usually: the *partial solution* so far (by reference) and *which decision is next* (an index).
+ *Base case:* no decision left: the partial solution is complete. Print or count it.
+ *Recursive case:* for each option: if it is allowed (pruning), apply it, call recursively for the next decision, *undo* it.
]

#recipe("How many steps? (complexity questions)")[
- The problem shrinks by *one* per call ($n -> n - 1$) and each call does constant work: about $n$ steps.
- The problem is *halved* and only one half is followed (binary search): about $log_2 n$ steps. Quick values: $log_2 1000 approx 10$, $log_2 10^6 approx 20$, $log_2 10^9 approx 30$.
- The problem is halved, *both* halves are handled, and the combining costs $n$ (merge sort): about $n log_2 n$.
- Each call makes *two* calls with $n - 1$ (naive Fibonacci, subsets): about $2^n$, which explodes.
]

#ex("Exam-style: binary search steps")[
*Task.* In the sorted vector `{2, 5, 8, 12, 16, 23, 38, 56, 72, 91}`, which elements are looked at when searching for `56`?

#step[Step 1.] `lo = 0`, `hi = 10`, `mid = 5`: $23 < 56$, so `lo = 6`.

#step[Step 2.] `lo = 6`, `hi = 10`, `mid = 8`: $72 > 56$, so `hi = 8`.

#step[Step 3.] `lo = 6`, `hi = 8`, `mid = 7`: $56$, found at index 7.

#step[Answer.] The elements `23`, `72`, `56` (at indices 5, 8, 7). Always write `lo`, `hi` and `mid` in a small table; computing in your head is where mistakes happen.
]

#recipe("Define and use a struct")[
+ Decide which values belong together, and give each a name and a type: `struct Time { int h; int m; };`.
+ Write functions that take the struct as a parameter: `const Time&` to read, `Time&` to change, and return a new `Time` as a result.
+ If the type should work with `+`, `<`, `==` or `<<`, overload these operators. The output operator always has this form:
  #snip("std::ostream& operator<<(std::ostream& out, const T& x) {\n    out << ...;     // print the members\n    return out;\n}")
+ Trick for times, dates and money: convert everything into *one* unit (minutes, days, cents), compute, and convert back.
]

#ex("Exam-style: a Time type")[
*Task.* Write a struct for a time of day, a function that adds a number of minutes, a comparison `<` and an output operator.

#step[Idea.] Converting to minutes since midnight avoids all the special cases "60 minutes = 1 hour" and "24 hours = midnight": compute `total`, take it modulo $24 dot 60$, and split it again with `/ 60` and `% 60`.
#cpp("d09_time")
`10:15` plus $105$ minutes is $615 + 105 = 720$ minutes $= 12:00$. `23:30` plus $45$ minutes is $1455$ minutes; $1455 mod 1440 = 15$, which is `0:15`. The last line prints `1` because `true` is output as `1`.
]

#ex("Exam-style: what is printed? (structs are copied)")[
#cpp("d09_ex_struct", out: false)

#step[Step 1.] `p = {1, 2}`. `q = p` copies both members: `q = {1, 2}`. Then `q.x = 5`: `q = {5, 2}`; `p` is unchanged.

#step[Step 2: `f(p, q)`.] `a` is a *copy* of `p`: `a = {1, 2}`. `b` is an *alias* of `q`.
- `a.x = 100` changes only the copy: `a = {100, 2}`.
- `b.y = a.x + b.x = 100 + 5 = 105` changes `q`: `q = {5, 105}`.

#step[Answer.]
#outonly("d09_ex_struct")
]

#mistake[
- Backtracking without *undo*: the partial solution keeps the choices of earlier branches.
- Binary search on an *unsorted* vector: it gives wrong answers, without any error message.
- `power(x, n / 2) * power(x, n / 2)` instead of storing the result once: back to linear (or worse) running time.
- Forgetting `return out;` in `operator<<`, or taking the stream by value (`std::ostream out` does not compile: streams cannot be copied).
]
