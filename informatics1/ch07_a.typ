#import "lib.typ": *

== The idea in plain words

This chapter has two unrelated halves. The first is about *text*, the second about functions that *call themselves*. Both are easier than they first look, if you keep the right picture in mind.

=== A character is just a small number

The computer does not know letters. It stores the number $100$ and, when you print it as a `char`, the screen shows `d`. The table that connects numbers and characters (ASCII) has one property that makes everything easy: `'a'` to `'z'` are *consecutive* numbers ($97$ to $122$), and so are `'A'` to `'Z'` ($65$ to $90$) and the digits `'0'` to `'9'` ($48$ to $57$). You never need to remember these numbers. You only use *differences*:

#cpp("d07_charmath")

#table(columns: (auto, 1fr), stroke: (x, y) => (bottom: if y == 0 { 0.6pt } else { 0.3pt + luma(200) }), inset: (y: 5pt),
  [*You want …*], [*Write …*],
  [is `c` a lower-case letter?], [`c >= 'a' && c <= 'z'`],
  [is `c` a digit?], [`c >= '0' && c <= '9'`],
  [position of a letter (`a` → 0, `b` → 1, …)], [`c - 'a'`],
  [the number of a digit character (`'7'` → 7)], [`c - '0'`],
  [lower case → upper case], [`c - 'a' + 'A'`],
  [the letter at position `k`], [`'a' + k`])

#mistake[`'7' + 1` is *not* `8`: it is the code of `'7'` plus one, i.e. $56$ (the code of `'8'`). First convert the character to a number with `- '0'`, then compute.]

=== A string is a vector of characters

`std::string s = "Hello";` is a row of five lockers, each containing one character, numbered from 0:

#mem(("[0]", "H"), ("[1]", "e"), ("[2]", "l"), ("[3]", "l"), ("[4]", "o"), note: [`s.size() == 5`, `s[0] == 'H'`, `s[4] == 'o'`.])

Everything you learned for vectors works: loop over `i` from `0` to `s.size() - 1`, look at `s[i]`, count, search, build a new string with `+=`. This loop is the template for almost every string exercise:

#cpp("d07_strloop")

=== Recursion: solve a smaller copy of the same problem

Suppose a queue of people is waiting, and you want to know your position, but you cannot see the front. You ask the person in front of you: "What is your position?" They do not know either, so they ask the person in front of *them*, and so on, until the question reaches the first person, who simply says "1". Then the answers travel back: "2", "3", … and each person adds one to the answer they received.

That is recursion. Each person does a *tiny* bit of work (add one) and passes the *rest of the problem*, which is the same question but for a shorter queue, to someone else. Someone at the very front must be able to answer without asking: this is the *base case*.

#remember[Every recursive function has exactly two parts:
+ *Base case:* the smallest problem, answered directly, without a recursive call ("I am first, my position is 1").
+ *Recursive case:* reduce the problem to a *smaller* version of itself, call the function for it, and use the answer ("my position = position of the person in front + 1").

The leap of faith: when you write the recursive case, *assume the smaller call already works*. Do not try to follow all calls in your head while writing; only check that the smaller problem is really smaller and that the base case is eventually reached.]
