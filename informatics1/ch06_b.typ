#import "lib.typ": *

== The six loop patterns for vectors

Almost every exercise about vectors is one of six patterns, or a combination of them. If you can recognise the pattern, the code is half written. Here they are, all in one program:

#cpp("d06_patterns")

#table(columns: (auto, 1fr, auto), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), inset: (y: 5pt),
  [*Pattern*], [*Recognise it by the question …*], [*Before the loop*],
  [1. accumulate], ["What is the sum / product / average of …?"], [`sum = 0` (product: `1`)],
  [2. count], ["How many elements are …?"], [`count = 0`],
  [3. extreme], ["What is the largest / smallest …?"], [`best = v[0]` (needs `!v.empty()`)],
  [4. search], ["Is there an element …? Where is the first …?"], [`pos = -1`; `break` when found],
  [5. filter], ["Give me all elements that …" (new vector)], [empty result vector],
  [6. modify], ["Change every element …" (same vector)], [nothing; use `int&` or `v[i]`])

#why("Why start the maximum with v[0] and not with 0?")[If all numbers are negative, say `{-5, -2, -9}`, a start value of `0` would never be beaten and the "maximum" would be `0`, which is not even in the vector. Starting with the first element always gives a real element.]

#why("Why int& in pattern 6?")[`for (int x : v)` gives you a *copy* of each element (photocopy, see above). Changing `x` changes the copy, which is thrown away at the end of each round. `for (int& x : v)` makes `x` a second name for the element itself.]

=== Tables: vectors of vectors, slowly

A `std::vector<std::vector<int>>` is a vector whose lockers each contain a whole vector: a *table*. `m[i]` is row `i` (a vector), and `m[i][j]` is the element in row `i`, column `j`. Read it from left to right: first choose the row, then the position inside that row.

#align(center, table(columns: 4, inset: (x: 10pt, y: 5pt), align: center, stroke: 0.6pt + luma(120),
  [], [*col 0*], [*col 1*], [*col 2*],
  [*row 0*], [`m[0][0]` = 1], [`m[0][1]` = 2], [`m[0][2]` = 3],
  [*row 1*], [`m[1][0]` = 4], [`m[1][1]` = 5], [`m[1][2]` = 6]))

Number of rows: `m.size()`. Number of columns of row `i`: `m[i].size()`. To create an $r times c$ table filled with zeros: `std::vector<std::vector<int>> m(r, std::vector<int>(c, 0));` ("`r` copies of a row of `c` zeros"). To visit all elements, two loops: the outer over rows `i`, the inner over the columns `j`.

== How to solve exercises on references and vectors

In exams and exercise sheets this chapter shows up in three kinds of tasks: *"What is printed?"*, *"Write a function that …"* and *"Find the bug"*. Each has its own procedure.

#recipe("What is printed? (references and copies)")[
+ Draw a box for every variable of `main`, with its value.
+ For each function call, draw a frame. For a *value* parameter, draw a new box and copy the value in. For a *reference* parameter, draw *no* box; write next to the name which variable of the caller it means ("`b` = `y`").
+ Execute line by line. Every assignment to a reference parameter changes the caller's box. Every assignment to a value parameter changes only the box in the frame.
+ When the function returns, erase its frame. Only changes to the caller's boxes survive.
+ Do *not* compute in your head. The boxes are what make you fast and correct.
]

#ex("Exam-style: what is printed?")[
#cpp("d06_ex1", out: false)

#step[Step 1.] At the start: `x = {1, 2}`, `y = {3, 4}`.

#step[Step 2: `f(x, y)`.] `a` is a *copy* of `x`, so a new vector `a = {1, 2}`. `b` is *another name* for `y`.
- `a[0] = 10` changes the copy: `a = {10, 2}`. `x` is unchanged.
- `b[0] = 20` changes `y`: `y = {20, 4}`.
- `b.push_back(a[1])` appends `a[1] = 2` to `y`: `y = {20, 4, 2}`.

#step[Step 3: `f(y, x)`.] Now the roles are swapped. `a` is a copy of `y`, so `a = {20, 4, 2}`, and `b` is another name for `x`.
- `a[0] = 10`: `a = {10, 4, 2}` (`y` unchanged).
- `b[0] = 20`: `x = {20, 2}`.
- `b.push_back(a[1])` appends `4`: `x = {20, 2, 4}`.

#step[Answer.] `x = {20, 2, 4}` and `y = {20, 4, 2}`, so the output is:
#outonly("d06_ex1")
]

#recipe("Write a function that works on a vector")[
+ *Signature first.* What does the function return (a number? a `bool`? a new vector? nothing)? Does it only *read* the vector (`const std::vector<int>& v`) or *change* it (`std::vector<int>& v`)?
+ *Which pattern?* Read the task and find the pattern from the table above (count, search, filter, …).
+ *Write down the "before the loop" part* (start value), then the loop, then what happens after the loop (`return`).
+ *Test by hand* with a normal case and with the edge cases: empty vector, one element, all elements equal, the special element at the very beginning and at the very end.
]

#ex("Exam-style: count the large elements")[
*Task.* Write a function that returns how many elements of a vector are strictly greater than a threshold `t`.

#step[Step 1: signature.] We only read the vector and return a count: `int count_greater(const std::vector<int>& v, int t)`.

#step[Step 2: pattern.] "How many …?" is the *count* pattern: start with `0`, add one for each element that satisfies the condition.

#step[Step 3: code and tests.]
#cpp("d06_ex2")
The tests cover a normal case (`5` and `8` are greater than `3`), the empty vector and the boundary case "equal is not greater".
]

#ex("Exam-style: remove elements in place")[
*Task.* Remove all negative numbers from a vector, keeping the order of the others, *without* a second vector.

#step[Idea.] Walk through the vector with `i` (reading) and keep a second index `k` (writing): the next free place for an element we want to keep. Every kept element is copied to position `k`, then `k` moves one step. At the end, the first `k` places hold exactly the kept elements; `resize(k)` cuts off the rest.

#step[Trace for `{3, -1, -4, 5, -9, 2}`.]
#trace(("i", "v[i]", "keep?", "k before", "vector afterwards"),
  ("0", "3", "yes", "0", "3 -1 -4 5 -9 2"), ("1", "-1", "no", "1", "3 -1 -4 5 -9 2"), ("2", "-4", "no", "1", "3 -1 -4 5 -9 2"),
  ("3", "5", "yes", "1", "3 5 -4 5 -9 2"), ("4", "-9", "no", "2", "3 5 -4 5 -9 2"), ("5", "2", "yes", "2", "3 5 2 5 -9 2"))
After the loop `k = 3`, and `resize(3)` leaves `3 5 2`.
#cpp("d06_ex3")
The parameter is a non-`const` reference because the function must change the caller's vector.
]

#ex("Exam-style: a table")[
*Task.* Return a vector with the sum of each row of a table.

#step[Think in rows.] The result has one number per row, so it has `m.size()` elements. For each row `i` we do the *accumulate* pattern over its columns `j`.
#cpp("d06_ex4")
Row 0: $1 + 2 + 3 = 6$; row 1: $4 + 5 + 6 = 15$.
]

#recipe("Find the bug in vector code")[
Check these four places, in this order. They contain almost all bugs in exam tasks:
+ *Loop bounds:* `<=` instead of `<`? Starting at `1` instead of `0`?
+ *Empty vector:* is `v[0]` or `v.size() - 1` used without checking `!v.empty()`?
+ *Copy or reference:* does a function (or a range-based `for`) change a copy instead of the original?
+ *Start value:* maximum with `0`, product with `0`?
]
