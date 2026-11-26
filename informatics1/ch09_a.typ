#import "lib.typ": *

== The idea in plain words

This chapter shows three *recipes* for recursive algorithms and then a way to build your own types. Here are the pictures behind them.

=== Backtracking is walking through a maze

You are in a maze. At every junction you pick a path. If you hit a dead end, you walk *back* to the last junction and try the next path you have not tried yet. If all paths of a junction are dead, you go back one more junction. You never get lost, because you always know where you came from.

A recursive function does exactly this. Each call is one junction. Its frame remembers *which path it is currently trying* (its loop variable). When a recursive call returns, the program is automatically back at that junction, with that memory intact, and can try the next path. That is why backtracking is so natural with recursion: the "way back" is the return from the call.

=== Divide and conquer is looking up a name in a phone book

Nobody looks up "Müller" by reading the phone book from page 1. You open it in the middle, see "K…", know that "M" comes later, and throw away the first half. Then you open the remaining half in the middle, and so on. Each look *halves* the problem. After about $20$ looks you have found one name among a million.

The same idea sorts: split the pile of cards into two halves, let two friends sort a half each (that is the recursive call), and then *merge* the two sorted piles by repeatedly taking the smaller top card.

=== Memoization is a notebook

When you compute the same thing again and again (like `fib(3)` inside `fib(5)`), you can write each answer into a notebook the first time and look it up the next time. In the program, the notebook is a vector: `memo[n]` holds the answer for `n`, or a marker for "not computed yet".

=== A struct is a form with several fields

A form at the doctor's has fields: name, date of birth, insurance number. They belong together, so you hand in one form, not three slips of paper. A `struct` is such a form for the computer: a new type that bundles several values, each with a name (the *members*).

#mem(("p.x", "1"), ("p.y", "2"), note: [A variable `p` of type `struct Point { int x; int y; };` is one big box containing two small boxes. `p.x` means "the box `x` inside `p`".])

#remember[A struct behaves like an `int` in every respect: `q = p` *copies all members*, a value parameter receives a copy, a reference parameter is an alias. The only new thing is the dot: `p.x` to reach a member.]
